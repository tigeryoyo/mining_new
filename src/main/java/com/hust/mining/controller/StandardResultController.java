package com.hust.mining.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hust.mining.constant.Constant.KEY;
import com.hust.mining.model.Issue;
import com.hust.mining.model.StandardResult;
import com.hust.mining.service.IssueService;
import com.hust.mining.service.RedisService;
import com.hust.mining.service.StandardResultService;
import com.hust.mining.util.ExcelUtil;
import com.hust.mining.util.ResultUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/standardResult")
public class StandardResultController {
    private static final Logger logger = LoggerFactory.getLogger(StandardResultController.class);
    @Autowired
    private IssueService issueService;
    @Autowired
    private StandardResultService standardResultService;
    @Autowired
    private RedisService redisService;
    
    @ResponseBody
    @RequestMapping(value = "/queryStandardResults")
    public Object queryStandardResults(@RequestParam(value = "issueId", required = false) String issueId,
            HttpServletRequest request){
    	Issue issue = issueService.queryIssueById(issueId);
    	if (issue == null) {
            return ResultUtil.errorWithMsg("查询任务文件失败");
        }
    	List<StandardResult> stdResList = standardResultService.queryStdRessByIssueId(issueId);
    	redisService.setString(KEY.ISSUE_ID, issueId, request);
    	JSONObject json = new JSONObject();
        json.put("issue", issue);
        json.put("stdResList", stdResList);
        return ResultUtil.success(json);
    }
    
    @SuppressWarnings("unchecked")
    @ResponseBody
    @RequestMapping(value = "/download", method = RequestMethod.POST)
    public void download(@RequestParam(value = "stdResId", required = true) String stdResId,HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("*****???**************");
    	String issueId = issueService.getCurrentIssueId(request);
        if (StringUtils.isBlank(issueId)) {
            response.sendError(404, "未找到当前处理事件，请先创建或者选择某一事件");
            logger.error("issueId为空");
            return;
        }
        StandardResult standardResult = standardResultService.queryStdResById(stdResId);
        
        if (null == standardResult) {
            response.sendError(404, "未找到当前处理记录，请先创建或者选择某一记录");
            logger.error("standardResult为空");
            return;
        }
        OutputStream outputStream = null;
        try {
            List<String[]> cluster = standardResultService.getStdResContentById(stdResId);
            if (cluster == null) {
                return;
            }
            outputStream = response.getOutputStream();
            response.setCharacterEncoding("utf-8");
            response.setContentType("multipart/form-data");
            String stdResName = new String(standardResult.getResName().getBytes(),"ISO8859-1");
            response.setHeader("Access-Control-Allow-Origin", "*"); 
            response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE"); 
            response.setHeader("Access-Control-Max-Age", "3600"); 
            response.setHeader("Content-Disposition", "attachment;filename="+stdResName+".xls");
            HSSFWorkbook workbook = ExcelUtil.exportToExcel(cluster);
            workbook.write(outputStream);
        } catch (Exception e) {
            logger.info("excel 导出失败\t" + e.toString());
        } finally {
            try {
                outputStream.close();
            } catch (Exception e) {
                logger.info("导出excel时，关闭outputstream失败");
                return;
            }
        }
    }
    
    @ResponseBody
    @RequestMapping(value = "/delete")
    public Object delete(@RequestParam(value = "stdResId", required = false) String stdResId,
            HttpServletRequest request){
    	String issueId = issueService.getCurrentIssueId(request);
    	if(standardResultService.deleteById(stdResId) <= 0){
    		return ResultUtil.errorWithMsg("删除失败！");
    	}
    	JSONObject json = new JSONObject();
        json.put("issueId", issueId);
        return ResultUtil.success(json);
    }
}

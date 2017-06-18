package com.hust.mining.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
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
import com.hust.mining.dao.StandardResultDao;
import com.hust.mining.model.Issue;
import com.hust.mining.model.Label;
import com.hust.mining.model.StandardResult;
import com.hust.mining.service.IssueService;
import com.hust.mining.service.LabelService;
import com.hust.mining.service.RedisService;
import com.hust.mining.service.StandardResultService;
import com.hust.mining.service.StandardResult_labelService;
import com.hust.mining.urltags.URLTool;
import com.hust.mining.util.AttrUtil;
import com.hust.mining.util.ConvertUtil;
import com.hust.mining.util.ExcelUtil;
import com.hust.mining.util.FileUtil;
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
    @Autowired
    private StandardResult_labelService stand_label;
    @Autowired
    private LabelService labelservice;
    
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
            
            String dateCount = "";
            String srcCount = "";
            
            if(StringUtils.isBlank(standardResult.getDateCount())){
            	dateCount = standardResultService.getDateCount(cluster);
            	srcCount = standardResultService.getSourceCount(cluster);
            	standardResult.setDateCount(dateCount);
            	standardResult.setSourceCount(srcCount);
            	standardResultService.updateByPrimaryKey(standardResult);
            } else {
            	dateCount = standardResult.getDateCount();
            	srcCount = standardResult.getSourceCount();
            }
            
            List<String[]> dateCountList = FileUtil.calcPOfCount(ConvertUtil.strConvertToList(dateCount, "日期"));
            List<String[]> srcCountList = FileUtil.calcPOfCount(ConvertUtil.strConvertToList(srcCount, "来源"));
            
            outputStream = response.getOutputStream();
            response.setCharacterEncoding("utf-8");
            response.setContentType("multipart/form-data");
            String stdResName = new String(standardResult.getResName().getBytes(),"ISO8859-1");
            response.setHeader("Content-Disposition", "attachment;filename="+stdResName+".xls");
            HSSFWorkbook workbook = ExcelUtil.exportToExcel(cluster,dateCountList,srcCountList);
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
    
    ////以下全是关于为准数据贴标签的函数
    /**
     * 为准数据贴标签
     */
    @ResponseBody
    @RequestMapping(value="/SetLabelForStandardResult")
    public Object SetLabelForStandardResult(@RequestParam(value="stdResId",required=true) String stdResId,
    		@RequestParam(value="labelids",required=false) List<Integer> labelids)
    {
    	if (labelids.isEmpty()) {
			return ResultUtil.errorWithMsg("没有选中任何标签！");
		}
    	boolean status = stand_label.attachlabels(stdResId, labelids);
    	if (status==false) {
    		return ResultUtil.errorWithMsg("贴标签失败！");
		}
    	return ResultUtil.success("贴标签成功！");
    	
    }
    
    /**
     * 查找当前的任务，没有哪些标签
     */
    @ResponseBody
    @RequestMapping(value="/findLabelNotInStandardResult")
    public Object findLabelNotInStandardResult(@RequestParam(value="stdResId",required=true) String stdResId,
    		@RequestParam(value="labelids",required=false) List<Integer> labelids)
    {
    	if (stdResId==null) {
    		return ResultUtil.errorWithMsg("没有选中任何准数据！");
		}
    	List<Integer> list = stand_label.findLabelNotInStandardResult(stdResId);
    	return ResultUtil.success(list);
    	
    }
    
    /**
     * 查看某个准数据被打贴了什么标签
     * @param stdResId
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/selectLabelsForStandResult")
    public Object selectLabelsForStandResult(@RequestParam(value="stdResId",required=true)String stdResId)
    {
    	if (stdResId==null) {
    		return ResultUtil.errorWithMsg("没有选中任何准数据！");
		}
    	List<Integer> list = stand_label.selectLabelsForStandResult(stdResId);
    	return ResultUtil.success(list);
    }
    
    /**
     * 根据标签查找那些准数据包含此标签
     * @param labelname
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/selectStandResultsBylabel")
    public Object selectStandResultsBylabel(@RequestParam(value="labelname",required=true)String labelname)
    {
    	//根据labelname找到labelid
    	Label label = labelservice.selectByname(labelname);
    	if (label==null) {
    		return ResultUtil.errorWithMsg("没有准数据包含此标签！");
		}
    	//根据labelId返回任务的id列表
    	List<String> list = stand_label.selectStandResultsBylabel(label.getLabelid());
    	return ResultUtil.success(list);
    }
    
    @ResponseBody
    @RequestMapping(value="/deleteLabelOfStandard")
    public Object deleteLabelOfStandard(@RequestParam(value="staRtId",required=true)String staRtId,
    		@RequestParam(value="labelid",required=true)int labelid)
    {
    	
    	if (staRtId.isEmpty()) {
    		return ResultUtil.errorWithMsg("请选择准数据！");
		}
    	boolean status = stand_label.delete(staRtId, labelid);
    	if (status==false) {
    		return ResultUtil.errorWithMsg("移除标签失败！");
		}
    	return ResultUtil.success("移除标签成功！");
    }
    
    @ResponseBody
    @RequestMapping(value="/countURL")
	public Object deleteLabelOfStandard(@RequestParam(value="staRtId",required=true)String staRtId)
	{
    	//获取当前准数据的内容
    	List<String[]> cluster = standardResultService.getStdResContentById(staRtId);
    	if (cluster.isEmpty()) {
    		return ResultUtil.errorWithMsg("当前准数据为空！");
		}
    	String[] firstline = cluster.get(0);
    	int URL = AttrUtil.findIndexOfUrl(firstline);
    	int name = AttrUtil.findIndexOfWebName(firstline);
    	List<String[]> uRList = new ArrayList<String[]>();
    	for (String[] strings : cluster) {
			String[] string = new String[2];
			string[0] = strings[URL];
			string[1] = strings[name];
			uRList.add(string);
		}
    	URLTool urlTool = new URLTool();
    	List<String[]> result = urlTool.statisticUrl(uRList);
    	if (result.isEmpty()) {
    		return ResultUtil.errorWithMsg("统计网站失败！");
		}
    	List<String[]> finalresult = new ArrayList<String[]>();
    	//只需输出5个
    	for(int i = 0; i < 5; i++)
    	{
    		finalresult.add(result.get(i));
    	}
    	return ResultUtil.success(finalresult);
    	
	}
    
}

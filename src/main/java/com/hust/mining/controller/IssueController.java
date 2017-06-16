package com.hust.mining.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hust.mining.constant.Constant.KEY;
import com.hust.mining.model.Issue;
import com.hust.mining.model.params.IssueQueryCondition;
import com.hust.mining.service.IssueService;
import com.hust.mining.service.RedisService;
import com.hust.mining.service.UserService;
import com.hust.mining.util.ResultUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/issue")
public class IssueController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = LoggerFactory.getLogger(IssueController.class);

	@Autowired
	private UserService userService;
	@Autowired
	private IssueService issueService;
	@Autowired
	private RedisService redisService;

	/**
	 * 创建任务
	 * @param issueName 创建任务的名字
	 * @param issueType 创建任务的类型（泛数据，准数据，核心数据）
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public Object createIssue(@RequestParam(value = "issueName", required = true) String issueName,
			@RequestParam(value = "issueType", required = true) String issueType, HttpServletRequest request) {
		if (issueService.createIssue(issueName, issueType, request) == 0) {
			logger.info("create issue fail");
			return ResultUtil.errorWithMsg("创建任务失败");
		}
		return ResultUtil.success("创建任务成功");
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public Object deleteIssue(@RequestParam(value = "issueId", required = true) String issueId,@RequestParam(value = "issueType", required = true) String issueType,
			HttpServletRequest request) {
		if (issueService.deleteIssueById(issueId,issueType,request) > 0) {
			return ResultUtil.success("删除任务成功");
		}
		return ResultUtil.errorWithMsg("删除任务失败");
	}

	@ResponseBody
	@RequestMapping("/createIssueWithLink")
	public Object createIssueWithLink(@RequestParam(value = "issueType", required = true) String issueType,
			@RequestParam(value = "stdResId", required = false) String stdResId,
			HttpServletRequest request){
		String linkedIssueId = redisService.getString(KEY.ISSUE_ID, request);
		if (StringUtils.isEmpty(linkedIssueId)) {
			return ResultUtil.errorWithMsg("请重新选择任务");
		}
		int exists = issueService.createIssueWithLink(linkedIssueId, issueType, stdResId, request);
		if (exists == 0) {
			logger.error("create Issue with link fail.");
			return ResultUtil.errorWithMsg("创建准数据失败.");
		} else if(exists == -1){
			logger.error("current Result Id is null.");
			return ResultUtil.errorWithMsg("result为空，请点击“重置”。");
		}
		return ResultUtil.success("创建任务成功");
	}

	@ResponseBody
	@RequestMapping("/queryOwnIssue")
	public Object queryOwnIssue(@RequestBody IssueQueryCondition con, HttpServletRequest request) {
		String user = userService.getCurrentUser(request);
		con.setUser(user);
		System.out.println(con.getIssueId());
		System.out.println(con.getIssueName());
		System.out.println(con.getIssueType());
		System.out.println(con.getIssueHold()+"***************");
		if(null == con.getIssueType()){
			return ResultUtil.successWithoutMsg();
		}
		System.out.println(con.getPageNo());
		System.out.println(con.getPageSize());
		System.out.println(con.getUser());
		System.out.println("CreateEndTime" + con.getCreateEndTime());
		System.out.println("CreateStartTime" + con.getCreateStartTime());
		System.out.println("LastUpdateEndTime" + con.getLastUpdateEndTime());
		System.out.println("LastUpdateStartTime" + con.getLastUpdateStartTime());
		List<Issue> list = issueService.queryIssue(con);
		if (null == list || 0 == list.size()) {
			return ResultUtil.errorWithMsg("没有任务被创建！");
		}
		long count = list.size();
		JSONObject result = new JSONObject();
		long pageTotal = count % 10 == 0 ? (count / 10) : (count / 10 + 1);
		result.put("pageTotal", pageTotal);
		result.put("list", list);
		return ResultUtil.success(result);
	}

	@ResponseBody
	@RequestMapping("/queryAllIssue")
	public Object queryAllIssue(@RequestBody IssueQueryCondition con, HttpServletRequest request) {
		List<Issue> list = issueService.queryIssue(con);
		if (null == list || 0 == list.size()) {
			return ResultUtil.errorWithMsg("没有任务被创建！");
		}
		long count = list.size();
		JSONObject result = new JSONObject();
		long pageTotal = count % 10 == 0 ? (count / 10) : (count / 10 + 1);
		result.put("pageTotal", pageTotal);
		result.put("list", list);
		return ResultUtil.success(result);
	}
	
	@ResponseBody
	@RequestMapping("/queryOwnIssueCount")
	public Object queryOwnIssueCount(@RequestBody IssueQueryCondition con, HttpServletRequest request) {
		long count = 0;
		count = issueService.queryIssueCount(con);
		if(count<=0){
			return ResultUtil.errorWithMsg("没有任务被创建！");
		}
		System.out.println(count+"-----------------------------");
		return ResultUtil.success(count);
	}

	@ResponseBody
	@RequestMapping("/queryAllIssueCount")
	public Object queryAllIssueCount(@RequestBody IssueQueryCondition con, HttpServletRequest request) {
		long count = 0;
		count = issueService.queryIssueCount(con);
		if(count<=0){
			return ResultUtil.errorWithMsg("没有任务被创建！");
		}
		return ResultUtil.success(count);
	}
	
	@ResponseBody
	@RequestMapping("/miningByTime")
	public Object miningByTime(@RequestParam(value = "startTime", required = true) Date startTime,
			@RequestParam(value = "endTime", required = true) Date endTime, HttpServletRequest request) {
		String issueId = redisService.getString(KEY.ISSUE_ID, request);
		if (StringUtils.isEmpty(issueId)) {
			return ResultUtil.errorWithMsg("请重新选择任务");
		}
		List<String[]> count = issueService.miningByTime(startTime, endTime, request);
		if (count == null) {
			return ResultUtil.unknowError();
		}
		return ResultUtil.success(count);
	}

	 @ResponseBody
    @RequestMapping("/miningByFile")
    public Object miningByFileIds(@RequestBody List<String> fileIds,  HttpServletRequest request) {
      
		 System.out.println("-------------");
		 System.out.println("-------------"+fileIds.size());
        for (String string : fileIds) {
        	System.out.println("-------------"+string);
		}
    	String issueId = redisService.getString(KEY.ISSUE_ID, request);
        if (StringUtils.isEmpty(issueId)) {
            return ResultUtil.errorWithMsg("请重新选择任务");
        }
        List<String[]> count = issueService.miningByFileIds(fileIds, request);
        if (count == null) {
            return ResultUtil.unknowError();
        }
        return ResultUtil.success(count);
    }

	/**
	 * 单文件聚类
	 * @param fileId 聚类文件id
	 * @param request
	 * @return
	 */
    @ResponseBody
    @RequestMapping("/miningSingleFile")
    public Object miningSingleFile(@RequestParam(value = "fileId", required = true) String fileId, HttpServletRequest request) {
        String issueId = redisService.getString(KEY.ISSUE_ID, request);
        if (StringUtils.isEmpty(issueId)) {
            return ResultUtil.errorWithMsg("请重新选择任务");
        }
        List<String> fileIds = new ArrayList<String>();
        fileIds.add(fileId);
        System.out.println("hahahah");
        List<String[]> count = issueService.miningByFileIds(fileIds, request);
      
        if (count == null) {
            return ResultUtil.unknowError();
        }
        return ResultUtil.successWithoutMsg();
    }

	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		CustomDateEditor editor = new CustomDateEditor(df, false);
		binder.registerCustomEditor(Date.class, editor);
	}


}

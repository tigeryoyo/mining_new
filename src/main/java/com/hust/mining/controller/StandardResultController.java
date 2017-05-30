package com.hust.mining.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hust.mining.constant.Constant.KEY;
import com.hust.mining.model.Issue;
import com.hust.mining.model.StandardResult;
import com.hust.mining.service.IssueService;
import com.hust.mining.service.RedisService;
import com.hust.mining.service.StandardResultService;
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
}

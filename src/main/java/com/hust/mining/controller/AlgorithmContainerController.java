package com.hust.mining.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hust.mining.model.params.Condition;
import com.hust.mining.service.AlgorithmContainerService;
import com.hust.mining.service.FileService;
import com.hust.mining.service.IssueService;
import com.hust.mining.service.RedisService;
import com.hust.mining.service.ResultService;
import com.hust.mining.service.UserService;
import com.hust.mining.service.WebsiteService;
import com.hust.mining.util.ResultUtil;

@Controller
@RequestMapping("/Al")
public class AlgorithmContainerController {
	
	 /**
     * Logger for this class
     */
    private static final Logger logger = LoggerFactory.getLogger(FileController.class);

    @Autowired
    private AlgorithmContainerService algorithmContainerService;
    @Autowired
    private IssueService issueService;
    @Autowired
    private ResultService resultService;
    @Autowired
    private UserService userService;
    @Autowired
    private WebsiteService websiteService;
    @Autowired
    private RedisService redisService;
	/**
	 *  上传测试算法效果的文档
	 * @param file
	 * @param titleIndex
	 * @param timeIndex
	 * @param urlIndex
	 * @param sourceType
	 * @param request
	 * @return
	 */
	@ResponseBody
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public Object upload(@RequestParam(value = "file", required = true) MultipartFile file,
            @RequestParam(value = "titleIndex", required = true) int titleIndex,
            @RequestParam(value = "timeIndex", required = true) int timeIndex,
            @RequestParam(value = "urlIndex", required = true) int urlIndex,
            @RequestParam(value = "sourceType", required = true) String sourceType, HttpServletRequest request)
	{
        // 数组之间必须是一一对应关系
        if (file.isEmpty()) {
            logger.info(file.getName() + "is empty");
            return ResultUtil.errorWithMsg("文件为空");
        }
        System.out.println("iiiii");
        Condition condition = new Condition();
        condition.setFile(file);
        condition.setTimeIndex(timeIndex);
        condition.setUrlIndex(urlIndex);
        condition.setTitleIndex(titleIndex);
        condition.setSourceType(sourceType);
        if (algorithmContainerService.getContent(condition, request) == 0) {
            logger.info("file insert failed");
            return ResultUtil.errorWithMsg("读取文件内容失败");
        }
        return ResultUtil.success("读取文件内容成功");
    }
	
	

}

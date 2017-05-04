package com.hust.mining.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hust.mining.model.User;
import com.hust.mining.service.UserService;
import com.hust.mining.util.ResultUtil;

/**
 * 用户个人信息管理控制器
 * 包括信息查看和修改、密码修改等
 * @author tankai
 *
 */
@Controller
@RequestMapping("/personal")
public class PersonalController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    
	@Autowired
	private UserService userService;
	
	/**
	 * 获得当前登录用户的个人信息
	 * @param request
	 * @return
	 */
	@ResponseBody
    @RequestMapping(value = "/getCurrentUserInfo", method = RequestMethod.GET)
    public Object getCurrentUser(@RequestParam(value = "userName", required = true) String userName,HttpServletRequest request) {
		System.out.println("getCurrentUserInfo"+userName);
        String username = userService.getCurrentUser(request);
        List<User> users = userService.selectSingleUserInfo(username, request);
        if (null == users || users.size() == 0) {
            return ResultUtil.errorWithMsg("sorry! user is not exist");
        }
        System.out.println(users.get(0).getTrueName());
        return ResultUtil.success(users.get(0));
    }
}

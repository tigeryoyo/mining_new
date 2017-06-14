package com.hust.mining.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.hust.mining.model.Label;
import com.hust.mining.service.LabelService;
import com.hust.mining.util.ResultUtil;

@Controller
@RequestMapping("/label")
public class LabelController {
	
	@Autowired
	private LabelService labelService;
	
	@ResponseBody
	@RequestMapping("/selectAllLabel")
	public Object selectAllLabel(@RequestParam(value="start", required=true) int start,
			@RequestParam(value = "limit", required = true) int limit, HttpServletRequest request)
	{
		List<Label> labels = labelService.selectAllLable(start, limit);
		if (labels.isEmpty()){
			return ResultUtil.errorWithMsg("没有标签存在！");
		}
		return ResultUtil.success(labels);
	}
	
	@ResponseBody
	@RequestMapping("/selectlabelcount")
	public Object selectlabelcount(@RequestParam(value="labelname",required = false)String labelname,
			HttpServletRequest request)
	{
		long count=0;
		if (null==labelname) {
			count=labelService.selectallcount();
		}
		else {
			count=labelService.selectLabelCount(labelname);
		}
		
		if (count<=0) {
			return ResultUtil.errorWithMsg("没有相关的标签");
		}
		return ResultUtil.success(count);
	}
	
	/**
	 * 根据标签名查询标签,相似查找
	 */
	@ResponseBody
	@RequestMapping("/selectLabelByName")
	public Object selectLabelByName(@RequestParam(value="labelname", required=true) String labelname,
			@RequestParam(value = "start", required = true) int start,
			@RequestParam(value = "limit", required = true) int limit,
			HttpServletRequest request)
	{
		List<Label> labels = labelService.selectLableLikeName(labelname,start,limit);
		if (labels.isEmpty()) {
			return ResultUtil.errorWithMsg("不存在相关的标签！");
		}
		return ResultUtil.success(labels);
	}
	
	/**
	 * 添加标签
	 */
	@ResponseBody
	@RequestMapping("insertLabel")
	public Object insertLabel(@RequestParam(value="labelname", required=true) String labelname,
			HttpServletRequest request)
	{
		Label label= new Label();
		label.setLabelname(labelname);
		boolean status = labelService.insertLable(labelname);
		if (status==false) {
			return ResultUtil.errorWithMsg(" 标签已存在！");
		}
		return ResultUtil.success(" 插入标签成功！");
	}
	
	/**
	 * 根据ID删除标签
	 */
	@ResponseBody
	@RequestMapping("/deleteLabelById")
	public Object deleteLabelById(@RequestParam(value="labelId", required=true) int labelid,
			HttpServletRequest request)
	{
		boolean status = labelService.deleteLabelById(labelid);
		if (status==false) {
			return ResultUtil.errorWithMsg("删除失败！");
		}
		return ResultUtil.success("删除成功！");
	}
	

	
	@ResponseBody
	@RequestMapping("/updateLabel")
	public Object updateLabel(@RequestParam(value="labelid",required=true)int labelid,
			@RequestParam(value="labelname",required=true) String labelname ,HttpServletRequest request)
	{
		Label label = new Label();
		label.setLabelid(labelid);
		label.setLabelname(labelname);
		boolean status = labelService.updateLabel(label);
		if (status==false) {
			ResultUtil.errorWithMsg("标签更新失败！");
		}
		return ResultUtil.success("标签修改成功！");
	}
	

}

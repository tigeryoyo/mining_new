package com.hust.mining.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.tools.ant.taskdefs.optional.depend.constantpool.StringCPInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hust.mining.dao.StandardResult_labeDao;
import com.hust.mining.model.StandardResult_label;
import com.hust.mining.service.StandardResult_labelService;

@Service
public class StandardResult_labelServiceImpl implements StandardResult_labelService {

	private static final Logger logger = LoggerFactory.getLogger(StandardResult_labelServiceImpl.class);
	
	@Autowired
	private StandardResult_labeDao standartResult_labeldao;
	/**
	 * 为准数据贴标签，参数为任务ID，以及标签ID
	 */
	@Override
	public boolean attachlabels(String staResId, List<Integer> labels) {
		StandardResult_label standardResult_label = new StandardResult_label();
		//遍历标签列表
		for (Integer label : labels) {
			standardResult_label.setLabelid(label);
			standardResult_label.setStdRid(staResId);
			//判断插入语句是否成功执行
			int status = standartResult_labeldao.insert(standardResult_label);
			if (status==0) {
				logger.info("为"+staResId+"任务贴标签失败！");
				return false;
			}
		}
		return true;
	}

	/**
	 * 返回的是标签的list
	 */
	@Override
	public List<Integer> selectLabelsForStandResult(String stdResId) {
		List<StandardResult_label> standardResult_labels = standartResult_labeldao.selectLabelsForStandResult(stdResId);
		List<Integer> labelids = new ArrayList<Integer>();
		for (StandardResult_label standardResult_label : standardResult_labels) {
			Integer integer = standardResult_label.getLabelid();
			labelids.add(integer);
		}
		return labelids;
	}

	@Override
	public List<String> selectStandResultsBylabel(int labelid) {
		List<StandardResult_label> standardResult_labels = standartResult_labeldao.selectStandResultsBylabel(labelid);
		List<String> list = new ArrayList<String>();
		for (StandardResult_label standardResult_label : standardResult_labels) {
			String string = standardResult_label.getStdRid();
			list.add(string);
		}
		return list;
	}
	
	@Override
	public boolean delete(String stdResId,int labelid)
	{
		int status = standartResult_labeldao.delete(stdResId, labelid);
		if (status==0) {
			logger.info("为任务删除标签失败！");
			return false;
		}
		return true;
	}

}

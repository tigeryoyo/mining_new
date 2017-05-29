package com.hust.mining.service.impl;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hust.mining.dao.StandardResultDao;
import com.hust.mining.model.StandardResult;
import com.hust.mining.model.params.StandardResultQueryCondition;
import com.hust.mining.service.IssueService;
import com.hust.mining.service.StandardResultService;
import com.hust.mining.service.UserService;

@Service
public class StandardResultServiceImpl implements StandardResultService {

	private static final Logger logger = LoggerFactory.getLogger(StandardResultServiceImpl.class);

	@Autowired
	private StandardResultDao standardResultDao;
	@Autowired
	private UserService userService;

	@Override
	public int insert(StandardResultQueryCondition con, HttpServletRequest request) {
		StandardResult standardResult =new StandardResult();
		standardResult.setStdRid(UUID.randomUUID().toString());
		standardResult.setContentName(con.getResId());
		standardResult.setCreator(userService.getCurrentUser(request));
		standardResult.setCreateTime(new Date());
		standardResult.setIssueId(con.getIssueId());
		standardResult.setResName(con.getStdResName());
		return standardResultDao.insert(con, standardResult);
	}

	@Override
	public int deleteById(String stdResId) {
		return standardResultDao.deleteById(stdResId);
	}

	@Override
	public List<StandardResult> queryStdRessByIssueId(String issueId) {
		return standardResultDao.queryStdRessByIssueId(issueId);
	}

	@Override
	public List<StandardResult> searchstdRessByTime(String issueId, Date start, Date end) {
		return null;
	}

}

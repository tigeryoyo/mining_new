package com.hust.mining.service.impl;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hust.mining.dao.CoreResultDao;
import com.hust.mining.model.CoreResult;
import com.hust.mining.model.params.CoreResultQueryCondition;
import com.hust.mining.service.CoreResultService;
import com.hust.mining.service.UserService;

@Service
public class CoreResultImpl implements CoreResultService {

	@Autowired
	private CoreResultDao coreResultDao;
	@Autowired
	private UserService userService;
	
	@Override
	public int insert(CoreResultQueryCondition con, HttpServletRequest request) {
		CoreResult coreResult = new CoreResult();
		coreResult.setCoreRid(UUID.randomUUID().toString());
		coreResult.setIssueId(con.getIssueId());
		coreResult.setResName(con.getCoreResName());
		coreResult.setCreateTime(new Date());
		coreResult.setCreator(userService.getCurrentUser(request));
		return coreResultDao.insert(con, coreResult);
	}

	@Override
	public int deleteById(String coreResId) {
		return coreResultDao.deleteById(coreResId);
	}
	
	@Override
	public CoreResult queryCoreResById(String coreResId) {
		return coreResultDao.queryCoreResById(coreResId);
	}

	@Override
	public List<CoreResult> queryCoreRessByIssueId(String issueId) {
		return coreResultDao.queryCoreRessByIssueId(issueId);
	}

}

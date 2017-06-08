package com.hust.mining.dao;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hust.mining.dao.mapper.CoreResultMapper;
import com.hust.mining.model.CoreResult;
import com.hust.mining.model.CoreResultExample;
import com.hust.mining.model.CoreResultExample.Criteria;
import com.hust.mining.model.params.CoreResultQueryCondition;

@Repository
public class CoreResultDao {
	private static final Logger logger = LoggerFactory.getLogger(CoreResultDao.class);
	
	@Autowired
	private CoreResultMapper coreResultMapper;
	
	public int insert(CoreResultQueryCondition con, CoreResult coreResult) {
		return coreResultMapper.insert(coreResult); 
	}
	
	public List<CoreResult> queryCoreRessByIssueId(String issueId) {
		CoreResultExample example = new CoreResultExample();
		Criteria criteria = example.createCriteria();
		criteria.andIssueIdEqualTo(issueId);
		return coreResultMapper.selectByExample(example);
	}
	
	public CoreResult queryCoreResById(String coreResId) {
		return coreResultMapper.selectByPrimaryKey(coreResId);
	}
	
	public int deleteById(String coreResId) {
		return coreResultMapper.deleteByPrimaryKey(coreResId);
	}
}

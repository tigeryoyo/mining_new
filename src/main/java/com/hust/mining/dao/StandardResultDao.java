package com.hust.mining.dao;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.common.io.Files;
import com.hust.mining.constant.Constant.DIRECTORY;
import com.hust.mining.dao.mapper.StandardResultMapper;
import com.hust.mining.model.StandardResult;
import com.hust.mining.model.StandardResultExample;
import com.hust.mining.model.params.StandardResultQueryCondition;
import com.hust.mining.util.FileUtil;

@Repository
public class StandardResultDao {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = LoggerFactory.getLogger(StandardResultDao.class);

	@Autowired
	private StandardResultMapper standardResultMapper;

	public int insert(StandardResultQueryCondition con,StandardResult standardResult) {
		String from = DIRECTORY.MODIFY_CLUSTER+con.getResId();
		String to = DIRECTORY.STDRES_CLUSTER+standardResult.getStdRid();
		try {
			Files.copy(new File(from), new File(to));
		} catch (IOException e) {
			logger.error("create standard result cluster from {} failed",from);
			return 0;
		}
		from = DIRECTORY.MODIFY_COUNT+con.getResId();
		to = DIRECTORY.STDRES_COUNT+standardResult.getStdRid();
		try {
			Files.copy(new File(from), new File(to));
		} catch (IOException e) {
			logger.error("create standard result cluster from {} failed",from);
			return 0;
		}
		
		return standardResultMapper.insert(standardResult);
	}
	
	public int deleteById(String stdResId){
		if(!FileUtil.delete(DIRECTORY.STDRES_CLUSTER+stdResId) && !FileUtil.delete(DIRECTORY.STDRES_COUNT+stdResId)){
			logger.error("delete standard cluster && count fail.");
		}
		return standardResultMapper.deleteByPrimaryKey(stdResId);
	}
	

	public StandardResult queryStdResById(String stdResId) {
		return standardResultMapper.selectByPrimaryKey(stdResId);
	}
	
	public List<StandardResult> queryStdRessByIssueId(String issueId) {
		StandardResultExample example = new StandardResultExample();
		example.createCriteria().andIssueIdEqualTo(issueId);
		example.setOrderByClause("create_time desc");
        return standardResultMapper.selectByExample(example);
	}
	
	public List<String[]> getContentById(String path, String name){
		return FileUtil.read(path+name);
	}
}

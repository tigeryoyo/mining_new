package com.hust.mining.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hust.mining.constant.Constant.DIRECTORY;
import com.hust.mining.constant.Constant.Index;
import com.hust.mining.dao.StandardResultDao;
import com.hust.mining.model.StandardResult;
import com.hust.mining.model.params.StandardResultQueryCondition;
import com.hust.mining.service.StandardResultService;
import com.hust.mining.service.UserService;
import com.hust.mining.util.AttrUtil;
import com.hust.mining.util.ConvertUtil;

@Service
public class StandardResultServiceImpl implements StandardResultService {

	private static final Logger logger = LoggerFactory.getLogger(StandardResultServiceImpl.class);

	@Autowired
	private StandardResultDao standardResultDao;
	@Autowired
	private UserService userService;

	@Override
	public int insert(StandardResultQueryCondition con, HttpServletRequest request) {
		StandardResult standardResult = new StandardResult();
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
	public StandardResult queryStdResById(String stdResId) {
		return standardResultDao.queryStdResById(stdResId);
	}

	@Override
	public List<StandardResult> queryStdRessByIssueId(String issueId) {
		return standardResultDao.queryStdRessByIssueId(issueId);
	}

	@Override
	public int updateByPrimaryKey(StandardResult record){
		return standardResultDao.updateByPrimaryKey(record);
	}
	
	@Override
	public List<StandardResult> searchstdRessByTime(String issueId, Date start, Date end) {
		return null;
	}

	@Override
	public List<String[]> getStdResCountById(String stdResId) {
		StandardResult standardResult = queryStdResById(stdResId);
		List<String[]> stdCount = standardResultDao.getContentById(DIRECTORY.STDRES_COUNT, stdResId);
		List<String[]> list = new ArrayList<String[]>();
		try {
			List<String[]> content = standardResultDao.getContentById(DIRECTORY.CONTENT,
					standardResult.getContentName());
			List<int[]> count = ConvertUtil.toIntList(stdCount);
			for (int[] item : count) {
				String[] old = content.get(item[Index.COUNT_ITEM_INDEX] + 1);
				String[] ne = new String[old.length + 1];
				System.arraycopy(old, 0, ne, 1, old.length);
				ne[0] = item[Index.COUNT_ITEM_AMOUNT] + "";
				list.add(ne);
			}
			//返回的list,第一个list元素存储title、url、time的索引
			list.add(0, AttrUtil.findEssentialIndex(content.get(0)));
		} catch (Exception e) {
			logger.error("get count result failed:{}", e.toString());
			return null;
		}

		return list;
	}

	@Override
	public List<String[]> getStdResContentById(String stdResId) {
		StandardResult standardResult = queryStdResById(stdResId);
		List<String[]> cluster = new ArrayList<String[]>();

		List<int[]> clusterIndex = ConvertUtil
				.toIntList(standardResultDao.getContentById(DIRECTORY.STDRES_CLUSTER, stdResId));
		List<String[]> content = standardResultDao.getContentById(DIRECTORY.CONTENT, standardResult.getContentName());

		try {
			// 保存第一行属性
			String[] attrs = content.get(0);
			content.remove(0);
			for (int[] set : clusterIndex) {
				for (int index : set) {
					String[] row = content.get(index);
					row = Arrays.copyOf(row, attrs.length);
					cluster.add(row);
				}
				cluster.add(new String[1]);
			}
			cluster.add(0, attrs);
		} catch (Exception e) {
			logger.error("exception occur when getStdResContentById() result:{}", e.toString());
			return null;
		}
		return cluster;
	}

	@Override
	public String getDateCount(List<String[]> cluster) {
		return standardResultDao.dateCount(cluster);
	}

	@Override
	public String getSourceCount(List<String[]> cluster) {
		return standardResultDao.sourceCount(cluster);
	}

}

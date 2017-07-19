package com.hust.mining.service.impl;

import java.io.File;
import java.util.ArrayList;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.tools.ant.taskdefs.Mkdir;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hust.mining.constant.Constant;
import com.hust.mining.constant.Constant.DIRECTORY;
import com.hust.mining.constant.Constant.Index;
import com.hust.mining.dao.IssueDao;
import com.hust.mining.dao.StandardResultDao;
import com.hust.mining.model.Issue;
import com.hust.mining.model.StandardResult;
import com.hust.mining.model.params.IssueQueryCondition;
import com.hust.mining.model.params.StandardResultQueryCondition;
import com.hust.mining.service.IssueService;
import com.hust.mining.service.StandardResultService;
import com.hust.mining.service.UserService;
import com.hust.mining.util.AttrUtil;
import com.hust.mining.util.ConvertUtil;
import com.hust.mining.util.FileUtil;

@Service
public class StandardResultServiceImpl implements StandardResultService {

	private static final Logger logger = LoggerFactory.getLogger(StandardResultServiceImpl.class);

	@Autowired
	private StandardResultDao standardResultDao;
	@Autowired
	private UserService userService;
	@Autowired
	private IssueService issueService;
	@Autowired
	private IssueDao issueDao;

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

	/**
	 * 从存放聚类好的内容list生成准数据，并保存到文件系统和数据库
	 */
	@Override
	public String createStandResult(List<String[]> list, HttpServletRequest request) {
	
		String issueid = issueService.getCurrentIssueId(request);
		String user = userService.getCurrentUser(request);
		
		//当前泛数据issue
		Issue issue = issueService.queryIssueById(issueid);
		if(issue == null){
			return "";
		}
		Issue stdissue = null;
		StandardResult stdres = null;
		if(StringUtils.isBlank(issue.getIssueHold())){
			//准数据issue
			stdissue = new Issue();
			stdissue.setIssueId(UUID.randomUUID().toString());
			stdissue.setIssueName(issue.getIssueName());
			stdissue.setIssueType(Constant.ISSUETYPE_STANDARD);
			stdissue.setIssueBelongTo(issueid);
			stdissue.setCreator(user);
			stdissue.setCreateTime(new Date());
			stdissue.setLastOperator(user);
			stdissue.setLastUpdateTime(new Date());
			//将创建的准数据issue添加到数据库
			int insert = issueDao.insert(stdissue);
			if(insert <= 0){
				return "";
			}
			//更新准数据对应的泛数据信息
			issue.setIssueHold(stdissue.getIssueId());
			int upd = issueDao.updateIssueInfo(issue);
			if(upd <= 0){
				return "";
			}
			stdres = new StandardResult();
			stdres.setStdRid(UUID.randomUUID().toString());
			String contentName = UUID.randomUUID().toString();
			stdres.setContentName(contentName);
			boolean w = FileUtil.write(DIRECTORY.STDRES_CONTENT+contentName, list);
			if(!w){
				return "";
			}
			stdres.setDateCount(getDateCount(list));
			stdres.setSourceCount(getSourceCount(list));
			stdres.setCreator(userService.getCurrentUser(request));
			stdres.setCreateTime(new Date());
			stdres.setIssueId(stdissue.getIssueId());
			stdres.setResName(stdissue.getIssueName());
			insert = standardResultDao.insert(stdres);
			
			if(insert <= 0){
				return "";
			}
			return stdres.getStdRid();
		}
		
		//准数据issue
		stdissue = issueService.queryIssueById(issue.getIssueHold());
		stdissue.setIssueType(Constant.ISSUETYPE_STANDARD);
		stdissue.setIssueBelongTo(issueid);
		stdissue.setLastOperator(user);
		stdissue.setLastUpdateTime(new Date());
		int update = issueDao.updateIssueInfo(stdissue);
		if(update <= 0){
			return "";
		}
		List<StandardResult> stdress = standardResultDao.queryStdRessByIssueId(issue.getIssueHold());
		if(stdress != null && !stdress.isEmpty()){
			
			//获得对应的准数据
			stdres = stdress.get(0);
			String contentName = stdres.getContentName();
			FileUtil.delete(DIRECTORY.STDRES_CONTENT+contentName);
			if(!new File(DIRECTORY.STDRES_CONTENT).exists()){
				new File(DIRECTORY.STDRES_CONTENT).mkdir();
			}
			boolean w = FileUtil.write(DIRECTORY.STDRES_CONTENT+contentName, list);
			if(!w){
				return "";
			}
			stdres.setDateCount(getDateCount(list));
			stdres.setSourceCount(getSourceCount(list));
			stdres.setCreator(userService.getCurrentUser(request));
			stdres.setCreateTime(new Date());
			stdres.setIssueId(stdissue.getIssueId());
			stdres.setResName(stdissue.getIssueName());
			int up = standardResultDao.updateByPrimaryKey(stdres);
			if(up <= 0){
				return "";
			}
			return stdres.getStdRid();
		}
		
		return "";		
	}

	/**
	 * 准数据聚类结果每类第一条，类中元素数量
	 */
	@Override
	public List<String[]> getCountResultById(String resultId) {
		// 
		List<String[]> content = new ArrayList<>();
		List<String[]> list = new ArrayList<>();
		StandardResult stdRes = standardResultDao.queryStdResById(resultId);
		if(stdRes == null){
			return list;
		}
		//保存的准数据内容，已经聚类好的数据，以空行区分
		content = FileUtil.read(DIRECTORY.STDRES_CONTENT+stdRes.getContentName());
		System.out.println("------------zhunshujushuliang---"+content.size());
		if(content == null || content.isEmpty()){
			return list;
		}
		list.add(AttrUtil.findEssentialIndex(content.get(0)));
		
		ArrayList<ArrayList<String[]>> clusters = new ArrayList<>();
		//是否为一个新类的第一个
		boolean isNew = true;
		ArrayList<String[]> cluster = null;
		for(int i = 1 ; i < content.size();i++ ){
			if(isNew){
				cluster = new ArrayList<>();
				cluster.add(content.get(i));
				isNew = false;
			}
			if(isBlankRow(content.get(i))){
				isNew = true;
				continue;
			}
			cluster.add(content.get(i));
		}
		for(ArrayList<String[]> c : clusters ){			
			String[] old = c.get(0);
	        String[] ne = new String[old.length + 1];
	        System.arraycopy(old, 0, ne, 1, old.length);
	        ne[0] = c.size() + "";
	        list.add(ne);		
        }
		System.out.println("------------zhunshujushuliang---"+list.size());
		return list;
	}

	/**
	 * 判断一个字符串数组是否全为空
	 * @param strs
	 * @return
	 */
	private boolean isBlankRow(String[] strs) {
		// TODO Auto-generated method stub
		for(String s : strs){
			if(!s.equals("")){
				return false;
			}
		}
		return true;
	}

}

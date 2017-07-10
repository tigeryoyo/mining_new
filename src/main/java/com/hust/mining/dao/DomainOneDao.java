package com.hust.mining.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hust.mining.dao.mapper.DomainOneMapper;
import com.hust.mining.model.DomainOne;
import com.hust.mining.model.DomainOneExample;
import com.hust.mining.model.DomainOneExample.Criteria;
import com.hust.mining.model.params.DomainOneQueryCondition;

@Repository
public class DomainOneDao {
	private static final Logger logger = LoggerFactory.getLogger(CoreResultDao.class);

	@Autowired
	private DomainOneMapper domainOneMapper;

	/**
	 * 按时间顺序分页查找一级域名，当start、limit均为0时，为查询所有一级域名
	 * 
	 * @param start
	 *            开始位置
	 * @param limit
	 *            查询数目
	 * @return
	 */
	public List<DomainOne> getAllDomainOneOrderByTime(int start, int limit) {
		List<DomainOne> list = new ArrayList<DomainOne>();
		DomainOneExample example = new DomainOneExample();
		Criteria criteria = example.createCriteria();
		criteria.andUuidIsNotNull();
		example.setOrderByClause("update_time desc");
		example.setStart(start);
		example.setLimit(limit);
		list = domainOneMapper.selectByExample(example);
		return list;
	}
	
	/**
	 * 根据uuid查找一级域名
	 * @param uuid
	 * @return
	 */
	public DomainOne getDomainOneById(String uuid){
		return domainOneMapper.selectByPrimaryKey(uuid);
	}

	/**
	 * 按权重大小顺序查询所有权重非0的一级域名
	 * 
	 * @return
	 */
	public List<DomainOne> getAllDomainOneOrderByWeight() {
		List<DomainOne> list = new ArrayList<DomainOne>();
		DomainOneExample example = new DomainOneExample();
		Criteria criteria = example.createCriteria();
		criteria.andUuidIsNotNull();
		criteria.andWeightNotEqualTo(0);
		example.setOrderByClause("weight desc");
		example.setStart(0);
		example.setLimit(0);
		list = domainOneMapper.selectByExample(example);
		return list;
	}

	/**
	 * 按时间顺序分页查找已知一级域名，当start、limit均为0时，为查询所有已知一级域名 域名名不为‘其他’视为已知
	 * 
	 * @param start
	 *            开始位置
	 * @param limit
	 *            查询数目
	 * @return
	 */
	public List<DomainOne> getDomainOneOrderByTime(int start, int limit) {
		List<DomainOne> list = new ArrayList<DomainOne>();
		DomainOneExample example = new DomainOneExample();
		Criteria criteria = example.createCriteria();
		criteria.andUuidIsNotNull();
		criteria.andNameNotEqualTo("其他");
		example.setOrderByClause("update_time desc");
		example.setStart(start);
		example.setLimit(limit);
		list = domainOneMapper.selectByExample(example);
		return list;
	}

	/**
	 * 按时间顺序分页查找未知一级域名，当start、limit均为0时，为查询所有未知一级域名 域名名为‘其他’视为未知
	 * 
	 * @param start
	 *            开始位置
	 * @param limit
	 *            查询数目
	 * @return
	 */
	public List<DomainOne> getUnknowDomainOneOrderByTime(int start, int limit) {
		List<DomainOne> list = new ArrayList<DomainOne>();
		DomainOneExample example = new DomainOneExample();
		Criteria criteria = example.createCriteria();
		criteria.andUuidIsNotNull();
		criteria.andNameEqualTo("其他");
		example.setOrderByClause("update_time desc");
		example.setStart(start);
		example.setLimit(limit);
		list = domainOneMapper.selectByExample(example);
		return list;
	}

	/**
	 * 按时间顺序和条件分页查找一级域名，当start、limit均为0时，为查询所有符合条件的一级域名
	 * 
	 * @param condition
	 * @return
	 */
	public List<DomainOne> getDomainOneOrderByTime(DomainOneQueryCondition condition) {
		DomainOneExample example = new DomainOneExample();
		Criteria criteria = example.createCriteria();
		if (!StringUtils.isBlank(condition.getName())) {
			criteria.andNameLike("%"+condition.getName()+"%");
		}
		if (!StringUtils.isBlank(condition.getUrl())) {
			criteria.andUrlEqualTo(condition.getUrl());
		}
		if (!StringUtils.isBlank(condition.getColumn())) {
			criteria.andColumnEqualTo(condition.getColumn());
		}
		if (!StringUtils.isBlank(condition.getType())) {
			criteria.andTypeEqualTo(condition.getType());
		}
		if (!StringUtils.isBlank(condition.getRank())) {
			criteria.andRankEqualTo(condition.getRank());
		}
		if (!StringUtils.isBlank(condition.getIncidence())) {
			criteria.andIncidenceEqualTo(condition.getIncidence());
		}
		if (null != condition.getIsFather()) {
			criteria.andIsFatherEqualTo(condition.getIsFather());
		}
		if (null != condition.getWeight()) {
			criteria.andWeightEqualTo(condition.getWeight());
		}
		if (null != condition.getStart()) {
			example.setStart(condition.getStart());
		} else {
			example.setStart(0);
		}
		if (null != condition.getLimit()) {
			example.setLimit(condition.getLimit());
		} else {
			example.setLimit(0);
		}
		example.setOrderByClause("update_time desc");

		return domainOneMapper.selectByExample(example);
	}

	/**
	 * 查询所有一级域名的数目
	 * 
	 * @return 一级域名数
	 */
	public long getDomainOneCount() {
		DomainOneExample example = new DomainOneExample();
		Criteria criteria = example.createCriteria();
		criteria.andUuidIsNotNull();
		example.setStart(0);
		example.setLimit(0);
		return domainOneMapper.countByExample(example);
	}

	/**
	 * 查询符合条件的一级域名数
	 * 
	 * @param condition
	 * @return
	 */
	public long getDomainOneCountByExample(DomainOneQueryCondition condition) {
		DomainOneExample example = new DomainOneExample();
		Criteria criteria = example.createCriteria();
		if (!StringUtils.isBlank(condition.getName())) {
			criteria.andNameLike("%"+condition.getName()+"%");
		}
		if (!StringUtils.isBlank(condition.getUrl())) {
			criteria.andUrlEqualTo(condition.getUrl());
		}
		if (!StringUtils.isBlank(condition.getColumn())) {
			criteria.andColumnEqualTo(condition.getColumn());
		}
		if (!StringUtils.isBlank(condition.getType())) {
			criteria.andTypeEqualTo(condition.getType());
		}
		if (!StringUtils.isBlank(condition.getRank())) {
			criteria.andRankEqualTo(condition.getRank());
		}
		if (!StringUtils.isBlank(condition.getIncidence())) {
			criteria.andIncidenceEqualTo(condition.getIncidence());
		}
		if (null != condition.getIsFather()) {
			criteria.andIsFatherEqualTo(condition.getIsFather());
		}
		if (null != condition.getWeight()) {
			criteria.andWeightEqualTo(condition.getWeight());
		}
		if (null != condition.getStart()) {
			example.setStart(condition.getStart());
		} else {
			example.setStart(0);
		}
		if (null != condition.getLimit()) {
			example.setLimit(condition.getLimit());
		} else {
			example.setLimit(0);
		}
		return domainOneMapper.countByExample(example);
	}

	/**
	 * 根据给定条件删除域名
	 * 
	 * @param condition
	 * @return
	 */
	public int deleteDomainOne(DomainOneQueryCondition condition) {
		DomainOneExample example = new DomainOneExample();
		Criteria criteria = example.createCriteria();
		if (!StringUtils.isBlank(condition.getName())) {
			criteria.andNameLike("%"+condition.getName()+"%");
		}
		if (!StringUtils.isBlank(condition.getUrl())) {
			criteria.andUrlEqualTo(condition.getUrl());
		}
		if (!StringUtils.isBlank(condition.getColumn())) {
			criteria.andColumnEqualTo(condition.getColumn());
		}
		if (!StringUtils.isBlank(condition.getType())) {
			criteria.andTypeEqualTo(condition.getType());
		}
		if (!StringUtils.isBlank(condition.getRank())) {
			criteria.andRankEqualTo(condition.getRank());
		}
		if (!StringUtils.isBlank(condition.getIncidence())) {
			criteria.andIncidenceEqualTo(condition.getIncidence());
		}
		if (null != condition.getIsFather()) {
			criteria.andIsFatherEqualTo(condition.getIsFather());
		}
		if (null != condition.getWeight()) {
			criteria.andWeightEqualTo(condition.getWeight());
		}
		if (null != condition.getStart()) {
			example.setStart(condition.getStart());
		} else {
			example.setStart(0);
		}
		if (null != condition.getLimit()) {
			example.setLimit(condition.getLimit());
		} else {
			example.setLimit(0);
		}
		return domainOneMapper.deleteByExample(example);
	}

	/**
	 * 根据给定id删除域名
	 * 
	 * @param id
	 * @return
	 */
	public int delelteDomainOneById(String id) {
		return domainOneMapper.deleteByPrimaryKey(id);
	}

	/**
	 * 根据id更新domain信息
	 * 
	 * @param domainOne
	 *            存放id和要修改的信息
	 * @return
	 */
	public int updateDomainOneInfo(DomainOne domainOne) {
		return domainOneMapper.updateByPrimaryKeySelective(domainOne);
	}

	/**
	 * 根据给定条件查找对应域名并修改其信息
	 * 
	 * @param domainOne
	 *            要修改的信息
	 * @param condition
	 *            给定条件用来锁定要修改的域名
	 * @return
	 */
	public int updateDomainOneInfo(DomainOne domainOne, DomainOneQueryCondition condition) {
		DomainOneExample example = new DomainOneExample();
		Criteria criteria = example.createCriteria();
		if (!StringUtils.isBlank(condition.getName())) {
			criteria.andNameLike("%"+condition.getName()+"%");
		}
		if (!StringUtils.isBlank(condition.getUrl())) {
			criteria.andUrlEqualTo(condition.getUrl());
		}
		if (!StringUtils.isBlank(condition.getColumn())) {
			criteria.andColumnEqualTo(condition.getColumn());
		}
		if (!StringUtils.isBlank(condition.getType())) {
			criteria.andTypeEqualTo(condition.getType());
		}
		if (!StringUtils.isBlank(condition.getRank())) {
			criteria.andRankEqualTo(condition.getRank());
		}
		if (!StringUtils.isBlank(condition.getIncidence())) {
			criteria.andIncidenceEqualTo(condition.getIncidence());
		}
		if (null != condition.getIsFather()) {
			criteria.andIsFatherEqualTo(condition.getIsFather());
		}
		if (null != condition.getWeight()) {
			criteria.andWeightEqualTo(condition.getWeight());
		}
		if (null != condition.getStart()) {
			example.setStart(condition.getStart());
		} else {
			example.setStart(0);
		}
		if (null != condition.getLimit()) {
			example.setLimit(condition.getLimit());
		} else {
			example.setLimit(0);
		}
		return domainOneMapper.updateByExampleSelective(domainOne, example);

	}

	/**
	 * 批量插入一级域名，url重复的数据直接覆盖，没有的属性会设为默认值
	 * 
	 * @param domainOnes
	 * @return
	 */
	public int insertDomain(List<DomainOne> domainOnes) {
		return domainOneMapper.insertBatch(domainOnes);
	}

	/**
	 * 插入一条一级域名，没有的属性为默认值
	 * 
	 * @param domainOne
	 * @return 插入失败则返回0
	 */
	public int insertDomain(DomainOne domainOne) {
		return domainOneMapper.insertSelective(domainOne);
	}

}

package com.hust.mining.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hust.mining.dao.mapper.DomainTwoMapper;
import com.hust.mining.model.DomainTwo;
import com.hust.mining.model.DomainTwoExample;
import com.hust.mining.model.DomainTwoExample.Criteria;
import com.hust.mining.model.params.DomainTwoQueryCondition;

@Repository
public class DomainTwoDao {

	private static final Logger logger = LoggerFactory.getLogger(CoreResultDao.class);

	@Autowired
	private DomainTwoMapper domainTwoMapper;
	
	/**
	 * 按时间顺序根据给定查询条件查找符合要求的二级域名网站
	 * @param condition 查询条件
	 * @return
	 */
	public List<DomainTwo> getDomainTwoByCondition(DomainTwoQueryCondition condition){
		List<DomainTwo> list =  new ArrayList<>();
		DomainTwoExample example = new DomainTwoExample();
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
		if (null != condition.getFatherId()) {
			criteria.andFatherUuidEqualTo(condition.getFatherId());
		}
		if (null != condition.getWeight()) {
			criteria.andWeightEqualTo(condition.getWeight());
		}
		example.setOrderByClause("update_time desc");
		list = domainTwoMapper.selectByExample(example);
		return list;
	}
	/**
	 * 按权重大小查找权重不为0的所有二级域名
	 * @return
	 */
	public List<DomainTwo> getAllDomainOrderByWeight(){
		List<DomainTwo> list =  new ArrayList<>();
		DomainTwoExample example = new DomainTwoExample();
		Criteria criteria = example.createCriteria();
		criteria.andUuidIsNotNull();
		criteria.andWeightNotEqualTo(0);
		example.setOrderByClause("weight desc");
		list = domainTwoMapper.selectByExample(example);
		return list;
	}
	
	/**
	 * 根据父级域名id查找二级域名
	 * @param fatherUuid
	 * @return
	 */
	public List<DomainTwo> getDomainTwoByFatherId(String fatherUuid){
		List<DomainTwo> list =  new ArrayList<>();
		DomainTwoExample example = new DomainTwoExample();
		Criteria criteria = example.createCriteria();
		criteria.andFatherUuidEqualTo(fatherUuid);
		example.setOrderByClause("update_time desc");
		list = domainTwoMapper.selectByExample(example);
		return list;
	}
	
	/**
	 * 按时间顺序查询所有二级域名
	 * @return
	 */
	public List<DomainTwo> getAllDomainTwo(){
		List<DomainTwo> list =  new ArrayList<>();
		DomainTwoExample example = new DomainTwoExample();
		Criteria criteria = example.createCriteria();
		criteria.andUuidIsNotNull();
		example.setOrderByClause("update_time desc");
		list = domainTwoMapper.selectByExample(example);
		return list;
	}
	/**
	 * 查询所有二级域名的个数
	 * @return
	 */
	public long getDomainTwoCount(){
		List<DomainTwo> list =  new ArrayList<>();
		DomainTwoExample example = new DomainTwoExample();
		Criteria criteria = example.createCriteria();
		criteria.andUuidIsNotNull();
		return domainTwoMapper.countByExample(example);
	}
	
	/**
	 * 根据二级域名id查找二级域名
	 * @param uuid
	 * @return
	 */
	public DomainTwo getDomainTwoById(String uuid){
		return domainTwoMapper.selectByPrimaryKey(uuid);
	}
	
	/**
	 * 根据二级域名id删除二级域名
	 * @param uuid
	 * @return
	 */
	public long deleteDomainById(String uuid){
		return domainTwoMapper.deleteByPrimaryKey(uuid);
	}
	/**
	 * 根据查询条件删除二级域名
	 * @param condition
	 * @return
	 */
	public long deleteDomain(DomainTwoQueryCondition condition){
		DomainTwoExample example = new DomainTwoExample();
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
		if (null != condition.getFatherId()) {
			criteria.andFatherUuidEqualTo(condition.getFatherId());
		}
		if (null != condition.getWeight()) {
			criteria.andWeightEqualTo(condition.getWeight());
		}
		return domainTwoMapper.deleteByExample(example);
	}
	
	/**
	 * 根据id和要修改的信息更新二级域名信息
	 * @param record Domain对象包含uuid，和其他需要修改的信息，不需要修改的信息可以不设置
	 * @return
	 */
	public long updateDomainTwo(DomainTwo record){
		return domainTwoMapper.updateByPrimaryKeySelective(record);
	}
	/**
	 * 根据给定条件查找对应域名并修改其信息
	 * 
	 * @param record
	 *            要修改的信息
	 * @param condition
	 *            给定条件用来锁定要修改的域名
	 * @return
	 */
	public long updateDomainTwo(DomainTwo record,DomainTwoQueryCondition condition){
		DomainTwoExample example = new DomainTwoExample();
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
		if (null != condition.getFatherId()) {
			criteria.andFatherUuidEqualTo(condition.getFatherId());
		}
		if (null != condition.getWeight()) {
			criteria.andWeightEqualTo(condition.getWeight());
		}
		return domainTwoMapper.updateByExampleSelective(record, example);
	}
	
	/**
	 * 批量插入二级域名，重复的url直接覆盖，其中没有的属性会设为默认值
	 * @param domainTwos
	 * @return 返回0表示插入失败
	 */
	public long insertDomainTwo(List<DomainTwo> domainTwos){
		return domainTwoMapper.insertBatch(domainTwos);
	}
	
	/**
	 * 插入二级域名，重复的url直接覆盖，其中没有的属性会设为默认值
	 * @param domainTwo
	 * @return 返回0表示插入失败
	 */
	public long insertDomainTwo(DomainTwo domainTwo){
		return domainTwoMapper.insertSelective(domainTwo);
	}
}
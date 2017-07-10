package com.hust.mining.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hust.mining.dao.mapper.DomainPropertyMapper;
import com.hust.mining.model.DomainProperty;
import com.hust.mining.model.DomainPropertyExample;
import com.hust.mining.model.DomainPropertyExample.Criteria;
import com.hust.mining.model.params.DomainPropertyQueryCondition;

@Repository
public class DomainPropertyDao {
	private static final Logger logger = LoggerFactory.getLogger(CoreResultDao.class);
	
	@Autowired
	private DomainPropertyMapper domainPropertyMapper;
	
/*	*//**
	 * 根据域名id查找其对应的扩展属性关系
	 * @param id 域名的uuid
	 * @return
	 *//*
	public List<DomainProperty> getDomainPropertyByDomainId(String domainId){
		List<DomainProperty> list = new ArrayList<>();
		DomainPropertyExample example = new DomainPropertyExample();
		Criteria criteria = example.createCriteria();
		criteria.andDomainIdEqualTo(domainId);
		list = domainPropertyMapper.selectByExample(example);
		return list;
	}
	
	*//**
	 * 根据属性id查找域名扩展属性关系
	 * @param id 属性的id
	 * @return
	 *//*
	public List<DomainProperty> getDomainPropertyByPropertyId(Integer id){
		List<DomainProperty> list = new ArrayList<>();
		DomainPropertyExample example = new DomainPropertyExample();
		Criteria criteria = example.createCriteria();
		criteria.andPropertyIdEqualTo(id);
		list = domainPropertyMapper.selectByExample(example);
		return list;
	}
	
	*//**
	 * 根据属性id和域名id查找其对应关系，通常用来获取该域名的该扩展属性对应的值
	 * @param domainId
	 * @param id
	 * @return
	 *//*
	public List<DomainProperty> getDomainProperty(String domainId ,Integer id){
		List<DomainProperty> list = new ArrayList<>();
		DomainPropertyExample example = new DomainPropertyExample();
		Criteria criteria = example.createCriteria();
		criteria.andDomainIdEqualTo(domainId);
		criteria.andPropertyIdEqualTo(id);
		list = domainPropertyMapper.selectByExample(example);
		return list;
	}*/
	
	/**
	 * 根据给定条件查找满足条件的域名属性对应关系
	 * @param condition 
	 * @return
	 */
	public List<DomainProperty> getDomainPropertyByCondition(DomainPropertyQueryCondition condition){
		List<DomainProperty> list = new ArrayList<>();
		DomainPropertyExample example = new DomainPropertyExample();
		Criteria criteria = example.createCriteria();
		if(!StringUtils.isBlank(condition.getDomainUuid())){
			criteria.andDomainIdEqualTo(condition.getDomainUuid());
		}
		if(null != condition.getPropertyId()){
			criteria.andPropertyIdEqualTo(condition.getPropertyId());
		}
		if(!StringUtils.isBlank(condition.getValue())){
			criteria.andPropertyValueEqualTo(condition.getValue());
		}
		list = domainPropertyMapper.selectByExample(example);
		return list;
	}
	
	/**
	 * 删除满足指定条件的域名属性关系
	 * @param condition
	 * @return
	 */
	public long deleteDomainPropertyByCondition(DomainPropertyQueryCondition condition){
		DomainPropertyExample example = new DomainPropertyExample();
		Criteria criteria = example.createCriteria();
		if(!StringUtils.isBlank(condition.getDomainUuid())){
			criteria.andDomainIdEqualTo(condition.getDomainUuid());
		}
		if(null != condition.getPropertyId()){
			criteria.andPropertyIdEqualTo(condition.getPropertyId());
		}
		if(!StringUtils.isBlank(condition.getValue())){
			criteria.andPropertyValueEqualTo(condition.getValue());
		}
		return domainPropertyMapper.deleteByExample(example);
	}
	
	/**
	 * 通过primaryKey更新指定信息
	 * @param domainProperty 必须包含primaryKey id
	 * @return 更新失败返回0
	 */
	public long updateDomainProperty(DomainProperty domainProperty){
		return domainPropertyMapper.updateByPrimaryKeySelective(domainProperty);
	}
	
	/**
	 * 通过给定条件搜索出满足条件的关系，根据给定信息更新满足条件的关系
	 * @param domainProperty 给定更新信息 ，可以不包含primaryKey id
	 * @param condition 需要更新的关系必须满足的条件
	 * @return 更新失败返回0
	 */
	public long updateDomainProperty(DomainProperty domainProperty, DomainPropertyQueryCondition condition){
		DomainPropertyExample example = new DomainPropertyExample();
		Criteria criteria = example.createCriteria();
		if(!StringUtils.isBlank(condition.getDomainUuid())){
			criteria.andDomainIdEqualTo(condition.getDomainUuid());
		}
		if(null != condition.getPropertyId()){
			criteria.andPropertyIdEqualTo(condition.getPropertyId());
		}
		if(!StringUtils.isBlank(condition.getValue())){
			criteria.andPropertyValueEqualTo(condition.getValue());
		}
		return domainPropertyMapper.updateByExampleSelective(domainProperty, example);
	}
	
	public long insertDomainProperty(List<DomainProperty> list){
		return domainPropertyMapper.insertBatch(list);
	}
	
	public long insertDomainProperty(DomainProperty domainProperty){
		return domainPropertyMapper.insertSelective(domainProperty);
	}
	
	
}

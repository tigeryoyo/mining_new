package com.hust.mining.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hust.mining.dao.mapper.ExtraPropertyMapper;
import com.hust.mining.model.ExtraProperty;
import com.hust.mining.model.ExtraPropertyExample;
import com.hust.mining.model.ExtraPropertyExample.Criteria;
import com.hust.mining.model.params.ExtraPropertyQueryCondition;

@Repository
public class ExtraPropertyDao {
	private static final Logger logger = LoggerFactory.getLogger(CoreResultDao.class);
	
	@Autowired
	private ExtraPropertyMapper extraPropertyMapper;
	
	/**
	 * 查询所有扩展属性
	 * @return
	 */
	public List<ExtraProperty> getAllExtraProperty(){
		List<ExtraProperty> list = new ArrayList<>();
		ExtraPropertyExample example = new ExtraPropertyExample();
		Criteria criteria = example.createCriteria();
		criteria.andIdIsNotNull();
		list = extraPropertyMapper.selectByExample(example);
		return list;
	}
	/**
	 * 按条件分页查询所有扩展属性
	 * @param condition 当条件里的start，limit为空或为0时，默认为所有全部扩展属性
	 * @return
	 */
	public List<ExtraProperty> getExtraPropertyByCondition(ExtraPropertyQueryCondition condition){
		List<ExtraProperty> list = new ArrayList<>();
		ExtraPropertyExample example = new ExtraPropertyExample();
		Criteria criteria = example.createCriteria();
		if(!StringUtils.isBlank(condition.getName())){
			criteria.andNameLike("%"+condition.getName()+"%");
		}
		if(null != condition.getStart()){
			example.setStart(condition.getStart());
		}else{
			example.setStart(0);
		}
		if(null != condition.getLimit()){
			example.setLimit(condition.getLimit());
		}else{
			example.setLimit(0);
		}
		list = extraPropertyMapper.selectByExample(example);
		return list;
	}
	
	/**
	 * 通过id查询扩展属性
	 * @param id
	 * @return
	 */
	public ExtraProperty getExtraPropertyById(Integer id){
		return extraPropertyMapper.selectByPrimaryKey(id);
	}
	
	/**
	 * 删除指定id的扩展属性
	 * @param id
	 * @return
	 */
	public long deleteExtraProperty(Integer id){
		return extraPropertyMapper.deleteByPrimaryKey(id);
	}
	
	/**
	 * 删除满足指定条件的扩展属性
	 * @param condition
	 * @return
	 */
	public long deleteExtraProperty(ExtraPropertyQueryCondition condition){
		ExtraPropertyExample example = new ExtraPropertyExample();
		Criteria criteria = example.createCriteria();
		if(!StringUtils.isBlank(condition.getName())){
			criteria.andNameLike("%"+condition.getName()+"%");
		}
		return extraPropertyMapper.deleteByExample(example);
	}
	
	/**
	 * 根据id更新扩展属性
	 * @param extraProperty id为要更新的扩展属性id不能为空
	 * @return
	 */
	public long updateExtraProperty(ExtraProperty extraProperty){
		return extraPropertyMapper.updateByPrimaryKeySelective(extraProperty);
	}
	
	/**
	 * 插入扩展属性，属性名重复时不做插入操作
	 * @param extraProperty，id可以为空
	 * @return
	 */
	public long insertExtraProperty(ExtraProperty extraProperty){
		return extraPropertyMapper.insertSelective(extraProperty);
	}
	
	/**
	 * 批量插入扩展属性，属性名重复时略过，不做插入操作
	 * @param list 属性集合，id可以为空
	 * @return
	 */
	public long insertExtraProperty(List<ExtraProperty> list){
		return extraPropertyMapper.insertBatch(list);
	}
}

package com.hust.mining.dao.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.hust.mining.model.SourceType;
import com.hust.mining.model.SourceTypeExample;

public interface SourceTypeMapper {
    long countByExample(SourceTypeExample example);

    int deleteByExample(SourceTypeExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(SourceType record);

    int insertSelective(SourceType record);

    List<SourceType> selectByExample(SourceTypeExample example);

    SourceType selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") SourceType record, @Param("example") SourceTypeExample example);

    int updateByExample(@Param("record") SourceType record, @Param("example") SourceTypeExample example);

    int updateByPrimaryKeySelective(SourceType record);

    int updateByPrimaryKey(SourceType record);
}
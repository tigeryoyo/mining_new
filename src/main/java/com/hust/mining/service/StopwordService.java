package com.hust.mining.service;

import java.util.List;

import com.hust.mining.model.Stopword;

public interface StopwordService {
	/**
	 * 模糊分页查询停用词
	 * @param word 停用词
	 * @param start 起始位置
	 * @param limit 每页个数
	 * @return 查询到的停用词集合
	 */
	public List<Stopword> selectStopwordInforByWord(String word,int start,int limit);
	/**
	 * 分页查询所有停用词
	 * @param start 停用词
	 * @param limit 每页显示页数
	 * @return 查询到的停用词集合
	 */
	public List<Stopword> selectAllStopwordInfor(int start,int limit);
	/**
	 * 查询所有停用词个数
	 * @return
	 */
	public long selectCount();
	/**
	 * 插入单个停用词
	 * @param stopword
	 * @return
	 */
	public boolean insertStopword(Stopword stopword);
	/**
	 * 批量插入停用词
	 * @param list  停用词集合
	 * @return 插入成功的数目
	 */
	public boolean insertStopwords(List<Stopword> list);
	/**
	 * 根据给定id删除停用词
	 * @param id
	 * @return
	 */
	public boolean delStopwordById(Integer id);
}

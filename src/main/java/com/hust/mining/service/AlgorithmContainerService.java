package com.hust.mining.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.hust.mining.model.params.Condition;

public interface AlgorithmContainerService {

	  public List<double[]> Converter(List<String[]> list, int converterType);
	  
	  public List<List<Integer>> Sort(List<String[]> list, List<List<Integer>> resultIndexSetList);
	  
	  public List<List<Integer>> UseKmeans(List<String[]> list, int k,int granularity);
	  
	  public List<List<Integer>> UseCanopy(List<String[]> list, float Threshold,int granularity);
	  
	  public List<List<Integer>> UseDBScan(List<String[]> list, float Eps,int MinPts,int granularity);

	

	  int getContent(Condition con, HttpServletRequest request);
}

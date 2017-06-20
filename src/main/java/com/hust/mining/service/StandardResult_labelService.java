package com.hust.mining.service;

import java.util.List;

import org.apache.xmlbeans.impl.xb.xsdschema.Public;

import com.hust.mining.model.Label;

public interface StandardResult_labelService {
	
	public boolean attachlabels(String staResId,List<Integer> labels);
	
	public List<Label> selectLabelsForStandResult(String stdResId);
	
	public List<String> selectStandResultsBylabel(int labelid);

	boolean delete(String stdResId, int labelid);

	List<Label> findLabelNotInStandardResult(String stdResId);
	
}

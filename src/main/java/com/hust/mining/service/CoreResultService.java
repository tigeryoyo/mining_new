package com.hust.mining.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.hust.mining.model.CoreResult;
import com.hust.mining.model.params.CoreResultQueryCondition;

public interface CoreResultService {
	int insert(CoreResultQueryCondition con, HttpServletRequest request);

    int deleteById(String coreResId);
    
    CoreResult queryCoreResById(String coreResId);
    
    List<CoreResult> queryCoreRessByIssueId(String issueId);
}

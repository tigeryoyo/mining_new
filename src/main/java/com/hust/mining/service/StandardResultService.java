package com.hust.mining.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.hust.mining.model.StandardResult;
import com.hust.mining.model.params.StandardResultQueryCondition;

public interface StandardResultService {
	int insert(StandardResultQueryCondition con, HttpServletRequest request);

    int deleteById(String stdResId);

    List<StandardResult> queryStdRessByIssueId(String issueId);

    List<StandardResult> searchstdRessByTime(String issueId, Date start, Date end);
}

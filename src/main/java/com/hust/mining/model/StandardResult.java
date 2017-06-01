package com.hust.mining.model;

import java.io.Serializable;
import java.util.Date;

public class StandardResult implements Serializable {
	private static final long serialVersionUID = 1L;

	private String stdRid;

	private String resName;

	private String contentName;
	
	private String issueId;

	private Date createTime;

	private String creator;

	public String getStdRid() {
		return stdRid;
	}

	public void setStdRid(String stdRid) {
		this.stdRid = stdRid == null ? null : stdRid.trim();
	}

	public String getResName() {
		return resName;
	}

	public void setResName(String resName) {
		this.resName = resName == null ? null : resName.trim();
	}

	public String getContentName() {
		return contentName;
	}

	public void setContentName(String contentName) {
		this.contentName = contentName;
	}

	public String getIssueId() {
		return issueId;
	}

	public void setIssueId(String issueId) {
		this.issueId = issueId == null ? null : issueId.trim();
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator == null ? null : creator.trim();
	}
}
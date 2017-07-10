package com.hust.mining.model;

import java.util.Date;
import java.util.Map;

public class DomainTwoProperty {
    private String uuid;

    private String url;

    private String name;

    private String column;

    private String type;

    private String rank;

    private String incidence;

    private Integer weight;

    private String fatherUuid;

    private Date updateTime;
    
    private Map<String,String> extraProperty;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}

	public String getIncidence() {
		return incidence;
	}

	public void setIncidence(String incidence) {
		this.incidence = incidence;
	}

	public Integer getWeight() {
		return weight;
	}

	public void setWeight(Integer weight) {
		this.weight = weight;
	}

	public String getFatherUuid() {
		return fatherUuid;
	}

	public void setFatherUuid(String fatherUuid) {
		this.fatherUuid = fatherUuid;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Map<String, String> getExtraProperty() {
		return extraProperty;
	}

	public void setExtraProperty(Map<String, String> extraProperty) {
		this.extraProperty = extraProperty;
	}

	public void setDomainTwo(DomainTwo domainTwo) {
		// TODO Auto-generated method stub
		this.setColumn(domainTwo.getColumn());
		this.setIncidence(domainTwo.getIncidence());
		this.setFatherUuid(domainTwo.getFatherUuid());
		this.setName(domainTwo.getName());
		this.setRank(domainTwo.getRank());
		this.setType(domainTwo.getType());
		this.setUpdateTime(domainTwo.getUpdateTime());
		this.setUrl(domainTwo.getUrl());
		this.setUuid(domainTwo.getUuid());
		this.setWeight(domainTwo.getWeight());
	}
    
}

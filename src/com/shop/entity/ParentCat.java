package com.shop.entity;

import java.util.Date;

/**
 * 一级分类
 */
public class ParentCat {
	private Integer parentCatID;
	private String parentCatName;
	private String parentCatText;
	private Date parentCatTime;

	public Integer getParentCatID() {
		return parentCatID;
	}

	public void setParentCatID(Integer parentCatID) {
		this.parentCatID = parentCatID;
	}

	public String getParentCatName() {
		return parentCatName;
	}

	public void setParentCatName(String parentCatName) {
		this.parentCatName = parentCatName;
	}

	public String getParentCatText() {
		return parentCatText;
	}

	public void setParentCatText(String parentCatText) {
		this.parentCatText = parentCatText;
	}

	public Date getParentCatTime() {
		return parentCatTime;
	}

	public void setParentCatTime(Date parentCatTime) {
		this.parentCatTime = parentCatTime;
	}

}

package com.shop.entity;

import java.util.Date;

/**
 * 商品二级分类
 */
public class Category {
	private Integer categoryID;
	private Integer parentCatID;
	private String categoryName;
	private String categoryText;
	private Date categoryTime;

	public Integer getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(Integer categoryID) {
		this.categoryID = categoryID;
	}

	public Integer getParentCatID() {
		return parentCatID;
	}

	public void setParentCatID(Integer parentCatID) {
		this.parentCatID = parentCatID;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getCategoryText() {
		return categoryText;
	}

	public void setCategoryText(String categoryText) {
		this.categoryText = categoryText;
	}

	public Date getCategoryTime() {
		return categoryTime;
	}

	public void setCategoryTime(Date categoryTime) {
		this.categoryTime = categoryTime;
	}

	@Override
	public String toString() {
		return "Category [categoryID=" + categoryID + ", parentCatID=" + parentCatID + ", categoryName=" + categoryName
				+ ", categoryText=" + categoryText + ", categoryTime=" + categoryTime + "]";
	}

}

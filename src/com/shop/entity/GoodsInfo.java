package com.shop.entity;

import java.util.ArrayList;
import java.util.List;

public class GoodsInfo {
	private Integer goodsID;
	private Integer categoryID;
	private Integer parentCatID;
	private String goodsName;
	private String goodsKeys;
	private String goodsText;
	private String goodsContent;
	private Integer goodsIsVouch;
	private Integer goodsIsNew;
	private String goodsCheckAdmin;
	
	List<GoodsModel> modles = new ArrayList<GoodsModel>();
	
	public Integer getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(Integer goodsID) {
		this.goodsID = goodsID;
	}

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

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getGoodsKeys() {
		return goodsKeys;
	}

	public void setGoodsKeys(String goodsKeys) {
		this.goodsKeys = goodsKeys;
	}

	public String getGoodsText() {
		return goodsText;
	}

	public void setGoodsText(String goodsText) {
		this.goodsText = goodsText;
	}

	public String getGoodsContent() {
		return goodsContent;
	}

	public void setGoodsContent(String goodsContent) {
		this.goodsContent = goodsContent;
	}

	public Integer getGoodsIsVouch() {
		return goodsIsVouch;
	}

	public void setGoodsIsVouch(Integer goodsIsVouch) {
		this.goodsIsVouch = goodsIsVouch;
	}

	public Integer getGoodsIsNew() {
		return goodsIsNew;
	}

	public void setGoodsIsNew(Integer goodsIsNew) {
		this.goodsIsNew = goodsIsNew;
	}

	public String getGoodsCheckAdmin() {
		return goodsCheckAdmin;
	}

	public void setGoodsCheckAdmin(String goodsCheckAdmin) {
		this.goodsCheckAdmin = goodsCheckAdmin;
	}

	public List<GoodsModel> getModles() {
		return modles;
	}

	public void setModles(List<GoodsModel> modles) {
		this.modles = modles;
	}

}

package com.shop.entity;

import java.util.Date;

public class CartInfo {
	private Integer cartID;
	private Integer userID;
	private Integer goodsID;
	private String goodName;
	private Double goodPrice;
	private Integer goodNumber;
	private Integer shoppingCheck;
	private Date shoppingTime;

	public Integer getCartID() {
		return cartID;
	}

	public void setCartID(Integer cartID) {
		this.cartID = cartID;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	public Integer getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(Integer goodsID) {
		this.goodsID = goodsID;
	}

	public String getGoodName() {
		return goodName;
	}

	public void setGoodName(String goodName) {
		this.goodName = goodName;
	}

	public Double getGoodPrice() {
		return goodPrice;
	}

	public void setGoodPrice(Double goodPrice) {
		this.goodPrice = goodPrice;
	}

	public Integer getGoodNumber() {
		return goodNumber;
	}

	public void setGoodNumber(Integer goodNumber) {
		this.goodNumber = goodNumber;
	}

	public Integer getShoppingCheck() {
		return shoppingCheck;
	}

	public void setShoppingCheck(Integer shoppingCheck) {
		this.shoppingCheck = shoppingCheck;
	}

	public Date getShoppingTime() {
		return shoppingTime;
	}

	public void setShoppingTime(Date shoppingTime) {
		this.shoppingTime = shoppingTime;
	}

}

package com.shop.entity;

import java.util.Date;

public class OrderInfo {
	private Integer orderID;
	private Integer userID;
	private String orderUserRealName;
	private String orderUserAddress;
	private String orderUserPhone;
	private String orderSendType;
	private String orderPayType;
	private Integer orderWeight;
	private Double orderAllPrice;
	private String orderRemark;
	private Date orderTime;
	private String goodsInfo;

	public String getGoodsInfo() {
		return goodsInfo;
	}

	public void setGoodsInfo(String goodsInfo) {
		this.goodsInfo = goodsInfo;
	}

	public Integer getOrderID() {
		return orderID;
	}

	public void setOrderID(Integer orderID) {
		this.orderID = orderID;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	public String getOrderUserRealName() {
		return orderUserRealName;
	}

	public void setOrderUserRealName(String orderUserRealName) {
		this.orderUserRealName = orderUserRealName;
	}

	public String getOrderUserAddress() {
		return orderUserAddress;
	}

	public void setOrderUserAddress(String orderUserAddress) {
		this.orderUserAddress = orderUserAddress;
	}

	public String getOrderUserPhone() {
		return orderUserPhone;
	}

	public void setOrderUserPhone(String orderUserPhone) {
		this.orderUserPhone = orderUserPhone;
	}

	public String getOrderSendType() {
		return orderSendType;
	}

	public void setOrderSendType(String orderSendType) {
		this.orderSendType = orderSendType;
	}

	public String getOrderPayType() {
		return orderPayType;
	}

	public void setOrderPayType(String orderPayType) {
		this.orderPayType = orderPayType;
	}

	public Integer getOrderWeight() {
		return orderWeight;
	}

	public void setOrderWeight(Integer orderWeight) {
		this.orderWeight = orderWeight;
	}

	public Double getOrderAllPrice() {
		return orderAllPrice;
	}

	public void setOrderAllPrice(Double orderAllPrice) {
		this.orderAllPrice = orderAllPrice;
	}

	public String getOrderRemark() {
		return orderRemark;
	}

	public void setOrderRemark(String orderRemark) {
		this.orderRemark = orderRemark;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

}

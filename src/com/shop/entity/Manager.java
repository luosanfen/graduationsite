package com.shop.entity;

import java.util.Date;

public class Manager {
	private Integer managerID;
	private String username; //管理员用户名
	private String managerName; //管理员真实姓名
	private String managerPwd;
	private Integer managerType;
	private String managerTypeName;
	private String managerText;
	private Integer managerCheck;
	private Integer managerVisitCount;
	private Date managerLastVisitTime;
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Integer getManagerID() {
		return managerID;
	}

	public void setManagerID(Integer managerID) {
		this.managerID = managerID;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getManagerPwd() {
		return managerPwd;
	}

	public void setManagerPwd(String managerPwd) {
		this.managerPwd = managerPwd;
	}

	public Integer getManagerType() {
		return managerType;
	}

	public void setManagerType(Integer managerType) {
		if(managerType == 0){
			managerTypeName = "超级管理员";
		} else if(managerType == 1) {
			managerTypeName = "系统管理员";
		}
		this.managerType = managerType;
	}

	public String getManagerTypeName() {
		return managerTypeName;
	}

	public void setManagerTypeName(String managerTypeName) {
		this.managerTypeName = managerTypeName;
	}

	public String getManagerText() {
		return managerText;
	}

	public void setManagerText(String managerText) {
		this.managerText = managerText;
	}

	public Integer getManagerCheck() {
		return managerCheck;
	}

	public void setManagerCheck(Integer managerCheck) {
		this.managerCheck = managerCheck;
	}

	public Integer getManagerVisitCount() {
		return managerVisitCount;
	}

	public void setManagerVisitCount(Integer managerVisitCount) {
		this.managerVisitCount = managerVisitCount;
	}

	public Date getManagerLastVisitTime() {
		return managerLastVisitTime;
	}

	public void setManagerLastVisitTime(Date managerLastVisitTime) {
		this.managerLastVisitTime = managerLastVisitTime;
	}

}

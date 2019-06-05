package com.shop.entity;

import java.util.Date;

public class Bulletin {
	private Integer bulletinID;
	private String bulletinTitle;
	private String bulletinAbust;
	private String bulletincontent;
	private Date bulletinInputDate;
	private Date bulletinUpdateDate;
	private Integer bulletinSort;
	private String isValid;
	private Integer managerID;
	private String managerName;
	
	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public Integer getBulletinID() {
		return bulletinID;
	}

	public void setBulletinID(Integer bulletinID) {
		this.bulletinID = bulletinID;
	}

	public String getBulletinTitle() {
		return bulletinTitle;
	}

	public void setBulletinTitle(String bulletinTitle) {
		this.bulletinTitle = bulletinTitle;
	}

	public String getBulletinAbust() {
		return bulletinAbust;
	}

	public void setBulletinAbust(String bulletinAbust) {
		this.bulletinAbust = bulletinAbust;
	}

	public String getBulletincontent() {
		return bulletincontent;
	}

	public void setBulletincontent(String bulletincontent) {
		this.bulletincontent = bulletincontent;
	}

	public Date getBulletinInputDate() {
		return bulletinInputDate;
	}

	public void setBulletinInputDate(Date bulletinInputDate) {
		this.bulletinInputDate = bulletinInputDate;
	}

	public Date getBulletinUpdateDate() {
		return bulletinUpdateDate;
	}

	public void setBulletinUpdateDate(Date bulletinUpdateDate) {
		this.bulletinUpdateDate = bulletinUpdateDate;
	}

	public Integer getBulletinSort() {
		return bulletinSort;
	}

	public void setBulletinSort(Integer bulletinSort) {
		this.bulletinSort = bulletinSort;
	}

	public String getIsValid() {
		return isValid;
	}

	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

	public Integer getManagerID() {
		return managerID;
	}

	public void setManagerID(Integer managerID) {
		this.managerID = managerID;
	}

}

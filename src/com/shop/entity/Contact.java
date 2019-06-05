package com.shop.entity;

public class Contact {
	private Integer conID;
	private String conName;
	private String conTitle;
	private String conContent;
	private String conEmail;

	public String getConEmail() {
		return conEmail;
	}

	public void setConEmail(String conEmail) {
		this.conEmail = conEmail;
	}

	public Integer getConID() {
		return conID;
	}

	public void setConID(Integer conID) {
		this.conID = conID;
	}

	public String getConTitle() {
		return conTitle;
	}

	public void setConTitle(String conTitle) {
		this.conTitle = conTitle;
	}

	public String getConContent() {
		return conContent;
	}

	public void setConContent(String conContent) {
		this.conContent = conContent;
	}

	public String getConName() {
		return conName;
	}

	public void setConName(String conName) {
		this.conName = conName;
	}

	@Override
	public String toString() {
		return "Contact [conID=" + conID + ", conName=" + conName + ", conTitle=" + conTitle + ", conContent="
				+ conContent + "]";
	}

}

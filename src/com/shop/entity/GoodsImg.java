package com.shop.entity;

/**
 * 商品表
 */
public class GoodsImg {
	private String goodImgId;
	private Integer goodsId;
	private String file_name;
	private String file_address;
	private Integer file_sort;

	public String getGoodImgId() {
		return goodImgId;
	}

	public void setGoodImgId(String goodImgId) {
		this.goodImgId = goodImgId;
	}

	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getFile_address() {
		return file_address;
	}

	public void setFile_address(String file_address) {
		this.file_address = file_address;
	}

	public Integer getFile_sort() {
		return file_sort;
	}

	public void setFile_sort(Integer file_sort) {
		this.file_sort = file_sort;
	}

}

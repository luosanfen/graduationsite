package com.shop.service;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.shop.dao.BaseDao;
import com.shop.entity.CartInfo;
import com.shop.entity.Contact;
import com.shop.entity.GoodsInfo;
import com.shop.entity.GoodsModel;
import com.shop.entity.OrderGoodsInfo;
import com.shop.entity.OrderInfo;

public class ShopService {
     //删除购物车商品
	public Boolean del_cart(CartInfo cartInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from cartinfo where cartID=?";
		params.add(cartInfo.getCartID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}

	//添加订单
	public Boolean save_order(OrderInfo orderInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql = "insert into orderinfo(userID, orderUserRealName, orderUserAddress, orderUserPhone, orderSendType, orderPayType, orderWeight, orderAllPrice, orderRemark, orderTime) values(?,?,?,?,?,?,?,?,?,now())";
		
		params.add(orderInfo.getUserID());
		params.add(orderInfo.getOrderUserRealName());
		params.add(orderInfo.getOrderUserAddress());
		params.add(orderInfo.getOrderUserPhone());
		params.add(orderInfo.getOrderSendType());
		params.add(orderInfo.getOrderPayType());
		params.add(0);
		params.add(orderInfo.getOrderAllPrice());
		params.add(orderInfo.getOrderRemark());
		int orderID = BaseDao.executeSQLKey(sql, params);
		
		String goods_sql = "insert into ordergoodsinfo(orderID, goodsName, goodsID, goodsPrice, goodsNumber, buyDate) values(?,?,?,?,?, now())";
		String goodsInfo_str = orderInfo.getGoodsInfo();
		if(goodsInfo_str != null){
			JSONArray json = JSONArray.parseArray(goodsInfo_str);
			for(int i = 0; i < json.size(); i++){
				JSONObject goodsinfo_json = (JSONObject) json.get(i);
				OrderGoodsInfo goodsInfo = JSONObject.parseObject(JSONObject.toJSONString(goodsinfo_json), OrderGoodsInfo.class);
				params = new ArrayList<Object>();
				params.add(orderID);
				params.add(goodsInfo.getGoodsName());
				params.add(goodsInfo.getGoodsId());
				params.add(goodsInfo.getGoodsPrice());
				params.add(goodsInfo.getGoodsNumber());
				BaseDao.executeSQLKey(goods_sql, params);
			}
		}
		
		return  orderID > 0 ? true : false;
	}
	
  //保存到购物车
	public Boolean save_Cart(CartInfo cartInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql = "insert into cartinfo(userID, goodsID, goodName, goodPrice, goodNumber, shoppingTime) values(?,?,?,?,?,now())";
		params.add(cartInfo.getUserID());
		params.add(cartInfo.getGoodsID());
		params.add(cartInfo.getGoodName());
		params.add(cartInfo.getGoodPrice());
		params.add(cartInfo.getGoodNumber());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}

	public void del_carts(Integer userID) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from cartinfo where userID=?";
		params.add(userID);
		BaseDao.executeSQL(sql, params);
	}

	public Boolean delOrder(OrderInfo orderInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql1 = "delete from orderinfo where orderid=?";
		params.add(orderInfo.getOrderID());
		String sql2 = "delete from ordergoodsinfo where orderid=?";
		BaseDao.executeSQL(sql2, params);
		return BaseDao.executeSQL(sql1, params) > 0 ? true : false;
	}

}

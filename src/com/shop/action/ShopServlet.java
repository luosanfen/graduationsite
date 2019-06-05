package com.shop.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSONObject;
import com.shop.entity.CartInfo;
import com.shop.entity.OrderInfo;
import com.shop.service.ShopService;

public class ShopServlet extends HttpServlet {
	private static final long serialVersionUID = 2807964174199598386L;
	private HttpServletRequest request;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.request = request;
		request.setCharacterEncoding("UTF-8");// 处理中文
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		ShopService shopService = new ShopService();
		
		HttpSession session = request.getSession();
		Integer userID = (Integer) session.getAttribute("userID");
		String option = request.getParameter("option");
		HashMap<String, String> resultMap = new HashMap<String, String>();
		if(userID != null && !"".equals(userID)){
			if("delCart".equals(option)){
				CartInfo cartInfo = getEntity(CartInfo.class);
				Boolean flag = shopService.del_cart(cartInfo);
				if(flag){
					resultMap.put("state", "0");
					resultMap.put("msg", "删除成功");
				} else {
					resultMap.put("state", "1");
					resultMap.put("msg", "删除失败");
				}
			} else if("buy".equals(option)){
				OrderInfo orderInfo = getEntity(OrderInfo.class);
				orderInfo.setUserID(userID);
				Boolean flag = shopService.save_order(orderInfo);
				if(flag){
					shopService.del_carts(userID);//清空购物车
					resultMap.put("state", "0");
					resultMap.put("msg", "保存成功");
				} else {
					resultMap.put("state", "1");
					resultMap.put("msg", "保存失败");
				}
			} else if("addCart".equals(option)) {
				CartInfo cartInfo = getEntity(CartInfo.class);
				cartInfo.setUserID(userID);
				Boolean flag = shopService.save_Cart(cartInfo);
				if(flag){
					resultMap.put("state", "0");
					resultMap.put("msg", "添加成功");
				} else {
					resultMap.put("state", "1");
					resultMap.put("msg", "添加失败");
				}
			} else if("delOrder".equals(option)) {
				OrderInfo orderInfo = getEntity(OrderInfo.class);
				Boolean flag = shopService.delOrder(orderInfo);
				if(flag){
					resultMap.put("state", "0");
					resultMap.put("msg", "删除成功");
				} else {
					resultMap.put("state", "1");
					resultMap.put("msg", "删除失败");
				}
			}
		} else {
			resultMap.put("state", "2");
			resultMap.put("msg", "登陆超时");
		}
		out.write(JSONObject.toJSONString(resultMap));
		out.flush();
		out.close();
	}
	
	private <T> T getEntity(Class<T> c){
		HashMap<String, String> result_map = new HashMap<String, String>();
		Enumeration enu = request.getParameterNames();  
		while(enu.hasMoreElements()){  
			String paraName=(String)enu.nextElement();  
			result_map.put(paraName, request.getParameter(paraName));
		}
		String json_str = JSONObject.toJSONString(result_map);
		T t = JSONObject.toJavaObject(JSONObject.parseObject(json_str), c);
		return t;
	}

}

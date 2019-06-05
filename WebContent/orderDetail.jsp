<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="head.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
ul li {
	margin-bottom: 5px;
}
.btnBack{
    padding: 4px 14px;
    color: #e83206;
    font-size: 1em;
   }
</style>
<div class="container" style="margin-top:2rem;
 background-color: #eeeeee; padding-top: 1rem;">
        <div>
       <%
  		String orderID = request.getParameter("orderID");
		if (orderID == null || "".equals(orderID)) {
			response.sendRedirect("index.jsp");
			return;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<Object> params = new ArrayList<Object>();
		params.add(orderID);
		//查询订单商品表
		String order_sql = "select * from ordergoodsinfo where orderID=?";
		OrderGoodsInfo order  = BaseDao.executeJDBCSQLQuery(order_sql, params, OrderGoodsInfo.class);
		//查询收货表
		String or_sql = "select * from orderinfo where orderID=?";
		OrderInfo order2  = BaseDao.executeJDBCSQLQuery(or_sql, params, OrderInfo.class);
		//查询商品图片
		String img_sql = "SELECT t.* FROM goodsimg t left join ordergoodsinfo a on a.goodsID = t.GOODSID where a.orderID=?";
		GoodsImg img = BaseDao.executeJDBCSQLQuery(img_sql, params, GoodsImg.class);
		if(img.getFile_address() != null && !"".equals(img.getFile_address())){
			%>
				<div style="float: left;"><img alt="" src="<%=img.getFile_address() %>" style="height: 300px; width: 250px;"></div>
			<%
		}
		%>
		  <div style="float: left; margin-left: 2rem;">
		 <ul style="list-style-type:none">
				<li><label>订单编号：</label><%=order.getOrderID() %>
				(<%if(order2.getOrderWeight() == 0){%>
		        	<td>未付款</td>
				  <%}%>
				  <%if(order2.getOrderWeight() == 1){%>
					<td>已完成</td>
				  <%}%>
				  <% if(order2.getOrderWeight() == 2){%>
					<td>待发货</td>
				 <%}%>)
				<label style="margin-left:2rem;">下单时间：</label><%=sdf.format(order.getBuyDate()) %></li>
				<li><label>商品名称：</label><%=order.getGoodsName() %></li>
				<li><label>商品名称：</label><%=order.getGoodsNumber() %></li>
				<li><label>商品总价：</label><%=order.getGoodsNumber() * order.getGoodsPrice() %></li>
				<li><label>收货人：</label><%=order2.getOrderUserRealName() %></li>
				<li><label>收货电话：</label><%=order2.getOrderUserPhone() %></li>
				<li><label>收货地址：</label><%=order2.getOrderUserAddress() %></li>
				<li><label>发货方式：</label><%=order2.getOrderSendType() %></li>
				<li><label>备注：</label><%=order2.getOrderRemark() %></li>
			</ul>
			<!-- <a href="order.jsp"> <p style="float: right; margin:1rem;"><input type="button" value="返回订单" class="btnBack"></p> </a> -->
        </div>
       <!--  <div style="float: right; margin-top: 5rem; margin-right: 3rem;">
        <a href="order.jsp"> <input type="button" value="返回订单" class="btnBack"> </a>
		<div class="clearfix"></div>
         </div> -->
       </div>
<div class="col-md-12">
 <div style="background-color: #c9c9d0; height: 5rem; margin-top: 2rem;"> <h4 class="head"><span class="m_2">好货~新品推荐</span></h4></div>
	<%
		String vouch_sql = "SELECT * FROM goodsinfo t where t.goodsIsVouch=1";
		List<GoodsInfo> goods2_list = BaseDao.executeJDBCSQLQuerys(vouch_sql, null, GoodsInfo.class);
	%>
	<div class="top_grid2">
		<%
			for(int l = 0; l < goods2_list.size(); l++){
				 if(l == 8){
					break;
				} 
				List<Object> param2 = new ArrayList<Object>();
				GoodsInfo goodsInfo = goods2_list.get(l);
				param2.add(goodsInfo.getGoodsID());
				String model2_sql = "select * from goodsModel t where t.GOODSID=?";
				List<GoodsModel> model2_list = BaseDao.executeJDBCSQLQuerys(model2_sql, param2, GoodsModel.class);
				String price = "0";
				String small = "0";
				if(model2_list != null && model2_list.size() > 0){
					price = model2_list.get(0).getOrderPrice() + "";
					small = price.substring(price.indexOf("."));
					price = price.substring(0, price.indexOf("."));
				}
				//商品图片信息
				String img_sql2 = "select * from goodsImg t where t.GOODSID=?";
				List<GoodsImg> img_list = BaseDao.executeJDBCSQLQuerys(img_sql2, param2, GoodsImg.class);
		%>
				<div class="col-md-3 top_grid1-box1" style="margin-top:1rem;">
					<a href="single.jsp?goodsID=<%=goodsInfo.getGoodsID() %>">
						<div class="grid_1">
							<div class="b-link-stroke b-animate-go  thickbox">
								<img src="<%=img_list.get(0).getFile_address() %>" class="img-responsive" alt="" 
								 style="height: 16em !important; width: 15.7rem;"/>
							</div>
							<div class="grid_2">
								<p style="height: 50px;"><%=goodsInfo.getGoodsName() %></p>
								<ul class="grid_2-bottom">
									<li class="grid_2-left"><p>
											￥<%=price %><small><%=small %></small>
										</p></li>
									<li class="grid_2-right"><div
											class="btn btn-primary btn-normal btn-inline " target="_self"
											title="快戳我！(☆▽☆)">购买</div></li>
									<div class="clearfix"></div>
								</ul>
							</div>
						</div>
					</a>
				</div>
				<% 
		}
	%>
		<div class="clearfix"></div>
	  </div>
	  </div>
       
</div>
<%@ include file="footer.jsp"%>

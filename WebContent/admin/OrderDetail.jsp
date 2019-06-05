<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<link rel="stylesheet" type="text/css" href="../common/layui/css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="../common/bootstrap/css/bootstrap.css" media="all">
	<link rel="stylesheet" type="text/css" href="../common/global.css" media="all">
	<script type="text/javascript" src="../common/layui/layui.js"></script>
	<script type="text/javascript" src="../js/larry.js"></script>
  </head>
  
  <body>
    <table class="layui-table">
	    <colgroup>
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
		</colgroup>
	  <thead>
	    <tr>
		 <th>订单编号</th>
		 <th>商品名称</th>
		 <th>价格</th>
		 <th>数量</th>
		 <th>总金额</th>
		 <th>购买日期</th>
	    </tr> 
	  </thead>
	  <tbody>
	  <%
	  	String orderID = request.getParameter("orderID");
	  	if(orderID == null || "".equals(orderID))return;
	  	List<Object> params = new ArrayList<Object>();
	  	String sql = "select * from ordergoodsinfo t where t.orderID=?";
	  	params.add(orderID);
	  	List<OrderGoodsInfo> orderGoodsInfos = BaseDao.executeJDBCSQLQuerys(sql, params, OrderGoodsInfo.class);
	  	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	  	for(OrderGoodsInfo orderGoodsInfo : orderGoodsInfos){
	  	 %>
		    <tr>
				<td><%=orderGoodsInfo.getOrderID() %></td>
				<td><%=orderGoodsInfo.getGoodsName() %></td>
				<td><%=orderGoodsInfo.getGoodsPrice() %></td>
				<td><%=orderGoodsInfo.getGoodsNumber() %></td>
				<td><%=orderGoodsInfo.getGoodsPrice() * orderGoodsInfo.getGoodsNumber() %></td>
				<td><%=sdf.format(orderGoodsInfo.getBuyDate()) %></td>
		    </tr>
		    <%
		  	}
		   %>
	  </tbody>
	</table>
  </body>
</html>

<!--头部内容-->
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="head.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.rowTitle {
	background: #e5e5e5;
	line-height: 3rem;
	font-size: 1rem;
	font-weight: bold;
	text-align: center;
}
.backcolor{
      background: #fbf5f5;
      padding: 1em 0 5em;
      height: 100%;
}
.row {
	margin-top: 1rem;
}
</style>
<!-- <h1>我的订单</h1> -->
<%
	Integer userID = (Integer) session.getAttribute("userID");
	if (userID == null || "".equals(userID)) {
		response.sendRedirect("login.jsp");
		return;
	}
 %>
<div class="backcolor">
	<div class="container">
	 <div class="bs-example" data-example-id="bordered-table" style="margin:1rem;">
    <table class="table table-bordered">
      <thead>
        <tr>
          <th>订单编号</th>
          <th>名称</th>
        <!--   <th>单价</th> -->
          <th>数量</th>
         <!--  <th>总价</th>  -->
          <th>支付方式</th>
          <th>支付状态</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
      <%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<Object> params = new ArrayList<Object>();
		String order_sql = "select * from orderinfo t where t.userID=?";
		params.add(userID);
		List<OrderInfo> order_list = BaseDao.executeJDBCSQLQuerys(order_sql, params, OrderInfo.class);
		for(OrderInfo orderInfo : order_list){
			params = new ArrayList<Object>();
			params.add(orderInfo.getOrderID());
			String goods_sql = "select * from ordergoodsinfo where orderID=?";
			List<OrderGoodsInfo> goods_list = BaseDao.executeJDBCSQLQuerys(goods_sql, params, OrderGoodsInfo.class);
			for(OrderGoodsInfo goodsInfo : goods_list){
				%>
        <tr>
          <th scope="row"><%=orderInfo.getOrderID() %></th>
          <td><%=goodsInfo.getGoodsName() %></td>
        <%--   <td><%=goodsInfo.getGoodsPrice() %></td> --%>
          <td><%=goodsInfo.getGoodsNumber() %></td>
          <%-- <td><%=goodsInfo.getGoodsNumber() * goodsInfo.getGoodsPrice() %></td>  --%>
          <td><%=orderInfo.getOrderPayType() %></td>
          <%if(orderInfo.getOrderWeight() == 0){%>
        	<td>待付款</td>
		  <%}%>
		  <%if(orderInfo.getOrderWeight() == 1){%>
			<td>已完成</td>
		  <%}%>
		  <% if(orderInfo.getOrderWeight() == 2){%>
			<td>待发货</td>
		 <%}%>
        <%--   <td><%=sdf.format(goodsInfo.getBuyDate()) %></td> --%>
          <td><span><a style="color:#1c8aea;" href="orderDetail.jsp?orderID=<%=orderInfo.getOrderID() %>">详情</a></span>&ensp;&ensp;
              <span><a style="color:#f90f23;" href="javascript:del_order(<%=orderInfo.getOrderID() %>)">删除</a></span>
            </td>
        </tr>
   	  <%
			}
		}
	 %>  
      </tbody>
    </table>
  </div><!-- /example -->
</div>

</div>
<script>
	function del_order(orderID){
		layer.confirm('确认要删除所选记录吗？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
			$.ajax({
				url : "shopServlet", // 请求的url地址
				data : {
					"option" : "delOrder",
					"orderID" : orderID
				},
				cache : false,
				dataType : "json", // 返回格式为json
				async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
				type : "POST", // 请求方式
				success : function(req) {
					layer.msg(req.msg);
				}
			});
			setTimeout(function() {
				window.location.reload();
			}, 2000);
        }); 
	}
</script>

<%@ include file="footer.jsp"%>





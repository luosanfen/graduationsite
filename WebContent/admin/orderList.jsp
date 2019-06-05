<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>后台商城管理中心</title>
		<meta name="renderer" content="webkit">	
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
		<meta name="viewport" content="width=device-width, initial-scale=1">	
		<meta name="apple-mobile-web-app-status-bar-style" content="black">	
		<meta name="apple-mobile-web-app-capable" content="yes">	
		<meta name="format-detection" content="telephone=no">	
		<!-- load css -->
		<link rel="stylesheet" type="text/css"
			href="../common/layui/css/layui.css" media="all">
		<link rel="stylesheet" type="text/css"
			href="../common/bootstrap/css/bootstrap.css" media="all">
		<link rel="stylesheet" type="text/css" href="../common/global.css"
			media="all">
		<script type="text/javascript" src="../common/layui/layui.js"></script>
		<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="../js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../js/layui.all.js"></script>
	</head>
	<body style="width:100%; height: 100%">
		<%
			List<Object> params = new ArrayList<Object>();
			String model = request.getParameter("model");
			String name = request.getParameter("name");
			String sql1 = "select count(*) count from orderinfo where 1=1";
			if(name != null && !"".equals(name)){
				name = new String(name.getBytes("ISO-8859-1"),"UTF-8");
				sql1 += "and orderID = ?";
				params.add(name);
			}
			List<HashMap<String, Object>> count1_list = BaseDao.executeJDBCSQLQuery(sql1, params);
			
			String sql2 = "select count(*) count from orderinfo where orderWeight=1";
			List<HashMap<String, String>> count2_list = BaseDao.executeJDBCSQLQuery(sql2);
			
			String sql3 = "select count(*) count from orderinfo where orderWeight in (0,2)";
			List<HashMap<String, String>> count3_list = BaseDao.executeJDBCSQLQuery(sql3);
			
			String sql4 = "select count(*) count from orderinfo where orderWeight=2";
			List<HashMap<String, String>> count4_list = BaseDao.executeJDBCSQLQuery(sql4);
			
			String sql5 = "select count(*) count from orderinfo where orderWeight=0";
			List<HashMap<String, String>> count5_list = BaseDao.executeJDBCSQLQuery(sql5);
			
			String count1 = "0";
			String count2 = "0";
			String count3 = "0";
			String count4 = "0";
			String count5 = "0";
			if(count1_list != null && count1_list.size() > 0){
				count1 = count1_list.get(0).get("count") + "";
			}
			if(count2_list != null && count2_list.size() > 0){
				count2 = count2_list.get(0).get("count");
			}
			if(count3_list != null && count3_list.size() > 0){
				count3 = count3_list.get(0).get("count");
			}
			if(count4_list != null && count4_list.size() > 0){
				count4 = count4_list.get(0).get("count");
			}
			if(count5_list != null && count5_list.size() > 0){
				count5 = count5_list.get(0).get("count");
			}
			/**
			0:未付款订单；
			1：已经发货，完成的订单；
			2：待发货的订单。
			*/
			
			String order_sql = "select * from orderinfo where 1=1 ";
			if("0".equals(model)){
				order_sql += "and orderWeight=1";
			}
			if("1".equals(model)){
				order_sql += "and orderWeight in (0,2)";
			}
			if("2".equals(model)){
				order_sql += "and orderWeight=2";
			}
			if("3".equals(model)){
				order_sql += "and orderWeight=0";
			}
			if(name != null && !"".equals(name)){
				order_sql += "and orderID like ?";
			}
			List<OrderInfo> order_list = BaseDao.executeJDBCSQLQuerys(order_sql, params, OrderInfo.class);
		 %>
		<section class="layui-larry-box">
			<div class="larry-parent">
			    <div class="layui-tab">
			        <blockquote class="layui-elem-quote">
			        	<div class="layui-inline">订单号:</div>
					<div class="layui-inline">
					    <form>
							<div class="layui-input-inline">
						    	<input name="name" value="" placeholder="请输入订单编号"
									class="layui-input search_input" type="text">
						    </div>
							<button class="layui-btn gsearch_btn" type="submit">查询</button>
						</form>
					</div>
					<div class="layui-inline">
						<div class="layui-form-mid layui-word-aux"></div>
					</div>
				    </blockquote>
			     	<div class="layui-inline">
						<a class="layui-btn layui-btn-normal" href="orderList.jsp?model=5">所有订单(<%=count1 %>)</a>
						<a class="layui-btn layui-btn-normal" href="orderList.jsp?model=1">未完成订单(<%=count3 %>)</a>
						<a class="layui-btn layui-btn-normal" href="orderList.jsp?model=0">已发货订单(<%=count2 %>)</a>
						<a class="layui-btn layui-btn-normal" href="orderList.jsp?model=2">待发货订单(<%=count4 %>)</a>
						<a class="layui-btn layui-btn-normal" href="orderList.jsp?model=3">待付款订单(<%=count5 %>)</a>
					</div>
					<table class="layui-table">
					     <colgroup>
							<col width="5%">
							<col width="8%">
							<col width="10%">
							<col width="9%">
							<col width="8%">
							<col width="8%">
							<col width="20%">
							<col width="9%">
							<col width="15%">
						</colgroup>
					  <thead>
					    <tr>
					     <th><input type="checkbox" name=""></th>
						 <th>订单编号</th>
						 <th>下单时间</th>
						 <th>消费金额</th>
						 <th>支付方式</th>
						 <th>发货方式</th>
						 <th>备注</th>
						 <th>订单状态</th>
						 <th>操作</th>
					    </tr> 
					  </thead>
					  <tbody>
					  <%
					  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					  	for(OrderInfo orderInfo : order_list){
					  	 %>
						    <tr>
							    <td><input type="checkbox" name=""></td>
									<td><%=orderInfo.getOrderID() %></td>
									<td><%=sdf.format(orderInfo.getOrderTime()) %></td>
									<td><%=orderInfo.getOrderAllPrice() %></td>
									<td><%=orderInfo.getOrderPayType() %></td>
									<td><%=orderInfo.getOrderSendType() %></td>
									<td><%=orderInfo.getOrderRemark() %></td>
									<%
										if(orderInfo.getOrderWeight() == 0){
										%>
											<td style="color:red;">未付款</td>
										<%
										}
									 %>
									 <%
										if(orderInfo.getOrderWeight() == 1){
										%>
											<td style="color:gray;">已完成</td>
										<%
										}
									 %>
									<%
										if(orderInfo.getOrderWeight() == 2){
										%>
											<td style="color:#0391fb;">待发货</td>
										<%
										}
									 %>
									<td>
										
										<a class="layui-btn layui-btn-mini goog_edit" onclick="order_detail(<%=orderInfo.getOrderID() %>)">查看</a>
										<a class="layui-btn layui-btn-mini goog_edit" onclick="change_state(<%=orderInfo.getOrderID() %>,<%=orderInfo.getOrderWeight() %>)">修改</a>
									    <a class="layui-btn layui-btn-danger layui-btn-mini news_del" data-id="1" onclick="del_order(<%=orderInfo.getOrderID() %>)">删除</a>
									</td>
						    </tr>
						    <%
						  	}
						   %>
					  </tbody>
					</table>
				</div>		 
			</div>
		</section>
		<div id="state_panel" style="display: none;" class="layui-form" >
			<form class="layui-form" id="stateForm" name="stateForm"
				lay-filter="stateForm">
				<input name="orderID" id="orderID" type="hidden">
				<div class="layui-form-item">
					</br>
					</br>
					<label class="layui-form-label">订单状态</label>
					<div class="layui-input-block">
						<select name="state" id="state" class="layui-input" lay-verify="required">
							<option value="0">未付款</option>
							<option value="1">已发货</option>
							<option value="2">已付款</option>
						</select>
					</div>
				</div>
				<center>
					<button type="button" class="btn btn-success" onclick="do_change_state()">提交</button>
					<button type="button" class="btn btn-warning" onclick="close_state()">返回</button>
				</center>
			</form>
		</div>
		
	</body>
	<script type="text/javascript">
		var form;
		var layer;
		var table;
		$(function (){
			layui.use([ 'form', 'layer', 'table'], function() {
				form = layui.form;
				layer = layui.layer;
				table = layui.table;
			})
		});
		
		function del_order(orderID){
			layer.confirm('确认要删除所选记录吗？', {
	            btn : [ '确定', '取消' ]//按钮
	        }, function(index) {
				$.ajax({
					url : "../admin", // 请求的url地址
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
		
		function do_change_state(){
			var orderID = $("#state_panel #orderID").val();
			layer.confirm('确认要修改吗？', {
	            btn : [ '确定', '取消' ]//按钮
	        }, function(index) {
				$.ajax({
					url : "../admin", // 请求的url地址
					data : {
						"option" : "change_state",
						"orderWeight" : $("#state").val(),
						"orderID" : orderID,
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
		
		function change_state(orderID, state){
			layer.open({
				type : 1,
				area : [ '400px', '400px' ],
				content : $('#state_panel'),
				closeBtn: 0
			});
			$("#state").val(state)
			$("#state_panel #orderID").val(orderID);
			form.render();
		}
		
		function close_state(){
			layer.close(layer.index); 
			$("#state_panel").css("display", "none");
		}
		
		function order_detail(orderID){
			layer.open({
				type : 2,
				area : [ '900px', '500px' ],
				content : "OrderDetail.jsp?orderID=" + orderID
			});
		}
	</script>
</html>

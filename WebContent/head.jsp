<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao" %>
<html>
<head>
<title>FENSTORE服装商城</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Fashionpress Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript">addEventListener("load", function() {
		setTimeout(hideURLbar, 0);
	}, false);
	function hideURLbar() {
		window.scrollTo(0, 1);
	}
</script>
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link
	href='https://fonts.googleapis.com/css?family=Lato:100,200,300,400,500,600,700,800,900'
	rel='stylesheet' type='text/css'>
<script type="text/javascript" scr="common/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script src="js/responsiveslides.min.js"></script>
<script type="text/javascript" src="common/layui/layui.js"></script>
<script type="text/javascript" src="js/larry.js"></script>
<script>
	$(function() {
		$("#slider").responsiveSlides({
			auto : true,
			nav : true,
			speed : 500,
			namespace : "callbacks",
			pager : true,
		});
	});
</script>
<script type="text/javascript" src="js/hover_pack.js"></script>
</head>
<body>
	<div class="header">
		<div class="header_top">
			<div class="container">
				<div class="logo">
					<a href="index.jsp"><img src="images/logofen.png" alt="" /></a>
				</div>
				<ul class="shopping_grid">
					<%
						if (session.getAttribute("userName") == null) {
					%>
					<a href="register.jsp"><li>注册</li></a>
					<a href="login.jsp"><li>登录</li></a>
					<%
						} else {
					%>
					<li><span>用户名：<%
						out.print(session.getAttribute("userName"));
					%></span></li>
					<a href="cartBag.jsp"><li><span class="m_1">购物袋</span><!-- &nbsp;&nbsp;(0) -->
							&nbsp;<img src="images/bag.png" alt="" /></li></a>
					<a href="loginout.jsp"><li>退出登录</li></a>
					<%
						}
					%>
				</ul>
				<div class="clearfix"></div>
			</div>
		</div>
		<!-- 导航栏 -->
		<div class="h_menu4">
			<div class="container">
				<a class="toggleMenu" href="#">列表选项</a>
				<ul class="nav">
					<li class="active"><a href="index.jsp" data-hover="Home">首页</a></li>
					<!-- <li><a href="saleRank.jsp" data-hover="Sales ranking"></a></li> -->
					<li><a href="newStore.jsp" data-hover="New stores">全部新品</a></li>
					<li><a href="storeInfo.jsp" data-hover="Store information">资讯公告</a></li>
					<li><a href="contact.jsp" data-hover="Contact">联系留言</a></li>
					<li><a href="order.jsp" data-hover="My order">我的订单</a></li>
					<li><a href="userInfo.jsp" data-hover="Personal information">个人信息</a></li>
				</ul>
				<script type="text/javascript" src="js/nav.js"></script>
			</div>
		</div>
		<!-- 导航栏结束 -->
	</div>
	<!--头部     -->
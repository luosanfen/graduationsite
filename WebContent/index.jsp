<!--头部内容-->
<%@ include file="head.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 广告轮播图-->
<div class="slider">
	<div class="callbacks_container">
		<ul class="rslides" id="slider">
			<li><img src="images/banner02.jpg" class="img-responsive" alt="" />
				<!-- <div class="banner_desc">
					<h1>是否能完成这个网站，要加油哦</h1>
					<h2>不仅时尚，价格还很合理，好穿不贵</h2>
				</div> --></li>
			<li><img src="images/banner03.jpg" class="img-responsive" alt="" />
				<!-- <div class="banner_desc">
					<h1>任意款式，任你挑选</h1>
					<h2>一百种方法让你开心</h2>
				</div> --></li>
			<li><img src="images/banner04.jpg" class="img-responsive" alt="" />
				<!-- <div class="banner_desc">
					<h1>这是新华电脑，代购</h1>
					<h2>写什么我也不知都了</h2>
				</div> --></li>
		</ul>
	</div>
</div> 
<!-- 广告轮播图结束-->
<!-- 广告那些字以上-->
<%-- <% 
String name = request.getParameter("schContent");
String sql = "select * from goodsinfo where goodsName like '%" + name + "%'";

 %>
 --%>
 <!-- 搜索框-->
	<div class="container">
		<div class="search">
			<div class="stay">搜索你想要的商品</div>
			<form name="form" method="post" action="search.jsp">
			<div class="stay_right">
				<input name="schContent" type="text" value="">
				<input type="submit" value="搜  索">
			</div>
			</form>
			<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
	</div>
</div>
<!-- 搜索框结束-->

<!--主体部分-->
<div class="main">
	<div class="content_top">
		<div class="container">
			<!--引入左侧栏内容 -->
			<%@ include file="left.jsp"%>
			<!--引入右侧栏内容 -->
			<%@ include file="right.jsp"%>
		</div>
	</div>
</div>

<!--尾部部分-->
<%@ include file="footer.jsp"%>

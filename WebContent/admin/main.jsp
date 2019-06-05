<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>主页</title>
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css" href="../common/layui/css/layui.css" media="all">
<link rel="stylesheet" type="text/css" href="../common/bootstrap/css/bootstrap.css" media="all">
<link rel="stylesheet" type="text/css" href="../common/global.css">
<link rel="stylesheet" type="text/css" href="../css/main.css" media="all">
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>

<script type="text/javascript" src="../common/layui/layui.js"></script>
<script type="text/javascript">
	$(function() {
		layui.use([ 'jquery', 'layer', 'element' ], function() {
			window.jQuery = window.$ = layui.jquery;
			window.layer = layui.layer;
			window.element = layui.element();

			$('.panel .tools .iconpx-chevron-down').click(function() {
				var el = $(this).parents(".panel").children(".panel-body");
				if ($(this).hasClass("iconpx-chevron-down")) {
					$(this).removeClass("iconpx-chevron-down").addClass("iconpx-chevron-up");
					el.slideUp(200);
				} else {
					$(this).removeClass("iconpx-chevron-up").addClass("iconpx-chevron-down");
					el.slideDown(200);
				}
			})
		});
	});
</script>
<script type="text/javascript" src="../jsplug/echarts.min.js"></script>
<script type="text/javascript" src="../js/main.js"></script>
</head>
<body>
<%
    //查询用户条数
	String user_count = "select count(*) count from userinfo t ";
	List<HashMap<String, String>> list1 = BaseDao.executeJDBCSQLQuery(user_count);
	//查询今日注册条数
	String rigister_count = "select count(*) count from userinfo t where DATE_FORMAT(t.userCreateTime,'%Y-%d-%m') = DATE_FORMAT(NOW(),'%Y-%d-%m')";
	List<HashMap<String, String>> list2 = BaseDao.executeJDBCSQLQuery(rigister_count);
	//查询订单条数
	String order_count = "select count(*) count from orderinfo t";
	List<HashMap<String, String>> list3 = BaseDao.executeJDBCSQLQuery(order_count);
	//查询完成的订单条数
	String ordered_count = "select count(*) count from orderinfo t where t.orderWeight = 0";
	List<HashMap<String, String>> list4 = BaseDao.executeJDBCSQLQuery(ordered_count);
	
	int count1 = 0;
	int count2 = 0;
	int count3 = 0;
	int count4 = 0;
	
	if(list1 != null && list1.size() > 0){
		count1 = Integer.valueOf(list1.get(0).get("count"));
	}
	if(list2 != null && list2.size() > 0){
		count2 = Integer.valueOf(list2.get(0).get("count"));
	}
	if(list3 != null && list3.size() > 0){
		count3 = Integer.valueOf(list3.get(0).get("count"));
	}
	if(list4 != null && list4.size() > 0){
		count4 = Integer.valueOf(list4.get(0).get("count"));
	}
 %>
	<section class="larry-wrapper">
		<!-- overview -->
		<div class="row state-overview">
			<div class="col-lg-3 col-sm-6 layui-anim layui-anim-up">
				<section class="panel">
					<div class="symbol userblue layui-anim layui-anim-rotate">
						<i class="iconpx-users"></i>
					</div>
					<div class="value">
						<a href="#">
							<h1 id="count1"><%=count1 %></h1>
						</a>
						<p>用户总量</p>
					</div>
				</section>
			</div>
			<div class="col-lg-3 col-sm-6 layui-anim layui-anim-up">
				<section class="panel">
					<div class="symbol commred layui-anim layui-anim-rotate">
						<i class="iconpx-user-add"></i>
					</div>
					<div class="value">
						<a href="#">
							<h1 id="count2"><%=count2 %></h1>
						</a>
						<p>今日注册用户</p>
					</div>
				</section>
			</div>
			<div class="col-lg-3 col-sm-6 layui-anim layui-anim-up">
				<section class="panel">
					<div class="symbol articlegreen layui-anim layui-anim-rotate">
						<i class="iconpx-file-word-o"></i>
					</div>
					<div class="value">
						<a href="#">
							<h1 id="count3"><%=count3 %></h1>
						</a>
						<p>下单数目</p>
					</div>
				</section>
			</div>
			<div class="col-lg-3 col-sm-6 layui-anim layui-anim-up">
				<section class="panel">
					<div class="symbol rsswet layui-anim layui-anim-rotate">
						<i class="iconpx-check-circle"></i>
					</div>
					<div class="value">
						<a href="#">
							<h1 id="count4"><%=count4 %></h1>
						</a>
						<p>完成订单数</p>
					</div>
				</section>
			</div>
		</div>
		<!-- overview end -->
		<div class="row">

			<!-- 最新文章 -->
			<section class="panel">
				<header class="panel-heading bm0">
					<span class='span-title'>最新公告</span> <span class="badge"
						style="background-color:#FF3333;"> new </span> <span
						class="tools pull-right"><!-- <a href="javascript:;"
						class="iconpx-chevron-down"></a> --></span>
				</header>
				<div class="panel-body">
					<table class="table table-hover personal-task">
						<tbody>
								<%
								    //获取日期
									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
								    //查询公告信息
									String sql = "SELECT t.*,a.managerName FROM bulletininfo t left join managerinfo a on a.managerID = t.managerID where(t.isValid='1')Order By bulletinInputDate Desc limit 5";
									List<Bulletin> bulletins = BaseDao.executeJDBCSQLQuerys(sql, null, Bulletin.class);
									if(bulletins != null && bulletins.size() > 0){
										for (Bulletin bulletin : bulletins) {
								%>
							<tr>
								<td><a href="bulletInfo.jsp" target="_blank"><%=bulletin.getBulletinTitle() %></a></td>
								<td class="col-md-4">发布人：<%=bulletin.getManagerName() %>&nbsp;&nbsp;&nbsp;&nbsp;<%=bulletin.getBulletinInputDate() == null ? "" : sdf.format(bulletin.getBulletinInputDate()) %></td>
							</tr>
							<%
									}
								} else {
									%>
									<tr>
										<td style="text-align: center;">暫無資訊</td>
									</tr>
									<%
								}
							 %>
						</tbody>
					</table>
				</div>
			</section>
		</div>
		</div>

	</section>
</body>
</html>
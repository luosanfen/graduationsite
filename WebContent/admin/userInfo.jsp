<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>个人信息</title>
	<meta name="renderer" content="webkit">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">	
	<meta name="apple-mobile-web-app-status-bar-style" content="black">	
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="format-detection" content="telephone=no">	
	<link rel="stylesheet" type="text/css" href="../common/layui/css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="../common/bootstrap/css/bootstrap.css" media="all">
	<link rel="stylesheet" type="text/css" href="../common/global.css" media="all">
	<link rel="stylesheet" type="text/css" href="../css/personal.css" media="all">
	<script type="text/javascript" src="../common/layui/layui.js"></script>
	<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
</head>
<body>
<section class="layui-larry-box">
	<section class="layui-larry-box">
		<div class="larry-parent">
			<div class="layui-tab">
				<div class="larry-personal">
					<div class="layui-tab">
						<blockquote class="layui-elem-quote news_search">
							<div class="layui-inline">
								<a class="layui-btn layui-btn-danger batchDel" onclick="delbullets()">批量删除</a>
							</div>
						</blockquote>
						<table class="layui-table" id="table">
							<colgroup>
								<col width="50">
								<col width="10%">
								<col>
								<col width="9%">
								<col width="12%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<th>
										<input type="checkbox" id="addCheck" onclick="allCheck()">
									</th>
									<th>用户名</th>
									<th>真实姓名</th>
									<th>性别</th>
									<th>联系电话</th>
									<th>Email</th>
									<th>地址</th>
									<th>注册时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody class="news_content">
								<%
									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
									String sql = "select * from userinfo t ";
									List<User> users = BaseDao.executeJDBCSQLQuerys(sql, null, User.class);
									for (User user : users) {
								%>
								<tr>
									<td><input type="checkbox" name="checks"><input type="hidden" name="userID" value="<%=user.getUserID() %>"></td>
									<td><%=user.getUserName() %></td>
									<td><%=user.getUserRealName() %></td>
									<td><%=user.getUserSex() == 1 ? "男" : "女" %></td>
									<td><%=user.getUserPhone() %></td>
									<td><%=user.getUserEmail() %></td>
									<td><%=user.getUserAddress() %></td>
									<td><%=user.getUserCreateTime() == null ? "" : sdf.format(user.getUserCreateTime()) %></td>
									<td>
									<a class="layui-btn layui-btn-mini news_edit"
										href="javascript:void(0)" onclick="resetPwd(<%=user.getUserID() %>)"><i
											class="iconfont icon-edit"></i> 重置密码</a> 
									<a class="layui-btn layui-btn-danger layui-btn-mini news_del"
										data-id="1" onclick="single_del(<%=user.getUserID() %>)"><i class="layui-icon"></i> 删除</a></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
	</section>
<script type="text/javascript">
	var table;
	var form;
	var layer;
	$(function() {
		layui.use('table', function() {
			table = layui.table;
		});
	});

	function delUser(userID){
		$.ajax({
			url : "../admin", // 请求的url地址
			data : {
				option : "del_User",
				userID : userID
			},
			cache : false,
			dataType : "json", // 返回格式为json
			async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
			type : "POST", // 请求方式
			success : function(req) {
				window.top.layer.msg(req.msg);
				if(req.state == 1){
					setTimeout(function() {
						window.location.reload();
					}, 2000);
				}
			}
		}); 
	}
	
	function delbullets(){
		layer.confirm('确认要删除所选记录吗？', {
   	        btn : [ '确定', '取消' ]//按钮
        }, function(index) {
		var checks = $("input[name='checks']");
			for(var i = 0; i < checks.length; i++){
				var check = checks.eq(i);
				if(check.is(':checked')){
					var userID = $("#table input[name='userID']").eq(i).val();
					delUser(userID);
				}
			}
		}); 
	}
	
	function single_del(userID){
		layer.confirm('确认要删除这条记录吗？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
			delUser(userID);
        }); 
	}
	
	function resetPwd(userID){
		layer.confirm('确认要重置这个用户的密码？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
			$.ajax({
				url : "../admin", // 请求的url地址
				data : {
					option : "resetPwd",
					userID : userID
				},
				cache : false,
				dataType : "json", // 返回格式为json
				async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
				type : "POST", // 请求方式
				success : function(req) {
					window.top.layer.msg(req.msg);
					layer.close(layer.index);
				}
			}); 
        }); 
	}
	
	function allCheck(){
		var checks = $("input[name='checks']");;
		for(var i = 0; i < checks.length; i ++){
			if($("#addCheck").is(':checked')){
				checks[i].checked = true;
			} else {
				checks[i].checked = false;
			}
		}
	}
</script>
</body>
</html>
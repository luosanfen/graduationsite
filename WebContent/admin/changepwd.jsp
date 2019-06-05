<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>修改密码</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css"
	href="../common/layui/css/layui.css" media="all">
<link rel="stylesheet" type="text/css"
	href="../common/bootstrap/css/bootstrap.css" media="all">
<link rel="stylesheet" type="text/css" href="../common/global.css"
	media="all">
<link rel="stylesheet" type="text/css" href="../css/personal.css"
	media="all">
<script type="text/javascript" src="../common/layui/layui.js"></script>
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
</head>
<body>
	<section class="layui-larry-box">
		<div class="larry-personal">
			<header class="larry-personal-tit">
				<span>修改密码</span>
			</header>
			<!-- /header -->
			<div class="larry-personal-body clearfix changepwd">
				<form class="layui-form col-lg-4" lay-filter="changepwd_form" id="changepwd_form">
					<input type="hidden" name="option" value="changepwd">
					<div class="layui-form-item">
						<label class="layui-form-label">用户名</label>
						<div class="layui-input-block">
							<input type="text" autocomplete="off"
								class="layui-input layui-disabled" value="<%=(String) session.getAttribute("manageUserName") %>"
								disabled="disabled">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">旧密码</label>
						<div class="layui-input-block">
							<input type="password" id="oldPwd" name="oldPwd" autocomplete="off"
								class="layui-input" value="" placeholder="请输入旧密码">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">新密码</label>
						<div class="layui-input-block">
							<input type="password" name="newPwd" id="newPwd" autocomplete="off"
								class="layui-input" placeholder="请输入新密码">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">确认密码</label>
						<div class="layui-input-block">
							<input type="password" id="newPwd2" autocomplete="off"
								class="layui-input" placeholder="请输入确认新密码">
						</div>
					</div>
					<div class="layui-form-item change-submit">
						<div class="layui-input-block">
							<button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
							<button type="reset" class="layui-btn layui-btn-primary">重置</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>
<script type="text/javascript">
	$(function (){
		layui.use(['form'],function(){
	        var form = layui.form();
	        form.on('submit(changepwd_form)', function(data){oldPwd
	        	var oldPwd = $("#oldPwd").val();
				var newPwd = $("#newPwd").val();
				var newPwd2 = $("#newPwd2").val();
				if(oldPwd == ""){
					window.top.layer.msg("旧密码不能为空");
					return false;
				}
				if(newPwd == ""){
					window.top.layer.msg("新密码不能为空");
					return false;
				}
				
				if(newPwd != newPwd2){
					window.top.layer.msg("新密码与确认密码不一致(＾Ｕ＾)ノ~ＹＯ");
					return false;
				}
				$.ajax({
					url : "../admin", // 请求的url地址
					data : $("#changepwd_form").serialize(),
					cache : false,
					dataType : "json", // 返回格式为json
					async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
					type : "POST", // 请求方式
					success : function(req) {
						window.top.layer.msg(req.msg);
						if(req.state == 1){
							window.location.reload();
						}
					}
				}); 
				return false; 
			});
		});
	});
</script>
</body>
</html>
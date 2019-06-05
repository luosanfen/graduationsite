<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>二级分类添加</title>
<meta name="renderer" content="webkit">
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
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../common/layui/layui.js"></script>
<script type="text/javascript" src="../js/bulletadd.js"></script>
</head>
<body>
	<br />
	<form class="layui-form" id="catFrom">
		<input type="hidden" name="option" value="save_GoodsCat">
		<div class="layui-form-item">
			<label class="layui-form-label">二级分类名</label>
			<div class="layui-input-block">
				<input name="categoryName" id="categoryName" required class="layui-input newsName" lay-verify="required"
					placeholder="类名" type="text">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">一级分类</label>
			<div class="layui-input-inline">
				<select name="parentCatID" id="parentCatID" required class="layui-input" lay-verify="required">
					<option value="">请选择一级分类</option>
					<%
						String sql = "select * from parentcatinfo t ";
						List<ParentCat> parentCats = BaseDao.executeJDBCSQLQuerys(sql, null, ParentCat.class);
						for(ParentCat parentCat : parentCats){
						%>
							<option value="<%=parentCat.getParentCatID() %>"><%=parentCat.getParentCatName() %></option>
						<%
						}
					%>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">类别说明</label>
			<div class="layui-input-block">
				<textarea name="categoryText" style="resize: none;" placeholder="请输入类别简要概述"
					class="layui-textarea"></textarea>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" onclick="save_cat()">立即添加</button>
			</div>
		</div>
	</form>
</body>
</html>
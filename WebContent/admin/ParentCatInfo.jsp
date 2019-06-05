<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>个人信息</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css" href="../common/layui/css/layui.css" media="all">
<link rel="stylesheet" type="text/css" href="../common/bootstrap/css/bootstrap.css" media="all">
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../common/layui/layui.js"></script>
<script type="text/javascript" src="../js/larry.js"></script>
</head>
<body>
	<section class="layui-larry-box">
		<div class="larry-parent">
			<div class="layui-tab">
				<blockquote class="layui-elem-quote news_search">
					<div class="layui-inline">
						<form>
							<div class="layui-input-inline">
								<input name="name" value="" placeholder="请输入分类名称"
									class="layui-input search_input" type="text">
							</div>
							<button class="layui-btn gsearch_btn" type="submit">查询</button>
						</form>
					</div>
					<div class="layui-inline">
						<a class="layui-btn layui-btn-normal" href="javascript:void(0)" onclick="addPanel()">添加</a>
					</div>
					<div class="layui-inline">
						<div class="layui-form-mid layui-word-aux"></div>
					</div>
				</blockquote>
				<table class="layui-table">
					<colgroup>
						<col width="10%">
						<col width="20%">
						<col width="25%">
						<col width="15%">
						<col width="9%">
					</colgroup>
					<thead>
						<tr>
							<th>分类名称</th>
							<th>类别描述</th>
							<th>录入时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<%
							List<Object> params = new ArrayList<Object>();
							String name = request.getParameter("name");
							String sql = "select * from parentcatinfo t where 1=1 ";
							if(name != null && !"".equals(name)){
								name = new String(name.getBytes("ISO-8859-1"),"UTF-8");
								sql += "and parentCatName like ?";
								params.add("%" + name + "%");
							}
							List<ParentCat> parentCats = BaseDao.executeJDBCSQLQuerys(sql, params, ParentCat.class);
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							for(ParentCat parentCat : parentCats){
						%>
							<tr>
								<td><%=parentCat.getParentCatName() %></td>
								<td><%=parentCat.getParentCatText() %></td>
								<td><%=sdf.format(parentCat.getParentCatTime()) %></td>
								<td><a
									class="layui-btn layui-btn-danger layui-btn-mini news_del"
									data-id="1" onclick="delFun('<%=parentCat.getParentCatID() %>')"><i class="layui-icon"></i> 删除</a></td>
							</tr>
						 <%
							}
						 %>
					</tbody>
				</table>
			</div>
		</div>
	</section>
</body>
<script type="text/javascript">
	$(function(){
		layui.use(['jquery','layer','element','laypage'],function(){
		      window.jQuery = window.$ = layui.jquery;
		      window.layer = layui.layer;
		});
	});
	
	function delFun(parentCatID){
		layer.confirm('是否删除', {
			btn: ['确定', '取消']
	    }, function (index, layero) {
			$.ajax({
				url : "../admin",
				data : {
					"parentCatID" : parentCatID,
					"option" : "del_ParentCat"
				},
				type : "post",
				dataType : "json",
				success : function(data) {
					window.top.layer.msg(data.msg);
					if (data.state == 1) {
						//刷新父页面
						location.reload();
					}
				}
			});
		});
	}
	
	function addPanel(){
		layer.open({
		  type: 2,
		  area: ['430px', '350px'],
		  content: "ParentCatAdd.jsp"
		});
	}
	
	function close(){
		layer.close(layer.index);
	}
</script>
</html>
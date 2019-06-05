<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>留言</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css"
	href="../common/layui/css/layui.css" media="all">
<link rel="stylesheet" type="text/css"
	href="../common/bootstrap/css/bootstrap.css" media="all">
<link rel="stylesheet" type="text/css" href="../common/global.css"
	media="all">
<script type="text/javascript" src="../common/layui/layui.js"></script>
<script type="text/javascript" src="../js/larry.js"></script>
<style>
.conBody {
	font-size: 1.5rem;
	margin: 2.5rem 0;
	background-color: #f2f2f2;
	padding: 2rem;
}

.conBody>p {
	text-align: right;
	font-size: 2rem;
	font-weight: bold;
}

.conPage {
	text-align: center;
	margin-bottom: 2rem;
	font-size: 2rem;
	font-weight: bold;
}

.conPage>span {
	margin-right: 2rem;
}
</style>
</head>
<body>
<section class="layui-larry-box">
<div class="larry-parent">
	<div class="layui-tab">
	<div class="larry-personal">
	<div class="layui-tab">
		<blockquote class="layui-elem-quote news_search">
		<div class="layui-inline">
			<a class="layui-btn layui-btn-danger batchDel" onclick="delContacts()">批量删除</a>
		</div>
	</blockquote>
		<table class="layui-table" id="table">
			<colgroup>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>
						<input type="checkbox" id="addCheck">
					</th>
					<th>用户名</th>
					<th>邮箱</th>
					<th>关键字</th>
					<th>内容</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody class="news_content">
			 <%
               String sql = "SELECT * FROM contactinfo";
	           List<Contact> contacts = BaseDao.executeJDBCSQLQuerys(sql, null, Contact.class);
	           for(Contact contact : contacts){
              %>
				<tr>
				  <td><input type="checkbox" name="checks"><input type="hidden" name="conID" value="<%=contact.getConID() %>"></td>
					<td><%=contact.getConName() %></td>
					<td><%=contact.getConEmail() %></td>								
					<td><%=contact.getConTitle() %></td>
					<td><%=contact.getConContent() %></td>
					
					<td><a class="layui-btn layui-btn-danger layui-btn-mini news_del"
						data-id="1" onclick="del_Contact(<%=contact.getConID() %>)">
						<i class="layui-icon"></i> 删除</a>
					</td>
				</tr>
			<%}%>
			</tbody>
			</table>
		</div>
		
	</div>
</section>
	<%-- <div class="container">
		<%
			String sql = "SELECT * FROM contactinfo";
			List<Contact> contacts = BaseDao.executeJDBCSQLQuerys(sql, null, Contact.class);
			for(Contact contact : contacts){
		%>
			<div class="conBody">
				<ul>
					<li><label>用 户 名：</label><span><%=contact.getConName() %></span></li>
					<li><label>邮&ensp;&ensp;箱：</label><span><%=contact.getConEmail() == null ? "" : contact.getConEmail() %></span></li>
					<li><label>标&ensp;&ensp;题：</label><span><%=contact.getConTitle() %></span></li>
					<li><label>内&ensp;&ensp;容：</label>
					<p>&ensp;&ensp;&ensp;&ensp;<%=contact.getConContent() %></p></li>
				</ul>
				<p>
					<a href="javascript:void(0)" onclick="del_Contact(<%=contact.getConID() %>)">删除留言</a>
				</p>
			</div>
		<%
			}
		 %>
	</div> --%>
</body>
<script type="text/javascript">
var table;
var layer;
//删除方法，传参用的
function delContact(conID){
	$.ajax({
		url : "../admin", // 请求的url地址
		data : {
			option : "del_Contact",
			conID : conID
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
function delContacts(){
	layer.confirm('确认要删除所选记录吗？', {
	        btn : [ '确定', '取消' ]//按钮
    }, function(index) {
	var checks = $("input[name='checks']");
		for(var i = 0; i < checks.length; i++){
			var check = checks.eq(i);
			if(check.is(':checked')){
				var conID = $("#table input[name='conID']").eq(i).val();
				delContact(conID);//调用
			}
		}
	}); 
}
	function del_Contact(conID){
		layer.confirm('确认要删除这条记录吗？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
        	delContact(conID);//调用
        }); 
	}
</script>
</html>

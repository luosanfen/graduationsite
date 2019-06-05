<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>管理员信息</title>
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
								<form>
									<div class="layui-input-inline">
										<input name="name" value="" placeholder="请输入关键字"
											class="layui-input search_input" type="text">
									</div>
									<button class="layui-btn gsearch_btn" type="submit">查询</button>
								</form>
							</div>
							<div class="layui-inline">
								<a class="layui-btn layui-btn-normal newsAdd_btn"
									href="javascript:void(0)" onclick="show_panel(0)">添加管理员</a>
							</div>
							<div class="layui-inline">
								<a class="layui-btn layui-btn-danger batchDel" onclick="delbullets()">批量删除</a>
							</div>
						</blockquote>
						<table class="layui-table" id="table">
							<colgroup>
								<col width="50">
								<col>
								<col>
								<col>
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<th>
										<input type="checkbox" id="addCheck" onclick="allCheck()">
									</th>
									<th>用户名</th>
									<th>管理员类型</th>
									<th>管理员描述</th>
									<th>有效标志</th>
									<th>访问次数</th>
									<th>最后访问时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody class="news_content">
								<%
									List<Object> params = new ArrayList<Object>();
									String name = request.getParameter("name");
									String sql = "select * from managerinfo t where 1=1 ";
									if(name != null && !"".equals(name)){
										name = new String(name.getBytes("ISO-8859-1"),"UTF-8");
										sql += "and managerName like ?";
										params.add("%" + name + "%");
									}
									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									List<Manager> managers = BaseDao.executeJDBCSQLQuerys(sql, params, Manager.class);
									for (Manager manager : managers) {
								%>
								<tr>
									<td><input type="checkbox" name="checks"><input type="hidden" name="managerID" value="<%=manager.getManagerID() %>"></td>
									<td><%=manager.getManagerName() %></td>
									<td><%=manager.getManagerTypeName() %></td>
									<td><%=manager.getManagerText() %></td>
									<td><%=manager.getManagerCheck() == 1 ? "是" : "否" %></td>
									<td><%=manager.getManagerVisitCount() == null ? "" : manager.getManagerVisitCount() %></td>
									<td><%=manager.getManagerLastVisitTime() == null ? "" : sdf.format(manager.getManagerLastVisitTime())%></td>
									<td><a class="layui-btn layui-btn-mini news_edit"
										href="javascript:void(0)" onclick="show_panel(<%=manager.getManagerID() %>)"><i
											class="iconfont icon-edit"></i> 编辑</a> <a
										class="layui-btn layui-btn-danger layui-btn-mini news_del"
										data-id="1" onclick="single_del(<%=manager.getManagerID() %>)"><i class="layui-icon"></i> 删除</a></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
	</section>
	<div id="manege_panel" style="display: none;" class="layui-form" >
		<form class="layui-form" id="manege_form" lay-filter="manege_form">
			<input type="hidden" name="option" value="save_manege">
			<input type="hidden" name=managerID id="managerID">
			<div class="layui-form-item">
				<label class="layui-form-label"></label>
				<div class="layui-input-block">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">用户名</label>
				<div class="layui-input-block">
					<input id="username" name="username" class="layui-input"
						lay-verify="required" placeholder="用户名" type="text" disabled="disabled">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">真实姓名</label>
				<div class="layui-input-block">
					<input id="managerName" name="managerName" class="layui-input"
						lay-verify="required" placeholder="真实姓名" type="text">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">管理员类型</label>
				<div class="layui-input-block">
					<select id="managerType" name="managerType" lay-verify="required" >
					  <option value="">请选择管理员类型</option>
					  <option value="0">超级管理员</option>
					  <option value="1">系统管理员</option>
					</select>   
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">有效标志</label>
				<div class="layui-input-block">
					<input id="managerCheck" name="managerCheck" type="checkbox" lay-skin="switch"
						lay-text="否|是" value="1">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">管理员描述</label>
				<div class="layui-input-block">
					<textarea id="managerText" name="managerText" class="layui-textarea"
						lay-verify="content" style="resize: none;" rows="14"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit="" lay-filter="addNews">保存</button>
				</div>
			</div>
		</form>
	</div>
<script type="text/javascript">
	var table;
	var form;
	var layer;
	$(function() {
		layui.use('table', function() {
			table = layui.table;
		});
		layui.use([ 'form', 'layer' ], function() {
			form = layui.form();
			layer = layui.layer;
			form.on('submit(manege_form)', function(data){
				$.ajax({
					url : "../admin", // 请求的url地址
					data : $("#manege_form").serialize(),
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
 
	
	//添加、修改管理员信息
	function show_panel(managerID) {
		$("#manege_form")[0].reset();//添加
		if(managerID != 0){
			$("#managerID").val(managerID);
			$.ajax({
				url : "../admin", // 请求的url地址
				data : {
					option : "getManager",
					managerID : managerID
				},
				cache : false,
				dataType : "json", // 返回格式为json
				async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
				type : "POST", // 请求方式
				success : function(req) {//修改，获取原来信息
					if(req.state != 1){
						window.top.layer.msg(req.msg);
					}
					var data = JSON.parse(req.data);
					$("#username").val(data.username);
					$("#managerName").val(data.managerName);
					$("#managerType").val(data.managerType);
					$("#managerText").val(data.managerText);
					if(data.managerCheck == 1){
						$("#managerCheck").parent().find(".layui-form-switch").click();
					}
				}
			}); 
		} else {
			$("#username").removeAttr("disabled");
			$("#managerID").val("");
		}
		layer.open({
			type : 1,
			area : [ '600px', '460px' ],
			content : $('#manege_panel')
		});
	}
	
	function delManager(managerID){
		$.ajax({
			url : "../admin", // 请求的url地址
			data : {
				option : "del_Manager",
				managerID : managerID
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
					var managerID = $("#table input[name='managerID']").eq(i).val();
					delManager(managerID);
				}
			}
		}); 
	}
	
	function single_del(managerID){
		layer.confirm('确认要删除这条记录吗？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
			delManager(managerID);
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
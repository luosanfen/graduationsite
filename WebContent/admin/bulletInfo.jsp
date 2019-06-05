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
<script type="text/javascript" src="../js/larry.js"></script>
<script type="text/javascript"
	src="../common/layui/lay/modules/laydate.js"></script>
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
</head>
<body>
	<section class="layui-larry-box">
		<div class="larry-parent">
			<div class="layui-tab">
				<div class="larry-personal">
					<div class="layui-tab">
						<blockquote class="layui-elem-quote news_search">
							<div class="layui-inline">
								<form>
									<div class="layui-input-inline">
										<input name="name" value="" placeholder="请输入标题"
											class="layui-input search_input" type="text">
									</div>
									<button class="layui-btn gsearch_btn" type="submit">查询</button>
								</form>
							</div>
							<div class="layui-inline">
								<a class="layui-btn layui-btn-normal newsAdd_btn"
									href="javascript:void(0)" onclick="show_panel(0)">添加公告</a>
							</div>
							<div class="layui-inline">
								<a class="layui-btn layui-btn-danger batchDel" onclick="delbullets()">批量删除</a>
							</div>
							<div class="layui-inline">
								<div class="layui-form-mid layui-word-aux">本页面刷新后除新添加的文章外所有操作无效，关闭页面所有数据重置</div>
							</div>
						</blockquote>
						<table class="layui-table" id="table">
							<colgroup>
								<col width="50">
								<col>
								<col width="9%">
								<col width="12%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<th>
										<input type="checkbox" id="addCheck">
									</th>
									<th style="text-align:left;">公告标题</th>
									<th>发布人</th>
									<th>是否有效</th>
									<th>发布时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody class="news_content">
								<%
									List<Object> params = new ArrayList<Object>();
									String name = request.getParameter("name");
									String sql = "SELECT t.*,a.managerName FROM bulletininfo t left join managerinfo a on a.managerID = t.managerID where 1=1 ";
									if(name != null && !"".equals(name)){
										name = new String(name.getBytes("ISO-8859-1"),"UTF-8");
										sql += "and t.bulletinTitle like ?";
										params.add("%" + name + "%");
									}
									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
									List<Bulletin> bulletins = BaseDao.executeJDBCSQLQuerys(sql, params, Bulletin.class);
									for (Bulletin bulletin : bulletins) {
								%>
								<tr>
									<td><input type="checkbox" name="checks"><input type="hidden" name="bulletinID" value="<%=bulletin.getBulletinID()%>"></td>
									<td align="left"><%=bulletin.getBulletinTitle()%></td>
									<td><%=bulletin.getManagerName()%></td>
									<td>
										<%
											if ("1".equals(bulletin.getIsValid())) {
										%> 是 <%
											} else {
										%> 否 <%
											}
										%>
									</td>
									<td><%=sdf.format(bulletin.getBulletinInputDate())%></td>
									<td><a class="layui-btn layui-btn-mini news_edit"
										href="javascript:void(0)" onclick="show_panel(<%=bulletin.getBulletinID()%>)"><i
											class="iconfont icon-edit"></i> 编辑</a> <a
										class="layui-btn layui-btn-danger layui-btn-mini news_del"
										data-id="1" onclick="single_del(<%=bulletin.getBulletinID()%>)"><i class="layui-icon"></i> 删除</a></td>
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
<div id="bullet_panel" style="display: none;" class="layui-form" >
	<form class="layui-form" id="bullet_form" lay-filter="bullet_form">
		<input type="hidden" name="option" value="save_bullet">
		<input type="hidden" name="bulletinID" id="bulletinID">
		<div class="layui-form-item">
			<label class="layui-form-label"></label>
			<div class="layui-input-block">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">公告标题</label>
			<div class="layui-input-block">
				<input id="bulletinTitle" name="bulletinTitle" class="layui-input"
					lay-verify="required" placeholder="请输入文章标题" type="text">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">是否发布</label>
			<div class="layui-input-block">
				<input id="isValid" name="isValid" type="checkbox" lay-skin="switch"
					lay-text="否|是" value="1">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">公告内容</label>
			<div class="layui-input-block">
				<textarea id="bulletincontent" name="bulletincontent" class="layui-textarea"
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
</html>
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
			form.on('submit(bullet_form)', function(data){
				$.ajax({
					url : "../admin", // 请求的url地址
					data : $("#bullet_form").serialize(),
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

	function show_panel(bulletId) {
		$("#bullet_form")[0].reset();
		if(bulletId != 0){
			$("#bulletinID").val(bulletId);
			$.ajax({
				url : "../admin", // 请求的url地址
				data : {
					option : "getBullet",
					bulletinID : bulletId
				},
				cache : false,
				dataType : "json", // 返回格式为json
				async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
				type : "POST", // 请求方式
				success : function(req) {
					if(req.state != 1){
						window.top.layer.msg(req.msg);
					}
					var data = JSON.parse(req.data);
					$("#bulletinTitle").val(data.bulletinTitle);
					$("#bulletincontent").val(data.bulletincontent);
					if(data.isValid == 1){
						$("#isValid").parent().find(".layui-form-switch").click();
					}
				}
			}); 
		} else {
			$("#bulletinID").val("");
		}
		layer.open({
			type : 1,
			area : [ '50rem', '40rem' ],
			content : $('#bullet_panel')
		});
	}
	//调用，传递数据、动作
	function delbullet(bulletId){
		$.ajax({
			url : "../admin", // 请求的url地址
			data : {
				option : "del_Bullet",
				bulletinID : bulletId
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
	//全部删除
	function delbullets(){
		layer.confirm('确认要删除所选记录吗？', {
   	        btn : [ '确定', '取消' ]//按钮
        }, function(index) {
		var checks = $("input[name='checks']");
			for(var i = 0; i < checks.length; i++){
				var check = checks.eq(i);
				if(check.is(':checked')){
					var bulletId = $("#table input[name='bulletinID']").eq(i).val();
					delbullet(bulletId);//调用方法
				}
			}
		}); 
	}
	//单条删除
	function single_del(bulletId){
		layer.confirm('确认要删除这条记录吗？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
			delbullet(bulletId);
        }); 
	}
	
/* 	function allCheck(){
		var checks = $("input[name='checks']");;
		for(var i = 0; i < checks.length; i ++){
			if($("#addCheck").is(':checked')){
				checks[i].checked = true;
			} else {
				checks[i].checked = false;
			}
		}
	} */
	
</script>
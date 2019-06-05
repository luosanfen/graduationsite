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
<link rel="stylesheet" type="text/css" href="../css/fileinput.min.css"
	media="all">
<script type="text/javascript" src="../common/layui/layui.js"></script>
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/layui.all.js"></script>
<script type="text/javascript" src="../js/fileinput.min.js"></script>
</head>
<body>
	<section class="layui-larry-box">
		<div class="larry-parent">
			<div class="layui-tab">
				<blockquote class="layui-elem-quote news_search">
					<div class="layui-inline">
						<form>
							<div class="layui-input-inline">
								<input name="name" value="" placeholder="请输入商品名称"
									class="layui-input search_input" type="text">
							</div>
							<button class="layui-btn gsearch_btn" type="submit">查询</button>
						</form>
					</div>
					<div class="layui-inline">
						<a class="layui-btn layui-btn-normal" href="javascript:void(0)"
							onclick="openEdit(true)">添加</a>
					</div>
					<div class="layui-inline">
						<div class="layui-form-mid layui-word-aux"></div>
					</div>
				</blockquote>
				<!-- 一级商品类别 -->
				<table class="layui-table">
					<colgroup>
						<col width="4%">
						<col width="7%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="18%" />
						<col width="8%" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" name=""></th>
							<th style="text-align:left;">商品编号</th>
							<th>商品名称</th>
							<th>一级分类</th>
							<th>二级分类</th>
							<th>关键字</th>
							<th>简介</th>
							<th>是否新品</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<%
							List<Object> params = new ArrayList<Object>();
							String name = request.getParameter("name");
							String sql = "select * from goodsinfo where 1=1 ";
							if(name != null && !"".equals(name)){
								name = new String(name.getBytes("ISO-8859-1"),"UTF-8");
								sql += "and goodsName like ?";
								params.add("%" + name + "%");
							}
							List<GoodsInfo> goodsInfos = BaseDao.executeJDBCSQLQuerys(sql, params, GoodsInfo.class);
							for (GoodsInfo goodsInfo : goodsInfos) {
								params = new ArrayList<Object>();
								params.add(goodsInfo.getParentCatID());
								String parentCat_sql = "select * from parentcatinfo t where t.parentCatID=?";
								ParentCat parentCat = BaseDao.executeJDBCSQLQuery(parentCat_sql, params, ParentCat.class);
								params = new ArrayList<Object>();
								params.add(goodsInfo.getCategoryID());
								String category_sql = "select * from goodscatinfo t where t.categoryID=?";
								Category category = BaseDao.executeJDBCSQLQuery(category_sql, params, Category.class);
						%>
						<tr>
							<th><input type="checkbox" name=""></th>
							<td><%=goodsInfo.getGoodsID()%></td>
							<td><%=goodsInfo.getGoodsName()%></td>
							<td><%=parentCat.getParentCatName()%></td>
							<td><%=category.getCategoryName()%></td>
							<td><%=goodsInfo.getGoodsKeys()%></td>
							<td><%=goodsInfo.getGoodsText()%></td>
							<%
								if (goodsInfo.getGoodsIsNew() == 1) {
							%>
							<td>是</td>
							<%
								} else {
							%>
							<td>否</td>
							<%
								}
							%>

							<td>
							<a class="layui-btn layui-btn-mini goog_edit"
								onclick="modifyGoods(<%=goodsInfo.getGoodsID()%>)">
								<i class="iconfont icon-edit"> </i>编辑</a> 
							<a class="layui-btn layui-btn-mini goog_edit"
								onclick="imgList(<%=goodsInfo.getGoodsID()%>)">图片</a> 
							<a class="layui-btn layui-btn-mini goog_edit"
								onclick="modelList(<%=goodsInfo.getGoodsID()%>)">规格</a>
						    <a class="layui-btn layui-btn-danger layui-btn-mini news_del"
								data-id="1" onclick="delGoods(<%=goodsInfo.getGoodsID()%>)">
								<i class="layui-icon"></i> 删除</a></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	
	<!-- 添加的商品信息 -->
	<div id="edit_panel" style="display: none;">
		<br />
		<form class="layui-form" id="goodsForm" name="goodsForm"
			lay-filter="goodsForm">
			<input type="hidden" name="option" value="save_Goods"> <input
				type="hidden" name="goodsID" id="goodsID">
			<div class="layui-form-item">
				<label class="layui-form-label">一级分类</label>
				<div class="layui-input-block">
					<select name="parentCatID" id="parentCatID" lay-filter="parentCat"
						class="layui-input" lay-verify="required" onchange="getCategory()">
						<option value="">请选择一级分类</option>
						<%
							String parentCat_sql = "select * from parentcatinfo t ";
							List<ParentCat> parentCats = BaseDao.executeJDBCSQLQuerys(parentCat_sql, null, ParentCat.class);
							for (ParentCat parentCat : parentCats) {
						%>
						<option value="<%=parentCat.getParentCatID()%>"><%=parentCat.getParentCatName()%></option>
						<%
							}
						%>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">二级分类</label>
				<div class="layui-input-block">
					<select name="categoryID" id="categoryID" class="layui-input"
						lay-verify="required">
						<option value="">请选择二级分类</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">商品名称</label>
				<div class="layui-input-block">
					<input type="text" name="goodsName" required lay-verify="required"
						placeholder="请输入商品名称" autocomplete="off" class="layui-input"
						style="width: 300px;">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">关键字</label>
				<div class="layui-input-block">
					<input type="text" name="goodsKeys" required lay-verify="required"
						placeholder="请输入关键字" autocomplete="off" class="layui-input"
						style="width: 300px;">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">简介</label>
				<div class="layui-input-block">
					<input type="text" name="goodsText" required lay-verify="required"
						placeholder="请输入简介" autocomplete="off" class="layui-input"
						style="width: 300px;">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">是否新品</label>
				<div class="layui-input-block" style="width: 300px;">
					<select id="goodsIsNew" name="goodsIsNew" lay-verify="required">
						<option value="">请选择是否新品</option>
						<option value="1" selected>是</option>
						<option value="0">否</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">是否推荐</label>
				<div class="layui-input-block" style="width: 300px;">
					<select id="goodsIsVouch" name="goodsIsVouch" lay-verify="required">
						<option value="">请选择是否推荐</option>
						<option value="1" selected>是</option>
						<option value="0">否</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">详细说明</label>
				<div class="layui-input-block">
					<textarea id="goodsContent" name="goodsContent" style="resize: none;"
						placeholder="详细说明" class="layui-textarea"></textarea>
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-input-block">
					<button id="subBtn" type="submit" class="layui-btn">立即提交</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</form>
	</div>
	
	<!--商品规格信息  -->
	<div id="model_panel" style="display: none;">
		<br />
		<form class="layui-form" id="modelForm" name="modelForm"
			lay-filter="modelForm">
			<input type="hidden" name="option" value="add_Model"> <input
				type="hidden" name="modelId" id="modelId"> <input
				type="hidden" name="goodsID" id="goodsID">
			<div class="layui-form-item">
				<label class="layui-form-label">商品规格</label>
				<div class="layui-input-block">
					<input type="text" name="modelName" required lay-verify="required"
						placeholder="请输入商品规格" autocomplete="off" class="layui-input"
						style="width: 300px;">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">价格</label>
				<div class="layui-input-block">
					<input type="text" name="orderPrice" required
						lay-verify="required|number" placeholder="请输入价格"
						autocomplete="off" class="layui-input" style="width: 300px;">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">库存</label>
				<div class="layui-input-block">
					<input type="text" name="inventoryNum" required
						lay-verify="required|number" placeholder="请输入库存"
						autocomplete="off" class="layui-input" style="width: 300px;">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button id="sub_model" class="layui-btn" type="submit">立即提交</button>
					<button class="layui-btn layui-btn-primary" onclick="back_goods()">上一步</button>
				</div>
			</div>
		</form>
	</div>
    
    <!-- 上传图片 -->
	<div id="img_panel" style="display: none;">
		<input type="hidden" name="goodsID" id="goodsID"> 
		<input id="file" name="file" type="file" class="file" multiple="multiple">
		<br />
		<center>
			<button type="button" class="btn btn-success"
				onclick="clo_Img_panel()">完成</button>
		</center>
	</div>

	<div id="img_list_panel" style="display: none;" class="layui-form" >
		<table id="img_list" lay-filter="img_list"></table>
	</div>

	<div id="model_list_panel" style="display: none;" class="layui-form" >
		<table id="model_list" lay-filter="model_list"></table>
	</div>
</body>
<script type="text/javascript">
var form;
var layer;
var table;
	$(function() {
		$("#kvFileinputModal").css("z-index", "9999");
		layui.use('table', function () {
			table = layui.table;
		});
		layui.use([ 'form', 'layer' ], function() {
			form = layui.form;
			layer = layui.layer;
			form.on('select(parentCat)', function(data) {
				getParentCat(data.value);
			});
			form.on('submit(goodsForm)', function(data){
				if($("#parentCatID").val() != "" && $("#categoryID").val() != ""){
					if($("#goodsID").val() == ""){
						$("#sub_model").html("下一步");
						$("#modelForm")[0].reset();
						next_model();
					} else {
						addGoods();
					}
				}
				return false; 
			});
			form.on('submit(modelForm)', function(data){
				if($("#modelId").val() == ""){
					next_Img();
				} else {
					addModel()
				}
				return false; 
			});
			
		})
		initFileBtn();
	});
	
	function getParentCat(parentCatID){
		$.ajax({
			url : "../admin",
			data : {
				"parentCatID" : parentCatID,
				"option" : "get_Category"
			},
			type : "post",
			dataType : "json",
			success : function(data) {
				$("#categoryID").html("");
				for(var i = 0; i < data.length; i++){
					$("#categoryID").append("<option value="+data[i].categoryID+">"+data[i].categoryName+"</option>");  
				}
				form.render();
			}
		});
	}
	
	function addGoods(){
		$.ajax({
			url : "../admin",
			data : $("#goodsForm").serialize(),
			type : "post",
			dataType : "json",
			success : function(data) {
				window.top.layer.msg(data.msg);
				layer.close(layer.index);
				window.location.reload();
			}
		});
	}
	
	function addModel(){
		$.ajax({
			url : "../admin",
			data : $("#modelForm").serialize(),
			type : "post",
			dataType : "json",
			success : function(data) {
				window.top.layer.msg(data.msg);
				layer.close(layer.index);
				window.location.reload();
			}
		});
	}

	function openEdit(flag) {
		if(flag){
			$("#goodsForm #goodsID").val("");
			$("#modelForm").find("#goodsID").val("");
			$("#img_panel").find("#goodsID").val("");
		} else {
		
		}
		if($("#goodsForm #goodsID").val() == ""){
			$("#subBtn").html("下一步");
			$("#goodsForm")[0].reset();
		} else {
			$("#subBtn").html("立即提交");
		}
		
		layer.open({
			type : 1,
			area : [ '440px', '480px' ],
			content : $('#edit_panel')
		});
	}
	
	function next_Img(){
		layer.close(layer.index);
		layer.open({
			type : 1,
			area : [ '560px', '400px' ],
			content : $('#img_panel')
		});
	}
	
	//图片处理
	function clo_Img_panel(){
		if($('#file').fileinput('getFilesCount') > 0){
			$.ajax({
				url : "../admin",
				data : $("#goodsForm").serialize(),
				type : "post",
				dataType : "json",
				success : function(data1) {
					$("#modelForm").find("#goodsID").val(data1.goodsID);
					$.ajax({
						url : "../admin",
						data : $("#modelForm").serialize(),
						type : "post",
						dataType : "json",
						success : function(data2) {
						$("#img_panel").find("#goodsID").val(data1.goodsID);
							$('#file').fileinput('upload');
						}
					});
				}
			});
			layer.close(layer.index);
		} else {
			window.top.layer.msg("您未选择任何文件");
		}
	}
	
	//弹出商品规格
	function next_model(){
		layer.close(layer.index);
		layer.open({
			type : 1,
			area : [ '430px', '300px' ],
			content : $('#model_panel')
		});
	}
	//返回上级商品信息填写
	function back_goods(){
		layer.close(layer.index);
		layer.open({
			type : 1,
			area : [ '440px', '480px' ],
			content : $('#edit_panel')
		});
	}
	
	//获取修改的商品ID
	function modifyGoods(goodsID){
		$("#goodsForm #goodsID").val(goodsID);
		$.ajax({
			url : "../admin", // 请求的url地址
			data : {
				"option" : "getGoods",
				"goodsID" : goodsID
			},
			cache : false,
			dataType : "json", // 返回格式为json
			type : "POST", // 请求方式
			success : function(req) {
				$("#goodsForm #parentCatID").val(req.parentCatID);
				getParentCat(req.parentCatID);
				$("#goodsForm #categoryID").val(req.categoryID);
				$("#goodsForm input[name='goodsName']").val(req.goodsName);
				$("#goodsForm input[name='goodsKeys']").val(req.goodsKeys);
				$("#goodsForm input[name='goodsText']").val(req.goodsText);
				$("#goodsForm #goodsIsNew").val(req.goodsIsNew);
				$("#goodsForm #goodsIsVouch").val(req.goodsIsVouch);
				$("#goodsForm #goodsContent").val(req.goodsContent);
				form.render('select');
			}
		}); 
		openEdit(false);
	}
	
	function imgList(goodsID){
		//执行渲染
		table.render({
		  elem: '#img_list' //指定原始表格元素选择器（推荐id选择器）
		  ,height: 315 //容器高度
		  ,url : "../admin?option=getImgList&goodsId=" + goodsID
		  ,cols:  [[ //标题栏
		    {field: 'goodImgId', title: 'ID',  hide:true}
		    ,{field: 'file_address', title: '文件地址', width: 400}
		    ,{field: 'file_sort', title: '排序', width: 300}
		    ,{field: 'option', title: '操作', width: 100,templet: function(d){
		        return '<a href="javascript:delImg(\'' + d.goodImgId + '\')">删除</a>';
		    }}
		  ]]
		});
		
		layer.open({
			type : 1,
			area : [ '900px', '500px' ],
			content : $('#img_list_panel')
		});
	}
	
	function modelList(goodsID){
		table.render({
		  elem: '#model_list' //指定原始表格元素选择器（推荐id选择器）
		  ,height: 315 //容器高度
		  ,url : "../admin?option=getModels&goodsId=" + goodsID
		  ,cols:  [[ //标题栏
		    {field: 'modelId', title: 'ID',  hide:true}
		    ,{field: 'modelName', title: '规格名称', width: 300}
		    ,{field: 'orderPrice', title: '价格', width: 180}
		    ,{field: 'orderNum', title: '库存', width: 180}
		    ,{field: 'option', title: '操作', width: 100,templet: function(d){
		        return '<a href="javascript:delImg(\'' + d.goodImgId + '\')">删除</a>';
		    }}
		  ]]
		});
		
		layer.open({
			type : 1,
			area : [ '900px', '500px' ],
			content : $('#model_list_panel')
		});
	}
	
	function delGoods(goodsID){
		layer.confirm('确认要删除所选记录吗？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
			$.ajax({
				url : "admin", // 请求的url地址
				data : {
					"option" : "delGoods",
					"goodsID" : goodsID
				},
				cache : false,
				dataType : "json", // 返回格式为json
				async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
				type : "POST", // 请求方式
				success : function(req) {
					window.top.layer.msg(req.msg);
					window.location.reload();
				}
			}); 
        }); 
	}
	
	function delModel(modelID){
		layer.confirm('确认要删除所选记录吗？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
			$.ajax({
				url : "admin", // 请求的url地址
				data : {
					"option" : "delModel",
					"modelID" : modelID
				},
				cache : false,
				dataType : "json", // 返回格式为json
				async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
				type : "POST", // 请求方式
				success : function(req) {
					window.top.layer.msg(req.msg);
					window.location.reload();
				}
			}); 
        }); 
	}
	
	function delImg(goodImgId){
		layer.confirm('确认要删除所选记录吗？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
			$.ajax({
				url : "../admin", // 请求的url地址
				data : {
					"option" : "delImg",
					"goodImgId" : goodImgId
				},
				cache : false,
				dataType : "json", // 返回格式为json
				async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
				type : "POST", // 请求方式
				success : function(req) {
					window.top.layer.msg(req.msg);
					window.location.reload();
				}
			}); 
        }); 
	}
	
	function initFileBtn(){
	$("#file").fileinput('destroy');
	$("#file").off();
	$("#file").fileinput({
		uploadUrl:"../admin", //上传的地址
        allowedFileExtensions: ['jpg', 'jpeg', 'gif', 'png'],//接收的文件后缀
        uploadExtraData : function(a, b) {
			var obj = {};
			obj.option = "upload";
			obj.goodsID = $("#img_panel").find("#goodsID").val();
			return obj;
        },
        maxFileSize : 10240, //最大上传10MB
        uploadAsync: true, //默认异步上传
        showUpload:false, //是否显示上传按钮
        showPreview :true, //是否显示预览
        browseClass:"btn btn-primary", //按钮样式    
        maxFileCount:10, //表示允许同时上传的最大文件个数
        enctype:'multipart/form-data',
        validateInitialCount:true,
        previewFileIcon: "<iclass='glyphicon glyphicon-king'></i>",
        msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        overwriteInitial: false,
        initialPreviewAsData: true,
        initialPreviewFileType: 'image',
        layoutTemplates:{
            actionDelete : "",
            actionUpload : ""
        }
	}).on('fileuploaded', function(e, params) {
		if(params.response.state == 1){
			window.top.layer.msg("保存成功");
			layer.close(layer.index);
			window.location.reload();
		} else {
			window.top.layer.msg("保存失败");
			layer.close(layer.index);
			window.location.reload();
		}
	}).on('filebatchselected', function(event, files) {
	});
}
</script>
</html>

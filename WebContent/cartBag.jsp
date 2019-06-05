<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.carabout {
	padding: 2em 0;
	height: 100%;
}

.container {
	width: 95% !important;
}

.rowcontent {
	margin: 2rem 0;
}

.buyAll {background-color：red;
	font-text: 1rem;
}
</style>
<!--头部内容-->
<%@ include file="head.jsp"%>
<link href="common/layui/css/layui.css" rel='stylesheet' type='text/css' />
<%
	String userID = String.valueOf(session.getAttribute("userID"));
	if (userID == null || "".equals(userID) || "null".equals(userID)) {
		response.sendRedirect("login.jsp");
		return;
	}
	List<Object> params = new ArrayList<Object>();
	String cart_sql = "select * from cartinfo t where t.userID=?";
	params.add(userID);
	List<CartInfo> cartInfo_list = BaseDao.executeJDBCSQLQuerys(cart_sql, params, CartInfo.class);
%>
<!-- <h1>购物车</h1> -->
<div class="carabout">
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-1 col-xs-1">
						<label><input id="allCheckked" type="checkbox" onclick="allCheck()"> &nbsp;&nbsp;全选</label>
					</div>
					<div class="col-md-1 col-xs-1 text-center">图片</div>
					<div class="col-md-2 col-xs-2 text-center">商品</div>
					<div class="col-md-2 col-xs-2 text-center">单价(元)</div>
					<div class="col-md-2 col-xs-2 text-center">数量</div>
					<div class="col-md-2 col-xs-2 text-center">小计</div>
					<div class="col-md-1 col-xs-1 text-center">操作</div>
				</div>
			</div>
			<!-- 面板标题 -->

			<div class="panel-body">
			<input type="hidden" id="info_count" value="<%=cartInfo_list.size() %>">
				<!-- 这是一列 -->
				<%
					for (int i = 0; i < cartInfo_list.size(); i++) {
						CartInfo cartInfo = cartInfo_list.get(i);
						List<Object> params2 = new ArrayList<Object>();//再建一个list,循环商品ID
						params2.add(cartInfo.getGoodsID());
						//查询商品图片
				    String cart_img = "SELECT t.* FROM goodsimg t left join cartinfo a on a.goodsID = t.GOODSID where a.goodsID=?";
					List<GoodsImg> cartimg = BaseDao.executeJDBCSQLQuerys(cart_img, params2, GoodsImg.class);
				%>
					<div class="row rowcontent">
						<div class="col-md-1 col-xs-1">
							<input name="rowcheck" id="singleChecked" type="checkbox" onclick="singleCheck()">
						</div>
						<input id="cartID<%=i %>" type="hidden" name="cartID" value="<%=cartInfo.getCartID() %>">
						<input type="hidden" name="goodsID" value="<%=cartInfo.getGoodsID() %>">
						<input type="hidden" name="goodsName" value="<%=cartInfo.getGoodName() %>">
						<input type="hidden" name="goodsPrice" value="<%=cartInfo.getGoodPrice() %>">
						<input type="hidden" name="goodsNumber" value="<%=cartInfo.getGoodNumber() %>">
						<!--  -->
						<div class="col-md-1 col-xs-1　text-center">
						   <img src="<%=cartimg.get(0).getFile_address() %>" style="width: 80px; height: 60px;">
						</div>
						<div class="col-md-2 col-xs-2 text-center"><%=cartInfo.getGoodName() %></div>
						<div class="col-md-2 col-xs-2 text-center"><%=cartInfo.getGoodPrice() %></div>
						<div class="col-md-2 col-xs-2 text-center">
							<span id="count<%=i + 1 %>"><%=cartInfo.getGoodNumber() %></span>
						</div>
						<div class="col-md-2 col-xs-2 text-center">
							<span id="price<%=i + 1 %>"><%=cartInfo.getGoodPrice() * cartInfo.getGoodNumber() %></span>
						</div>
						<div class="col-md-1 col-xs-1 text-center">
							<a href="javascript:void(0)" onclick="del('<%=cartInfo.getCartID() %>')">删除</a>
						</div>
					</div>
				<%
					}
				%>
				
			</div>
			<div class="panel-footer">
				<div class="row">
					<!-- <div class="col-md-2" style="margin-top: 1rem;">
						<label>&nbsp;&nbsp;已选<span class="Selected-pieces">0</span>件
						</label>
					</div> -->
					<div class="col-md-2" style="margin-top: 1rem;">
						<label>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="delSelect()">批量删除</a></label>
					</div>
					<div class="col-md-8 text-right"
						style="margin-top: 1rem; padding-right:3rem">
						应付：<b id="total" style="font-size: 24px; color:red;"></b>
					</div>
					<div class="col-md-1 text-center"
						style="background-color:#ff5500;font-size: 1rem;padding: 1rem; cursor:pointer" onclick="goBuy()">
						<a href="javascript:void(0)">结算</a>
					</div>
				</div>
			</div>
			
		</div>
		<!-- 面板内容 -->
	</div>
</div>
<div id="buy" style="display: none;">
	<br/>
	<form class="layui-form" id="orderForm">
		<input type="hidden" name="option" value="buy">
		<input type="hidden" name="orderAllPrice" id="orderAllPrice">
		<input type="hidden" name="goodsInfo" id="goodsInfo">
		<div class="layui-form-item">
			<label class="layui-form-label">收货人姓名</label>
			<div class="layui-input-block">
				<input type="text" name="orderUserRealName" required lay-verify="required" placeholder="请输入收货人姓名" autocomplete="off" class="layui-input" style="width: 300px;">   
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">收货人电话</label>
			<div class="layui-input-block">
				<input type="text" name="orderUserPhone" required lay-verify="required" placeholder="请输入收货人电话" autocomplete="off" class="layui-input" style="width: 300px;">  
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">收货地址</label>
			<div class="layui-input-block">
				<input type="text" name="orderUserAddress" required lay-verify="required" placeholder="请输入收货地址" autocomplete="off" class="layui-input" style="width: 300px;">  
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">送货方式</label>
			<div class="layui-input-block" style="width: 300px;">
				<select name="orderSendType" lay-verify="required" >
				  <option value="">请选择送货方式</option>
				  <option value="快递">快递</option>
				  <option value="自取">自取</option>
				  <option value="代取">代取</option>
				</select>     
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" >支付类型</label>
			<div class="layui-input-block" style="width: 300px;">
				<select name="orderPayType" lay-verify="required" >
				  <option value="">请选择支付类型</option>
				  <option value="支付宝">支付宝</option>
				  <option value="微信">微信</option>
				  <option value="网银">网银</option>
				  <option value="到付">到付</option>
				</select>      
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注</label>
			<div class="layui-input-block">
				<input type="text" name="orderRemark" required lay-verify="required" placeholder="备注" autocomplete="off" class="layui-input" style="width: 300px;">  
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" onclick="subOrder()">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
   //显示总价的
	 $(function (){
	/* 	var total = 0;
		var checks = $("input[name='rowcheck']");
		for(var i = 0; i < checks.length; i ++){
			total += parseFloat($("#price" + (i + 1)).html());
		}
		$("#total").html(total.toFixed(2)); */
		
		layui.use('form', function(){
		  var form = layui.form; 
		});
	}); 
	
	function del(cartID){
		layer.confirm('确认要删除所选记录吗？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
			$.ajax({
				url : "shopServlet", // 请求的url地址
				data : {
					"option" : "delCart",
					"cartID" : cartID
				},
				cache : false,
				dataType : "json", // 返回格式为json
				async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
				type : "POST", // 请求方式
				success : function(req) {
					layer.msg(req.msg);
					if(req.state == 0){
						setTimeout(function() {
							window.location.reload();
						}, 2000) 
					}
				}
			});
        }); 
	}
	
	function delSelect(){
		layer.confirm('确认要删除所选记录吗？', {
            btn : [ '确定', '取消' ]//按钮
        }, function(index) {
	        var checks = $("input[name='rowcheck']");
			for(var i = 0; i < checks.length; i ++){
				if(checks.eq(i).is(':checked')){
					$.ajax({
					url : "shopServlet", // 请求的url地址
					data : {
						"option" : "delCart",
						"cartID" : $("#cartID" + i).val()
					},
					cache : false,
					dataType : "json", // 返回格式为json
					async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
					type : "POST", // 请求方式
					success : function(req) {
						layer.msg(req.msg);
					}
				});
				}
			}
			setTimeout(function() {
				window.location.reload();
			}, 2000);
        }); 
		
	}
	
	//结算
	function goBuy(){
		var info_count = $("#info_count").val();
		var checks = $("input[name='rowcheck']");
		//是否有内容
		if(info_count <= 0){
			layer.msg("购物车空撩撩，去逛逛呗(●'◡'●)");
			return;
		}
		//总价
		$("#orderAllPrice").val($("#total").html());
		
		//弹出框
		if(checks.is(':checked')){
		layer.open({
			  type: 1,
			  area: ['430px', '460px'],
			  content: $('#buy')
			});
		}
	}
	//全选
	function allCheck(){
		var checks = $("input[name='rowcheck']");
		var total = 0;
		for(var i = 0; i < checks.length; i ++){
			if($("#allCheckked").is(':checked')){
				checks[i].checked = true;
				total += parseFloat($("#price" + (i + 1)).html());
			} else {
				checks[i].checked = false;
			}
			
		}
		$("#total").html(total.toFixed(2));
	}
	//单选
	function singleCheck(){
		var checks = $("input[name='rowcheck']");
		var total = 0;
		for(var i = 0; i < checks.length; i ++){
			if(checks.eq(i).is(':checked')){
				total += parseFloat($("#price" + (i + 1)).html());
				checks[i].checked = true;
			} else {
				checks[i].checked = false;
			}
			$("#total").html(total.toFixed(2));
		}
	}
	
	function subOrder(){
		var cartID = $("input[name='cartID']");
		var goodsID = $("input[name='goodsID']");
		var goodsName = $("input[name='goodsName']");
		var goodsPrice = $("input[name='goodsPrice']");
		var goodsNumber = $("input[name='goodsNumber']");
		var content = "[";
		for(var i = 0; i < cartID.length; i++){
			content += "{\"goodsId\":\"" + goodsID.eq(i).val() + "\",\"goodsName\" : \"" + goodsName.eq(i).val() + "\",\"goodsPrice\" : \"" + goodsPrice.eq(i).val() + "\", \"goodsNumber\" : \"" + goodsNumber.eq(i).val() + "\"}";
			if(i != cartID.length - 1){
				content += ",";
			}
		}
		content += "]";
		$("#goodsInfo").val(content);
		$.ajax({
			url : "shopServlet", // 请求的url地址
			data : $("#orderForm").serialize(),
			cache : false,
			dataType : "json", // 返回格式为json
			async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
			type : "POST", // 请求方式
			success : function(req) {
				layer.msg(req.msg);
				window.location.reload();
			}
		});
	}
</script>

<%@ include file="footer.jsp"%>

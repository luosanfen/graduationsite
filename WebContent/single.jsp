<!--头部内容-->
<%@ include file="head.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String goodsID = request.getParameter("goodsID");
	if (goodsID == null || "".equals(goodsID)) {
		response.sendRedirect("index.jsp");
		return;
	}

	List<Object> param = new ArrayList<Object>();
	String goods_sql = "select * from goodsinfo t where t.GOODSID=?";
	param.add(goodsID);
	//商品信息
	GoodsInfo goodsInfo = BaseDao.executeJDBCSQLQuery(goods_sql, param, GoodsInfo.class);
	
	String model_sql = "select * from goodsModel t where t.GOODSID=?";
	List<GoodsModel> model_list = BaseDao.executeJDBCSQLQuerys(model_sql, param, GoodsModel.class);
	if (goodsInfo == null) {
		%>
		<script type="text/javascript">
			alert("获取商品信息异常");
		</script>
		<%
	response.sendRedirect("index.jsp");
	}

	//商品图片信息
	String img_sql = "select * from goodsImg t where t.GOODSID=? order by t.file_sort";
	List<GoodsImg> img_list = BaseDao.executeJDBCSQLQuerys(img_sql, param, GoodsImg.class);
%>
<link rel="stylesheet" href="css/etalage.css">
<link href="common/layui/css/layui.css" rel='stylesheet' type='text/css' />
<script src="js/jquery.etalage.min.js"></script>
<script>
	$(function() {
		$('#etalage').etalage({
			thumb_image_width : 300,
			thumb_image_height : 400,
			source_image_width : 900,
			source_image_height : 1200,
			show_hint : true,
			click_callback : function(image_anchor, instance_id) {
				alert('Callback example:\你用锚点点击了一张图片: "' + image_anchor + '"\n(in Etalage instance: "' + instance_id + '")');
			}
		});
		$(document).ready(function() {
			$('#horizontalTab').easyResponsiveTabs({
				type : 'default',
				width : 'auto',
				fit : true
			});
		});
	});
</script>
<script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
<div class="column_center">
	<div class="container">
		<div class="search">
			<div class="stay">搜索你想要的商品</div>
			<form name="form" method="post" action="search.jsp">
			<div class="stay_right">
				<input name="schContent" type="text" value="">
				<input type="submit" value="搜  索">
			</div>
			</form>
			<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
	</div>
</div>
</div>
<div style="background: #eee; padding: 0rem;">
	<div class="content_top">
		<div class="container">
			<!--引入左侧栏内容 -->
			<%@ include file="left.jsp"%>

			<div class="col-md-9" style="margin-top:1rem;">
				<div class="single_top">
					<form id="cartForm">
					<input type="hidden" name="option" value="addCart">
					<input type="hidden" name="goodName" value="<%=goodsInfo.getGoodsName()%>">
					<input type="hidden" name="goodsID" value="<%=goodsID %>">
					<%
						if(model_list != null && model_list.size() > 0){
						%>
							<input type="hidden" name="goodPrice" id="goodsPrice" value="<%=model_list.get(0).getOrderPrice() %>">
						<%
						} else {
						%>
							<input type="hidden" name="goodPrice" id="goodsPrice" value="0">
						<%
						}
					 %>
					<div class="single_grid">
						<div class="grid images_3_of_2">
							<ul id="etalage">
								<%
									for (GoodsImg goodsImg : img_list) {
								%>
								<li><img class="etalage_thumb_image"
									src="<%=goodsImg.getFile_address()%>" class="img-responsive" />
									<img class="etalage_source_image"
									src="<%=goodsImg.getFile_address()%>" class="img-responsive"
									title="" /></li>
								<%
									}
								%>
							</ul>
							<div class="clearfix"></div>
						</div>
						<div class="desc1 span_3_of_2">
							<h1><%=goodsInfo.getGoodsName()%></h1>
							<%
								if(model_list != null && model_list.size() > 0){
							%>
							<p class="availability">
								<%
									if (model_list.get(0).getInventoryNum() > 0) {
								%>
									可用性: <span class="color">现在有货</span>
								<%
									} else {
								%>
									可用性: <span class="color">现在无货</span>
								<%
									}
								%>
							</p>
							<div class="price_single">
								<span class="actual" id="price"><%=model_list.get(0).getOrderPrice() %></span>
							</div>
							<%
								}
							 %>
							<h2 class="quick">快速概述:</h2>
							<p class="quick_desc"><%=goodsInfo.getGoodsText() %></p>
							<ul class="size">
								<h3>Length</h3>
								<%
									if(model_list != null && model_list.size() > 0){
										for(GoodsModel goodsModel : model_list){
											%>
												<li><a href="javascript:void(0)" onclick="changePrice(<%=goodsModel.getOrderPrice() %>)"><%=goodsModel.getModelName() %></a></li>
											<%
										}
									}
								 %>
							</ul>
							<div class="quantity_box">
								<ul class="product-qty">
									<span>数量:</span>
									<select name="goodNumber">
										<option>1</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
										<option>5</option>
										<option>6</option>
									</select>
								</ul>
								<div class="clearfix"></div>
							</div>
							<button type="button" onclick="doAddCart()" class="btn bt1 btn-primary btn-normal btn-inline " title="快戳我！(☆▽☆)">加入购物车</button>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="clearfix"></div>
					</form>
				</div>
				<div class="sap_tabs">
					<div id="horizontalTab"
						style="display: block; width: 100%; margin: 0px;">
						<ul class="resp-tabs-list">
							<li class="resp-tab-item" aria-controls="tab_item-0" role="tab"><span>商品简介</span></li>
							<div class="clear"></div>
						</ul>
						<div class="resp-tabs-container">
							<div class="tab-1 resp-tab-content" aria-labelledby="tab_item-0">
								<div class="facts">
									<ul class="tab_list">
										<li>
											<%=goodsInfo.getGoodsContent() %>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<h3 class="single_head">新品推荐</h3>
				<%
					String new_sql = "SELECT * FROM goodsinfo t where t.goodsIsNew=1 ORDER BY goodsID Desc";
					List<GoodsInfo> goods_list = BaseDao.executeJDBCSQLQuerys(new_sql, null, GoodsInfo.class);
					int j = 0;
					loop1:for(int i = 0; i < 2; i++){
				%>
				<div style="margin-top: 1em; margin-bottom: 1rem;">
				<%
					for(; j < goods_list.size(); j++){
						List<Object> param2 = new ArrayList<Object>();
						GoodsInfo goodsInfos = goods_list.get(j);//遍历商品
						param2.add(goodsInfos.getGoodsID());//添加商品ID
						//查询商品规格
						String model2_sql = "select * from goodsModel t where t.GOODSID=?";
						List<GoodsModel> model2_list = BaseDao.executeJDBCSQLQuerys(model2_sql, param2, GoodsModel.class);
						String price = model2_list.get(0).getOrderPrice() + "";//获取商品价格
						String small = price.substring(price.indexOf("."));
						price = price.substring(0, price.indexOf("."));
						//商品图片信息
						String img_sql2 = "select * from goodsImg t where t.GOODSID=?";
						List<GoodsImg> img_list2 = BaseDao.executeJDBCSQLQuerys(img_sql2, param2, GoodsImg.class);
			
				%>
					<div class="col-md-4 top_grid1-box1">
						<a href="single.jsp?goodsID=<%=goodsInfos.getGoodsID() %>">
							<div class="grid_1">
								<div class="b-link-stroke b-animate-go  thickbox">
								<img src="<%=img_list2.get(0).getFile_address() %>" class="img-responsive" alt=""
								   style="height: 16em !important; width: 15.7rem;" />
								</div>
								<div class="grid_2">
									<p style="height: 4rem;"><%=goodsInfos.getGoodsName() %></p>
									<ul class="grid_2-bottom">
										<li class="grid_2-left"><p>
												￥<%=price %><small><%=small %></small>
											</p></li>
										<li class="grid_2-right"><div
												class="btn btn-primary btn-normal btn-inline " target="_self"
												title="快戳我！(☆▽☆)">购买</div></li>
										<div class="clearfix"></div>
									</ul>
								</div>
							</div>
						</a>
					</div>
					<% 
							if(j == 2){
								%>
								<div class="clearfix"></div>
								<%
								break loop1;
							}
						}
					%>
					<div class="clearfix"></div>
					</div>
					<% 
						}
					%>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	function changePrice(price){
		$("#price").html(price);
		$("#goodsPrice").val(price);
	}
	
	function doAddCart(){
		$.ajax({
			url : "shopServlet", // 请求的url地址
			data : $("#cartForm").serialize(),
			cache : false,
			dataType : "json", // 返回格式为json
			async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
			type : "POST", // 请求方式
			success : function(req) {
				alert(req.msg);
				if(req.state == 2){
					setTimeout(function() {
						window.location.href = "index.jsp";
					}, 2000) 
				}
			}
		});
	}
</script>
<!--引入底部内容 -->
<%@ include file="footer.jsp"%>

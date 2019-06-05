<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--右侧栏内容-->
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao" %>
<div class="col-md-9 content_right">
	<h4 class="head">
		<span class="m_2">热卖</span> 
	</h4>
	<%
		String new_sql = "SELECT * FROM goodsinfo t where t.goodsIsNew=1";
		List<GoodsInfo> goods_list = BaseDao.executeJDBCSQLQuerys(new_sql, null, GoodsInfo.class);
	%>
	<div>
		<%
			for(int j = 0; j < goods_list.size(); j++){
			 	if(j == 6){
					break;
				} 
				List<Object> param2 = new ArrayList<Object>();
				GoodsInfo goodsInfo = goods_list.get(j);
				param2.add(goodsInfo.getGoodsID());
				String model2_sql = "select * from goodsModel t where t.GOODSID=?";
				List<GoodsModel> model2_list = BaseDao.executeJDBCSQLQuerys(model2_sql, param2, GoodsModel.class);
				String price = "0";
				String small = "0";
				if(model2_list != null && model2_list.size() > 0){
					price = model2_list.get(0).getOrderPrice() + "";
					small = price.substring(price.indexOf("."));
					price = price.substring(0, price.indexOf("."));
				}
				//商品图片信息
				String img_sql = "select * from goodsImg t where t.GOODSID=?";
				List<GoodsImg> img_list = BaseDao.executeJDBCSQLQuerys(img_sql, param2, GoodsImg.class);
		%>
				<div class="col-md-4 top_grid1-box1" style="margin-top:1rem;">
					<a href="single.jsp?goodsID=<%=goodsInfo.getGoodsID() %>">
						<div class="grid_1">
							<div class="b-link-stroke b-animate-go  thickbox">
								<img src="<%=img_list.get(0).getFile_address() %>" 
								class="img-responsive" alt="" style="height: 16em !important; width: 15.7rem;" />
							</div>
							<div class="grid_2">
								<p style="height: 4rem;"><%=goodsInfo.getGoodsName() %></p>
								<ul class="grid_2-bottom">
									<li class="grid_2-left">
									<p>￥<%=price %><small><%=small %></small></p>
									</li>
									<li class="grid_2-right">
									<div class="btn btn-primary btn-normal btn-inline "
									 target="_self" title="快戳我！(☆▽☆)">购买</div>
									 </li>
									<div class="clearfix"></div>
								</ul>
							</div>
						</div>
					</a>
				</div>
		 	<% 
	     	 }
	        %>
		<div class="clearfix"></div>
	</div>

	<h4 class="head">
		<span class="m_2">推荐</span>
	</h4>
	<%
		String vouch_sql = "SELECT * FROM goodsinfo t where t.goodsIsVouch=1 ORDER BY goodsID Desc";
		List<GoodsInfo> goods2_list = BaseDao.executeJDBCSQLQuerys(vouch_sql, null, GoodsInfo.class);
	%>
	<div>
		<%
			for(int l = 0; l < goods2_list.size(); l++){
				 if(l == 6){
					break;
				} 
				List<Object> param2 = new ArrayList<Object>();
				GoodsInfo goodsInfo = goods2_list.get(l);
				param2.add(goodsInfo.getGoodsID());
				String model2_sql = "select * from goodsModel t where t.GOODSID=?";
				List<GoodsModel> model2_list = BaseDao.executeJDBCSQLQuerys(model2_sql, param2, GoodsModel.class);
				String price = "0";
				String small = "0";
				if(model2_list != null && model2_list.size() > 0){
					price = model2_list.get(0).getOrderPrice() + "";
					small = price.substring(price.indexOf("."));
					price = price.substring(0, price.indexOf("."));
				}
				//商品图片信息
				String img_sql = "select * from goodsImg t where t.GOODSID=?";
				List<GoodsImg> img_list = BaseDao.executeJDBCSQLQuerys(img_sql, param2, GoodsImg.class);
		%>
				<div class="col-md-4 top_grid1-box1" style="margin-top:1rem;">
					<a href="single.jsp?goodsID=<%=goodsInfo.getGoodsID() %>">
						<div class="grid_1">
							<div class="b-link-stroke b-animate-go  thickbox">
								<img src="<%=img_list.get(0).getFile_address() %>" class="img-responsive" alt="" 
								 style="height: 16em !important; width: 15.7rem;"/>
							</div>
							<div class="grid_2">
								<p style="height: 50px;"><%=goodsInfo.getGoodsName() %></p>
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
		}
	%>
		<div class="clearfix"></div>
	</div>
	
</div>
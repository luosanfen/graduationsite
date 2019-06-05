<!--头部内容-->
<style>
.maxTitle {
	background: #dde6ea;;
	font-size: 2rem;
	font-weight: bold;
	padding: 0.5rem;
	margin-top: 1rem;
	color: #f1331e;
	text-align: center;
}
}
</style>
<%@ include file="head.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- <h1>新品上架</h1> -->
<div class="main">
	<div class="container">
		<div class="col-md-12">
			<%
				request.setCharacterEncoding("utf-8");// 处理中文
				String name = request.getParameter("schContent");
				String sql = "select * from goodsinfo where goodsName like '%" + name + "%'";
				List<GoodsInfo> goods_list = BaseDao.executeJDBCSQLQuerys(sql, null, GoodsInfo.class);
			%>
			<div>
				<h3>你想找的：<span style="color: red"><%=name%></span><h3>
			</div>
			<div class="top_grid2">
				<%
					for (int j = 0; j < goods_list.size(); j++) {
						List<Object> param2 = new ArrayList<Object>();
						//获取商品
						GoodsInfo goodsInfo = goods_list.get(j);
						param2.add(goodsInfo.getGoodsID());
						String model2_sql = "select * from goodsModel t where t.GOODSID=?";
						List<GoodsModel> model2_list = BaseDao.executeJDBCSQLQuerys(model2_sql, param2, GoodsModel.class);
						String price = model2_list.get(0).getOrderPrice() + "";
						String small = price.substring(price.indexOf("."));
						price = price.substring(0, price.indexOf("."));

						//商品图片信息
						String img_sql = "select * from goodsImg t where t.GOODSID=?";
						List<GoodsImg> img_list = BaseDao.executeJDBCSQLQuerys(img_sql, param2, GoodsImg.class);
				%>
				<div class="col-md-3 top_grid1-box1" style="margin-top: 1rem;">
					<a href="single.jsp?goodsID=<%=goodsInfo.getGoodsID()%>">
						<div class="grid_1">
							<div class="b-link-stroke b-animate-go  thickbox">
								<img src="<%=img_list.get(0).getFile_address()%>"
									class="img-responsive" alt=""
									style="height: 16em !important; width: 15.7rem;" />
							</div>
							<div class="grid_2">
								<p style="height: 4rem;"><%=goodsInfo.getGoodsName()%></p>
								<ul class="grid_2-bottom">
									<li class="grid_2-left"><p>
											￥<%=price%><small><%=small%></small>
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
				<%}%>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
</div>

</div>
<!-- cm-d-12 -->
</div>
</div>

<%@ include file="footer.jsp"%>


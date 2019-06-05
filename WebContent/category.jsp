<!--头部内容-->
<style>
   .maxTitle{
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
  <%
  		String categoryID = request.getParameter("categoryID");
  		String categoryName = request.getParameter("categoryName");
		if (categoryID == null || "".equals(categoryID)) {
			response.sendRedirect("index.jsp");
			return;
		}
		List<Object> params = new ArrayList<Object>();
		params.add(categoryID);
		String category_sql = "SELECT * FROM goodscatinfo t where t.categoryID=?";
		Category category = BaseDao.executeJDBCSQLQuery(category_sql, params, Category.class);
   %>
   <div class="row maxTitle"><%=category.getCategoryName() %></div>
   <div class="col-md-12">
	<%
		String goods_sql = "SELECT * FROM goodsinfo t where t.categoryID=?";
		List<GoodsInfo> goods_list = BaseDao.executeJDBCSQLQuerys(goods_sql, params, GoodsInfo.class);
		int j = 0;
		 loop1:for(int i = 0; i < 3; i++){ 
	%>
	<div class="top_grid2">
		<%
			for(; j < goods_list.size(); j++){
				List<Object> param2 = new ArrayList<Object>();
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
				<div class="col-md-3 top_grid1-box1">
					<a href="single.jsp?goodsID=<%=goodsInfo.getGoodsID() %>">
						<div class="grid_1">
							<div class="b-link-stroke b-animate-go  thickbox">
								<img src="<%=img_list.get(0).getFile_address() %>" class="img-responsive" alt="" 
								style="height: 16em !important; width: 15.7rem;"/>
							</div>
							<div class="grid_2">
								<p style="height: 4rem;"><%=goodsInfo.getGoodsName() %></p>
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

		 if(i == 3){continue loop1; }
		  }
		%>
		<div class="clearfix"></div>
	</div>
	 <% }%> 
	
	</div><!-- cm-d-12 -->
	</div>
	 <div class="row"><img alt="" src="images/bottomImg.jpg" style="width:100%"> </div>
</div>

 <%@ include file="footer.jsp"%>


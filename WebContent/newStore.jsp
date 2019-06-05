<!--头部内容-->
<style>
   .maxTitle{
    background: #d3d9dc;;
    font-size: 2rem;
    font-weight: bold;
    padding: 0.5rem;
    margin-top: 1rem;
    color: #f1331e;
    }
}

</style>
<%@ include file="head.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- <h1>新品上架</h1> -->
<div class="main">
  <div class="container">
  <div class="row"><img alt="" src="images/banner01.jpg" style="width:100%"> </div>
  <div class="col-md-12">
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
  <!--  <div class="row maxTitle">新上排行</div> -->
   <div class="col-md-12">
	<%
		String new_sql = "SELECT * FROM goodsinfo t where t.goodsIsNew=1";
		List<GoodsInfo> goods_list = BaseDao.executeJDBCSQLQuerys(new_sql, null, GoodsInfo.class);
	%>
	<div class="top_grid2">
		<%
			for(int j = 0; j < goods_list.size(); j++){
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
				<div class="col-md-3 top_grid1-box1" style="margin-top:1rem;">
					<a href="single.jsp?goodsID=<%=goodsInfo.getGoodsID() %>">
						<div class="grid_1">
							<div class="b-link-stroke b-animate-go  thickbox">
								<img src="<%=img_list.get(0).getFile_address() %>" class="img-responsive" alt=""
								 style="height: 16em !important; width: 15.7rem;" />
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
	      	}
	       %>
		<div class="clearfix"></div>
	  </div>
	  </div>
	</div>
</div>

<%@ include file="footer.jsp"%>
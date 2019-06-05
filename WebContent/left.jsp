<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao" %>
<!--左侧栏内容 -->
<%
	String parentcat_sql = "SELECT t.parentCatID,t.parentCatName FROM parentcatinfo t";
	List<ParentCat> parentCat_list = BaseDao.executeJDBCSQLQuerys(parentcat_sql, null, ParentCat.class);
 %>
<div class="col-md-3 sidebar_box">
	<div class="sidebar">
		<div class="menu_box">
			<h3 class="menu_head">商品分类</h3>
			<ul class="menu">
				<%
					for(int i = 0; i<parentCat_list.size(); i++){
						ParentCat parentCat = parentCat_list.get(i);
						%>
						<li class="item<%=(i+1)%>"><a href="#"><img class="arrow-img"
								src="images/f_menu.png" alt="" /><%=parentCat.getParentCatName() %></a>
							<ul class="cute">
								<%
									List<Object> params = new ArrayList<Object>();
									String category_sql = "SELECT t.categoryID,t.categoryName FROM goodscatinfo t where t.parentCatID=?";
									params.add(parentCat.getParentCatID());
									List<Category> category_list = BaseDao.executeJDBCSQLQuerys(category_sql, params, Category.class);
									for(int j = 0; j < category_list.size(); j++){
										Category category = category_list.get(j);
										%>
											<li class="subitem1"><a target="_blank" href="category.jsp?categoryID=<%=category.getCategoryID() %>"><%=category.getCategoryName() %> </a></li>
										<%
									}
								 %>
							</ul>
						</li>
						<%
					}
				 %>
			</ul>
		</div>
		<!--initiate accordion-->
		<script type="text/javascript">
$(function() {
    var menu_ul = $('.menu > li > ul'),
           menu_a  = $('.menu > li > a');
    menu_ul.hide();
    menu_a.click(function(e) {
        e.preventDefault();
        if(!$(this).hasClass('active')) {
            menu_a.removeClass('active');
            menu_ul.filter(':visible').slideUp('normal');
            $(this).addClass('active').next().stop(true,true).slideDown('normal');
        } else {
            $(this).removeClass('active');
            $(this).next().stop(true,true).slideUp('normal');
        }
    });

});
</script>
	</div>
	<!--截至 商品分类 -->

	<!--<div class="tlinks">收藏这个网站<a href="http://www.cssmoban.com/" >这是一个申请</a></div>-->
	<!-- <div class="delivery">
		<img src="images/delivery.jpg" class="img-responsive" alt="" />
		<h3>世界很大</h3>
		<h4>我想出去看看</h4>
	</div> -->
	<div class="twitter">
		<h3>时尚时尚最时尚</h3>
		<ul class="twt1">
			<li class="twt1_desc"><span class="m_1">@Contrary</span>受欢迎的网站<span
				class="m_1">不简单</span></li>
			<div class="clearfix"></div>
		</ul>
		<ul class="twt1">
			<li class="twt1_desc"><span class="m_1">这里有许多</span> 你们觉得呢<span
				class="m_1">有更欢迎</span></li>
			<div class="clearfix"></div>
		</ul>
		<ul class="twt1">
			<!-- <i class="twt"> </i> -->
			<li class="twt1_desc"><span class="m_1">Hello</span> 任你挑选 <span
				class="m_1">共有超过ndard dummy text ever</span></li>
			<div class="clearfix"></div>
		</ul>
	</div>
	<div class="clients">
		<h3>我们欢迎每一个到访的游客</h3>
		<h4>穿出不一样的味道</h4>
		<ul class="user">
			<i class="user_icon"></i>
			<li class="user_desc"><a href="#"><p>遇见你，很幸运，都是缘分</p></a></li>
			<div class="clearfix"></div>
		</ul>
	</div>
</div>

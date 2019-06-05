<!--头部内容-->
<style>
  .storecolor{
    padding: 4em 0;
    background: #fbf5f5;
   }
  .storeContent{
     border: 1px solid #ccc3c3; 
     padding: 1.5rem;
     margin-bottom: 2rem;
     text-align: center;
     font-size: 14px;
     background: #f7f3f3;
    }
</style>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="head.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.shop.entity.*,com.shop.dao.BaseDao"%>
<!-- <h1>商城资讯</h1> -->
<div class="column_center"></div>
<div class="storecolor">
	<div class="container">
		<%
			String page_str = request.getParameter("page");
			int thisPage = 1;
			if(page_str != null && !"".equals(page_str)){
				try{
					thisPage = Integer.parseInt(page_str);
				} catch(Exception e){
					return ;
				}
			}
			String count_sql = "SELECT count(*) count FROM bulletininfo t where t.isValid='1'";
			List<HashMap<String, String>> count_list = BaseDao.executeJDBCSQLQuery(count_sql);
			Integer count = 0;
			if(count_list != null){
				count = Integer.valueOf(String.valueOf(count_list.get(0).get("count")));
			} else {
				return ;
			}
			
			int pageRow = 2;//定义一页两条数据
			int pageNum = (count / pageRow) + 1; //定义页数
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			int start = (thisPage-1) * pageRow;//开始页码
			//获取数据
			String bulletin_sql = "SELECT t.*,a.managerName FROM bulletininfo t left join managerinfo a on t.managerID = a.managerID where t.isValid='1' order by t.bulletinSort limit " + start + "," + pageRow;
			List<Bulletin> bulletin_list = BaseDao.executeJDBCSQLQuerys(bulletin_sql, null, Bulletin.class);
			for (Bulletin bulletin : bulletin_list) {
		%>
			<div class="storeContent">
				<div>
					<h4><%=bulletin.getBulletinTitle() %></h4>
				</div>
				<div style="color: #8a7f7fe8;">
					<span style="margin-right:1.5rem">发布者:<%=bulletin.getManagerName() %></span>
					<span style="margin-right:1.5rem">发布时间：<%=sdf.format(bulletin.getBulletinInputDate()) %></span>
					<span>最后更新时间：<%=(bulletin.getBulletinUpdateDate()==null)? "已是最新":sdf.format(bulletin.getBulletinUpdateDate()) %></span>
				</div>
				<div style="text-align:left; font-size: 16px;margin-top: 1rem;">
					&ensp; &ensp; &ensp;<span><%=bulletin.getBulletincontent() %></span>
				</div>
			</div>
		<%
			}
		%>
		<div style="text-align:center;">
			<ul class="pagination pagination-lg">
				<%
					int i = 0;
					if(thisPage - 3 > 0){
						i = thisPage - 3;
					}
				//最末尾数判断，
					if(thisPage + 3 > pageNum){
						i = thisPage - (thisPage-1);
					}
					//上一页
					if(thisPage != 1){
						%>
							<li><a href="storeInfo.jsp?page=<%=thisPage-1 %>">&laquo;</a></li>
						<%
					}
					//显示界面的页数号
					int bun_count = 0;//定义一个只能显示5个页号
					//int i = 0;
					for(; bun_count < 5 && i < pageNum; i++){
						bun_count++;
						%>
							<li><a href="storeInfo.jsp?page=<%=i+1 %>" <%if(i+1 == thisPage){%>style="background-color: #fadfe8"<%} %>><%=i+1 %></a></li>
						<%
					}
					//下一页
					if(thisPage != pageNum){
						%>
							<li><a href="storeInfo.jsp?page=<%=thisPage+1 %>">&raquo;</a></li>
						<%
					}
				 %>
			</ul>
		</div>

	</div>
</div>

<%@ include file="footer.jsp"%>





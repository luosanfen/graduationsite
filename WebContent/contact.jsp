<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="head.jsp"%>
<% Object msg = request.getAttribute("result"); %>	
<div class="about">
	<div class="container">
		<div class="singel_right">
		   <%if(msg != null){ %>	
			<div class="col-md-8"><h3 style="color:red; margin:1rem;"><%=msg.toString() %></h3></div>
			<%} %>
			<%if(session.getAttribute("userName") == null){
				response.sendRedirect("login.jsp");
			}%>
			<div class="col-md-8">
				<div class="contact-form">
					<form name="form" method="post" action="ContactServlet" onsubmit="return reg(this);">
						<p class="comment-form-author">
							<label for="email">邮箱:</label>
							 <input type="text" name="userEmail" class="textbox" >
						</p>
						<p class="comment-form-author">
							<label for="title">关键字:(如建议，表扬等词)</label> 
							<input type="text" name="userTitle" class="textbox" >
						</p>
						<p class="comment-form-author">
							<label for="content">内容:</label>
							<textarea name="userContent" ></textarea>
						</p>
						<input name="submit" type="submit" id="submit" value="提交">
					</form>
				</div>
			</div>
			<div class="col-md-4 contact_right">
				<h3>商店地址</h3>
				<div class="address">
					<i class="pin_icon"></i>
					<div class="contact_address">
						你好，你是一个好人，你真是一个大大好人，能不能一起去锻炼，走逛实体店去！</div>
					<div class="clearfix"></div>
				</div>
				<div class="address">
					<i class="phone"></i>
					<div class="contact_address">132-6384-8207</div>
					<div class="clearfix"></div>
				</div>
				<div class="address">
					<i class="mail"></i>
					<div class="contact_email">
						<a href="#">2423096678@qq.com</a>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div><!--col-md-12  -->
</div>
</div>

<%@ include file="footer.jsp"%>
<script type="text/javascript">
function reg(form){
	//判断输入的电子邮箱是否正确
    var reg = /^[a-z0-9]\w+@[a-z0-9]{2,3}(\.[a-z]{2,3}){1,2}$/i;
    var email = form.userEmail.value;
	if(email == ""){
		alert("电子邮箱不能为空！");
		return false;
	} else if(!reg.test(email)){
		alert("请正确输入电子邮箱!");
		return false;
	}
	if(form.userTitle.value == ""){
		alert("关键字不能为空！");
		return false;
	}
	if(form.userContent.value == ""){
		alert("内容不能为空！");
		return false;
	}
	return true;
}
</script>



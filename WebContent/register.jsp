
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.shop.entity.User"%>
<style>
 .regSubmit{
    display: inline-block;
    padding: 13px 25px;
    background: #df1f26;
    color: #FFF;
    font-size: 1em;
    line-height: 18px;
    text-transform: uppercase;
    border: none;
    outline: none;
    }
  .pwd{
    border: 1px solid #9e8f8f;
    outline-color: #fb4d01;
    width: 96%;
    font-size: 0.8125em;
    padding: 10px;
   }
</style>
<!--头部内容-->
<%@ include file="head.jsp"%>
<%
	User user = (User) request.getAttribute("user");
	Object msg = request.getAttribute("result");
%>
<div class="about">
	<div class="container">
		<div class="register">
			<form name="form" method="post" action="user"
				onsubmit="return reg(this);">
				<input type="hidden" name="option" value="register">
				<%
					if (msg != null) {
				%>
				<div class="register-top-grid" style="text-align:center">
					<h3><%=msg.toString()%></h3>
				</div>
				<%
					}
				%>
				<div class="register-top-grid">
					<h3>个人信息</h3>
					<div>
						<span>用户名<label style="color: red; padding-left: 0.3em;">*</label></span>
						<input type="text" name="UserName" id="UserName"
							value="<%=(user == null) ? "" : user.getUserName()%>">
					</div>
					<div>
						<span>真实姓名<label style="color: red; padding-left: 0.3em;">*</label></span>
						<input type="text" name="UserRealName" id="UserRealName"
							value="<%=(user == null) ? "" : user.getUserRealName()%>">
					</div>
					<div>
						<span>邮箱地址<label style="color: red; padding-left: 0.3em;">*</label></span>
						<input type="text" name="UserEmail" id="UserEmail"
							value="<%=(user == null) ? "" : user.getUserEmail()%>">
					</div>
					<div>
						<span>联系电话<label style="color: red; padding-left: 0.3em;">*</label></span>
						<input type="text" name="UserPhone" id="UserPhone"
							value="<%=(user == null) ? "" : user.getUserPhone()%>">
					</div>
					<div>
						<span>通讯地址<label style="color: red; padding-left: 0.3em;">*</label></span>
						<input type="text" name="UserAddress" id="UserAddress"
							value="<%=(user == null) ? "" : user.getUserAddress()%>">
					</div>
					<div>
						<span>性别<label>*</label></span> 
						<select style="width: 8rem; height: 2.3rem;" name="UserSex">
							<%
								if (user == null) {
							%>
								<option value="0">女</option>
								<option selected value="1">男</option>
							<%
								} else {
							%>
								<option <%if(user.getUserSex() == 1){ %> selected <%}%> value="1">男</option>
								<option <%if(user.getUserSex() == 0){ %> selected <%}%> value="0">女</option>
							<%
								}
							%>
						</select>
					</div>
					<div class="clearfix"></div>
					<a class="news-letter" href="#"> </a>
				</div>
				<div class="register-bottom-grid">
					<h3>登陆信息</h3>
					<div>
						<span>密码<label style="color: red; padding-left: 0.3em;">*</label></span>
						<input type="password" name="UserPwd" id="UserPwd" class="pwd">
					</div>
					<div>
						<span>确认密码<label style="color: red; padding-left: 0.3em;">*</label></span>
						<input type="password" name="UserRepwd" id="UserRepwd" class="pwd">
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
				<div class="register-but">
					<input type="submit" value="提交" class="regSubmit">
					<div class="clearfix"></div>
			</form>
		</div>
	</div>
</div>
</div>
<script type="text/javascript">
function reg(form){
//判断用户名是否为空
	var name = form.UserName.value;
	//var rg = /^[a-zA-Z][a-zA-Z0-9]{4,9}$/;
	  //检测输入内容是否匹配正则表达式
	if( name == ""){
		alert("用户不能为空！");
		return false;
 	}
	// if(!rg.test(name)){
	//	alert("用户名必须是5-10位数字或字母组成，开头不能是数字");
	//   return false;
	// } 
//真实姓名不能为空
	if( form.UserRealName.value == ""){
		alert("真实姓名不能为空！");
		return false;
	}

//判断输入的电子邮箱是否正确
    var reg = /^[a-z0-9]\w+@[a-z0-9]{2,3}(\.[a-z]{2,3}){1,2}$/i;
    var email = form.UserEmail.value;
	if(email == ""){
		alert("电子邮箱不能为空！");
		return false;
	}
	if(!reg.test(email)){
		alert("请正确输入电子邮箱!");
		return false;
	}
	
//判断手机号是否正确
   var tel = form.UserPhone.value;
   var hp = /^1[34578]\d{9}$/;;
	if(tel == ""){
		alert("联系电话不能为空！");
		return false;
	}
	if(!hp.test(tel)){
		alert("输入的联系电话不合法！");
		return false;
	}
	
//判断通讯地址是否为空
	if(form.UserAddress.value == ""){
		alert("通讯地址不能为空！");
		return false;
	}
	
//判断密码是否正确
    var UserPwd = form.UserPwd.value;
    var pwd = /^\S{6,}$/;
	if(UserPwd == ""){
		alert("密码不能为空！");
		return false;
	}
	if(pwd.test(UserPwd) == false){
		alert("密码必须是6位或6位以上！");
		return false;
	}
	if(form.UserRepwd.value == ""){
		alert("确认密码不能为空！");
		return false;
	}
	if(form.UserPwd.value != form.UserRepwd.value){
		alert("两次密码输入不一致！");
		return false;
	}
	return true;
}
</script>
<%@ include file="footer.jsp"%>



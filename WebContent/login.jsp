<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--头部内容-->
<style>
 .resett{
    display: inline-block;
    padding: 13px 25px;
    background: #676d77;
    color: #FFF;
    font-size: 1em;
    line-height: 18px;
    text-transform: uppercase;
    border: none;
    outline: none;
 }
</style>
<%@ include file="head.jsp"%>

<%
	Object msg = request.getAttribute("result");
%>

<div class="column_center">
	<div class="container">
		<!-- <div class="search">
			<div class="stay">搜索你想要的商品</div>
			<div class="stay_right">
				<input type="text" value="" onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = '';}"> <input
					type="submit" value="">
			</div>
			<div class="clearfix"></div>
		</div> -->
		<div class="clearfix"></div>
	</div>
</div>
<div class="about">
	<div class="container">
		<div class="register">
			<div class="col-md-6 login-left">
				<h3>新用户</h3>
				<p>通过创建一个帐户与我们的商店，您将能够通过结帐过程更快，存储多个送货地址，，查看和跟踪您的订单在您的帐户和更多浏览我们的商品，符合您满意的服装，更称您的心意。</p>
				<a class="acount-btn" href="register.jsp">创建账号</a>
			</div>
			<div class="col-md-6 login-right">
				<h3>注册用户</h3>
				<p>如果您在我们这里有账户，请登录。</p>
				<!-- 判断是否为空 -->
				<%
					if (msg != null) {
				%>
				<h3>
					提示：<%=msg.toString()%></h3>
				<%
					}
				%>
				<!--提交的Form  -->
				<form id="loginform" name="loginform" method="post" action="user">
					<input type="hidden" name="option" value="login">
					<div>
						<span>用户名<label style="color: red; padding-left: 0.3em;">*</label></span>
						<input type="text" name="txtUserName" id="userName">
					</div>
					<div>
						<span>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码 <label
							style="color: red; padding-left: 0.3em;">*</label></span> <input
							type="password" class="psd" name="txtUserPwd" id="userPwd">
					</div>
					<a class="forgot" href="#">忘记密码?</a> 
					<input type="button" class="submit" value="登录" onclick="doLogin()" name="loginSubmit">
					<input class="resett" type="reset" value="重置" name="loginReset">
				</form>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function doLogin() {
		var userName = $("#userName").val();
		var userPwd = $("#userPwd").val();
		if (userName == "") {
			alert("请输入用户名");
			return;
		}
		if (userPwd == "") {
			alert("请输入密码");
			return;
		}
		$("#loginform").submit();
	}
</script>
<%@ include file="footer.jsp"%>

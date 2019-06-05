<!--头部内容-->
<%@ include file="head.jsp"%>
<link href="common/layui/css/layui.css" rel='stylesheet' type='text/css' />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.form-control {
	width: 45% !important;
}
</style>
<%
	Integer userID = (Integer) session.getAttribute("userID");
	if (userID == null || "".equals(userID)) {
		response.sendRedirect("login.jsp");
		return;
	}
	List<Object> params = new ArrayList<Object>();
	String user_sql = "select * from userinfo where userID=?";
	params.add(userID);
	User user = BaseDao.executeJDBCSQLQuery(user_sql, params, User.class);
 %>
<div class="about">
	<div class="container">
		<div class="col-md-8">
			<form class="form-horizontal" id="userFrom">
				<input type="hidden" name="option" value="modifyUser">
				<div class="form-group">
					<label for="userRealName" class="col-sm-4 control-label">真实姓名：</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="UserRealName" value="<%=user.getUserRealName() %>">
					</div>
				</div>
				<div class="form-group">
					<label for="userPhone" class="col-sm-4 control-label">联系方式：</label>
					<div class="col-sm-8">
						<input type="tel" class="form-control" name="UserPhone" value="<%=user.getUserPhone() %>">
					</div>
				</div>
				<div class="form-group">
					<label for="userEmail" class="col-sm-4 control-label">电子邮箱：</label>
					<div class="col-sm-8">
						<input type="tel" class="form-control" name="UserEmail" value="<%=user.getUserEmail() %>">
					</div>
				</div>
				<div class="form-group">
					<label for="userAddress" class="col-sm-4 control-label">联系地址：</label>
					<div class="col-sm-8">
						<textarea rows="2" cols="2" type="tel" class="form-control"
							name="UserAddress"><%=user.getUserAddress() %></textarea>
					</div>
				</div>
				<div class="form-group">
					<label for="userSex" class="col-sm-4 control-label">性别：</label>
					<div class="col-sm-8" style="margin-top:0.5rem;">
						<%
							if(user.getUserSex() == 1){
							 %>
							 	<label><input name="userSex" type="radio" value="1" checked/>男 </label> 
								<label style="margin-left:1rem;">
								<input name="UserSex" type="radio" value="0" />女 </label>
							 <%
							} else {
							 %>
							 	<label><input name="userSex" type="radio" value="1" />男 </label> 
								<label style="margin-left:1rem;">
								<input name="UserSex" type="radio" value="0" checked/>女 </label>
							 <%
							}
						 %>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-3 col-sm-9"></div>
				</div>

				<div class="form-group"></div>
				<div class="form-group">
					<div class="col-sm-offset-3 col-sm-9">
						<input type="button" class="btn btn-danger" value="修改密码"
							onclick="goModify()"
							style="width: 8rem; color: white; font-size:16px; margin-right:1rem; height: 3rem;">
						<button type="button" class="btn btn-info" style="width: 8rem;font-size:16px; height: 3rem;" onclick="modify_user()">确认修改</button>
					</div>
				</div>
			</form>
		</div>
		 <div class="col-md-3" style="font-size:1rem;">
            <p>温习提示：</p>
            <p style="color:red;margin: 2rem">修改信息，请认真操作。</p>
            <p style="color:red;margin: 2rem;">如非本人操作,请谨慎！</p>
      </div>
	</div>
</div>

<!--弹框修改密码页  -->
<div id="updatePwd" style="display: none;">
	<br />
	<form class="layui-form" id="pwdForm">
		<input type="hidden" name="option" value="pwdModify"/>
		<div class="layui-form-item">
			<label class="layui-form-label">原密码</label>
			<div class="layui-input-block">
				<input type="text" name="originalPassword" id="originalPassword" required
					lay-verify="required" placeholder="请输入原密码" autocomplete="off"
					class="layui-input" style="width: 300px;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">新密码</label>
			<div class="layui-input-block">
				<input type="password" name="newPassword" id="newPwd1" required lay-verify="required"
					placeholder="请输入新密码" autocomplete="off" class="layui-input"
					style="width: 300px;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">确认密码</label>
			<div class="layui-input-block">
				<input type="password" name="confirmPassword" id="newPwd2" required
					lay-verify="required" placeholder="请输入确认密码" autocomplete="off"
					class="layui-input" style="width: 300px;">
			</div>
		</div>
		<div class="layui-form-item"></div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button type="button" class="layui-btn" onclick="modify_pwd()">立即修改</button>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
	function goModify() {
		layer.open({
			type : 1,
			area : [ '430px', '290px' ],
			content : $('#updatePwd')
		});
	}
	
	function modify_user(){
		$.ajax({
			url : "user", // 请求的url地址
			data : $("#userFrom").serialize(),
			cache : false,
			dataType : "json", // 返回格式为json
			async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
			type : "POST", // 请求方式
			success : function(req) {
				layer.msg(req.msg);
			}
		});
	}
	
	function modify_pwd(){
		var originalPassword = $.trim($("#originalPassword").val());
		if(originalPassword == ""){
			layer.msg("原密码不能为空！（。＾▽＾）");
			return ;
		}
		var newPwd1 = $.trim($("#newPwd1").val());
		if(newPwd1 == ""){
			layer.msg("新密码不能为空！(ง •_•)ง");
			return ;
		}
		var newPwd2 = $.trim($("#newPwd2").val());
		if(newPwd2 == ""){
			layer.msg("确认密码不能为空！(。・∀・)ノ");
			return ;
		}
		if(newPwd1 != newPwd2){
			layer.msg("新密码与确认密码不一致！(￣▽￣)");
			return;
		}
		$.ajax({
			url : "user", // 请求的url地址
			data : $("#pwdForm").serialize(),
			cache : false,
			dataType : "json", // 返回格式为json
			async : false,// 请求是否异步，默认为异步，这也是ajax重要特性
			type : "POST", // 请求方式
			success : function(req) {
				layer.msg(req.msg);
				if(req.state == 0){
					layer.msg(req.msg + ",请重新登录");
					setTimeout(function() {
						window.location.href = "loginout.jsp";
					}, 2000);
				}
			}
		});
	}
</script>

<%@ include file="footer.jsp"%>





<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>管理后台登录</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="description" content="This is my page">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <link rel="stylesheet" type="text/css" href="../common/bootstrap/css/bootstrap.css" media="all">

    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../common/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../common/layui/layui.js"></script>
    <link rel="stylesheet" type="text/css" href="../common/layui/css/layui.css" media="all">
    <style type="text/css">
        body{
            width: 100%;
            height: 100%;
            font-family: SimHei;
            background-image: url(../images/login_bg.jpg);
            overflow: hidden;
            position:absolute;top:0px;left:0px;right:0px;bottom:0px;padding:0;margin: 0;
        }
        .frosted-glass{
            z-index: 50;
            width: 100%;
            height: 100%;
            background: inherit;
            -webkit-filter: blur(5px);
            -moz-filter: blur(5px);
            -ms-filter: blur(5px);
            -o-filter: blur(5px);
            filter: blur(5px);
            filter: progid:DXImageTransform.Microsoft.Blur(PixelRadius=4, MakeShadow=false);
        }
        .login{
            z-index: 100;
            width: 375px;
            height: 375px;
            margin: auto;
            display: flex;
            align-items: center;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            border-radius:10px;
            background-color: #ffffff;
        }

        #login_form{
            width: 230px;
            height: 300px;
            margin: auto;
        }
    </style>
</head>
<body>
<div class="frosted-glass">

</div>
<input id="userID" type="hidden" value="<%=session.getAttribute("manageUserID") %>"/>
<div class="login">
    <form id="login_form" >
        <table>
            <tr style="font-size: 34px;height: 80px">
                <td><strong>登录</strong></td>
            </tr>
            <tr>
                <td>
                    <input name="name" type="text" class="form-control" placeholder="用户名" aria-describedby="sizing-addon1" style="width: 230px;">
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <input name="password" type="password" class="form-control" placeholder="密码" aria-describedby="sizing-addon1" style="width: 230px;">
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <label><input id="remaber" type="checkbox" />记住我</label>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <button type="button" class="btn btn-success" onclick="login()">登录</button>
                </td>
            </tr>
        </table>
    </form>
</div>

</body>
<script type="text/javascript">
	var layer;
	$(function () {
	    var userID = $("#userID").val();
	    if (userID != "" && userID != "null") {//判断ID是否为空
	        window.top.location.href = "home.jsp";//跳转到后台首页
	    }
	   
	    //键盘操作，回车键进行确认
	    $(document).keydown(function (event) {
	        if (event.keyCode == 13 && $(".messager-window").length == 0) {
	            login(); //登录
	        }
	    });
	  //存管理员用户名
	    var username = getCookie("username");
	    if(username && "" != username){
	        $('input[name="name"]').val(username);
	        $("#remaber").attr("checked","checked");//记住密码操作
	        $('input[name="password"]').focus();
	    } else {
	        $('input[name="name"]').focus();
	    }
		layui.use([ 'layer' ], function() {
			layer = layui.layer;
		});
	});

	//登录判断
function login() {
    var name = $('input[name="name"]').val();
    var password = $('input[name="password"]').val();
    if (name == "" || !name) {
   		layer.msg("用户名不能为空");
        return;
    }
    if (password == "" || !password) {
    	layer.msg("密码不能为空");
        return;
    }

    $.ajax({
        type: "POST",
        dataType: "json",
        url: "../user",
        data: {
        	"option" : "manege_login",
            "name": name,
            "password": password
        },
        success: function (data) {
            if (data.state == "1") {
                if($("#remaber").is(':checked')){
                    setCookie("username", name, 7);//Cookie有效7天
                } else {
                    setCookie("username", "", 7);//Cookie有效7天
                }
                window.top.location.href = "home.jsp";
            } else {
            	layer.msg(data.msg);
            }
        }
    });
}

//存取cookie，在客户端缓存，session在服务端缓存
function getCookie(c_name) {
    var c_start;
    var c_end;
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(c_name + "=");
        if (c_start != -1) {
            c_start = c_start + c_name.length + 1;
            c_end = document.cookie.indexOf(";", c_start);
            if (c_end == -1) c_end = document.cookie.length;
            return unescape(document.cookie.substring(c_start, c_end))
        }
    }
    return ""
}

function setCookie(c_name, value, expiredays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + expiredays);
    document.cookie = c_name + "=" + escape(value) +
        ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString())
}
</script>
</html>
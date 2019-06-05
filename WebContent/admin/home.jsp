<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
	<head>
		<meta charset="UTF-8">
	<title>后台商城管理中心</title>
	<meta name="renderer" content="webkit">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
	<meta name="viewport" content="width=device-width, initial-scale=1">	
	<meta name="apple-mobile-web-app-status-bar-style" content="black">	
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="format-detection" content="telephone=no">	
	<!-- load css -->
	<link rel="stylesheet" type="text/css" href="../common/layui/css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="../common/global.css" media="all">
	<link rel="stylesheet" type="text/css" href="../css/adminstyle.css" media="all">
	<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
	
	</head>
	<body>
	<!--存管理员ID //隐藏 -->
	<input id="userID" type="hidden" value="<%=session.getAttribute("manageUserID") == null ? "" : session.getAttribute("manageUserID") %>"/>
	<div class="layui-layout layui-layout-admin" id="layui_layout">
	<!-- 顶部区域 -->
	<div class="layui-header header header-demo">
		<div class="layui-main">
		    <!-- logo区域 -->
			<div class="admin-logo-box">
				<b class="logo">后台商城管理</b>
				<div class="larry-side-menu">
					<i class="fa fa-bars" aria-hidden="true"></i>
				</div>
			</div>
            <!-- 右侧导航 -->
            <ul class="layui-nav larry-header-item">
            		<li class="layui-nav-item">
            			账户名：<%=session.getAttribute("manageName") %>
            		</li>
					<li class="layui-nav-item" onclick="logout()">
						<a href="javascript:void(0)">
                        <i class="iconfont icon-exit"></i>
						退出</a>
					</li>
            </ul>
		</div>
	</div>
	
	<!-- 左侧侧边导航开始 -->
	<div class="layui-side layui-side-bg layui-larry-side" id="larry-side">
        <div class="layui-side-scroll" id="larry-nav-side" lay-filter="side">
		
		<!-- 左侧菜单 -->
		<ul class="layui-nav layui-nav-tree">
			<li class="layui-nav-item layui-this">
				<a href="javascript:;" data-url="main.jsp">
				    <i class="iconfont icon-home1" data-icon='icon-home1'></i>
					<span>首页</span>
				</a>
			</li>
			<!-- 产品管理 -->
			<li class="layui-nav-item">
				<a href="javascript:;">
				   <i class="iconfont icon-jiaoseguanli2" ></i>
				   <span>商品管理</span>
				   <em class="layui-nav-more"></em>
				</a>
				    <dl class="layui-nav-child">
				    	<dd>
				    		<a href="javascript:;" data-url="GoodsInfo.jsp">
				    		   <i class="iconfont icon-yonghu1" data-icon='icon-yonghu1'></i>
				    		   <span>产品管理</span>
				    		</a>
				    	</dd>
				    	<dd>
				    		<a href="javascript:;"  data-url="ParentCatInfo.jsp">
				    		   <i class="iconfont icon-jiaoseguanli4" data-icon='icon-jiaoseguanli4'></i>
				    		   <span>一级分类管理</span>
				    		</a>
				    	</dd>
				    	<dd>
				    		<a href="javascript:;" data-url="GoodsCatInfo.jsp">
				    		   <i class="iconfont icon-quanxian2" data-icon='icon-quanxian2'></i>
				    		   <span>二级分类管理</span>
				    		</a>
				    	</dd>
				    </dl>
			    </li>
			<!-- 订单管理 -->
			<li class="layui-nav-item">
					<a href="javascript:;">
					   <i class="iconfont icon-wenzhang1" ></i>
					   <span>订单管理</span>
					   <em class="layui-nav-more"></em>
					</a>
					   <dl class="layui-nav-child">
					   	   <dd>
					    		<a href="javascript:;" data-url="orderList.jsp">
					    		   <i class="iconfont icon-lanmuguanli" data-icon='icon-lanmuguanli'></i>
					    		   <span>订单列表</span>
					    		</a>
					    	</dd>
					   </dl>
			   </li>
			<li class="layui-nav-item">
					<a href="javascript:;">
					   <i class="iconfont icon-xitong" ></i>
					   <span>商城维护</span>
					   <em class="layui-nav-more"></em>
					</a>
					   <dl class="layui-nav-child">
                           <dd>
                           	   <a href="javascript:;" data-url="bulletInfo.jsp">
					              <i class="iconfont icon-zhuti"  data-icon='icon-zhuti'></i>
					              <span>资讯公告</span>
					           </a>
                           </dd>
                           <dd>
					    		<a href="javascript:;" data-url="contact.jsp">
					    		   <i class="iconfont icon-database" data-icon='icon-database'></i>
					    		   <span>联系留言</span>
					    		</a>
					    	</dd>
					   </dl>
				</li>
		    <!-- 管理员信息 -->
			<li class="layui-nav-item">
				<a href="javascript:;">
					<i class="iconfont icon-jiaoseguanli" ></i>
					<span>管理员信息</span>
					<em class="layui-nav-more"></em>
				</a>
				<dl class="layui-nav-child">
					<dd>
                        <a href="javascript:;" data-url="managerInfo.jsp">
                            <i class="iconfont icon-geren1" data-icon='icon-geren1'></i>
                            <span>管理员列表</span>
                        </a>
                    </dd>
					<dd>
                        <a href="javascript:;" data-url="changepwd.jsp">
                            <i class="iconfont icon-iconfuzhi01" data-icon='icon-iconfuzhi01'></i>
                            <span>修改密码</span>
                        </a>
                    </dd>
                </dl>
			</li>				
			<!--用户管理 -->
	       <li class="layui-nav-item">
			<a href="javascript:;">
			   <i class="iconfont icon-xitong" ></i>
			   <span>用户管理</span>
			 <em class="layui-nav-more"></em>
			</a>
			  <dl class="layui-nav-child">
			    	<dd>
			    		<a href="javascript:;" data-url="userInfo.jsp">
			    		   <i class="iconfont icon-zhandianpeizhi" data-icon='icon-zhandianpeizhi'></i>
			    		   <span>用户列表</span>
			    		</a>
			    	</dd>
			</li>
		</ul>
	    </div>
	</div>

	<!-- 左侧侧边导航结束 -->	    
	<!-- 右侧主体内容 -->
	<div class="layui-body" id="larry-body" style="bottom: 0;border-left: solid 2px #2299ee;">
		<div class="layui-tab layui-tab-card larry-tab-box" id="larry-tab" lay-filter="demo" lay-allowclose="true">
			<div class="go-left key-press pressKey" id="titleLeft" title="滚动至最右侧"><i class="larry-icon larry-weibiaoti6-copy"></i> </div>
			<ul class="layui-tab-title">
				<li class="layui-this" id="admin-home"><i class="iconfont icon-diannao1"></i><em>首页</em></li>
			</ul>
			<!--最右侧的页面刷新-->
			<div class="go-right key-press pressKey" id="titleRight" title="滚动至最左侧"><i class="larry-icon larry-right"></i></div> 
			<ul class="layui-nav closeBox">
				  <li class="layui-nav-item">
				    <a href="javascript:;"><i class="iconfont icon-caozuo"></i> 页面操作</a>
				    <dl class="layui-nav-child">
					  <dd><a href="javascript:;" class="refresh refreshThis"><i class="layui-icon">&#x1002;</i> 刷新当前</a></dd>
				      <dd><a href="javascript:;" class="closePageOther"><i class="iconfont icon-prohibit"></i> 关闭其他</a></dd>
				      <dd><a href="javascript:;" class="closePageAll"><i class="iconfont icon-guanbi"></i> 关闭全部</a></dd>
				    </dl>
				  </li>
				</ul>
			<div class="layui-tab-content" style="min-height: 150px; ">
				<div class="layui-tab-item layui-show">
					<iframe class="larry-iframe" data-id='0' src="main.jsp"></iframe>
				</div>
			</div>
		</div>
	</div>
	<!-- 底部区域 -->
	<div class="layui-footer layui-larry-foot" id="larry-footer">
		<div class="layui-mian">  
		    <p class="p-admin">
		    	<span>2019</span>
		    	FEN商城管理中心
		    </p>
		</div>
	</div>   
	    
	    
	</div>
		
		<!-- 加载js文件-->                                                                                                                                                                                           
	<script type="text/javascript" src="../common/layui/layui.js"></script> 
	<script type="text/javascript" src="../js/larry.js"></script>
	<script type="text/javascript" src="../js/index.js"></script>

	</body>
	<script type="text/javascript">
	//判断ID是否为空
		$(function () {
		    var userID = $("#userID").val();
		    if (userID == "") {
		        window.top.location.href = "mgLogin.jsp";//跳到登录页
		    }
   		});
		//管理员退出登录
   		function logout(){
	   		layer.confirm('确认要退出登录？', {
	   	        btn : [ '确定', '取消' ]//按钮
	        }, function(index) {
				$.ajax({
			        type: "POST",
			        dataType: "json",
			        url: "../user",
			        data: {
			        	"option" : "logout"
			        },
			        success: function (data) {
			            window.top.location.href = "mgLogin.jsp";
			        }
			    });
			}); 
   		}
	</script>
</html>

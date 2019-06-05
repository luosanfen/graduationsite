package com.shop.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSONObject;
import com.shop.entity.Manager;
import com.shop.entity.User;
import com.shop.service.UserService;

/**
 * Servlet implementation class LoginServlet 用户登录模块Servlet
 */
public class UserServlet extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;

	public UserServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");// 处理中文
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HashMap<String, String> resultMap = new HashMap<String, String>();
		HttpSession session = request.getSession();
		String option = request.getParameter("option");
		String result = "";
		UserService userService = new UserService();
		String userName = request.getParameter("UserName");
		String userRealName = request.getParameter("UserRealName");
		String userEmail = request.getParameter("UserEmail");
		String userPhone = request.getParameter("UserPhone");
		String userAddress = request.getParameter("UserAddress");
		String userPwd = request.getParameter("UserPwd");
		String userSex = request.getParameter("UserSex");
		
		Integer userID = (Integer) session.getAttribute("userID");
		if ("login".equals(option)) {
			// 获取提交的用户名
			userName = request.getParameter("txtUserName");
			// 获取提交用户的密码
			userPwd = request.getParameter("txtUserPwd");
			User user = new User();
			user.setUserName(userName);
			user.setUserPwd(userPwd);
			user = userService.login(user);
			if (user != null && user.getUserID() != null) {
				// 有数据登录成功,设置成sesseion变量
				request.setAttribute("result", result);
				session.setAttribute("userName", userName);
				session.setAttribute("userID", user.getUserID());
				request.getRequestDispatcher("index.jsp").forward(request, response);
			} else {
				request.setAttribute("result", "登录失败，请正确输入用户或密码！");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		} else if ("register".equals(option)) {

			User user = new User();

			user.setUserName(userName);
			user.setUserRealName(userRealName);
			user.setUserPwd(userPwd);
			user.setUserAddress(userAddress);
			user.setUserPhone(userPhone);
			user.setUserEmail(userEmail);
			user.setUserSex(Integer.valueOf(userSex));
			user.setUserCreateTime(new Date());

			Boolean check_user = userService.check_user(user);
			if (!check_user) {
				result = "已经存在此用户名！";
				request.setAttribute("result", result);
				request.setAttribute("user", user);
				request.getRequestDispatcher("register.jsp").forward(request, response);
			} else {
				Boolean register_user = userService.register_user(user);
				if (register_user) {
					// 注册成功
					result = "注册成功,请登录";
					request.setAttribute("result", result);
					request.setAttribute("user", user);
					request.getRequestDispatcher("login.jsp").forward(request, response);
				} else {
					result = "<h1>注册用户" + userName + "失败！</h1>";
					request.setAttribute("result", result);
					request.setAttribute("user", user);
					request.getRequestDispatcher("register.jsp").forward(request, response);
				}
			}
		} else if("modifyUser".equals(option)) {
			User user = new User();

			user.setUserID(userID);
			user.setUserRealName(userRealName);
			user.setUserAddress(userAddress);
			user.setUserPhone(userPhone);
			user.setUserEmail(userEmail);
			user.setUserSex(Integer.valueOf(userSex));
			
			Boolean modify_flag = userService.modify_user(user);
			if(modify_flag){
				resultMap.put("state", "0");
				resultMap.put("msg", "修改成功");
			} else {
				resultMap.put("state", "1");
				resultMap.put("msg", "修改失败");
			}
		} else if("pwdModify".equals(option)) {
			String originalPassword = request.getParameter("originalPassword");
			String newPassword = request.getParameter("newPassword");
			
			Boolean pwd_flag = userService.check_pwd(originalPassword, userID);
			if(pwd_flag){
				Boolean change_flag = userService.change_pwd(newPassword, userID);
				if(change_flag){
					resultMap.put("state", "0");
					resultMap.put("msg", "修改成功");
				} else {
					resultMap.put("state", "1");
					resultMap.put("msg", "修改失败");
				}
			} else {
				resultMap.put("state", "1");
				resultMap.put("msg", "修改失败,旧密码错误");
			}
		} else if("manege_login".equals(option)) { //管理员登录操作，获取传递的Data数据
			String name = request.getParameter("name");
			String password = request.getParameter("password");
			
			Manager manager = userService.manege_login(name, password);
			if(manager != null){
				//增加访问次数
				userService.add_loginCount(manager);
				session.setAttribute("manageUserID", manager.getManagerID());
				session.setAttribute("manageName", manager.getManagerName());
				session.setAttribute("manageUserName", manager.getUsername());
				resultMap.put("state", "1");
				resultMap.put("msg", "登录成功");
			} else {
				resultMap.put("state", "0");
				resultMap.put("msg", "登录失败,账号密码不匹配");
			}
		} else if("logout".equals(option)) { //管理员退出
			session.invalidate();
		}
		
		out.write(JSONObject.toJSONString(resultMap));
		out.flush();
		out.close();

	}
}

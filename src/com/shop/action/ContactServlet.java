package com.shop.action;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.shop.entity.Contact;
import com.shop.service.ContactService;

/**
 * Servlet implementation class ContactServlet 用户联系我们留言模块Servlet
 */
@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;

	public ContactServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");// 处理中文
		String result = null;
		// 获取标题 判断有问题 ，明天任务
		String conEmail = request.getParameter("userEmail").trim();
		String conTitle = request.getParameter("userTitle").trim();
		String conContent = request.getParameter("userContent").trim();

		// 建立留言 表对应JavaBean对象，把数据封装进去
		Contact contact = new Contact();
		contact.setConTitle(conTitle);
		contact.setConEmail(conEmail);
		contact.setConContent(conContent);
		// 获取当前用户存入
		contact.setConName(request.getSession().getAttribute("userName").toString());
		
		ContactService contactService = new ContactService();
		Boolean flag = contactService.save_Contact(contact);
		if(flag){
			result = "留言成功，可继续留言！";
			request.setAttribute("result", result);
			request.getRequestDispatcher("contact.jsp").forward(request, response);
		} else {
			result = "留言失败，重新留言！";
			request.setAttribute("result", result);
			request.getRequestDispatcher("contact.jsp").forward(request, response);
		}
	}
}

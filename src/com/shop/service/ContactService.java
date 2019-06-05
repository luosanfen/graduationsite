package com.shop.service;

import java.util.ArrayList;
import java.util.List;

import com.shop.dao.BaseDao;
import com.shop.entity.Contact;
public class ContactService {

	// 添加留言
	public Boolean save_Contact(Contact contact) {
		List<Object> params = new ArrayList<Object>();
		String sql = "insert into contactinfo(conName,conEmail,conTitle,conContent)values(?,?,?,?)";
		params.add(contact.getConName());
		params.add(contact.getConEmail());
		params.add(contact.getConTitle());
		params.add(contact.getConContent());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
	
	 // 查询出某条留言
	public Contact getContactByNewId(int conID) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select * from contact where conID = " + conID;//
		params.add(conID);
		return BaseDao.executeJDBCSQLQuery(sql, params, Contact.class);
	}
	
	 // 查询留言
		public Contact getContactAll() {
			List<Object> params = new ArrayList<Object>();
			String sql = "select * from contact";//
			return BaseDao.executeJDBCSQLQuery(sql, params, Contact.class);
		}

}

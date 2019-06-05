package com.shop.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dao.BaseDao;
import com.shop.entity.Manager;
import com.shop.entity.User;

public class UserService {
   
	//用户登录
	public User login(User user) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select * from userinfo where userName = ? and userPwd = ?";
		params.add(user.getUserName());
		params.add(encodeMD5(user.getUserPwd()));
		User userr = BaseDao.executeJDBCSQLQuery(sql, params, User.class);
		return userr;
	}
   //查询用户名
	public Boolean check_user(User user) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select * from userinfo where userName = ?";
		params.add(user.getUserName());
		List<User> user_list = BaseDao.executeJDBCSQLQuerys(sql, params, User.class);
		if(user_list == null || user_list.size() <= 0){
			return true;
		} else {
			return false;
		}
	}
  //用户注册
	public Boolean register_user(User user) {
		List<Object> params = new ArrayList<Object>();
		String sql ="insert into userinfo(userName,userRealName,userPwd,userSex,userPhone,userAddress,userEmail,userCreateTime)values(?,?,?,?,?,?,?, now())";
		params.add(user.getUserName());
		params.add(user.getUserRealName());
		params.add(encodeMD5(user.getUserPwd()));
		params.add(user.getUserSex());
		params.add(user.getUserPhone());
		params.add(user.getUserAddress());
		params.add(user.getUserEmail());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
	//修改用户信息
	public Boolean modify_user(User user) {
		List<Object> params = new ArrayList<Object>();
		String sql = "update userinfo set userRealName=?, userSex=?, userPhone=?, userAddress=?, userEmail=? where userID=?";
		params.add(user.getUserRealName());
		params.add(user.getUserSex());
		params.add(user.getUserPhone());
		params.add(user.getUserAddress());
		params.add(user.getUserEmail());
		params.add(user.getUserID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
	//查询旧密码密码操作
	public Boolean check_pwd(String originalPassword, Integer userID) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select 1 from userinfo where userID=? and userPwd=?";
		params.add(userID);
		params.add(encodeMD5(originalPassword));
		List<User> user_list = BaseDao.executeJDBCSQLQuerys(sql, params, User.class);
		if(user_list != null && user_list.size() > 0){
			return true;
		} else {
			return false;
		}
	}
  //修改密码操作
	public Boolean change_pwd(String newPassword, Integer userID) {
		List<Object> params = new ArrayList<Object>();
		String sql = "update userinfo set userPwd=? where userID=? ";
		params.add(encodeMD5(newPassword));
		params.add(userID);
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
	
	//密码加密操作
	public static String encodeMD5(String plainText) {
        String re_md5 = "";
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(plainText.getBytes());
            byte[] b = md.digest();

            int i;

            StringBuffer buf = new StringBuffer();
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }

            re_md5 = buf.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return re_md5;
    }
    
	//管理员登录
	public Manager manege_login(String name, String password) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select * from managerinfo t where t.username=? and t.managerPwd=?";
		params.add(name);
		params.add(encodeMD5(password));
		return BaseDao.executeJDBCSQLQuery(sql, params, Manager.class);
	}
 //管理员登录次数
	public void add_loginCount(Manager manager) {
		List<Object> params = new ArrayList<Object>();
		String sql = "update managerinfo set managerVisitCount=? where managerID=?";
		params.add(manager.getManagerVisitCount() == null ? 0 : manager.getManagerVisitCount() + 1);
		params.add(manager.getManagerID());
		BaseDao.executeSQL(sql, params);
	}

}

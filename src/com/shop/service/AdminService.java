package com.shop.service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.shop.dao.BaseDao;
import com.shop.entity.Bulletin;
import com.shop.entity.Category;
import com.shop.entity.Contact;
import com.shop.entity.GoodsImg;
import com.shop.entity.GoodsInfo;
import com.shop.entity.GoodsModel;
import com.shop.entity.Manager;
import com.shop.entity.OrderInfo;
import com.shop.entity.ParentCat;
import com.shop.entity.User;

public class AdminService {
	//添加二级分类
	public Boolean save_GoodsCat(Category category) {
		List<Object> params = new ArrayList<Object>();
		String sql = "insert into goodscatinfo(parentcatid, categoryname, categorytext, categorytime) values(?,?,?,now())";
		params.add(category.getParentCatID());
		params.add(category.getCategoryName());
		params.add(category.getCategoryText());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
   //删除二级分类
	public Boolean del_GoodsCat(Category category) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from goodscatinfo where categoryID=?";
		params.add(category.getCategoryID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
   //添加一级分类
	public Boolean save_ParentCat(ParentCat parentCat) {
		List<Object> params = new ArrayList<Object>();
		String sql = "insert into parentcatinfo(parentCatName, parentCatText, parentCatTime) values(?,?,now())";
		params.add(parentCat.getParentCatName());
		params.add(parentCat.getParentCatText());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
    //删除一级分类
	public Boolean del_ParentCat(ParentCat parentCat) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from parentcatinfo where parentCatID=?";
		params.add(parentCat.getParentCatID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
   //查询二级分类
	public List<Category> get_Category(Category category) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select * from goodscatinfo t where t.parentCatID=?";
		params.add(category.getParentCatID());
		return BaseDao.executeJDBCSQLQuerys(sql, params, Category.class);
	}
/*******商品模块*************/
   //添加商品信息
	public Integer save_Goods(GoodsInfo goodsInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql = "insert into goodsinfo(categoryID, parentCatID, goodsName, goodsKeys, goodsText, goodsContent, goodsIsVouch, goodsIsNew, goodsCheckAdmin) values(?,?,?,?,?,?,?,?,?)";
		params.add(goodsInfo.getCategoryID());
		params.add(goodsInfo.getParentCatID());
		params.add(goodsInfo.getGoodsName());
		params.add(goodsInfo.getGoodsKeys());
		params.add(goodsInfo.getGoodsText());
		params.add(goodsInfo.getGoodsContent());
		params.add(goodsInfo.getGoodsIsVouch());
		params.add(goodsInfo.getGoodsIsNew());
		params.add(goodsInfo.getGoodsCheckAdmin());
		return BaseDao.executeSQLKey(sql, params);
	}
   //修改商品信息
	public Integer modify_Goods(GoodsInfo goodsInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql = "update goodsinfo t set categoryID=?, parentCatID=?, goodsName=?, goodsKeys=?, goodsText=?, goodsContent=?, goodsIsVouch=?, goodsIsNew=? where t.goodsID=?";
		params.add(goodsInfo.getCategoryID());
		params.add(goodsInfo.getParentCatID());
		params.add(goodsInfo.getGoodsName());
		params.add(goodsInfo.getGoodsKeys());
		params.add(goodsInfo.getGoodsText());
		params.add(goodsInfo.getGoodsContent());
		params.add(goodsInfo.getGoodsIsVouch());
		params.add(goodsInfo.getGoodsIsNew());
		params.add(goodsInfo.getGoodsID());
		return BaseDao.executeSQL(sql, params);
	}

	//保存规格、价格等
	public Boolean save_Model(GoodsModel goodsModel) {
		List<Object> params = new ArrayList<Object>();
		String sql = "insert into goodsModel(goodsID, modelName, orderPrice, orderNum, buyNum, inventoryNum, modelInTime) values(?,?,?,?,?,?, now())";
		params.add(goodsModel.getGoodsID());
		params.add(goodsModel.getModelName());
		params.add(goodsModel.getOrderPrice());
		params.add(0);
		params.add(0);
		params.add(goodsModel.getInventoryNum());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
   //修改规格
	public Boolean modify_Model(GoodsModel goodsModel) {
		List<Object> params = new ArrayList<Object>();
		String sql = "update goodsModel t set goodsID=?, modelName=?, orderPrice=?, orderNum=?, buyNum=?, inventoryNum=? where t.modelId=?";
		params.add(goodsModel.getGoodsID());
		params.add(goodsModel.getModelName());
		params.add(goodsModel.getOrderPrice());
		params.add(goodsModel.getOrderNum());
		params.add(goodsModel.getBuyNum());
		params.add(goodsModel.getInventoryNum());
		params.add(goodsModel.getModelId());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
   //添加图片
	public void save_Img(GoodsImg goodsImg) {
		List<Object> params = new ArrayList<Object>();
		String sql = "INSERT INTO goodsImg (GOOD_IMG_ID, GOODSID, FILE_ADDRESS, FILE_SORT) VALUES (?,?,?,?)";
		params.add(UUID.randomUUID().toString().replace("-", ""));
		params.add(goodsImg.getGoodsId());
		params.add(goodsImg.getFile_address());
		params.add(goodsImg.getFile_sort());
		BaseDao.executeSQL(sql, params);
	}
    //删除商品
	public Boolean delete_goods(GoodsInfo goodsInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from goodsinfo where goodsID=?";
		params.add(goodsInfo.getGoodsID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
  //删除
	public Boolean delete_model(GoodsModel goodsModel) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from goodsModel where modelId=?";
		params.add(goodsModel.getModelId());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
  //删除图片
	public Boolean delete_Img(GoodsImg goodsModel) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from goodsImg where GOOD_IMG_ID=?";
		params.add(goodsModel.getGoodImgId());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
   //查询商品规格
	public List<GoodsModel> getModels(GoodsModel goodsModel) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select * from goodsModel where goodsID=?";
		params.add(goodsModel.getGoodsID());
		return BaseDao.executeJDBCSQLQuerys(sql, params, GoodsModel.class);
	}
	
	//删除订单操作
	public Boolean delete_order(OrderInfo orderInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from orderinfo where orderID=?";
		params.add(orderInfo.getOrderID());
		String del_order_detail = "delete from ordergoodsinfo where orderID=?";
		return BaseDao.executeSQL(sql, params) > 0 && BaseDao.executeSQL(del_order_detail, params) > 0 ? true : false;
	}
	
/**********公告模块的操作****************/
   //修改公告内容
	public Boolean modify_bullet(Bulletin bulletin) {
		List<Object> params = new ArrayList<Object>();
		String sql = "update bulletininfo set bulletinTitle=?, bulletincontent=?, isValid=?, bulletinUpdateDate=now() where bulletinID=?";
		params.add(bulletin.getBulletinTitle());
		params.add(bulletin.getBulletincontent());
		params.add(bulletin.getIsValid());
		params.add(bulletin.getBulletinID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
  // 增加公告内容
	public Boolean save_bullet(Bulletin bulletin) {
		List<Object> params = new ArrayList<Object>();
		String sql = "insert into bulletininfo(bulletinTitle, bulletincontent, bulletinInputDate, isValid, managerID) values(?,?,now(),?,?)";
		params.add(bulletin.getBulletinTitle());
		params.add(bulletin.getBulletincontent());
		params.add(bulletin.getIsValid());
		params.add(bulletin.getManagerID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
   
	//查询公告信息
	public Bulletin getBullet(Bulletin bulletin) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select * from bulletininfo where bulletinID=?";
		params.add(bulletin.getBulletinID());
		return BaseDao.executeJDBCSQLQuery(sql, params, Bulletin.class);
	}
   //删除公告信息
	public Boolean del_Bullet(Bulletin bulletin) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from bulletininfo where bulletinID=?";
		params.add(bulletin.getBulletinID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
	
	
/*********联系留言模块*********/
	//删除留言信息
	public Boolean del_Contact(Contact contact) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from contactinfo where conID=?";
		params.add(contact.getConID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
	
/********管理员模块操作**********/
	//查询管理员旧密码
	public Boolean check_old(String oldPwd, Integer manageUserID) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select 1 from managerinfo t where t.managerPwd=? and t.managerID=?";
		params.add(UserService.encodeMD5(oldPwd));
		params.add(manageUserID);
		List list = BaseDao.executeJDBCSQLQuery(sql, params);
		if(list != null && list.size() > 0){
			return true;
		}
		return false;
	}
    //修改管理员密码
	public Boolean change_pwd(String newPwd, Integer manageUserID) {
		List<Object> params = new ArrayList<Object>();
		String sql = "update managerinfo t set t.managerPwd=? where t.managerID=?";
		params.add(UserService.encodeMD5(newPwd));
		params.add(manageUserID);
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
   //修改管理员信息
	public Boolean modify_manage(Manager manager) {
		List<Object> params = new ArrayList<Object>();
		String sql = "update managerinfo set managerType=?, managerText=?, managerCheck=?, managerName=? where managerID=?";
		params.add(manager.getManagerType());
		params.add(manager.getManagerText());
		params.add(manager.getManagerCheck());
		params.add(manager.getManagerName());
		params.add(manager.getManagerID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
    //增加管理员账号
	public Boolean save_manage(Manager manager) {
		List<Object> params = new ArrayList<Object>();
		String sql = "insert into managerinfo(username, managerName, managerPwd, managerType, managerText, managerCheck, managerVisitCount,managerLastVisitTime) values(?,?,?,?,?,?,?,now())";
		params.add(manager.getUsername());
		params.add(manager.getManagerName());
		params.add(UserService.encodeMD5("123456"));
		params.add(manager.getManagerType());
		params.add(manager.getManagerText());
		params.add(manager.getManagerCheck());
		params.add(0);
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
   //查询管理员信息
	public Manager getManager(Manager manager) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select * from managerinfo where managerID = ?";
		params.add(manager.getManagerID());
		return BaseDao.executeJDBCSQLQuery(sql, params, Manager.class);
	}
   //删除管理员信息
	public Boolean del_Manager(Manager manager) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from managerinfo where managerID=?";
		params.add(manager.getManagerID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
	
   //删除用户账号
	public Boolean del_User(User user) {
		List<Object> params = new ArrayList<Object>();
		String sql = "delete from userinfo where userID=?";
		params.add(user.getUserID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
    
	//管理员重置用户密码操作
	public Boolean resetPwd(User user) {
		List<Object> params = new ArrayList<Object>();
		String sql = "update userinfo set userPwd=? where userID=?";
		params.add(UserService.encodeMD5("123456"));
		params.add(user.getUserID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
	//用于修改时获取商品原有的信息
	public GoodsInfo getGoods(GoodsInfo goodsInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select * from goodsinfo t where t.goodsID=?";
		params.add(goodsInfo.getGoodsID());
		return BaseDao.executeJDBCSQLQuery(sql, params, GoodsInfo.class);
	}
	public List<GoodsImg> getImgList(GoodsInfo goodsInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql = "select * from goodsImg t where t.goodsID=?";
		params.add(goodsInfo.getGoodsID());
		return BaseDao.executeJDBCSQLQuerys(sql, params, GoodsImg.class);
	}
	
	public Boolean change_state(OrderInfo orderInfo) {
		List<Object> params = new ArrayList<Object>();
		String sql = "update orderinfo set orderWeight=? where orderID=?";
		params.add(orderInfo.getOrderWeight());
		params.add(orderInfo.getOrderID());
		return BaseDao.executeSQL(sql, params) > 0 ? true : false;
	}
	
}

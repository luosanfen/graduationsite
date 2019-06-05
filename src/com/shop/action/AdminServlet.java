package com.shop.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
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
import com.shop.service.AdminService;

@MultipartConfig
public class AdminServlet extends HttpServlet {

	private static final long serialVersionUID = 8961328526447005713L;
	private HttpServletRequest request;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.request = request;
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HashMap<String, String> resultMap = new HashMap<String, String>();
		AdminService adminService = new AdminService();//
		HttpSession session = request.getSession();
		Integer manageUserID = (Integer) session.getAttribute("manageUserID");
		
		String option = request.getParameter("option");//获取网页的数据调用方法
		if(manageUserID != null){
			if(option != null && !"".equals(option)){
				if("save_GoodsCat".equals(option)){//添加二级分类
					Category category = getEntity(Category.class);//获取实体类
					Boolean flag = adminService.save_GoodsCat(category);//调用方法
					if(flag){//进行判断，返回结果值
						resultMap.put("state", "1");
						resultMap.put("msg", "二级分类添加成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "二级分类添加失败");
					}
				} else if("del_GoodsCat".equals(option)){//删除二级分类
					Category category = getEntity(Category.class);
					Boolean flag = adminService.del_GoodsCat(category);
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "二级分类删除成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "二级分类删除失败");
					}
				} else if("save_ParentCat".equals(option)){//添加一级分类
					ParentCat parentCat = getEntity(ParentCat.class);
					Boolean flag = adminService.save_ParentCat(parentCat);//调用
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "一级分类添加成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "一级分类添加失败");
					}
				} else if("del_ParentCat".equals(option)){//删除一级分类
					ParentCat parentCat = getEntity(ParentCat.class);
					Boolean flag = adminService.del_ParentCat(parentCat);
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "一级分类删除成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "一级分类删除失败");
					}
				} else if("get_Category".equals(option)){//获取一级分类下的二级分类
					Category category = getEntity(Category.class);
					List<Category> categories = adminService.get_Category(category);
					out.write(JSONObject.toJSONString(categories));
					out.flush();
					out.close();
					return;
				} else if("save_Goods".equals(option)){//添加商品
					GoodsInfo goodsInfo = getEntity(GoodsInfo.class);
					if(manageUserID != null && !"".equals(manageUserID)){
						goodsInfo.setGoodsCheckAdmin(String.valueOf(manageUserID));
					}
					Boolean flag = false;
					if(goodsInfo.getGoodsID() != null){
						flag = adminService.modify_Goods(goodsInfo) > 0 ? true : flag;
					} else {
						Integer goodsID = adminService.save_Goods(goodsInfo);
						if(goodsID != -1){
							resultMap.put("goodsID", String.valueOf(goodsID));
							flag = true;
						}
					}
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "保存成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "保存失败");
					}
				} else if("add_Model".equals(option)){//添加商品对于的规格信息
					GoodsModel goodsModel = getEntity(GoodsModel.class);
					Boolean flag;
					if(goodsModel.getModelId() != null){
						flag = adminService.modify_Model(goodsModel);
					} else {
						flag = adminService.save_Model(goodsModel);
					}
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "保存成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "保存失败");
					}
				} else if("upload".equals(option)){//用于上传图片
					Collection<Part> parts = request.getParts();
					for(Part part : parts){
				        String disposition = part.getHeader("Content-Disposition");
				        if(disposition.lastIndexOf(".") == -1){
				        	continue;
				        }
				        String suffix = disposition.substring(disposition.lastIndexOf("."),disposition.length()-1);
				          //随机的生存一个32的字符串
				        String filename = UUID.randomUUID()+suffix;
				          //获取上传的文件名
				        InputStream is = part.getInputStream();
				        //动态获取服务器的路径
				        String serverpath = request.getServletContext().getRealPath("upload");
				        File file = new File(serverpath);
				        if(!file.exists()){
				        	file.mkdirs();
				        }
				        FileOutputStream fos = new FileOutputStream(serverpath+"/"+filename);
				        byte[] bty = new byte[1024];
				        int length =0;
				        while((length=is.read(bty))!=-1){
				            fos.write(bty,0,length);
				        }
				        String file_id = request.getParameter("file_id");
				        String goodsID = request.getParameter("goodsID");
				        GoodsImg goodsImg = new GoodsImg();
				        goodsImg.setFile_sort(Integer.valueOf(file_id) + 1);
				        goodsImg.setGoodsId(Integer.valueOf(goodsID));
				        goodsImg.setFile_address("upload/" + filename);
				        adminService.save_Img(goodsImg);
				        fos.close();
				        is.close();
					}
			        resultMap.put("state", "1");
					resultMap.put("msg", "上传成功");
				} else if("delGoods".equals(option)) {//删除商品信息
					GoodsInfo goodsInfo = getEntity(GoodsInfo.class);
					Boolean flag= adminService.delete_goods(goodsInfo);
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "删除成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "删除失败");
					}
				} else if("delModel".equals(option)) {//删除商品规格
					GoodsModel goodsModel = getEntity(GoodsModel.class);
					Boolean flag= adminService.delete_model(goodsModel);
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "删除成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "删除失败");
					}
				} else if("delImg".equals(option)) {//删除图片
					GoodsImg goodsModel = getEntity(GoodsImg.class);
					Boolean flag= adminService.delete_Img(goodsModel);
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "删除成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "删除失败");
					}
				} else if("getModels".equals(option)) {//获取商品规格
					GoodsModel goodsModel = getEntity(GoodsModel.class);
					List<GoodsModel> models = adminService.getModels(goodsModel);
					if(models != null){
						HashMap<String, Object> result = new HashMap<String, Object>();
						result.put("code", "0");
						result.put("msg", "查询成功");
						result.put("count", models.size());
						result.put("data", models);
						out.write(JSONObject.toJSONString(result));
						out.flush();
						out.close();
						return;
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "查询失败");
					}
				} else if("delOrder".equals(option)){//删除订单
					OrderInfo orderInfo = getEntity(OrderInfo.class);
					Boolean flag = adminService.delete_order(orderInfo);
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "删除成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "删除失败");
					}
				} else if("save_bullet".equals(option)){//添加公告
					Bulletin bulletin = getEntity(Bulletin.class);
					Integer bulletinId = bulletin.getBulletinID();
					Boolean flag;
					if(bulletinId != null){
						flag = adminService.modify_bullet(bulletin);
					} else {
						bulletin.setManagerID(manageUserID);
						flag = adminService.save_bullet(bulletin);
					}
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "保存成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "保存失败");
					}
				} else if("getBullet".equals(option)){//查询公告
					Bulletin bulletin = getEntity(Bulletin.class);
					Bulletin bullet2 = adminService.getBullet(bulletin);
					if(bullet2 != null){
						resultMap.put("state", "1");
						resultMap.put("data", JSONObject.toJSONString(bullet2));
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "获取公告信息失败");
					}
				} else if("del_Bullet".equals(option)){//删除公告
					Bulletin bulletin = getEntity(Bulletin.class);
					Boolean flag = adminService.del_Bullet(bulletin);
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "操作成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "操作失败");
					}
				} else if("del_Contact".equals(option)){//删除留言
					Contact contact = getEntity(Contact.class);
					Boolean flag = adminService.del_Contact(contact);//调用方法
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "操作成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "操作失败");
					}
				} else if("changepwd".equals(option)){//修改管理员密码
					String oldPwd = request.getParameter("oldPwd");//获取文本框密码
					String newPwd = request.getParameter("newPwd");
					Boolean flag1 = adminService.check_old(oldPwd, manageUserID);//用于检测与原来的密码是否相同
					Boolean flag2 = adminService.change_pwd(newPwd, manageUserID);//用于修改密码
					if(flag1){
						if(flag2){
							resultMap.put("state", "1");
							resultMap.put("msg", "操作成功");
						} else {
							resultMap.put("state", "0");
							resultMap.put("msg", "操作失败");
						}
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "旧密码错误");
					}
				} else if("getManager".equals(option)){//获取修改原来的管理员信息
					Manager manager = getEntity(Manager.class);
					Manager manager2 = adminService.getManager(manager);
					if(manager2 != null){
						resultMap.put("state", "1");
						resultMap.put("data", JSONObject.toJSONString(manager2));
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "操作失败");
					}
				} else if("save_manege".equals(option)){//增加管理员信息
					Manager manager = getEntity(Manager.class);
					Integer managerId = manager.getManagerID();
					Boolean flag = false;
					if(managerId != null){
						if(manager.getManagerCheck() == null){
							manager.setManagerCheck(0);
						}
						flag = adminService.modify_manage(manager);
					} else {
						flag = adminService.save_manage(manager);
					}
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "操作成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "操作失败");
					}
				} else if("del_Manager".equals(option)){//删除管理员账户
					Manager manager = getEntity(Manager.class);
					Boolean flag = adminService.del_Manager(manager);
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "操作成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "操作失败");
					}
				} else if("del_User".equals(option)){//管理员删除用户操作
					User user = getEntity(User.class);
					Boolean flag = adminService.del_User(user);
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "操作成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "操作失败");
					}
				} else if("resetPwd".equals(option)){//管理员重置用户密码
					User user = getEntity(User.class);
					Boolean flag = adminService.resetPwd(user);//调用方法
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "操作成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "操作失败");
					}
				} else if("getGoods".equals(option)){//编辑商品信息
					GoodsInfo goodsInfo = getEntity(GoodsInfo.class);
					goodsInfo = adminService.getGoods(goodsInfo);//获取原有信息
					if(goodsInfo != null){
						out.write(JSONObject.toJSONString(goodsInfo));
						out.flush();
						out.close();
						return;
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "操作失败");
					}
				} else if("getImgList".equals(option)){
					
					GoodsInfo goodsInfo = getEntity(GoodsInfo.class);
					List<GoodsImg> goodsImg = adminService.getImgList(goodsInfo);
					if(goodsImg != null){
						HashMap<String, Object> result = new HashMap<String, Object>();
						result.put("code", "0");
						result.put("msg", "查询成功");
						result.put("count", goodsImg.size());
						result.put("data", goodsImg);
						out.write(JSONObject.toJSONString(result));
						out.flush();
						out.close();
						return;
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "操作失败");
					}
				} else if("change_state".equals(option)){
					OrderInfo orderInfo = getEntity(OrderInfo.class);
					Boolean flag = adminService.change_state(orderInfo);
					if(flag){
						resultMap.put("state", "1");
						resultMap.put("msg", "操作成功");
					} else {
						resultMap.put("state", "0");
						resultMap.put("msg", "操作失败");
					}
				}
			} else {
				resultMap.put("state", "0");
				resultMap.put("msg", "接口调用失败");
			}
			out.write(JSONObject.toJSONString(resultMap));
			out.flush();
			out.close();
			return;
		} else {
			request.getRequestDispatcher("mgLogin.jsp").forward(request, response);
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	private <T> T getEntity(Class<T> c){
		HashMap<String, String> result_map = new HashMap<String, String>();
		Enumeration enu = request.getParameterNames();  
		while(enu.hasMoreElements()){  
			String paraName=(String)enu.nextElement();  
			result_map.put(paraName, request.getParameter(paraName));
		}
		String json_str = JSONObject.toJSONString(result_map);
		T t = JSONObject.toJavaObject(JSONObject.parseObject(json_str), c);
		return t;
	}

}

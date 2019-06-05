package com.shop.dao;

import java.sql.Blob;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.zaxxer.hikari.HikariDataSource;

/**
 * 数据库操作类，封装了获取数据库连接的方法
 * @author fen
 *
 */
public class BaseDao {
	
	private static HikariDataSource dataSource = null;
	
	/**
	 * 初始化 数据连接池
	 */
	static{
		System.out.println("----------------------初始化 数据连接池----------------------");
		if(dataSource == null){
			dataSource = new HikariDataSource();
			dataSource.setDriverClassName("com.mysql.jdbc.Driver");
			dataSource.setJdbcUrl("jdbc:mysql://localhost/fenstore?useUnicode=true&characterEncoding=utf-8");
			dataSource.setUsername("root");
			dataSource.setPassword("");
			dataSource.setMinimumIdle(3);
			dataSource.setMaximumPoolSize(20);
			dataSource.setAutoCommit(true);
	        dataSource.setIdleTimeout(35000);
	        dataSource.setMaxLifetime(35000);
	        dataSource.setConnectionTimeout(1800000);
	        dataSource.setValidationTimeout(3000);
		}
	}
	
	public static List<HashMap<String, String>> executeJDBCSQLQuery(String sql) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<HashMap<String, String>> retuenList = new ArrayList<HashMap<String, String>>();
        try{
            conn = dataSource.getConnection();
            ps = conn.prepareStatement(sql);

            rs = ps.executeQuery();

            ResultSetMetaData rsmd = rs.getMetaData();
            while (rs.next()){
                HashMap<String, String> dataMap = new HashMap<String, String>();
                for(int i = 1; i <= rsmd.getColumnCount(); i++){
                    dataMap.put(rsmd.getColumnName(i).toLowerCase(), rs.getString(rsmd.getColumnName(i)));
                }
                retuenList.add(dataMap);
            }
            sqlLog(sql, null);
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            closeJDBC(conn, ps, rs);
        }
        return retuenList;
    }

	/**
	 * 
	 * @param sql 语句
	 * @param params List<Object> 参数
	 * @return List<HashMap<String, Object>>
	 */
    public static List<HashMap<String, Object>> executeJDBCSQLQuery(String sql, List<Object> params){
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<HashMap<String, Object>> retuenList = new ArrayList<HashMap<String, Object>>();
        try{
            conn = dataSource.getConnection();
            ps = conn.prepareStatement(sql);
            ps = setJDBCParameter(params, ps);

            rs = ps.executeQuery();

            ResultSetMetaData rsmd = rs.getMetaData();
            while (rs.next()){
                HashMap<String, Object> dataMap = new HashMap<String, Object>();
                for(int i = 1; i <= rsmd.getColumnCount(); i++){
                    dataMap.put(rsmd.getColumnName(i).toLowerCase(), rs.getObject(rsmd.getColumnName(i)));
                }
                retuenList.add(dataMap);
            }
            sqlLog(sql, params);
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            closeJDBC(conn, ps, rs);
        }
        return retuenList;
    }

    /**
     * 
     * @param sql
     * @param params
     * @return Boolean 执行Insert、Delete、Update失败时返回 false 
     */
    public static Boolean executeJDBCSQL(String sql, List<Object> params) {
        Connection conn = null;
        PreparedStatement ps = null;
        Boolean flag = false;
        try{
            conn = dataSource.getConnection();
            ps = conn.prepareStatement(sql);
            ps = setJDBCParameter(params, ps);

            flag = ps.execute();
            sqlLog(sql, params);
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            closeJDBC(conn, ps, null);
        }
        return flag;
    }
    
    /**
     * 
     * @param sql
     * @param params 参数
     * @param c 类
     * @return List<类>
     */
    public static <T> T executeJDBCSQLQuery(String sql, List<Object> params, Class<T> c) {
    	T t = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            conn = dataSource.getConnection();
            ps = conn.prepareStatement(sql);
            ps = setJDBCParameter(params, ps);

            rs = ps.executeQuery();

            ResultSetMetaData rsmd = rs.getMetaData();
            int count = rs.getRow();
            if(count > 1){
            	throw new Exception("行数过多count：" + count);
            }
            while (rs.next()){
                HashMap<String, Object> dataMap = new HashMap<String, Object>();
                for(int i = 1; i <= rsmd.getColumnCount(); i++){
                    dataMap.put(rsmd.getColumnName(i).toLowerCase(), rs.getObject(rsmd.getColumnName(i)));
                }
                String obj_sta = JSONObject.toJSONString(dataMap);
                JSONObject obj_json = JSONObject.parseObject(obj_sta);
                t = JSONObject.toJavaObject(obj_json, c);
            }
            sqlLog(sql, params);
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            closeJDBC(conn, ps, rs);
        }
        return t;
    }

    /**
     * 
     * @param sql
     * @param params 参数
     * @param c 类
     * @return List<类>
     */
    public static <T> List<T> executeJDBCSQLQuerys(String sql, List<Object> params, Class<T> c) {
        List<T> retuenList = new ArrayList<T>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            conn = dataSource.getConnection();
            ps = conn.prepareStatement(sql);
            ps = setJDBCParameter(params, ps);

            rs = ps.executeQuery();

            ResultSetMetaData rsmd = rs.getMetaData();
            while (rs.next()){
                HashMap<String, Object> dataMap = new HashMap<String, Object>();
                for(int i = 1; i <= rsmd.getColumnCount(); i++){
                    dataMap.put(rsmd.getColumnName(i).toLowerCase(), rs.getObject(rsmd.getColumnName(i)));
                }
                String obj_sta = JSONObject.toJSONString(dataMap);
                JSONObject obj_json = JSONObject.parseObject(obj_sta);
                T t = JSONObject.toJavaObject(obj_json, c);
                retuenList.add(t);
            }
            sqlLog(sql, params);
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            closeJDBC(conn, ps, rs);
        }
        return retuenList;
    }

    /**
     * 
     * @param sql
     * @return int 若查询无数据 或 执行Insert、Delete、Update失败时返回  <=0 
     */
    public static int executeSQL(String sql) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;
        try{
            conn = dataSource.getConnection();
            ps = conn.prepareStatement(sql);

            result = ps.executeUpdate();
            sqlLog(sql, null);
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            closeJDBC(conn, ps, null);
        }
        return result;
    }

    /**
     * 
     * @param sql
     * @param params 参数
     * @return int 若查询无数据 或 执行Insert、Delete、Update失败时返回  <=0 
     */
    public static int executeSQL(String sql, List<Object> params) {
        Long start = 0L;
        Long end = 0L;
        int result = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        try{
            conn = dataSource.getConnection();
            ps = conn.prepareStatement(sql);
            ps = setJDBCParameter(params, ps);

            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeJDBC(conn, ps, null);
            sqlLog(sql, params);
        }
        return result;
    }
    
    public static int executeSQLKey(String sql, List<Object> params) {
    	int result = 0;
    	Connection conn = null;
    	PreparedStatement ps = null;
    	ResultSet rs = null;
    	try{
    		conn = dataSource.getConnection();
    		ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
    		ps = setJDBCParameter(params, ps);
    		
    		result = ps.executeUpdate();
    		rs = ps.getGeneratedKeys();
    		if(rs.next()){
    			result = rs.getInt(1);
    		} else {
    			result = -1;
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = -1;
    	} finally {
    		closeJDBC(conn, ps, null);
    		sqlLog(sql, params);
    	}
    	return result;
    }
	
    private static PreparedStatement setJDBCParameter(List<Object> params, PreparedStatement ps) throws Exception {
        if(params == null){
            return ps;
        }
        for(int i = 0; i < params.size(); i++){
            int index = i+1;
            Object obj = params.get(i);
            if(obj instanceof Integer){
                ps.setInt(index, (Integer) obj);
            } else if(obj instanceof String){
                ps.setString(index, (String) obj);
            } else if(obj instanceof Double){
                ps.setDouble(index, (Double) obj);
            } else if(obj instanceof Float){
                ps.setFloat(index, (Float) obj);
            } else if(obj instanceof Long){
                ps.setLong(index, (Long) obj);
            } else if(obj instanceof Boolean){
                ps.setBoolean(index, (Boolean) obj);
            } else if(obj instanceof Date){
                ps.setDate(index, (Date) obj);
            } else if(obj instanceof Timestamp){
                ps.setTimestamp(index, (Timestamp) obj);
            } else if(obj instanceof Blob){
                ps.setBlob(index, (Blob) obj);
            } else if(obj instanceof Clob){
                ps.setClob(index, (Clob) obj);
            } else if(obj == null){
                ps.setString(index, null);
            }
        }
        return ps;
    }
   
    //后台打印
    private static void sqlLog(String sql, List<Object> params){
        try{
            String para = "[]";
            if(params != null){
                para = JSONObject.toJSONString(params);
            }
            System.out.println("BaseDao Run SQL-> " + sql + "    params-> " + para);
        } catch (Exception e) {
        }
    }
    //关闭连接
    private static void closeJDBC(Connection conn, PreparedStatement ps, ResultSet rs){
        try{
            if(rs != null){
                rs.close();
            }
            if(ps != null){
                ps.close();
            }
            if(conn != null){
                conn.close();
            }
        } catch (Exception e){
            e.printStackTrace();
        }
    }

}

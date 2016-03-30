package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import com.entity.Message;
import com.entity.Question;
import com.utils.ConnUtils;
import com.utils.SeparatePage;

public class MessageDao {
	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private int ri,row,rc;
	public String getAllMessage() {
		ArrayList<Message> res = new ArrayList<Message>();
		try {
			conn = ConnUtils.getConnection();//
			pstmt = conn.prepareStatement("SELECT * FROM Message");
			rs = pstmt.executeQuery();					
			while (rs.next()){
				//String id, int origin, int dest, String content
				//String temp = rs.getString("id");
				//temp.replaceAll(" ", "/");
				//temp.replaceAll(":", "/");
				String temp = rs.getString("id");
				String f = temp.substring(0, temp.length() - 2);
				res.add(new Message(f,rs.getInt("origin"),rs.getInt("destination"),rs.getString("content")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnUtils.releaseConn(rs, pstmt, conn);
		}
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for (int i = 0; i < res.size();i++) {
			sb.append("[");
			sb.append(""+res.get(i).getOrigin()+",");
			sb.append(""+res.get(i).getDestination()+",");
			sb.append("\""+res.get(i).getId()+"\",");
			sb.append("'"+res.get(i).getContent()+"'");
			sb.append("],");
		}
		sb.append("]");
		return sb.toString();

	}
	
	public boolean addMessage(String content, int origin, int destination) {
		boolean result = false;
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = sdf.format(dt);
			try {
				conn = ConnUtils.getConnection();//
				pstmt = conn.prepareStatement("INSERT INTO Message(id,content,origin, destination)"
						+ "VALUES(?,?,?,?)");
				
				pstmt.setString(1, currentTime);
				pstmt.setString(2, content);
				pstmt.setInt(3, origin);
				pstmt.setInt(4, destination);
				row = pstmt.executeUpdate();
				if (row > 0){
				    result =true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				ConnUtils.releaseConn(rs, pstmt, conn);
			}
			return result;
		}
	public List<Message> showMessage(int pageNo, int pageSize, Map<String, String> parameters) {
		List<Message> result = new ArrayList<Message>();
		int firstPos = (pageNo - 1) * pageSize;
		String value = "";
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM Message WHERE destination = ?");
		if (parameters != null){
			Set keySet = parameters.keySet();
			if (keySet != null && keySet.size() > 0){
				for (Iterator it = keySet.iterator(); it.hasNext(); ){
					String key = (String)it.next();
					value =(String)parameters.get(key);
				}
			}
		}
		sql.append(" LIMIT ").append(firstPos).append(",").append(pageSize);
		
		try {
			conn = ConnUtils.getConnection();//
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, value);
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				String temp = rs.getString("id").substring(0, rs.getString("id").length() - 2);
				Message user = new Message(temp,rs.getInt("origin"),rs.getInt("destination"),rs.getString("content"));
				result.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnUtils.releaseConn(rs, pstmt, conn);
		}
		return result;

	}
	public int GetMessageCount(Map parameters){
		int result = 0;
		String value = "";
		if (parameters != null){
			Set keySet = parameters.keySet();
			if (keySet != null && keySet.size() > 0){
				for (Iterator it = keySet.iterator(); it.hasNext(); ){
					String key = (String)it.next();
					value =(String)parameters.get(key);
				}
			}
		}
		try{
		conn = ConnUtils.getConnection();//
		pstmt = conn.prepareStatement("SELECT COUNT(*) FROM Message WHERE destination = ?");
		pstmt.setString(1, value);
		rs = pstmt.executeQuery();
		if (rs.next()){
			result = rs.getInt(1);
		}
		}catch (SQLException e){}
		finally {
			ConnUtils.releaseConn(rs, pstmt, conn);
		}
		return result;
	}
	public SeparatePage showMessageService(int pageNo, int pageSize, Map parameters) {
		List<Message> userList = showMessage(pageNo, pageSize, parameters);
		int totalRecord = GetMessageCount(parameters);
		SeparatePage sp = new SeparatePage();
		parameters.put("method", "show");
		sp = sp.createSeparatePage("showMessage", pageNo, pageSize, totalRecord, userList, parameters);
		return sp;
	}}
	

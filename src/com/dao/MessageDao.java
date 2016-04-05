package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import com.entity.Message;
import com.utils.ConnUtils;

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
	}
	

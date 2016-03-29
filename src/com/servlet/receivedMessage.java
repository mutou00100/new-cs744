package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.MessageDao;
import com.entity.Message;
public class receivedMessage extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		MessageDao md = new MessageDao();
//		PrintWriter out = response.getWriter() ;
//		ArrayList<Message> res  = md.getAllMessage();
//		StringBuffer sb = new StringBuffer();
//		sb.append("[");
//		for (int i = 0; i < res.size();i++) {
//			sb.append("[");
//			sb.append(res.get(i).getOrigin());
//			sb.append(res.get(i).getDestination());
//			sb.append(res.get(i).getId());
//			sb.append(res.get(i).getContent());
//			sb.append("]");
//		}
//		sb.append("]");
//		out.print(sb.toString());
	}		
}

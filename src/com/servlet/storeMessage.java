package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.MessageDao;

public class storeMessage extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter() ;
		MessageDao md = new MessageDao();
		int ori = Integer.parseInt(request.getParameter("ori"));
		int dest = Integer.parseInt(request.getParameter("dest"));
		String message = request.getParameter("message");
		out.print(md.addMessage(message, ori, dest));
		
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}
}

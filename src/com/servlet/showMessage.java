package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.MessageDao;

public class showMessage extends HttpServlet {
			MessageDao md = new MessageDao();
			protected void doGet(HttpServletRequest req, HttpServletResponse resp)
					throws ServletException, IOException {
				doPost(req,resp);}
			

			@Override
			protected void doPost(HttpServletRequest req, HttpServletResponse resp)
					throws ServletException, IOException {
				// TODO Auto-generated method stub
				String method = req.getParameter("method");
				if (method != null){
					if (method.equals("show")){
						int pageNo = 1;
						int pageSize = 6;
						String key = req.getParameter("destination");
						if (key == null || key.equals("null")) key = "";
						Map parameters = new HashMap();
						parameters.put("destination", key);
						req.setAttribute("destination", key);
						if (req.getParameter("pageNo") != null){
							pageNo = Integer.parseInt(req.getParameter("pageNo"));
						}
						if (req.getParameter("pageSize") != null){
							pageSize = Integer.parseInt(req.getParameter("pageSize"));
						}
						req.setAttribute("sp", md.showMessageService(pageNo, pageSize, parameters));
						req.getRequestDispatcher("showMessage.jsp").forward(req, resp);
					}
				} else {
				
				}
			}}

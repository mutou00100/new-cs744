package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.UserDAO;
import com.dao.UserDAOImpl;
import com.entity.User;

public class showAllUser extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			UserDAO userDAO = new UserDAOImpl();
			List<User> u = userDAO.findAllUser();
			PrintWriter out = response.getWriter();
			StringBuffer sb = new StringBuffer();
			sb.append("[");
			for (int i = 0; i < u.size();i++) {
				sb.append("[");
				sb.append("\""+u.get(i).getUid()+"\",");
				sb.append("\""+u.get(i).getFirstName()+"\",");
				sb.append("\""+u.get(i).getLastName()+"\"");
				sb.append("],");
			}
			if (sb.charAt(sb.length()- 1) == ','){
			sb.deleteCharAt(sb.length() - 1);}
			sb.append("]");
			out.print(sb.toString());
	}

}

package com.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.dao.UserDAO;
import com.dao.UserDAOImpl;
import com.entity.User;

public class deleteUser extends HttpServlet {

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
		int eid = 0;
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
	    String json = "";
	    if(br != null){
	        json = br.readLine();
	    }
	    JSONObject jsonObj = new JSONObject();
	    String uid="";
	    try {
			jsonObj = new JSONObject(json);
			uid = (String) jsonObj.get("uid");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    System.out.println(uid);
	    userDAO.delete(userDAO.findUserByID(uid));
	    PrintWriter out = response.getWriter();
	    response.setContentType("text/html");
	    response.setHeader("Cache-control", "no-cache, no-store");
	    response.setHeader("Pragma", "no-cache");
	    response.setHeader("Expires", "-1");

	    response.setHeader("Access-Control-Allow-Origin", "*");
	    response.setHeader("Access-Control-Allow-Methods", "POST");
	    response.setHeader("Access-Control-Allow-Headers", "Content-Type");
	    response.setHeader("Access-Control-Max-Age", "86400");
	    JSONObject result = new JSONObject();
	    try {
			result.put("eid", eid);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    out.println(result);
	    out.close();
	}

}

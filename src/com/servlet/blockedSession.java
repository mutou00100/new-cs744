package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
	import java.io.IOException;
	import java.io.PrintWriter;
	import java.util.ArrayList;

	import javax.servlet.ServletException;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;

	import com.dao.NodeDao;
	import com.entity.Edge;
	import com.entity.Node;

	import org.json.JSONArray;
	import org.json.JSONException;
	import org.json.JSONObject;

	import java.io.BufferedReader;
	import java.io.IOException;
	import java.io.InputStreamReader;
	public class blockedSession extends HttpServlet {
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
		 public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		        doPost(request,response);
		    }
		public void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
	        String json = "";
	        if(br != null){
	            json = br.readLine();
	        }
	        JSONObject jsonObj = new JSONObject();
	        HttpSession session = request.getSession();
			session.setAttribute("blockedlist", json);
	}
}

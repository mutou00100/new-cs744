package com.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.security.MessageDigest;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.dao.UserDAO;
import com.dao.UserDAOImpl;
import com.entity.User;
import com.utils.Base64Coder;

public class addUser extends HttpServlet {

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
		doPost(request,response);
	}
	
	private String encrypt(String message) {
		MessageDigest md;
		byte[] buffer;
		byte[] digest = new byte[0];
		try {
			buffer = message.getBytes(); // getBytes translates String to byte[]
			md = MessageDigest.getInstance("SHA-256");
			md.update(buffer);
			digest = md.digest();
		} catch (Exception ex) {
			System.out.println("Encryption Error!");
		}
		return String.valueOf(Base64Coder.encode(digest));
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
	    String firstname = "";
	    String lastname = "";
	    String password = "";
	    try {
			jsonObj = new JSONObject(json);
			uid = (String) jsonObj.get("uid");
			firstname = (String) jsonObj.get("firstname");
			lastname = (String) jsonObj.get("lastname");
			password = (String) jsonObj.get("password");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    User user = new User();
	    user.setFirstName(firstname);
	    user.setLastName(lastname);
	    user.setUid(uid);
	    String [] num = {"1","2","3","4","5","6","7","8","9","0"};
		String [] str = {"(",")","{","}","[","]",":","'",";","<",">","/",",",".","_","-","+","|","`"};
		for (int i=0;i<num.length;i++){
			if (uid.startsWith(num[i])){
				//this.addFieldError("addUserError","The first character of user ID can't be number!");
				eid = 1;
			}
		}
		for (int i=0;i<str.length;i++){
			if (password.contains(str[i])){
				//this.addFieldError("addUserError","The password can't contain the invalid character!");
				eid = 2;
			}
		}
		if ( userDAO.findUserByID(uid) != null){
			//this.addFieldError("addUserError","This user ID has existed!");
			eid = 3;
		}
		if ( uid.length() < 6){
			//this.addFieldError("addUserError","This user ID has existed!");
			eid = 4;
		}
		if ( password.length()<6){
			//this.addFieldError("addUserError","This user ID has existed!");
			eid = 5;
		}
	    user.setPassword(encrypt(password));
	    userDAO.save(user);
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

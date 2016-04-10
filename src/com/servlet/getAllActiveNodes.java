package com.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.dao.NodeDao;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class getAllActiveNodes extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        doPost(request,response);
	    }
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		NodeDao nDao = new NodeDao();
		PrintWriter out = response.getWriter();
		ArrayList<Integer> res = nDao.getAllActiveNode();
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
			result.put("activelist", new JSONArray(res));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    out.println(result);
	    out.close();
	}
	}

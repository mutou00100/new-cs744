package com.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.dao.NodeDao;

public class searchNonConnectedNode extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
	NodeDao nDao = new NodeDao();
	BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
    String json = "";
    if(br != null){
        json = br.readLine();
    }
    JSONObject jsonObj = new JSONObject();
    String type="";
    int node=-1;
    int domain=-1;
    try {
		jsonObj = new JSONObject(json);
		node = Integer.parseInt((String) jsonObj.get("node"));
		type = (String) jsonObj.get("type");
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    ArrayList<Integer> res=new ArrayList<Integer>();
    ArrayList<Integer> domains = nDao.getAllD();
    if(type.equals("DD")){
    	HashSet<Integer> temp=new HashSet<Integer>(nDao.searchNeighborNode(node));
    	for (int i = 0; i < domains.size();i++){
    		int cur = domains.get(i);
    		if (!temp.contains(cur) && cur != node) {
    			res.add(cur);
    		}
    	}
    
    }
    if(type.equals("CC")){
    	 try {
    			domain = Integer.parseInt((String) jsonObj.get("domain"));
    		} catch (JSONException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
    	HashSet<Integer> temp=new HashSet<Integer>(nDao.searchNeighborNode(node));
    	ArrayList<Integer> patterns = nDao.getAllCforDomain(domain);
    	for (int i = 0; i < patterns.size();i++){
    		int cur = patterns.get(i);
    		if (!temp.contains(cur) && cur != node) {
    			res.add(cur);
    		}
    	}
    	
    }
    if(type.equals("CN")){
    	 res=nDao.getNonConectedForPattern(node);   
    }
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
		result.put("neighbour", new JSONArray(res));
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    out.println(result);
    out.close();
}}

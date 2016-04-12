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

import org.json.JSONException;
import org.json.JSONObject;

import com.dao.NodeDao;
import com.entity.Edge;

public class addEdge extends HttpServlet {

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
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
	    String json = "";
	    if(br != null){
	        json = br.readLine();
	    }
	    JSONObject jsonObj = new JSONObject();
	    String d1="";
	    String d2="";
	    String type="";
	    try {
			jsonObj = new JSONObject(json);
			d1 = (String) jsonObj.get("node1");
			d2 = (String) jsonObj.get("node2");
			type=(String) jsonObj.get("type");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    int node1=Integer.parseInt(d1);
	    int node2=Integer.parseInt(d2);
	    int eid=-2;
		NodeDao nDao = new NodeDao();
		if(type.equals("DD")){
			if (nDao.searchEdge(node1, node2)==-1 && nDao.searchEdge(node2, node1)==-1){
				nDao.addEdge(node1, node2);
				eid = nDao.getLastEdge();
			}else {
				eid = -1;
			}
		}
		if(type.equals("CC")){
			if (nDao.searchEdge(node1, node2)==-1 && nDao.searchEdge(node2, node1)==-1){
				nDao.addEdge(node1, node2);
				eid = nDao.getLastEdge();
			}else {
				eid = -1;
			}
		}
		if(type.equals("CN")){
			ArrayList<Edge> l = nDao.getCEdges();
			for (int i=0;i<l.size();i++){
				if (l.get(i).getNode1()==node2 && l.get(i).getNode2()==node1){
					eid = -1;
				}
			}
			if (eid!= -1){
				if (nDao.countG(node1)==3){
					eid = -2;
				}else {
					nDao.updateCNedge(node2);;
					eid = node2*1000;
				}
			}
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
			result.put("eid", eid);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    out.println(result);
	    out.close();
	}

}

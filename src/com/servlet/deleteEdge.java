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

public class deleteEdge extends HttpServlet {

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
		eid = nDao.searchEdge(node1, node2);
		if(eid==-1){
			eid = nDao.searchEdge(node2, node1);
		}
		if((nDao.validDeleteDD(node1, eid))&&(nDao.validDeleteDD(node2, eid))){
			nDao.deleteEdgeById(eid);
		}
		else{
			eid=-1;
		}
	}
	if(type.equals("CC")){
		eid = nDao.searchEdge(node1, node2);
		if(eid==-1){
			eid = nDao.searchEdge(node2, node1);
		}
		if((nDao.validDeleteDD(node1, eid))&&(nDao.validDeleteDD(node2, eid))){
			nDao.deleteEdgeById(eid);
		}
		else{
			eid=-1;
		}
	}
	if(type.equals("CN")){
		ArrayList<Integer> L=nDao.getAllNforPattern(node1);
		if(L.size()>1){
			nDao.updateCNNode(node2);
			eid=node2*1000;
		}
		else{
			eid=-1;
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

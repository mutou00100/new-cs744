package com.servlet;

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

public class addConnector extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		NodeDao nDao = new NodeDao();
		String checked[] = request.getParameter("checkedC").split(",");
		int dID = Integer.parseInt(request.getParameter("dID"));
		nDao.addCNode();
		int node = nDao.getLast();
		response.setContentType("text/xml;charset=UTF-8");
		StringBuffer sb = new StringBuffer(""); 
		sb.append("<test>");
		sb.append("<node>");
		nDao.updateCNode(node, dID);
		sb.append(""+node);
		sb.append("</node>");
		sb.append("<edge>");  
		if (checked == null || checked.length == 0 ||(checked.length == 1 && checked[0] == "")) {
			
		} else {
			int[] checkedC = new int[checked.length];
			for (int i = 0; i < checkedC.length; i++) {
			checkedC[i] = Integer.parseInt(checked[i]);
			}
			for (int i = 0; i < checkedC.length;i++){
				nDao.addEdge(node, checkedC[i]);
				int eID = nDao.getLastEdge();
				sb.append("<node0>"+eID+"</node0>");
				sb.append("<node1>"+node+"</node1>");
				sb.append("<node2>"+checkedC[i]+"</node2>");
			}
		}
		sb.append("</edge>");  
		sb.append("<edgeCD>"); 
		sb.append("<node00>"+dID+"</node00>");
		sb.append("<node11>"+node+"</node11>");
		sb.append("</edgeCD>"); 
		sb.append("</test>");
		PrintWriter out = response.getWriter() ;
		out.print(sb);
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
		this.doGet(request, response);

}}

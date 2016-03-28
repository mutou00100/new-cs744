package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.NodeDao;
import com.entity.Edge;
import com.entity.Node;

public class addNode extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String s1 = request.getParameter("n1");
		String s2 = request.getParameter("n2");
		NodeDao nDao = new NodeDao();
		int gid = Integer.parseInt(request.getParameter("gid"));
		int flag = Integer.parseInt(request.getParameter("flag"));
		response.setContentType("text/xml;charset=UTF-8");
		StringBuffer sb = new StringBuffer(""); 
		sb.append("<test>");	
		if (nDao.countTotalNodes(gid) == 8) {
			sb.append("<error>");
			sb.append("Nodes in a pattern has reached maximum connections");
			sb.append("</error>");
		} else if (flag == 0 && nDao.countG(gid) == 3) {// connector node is full
			sb.append("<error>");
			sb.append("Connector node has reached maximum connections");
			sb.append("</error>");
		} else if (s1.length() == 0 && s2.length() == 0) {
			// corner case1: only connector node
			if (flag == 0 && nDao.countTotalNodes(gid)==1){
				nDao.addNNode(gid, flag);
				int id = nDao.getLast(); // update database
				sb.append("<node>");
				sb.append(""+id);
				sb.append("</node>");
				sb.append("<edgeCN>");
				sb.append("<edgeCN1>");
				sb.append(""+id);
				sb.append("</edgeCN1>");
				sb.append("<edgeCN2>");
				sb.append(""+gid);
				sb.append("</edgeCN2>");
				sb.append("</edgeCN>");
			} else {
				sb.append("<error>");
				sb.append("the pattern must be closed to form a ring");
				sb.append("</error>");
			} 
		} else if (s1.length() == 0) {
			int n2 = Integer.parseInt(s2);
			if (!nDao.belong(n2, gid)) {
				sb.append("<error>");
				sb.append("Non-connector should be in the pattern you choose");
				sb.append("</error>");
			} else if (nDao.countN(n2) == 0) {
				nDao.addNNode(gid, flag);
				int id = nDao.getLast(); // update database
				sb.append("<node>");
				sb.append(""+id);
				sb.append("</node>");
				if (flag == 0) {
					sb.append("<edgeCN>");
					sb.append("<edgeCN1>");
					sb.append(""+id);
					sb.append("</edgeCN1>");
					sb.append("<edgeCN2>");
					sb.append(""+gid);
					sb.append("</edgeCN2>");
					sb.append("</edgeCN>");
				}
				nDao.addEdge(id, n2);// update database;
				int eid1 = nDao.getLastEdge();
				sb.append("<edgeNN>");
				sb.append("<edgeNN0>");
				sb.append(""+eid1);
				sb.append("</edgeNN0>");
				sb.append("<edgeNN1>");
				sb.append(""+id);
				sb.append("</edgeNN1>");
				sb.append("<edgeNN2>");
				sb.append(""+n2);
				sb.append("</edgeNN2>");
				sb.append("</edgeNN>");
			} else {
				sb.append("<error>");
				sb.append("the pattern must be closed to form a ring");
				sb.append("</error>");
			}
		} else if (s2.length() == 0) {
			// corner case2: add one to two
			int n1 = Integer.parseInt(s1);
			// corner case2: add one to two
			if (!nDao.belong(n1, gid)) {
				sb.append("<error>");
				sb.append("Non-connector should be in the pattern you choose");
				sb.append("</error>");
			}
			else if (nDao.countN(n1) == 0) {
				nDao.addNNode(gid, flag);
				int id = nDao.getLast(); // update database
				sb.append("<node>");
				sb.append(""+id);
				sb.append("</node>");
				if (flag == 0) {
					sb.append("<edgeCN>");
					sb.append("<edgeCN1>");
					sb.append(""+id);
					sb.append("</edgeCN1>");
					sb.append("<edgeCN2>");
					sb.append(""+gid);
					sb.append("</edgeCN2>");
					sb.append("</edgeCN>");
				}
				nDao.addEdge(id, n1);// update database;
				int eid1 = nDao.getLastEdge();
				sb.append("<edgeNN>");
				sb.append("<edgeNN0>");
				sb.append(""+eid1);
				sb.append("</edgeNN0>");
				sb.append("<edgeNN1>");
				sb.append(""+id);
				sb.append("</edgeNN1>");
				sb.append("<edgeNN2>");
				sb.append(""+n1);
				sb.append("</edgeNN2>");
				sb.append("</edgeNN>");
			} else {
				sb.append("<error>");
				sb.append("the pattern must be closed to form a ring");
				sb.append("</error>");
			}
		} else {
			int n1 = Integer.parseInt(s1);// if null, -1 should be 
			int n2 = Integer.parseInt(s2);
			if (!nDao.belong(n1, gid) && !nDao.belong(n2, gid)) { 
				sb.append("<error>");
				sb.append(" Non-connector should be in the pattern you choose ");
				sb.append("</error>");
			} else if (nDao.countN(n1) == 1 && nDao.countN(n2) == 1) {
				nDao.addNNode(gid, flag);
				int id = nDao.getLast(); // update database
				sb.append("<node>");
				sb.append(""+id);
				sb.append("</node>");
				if (flag == 0) {
					sb.append("<edgeCN>");
					sb.append("<edgeCN1>");
					sb.append(""+id);
					sb.append("</edgeCN1>");
					sb.append("<edgeCN2>");
					sb.append(""+gid);
					sb.append("</edgeCN2>");
					sb.append("</edgeCN>");
				}
				nDao.addEdge(id, n1);
				sb.append("<edgeNN>");
				int eid1 = nDao.getLastEdge();
				sb.append("<edgeNN0>");
				sb.append(""+eid1);
				sb.append("</edgeNN0>");
				sb.append("<edgeNN1>");
				sb.append(""+id);
				sb.append("</edgeNN1>");
				sb.append("<edgeNN2>");
				sb.append(""+n1);
				sb.append("</edgeNN2>");
				nDao.addEdge(id, n2);
				int eid2 = nDao.getLastEdge();
				sb.append("<edgeNN0>");
				sb.append(""+eid2);
				sb.append("</edgeNN0>");
				sb.append("<edgeNN1>");
				sb.append(""+id);
				sb.append("</edgeNN1>");
				sb.append("<edgeNN2>");
				sb.append(""+n2);
				sb.append("</edgeNN2>");
				sb.append("</edgeNN>");
			} else if (nDao.countN(n1) == 2 && nDao.countN(n2) == 2 && (nDao.edge(n1, n2)|| nDao.edge(n2, n1))) {
				int eid = -1;
				int temp1 = nDao.searchEdge(n1,n2);
				int temp2 = nDao.searchEdge(n2,n1);
				if (temp1 == -1) {
					eid = temp2;
				} else {
					eid = temp1;
				}
				sb.append("<edgeDelete>");
				sb.append(""+eid);
				sb.append("</edgeDelete>");
				nDao.deleteEdge(n1, n2);
				nDao.deleteEdge(n2, n1);	
				nDao.addNNode(gid, flag);
				int id = nDao.getLast();
				sb.append("<node>");
				sb.append(""+id);
				sb.append("</node>");
				if (flag == 0) {
					sb.append("<edgeCN>");
					sb.append("<edgeCN1>");
					sb.append(""+id);
					sb.append("</edgeCN1>");
					sb.append("<edgeCN2>");
					sb.append(""+gid);
					sb.append("</edgeCN2>");
					sb.append("</edgeCN>");
				}
				
				nDao.addEdge(id, n1);
				int eid1 = nDao.getLastEdge();
				sb.append("<edgeNN>");
				sb.append("<edgeNN0>");
				sb.append(""+eid1);
				sb.append("</edgeNN0>");
				sb.append("<edgeNN1>");
				sb.append(""+id);
				sb.append("</edgeNN1>");
				sb.append("<edgeNN2>");
				sb.append(""+n1);
				sb.append("</edgeNN2>");
				sb.append("</edgeNN>");
				nDao.addEdge(id, n2);
				int eid2 = nDao.getLastEdge();
				sb.append("<edgeNN>");
				sb.append("<edgeNN0>");
				sb.append(""+eid2);
				sb.append("</edgeNN0>");
				sb.append("<edgeNN1>");
				sb.append(""+id);
				sb.append("</edgeNN1>");
				sb.append("<edgeNN2>");
				sb.append(""+n2);
				sb.append("</edgeNN2>");
				sb.append("</edgeNN>");
			} else {
				sb.append("<error>");
				sb.append(" Non-connector node can only connected with up to two non-connector nodes");
				sb.append("</error>");
			}
		}	
		sb.append("</test>");	
		PrintWriter out = response.getWriter() ;
		out.print(sb);		
	}

}

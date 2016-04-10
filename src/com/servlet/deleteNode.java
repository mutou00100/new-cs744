package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.NodeDao;
import com.entity.Edge;

public class deleteNode extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		NodeDao nDao = new NodeDao();
		int nid = Integer.parseInt(request.getParameter("nid"));
		// the node to be deleted
		response.setContentType("text/xml;charset=UTF-8");
		StringBuffer sb = new StringBuffer("");
		sb.append("<test>");
		if (!nDao.contains(nid)) {
			sb.append("<error>");
			sb.append("the node doesn't exist");
			sb.append("</error>");
		} else if (nDao.whetherC(nid)) {
			if (nDao.countG(nid) != 0) {
				sb.append("<error>");
				sb.append("connector node cannot be deleted if there is at least one other node in the pattern");
				sb.append("</error>");
			} else {
				ArrayList<Edge> neighbors = nDao.searchNeighbors(nid);
				ArrayList<Integer> patterns = new ArrayList<Integer>();
				for (int i = 0; i < neighbors.size(); i++) {
					int node1 = neighbors.get(i).getNode1();
					int node2 = neighbors.get(i).getNode2();
					if (node1 != nid) {
						patterns.add(node1);
					}
					if (node2 != nid) {
						patterns.add(node2);
					}
				}
				int bad = 0;
				// get all the patterns that would be effected
				for (int i = 0; i < patterns.size(); i++) {
					if (nDao.countN(patterns.get(i)) == 1) {
						bad++;
					}
				}
				if (bad == 0|| patterns.size()==1) {
					sb.append("<node>");
					sb.append("" + nid);
					sb.append("</node>");
					nDao.deleteInNodeEdge(nid); // delete connections with other											// connectors
					nDao.deletePattern(nid); // delete connections with other											// connectors
				}
			}
		} else {
			ArrayList<Edge> neighbors = nDao.searchNeighbors(nid);
			if (neighbors.size() == 0) {
				nDao.deleteInNode(nid);
				sb.append("<node>");
				sb.append("" + nid);
				sb.append("</node>");
			} else if (nDao.patternConnected(nid)
					&& nDao.countConnector(nDao.whichPattern(nid)) == 1) {
				sb.append("<error>");
				sb.append("It should still be a ring after delete operation");
				sb.append("</error>");
			} else {
				ArrayList<Integer> effected = new ArrayList<Integer>();
				for (int i = 0; i < neighbors.size(); i++) {
					int node1 = neighbors.get(i).getNode1();
					int node2 = neighbors.get(i).getNode2();
					if (node1 != nid) {
						effected.add(node1);
					}
					if (node2 != nid) {
						effected.add(node2);
					}
				}
				sb.append("<node>");
				sb.append("" + nid);
				sb.append("</node>");
				sb.append("<node>");
				if (effected.size() == 2) {
					int n1 = effected.get(0);
					int n2 = effected.get(1);
					if (!nDao.containEdge(n1, n2) && !nDao.containEdge(n2, n1)) {
						nDao.addEdge(n1, n2);
						int eid = nDao.getLastEdge();
						sb.append("<addEdge0>");
						sb.append("" + eid);
						sb.append("</addEdge0>");
						sb.append("<addEdge1>");
						sb.append("" + n1);
						sb.append("</addEdge1>");
						sb.append("<addEdge2>");
						sb.append("" + n2);
						sb.append("</addEdge2>");
					}
				}
				sb.append("</node>");
				nDao.deleteInNode(nid);
				nDao.deleteInNodeEdge(nid);
			}
		}
		sb.append("</test>");
		PrintWriter out = response.getWriter();
		out.print(sb);
	}

}

package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.MessageDao;
import com.dao.NodeDao;

public class checkMessage extends HttpServlet {
	boolean rememberToChange = false;
	NodeDao nd = new NodeDao();
	
	int count = 0;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		rememberToChange = false;
		PrintWriter out = response.getWriter() ;
		int ori = Integer.parseInt(request.getParameter("ori"));
		int dest = Integer.parseInt(request.getParameter("dest"));
		boolean flag = helper(new HashSet<Integer>(), ori, dest,new ArrayList<Integer>());
		out.print(""+flag);
		
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}
	boolean helper(HashSet<Integer> hs, int cur, int dest, ArrayList<Integer> fake) {
		if (rememberToChange) {
			return true;
		}	
		if (cur == dest) {
			rememberToChange = true;
			return true;
		}
		if (nd.getNodeById(cur).getStatus()== 0) {
			ArrayList<Integer> neighbors = new ArrayList<Integer>();
			neighbors.addAll(nd.searchNeighborNode(cur));
			if (nd.whetherConnectedToPattern(cur)) {
				neighbors.add(nd.whichPattern(cur));
			} else if (nd.whetherC(cur)) {
				neighbors.addAll(nd.getAllNforPattern(cur));
			}
			for (int i = 0; i < neighbors.size(); i++) {
				int temp = neighbors.get(i);
				if (!hs.contains(temp)&& nd.getNodeById(temp).getStatus() == 0) {
					fake.add(cur);
					hs.add(cur);	
					if (!helper(hs, temp, dest, fake)){
						fake.remove(fake.size() - 1);
					}
				}
			}
		}
		return rememberToChange;
		}
}

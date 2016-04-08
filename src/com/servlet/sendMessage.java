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
import com.entity.Edge;

public class sendMessage extends HttpServlet {
	boolean rememberToChange = false;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
	}
	NodeDao nd = new NodeDao();
	boolean flag = false;
	boolean fakeRememberToChange = false;
	int count = 0;
	ArrayList<Integer> path = new ArrayList<Integer>();
	ArrayList<Integer> fakepath = new ArrayList<Integer>();
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter() ;
		rememberToChange = false;
		fakeRememberToChange = false;
		path.clear();
		fakepath.clear();
		rememberToChange = false;
		int ori = Integer.parseInt(request.getParameter("ori"));
		int dest = Integer.parseInt(request.getParameter("dest"));
		HashSet<Integer> hs = new HashSet<Integer>();
		HashSet<Integer> hsfake = new HashSet<Integer>();
		String message = request.getParameter("message");
		if (nd.getNodeById(ori).getStatus() == 0) {
			hs.add(ori);
			hsfake.add(ori);
			if (!helper(hs, ori, dest,new ArrayList<Integer>())){
				fakehelper(hsfake,ori, dest, new ArrayList<Integer>());
				fakepath.add(-1);
				fakepath.add(ori);
				out.print(fakepath);
			} else {
				for (int i = 0; i < path.size(); i++) {
					System.out.print(path.get(i) + "");
				}
				path.add(0);
				path.add(ori);
				out.print(path);
			}
		} else {
			ArrayList<Integer> temp = new ArrayList<Integer>();
			temp.add(-1);
			temp.add(ori);
			out.print(temp);
		}
		//request.getRequestDispatcher("sendMessage.jsp").forward(request, response);	
	}
	boolean helper(HashSet<Integer> hs, int cur, int dest, ArrayList<Integer> fake) {
		if (rememberToChange) {
			return true;
		}
		if (cur == dest) {
			path.addAll(fake);
			rememberToChange = true;
			return true;
		}
		ArrayList<Integer> neighbors = new ArrayList<Integer>();
		neighbors.addAll(nd.searchNeighborNode(cur));
		if (nd.whetherConnectedToPattern(cur)) {//("SELECT * FROM Node WHERE nID = ? AND flag = ?");
			neighbors.add(nd.whichPattern(cur));//("SELECT * FROM Node WHERE nid = ?"diff
		} 
		if (nd.whetherC(cur)) {
			neighbors.addAll(nd.getAllNforPattern(cur));//"SELECT * FROM Node WHERE flag = 0 AND cid = ?"
			neighbors.add(nd.whichDomain(cur));
		}
		if (nd.whetherD(cur)) {
			neighbors.addAll(nd.getAllCforDomain(cur));
		}
		for (int i = 0; i < neighbors.size(); i++) {
			int temp = neighbors.get(i);
			if (!hs.contains(temp) && nd.getNodeById(temp).getStatus() == 0) {
				hs.add(temp);
				fake.add(temp);
				if (!helper(hs, temp, dest, fake)){
					fake.remove(fake.size() - 1);
				}
			}
		}
		return rememberToChange;
		}
	void fakehelper(HashSet<Integer> hs, int cur, int dest, ArrayList<Integer> fake) {
		if (fakeRememberToChange == true) {
			return;
		}
		if (cur == dest) {
			fakepath.addAll(fake);
			fakeRememberToChange = true;
			return;
		}
		ArrayList<Integer> neighbors = new ArrayList<Integer>();
		neighbors.addAll(nd.searchNeighborNode(cur));//"SELECT * FROM NodeEdge Where nID1 = ? or nID2 = ?", same
		if (nd.whetherConnectedToPattern(cur)) {//("SELECT * FROM Node WHERE nID = ? AND flag = ?");
			neighbors.add(nd.whichPattern(cur));//("SELECT * FROM Node WHERE nid = ?"diff
		} 
		if (nd.whetherC(cur)) {
			neighbors.addAll(nd.getAllNforPattern(cur));//"SELECT * FROM Node WHERE flag = 0 AND cid = ?"
			neighbors.add(nd.whichDomain(cur));
		}
		if (nd.whetherD(cur)) {
			neighbors.addAll(nd.getAllCforDomain(cur));
		}
		
		for (int i = 0; i < neighbors.size(); i++) {
			int temp = neighbors.get(i);
			if (!hs.contains(temp)) {
				hs.add(temp);
				fake.add(temp);
				fakehelper(hs, temp, dest, fake);
				fake.remove(fake.size() - 1);
				}
			}
		}
	}

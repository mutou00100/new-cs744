package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.NodeDao;
import com.utils.ConnUtils;

public class getNodes extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		ArrayList<Integer> res = new ArrayList<Integer>();
		NodeDao nd = new NodeDao();
		int cid = Integer.parseInt(request.getParameter("cid"));
		res = nd.getAllNforPattern(cid);
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < res.size();i++) {
			sb.append("" + res.get(i));
			sb.append(",");
		}
		out.print(sb.toString());
	}

}

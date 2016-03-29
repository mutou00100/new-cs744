package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.QuestionDao;
import com.entity.Question;

public class addQuestion extends HttpServlet {

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
		this.doPost(request, response);
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
		String content = request.getParameter("content");
		response.setContentType("text/xml;charset=UTF-8");
		StringBuffer sb = new StringBuffer(""); 
		sb.append("<test>");
		Question q = new Question();
		q.setContent(content);
		QuestionDao qd = new QuestionDao();
		ArrayList<Question> l = new ArrayList<Question>();
		l = qd.getQuestions();
		boolean flag = true;
		if (content == null || content == ""){
			flag = false;
			sb.append("<error>");
			sb.append("The content can't be null");
			sb.append("</error>");
		}
		for (int i=0;i<l.size();i++){
			if (l.get(i).getContent().equals(content)){
				flag = false;
				sb.append("<error>");
				sb.append("The question has existed");
				sb.append("</error>");
			}
		}
		if (flag){
			qd.addQuestion(q);
			sb.append("<success>");
			sb.append("Add successful!");
			sb.append("</success>");
		}
		sb.append("</test>");
		PrintWriter out = response.getWriter();
		out.print(sb);
	}

}

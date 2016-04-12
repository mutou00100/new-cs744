package com.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.dao.QuestionDao;
import com.entity.Question;
import com.annabel.UserDao;

public class changeQuestion extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserDao uDao = new UserDao();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
			QuestionDao qDao = new QuestionDao();
			BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
		    String json = "";
		    int ques1 = 0;
			int ques2 = 0;
			int ques3 = 0;
			String ans1 = "";
			String ans2 = "";
			String ans3 = "";
		    if(br != null){
		        json = br.readLine();
		    }
		    JSONObject jsonObj = new JSONObject();
		    String uid="";
		    try {
				jsonObj = new JSONObject(json);
				uid = (String) jsonObj.get("uid");
				ques1 = Integer.parseInt((String) jsonObj.get("ques1"));
				ques2 = Integer.parseInt((String) jsonObj.get("ques2"));
				ques3 = Integer.parseInt((String) jsonObj.get("ques3"));
				ans1 = (String) jsonObj.get("ans1");
				ans2 = (String) jsonObj.get("ans2");
				ans3 = (String) jsonObj.get("ans3");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    ArrayList<String> res=qDao.getQuestAndAnsById(uid);
		    ArrayList<Question> questions=qDao.getQuestions();
		    HashMap<String, String> hm= new HashMap<String, String>();
		    for (int i = 0; i < questions.size(); i++){
		    	hm.put(questions.get(i).getId()+"",questions.get(i).getContent());
		    }
		    uDao.setQuestions(ques1, ans1, ques2, ans2, ques3, ans3, uid);
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
				result.put("success", "success");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    out.println(result);
		    out.close();
		}
}

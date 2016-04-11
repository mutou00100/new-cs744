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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.dao.NodeDao;
import com.dao.QuestionDao;
import com.entity.Question;

public class showQuesAndAns extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
	QuestionDao qDao = new QuestionDao();
	BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
    String json = "";
    if(br != null){
        json = br.readLine();
    }
    JSONObject jsonObj = new JSONObject();
    String uid="";
    try {
		jsonObj = new JSONObject(json);
		uid = (String) jsonObj.get("uid");
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
    JSONObject questionobject = new JSONObject(hm);
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
		result.put("QuesAndAns", new JSONArray(res));
		result.put("AllQuestions", questionobject);
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    out.println(result);
    out.close();
}
}

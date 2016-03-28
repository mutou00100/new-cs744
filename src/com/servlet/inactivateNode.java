package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Timer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.utils.RandomGenerator;

public class inactivateNode extends HttpServlet {
	RandomGenerator ran;
	Timer timer;
	int last = -2;
	long interval;
	float speed = 0;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			if (request.getParameter("speed")!= null) {
				speed = Float.parseFloat(request.getParameter("speed"));
				if (Math.abs(speed - 0) < 0.000001) {
					interval = 0;
				} else {
					interval = (long) ((long)2/speed) * 1000;
				}
				ran.setInterval(0);
				boolean x = ran.cancel();
				ran = new RandomGenerator(interval);
				timer = new Timer();
				timer.schedule(ran,0);
			}
			PrintWriter out = response.getWriter() ; 
		    int node = ran.getRandom();		    		
		    if (node != last && node != -2) {	    		    			
			   out.print(node +"");
			   last = node;
		    }
			out.flush();  
		    out.close();  
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
		
	}
	public void init() throws ServletException {
			ran = new RandomGenerator(0);
			timer = new Timer();
			timer.schedule(ran,0);
	}
}

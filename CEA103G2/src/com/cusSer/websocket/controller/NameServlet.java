package com.cusSer.websocket.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.employee.model.*;
import com.employee.controller.*;
import com.memTen.model.*;
import com.memTen.controller.*;

public class NameServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		
		String action = req.getParameter("action");
		
		if ("backChat".equals(action)) {
			String empName = req.getParameter("empName");
			req.setAttribute("empName", empName);
			RequestDispatcher dispatcher = req.getRequestDispatcher("/back-end/cusSer/chatBack.jsp");
			dispatcher.forward(req, res);
		}
		
		if("frontChat".equals(action)){
			String userName = req.getParameter("userName");
			req.setAttribute("userName",userName);
			RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/cusSer/chatFront.jsp");
			dispatcher.forward(req, res);
			
		}
	}
}

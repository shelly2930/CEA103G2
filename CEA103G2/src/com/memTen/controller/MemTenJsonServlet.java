package com.memTen.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.memTen.model.MemTenService;
import com.memTen.model.MemTenVO;

@WebServlet("/MemTenJsonServlet")
public class MemTenJsonServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String action = req.getParameter("action");
		
		if("getOneMember".equals(action)) {
			
			Integer mem_no = new Integer(req.getParameter("mem_no"));
			
			MemTenService memTenSvc = new MemTenService();
			MemTenVO memTenVO = memTenSvc.getOneMemTen(mem_no);
			
			String str = new Gson().toJson(memTenVO);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
		}
	}
}

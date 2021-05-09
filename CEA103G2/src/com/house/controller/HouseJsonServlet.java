package com.house.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.house.model.HouseService;
import com.house.model.HouseVO;

/**
 * Servlet implementation class HouseJsonServlet
 */
@WebServlet("/HouseJsonServlet")
public class HouseJsonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");
		if("getOneHouse".equals(action)) {
			Integer houseno = new Integer(req.getParameter("houseno"));
			HouseService svc = new HouseService();
			HouseVO housevo = svc.getOneHouse(houseno);
			String str = new Gson().toJson(housevo);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
		}
		if("getAllHouseOnLine".equals(action)) {
			HouseService svc = new HouseService();
			List<HouseVO> list = new ArrayList<HouseVO>(); 
			list =	svc.getAll();
			String str = new Gson().toJson(list);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
		}
	}

}

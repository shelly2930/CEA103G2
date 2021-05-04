package com.house.controller;

import java.io.IOException;
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HouseService svc = new HouseService();
		Integer houseno =new Integer(request.getParameter("houseno"));
		HouseVO housevo = svc.getOneHouse(houseno);
		String str = new Gson().toJson(housevo);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(str);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

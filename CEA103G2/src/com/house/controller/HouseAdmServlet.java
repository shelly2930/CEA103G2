package com.house.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.house.model.HouseService;
import com.house.model.HouseVO;
import com.google.gson.*;
/**
 * Servlet implementation class HouseAdmServlet
 */
public class HouseAdmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		if("listAllHouseByState".equals(action)) {
			try {
				HouseService svc = new HouseService();
				List<HouseVO> list = new ArrayList<HouseVO>();
				list = svc.getAllByState(0, 2);
				req.setAttribute("list", list);
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/house/listAllHouseAdm.jsp"); 
				successView.forward(req, res);
				
			}catch(Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
			
		}
	}
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			doPost(req,res);
	}

}

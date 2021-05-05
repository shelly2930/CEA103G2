package com.house.controller;

import java.io.IOException;
import java.sql.Timestamp;
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
				Byte state = null;
				Byte status = null;
				if(req.getParameter("state")==null) {
					state = 0;
				}else {
					state = new Byte(req.getParameter("state"));
				}
				if(req.getParameter("status")==null) {
					status = 2;
				}else {
					status = new Byte(req.getParameter("status"));
				}
				HouseService housesvc = new HouseService();
				List<HouseVO> list = new ArrayList<HouseVO>();
				list = housesvc.getAllByState(state, status);
				req.setAttribute("list",list);
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/house/listAllHouseAdm.jsp"); 
				successView.forward(req, res);
				
			}catch(Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
			
		}
//平台管理員 管理標題與內文
		if("changeContent".equals(action)||"sendChangeContent".equals(action)) {
			try {
				//平台管理員 可以暫時不填 故這裡不用錯誤驗證
				Integer houseno  = Integer.parseInt(req.getParameter("houseno"));
				HouseVO houseVO = null;
				String hos_name = null;
				String hos_info = null;
				List<HouseVO> list = new ArrayList<HouseVO>();
				HouseService housesvc = new HouseService();
				if(req.getParameter("hos_info")!=null && req.getParameter("hos_name")!=null) {
					hos_info = req.getParameter("hos_info");
					hos_name = req.getParameter("hos_name");
					housesvc.updateHouseContent(hos_name, hos_info, houseno);
				}
				if("changeContent".equals(action)) {
					houseVO = housesvc.getOneHouse(houseno);
					req.setAttribute("houseVO", houseVO);
					RequestDispatcher successView = req.getRequestDispatcher("/back-end/house/updateHouseForAdm.jsp"); 
					successView.forward(req, res);
					return;
				}else {
					list = housesvc.getAllByState(Byte.parseByte(req.getParameter("hos_state")), Byte.parseByte(req.getParameter("hos_status")));
					req.setAttribute("list", list);
					RequestDispatcher successView = req.getRequestDispatcher("/back-end/house/listAllHouseAdm.jsp"); 
					successView.forward(req, res);
					return;
				}
				
			}catch(Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
			
		}
		
		
		if("pushHouse".equals(action)||"pullHouse".equals(action)) {
//			try {
				Integer houseno = Integer.parseInt(req.getParameter("houseno"));
				Byte state = null;
				Byte status = null;
				Timestamp housedate =null;
				
				if("pushHouse".equals(action)) {
					state = new Byte("1");
					status = new Byte("2");
					housedate = new Timestamp(System.currentTimeMillis());
				}else {
					state = new Byte("2");
					status = new Byte("2");
					if(req.getParameter("housedate")!=null&&req.getParameter("housedate").trim().length()!=0) {
						System.out.println("S+"+housedate);
						housedate = Timestamp.valueOf(req.getParameter("housedate"));
					}else {
						housedate = Timestamp.valueOf(new String("1992-05-23 10:22:22"));
					}
				}
				System.out.println("S");
				HouseService housesvc = new HouseService();
				housesvc.updateHouseState(state, status, housedate, houseno);
				List<HouseVO> list = new ArrayList<HouseVO>();
				list = housesvc.getAllByState(state, status);
				req.setAttribute("list",list);
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/house/listAllHouseAdm.jsp"); 
				successView.forward(req, res);
				
//			}catch(Exception e) {
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/error.jsp");
//				failureView.forward(req, res);
//			}
			
		}
	}
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			doPost(req,res);
	}

}

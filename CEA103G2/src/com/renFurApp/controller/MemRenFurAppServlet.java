package com.renFurApp.controller;

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
import com.lanlord.model.LanlordService;
import com.lanlord.model.LanlordVO;
import com.renFurApp.model.RenFurAppService;
import com.renFurApp.model.RenFurAppVO;

public class MemRenFurAppServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("listRenFurAppByMem".equals(action)) {
			try {
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				
//				Byte rfa_status = null;
				Byte rfa_status = Byte.valueOf(req.getParameter("lld_status"));
				
				RenFurAppService renFurAppSvc = new RenFurAppService();
				List<RenFurAppVO> list = new ArrayList<RenFurAppVO>();
				list = renFurAppSvc.getAllByMem(mem_no, rfa_status);
				
				req.setAttribute("list",list);
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/renFurApp/listRenFurAppByMem.jsp"); 
				successView.forward(req, res);
				
			}catch(Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
			
		}
	}
}

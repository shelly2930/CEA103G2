package com.renCon.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.house.model.HouseService;
import com.lanlord.model.LanlordService;
import com.lanlord.model.LanlordVO;
import com.renCon.model.RenConService;
import com.renCon.model.RenConVO;

@WebServlet("/RenConServlet")
public class RenConServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer hos_no = new Integer(req.getParameter("hos_no"));
				
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				
				java.sql.Date rtct_eff_date = null;
				try {
					rtct_eff_date = java.sql.Date.valueOf(req.getParameter("rtct_eff_date").trim());
				} catch (IllegalArgumentException e) {
					rtct_eff_date=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				java.sql.Date rtct_tmt_date = null;
				try {
					rtct_tmt_date = java.sql.Date.valueOf(req.getParameter("rtct_apptime").trim());
				} catch (IllegalArgumentException e) {
					rtct_tmt_date=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				Integer rtct_deposit = new Integer(req.getParameter("rtct_deposit"));
				
				java.sql.Timestamp rtct_apptime = new java.sql.Timestamp(System.currentTimeMillis());
				
				RenConVO renConVO = new RenConVO();
				renConVO.setMem_no(mem_no);
				renConVO.setHos_no(hos_no);
				renConVO.setRtct_eff_date(rtct_eff_date);
				renConVO.setRtct_tmt_date(rtct_tmt_date);
				renConVO.setRtct_apptime(rtct_apptime);
				renConVO.setHos_no(hos_no);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("renConVO", renConVO); // 含有輸入格式錯誤的renConVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/renCon/addRenCon.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				RenConService renConSvc = new RenConService();
				renConVO = renConSvc.addRenCon2(mem_no, hos_no, rtct_eff_date, rtct_tmt_date, rtct_apptime, rtct_deposit);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/renCon/listAllRenCon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllRenCon.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/renCon/addRenCon.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("findByStatus".equals(action)) {
			
			try {
				
				Byte rtct_status = null;
				rtct_status = Byte.valueOf(req.getParameter("rtct_status"));
				
				RenConService renConSvc = new RenConService();
				List<RenConVO> list = new ArrayList<RenConVO>();
				list = renConSvc.findByStatus(rtct_status);
				req.setAttribute("list",list);
				
				String url = "/back-end/renCon/rentalAuth.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			
			}catch(Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/renCon/rentalAuth.jsp");
				failureView.forward(req, res);
			}
		}
		
		String pass = req.getParameter("pass");
		String fail = req.getParameter("fail");
		if ("通過".equals(pass) || "不通過".equals(fail)) {
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				Integer rtct_no = null;
				
				Byte rtct_status = null;
				
				String[] rtct_no_array = req.getParameterValues("no");
				
				if("通過".equals(pass)) {
					rtct_status = 1;
				}
				if("不通過".equals(fail)) {
					rtct_status = 3;
				}
				
				/***************************2.開始修改資料*****************************************/
				RenConService renConSvc = new RenConService();
					
				for(int i = 0; i < rtct_no_array.length; i++) {
					System.out.println(rtct_no_array[i]);
					rtct_no = new Integer(rtct_no_array[i]);
					RenConVO renConVO = renConSvc.findByPK(rtct_no);
					renConVO = renConSvc.updateStatus(rtct_no, rtct_status);
//					req.setAttribute("renConVO", renConVO);
				}
				
				List<RenConVO> list = new ArrayList<RenConVO>();
				list = renConSvc.findByStatus(rtct_status);
				req.setAttribute("list",list);
				
				String url = "/back-end/renCon/rentalAuth.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/	
			} catch (Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/renCon/rentalAuth.jsp");
				failureView.forward(req, res);
			}
		}
		
		
	}
}

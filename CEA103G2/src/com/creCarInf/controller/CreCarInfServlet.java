package com.creCarInf.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.creCarInf.model.CreCarInfService;
import com.creCarInf.model.CreCarInfVO;



public class CreCarInfServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer mem_no = new Integer(req.getParameter("mem_no").trim());
				
				String cci_name = req.getParameter("cci_name").trim();
				
				String cci_id = req.getParameter("cci_id").trim();
				String cci_idReg = "^[0-9]{16}$";
				if (!cci_id.trim().matches(cci_idReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("格式不符");
	            }
				
				java.sql.Date cci_due = null;
				try {
					cci_due = java.sql.Date.valueOf(req.getParameter("cci_due").trim());
				} catch (IllegalArgumentException e) {
					cci_due = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
								
				Integer cci_code = null;
				try {
					cci_code = new Integer(req.getParameter("cci_code").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("安全碼請填數字!");
				}

				CreCarInfVO creCarInfVO = new CreCarInfVO();
				creCarInfVO.setMem_no(mem_no);
				creCarInfVO.setCci_name(cci_name);
				creCarInfVO.setCci_id(cci_id);
				creCarInfVO.setCci_due(cci_due);
				creCarInfVO.setCci_code(cci_code);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("creCarInfVO", creCarInfVO); // 含有輸入格式錯誤的creCarInfVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/creCarInf/addCreditcard.jsp.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				CreCarInfService creCarInfSvc = new CreCarInfService();
				creCarInfVO = creCarInfSvc.addCreCarInf(mem_no, cci_name, cci_id, cci_due, cci_code);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/creCarInf/listAllCreCarInf.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllCreCarInf.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/creCarInf/addCreditcard.jsp.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer cci_no = new Integer(req.getParameter("cci_no"));
				
				/***************************2.開始刪除資料***************************************/
				CreCarInfService creCarInfSvc = new CreCarInfService();
				creCarInfSvc.deleteCreCarInf(cci_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/creCarInf/listAllCreCarInf.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/creCarInf/listAllCreCarInf.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
}

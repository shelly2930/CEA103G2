package com.renCon.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.renCon.model.RenConService;
import com.renCon.model.RenConVO;

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
				
				// 押金
				Integer rtct_deposit = new Integer(req.getParameter("rtct_deposit"));
				
				RenConVO renConVO = new RenConVO();
				renConVO.setMem_no(mem_no);
				renConVO.setHos_no(hos_no);
				renConVO.setRtct_deposit(rtct_deposit);

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
				renConVO = renConSvc.addRenCon2(mem_no, hos_no, rtct_deposit);
				
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
		
	}
}

package com.lanlord.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.bill.model.BillService;
import com.bill.model.BillVO;
import com.lanlord.model.LanlordService;
import com.lanlord.model.LanlordVO;
import com.memTen.model.MemTenVO;

public class LanlordServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("bill_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入帳單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/bill/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer bill_no = null;
				try {
					bill_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("帳單編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/bill/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				BillService billSvc = new BillService();
				BillVO billVO = billSvc.getOneBill(bill_no);
				if (billVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println("SSSSSSSs");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/bill/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("billVO", billVO); // 資料庫取出的billVO物件,存入req
				String url = "/back-end/bill/listOneBill.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				System.out.println("BBBBBB");
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/bill/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		if("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {

				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/				
				Integer mem_no = ((MemTenVO)req.getSession().getAttribute("MemTenVO")).getMem_no();
				System.out.println(mem_no);
				
				java.sql.Date lld_apptime = null;
				try {
					lld_apptime = java.sql.Date.valueOf(req.getParameter("lld_apptime").trim());
				} catch (IllegalArgumentException e) {
					lld_apptime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				String lld_bank = req.getParameter("lld_bank").trim();
				
				String lld_account = req.getParameter("lld_account").trim();
				
				Part part = req.getPart("lld_acc_pic");
				InputStream lld_acc_picin = part.getInputStream();
				byte[] lld_acc_picBuf = new byte[lld_acc_picin.available()];
				lld_acc_picin.read(lld_acc_picBuf);
				lld_acc_picin.close();
				
				LanlordVO lanlordVO = new LanlordVO();
				lanlordVO.setLld_apptime(lld_apptime);
				lanlordVO.setLld_bank(lld_bank);
				lanlordVO.setLld_account(lld_account);
				lanlordVO.setLld_acc_pic(lld_acc_picBuf);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("lanlordVO", lanlordVO); // 含有輸入格式錯誤的memTenVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/unprotected/memTen/addMemTen.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				LanlordService lanlordSvc = new LanlordService();
				lanlordVO = lanlordSvc.addLanlord(mem_no, lld_apptime, lld_bank, lld_account, lld_acc_picBuf);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/unprotected/memTen/unverify.jsp"; // 轉到註冊成功頁面?
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
			}
		}
		
		
	}
}

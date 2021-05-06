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
		
		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String str = req.getParameter("bill_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�b��s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/bill/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				Integer bill_no = null;
				try {
					bill_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("�b��s���榡�����T");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/bill/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************2.�}�l�d�߸��*****************************************/
				BillService billSvc = new BillService();
				BillVO billVO = billSvc.getOneBill(bill_no);
				if (billVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println("SSSSSSSs");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/bill/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("billVO", billVO); // ��Ʈw���X��billVO����,�s�Jreq
				String url = "/back-end/bill/listOneBill.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				System.out.println("BBBBBB");
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/bill/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		if("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {

				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/				
				Integer mem_no = ((MemTenVO)req.getSession().getAttribute("MemTenVO")).getMem_no();
				System.out.println(mem_no);
				
				java.sql.Date lld_apptime = null;
				try {
					lld_apptime = java.sql.Date.valueOf(req.getParameter("lld_apptime").trim());
				} catch (IllegalArgumentException e) {
					lld_apptime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
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
					req.setAttribute("lanlordVO", lanlordVO); // �t����J�榡���~��memTenVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/unprotected/memTen/addMemTen.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.�}�l�s�W���***************************************/
				LanlordService lanlordSvc = new LanlordService();
				lanlordVO = lanlordSvc.addLanlord(mem_no, lld_apptime, lld_bank, lld_account, lld_acc_picBuf);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/unprotected/memTen/unverify.jsp"; // �����U���\����?
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
			}
		}
		
		
	}
}

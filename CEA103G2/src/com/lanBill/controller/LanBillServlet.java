package com.lanBill.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lanBill.model.LanBillService;
import com.lanBill.model.LanBillVO;

public class LanBillServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllEmp.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				Integer lldb_no = new Integer(req.getParameter("lldb_no"));
				
				/***************************2.�}�l�d�߸��****************************************/
				LanBillService lanBillSvc = new LanBillService();
				LanBillVO lanBillVO = lanBillSvc.getOneLanBill(lldb_no);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("lanBillVO", lanBillVO);         // ��Ʈw���X��lanBillVO����,�s�Jreq
				String url = "/back-end/lanBill/update_lanBill_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_bill_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/lanBill/listAllLanBill.jsp");
				failureView.forward(req, res);
			}
		}
		
//		if ("update".equals(action)) { // �Ӧ�update_bill_input.jsp���ШD
//			
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//		
//			try {
//				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
//				Integer lldb_no = new Integer(req.getParameter("lldb_no").trim());
//
//				Integer mem_no = null;
//				try {
//					mem_no = new Integer(req.getParameter("mem_no").trim());
//				} catch (NumberFormatException e) {
//					mem_no = 1;
//					errorMsgs.add("�|���s���ж�Ʀr!");
//				}
//				
//				Integer hos_no = null;
//				try {
//					hos_no = new Integer(req.getParameter("hos_no").trim());
//				} catch (NumberFormatException e) {
//					hos_no = 1;
//				errorMsgs.add("����s���ж�Ʀr!");
//				}
//				
//				java.sql.Date bill_date = null;
//				try {
//					bill_date = java.sql.Date.valueOf(req.getParameter("bill_date").trim());
//				} catch (IllegalArgumentException e) {
//					bill_date=new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.add("�п�J���!");
//				}
//				
//				java.sql.Date bill_due = null;
//				try {
//					bill_due = java.sql.Date.valueOf(req.getParameter("bill_due").trim());
//				} catch (IllegalArgumentException e) {
//					bill_due=new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.add("�п�J���!");
//				}
//				
//				Integer bill_power = null;
//				try {
//					bill_power = new Integer(req.getParameter("bill_power").trim());
//				} catch (NumberFormatException e) {
//					bill_power = 0;
//					errorMsgs.add("����ιq�q�ж�Ʀr!");
//				}
//
//				Integer bill_water = null;
//				try {
//					bill_water = new Integer(req.getParameter("bill_water").trim());
//				} catch (NumberFormatException e) {
//					bill_water = 0;
//					errorMsgs.add("����Τ��q�ж�Ʀr!");
//				}
//				
//				Byte bill_p_status = null;
//				bill_p_status = Byte.valueOf(req.getParameter("bill_p_status").trim());
//				
//
//				Byte bill_r_status = null;
//				bill_r_status = Byte.valueOf(req.getParameter("bill_r_status").trim());
//							
//				LanBillVO lanBillVO = new LanBillVO();
//				lanBillVO.setLanBill_no(bill_no);
//				lanBillVO.setMem_no(mem_no);
//				lanBillVO.setHos_no(hos_no);
//				lanBillVO.setLanBill_date(bill_date);
//				lanBillVO.setLanBill_due(bill_due);
//				lanBillVO.setLanBill_power(bill_power);
//				lanBillVO.setLanBill_water(bill_water);
//				lanBillVO.setLanBill_p_status(bill_p_status);
//				lanBillVO.setLanBill_r_status(bill_r_status);
//				
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					System.out.println("C");
//					req.setAttribute("lanBillVO", lanBillVO); // �t����J�榡���~��lanBillVO����,�]�s�Jreq
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/back-end/bill/update_bill_input.jsp");
//					failureView.forward(req, res);
//					return; //�{�����_
//				}
//
//				/***************************2.�}�l�ק���*****************************************/
//				LanBillService billSvc = new LanBillService();
//				lanBillVO = billSvc.updateLanBill(bill_no, mem_no, hos_no, bill_date, bill_due, bill_power, bill_water, bill_p_status, bill_r_status);
//				
//				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
//				req.setAttribute("lanBillVO", lanBillVO); // ��Ʈwupdate���\��,���T����lanBillVO����,�s�Jreq
//				String url = "/back-end/bill/listOneLanBill.jsp";
//
//				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneLanBill.jsp
//				successView.forward(req, res);
//
//				/***************************��L�i�઺���~�B�z*************************************/
//			} catch (Exception e) {
//				System.out.println("FFFFFFFFF");
//				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/back-end/bill/update_bill_input.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
		
		if ("insert".equals(action)) { // �Ӧ�addEmp.jsp���ШD  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				
				Integer lld_no = new Integer(req.getParameter("lld_no").trim());
				
				Integer hos_no = null;
				try {
					hos_no = new Integer(req.getParameter("hos_no").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("����s���ж�Ʀr!");
				}
				
				java.sql.Date lldb_date = null;
				try {
					lldb_date = java.sql.Date.valueOf(req.getParameter("lldb_date").trim());
				} catch (IllegalArgumentException e) {
					lldb_date=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
				
				java.sql.Date lldb_due = null;
				try {
					lldb_due = java.sql.Date.valueOf(req.getParameter("lldb_due").trim());
				} catch (IllegalArgumentException e) {
					lldb_due=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}

				LanBillVO lanBillVO = new LanBillVO();
				lanBillVO.setLld_no(lld_no);
				lanBillVO.setHos_no(hos_no);
				lanBillVO.setLldb_date(lldb_date);
				lanBillVO.setLldb_due(lldb_due);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("lanBillVO", lanBillVO); // �t����J�榡���~��lanBillVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/bill/addLanBill.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�s�W���***************************************/
				LanBillService billSvc = new LanBillService();
				lanBillVO = billSvc.addLanBill(lld_no, hos_no, lldb_date, lldb_due);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/back-end/bill/listAllLanBill.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllLanBill.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/bill/addLanBill.jsp");
				failureView.forward(req, res);
			}
		}
	}

}

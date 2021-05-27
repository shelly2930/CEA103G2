package com.bill.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.bill.model.*;
import com.furIte.model.FurIteService;
import com.furLis.model.FurLisService;
import com.google.gson.Gson;
import com.house.model.HouseService;
import com.renFurApp.model.RenFurAppService;
import com.renFurApp.model.RenFurAppVO;
import com.renFurDet.model.RenFurDetService;
import com.renFurDet.model.RenFurDetVO;




public class BillServlet extends HttpServlet {
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
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
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
		
		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllEmp.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				Integer bill_no = new Integer(req.getParameter("bill_no"));
				
				/***************************2.�}�l�d�߸��****************************************/
				BillService billSvc = new BillService();
				BillVO billVO = billSvc.getOneBill(bill_no);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("billVO", billVO);         // ��Ʈw���X��billVO����,�s�Jreq
				String url = "/back-end/bill/update_bill_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_bill_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				System.out.println("AAAA");
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/bill/showAllBill.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // �Ӧ�update_bill_input.jsp���ШD
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				Integer bill_no = new Integer(req.getParameter("bill_no").trim());

				Integer mem_no = null;
				try {
					mem_no = new Integer(req.getParameter("mem_no").trim());
				} catch (NumberFormatException e) {
					mem_no = 1;
					errorMsgs.add("�|���s���ж�Ʀr!");
				}
				
				Integer hos_no = null;
				try {
					hos_no = new Integer(req.getParameter("hos_no").trim());
				} catch (NumberFormatException e) {
					hos_no = 1;
				errorMsgs.add("����s���ж�Ʀr!");
				}
				
				java.sql.Date bill_date = null;
				try {
					bill_date = java.sql.Date.valueOf(req.getParameter("bill_date").trim());
				} catch (IllegalArgumentException e) {
					bill_date=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
				
				java.sql.Date bill_due = null;
				try {
					bill_due = java.sql.Date.valueOf(req.getParameter("bill_due").trim());
				} catch (IllegalArgumentException e) {
					bill_due=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
				
				Integer bill_power = null;
				try {
					bill_power = new Integer(req.getParameter("bill_power").trim());
				} catch (NumberFormatException e) {
					bill_power = 0;
					errorMsgs.add("����ιq�q�ж�Ʀr!");
				}

				Integer bill_water = null;
				try {
					bill_water = new Integer(req.getParameter("bill_water").trim());
				} catch (NumberFormatException e) {
					bill_water = 0;
					errorMsgs.add("����Τ��q�ж�Ʀr!");
				}
				
				Byte bill_p_status = null;
				bill_p_status = Byte.valueOf(req.getParameter("bill_p_status").trim());
				

				Byte bill_r_status = null;
				bill_r_status = Byte.valueOf(req.getParameter("bill_r_status").trim());
							
				BillVO billVO = new BillVO();
				billVO.setBill_no(bill_no);
				billVO.setMem_no(mem_no);
				billVO.setHos_no(hos_no);
				billVO.setBill_date(bill_date);
				billVO.setBill_due(bill_due);
				billVO.setBill_power(bill_power);
				billVO.setBill_water(bill_water);
				billVO.setBill_p_status(bill_p_status);
				billVO.setBill_r_status(bill_r_status);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println("C");
					req.setAttribute("billVO", billVO); // �t����J�榡���~��billVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/bill/update_bill_input.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}

				/***************************2.�}�l�ק���*****************************************/
				BillService billSvc = new BillService();
				billVO = billSvc.update(bill_no, mem_no, hos_no, bill_date, bill_due, bill_power, bill_water, bill_p_status, bill_r_status);
				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				req.setAttribute("billVO", billVO); // ��Ʈwupdate���\��,���T����billVO����,�s�Jreq
				String url = "/back-end/bill/listOneBill.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneBill.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				System.out.println("FFFFFFFFF");
				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/bill/update_bill_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("insert".equals(action)) { // �Ӧ�addEmp.jsp���ШD  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				Integer mem_no = null;
				try {
					mem_no = new Integer(req.getParameter("mem_no").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("�|���s���ж�Ʀr!");
				}
				
				Integer hos_no = null;
				try {
					hos_no = new Integer(req.getParameter("hos_no").trim());
				} catch (NumberFormatException e) {
				errorMsgs.add("����s���ж�Ʀr!");
				}
				
				java.sql.Date bill_date = null;
				try {
					bill_date = java.sql.Date.valueOf(req.getParameter("bill_date").trim());
				} catch (IllegalArgumentException e) {
					bill_date=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
				
				java.sql.Date bill_due = null;
				try {
					bill_due = java.sql.Date.valueOf(req.getParameter("bill_due").trim());
				} catch (IllegalArgumentException e) {
					bill_due=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
				
				Integer bill_power = null;
				try {
					bill_power = new Integer(req.getParameter("bill_power").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("����ιq�q�ж�Ʀr!");
				}

				Integer bill_water = null;
				try {
					bill_water = new Integer(req.getParameter("bill_water").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("����Τ��q�ж�Ʀr!");
				}
				
				
				BillVO billVO = new BillVO();
				billVO.setMem_no(mem_no);
				billVO.setHos_no(hos_no);
				billVO.setBill_date(bill_date);
				billVO.setBill_due(bill_due);
				billVO.setBill_power(bill_power);
				billVO.setBill_water(bill_water);								

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("billVO", billVO); // �t����J�榡���~��billVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/bill/addBill.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�s�W���***************************************/
				BillService billSvc = new BillService();
				billVO = billSvc.addBill(mem_no, hos_no, bill_date, bill_due, bill_power, bill_water);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/index.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllBill.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/bill/addBill.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) { // �Ӧ�listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.�����ШD�Ѽ�***************************************/
				Integer bill_no = new Integer(req.getParameter("bill_no"));
				
				/***************************2.�}�l�R�����***************************************/
				BillService billSvc = new BillService();
				billSvc.deleteBill(bill_no);
				
				/***************************3.�R������,�ǳ����(Send the Success view)***********/								
				String url = "/back-end/bill/showAllBill.jsp";
				System.out.println("DS");
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/bill/showAllBill.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("autoInsert".equals(action)) {
			try {
				BillService billSvc = new BillService();
				int amountOfInsert = billSvc.autoAddBill();
				res.getWriter().print(amountOfInsert);
			} catch (Exception e) {
				e.printStackTrace();
				res.sendRedirect(req.getContextPath() + "/back-end/bill/showAllBill.jsp");
			}
		}
		
		if ("get_A_Bill".equals(action)) {
			try {
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				java.sql.Date bill_date = java.sql.Date.valueOf(req.getParameter("bill_date"));
				List<BillVO> list = new BillService().getMemMonthlyBill(mem_no, bill_date);
				
				req.setAttribute("list", list); // ��Ʈw���X��billVO����,�s�Jreq
				String url = "/back-end/bill/showOneBill.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();;
				res.sendRedirect(req.getContextPath() + "/back-end/bill/showAllBill.jsp");
			}
		}
		
		if ("getMemMonthlyBill".equals(action)) {
			Integer mem_no = new Integer(req.getParameter("mem_no"));
			java.sql.Date bill_date = java.sql.Date.valueOf(req.getParameter("bill_date"));
			List<BillVO> list = new BillService().getMemMonthlyBill(mem_no, bill_date);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(new Gson().toJson(list));
		}
		
		if ("send_bill".equals(action)) {
		
			try {
				Integer bill_no = new Integer(req.getParameter("bill_no").trim());
				
//				BillService billsvc = new BillService();
//				BillVO bill = billsvc.getOneBill(bill_no);
				int deadline = Integer.parseInt(req.getParameter("deadline"));
				java.sql.Date bill_due = new java.sql.Date(new Date().getTime() + deadline*24*60*60*1000);
				
				Integer bill_power = new Integer(req.getParameter("bill_power").trim());

				Integer bill_water = new Integer(req.getParameter("bill_water").trim());
				
				Byte bill_p_status = Byte.valueOf("0");

				Byte bill_r_status = Byte.valueOf("0");
							
//				BillVO billVO = new BillVO();
//				billVO.setBill_no(bill_no);
//				billVO.setBill_due(bill_due);
//				billVO.setBill_power(bill_power);
//				billVO.setBill_water(bill_water);
//				billVO.setBill_p_status(bill_p_status);
//				billVO.setBill_r_status(bill_r_status);
				
				BillService billSvc = new BillService();
				billSvc.updateBill(bill_no, bill_due, bill_power, bill_water, bill_p_status, bill_r_status);
				
				res.setCharacterEncoding("UTF-8");
				res.getWriter().print(bill_due);

			} catch (Exception e) {
				e.printStackTrace();
				res.sendRedirect(req.getContextPath() + "/back-end/bill/showAllBill.jsp");
			}
		}
		
		if ("get_Mem_Bill".equals(action)) {
			try {
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				java.sql.Date bill_date = java.sql.Date.valueOf(req.getParameter("bill_date"));
				List<BillVO> list = new BillService().getMemMonthlyBill(mem_no, bill_date);
				
				req.setAttribute("list", list); // ��Ʈw���X��billVO����,�s�Jreq
				String url = "/front-end/bill/memOneBill.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();;
				res.sendRedirect(req.getContextPath() + "/front-end/bill/memAllBill.jsp");
			}
		}
		
		if ("pay_bill".equals(action)) {
			
			try {
				Integer bill_no = new Integer(req.getParameter("bill_no").trim());
				
				BillService billSvc = new BillService();
				BillVO billVO = billSvc.getOneBill(bill_no);
				
				java.sql.Date bill_due = billVO.getBill_due();
				Integer bill_power = billVO.getBill_power();
				Integer bill_water = billVO.getBill_water();
				Byte bill_p_status = Byte.valueOf("1");
				Byte bill_r_status = Byte.valueOf("0");
				
				billSvc.updateBill(bill_no, bill_due, bill_power, bill_water, bill_p_status, bill_r_status);
				
				res.setCharacterEncoding("UTF-8");
				res.getWriter().print("ú�O���\");

			} catch (Exception e) {
				e.printStackTrace();
				res.sendRedirect(req.getContextPath() + "/back-end/bill/showAllBill.jsp");
			}
		}
	}
}

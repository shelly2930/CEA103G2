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
		
		if ("insert".equals(action)) { // �Ӧ�addEmp.jsp���ШD  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				Integer mem_no = new Integer(req.getParameter("mem_no").trim());
				
				String cci_name = req.getParameter("cci_name").trim();
				
				String cci_id = req.getParameter("cci_id").trim();
				String cci_idReg = "^[0-9]{16}$";
				if (!cci_id.trim().matches(cci_idReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�榡����");
	            }
				
				java.sql.Date cci_due = null;
				try {
					cci_due = java.sql.Date.valueOf(req.getParameter("cci_due").trim());
				} catch (IllegalArgumentException e) {
					cci_due = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
								
				Integer cci_code = null;
				try {
					cci_code = new Integer(req.getParameter("cci_code").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("�w���X�ж�Ʀr!");
				}

				CreCarInfVO creCarInfVO = new CreCarInfVO();
				creCarInfVO.setMem_no(mem_no);
				creCarInfVO.setCci_name(cci_name);
				creCarInfVO.setCci_id(cci_id);
				creCarInfVO.setCci_due(cci_due);
				creCarInfVO.setCci_code(cci_code);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("creCarInfVO", creCarInfVO); // �t����J�榡���~��creCarInfVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/creCarInf/addCreditcard.jsp.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�s�W���***************************************/
				CreCarInfService creCarInfSvc = new CreCarInfService();
				creCarInfVO = creCarInfSvc.addCreCarInf(mem_no, cci_name, cci_id, cci_due, cci_code);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/front-end/creCarInf/listAllCreCarInf.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllCreCarInf.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/creCarInf/addCreditcard.jsp.jsp");
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
				Integer cci_no = new Integer(req.getParameter("cci_no"));
				
				/***************************2.�}�l�R�����***************************************/
				CreCarInfService creCarInfSvc = new CreCarInfService();
				creCarInfSvc.deleteCreCarInf(cci_no);
				
				/***************************3.�R������,�ǳ����(Send the Success view)***********/								
				String url = "/front-end/creCarInf/listAllCreCarInf.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/creCarInf/listAllCreCarInf.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
}

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
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				Integer hos_no = new Integer(req.getParameter("hos_no"));
				
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				
				// ���
				Integer rtct_deposit = new Integer(req.getParameter("rtct_deposit"));
				
				RenConVO renConVO = new RenConVO();
				renConVO.setMem_no(mem_no);
				renConVO.setHos_no(hos_no);
				renConVO.setRtct_deposit(rtct_deposit);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("renConVO", renConVO); // �t����J�榡���~��renConVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/renCon/addRenCon.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�s�W���***************************************/
				RenConService renConSvc = new RenConService();
				renConVO = renConSvc.addRenCon2(mem_no, hos_no, rtct_deposit);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/back-end/renCon/listAllRenCon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllRenCon.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/renCon/addRenCon.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
}

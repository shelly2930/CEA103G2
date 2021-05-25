package com.renFurApp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.memTen.model.MemTenVO;
import com.renFurApp.model.RenFurAppService;
import com.renFurApp.model.RenFurAppVO;
import com.renFurDet.model.RenFurDetService;
import com.renFurDet.model.RenFurDetVO;

@WebServlet("/MemRenFurAppServlet")
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
				Integer mem_no = ((MemTenVO)req.getSession().getAttribute("MemTenVO")).getMem_no();
				
				Byte rfa_status = null;
				
				if(req.getParameter("rfa_status")==null) {
					rfa_status = 0;
				}else {
					rfa_status = new Byte(req.getParameter("rfa_status"));
				}
				
				RenFurAppService renFurAppSvc = new RenFurAppService();
				List<RenFurAppVO> list = new ArrayList<RenFurAppVO>();
				list = renFurAppSvc.getAllByMem(mem_no, rfa_status);
				System.out.println("list="+list.size());
				
				req.setAttribute("list",list);
				req.setAttribute("rfastatus", rfa_status); // �n�[�o�椣�Mjsp�줣��
				
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/renFurApp/listRenFurAppByMem.jsp"); 
				successView.forward(req, res);
				
			}catch(Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/index.jsp");
				failureView.forward(req, res);
			}
			
		}
		
		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllRenFurApp.jsp���ШD
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				Integer rfa_no = new Integer(req.getParameter("rfa_no"));
				/***************************2.�}�l�d�߸��****************************************/
				RenFurAppService renFurAppSvc = new RenFurAppService();
//�Ѧ��}�l��	 �d�@��i�ӽг���Ӧslist
RenFurAppVO renFurAppVO = renFurAppSvc.getOneRenFurApp(rfa_no);
			    
//��rfa_no�d�@��i�檺�Ҧ�����
RenFurDetService renFurDetSvc = new RenFurDetService();
				List<RenFurDetVO> list = renFurDetSvc.getOneList(rfa_no);

				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ************/
//				����listDets_by~
				req.setAttribute("listDets_ByRenFurApp", list);    // ��Ʈw���X��set����,�s�Jrequest
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("renFurAppVO", renFurAppVO);         // ��Ʈw���X��renFurAppVO����,�s�Jreq
				String url="";
//				�����ճ�������P�@�e�� �̫�A�����Ӷi�d�� ���Ӷi�קﭶ��
				if("getOne_For_Update".equals(action)){
//					url = "/back-end/renFurApp/update_renFurApp_input.jsp";
					url = "/front-end/renFurApp/renFurDetByMem.jsp";
					}
				else {
					url = "/back-end/renFurApp/listOne_renFurApp.jsp";
				}
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/renFurApp/listRenFurAppByMem.jsp");
				failureView.forward(req, res);
			}
		}
	}
}

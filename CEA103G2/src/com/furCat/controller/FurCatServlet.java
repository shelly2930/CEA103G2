package com.furCat.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.furCat.model.*;

public class FurCatServlet extends HttpServlet {

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
				String str = req.getParameter("fnt_ctgr_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�a�����O�s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furCat/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				Integer fnt_ctgr_no = null;
				try {
					fnt_ctgr_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("�a�����O�s���榡�����T");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furCat/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************2.�}�l�d�߸��*****************************************/
				FurCatService furCatSvc = new FurCatService();
				FurCatVO furCatVO = furCatSvc.getOneFurCat(fnt_ctgr_no);
				if (furCatVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furCat/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("furCatVO", furCatVO); // ��Ʈw���X��furCatVO����,�s�Jreq
				String url = "/back-end/furCat/listOneFurCat.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneFurCat.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/furCat/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllFurCat.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no"));
				
				/***************************2.�}�l�d�߸��****************************************/
				FurCatService furCatSvc = new FurCatService();
				FurCatVO furCatVO = furCatSvc.getOneFurCat(fnt_ctgr_no);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("furCatVO", furCatVO);         // ��Ʈw���X��furCatVO����,�s�Jreq
				String url = "/back-end/furCat/update_furCat_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/furCat/listAllFurCat.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("update".equals(action)) { // �Ӧ�update_emp_input.jsp���ШD
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
				
				String fnt_ctgr_name = req.getParameter("fnt_ctgr_name");
				String fnt_ctgr_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (fnt_ctgr_name == null || fnt_ctgr_name.trim().length() == 0) {
					errorMsgs.add("�a�����O�W��: �ФŪť�");
				} else if(!fnt_ctgr_name.trim().matches(fnt_ctgr_nameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�a�����O�W��: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��10����");
	            }
				
				FurCatVO furCatVO = new FurCatVO();
				furCatVO.setFnt_ctgr_no(fnt_ctgr_no);
				furCatVO.setFnt_ctgr_name(fnt_ctgr_name);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("furCatVO", furCatVO); // �t����J�榡���~��furCatVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furCat/update_furCat_input.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}
				
				/***************************2.�}�l�ק���*****************************************/
				FurCatService furCatSvc = new FurCatService();
				furCatVO = furCatSvc.updateFurCat(fnt_ctgr_no, fnt_ctgr_name);
				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				req.setAttribute("furCatVO", furCatVO); // ��Ʈwupdate���\��,���T����furCatVO����,�s�Jreq
				String url = "/back-end/furCat/listOneFurCat.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneFurCat.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/furCat/update_furCat_input.jsp");
				failureView.forward(req, res);
			}
		}

 if ("insert".equals(action)) { // �Ӧ�addFurCat.jsp���ШD  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				String fnt_ctgr_name = req.getParameter("fnt_ctgr_name");
				String fnt_ctgr_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (fnt_ctgr_name == null || fnt_ctgr_name.trim().length() == 0) {
					errorMsgs.add("�a�����O�W��: �ФŪť�");
				} else if(!fnt_ctgr_name.trim().matches(fnt_ctgr_nameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�a�����O�W��: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��10����");
	            }
				

				FurCatVO furCatVO = new FurCatVO();
				furCatVO.setFnt_ctgr_name(fnt_ctgr_name);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("furCatVO", furCatVO); // �t����J�榡���~��furCatVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furCat/addFurCat.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�s�W���***************************************/
				FurCatService furCatSvc = new FurCatService();
				furCatVO = furCatSvc.addFurCat(fnt_ctgr_name);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/back-end/furCat/listAllFurCat.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllFurCat.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/furCat/addFurCat.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("delete".equals(action)) { // �Ӧ�listAllFurCat.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.�����ШD�Ѽ�***************************************/
				Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no"));
				
				/***************************2.�}�l�R�����***************************************/
				FurCatService furCatSvc = new FurCatService();
				furCatSvc.deleteFurCat(fnt_ctgr_no);
				
				/***************************3.�R������,�ǳ����(Send the Success view)***********/								
				String url = "/back-end/furCat/listAllFurCat.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/furCat/listAllFurCat.jsp");
				failureView.forward(req, res);
			}
		}

//����~�� ���զ��\ �ݤ���ƦX�d�ߥ�
//if ("getOne_furCat".equals(action)) { // �Ӧ�listAllFurCat.jsp������~���ШD
//	System.out.println("RUN");
//	try {
//		/***************************1.�����ШD�Ѽ�****************************************/
//		//Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no"));
//		
//		/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
//		//HttpSession session=req.getSession();
//		//session.setAttribute("fnt_ctgr_no",fnt_ctgr_no);
//		String url = "/back-end/furIte/listAllFurIte.jsp";
//		RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
//		successView.forward(req, res);
//
//		/***************************��L�i�઺���~�B�z**********************************/
//	} catch (Exception e) {
//		RequestDispatcher failureView = req
//				.getRequestDispatcher("/back-end/furCat/listAllFurCat.jsp");
//		failureView.forward(req, res);
//	}
//}

	}
}

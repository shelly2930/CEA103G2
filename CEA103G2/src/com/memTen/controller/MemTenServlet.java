package com.memTen.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.memTen.model.*;
@MultipartConfig
public class MemTenServlet extends HttpServlet {

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
				String str = req.getParameter("mem_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�|���s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				Integer mem_no = null;
				try {
					mem_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("���u�s���榡�����T");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************2.�}�l�d�߸��*****************************************/
				MemTenService memTenSvc = new MemTenService();
				MemTenVO memTenVO = memTenSvc.getOneMemTen(mem_no);
				if (memTenVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("memTenVO", memTenVO); // ��Ʈw���X��memTenVO����,�s�Jreq
				String url = "/back-end/memTen/listOneMemTen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("select_page.jsp");
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
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				
				/***************************2.�}�l�d�߸��****************************************/
				MemTenService memTenSvc = new MemTenService();
				MemTenVO memTenVO = memTenSvc.getOneMemTen(mem_no);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("memTenVO", memTenVO);         // ��Ʈw���X��memTenVO����,�s�Jreq
				String url = "/front-end/memTen/update_memTen_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_memTen_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/memTen/listAllMemTen.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // �Ӧ�update_memTen_input.jsp���ШD
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				Integer mem_no = new Integer(req.getParameter("mem_no").trim());
				
				String mem_username = req.getParameter("mem_username");
				String mem_usernameReg = "^[a-zA-Z0-9_]{2,20}$";
				if (mem_username == null || mem_username.trim().length() == 0) {
					errorMsgs.add("�|���b��: �ФŪť�");
				} else if(!mem_username.trim().matches(mem_usernameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���b��: �u��O�^��r���B�Ʀr�M_ , �B���׶��b2��20����");
	            }
				
				String mem_password = req.getParameter("mem_password");
				String mem_passwordReg = "^[(a-zA-Z0-9_)]{8,20}$";
				if (mem_password == null || mem_password.trim().length() == 0) {
					errorMsgs.add("�|���K�X: �ФŪť�");
				} else if(!mem_password.trim().matches(mem_passwordReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���K�X: �K�X���]�t�^��r���B�Ʀr�M_�䤤2��, �B���׶��b8��20����");
	            }
				
				InputStream mem_picin = req.getPart("mem_pic").getInputStream();
				byte[] mem_picBuf = new byte[mem_picin.available()];
				mem_picin.read(mem_picBuf);
				
				String mem_name = req.getParameter("mem_name");
				String mem_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,60}$";
				if (mem_name == null || mem_name.trim().length() == 0) {
					errorMsgs.add("�|���m�W: �ФŪť�");
				} else if(!mem_name.trim().matches(mem_nameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���m�W: �u��O���B�^��r�� , �B���ץ����b1��60����");
	            }
				
				Byte mem_gender = null;
				mem_gender = Byte.valueOf(req.getParameter("mem_gender").trim());
				
				String mem_id = req.getParameter("mem_id");
				String mem_idReg = "^[A-Za-z][12]\\\\d{8}$";
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.add("�|�������Ҧr��: �ФŪť�");
				} else if(!mem_id.trim().matches(mem_idReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�����Ҧr���榡���~�I");
	            }
				
				java.sql.Date mem_birthday = null;
				try {
					mem_birthday = java.sql.Date.valueOf(req.getParameter("mem_birthday").trim());
				} catch (IllegalArgumentException e) {
					mem_birthday = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
				
				String mem_phone = req.getParameter(("mem_phone").trim());
				
				String mem_mobile = req.getParameter("mem_mobile");
				String mem_mobileReg = "^09[0-9]{8}$";
				if (mem_mobile == null || mem_mobile.trim().length() == 0) {
					errorMsgs.add("�|����ʹq��: �ФŪť�");
				} else if(!mem_mobile.trim().matches(mem_mobileReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|����ʹq�ܮ榡����");
	            }

				String mem_email = req.getParameter("mem_email");
				String mem_emailReg = "^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4})*$";
				if (mem_email == null || mem_email.trim().length() == 0) {
					errorMsgs.add("�|���H�c: �ФŪť�");
				} else if(!mem_email.trim().matches(mem_emailReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���H�c�榡����");
	            }
				
				String mem_addr = req.getParameter("mem_addr");
				String mem_addrReg = "^[(\u4e00-\u9fa5)(a-zA-Z)(0-9)]{1,60}$";
				if (mem_addr == null || mem_addr.trim().length() == 0) {
					errorMsgs.add("�|���a�}: �ФŪť�");
				} else if(!mem_addr.trim().matches(mem_addrReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���a�}: �u��O���B�^��r���P�Ʀr, �B���ץ����b1��60����");
	            }
				
//				Byte mem_status = null;
//				mem_status = Byte.valueOf(req.getParameter("mem_status").trim());
				
//				InputStream mem_idcard_fin = req.getPart("mem_idcard_f").getInputStream();
//				byte[] mem_idcard_fBuf = new byte[mem_idcard_fin.available()];
//				mem_idcard_fin.read(mem_idcard_fBuf);
//				byte[] mem_idcard_fBuf = new byte[2];
				
//				InputStream mem_idcard_rin = req.getPart("mem_idcard_r").getInputStream();
//				byte[] mem_idcard_rBuf = new byte[mem_idcard_rin.available()];
//				mem_idcard_rin.read(mem_idcard_rBuf);
//				byte[] mem_idcard_rBuf = new byte[2];
				
//				Byte mem_id_status = null;
//				mem_id_status = Byte.valueOf(req.getParameter("mem_id_status").trim());
				
//				String mem_suspend = req.getParameter(("mem_suspend").trim());
//				
//				String mem_refuse = req.getParameter(("mem_refuse").trim());

				MemTenVO memTenVO = new MemTenVO();
				memTenVO.setMem_no(mem_no);
				memTenVO.setMem_username(mem_username);
				memTenVO.setMem_password(mem_password);
				memTenVO.setMem_pic(mem_picBuf);
				memTenVO.setMem_name(mem_name);
				memTenVO.setMem_gender(mem_gender);
				memTenVO.setMem_id(mem_id);
				memTenVO.setMem_birthday(mem_birthday);
				memTenVO.setMem_phone(mem_phone);
				memTenVO.setMem_mobile(mem_mobile);
				memTenVO.setMem_email(mem_email);
				memTenVO.setMem_addr(mem_addr);
//				memTenVO.setMem_status(mem_status);
//				memTenVO.setMem_idcard_f(mem_idcard_fBuf);
//				memTenVO.setMem_idcard_r(mem_idcard_rBuf);
//				memTenVO.setMem_id_status(mem_id_status);
//				memTenVO.setMem_suspend(mem_suspend);
//				memTenVO.setMem_refuse(mem_refuse);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memTenVO", memTenVO); // �t����J�榡���~��memTenVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/memTen/update_memTen_input.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}
				
				/***************************2.�}�l�ק���*****************************************/
				MemTenService memTenSvc = new MemTenService();
				memTenVO = memTenSvc.updateMemTen(mem_no, mem_username, mem_password, mem_picBuf, mem_name, mem_gender, mem_id,
						mem_birthday, mem_phone, mem_mobile, mem_email, mem_addr);
				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				req.setAttribute("memTenVO", memTenVO); // ��Ʈwupdate���\��,���T����memTenVO����,�s�Jreq
				String url = "/front-end/memTen/listOneMemTen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneMemTen.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {	
				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/memTen/update_memTen_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)) { // �Ӧ�addEmp.jsp���ШD  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

//			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/				
				String mem_username = req.getParameter("mem_username");
				String mem_usernameReg = "^[a-zA-Z0-9_]{2,20}$";
				if (mem_username == null || mem_username.trim().length() == 0) {
					errorMsgs.add("�|���b��: �ФŪť�");
				} else if(!mem_username.trim().matches(mem_usernameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���b��: �u��O�^��r���B�Ʀr�M_ , �B���׶��b2��20����");
	            }
				
				String mem_password = req.getParameter("mem_password");
				String mem_passwordReg = "^[(a-zA-Z0-9_)]{8,20}$";
				if (mem_password == null || mem_password.trim().length() == 0) {
					errorMsgs.add("�|���K�X: �ФŪť�");
				} else if(!mem_password.trim().matches(mem_passwordReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���K�X: �K�X���]�t�^��r���B�Ʀr�M_�䤤2��, �B���׶��b8��20����");
	            }
				
				InputStream mem_picin = req.getPart("mem_pic").getInputStream();
				byte[] mem_picBuf = new byte[mem_picin.available()];
				mem_picin.read(mem_picBuf);
				
				String mem_name = req.getParameter("mem_name");
				String mem_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,60}$";
				if (mem_name == null || mem_name.trim().length() == 0) {
					errorMsgs.add("�|���m�W: �ФŪť�");
				} else if(!mem_name.trim().matches(mem_nameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���m�W: �u��O���B�^��r�� , �B���ץ��ݦb1��60����");
	            }
				
				Byte mem_gender = null;
				mem_gender = Byte.valueOf(req.getParameter("mem_gender").trim());
				
				String mem_id = req.getParameter("mem_id");
//				String mem_idReg = "^[A-Za-z][12]\\\\d{8}$";
//				if (mem_id == null || mem_id.trim().length() == 0) {
//					errorMsgs.add("�|�������Ҧr��: �ФŪť�");
//				} else if(!mem_id.trim().matches(mem_idReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
//					errorMsgs.add("�����Ҧr���榡���~�I");
//	            }
				
				java.sql.Date mem_birthday = null;
				try {
					mem_birthday = java.sql.Date.valueOf(req.getParameter("mem_birthday").trim());
				} catch (IllegalArgumentException e) {
					mem_birthday = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
				
				String mem_phone = req.getParameter(("mem_phone").trim());
//				String mem_phoneReg = "^[A-Za-z][12]\\\\d{8}$";
//				if (mem_phone == null || mem_phone.trim().length() == 0) {
//					errorMsgs.add("�|���p���q��: �ФŪť�");
//				} else if(!mem_phone.trim().matches(mem_phoneReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
//					errorMsgs.add("�����Ҧr���榡���~�I");
//	            }
				
				String mem_mobile = req.getParameter("mem_mobile");
				String mem_mobileReg = "^09[0-9]{8}$";
				if (mem_mobile == null || mem_mobile.trim().length() == 0) {
					errorMsgs.add("�|����ʹq��: �ФŪť�");
				} else if(!mem_mobile.trim().matches(mem_mobileReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|����ʹq�ܮ榡����");
	            }

				String mem_email = req.getParameter("mem_email");
				String mem_emailReg = "^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4})*$";
				if (mem_email == null || mem_email.trim().length() == 0) {
					errorMsgs.add("�|���H�c: �ФŪť�");
				} else if(!mem_email.trim().matches(mem_emailReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���H�c�榡����");
	            }
				
				String mem_addr = req.getParameter("mem_addr");
//				String mem_addrReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,60}$";
//				if (mem_addr == null || mem_addr.trim().length() == 0) {
//					errorMsgs.add("�|���a�}: �ФŪť�");
//				} else if(!mem_addr.trim().matches(mem_addrReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
//					errorMsgs.add("�|���a�}: �u��O���B�^��r�� , �B���ץ��ݦb1��60����");
//	            }
				
				Byte mem_status = 0;
//				mem_status = Byte.valueOf(req.getParameter("mem_status").trim());
				
//				InputStream mem_idcard_fin = req.getPart("mem_idcard_f").getInputStream();
//				byte[] mem_idcard_fBuf = new byte[mem_idcard_fin.available()];
//				mem_idcard_fin.read(mem_idcard_fBuf);
//				byte[] mem_idcard_fBuf = new byte[2];
				
//				InputStream mem_idcard_rin = req.getPart("mem_idcard_r").getInputStream();
//				byte[] mem_idcard_rBuf = new byte[mem_idcard_rin.available()];
//				mem_idcard_rin.read(mem_idcard_rBuf);
//				byte[] mem_idcard_rBuf = new byte[2];
				
				Byte mem_id_status = 0;
//				mem_id_status = Byte.valueOf(req.getParameter("mem_id_status").trim());
				
				String mem_suspend = req.getParameter(("mem_suspend").trim());
				
				String mem_refuse = req.getParameter(("mem_refuse").trim());

				MemTenVO memTenVO = new MemTenVO();
				memTenVO.setMem_username(mem_username);
				memTenVO.setMem_password(mem_password);
				memTenVO.setMem_pic(mem_picBuf);
				memTenVO.setMem_name(mem_name);
				memTenVO.setMem_gender(mem_gender);
				memTenVO.setMem_id(mem_id);
				memTenVO.setMem_birthday(mem_birthday);
				memTenVO.setMem_phone(mem_phone);
				memTenVO.setMem_mobile(mem_mobile);
				memTenVO.setMem_email(mem_email);
				memTenVO.setMem_addr(mem_addr);
				memTenVO.setMem_status(mem_status);
//				memTenVO.setMem_idcard_f(mem_idcard_fBuf);
//				memTenVO.setMem_idcard_r(mem_idcard_rBuf);
				memTenVO.setMem_id_status(mem_id_status);
				memTenVO.setMem_suspend(mem_suspend);
				memTenVO.setMem_refuse(mem_refuse);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memTenVO", memTenVO); // �t����J�榡���~��memTenVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("addMemTen.jsp");
					failureView.forward(req, res);
					return;
				}
				System.out.println("AAAAAAAAAAa");

				/***************************2.�}�l�s�W���***************************************/
				MemTenService memTenSvc = new MemTenService();
				memTenVO = memTenSvc.addMemTen(mem_username, mem_password, mem_picBuf, mem_name, mem_gender, mem_id,
						mem_birthday, mem_phone, mem_mobile, mem_email, mem_addr, mem_status, 
						mem_id_status, mem_suspend, mem_refuse);
				System.out.println("Avvvva");
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/back-end/memTen/listAllMemTen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllMemTen.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/back-end/memTen/addMemTen.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		if ("delete".equals(action)) { // �Ӧ�listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.�����ШD�Ѽ�***************************************/
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				
				/***************************2.�}�l�R�����***************************************/
				MemTenService memTenSvc = new MemTenService();
				memTenSvc.deleteMemTen(mem_no);
				
				/***************************3.�R������,�ǳ����(Send the Success view)***********/								
				String url = "/back-end/memTen/listAllMemTen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/memTen/listAllMemTen.jsp");
				failureView.forward(req, res);
			}
		}
	}
	
	
	
}

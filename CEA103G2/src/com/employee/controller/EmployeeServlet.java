package com.employee.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.JSONException;
import org.json.JSONObject;

import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.google.gson.Gson;
import com.house.model.HouseService;
import com.house.model.HouseVO;
import com.renFurApp.model.RenFurAppService;
import com.renFurApp.model.RenFurAppVO;
import com.rooVieApp.model.RooVieAppService;
import com.rooVieApp.model.RooVieAppVO;
import com.staRig.model.StaRigService;
import com.staRig.model.StaRigVO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 10 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class EmployeeServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
//		ServletContext context = getServletContext();

		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD

			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				String str = req.getParameter("emp_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.put("emp_no", "�п�J���u�s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				Integer emp_no = null;
				try {
					emp_no = new Integer(str); // str�D�Ʀr�r��ɥ�NumberFormatException
				} catch (Exception e) {
					errorMsgs.put("emp_no", "���u�s���榡�����T");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/*************************** 2.�}�l�d�߸�� *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmp(emp_no);
				if (employeeVO == null) {
					errorMsgs.put("getOneEmp", "�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) *************/
				req.setAttribute("employeeVO", employeeVO); // ��Ʈw���X��empVO����,�s�Jreq
				String url = "/back-end/employee/showOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllEmp.jsp���ШD

			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� ****************************************/
				Integer emp_no = new Integer(req.getParameter("emp_no"));

				/*************************** 2.�}�l�d�߸�� ****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmp(emp_no);
				StaRigService staRigService = new StaRigService();
				List<StaRigVO> list_StaRigVO = staRigService.getOneEmpStaRig(emp_no);
				
				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ************/
				req.setAttribute("employeeVO", employeeVO); // ��Ʈw���X��empVO����,�s�Jreq
				req.setAttribute("list_StaRigVO", list_StaRigVO);
				String url = "/back-end/employee/updateEmpData.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/showAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("updateBySup".equals(action)) { // �Ӧ�update_emp_input.jsp���ШD
			
			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				Integer emp_no = new Integer(req.getParameter("emp_no"));
				
				String emp_username = req.getParameter("emp_username");

				String emp_job = req.getParameter("emp_job").trim();
				
				java.sql.Date emp_hiredate = null;
				try {
					emp_hiredate = java.sql.Date.valueOf(req.getParameter("emp_hiredate").trim());
				} catch (IllegalArgumentException e) {
//					emp_hiredate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("emp_hiredate", "�ФŪť�");
				}
				
				java.sql.Date emp_quitdate = null;
				try {
					emp_quitdate = java.sql.Date.valueOf(req.getParameter("emp_quitdate").trim());
				} catch (IllegalArgumentException e) {
					// ��¾��i���ť�
				}
				
				String emp_email = req.getParameter("emp_email").trim();
				String emp_emailReg = "^.+@{1}.+$";
				if(!emp_email.matches(emp_emailReg)) {
					errorMsgs.put("emp_email", "�榡�����T , �����]�t\"@\"�Ÿ��B�e�ᤣ�o���ť�");
				}
				
				String emp_sal_Str = req.getParameter("emp_sal").trim();
				String emp_salReg = "^\\d*$";
				Integer emp_sal = 0;
				if (emp_sal_Str == null || (emp_sal_Str).length() == 0)
					errorMsgs.put("emp_sal", "�ФŪť�");
				else if(!emp_sal_Str.matches(emp_salReg))
					errorMsgs.put("emp_sal", "�榡�����T , �u��O�����");
				else
					emp_sal = new Integer(emp_sal_Str);
				
//				try {
//					emp_sal = new Integer(emp_sal_Str); // str�D�Ʀr�r��ɥ�NumberFormatException
//				} catch (Exception e) {
//					errorMsgs.put("emp_sal", "�榡�����T , �u��O���");
//				}
				
				String emp_bonus_Str = req.getParameter("emp_bonus").trim();
				String emp_bonusReg = "^\\d*$";
				Integer emp_bonus = 0;
				if (emp_bonus_Str == null || (emp_bonus_Str).length() == 0)
					errorMsgs.put("emp_bonus", "�ФŪť�");
				else if(!emp_bonus_Str.matches(emp_bonusReg))
					errorMsgs.put("emp_bonus", "�榡�����T , �u��O�����");
				else
					emp_bonus = new Integer(emp_bonus_Str);
				
				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(emp_no);
				employeeVO.setEmp_username(emp_username);
				employeeVO.setEmp_job(emp_job);
				employeeVO.setEmp_hiredate(emp_hiredate);
				employeeVO.setEmp_quitdate(emp_quitdate);
				employeeVO.setEmp_email(emp_email);
				employeeVO.setEmp_sal(emp_sal);
				employeeVO.setEmp_bonus(emp_bonus);
				
				
				List<Integer> list_Fun_no = new ArrayList<Integer>();
				String[] staFun = req.getParameterValues("staFun");
				for(String fun_no_Str : staFun) {
					Integer fun_no = new Integer(fun_no_Str);
					list_Fun_no.add(fun_no);
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("employeeVO", employeeVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/updateEmpData.jsp");
					failureView.forward(req, res);
					return; // �{�����_
				}

				/*************************** 2.�}�l�ק��� *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.updateBySup(emp_no, emp_job, emp_hiredate, emp_quitdate, emp_email, emp_sal, emp_bonus, list_Fun_no);

				/*************************** 3.�ק粒��,�ǳ����(Send the Success view) *************/
				req.setAttribute("employeeVO", employeeVO); // ��Ʈwupdate���\��,���T����empVO����,�s�Jreq
				req.setAttribute("updateSuccess", "updateSuccess");
				String url = "/back-end/employee/showAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneEmp.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "�ק��ƥ���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/updateEmpData.jsp");
				failureView.forward(req, res);
			}
		}

		if ("updateByEmp".equals(action)) { // �Ӧ�update_emp_input.jsp���ШD
			
			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				Integer emp_no = new Integer(req.getParameter("emp_no").trim());
				
				String emp_name = req.getParameter("emp_name").trim();
				String emp_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (emp_name == null || emp_name.length() == 0) {
					errorMsgs.put("emp_name", "�ФŪť�");
				} else if (!emp_name.matches(emp_nameReg)) { // �H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.put("emp_name", "�u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��10����");
				}
				
				Byte emp_gender = new Byte(req.getParameter("emp_gender"));
				
				String emp_id = req.getParameter("emp_id").trim().toUpperCase();
				String emp_idReg = "^[A-Z][12][\\d]{8}$";
				String str = "0123456789ABCDEFGHJKLMNPQRSTUVXYWZIO";
				if(emp_id.length() == 0) {
					errorMsgs.put("emp_id", "�ФŪť�");
				} else if(emp_id.matches(emp_idReg)) {
					int sum = 0;
					for(int i = 0; i < (emp_id.length()-1); i++) {
						int charValue = str.indexOf(emp_id.charAt(i));
						if(i == 0)
							sum += (charValue / 10 + (charValue % 10) * 9);
						else
							sum += charValue * (9 - i);
					}
					if(Character.getNumericValue(emp_id.charAt(9)) != (10 - (sum % 10)) % 10) {
						errorMsgs.put("emp_id", "�D�u�ꨭ����");
					}
				} else {
					errorMsgs.put("emp_id", "�榡���~");
				}
				
				java.sql.Date emp_birthday = null;
				try {
					emp_birthday = java.sql.Date.valueOf(req.getParameter("emp_birthday").trim());
				} catch (IllegalArgumentException e) {
					// �i���ť�
				}
				
				String emp_phone = req.getParameter("emp_phone").trim();
				
				String emp_mobile = req.getParameter("emp_mobile").trim();
				String emp_mobileReg = "^09[\\d]{8}$";
				if(emp_mobile.length() == 0) {
					errorMsgs.put("emp_mobile", "�ФŪť�");
				} else if(!emp_mobile.matches(emp_mobileReg)) {
					errorMsgs.put("emp_mobile", "�u��O09�}�Y��10�츹�X");
				}
				
				String emp_addr = req.getParameter("emp_addr").trim();

				String emp_email = req.getParameter("emp_email").trim();
				String emp_emailReg = "^.+@{1}.+$";
				if(emp_email == null || emp_email.length() == 0) {
					errorMsgs.put("emp_email", "�ФŪť�");
				}else if(!emp_email.matches(emp_emailReg)) {
					errorMsgs.put("emp_email", "�榡�����T , �����]�t\"@\"�Ÿ��B�e�ᤣ�o���ť�");
				}
				
				String emp_bank = req.getParameter("emp_bank").trim();
				if(emp_bank == null || emp_bank.length() == 0)
					errorMsgs.put("emp_bank", "�ФŪť�");
				
				String emp_account = req.getParameter("emp_account").trim();
				if(emp_account == null || emp_account.length() == 0)
					errorMsgs.put("emp_account", "�ФŪť�");
				
				Part part = req.getPart("emp_pic");
				InputStream in = part.getInputStream();
				byte[] emp_pic = null;
				if(in.available() == 0) {
					emp_pic = new EmployeeService().getOneEmp(emp_no).getEmp_pic();
				} else {
					emp_pic = new byte[in.available()];
					in.read(emp_pic);
				}
				in.close();
				
				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(emp_no);
				employeeVO.setEmp_name(emp_name);
				employeeVO.setEmp_gender(emp_gender);
				employeeVO.setEmp_id(emp_id);
				employeeVO.setEmp_birthday(emp_birthday);
				employeeVO.setEmp_phone(emp_phone);
				employeeVO.setEmp_mobile(emp_mobile);
				employeeVO.setEmp_addr(emp_addr);
				employeeVO.setEmp_email(emp_email);
				employeeVO.setEmp_bank(emp_bank);
				employeeVO.setEmp_account(emp_account);
				employeeVO.setEmp_pic(emp_pic);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("employeeVO", employeeVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/showOneEmp.jsp");
					failureView.forward(req, res);
					return; // �{�����_
				}

				/*************************** 2.�}�l�ק��� *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.updateByEmp(emp_no, emp_name, emp_gender, emp_id, emp_birthday, emp_phone, emp_mobile, emp_addr, emp_email, emp_bank, emp_account, emp_pic);
				/*************************** 3.�ק粒��,�ǳ����(Send the Success view) *************/
				session.setAttribute("employeeVO", employeeVO); // ��Ʈwupdate���\��,���T����empVO����,�s�Jreq
				req.setAttribute("updateSuccess", "updateSuccess");
				String url = "/back-end/employee/showOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneEmp.jsp
				successView.forward(req, res);
//				res.sendRedirect(req.getContextPath() + "/back-end/employee/showOneEmp.jsp");

				/*************************** ��L�i�઺���~�B�z *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "�ק��ƥ���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/showOneEmp.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // �Ӧ�addEmp.jsp���ШD

			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				String emp_username = req.getParameter("emp_username").trim();
				String emp_usernameReg = "^(\\w*[a-zA-Z]+\\w*\\d+\\w*)|(\\w*\\d+\\w*[a-zA-Z]+\\w*)$";
				if(emp_username == null || emp_username.length() == 0)
					errorMsgs.put("emp_username", "�ФŪť�");
				else if(!emp_username.matches(emp_usernameReg) || emp_username.length() < 6)
					errorMsgs.put("emp_username", "�u��O�^��r���B�Ʀr�M_ , �B���ץ����j��6�å]�t�@�ӭ^��r���Τ@�ӼƦr");
				else if(new EmployeeService().doesItExist(emp_username))
					errorMsgs.put("emp_username", "���N���w�ϥ�");
				
				String emp_job = req.getParameter("emp_job").trim();
				if(emp_job == "") {
					errorMsgs.put("emp_job", "�п��¾��");
				}
				
				StringBuffer sb = new StringBuffer();
				for(int i = 0; i < 8; i++) {
					int abc = (int)(Math.random() * 3); // �H��0-2
					switch (abc) {
					case 0:
						char a = (char)((int)(Math.random() * 10) + 48); // �H��1-9:(char)48-57
						sb.append(a);
						break;
					case 1:
						char b = (char)((int)(Math.random() * 26) + 65); // �H��A-Z:(char)65-90
						sb.append(b);
						break;
					case 2:
						char c = (char)((int)(Math.random() * 26) + 97); // �H��a-z:(char)97-122
						sb.append(c);
					}
				}
				String emp_password = sb.toString();
				
				java.sql.Date emp_hiredate = null;
				try {
					emp_hiredate = java.sql.Date.valueOf(req.getParameter("emp_hiredate").trim());
				} catch (IllegalArgumentException e) {
					emp_hiredate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("emp_hiredate", "�ФŪť�");
				}
				
				String emp_email = req.getParameter("emp_email").trim();
				String emp_emailReg = "^.+@{1}.+$";
				if(emp_email == null || emp_email.length() == 0) {
					errorMsgs.put("emp_email", "�ФŪť�");
				}else if(!emp_email.matches(emp_emailReg)) {
					errorMsgs.put("emp_email", "�榡�����T , �����]�t\"@\"�Ÿ��B�e�ᤣ�o���ť�");
				}
				
				String emp_sal_Str = req.getParameter("emp_sal").trim();
				String emp_salReg = "^\\d*$";
				Integer emp_sal = 0;
				if (emp_sal_Str == null || (emp_sal_Str).length() == 0)
					errorMsgs.put("emp_sal", "�ФŪť�");
				else if(!emp_sal_Str.matches(emp_salReg))
					errorMsgs.put("emp_sal", "�榡�����T , �u��O�����");
				else
					emp_sal = new Integer(emp_sal_Str);
				
//				try {
//					emp_sal = new Integer(emp_sal_Str); // str�D�Ʀr�r��ɥ�NumberFormatException
//				} catch (Exception e) {
//					errorMsgs.put("emp_sal", "�榡�����T , �u��O���");
//				}
					
				
				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmp_job(emp_job);
				employeeVO.setEmp_username(emp_username);
				employeeVO.setEmp_password(emp_password);
				employeeVO.setEmp_hiredate(emp_hiredate);
				employeeVO.setEmp_email(emp_email);
				employeeVO.setEmp_sal(emp_sal);

				
				List<Integer> list_Fun_no = new ArrayList<Integer>();
				String[] staFun = req.getParameterValues("staFun");
				for(String fun_no_Str : staFun) {
					Integer fun_no = new Integer(fun_no_Str);
					list_Fun_no.add(fun_no);
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("employeeVO", employeeVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/addNewEmp.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.�}�l�s�W��� ***************************************/
				// 1. �üƲ��ͱK�X password
				// 2. password --> email --> employee
				MailService mailService = new MailService();
			    String subject = "HowTrue�n��  - �s�i���u�n�J�q��";
			    String messageText = "Hello!�ܰ����z���������q���@��\n�ХѥH�U���@�����u�N���αK�X�n�J�����q�t�ΡA�íק�K�X�Χ�����g�򥻸��\n���u�N��: " + emp_username + "\n�ȮɩʱK�X: " + emp_password
			    		+ "\n�n�J���}�G" + req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath() + "/loginBack.jsp";
			    mailService.sendMail(emp_email, subject, messageText);
				// 3. password �ন�t�@�նüƦs�i��Ʈw (�w���ʰ��D)
				
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.addEmp(emp_job, emp_username, emp_password, emp_hiredate, emp_email, emp_sal, list_Fun_no);

				/*************************** 3.�s�W����,�ǳ����(Send the Success view) ***********/
				req.setAttribute("insertSuccess", "insertSuccess");
				String url = "/back-end/employee/showAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����showAllEmp.jsp
				successView.forward(req, res);
//				res.sendRedirect(req.getContextPath() + "/back-end/employee/showAllEmp.jsp");

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/addNewEmp.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // �Ӧ�listAllEmp.jsp

			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� ***************************************/
				Integer emp_no = new Integer(req.getParameter("emp_no"));

				/*************************** 2.�}�l�R����� ***************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeSvc.deleteEmp(emp_no);

				/*************************** 3.�R������,�ǳ����(Send the Success view) ***********/
				String url = "/back-end/employee/showAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "�R����ƥ���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/showAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("checkEmp_username".equals(action)) {
			PrintWriter out = res.getWriter();
			String emp_username = req.getParameter("emp_username").trim();
			if(emp_username.length() == 0) {
				out.print("�ФŪť�");
				return;
			}
			
			String emp_usernameReg = "^(\\w*[a-zA-Z]+\\w*\\d+\\w*)|(\\w*\\d+\\w*[a-zA-Z]+\\w*)$";
			if(!emp_username.matches(emp_usernameReg) || emp_username.length() < 6) {
				out.print("�u��O�^��r���B�Ʀr�M_ , �B���ץ����j��6�å]�t�@�ӭ^��r���Τ@�ӼƦr");
				return;
			}
			
			if(new EmployeeService().doesItExist(emp_username))
				out.print("���N���w�ϥ�");
			else
				out.print("�i�ϥ�");
			
//			���t�~�gdoesItExist���ܥu�༴�X�Ҧ����u�@�@���
//			List<EmployeeVO> list = new EmployeeService().getAll();
//			for(EmployeeVO employeeVO : list) {
//				if(employeeVO.getEmp_username().equals(emp_username)) {
//					out.print("�w�ϥ�");
//					return;
//				}
//			}
//			out.print("�i�ϥ�");
		}
		
		if("login".equals(action)) {
			Map<String,String> messages = new HashMap<String,String>();
			req.setAttribute("messages", messages);
			
			try {
				String emp_username = req.getParameter("emp_username").trim();
				String emp_password = req.getParameter("emp_password").trim();
				String[] rememberMe = req.getParameterValues("rememberMe");
				List<EmployeeVO> list = new EmployeeService().getAll();
				for(EmployeeVO employeeVO : list) {
					if(employeeVO.getEmp_username().equals(emp_username)) {
						if(employeeVO.getEmp_password().equals(emp_password)) {
							
							if(employeeVO.getEmp_quitdate() != null) {
								messages.put("failure", "�w��¾�L�k�n�J");
								RequestDispatcher failureView = req.getRequestDispatcher("/loginBack.jsp");
								failureView.forward(req, res);
								return;
							}
							
							session.setAttribute("employeeVO", employeeVO);
							
							StaRigService staRigService = new StaRigService();
							List<StaRigVO> list_StaRigVO = staRigService.getOneEmpStaRig(employeeVO.getEmp_no());
							List<Integer> list_Fun_no = new ArrayList<Integer>();
							for(StaRigVO staRigVO : list_StaRigVO) {
								Integer fun_no = staRigVO.getFun_no();
								list_Fun_no.add(fun_no);
							}
							session.setAttribute("list_Fun_no", list_Fun_no);
								
							if(rememberMe != null) {
								Cookie cookie = new Cookie("emp_username", emp_username);
								cookie.setMaxAge(12*60*60);
								cookie.setPath("/");
								res.addCookie(cookie);
								cookie = new Cookie("emp_no", employeeVO.getEmp_no().toString());
								cookie.setMaxAge(12*60*60);
								cookie.setPath("/");
								res.addCookie(cookie);
								
//								�U���|��N�i�H����O���n�J
//								cookie = new Cookie("JSESSIONID", session.getId());
//								cookie.setMaxAge(60);
//								cookie.setPath("/");
//								res.addCookie(cookie);
							}else {
								Cookie[] cookieList = req.getCookies();
								for(Cookie cookie : cookieList) {
									if(cookie.getName().equals("emp_username")){
										cookie.setMaxAge(0);
										cookie.setPath("/");
										res.addCookie(cookie);
									}
								}
							}
							
							
							String location = (String)session.getAttribute("location");
							session.removeAttribute("location");
							if(employeeVO.getEmp_id() == null) {
								res.sendRedirect(req.getContextPath() + "/back-end/employee/showOneEmp.jsp");
							}else if(location != null) {
								res.sendRedirect(location);
							}else {
								res.sendRedirect(req.getContextPath() + "/back-end/indexBack.jsp");
							}
							return;
						} else {
							messages.put("emp_username", emp_username);
							messages.put("rememberMe", (rememberMe == null)? null : rememberMe[0]);
							messages.put("failure", "�K�X���~");
							RequestDispatcher failureView = req.getRequestDispatcher("/loginBack.jsp");
							failureView.forward(req, res);
							return;
						}
					}
				}
				messages.put("emp_username", emp_username);
				messages.put("rememberMe", (rememberMe == null)? null : rememberMe[0]);
				
				messages.put("failure", "�L�����u�N��");
				RequestDispatcher failureView = req.getRequestDispatcher("/loginBack.jsp");
				failureView.forward(req, res);
			} catch (Exception e) {
				messages.put("failure", "�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/loginBack.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("logout".equals(action)) {
			session.invalidate();
			Cookie[] cookieList = req.getCookies();
			if(cookieList != null){
				for(Cookie cookie : cookieList) {
					if(cookie.getName().equals("emp_no")){
						cookie.setMaxAge(0);
						cookie.setPath("/");
						res.addCookie(cookie);
					}
				}
			}
			
//			RequestDispatcher failureView = req.getRequestDispatcher("/loginBack.jsp");
//			failureView.forward(req, res);
			res.sendRedirect(req.getContextPath() + "/loginBack.jsp");
		}
		
		if("sendEmail".equals(action)) {
			PrintWriter out = res.getWriter();
			
			String emp_email = req.getParameter("emp_email").trim();
			String emp_emailReg = "^.+@{1}.+$";
			if(emp_email == null || emp_email.length() == 0) {
				out.print("�ФŪť�");
			}else if(!emp_email.matches(emp_emailReg)) {
				out.print("�榡�����T , �����]�t\"@\"�Ÿ��B�e�ᤣ�o���ť�");
			}else {
				MailService mailService = new MailService();
				String emp_username = req.getParameter("emp_username");
				String emp_password = new EmployeeService().getOneEmp(new Integer(req.getParameter("emp_no"))).getEmp_password();
				String subject = "HowTrue�n��  - �s�i���u�n�J�q��";
				String messageText = "Hello!�ܰ����z���������q���@��\n�ХѥH�U���@�����u�N���αK�X�n�J�����q�t�ΡA�íק�K�X�Χ�����g�򥻸��\n���u�N��: " + emp_username + "\n�ȮɩʱK�X: " + emp_password
						+ "\n�n�J���}�G" + req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath() + "/loginBack.jsp";
				mailService.sendMail(emp_email, subject, messageText);
				out.print("�o�e���\");
			}
		}
		
		if("updatePassword".equals(action)) {
			
			PrintWriter out = res.getWriter();
			JSONObject errorMsgs = new JSONObject();
			EmployeeService employeeService = new EmployeeService();
			
			Integer emp_no = new Integer(req.getParameter("emp_no"));
			String emp_password = employeeService.getOneEmp(emp_no).getEmp_password();
			String oldPassword = req.getParameter("oldPassword").trim();
			String newPassword = req.getParameter("newPassword").trim();
			String newPasswordCheck = req.getParameter("newPasswordCheck").trim();
			String emp_passwordReg = "^(\\w*[a-zA-Z]+\\w*\\d+\\w*)|(\\w*\\d+\\w*[a-zA-Z]+\\w*)$";
			
			try {
				if(oldPassword.length() == 0)
					errorMsgs.put("oldPassword", "�ФŪť�");
				else if(!oldPassword.equals(emp_password))
					errorMsgs.put("oldPassword", "�±K�X���~");
				
				if(newPassword.length() == 0)
					errorMsgs.put("newPassword", "�ФŪť�");
				else if(newPassword.equals(emp_password))
					errorMsgs.put("newPassword", "�P�±K�X�ۦP");
				else if(!newPassword.matches(emp_passwordReg) || newPassword.length() < 6)
					errorMsgs.put("newPassword", "�u��O�^��r���B�Ʀr�M_ , �B���ץ����j��6�å]�t�@�ӭ^��r���Τ@�ӼƦr");
				
				if(newPasswordCheck.length() == 0)
					errorMsgs.put("newPasswordCheck", "�ФŪť�");
				else if(!newPasswordCheck.equals(newPassword))
					errorMsgs.put("newPasswordCheck", "�P�s�K�X����");
				
				if(errorMsgs.length() != 0) {
					out.print(errorMsgs);
				}else {
					errorMsgs.put("success", "success");
					out.print(errorMsgs);
					employeeService.updatePassword(emp_no, newPassword);
				}
					
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
		
		if("getAllRenFurAppJSON".equals(action)) {
			 List<RenFurAppVO> list = new RenFurAppService().getAll();
			 res.setContentType("application/json");
			 res.setCharacterEncoding("UTF-8");
			 res.getWriter().print(new Gson().toJson(list));
			 System.out.println("????");
		 }
		if("getAllRooVieAppJSON".equals(action)) {
			 List<RooVieAppVO> list = new RooVieAppService().getAll();
			 res.setContentType("application/json");
			 res.setCharacterEncoding("UTF-8");
			 res.getWriter().print(new Gson().toJson(list));
		}
		if("getAllHouseJSON".equals(action)) {
			List<HouseVO> list = new HouseService().getAll(); 
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(new Gson().toJson(list));
		}
		
	}
}
package com.memTen.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.lanlord.model.LanlordService;
import com.memTen.jedis.JedisHandler;
import com.memTen.model.*;
import com.renCon.model.RenConService;
import com.renCon.model.RenConVO;
import com.house.model.HouseService;
import com.house.model.HouseVO;
import com.lanlord.model.*;

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
		
		// �n�J,���~�T���令map��
		if ("login".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				// �i���o�ϥΪ� �b��(account) �K�X(password)�j
				String mem_username = req.getParameter("mem_username").trim();
				
				String mem_password = req.getParameter("mem_password").trim();
				
				/*************************** 2.�}�l�d�߸�� *****************************************/
				// �i�ˬd�ϥΪ̿�J���b��(mem_username) �K�X(mem_password)�O�_���ġj
				MemTenService memTenSvc = new MemTenService();
				MemTenVO memTenVO = memTenSvc.loginCheck(mem_username);
				
				// �U�صn�J����
				if (memTenVO == null) {
					errorMsgs.put("mem_username", "�d�L���b��");
					RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/memTen/login.jsp");
					failureView.forward(req, res);
				} else if (memTenVO.getMem_status() == 0) {
					errorMsgs.put("mem_username", "�z���b���|������");
					RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/memTen/unverify.jsp");
					failureView.forward(req, res);
				} else if (memTenVO.getMem_status() == 2) {
					errorMsgs.put("mem_username", "�z���b���w���v");
					RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/memTen/login.jsp");
					failureView.forward(req, res);
				} else if(!(mem_password.equals(memTenVO.getMem_password()))) {
					errorMsgs.put("mem_password", "�K�X���~");
					RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/memTen/login.jsp");
					failureView.forward(req, res);
				} else { // �b�K���T
					HttpSession session = req.getSession();
			
					session.setAttribute("MemTenVO", memTenVO);
					
					// �ЪF
					LanlordService lanlordSvc = new LanlordService();
					LanlordVO lanlordVO = lanlordSvc.getOneLanlordByMemTen(memTenVO.getMem_no());
					// �η|���s���ˬd�O�_���ЪF�s��
					if(lanlordVO != null) {
						session.setAttribute("lanlordVO", lanlordVO);
					}
					
					try {                                                        
				         String location = (String) session.getAttribute("location");
				         if (location != null) {
				           session.removeAttribute("location");   //*�u�@2: �ݬݦ��L�ӷ����� (-->�p���ӷ�����:�h���ɦܨӷ�����)
				           res.sendRedirect(location); // res.sendRedirect(location+"?");           
				           return;
				         }
				       }catch (Exception ignored) { 
				       
				    }
				  res.sendRedirect(req.getContextPath()+"/index.jsp");  //*�u�@3: (-->�p�L�ӷ�����:�h���ɦ�login_success.jsp)
				}
				
				
			
			/*************************** ��L�i�઺���~�B�z *************************************/	
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/memTen/login.jsp");
				failureView.forward(req, res);
			}
			
		}
		
		// �n�X
		if ("logout".equals(action)) {
			
			/***************************�}�l�d�߸�� ***************************/
			HttpSession session = req.getSession();
			if (session != null) {
				session.removeAttribute("MemTenVO");
				session.removeAttribute("lanlordSession");
				session.removeAttribute("rentCartList");
			}
			
			/****************�d�ߧ���,�ǳ����(Send the Success view)***************/
			String url = req.getContextPath()+"/index.jsp";
			res.sendRedirect(url);
			return;
		}	
		
		// �ѰO�K�X
		if ("forgetPwd".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			

			/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
			String mem_username = req.getParameter("mem_username").trim();
			
			String mem_email = req.getParameter("mem_email").trim();
			/*************************** 2.�}�l�d�߸�� *****************************************/
			MemTenService memTenSvc = new MemTenService();
			MemMailService mms = new MemMailService();
			
			MemTenVO memTenVO = memTenSvc.findByEmail(mem_username,mem_email);
			
			if(memTenVO == null || mem_username.length() == 0 || mem_email.length() == 0) {
				errorMsgs.put("mem_username", "�b���ιq�l�H�c���~");
				RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/memTen/forgetPwd.jsp");
				failureView.forward(req, res);
			}else {
				String to = mem_email;
				String subject = "HowTrue�n���{�ɱK�X";
				
				String temPwd = JedisHandler.randAuthCode();
				String messageText = memTenVO.getMem_username() + "�z�n:\n\n"
						+ "�H�U�O�z���{�ɱK�X�A�ХΦ��K�X�n�J��A�ܷ|���M�ϭ��]�z���K�X:\n\n"
						+ temPwd + "\n\n" + "HowTrue�n��ζ��q�W�C";

				mms.sendMail(to, subject, messageText);

				// �K�X�ܧ��{�ɱK�XtemPwd
				memTenSvc.updatePwd(mem_email, temPwd);
				
				RequestDispatcher SuccessView = req.getRequestDispatcher("/unprotected/memTen/forgetPwd_email_send.jsp");
				SuccessView.forward(req, res);
				return;
			}
		}
		
		if ("sendAuthMail".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				String mem_username = req.getParameter("mem_username").trim();
				
				/*************************** 2.�}�l�s�W��� ***************************************/
				MemTenService memTenSvc = new MemTenService();
				MemTenVO memTenVO = memTenSvc.loginCheck(mem_username);
				
				// �H�e���ҫH��
				MemMailService mms = new MemMailService();
				
				// �����H���{�ҽX�s�Jredis
				JedisHandler jh = new JedisHandler();				
				String authCode = jh.setAuthCode(mem_username);
				
				String to = memTenVO.getMem_email();
				String subject = "HowTrue�n��|���b�����ҳq���H";
				String messageText = mem_username + "�z�n :\n\n" 
						+ "�P�±z�ϥΡiHowTrue�n��j�A���F�T�{�z����ƥ��T�ʡA���O�ݭn���ҫ�~��ҥαz���b���C\n\n" 
						+ "���I���H�U�s���i������ :\n" 
						+ req.getScheme() + "://" + req.getServerName() + ":"  + req.getServerPort()
						+ req.getContextPath() + req.getServletPath() + "?action=verify&mem_username="
						+ mem_username + "&authCode=" + authCode + "\n\n"
						+ "HowTrue�n��ζ��q�W�C";
				
				mms.sendMail(to, subject, messageText);
				
				/*************************** 3.�s�W����,�ǳ����(Send the Success view) ***********/
				req.setAttribute("mem_username", mem_username);
				String url = "/unprotected/memTen/unverify.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add("Exception" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/index.jsp");
				failureView.forward(req, res);
			}
		}
		
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
				String url = "/front-end/memTen/listOneMemTen.jsp";
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
		
		// �|���M�ϭק�ӤH���
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
						.getRequestDispatcher("/front-end/memTen/listOneMemTen.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Rental".equals(action)) { // �Ӧ�listAllEmp.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				
				Integer hos_no = new Integer(req.getParameter("hos_no"));
				
				/***************************2.�}�l�d�߸��****************************************/
				HouseService houseSvc = new HouseService();
				HouseVO houseVO = houseSvc.getOneHouse(hos_no);
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("houseVO", houseVO);
				
				req.getSession().setAttribute("hos_no", hos_no);
				
				String url = "/front-end/memTen/rentalConfirm.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_memTen_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/memTen/listOneMemTen.jsp");
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
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				
				String mem_username = req.getParameter("mem_username");
//				String mem_usernameReg = "^[a-zA-Z0-9_]{2,20}$";
//				if (mem_username == null || mem_username.trim().length() == 0) {
//					errorMsgs.add("�|���b��: �ФŪť�");
//				} else if(!mem_username.trim().matches(mem_usernameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
//					errorMsgs.add("�|���b��: �u��O�^��r���B�Ʀr�M_ , �B���׶��b2��20����");
//	            }
				
				String mem_password = req.getParameter("mem_password");
				String mem_passwordReg = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}|"
						+ "(?=.*[@$!%*#?&_-])(?=.*\\d)[\\d@$!%*#?&_-]{8,}|"
						+ "(?=.*[@$!%*#?&_-])(?=.*[A-Za-z])[A-Za-z@$!%*#?&_-]{8,}|"
						+ "(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&_-])[A-Za-z\\d@$!%*#?&_-]{8,}$"; // �^��r���P�Ʀr
//				String mem_passwordReg2 = "^(?=.*[@$!%*#?&_-])(?=.*\\d)[\\d@$!%*#?&_-]{8,}$"; // �Ʀr�P�S��Ÿ�
//				String mem_passwordReg3 = "^(?=.*[@$!%*#?&_-])(?=.*[A-Za-z])[A-Za-z@$!%*#?&_-]{8,}$"; // �^��r���P�Ÿ�
//				String mem_passwordReg4 = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&_-])[A-Za-z\\d@$!%*#?&_-]{8,}$"; // �^��r���P�Ʀr�P�Ÿ�
				if (mem_password == null || mem_password.trim().length() == 0) {
					errorMsgs.add("�|���K�X: �ФŪť�");
				} else if(!mem_password.trim().matches(mem_passwordReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���K�X: �K�X���]�t�^��r���B�Ʀr�M�S��Ÿ�(�p_)�ܤ֨䤤2��, �B���׶��b8�H�W");
	            }
				
				// �Y�L��ܹϤ��A�h�|��쥻����
				Part part = req.getPart("mem_pic");
				InputStream mem_picin = part.getInputStream();
				byte[] mem_picBuf = null;
				if(mem_picin.available() == 0) {
					mem_picBuf = new MemTenService().getOneMemTen(mem_no).getMem_pic();
			    } else {
			    	mem_picBuf = new byte[mem_picin.available()];
			    	mem_picin.read(mem_picBuf);
			    }
				mem_picin.close();
				
				String mem_name = req.getParameter("mem_name");
				String mem_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,60}$";
				if (mem_name == null || mem_name.trim().length() == 0) {
					errorMsgs.add("�|���m�W: �ФŪť�");
				} else if(!mem_name.trim().matches(mem_nameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���m�W: �u��O���B�^��r�� , �B���ץ����b1��60����");
	            }
				
				Byte mem_gender = null;
				mem_gender = Byte.valueOf(req.getParameter("mem_gender").trim());
				
				//�S�g�ˬd�X����
				String mem_id = req.getParameter("mem_id");
				String mem_idReg = "^[A-Za-z][12][\\d]{8}$";
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
				String mem_emailReg = "^(.+)@(.+)$";
				if (mem_email == null || mem_email.trim().length() == 0) {
					errorMsgs.add("�|���H�c: �ФŪť�");
				} else if(!mem_email.trim().matches(mem_emailReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���H�c�榡����");
	            }
				
				String mem_city = req.getParameter(("county"));
//				System.out.println(mem_city);
				String mem_dist = req.getParameter(("district"));
				
//				String mem_city = req.getParameter(("mem_city"));
//				if (mem_city == null || mem_city.trim().length() == 0) {
//					errorMsgs.add("�ФŪť�");
//				}
//				
//				String mem_dist = req.getParameter(("mem_dist"));
//				if (mem_dist == null || mem_dist.trim().length() == 0) {
//					errorMsgs.add("�ФŪť�");
//				}
				
				String mem_addr = req.getParameter(("mem_addr").trim());
				
//				Byte mem_status = null;
//				mem_status = Byte.valueOf(req.getParameter("mem_status").trim());
				
				Part idcard_fpart = req.getPart("mem_idcard_f");
				InputStream mem_idcard_fin = idcard_fpart.getInputStream();
				byte[] mem_idcard_fBuf = null;
				if(mem_idcard_fin.available() == 0) {
					mem_idcard_fBuf = new MemTenService().getOneMemTen(mem_no).getMem_idcard_f();
			    } else {
			    	mem_idcard_fBuf = new byte[mem_idcard_fin.available()];
			    	mem_idcard_fin.read(mem_idcard_fBuf);
			    }
				mem_idcard_fin.close();
				
				Part idcard_rpart = req.getPart("mem_idcard_r");
				InputStream mem_idcard_rin = idcard_rpart.getInputStream();
				byte[] mem_idcard_rBuf = null;
				if(mem_idcard_rin.available() == 0) {
					mem_idcard_rBuf = new MemTenService().getOneMemTen(mem_no).getMem_idcard_r();
			    } else {
			    	mem_idcard_rBuf = new byte[mem_idcard_rin.available()];
			    	mem_idcard_rin.read(mem_idcard_rBuf);
			    }
				mem_idcard_rin.close();
				
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
				memTenVO.setMem_city(mem_city);
				memTenVO.setMem_dist(mem_dist);
				memTenVO.setMem_addr(mem_addr);
//				memTenVO.setMem_status(mem_status);
				memTenVO.setMem_idcard_f(mem_idcard_fBuf);
				memTenVO.setMem_idcard_r(mem_idcard_rBuf);
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
				memTenVO = memTenSvc.updateMemTen(mem_no,mem_username, mem_password, mem_picBuf, mem_name,
								mem_gender, mem_id, mem_birthday, mem_phone, mem_mobile, mem_email, mem_city,
								mem_dist, mem_addr, mem_idcard_fBuf, mem_idcard_rBuf);
				
				HttpSession session = req.getSession();
				
				session.setAttribute("MemTenVO", memTenVO);
				
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
		
		// ���ЮɽT�{���
		if("rentalConfirm".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				
				Integer hos_no = new Integer(req.getParameter("hos_no"));
				
				Integer rtct_deposit = new Integer(req.getParameter("hos_rent")) * 2;
				
				java.sql.Date rtct_eff_date = null;
				try {
					rtct_eff_date = java.sql.Date.valueOf(req.getParameter("rtct_eff_date").trim());
				} catch (IllegalArgumentException e) {
					rtct_eff_date = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
				
				java.sql.Date rtct_end_date = java.sql.Date.valueOf(req.getParameter("rtct_end_date").trim());
				
				java.sql.Timestamp rtct_apptime = new java.sql.Timestamp(System.currentTimeMillis());
				
				String mem_name = req.getParameter("mem_name");
				String mem_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,60}$";
				if (mem_name == null || mem_name.trim().length() == 0) {
					errorMsgs.add("�|���m�W: �ФŪť�");
				} else if(!mem_name.trim().matches(mem_nameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���m�W: �u��O���B�^��r�� , �B���ץ����b1��60����");
	            }
				
				//�S�g�ˬd�X����
				String mem_id = req.getParameter("mem_id");
				String mem_idReg = "^[A-Za-z][12][\\d]{8}$";
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.add("�|�������Ҧr��: �ФŪť�");
				} else if(!mem_id.trim().matches(mem_idReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�����Ҧr���榡���~�I");
	            }
				
				String mem_mobile = req.getParameter("mem_mobile");
				String mem_mobileReg = "^09[0-9]{8}$";
				if (mem_mobile == null || mem_mobile.trim().length() == 0) {
					errorMsgs.add("�|����ʹq��: �ФŪť�");
				} else if(!mem_mobile.trim().matches(mem_mobileReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|����ʹq�ܮ榡����");
	            }
				
				String mem_city = req.getParameter(("county"));
//				System.out.println(mem_city);
				String mem_dist = req.getParameter(("district"));
				
//				String mem_city = req.getParameter(("mem_city"));
//				if (mem_city == null || mem_city.trim().length() == 0) {
//					errorMsgs.add("�ФŪť�");
//				}
//				
//				String mem_dist = req.getParameter(("mem_dist"));
//				if (mem_dist == null || mem_dist.trim().length() == 0) {
//					errorMsgs.add("�ФŪť�");
//				}
				
				String mem_addr = req.getParameter(("mem_addr").trim());
				
				Part idcard_fpart = req.getPart("mem_idcard_f");
				InputStream mem_idcard_fin = idcard_fpart.getInputStream();
				byte[] mem_idcard_fBuf = null;
				if(mem_idcard_fin.available() == 0) {
					mem_idcard_fBuf = new MemTenService().getOneMemTen(mem_no).getMem_idcard_f();
			    } else {
			    	mem_idcard_fBuf = new byte[mem_idcard_fin.available()];
			    	mem_idcard_fin.read(mem_idcard_fBuf);
			    }
				mem_idcard_fin.close();
				
				Part idcard_rpart = req.getPart("mem_idcard_r");
				InputStream mem_idcard_rin = idcard_rpart.getInputStream();
				byte[] mem_idcard_rBuf = null;
				if(mem_idcard_rin.available() == 0) {
					mem_idcard_rBuf = new MemTenService().getOneMemTen(mem_no).getMem_idcard_r();
			    } else {
			    	mem_idcard_rBuf = new byte[mem_idcard_rin.available()];
			    	mem_idcard_rin.read(mem_idcard_rBuf);
			    }
				mem_idcard_rin.close();
				
				// ���ЮɤW���ҥ��,���A�אּ���f��
				Byte mem_id_status = 1;
				
				MemTenVO memTenVO = new MemTenVO();
				memTenVO.setMem_no(mem_no);
				memTenVO.setMem_name(mem_name);
				memTenVO.setMem_id(mem_id);
				memTenVO.setMem_mobile(mem_mobile);
				memTenVO.setMem_city(mem_city);
				memTenVO.setMem_dist(mem_dist);
				memTenVO.setMem_addr(mem_addr);
				memTenVO.setMem_idcard_f(mem_idcard_fBuf);
				memTenVO.setMem_idcard_r(mem_idcard_rBuf);
				memTenVO.setMem_id_status(mem_id_status);
				
				RenConVO renConVO = new RenConVO();
				renConVO.setRtct_deposit(rtct_deposit);
				renConVO.setRtct_eff_date(rtct_eff_date);
				renConVO.setRtct_end_date(rtct_end_date);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memTenVO", memTenVO); // �t����J�榡���~��memTenVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/memTen/rentalConfirm.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}
				
				/***************************2.�}�l�ק���*****************************************/
				MemTenService memTenSvc = new MemTenService();
				memTenVO = memTenSvc.rentalConfirm(mem_no, mem_name, mem_id, mem_mobile, mem_city,
								mem_dist, mem_addr, mem_idcard_fBuf, mem_idcard_rBuf, mem_id_status);
				// 
				RenConService renConSvc = new RenConService();
				renConVO = renConSvc.addRenCon2(hos_no, mem_no, rtct_eff_date, rtct_end_date, rtct_apptime, rtct_deposit);
				
				HttpSession session = req.getSession();
				
				session.setAttribute("MemTenVO", memTenVO);
				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				req.setAttribute("memTenVO", memTenVO); // ��Ʈwupdate���\��,���T����memTenVO����,�s�Jreq
				req.setAttribute("renConVO", renConVO);
				
				String url = "/index.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneMemTen.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {	
				System.out.println("xxxxxxxxxx");
				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/index.jsp");
				failureView.forward(req, res);
			}
		}
		
		// �|�����U
		if ("insert".equals(action)) { // �Ӧ�addEmp.jsp���ШD  
			
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/				
				String mem_username = req.getParameter("mem_username");
				String mem_usernameReg = "^[a-zA-Z0-9_]{2,20}$";
				if (mem_username == null || mem_username.trim().length() == 0) {
					errorMsgs.put("mem_username", "�ФŪť�");
				} else if(!mem_username.trim().matches(mem_usernameReg)) {
					errorMsgs.put("mem_username", "�u��O�^��r���B�Ʀr�M_ , �B���׶��b2��20����");
	            }
				
				String mem_password = req.getParameter("mem_password");
				String mem_passwordReg = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}|(?=.*[@$!%*#?&_-])(?=.*\\d)[\\d@$!%*#?&_-]{8,}|(?=.*[@$!%*#?&_-])(?=.*[A-Za-z])[A-Za-z@$!%*#?&_-]{8,}|(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&_-])[A-Za-z\\d@$!%*#?&_-]{8,}$"; // �^��r���P�Ʀr
//				String mem_passwordReg2 = "^(?=.*[@$!%*#?&_-])(?=.*\\d)[\\d@$!%*#?&_-]{8,}$"; // �Ʀr�P�S��Ÿ�
//				String mem_passwordReg3 = "^(?=.*[@$!%*#?&_-])(?=.*[A-Za-z])[A-Za-z@$!%*#?&_-]{8,}$"; // �^��r���P�Ÿ�
//				String mem_passwordReg4 = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&_-])[A-Za-z\\d@$!%*#?&_-]{8,}$"; // �^��r���P�Ʀr�P�Ÿ�
				if (mem_password == null || mem_password.trim().length() == 0) {
					errorMsgs.put("mem_password", "�ФŪť�");
				} else if(!mem_password.trim().matches(mem_passwordReg)) {
					errorMsgs.put("mem_password", "�K�X���]�t�^��r���B�Ʀr�M�S��Ÿ�(�p_)�ܤ֨䤤2��, �B���׶��b8�H�W");
	            }
				
				Part part = req.getPart("mem_pic");
				InputStream mem_picin = part.getInputStream();
				byte[] mem_picBuf = new byte[mem_picin.available()];
				mem_picin.read(mem_picBuf);
				mem_picin.close();
				
				String mem_name = req.getParameter("mem_name");
				String mem_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,60}$";
				if (mem_name == null || mem_name.trim().length() == 0) {
					errorMsgs.put("mem_name", "�ФŪť�");
				} else if(!mem_name.trim().matches(mem_nameReg)) {
					errorMsgs.put("mem_name", "�u��O���B�^��r�� ");
	            }
				
				Byte mem_gender = null;
				mem_gender = Byte.valueOf(req.getParameter("mem_gender").trim());
				
				String mem_id = req.getParameter("mem_id");
				String mem_idReg = "^[A-Za-z][12]\\d{8}$";
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.put("mem_id", "�ФŪť�");
				} else if(!mem_id.trim().matches(mem_idReg)) {
					errorMsgs.put("mem_id", "�����Ҧr���榡���~�I");
	            }
				
				java.sql.Date mem_birthday = null;
				try {
					mem_birthday = java.sql.Date.valueOf(req.getParameter("mem_birthday").trim());
				} catch (IllegalArgumentException e) {
					mem_birthday = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("mem_birthday", "�п�J���");
				}
				
				String mem_phone = req.getParameter(("mem_phone").trim());
				
				String mem_mobile = req.getParameter("mem_mobile");
				String mem_mobileReg = "^09[0-9]{8}$";
				if (mem_mobile == null || mem_mobile.trim().length() == 0) {
					errorMsgs.put("mem_mobile", "�ФŪť�");
				} else if(!mem_mobile.trim().matches(mem_mobileReg)) {
					errorMsgs.put("mem_mobile", "�q�ܮ榡����");
	            }

				String mem_email = req.getParameter("mem_email");
				String mem_emailReg = "^(.+)@(.+)$";
				if (mem_email == null || mem_email.trim().length() == 0) {
					errorMsgs.put("mem_email", "�ФŪť�");
				} else if(!mem_email.trim().matches(mem_emailReg)) {
					errorMsgs.put("mem_email", "�H�c�榡����");
	            }
//				System.out.println("aaaaaaaaaaa");
//				String mem_city = req.getParameter(("county"));
//				System.out.println(mem_city);
//				String mem_dist = req.getParameter(("district"));
//				System.out.println(mem_dist);
				
				String mem_city = req.getParameter(("mem_city"));
				if (mem_city == null || mem_city.trim().length() == 0) {
					errorMsgs.put("mem_city", "�ФŪť�");
				}
				
				String mem_dist = req.getParameter(("mem_dist"));
				if (mem_dist == null || mem_dist.trim().length() == 0) {
					errorMsgs.put("mem_dist", "�ФŪť�");
				}
				
				String mem_addr = req.getParameter(("mem_addr").trim());

				MemTenVO memVO = new MemTenVO();
				memVO.setMem_username(mem_username);
				memVO.setMem_password(mem_password);
				memVO.setMem_pic(mem_picBuf);
				memVO.setMem_name(mem_name);
				memVO.setMem_gender(mem_gender);
				memVO.setMem_id(mem_id);
				memVO.setMem_birthday(mem_birthday);
				memVO.setMem_phone(mem_phone);
				memVO.setMem_mobile(mem_mobile);
				memVO.setMem_email(mem_email);
				memVO.setMem_city(mem_city);
				memVO.setMem_dist(mem_dist);
				memVO.setMem_addr(mem_addr);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memVO", memVO); // �t����J�榡���~��memTenVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/unprotected/memTen/addMemTen.jsp");
					failureView.forward(req, res);
					return;
				}

				/***************************2.�}�l�s�W���***************************************/
				MemTenService memTenSvc = new MemTenService();
				memVO = memTenSvc.addMemTen(mem_username, mem_password, mem_picBuf, mem_name, mem_gender, mem_id,
						mem_birthday, mem_phone, mem_mobile, mem_email, mem_city, mem_dist, mem_addr);
				
				// �H�e���ҫH��
				MemMailService mms = new MemMailService();
				
				// �����H���{�ҽX�s�Jredis
				JedisHandler jh = new JedisHandler();				
				String authCode = jh.setAuthCode(mem_username);
				
				String to = mem_email;
				String subject = "HowTrue�n��|���b�����ҳq���H";
				String messageText = mem_username + "�z�n :\n\n" 
						+ "�P�±z�ϥΡiHowTrue�n��j�A���F�T�{�z����ƥ��T�ʡA���O�ݭn���ҫ�~��ҥαz���b���C\n\n" 
						+ "���I���H�U�s���i������ :\n" 
						+ req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() 
						+ req.getContextPath() + req.getServletPath() + "?action=verify&mem_username="
						+ mem_username + "&authCode=" + authCode + "\n\n"
						+ "HowTrue�n��ζ��q�W�C";
				
				mms.sendMail(to, subject, messageText);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/unprotected/memTen/unverify.jsp"; // �����U���\����?
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.put("errorMsgs",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/unprotected/memTen/addMemTen.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("verify".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
			String mem_username = req.getParameter("mem_username");
			
			String authCode = req.getParameter("authCode");
			
			String savedCode = JedisHandler.getAuthCode(mem_username);
			if (savedCode == null) {
				errorMsgs.add("���ҫH�w�L���A�Э��s�ӽ�");
			} else if (savedCode.equals(authCode)){
				System.out.println("���Ҧ��\!");
				MemTenService memTenSvc = new MemTenService();
				memTenSvc.updateMemStatus(mem_username, (byte) 1);
			} else {
				errorMsgs.add("���Ҧ��~�A�Э��s�ӽ�");
			}
			/*************************** 3.�s�W����,�ǳ����(Send the Success view) ***********/
			String url = "/unprotected/memTen/verify.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
			successView.forward(req, res);
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

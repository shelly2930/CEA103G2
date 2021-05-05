package com.memTen.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.memTen.model.*;

import jedis.JedisHandler;
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
		
		// 登入,錯誤訊息改成map版
		if ("login".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				// 【取得使用者 帳號(account) 密碼(password)】
				String mem_username = req.getParameter("mem_username").trim();
				
				String mem_password = req.getParameter("mem_password").trim();
				
				/*************************** 2.開始查詢資料 *****************************************/
				// 【檢查使用者輸入的帳號(mem_username) 密碼(mem_password)是否有效】
				MemTenService memTenSvc = new MemTenService();
				MemTenVO memTenVO = memTenSvc.loginCheck(mem_username);
				
				// 各種登入失敗
				if (memTenVO == null) {
					errorMsgs.put("mem_username", "查無此帳號");
					RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/login.jsp");
					failureView.forward(req, res);
				} else if (memTenVO.getMem_status() == 0) {
					errorMsgs.put("mem_username", "您的帳號尚未驗證");
					RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/unverify.jsp");
					failureView.forward(req, res);
				} else if (memTenVO.getMem_status() == 2) {
					errorMsgs.put("mem_username", "您的帳號已停權");
					RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/login.jsp");
					failureView.forward(req, res);
				} else if(!(mem_password.equals(memTenVO.getMem_password()))) {
					errorMsgs.put("mem_password", "密碼錯誤");
					RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/login.jsp");
					failureView.forward(req, res);
				} else { // 帳密正確
					HttpSession session = req.getSession();
					session.setAttribute("MemTenVO", memTenVO);
					
					try {                                                        
				         String location = (String) session.getAttribute("location");
				         if (location != null) {
				           session.removeAttribute("location");   //*工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)
				           res.sendRedirect(location);            
				           return;
				         }
				       }catch (Exception ignored) { 
				       
				    }
				  res.sendRedirect(req.getContextPath()+"/front-end/memTen/login_success.jsp");  //*工作3: (-->如無來源網頁:則重導至login_success.jsp)
				}
				
				
			
			/*************************** 其他可能的錯誤處理 *************************************/	
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/login.jsp");
				failureView.forward(req, res);
			}
			
		}
		
		// 登出
		if ("logout".equals(action)) {
			
			/***************************開始查詢資料 ***************************/
			HttpSession session = req.getSession();
			if (session != null) {
				session.removeAttribute("MemTenVO");
			}
			
			/****************查詢完成,準備轉交(Send the Success view)***************/
			String url = req.getContextPath()+"/index.jsp";
			res.sendRedirect(url);
			return;
		}	
		
		// 忘記密碼
		if ("forgetPwd".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String mem_email = req.getParameter("mem_email").trim();
			/*************************** 2.開始查詢資料 *****************************************/
			MemTenService memTenSvc = new MemTenService();
			MemMailService mms = new MemMailService();
			
			MemTenVO memTenVO = memTenSvc.findByEmail(mem_email);
			
			if (memTenVO != null) {
			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				
				String to = mem_email;
				String subject = "HowTrue好厝臨時密碼";
				
				String temPwd = JedisHandler.randAuthCode();
				String messageText = memTenVO.getMem_username() + "您好:\n\n"
						+ "以下是您的臨時密碼，請用此密碼登入後，至會員專區重設您的密碼:\n\n"
						+ temPwd + "\n\n" + "HowTrue好厝團隊敬上。";

				mms.sendMail(to, subject, messageText);

				// 密碼變更為臨時密碼temPwd
				memTenSvc.updatePwd(mem_email, temPwd);
				
				RequestDispatcher SuccessView = req.getRequestDispatcher("/unprotected/forgetPwd_email_send.jsp");
				SuccessView.forward(req, res);
				return;
			
			} else {
				errorMsgs.add("信箱不存在");
				RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/forgetPwd.jsp");
				failureView.forward(req, res);
				return;
			}
		}
		
		if ("sendAuthMail".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String mem_username = req.getParameter("mem_username").trim();
				
				/*************************** 2.開始新增資料 ***************************************/
				MemTenService memTenSvc = new MemTenService();
				MemTenVO memTenVO = memTenSvc.loginCheck(mem_username);
				
				// 寄送驗證信件
				MemMailService mms = new MemMailService();
				
				// 產生隨機認證碼存入redis
				JedisHandler jh = new JedisHandler();				
				String authCode = jh.setAuthCode(mem_username);
				
				String to = memTenVO.getMem_email();
				String subject = "HowTrue好厝會員帳號驗證通知信";
				String messageText = mem_username + "您好 :\n\n" 
						+ "感謝您使用【HowTrue好厝】，為了確認您的資料正確性，平臺需要驗證後才能啟用您的帳號。\n\n" 
						+ "請點擊以下連結進行驗證 :\n" 
						+ req.getScheme() + "://" + req.getServerName() + ":"  + req.getServerPort()
						+ req.getContextPath() + req.getServletPath() + "?action=verify&mem_username="
						+ mem_username + "&authCode=" + authCode + "\n\n"
						+ "HowTrue好厝團隊敬上。";
				
				mms.sendMail(to, subject, messageText);
				
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("mem_username", mem_username);
				String url = "/unprotected/unverify.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add("Exception" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/index.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("mem_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer mem_no = null;
				try {
					mem_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				MemTenService memTenSvc = new MemTenService();
				MemTenVO memTenVO = memTenSvc.getOneMemTen(mem_no);
				if (memTenVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("memTenVO", memTenVO); // 資料庫取出的memTenVO物件,存入req
				String url = "/front-end/memTen/listOneMemTen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				
				/***************************2.開始查詢資料****************************************/
				MemTenService memTenSvc = new MemTenService();
				MemTenVO memTenVO = memTenSvc.getOneMemTen(mem_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("memTenVO", memTenVO);         // 資料庫取出的memTenVO物件,存入req
				String url = "/front-end/memTen/update_memTen_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_memTen_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/memTen/listAllMemTen.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自update_memTen_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer mem_no = new Integer(req.getParameter("mem_no").trim());
				
				String mem_username = req.getParameter("mem_username");
				String mem_usernameReg = "^[a-zA-Z0-9_]{2,20}$";
				if (mem_username == null || mem_username.trim().length() == 0) {
					errorMsgs.add("會員帳號: 請勿空白");
				} else if(!mem_username.trim().matches(mem_usernameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員帳號: 只能是英文字母、數字和_ , 且長度須在2到20之間");
	            }
				
				String mem_password = req.getParameter("mem_password");
				String mem_passwordReg = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}|"
						+ "(?=.*[@$!%*#?&_-])(?=.*\\d)[\\d@$!%*#?&_-]{8,}|"
						+ "(?=.*[@$!%*#?&_-])(?=.*[A-Za-z])[A-Za-z@$!%*#?&_-]{8,}|"
						+ "(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&_-])[A-Za-z\\d@$!%*#?&_-]{8,}$"; // 英文字母與數字
//				String mem_passwordReg2 = "^(?=.*[@$!%*#?&_-])(?=.*\\d)[\\d@$!%*#?&_-]{8,}$"; // 數字與特殊符號
//				String mem_passwordReg3 = "^(?=.*[@$!%*#?&_-])(?=.*[A-Za-z])[A-Za-z@$!%*#?&_-]{8,}$"; // 英文字母與符號
//				String mem_passwordReg4 = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&_-])[A-Za-z\\d@$!%*#?&_-]{8,}$"; // 英文字母與數字與符號
				if (mem_password == null || mem_password.trim().length() == 0) {
					errorMsgs.add("會員密碼: 請勿空白");
				} else if(!mem_password.trim().matches(mem_passwordReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員密碼: 密碼應包含英文字母、數字和特殊符號(如_)至少其中2項, 且長度須在8以上");
	            }
				
				// 若無選擇圖片，則會抓原本的圖
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
					errorMsgs.add("會員姓名: 請勿空白");
				} else if(!mem_name.trim().matches(mem_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員姓名: 只能是中、英文字母 , 且長度必須在1到60之間");
	            }
				
				Byte mem_gender = null;
				mem_gender = Byte.valueOf(req.getParameter("mem_gender").trim());
				
				//沒寫檢查碼驗證
				String mem_id = req.getParameter("mem_id");
				String mem_idReg = "^[A-Za-z][12][\\d]{8}$";
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.add("會員身分證字號: 請勿空白");
				} else if(!mem_id.trim().matches(mem_idReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("身分證字號格式錯誤！");
	            }
				
				java.sql.Date mem_birthday = null;
				try {
					mem_birthday = java.sql.Date.valueOf(req.getParameter("mem_birthday").trim());
				} catch (IllegalArgumentException e) {
					mem_birthday = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				String mem_phone = req.getParameter(("mem_phone").trim());
				
				String mem_mobile = req.getParameter("mem_mobile");
				String mem_mobileReg = "^09[0-9]{8}$";
				if (mem_mobile == null || mem_mobile.trim().length() == 0) {
					errorMsgs.add("會員行動電話: 請勿空白");
				} else if(!mem_mobile.trim().matches(mem_mobileReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員行動電話格式不符");
	            }

				String mem_email = req.getParameter("mem_email");
				String mem_emailReg = "^(.+)@(.+)$";
				if (mem_email == null || mem_email.trim().length() == 0) {
					errorMsgs.add("會員信箱: 請勿空白");
				} else if(!mem_email.trim().matches(mem_emailReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員信箱格式不符");
	            }
				
				String mem_city = req.getParameter(("mem_city").trim());
				
				String mem_dist = req.getParameter(("mem_dist").trim());
				
				String mem_addr = req.getParameter(("mem_addr").trim());
				
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
				memTenVO.setMem_city(mem_city);
				memTenVO.setMem_dist(mem_dist);
				memTenVO.setMem_addr(mem_addr);
//				memTenVO.setMem_status(mem_status);
//				memTenVO.setMem_idcard_f(mem_idcard_fBuf);
//				memTenVO.setMem_idcard_r(mem_idcard_rBuf);
//				memTenVO.setMem_id_status(mem_id_status);
//				memTenVO.setMem_suspend(mem_suspend);
//				memTenVO.setMem_refuse(mem_refuse);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memTenVO", memTenVO); // 含有輸入格式錯誤的memTenVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/memTen/update_memTen_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				MemTenService memTenSvc = new MemTenService();
				memTenVO = memTenSvc.updateMemTen(mem_no, mem_username, mem_password, mem_picBuf, mem_name,
								mem_gender, mem_id, mem_birthday, mem_phone, mem_mobile, mem_email, mem_city,
								mem_dist, mem_addr);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("memTenVO", memTenVO); // 資料庫update成功後,正確的的memTenVO物件,存入req
				String url = "/back-end/memTen/listOneMemTen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneMemTen.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {	
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/memTen/update_memTen_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		// 會員註冊
		if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/				
				String mem_username = req.getParameter("mem_username");
				String mem_usernameReg = "^[a-zA-Z0-9_]{2,20}$";
				if (mem_username == null || mem_username.trim().length() == 0) {
					errorMsgs.add("會員帳號: 請勿空白");
				} else if(!mem_username.trim().matches(mem_usernameReg)) {
					errorMsgs.add("會員帳號: 只能是英文字母、數字和_ , 且長度須在2到20之間");
	            }
				
				String mem_password = req.getParameter("mem_password");
				String mem_passwordReg = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}|(?=.*[@$!%*#?&_-])(?=.*\\d)[\\d@$!%*#?&_-]{8,}|(?=.*[@$!%*#?&_-])(?=.*[A-Za-z])[A-Za-z@$!%*#?&_-]{8,}|(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&_-])[A-Za-z\\d@$!%*#?&_-]{8,}$"; // 英文字母與數字
//				String mem_passwordReg2 = "^(?=.*[@$!%*#?&_-])(?=.*\\d)[\\d@$!%*#?&_-]{8,}$"; // 數字與特殊符號
//				String mem_passwordReg3 = "^(?=.*[@$!%*#?&_-])(?=.*[A-Za-z])[A-Za-z@$!%*#?&_-]{8,}$"; // 英文字母與符號
//				String mem_passwordReg4 = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&_-])[A-Za-z\\d@$!%*#?&_-]{8,}$"; // 英文字母與數字與符號
				if (mem_password == null || mem_password.trim().length() == 0) {
					errorMsgs.add("會員密碼: 請勿空白");
				} else if(!mem_password.trim().matches(mem_passwordReg)) {
					errorMsgs.add("會員密碼: 密碼應包含英文字母、數字和特殊符號(如_)至少其中2項, 且長度須在8以上");
	            }
				
				Part part = req.getPart("mem_pic");
				InputStream mem_picin = part.getInputStream();
				byte[] mem_picBuf = new byte[mem_picin.available()];
				mem_picin.read(mem_picBuf);
				mem_picin.close();
				
				String mem_name = req.getParameter("mem_name");
				String mem_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,60}$";
				if (mem_name == null || mem_name.trim().length() == 0) {
					errorMsgs.add("會員姓名: 請勿空白");
				} else if(!mem_name.trim().matches(mem_nameReg)) {
					errorMsgs.add("會員姓名: 只能是中、英文字母 , 且長度必需在1到60之間");
	            }
				
				Byte mem_gender = null;
				mem_gender = Byte.valueOf(req.getParameter("mem_gender").trim());
				
				String mem_id = req.getParameter("mem_id");
				String mem_idReg = "^[A-Za-z][12]\\d{8}$";
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.add("會員身分證字號: 請勿空白");
				} else if(!mem_id.trim().matches(mem_idReg)) {
					errorMsgs.add("身分證字號格式錯誤！");
	            }
				
				java.sql.Date mem_birthday = null;
				try {
					mem_birthday = java.sql.Date.valueOf(req.getParameter("mem_birthday").trim());
				} catch (IllegalArgumentException e) {
					mem_birthday = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				String mem_phone = req.getParameter(("mem_phone").trim());
				
				String mem_mobile = req.getParameter("mem_mobile");
				String mem_mobileReg = "^09[0-9]{8}$";
				if (mem_mobile == null || mem_mobile.trim().length() == 0) {
					errorMsgs.add("會員行動電話: 請勿空白");
				} else if(!mem_mobile.trim().matches(mem_mobileReg)) {
					errorMsgs.add("會員行動電話格式不符");
	            }

				String mem_email = req.getParameter("mem_email");
				String mem_emailReg = "^(.+)@(.+)$";
				if (mem_email == null || mem_email.trim().length() == 0) {
					errorMsgs.add("會員信箱: 請勿空白");
				} else if(!mem_email.trim().matches(mem_emailReg)) {
					errorMsgs.add("會員信箱格式不符");
	            }
				
				String mem_city = req.getParameter(("mem_city").trim());
				
				String mem_dist = req.getParameter(("mem_dist").trim());
				
				String mem_addr = req.getParameter(("mem_addr").trim());

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
				memTenVO.setMem_city(mem_city);
				memTenVO.setMem_dist(mem_dist);
				memTenVO.setMem_addr(mem_addr);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memTenVO", memTenVO); // 含有輸入格式錯誤的memTenVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/unprotected/addMemTen.jsp");
					failureView.forward(req, res);
					return;
				}

				/***************************2.開始新增資料***************************************/
				MemTenService memTenSvc = new MemTenService();
				memTenVO = memTenSvc.addMemTen(mem_username, mem_password, mem_picBuf, mem_name, mem_gender, mem_id,
						mem_birthday, mem_phone, mem_mobile, mem_email, mem_city, mem_dist, mem_addr);
				
				// 寄送驗證信件
				MemMailService mms = new MemMailService();
				
				// 產生隨機認證碼存入redis
				JedisHandler jh = new JedisHandler();				
				String authCode = jh.setAuthCode(mem_username);
				
				String to = mem_email;
				String subject = "HowTrue好厝會員帳號驗證通知信";
				String messageText = mem_username + "您好 :\n\n" 
						+ "感謝您使用【HowTrue好厝】，為了確認您的資料正確性，平臺需要驗證後才能啟用您的帳號。\n\n" 
						+ "請點擊以下連結進行驗證 :\n" 
						+ req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() 
						+ req.getContextPath() + req.getServletPath() + "?action=verify&mem_username="
						+ mem_username + "&authCode=" + authCode + "\n\n"
						+ "HowTrue好厝團隊敬上。";
				
				mms.sendMail(to, subject, messageText);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/unprotected/unverify.jsp"; // 轉到註冊成功頁面?
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/unprotected/addMemTen.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("verify".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			String mem_username = req.getParameter("mem_username");
			
			String authCode = req.getParameter("authCode");
			
			String savedCode = JedisHandler.getAuthCode(mem_username);
			if (savedCode == null) {
				errorMsgs.add("驗證信已過期，請重新申請");
			} else if (savedCode.equals(authCode)){
				System.out.println("驗證成功!");
				MemTenService memTenSvc = new MemTenService();
				memTenSvc.updateMemStatus(mem_username, (byte) 1);
			} else {
				errorMsgs.add("驗證有誤，請重新申請");
			}
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			String url = "/unprotected/verify.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successView.forward(req, res);
		}
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer mem_no = new Integer(req.getParameter("mem_no"));
				
				/***************************2.開始刪除資料***************************************/
				MemTenService memTenSvc = new MemTenService();
				memTenSvc.deleteMemTen(mem_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/memTen/listAllMemTen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/memTen/listAllMemTen.jsp");
				failureView.forward(req, res);
			}
		}
	}
	
	
}

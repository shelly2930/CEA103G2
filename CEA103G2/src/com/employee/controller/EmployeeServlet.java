package com.employee.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.employee.model.EmployeeDAO;
import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class EmployeeServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("emp_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.put("emp_no", "請輸入員工編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer emp_no = null;
				try {
					emp_no = new Integer(str); // str非數字字串時丟NumberFormatException
				} catch (Exception e) {
					errorMsgs.put("emp_no", "員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmp(emp_no);
				if (employeeVO == null) {
					errorMsgs.put("getOneEmp", "查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("employeeVO", employeeVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/employee/listOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer emp_no = new Integer(req.getParameter("emp_no"));

				/*************************** 2.開始查詢資料 ****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmp(emp_no);
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("employeeVO", employeeVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/employee/updateByEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("updateBySup".equals(action)) { // 來自update_emp_input.jsp的請求

			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer emp_no = new Integer(req.getParameter("emp_no").trim());

				String emp_job = req.getParameter("emp_job").trim();
				
				java.sql.Date emp_hiredate = null;
				try {
					emp_hiredate = java.sql.Date.valueOf(req.getParameter("emp_hiredate").trim());
				} catch (IllegalArgumentException e) {
//					hiredate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("emp_hiredate", "請勿空白");
				}
				
				java.sql.Date emp_quitdate = null;
				try {
					emp_quitdate = java.sql.Date.valueOf(req.getParameter("emp_quitdate").trim());
				} catch (IllegalArgumentException e) {
					// 離職日可為空白
				}
				
				String emp_email = req.getParameter("emp_email").trim();
				String emp_emailReg = "^.+@{1}.+$";
				if(!emp_email.matches(emp_emailReg)) {
					errorMsgs.put("emp_email", "格式不正確 , 必須包含\"@\"符號且前後不得為空白");
				}
				
				String emp_sal_Str = req.getParameter("emp_sal").trim();
				String emp_salReg = "^\\d*$";
				Integer emp_sal = 0;
				if (emp_sal_Str == null || (emp_sal_Str).length() == 0)
					errorMsgs.put("emp_sal", "請勿空白");
				else if(!emp_sal_Str.matches(emp_salReg))
					errorMsgs.put("emp_sal", "格式不正確 , 只能是正整數");
				else
					emp_sal = new Integer(emp_sal_Str);
				
//				try {
//					emp_sal = new Integer(emp_sal_Str); // str非數字字串時丟NumberFormatException
//				} catch (Exception e) {
//					errorMsgs.put("emp_sal", "格式不正確 , 只能是整數");
//				}
				
				String emp_bonus_Str = req.getParameter("emp_bonus").trim();
				String emp_bonusReg = "^\\d*$";
				Integer emp_bonus = 0;
				if (emp_bonus_Str == null || (emp_bonus_Str).length() == 0)
					errorMsgs.put("emp_bonus", "請勿空白");
				else if(!emp_bonus_Str.matches(emp_bonusReg))
					errorMsgs.put("emp_bonus", "格式不正確 , 只能是正整數");
				else
					emp_bonus = new Integer(emp_bonus_Str);
				
				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(emp_no);
				employeeVO.setEmp_job(emp_job);
				employeeVO.setEmp_hiredate(emp_hiredate);
				employeeVO.setEmp_quitdate(emp_quitdate);
				employeeVO.setEmp_email(emp_email);
				employeeVO.setEmp_sal(emp_sal);
				employeeVO.setEmp_bonus(emp_bonus);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("employeeVO", employeeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/updateBySup.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.updateBySup(emp_no, emp_job, emp_hiredate, emp_quitdate, emp_email, emp_sal, emp_bonus);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("employeeVO", employeeVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back-end/employee/listOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/updateBySup.jsp");
				failureView.forward(req, res);
			}
		}

		if ("updateByEmp".equals(action)) { // 來自update_emp_input.jsp的請求

			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer emp_no = new Integer(req.getParameter("emp_no").trim());

				String emp_name = req.getParameter("emp_name").trim();
				String emp_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (emp_name == null || emp_name.length() == 0) {
					// 可空白
				} else if (!emp_name.matches(emp_nameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_name", "只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String emp_password = req.getParameter("emp_password").trim();
				String emp_passwordReg = "^(\\w*[a-zA-Z]+\\w*\\d+\\w*)|(\\w*\\d+\\w*[a-zA-Z]+\\w*)$";
				if(!emp_password.matches(emp_passwordReg) || emp_password.length() < 6) {
					errorMsgs.put("emp_password", "只能是英文字母、數字和_ , 且長度必須大於6並包含一個英文字母及一個數字");
				}
				
				Byte emp_gender = new Byte(req.getParameter("emp_gender"));
				
				String emp_id = req.getParameter("emp_id").trim().toUpperCase();
				String emp_idReg = "^[A-Z][12][\\d]{8}$";
				String str = "0123456789ABCDEFGHJKLMNPQRSTUVXYWZIO";
				if(emp_id.length() == 0) {
					// 身分證字號可為空白
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
						errorMsgs.put("emp_id", "假身分證!!!");
					}
				} else {
					errorMsgs.put("emp_id", "格式錯誤");
				}
				
				java.sql.Date emp_birthday = null;
				try {
					emp_birthday = java.sql.Date.valueOf(req.getParameter("emp_birthday").trim());
				} catch (IllegalArgumentException e) {
					// 可為空白
				}
				
				String emp_phone = req.getParameter("emp_phone").trim();
				
				String emp_mobile = req.getParameter("emp_mobile").trim();
				String emp_mobileReg = "^09[\\d]{8}$";
				if(emp_mobile.length() == 0) {
					// 行動電話可為空白
				} else if(!emp_mobile.matches(emp_mobileReg)) {
					errorMsgs.put("emp_mobile", "只能是09開頭的10位號碼");
				}
				
				String emp_addr = req.getParameter("emp_addr").trim();

				String emp_email = req.getParameter("emp_email").trim();
				String emp_emailReg = "^.+@{1}.+$";
				if(!emp_email.matches(emp_emailReg)) {
					errorMsgs.put("emp_email", "格式不正確 , 必須包含\"@\"符號且前後不得為空白");
				}
				
				String emp_bank = req.getParameter("emp_bank").trim();
				
				String emp_account = req.getParameter("emp_account").trim();
				
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
				employeeVO.setEmp_password(emp_password);
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
					req.setAttribute("employeeVO", employeeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/updateByEmp.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.updateByEmp(emp_no, emp_name, emp_password, emp_gender, emp_id, emp_birthday, emp_phone, emp_mobile, emp_addr, emp_email, emp_bank, emp_account, emp_pic);
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("employeeVO", employeeVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back-end/employee/listOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/updateByEmp.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String emp_job = req.getParameter("emp_job").trim();
				
				String emp_username = req.getParameter("emp_username").trim();
				if(emp_username.length() == 0)
					errorMsgs.put("emp_username", "請勿空白");
//				String emp_usernameReg = "^(\\w*[a-zA-Z]+\\w*\\d+\\w*)|(\\w*\\d+\\w*[a-zA-Z]+\\w*)$";
//				if(!emp_username.matches(emp_usernameReg) || emp_username.length() < 6) {
//					errorMsgs.put("emp_username", "只能是英文字母、數字和_ , 且長度必須大於6並包含一個英文字母及一個數字");
//				}
				
				StringBuffer sb = new StringBuffer();
				for(int i = 0; i < 8; i++) {
					int abc = (int)(Math.random() * 3); // 隨機0-2
					switch (abc) {
					case 0:
						char a = (char)((int)(Math.random() * 10) + 48); // 隨機1-9:(char)48-57
						sb.append(a);
						break;
					case 1:
						char b = (char)((int)(Math.random() * 26) + 65); // 隨機A-Z:(char)65-90
						sb.append(b);
						break;
					case 2:
						char c = (char)((int)(Math.random() * 26) + 97); // 隨機a-z:(char)97-122
						sb.append(c);
					}
				}
				String emp_password = sb.toString();
				
				java.sql.Date emp_hiredate = null;
				try {
					emp_hiredate = java.sql.Date.valueOf(req.getParameter("emp_hiredate").trim());
				} catch (IllegalArgumentException e) {
					emp_hiredate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("emp_hiredate", "請勿空白");
				}
				
				String emp_email = req.getParameter("emp_email").trim();
				String emp_emailReg = "^.+@{1}.+$";
				if(!emp_email.matches(emp_emailReg)) {
					errorMsgs.put("emp_email", "格式不正確 , 必須包含\"@\"符號且前後不得為空白");
				}
				
				String emp_sal_Str = req.getParameter("emp_sal").trim();
				String emp_salReg = "^\\d*$";
				Integer emp_sal = 0;
				if (emp_sal_Str == null || (emp_sal_Str).length() == 0)
					errorMsgs.put("emp_sal", "請勿空白");
				else if(!emp_sal_Str.matches(emp_salReg))
					errorMsgs.put("emp_sal", "格式不正確 , 只能是正整數");
				else
					emp_sal = new Integer(emp_sal_Str);
				
//				try {
//					emp_sal = new Integer(emp_sal_Str); // str非數字字串時丟NumberFormatException
//				} catch (Exception e) {
//					errorMsgs.put("emp_sal", "格式不正確 , 只能是整數");
//				}
				
				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmp_job(emp_job);
				employeeVO.setEmp_username(emp_username);
				employeeVO.setEmp_password(emp_password);
				employeeVO.setEmp_hiredate(emp_hiredate);
				employeeVO.setEmp_email(emp_email);
				employeeVO.setEmp_sal(emp_sal);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("employeeVO", employeeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/addEmp.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				// 1. 亂數產生密碼 password
				// 2. password --> email --> employee
				MailService mailService = new MailService();
				
				String to = emp_email;
			    String subject = "HowTrue好厝  - 新進員工登入通知";
			    String messageText = "Hello!很高興您成為本公司的一員\n請由以下提共之員工代號及密碼登入本公司系統，並修改密碼及完成填寫基本資料\n員工代號: " + emp_username + "\n暫時性密碼: " + emp_password; 
			       
			    mailService.sendMail(to, subject, messageText);
				// 3. password 轉成另一組亂數存進資料庫 (安全性問題)
				
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.addEmp(emp_job, emp_username, emp_password, emp_hiredate, emp_email, emp_sal);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/employee/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/addEmp.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			Map<String,String> errorMsgs = new HashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer emp_no = new Integer(req.getParameter("emp_no"));

				/*************************** 2.開始刪除資料 ***************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeSvc.deleteEmp(emp_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/employee/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("checkEmp_username".equals(action)) {
			PrintWriter out = res.getWriter();
			String emp_username = req.getParameter("emp_username").trim();
			if(emp_username.length() == 0) {
				out.print("請勿空白");
				return;
			}
			
			String emp_usernameReg = "^(\\w*[a-zA-Z]+\\w*\\d+\\w*)|(\\w*\\d+\\w*[a-zA-Z]+\\w*)$";
			if(!emp_username.matches(emp_usernameReg) || emp_username.length() < 6) {
				out.print("只能是英文字母、數字和_ , 且長度必須大於6並包含一個英文字母及一個數字");
				return;
			}
			
			if(new EmployeeService().doesItExist(emp_username))
				out.print("已使用");
			else
				out.print("可使用");
			
//			不另外寫doesItExist的話只能撈出所有員工一一比對
//			List<EmployeeVO> list = new EmployeeService().getAll();
//			for(EmployeeVO employeeVO : list) {
//				if(employeeVO.getEmp_username().equals(emp_username)) {
//					out.print("已使用");
//					return;
//				}
//			}
//			out.print("可使用");
		}
		
		if("login".equals(action)) {
			Map<String,String> messages = new HashMap<String,String>();
			req.setAttribute("messages", messages);
			HttpSession session = req.getSession();
			
			try {
				String emp_username = req.getParameter("emp_username").trim();
				String emp_password = req.getParameter("emp_password").trim();
				List<EmployeeVO> list = new EmployeeService().getAll();
				for(EmployeeVO employeeVO : list) {
					if(employeeVO.getEmp_username().equals(emp_username)) {
						if(employeeVO.getEmp_password().equals(emp_password)) {
							session.setAttribute("employeeVO", employeeVO);
//							session.setAttribute("staRigVOs", 權限list);
							String location = (String)session.getAttribute("location");
							if(location == null)
								res.sendRedirect(req.getContextPath() + "/indexBack.jsp");
							else
								res.sendRedirect(location);
							return;
						} else {
							messages.put("emp_username", emp_username);
							messages.put("failure", "密碼錯誤");
							RequestDispatcher failureView = req.getRequestDispatcher("/loginBack.jsp");
							failureView.forward(req, res);
							return;
						}
					}
				}
				messages.put("emp_username", emp_username);
				messages.put("failure", "查無此帳號");
				RequestDispatcher failureView = req.getRequestDispatcher("/loginBack.jsp");
				failureView.forward(req, res);
			} catch (Exception e) {
				messages.put("failure", "無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/loginBack.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
}
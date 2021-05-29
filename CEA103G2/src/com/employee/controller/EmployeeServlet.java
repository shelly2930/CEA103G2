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
				String url = "/back-end/employee/showOneEmp.jsp";
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
				StaRigService staRigService = new StaRigService();
				List<StaRigVO> list_StaRigVO = staRigService.getOneEmpStaRig(emp_no);
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("employeeVO", employeeVO); // 資料庫取出的empVO物件,存入req
				req.setAttribute("list_StaRigVO", list_StaRigVO);
				String url = "/back-end/employee/updateEmpData.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/showAllEmp.jsp");
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
				Integer emp_no = new Integer(req.getParameter("emp_no"));
				
				String emp_username = req.getParameter("emp_username");

				String emp_job = req.getParameter("emp_job").trim();
				
				java.sql.Date emp_hiredate = null;
				try {
					emp_hiredate = java.sql.Date.valueOf(req.getParameter("emp_hiredate").trim());
				} catch (IllegalArgumentException e) {
//					emp_hiredate = new java.sql.Date(System.currentTimeMillis());
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
					req.setAttribute("employeeVO", employeeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/updateEmpData.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.updateBySup(emp_no, emp_job, emp_hiredate, emp_quitdate, emp_email, emp_sal, emp_bonus, list_Fun_no);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("employeeVO", employeeVO); // 資料庫update成功後,正確的的empVO物件,存入req
				req.setAttribute("updateSuccess", "updateSuccess");
				String url = "/back-end/employee/showAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/updateEmpData.jsp");
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
					errorMsgs.put("emp_name", "請勿空白");
				} else if (!emp_name.matches(emp_nameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("emp_name", "只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}
				
				Byte emp_gender = new Byte(req.getParameter("emp_gender"));
				
				String emp_id = req.getParameter("emp_id").trim().toUpperCase();
				String emp_idReg = "^[A-Z][12][\\d]{8}$";
				String str = "0123456789ABCDEFGHJKLMNPQRSTUVXYWZIO";
				if(emp_id.length() == 0) {
					errorMsgs.put("emp_id", "請勿空白");
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
						errorMsgs.put("emp_id", "非真實身分證");
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
					errorMsgs.put("emp_mobile", "請勿空白");
				} else if(!emp_mobile.matches(emp_mobileReg)) {
					errorMsgs.put("emp_mobile", "只能是09開頭的10位號碼");
				}
				
				String emp_addr = req.getParameter("emp_addr").trim();

				String emp_email = req.getParameter("emp_email").trim();
				String emp_emailReg = "^.+@{1}.+$";
				if(emp_email == null || emp_email.length() == 0) {
					errorMsgs.put("emp_email", "請勿空白");
				}else if(!emp_email.matches(emp_emailReg)) {
					errorMsgs.put("emp_email", "格式不正確 , 必須包含\"@\"符號且前後不得為空白");
				}
				
				String emp_bank = req.getParameter("emp_bank").trim();
				if(emp_bank == null || emp_bank.length() == 0)
					errorMsgs.put("emp_bank", "請勿空白");
				
				String emp_account = req.getParameter("emp_account").trim();
				if(emp_account == null || emp_account.length() == 0)
					errorMsgs.put("emp_account", "請勿空白");
				
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
					req.setAttribute("employeeVO", employeeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/showOneEmp.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.updateByEmp(emp_no, emp_name, emp_gender, emp_id, emp_birthday, emp_phone, emp_mobile, emp_addr, emp_email, emp_bank, emp_account, emp_pic);
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				session.setAttribute("employeeVO", employeeVO); // 資料庫update成功後,正確的的empVO物件,存入req
				req.setAttribute("updateSuccess", "updateSuccess");
				String url = "/back-end/employee/showOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);
//				res.sendRedirect(req.getContextPath() + "/back-end/employee/showOneEmp.jsp");

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/showOneEmp.jsp");
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
				String emp_username = req.getParameter("emp_username").trim();
				String emp_usernameReg = "^(\\w*[a-zA-Z]+\\w*\\d+\\w*)|(\\w*\\d+\\w*[a-zA-Z]+\\w*)$";
				if(emp_username == null || emp_username.length() == 0)
					errorMsgs.put("emp_username", "請勿空白");
				else if(!emp_username.matches(emp_usernameReg) || emp_username.length() < 6)
					errorMsgs.put("emp_username", "只能是英文字母、數字和_ , 且長度必須大於6並包含一個英文字母及一個數字");
				else if(new EmployeeService().doesItExist(emp_username))
					errorMsgs.put("emp_username", "此代號已使用");
				
				String emp_job = req.getParameter("emp_job").trim();
				if(emp_job == "") {
					errorMsgs.put("emp_job", "請選擇職位");
				}
				
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
				if(emp_email == null || emp_email.length() == 0) {
					errorMsgs.put("emp_email", "請勿空白");
				}else if(!emp_email.matches(emp_emailReg)) {
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

				
				List<Integer> list_Fun_no = new ArrayList<Integer>();
				String[] staFun = req.getParameterValues("staFun");
				for(String fun_no_Str : staFun) {
					Integer fun_no = new Integer(fun_no_Str);
					list_Fun_no.add(fun_no);
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("employeeVO", employeeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/addNewEmp.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				// 1. 亂數產生密碼 password
				// 2. password --> email --> employee
				MailService mailService = new MailService();
			    String subject = "HowTrue好厝  - 新進員工登入通知";
			    String messageText = "Hello!很高興您成為本公司的一員\n請由以下提共之員工代號及密碼登入本公司系統，並修改密碼及完成填寫基本資料\n員工代號: " + emp_username + "\n暫時性密碼: " + emp_password
			    		+ "\n登入網址：" + req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath() + "/loginBack.jsp";
			    mailService.sendMail(emp_email, subject, messageText);
				// 3. password 轉成另一組亂數存進資料庫 (安全性問題)
				
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.addEmp(emp_job, emp_username, emp_password, emp_hiredate, emp_email, emp_sal, list_Fun_no);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("insertSuccess", "insertSuccess");
				String url = "/back-end/employee/showAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交showAllEmp.jsp
				successView.forward(req, res);
//				res.sendRedirect(req.getContextPath() + "/back-end/employee/showAllEmp.jsp");

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/addNewEmp.jsp");
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
				String url = "/back-end/employee/showAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/showAllEmp.jsp");
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
				out.print("此代號已使用");
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
			
			try {
				String emp_username = req.getParameter("emp_username").trim();
				String emp_password = req.getParameter("emp_password").trim();
				String[] rememberMe = req.getParameterValues("rememberMe");
				List<EmployeeVO> list = new EmployeeService().getAll();
				for(EmployeeVO employeeVO : list) {
					if(employeeVO.getEmp_username().equals(emp_username)) {
						if(employeeVO.getEmp_password().equals(emp_password)) {
							
							if(employeeVO.getEmp_quitdate() != null) {
								messages.put("failure", "已離職無法登入");
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
								
//								下面四行就可以做到保持登入
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
							messages.put("failure", "密碼錯誤");
							RequestDispatcher failureView = req.getRequestDispatcher("/loginBack.jsp");
							failureView.forward(req, res);
							return;
						}
					}
				}
				messages.put("emp_username", emp_username);
				messages.put("rememberMe", (rememberMe == null)? null : rememberMe[0]);
				
				messages.put("failure", "無此員工代號");
				RequestDispatcher failureView = req.getRequestDispatcher("/loginBack.jsp");
				failureView.forward(req, res);
			} catch (Exception e) {
				messages.put("failure", "無法取得資料:" + e.getMessage());
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
				out.print("請勿空白");
			}else if(!emp_email.matches(emp_emailReg)) {
				out.print("格式不正確 , 必須包含\"@\"符號且前後不得為空白");
			}else {
				MailService mailService = new MailService();
				String emp_username = req.getParameter("emp_username");
				String emp_password = new EmployeeService().getOneEmp(new Integer(req.getParameter("emp_no"))).getEmp_password();
				String subject = "HowTrue好厝  - 新進員工登入通知";
				String messageText = "Hello!很高興您成為本公司的一員\n請由以下提共之員工代號及密碼登入本公司系統，並修改密碼及完成填寫基本資料\n員工代號: " + emp_username + "\n暫時性密碼: " + emp_password
						+ "\n登入網址：" + req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath() + "/loginBack.jsp";
				mailService.sendMail(emp_email, subject, messageText);
				out.print("發送成功");
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
					errorMsgs.put("oldPassword", "請勿空白");
				else if(!oldPassword.equals(emp_password))
					errorMsgs.put("oldPassword", "舊密碼錯誤");
				
				if(newPassword.length() == 0)
					errorMsgs.put("newPassword", "請勿空白");
				else if(newPassword.equals(emp_password))
					errorMsgs.put("newPassword", "與舊密碼相同");
				else if(!newPassword.matches(emp_passwordReg) || newPassword.length() < 6)
					errorMsgs.put("newPassword", "只能是英文字母、數字和_ , 且長度必須大於6並包含一個英文字母及一個數字");
				
				if(newPasswordCheck.length() == 0)
					errorMsgs.put("newPasswordCheck", "請勿空白");
				else if(!newPasswordCheck.equals(newPassword))
					errorMsgs.put("newPasswordCheck", "與新密碼不符");
				
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
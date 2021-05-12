package com.lanlord.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.google.gson.Gson;
import com.house.model.HouseService;
import com.house.model.HouseVO;
import com.lanlord.model.LanlordService;
import com.lanlord.model.LanlordVO;
import com.memTen.model.MemTenVO;

@MultipartConfig
public class LanlordServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("lld_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入房東編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/lanlord/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer lld_no = null;
				try {
					lld_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("房東編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/lanlord/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				LanlordService lanlordSvc = new LanlordService();
				LanlordVO lanlordVO = lanlordSvc.getOneLanlord(lld_no);
				if (lanlordVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/lanlord/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("lanlordVO", lanlordVO); // 資料庫取出的lanlordVO物件,存入req
				String url = "/back-end/lanlord/listOneLanlord.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/lanlord/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp 的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			/***************************不同****************************************/
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】		
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer lld_no = new Integer(req.getParameter("lld_no"));
				
				/***************************2.開始查詢資料****************************************/
				LanlordService lanlordSvc = new LanlordService();
				LanlordVO lanlordVO = lanlordSvc.getOneLanlord(lld_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("lanlordVO", lanlordVO); // 資料庫取出的lanlordVO物件,存入req
				String url = "/back-end/lanlord/authOneLanlord.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_lanlord_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
//		// 前台房東
//		if ("update".equals(action)) { // 來自update_lanlord_input.jsp的請求
//			
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/lanlord/listAllEmp.jsp】 或  【/dept/listLanlords_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
//		
//			try {
//				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				Integer lld_no = new Integer(req.getParameter("lld_no").trim());
//
//				Integer mem_no = new Integer(req.getParameter("mem_no").trim());
//				
//				String lld_bank = req.getParameter("lld_bank").trim();
//				
//				String lld_account = req.getParameter("lld_account").trim();
//				
//				Part part = req.getPart("lld_acc_pic");
//				InputStream lld_acc_picin = part.getInputStream();
//				byte[] lld_acc_picBuf = new byte[lld_acc_picin.available()];
//				lld_acc_picin.read(lld_acc_picBuf);
//				lld_acc_picin.close();
//				
//				String ename = req.getParameter("ename");
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//				if (ename == null || ename.trim().length() == 0) {
//					errorMsgs.add("員工姓名: 請勿空白");
//				} else if(!ename.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//	            }
//				
//				String job = req.getParameter("job").trim();
//				if (job == null || job.trim().length() == 0) {
//					errorMsgs.add("職位請勿空白");
//				}		
//				
//				
//
//				Double sal = null;
//				try {
//					sal = new Double(req.getParameter("sal").trim());
//				} catch (NumberFormatException e) {
//					sal = 0.0;
//					errorMsgs.add("薪水請填數字.");
//				}
//
//				Double comm = null;
//				try {
//					comm = new Double(req.getParameter("comm").trim());
//				} catch (NumberFormatException e) {
//					comm = 0.0;
//					errorMsgs.add("獎金請填數字.");
//				}
//
//				Integer deptno = new Integer(req.getParameter("deptno").trim());
//
//				LanlordVO lanlordVO = new LanlordVO();
//				lanlordVO.setEmpno(lld_no);
//				lanlordVO.setEname(ename);
//				lanlordVO.setJob(job);
//				lanlordVO.setHiredate(hiredate);
//				lanlordVO.setSal(sal);
//				lanlordVO.setComm(comm);
//				lanlordVO.setDeptno(deptno);
//
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("lanlordVO", lanlordVO); // 含有輸入格式錯誤的lanlordVO物件,也存入req
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/lanlord/update_lanlord_input.jsp");
//					failureView.forward(req, res);
//					return; //程式中斷
//				}
//				
//				/***************************2.開始修改資料*****************************************/
//				LanlordService lanlordSvc = new LanlordService();
//				lanlordVO = lanlordSvc.updateLanlord(lld_no, ename, job, hiredate, sal,comm, deptno);
//				
//				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
//				DeptService deptSvc = new DeptService(); //
//				if(requestURL.equals("/dept/listLanlords_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//					req.setAttribute("listLanlords_ByDeptno",deptSvc.getLanlordsByDeptno(deptno)); // 資料庫取出的list物件,存入request
//
//                String url = requestURL;
//				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
//				successView.forward(req, res);
//
//				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/lanlord/update_lanlord_input.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
		// 申請成為房東
		if("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {

				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/				
				Integer mem_no = ((MemTenVO)req.getSession().getAttribute("MemTenVO")).getMem_no();
//				Integer mem_no=null;
//				try {
//					mem_no = new Integer(req.getParameter("mem_no").trim());
//				} catch (Exception e) {
//					errorMsgs.add("請選擇家具類別");
//				}
				
//				Integer mem_no = new Integer(req.getParameter("mem_no").trim());
//				System.out.println(mem_no);
				
				java.sql.Timestamp lld_apptime = new java.sql.Timestamp(System.currentTimeMillis());
				
				String lld_bank = req.getParameter("lld_bank").trim();
				
				String lld_account = req.getParameter("lld_account").trim();
				
				Part part = req.getPart("lld_acc_pic");
				InputStream lld_acc_picin = part.getInputStream();
				byte[] lld_acc_picBuf = new byte[lld_acc_picin.available()];
				lld_acc_picin.read(lld_acc_picBuf);
				lld_acc_picin.close();
				
				LanlordVO lanlordVO = new LanlordVO();
				lanlordVO.setLld_apptime(lld_apptime);
				lanlordVO.setLld_bank(lld_bank);
				lanlordVO.setLld_account(lld_account);
				lanlordVO.setLld_acc_pic(lld_acc_picBuf);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("lanlordVO", lanlordVO); // 含有輸入格式錯誤的memTenVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/lanlord/addLanlord.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				LanlordService lanlordSvc = new LanlordService();
				lanlordVO = lanlordSvc.addLanlord(mem_no, lld_apptime, lld_bank, lld_account, lld_acc_picBuf);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/index.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
			}
		}
		
		if("findByLldStatus".equals(action)) {
			
			try {
				
				Byte lld_status = null;
				lld_status = Byte.valueOf(req.getParameter("lld_status"));
				
				LanlordService lanlordSvc = new LanlordService();
				List<LanlordVO> list = new ArrayList<LanlordVO>();
				list = lanlordSvc.findByLldstatus(lld_status);
				req.setAttribute("list",list);
				
				String url = "/back-end/lanlord/findByLldStatus.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			
			}catch(Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/lanlord/listAllLanlord.jsp");
				failureView.forward(req, res);
			}
		}
		
		// 目前沒用到
		if ("authLanlord".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			/***************************不同****************************************/
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】		
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer lld_no = new Integer(req.getParameter("lld_no"));
				
				/***************************2.開始查詢資料****************************************/
				LanlordService lanlordSvc = new LanlordService();
				LanlordVO lanlordVO = lanlordSvc.getOneLanlord(lld_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("lanlordVO", lanlordVO); // 資料庫取出的lanlordVO物件,存入req
				String url = "/back-end/lanlord/authOneLanlord.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_lanlord_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		String pass = req.getParameter("pass");
		String fail = req.getParameter("fail");
		if ("通過".equals(pass) || "不通過".equals(fail)) {
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer lld_no = new Integer(req.getParameter("lld_no"));
				
				LanlordService lanlordSvc = new LanlordService();
				LanlordVO lanlordVO = lanlordSvc.getOneLanlord(lld_no);
				
				Byte lld_status = null;
				
				Timestamp lld_id_isvrfed = null;
				
				String lld_id_disapprove = null;
				
				if("通過".equals(pass)) {
					lld_status = 1;
					lld_id_isvrfed = new java.sql.Timestamp(System.currentTimeMillis());
				}
				if("不通過".equals(fail)) {
					lld_status = 2;
					lld_id_disapprove = req.getParameter("lld_id_disapprove").trim();
					lld_id_isvrfed = null;
				}
				
				/***************************2.開始修改資料*****************************************/
				lanlordVO = lanlordSvc.updatelldstatus(lld_no, lld_status, lld_id_isvrfed, lld_id_disapprove);
				req.setAttribute("lanlordVO", lanlordVO);
				
				List<LanlordVO> list = new ArrayList<LanlordVO>();
				list = lanlordSvc.findByLldstatus(lld_status);
				req.setAttribute("list",list);
				
				String url = "/back-end/lanlord/findByLldStatus.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/	
			} catch (Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/lanlord/findByLldStatus.jsp");
				failureView.forward(req, res);
			}
		}
		
		
	}
}

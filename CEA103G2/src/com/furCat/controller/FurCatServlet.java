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
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("fnt_ctgr_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入家具類別編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furCat/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer fnt_ctgr_no = null;
				try {
					fnt_ctgr_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("家具類別編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furCat/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				FurCatService furCatSvc = new FurCatService();
				FurCatVO furCatVO = furCatSvc.getOneFurCat(fnt_ctgr_no);
				if (furCatVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furCat/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("furCatVO", furCatVO); // 資料庫取出的furCatVO物件,存入req
				String url = "/back-end/furCat/listOneFurCat.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneFurCat.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/furCat/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
if ("getOne_For_Update".equals(action)) { // 來自listAllFurCat.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no"));
				
				/***************************2.開始查詢資料****************************************/
				FurCatService furCatSvc = new FurCatService();
				FurCatVO furCatVO = furCatSvc.getOneFurCat(fnt_ctgr_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("furCatVO", furCatVO);         // 資料庫取出的furCatVO物件,存入req
				String url = "/back-end/furCat/update_furCat_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/furCat/listAllFurCat.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
				
				String fnt_ctgr_name = req.getParameter("fnt_ctgr_name");
				String fnt_ctgr_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (fnt_ctgr_name == null || fnt_ctgr_name.trim().length() == 0) {
					errorMsgs.add("家具類別名稱: 請勿空白");
				} else if(!fnt_ctgr_name.trim().matches(fnt_ctgr_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("家具類別名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				FurCatVO furCatVO = new FurCatVO();
				furCatVO.setFnt_ctgr_no(fnt_ctgr_no);
				furCatVO.setFnt_ctgr_name(fnt_ctgr_name);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("furCatVO", furCatVO); // 含有輸入格式錯誤的furCatVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furCat/update_furCat_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				FurCatService furCatSvc = new FurCatService();
				furCatVO = furCatSvc.updateFurCat(fnt_ctgr_no, fnt_ctgr_name);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("furCatVO", furCatVO); // 資料庫update成功後,正確的的furCatVO物件,存入req
				String url = "/back-end/furCat/listOneFurCat.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneFurCat.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/furCat/update_furCat_input.jsp");
				failureView.forward(req, res);
			}
		}

 if ("insert".equals(action)) { // 來自addFurCat.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String fnt_ctgr_name = req.getParameter("fnt_ctgr_name");
				String fnt_ctgr_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (fnt_ctgr_name == null || fnt_ctgr_name.trim().length() == 0) {
					errorMsgs.add("家具類別名稱: 請勿空白");
				} else if(!fnt_ctgr_name.trim().matches(fnt_ctgr_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("家具類別名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				

				FurCatVO furCatVO = new FurCatVO();
				furCatVO.setFnt_ctgr_name(fnt_ctgr_name);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("furCatVO", furCatVO); // 含有輸入格式錯誤的furCatVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furCat/addFurCat.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				FurCatService furCatSvc = new FurCatService();
				furCatVO = furCatSvc.addFurCat(fnt_ctgr_name);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/furCat/listAllFurCat.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllFurCat.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/furCat/addFurCat.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("delete".equals(action)) { // 來自listAllFurCat.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no"));
				
				/***************************2.開始刪除資料***************************************/
				FurCatService furCatSvc = new FurCatService();
				furCatSvc.deleteFurCat(fnt_ctgr_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/furCat/listAllFurCat.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/furCat/listAllFurCat.jsp");
				failureView.forward(req, res);
			}
		}

//跳轉品項 測試成功 待之後複合查詢用
//if ("getOne_furCat".equals(action)) { // 來自listAllFurCat.jsp的跳轉品項請求
//	System.out.println("RUN");
//	try {
//		/***************************1.接收請求參數****************************************/
//		//Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no"));
//		
//		/***************************3.查詢完成,準備轉交(Send the Success view)************/
//		//HttpSession session=req.getSession();
//		//session.setAttribute("fnt_ctgr_no",fnt_ctgr_no);
//		String url = "/back-end/furIte/listAllFurIte.jsp";
//		RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
//		successView.forward(req, res);
//
//		/***************************其他可能的錯誤處理**********************************/
//	} catch (Exception e) {
//		RequestDispatcher failureView = req
//				.getRequestDispatcher("/back-end/furCat/listAllFurCat.jsp");
//		failureView.forward(req, res);
//	}
//}

	}
}

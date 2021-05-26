package com.furLis.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.http.*;
import com.furCat.model.FurCatService;
import com.furLis.model.*;
import com.furPho.model.FurPhoVO;
import com.lanBill.controller.LanBillServlet;

public class FurLisServlet extends HttpServlet {
//新增及修改 刪除 查詢DAO待改
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=Big5");
		String action = req.getParameter("action");
		
	//新增資料鈕連結 待處理品項連類別下拉式選單問題 家具大類的下拉式選單的值要存??
		 if ("insert".equals(action)) {   
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
					Integer fnt_ctgr_no=null;
					try {
						fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
					} catch (Exception e) {
						errorMsgs.add("請選擇家具類別");
					}
					
					Integer fnt_it_no=null;
					try {
						fnt_it_no = new Integer(req.getParameter("fnt_it_no").trim());
					} catch (Exception e) {
						errorMsgs.add("請選擇家具品項類別");
					}
					//購置日期
					Timestamp fnt_acq_date = null;
					try {
						fnt_acq_date = Timestamp.valueOf(req.getParameter("fnt_acq_date").trim());
					} catch (IllegalArgumentException e) {
						fnt_acq_date=new Timestamp(System.currentTimeMillis());
						errorMsgs.add("請輸入日期!");
					}
					//家具狀態
					Byte fnt_status=null;
					try {
						fnt_status = new Byte(req.getParameter("fnt_status").trim());
					} catch (Exception e) {
						fnt_status=0;
						errorMsgs.add("請選擇家具狀態");
					}
					//租借狀態
					Byte fnt_rent_status=0;
					
				//報廢日期 可為空值	
					Timestamp fnt_unusable_date = null;
					try {
						fnt_unusable_date = Timestamp.valueOf(req.getParameter("fnt_unusable_date").trim());
					} catch (IllegalArgumentException e) {
						fnt_unusable_date = null;
					}
					
					FurLisVO furLisVO = new FurLisVO();
					furLisVO.setFnt_it_no(fnt_it_no);
					furLisVO.setFnt_acq_date(fnt_acq_date);
					furLisVO.setFnt_status(fnt_status);
					furLisVO.setFnt_rent_status(fnt_rent_status);
					furLisVO.setFnt_unusable_date(fnt_unusable_date);
									
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furLisVO", furLisVO); // 含有輸入格式錯誤的furLisVO物件,也存入req
						req.setAttribute("fnt_ctgr_no", fnt_ctgr_no);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furLis/addFurLis.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.開始新增資料***************************************/
					FurLisService furLisSvc = new FurLisService();
					furLisVO = furLisSvc.addFurLis(fnt_it_no, fnt_acq_date,fnt_status, fnt_rent_status,fnt_unusable_date);
					req.setAttribute("fnt_ctgr_no", fnt_ctgr_no);
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = "/back-end/furLis/listAllFurLis.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 
					successView.forward(req, res);				
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furLis/addFurLis.jsp");
					failureView.forward(req, res);
				}
			}
		//來自管理頁面修改鈕
		 if ("getOne_For_Update".equals(action)) { // 來自listAllFurLis.jsp的請求

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				String requestURL = req.getParameter("requestURL"); 
				try {
					/***************************1.接收請求參數****************************************/
					Integer fnt_id = new Integer(req.getParameter("fnt_id"));
					
					/***************************2.開始查詢資料****************************************/
					FurLisService furLisSvc = new FurLisService();
					FurLisVO furLisVO = furLisSvc.getOneFurLis(fnt_id);
									
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("furLisVO", furLisVO);         // 資料庫取出的empVO物件,存入req
					String url = "/back-end/furLis/update_furLis_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
				}
			}
		 
		 
		//修改資料頁面連結
		 if ("update".equals(action)) {   
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				String requestURL = req.getParameter("requestURL"); 
				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/

					Integer fnt_id=new Integer(req.getParameter("fnt_id").trim());
					Integer fnt_it_no=new Integer(req.getParameter("fnt_it_no").trim());
					
					//購置日期
					Timestamp fnt_acq_date = null;
					try {
						fnt_acq_date = Timestamp.valueOf(req.getParameter("fnt_acq_date").trim());
					} catch (IllegalArgumentException e) {
						fnt_acq_date=new Timestamp(System.currentTimeMillis());
						errorMsgs.add("請輸入日期!");
					}
					//家具狀態
					Byte fnt_status=null;
					try {
						fnt_status = new Byte(req.getParameter("fnt_status").trim());
					} catch (Exception e) {
						fnt_status=0;
						errorMsgs.add("請選擇家具狀態");
					}
					//租借狀態
					Byte fnt_rent_status=new Byte(req.getParameter("fnt_rent_status").trim());
					//後端防呆 當家具狀態不為正常時 租借狀態均為未出租!
					if(fnt_status!=0) {
						fnt_rent_status=0;
					}
				//報廢日期 可為空值	
					Timestamp fnt_unusable_date = null;
					try {
						fnt_unusable_date = Timestamp.valueOf(req.getParameter("fnt_unusable_date").trim());
					} catch (IllegalArgumentException e) {
						fnt_unusable_date = null;
					}
					
					FurLisVO furLisVO = new FurLisVO();
					furLisVO.setFnt_it_no(fnt_id);
					furLisVO.setFnt_it_no(fnt_it_no);
					furLisVO.setFnt_acq_date(fnt_acq_date);
					furLisVO.setFnt_status(fnt_status);
					furLisVO.setFnt_rent_status(fnt_rent_status);
					furLisVO.setFnt_unusable_date(fnt_unusable_date);
									
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furLisVO", furLisVO); // 含有輸入格式錯誤的furLisVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furLis/update_furLis_input.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.開始新增資料***************************************/
					FurLisService furLisSvc = new FurLisService();
					furLisVO = furLisSvc.updateFurLis(fnt_id,fnt_it_no, fnt_acq_date,fnt_status, fnt_rent_status,fnt_unusable_date);
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = requestURL;
					RequestDispatcher successView = req.getRequestDispatcher(url); // 
					successView.forward(req, res);				
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furLis/update_furLis_input.jsp");
					failureView.forward(req, res);
				}
			}
		 
			if ("delete".equals(action)) { 
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑
				try {
					/***************************1.接收請求參數***************************************/
					Integer fnt_id = new Integer(req.getParameter("fnt_id"));
					
					/***************************2.開始刪除資料***************************************/
					FurLisService furLisSvc = new FurLisService();
					furLisSvc.deleteFurLis(fnt_id);
					
					/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
					String url =requestURL;
					RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
					successView.forward(req, res);
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("刪除資料失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
				}
			}		
		 
//複合查詢
//			if ("compositeQuery".equals(action)) { // 來自listAllLis.jsp的複合查詢請求
//				System.out.println("Enter compositeQuery");
//				System.out.println("執行到A此");
//				try {
//					String furCatSelect=req.getParameter("furCatSelect");
//					System.out.println("取到的furCatSelect: "+furCatSelect);
//					Integer furIteSelect=new Integer(req.getParameter("furIteSelect").trim());
//					Integer fntStatusSelect=new Integer(req.getParameter("fntStatusSelect").trim());
//					Integer rentStatusSelect=new Integer(req.getParameter("rentStatusSelect").trim());
//					System.out.println("執行到此");
//					System.out.println("取到的furCatSelect: "+furCatSelect);
//					System.out.println("取到的furIteSelect: "+furIteSelect);
//					System.out.println("取到的fntStatusSelect: "+fntStatusSelect);
//					System.out.println("取到的rentStatusSelect: "+rentStatusSelect);
//					
//					/***************************開始複合查詢***************************************/
////					FurLisService furLisSvc = new FurLisService();
////					List<FurLisVO> multiQueryList  = furLisSvc.getMultiQuery(furCatSelect,furIteSelect,fntStatusSelect,rentStatusSelect);
//					
//					/***************************查詢完成,準備傳前端************/
//					
//					/***************************其他可能的錯誤處理**********************************/
//				} catch (Exception e) {
//				
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/back-end/furLis/listAllFurLis.jsp");
//					failureView.forward(req, res);
//				}
//			}
			
			
	}
}
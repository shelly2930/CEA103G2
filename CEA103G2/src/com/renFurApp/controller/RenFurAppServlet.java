package com.renFurApp.controller;

import java.io.*;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.Vector;

import javax.servlet.*;
import javax.servlet.http.*;

import com.renCon.model.RenConService;
import com.renFurApp.model.*;
import com.renFurDet.model.*;
import com.rentCart.model.RentCartItem;

public class RenFurAppServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
	    res.setContentType("text/html; charset=Big5");
	    HttpSession session = req.getSession();
		String action = req.getParameter("action");
		

		//訂單成立(from 前台)
		 if (action.equals("insert")) {
			Integer mem_no = new Integer(req.getParameter("memTen_no"));
			Integer rfa_total = new Integer(req.getParameter("rfa_total"));
			Timestamp rfa_order_date = Timestamp.valueOf(req.getParameter("rfa_order_date").trim());
			Timestamp rfa_acpt_date = new java.sql.Timestamp(System.currentTimeMillis());
			Byte rfa_status = 0;
			//合約編號要塞明細和找合約終止日期
			Integer rtct_no=new Integer(req.getParameter("rtct_no"));
			
			RenFurAppVO renFurAppVO=new RenFurAppVO();
			renFurAppVO.setMem_no(mem_no);
			renFurAppVO.setRfa_apct_date(rfa_acpt_date);
			renFurAppVO.setRfa_total(rfa_total);
			renFurAppVO.setRfa_status(rfa_status);
			renFurAppVO.setRfa_order_date(rfa_order_date);
			
			RenConService renConSvc=new RenConService();
			Timestamp rfa_end_date=renConSvc.getEndDate(rtct_no);
			
			@SuppressWarnings("unchecked")
			List<RentCartItem> rentCartList = (Vector<RentCartItem>) session.getAttribute("rentCartList");
			List<RenFurDetVO> renFurDetList = new ArrayList<RenFurDetVO>();
			
			for(int index=0; index<rentCartList.size();index++) {
				RenFurDetVO renFurDetVO=new RenFurDetVO();
				RentCartItem orderFurCartItem=rentCartList.get(index);
				Integer qty=orderFurCartItem.getQuantity();
				if(qty>1) {
					int innerloopSize=qty;
					for(int index2=0;index2<innerloopSize;index2++) {
						RenFurDetVO renFurDetVO2=new RenFurDetVO();
						renFurDetVO2.setFnt_id(orderFurCartItem.getFnt_it_no());
						renFurDetVO2.setRtct_no(rtct_no);
						renFurDetVO2.setRent_end_date(rfa_end_date);
						renFurDetList.add(renFurDetVO2);
					}
				}else {
					renFurDetVO.setFnt_id(orderFurCartItem.getFnt_it_no());
					renFurDetVO.setRtct_no(rtct_no);
					renFurDetVO.setRent_end_date(rfa_end_date);
					renFurDetList.add(renFurDetVO);
				}
			}
			RenFurAppService renFurAppService=new RenFurAppService();
			renFurAppService.insertWithDetail(renFurAppVO,renFurDetList);
			
			session.removeAttribute("rentCartList");
		}
		
		
//來自管理頁面邊及鈕及查看鈕
		 if ("getOne_For_Update".equals(action) || "getOne_For_Look".equals(action)) { // 來自listAllRenFurApp.jsp的請求
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.接收請求參數****************************************/
					Integer rfa_no = new Integer(req.getParameter("rfa_no"));
					
					/***************************2.開始查詢資料****************************************/
					RenFurAppService renFurAppSvc = new RenFurAppService();
//由此開始改	 查一整張申請單明細存list
RenFurAppVO renFurAppVO = renFurAppSvc.getOneRenFurApp(rfa_no);
				    
//由rfa_no查一整張單的所有明細
RenFurDetService renFurDetSvc = new RenFurDetService();
					List<RenFurDetVO> list = renFurDetSvc.getOneList(rfa_no);

					/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
//					轉交到listDets_by~
					req.setAttribute("listDets_ByRenFurApp", list);    // 資料庫取出的set物件,存入request
					
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("renFurAppVO", renFurAppVO);         // 資料庫取出的renFurAppVO物件,存入req
					String url="";
//					先測試都到跳轉到同一畫面 最後再分哪個進查看 哪個進修改頁面
					if("getOne_For_Update".equals(action)){
//						url = "/back-end/renFurApp/update_renFurApp_input.jsp";
						url = "/back-end/renFurApp/up_renFurApp.jsp";
						}
					else {
						url = "/back-end/renFurApp/listOne_renFurApp.jsp";
					}
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/renFurApp/listAllRenFurApp.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 
//		 
		//修改資料頁面連結
		 if ("update".equals(action)) {   
				System.out.println("有進到action=updation內");
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
	
//						//租金合計
//						Integer rfa_total= new Integer(req.getParameter("rfa_total"));
//						  System.out.println("rfa_total="+rfa_total);
					  
							//預約日期
							Timestamp rfa_order_date = null;
							try {
								rfa_order_date = Timestamp.valueOf(req.getParameter("rfa_order_date").trim());
								  System.out.println("rfa_order_date="+rfa_order_date);
							} catch (IllegalArgumentException e) {
								rfa_order_date=new Timestamp(System.currentTimeMillis());
								errorMsgs.add("請輸入日期!");
							}
							//申請單編號
							Integer rfa_no = new Integer(req.getParameter("rfa_no"));
							  System.out.println("rfa_no="+rfa_no);
							
							
							//申請進度
//							Byte rfa_status = new Byte(req.getParameter("rfa_status").trim());
//							  System.out.println("rfa_status="+rfa_status+"======");
							
					  //會員編號
//					Integer mem_no= new Integer(req.getParameter("mem_no"));
//					  System.out.println("mem_no="+mem_no);
				
					//申請時間
//					Timestamp rfa_acpt_date=null; 
//					rfa_acpt_date=Timestamp.valueOf(req.getParameter("rfa_acpt_date").trim());
				
					//員工選單
					Integer emp_no=null;
					try {
						emp_no = new Integer(req.getParameter("emp_no").trim());
					} catch (Exception e) {
						errorMsgs.add("請選擇指派員工");
					}
					
					Byte rfa_status = new Byte(req.getParameter("rfa_status"));
					 System.out.println("rfa_status="+rfa_status);
				
					RenFurAppVO renFurAppVO = new RenFurAppVO();
					renFurAppVO.setRfa_no(rfa_no);
//					renFurAppVO.setMem_no(mem_no);
					renFurAppVO.setEmp_no(emp_no);
//					renFurAppVO.setRfa_apct_date(rfa_acpt_date);
					renFurAppVO.setRfa_order_date(rfa_order_date);
//					renFurAppVO.setRfa_total(rfa_total);
					renFurAppVO.setRfa_status(rfa_status);
					
					
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("renFurAppVO", renFurAppVO); // 含有輸入格式錯誤的furIteVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/renFurApp/up_renFurApp.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.開始新增資料***************************************/
					RenFurAppService renFurAppSvc = new RenFurAppService();
					renFurAppVO = renFurAppSvc.updateRenFurApp( rfa_no,  emp_no,  rfa_order_date, rfa_status);
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					RenFurDetService renFurDetSvc = new RenFurDetService();
					List<RenFurDetVO> list = renFurDetSvc.getOneList(rfa_no);
					req.setAttribute("listDets_ByRenFurApp", list);
					
					renFurAppVO = renFurAppSvc.getOneRenFurApp(rfa_no);
					req.setAttribute("renFurAppVO", renFurAppVO);
					
					req.setAttribute("updateSuccess", "updateSuccess");
					
					String url = "/back-end/renFurApp/up_renFurApp.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);	
				
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/renFurApp/up_renFurApp.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 
		 if("getByRfa_status".equals(action)) {
			 Byte rfa_status = new Byte(req.getParameter("rfa_status").trim());
			 List<RenFurAppVO> list = new RenFurAppService().getAll();
			 List<RenFurAppVO> newList = new  ArrayList<RenFurAppVO>();
			 for(int i = 0; i < list.size(); i++) {
				 RenFurAppVO renFurAppVO = list.get(i);
				 if(renFurAppVO.getRfa_status().equals(rfa_status)) {
					 newList.add(renFurAppVO);
				 }
			 }
			 
			 req.setAttribute("list", newList);  
			 RequestDispatcher successView = req.getRequestDispatcher("/back-end/renFurApp/showAllRenFurApp.jsp"); 
			 successView.forward(req, res);
		 }
	}
}
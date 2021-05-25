package com.renFurApp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.memTen.model.MemTenVO;
import com.renFurApp.model.RenFurAppService;
import com.renFurApp.model.RenFurAppVO;
import com.renFurDet.model.RenFurDetService;
import com.renFurDet.model.RenFurDetVO;

@WebServlet("/MemRenFurAppServlet")
public class MemRenFurAppServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("listRenFurAppByMem".equals(action)) {
			try {
				Integer mem_no = ((MemTenVO)req.getSession().getAttribute("MemTenVO")).getMem_no();
				
				Byte rfa_status = null;
				
				if(req.getParameter("rfa_status")==null) {
					rfa_status = 0;
				}else {
					rfa_status = new Byte(req.getParameter("rfa_status"));
				}
				
				RenFurAppService renFurAppSvc = new RenFurAppService();
				List<RenFurAppVO> list = new ArrayList<RenFurAppVO>();
				list = renFurAppSvc.getAllByMem(mem_no, rfa_status);
				System.out.println("list="+list.size());
				
				req.setAttribute("list",list);
				req.setAttribute("rfastatus", rfa_status); // 要加這行不然jsp抓不到
				
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/renFurApp/listRenFurAppByMem.jsp"); 
				successView.forward(req, res);
				
			}catch(Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/index.jsp");
				failureView.forward(req, res);
			}
			
		}
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllRenFurApp.jsp的請求
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
//				轉交到listDets_by~
				req.setAttribute("listDets_ByRenFurApp", list);    // 資料庫取出的set物件,存入request
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("renFurAppVO", renFurAppVO);         // 資料庫取出的renFurAppVO物件,存入req
				String url="";
//				先測試都到跳轉到同一畫面 最後再分哪個進查看 哪個進修改頁面
				if("getOne_For_Update".equals(action)){
//					url = "/back-end/renFurApp/update_renFurApp_input.jsp";
					url = "/front-end/renFurApp/renFurDetByMem.jsp";
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
						.getRequestDispatcher("/front-end/renFurApp/listRenFurAppByMem.jsp");
				failureView.forward(req, res);
			}
		}
	}
}

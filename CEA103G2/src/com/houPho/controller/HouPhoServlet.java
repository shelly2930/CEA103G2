package com.houPho.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.houPho.model.HouPhoService;
import com.houPho.model.HouPhoVO;
import com.house.model.HouseService;
@MultipartConfig
public class HouPhoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
//沒用 待刪
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> ErrorMessage = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("ErrorMessage", ErrorMessage);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("houPhono");
				//null是避免工程師打錯字，防呆用
//				沒有輸入的話
				if (str == null || (str.trim()).length() == 0) {
					ErrorMessage.add("請輸入員工編號");
				}
				if (!ErrorMessage.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
//				沒有輸入數字的話
				Integer houPhono = null;
				try {
					houPhono = new Integer(str);
				} catch (Exception e) {
					ErrorMessage.add("員工編號格式不正確");
				}
				if (!ErrorMessage.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				HouPhoService houPhoSvc = new HouPhoService();
				HouPhoVO houPhoVO = houPhoSvc.getOneHouPho(houPhono);
				if (houPhoVO == null) {
					ErrorMessage.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!ErrorMessage.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("houPhoVO", houPhoVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/houPho/listOneHouPho.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				ErrorMessage.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
				failureView.forward(req, res);
			}
		}
/********新增多張照片*******************/		
		 if ("insert".equals(action)) { // 來自addHouPho.jsp的請求  
			 List<String> ErrorMessage = new LinkedList<String>();	
			 req.setAttribute("ErrorMessage", ErrorMessage);
				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
					Integer houseno = new Integer(req.getParameter("houseno").trim());
//					===================讀檔案================================
//					InputStream in = req.getPart("hos_pic").getInputStream();
//					if(in.available()==0) {
//						System.out.println("HouPhoServlet檔案錯誤");
//					}
//					byte[] hos_picBuf = new byte[in.available()];
					
//					in.read(buf) 是buf這陣列用inputstream到資料近來
//					所下面執行完，buf已經含有資料了
//					in.read(hos_picBuf);
//					========================================================
					HouPhoService houPhoSvc = new HouPhoService();
					Collection<Part> parts = req.getParts();
					InputStream in =null;
					byte[] hos_picBuf =null;
					int count = 0;
					for(Part part : parts) {
						if(!"hos_pic".equals(part.getName()))continue;
						in = part.getInputStream();
						if(in.available()==0) continue;
						hos_picBuf = new byte[in.available()];
						in.read(hos_picBuf);
						count++;
						houPhoSvc.addHouPho(houseno,hos_picBuf);
					}
					if(count==0) ErrorMessage.add("沒有選取要刪除的圖片喔!!!");
					else req.removeAttribute("ErrorMessage");
					//========================================================
					/***************************2.開始新增資料***************************************/
					
					HouseService houseSvc = new HouseService();
					Set<HouPhoVO> set = houseSvc.getHouPhoByHouse(houseno);
					req.setAttribute("listHouPho_ByHouseNo",set);
					
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = "/back-end/houPho/listHouPhoEmp.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
					successView.forward(req, res);				
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					ErrorMessage.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/houPho/addHouPho.jsp");
					failureView.forward(req, res);
				}
			}
/********刪除多張照片*******************/			 
		 if ("delete".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp的請求

				List<String> ErrorMessage = new LinkedList<String>();
				req.setAttribute("ErrorMessage", ErrorMessage);
				RequestDispatcher successView = null;
				try {
					Integer houseno = new Integer(req.getParameter("houseno"));
					String[] deleteHousePic_array =null;
					HouPhoService houPhoSvc = new HouPhoService();
					if(req.getParameterValues("pickHousePic")!=null) {
						deleteHousePic_array= req.getParameterValues("pickHousePic");
						for(String pic_no:deleteHousePic_array) {
							houPhoSvc.deleteHouPho(new Integer(pic_no));
						}
						req.removeAttribute("ErrorMessage");
					}else {
						ErrorMessage.add("沒有選取照片!");
					}
					HouseService houseSvc =new  HouseService();
					Set<HouPhoVO> set = houseSvc.getHouPhoByHouse(houseno);
					req.setAttribute("listHouPho_ByHouseNo", set);
					
					String url = "/back-end/houPho/listHouPhoEmp.jsp";
					successView= req.getRequestDispatcher(url); // 刪除成功後,轉交回送出刪除的來源網頁
					successView.forward(req, res);
				} catch (Exception e) {
					ErrorMessage.add("刪除資料失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/houPho/listHouPhoEmp.jsp");
					failureView.forward(req, res);
				}
			}
//待刪		 
		 if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp 的請求

				List<String> ErrorMessage = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("ErrorMessage", ErrorMessage);
				
				String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】		
				
				try {
					/***************************1.接收請求參數****************************************/
					Integer houPhono = new Integer(req.getParameter("houPhono"));
					
					/***************************2.開始查詢資料****************************************/
					HouPhoService houPhoSvc = new HouPhoService();
					HouPhoVO houPhoVO = houPhoSvc.getOneHouPho(houPhono);
									
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("houPhoVO", houPhoVO); // 資料庫取出的empVO物件,存入req
					String url = "/front-end/houPho/update_HouPho_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_emp_input.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理************************************/
				} catch (Exception e) {
					ErrorMessage.add("修改資料取出時失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
				}
			}
/********更改多張照片照片*******************/		 
		 if ("getMoreForUpdate".equals(action)||"updateMoreHouPho".equals(action)) { // 來自update_emp_input.jsp的請求
				List<String> ErrorMessage = new LinkedList<String>();
				try {
					/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
					Integer houseno = new Integer(req.getParameter("houseno"));
					HouseService houseSvc =new  HouseService();
					Set<HouPhoVO> set = houseSvc.getHouPhoByHouse(houseno);
					req.setAttribute("listHouPho_ByHouseNo", set); //過去回來都要setet
					
					String[] updateHouPho_array = null;
					if("getMoreForUpdate".equals(action)) {
						updateHouPho_array = req.getParameterValues("pickHousePic");
						System.out.println(updateHouPho_array);
						if(req.getParameterValues("pickHousePic")==null) {
							ErrorMessage.add("你沒有選圖片");
							req.setAttribute("ErrorMessage",ErrorMessage);
							RequestDispatcher successView = req.getRequestDispatcher("/back-end/houPho/listHouPhoEmp.jsp");   // 修改成功後,轉交回送出修改的來源網頁
							successView.forward(req, res);
							return;
						}
					}else {
						HouPhoService houPhoSvc =  new HouPhoService();
						InputStream in = null;
						Collection<Part> parts = req.getParts();
						for(Part part : parts) {
							if("action".equals(part.getName()) || "houseno".equals(part.getName())) continue;
							in = part.getInputStream();
							byte[] hos_pic = new byte[in.available()];
							if(in.available()!=0) {
								in.read(hos_pic);
								houPhoSvc.updateHouPho(Integer.parseInt(part.getName()), houseno , hos_pic);
							}
						}
					}
					/***************************3.修改完成,準備轉交(Send the Success view)*************/	
					String url = null;
					if("getMoreForUpdate".equals(action)) {
						url="/back-end/houPho/updateHouPhoInput.jsp";
					}else {
						url="/back-end/houPho/listHouPhoEmp.jsp";
					}
					RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
					successView.forward(req, res);
					/***************************其他可能的錯誤處理*************************************/
				} catch (Exception e) {
					ErrorMessage.add("修改物件照片失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/error.jsp");
					failureView.forward(req, res);
				}
			}
	}

}

package com.furPho.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.furIte.model.FurIteService;
import com.furIte.model.FurIteVO;
import com.furPho.model.FurPhoService;
import com.furPho.model.FurPhoVO;

@MultipartConfig
public class FurPhoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//取圖片檔名方法
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();

		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
	    res.setContentType("text/html; charset=Big5");
	    
		String action = req.getParameter("action");
		
		//接新增品項下一步 新增照片 從addFurItePho來的
		 if ("insert_pic".equals(action)) { // 來自addFurPho.jsp的請求  
				List<String> errorMsgs = new LinkedList<String>();

				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				//	fnt_it_no接來自新增品項的頁面(找新增一筆的品項編號)或首頁更換照片的頁面(頁面擷取的fnt_it_no)
					System.out.println("有執行");
					String getFnt_it_noString=req.getParameter("fnt_it_no");
					 Integer fnt_it_no = Integer.parseInt(getFnt_it_noString); 
					
					 
					 //測試給另開畫面用
//					 System.out.println("測試從另跳頁面的取值狀況 有執行");
//						String getFnt_it_noString2=req.getParameter("fnt_it_no2");
//						System.out.println("有拿到fnt_it_no2:"+getFnt_it_noString2+" 根本沒東西???");
//						 Integer fnt_it_no2 = Integer.parseInt(getFnt_it_noString2); 
//						 System.out.println("轉型的fnt_it_no2"+fnt_it_no2);
//					-----讀取檔案-----
					Collection<Part> parts = req.getParts(); 
					FurPhoService furPhoSvc = new FurPhoService();
					for (Part part : parts) {
						System.out.println("讀照片");
						String filename = getFileNameFromPart(part);
						//有照片名稱才讀
						if (filename!= null && part.getContentType()!=null) {

							// 額外測試 InputStream 與 byte[] (幫將來model的VO預作準備)
							InputStream in = part.getInputStream();
							byte[] buf = new byte[in.available()]; 
							in.read(buf);
							in.close();
							//讀取圖片後 新增照片
							FurPhoVO furPhoVO=new FurPhoVO();
							furPhoVO.setFnt_it_no(fnt_it_no);
							furPhoVO.setFnt_pic(buf);
							furPhoSvc.insert(furPhoVO);
						}
					}					
				
//					/***************************新增完成,準備回成功頁面***********/
					String url = "/back-end/furIte/listAllFurIte.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);								
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/addFurItePho.jsp");
					failureView.forward(req, res);
				}
			}
		
		 
			//接另開視窗的 新增照片 從另開視窗來的
		 if ("insert_pic_from_js".equals(action)) { // 來自addFurPho.jsp的請求  
				List<String> errorMsgs = new LinkedList<String>();

				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				//	fnt_it_no接來自新增品項的頁面(找新增一筆的品項編號)或首頁更換照片的頁面(頁面擷取的fnt_it_no)
					String getFnt_it_noString=req.getParameter("fnt_it_no");
					 Integer fnt_it_no = Integer.parseInt(getFnt_it_noString); 
										 
					 //測試給另開畫面用
//					 System.out.println("測試從另跳頁面的取值狀況 有執行");
//						String getFnt_it_noString2=req.getParameter("fnt_it_no2");
//						System.out.println("有拿到fnt_it_no2:"+getFnt_it_noString2+" 根本沒東西???");
//						 Integer fnt_it_no2 = Integer.parseInt(getFnt_it_noString2); 
//						 System.out.println("轉型的fnt_it_no2"+fnt_it_no2);
//					-----讀取檔案-----
					Collection<Part> parts = req.getParts(); 
					FurPhoService furPhoSvc = new FurPhoService();
					for (Part part : parts) {
						String filename = getFileNameFromPart(part);
						//有照片名稱才讀
						if (filename!= null && part.getContentType()!=null) {

							// 額外測試 InputStream 與 byte[] (幫將來model的VO預作準備)
							InputStream in = part.getInputStream();
							byte[] buf = new byte[in.available()]; 
							in.read(buf);
							in.close();
							//讀取圖片後 新增照片
							FurPhoVO furPhoVO=new FurPhoVO();
							furPhoVO.setFnt_it_no(fnt_it_no);
							furPhoVO.setFnt_pic(buf);
							furPhoSvc.insert(furPhoVO);
						}
					}					
				
//					/***************************新增完成,準備回成功頁面***********/
					String url = "/back-end/furPho/listAllFurPho.jsp?fnt_it_no="+fnt_it_no;
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);								
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/addFurItePho.jsp");
					failureView.forward(req, res);
				}
			}
		//此段未改
//		if ("getOne_For_Display".equals(action)) { 
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//				String str = req.getParameter("furPhono");
//
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("請輸入員工編號");
//				}
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}
//
//				Integer furPhono = null;
//				try {
//					furPhono = new Integer(str);
//				} catch (Exception e) {
//					errorMsgs.add("員工編號格式不正確");
//				}
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}
//
//				/*************************** 2.開始查詢資料 *****************************************/
//				FurPhoService furPhoSvc = new FurPhoService();
//				FurPhoVO furPhoVO = furPhoSvc.getOneFurPho(furPhono);
//				if (furPhoVO == null) {
//					errorMsgs.add("查無資料");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}
//
//				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("furPhoVO", furPhoVO); // 資料庫取出的empVO物件,存入req
//				String url = "/back-end/furPho/listOneFurPho.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
//				successView.forward(req, res);
//
//				/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
//				failureView.forward(req, res);
//			}
//		}
	

	 
		 if ("insert".equals(action)) { // 來自addFurPho.jsp的請求  
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				byte[] fnt_picRead=null;
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
//					-----讀取檔案-----
					
					InputStream in = req.getPart("fnt_pic").getInputStream();
					fnt_picRead = new byte[in.available()];
					in.read(fnt_picRead);
					if(in.available()==0) {
						errorMsgs.add("請選擇家具照片");
					}
//					========================================================
					FurPhoVO furPhoVO = new FurPhoVO();
					furPhoVO.setFnt_it_no(fnt_it_no);
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furPhoVO", furPhoVO);
						req.setAttribute("fnt_ctgr_no", fnt_ctgr_no);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furPho/addFurPho.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.開始新增資料***************************************/
					FurPhoService furPhoSvc = new FurPhoService();
				
					furPhoVO = furPhoSvc.addFurPho(fnt_it_no,fnt_picRead);
					
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = "/back-end/furPho/listAllFurPho.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
					successView.forward(req, res);				
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furPho/addFurPho.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 if ("delete".equals(action)) { 

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
				String requestURL = req.getParameter("requestURL");
				System.out.println(requestURL);
				
				try {
					/***************************1.接收請求參數***************************************/
					Integer fnt_pic_no = new Integer(req.getParameter("fnt_pic_no"));
					
					/***************************2.開始刪除資料***************************************/
					FurPhoService furPhoSvc = new FurPhoService();
					FurPhoVO furPhoVO=new FurPhoVO();
					furPhoVO=furPhoSvc. getOneFurPho(fnt_pic_no);
					Integer fnt_it_no=furPhoVO.getFnt_it_no();
					furPhoSvc.deleteFurPho(fnt_pic_no);
					
					/***************************3.刪除完成,準備轉交(Send the Success view)***********/
					String url = requestURL;
					RequestDispatcher successView = req.getRequestDispatcher(url+"?fnt_it_no="+fnt_it_no); // 刪除成功後,轉交回送出刪除的來源網頁
					successView.forward(req, res);
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("刪除資料失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furPho/listAllFurPho.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 if ("getOne_For_Update".equals(action)) { 

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.接收請求參數****************************************/
					Integer fnt_pic_no = new Integer(req.getParameter("fnt_pic_no"));
					
					/***************************2.開始查詢資料****************************************/
					FurPhoService furPhoSvc = new FurPhoService();
					FurPhoVO furPhoVO = furPhoSvc.getOneFurPho(fnt_pic_no);
					FurIteService svc = new FurIteService();
					Integer ii = furPhoVO.getFnt_it_no();
					FurIteVO furIteVO = svc.getOneFurIte(ii);
					
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("furPhoVO", furPhoVO); 
					req.setAttribute("furIteVO", furIteVO); 
					String url = "/back-end/furPho/update_FurPho_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_emp_input.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理************************************/
				} catch (Exception e) {
					errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furPho/listAllFurPho.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				byte[] fnt_picRead=null;
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
					Integer fnt_pic_no = new Integer(req.getParameter("fnt_pic_no"));
					Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
//					-----讀取照片檔案-----
					
					InputStream in = req.getPart("fnt_pic").getInputStream();
					fnt_picRead = new byte[in.available()];
					
					if(in.available()==0) {
						FurPhoService furPhoSvc=new FurPhoService();
						FurPhoVO furPhoVO=furPhoSvc.getOneFurPho(fnt_pic_no);
						fnt_picRead=furPhoVO.getFnt_pic();
						//取原資料庫
					}
					in.read(fnt_picRead);
					in.close();
//					========================================================
					FurPhoVO furPhoVO = new FurPhoVO();
					furPhoVO.setFnt_pic_no(fnt_pic_no);
					furPhoVO.setFnt_it_no(fnt_it_no);
					furPhoVO.setFnt_pic(fnt_picRead);
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furPhoVO", furPhoVO); 
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furPho/update_FurPho_input.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.開始新增資料***************************************/
					FurPhoService furPhoSvc = new FurPhoService();			
					furPhoVO = furPhoSvc.updateFurPho(fnt_pic_no,fnt_it_no,fnt_picRead);
					
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = "/back-end/furPho/listAllFurPho.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
					successView.forward(req, res);				
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furPho/update_FurPho_input.jsp");
					failureView.forward(req, res);
				}
		 }
	}



	
}

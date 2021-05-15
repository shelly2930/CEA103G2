package com.furIte.controller;

import java.io.*;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.*;
import javax.servlet.http.*;
import com.furCat.model.FurCatService;
import com.furIte.model.*;
import com.furPho.model.FurPhoService;
import com.furPho.model.FurPhoVO;

public class FurIteServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
	    res.setContentType("text/html; charset=Big5");
		String action = req.getParameter("action");
		
		
		//<前台用>首頁進租家具瀏覽頁面 所呈現之家具(留意上下架狀態)
	 if ("listGetOnFurIteByCat".equals(action)) { // 來自前台瀏覽家具listAllFur.jsp的請求
		
		try {
			Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
		   /***************************1.開始查詢所以上架家具資料****************************************/
			FurIteService furIteSvc = new FurIteService();
			List <FurIteVO> list=furIteSvc.getGetOnFurIteByCat(fnt_ctgr_no);
							
			/***************************3.查詢完成,準備轉交(Send the Success view)************/
			req.setAttribute("QueryResultList", list);         // 資料庫取出的empVO物件,存入req
			req.setAttribute("fnt_ctgr_no", fnt_ctgr_no);         // 資料庫取出的empVO物件,存入req
			String url = "/unprotected/furniture/listAllFur.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);

			/***************************其他可能的錯誤處理**********************************/
		} catch (Exception e) {
//			errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("/index.jsp");
			failureView.forward(req, res);
		}
	}
		
		//<前台及後台查上架商品用>首頁進租家具瀏覽頁面 所呈現之家具(留意上下架狀態)
		 if ("listAllGetOnFurIte".equals(action) || "getOnItem".equals(action)) { // 來自前台瀏覽家具listAllFur.jsp的請求
			 String requestURL=req.getParameter("requestURL");
				try {
			     
				   /***************************1.開始查詢所有上架家具資料****************************************/
					FurIteService furIteSvc = new FurIteService();
					List <FurIteVO> list=furIteSvc.getAllGetOnFurIte();
									
					/***************************2.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("QueryResultList", list);         // 資料庫取出的empVO物件,存入req
					//從前台來的上架需求
					if(!("/back-end/furIte/listAllFurIte.jsp".equals(requestURL))) {
					String url = "/unprotected/furniture/listAllFur.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);}else{ //從後台來的查上架商品需求
						String url = "/back-end/furIte/listAllFurIte.jsp";
						RequestDispatcher successView = req.getRequestDispatcher(url);
						successView.forward(req, res);
					}

					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
//					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					if(!("/listAllFurIte.jsp".equals(requestURL))) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
				}else {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/listAllFurIte.jsp");
					failureView.forward(req, res);
				}
			}
		 }
		 //<後台查下架商品用>
		 if ("getOffItem".equals(action)) { // 來自後台瀏覽家具listAllFurIte.jsp的請求
			 List<String> errorMsgs = new LinkedList<String>();
			 try {
				 
				 /***************************1.開始查詢所有上架家具資料****************************************/
				 FurIteService furIteSvc = new FurIteService();
				 List <FurIteVO> list=furIteSvc.getAllGetOffFurIte();
				 
				 /***************************2.查詢完成,準備轉交(Send the Success view)************/
				 req.setAttribute("QueryResultList", list);         // 資料庫取出的empVO物件,存入req
				 //從後台來的下架需求
						 String url = "/back-end/furIte/listAllFurIte.jsp";
						 RequestDispatcher successView = req.getRequestDispatcher(url);
						 successView.forward(req, res);
				 
				 /***************************其他可能的錯誤處理**********************************/
			 } catch (Exception e) {
					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					 RequestDispatcher failureView = req
							 .getRequestDispatcher("/back-end/furIte/listAllFurIte.jsp");
					 failureView.forward(req, res);
			 }
		 }

//<前台用>已上架商品之關鍵字模糊查詢 keywordSearchFromFN
		 if ("keywordSearchFromFE".equals(action)) { // 來自瀏覽家具頁面listAllFur.jsp的請求
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
					String keyword = req.getParameter("keyword");
					if (keyword == null || (keyword.trim()).length() == 0) {
						errorMsgs.add("請輸入搜尋關鍵字");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/unprotected/furniture/listAllFur.jsp");
						failureView.forward(req, res);
						return;//程式中斷
					}
				     
							/***************************2.開始查詢資料****************************************/
					FurIteService furIteSvc = new FurIteService();
					List <FurIteVO> list=furIteSvc.getOneFurIteByKWtoFE(keyword);
									
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("QueryResultList", list);         // 資料庫取出的empVO物件,存入req
					String url = "/unprotected/furniture/listAllFur.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 
		
		//關鍵字模糊查詢
		 if ("keywordSearch".equals(action)) { // 來自listAllFurIte.jsp的請求
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
					String keyword = req.getParameter("keyword");
					if (keyword == null || (keyword.trim()).length() == 0) {
						errorMsgs.add("請輸入搜尋關鍵字");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/listAllFurIte.jsp");
						failureView.forward(req, res);
						return;//程式中斷
					}
				
				     
							/***************************2.開始查詢資料****************************************/
					FurIteService furIteSvc = new FurIteService();
					List <FurIteVO> list=furIteSvc.getOneFurIteByKW(keyword);
									
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("QueryResultList", list);         // 資料庫取出的empVO物件,存入req
					String url = "/back-end/furIte/listAllFurIte.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/listAllFurIte.jsp");
					failureView.forward(req, res);
				}
			}
		 
		
		
		//點擊家具品項名稱跳轉至所選品項清單
		if ("getOne_furLis".equals(action)) {

			try {
				// Retrieve form parameters.
				String fnt_name = new String(req.getParameter("fnt_name"));
				FurIteDAO dao = new FurIteDAO();
				FurIteVO furIteVO = dao.findByFurName(fnt_name);

				req.setAttribute("furIteVO", furIteVO); 

				RequestDispatcher successView = req
						.getRequestDispatcher("/back-end/furIte/listOneFurList.jsp");
				successView.forward(req, res);
				return;

				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
	//新增資料鈕連結(新增品項頁面的下一步按鈕)
		 if ("insert".equals(action)) {   
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
					//家具類別選單
					Integer fnt_ctgr_no=null;
					try {
						fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
					} catch (Exception e) {
						errorMsgs.add("請選擇家具類別");
					}
					
					//家具名稱					
					String fnt_name = req.getParameter("fnt_name");
					String fnt_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
					if (fnt_name == null || fnt_name.trim().length() == 0) {
						fnt_name ="";
						errorMsgs.add("家具品項名稱: 請勿空白");
					} else if(!fnt_name.trim().matches(fnt_nameReg)) { 
						errorMsgs.add("家具品項名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
		            }
//					//家具圖片
//					InputStream in = req.getPart("fnt_pic").getInputStream();
//					byte[] fnt_picRead = new byte[in.available()];
//					in.read(fnt_picRead);
					
					//可租數量
					Integer fnt_unrent = null;
					try {
						fnt_unrent = new Integer(req.getParameter("fnt_unrent").trim());
					} catch (NumberFormatException e) {
						fnt_unrent = 0;
						errorMsgs.add("可租數量請填數字.");
					}
					
					//維修數量
					Integer fnt_repair = null;
					try {
						fnt_repair = new Integer(req.getParameter("fnt_repair").trim());
					} catch (NumberFormatException e) {
						fnt_repair = 0;
						errorMsgs.add("維修數量請填數字.");
					}
					
					//總數量
					Integer fnt_total = null;
					try {
						fnt_total = new Integer(req.getParameter("fnt_total").trim());
					} catch (NumberFormatException e) {
						fnt_total = 0;
						errorMsgs.add("總數量請填數字.");
					}
					
					//出租價格
					Integer fnt_price = null;
					try {
						fnt_price = new Integer(req.getParameter("fnt_price").trim());
					} catch (NumberFormatException e) {
						fnt_price = 0;
						errorMsgs.add("維修數量請填數字.");
					}
					//長度
					Double fnt_length = null;
					try {
						fnt_length = new Double(req.getParameter("fnt_length").trim());
					} catch (NumberFormatException e) {
						fnt_length = 0.0;
						errorMsgs.add("長度請填數字.");
					}
					//寬度
					Double fnt_width = null;
					try {
						fnt_width = new Double(req.getParameter("fnt_width").trim());
					} catch (NumberFormatException e) {
						fnt_width = 0.0;
						errorMsgs.add("寬度請填數字.");
					}
				
					//高度
					Double fnt_height = null;
					try {
						fnt_height = new Double(req.getParameter("fnt_height").trim());
					} catch (NumberFormatException e) {
						fnt_height = 0.0;
						errorMsgs.add("高度請填數字.");
					}
				
					//重量
					Double fnt_weight = null;
					try {
						fnt_weight = new Double(req.getParameter("fnt_weight").trim());
					} catch (NumberFormatException e) {
						fnt_weight = 0.0;
						errorMsgs.add("重量請填數字.");
					}
					//規格					
					String fnt_standard = req.getParameter("fnt_standard");
					String fnt_standardReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_ )( /)]{2,20}$";
					if (fnt_standard  == null || fnt_standard.trim().length() == 0) {
						errorMsgs.add("家具規格: 請勿空白");
					} else if(!fnt_standard .trim().matches(fnt_standardReg)) { 
						errorMsgs.add("家具規格: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
		            }
					//品項介紹					
					String fnt_info = req.getParameter("fnt_info");
					if (fnt_info  == null || fnt_info.trim().length() == 0) {
						errorMsgs.add("品項介紹: 請勿空白");
					} 
					
					//瀏覽次數
					Integer fnt_views = null;
					try {
						fnt_views = new Integer(req.getParameter("fnt_views").trim());
					} catch (NumberFormatException e) {
						fnt_views = 0;
						errorMsgs.add("瀏覽次數請填數字.");
					}
					
					//刊登狀態
					Byte fnt_post_status=null;
					try {
						fnt_post_status = new Byte(req.getParameter("fnt_post_status").trim());
					} catch (Exception e) {
						fnt_post_status='0';
						errorMsgs.add("請選擇家具刊登狀態");
					}
					
					FurIteVO furIteVO = new FurIteVO();
					furIteVO.setFnt_ctgr_no(fnt_ctgr_no);
					furIteVO.setFnt_name(fnt_name);
					furIteVO.setFnt_unrent(fnt_unrent);
					furIteVO.setFnt_repair(fnt_repair);
					furIteVO.setFnt_total(fnt_total);
					furIteVO.setFnt_price(fnt_price);
					furIteVO.setFnt_length(fnt_length);
					furIteVO.setFnt_width(fnt_width);
					furIteVO.setFnt_height(fnt_height);
					furIteVO.setFnt_weight(fnt_weight);
					furIteVO.setFnt_standard(fnt_standard);
					furIteVO.setFnt_info(fnt_info);
					furIteVO.setFnt_views(fnt_views);
					furIteVO.setFnt_post_status(fnt_post_status);
		
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furIteVO", furIteVO); // 含有輸入格式錯誤的furIteVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furIte/addFurIte.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.開始新增資料***************************************/
					FurIteService furIteSvc = new FurIteService();
					furIteVO = furIteSvc.addFurIte(fnt_ctgr_no,fnt_name, fnt_unrent, fnt_repair,
							fnt_total, fnt_price, fnt_length, fnt_width, fnt_height,
							fnt_weight, fnt_standard, fnt_info, fnt_views,fnt_post_status);

//	找新增的品項編號給新增圖片用
					Integer fnt_it_no=furIteSvc.GetLastFnt_it_no();
					req.setAttribute("fnt_it_no", fnt_it_no);
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = "/back-end/furIte/addFurItePho.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 
					successView.forward(req, res);				
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/addFurIte.jsp");
					failureView.forward(req, res);
				}
			}
		//來自管理頁面修改鈕
		 if ("getOne_For_Update".equals(action)) { // 來自listAllFurIte.jsp的請求

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.接收請求參數****************************************/
					Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
					
					/***************************2.開始查詢資料****************************************/
					FurIteService furIteSvc = new FurIteService();
					FurIteVO furIteVO = furIteSvc.getOneFurIte(fnt_it_no);
									
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("furIteVO", furIteVO);         // 資料庫取出的empVO物件,存入req
					String url = "/back-end/furIte/update_furIte_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/listAllFurIte.jsp");
					failureView.forward(req, res);
				}
			}
		 
		//來自前台家具圖點入家具介紹
		 if ("getOneFurIteToFE".equals(action)) { // 來自listAllFurIte.jsp的請求

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				try {
					/***************************1.接收請求參數****************************************/
					Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
					/***************************2.開始查詢資料****************************************/
					FurIteService furIteSvc = new FurIteService();
					FurIteVO furIteVO = furIteSvc.showOneFurIteToFE(fnt_it_no);
					FurPhoService furPhoSvc=new FurPhoService();
					List<FurPhoVO> furPhoList=furPhoSvc.getOneFntItePics(fnt_it_no);
									
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("furPhoList", furPhoList);         // 資料庫取出的empVO物件,存入req
					req.setAttribute("furIteVO", furIteVO);         // 資料庫取出的empVO物件,存入req
					String url = "/unprotected/furniture/listOneFurIteToFE.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交至介紹頁面
					successView.forward(req, res);

					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/unprotected/furniture/listAllFur.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 
		//修改資料頁面連結
		 if ("update".equals(action)) {   
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
					//家具品項編號
					Integer fnt_it_no=new Integer(req.getParameter("fnt_it_no").trim());
					//家具類別選單
					Integer fnt_ctgr_no=null;
					try {
						fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
					} catch (Exception e) {
						errorMsgs.add("請選擇家具類別");
					}
					
					//家具品項名稱					
					String fnt_name = req.getParameter("fnt_name");
					String fnt_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_ )]{2,20}$";
					if (fnt_name == null || fnt_name.trim().length() == 0) {
						fnt_name ="";
						errorMsgs.add("家具品項名稱: 請勿空白");
					} else if(!fnt_name.trim().matches(fnt_nameReg)) { 
						errorMsgs.add("家具品項名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
		            }
					
					//可租數量
					Integer fnt_unrent = null;
					try {
						fnt_unrent = new Integer(req.getParameter("fnt_unrent").trim());
					} catch (NumberFormatException e) {
						fnt_unrent = 0;
						errorMsgs.add("可租數量請填數字.");
					}
					
					//維修數量
					Integer fnt_repair = null;
					try {
						fnt_repair = new Integer(req.getParameter("fnt_repair").trim());
					} catch (NumberFormatException e) {
						fnt_repair = 0;
						errorMsgs.add("維修數量請填數字.");
					}
					
					//總數量
					Integer fnt_total = null;
					try {
						fnt_total = new Integer(req.getParameter("fnt_total").trim());
					} catch (NumberFormatException e) {
						fnt_total = 0;
						errorMsgs.add("總數量請填數字.");
					}
					
					//出租價格
					Integer fnt_price = null;
					try {
						fnt_price = new Integer(req.getParameter("fnt_price").trim());
					} catch (NumberFormatException e) {
						fnt_price = 0;
						errorMsgs.add("維修數量請填數字.");
					}
					//長度
					Double fnt_length = null;
					try {
						fnt_length = new Double(req.getParameter("fnt_length").trim());
					} catch (NumberFormatException e) {
						fnt_length = 0.0;
						errorMsgs.add("長度請填數字.");
					}
					//寬度
					Double fnt_width = null;
					try {
						fnt_width = new Double(req.getParameter("fnt_width").trim());
					} catch (NumberFormatException e) {
						fnt_width = 0.0;
						errorMsgs.add("寬度請填數字.");
					}
				
					//高度
					Double fnt_height = null;
					try {
						fnt_height = new Double(req.getParameter("fnt_height").trim());
					} catch (NumberFormatException e) {
						fnt_height = 0.0;
						errorMsgs.add("高度請填數字.");
					}
				
					//重量
					Double fnt_weight = null;
					try {
						fnt_weight = new Double(req.getParameter("fnt_weight").trim());
					} catch (NumberFormatException e) {
						fnt_weight = 0.0;
						errorMsgs.add("重量請填數字.");
					}
					//規格					
					String fnt_standard = req.getParameter("fnt_standard");
					String fnt_standardReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_ )( /)]{2,20}$";
					if (fnt_standard  == null || fnt_standard.trim().length() == 0) {
						errorMsgs.add("家具規格: 請勿空白");
					} else if(!fnt_standard.trim().matches(fnt_standardReg)) { 
						errorMsgs.add("家具規格: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
		            }
					//品項介紹					
					String fnt_info = req.getParameter("fnt_info");
					if (fnt_info  == null || fnt_info.trim().length() == 0) {
						errorMsgs.add("品項介紹: 請勿空白");
					} 
					//瀏覽次數
					Integer fnt_views = null;
					try {
						fnt_views = new Integer(req.getParameter("fnt_views").trim());
					} catch (NumberFormatException e) {
						fnt_views = 0;
						errorMsgs.add("瀏覽次數請填數字.");
					}
					
					//刊登狀態
					Byte fnt_post_status=null;
					try {
						fnt_post_status = new Byte(req.getParameter("fnt_post_status").trim());
					} catch (Exception e) {
						fnt_post_status='0';
						errorMsgs.add("請選擇家具刊登狀態");
					}
					FurIteVO furIteVO = new FurIteVO();
					furIteVO.setFnt_it_no(fnt_it_no);
					furIteVO.setFnt_ctgr_no(fnt_ctgr_no);
					furIteVO.setFnt_name(fnt_name);
					furIteVO.setFnt_unrent(fnt_unrent);
					furIteVO.setFnt_repair(fnt_repair);
					furIteVO.setFnt_total(fnt_total);
					furIteVO.setFnt_price(fnt_price);
					furIteVO.setFnt_length(fnt_length);
					furIteVO.setFnt_width(fnt_width);
					furIteVO.setFnt_height(fnt_height);
					furIteVO.setFnt_weight(fnt_weight);
					furIteVO.setFnt_standard(fnt_standard);
					furIteVO.setFnt_info(fnt_info);
					furIteVO.setFnt_views(fnt_views);
					furIteVO.setFnt_post_status(fnt_post_status);
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furIteVO", furIteVO); // 含有輸入格式錯誤的furIteVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furIte/update_furIte_input.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.開始新增資料***************************************/
					FurIteService furIteSvc = new FurIteService();
					furIteVO = furIteSvc.updateFurIte(fnt_it_no,fnt_ctgr_no,fnt_name, fnt_unrent, fnt_repair,
							fnt_total, fnt_price, fnt_length, fnt_width, fnt_height,
							fnt_weight, fnt_standard, fnt_info, fnt_views,fnt_post_status);
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = "/back-end/furIte/listAllFurIte.jsp";
					req.setAttribute("furIteVO", furIteVO);  
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);				
				
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/update_furIte_input.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 
			if ("delete".equals(action)) { 

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑

				try {
					/***************************1.接收請求參數***************************************/
					Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
					
					/***************************2.開始刪除資料***************************************/
					FurIteService furIteSvc = new FurIteService();
					furIteSvc.deleteFurIte(fnt_it_no);
					
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
		 
//從家具類別查家具品項 
			if ("getFurIteSelect".equals(action)) {
//				List<String> errorMsgs = new LinkedList<String>();
//				req.setAttribute("errorMsgs", errorMsgs);

				try {
					
					/*************************** 1.接收請求參數 ****************************************/
					Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no"));
					/*************************** 2.開始查詢資料 ****************************************/
					FurIteService furIteSvc = new FurIteService();
					String  fnt_name_Str = furIteSvc.selectByPrimaryKey(fnt_ctgr_no);

					/*************************** 3.查詢完成 ********************************************/
					   // 資料庫取出的家具品項名稱字串傳回前端
					PrintWriter out = res.getWriter();
		            out.print(fnt_name_Str);

					/*************************** 其他可能的錯誤處理 ***********************************/
				} catch (Exception e) {
					FurIteService furIteSvc = new FurIteService();
					String  all_fnt_name_Str = furIteSvc.getAllFntName();
					PrintWriter out = res.getWriter();
		            out.print(all_fnt_name_Str);
				}
			}
						
			
	}
}
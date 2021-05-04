package com.house.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.json.JSONArray;
import org.json.JSONObject;
import org.jsoup.Jsoup;

import com.addFur.model.AddFurService;
import com.addFur.model.AddFurVO;
import com.houAddFur.model.HouAddFurService;
import com.houPho.model.HouPhoService;
import com.houPho.model.HouPhoVO;
import com.house.model.HouseService;
import com.house.model.HouseVO;

@MultipartConfig
public class HouseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	======以下KEY是不是要藏一下ㄚㄚㄚㄚ?=====
	private static final String SILVERVANE_KEY = "AIzaSyDJtdRDJrA8jHn3wA3iA_20Uh7rl8CCUbY";
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
//拿到action，來進行是哪種請求
		String action = req.getParameter("action");
		if ("listHouPho_ByHouseA".equals(action) || "listHouPhoEmp".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer houseno = new Integer(req.getParameter("houseno"));
				/*************************** 2.開始查詢資料 ****************************************/
				HouseService houseSvc = new HouseService();
				Set<HouPhoVO> set = houseSvc.getHouPhoByHouse(houseno);
				HouseVO houseVO =  houseSvc.getOneHouse(houseno);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listHouPho_ByHouseNo", set); // 資料庫取出的set物件,存入request
				req.setAttribute("houseVO", houseVO);
				req.setAttribute("picSize", set.size());
				String url = null;
				if ("listHouPho_ByHouseA".equals(action))
					url = "/unprotected/house/listHouPho_ByHouseNo.jsp"; // 成功轉交 dept/listEmps_ByDeptno.jsp
				else if ("listHouPhoEmp".equals(action))
					url = "/back-end/houPho/listHouPhoEmp.jsp"; // 成功轉交 dept/listAllDept.jsp

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
/*******複合查詢***********/	/**map name : map***/	
		if ("listHouse_AllOrQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
			try {
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				//Map<String, String[]> map = req.getParameterMap();
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				/*===================
				為什麼要用session? 因為你有分頁，下面當whichpage=null，表示第一次查詢
				所以第一次時，你會拿到新的資料(VO)，放到session
				第二次進來時，你不應該從request取東西，而是用session去取出舊資料
				session的用意，簡單說就是重複拜訪servlet
				===================*/
				// 以下的 if 區塊只對第一次執行時有效
				if (req.getParameter("whichPage") == null ){//洗白
					Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
						if(req.getParameter("orderType")!=null) {
							//用舊的
							String[] orderType = {req.getParameter("orderType")};
							String[] orderCol = {req.getParameter("orderCol")};
							map.put("orderType",orderType);
							map.put("orderCol",orderCol);
						}else if(req.getParameter("hos_city")!=null && req.getParameter("hos_dist")!=null){
							String[] hos_city = {req.getParameter("hos_city")};
							String[] hos_dist = {req.getParameter("hos_dist")};
							map.put("hos_city",hos_city);
							map.put("hos_dist",hos_dist);
						}else if(req.getParameter("hos_city")!=null && req.getParameter("hos_dist")==null){
							String[] hos_city = {req.getParameter("hos_city")};
							map.put("hos_city",hos_city);
						}else if(req.getParameter("hos_dist")==null && req.getParameter("hos_dist")!=null){
							String[] hos_dist = {req.getParameter("hos_dist")};
							map.put("hos_dist",hos_dist);
						}else if(req.getParameter("price")!=null){
							String[] price = {req.getParameter("price")};
							map.put("price",price);
						}else if(req.getParameter("hos_type")!=null){
							String[] hos_type = {req.getParameter("hos_type")};
							map.put("hos_type",hos_type);
						}else if(req.getParameter("area")!=null){
							String[] area = {req.getParameter("area")};
							map.put("area",area);
						}else{
							//首次進入該頁面
							String[] hos_city = {req.getParameter("hos_city")};
							String[] hos_dist = {req.getParameter("hos_dist")};
							String[] hos_rent = {req.getParameter("hos_rent")};
							String[] hos_type = {req.getParameter("hos_type")};//0：不限1：獨立套房2：分租套房3：雅房  4：整層住家 5：車位6：其他
							String[] hos_squares = {req.getParameter("hos_squares")};
							map1.put("hos_city",hos_city);
							map1.put("hos_dist", hos_dist);
							map1.put("hos_rent", hos_rent);
							map1.put("hos_type", hos_type);
							map1.put("hos_squares", hos_squares);
							session.setAttribute("map",map1);//放到session
							map = map1;
						}
				}
				/***************************2.開始複合查詢***************************************/
				HouseService houseSvc = new HouseService();
				List<HouseVO> list  = houseSvc.getAll(map);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listHouse_AllOrQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/unprotected/house/listAllHouse.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
		}
/*******複合查詢**************/	
		
/*******後台物件查詢***********//**map name : map_house_back***/
			if ("listAllHouse_Backend".equals(action)||"listAllHouse_Backend_Emp".equals(action)) { 
				/*************************** 1.接收請求參數 ***************************************/
			try {
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map_house_back");
				if(req.getParameter("whichPage")==null) {
					Map<String, String[]> map_house_back = new HashMap<String, String[]>(req.getParameterMap());
					if(map_house_back!=null) {
						map=map_house_back;
					}
				}
				session.setAttribute("map_house_back",map);//放到session
				/*************************** 2.開始取出物件 ***************************************/
				HouseService houseSvc = new HouseService();
				List<HouseVO> list = houseSvc.getAll_Back(map);
				/*************************** 3.取出完成,準備轉交(Send the Success view) ***********/
				String url =null;
				if("listAllHouse_Backend_Emp".equals(action)) {
					url = "/back-end/house/listAllHouseEmp.jsp";
				}else {
					url = "/back-end/house/listAllHouseBoss.jsp";
				}
				//轉交到listAllHouse_Backend 傳送要show給主管物件
				req.setAttribute("listAllHouse_Backend_list", list);
				req.setAttribute("listSize", list.size());
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
		}
	
/*******導向房東新增物件***********/		
		if ("goToInsert".equals(action)) { 
			try {
				/*************************** 1.接收請求參數 ***************************************/
				//只是想要拉出所有附設家具
				/*************************** 2.開始取出附設家具資料 ***************************************/
				AddFurService addFurSvc = new AddFurService();
				List<AddFurVO> addFurVO_list = addFurSvc.getAll();
				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/unprotected/house/addHouse.jsp";
				req.setAttribute("addFurVO_list", addFurVO_list);
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
		}
		
/*******房東新增物件***********/
		if ("insert".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				//*表示 功能要在改善
				//#表示 該表格之後要在主管或員工那裏可以更改
				//*2.房東編號(之後要從會員拿出資料 不用驗證，前臺直接顯示)
				Integer lld_no = null;
				try {
					lld_no = new Integer(req.getParameter("lld_no").trim());//new Integer("2")可以轉成數字，備註:小數轉會跳出num錯誤
				} catch (NumberFormatException e) {
					lld_no = 0;
					errorMsgs.add("房東編號請填數字");
				}
				//#3.物件名稱(房東 員工 主管 都能改)
				String hos_name = req.getParameter("hos_name").trim();
				if (hos_name == null || hos_name.trim().length() == 0) {
					errorMsgs.add("物件名稱請勿空白");
				}
//				#4.物件租金(房東 員工 主管 都能改)
				Integer hos_rent = null;
				try {
					hos_rent = new Integer(req.getParameter("hos_rent").trim());
				} catch (NumberFormatException e) {
					hos_rent = 0;
					errorMsgs.add("物件租金請填數字");
				}
//				*#5.管理費(之後要製作讓主管 員工可以更改 倍率)
				Integer hos_expense = (int) (hos_rent * 0.1);
//				#8.縣市(下拉式選單)
				String hos_city = req.getParameter("hos_city");
//				#9.鄉鎮(下拉式選單)
				String hos_dist = req.getParameter("hos_dist");
//				*#10.地址(之後要驗證 不要讓別人亂填)(員工可以更改)
				String hos_address = req.getParameter("hos_address");
				String hos_addressReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,30}$";
				if (hos_address == null || hos_address.trim().length() == 0) {
					errorMsgs.add("地址: 請勿空白");
				} else if (!hos_address.trim().matches(hos_addressReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("地址只能是中文字，且長度必需在1到30之間");
				}
//				經緯度(地址成功，才從Geocoding去取得資料)
/**應該另外寫一個controller去轉經緯度，之後完成(未完待續)****/
				String address= hos_city+hos_dist+hos_address;
				String URL = "https://maps.googleapis.com/maps/api/geocode/json"
						+ "?address="+address
						+ "&key=" + SILVERVANE_KEY;
//				#11,12.經緯
			
				Double hos_lon = null;
				Double hos_lat = null;						
				try {
					String jsonStr = Jsoup.connect(URL).ignoreContentType(true).execute().body().toString();				
					JSONObject jsonObj = new JSONObject(jsonStr);
					JSONArray results = jsonObj.getJSONArray("results");
					JSONObject southwest = results.getJSONObject(0).getJSONObject("geometry").getJSONObject("viewport").getJSONObject("southwest");
//					經度
					hos_lon = southwest.getDouble("lng");
//					緯度
					hos_lat = southwest.getDouble("lat");
			
				}catch(Exception e) {
					System.out.println("GEOcoding連線失敗!!");
				}
//				#13.房型(用下拉式選單，不用驗證)
				Byte hos_type =Byte.valueOf(req.getParameter("hos_type").trim());
//				#14.介紹(房東填寫出版   員工更改要上架的介紹)
				String hos_info = req.getParameter("hos_info").trim();
				if (hos_info == null || hos_info.trim().length() == 0) {
					errorMsgs.add("介紹請勿空白");
				}
//				#15.屋齡(房東 員工 主管可以更改)
				Integer hos_age = null;
				try {
					hos_age = new Integer(req.getParameter("hos_age").trim());
				} catch (NumberFormatException e) {
					hos_age = 0;
					errorMsgs.add("屋齡請填數字");
				}
//				#16.樓層(房東 員工 主管可以更改)
				Integer hos_floor = null;
				try {
					hos_floor = new Integer(req.getParameter("hos_floor").trim());
				} catch (NumberFormatException e) {
					hos_floor = 0;
					errorMsgs.add("樓層請填數字");
				}
//				#17、18、19、20提供服務，電梯、停車位、可養寵物等等	(房東 員工 主管可以更改)			
				Byte hos_ele = 0;
				Byte hos_parking = 0;
				Byte hos_pet = 0;
				Byte hos_cook = 0;
				String[] hos_check = req.getParameterValues("hos_check");
				if (hos_check != null) {//全部沒選checkbox，會是null
					for (int i = 0; i < hos_check.length; i++) {
						switch (hos_check[i]) {//java X版本後面可以比較字串了
						case "hos_ele":
							hos_ele = 1;
							break;
						case "hos_parking":
							hos_parking = 1;
							break;
						case "hos_pet":
							hos_pet = 1;
							break;
						case "hos_cook":
							hos_cook = 1;
							break;
						}
					}
				}
//				#21坪數(房東 員工 主管可以更改)
				Double hos_squares = null;
				try {
					hos_squares = new Double(req.getParameter("hos_squares").trim());
				} catch (NumberFormatException e) {
					hos_squares = 0.0;
					errorMsgs.add("坪數請填數字.");
				}
//				#22.性別限制 Byte(下拉式選單，不用驗證)
				Byte hos_gender =Byte.valueOf(req.getParameter("hos_gender").trim());
//				#23.水費Double
				Double hos_water = null;
				try {
					hos_water = new Double(req.getParameter("hos_water").trim());
				} catch (NumberFormatException e) {
					hos_water = 0.0;
					errorMsgs.add("水費請填數字.");
				}
//				#24.電費Double
				Double hos_power = null;
				try {
					hos_power = new Double(req.getParameter("hos_power").trim());
				} catch (NumberFormatException e) {
					hos_power = 0.0;
					errorMsgs.add("電費請填數字.");
				}
//				#25.網路費Int
				Integer hos_internet = null;
				try {
					hos_internet = new Integer(req.getParameter("hos_internet").trim());
				} catch (NumberFormatException e) {
					hos_internet = 0;
					errorMsgs.add("網路費請填數字");
				}
//				26.申請時間Timestamp(當下時間)
				java.sql.Timestamp hos_apptime = new java.sql.Timestamp(System.currentTimeMillis());
//				27.預約時間Timestamp(選取時間)
/**到時候定義一個初始值**/
				java.sql.Timestamp hos_order_date = null;
				try {
					hos_order_date = java.sql.Timestamp.valueOf(req.getParameter("hos_order_date"));
				} catch (IllegalArgumentException e) {
					hos_order_date = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
//				31.所有權狀照片byte[]
//				===================以下所有權狀讀檔案================================
				InputStream in = req.getPart("hos_loc_pic").getInputStream();
				byte[] hos_picBuf = new byte[in.available()];
//				in.read(hos_picBuf) 是buf這陣列用inputstream到資料近來
//				所下面執行完，buf已經含有資料了
				in.read(hos_picBuf);
//				===================以上所有權狀讀檔案================================	
				
//==============(以下僅參考)之後可以用的格式轉換===========================================================				
				//java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//這是yyyy-MM-dd HH:mm:ss是你讀進來的檔案格式
				//格式
				
				//這是date轉String
				//String formatDate = df.format(new java.util.Date());
				//這是String轉date
				//java.sql.Date date = df.parse("0000-00-00 00:00:00");
				//方法
				//java.sql.Date date = java.sql.Date.valueOf();
				/***************以下是沒有要讓房東新增的資料****************************************/
//				#6.刊登日期(先塞申請 之後當員工上架時要填入日期)
/**到時候定義一個初始值**/
				java.sql.Timestamp hos_date = null;
				hos_date = new java.sql.Timestamp(System.currentTimeMillis());
//				*7.瀏覽次數 (之後實作)
				Integer hos_views = 0;
//				#28.負責員工(主管更改)(0表示尚未指派)
				Integer emp_no = 0;
//				#29.申請進度(從未處理0曾經修改就1送出已成功2申請失敗3)
				Byte hos_status = 0;
//				30.審核結果(廢棄欄位，無視)
				Byte hos_result = 0;
//				#32.刊登狀態(0申請成功但未刊登 1上架中 2下架中)
				Byte hos_state = 0;
//				33.未通過原因
				String hos_refuse ="未填";
				/***************以上是沒有要讓房東新增的資料****************************************/			
//==============以上表單為table(House)部分=================
				
				
//==============以下表單為table(AddFur)部分================
/**附設家具(未完)**/
//				List<Integer> add_fnt_no_list = new ArrayList<Integer>();
//				String[] addfur_check = req.getParameterValues("addfur_check");
//				if (addfur_check != null) {//全部沒選checkbox，會是null
//					for (int i = 0; i < addfur_check.length; i++) {
//						add_fnt_no_list.add(new Integer(addfur_check[i]));
//					}
//				}		
//==============以上表單為table(AddFur)部分================

//==============使用者填寫時，如果有一個驗證失敗，可以不用全部重寫
//==============33個屬性只裝有填寫的部分，目前共24個
//==============物件部分
				HouseVO houseVO = new HouseVO();
				houseVO.setLld_no(lld_no);
				houseVO.setHos_name(hos_name);
				houseVO.setHos_rent(hos_rent);
				houseVO.setHos_city(hos_city);
				houseVO.setHos_dist(hos_dist);
				houseVO.setHos_address(hos_address);
				houseVO.setHos_lon(hos_lon);
				houseVO.setHos_lat(hos_lat);
				houseVO.setHos_type(hos_type);
				houseVO.setHos_info(hos_info);
				houseVO.setHos_age(hos_age);
				houseVO.setHos_floor(hos_floor);
				houseVO.setHos_ele(hos_ele);
				houseVO.setHos_parking(hos_parking);
				houseVO.setHos_pet(hos_pet);
				houseVO.setHos_cook(hos_cook);
				houseVO.setHos_squares(hos_squares);
				houseVO.setHos_gender(hos_gender);
				houseVO.setHos_water(hos_water);
				houseVO.setHos_power(hos_power);
				houseVO.setHos_internet(hos_internet);
				houseVO.setHos_apptime(hos_apptime);
				houseVO.setHos_order_date(hos_order_date);
//				======以下傳送圖片
				houseVO.setHos_loc_pic(hos_picBuf);
//				======以上傳送圖片
				if (!errorMsgs.isEmpty()) {
					AddFurService addFurSvc = new AddFurService();
					List<AddFurVO> addFurVO_list = addFurSvc.getAll();
					req.setAttribute("addFurVO_list", addFurVO_list);
					req.setAttribute("houseVO", houseVO); // 含有輸入格式錯誤的houseVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/house/addHouse.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 ***************************************/
				HouseService houseSvc = new HouseService();
				houseVO = houseSvc.addHouse(lld_no, hos_name, hos_rent, hos_expense, hos_date, hos_views, hos_city,
						hos_dist, hos_address, hos_lon, hos_lat, hos_type, hos_info, hos_age, hos_floor, hos_ele,
						hos_parking, hos_pet, hos_cook, hos_squares, hos_gender, hos_water, hos_power, hos_internet,
						hos_apptime, hos_order_date, emp_no, hos_status, hos_result, hos_picBuf, hos_state,
						hos_refuse);
/**新增物件同時新增附設家具(未完待續)**/
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/index.jsp";
/**這暫時回傳到首頁，到時候應該導向新增成功頁面，並詢問是否續新增或者一段時間回首頁**/				
				req.setAttribute("upload", "success");
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
		}
/*******指派員工***********/
		if ("change_Emp".equals(action)) { 
			HouseVO houseVO = null;//舊物件
			Integer houseno = null;//想要修改的物件編號
			Integer emp_no = null;// 欲指派員工，若尚未指派(0) 指派員工(~0)
			String[] houseno_array = null;
			String[] empno_array = null;
			List<Integer> houseno_list = new LinkedList<Integer>();
			try {
				/*************************** 1.接收請求參數 ***************************************/
				//req.getParameter("whichPage") forword會保留parameter所以不用get再set 除非你經過別頁面
				String URL = req.getParameter("requestURL");///CEA103G2/house/house.do
				/*************************** 2.開始更改資料 ***************************************/
				HouseService houseSvc = new HouseService();
				if(req.getParameterValues("houseno")!=null) {//有要更新
					houseno_array = req.getParameterValues("houseno");//拿尚未改的物件
					empno_array = req.getParameterValues("emp_no");
					int count = 0;
					for(String i : houseno_array) {
						emp_no = new Integer(empno_array[count++]);
						houseno = new Integer(i);
						houseVO = houseSvc.getOneHouse(houseno);//拿到舊資料囉
						houseSvc.updateHouse(houseVO.getHos_no(), houseVO.getLld_no(), houseVO.getHos_name()
								, houseVO.getHos_rent(), houseVO.getHos_expense(), houseVO.getHos_date()
								, houseVO.getHos_views(), houseVO.getHos_city(), houseVO.getHos_dist()
								, houseVO.getHos_address(), houseVO.getHos_lon(), houseVO.getHos_lat()
								, houseVO.getHos_type(), houseVO.getHos_info(), houseVO.getHos_age()
								, houseVO.getHos_floor(), houseVO.getHos_ele(), houseVO.getHos_parking()
								, houseVO.getHos_pet(), houseVO.getHos_cook(), houseVO.getHos_squares()
								, houseVO.getHos_gender(), houseVO.getHos_water(), houseVO.getHos_power()
								, houseVO.getHos_internet(), houseVO.getHos_apptime(), houseVO.getHos_order_date()
								, emp_no, houseVO.getHos_status(), houseVO.getHos_result()
								, houseVO.getHos_loc_pic(), houseVO.getHos_state(), houseVO.getHos_refuse());
						houseno_list.add(houseno);
					}
				}
				List<HouseVO> listAllHouse_Backend_list = houseSvc.getAll();
				/*************************** 3.更新完成,準備轉交 ***********/
				req.setAttribute("listSize", listAllHouse_Backend_list.size());
				req.setAttribute("houseVO", houseVO);
				req.setAttribute("houseno_list", houseno_list);
				req.setAttribute("listAllHouse_Backend_list", listAllHouse_Backend_list);
				
				RequestDispatcher successView = req.getRequestDispatcher(URL);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/house/indexBack.jsp");
				failureView.forward(req, res);
			}
		}
/*******更改物件狀態:多筆確認送出***********/
		if ("changeHouseStatus".equals(action)) { 
			HouseVO houseVO = null;//舊物件
			Integer houseno = null;//想要修改的物件編號
			String[] houseno_array = null;
			List<Integer> houseno_list = new LinkedList<Integer>();//變色用
			Byte status = null;
			String[]  hos_status = new String[1];
			
			if(req.getParameter("delete")!=null) {
				status = new Byte(req.getParameter("delete"));//update
				hos_status[0]=req.getParameter("delete");//換頁用
				System.out.println("S");
			}else {
				status = new Byte("2");//update
				hos_status[0]= "2";//換頁用
			}
//			try {
				/*************************** 1.接收請求參數 ***************************************/
				//req.getParameter("whichPage") forword會保留parameter所以不用get再set 除非你經過別頁面
				String URL = req.getParameter("requestURL");///CEA103G2/house/house.do
				/*************************** 2.開始更改資料 ***************************************/
				HouseService houseSvc = new HouseService();
				if(req.getParameterValues("houseno")!=null) {//有要更新
					houseno_array = req.getParameterValues("houseno");//拿尚未改的物件
					for(String i : houseno_array) {
						houseno = new Integer(i);
						houseVO = houseSvc.getOneHouse(houseno);//拿到舊資料囉
						houseSvc.updateHouse(houseVO.getHos_no(), houseVO.getLld_no(), houseVO.getHos_name()
								, houseVO.getHos_rent(), houseVO.getHos_expense(), houseVO.getHos_date()
								, houseVO.getHos_views(), houseVO.getHos_city(), houseVO.getHos_dist()
								, houseVO.getHos_address(), houseVO.getHos_lon(), houseVO.getHos_lat()
								, houseVO.getHos_type(), houseVO.getHos_info(), houseVO.getHos_age()
								, houseVO.getHos_floor(), houseVO.getHos_ele(), houseVO.getHos_parking()
								, houseVO.getHos_pet(), houseVO.getHos_cook(), houseVO.getHos_squares()
								, houseVO.getHos_gender(), houseVO.getHos_water(), houseVO.getHos_power()
								, houseVO.getHos_internet(), houseVO.getHos_apptime(), houseVO.getHos_order_date()
								, houseVO.getEmp_no(), status, houseVO.getHos_result()
								, houseVO.getHos_loc_pic(), houseVO.getHos_state(), houseVO.getHos_refuse());
						houseno_list.add(houseno);//變色用
					}
				}
				Map<String,String[]> map = new HashMap<String, String[]>();
				
				map.put("hos_status",hos_status);
				List<HouseVO> listAllHouse_Backend_list = houseSvc.getAll_Back(map);
				HttpSession session = req.getSession();
				session.setAttribute("map_house_back",map);//換頁 搜尋用
				
				
				
				
				/*************************** 3.更新完成,準備轉交 ***********/
				req.setAttribute("listSize", listAllHouse_Backend_list.size());
				req.setAttribute("houseVO", houseVO);//變色用，找到更動物件
				req.setAttribute("houseno_list", houseno_list);//變色用，找到更動物件
				req.setAttribute("listAllHouse_Backend_list", listAllHouse_Backend_list);
				System.out.println(URL);///back-end/house/listAllHouseBoss.jsp
				RequestDispatcher successView = req.getRequestDispatcher(URL);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 ***********************************/
//			} catch (Exception e) {
//				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/house/indexBack.jsp");
//				failureView.forward(req, res);
//			}
		}
/*******針對物件更改***********/
		if ("getOneHouseForUpdate".equals(action)||"updateHouseForEmp".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			HouseVO houseVO = null;//舊物件
			Integer houseno = null;//想要修改的物件編號
			try {
				/*************************** 1.接收請求參數 ***************************************/
				//req.getParameter("whichPage") forword會保留parameter所以不用get再set 除非你經過別頁面
				String URL = req.getParameter("requestURL");//回家用 送去給填資料頁面，記得設參數要回家用
				/*************************** 2.開始更改資料 ***************************************/
				HouseService houseSvc = new HouseService();
				houseno = new Integer(req.getParameter("houseno"));//拿尚未改的物件
				houseVO = houseSvc.getOneHouse(houseno);//拿到舊資料囉
				if("getOneHouseForUpdate".equals(action)) {//去updateHouseForEmp填表單
					req.setAttribute("houseVO", houseVO);
					RequestDispatcher successView = req.getRequestDispatcher("/back-end/house/updateHouseForEmp.jsp");
					successView.forward(req, res);
					return;
				}//以下就是要更新的
				/****************************驗證************************************************/
				//*2.房東編號(之後要從會員拿出資料 不用驗證，前臺直接顯示)
				//#3.物件名稱(房東 員工 主管 都能改)
				String hos_name = req.getParameter("hos_name").trim();
				if (hos_name == null || hos_name.trim().length() == 0) {
					errorMsgs.add("物件名稱請勿空白");
				}
				houseVO.setHos_name(hos_name);
//				#4.物件租金(房東 員工 主管 都能改)
				Integer hos_rent = null;
				try {
					hos_rent = new Integer(req.getParameter("hos_rent").trim());
				} catch (NumberFormatException e) {
					hos_rent = 0;
					errorMsgs.add("物件租金請填數字");
				}
				houseVO.setHos_rent(hos_rent);
//				*#5.管理費(之後要製作讓主管 員工可以更改 倍率)
				Integer hos_expense = (int) (hos_rent * 0.1);
				houseVO.setHos_expense(hos_expense);
//				#8.縣市(下拉式選單)
				String hos_city = req.getParameter("hos_city");
				houseVO.setHos_city(hos_city);
//				#9.鄉鎮(下拉式選單)
				String hos_dist = req.getParameter("hos_dist");
				houseVO.setHos_dist(hos_dist);
//				*#10.地址(之後要驗證 不要讓別人亂填)(員工可以更改)
				String hos_address = req.getParameter("hos_address");
				String hos_addressReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,30}$";
				if (hos_address == null || hos_address.trim().length() == 0) {
					errorMsgs.add("地址: 請勿空白");
				} else if (!hos_address.trim().matches(hos_addressReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("地址只能是中文字，且長度必需在1到30之間");
				}
				houseVO.setHos_address(hos_address);
//				經緯度(地址成功，才從Geocoding去取得資料)
				String address= hos_city+hos_dist+hos_address;

				String URL_update = "https://maps.googleapis.com/maps/api/geocode/json"
						+ "?address="+address
						+ "&key=" + SILVERVANE_KEY;
//				#11,12.經緯
				Double hos_lon = null;
				Double hos_lat = null;						
				try {
					String jsonStr = Jsoup.connect(URL_update).ignoreContentType(true).execute().body().toString();				
					JSONObject jsonObj = new JSONObject(jsonStr);
					JSONArray results = jsonObj.getJSONArray("results");
					JSONObject southwest = results.getJSONObject(0).getJSONObject("geometry").getJSONObject("viewport").getJSONObject("southwest");
//					經度
					hos_lon = southwest.getDouble("lng");
//					緯度
					hos_lat = southwest.getDouble("lat");
				}catch(Exception e) {
					System.out.println("GEOcoding連線失敗!!");
				}
				houseVO.setHos_lon(hos_lon);
				houseVO.setHos_lat(hos_lat);
//				#13.房型(用下拉式選單，不用驗證)
				Byte hos_type =Byte.valueOf(req.getParameter("hos_type").trim());
				houseVO.setHos_type(hos_type);
//				#14.介紹(房東填寫出版   員工更改要上架的介紹)
				String hos_info = req.getParameter("hos_info").trim();
				if (hos_info == null || hos_info.trim().length() == 0) {
					errorMsgs.add("介紹請勿空白");
				}
				houseVO.setHos_info(hos_info);
//				#15.屋齡(房東 員工 主管可以更改)
				Integer hos_age = null;
				try {
					hos_age = new Integer(req.getParameter("hos_age").trim());
				} catch (NumberFormatException e) {
					hos_age = 0;
					errorMsgs.add("屋齡請填數字");
				}
				houseVO.setHos_age(hos_age);
//				#16.樓層(房東 員工 主管可以更改)
				Integer hos_floor = null;
				try {
					hos_floor = new Integer(req.getParameter("hos_floor").trim());
				} catch (NumberFormatException e) {
					hos_floor = 0;
					errorMsgs.add("樓層請填數字");
				}
				houseVO.setHos_floor(hos_floor);
//				#17、18、19、20提供服務，電梯、停車位、可養寵物等等	(房東 員工 主管可以更改)			
				Byte hos_ele = 0;
				Byte hos_parking = 0;
				Byte hos_pet = 0;
				Byte hos_cook = 0;
				String[] hos_check = req.getParameterValues("hos_check");
				if (hos_check != null) {//全部沒選checkbox，會是null
					for (int i = 0; i < hos_check.length; i++) {
						switch (hos_check[i]) {//java X版本後面可以比較字串了
						case "hos_ele":
							hos_ele = 1;
							break;
						case "hos_parking":
							hos_parking = 1;
							break;
						case "hos_pet":
							hos_pet = 1;
							break;
						case "hos_cook":
							hos_cook = 1;
							break;
						}
					}
				}
				houseVO.setHos_ele(hos_ele);
				houseVO.setHos_parking(hos_parking);
				houseVO.setHos_pet(hos_pet);
				houseVO.setHos_cook(hos_cook);
//				#21坪數(房東 員工 主管可以更改)
				Double hos_squares = null;
				try {
					hos_squares = new Double(req.getParameter("hos_squares").trim());
				} catch (NumberFormatException e) {
					hos_squares = 0.0;
					errorMsgs.add("坪數請填數字.");
				}
				houseVO.setHos_squares(hos_squares);
//				#22.性別限制 Byte(下拉式選單，不用驗證)
//				new Integer("2")來轉型成數字，但Byte並沒有
//				!!Byte沒有提供字串自動轉型，需要Byte.valueOf()來轉成Byte
				houseVO.setHos_gender(Byte.valueOf(req.getParameter("hos_gender").trim()));
//				#23.水費Double
				Double hos_water = null;
				try {
					hos_water = new Double(req.getParameter("hos_water").trim());
				} catch (NumberFormatException e) {
					hos_water = 0.0;
					errorMsgs.add("水費請填數字.");
				}
				houseVO.setHos_water(hos_water);
//				#24.電費Double
				Double hos_power = null;
				try {
					hos_power = new Double(req.getParameter("hos_power").trim());
				} catch (NumberFormatException e) {
					hos_power = 0.0;
					errorMsgs.add("電費請填數字.");
				}
				houseVO.setHos_power(hos_power);
//				#25.網路費Int
				Integer hos_internet = null;
				try {
					hos_internet = new Integer(req.getParameter("hos_internet").trim());
				} catch (NumberFormatException e) {
					hos_internet = 0;
					errorMsgs.add("網路費請填數字");
				}
				houseVO.setHos_internet(hos_internet);
//				26.申請時間Timestamp(不需要更改時間)
//				27.預約時間Timestamp(不需要更改時間)
//				31.所有權狀照片byte[]
//				===================以下所有權狀讀檔案================================
				InputStream in = req.getPart("hos_loc_pic").getInputStream();
				byte[] hos_picBuf = new byte[in.available()];
//						in.read(hos_picBuf) 是buf這陣列用inputstream到資料近來
//						所下面執行完，buf已經含有資料了
				in.read(hos_picBuf);
				houseVO.setHos_loc_pic(hos_picBuf);
//				===================以上所有權狀讀檔案================================	
				
//==============(以下僅參考)之後可以用的格式轉換===========================================================				
//==============以下是沒有要讓房東新增的資料==================================
//				#6.刊登日期(先塞申請 之後當員工上架時要填入日期)

//				#28.負責員工(主管更改)
//				#29.申請進度
				Byte hos_status = new Byte("1");//修改過了 更正為1
				houseVO.setHos_status(hos_status);
//				30.審核結果(廢棄欄位)
//				#32.刊登狀態(1.未刊登 2.上架中 3.下架)
//				33.未通過原因
//==============以上是沒有要讓房東新增的資料==================================
				
				
//==============以上表單為table(House)部分====================================
				
//==============以下表單為table(AddFur)部分===================================
//===================================以上表單為table(AddFur)部分===================================

				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("houseVO", houseVO); // 含有輸入格式錯誤的houseVO物件,也存入req
//					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/house/addHouse.jsp");
//					failureView.forward(req, res);
//					return;
//				}
				/*************************** 3.驗證完成,準備轉交(Send the Success view) ***********/
				houseSvc.updateHouse(houseVO.getHos_no(), houseVO.getLld_no(), houseVO.getHos_name()
						, houseVO.getHos_rent(), houseVO.getHos_expense(), houseVO.getHos_date()
						, houseVO.getHos_views(), houseVO.getHos_city(), houseVO.getHos_dist()
						, houseVO.getHos_address(), houseVO.getHos_lon(), houseVO.getHos_lat()
						, houseVO.getHos_type(), houseVO.getHos_info(), houseVO.getHos_age()
						, houseVO.getHos_floor(), houseVO.getHos_ele(), houseVO.getHos_parking()
						, houseVO.getHos_pet(), houseVO.getHos_cook(), houseVO.getHos_squares()
						, houseVO.getHos_gender(), houseVO.getHos_water(), houseVO.getHos_power()
						, houseVO.getHos_internet(), houseVO.getHos_apptime(), houseVO.getHos_order_date()
						, houseVO.getEmp_no(), houseVO.getHos_status(), houseVO.getHos_result()
						, houseVO.getHos_loc_pic(), houseVO.getHos_state(), houseVO.getHos_refuse());
				
				Map<String,String[]> map = new HashMap<String, String[]>();
				String[]  hos_state_value = {"0"};
				String[] hos_status_value = {Byte.toString(hos_status)};//hos_status=1
				map.put("hos_status",hos_status_value);//byte->轉string
				map.put("hos_state",hos_state_value);
				List<HouseVO> listAllHouse_Backend_list = houseSvc.getAll_Back(map);
				HttpSession session = req.getSession();
				session.setAttribute("map_house_back",map);//換頁 搜尋用
				
				
				req.setAttribute("listAllHouse_Backend_list",listAllHouse_Backend_list);
				req.setAttribute("listSize",listAllHouse_Backend_list.size());
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/house/listAllHouseEmp.jsp"); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("資料格式錯誤:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
		}
//		
//		
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}

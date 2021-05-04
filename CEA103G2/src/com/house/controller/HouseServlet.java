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
//	======�H�UKEY�O���O�n�ä@�U��������?=====
	private static final String SILVERVANE_KEY = "AIzaSyDJtdRDJrA8jHn3wA3iA_20Uh7rl8CCUbY";
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
//����action�A�Ӷi��O���ؽШD
		String action = req.getParameter("action");
		if ("listHouPho_ByHouseA".equals(action) || "listHouPhoEmp".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� ****************************************/
				Integer houseno = new Integer(req.getParameter("houseno"));
				/*************************** 2.�}�l�d�߸�� ****************************************/
				HouseService houseSvc = new HouseService();
				Set<HouPhoVO> set = houseSvc.getHouPhoByHouse(houseno);
				HouseVO houseVO =  houseSvc.getOneHouse(houseno);
				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ************/
				req.setAttribute("listHouPho_ByHouseNo", set); // ��Ʈw���X��set����,�s�Jrequest
				req.setAttribute("houseVO", houseVO);
				req.setAttribute("picSize", set.size());
				String url = null;
				if ("listHouPho_ByHouseA".equals(action))
					url = "/unprotected/house/listHouPho_ByHouseNo.jsp"; // ���\��� dept/listEmps_ByDeptno.jsp
				else if ("listHouPhoEmp".equals(action))
					url = "/back-end/houPho/listHouPhoEmp.jsp"; // ���\��� dept/listAllDept.jsp

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
/*******�ƦX�d��***********/	/**map name : map***/	
		if ("listHouse_AllOrQuery".equals(action)) { // �Ӧ�select_page.jsp���ƦX�d�߽ШD
			try {
				/***************************1.�N��J����ରMap**********************************/ 
				//�ĥ�Map<String,String[]> getParameterMap()����k 
				//�`�N:an immutable java.util.Map 
				//Map<String, String[]> map = req.getParameterMap();
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				/*===================
				������n��session? �]���A�������A�U����whichpage=null�A��ܲĤ@���d��
				�ҥH�Ĥ@���ɡA�A�|����s�����(VO)�A���session
				�ĤG���i�ӮɡA�A�����ӱqrequest���F��A�ӬO��session�h���X�¸��
				session���ηN�A²�满�N�O���ƫ��Xservlet
				===================*/
				// �H�U�� if �϶��u��Ĥ@������ɦ���
				if (req.getParameter("whichPage") == null ){//�~��
					Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
						if(req.getParameter("orderType")!=null) {
							//���ª�
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
							//�����i�J�ӭ���
							String[] hos_city = {req.getParameter("hos_city")};
							String[] hos_dist = {req.getParameter("hos_dist")};
							String[] hos_rent = {req.getParameter("hos_rent")};
							String[] hos_type = {req.getParameter("hos_type")};//0�G����1�G�W�߮M��2�G�����M��3�G����  4�G��h��a 5�G����6�G��L
							String[] hos_squares = {req.getParameter("hos_squares")};
							map1.put("hos_city",hos_city);
							map1.put("hos_dist", hos_dist);
							map1.put("hos_rent", hos_rent);
							map1.put("hos_type", hos_type);
							map1.put("hos_squares", hos_squares);
							session.setAttribute("map",map1);//���session
							map = map1;
						}
				}
				/***************************2.�}�l�ƦX�d��***************************************/
				HouseService houseSvc = new HouseService();
				List<HouseVO> list  = houseSvc.getAll(map);
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("listHouse_AllOrQuery", list); // ��Ʈw���X��list����,�s�Jrequest
				RequestDispatcher successView = req.getRequestDispatcher("/unprotected/house/listAllHouse.jsp"); // ���\���listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
		}
/*******�ƦX�d��**************/	
		
/*******��x����d��***********//**map name : map_house_back***/
			if ("listAllHouse_Backend".equals(action)||"listAllHouse_Backend_Emp".equals(action)) { 
				/*************************** 1.�����ШD�Ѽ� ***************************************/
			try {
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map_house_back");
				if(req.getParameter("whichPage")==null) {
					Map<String, String[]> map_house_back = new HashMap<String, String[]>(req.getParameterMap());
					if(map_house_back!=null) {
						map=map_house_back;
					}
				}
				session.setAttribute("map_house_back",map);//���session
				/*************************** 2.�}�l���X���� ***************************************/
				HouseService houseSvc = new HouseService();
				List<HouseVO> list = houseSvc.getAll_Back(map);
				/*************************** 3.���X����,�ǳ����(Send the Success view) ***********/
				String url =null;
				if("listAllHouse_Backend_Emp".equals(action)) {
					url = "/back-end/house/listAllHouseEmp.jsp";
				}else {
					url = "/back-end/house/listAllHouseBoss.jsp";
				}
				//����listAllHouse_Backend �ǰe�nshow���D�ު���
				req.setAttribute("listAllHouse_Backend_list", list);
				req.setAttribute("listSize", list.size());
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** ��L�i�઺���~�B�z ***********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
		}
	
/*******�ɦV�ЪF�s�W����***********/		
		if ("goToInsert".equals(action)) { 
			try {
				/*************************** 1.�����ШD�Ѽ� ***************************************/
				//�u�O�Q�n�ԥX�Ҧ����]�a��
				/*************************** 2.�}�l���X���]�a���� ***************************************/
				AddFurService addFurSvc = new AddFurService();
				List<AddFurVO> addFurVO_list = addFurSvc.getAll();
				/*************************** 3.�R������,�ǳ����(Send the Success view) ***********/
				String url = "/unprotected/house/addHouse.jsp";
				req.setAttribute("addFurVO_list", addFurVO_list);
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** ��L�i�઺���~�B�z ***********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
		}
		
/*******�ЪF�s�W����***********/
		if ("insert".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				//*��� �\��n�b�ﵽ
				//#��� �Ӫ�椧��n�b�D�ީέ��u���إi�H���
				//*2.�ЪF�s��(����n�q�|�����X��� �������ҡA�e�O�������)
				Integer lld_no = null;
				try {
					lld_no = new Integer(req.getParameter("lld_no").trim());//new Integer("2")�i�H�ন�Ʀr�A�Ƶ�:�p����|���Xnum���~
				} catch (NumberFormatException e) {
					lld_no = 0;
					errorMsgs.add("�ЪF�s���ж�Ʀr");
				}
				//#3.����W��(�ЪF ���u �D�� �����)
				String hos_name = req.getParameter("hos_name").trim();
				if (hos_name == null || hos_name.trim().length() == 0) {
					errorMsgs.add("����W�ٽФŪť�");
				}
//				#4.���󯲪�(�ЪF ���u �D�� �����)
				Integer hos_rent = null;
				try {
					hos_rent = new Integer(req.getParameter("hos_rent").trim());
				} catch (NumberFormatException e) {
					hos_rent = 0;
					errorMsgs.add("���󯲪��ж�Ʀr");
				}
//				*#5.�޲z�O(����n�s�@���D�� ���u�i�H��� ���v)
				Integer hos_expense = (int) (hos_rent * 0.1);
//				#8.����(�U�Ԧ����)
				String hos_city = req.getParameter("hos_city");
//				#9.�m��(�U�Ԧ����)
				String hos_dist = req.getParameter("hos_dist");
//				*#10.�a�}(����n���� ���n���O�H�ö�)(���u�i�H���)
				String hos_address = req.getParameter("hos_address");
				String hos_addressReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,30}$";
				if (hos_address == null || hos_address.trim().length() == 0) {
					errorMsgs.add("�a�}: �ФŪť�");
				} else if (!hos_address.trim().matches(hos_addressReg)) { // �H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�a�}�u��O����r�A�B���ץ��ݦb1��30����");
				}
//				�g�n��(�a�}���\�A�~�qGeocoding�h���o���)
/**���ӥt�~�g�@��controller�h��g�n�סA���᧹��(��������)****/
				String address= hos_city+hos_dist+hos_address;
				String URL = "https://maps.googleapis.com/maps/api/geocode/json"
						+ "?address="+address
						+ "&key=" + SILVERVANE_KEY;
//				#11,12.�g�n
			
				Double hos_lon = null;
				Double hos_lat = null;						
				try {
					String jsonStr = Jsoup.connect(URL).ignoreContentType(true).execute().body().toString();				
					JSONObject jsonObj = new JSONObject(jsonStr);
					JSONArray results = jsonObj.getJSONArray("results");
					JSONObject southwest = results.getJSONObject(0).getJSONObject("geometry").getJSONObject("viewport").getJSONObject("southwest");
//					�g��
					hos_lon = southwest.getDouble("lng");
//					�n��
					hos_lat = southwest.getDouble("lat");
			
				}catch(Exception e) {
					System.out.println("GEOcoding�s�u����!!");
				}
//				#13.�Ы�(�ΤU�Ԧ����A��������)
				Byte hos_type =Byte.valueOf(req.getParameter("hos_type").trim());
//				#14.����(�ЪF��g�X��   ���u���n�W�[������)
				String hos_info = req.getParameter("hos_info").trim();
				if (hos_info == null || hos_info.trim().length() == 0) {
					errorMsgs.add("���нФŪť�");
				}
//				#15.����(�ЪF ���u �D�ޥi�H���)
				Integer hos_age = null;
				try {
					hos_age = new Integer(req.getParameter("hos_age").trim());
				} catch (NumberFormatException e) {
					hos_age = 0;
					errorMsgs.add("���ֽж�Ʀr");
				}
//				#16.�Ӽh(�ЪF ���u �D�ޥi�H���)
				Integer hos_floor = null;
				try {
					hos_floor = new Integer(req.getParameter("hos_floor").trim());
				} catch (NumberFormatException e) {
					hos_floor = 0;
					errorMsgs.add("�Ӽh�ж�Ʀr");
				}
//				#17�B18�B19�B20���ѪA�ȡA�q��B������B�i�i�d������	(�ЪF ���u �D�ޥi�H���)			
				Byte hos_ele = 0;
				Byte hos_parking = 0;
				Byte hos_pet = 0;
				Byte hos_cook = 0;
				String[] hos_check = req.getParameterValues("hos_check");
				if (hos_check != null) {//�����S��checkbox�A�|�Onull
					for (int i = 0; i < hos_check.length; i++) {
						switch (hos_check[i]) {//java X�����᭱�i�H����r��F
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
//				#21�W��(�ЪF ���u �D�ޥi�H���)
				Double hos_squares = null;
				try {
					hos_squares = new Double(req.getParameter("hos_squares").trim());
				} catch (NumberFormatException e) {
					hos_squares = 0.0;
					errorMsgs.add("�W�ƽж�Ʀr.");
				}
//				#22.�ʧO���� Byte(�U�Ԧ����A��������)
				Byte hos_gender =Byte.valueOf(req.getParameter("hos_gender").trim());
//				#23.���ODouble
				Double hos_water = null;
				try {
					hos_water = new Double(req.getParameter("hos_water").trim());
				} catch (NumberFormatException e) {
					hos_water = 0.0;
					errorMsgs.add("���O�ж�Ʀr.");
				}
//				#24.�q�ODouble
				Double hos_power = null;
				try {
					hos_power = new Double(req.getParameter("hos_power").trim());
				} catch (NumberFormatException e) {
					hos_power = 0.0;
					errorMsgs.add("�q�O�ж�Ʀr.");
				}
//				#25.�����OInt
				Integer hos_internet = null;
				try {
					hos_internet = new Integer(req.getParameter("hos_internet").trim());
				} catch (NumberFormatException e) {
					hos_internet = 0;
					errorMsgs.add("�����O�ж�Ʀr");
				}
//				26.�ӽЮɶ�Timestamp(��U�ɶ�)
				java.sql.Timestamp hos_apptime = new java.sql.Timestamp(System.currentTimeMillis());
//				27.�w���ɶ�Timestamp(����ɶ�)
/**��ɭԩw�q�@�Ӫ�l��**/
				java.sql.Timestamp hos_order_date = null;
				try {
					hos_order_date = java.sql.Timestamp.valueOf(req.getParameter("hos_order_date"));
				} catch (IllegalArgumentException e) {
					hos_order_date = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
//				31.�Ҧ��v���Ӥ�byte[]
//				===================�H�U�Ҧ��v��Ū�ɮ�================================
				InputStream in = req.getPart("hos_loc_pic").getInputStream();
				byte[] hos_picBuf = new byte[in.available()];
//				in.read(hos_picBuf) �Obuf�o�}�C��inputstream���ƪ��
//				�ҤU�����槹�Abuf�w�g�t����ƤF
				in.read(hos_picBuf);
//				===================�H�W�Ҧ��v��Ū�ɮ�================================	
				
//==============(�H�U�ȰѦ�)����i�H�Ϊ��榡�ഫ===========================================================				
				//java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//�o�Oyyyy-MM-dd HH:mm:ss�O�AŪ�i�Ӫ��ɮ׮榡
				//�榡
				
				//�o�Odate��String
				//String formatDate = df.format(new java.util.Date());
				//�o�OString��date
				//java.sql.Date date = df.parse("0000-00-00 00:00:00");
				//��k
				//java.sql.Date date = java.sql.Date.valueOf();
				/***************�H�U�O�S���n���ЪF�s�W�����****************************************/
//				#6.�Z�n���(����ӽ� �������u�W�[�ɭn��J���)
/**��ɭԩw�q�@�Ӫ�l��**/
				java.sql.Timestamp hos_date = null;
				hos_date = new java.sql.Timestamp(System.currentTimeMillis());
//				*7.�s������ (�����@)
				Integer hos_views = 0;
//				#28.�t�d���u(�D�ާ��)(0��ܩ|������)
				Integer emp_no = 0;
//				#29.�ӽжi��(�q���B�z0���g�ק�N1�e�X�w���\2�ӽХ���3)
				Byte hos_status = 0;
//				30.�f�ֵ��G(�o�����A�L��)
				Byte hos_result = 0;
//				#32.�Z�n���A(0�ӽЦ��\�����Z�n 1�W�[�� 2�U�[��)
				Byte hos_state = 0;
//				33.���q�L��]
				String hos_refuse ="����";
				/***************�H�W�O�S���n���ЪF�s�W�����****************************************/			
//==============�H�W��欰table(House)����=================
				
				
//==============�H�U��欰table(AddFur)����================
/**���]�a��(����)**/
//				List<Integer> add_fnt_no_list = new ArrayList<Integer>();
//				String[] addfur_check = req.getParameterValues("addfur_check");
//				if (addfur_check != null) {//�����S��checkbox�A�|�Onull
//					for (int i = 0; i < addfur_check.length; i++) {
//						add_fnt_no_list.add(new Integer(addfur_check[i]));
//					}
//				}		
//==============�H�W��欰table(AddFur)����================

//==============�ϥΪ̶�g�ɡA�p�G���@�����ҥ��ѡA�i�H���Υ������g
//==============33���ݩʥu�˦���g�������A�ثe�@24��
//==============���󳡤�
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
//				======�H�U�ǰe�Ϥ�
				houseVO.setHos_loc_pic(hos_picBuf);
//				======�H�W�ǰe�Ϥ�
				if (!errorMsgs.isEmpty()) {
					AddFurService addFurSvc = new AddFurService();
					List<AddFurVO> addFurVO_list = addFurSvc.getAll();
					req.setAttribute("addFurVO_list", addFurVO_list);
					req.setAttribute("houseVO", houseVO); // �t����J�榡���~��houseVO����,�]�s�Jreq
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/house/addHouse.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.�}�l�s�W��� ***************************************/
				HouseService houseSvc = new HouseService();
				houseVO = houseSvc.addHouse(lld_no, hos_name, hos_rent, hos_expense, hos_date, hos_views, hos_city,
						hos_dist, hos_address, hos_lon, hos_lat, hos_type, hos_info, hos_age, hos_floor, hos_ele,
						hos_parking, hos_pet, hos_cook, hos_squares, hos_gender, hos_water, hos_power, hos_internet,
						hos_apptime, hos_order_date, emp_no, hos_status, hos_result, hos_picBuf, hos_state,
						hos_refuse);
/**�s�W����P�ɷs�W���]�a��(��������)**/
				/*************************** 3.�s�W����,�ǳ����(Send the Success view) ***********/
				String url = "/index.jsp";
/**�o�Ȯɦ^�Ǩ쭺���A��ɭ����ӾɦV�s�W���\�����A�ø߰ݬO�_��s�W�Ϊ̤@�q�ɶ��^����**/				
				req.setAttribute("upload", "success");
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/error.jsp");
				failureView.forward(req, res);
			}
		}
/*******�������u***********/
		if ("change_Emp".equals(action)) { 
			HouseVO houseVO = null;//�ª���
			Integer houseno = null;//�Q�n�ק諸����s��
			Integer emp_no = null;// ���������u�A�Y�|������(0) �������u(~0)
			String[] houseno_array = null;
			String[] empno_array = null;
			List<Integer> houseno_list = new LinkedList<Integer>();
			try {
				/*************************** 1.�����ШD�Ѽ� ***************************************/
				//req.getParameter("whichPage") forword�|�O�dparameter�ҥH����get�Aset ���D�A�g�L�O����
				String URL = req.getParameter("requestURL");///CEA103G2/house/house.do
				/*************************** 2.�}�l����� ***************************************/
				HouseService houseSvc = new HouseService();
				if(req.getParameterValues("houseno")!=null) {//���n��s
					houseno_array = req.getParameterValues("houseno");//���|���諸����
					empno_array = req.getParameterValues("emp_no");
					int count = 0;
					for(String i : houseno_array) {
						emp_no = new Integer(empno_array[count++]);
						houseno = new Integer(i);
						houseVO = houseSvc.getOneHouse(houseno);//�����¸���o
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
				/*************************** 3.��s����,�ǳ���� ***********/
				req.setAttribute("listSize", listAllHouse_Backend_list.size());
				req.setAttribute("houseVO", houseVO);
				req.setAttribute("houseno_list", houseno_list);
				req.setAttribute("listAllHouse_Backend_list", listAllHouse_Backend_list);
				
				RequestDispatcher successView = req.getRequestDispatcher(URL);
				successView.forward(req, res);
				/*************************** ��L�i�઺���~�B�z ***********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/house/indexBack.jsp");
				failureView.forward(req, res);
			}
		}
/*******��磌�󪬺A:�h���T�{�e�X***********/
		if ("changeHouseStatus".equals(action)) { 
			HouseVO houseVO = null;//�ª���
			Integer houseno = null;//�Q�n�ק諸����s��
			String[] houseno_array = null;
			List<Integer> houseno_list = new LinkedList<Integer>();//�ܦ��
			Byte status = null;
			String[]  hos_status = new String[1];
			
			if(req.getParameter("delete")!=null) {
				status = new Byte(req.getParameter("delete"));//update
				hos_status[0]=req.getParameter("delete");//������
				System.out.println("S");
			}else {
				status = new Byte("2");//update
				hos_status[0]= "2";//������
			}
//			try {
				/*************************** 1.�����ШD�Ѽ� ***************************************/
				//req.getParameter("whichPage") forword�|�O�dparameter�ҥH����get�Aset ���D�A�g�L�O����
				String URL = req.getParameter("requestURL");///CEA103G2/house/house.do
				/*************************** 2.�}�l����� ***************************************/
				HouseService houseSvc = new HouseService();
				if(req.getParameterValues("houseno")!=null) {//���n��s
					houseno_array = req.getParameterValues("houseno");//���|���諸����
					for(String i : houseno_array) {
						houseno = new Integer(i);
						houseVO = houseSvc.getOneHouse(houseno);//�����¸���o
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
						houseno_list.add(houseno);//�ܦ��
					}
				}
				Map<String,String[]> map = new HashMap<String, String[]>();
				
				map.put("hos_status",hos_status);
				List<HouseVO> listAllHouse_Backend_list = houseSvc.getAll_Back(map);
				HttpSession session = req.getSession();
				session.setAttribute("map_house_back",map);//���� �j�M��
				
				
				
				
				/*************************** 3.��s����,�ǳ���� ***********/
				req.setAttribute("listSize", listAllHouse_Backend_list.size());
				req.setAttribute("houseVO", houseVO);//�ܦ�ΡA����ʪ���
				req.setAttribute("houseno_list", houseno_list);//�ܦ�ΡA����ʪ���
				req.setAttribute("listAllHouse_Backend_list", listAllHouse_Backend_list);
				System.out.println(URL);///back-end/house/listAllHouseBoss.jsp
				RequestDispatcher successView = req.getRequestDispatcher(URL);
				successView.forward(req, res);
				/*************************** ��L�i�઺���~�B�z ***********************************/
//			} catch (Exception e) {
//				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/house/indexBack.jsp");
//				failureView.forward(req, res);
//			}
		}
/*******�w�磌����***********/
		if ("getOneHouseForUpdate".equals(action)||"updateHouseForEmp".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			HouseVO houseVO = null;//�ª���
			Integer houseno = null;//�Q�n�ק諸����s��
			try {
				/*************************** 1.�����ШD�Ѽ� ***************************************/
				//req.getParameter("whichPage") forword�|�O�dparameter�ҥH����get�Aset ���D�A�g�L�O����
				String URL = req.getParameter("requestURL");//�^�a�� �e�h�����ƭ����A�O�o�]�Ѽƭn�^�a��
				/*************************** 2.�}�l����� ***************************************/
				HouseService houseSvc = new HouseService();
				houseno = new Integer(req.getParameter("houseno"));//���|���諸����
				houseVO = houseSvc.getOneHouse(houseno);//�����¸���o
				if("getOneHouseForUpdate".equals(action)) {//�hupdateHouseForEmp����
					req.setAttribute("houseVO", houseVO);
					RequestDispatcher successView = req.getRequestDispatcher("/back-end/house/updateHouseForEmp.jsp");
					successView.forward(req, res);
					return;
				}//�H�U�N�O�n��s��
				/****************************����************************************************/
				//*2.�ЪF�s��(����n�q�|�����X��� �������ҡA�e�O�������)
				//#3.����W��(�ЪF ���u �D�� �����)
				String hos_name = req.getParameter("hos_name").trim();
				if (hos_name == null || hos_name.trim().length() == 0) {
					errorMsgs.add("����W�ٽФŪť�");
				}
				houseVO.setHos_name(hos_name);
//				#4.���󯲪�(�ЪF ���u �D�� �����)
				Integer hos_rent = null;
				try {
					hos_rent = new Integer(req.getParameter("hos_rent").trim());
				} catch (NumberFormatException e) {
					hos_rent = 0;
					errorMsgs.add("���󯲪��ж�Ʀr");
				}
				houseVO.setHos_rent(hos_rent);
//				*#5.�޲z�O(����n�s�@���D�� ���u�i�H��� ���v)
				Integer hos_expense = (int) (hos_rent * 0.1);
				houseVO.setHos_expense(hos_expense);
//				#8.����(�U�Ԧ����)
				String hos_city = req.getParameter("hos_city");
				houseVO.setHos_city(hos_city);
//				#9.�m��(�U�Ԧ����)
				String hos_dist = req.getParameter("hos_dist");
				houseVO.setHos_dist(hos_dist);
//				*#10.�a�}(����n���� ���n���O�H�ö�)(���u�i�H���)
				String hos_address = req.getParameter("hos_address");
				String hos_addressReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,30}$";
				if (hos_address == null || hos_address.trim().length() == 0) {
					errorMsgs.add("�a�}: �ФŪť�");
				} else if (!hos_address.trim().matches(hos_addressReg)) { // �H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�a�}�u��O����r�A�B���ץ��ݦb1��30����");
				}
				houseVO.setHos_address(hos_address);
//				�g�n��(�a�}���\�A�~�qGeocoding�h���o���)
				String address= hos_city+hos_dist+hos_address;

				String URL_update = "https://maps.googleapis.com/maps/api/geocode/json"
						+ "?address="+address
						+ "&key=" + SILVERVANE_KEY;
//				#11,12.�g�n
				Double hos_lon = null;
				Double hos_lat = null;						
				try {
					String jsonStr = Jsoup.connect(URL_update).ignoreContentType(true).execute().body().toString();				
					JSONObject jsonObj = new JSONObject(jsonStr);
					JSONArray results = jsonObj.getJSONArray("results");
					JSONObject southwest = results.getJSONObject(0).getJSONObject("geometry").getJSONObject("viewport").getJSONObject("southwest");
//					�g��
					hos_lon = southwest.getDouble("lng");
//					�n��
					hos_lat = southwest.getDouble("lat");
				}catch(Exception e) {
					System.out.println("GEOcoding�s�u����!!");
				}
				houseVO.setHos_lon(hos_lon);
				houseVO.setHos_lat(hos_lat);
//				#13.�Ы�(�ΤU�Ԧ����A��������)
				Byte hos_type =Byte.valueOf(req.getParameter("hos_type").trim());
				houseVO.setHos_type(hos_type);
//				#14.����(�ЪF��g�X��   ���u���n�W�[������)
				String hos_info = req.getParameter("hos_info").trim();
				if (hos_info == null || hos_info.trim().length() == 0) {
					errorMsgs.add("���нФŪť�");
				}
				houseVO.setHos_info(hos_info);
//				#15.����(�ЪF ���u �D�ޥi�H���)
				Integer hos_age = null;
				try {
					hos_age = new Integer(req.getParameter("hos_age").trim());
				} catch (NumberFormatException e) {
					hos_age = 0;
					errorMsgs.add("���ֽж�Ʀr");
				}
				houseVO.setHos_age(hos_age);
//				#16.�Ӽh(�ЪF ���u �D�ޥi�H���)
				Integer hos_floor = null;
				try {
					hos_floor = new Integer(req.getParameter("hos_floor").trim());
				} catch (NumberFormatException e) {
					hos_floor = 0;
					errorMsgs.add("�Ӽh�ж�Ʀr");
				}
				houseVO.setHos_floor(hos_floor);
//				#17�B18�B19�B20���ѪA�ȡA�q��B������B�i�i�d������	(�ЪF ���u �D�ޥi�H���)			
				Byte hos_ele = 0;
				Byte hos_parking = 0;
				Byte hos_pet = 0;
				Byte hos_cook = 0;
				String[] hos_check = req.getParameterValues("hos_check");
				if (hos_check != null) {//�����S��checkbox�A�|�Onull
					for (int i = 0; i < hos_check.length; i++) {
						switch (hos_check[i]) {//java X�����᭱�i�H����r��F
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
//				#21�W��(�ЪF ���u �D�ޥi�H���)
				Double hos_squares = null;
				try {
					hos_squares = new Double(req.getParameter("hos_squares").trim());
				} catch (NumberFormatException e) {
					hos_squares = 0.0;
					errorMsgs.add("�W�ƽж�Ʀr.");
				}
				houseVO.setHos_squares(hos_squares);
//				#22.�ʧO���� Byte(�U�Ԧ����A��������)
//				new Integer("2")���૬���Ʀr�A��Byte�èS��
//				!!Byte�S�����Ѧr��۰��૬�A�ݭnByte.valueOf()���নByte
				houseVO.setHos_gender(Byte.valueOf(req.getParameter("hos_gender").trim()));
//				#23.���ODouble
				Double hos_water = null;
				try {
					hos_water = new Double(req.getParameter("hos_water").trim());
				} catch (NumberFormatException e) {
					hos_water = 0.0;
					errorMsgs.add("���O�ж�Ʀr.");
				}
				houseVO.setHos_water(hos_water);
//				#24.�q�ODouble
				Double hos_power = null;
				try {
					hos_power = new Double(req.getParameter("hos_power").trim());
				} catch (NumberFormatException e) {
					hos_power = 0.0;
					errorMsgs.add("�q�O�ж�Ʀr.");
				}
				houseVO.setHos_power(hos_power);
//				#25.�����OInt
				Integer hos_internet = null;
				try {
					hos_internet = new Integer(req.getParameter("hos_internet").trim());
				} catch (NumberFormatException e) {
					hos_internet = 0;
					errorMsgs.add("�����O�ж�Ʀr");
				}
				houseVO.setHos_internet(hos_internet);
//				26.�ӽЮɶ�Timestamp(���ݭn���ɶ�)
//				27.�w���ɶ�Timestamp(���ݭn���ɶ�)
//				31.�Ҧ��v���Ӥ�byte[]
//				===================�H�U�Ҧ��v��Ū�ɮ�================================
				InputStream in = req.getPart("hos_loc_pic").getInputStream();
				byte[] hos_picBuf = new byte[in.available()];
//						in.read(hos_picBuf) �Obuf�o�}�C��inputstream���ƪ��
//						�ҤU�����槹�Abuf�w�g�t����ƤF
				in.read(hos_picBuf);
				houseVO.setHos_loc_pic(hos_picBuf);
//				===================�H�W�Ҧ��v��Ū�ɮ�================================	
				
//==============(�H�U�ȰѦ�)����i�H�Ϊ��榡�ഫ===========================================================				
//==============�H�U�O�S���n���ЪF�s�W�����==================================
//				#6.�Z�n���(����ӽ� �������u�W�[�ɭn��J���)

//				#28.�t�d���u(�D�ާ��)
//				#29.�ӽжi��
				Byte hos_status = new Byte("1");//�ק�L�F �󥿬�1
				houseVO.setHos_status(hos_status);
//				30.�f�ֵ��G(�o�����)
//				#32.�Z�n���A(1.���Z�n 2.�W�[�� 3.�U�[)
//				33.���q�L��]
//==============�H�W�O�S���n���ЪF�s�W�����==================================
				
				
//==============�H�W��欰table(House)����====================================
				
//==============�H�U��欰table(AddFur)����===================================
//===================================�H�W��欰table(AddFur)����===================================

				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("houseVO", houseVO); // �t����J�榡���~��houseVO����,�]�s�Jreq
//					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/house/addHouse.jsp");
//					failureView.forward(req, res);
//					return;
//				}
				/*************************** 3.���ҧ���,�ǳ����(Send the Success view) ***********/
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
				map.put("hos_status",hos_status_value);//byte->��string
				map.put("hos_state",hos_state_value);
				List<HouseVO> listAllHouse_Backend_list = houseSvc.getAll_Back(map);
				HttpSession session = req.getSession();
				session.setAttribute("map_house_back",map);//���� �j�M��
				
				
				req.setAttribute("listAllHouse_Backend_list",listAllHouse_Backend_list);
				req.setAttribute("listSize",listAllHouse_Backend_list.size());
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/house/listAllHouseEmp.jsp"); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("��Ʈ榡���~:" + e.getMessage());
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

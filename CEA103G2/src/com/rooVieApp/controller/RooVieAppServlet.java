package com.rooVieApp.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.rooVieApp.model.RooVieAppService;
import com.rooVieApp.websocket.jedis.HandlePickTime;
import com.rooVieApp.websocket.model.ControlTimeVO;

public class RooVieAppServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");
		req.setCharacterEncoding("UTF-8");
		//儲存所有物件初始值
		if("saveInitControlTime".equals(action)) {
			System.out.println("S");
			String type = "control";
			String identity = "0";
			String sender = "";
			String freeTimeToSee = null;
			String gotowork = null;
			String gooffwork = null;
			Set<String> freedate = new TreeSet<String>();
			//現在時間幾小時後，不可預約
			if(req.getParameter("freeTimeToSee")!=null) {
				freeTimeToSee = req.getParameter("freeTimeToSee");
			}else {
				freeTimeToSee = "2";//系統初始值
			}
			//上班時間
			if(req.getParameter("gotowork")!=null) {
				gotowork = req.getParameter("gotowork");
			}else {
				gotowork = "6";//系統初始值
			}
			//下班時間
			if(req.getParameter("gooffwork")!=null) {
				gooffwork = req.getParameter("gooffwork");
			}else {
				gooffwork = "23";//系統初始值
			}
			//不可預約的時間
			if(req.getParameterValues("freedate") != null) {
				String temps[] = req.getParameterValues("freedate");
				for(String temp : temps) {
					freedate.add(temp);
				}
			}else {
				freedate.add("");
			}
			ControlTimeVO ctVO = new ControlTimeVO(type,sender,identity,freeTimeToSee,gotowork,gooffwork,freedate);
			Gson gson = new Gson();
			String message_controltime = gson.toJson(ctVO);
			HandlePickTime.saveControlTime(identity, message_controltime);
			
		}
		//存儲個別物件時間
		if("saveControlTime".equals(action)) {
			String type = "control";
			String identity = req.getParameter("identity");
			String sender = "";
			String freeTimeToSee = null;
			String gotowork = null;
			String gooffwork = null;
			Set<String> freedate = new TreeSet<String>();
			
			String control_JSON = HandlePickTime.getControlTime("0");
			ControlTimeVO initctvo = new Gson().fromJson(control_JSON, ControlTimeVO.class);
			
			//現在時間幾小時後，不可預約 
			if(req.getParameter("freeTimeToSee")!=null) {
				freeTimeToSee = req.getParameter("freeTimeToSee");
			}else {
				freeTimeToSee = initctvo.getFreeTimeToSee();
			}
			//上班時間
			if(req.getParameter("gotowork")!=null) {
				gotowork = req.getParameter("gotowork");
			}else {
				gotowork = initctvo.getGotowork();
			}
			//下班時間
			if(req.getParameter("gooffwork")!=null) {
				gooffwork = req.getParameter("gooffwork");
			}else {
				gooffwork = initctvo.getGooffwork();
			}
			//不可預約的時間
			if(req.getParameterValues("freedate") != null) {
				String temps[] = req.getParameterValues("freedate");
				for(String temp : temps) {
					freedate.add(temp);
				}
			}else {
				freedate.add("");
			}
			ControlTimeVO ctVO = new ControlTimeVO(type,sender,identity,freeTimeToSee,gotowork,gooffwork,freedate);
			String message_controltime = new Gson().toJson(ctVO);
			HandlePickTime.saveControlTime(identity, message_controltime);
			
		}
		//SHOW個別物件時間，若物件編號查詢不到就 用物件0號
		if("listControlTime".equals(action)) {
			String identity = req.getParameter("identity");
			String control_JSON = HandlePickTime.getControlTime(identity);
			if(control_JSON==null) {
				control_JSON= HandlePickTime.getControlTime("0");//之後要改成0
			}
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(control_JSON);
			
		}
		//印出所有CASE初始值
		if("listInitControlTime".equals(action)) {
			String control_JSON = HandlePickTime.getControlTime("0");
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(control_JSON);
		}
//事發現場///////////////////////////////////////////
		if("addPickTime".equals(action)){
			System.out.println("進入Servlet");
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			
			
			java.sql.Timestamp rva_order_time =new Timestamp(System.currentTimeMillis());
			rva_order_time = Timestamp.valueOf(req.getParameter("rva_order_time"));
//			rva_order_time =java.sql.Timestamp.valueOf(req.getParameter("rva_order_time"));
			//成立訂單為狀態為0
			Byte rva_status =new Byte("0");
			RooVieAppService rvaSvc = new RooVieAppService();
			rvaSvc.addpicktime(mem_no, hos_no, rva_order_time, rva_status);
			return;
		}
//事發現場///////////////////////////////////////////		
		if("cancelPickTime".equals(action)){
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			java.sql.Timestamp rva_order_time = null;
			rva_order_time = java.sql.Timestamp.valueOf(req.getParameter("rva_order_time"));
			RooVieAppService rvaSvc = new RooVieAppService();
			rvaSvc.cancelpicktime(mem_no, hos_no, rva_order_time);
			return;
		}
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}

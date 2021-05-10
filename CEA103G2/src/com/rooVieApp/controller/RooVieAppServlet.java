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
		//�x�s�Ҧ������l��
		if("saveInitControlTime".equals(action)) {
			System.out.println("S");
			String type = "control";
			String identity = "0";
			String sender = "";
			String freeTimeToSee = null;
			String gotowork = null;
			String gooffwork = null;
			Set<String> freedate = new TreeSet<String>();
			//�{�b�ɶ��X�p�ɫ�A���i�w��
			if(req.getParameter("freeTimeToSee")!=null) {
				freeTimeToSee = req.getParameter("freeTimeToSee");
			}else {
				freeTimeToSee = "2";//�t�Ϊ�l��
			}
			//�W�Z�ɶ�
			if(req.getParameter("gotowork")!=null) {
				gotowork = req.getParameter("gotowork");
			}else {
				gotowork = "6";//�t�Ϊ�l��
			}
			//�U�Z�ɶ�
			if(req.getParameter("gooffwork")!=null) {
				gooffwork = req.getParameter("gooffwork");
			}else {
				gooffwork = "23";//�t�Ϊ�l��
			}
			//���i�w�����ɶ�
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
		//�s�x�ӧO����ɶ�
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
			
			//�{�b�ɶ��X�p�ɫ�A���i�w�� 
			if(req.getParameter("freeTimeToSee")!=null) {
				freeTimeToSee = req.getParameter("freeTimeToSee");
			}else {
				freeTimeToSee = initctvo.getFreeTimeToSee();
			}
			//�W�Z�ɶ�
			if(req.getParameter("gotowork")!=null) {
				gotowork = req.getParameter("gotowork");
			}else {
				gotowork = initctvo.getGotowork();
			}
			//�U�Z�ɶ�
			if(req.getParameter("gooffwork")!=null) {
				gooffwork = req.getParameter("gooffwork");
			}else {
				gooffwork = initctvo.getGooffwork();
			}
			//���i�w�����ɶ�
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
		//SHOW�ӧO����ɶ��A�Y����s���d�ߤ���N �Ϊ���0��
		if("listControlTime".equals(action)) {
			String identity = req.getParameter("identity");
			String control_JSON = HandlePickTime.getControlTime(identity);
			if(control_JSON==null) {
				control_JSON= HandlePickTime.getControlTime("0");//����n�令0
			}
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(control_JSON);
			
		}
		//�L�X�Ҧ�CASE��l��
		if("listInitControlTime".equals(action)) {
			String control_JSON = HandlePickTime.getControlTime("0");
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(control_JSON);
		}
//�Ƶo�{��///////////////////////////////////////////
		if("addPickTime".equals(action)){
			System.out.println("�i�JServlet");
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			
			
			java.sql.Timestamp rva_order_time =new Timestamp(System.currentTimeMillis());
			rva_order_time = Timestamp.valueOf(req.getParameter("rva_order_time"));
//			rva_order_time =java.sql.Timestamp.valueOf(req.getParameter("rva_order_time"));
			//���߭q�欰���A��0
			Byte rva_status =new Byte("0");
			RooVieAppService rvaSvc = new RooVieAppService();
			rvaSvc.addpicktime(mem_no, hos_no, rva_order_time, rva_status);
			return;
		}
//�Ƶo�{��///////////////////////////////////////////		
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

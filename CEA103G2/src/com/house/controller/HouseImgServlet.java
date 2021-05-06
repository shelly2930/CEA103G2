package com.house.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.houPho.model.HouPhoService;
import com.houPho.model.HouPhoVO;
import com.house.model.HouseService;
import com.house.model.HouseVO;
//我是負責管理照片的servlet
/*
 1. getOneImg 取出一張物件照片而已
 */
public class HouseImgServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");
		if ("getOneImg".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer houseno = null;
				if(req.getParameter("houseno")!=null) {
					houseno = new Integer(req.getParameter("houseno"));
				}
				boolean hasAssignment  = false;
				Integer hos_pic_no = 0;//沒拿到參數count 表示你只要一張
				if(req.getParameter("hos_pic_no") != null) {
					hos_pic_no = new Integer(req.getParameter("hos_pic_no"));
					hasAssignment = true;
				}
				/*************************** 2.開始取出物件 ***************************************/
				OutputStream output = res.getOutputStream();
				res.setContentType("image/*");
				HouseService houseSvc = new HouseService();
				Set<HouPhoVO> houseImgSet = houseSvc.getHouPhoByHouse(houseno);
				byte[] img = null;
				for(HouPhoVO houphoVO : houseImgSet) {
					if(hasAssignment==false) {
						img = houphoVO.getHos_pic();
						break;
					}
					if(hos_pic_no.equals(houphoVO.getHos_pic_no())) {//有指定照片
						img = houphoVO.getHos_pic();
						break;
					}
				}
				if(img.length == 0 || img == null) {
					File file = new File(req.getServletContext().getRealPath("/")+"errorImg/error.png");
					InputStream is = new FileInputStream(file);
					System.out.println(file);
					byte[] b = new byte[is.available()];
					is.read(b);
					output.write(b);
				}else {
					output.write(img);
				}
				/*************************** 3.取出完成,準備轉交(Send the Success view) ***********/
				
				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				OutputStream output = res.getOutputStream();
				File file = new File(req.getServletContext().getRealPath("/")+"errorImg/error.png");
				InputStream is = new FileInputStream(file);
				byte[] b = new byte[is.available()];
				is.read(b);
				output.write(b);
			}
		}
		if ("getOneContractImg".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer houseno = null;
				if(req.getParameter("houseno")!=null) {
					houseno = new Integer(req.getParameter("houseno"));
				}
				/*************************** 2.開始取出物件 ***************************************/
				OutputStream output = res.getOutputStream();
				res.setContentType("image/*");
				HouseService houseSvc = new HouseService();
				HouseVO houseVO = houseSvc.getOneHouse(houseno);
				byte[] img = houseVO.getHos_loc_pic();
				if(img.length == 0 || img == null) {
					File file = new File(req.getServletContext().getRealPath("/")+"errorImg/error.png");
					System.out.println(file);
					InputStream is = new FileInputStream(file);
					byte[] b = new byte[is.available()];
					is.read(b);
					output.write(b);
				}
				/*************************** 3.取出完成,準備轉交(Send the Success view) ***********/
				output.write(img);
				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				OutputStream output = res.getOutputStream();
				File file = new File(req.getServletContext().getRealPath("/")+"errorImg/error.png");
				InputStream is = new FileInputStream(file);
				byte[] b = new byte[is.available()];
				is.read(b);
				output.write(b);
			}
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

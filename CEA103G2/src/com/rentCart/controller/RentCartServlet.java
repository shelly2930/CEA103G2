package com.rentCart.controller;
import java.util.*;
import java.io.*;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Timestamp;
import com.renCon.model.RenConService;
import com.rentCart.model.RentCartItem;

import sun.print.PSPrinterJob.PluginPrinter;


public class RentCartServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();

		@SuppressWarnings("unchecked")
		List<RentCartItem> rentCartList = (Vector<RentCartItem>) session.getAttribute("rentCartList");
		String action = req.getParameter("action");
		
//結帳前動作  action不等於checkout時 可再新增或刪除品項 
		if (!action.equals("CHECKOUT")) {
			// 刪除購物車中的家具
			if (action.equals("DELETE")) {
				String del = req.getParameter("del");
				int d = Integer.parseInt(del);
				rentCartList.remove(d);
			}
			// 新增家具至購物車中
			else if (action.equals("ADD")) {
				// 取得後來新增的家具
				RentCartItem aRentCartItem = getRentFurItem(req);
	
				if (rentCartList == null) {
					rentCartList = new Vector<RentCartItem>();
					rentCartList.add(aRentCartItem);
				} else {
					if (rentCartList.contains(aRentCartItem)) {
						RentCartItem innerRentCartItem = rentCartList.get(rentCartList.indexOf(aRentCartItem));
					//(重複租用同家具時)取得購物車內的家具數量+新增數量 再一起重新設定此家具品項的數量
						innerRentCartItem.setQuantity(innerRentCartItem.getQuantity() + aRentCartItem.getQuantity());
					} else {
						//購物車內無此家具時 直接add
						rentCartList.add(aRentCartItem);
					}
				}
				PrintWriter out = res.getWriter();
				String countParse=Integer.toString(rentCartList.size());
	            out.print(countParse);
			}
			if("changeQuantity".equals(action)){
				Integer changeFnt_it_no = new Integer(req.getParameter("fnt_it_no"));
				Integer newQuantity = new Integer(req.getParameter("newQuantity"));
				for(int i = 0; i < rentCartList.size(); i++) {
					RentCartItem orinRentCartItem = rentCartList.get(i);
					if(orinRentCartItem.getFnt_it_no().equals(changeFnt_it_no)) {
						orinRentCartItem.setQuantity(newQuantity);
					}
				}
			}
			if("DeleteAll".equals(action)){
				((Vector<RentCartItem>) rentCartList).removeAllElements();
			}
			session.setAttribute("rentCartList", rentCartList);
//			String url = "/front-end/furIte/rentCart.jsp";
//			String url = requestURL;
//			RequestDispatcher rd = req.getRequestDispatcher(url);
//			rd.forward(req, res);
		}

		// 結帳，計算購物車家具品項租金及項目總數
		else if (action.equals("CHECKOUT")) {
			Integer rent_mem_no = new Integer(req.getParameter("rent_mem_no"));
			Byte canRent=null;
			RenConService renConSvc=new RenConService();
			java.sql.Timestamp rent_start_date=renConSvc.getRentStartDate(rent_mem_no); 
			
			SimpleDateFormat df = new SimpleDateFormat( "yyyyMMdd" );
			java.sql.Timestamp rent_app_due = new java.sql.Timestamp(System.currentTimeMillis() + 7 * 24 * 60 * 60 * 1000);
			Integer intRent_app_due=new Integer(df.format(rent_app_due));
			Integer intRent_start_date=new Integer(df.format(rent_start_date));
		
			if(intRent_start_date>intRent_app_due) {
				canRent=0;    //起始日大於等於預約截止日 不可租用
			}else {
				canRent=1;   //起始日小於預約截止日 可租用
			}
			PrintWriter out = res.getWriter();
            out.print(canRent);
		}
			
	}
	

	private RentCartItem getRentFurItem(HttpServletRequest req) {
		Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
		String fnt_name = req.getParameter("fnt_name");
		Integer fnt_price = new Integer(req.getParameter("fnt_price"));
		Integer quantity =new Integer(req.getParameter("quantity"));
		RentCartItem rentCartItem = new RentCartItem();

		rentCartItem.setFnt_name(fnt_name);
		rentCartItem.setQuantity(quantity);
		rentCartItem.setFnt_it_no(fnt_it_no);
		rentCartItem.setFnt_price(fnt_price);
		return rentCartItem;
	}
}
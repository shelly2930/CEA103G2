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
		
//���b�e�ʧ@  action������checkout�� �i�A�s�W�ΧR���~�� 
		if (!action.equals("CHECKOUT")) {
			// �R���ʪ��������a��
			if (action.equals("DELETE")) {
				String del = req.getParameter("del");
				int d = Integer.parseInt(del);
				rentCartList.remove(d);
			}
			// �s�W�a����ʪ�����
			else if (action.equals("ADD")) {
				// ���o��ӷs�W���a��
				RentCartItem aRentCartItem = getRentFurItem(req);
	
				if (rentCartList == null) {
					rentCartList = new Vector<RentCartItem>();
					rentCartList.add(aRentCartItem);
				} else {
					if (rentCartList.contains(aRentCartItem)) {
						RentCartItem innerRentCartItem = rentCartList.get(rentCartList.indexOf(aRentCartItem));
					//(���Ư��ΦP�a���)���o�ʪ��������a��ƶq+�s�W�ƶq �A�@�_���s�]�w���a��~�����ƶq
						innerRentCartItem.setQuantity(innerRentCartItem.getQuantity() + aRentCartItem.getQuantity());
					} else {
						//�ʪ������L���a��� ����add
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

		// ���b�A�p���ʪ����a��~�������ζ����`��
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
				canRent=0;    //�_�l��j�󵥩�w���I��� ���i����
			}else {
				canRent=1;   //�_�l��p��w���I��� �i����
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
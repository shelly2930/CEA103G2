package com.rentCart.controller;
import java.util.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
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
		System.out.println("���i�즹Servlet");
		
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
				System.out.println("���i��ADD");
				RentCartItem aRentCartItem = getRentFurItem(req);
				System.out.println(aRentCartItem.getFnt_name());
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
				System.out.println("�w�i����ܤ�k");
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
			Integer total = 0;
			Integer amount=0;
			for (int i = 0; i < rentCartList.size(); i++) {
				RentCartItem order = rentCartList.get(i);
				Integer price = order.getFnt_price();
				Integer quantity = order.getQuantity();
				total += (price * quantity);   //�����X�p
				amount+=quantity;              //���ήa��X�p(�t�P�~��)
			}
			//�����X�p
			String rfa_total = String.valueOf(total);
			//���ήa��X�p
			String rfa_amount = String.valueOf(amount);
			req.setAttribute("rfa_total", rfa_total);
			req.setAttribute("rfa_amount", rfa_amount);
			
//����ݧ�checkout.jsp���|
String url = "/Checkout.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);
		}
	}
	
	private RentCartItem getRentFurItem(HttpServletRequest req) {

		Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
		String fnt_name = req.getParameter("fnt_name");
		Integer fnt_price = new Integer(req.getParameter("fnt_price"));
		Integer quantity =new Integer(req.getParameter("quantity"));
		System.out.println("�ƶq"+quantity);
		RentCartItem rentCartItem = new RentCartItem();

		rentCartItem.setFnt_name(fnt_name);
		rentCartItem.setQuantity(quantity);
		rentCartItem.setFnt_it_no(fnt_it_no);
		rentCartItem.setFnt_price(fnt_price);
		return rentCartItem;
	}
}
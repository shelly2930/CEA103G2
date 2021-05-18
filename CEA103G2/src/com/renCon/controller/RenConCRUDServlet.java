package com.renCon.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.renCon.model.RenConService;

/**
 * Servlet implementation class RenConCRUDServlet
 */
@WebServlet("/RenConCRUDServlet")
public class RenConCRUDServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");
		if("list".equals(action)) {
			File pdffile = new File(getServletContext().getRealPath("/pdf_uploaded"));
			if(!pdffile.exists()) {
				pdffile.mkdir();
			}
			String[] filename = pdffile.list();
			Gson g = new Gson();
			
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(g.toJson(filename));
		}
		if("del".equals(action)) {
			String name = null;
			if(req.getParameter("name")!=null) {
				name= req.getParameter("name");
			}
			
			File de = new File(getServletContext().getRealPath("/pdf_uploaded") +"\\"+name);
			System.out.println(de);
			de.delete();
		}
		if("getMem".equals(action)) {
			//呼叫service 取出所有會員
			RenConService svc = new RenConService();
			List<Integer> list_mem = svc.getMem(new Byte("1"));
			File mem_file = null;
			if(list_mem != null) {
				for(Integer mem_no : list_mem) {
					String mem= mem_no.toString();
					mem_file = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem);
					if(!mem_file.exists()) {
						mem_file.mkdir();
					}
				}
			}
			File file = new File(getServletContext().getRealPath("/pdf_uploaded"));
			String[] filename = file.list();
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(g.toJson(filename));
		}
		if("getMemHou".equals(action)) {
			//呼叫service 取出這會員所有租過物件
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			RenConService svc = new RenConService();
			List<Integer> list_mem_hou = svc.getMemHou(new Byte("1"),mem_no);
			File mem_hou_file = null;
			if(list_mem_hou != null) {
				for(Integer hos_no : list_mem_hou) {
					String hou= hos_no.toString();
					mem_hou_file = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no+"\\"+hou);
					if(!mem_hou_file.exists()) {
						mem_hou_file.mkdir();
					}
				}
			}
			File pdffile = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no);
			String[] filename = pdffile.list();
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(g.toJson(filename));
		}
		if("getMemHouCon".equals(action)) {
			//呼叫service 取出這會員且該物件的所有合約
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			RenConService svc = new RenConService();
			List<Integer> list_mem_hou_con = svc.getMemHouCon(new Byte("1"),mem_no,hos_no);
			File mem_hou_con_file = null;
			if(list_mem_hou_con != null) {
				for(Integer con_no : list_mem_hou_con) {
					String con= con_no.toString();
					mem_hou_con_file = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no+"\\"+hos_no+"\\"+con);
					if(!mem_hou_con_file.exists()) {
						mem_hou_con_file.mkdir();
					}
				}
			}
			
			
			
			
			File pdffile = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no+"\\"+hos_no);
			String[] filename = pdffile.list();
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(g.toJson(filename));
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}

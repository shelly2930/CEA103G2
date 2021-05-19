package com.renCon.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RenConPdfServlet
 */
@WebServlet("/RenConPdfServlet")
@MultipartConfig
public class RenConPdfServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		System.out.println("SSA");
		Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
		Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
		Integer con_no = Integer.parseInt(req.getParameter("con_no"));
		String name = req.getParameter("name");
		System.out.println("XX"+name);
		File path = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no+"\\"+hos_no+"\\"+con_no);
		System.out.println(path +"\\"+name);
		File pdfFile = new File(path +"\\"+name);
		res.setContentLength((int) pdfFile.length());

		try (FileInputStream is = new FileInputStream(pdfFile)) {
			OutputStream output = res.getOutputStream();
			byte[] b = new byte[is.available()];
			is.read(b);
			res.setContentType("application/pdf");
			output.write(b);
		}   
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}

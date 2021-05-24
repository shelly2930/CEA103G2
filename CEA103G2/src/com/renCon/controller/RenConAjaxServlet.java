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
import javax.servlet.http.Part;

import com.google.gson.Gson;
@WebServlet("/RenConAjaxServlet")
@MultipartConfig
public class RenConAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
		Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
		Integer con_no = Integer.parseInt(req.getParameter("con_no"));
		String judge = "different";
		req.setCharacterEncoding("utf-8");
		File pdffile = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no+"\\"+hos_no+"\\"+con_no);
		if(!pdffile.exists()) {
			pdffile.mkdir();
		}
		String[] ss = pdffile.list();
		for(String x : ss) {
			if(x.equals(getFileNameFromPart(req.getPart("file")))) {
				judge = "same";
			}
		}
		req.getPart("file").write(pdffile+"/"+getFileNameFromPart(req.getPart("file")));
		res.setCharacterEncoding("UTF-8");
		res.getWriter().print(judge);
			
		
		
		
	}	

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
		System.out.println("header=" + header); // 測試用
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
		System.out.println("filename=" + filename); // 測試用
		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}
}

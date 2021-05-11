package com.repApp.controller;


import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;

@WebServlet("/repAppPho/PhotoReader.do")
public class PhotoReader extends HttpServlet {

	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		try {
			Statement stmt = con.createStatement();
			String rep_no = req.getParameter("rep_no").trim();
			ResultSet rs = stmt.executeQuery("SELECT RAP_PHOTO FROM REPAIR_APPLICATION_PHOTO WHERE RAP_NO = " + rep_no);
			rs.next();
			InputStream in = rs.getBinaryStream("RAP_PHOTO");
			if(in != null) {
				BufferedInputStream bin = new BufferedInputStream(in);
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = bin.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				bin.close();
				in.close();
				System.out.println("有照片");
			} else {
//				res.sendError(HttpServletResponse.SC_NOT_FOUND);
				in = getServletContext().getResourceAsStream("/template_back-end/img/images.png");
				byte[] b = new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();
				System.out.println("沒照片");
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println(e);
			System.out.println("沒員工編號的例外");
			 
			InputStream in = getServletContext().getResourceAsStream("/template_back-end/img/images.png");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
		}
	}

	public void init() throws ServletException {
		try {
			Context ctx = new javax.naming.InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void destroy() {
		try {
			if (con != null) con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}

}
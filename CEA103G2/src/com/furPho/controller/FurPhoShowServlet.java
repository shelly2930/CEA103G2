package com.furPho.controller;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;



public class FurPhoShowServlet extends HttpServlet {

	Connection con;
	Statement stmt = null;
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {

			res.setContentType("image/gif");
			ServletOutputStream out = res.getOutputStream();

		try {
			stmt = con.createStatement();
			String fnt_pic_no=req.getParameter("fnt_pic_no").trim();
			ResultSet rs = stmt.executeQuery("SELECT fnt_pic FROM FURNITURE_PHOTO WHERE fnt_pic_no ="+fnt_pic_no);
			

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("fnt_pic"));
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
//				res.sendError(HttpServletResponse.SC_NOT_FOUND);
				InputStream in=getServletContext().getResourceAsStream("/back-end/furPho/images/none2.jpg");
				byte[] b =new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();
			
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			InputStream in=getServletContext().getResourceAsStream("/back-end/furPho/images/null2.jpg");
			byte[] b =new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
		
		}
	}
		
		
		
		
		public void init() throws ServletException {
			
			try {
				Context ctx = new InitialContext();
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
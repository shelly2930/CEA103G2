package com.memTen.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.memTen.model.MemTenService;
import com.memTen.model.MemTenVO;

@WebServlet("/MemberPicServlet")
public class MemberPicServlet extends HttpServlet {
	
	Connection con;

	private static final String GET_ONE_PIC = "SELECT mem_pic FROM MEMBER_TENANT WHERE mem_no = ?";
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("image/gif,image/png,image/jpeg");
		ServletOutputStream out = res.getOutputStream();
		String action = req.getParameter("action");
		
		try {
			PreparedStatement pstmt = con.prepareStatement(GET_ONE_PIC);
			
//			Integer mem_no = ((MemTenVO)req.getSession().getAttribute("MemTenVO")).getMem_no();
			
			Integer mem_no = new Integer(req.getParameter("mem_no"));
			pstmt.setInt(1, mem_no);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("mem_pic"));
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
//				res.sendError(HttpServletResponse.SC_NOT_FOUND);
				InputStream in = getServletContext().getResourceAsStream("/unprotected/memTen/images/none2.jpg");
				byte[] b = new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();
			}
			rs.close();
			pstmt.close();
			
//			MemTenService svc = new MemTenService();
//			MemTenVO vo = svc.getOneMemTen(mem_no);
//			out.write(vo.getMem_pic());
		} catch (Exception e) {
//			System.out.println(e);
			InputStream in = getServletContext().getResourceAsStream("/unprotected/memTen/images/null2.jpg");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
		}
		
	}
	
	// 連線池版本,要加上p182那3行,再用trycatch包起來
		public void init() throws ServletException {
			try {
				Context ctx = new javax.naming.InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject"); // 不管ds叫什麼,都是找到同一個連線池
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

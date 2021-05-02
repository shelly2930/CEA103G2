package com.houAddFur.model;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/testHouAddFur")
public class testHouAddFur extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HouAddFurDAO a = new HouAddFurDAO();
		HouAddFurVO aa = new HouAddFurVO();
		aa.setAdd_fnt_no(2);
		aa.setHos_no(1);
		System.out.println(a.findByPrimaryKey(aa).getHos_no());
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}

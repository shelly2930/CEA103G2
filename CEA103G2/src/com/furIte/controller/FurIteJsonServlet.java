package com.furIte.controller;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.furCat.model.*;
import com.furIte.model.*;


/**
 * Servlet implementation class HouseJsonServlet
 */
@WebServlet("/FurIteJsonServlet")
public class FurIteJsonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");
		if("getAllFurCat".equals(action)) {
			FurCatService furCatSvc = new FurCatService();
			List list=new ArrayList();
			list=furCatSvc.getAll();
			String str = new Gson().toJson(list);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
		}
		if("getAllHouseOnLine".equals(action)) {
			HouseService svc = new HouseService();
			List<HouseVO> list = new ArrayList<HouseVO>(); 
			list =	svc.getAll();
			String str = new Gson().toJson(list);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
		}
		if("getAllEmp".equals(action)) {
			EmployeeService svc = new EmployeeService();
			List<EmployeeVO> list = new ArrayList<EmployeeVO>(); 
			list =	svc.getAll();
			String str = new Gson().toJson(list);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
		}
		if("getEmpName".equals(action)){
			EmployeeService svc = new EmployeeService();
			Integer empno = Integer.parseInt(req.getParameter("empno"));
			EmployeeVO empvo = svc.getOneEmp(empno);
			String str = new Gson().toJson(empvo);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
		}
	}

}

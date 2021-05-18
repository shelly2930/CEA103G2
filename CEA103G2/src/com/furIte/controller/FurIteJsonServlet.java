package com.furIte.controller;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.house.model.HouseService;
import com.house.model.HouseVO;
import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.furCat.model.*;
import com.furIte.model.*;

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
			List<FurCatVO> list = new ArrayList<FurCatVO>();
			list = furCatSvc.getAll();
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
		if("getOneFurIte".equals(action)) {
			Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
			FurIteService svc = new FurIteService();
			FurIteVO furIteVO = svc.getOneFurIte(fnt_it_no);
			String str = new Gson().toJson(furIteVO);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
		}
	}

}

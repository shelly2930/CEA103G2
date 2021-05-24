package com.house.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.google.gson.Gson;
import com.house.model.HouseService;
import com.house.model.HouseVO;
import com.lanlord.model.LanlordService;
import com.lanlord.model.LanlordVO;

/**
 * Servlet implementation class HouseJsonServlet
 */
@WebServlet("/HouseJsonServlet")
public class HouseJsonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");
		if("getOneHouse".equals(action)) {
			Integer houseno = new Integer(req.getParameter("houseno"));
			HouseService svc = new HouseService();
			HouseVO housevo = svc.getOneHouse(houseno);
			String str = new Gson().toJson(housevo);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
			return;
		}
		if("getAllHouseOnLine".equals(action)) {
			HouseService svc = new HouseService();
			List<HouseVO> list = new ArrayList<HouseVO>(); 
			list =	svc.getAll();
			String str = new Gson().toJson(list);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
			return;
		}
		if("getAllEmp".equals(action)) {
			EmployeeService svc = new EmployeeService();
			List<EmployeeVO> list = new ArrayList<EmployeeVO>(); 
			list =	svc.getAll();
			String str = new Gson().toJson(list);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
			return;
		}
		if("getEmpName".equals(action)){
			EmployeeService svc = new EmployeeService();
			Integer empno = Integer.parseInt(req.getParameter("empno"));
			EmployeeVO empvo = svc.getOneEmp(empno);
			String str = new Gson().toJson(empvo);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
			return;
		}
		if("pullorpush".equals(action)){
			HouseService svc = new HouseService();
			Integer houseno = new Integer(req.getParameter("houseno"));
			Byte state = new Byte(req.getParameter("state"));
			svc.pullorpush(houseno, state);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(new Gson().toJson("жие\"));
			return;
		}
		if("findhouse".equals(action)) {
			HouseService svc = new HouseService();
			
			String keyword = null;
			if(req.getParameter("keyword")!=null) {
				keyword = req.getParameter("keyword");
			}else keyword="";
			System.out.println(keyword);
			List<HouseVO> list = svc.search(keyword);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(new Gson().toJson(list));
			return;
		}
		if("mapsearch".equals(action)) {
			String[] hos_city = new String[1];
			if(req.getParameter("hos_city")!=null) {
				hos_city[0] = req.getParameter("hos_city");
			}
			String[] hos_dist = new String[1];
			if(req.getParameter("hos_dist")!=null) {
				hos_dist[0] = req.getParameter("hos_dist");
			}
			Map<String,String[]> map = new HashMap<String, String[]>();
			map.put("hos_city",hos_city);
			map.put("hos_dist",hos_dist);
			HouseService houseSvc = new HouseService();
			List<HouseVO> list  = houseSvc.getAll(map);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(new Gson().toJson(list));
			return;
		}
		if("getLanlord".equals(action)) {
			Integer lld_no = new Integer(req.getParameter("lld_no"));
			LanlordService svc = new LanlordService();
			LanlordVO  lldvo = svc.getOneLanlord(lld_no);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(new Gson().toJson(lldvo));
			return;
		}
	}

}

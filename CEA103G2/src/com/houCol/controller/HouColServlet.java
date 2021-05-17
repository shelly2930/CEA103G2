package com.houCol.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.houCol.model.HouColService;
import com.houCol.model.HouColVO;
import com.rooVieApp.model.RooVieAppService;
/**
 * Servlet implementation class HouColServlet
 */
@WebServlet("/HouColServlet")
public class HouColServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");
		req.setCharacterEncoding("UTF-8");
		if("addHouCol".equals(action)){
			System.out.println("進入Servlet");
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			HouColService svc = new HouColService();
			svc.addHouCol(mem_no, hos_no, "");
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(hos_no);
		}
		if("getall".equals(action)){
			List<HouColVO> list = new LinkedList<HouColVO>();
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			HouColService svc = new HouColService();
			list= svc.getAll(mem_no);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(new Gson().toJson(list));
		}
		if("deleteCol".equals(action)){
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			HouColService svc = new HouColService();
			svc.deleteOneByPk1AndPk2(mem_no, hos_no);
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print("已刪除");
		}
		if("getOne".equals(action)){
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			HouColService svc = new HouColService();
			if(svc.judge(mem_no, hos_no)==0) {
				res.setCharacterEncoding("UTF-8");
				res.getWriter().print("notfind");
			}else {//表示有該列
				HouColVO houcolVO = svc.findByPrimaryKey(mem_no, hos_no);
				res.setContentType("application/json");
				res.setCharacterEncoding("UTF-8");
				res.getWriter().print(new Gson().toJson(houcolVO));
			}
			
		}
		if("update".equals(action)){
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			String hos_col_note = req.getParameter("hos_col_note");
			HouColService svc = new HouColService();
			svc.updateHouCol(mem_no, hos_no, hos_col_note);
			
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print("修改成功");
		}
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, res);
	}

}

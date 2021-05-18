package com.furCol.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.furCol.model.FurColService;
import com.furCol.model.FurColVO;
import com.google.gson.Gson;

@WebServlet("/FurColServlet")
public class FurColServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String action = req.getParameter("action");
		req.setCharacterEncoding("UTF-8");
		
		if("add_furCol".equals(action)){
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer fnt_it_no = Integer.parseInt(req.getParameter("fnt_it_no"));
			String fnt_col_note = req.getParameter("fnt_col_note");
			FurColService svc = new FurColService();
			svc.addFurCol(mem_no, fnt_it_no, fnt_col_note);
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print("新增成功");
		}
		if("update_furCol".equals(action)){
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer fnt_it_no = Integer.parseInt(req.getParameter("fnt_it_no"));
			String fnt_col_note = req.getParameter("fnt_col_note");
			FurColService svc = new FurColService();
			svc.updateFurCol(mem_no, fnt_it_no, fnt_col_note);
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print("修改成功");
		}
		if("delete_furCol".equals(action)){
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer fnt_it_no = Integer.parseInt(req.getParameter("fnt_it_no"));
			FurColService svc = new FurColService();
			svc.deleteFurCol(mem_no, fnt_it_no);
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print("刪除成功");
		}
		if("getOne_furCol".equals(action)){
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer fnt_it_no = Integer.parseInt(req.getParameter("fnt_it_no"));
			FurColService svc = new FurColService();
			FurColVO furColVO = svc.getOneFurCol(mem_no, fnt_it_no);
			if(furColVO != null) {
				res.setContentType("application/json");
				res.setCharacterEncoding("UTF-8");
				res.getWriter().print(new Gson().toJson(furColVO));
			}
		}
		if("getAll_furCol".equals(action)){
			List<FurColVO> list = new ArrayList<FurColVO>();
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			FurColService svc = new FurColService();
			list= svc.getOneMemCol(mem_no);
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(new Gson().toJson(list));
		}
	}
}

package com.memTen.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.lanlord.model.LanlordService;
import com.lanlord.model.LanlordVO;
import com.memTen.model.MemTenService;
import com.memTen.model.MemTenVO;

@WebServlet("/AjaxLoginServlet")
public class AjaxLoginServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		String action = req.getParameter("action");
		
		if (("login_ajax".equals(action)))  {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);	
			
			try {
				String mem_username = req.getParameter("mem_username").trim();

				String mem_password = req.getParameter("mem_password").trim();

				MemTenService memTenSvc = new MemTenService();
				MemTenVO memTenVO = memTenSvc.loginCheck(mem_username);

				if(memTenVO != null && mem_password.equals(memTenVO.getMem_password()) && memTenVO.getMem_status() == 1) {
					HttpSession session = req.getSession();
					
					session.setAttribute("MemTenVO", memTenVO);

					// 房東
					LanlordService lanlordSvc = new LanlordService();
					LanlordVO lanlordVO = lanlordSvc.getOneLanlordByMemTen(memTenVO.getMem_no());

					// 用會員編號檢查是否有房東編號
					if(lanlordVO != null) {
						session.setAttribute("lanlordVO", lanlordVO);
					}

					Gson gson =  new Gson();
					String str = gson.toJson(memTenVO);
					
					System.out.println("str:" + str);
					
					res.setContentType("application/json");
					res.setCharacterEncoding("UTF-8");
					
					PrintWriter out = res.getWriter();
					
					out.println(str);
						out.flush();
						out.close();
						
				}else {
					return;
				}

			}catch (Exception e) {
				System.out.println("8");
				return;
			}
		}
	}

}

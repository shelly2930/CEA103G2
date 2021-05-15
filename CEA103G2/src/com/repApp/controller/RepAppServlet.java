package com.repApp.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.JSONException;
import org.json.JSONObject;

import com.employee.model.EmployeeDAO;
import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.repApp.model.RepAppService;
import com.repApp.model.RepAppVO;
import com.repAppDet.model.RepAppDetVO;
import com.repAppPho.model.RepAppPhoVO;
import com.staRig.model.StaRigService;
import com.staRig.model.StaRigVO;

@WebServlet("/repApp/repApp.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class RepAppServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
		HttpSession session = req.getSession();

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			try {
				String mem_no = req.getParameter("mem_no");
				String rtct_no = req.getParameter("rtct_no");
				
				java.time.LocalDateTime ldt = java.time.LocalDateTime.parse(req.getParameter("ra_order_time").trim());
				java.sql.Timestamp ra_order_time = java.sql.Timestamp.valueOf(ldt);
				
//				Date轉Timestamp
//				java.sql.Date date = java.sql.Date.valueOf(req.getParameter("ra_order_time").trim());
//				java.sql.Timestamp ra_order_time = new java.sql.Timestamp(date.getTime());
				
//				String ra_no = req.getParameter("ra_no");
				String rad_dmg = req.getParameter("rad_dmg");
				String rad_dsc = req.getParameter("rad_dsc");
//				String rad_no = req.getParameter("rad_no");
				Part part = req.getPart("rap_photo");
				InputStream in = part.getInputStream();
				byte[] rap_photo =  new byte[in.available()];
				in.read(rap_photo);
				in.close();
				
				RepAppPhoVO repAppPhoVO = new RepAppPhoVO();
				RepAppDetVO repAppDetVO= new RepAppDetVO();
				
				repAppPhoVO.setRap_photo(rap_photo);
				repAppPhoVO.setRepAppDetVO(repAppDetVO);
				
				Set<RepAppPhoVO> set_RepAppPhoVO = new LinkedHashSet<RepAppPhoVO>();
				set_RepAppPhoVO.add(repAppPhoVO);
				
				repAppDetVO.setRad_dmg(rad_dmg);
				repAppDetVO.setRad_dsc(rad_dsc);
				repAppDetVO.setSet_RepAppPhoVO(set_RepAppPhoVO);
				
				Set<RepAppDetVO> set_RepAppDetVO = new LinkedHashSet<RepAppDetVO>();
				set_RepAppDetVO.add(repAppDetVO);
				
				
				RepAppService repAppService = new RepAppService();
				repAppService.addRepApp(new Integer(mem_no), new Integer(rtct_no), ra_order_time, set_RepAppDetVO);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
//				String url = "/back-end/employee/listAllEmp.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交showAllEmp.jsp
//				successView.forward(req, res);
				res.sendRedirect(req.getContextPath() + "/back-end/indexBack.jsp");

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				System.out.println(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/repApp/addRepApp.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
}
package com.renCon.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.house.model.HouseService;
import com.house.model.HouseVO;
import com.memTen.model.MemTenService;
import com.memTen.model.MemTenVO;
import com.renCon.model.RenConService;
import com.renCon.model.RenConVO;

/**
 * Servlet implementation class RenConCRUDServlet
 */
@WebServlet("/RenConCRUDServlet")
public class RenConCRUDServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");
		if("updateTmtDate".equals(action)) {
			Integer con_no = Integer.parseInt(req.getParameter("con_no"));
			Byte status = Byte.parseByte(req.getParameter("status"));
			System.out.println(req.getParameter("tmtdate"));
			java.util.Date tmttemp = null;
			java.sql.Date tmtdate = null;
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			try {
				tmttemp = format.parse(req.getParameter("tmtdate"));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			tmtdate = new java.sql.Date(tmttemp.getTime());
			RenConService svc = new RenConService();
			svc.updateTmtDate(con_no, tmtdate, status);
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(status);
		}
		
		if("updateStatus".equals(action)) {
			Integer con_no = Integer.parseInt(req.getParameter("con_no"));
			Byte status = Byte.parseByte(req.getParameter("status"));
			RenConService svc = new RenConService();
			svc.updateStatus(con_no, status);
		}
		if("getDate".equals(action)) {
			Integer con_no = Integer.parseInt(req.getParameter("con_no"));
			RenConService svc = new RenConService();
			System.out.println(svc.getEndDate(con_no));
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(svc.getEndDate(con_no));
		}
		
		
		if("getPic".equals(action)) {
			Integer con_no = Integer.parseInt(req.getParameter("con_no"));
			RenConService svc = new RenConService();
			byte[] bytepic = svc.getPic(con_no);
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			if(bytepic==null) {
				res.getWriter().print(g.toJson("none"));
			}else {
				String base64pic = bytetobase64(bytepic);
				res.getWriter().print(g.toJson(base64pic));
				
			}
		}
		
		if("savePic".equals(action)) {
			String base = req.getParameter("base");
			Integer con_no = Integer.parseInt(req.getParameter("con_no"));
			RenConService svc = new RenConService();
			svc.updatePic(base64tobyte(base), con_no);
		}
		
		if("list".equals(action)) {
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			Integer con_no = Integer.parseInt(req.getParameter("con_no"));
			File pdffile = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no+"\\"+hos_no+"\\"+con_no);
			if(!pdffile.exists()) {
				pdffile.mkdir();
			}
			String[] filename = pdffile.list();
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			if(filename==null) {
				res.getWriter().print(g.toJson("none"));
			}else {
				
				res.getWriter().print(g.toJson(filename));
			}
		}
		if("del".equals(action)) {
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			Integer con_no = Integer.parseInt(req.getParameter("con_no"));
			String name = null;
			if(req.getParameter("name")!=null) {
				name= req.getParameter("name");
			}
			
			File de = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no+"\\"+hos_no+"\\"+con_no+"\\"+name);
			de.delete();
		}
		if("getMem".equals(action)) {
			//呼叫service 取出所有會員
			RenConService svc = new RenConService();
			Byte status = Byte.parseByte(req.getParameter("status"));
			List<Integer> list_mem = svc.getMem(status);
			File mem_file = null;
			if(list_mem != null) {
				for(Integer mem_no : list_mem) {
					String mem= mem_no.toString();
					mem_file = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem);
					if(!mem_file.exists()) {
						mem_file.mkdirs();
					}
				}
			}
			File file = new File(getServletContext().getRealPath("/pdf_uploaded"));
			String[] filename = file.list();
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			if(filename!=null) {
				res.getWriter().print(g.toJson(filename));
			}else {
				res.getWriter().print(g.toJson("none"));
			}
		}
		if("getMemHou".equals(action)) {
			//呼叫service 取出這會員所有租過物件
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Byte status = Byte.parseByte(req.getParameter("status"));
			RenConService svc = new RenConService();
			List<Integer> list_mem_hou = svc.getMemHou(status,mem_no);
			File mem_hou_file = null;
			if(list_mem_hou != null) {
				for(Integer hos_no : list_mem_hou) {
					String hou= hos_no.toString();
					mem_hou_file = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no+"\\"+hou);
					if(!mem_hou_file.exists()) {
						mem_hou_file.mkdirs();
					}
				}
			}
			File pdffile = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no);
			String[] filename = pdffile.list();
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(g.toJson(filename));
		}
		if("getMemHouCon".equals(action)) {
			//呼叫service 取出這會員且該物件的所有合約
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			Byte status = Byte.parseByte(req.getParameter("status"));
			RenConService svc = new RenConService();
			List<Integer> list_mem_hou_con = svc.getMemHouCon(status,mem_no,hos_no);
			File mem_hou_con_file = null;
			if(list_mem_hou_con != null) {
				for(Integer con_no : list_mem_hou_con) {
					String con= con_no.toString();
					mem_hou_con_file = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no+"\\"+hos_no+"\\"+con);
					if(!mem_hou_con_file.exists()) {
						mem_hou_con_file.mkdirs();
					}
				}
			}
			File pdffile = new File(getServletContext().getRealPath("/pdf_uploaded")+"\\"+mem_no+"\\"+hos_no);
			String[] filename = pdffile.list();
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(g.toJson(filename));
		}
		if("getOneMemten".equals(action)) {
			Integer mem = Integer.parseInt(req.getParameter("mem_no"));
			MemTenService svc = new MemTenService();
			MemTenVO memvo = svc.getOneMemTen(mem);

			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(new Gson().toJson(memvo));
		}
		if("getOneHouse".equals(action)) {
			Integer houseno = Integer.parseInt(req.getParameter("houseno"));
			HouseService svc = new HouseService();
			HouseVO housevo = svc.getOneHouse(houseno);

			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(new Gson().toJson(housevo));
		}
		
		
		if("getMem_coustom".equals(action)) {
			//呼叫service 取出所有會員
			RenConService svc = new RenConService();
			Byte status = Byte.parseByte(req.getParameter("status"));
			List<Integer> list_mem = svc.getMem(status);
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(g.toJson(list_mem));
		}
		if("getMemHou_coustom".equals(action)) {
			//呼叫service 取出這會員所有租過物件
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Byte status = Byte.parseByte(req.getParameter("status"));
			RenConService svc = new RenConService();
			List<Integer> list_mem_hou = svc.getMemHou(status,mem_no);
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			if(list_mem_hou.size()==0) {
				res.getWriter().print(g.toJson("none"));
			}else {
				res.getWriter().print(g.toJson(list_mem_hou));
			}
		}
		if("getMemHouCon_coustom".equals(action)) {
			//呼叫service 取出這會員且該物件的所有合約
			Integer mem_no = Integer.parseInt(req.getParameter("mem_no"));
			Integer hos_no = Integer.parseInt(req.getParameter("hos_no"));
			Byte status = Byte.parseByte(req.getParameter("status"));
			RenConService svc = new RenConService();
			List<Integer> list_mem_hou_con = svc.getMemHouCon(status,mem_no,hos_no);
			
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			if(list_mem_hou_con.size()==0) {
				res.getWriter().print(g.toJson("none"));
			}else {
				res.getWriter().print(g.toJson(list_mem_hou_con));
			}
			
		}
		if("getOneCon".equals(action)) {
			Integer con_no = Integer.parseInt(req.getParameter("con_no"));
			RenConService svc = new RenConService();
			RenConVO renconvo = svc.findByPK(con_no);
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(g.toJson(renconvo));
		}
		if("getall".equals(action)) {
			RenConService svc = new RenConService();
			List<RenConVO> list = svc.getAllByMem();
			Gson g = new Gson();
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(g.toJson(list));
		}
		
		
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
	 public static byte[] base64tobyte(String base64Str){
	        return Base64.getDecoder().decode(base64Str);
	 }
	 public static String bytetobase64(byte[] base64byte){
	        return Base64.getEncoder().encodeToString(base64byte);
	 }
}

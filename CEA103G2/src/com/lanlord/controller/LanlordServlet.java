package com.lanlord.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.google.gson.Gson;
import com.house.model.HouseService;
import com.house.model.HouseVO;
import com.lanlord.model.LanlordService;
import com.lanlord.model.LanlordVO;
import com.memTen.model.MemTenVO;

@MultipartConfig
public class LanlordServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String str = req.getParameter("lld_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�ЪF�s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/lanlord/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				Integer lld_no = null;
				try {
					lld_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("�ЪF�s���榡�����T");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/lanlord/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************2.�}�l�d�߸��*****************************************/
				LanlordService lanlordSvc = new LanlordService();
				LanlordVO lanlordVO = lanlordSvc.getOneLanlord(lld_no);
				if (lanlordVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/lanlord/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("lanlordVO", lanlordVO); // ��Ʈw���X��lanlordVO����,�s�Jreq
				String url = "/back-end/lanlord/listOneLanlord.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/lanlord/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllEmp.jsp ��  /dept/listEmps_ByDeptno.jsp ���ШD

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			/***************************���P****************************************/
			String requestURL = req.getParameter("requestURL"); // �e�X�ק諸�ӷ��������|: �i�ର�i/emp/listAllEmp.jsp�j ��  �i/dept/listEmps_ByDeptno.jsp�j �� �i /dept/listAllDept.jsp�j		
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				Integer lld_no = new Integer(req.getParameter("lld_no"));
				
				/***************************2.�}�l�d�߸��****************************************/
				LanlordService lanlordSvc = new LanlordService();
				LanlordVO lanlordVO = lanlordSvc.getOneLanlord(lld_no);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("lanlordVO", lanlordVO); // ��Ʈw���X��lanlordVO����,�s�Jreq
				String url = "/back-end/lanlord/authOneLanlord.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���update_lanlord_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z************************************/
			} catch (Exception e) {
				errorMsgs.add("�ק��ƨ��X�ɥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
//		// �e�x�ЪF
//		if ("update".equals(action)) { // �Ӧ�update_lanlord_input.jsp���ШD
//			
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String requestURL = req.getParameter("requestURL"); // �e�X�ק諸�ӷ��������|: �i�ର�i/lanlord/listAllEmp.jsp�j ��  �i/dept/listLanlords_ByDeptno.jsp�j �� �i /dept/listAllDept.jsp�j
//		
//			try {
//				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
//				Integer lld_no = new Integer(req.getParameter("lld_no").trim());
//
//				Integer mem_no = new Integer(req.getParameter("mem_no").trim());
//				
//				String lld_bank = req.getParameter("lld_bank").trim();
//				
//				String lld_account = req.getParameter("lld_account").trim();
//				
//				Part part = req.getPart("lld_acc_pic");
//				InputStream lld_acc_picin = part.getInputStream();
//				byte[] lld_acc_picBuf = new byte[lld_acc_picin.available()];
//				lld_acc_picin.read(lld_acc_picBuf);
//				lld_acc_picin.close();
//				
//				String ename = req.getParameter("ename");
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//				if (ename == null || ename.trim().length() == 0) {
//					errorMsgs.add("���u�m�W: �ФŪť�");
//				} else if(!ename.trim().matches(enameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
//					errorMsgs.add("���u�m�W: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��10����");
//	            }
//				
//				String job = req.getParameter("job").trim();
//				if (job == null || job.trim().length() == 0) {
//					errorMsgs.add("¾��ФŪť�");
//				}		
//				
//				
//
//				Double sal = null;
//				try {
//					sal = new Double(req.getParameter("sal").trim());
//				} catch (NumberFormatException e) {
//					sal = 0.0;
//					errorMsgs.add("�~���ж�Ʀr.");
//				}
//
//				Double comm = null;
//				try {
//					comm = new Double(req.getParameter("comm").trim());
//				} catch (NumberFormatException e) {
//					comm = 0.0;
//					errorMsgs.add("�����ж�Ʀr.");
//				}
//
//				Integer deptno = new Integer(req.getParameter("deptno").trim());
//
//				LanlordVO lanlordVO = new LanlordVO();
//				lanlordVO.setEmpno(lld_no);
//				lanlordVO.setEname(ename);
//				lanlordVO.setJob(job);
//				lanlordVO.setHiredate(hiredate);
//				lanlordVO.setSal(sal);
//				lanlordVO.setComm(comm);
//				lanlordVO.setDeptno(deptno);
//
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("lanlordVO", lanlordVO); // �t����J�榡���~��lanlordVO����,�]�s�Jreq
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/lanlord/update_lanlord_input.jsp");
//					failureView.forward(req, res);
//					return; //�{�����_
//				}
//				
//				/***************************2.�}�l�ק���*****************************************/
//				LanlordService lanlordSvc = new LanlordService();
//				lanlordVO = lanlordSvc.updateLanlord(lld_no, ename, job, hiredate, sal,comm, deptno);
//				
//				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/				
//				DeptService deptSvc = new DeptService(); //
//				if(requestURL.equals("/dept/listLanlords_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//					req.setAttribute("listLanlords_ByDeptno",deptSvc.getLanlordsByDeptno(deptno)); // ��Ʈw���X��list����,�s�Jrequest
//
//                String url = requestURL;
//				RequestDispatcher successView = req.getRequestDispatcher(url);   // �ק令�\��,���^�e�X�ק諸�ӷ�����
//				successView.forward(req, res);
//
//				/***************************��L�i�઺���~�B�z*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/lanlord/update_lanlord_input.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
		// �ӽЦ����ЪF
		if("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {

				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/				
				Integer mem_no = ((MemTenVO)req.getSession().getAttribute("MemTenVO")).getMem_no();
//				Integer mem_no=null;
//				try {
//					mem_no = new Integer(req.getParameter("mem_no").trim());
//				} catch (Exception e) {
//					errorMsgs.add("�п�ܮa�����O");
//				}
				
//				Integer mem_no = new Integer(req.getParameter("mem_no").trim());
//				System.out.println(mem_no);
				
				java.sql.Timestamp lld_apptime = new java.sql.Timestamp(System.currentTimeMillis());
				
				String lld_bank = req.getParameter("lld_bank").trim();
				
				String lld_account = req.getParameter("lld_account").trim();
				
				Part part = req.getPart("lld_acc_pic");
				InputStream lld_acc_picin = part.getInputStream();
				byte[] lld_acc_picBuf = new byte[lld_acc_picin.available()];
				lld_acc_picin.read(lld_acc_picBuf);
				lld_acc_picin.close();
				
				LanlordVO lanlordVO = new LanlordVO();
				lanlordVO.setLld_apptime(lld_apptime);
				lanlordVO.setLld_bank(lld_bank);
				lanlordVO.setLld_account(lld_account);
				lanlordVO.setLld_acc_pic(lld_acc_picBuf);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("lanlordVO", lanlordVO); // �t����J�榡���~��memTenVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/lanlord/addLanlord.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.�}�l�s�W���***************************************/
				LanlordService lanlordSvc = new LanlordService();
				lanlordVO = lanlordSvc.addLanlord(mem_no, lld_apptime, lld_bank, lld_account, lld_acc_picBuf);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/index.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
			}
		}
		
		if("findByLldStatus".equals(action)) {
			
			try {
				
				Byte lld_status = null;
				lld_status = Byte.valueOf(req.getParameter("lld_status"));
				
				LanlordService lanlordSvc = new LanlordService();
				List<LanlordVO> list = new ArrayList<LanlordVO>();
				list = lanlordSvc.findByLldstatus(lld_status);
				req.setAttribute("list",list);
				
				String url = "/back-end/lanlord/findByLldStatus.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			
			}catch(Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/lanlord/listAllLanlord.jsp");
				failureView.forward(req, res);
			}
		}
		
		// �ثe�S�Ψ�
		if ("authLanlord".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			/***************************���P****************************************/
			String requestURL = req.getParameter("requestURL"); // �e�X�ק諸�ӷ��������|: �i�ର�i/emp/listAllEmp.jsp�j ��  �i/dept/listEmps_ByDeptno.jsp�j �� �i /dept/listAllDept.jsp�j		
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				Integer lld_no = new Integer(req.getParameter("lld_no"));
				
				/***************************2.�}�l�d�߸��****************************************/
				LanlordService lanlordSvc = new LanlordService();
				LanlordVO lanlordVO = lanlordSvc.getOneLanlord(lld_no);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("lanlordVO", lanlordVO); // ��Ʈw���X��lanlordVO����,�s�Jreq
				String url = "/back-end/lanlord/authOneLanlord.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���update_lanlord_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z************************************/
			} catch (Exception e) {
				errorMsgs.add("�ק��ƨ��X�ɥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		String pass = req.getParameter("pass");
		String fail = req.getParameter("fail");
		if ("�q�L".equals(pass) || "���q�L".equals(fail)) {
			
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				Integer lld_no = new Integer(req.getParameter("lld_no"));
				
				LanlordService lanlordSvc = new LanlordService();
				LanlordVO lanlordVO = lanlordSvc.getOneLanlord(lld_no);
				
				Byte lld_status = null;
				
				Timestamp lld_id_isvrfed = null;
				
				String lld_id_disapprove = null;
				
				if("�q�L".equals(pass)) {
					lld_status = 1;
					lld_id_isvrfed = new java.sql.Timestamp(System.currentTimeMillis());
				}
				if("���q�L".equals(fail)) {
					lld_status = 2;
					lld_id_disapprove = req.getParameter("lld_id_disapprove").trim();
					lld_id_isvrfed = null;
				}
				
				/***************************2.�}�l�ק���*****************************************/
				lanlordVO = lanlordSvc.updatelldstatus(lld_no, lld_status, lld_id_isvrfed, lld_id_disapprove);
				req.setAttribute("lanlordVO", lanlordVO);
				
				List<LanlordVO> list = new ArrayList<LanlordVO>();
				list = lanlordSvc.findByLldstatus(lld_status);
				req.setAttribute("list",list);
				
				String url = "/back-end/lanlord/findByLldStatus.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneEmp.jsp
				successView.forward(req, res);
				
				/***************************��L�i�઺���~�B�z*************************************/	
			} catch (Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/lanlord/findByLldStatus.jsp");
				failureView.forward(req, res);
			}
		}
		
		
	}
}

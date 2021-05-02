package com.furLis.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.http.*;
import com.furCat.model.FurCatService;
import com.furLis.model.*;
import com.furPho.model.FurPhoVO;

public class FurLisServlet extends HttpServlet {
//�s�W�έק� �R�� �d��DAO�ݧ�
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
		
	//�s�W��ƶs�s�� �ݳB�z�~���s���O�U�Ԧ������D �a��j�����U�Ԧ���檺�ȭn�s??
		 if ("insert".equals(action)) {   
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
					Integer fnt_ctgr_no=null;
					try {
						fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
					} catch (Exception e) {
						errorMsgs.add("�п�ܮa�����O");
					}
					
					Integer fnt_it_no=null;
					try {
						fnt_it_no = new Integer(req.getParameter("fnt_it_no").trim());
					} catch (Exception e) {
						errorMsgs.add("�п�ܮa��~�����O");
					}
					//�ʸm���
					Timestamp fnt_acq_date = null;
					try {
						fnt_acq_date = Timestamp.valueOf(req.getParameter("fnt_acq_date").trim());
					} catch (IllegalArgumentException e) {
						fnt_acq_date=new Timestamp(System.currentTimeMillis());
						errorMsgs.add("�п�J���!");
					}
					//�a�㪬�A
					Byte fnt_status=null;
					try {
						fnt_status = new Byte(req.getParameter("fnt_status").trim());
					} catch (Exception e) {
						fnt_status=0;
						errorMsgs.add("�п�ܮa�㪬�A");
					}
					//���ɪ��A
					Byte fnt_rent_status=null;
					try {
						fnt_rent_status = new Byte(req.getParameter("fnt_rent_status").trim());
					} catch (Exception e) {
						fnt_rent_status='0';
						errorMsgs.add("�п�ܮa�㯲�ɪ��A");
					}
				//���o��� �i���ŭ�	
					Timestamp fnt_unusable_date = null;
					try {
						fnt_unusable_date = Timestamp.valueOf(req.getParameter("fnt_unusable_date").trim());
					} catch (IllegalArgumentException e) {
						fnt_unusable_date = null;
					}
					
					FurLisVO furLisVO = new FurLisVO();
					furLisVO.setFnt_it_no(fnt_it_no);
					furLisVO.setFnt_acq_date(fnt_acq_date);
					furLisVO.setFnt_status(fnt_status);
					furLisVO.setFnt_rent_status(fnt_rent_status);
					furLisVO.setFnt_unusable_date(fnt_unusable_date);
									
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furLisVO", furLisVO); // �t����J�榡���~��furLisVO����,�]�s�Jreq
						req.setAttribute("fnt_ctgr_no", fnt_ctgr_no);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furLis/addFurLis.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.�}�l�s�W���***************************************/
					FurLisService furLisSvc = new FurLisService();
					furLisVO = furLisSvc.addFurLis(fnt_it_no, fnt_acq_date,fnt_status, fnt_rent_status,fnt_unusable_date);
					req.setAttribute("fnt_ctgr_no", fnt_ctgr_no);
					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
					String url = "/back-end/furLis/listAllFurLis.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 
					successView.forward(req, res);				
					
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furLis/addFurLis.jsp");
					failureView.forward(req, res);
				}
			}
		//�Ӧۺ޲z�����ק�s
		 if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllFurLis.jsp���ШD

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.�����ШD�Ѽ�****************************************/
					Integer fnt_id = new Integer(req.getParameter("fnt_id"));
					
					/***************************2.�}�l�d�߸��****************************************/
					FurLisService furLisSvc = new FurLisService();
					FurLisVO furLisVO = furLisSvc.getOneFurLis(fnt_id);
									
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("furLisVO", furLisVO);         // ��Ʈw���X��empVO����,�s�Jreq
					String url = "/back-end/furLis/update_furLis_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furLis/listAllFurLis.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 
		//�ק��ƭ����s��
		 if ("update".equals(action)) {   
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/

					Integer fnt_id=new Integer(req.getParameter("fnt_id").trim());
					Integer fnt_it_no=new Integer(req.getParameter("fnt_it_no").trim());
					
					//�ʸm���
					Timestamp fnt_acq_date = null;
					try {
						fnt_acq_date = Timestamp.valueOf(req.getParameter("fnt_acq_date").trim());
					} catch (IllegalArgumentException e) {
						fnt_acq_date=new Timestamp(System.currentTimeMillis());
						errorMsgs.add("�п�J���!");
					}
					//�a�㪬�A
					Byte fnt_status=null;
					try {
						fnt_status = new Byte(req.getParameter("fnt_status").trim());
					} catch (Exception e) {
						fnt_status=0;
						errorMsgs.add("�п�ܮa�㪬�A");
					}
					//���ɪ��A
					Byte fnt_rent_status=null;
					try {
						fnt_rent_status = new Byte(req.getParameter("fnt_rent_status").trim());
					} catch (Exception e) {
						fnt_rent_status='0';
						errorMsgs.add("�п�ܮa�㯲�ɪ��A");
					}
				//���o��� �i���ŭ�	
					Timestamp fnt_unusable_date = null;
					try {
						fnt_unusable_date = Timestamp.valueOf(req.getParameter("fnt_unusable_date").trim());
					} catch (IllegalArgumentException e) {
						fnt_unusable_date = null;
					}
					
					FurLisVO furLisVO = new FurLisVO();
					furLisVO.setFnt_it_no(fnt_id);
					furLisVO.setFnt_it_no(fnt_it_no);
					furLisVO.setFnt_acq_date(fnt_acq_date);
					furLisVO.setFnt_status(fnt_status);
					furLisVO.setFnt_rent_status(fnt_rent_status);
					furLisVO.setFnt_unusable_date(fnt_unusable_date);
									
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furLisVO", furLisVO); // �t����J�榡���~��furLisVO����,�]�s�Jreq
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furLis/update_furLis_input.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.�}�l�s�W���***************************************/
					FurLisService furLisSvc = new FurLisService();
					furLisVO = furLisSvc.updateFurLis(fnt_id,fnt_it_no, fnt_acq_date,fnt_status, fnt_rent_status,fnt_unusable_date);
					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
					String url = "/back-end/furLis/listAllFurLis.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 
					successView.forward(req, res);				
					
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furLis/update_furLis_input.jsp");
					failureView.forward(req, res);
				}
			}
		 
			if ("delete".equals(action)) { 
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				String requestURL = req.getParameter("requestURL"); // �e�X�R�����ӷ��������|
				try {
					/***************************1.�����ШD�Ѽ�***************************************/
					Integer fnt_id = new Integer(req.getParameter("fnt_id"));
					
					/***************************2.�}�l�R�����***************************************/
					FurLisService furLisSvc = new FurLisService();
					furLisSvc.deleteFurLis(fnt_id);
					
					/***************************3.�R������,�ǳ����(Send the Success view)***********/								
					String url =requestURL;
					RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
					successView.forward(req, res);
					
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�R����ƥ���:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
				}
			}		
		 
//�ƦX�d��
			if ("listEmps_ByCompositeQuery".equals(action)) { // �Ӧ�listAllLis.jsp���ƦX�d�߽ШD
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					
					/***************************1.�N��J����ରMap**********************************/ 
					//�ĥ�Map<String,String[]> getParameterMap()����k 
					//�`�N:an immutable java.util.Map 
					//Map<String, String[]> map = req.getParameterMap();
					//�x��]�pMap ����ssession
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					
					// �H�U�� if �϶��u��Ĥ@������ɦ���
					if (req.getParameter("whichPage") == null){
						Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					    //���ɦs���� �]map�٨S�F�� map.size()=0 ��HashMap��Map����ssession���S�ʬ~��
						session.setAttribute("map",map1);
						map = map1;
					} 
					
					/***************************2.�}�l�ƦX�d��***************************************/
					FurLisService furLisSvc = new FurLisService();
					List<FurLisVO> list  = furLisSvc.getAll(map);
					
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("listEmps_ByCompositeQuery", list); // ��Ʈw���X��list����,�s�Jrequest
					RequestDispatcher successView = req.getRequestDispatcher("/back-end/furLis/listAllFurLis.jsp"); // ���\���listEmps_ByCompositeQuery.jsp
					successView.forward(req, res);
					
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furLis/listAllFurLis.jsp");
					failureView.forward(req, res);
				}
			}
			
			
	}
}
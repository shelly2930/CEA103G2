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
import com.lanBill.controller.LanBillServlet;

public class FurLisServlet extends HttpServlet {
//�s�W�έק� �R�� �d��DAO�ݧ�
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=Big5");
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
					Byte fnt_rent_status=0;
					
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
				
				String requestURL = req.getParameter("requestURL"); 
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
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
				}
			}
		 
		 
		//�ק��ƭ����s��
		 if ("update".equals(action)) {   
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				String requestURL = req.getParameter("requestURL"); 
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
					Byte fnt_rent_status=new Byte(req.getParameter("fnt_rent_status").trim());
					//��ݨ��b ��a�㪬�A�������`�� ���ɪ��A�������X��!
					if(fnt_status!=0) {
						fnt_rent_status=0;
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
					String url = requestURL;
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
//			if ("compositeQuery".equals(action)) { // �Ӧ�listAllLis.jsp���ƦX�d�߽ШD
//				System.out.println("Enter compositeQuery");
//				System.out.println("�����A��");
//				try {
//					String furCatSelect=req.getParameter("furCatSelect");
//					System.out.println("���쪺furCatSelect: "+furCatSelect);
//					Integer furIteSelect=new Integer(req.getParameter("furIteSelect").trim());
//					Integer fntStatusSelect=new Integer(req.getParameter("fntStatusSelect").trim());
//					Integer rentStatusSelect=new Integer(req.getParameter("rentStatusSelect").trim());
//					System.out.println("����즹");
//					System.out.println("���쪺furCatSelect: "+furCatSelect);
//					System.out.println("���쪺furIteSelect: "+furIteSelect);
//					System.out.println("���쪺fntStatusSelect: "+fntStatusSelect);
//					System.out.println("���쪺rentStatusSelect: "+rentStatusSelect);
//					
//					/***************************�}�l�ƦX�d��***************************************/
////					FurLisService furLisSvc = new FurLisService();
////					List<FurLisVO> multiQueryList  = furLisSvc.getMultiQuery(furCatSelect,furIteSelect,fntStatusSelect,rentStatusSelect);
//					
//					/***************************�d�ߧ���,�ǳƶǫe��************/
//					
//					/***************************��L�i�઺���~�B�z**********************************/
//				} catch (Exception e) {
//				
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/back-end/furLis/listAllFurLis.jsp");
//					failureView.forward(req, res);
//				}
//			}
			
			
	}
}
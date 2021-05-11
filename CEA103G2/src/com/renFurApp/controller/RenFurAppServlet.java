package com.renFurApp.controller;

import java.io.*;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.*;
import javax.servlet.http.*;

import com.renFurApp.model.*;
import com.renFurDet.model.*;

public class RenFurAppServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		System.out.println(req.getParameter("action1"));
		System.out.println(req.getParameter("action"));
		req.setCharacterEncoding("UTF-8");
	    res.setContentType("text/html; charset=Big5");

		String action = req.getParameter("action");
		System.out.println("���i��servlet ���쪺action�Ȭ�:"+action);
		
		//String action1 = req.getParameter("action1");
		//�I���a��~���W�ٸ���ܩҿ�~���M��
//		if ("getOne_furLis".equals(action)) {
//
//			try {
//				// Retrieve form parameters.
//				String fnt_name = new String(req.getParameter("fnt_name"));
//				FurIteDAO dao = new FurIteDAO();
//				FurIteVO furIteVO = dao.findByFurName(fnt_name);
//
//				req.setAttribute("furIteVO", furIteVO); 
//
//				RequestDispatcher successView = req
//						.getRequestDispatcher("/back-end/furIte/listOneFurList.jsp");
//				successView.forward(req, res);
//				return;
//
//				// Handle any unusual exceptions
//			} catch (Exception e) {
//				throw new ServletException(e);
//			}
//		}
//		
//	//�s�W��ƶs�s��(�s�W�~���������U�@�B���s)
//		 if ("insert".equals(action)) {   
//				
//				List<String> errorMsgs = new LinkedList<String>();
//				req.setAttribute("errorMsgs", errorMsgs);
//
//				try {
//					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
//					//�a�����O���
//					Integer fnt_ctgr_no=null;
//					try {
//						fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
//					} catch (Exception e) {
//						errorMsgs.add("�п�ܮa�����O");
//					}
//					
//					//�a��W��					
//					String fnt_name = req.getParameter("fnt_name");
//					String fnt_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
//					if (fnt_name == null || fnt_name.trim().length() == 0) {
//						fnt_name ="";
//						errorMsgs.add("�a��~���W��: �ФŪť�");
//					} else if(!fnt_name.trim().matches(fnt_nameReg)) { 
//						errorMsgs.add("�a��~���W��: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��20����");
//		            }
////					//�a��Ϥ�
////					InputStream in = req.getPart("fnt_pic").getInputStream();
////					byte[] fnt_picRead = new byte[in.available()];
////					in.read(fnt_picRead);
//					
//					//�i���ƶq
//					Integer fnt_unrent = null;
//					try {
//						fnt_unrent = new Integer(req.getParameter("fnt_unrent").trim());
//					} catch (NumberFormatException e) {
//						fnt_unrent = 0;
//						errorMsgs.add("�i���ƶq�ж�Ʀr.");
//					}
//					
//					//���׼ƶq
//					Integer fnt_repair = null;
//					try {
//						fnt_repair = new Integer(req.getParameter("fnt_repair").trim());
//					} catch (NumberFormatException e) {
//						fnt_repair = 0;
//						errorMsgs.add("���׼ƶq�ж�Ʀr.");
//					}
//					
//					//�`�ƶq
//					Integer fnt_total = null;
//					try {
//						fnt_total = new Integer(req.getParameter("fnt_total").trim());
//					} catch (NumberFormatException e) {
//						fnt_total = 0;
//						errorMsgs.add("�`�ƶq�ж�Ʀr.");
//					}
//					
//					//�X������
//					Integer fnt_price = null;
//					try {
//						fnt_price = new Integer(req.getParameter("fnt_price").trim());
//					} catch (NumberFormatException e) {
//						fnt_price = 0;
//						errorMsgs.add("���׼ƶq�ж�Ʀr.");
//					}
//					//����
//					Double fnt_length = null;
//					try {
//						fnt_length = new Double(req.getParameter("fnt_length").trim());
//					} catch (NumberFormatException e) {
//						fnt_length = 0.0;
//						errorMsgs.add("���׽ж�Ʀr.");
//					}
//					//�e��
//					Double fnt_width = null;
//					try {
//						fnt_width = new Double(req.getParameter("fnt_width").trim());
//					} catch (NumberFormatException e) {
//						fnt_width = 0.0;
//						errorMsgs.add("�e�׽ж�Ʀr.");
//					}
//				
//					//����
//					Double fnt_height = null;
//					try {
//						fnt_height = new Double(req.getParameter("fnt_height").trim());
//					} catch (NumberFormatException e) {
//						fnt_height = 0.0;
//						errorMsgs.add("���׽ж�Ʀr.");
//					}
//				
//					//���q
//					Double fnt_weight = null;
//					try {
//						fnt_weight = new Double(req.getParameter("fnt_weight").trim());
//					} catch (NumberFormatException e) {
//						fnt_weight = 0.0;
//						errorMsgs.add("���q�ж�Ʀr.");
//					}
//					//�W��					
//					String fnt_standard = req.getParameter("fnt_standard");
//					String fnt_standardReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_ )( /)]{2,20}$";
//					if (fnt_standard  == null || fnt_standard.trim().length() == 0) {
//						errorMsgs.add("�a��W��: �ФŪť�");
//					} else if(!fnt_standard .trim().matches(fnt_standardReg)) { 
//						errorMsgs.add("�a��W��: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��20����");
//		            }
//					//�~������					
//					String fnt_info = req.getParameter("fnt_info");
//					if (fnt_info  == null || fnt_info.trim().length() == 0) {
//						errorMsgs.add("�~������: �ФŪť�");
//					} 
//					
//					//�s������
//					Integer fnt_views = null;
//					try {
//						fnt_views = new Integer(req.getParameter("fnt_views").trim());
//					} catch (NumberFormatException e) {
//						fnt_views = 0;
//						errorMsgs.add("�s�����ƽж�Ʀr.");
//					}
//					FurIteVO furIteVO = new FurIteVO();
//					furIteVO.setFnt_ctgr_no(fnt_ctgr_no);
//					furIteVO.setFnt_name(fnt_name);
//					furIteVO.setFnt_unrent(fnt_unrent);
//					furIteVO.setFnt_repair(fnt_repair);
//					furIteVO.setFnt_total(fnt_total);
//					furIteVO.setFnt_price(fnt_price);
//					furIteVO.setFnt_length(fnt_length);
//					furIteVO.setFnt_width(fnt_width);
//					furIteVO.setFnt_height(fnt_height);
//					furIteVO.setFnt_weight(fnt_weight);
//					furIteVO.setFnt_standard(fnt_standard);
//					furIteVO.setFnt_info(fnt_info);
//					furIteVO.setFnt_views(fnt_views);
//		
//					
//					// Send the use back to the form, if there were errors
//					if (!errorMsgs.isEmpty()) {
//						req.setAttribute("furIteVO", furIteVO); // �t����J�榡���~��furIteVO����,�]�s�Jreq
//						RequestDispatcher failureView = req
//								.getRequestDispatcher("/back-end/furIte/addFurIte.jsp");
//						failureView.forward(req, res);
//						return;
//					}
//					
//					/***************************2.�}�l�s�W���***************************************/
//					FurIteService furIteSvc = new FurIteService();
//					furIteVO = furIteSvc.addFurIte(fnt_ctgr_no,fnt_name, fnt_unrent, fnt_repair,
//							fnt_total, fnt_price, fnt_length, fnt_width, fnt_height,
//							fnt_weight, fnt_standard, fnt_info, fnt_views);
//
////	��s�W���~���s�����s�W�Ϥ���
//					Integer fnt_it_no=furIteSvc.GetLastFnt_it_no();
//					req.setAttribute("fnt_it_no", fnt_it_no);
//					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
//					String url = "/back-end/furIte/addFurItePho.jsp";
//					RequestDispatcher successView = req.getRequestDispatcher(url); // 
//					successView.forward(req, res);				
//					
//					/***************************��L�i�઺���~�B�z**********************************/
//				} catch (Exception e) {
//					errorMsgs.add(e.getMessage());
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/back-end/furIte/addFurIte.jsp");
//					failureView.forward(req, res);
//				}
//			}
//�Ӧۺ޲z������ζs�άd�ݶs
		 if ("getOne_For_Update".equals(action) || "getOne_For_Look".equals(action)) { // �Ӧ�listAllRenFurApp.jsp���ШD
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.�����ШD�Ѽ�****************************************/
					Integer rfa_no = new Integer(req.getParameter("rfa_no"));
					
					/***************************2.�}�l�d�߸��****************************************/
					RenFurAppService renFurAppSvc = new RenFurAppService();
//�Ѧ��}�l��	 �d�@��i�ӽг���Ӧslist
RenFurAppVO renFurAppVO = renFurAppSvc.getOneRenFurApp(rfa_no);
				    
//��rfa_no�d�@��i�檺�Ҧ�����
RenFurDetService renFurDetSvc = new RenFurDetService();
					List<RenFurDetVO> list = renFurDetSvc.getOneList(rfa_no);

					/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ************/
//					����listDets_by~
					req.setAttribute("listDets_ByRenFurApp", list);    // ��Ʈw���X��set����,�s�Jrequest
					
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("renFurAppVO", renFurAppVO);         // ��Ʈw���X��renFurAppVO����,�s�Jreq
					String url="";
//					�����ճ�������P�@�e�� �̫�A�����Ӷi�d�� ���Ӷi�קﭶ��
					if("getOne_For_Update".equals(action)){
						url = "/back-end/renFurApp/update_renFurApp_input.jsp";
						}
					else {
						url = "/back-end/renFurApp/listOne_renFurApp.jsp";
					}
					RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/renFurApp/listAllRenFurApp.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 
//		 
		//�ק��ƭ����s��
		 if ("update".equals(action)) {   
				System.out.println("���i��action=updation��");
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
	
//						//�����X�p
//						Integer rfa_total= new Integer(req.getParameter("rfa_total"));
//						  System.out.println("rfa_total="+rfa_total);
					  
							//�w�����
							Timestamp rfa_order_date = null;
							try {
								rfa_order_date = Timestamp.valueOf(req.getParameter("rfa_order_date").trim());
								  System.out.println("rfa_order_date="+rfa_order_date);
							} catch (IllegalArgumentException e) {
								rfa_order_date=new Timestamp(System.currentTimeMillis());
								errorMsgs.add("�п�J���!");
							}
							//�ӽг�s��
							Integer rfa_no = new Integer(req.getParameter("rfa_no"));
							  System.out.println("rfa_no="+rfa_no);
							
							
							//�ӽжi��
//							Byte rfa_status = new Byte(req.getParameter("rfa_status").trim());
//							  System.out.println("rfa_status="+rfa_status+"======");
							
					  //�|���s��
//					Integer mem_no= new Integer(req.getParameter("mem_no"));
//					  System.out.println("mem_no="+mem_no);
				
					//�ӽЮɶ�
//					Timestamp rfa_acpt_date=null; 
//					rfa_acpt_date=Timestamp.valueOf(req.getParameter("rfa_acpt_date").trim());
				
					//���u���
					Integer emp_no=null;
					Integer no_emp=0;
					try {
						emp_no = new Integer(req.getParameter("emp_no").trim());
						System.out.println(emp_no+"���O: "+emp_no.getClass());
if(emp_no==no_emp) {
System.out.println("���i����u0�P�_");
errorMsgs.add("�п�ܫ������u");
						}
					} catch (Exception e) {
						errorMsgs.add("�п�ܫ������u");
					}
				
				
					RenFurAppVO renFurAppVO = new RenFurAppVO();
					renFurAppVO.setRfa_no(rfa_no);
//					renFurAppVO.setMem_no(mem_no);
					renFurAppVO.setEmp_no(emp_no);
//					renFurAppVO.setRfa_apct_date(rfa_acpt_date);
					renFurAppVO.setRfa_order_date(rfa_order_date);
//					renFurAppVO.setRfa_total(rfa_total);
//					renFurAppVO.setRfa_status(rfa_status);
					
					
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("renFurAppVO", renFurAppVO); // �t����J�榡���~��furIteVO����,�]�s�Jreq
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/renFurApp/update_renFurApp_input.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.�}�l�s�W���***************************************/
					RenFurAppService renFurAppSvc = new RenFurAppService();
					renFurAppVO = renFurAppSvc.updateRenFurApp( rfa_no,  emp_no,  rfa_order_date);
					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
					String url = "/back-end/renFurApp/listAllRenFurApp.jsp";
					req.setAttribute("renFurAppVO", renFurAppVO);  
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);				
				
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/renFurApp/update_renFurApp_input.jsp");
					failureView.forward(req, res);
				}
			}
		 
//		 
//			if ("delete".equals(action)) { 
//
//				List<String> errorMsgs = new LinkedList<String>();
//				req.setAttribute("errorMsgs", errorMsgs);
//				String requestURL = req.getParameter("requestURL"); // �e�X�R�����ӷ��������|
//
//				try {
//					/***************************1.�����ШD�Ѽ�***************************************/
//					Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
//					
//					/***************************2.�}�l�R�����***************************************/
//					FurIteService furIteSvc = new FurIteService();
//					furIteSvc.deleteFurIte(fnt_it_no);
//					
//					/***************************3.�R������,�ǳ����(Send the Success view)***********/								
//					String url =requestURL;
//					RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
//					successView.forward(req, res);
//					
//					/***************************��L�i�઺���~�B�z**********************************/
//				} catch (Exception e) {
//					errorMsgs.add("�R����ƥ���:"+e.getMessage());
//					RequestDispatcher failureView = req
//							.getRequestDispatcher(requestURL);
//					failureView.forward(req, res);
//				}
//			}		
//		 
////�q�a�����O�d�a��~�� 
//			if ("getFurIteSelect".equals(action)) {
////				List<String> errorMsgs = new LinkedList<String>();
////				req.setAttribute("errorMsgs", errorMsgs);
//
//				try {
//					
//					/*************************** 1.�����ШD�Ѽ� ****************************************/
//					Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no"));
//					/*************************** 2.�}�l�d�߸�� ****************************************/
//					FurIteService furIteSvc = new FurIteService();
//					String  fnt_name_Str = furIteSvc.selectByPrimaryKey(fnt_ctgr_no);
//
//					/*************************** 3.�d�ߧ��� ********************************************/
//					   // ��Ʈw���X���a��~���W�٦r��Ǧ^�e��
//					PrintWriter out = res.getWriter();
//		            out.print(fnt_name_Str);
//
//					/*************************** ��L�i�઺���~�B�z ***********************************/
//				} catch (Exception e) {
//					FurIteService furIteSvc = new FurIteService();
//					String  all_fnt_name_Str = furIteSvc.getAllFntName();
//					PrintWriter out = res.getWriter();
//		            out.print(all_fnt_name_Str);
//				}
//			}
//				
	}
}
package com.furIte.controller;

import java.io.*;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.*;
import javax.servlet.http.*;
import com.furCat.model.FurCatService;
import com.furIte.model.*;
import com.furPho.model.FurPhoService;
import com.furPho.model.FurPhoVO;

public class FurIteServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
	    res.setContentType("text/html; charset=Big5");
		String action = req.getParameter("action");
		
		
		//<�e�x��>�����i���a���s������ �ҧe�{���a��(�d�N�W�U�[���A)
	 if ("listGetOnFurIteByCat".equals(action)) { // �Ӧ۫e�x�s���a��listAllFur.jsp���ШD
		
		try {
			Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
		   /***************************1.�}�l�d�ߩҥH�W�[�a����****************************************/
			FurIteService furIteSvc = new FurIteService();
			List <FurIteVO> list=furIteSvc.getGetOnFurIteByCat(fnt_ctgr_no);
							
			/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
			req.setAttribute("QueryResultList", list);         // ��Ʈw���X��empVO����,�s�Jreq
			req.setAttribute("fnt_ctgr_no", fnt_ctgr_no);         // ��Ʈw���X��empVO����,�s�Jreq
			String url = "/unprotected/furniture/listAllFur.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);

			/***************************��L�i�઺���~�B�z**********************************/
		} catch (Exception e) {
//			errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("/index.jsp");
			failureView.forward(req, res);
		}
	}
		
		//<�e�x�Ϋ�x�d�W�[�ӫ~��>�����i���a���s������ �ҧe�{���a��(�d�N�W�U�[���A)
		 if ("listAllGetOnFurIte".equals(action) || "getOnItem".equals(action)) { // �Ӧ۫e�x�s���a��listAllFur.jsp���ШD
			 String requestURL=req.getParameter("requestURL");
				try {
			     
				   /***************************1.�}�l�d�ߩҦ��W�[�a����****************************************/
					FurIteService furIteSvc = new FurIteService();
					List <FurIteVO> list=furIteSvc.getAllGetOnFurIte();
									
					/***************************2.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("QueryResultList", list);         // ��Ʈw���X��empVO����,�s�Jreq
					//�q�e�x�Ӫ��W�[�ݨD
					if(!("/back-end/furIte/listAllFurIte.jsp".equals(requestURL))) {
					String url = "/unprotected/furniture/listAllFur.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);}else{ //�q��x�Ӫ��d�W�[�ӫ~�ݨD
						String url = "/back-end/furIte/listAllFurIte.jsp";
						RequestDispatcher successView = req.getRequestDispatcher(url);
						successView.forward(req, res);
					}

					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
//					errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
					if(!("/listAllFurIte.jsp".equals(requestURL))) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
				}else {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/listAllFurIte.jsp");
					failureView.forward(req, res);
				}
			}
		 }
		 //<��x�d�U�[�ӫ~��>
		 if ("getOffItem".equals(action)) { // �Ӧ۫�x�s���a��listAllFurIte.jsp���ШD
			 List<String> errorMsgs = new LinkedList<String>();
			 try {
				 
				 /***************************1.�}�l�d�ߩҦ��W�[�a����****************************************/
				 FurIteService furIteSvc = new FurIteService();
				 List <FurIteVO> list=furIteSvc.getAllGetOffFurIte();
				 
				 /***************************2.�d�ߧ���,�ǳ����(Send the Success view)************/
				 req.setAttribute("QueryResultList", list);         // ��Ʈw���X��empVO����,�s�Jreq
				 //�q��x�Ӫ��U�[�ݨD
						 String url = "/back-end/furIte/listAllFurIte.jsp";
						 RequestDispatcher successView = req.getRequestDispatcher(url);
						 successView.forward(req, res);
				 
				 /***************************��L�i�઺���~�B�z**********************************/
			 } catch (Exception e) {
					errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
					 RequestDispatcher failureView = req
							 .getRequestDispatcher("/back-end/furIte/listAllFurIte.jsp");
					 failureView.forward(req, res);
			 }
		 }

//<�e�x��>�w�W�[�ӫ~������r�ҽk�d�� keywordSearchFromFN
		 if ("keywordSearchFromFE".equals(action)) { // �Ӧ��s���a�㭶��listAllFur.jsp���ШD
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
					String keyword = req.getParameter("keyword");
					if (keyword == null || (keyword.trim()).length() == 0) {
						errorMsgs.add("�п�J�j�M����r");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/unprotected/furniture/listAllFur.jsp");
						failureView.forward(req, res);
						return;//�{�����_
					}
				     
							/***************************2.�}�l�d�߸��****************************************/
					FurIteService furIteSvc = new FurIteService();
					List <FurIteVO> list=furIteSvc.getOneFurIteByKWtoFE(keyword);
									
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("QueryResultList", list);         // ��Ʈw���X��empVO����,�s�Jreq
					String url = "/unprotected/furniture/listAllFur.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 
		
		//����r�ҽk�d��
		 if ("keywordSearch".equals(action)) { // �Ӧ�listAllFurIte.jsp���ШD
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
					String keyword = req.getParameter("keyword");
					if (keyword == null || (keyword.trim()).length() == 0) {
						errorMsgs.add("�п�J�j�M����r");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/listAllFurIte.jsp");
						failureView.forward(req, res);
						return;//�{�����_
					}
				
				     
							/***************************2.�}�l�d�߸��****************************************/
					FurIteService furIteSvc = new FurIteService();
					List <FurIteVO> list=furIteSvc.getOneFurIteByKW(keyword);
									
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("QueryResultList", list);         // ��Ʈw���X��empVO����,�s�Jreq
					String url = "/back-end/furIte/listAllFurIte.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/listAllFurIte.jsp");
					failureView.forward(req, res);
				}
			}
		 
		
		
		//�I���a��~���W�ٸ���ܩҿ�~���M��
		if ("getOne_furLis".equals(action)) {

			try {
				// Retrieve form parameters.
				String fnt_name = new String(req.getParameter("fnt_name"));
				FurIteDAO dao = new FurIteDAO();
				FurIteVO furIteVO = dao.findByFurName(fnt_name);

				req.setAttribute("furIteVO", furIteVO); 

				RequestDispatcher successView = req
						.getRequestDispatcher("/back-end/furIte/listOneFurList.jsp");
				successView.forward(req, res);
				return;

				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
	//�s�W��ƶs�s��(�s�W�~���������U�@�B���s)
		 if ("insert".equals(action)) {   
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
					//�a�����O���
					Integer fnt_ctgr_no=null;
					try {
						fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
					} catch (Exception e) {
						errorMsgs.add("�п�ܮa�����O");
					}
					
					//�a��W��					
					String fnt_name = req.getParameter("fnt_name");
					String fnt_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
					if (fnt_name == null || fnt_name.trim().length() == 0) {
						fnt_name ="";
						errorMsgs.add("�a��~���W��: �ФŪť�");
					} else if(!fnt_name.trim().matches(fnt_nameReg)) { 
						errorMsgs.add("�a��~���W��: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��20����");
		            }
//					//�a��Ϥ�
//					InputStream in = req.getPart("fnt_pic").getInputStream();
//					byte[] fnt_picRead = new byte[in.available()];
//					in.read(fnt_picRead);
					
					//�i���ƶq
					Integer fnt_unrent = null;
					try {
						fnt_unrent = new Integer(req.getParameter("fnt_unrent").trim());
					} catch (NumberFormatException e) {
						fnt_unrent = 0;
						errorMsgs.add("�i���ƶq�ж�Ʀr.");
					}
					
					//���׼ƶq
					Integer fnt_repair = null;
					try {
						fnt_repair = new Integer(req.getParameter("fnt_repair").trim());
					} catch (NumberFormatException e) {
						fnt_repair = 0;
						errorMsgs.add("���׼ƶq�ж�Ʀr.");
					}
					
					//�`�ƶq
					Integer fnt_total = null;
					try {
						fnt_total = new Integer(req.getParameter("fnt_total").trim());
					} catch (NumberFormatException e) {
						fnt_total = 0;
						errorMsgs.add("�`�ƶq�ж�Ʀr.");
					}
					
					//�X������
					Integer fnt_price = null;
					try {
						fnt_price = new Integer(req.getParameter("fnt_price").trim());
					} catch (NumberFormatException e) {
						fnt_price = 0;
						errorMsgs.add("���׼ƶq�ж�Ʀr.");
					}
					//����
					Double fnt_length = null;
					try {
						fnt_length = new Double(req.getParameter("fnt_length").trim());
					} catch (NumberFormatException e) {
						fnt_length = 0.0;
						errorMsgs.add("���׽ж�Ʀr.");
					}
					//�e��
					Double fnt_width = null;
					try {
						fnt_width = new Double(req.getParameter("fnt_width").trim());
					} catch (NumberFormatException e) {
						fnt_width = 0.0;
						errorMsgs.add("�e�׽ж�Ʀr.");
					}
				
					//����
					Double fnt_height = null;
					try {
						fnt_height = new Double(req.getParameter("fnt_height").trim());
					} catch (NumberFormatException e) {
						fnt_height = 0.0;
						errorMsgs.add("���׽ж�Ʀr.");
					}
				
					//���q
					Double fnt_weight = null;
					try {
						fnt_weight = new Double(req.getParameter("fnt_weight").trim());
					} catch (NumberFormatException e) {
						fnt_weight = 0.0;
						errorMsgs.add("���q�ж�Ʀr.");
					}
					//�W��					
					String fnt_standard = req.getParameter("fnt_standard");
					String fnt_standardReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_ )( /)]{2,20}$";
					if (fnt_standard  == null || fnt_standard.trim().length() == 0) {
						errorMsgs.add("�a��W��: �ФŪť�");
					} else if(!fnt_standard .trim().matches(fnt_standardReg)) { 
						errorMsgs.add("�a��W��: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��20����");
		            }
					//�~������					
					String fnt_info = req.getParameter("fnt_info");
					if (fnt_info  == null || fnt_info.trim().length() == 0) {
						errorMsgs.add("�~������: �ФŪť�");
					} 
					
					//�s������
					Integer fnt_views = null;
					try {
						fnt_views = new Integer(req.getParameter("fnt_views").trim());
					} catch (NumberFormatException e) {
						fnt_views = 0;
						errorMsgs.add("�s�����ƽж�Ʀr.");
					}
					
					//�Z�n���A
					Byte fnt_post_status=null;
					try {
						fnt_post_status = new Byte(req.getParameter("fnt_post_status").trim());
					} catch (Exception e) {
						fnt_post_status='0';
						errorMsgs.add("�п�ܮa��Z�n���A");
					}
					
					FurIteVO furIteVO = new FurIteVO();
					furIteVO.setFnt_ctgr_no(fnt_ctgr_no);
					furIteVO.setFnt_name(fnt_name);
					furIteVO.setFnt_unrent(fnt_unrent);
					furIteVO.setFnt_repair(fnt_repair);
					furIteVO.setFnt_total(fnt_total);
					furIteVO.setFnt_price(fnt_price);
					furIteVO.setFnt_length(fnt_length);
					furIteVO.setFnt_width(fnt_width);
					furIteVO.setFnt_height(fnt_height);
					furIteVO.setFnt_weight(fnt_weight);
					furIteVO.setFnt_standard(fnt_standard);
					furIteVO.setFnt_info(fnt_info);
					furIteVO.setFnt_views(fnt_views);
					furIteVO.setFnt_post_status(fnt_post_status);
		
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furIteVO", furIteVO); // �t����J�榡���~��furIteVO����,�]�s�Jreq
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furIte/addFurIte.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.�}�l�s�W���***************************************/
					FurIteService furIteSvc = new FurIteService();
					furIteVO = furIteSvc.addFurIte(fnt_ctgr_no,fnt_name, fnt_unrent, fnt_repair,
							fnt_total, fnt_price, fnt_length, fnt_width, fnt_height,
							fnt_weight, fnt_standard, fnt_info, fnt_views,fnt_post_status);

//	��s�W���~���s�����s�W�Ϥ���
					Integer fnt_it_no=furIteSvc.GetLastFnt_it_no();
					req.setAttribute("fnt_it_no", fnt_it_no);
					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
					String url = "/back-end/furIte/addFurItePho.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 
					successView.forward(req, res);				
					
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/addFurIte.jsp");
					failureView.forward(req, res);
				}
			}
		//�Ӧۺ޲z�����ק�s
		 if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllFurIte.jsp���ШD

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.�����ШD�Ѽ�****************************************/
					Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
					
					/***************************2.�}�l�d�߸��****************************************/
					FurIteService furIteSvc = new FurIteService();
					FurIteVO furIteVO = furIteSvc.getOneFurIte(fnt_it_no);
									
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("furIteVO", furIteVO);         // ��Ʈw���X��empVO����,�s�Jreq
					String url = "/back-end/furIte/update_furIte_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/listAllFurIte.jsp");
					failureView.forward(req, res);
				}
			}
		 
		//�Ӧ۫e�x�a����I�J�a�㤶��
		 if ("getOneFurIteToFE".equals(action)) { // �Ӧ�listAllFurIte.jsp���ШD

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				try {
					/***************************1.�����ШD�Ѽ�****************************************/
					Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
					/***************************2.�}�l�d�߸��****************************************/
					FurIteService furIteSvc = new FurIteService();
					FurIteVO furIteVO = furIteSvc.showOneFurIteToFE(fnt_it_no);
					FurPhoService furPhoSvc=new FurPhoService();
					List<FurPhoVO> furPhoList=furPhoSvc.getOneFntItePics(fnt_it_no);
									
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("furPhoList", furPhoList);         // ��Ʈw���X��empVO����,�s�Jreq
					req.setAttribute("furIteVO", furIteVO);         // ��Ʈw���X��empVO����,�s�Jreq
					String url = "/unprotected/furniture/listOneFurIteToFE.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// ���\���ܤ��Э���
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/unprotected/furniture/listAllFur.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 
		//�ק��ƭ����s��
		 if ("update".equals(action)) {   
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
					//�a��~���s��
					Integer fnt_it_no=new Integer(req.getParameter("fnt_it_no").trim());
					//�a�����O���
					Integer fnt_ctgr_no=null;
					try {
						fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no").trim());
					} catch (Exception e) {
						errorMsgs.add("�п�ܮa�����O");
					}
					
					//�a��~���W��					
					String fnt_name = req.getParameter("fnt_name");
					String fnt_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_ )]{2,20}$";
					if (fnt_name == null || fnt_name.trim().length() == 0) {
						fnt_name ="";
						errorMsgs.add("�a��~���W��: �ФŪť�");
					} else if(!fnt_name.trim().matches(fnt_nameReg)) { 
						errorMsgs.add("�a��~���W��: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��20����");
		            }
					
					//�i���ƶq
					Integer fnt_unrent = null;
					try {
						fnt_unrent = new Integer(req.getParameter("fnt_unrent").trim());
					} catch (NumberFormatException e) {
						fnt_unrent = 0;
						errorMsgs.add("�i���ƶq�ж�Ʀr.");
					}
					
					//���׼ƶq
					Integer fnt_repair = null;
					try {
						fnt_repair = new Integer(req.getParameter("fnt_repair").trim());
					} catch (NumberFormatException e) {
						fnt_repair = 0;
						errorMsgs.add("���׼ƶq�ж�Ʀr.");
					}
					
					//�`�ƶq
					Integer fnt_total = null;
					try {
						fnt_total = new Integer(req.getParameter("fnt_total").trim());
					} catch (NumberFormatException e) {
						fnt_total = 0;
						errorMsgs.add("�`�ƶq�ж�Ʀr.");
					}
					
					//�X������
					Integer fnt_price = null;
					try {
						fnt_price = new Integer(req.getParameter("fnt_price").trim());
					} catch (NumberFormatException e) {
						fnt_price = 0;
						errorMsgs.add("���׼ƶq�ж�Ʀr.");
					}
					//����
					Double fnt_length = null;
					try {
						fnt_length = new Double(req.getParameter("fnt_length").trim());
					} catch (NumberFormatException e) {
						fnt_length = 0.0;
						errorMsgs.add("���׽ж�Ʀr.");
					}
					//�e��
					Double fnt_width = null;
					try {
						fnt_width = new Double(req.getParameter("fnt_width").trim());
					} catch (NumberFormatException e) {
						fnt_width = 0.0;
						errorMsgs.add("�e�׽ж�Ʀr.");
					}
				
					//����
					Double fnt_height = null;
					try {
						fnt_height = new Double(req.getParameter("fnt_height").trim());
					} catch (NumberFormatException e) {
						fnt_height = 0.0;
						errorMsgs.add("���׽ж�Ʀr.");
					}
				
					//���q
					Double fnt_weight = null;
					try {
						fnt_weight = new Double(req.getParameter("fnt_weight").trim());
					} catch (NumberFormatException e) {
						fnt_weight = 0.0;
						errorMsgs.add("���q�ж�Ʀr.");
					}
					//�W��					
					String fnt_standard = req.getParameter("fnt_standard");
					String fnt_standardReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_ )( /)]{2,20}$";
					if (fnt_standard  == null || fnt_standard.trim().length() == 0) {
						errorMsgs.add("�a��W��: �ФŪť�");
					} else if(!fnt_standard.trim().matches(fnt_standardReg)) { 
						errorMsgs.add("�a��W��: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��20����");
		            }
					//�~������					
					String fnt_info = req.getParameter("fnt_info");
					if (fnt_info  == null || fnt_info.trim().length() == 0) {
						errorMsgs.add("�~������: �ФŪť�");
					} 
					//�s������
					Integer fnt_views = null;
					try {
						fnt_views = new Integer(req.getParameter("fnt_views").trim());
					} catch (NumberFormatException e) {
						fnt_views = 0;
						errorMsgs.add("�s�����ƽж�Ʀr.");
					}
					
					//�Z�n���A
					Byte fnt_post_status=null;
					try {
						fnt_post_status = new Byte(req.getParameter("fnt_post_status").trim());
					} catch (Exception e) {
						fnt_post_status='0';
						errorMsgs.add("�п�ܮa��Z�n���A");
					}
					FurIteVO furIteVO = new FurIteVO();
					furIteVO.setFnt_it_no(fnt_it_no);
					furIteVO.setFnt_ctgr_no(fnt_ctgr_no);
					furIteVO.setFnt_name(fnt_name);
					furIteVO.setFnt_unrent(fnt_unrent);
					furIteVO.setFnt_repair(fnt_repair);
					furIteVO.setFnt_total(fnt_total);
					furIteVO.setFnt_price(fnt_price);
					furIteVO.setFnt_length(fnt_length);
					furIteVO.setFnt_width(fnt_width);
					furIteVO.setFnt_height(fnt_height);
					furIteVO.setFnt_weight(fnt_weight);
					furIteVO.setFnt_standard(fnt_standard);
					furIteVO.setFnt_info(fnt_info);
					furIteVO.setFnt_views(fnt_views);
					furIteVO.setFnt_post_status(fnt_post_status);
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furIteVO", furIteVO); // �t����J�榡���~��furIteVO����,�]�s�Jreq
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furIte/update_furIte_input.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.�}�l�s�W���***************************************/
					FurIteService furIteSvc = new FurIteService();
					furIteVO = furIteSvc.updateFurIte(fnt_it_no,fnt_ctgr_no,fnt_name, fnt_unrent, fnt_repair,
							fnt_total, fnt_price, fnt_length, fnt_width, fnt_height,
							fnt_weight, fnt_standard, fnt_info, fnt_views,fnt_post_status);
					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
					String url = "/back-end/furIte/listAllFurIte.jsp";
					req.setAttribute("furIteVO", furIteVO);  
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);				
				
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/update_furIte_input.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 
			if ("delete".equals(action)) { 

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				String requestURL = req.getParameter("requestURL"); // �e�X�R�����ӷ��������|

				try {
					/***************************1.�����ШD�Ѽ�***************************************/
					Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
					
					/***************************2.�}�l�R�����***************************************/
					FurIteService furIteSvc = new FurIteService();
					furIteSvc.deleteFurIte(fnt_it_no);
					
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
		 
//�q�a�����O�d�a��~�� 
			if ("getFurIteSelect".equals(action)) {
//				List<String> errorMsgs = new LinkedList<String>();
//				req.setAttribute("errorMsgs", errorMsgs);

				try {
					
					/*************************** 1.�����ШD�Ѽ� ****************************************/
					Integer fnt_ctgr_no = new Integer(req.getParameter("fnt_ctgr_no"));
					/*************************** 2.�}�l�d�߸�� ****************************************/
					FurIteService furIteSvc = new FurIteService();
					String  fnt_name_Str = furIteSvc.selectByPrimaryKey(fnt_ctgr_no);

					/*************************** 3.�d�ߧ��� ********************************************/
					   // ��Ʈw���X���a��~���W�٦r��Ǧ^�e��
					PrintWriter out = res.getWriter();
		            out.print(fnt_name_Str);

					/*************************** ��L�i�઺���~�B�z ***********************************/
				} catch (Exception e) {
					FurIteService furIteSvc = new FurIteService();
					String  all_fnt_name_Str = furIteSvc.getAllFntName();
					PrintWriter out = res.getWriter();
		            out.print(all_fnt_name_Str);
				}
			}
						
			
	}
}
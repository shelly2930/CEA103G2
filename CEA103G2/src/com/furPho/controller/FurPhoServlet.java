package com.furPho.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.furIte.model.FurIteService;
import com.furIte.model.FurIteVO;
import com.furPho.model.FurPhoService;
import com.furPho.model.FurPhoVO;

@MultipartConfig
public class FurPhoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//���Ϥ��ɦW��k
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();

		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
	    res.setContentType("text/html; charset=Big5");
	    
		String action = req.getParameter("action");
		
		//���s�W�~���U�@�B �s�W�Ӥ� �qaddFurItePho�Ӫ�
		 if ("insert_pic".equals(action)) { // �Ӧ�addFurPho.jsp���ШD  
				List<String> errorMsgs = new LinkedList<String>();

				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				//	fnt_it_no���Ӧ۷s�W�~��������(��s�W�@�����~���s��)�έ����󴫷Ӥ�������(�����^����fnt_it_no)
					System.out.println("������");
					String getFnt_it_noString=req.getParameter("fnt_it_no");
					 Integer fnt_it_no = Integer.parseInt(getFnt_it_noString); 
					
					 
					 //���յ��t�}�e����
//					 System.out.println("���ձq�t�����������Ȫ��p ������");
//						String getFnt_it_noString2=req.getParameter("fnt_it_no2");
//						System.out.println("������fnt_it_no2:"+getFnt_it_noString2+" �ڥ��S�F��???");
//						 Integer fnt_it_no2 = Integer.parseInt(getFnt_it_noString2); 
//						 System.out.println("�૬��fnt_it_no2"+fnt_it_no2);
//					-----Ū���ɮ�-----
					Collection<Part> parts = req.getParts(); 
					FurPhoService furPhoSvc = new FurPhoService();
					for (Part part : parts) {
						System.out.println("Ū�Ӥ�");
						String filename = getFileNameFromPart(part);
						//���Ӥ��W�٤~Ū
						if (filename!= null && part.getContentType()!=null) {

							// �B�~���� InputStream �P byte[] (���N��model��VO�w�@�ǳ�)
							InputStream in = part.getInputStream();
							byte[] buf = new byte[in.available()]; 
							in.read(buf);
							in.close();
							//Ū���Ϥ��� �s�W�Ӥ�
							FurPhoVO furPhoVO=new FurPhoVO();
							furPhoVO.setFnt_it_no(fnt_it_no);
							furPhoVO.setFnt_pic(buf);
							furPhoSvc.insert(furPhoVO);
						}
					}					
				
//					/***************************�s�W����,�ǳƦ^���\����***********/
					String url = "/back-end/furIte/listAllFurIte.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);								
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/addFurItePho.jsp");
					failureView.forward(req, res);
				}
			}
		
		 
			//���t�}������ �s�W�Ӥ� �q�t�}�����Ӫ�
		 if ("insert_pic_from_js".equals(action)) { // �Ӧ�addFurPho.jsp���ШD  
				List<String> errorMsgs = new LinkedList<String>();

				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				//	fnt_it_no���Ӧ۷s�W�~��������(��s�W�@�����~���s��)�έ����󴫷Ӥ�������(�����^����fnt_it_no)
					String getFnt_it_noString=req.getParameter("fnt_it_no");
					 Integer fnt_it_no = Integer.parseInt(getFnt_it_noString); 
										 
					 //���յ��t�}�e����
//					 System.out.println("���ձq�t�����������Ȫ��p ������");
//						String getFnt_it_noString2=req.getParameter("fnt_it_no2");
//						System.out.println("������fnt_it_no2:"+getFnt_it_noString2+" �ڥ��S�F��???");
//						 Integer fnt_it_no2 = Integer.parseInt(getFnt_it_noString2); 
//						 System.out.println("�૬��fnt_it_no2"+fnt_it_no2);
//					-----Ū���ɮ�-----
					Collection<Part> parts = req.getParts(); 
					FurPhoService furPhoSvc = new FurPhoService();
					for (Part part : parts) {
						String filename = getFileNameFromPart(part);
						//���Ӥ��W�٤~Ū
						if (filename!= null && part.getContentType()!=null) {

							// �B�~���� InputStream �P byte[] (���N��model��VO�w�@�ǳ�)
							InputStream in = part.getInputStream();
							byte[] buf = new byte[in.available()]; 
							in.read(buf);
							in.close();
							//Ū���Ϥ��� �s�W�Ӥ�
							FurPhoVO furPhoVO=new FurPhoVO();
							furPhoVO.setFnt_it_no(fnt_it_no);
							furPhoVO.setFnt_pic(buf);
							furPhoSvc.insert(furPhoVO);
						}
					}					
				
//					/***************************�s�W����,�ǳƦ^���\����***********/
					String url = "/back-end/furPho/listAllFurPho.jsp?fnt_it_no="+fnt_it_no;
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);								
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furIte/addFurItePho.jsp");
					failureView.forward(req, res);
				}
			}
		//���q����
//		if ("getOne_For_Display".equals(action)) { 
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
//				String str = req.getParameter("furPhono");
//
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("�п�J���u�s��");
//				}
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
//					failureView.forward(req, res);
//					return;// �{�����_
//				}
//
//				Integer furPhono = null;
//				try {
//					furPhono = new Integer(str);
//				} catch (Exception e) {
//					errorMsgs.add("���u�s���榡�����T");
//				}
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
//					failureView.forward(req, res);
//					return;// �{�����_
//				}
//
//				/*************************** 2.�}�l�d�߸�� *****************************************/
//				FurPhoService furPhoSvc = new FurPhoService();
//				FurPhoVO furPhoVO = furPhoSvc.getOneFurPho(furPhono);
//				if (furPhoVO == null) {
//					errorMsgs.add("�d�L���");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
//					failureView.forward(req, res);
//					return;// �{�����_
//				}
//
//				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) *************/
//				req.setAttribute("furPhoVO", furPhoVO); // ��Ʈw���X��empVO����,�s�Jreq
//				String url = "/back-end/furPho/listOneFurPho.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���listOneEmp.jsp
//				successView.forward(req, res);
//
//				/*************************** ��L�i�઺���~�B�z *************************************/
//			} catch (Exception e) {
//				errorMsgs.add("�L�k���o���:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
//				failureView.forward(req, res);
//			}
//		}
	

	 
		 if ("insert".equals(action)) { // �Ӧ�addFurPho.jsp���ШD  
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				byte[] fnt_picRead=null;
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
//					-----Ū���ɮ�-----
					
					InputStream in = req.getPart("fnt_pic").getInputStream();
					fnt_picRead = new byte[in.available()];
					in.read(fnt_picRead);
					if(in.available()==0) {
						errorMsgs.add("�п�ܮa��Ӥ�");
					}
//					========================================================
					FurPhoVO furPhoVO = new FurPhoVO();
					furPhoVO.setFnt_it_no(fnt_it_no);
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furPhoVO", furPhoVO);
						req.setAttribute("fnt_ctgr_no", fnt_ctgr_no);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furPho/addFurPho.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.�}�l�s�W���***************************************/
					FurPhoService furPhoSvc = new FurPhoService();
				
					furPhoVO = furPhoSvc.addFurPho(fnt_it_no,fnt_picRead);
					
					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
					String url = "/back-end/furPho/listAllFurPho.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
					successView.forward(req, res);				
					
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furPho/addFurPho.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 if ("delete".equals(action)) { 

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
				String requestURL = req.getParameter("requestURL");
				System.out.println(requestURL);
				
				try {
					/***************************1.�����ШD�Ѽ�***************************************/
					Integer fnt_pic_no = new Integer(req.getParameter("fnt_pic_no"));
					
					/***************************2.�}�l�R�����***************************************/
					FurPhoService furPhoSvc = new FurPhoService();
					FurPhoVO furPhoVO=new FurPhoVO();
					furPhoVO=furPhoSvc. getOneFurPho(fnt_pic_no);
					Integer fnt_it_no=furPhoVO.getFnt_it_no();
					furPhoSvc.deleteFurPho(fnt_pic_no);
					
					/***************************3.�R������,�ǳ����(Send the Success view)***********/
					String url = requestURL;
					RequestDispatcher successView = req.getRequestDispatcher(url+"?fnt_it_no="+fnt_it_no); // �R�����\��,���^�e�X�R�����ӷ�����
					successView.forward(req, res);
					
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�R����ƥ���:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furPho/listAllFurPho.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 if ("getOne_For_Update".equals(action)) { 

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.�����ШD�Ѽ�****************************************/
					Integer fnt_pic_no = new Integer(req.getParameter("fnt_pic_no"));
					
					/***************************2.�}�l�d�߸��****************************************/
					FurPhoService furPhoSvc = new FurPhoService();
					FurPhoVO furPhoVO = furPhoSvc.getOneFurPho(fnt_pic_no);
					FurIteService svc = new FurIteService();
					Integer ii = furPhoVO.getFnt_it_no();
					FurIteVO furIteVO = svc.getOneFurIte(ii);
					
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("furPhoVO", furPhoVO); 
					req.setAttribute("furIteVO", furIteVO); 
					String url = "/back-end/furPho/update_FurPho_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���update_emp_input.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z************************************/
				} catch (Exception e) {
					errorMsgs.add("�ק��ƨ��X�ɥ���:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furPho/listAllFurPho.jsp");
					failureView.forward(req, res);
				}
			}
		 
		 if ("update".equals(action)) { // �Ӧ�update_emp_input.jsp���ШD
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				byte[] fnt_picRead=null;
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
					Integer fnt_pic_no = new Integer(req.getParameter("fnt_pic_no"));
					Integer fnt_it_no = new Integer(req.getParameter("fnt_it_no"));
//					-----Ū���Ӥ��ɮ�-----
					
					InputStream in = req.getPart("fnt_pic").getInputStream();
					fnt_picRead = new byte[in.available()];
					
					if(in.available()==0) {
						FurPhoService furPhoSvc=new FurPhoService();
						FurPhoVO furPhoVO=furPhoSvc.getOneFurPho(fnt_pic_no);
						fnt_picRead=furPhoVO.getFnt_pic();
						//�����Ʈw
					}
					in.read(fnt_picRead);
					in.close();
//					========================================================
					FurPhoVO furPhoVO = new FurPhoVO();
					furPhoVO.setFnt_pic_no(fnt_pic_no);
					furPhoVO.setFnt_it_no(fnt_it_no);
					furPhoVO.setFnt_pic(fnt_picRead);
					
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("furPhoVO", furPhoVO); 
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/furPho/update_FurPho_input.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.�}�l�s�W���***************************************/
					FurPhoService furPhoSvc = new FurPhoService();			
					furPhoVO = furPhoSvc.updateFurPho(fnt_pic_no,fnt_it_no,fnt_picRead);
					
					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
					String url = "/back-end/furPho/listAllFurPho.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
					successView.forward(req, res);				
					
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/furPho/update_FurPho_input.jsp");
					failureView.forward(req, res);
				}
		 }
	}



	
}

package com.houPho.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.houPho.model.HouPhoService;
import com.houPho.model.HouPhoVO;
import com.house.model.HouseService;
@MultipartConfig
public class HouPhoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
//�S�� �ݧR
		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> ErrorMessage = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("ErrorMessage", ErrorMessage);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				String str = req.getParameter("houPhono");
				//null�O�קK�u�{�v�����r�A���b��
//				�S����J����
				if (str == null || (str.trim()).length() == 0) {
					ErrorMessage.add("�п�J���u�s��");
				}
				if (!ErrorMessage.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}
//				�S����J�Ʀr����
				Integer houPhono = null;
				try {
					houPhono = new Integer(str);
				} catch (Exception e) {
					ErrorMessage.add("���u�s���榡�����T");
				}
				if (!ErrorMessage.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/*************************** 2.�}�l�d�߸�� *****************************************/
				HouPhoService houPhoSvc = new HouPhoService();
				HouPhoVO houPhoVO = houPhoSvc.getOneHouPho(houPhono);
				if (houPhoVO == null) {
					ErrorMessage.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!ErrorMessage.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) *************/
				req.setAttribute("houPhoVO", houPhoVO); // ��Ʈw���X��empVO����,�s�Jreq
				String url = "/front-end/houPho/listOneHouPho.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���listOneEmp.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z *************************************/
			} catch (Exception e) {
				ErrorMessage.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/select_HousePhoto.jsp");
				failureView.forward(req, res);
			}
		}
/********�s�W�h�i�Ӥ�*******************/		
		 if ("insert".equals(action)) { // �Ӧ�addHouPho.jsp���ШD  
			 List<String> ErrorMessage = new LinkedList<String>();	
			 req.setAttribute("ErrorMessage", ErrorMessage);
				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
					Integer houseno = new Integer(req.getParameter("houseno").trim());
//					===================Ū�ɮ�================================
//					InputStream in = req.getPart("hos_pic").getInputStream();
//					if(in.available()==0) {
//						System.out.println("HouPhoServlet�ɮ׿��~");
//					}
//					byte[] hos_picBuf = new byte[in.available()];
					
//					in.read(buf) �Obuf�o�}�C��inputstream���ƪ��
//					�ҤU�����槹�Abuf�w�g�t����ƤF
//					in.read(hos_picBuf);
//					========================================================
					HouPhoService houPhoSvc = new HouPhoService();
					Collection<Part> parts = req.getParts();
					InputStream in =null;
					byte[] hos_picBuf =null;
					int count = 0;
					for(Part part : parts) {
						if(!"hos_pic".equals(part.getName()))continue;
						in = part.getInputStream();
						if(in.available()==0) continue;
						hos_picBuf = new byte[in.available()];
						in.read(hos_picBuf);
						count++;
						houPhoSvc.addHouPho(houseno,hos_picBuf);
					}
					if(count==0) ErrorMessage.add("�S������n�R�����Ϥ���!!!");
					else req.removeAttribute("ErrorMessage");
					//========================================================
					/***************************2.�}�l�s�W���***************************************/
					
					HouseService houseSvc = new HouseService();
					Set<HouPhoVO> set = houseSvc.getHouPhoByHouse(houseno);
					req.setAttribute("listHouPho_ByHouseNo",set);
					
					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
					String url = "/back-end/houPho/listHouPhoEmp.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
					successView.forward(req, res);				
					
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					ErrorMessage.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/houPho/addHouPho.jsp");
					failureView.forward(req, res);
				}
			}
/********�R���h�i�Ӥ�*******************/			 
		 if ("delete".equals(action)) { // �Ӧ�listAllEmp.jsp ��  /dept/listEmps_ByDeptno.jsp���ШD

				List<String> ErrorMessage = new LinkedList<String>();
				req.setAttribute("ErrorMessage", ErrorMessage);
				RequestDispatcher successView = null;
				try {
					Integer houseno = new Integer(req.getParameter("houseno"));
					String[] deleteHousePic_array =null;
					HouPhoService houPhoSvc = new HouPhoService();
					if(req.getParameterValues("pickHousePic")!=null) {
						deleteHousePic_array= req.getParameterValues("pickHousePic");
						for(String pic_no:deleteHousePic_array) {
							houPhoSvc.deleteHouPho(new Integer(pic_no));
						}
						req.removeAttribute("ErrorMessage");
					}else {
						ErrorMessage.add("�S������Ӥ�!");
					}
					HouseService houseSvc =new  HouseService();
					Set<HouPhoVO> set = houseSvc.getHouPhoByHouse(houseno);
					req.setAttribute("listHouPho_ByHouseNo", set);
					
					String url = "/back-end/houPho/listHouPhoEmp.jsp";
					successView= req.getRequestDispatcher(url); // �R�����\��,���^�e�X�R�����ӷ�����
					successView.forward(req, res);
				} catch (Exception e) {
					ErrorMessage.add("�R����ƥ���:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/houPho/listHouPhoEmp.jsp");
					failureView.forward(req, res);
				}
			}
//�ݧR		 
		 if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllEmp.jsp ��  /dept/listEmps_ByDeptno.jsp ���ШD

				List<String> ErrorMessage = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("ErrorMessage", ErrorMessage);
				
				String requestURL = req.getParameter("requestURL"); // �e�X�ק諸�ӷ��������|: �i�ର�i/emp/listAllEmp.jsp�j ��  �i/dept/listEmps_ByDeptno.jsp�j �� �i /dept/listAllDept.jsp�j		
				
				try {
					/***************************1.�����ШD�Ѽ�****************************************/
					Integer houPhono = new Integer(req.getParameter("houPhono"));
					
					/***************************2.�}�l�d�߸��****************************************/
					HouPhoService houPhoSvc = new HouPhoService();
					HouPhoVO houPhoVO = houPhoSvc.getOneHouPho(houPhono);
									
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("houPhoVO", houPhoVO); // ��Ʈw���X��empVO����,�s�Jreq
					String url = "/front-end/houPho/update_HouPho_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���update_emp_input.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z************************************/
				} catch (Exception e) {
					ErrorMessage.add("�ק��ƨ��X�ɥ���:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
				}
			}
/********���h�i�Ӥ��Ӥ�*******************/		 
		 if ("getMoreForUpdate".equals(action)||"updateMoreHouPho".equals(action)) { // �Ӧ�update_emp_input.jsp���ШD
				List<String> ErrorMessage = new LinkedList<String>();
				try {
					/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
					Integer houseno = new Integer(req.getParameter("houseno"));
					HouseService houseSvc =new  HouseService();
					Set<HouPhoVO> set = houseSvc.getHouPhoByHouse(houseno);
					req.setAttribute("listHouPho_ByHouseNo", set); //�L�h�^�ӳ��nsetet
					
					String[] updateHouPho_array = null;
					if("getMoreForUpdate".equals(action)) {
						updateHouPho_array = req.getParameterValues("pickHousePic");
						System.out.println(updateHouPho_array);
						if(req.getParameterValues("pickHousePic")==null) {
							ErrorMessage.add("�A�S����Ϥ�");
							req.setAttribute("ErrorMessage",ErrorMessage);
							RequestDispatcher successView = req.getRequestDispatcher("/back-end/houPho/listHouPhoEmp.jsp");   // �ק令�\��,���^�e�X�ק諸�ӷ�����
							successView.forward(req, res);
							return;
						}
					}else {
						HouPhoService houPhoSvc =  new HouPhoService();
						InputStream in = null;
						Collection<Part> parts = req.getParts();
						for(Part part : parts) {
							if("action".equals(part.getName()) || "houseno".equals(part.getName())) continue;
							in = part.getInputStream();
							byte[] hos_pic = new byte[in.available()];
							if(in.available()!=0) {
								in.read(hos_pic);
								houPhoSvc.updateHouPho(Integer.parseInt(part.getName()), houseno , hos_pic);
							}
						}
					}
					/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/	
					String url = null;
					if("getMoreForUpdate".equals(action)) {
						url="/back-end/houPho/updateHouPhoInput.jsp";
					}else {
						url="/back-end/houPho/listHouPhoEmp.jsp";
					}
					RequestDispatcher successView = req.getRequestDispatcher(url);   // �ק令�\��,���^�e�X�ק諸�ӷ�����
					successView.forward(req, res);
					/***************************��L�i�઺���~�B�z*************************************/
				} catch (Exception e) {
					ErrorMessage.add("�ק磌��Ӥ�����:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/error.jsp");
					failureView.forward(req, res);
				}
			}
	}

}

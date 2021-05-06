package com.post.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.post.model.*;

public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String status = req.getParameter("status");

		// ��x�I�����i���D�d�ݤ���
		if ("getOneBackPost".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� ****************************************/
				String post_no = req.getParameter("post_no");

				/*************************** 2.�}�l�d�߸�� ****************************************/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePostShow(new Integer(post_no));
				req.setAttribute("postVO", postVO);
				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ************/
				String url = "/back-end/post/listOnePost.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/post/listAllPost.jsp");
				failureView.forward(req, res);
			}
		}

		// �ڷQ�n����listOneContent
		if ("GoToOneContent".equals(action)) { // �Ӧ�listAllEmp.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� ****************************************/
				String post_no = req.getParameter("post_no");

				/*************************** 2.�}�l�d�߸�� ****************************************/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePostShow(new Integer(post_no));
				req.setAttribute("postVO", postVO);
				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ************/
				String url = "/unprotected/post/listOneContent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/post/listAllPost.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				String str = req.getParameter("post_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J���i�s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/indexBack.jsp");
					failureView.forward(req, res);
					return;// �{�����_/back-end/indexBack.jsp
				}

				Integer post_no = null;
				try {
					post_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("���u�s���榡�����T");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/indexBack.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/*************************** 2.�}�l�d�߸�� *****************************************/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePostShow(post_no);
				if (postVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/indexBack.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) *************/
				req.setAttribute("postVO", postVO); // ��Ʈw���X��empVO����,�s�Jreq
				String url = "/back-end/post/listOnePost.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z *************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/indexBack.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllPost.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� ****************************************/
				Integer post_no = new Integer(req.getParameter("post_no"));

				/*************************** 2.�}�l�d�߸�� ****************************************/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePost(post_no);

				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ************/
				req.setAttribute("postVO", postVO); // ��Ʈw���X��empVO����,�s�Jreq
				String url = "/back-end/post/update_post_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				System.out.println("ppppp");
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/post/listAllPost.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // update_post���e�X�ɷ|����L������
			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				Integer post_no = new Integer(req.getParameter("post_no").trim());

				java.sql.Timestamp post_time = null;
				post_time = new java.sql.Timestamp(System.currentTimeMillis());

				String post_title = req.getParameter("post_title").trim();
				if (post_title == null || post_title.trim().length() == 0) {
					errorMsgs.add("�ФŪť�");
				}

				String post_content = req.getParameter("post_content").trim();
				if (post_content == null || post_content.trim().length() == 0) {
					errorMsgs.add("���i����ФŪť�");
				}

				Byte post_status = Byte.valueOf(req.getParameter("post_status"));

				PostVO postVO = new PostVO();
				postVO.setPost_no(post_no);
				postVO.setPost_title(post_title);
				postVO.setPost_content(post_content);
				postVO.setPost_status(post_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("postVO", postVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/post/update_post_input.jsp");
					failureView.forward(req, res);
					return; // �{�����_
				}

				/*************************** 2.�}�l�ק��� *****************************************/
				PostService postSvc = new PostService();
				postVO = postSvc.updatePost(post_no, post_time, post_title, post_content, post_status);

				/*************************** 3.�ק粒��,�ǳ����(Send the Success view) *************/
				req.setAttribute("postVO", postVO);
//				String url = "/back-end/post/select_page.jsp";
				String url = "/post/post.do?action=listAll&status=0";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z *************************************/
			} catch (Exception e) {
				errorMsgs.add("�ק��ƥ���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/indexBack.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String post_title = req.getParameter("post_title");

				if (post_title == null || post_title.trim().length() == 0) {
					errorMsgs.add("���i���D: �ФŪť�");
				}

				String post_content = req.getParameter("post_content").trim();
				if (post_content == null || post_content.trim().length() == 0) {
					errorMsgs.add("���i����ФŪť�");
				}

				Byte post_status = Byte.valueOf(req.getParameter("post_status"));

				PostVO postVO = new PostVO();
				postVO.setPost_title(post_title);
				postVO.setPost_content(post_content);
				postVO.setPost_status(post_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("postVO", postVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					System.out.println("DDDD");
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/post/addPost.jsp");
					failureView.forward(req, res);
					return;
				}

				PostService postSvc = new PostService();
				postVO = postSvc.addPost(post_title, post_content, post_status);

				String url = "/post/post.do?action=listAll&status=0";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				System.out.println("DDD");
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/indexBack.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // �Ӧ�listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� ***************************************/
				Integer post_no = new Integer(req.getParameter("post_no"));

				/*************************** 2.�}�l�R����� ***************************************/
				PostService postSvc = new PostService();
				postSvc.deletePost(post_no);

				/*************************** 3.�R������,�ǳ����(Send the Success view) ***********/
				String url = "/post/post.do?action=listAll&status=0";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/post/listAllPost.jsp");
				failureView.forward(req, res);
			}
		}
		if ("listAll".equals(action)) {
			/*************************** �}�l�d�߸�� ****************************************/
			List<PostVO> list = new LinkedList<PostVO>();
			PostService postSvc = new PostService();
			if ("0".equals(status)) {
				list = postSvc.getAllDesc();
				System.out.println("xxxxxxx");
			} else {
				list = postSvc.getAllAsc();
				System.out.println("aaaaa");
			}

			req.setAttribute("list", list);
			String url = "/back-end/post/listAllPost.jsp";
//			String url = "/back-end/post/TestPost.jsp";
			System.out.println("HI COMING");
			RequestDispatcher successView = req.getRequestDispatcher(url); // ���listAllEmp.jsp
			successView.forward(req, res);

		}

		if ("listAllFront".equals(action)) {
			/*************************** �}�l�d�߸�� ****************************************/
			List<PostVO> list = new LinkedList<PostVO>();
			PostService postSvc = new PostService();
			if ("0".equals(status)) {
				list = postSvc.getAllFront();
			} else {
				list = postSvc.getAllFrontAsc();
			}

			req.setAttribute("list", list);
			String url = "/unprotected/post/listAllPost.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // ���listAllEmp.jsp
			successView.forward(req, res);

		}

	}
}

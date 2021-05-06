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

		// 後台點擊公告標題查看內文
		if ("getOneBackPost".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String post_no = req.getParameter("post_no");

				/*************************** 2.開始查詢資料 ****************************************/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePostShow(new Integer(post_no));
				req.setAttribute("postVO", postVO);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/back-end/post/listOnePost.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/post/listAllPost.jsp");
				failureView.forward(req, res);
			}
		}

		// 我想要跳到listOneContent
		if ("GoToOneContent".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String post_no = req.getParameter("post_no");

				/*************************** 2.開始查詢資料 ****************************************/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePostShow(new Integer(post_no));
				req.setAttribute("postVO", postVO);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/unprotected/post/listOneContent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/unprotected/post/listAllPost.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("post_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入公告編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/indexBack.jsp");
					failureView.forward(req, res);
					return;// 程式中斷/back-end/indexBack.jsp
				}

				Integer post_no = null;
				try {
					post_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/indexBack.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePostShow(post_no);
				if (postVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/indexBack.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("postVO", postVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/post/listOnePost.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/indexBack.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllPost.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer post_no = new Integer(req.getParameter("post_no"));

				/*************************** 2.開始查詢資料 ****************************************/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePost(post_no);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("postVO", postVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/post/update_post_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				System.out.println("ppppp");
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/post/listAllPost.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // update_post按送出時會跳轉過來驗證
			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer post_no = new Integer(req.getParameter("post_no").trim());

				java.sql.Timestamp post_time = null;
				post_time = new java.sql.Timestamp(System.currentTimeMillis());

				String post_title = req.getParameter("post_title").trim();
				if (post_title == null || post_title.trim().length() == 0) {
					errorMsgs.add("請勿空白");
				}

				String post_content = req.getParameter("post_content").trim();
				if (post_content == null || post_content.trim().length() == 0) {
					errorMsgs.add("公告內文請勿空白");
				}

				Byte post_status = Byte.valueOf(req.getParameter("post_status"));

				PostVO postVO = new PostVO();
				postVO.setPost_no(post_no);
				postVO.setPost_title(post_title);
				postVO.setPost_content(post_content);
				postVO.setPost_status(post_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("postVO", postVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/post/update_post_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				PostService postSvc = new PostService();
				postVO = postSvc.updatePost(post_no, post_time, post_title, post_content, post_status);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("postVO", postVO);
//				String url = "/back-end/post/select_page.jsp";
				String url = "/post/post.do?action=listAll&status=0";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
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
					errorMsgs.add("公告標題: 請勿空白");
				}

				String post_content = req.getParameter("post_content").trim();
				if (post_content == null || post_content.trim().length() == 0) {
					errorMsgs.add("公告內文請勿空白");
				}

				Byte post_status = Byte.valueOf(req.getParameter("post_status"));

				PostVO postVO = new PostVO();
				postVO.setPost_title(post_title);
				postVO.setPost_content(post_content);
				postVO.setPost_status(post_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("postVO", postVO); // 含有輸入格式錯誤的empVO物件,也存入req
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

		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer post_no = new Integer(req.getParameter("post_no"));

				/*************************** 2.開始刪除資料 ***************************************/
				PostService postSvc = new PostService();
				postSvc.deletePost(post_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/post/post.do?action=listAll&status=0";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/post/listAllPost.jsp");
				failureView.forward(req, res);
			}
		}
		if ("listAll".equals(action)) {
			/*************************** 開始查詢資料 ****************************************/
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
			RequestDispatcher successView = req.getRequestDispatcher(url); // 轉交listAllEmp.jsp
			successView.forward(req, res);

		}

		if ("listAllFront".equals(action)) {
			/*************************** 開始查詢資料 ****************************************/
			List<PostVO> list = new LinkedList<PostVO>();
			PostService postSvc = new PostService();
			if ("0".equals(status)) {
				list = postSvc.getAllFront();
			} else {
				list = postSvc.getAllFrontAsc();
			}

			req.setAttribute("list", list);
			String url = "/unprotected/post/listAllPost.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 轉交listAllEmp.jsp
			successView.forward(req, res);

		}

	}
}

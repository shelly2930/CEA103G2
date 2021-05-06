<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.post.model.*"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="BIG5">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>後台空頁</title>

<!-- Custom fonts for this template-->
<link
	href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link
	href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css"
	rel="stylesheet">

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/back-end/includeFile/sidebarBack.file"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<%@ include file="/back-end/includeFile/topbarBack.file"%>

				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
				<%
					PostVO postVO = (PostVO) request.getAttribute("postVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
				%>
				<div class="container-fluid"></div>
				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>

				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/post/post.do" name="form1">
					<table>
						<tr>
							<td>公告編號:<font color=red><b></b></font></td>
							<td><%=postVO.getPost_no()%></td>
						</tr>
						<tr>
							<td>公告時間:</td>
							<td><fmt:formatDate value="${postVO.post_time}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
						</tr>
						<tr>
							<td>公告標題:</td>
							<td><input type="TEXT" name="post_title" size="45"
								value="<%=postVO.getPost_title()%>" /></td>
						</tr>
						<tr>
							<td>公告內容:</td>
							<td><textarea rows="5" cols="50" name="post_content"><%=(postVO == null) ? "請輸入公告內容" : postVO.getPost_content()%></textarea></td>
						</tr>
						<tr>
							<td>公告狀態:</td>
							<td><select name="post_status">
									<option value="0">下架</option>
									<option value="1">上架</option>
							</select></td>
						</tr>

						<jsp:useBean id="postSvc" scope="page"
							class="com.post.model.PostService" />


					</table>
					<br> <input type="hidden" name="action" value="update">
					<input type="hidden" name="post_no"
						value="<%=postVO.getPost_no()%>"> <input type="submit"
						value="送出修改">
				</FORM>



				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<%@ include file="/back-end/includeFile/footerBack.file"%>

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<%@ include file="/back-end/includeFile/otherBack.file"%>

	<!-- Bootstrap core JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>

</body>

</html>
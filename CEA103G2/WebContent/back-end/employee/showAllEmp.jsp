<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.employee.model.*"%>

<%
	EmployeeService employeeSvc = new EmployeeService();
	List<EmployeeVO> list = employeeSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>所有員工</title>

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
	
<!-- Custom styles for this page -->
<link
	href="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/back-end/includeFile/sidebarBack.file" %>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<%@ include file="/back-end/includeFile/topbarBack.file" %>

				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">Tables</h1>
					<p class="mb-4">
						DataTables is a third party plugin that is used to generate the
						demo table below. For more information about DataTables, please
						visit the <a target="_blank" href="https://datatables.net">official
							DataTables documentation</a>.
					</p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">DataTables
								Example</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>員工編號</th>
											<th>員工代號</th>
											<th>姓名</th>
											<th>性別</th>
											<th>行動電話</th>
											<th>職位</th>
											<th>薪資</th>
											<th>獎金</th>
											<th>到職日</th>
											<th>修改</th>
											<th>刪除</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="employeeVO" items="${list}">

											<tr>
												<td>${employeeVO.emp_no}</td>
												<td>${employeeVO.emp_username}</td>
												<td>${employeeVO.emp_name}</td>
												<c:choose>
													<c:when test="${employeeVO.emp_gender == 0}">
														<td></td>
													</c:when>
													<c:when test="${employeeVO.emp_gender == 1}">
														<td>男</td>
													</c:when>
													<c:when test="${employeeVO.emp_gender == 2}">
														<td>女</td>
													</c:when>
												</c:choose>
												<td>${employeeVO.emp_mobile}</td>
												<td>${employeeVO.emp_job}</td>
												<td>${employeeVO.emp_sal}</td>
												<td>${employeeVO.emp_bonus}</td>
												<td>${employeeVO.emp_hiredate}</td>
												<%-- 			<td><fmt:formatDate value="${employeeVO.hiredate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> 可更改時間顯示樣式 --%>

												<td align="center">
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/employee/employee.do"
														style="margin-bottom: 0px;">
														<button type="submit" class="btn btn-outline-info">修改</button>
														<input type="hidden" name="emp_no" value="${employeeVO.emp_no}">
														<input type="hidden" name="action" value="getOne_For_Update">
													</FORM>
												</td>
												<td align="center">
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/employee/employee.do"
														style="margin-bottom: 0px;">
														<button type="submit" class="btn btn-outline-danger">刪除</button>
														<input type="hidden" name="emp_no" value="${employeeVO.emp_no}">
														<input type="hidden" name="action" value="delete">
													</FORM>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<%@ include file="/back-end/includeFile/footerBack.file" %>

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<%@ include file="/back-end/includeFile/otherBack.file" %>

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
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/datatables-demo.js"></script>

</body>

</html>
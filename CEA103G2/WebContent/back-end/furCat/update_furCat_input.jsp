<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furCat.model.*"%>
<%
	FurCatVO furCatVO = (FurCatVO) request.getAttribute("furCatVO");
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

<title>�a�����O��ƽs��</title>

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

				<!--�@�@�@�����������������������e���������������������@�@�@-->
				<div class="container-fluid">

					<div class="container-fluid">

						<!-- Page Heading -->
						<h1 class="h3 mb-2 text-gray-800">�a�����O��ƽs��</h1>

						<!-- DataTales Example -->
						<div class="card shadow mb-4">
<!-- 							<div class="card-header py-3"> -->
<!-- 								                 ������       ���s�� �j�M�C�\���m�������� -->

<%-- 								<a href="<%=request.getContextPath()%>/back-end/furCat/listAllFurCat.jsp" --%>
<!-- 									class="btn btn-warning btn-icon-split"> <span class="text">��^���O�޲z</span> -->
<!-- 								</a> -->

<!-- 								                 ������       ���s�� �j�M�C�\���m�������� -->
<!-- 							</div> -->
							<div class="card-body">
								<div class="table-responsive">
									<%-- ���~��C --%>
									<c:if test="${not empty errorMsgs}">
										<font style="color: red">�Эץ��H�U���~:</font>
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color: red">${message}</li>
											</c:forEach>
										</ul>
									</c:if>
									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/furCat/furCat.do"
										name="form1">
										<div class="col-lg-12">
										<table class="table table-bordered" id="dataTable"
											width="100%" cellspacing="0">
											<!--                  ������       ����\���m�������� -->
											       <div class="col-lg-6">
                            <!-- ��r��� -->
                            <h6 class="font-weight-bold pt-4 pb-1">�a�����O�s�� : ${furCatVO.fnt_ctgr_no}</h6>
                            <h6 class="font-weight-bold pt-4 pb-1">�a�����O�W��:</h6>
                            <input type="text" class="border w-100 p-2 bg-white text-capitalize"  name="fnt_ctgr_name" size="45"
													value="<%=(furCatVO == null) ? "" : furCatVO.getFnt_ctgr_name()%>">
											      </div>
											      
											<!--                  ������       ����\���m�������� -->

										</table>
										 </div>
										 <div class="col-lg-12">
										 <div class="col-lg-10">
										 <a href="<%=request.getContextPath()%>/back-end/furCat/listAllFurCat.jsp"
									class="btn btn-light btn-icon-split"  style="background-color:#F5E5AE">
                                     
                                        <span class="text">��^�W��</span>
                                    </a>
										<input type="hidden" name="action" value="update">
											<input type="hidden" name="fnt_ctgr_no" value="<%=furCatVO.getFnt_ctgr_no()%>">
										<button	class="btn btn-info btn-icon-split" type="submit"> <span class="text">�T�w�e�X</span></button>
								</div>
								</div>
									</FORM>
								</div>
							</div>
						</div>

					</div>
					<!-- /.container-fluid -->

				</div>
				<!--�@�@�@�����������������������e���������������������@�@�@-->

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
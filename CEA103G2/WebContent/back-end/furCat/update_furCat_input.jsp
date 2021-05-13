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

<title>家具類別資料編輯</title>

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
				<div class="container-fluid">

					<div class="container-fluid">

						<!-- Page Heading -->
						<h1 class="h3 mb-2 text-gray-800">家具類別資料編輯</h1>

						<!-- DataTales Example -->
						<div class="card shadow mb-4">
<!-- 							<div class="card-header py-3"> -->
<!-- 								                 ↓↓↓       按鈕區 搜尋列擺放位置↓↓↓↓ -->

<%-- 								<a href="<%=request.getContextPath()%>/back-end/furCat/listAllFurCat.jsp" --%>
<!-- 									class="btn btn-warning btn-icon-split"> <span class="text">返回類別管理</span> -->
<!-- 								</a> -->

<!-- 								                 ↑↑↑       按鈕區 搜尋列擺放位置↑↑↑↑ -->
<!-- 							</div> -->
							<div class="card-body">
								<div class="table-responsive">
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
										ACTION="<%=request.getContextPath()%>/furCat/furCat.do"
										name="form1">
										<div class="col-lg-12">
										<table class="table table-bordered" id="dataTable"
											width="100%" cellspacing="0">
											<!--                  ↓↓↓       表單擺放位置↓↓↓↓ -->
											       <div class="col-lg-6">
                            <!-- 文字方塊 -->
                            <h6 class="font-weight-bold pt-4 pb-1">家具類別編號 : ${furCatVO.fnt_ctgr_no}</h6>
                            <h6 class="font-weight-bold pt-4 pb-1">家具類別名稱:</h6>
                            <input type="text" class="border w-100 p-2 bg-white text-capitalize"  name="fnt_ctgr_name" size="45"
													value="<%=(furCatVO == null) ? "" : furCatVO.getFnt_ctgr_name()%>">
											      </div>
											      
											<!--                  ↑↑↑       表單擺放位置↑↑↑↑ -->

										</table>
										 </div>
										 <div class="col-lg-12">
										 <div class="col-lg-10">
										 <a href="<%=request.getContextPath()%>/back-end/furCat/listAllFurCat.jsp"
									class="btn btn-light btn-icon-split"  style="background-color:#F5E5AE">
                                     
                                        <span class="text">返回上頁</span>
                                    </a>
										<input type="hidden" name="action" value="update">
											<input type="hidden" name="fnt_ctgr_no" value="<%=furCatVO.getFnt_ctgr_no()%>">
										<button	class="btn btn-info btn-icon-split" type="submit"> <span class="text">確定送出</span></button>
								</div>
								</div>
									</FORM>
								</div>
							</div>
						</div>

					</div>
					<!-- /.container-fluid -->

				</div>
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
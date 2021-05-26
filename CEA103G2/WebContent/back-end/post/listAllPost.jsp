<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>公告總覽</title>

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
<style>
.card {
    z-index: 99999;
}
.topbar .dropdown .dropdown-menu {
	z-index: 999999;
}
</style>
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


				<!-- Begin Page Content -->
				<div class="container-fluid">


					<!-- DataTales Example -->
					<div class="card shadow mb-4">

						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>公告編號</th>
											<th><div id="desc">
													<a
														href="<%=request.getContextPath()%>/post/post.do?action=listAll&status=0">公告日期<i
														class="fas fa-sort-up"></i>
													</a>
												</div>
												<div id="asc">
													<a
														href="<%=request.getContextPath()%>/post/post.do?action=listAll&status=1">公告日期<i
														class="fas fa-sort-down"></i>
													</a>
												</div></th>
											<th>公告標題</th>
											<th>公告狀態</th>
											<th>修改</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>公告編號</th>
											<th>公告日期</th>
											<th>公告標題</th>
											<th>公告狀態</th>
											<th>修改</th>
										</tr>
									</tfoot>
									<%
										List<PostVO> list = (ArrayList<PostVO>) (request.getAttribute("list"));
									%>

									<tbody>
										<%@ include file="page1.file"%>
										<c:forEach var="postVO" items="${list}" begin="<%=pageIndex%>"
											end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">
											<tr>
												<td>${postVO.post_no}</td>
												<td><fmt:formatDate value="${postVO.post_time}"
														pattern="yyyy-MM-dd HH:mm:ss" /></td>
												<td scope="col" colspan="1"><a
													href="javascript:presses${s.count}()">${postVO.post_title}</a></td>
												<td><c:choose>
														<c:when test="${postVO.post_status==0}">下架</c:when>
														<c:when test="${postVO.post_status==1}">上架</c:when>
														<c:when test="${postVO.post_status==2}">錯誤</c:when>
													</c:choose></td>
												<td>
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/post/post.do"
														style="margin-bottom: 0px;">
														<input type="submit" value="修改"> <input
															type="hidden" name="post_no" value="${postVO.post_no}">
														<input type="hidden" name="action"
															value="getOne_For_Update">
													</FORM>
												</td>
											</tr>
											<script>
       				  							function presses${s.count}(){
        	 										document.open("<%=request.getContextPath()%>/post/post.do?action=getOneBackPost&post_no=${postVO.post_no}", "" ,"height=350,width=650,left=65,top=157,resizable=yes,scrollbars=yes");
        										 }
											</script>
										</c:forEach>
									</tbody>
								</table>
								<%@ include file="page2.file"%>
							</div>
						</div>
					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->



		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	</a>
	<!-- Footer -->
	<%@ include file="/back-end/includeFile/footerBack.file"%>
	</div>
	<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<jsp:include page="/back-end/includeFile/otherBack.file"></jsp:include>

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
	<!-- Page level plugins -->
	<!-- 	<script -->
	<%-- 		src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/jquery.dataTables.min.js"></script> --%>
	<!-- 	<script -->
	<%-- 		src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.js"></script> --%>
	<!-- 	<script -->
	<%-- 		src="<%=request.getContextPath()%>/template_back-end/js/demo/datatables-demo.js"></script> --%>
	<script>
$(function(){
        if(${param.status}==0){
            $("#desc").hide();
        }else{
            $("#asc").hide();
        }
    })
</script>

</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.lanlord.model.*"%>

<%
    LanlordService lanlordSvc = new LanlordService();
	List<LanlordVO> list = lanlordSvc.getAll();
	pageContext.setAttribute("list",list);
%>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>�ЪF���</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

	<!-- Custom styles for this page -->
	<link href="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<style>
img.lld_acc_pic {
  	height: 200px;
  	width: auto;
  }
</style>
	
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

                <!--�@�@�@�����������������������e���������������������@�@�@-->
                <div class="container-fluid">
					
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">�Ҧ��ЪF���</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>�|���s��</th>
											<th>�ЪF�s��</th>
											<th>�ӽЮɶ�</th>
											<th>�Ȧ�N�X</th>
											<th>�״ڱb��</th>
											<th>�b���ҩ�</th>
											<th>�����f�֪��A</th>
											<th>�f�ֳq�L�ɶ�</th>
											<th>���q�L��]</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="lanlordVO" items="${list}">

											<tr>
												<td>${lanlordVO.mem_no}</td>
												<td>${lanlordVO.lld_no}</td>
												<td><fmt:formatDate value="${lanlordVO.lld_apptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>${lanlordVO.lld_bank}</td>
												<td>${lanlordVO.lld_account}</td>
												<td><img src="${pageContext.request.contextPath}/LanlordPicReadServlet?lld_no=${lanlordVO.lld_no}"  class="lld_acc_pic"></td>
												<td>
													<c:choose>
														<c:when test="${lanlordVO.lld_status == 0}">���f��</c:when>
														<c:when test="${lanlordVO.lld_status == 1}">�f�ֳq�L</c:when>
														<c:when test="${lanlordVO.lld_status == 2}">�f�֤��q�L</c:when>
														<c:when test="${lanlordVO.lld_status == 3}">���v</c:when>
													</c:choose>
												</td>
												<td><fmt:formatDate value="${lanlordVO.lld_id_isvrfed}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>${lanlordVO.lld_id_disapprove}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
                	

                </div>
                <!--�@�@�@�����������������������e���������������������@�@�@-->

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
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/datatables-demo.js"></script>
     
</body>

</html>
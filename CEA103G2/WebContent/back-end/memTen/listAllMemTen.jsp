<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.memTen.model.*"%>
<!DOCTYPE html>

<%
    MemTenService memTenSvc = new MemTenService();
    List<MemTenVO> list = memTenSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>

	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

<title>�|��/�Ыȸ��</title>

<!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

	<!-- Custom styles for this page -->
	<link href="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<style>
img.mem_pic {
  height: 100px;
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
							<h6 class="m-0 font-weight-bold text-primary">�|��/�Ыȸ��</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>�|���s��</th>
											<th>�b��</th>
											<th>�K�X</th>
											<th>�Ӥ�</th>
											<th>�m�W</th>
											<th>�ʧO</th>
											<th>�����Ҧr��</th>
											<th>�X�ͦ~���</th>
											<th>�s���q��</th>
											<th>��ʹq��</th>
											<th>�q�l�H�c</th>
											<th>����</th>
											<th>�m����</th>
											<th>�a�}</th>
											<th>�b���ҥΪ��A</th>
											<th>�����ҥ���</th>
											<th>�����ҭI��</th>
											<th>�����f�֪��A</th>
											<th>�f�֥��q�L��]</th>	
<!-- 											<th>�ק�</th> -->
										</tr>
									</thead>
									<tbody>
										<c:forEach var="memTenVO" items="${list}">
											<tr>
												<td>${memTenVO.mem_no}</td>
												<td>${memTenVO.mem_username}</td>
												<td>${memTenVO.mem_password}</td>			
												<td><img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?action=getmempic&mem_no=${memTenVO.mem_no}" class="mem_pic"></td>
												<td>${memTenVO.mem_name}</td>
												<td>
													<c:choose>
														<c:when test="${memTenVO.mem_gender == 0}">�k</c:when>
														<c:when test="${memTenVO.mem_gender == 1}">�k</c:when>
													</c:choose>
												</td>
												<td>${memTenVO.mem_id}</td>
												<td><fmt:formatDate value="${memTenVO.mem_birthday}" pattern="yyyy-MM-dd"/></td> 
												<td>${memTenVO.mem_phone}</td>
												<td>${memTenVO.mem_mobile}</td>
												<td>${memTenVO.mem_email}</td>
												<td>${memTenVO.mem_city}</td>
												<td>${memTenVO.mem_dist}</td>			
												<td>${memTenVO.mem_addr}</td>
												<td>
													<c:choose>
														<c:when test="${memTenVO.mem_status == 0}">������</c:when>
														<c:when test="${memTenVO.mem_status == 1}">�w����</c:when>
														<c:when test="${memTenVO.mem_status == 2}">���v</c:when>
													</c:choose>
												</td>
												<td><img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?action=getidcardf&mem_no=${memTenVO.mem_no}" class="mem_pic"></td>			
												<td><img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?action=getidcardr&mem_no=${memTenVO.mem_no}" class="mem_pic"></td>
												<td>
													<c:choose>
														<c:when test="${memTenVO.mem_id_status == 0}">���W��</c:when>
														<c:when test="${memTenVO.mem_id_status == 1}">���f��</c:when>
														<c:when test="${memTenVO.mem_id_status == 2}">�q�L</c:when>
														<c:when test="${memTenVO.mem_id_status == 3}">���q�L</c:when>
													</c:choose>
												</td>
												<td>${memTenVO.mem_refuse}</td>
<!-- 												<td> -->
<%-- 												  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" style="margin-bottom: 0px;"> --%>
<!-- 												     <input type="submit" value="�ק�"> -->
<%-- 												     <input type="hidden" name="mem_no"  value="${memTenVO.mem_no}"> --%>
<!-- 												     <input type="hidden" name="action"	value="getOne_For_Update"> -->
<!-- 												  </FORM> -->
<!-- 												</td> -->
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
<%--             <%@ include file="/back-end/includeFile/footerBack.file" %> --%>

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

<%@ include file="/back-end/includeFile/footerBack.file" %>

</body>
</html>
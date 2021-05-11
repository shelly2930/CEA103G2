<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.lanlord.model.*"%>

<%
// 	LanlordService lanlordSvc = new LanlordService();
// LanlordVO lanlordVO = lanlordSvc.getOneLanlord(${param.lld_no});
// 	LanlordVO lanlordVO = (LanlordVO) request.getAttribute("lanlordVO");
%>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>房東申請詳情</title>

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


         <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
                <div class="container-fluid">
					
					<!-- DataTales Example -->
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
							<c:forEach var="lanlordVO" items="${list}">
								<tr>
									<th>房東編號</th>
									<td>${lanlordVO.lld_no}</td>
								</tr>
								<tr>
									<th>會員編號</th>
									<td>${lanlordVO.mem_no}</td>
								</tr>
								<tr>
									<th>申請時間</th>
									<td><fmt:formatDate value="${lanlordVO.lld_apptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								</tr>
								<tr>
									<th>銀行代碼</th>
									<td>${lanlordVO.lld_bank}</td>
								</tr>
								<tr>
									<th>匯款帳號</th>
									<td>${lanlordVO.lld_account}</td>
								</tr>
								<tr>
									<th>帳戶證明</th>
									<td><img src="${pageContext.request.contextPath}/LanlordPicReadServlet?lld_no=${lanlordVO.lld_no}"  class="lld_acc_pic"></td>
								</tr>
								<tr>
									<th>審核狀態</th>
									<td>
										<c:choose>
											<c:when test="${lanlordVO.lld_status == 0}">未審核</c:when>
											<c:when test="${lanlordVO.lld_status == 1}">審核通過</c:when>
											<c:when test="${lanlordVO.lld_status == 2}">審核不通過</c:when>
											<c:when test="${lanlordVO.lld_status == 3}">停權</c:when>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>通過時間</th>
									<td><fmt:formatDate value="${lanlordVO.lld_id_isvrfed}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								</tr>
								<tr>
									<th>未通過原因</th>
									<td>
										<input type="text" name="lld_id_disapprove" value="${lanlordVO.lld_id_disapprove}">
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
                </div>
                <!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

            </div>
            <!-- End of Main Content -->


        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    
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

     
</body>

</html>
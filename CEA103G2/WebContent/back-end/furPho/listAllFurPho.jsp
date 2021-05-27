<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furPho.model.*"%>
<%@ page import="com.furCat.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>

<%
    Integer fnt_it_no=new Integer(request.getParameter("fnt_it_no"));
	FurPhoService furPhoSvc = new FurPhoService();
	List<FurPhoVO> list = furPhoSvc.getOneFntItePics(fnt_it_no);
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="furIteDAO" scope="page"  class="com.furIte.model.FurIteDAO" />
<jsp:useBean id="furCatDAO" scope="page" 	class="com.furCat.model.FurCatDAO" />
<html>
<head>

	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

<title>家具照片管理</title>

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
<%--        <%@ include file="/back-end/includeFile/sidebarBack.file" %> --%>

         <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

				<!-- Topbar -->
<%--                 <%@ include file="/back-end/includeFile/topbarBack.file" %> --%>

                <!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
                <div class="container-fluid">
					
					<h1 class="h3 mb-2 text-gray-800">家具照片管理</h1>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
						  <a href="<%=request.getContextPath()%>/back-end/furPho/addFurPho.jsp?fnt_it_no=${param.fnt_it_no}" class="btn btn-warning btn-icon-split">
                                        <span class="text">新增品項照片</span>
                                </a>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
												<th>照片<br>編號</th>
												<th style="display:none;">品項名稱</th>
												<th>家具照片</th>
												<th>更換</th>
												<th>刪除</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="furPhoVO" items="${list}" >
											<tr>
													<td>${furPhoVO.fnt_pic_no}</td>
														<td style="display:none;"><c:forEach var="furIteVO" items="${furIteDAO.all}">
												<c:if test="${furPhoVO.fnt_it_no==furIteVO.fnt_it_no}">
							                    ${furIteVO.fnt_name}
						                    </c:if>
											</c:forEach></td>
																			<td><img
											src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}"
											height="100"></td>
																			<td>
											<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furPho/furPho.do" style="margin-bottom: 0px;">
												<button type="submit" class="btn btn-outline-success">更換</button>
												 <input type="hidden" 	name="fnt_pic_no" value="${furPhoVO.fnt_pic_no}">
												  <input 	type="hidden" name="action" value="getOne_For_Update">
											</FORM>
										</td>
										<!-- 				刪除 -->
										<td>
											<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furPho/furPho.do" style="margin-bottom: 0px;">
												<button type="submit" class="btn btn-outline-danger">刪除</button> 
												<input type="hidden" name="fnt_pic_no" value="${furPhoVO.fnt_pic_no}">
													<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
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
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furCat.model.*"%>
<%
    FurCatService furCatSvc = new FurCatService();
    List<FurCatVO> list = furCatSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>家具類別管理</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

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
          <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">家具類別管理</h1>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
             <a href="<%=request.getContextPath()%>/back-end/furCat/addFurCat.jsp" class="btn btn-warning btn-icon-split">
                                        <span class="text">新增資料</span>
                                    </a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>家具類別編號</th>
											<th>家具類別名稱</th>
											<th>編輯</th>
<!-- 											<th>刪除</th> -->
                                        </tr>
                                    </thead>
                                    
                                    <tbody>
<!--                                         <tr> -->
<!--                                             <td>Tiger Nixon</td> -->
<!--                                             <td>System Architect</td> -->
<!--                                             <td>Edinburgh</td> -->
<!--                                             <td>61</td> -->
<!--                                         </tr> -->
<!-- 分頁 -->
<%--                                        	<%@ include file="page1_furCat.file" %>  --%>
<%--                                  	<c:forEach var="furCatVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">       --%>
                                       	<c:forEach var="furCatVO" items="${list}" >
												
												<tr>
													<td>${furCatVO.fnt_ctgr_no}</td>
										<!-- 			過controller寫法 -->
										<%-- 			<td><a href="<%=request.getContextPath()%>/furCat/furCat.do?fnt_ctgr_no=${furCatVO.fnt_ctgr_no}&action=getOne_furCat">${furCatVO.fnt_ctgr_name}</a></td> --%>
										<!-- 			直接從連結取值寫法 -->
													<td><a href="<%=request.getContextPath()%>/back-end/furIte/listAllFurIte.jsp?fnt_ctgr_no=${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</a></td>
											
													<td>
													  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCat/furCat.do" style="margin-bottom: 0px;">
													     <button type="submit" class="btn btn-outline-success">編輯</button>
<!-- 													     <button type="submit" class="btn btn-outline-success">編輯</button> -->
													     <input type="hidden" name="fnt_ctgr_no"  value="${furCatVO.fnt_ctgr_no}">
													     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
													</td>
<!-- 													<td> -->
<%-- 													  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCat/furCat.do" style="margin-bottom: 0px;"> --%>
<!-- 																<button type="button" class="btn btn-outline-danger">刪除</button> -->
<%-- 													     <input type="hidden" name="fnt_ctgr_no"  value="${furCatVO.fnt_ctgr_no}"> --%>
<!-- 													     <input type="hidden" name="action" value="delete"></FORM> -->
<!-- 													</td> -->
												</tr>
											</c:forEach>
										                                    
										                                  
                                      
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

                </div>
<%--    分頁用             <%@ include file="page2_furCat.file" %> --%>
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
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>

</body>

</html>
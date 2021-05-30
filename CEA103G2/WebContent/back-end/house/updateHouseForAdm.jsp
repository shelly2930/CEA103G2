<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.houPho.model.*"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>更新物件</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
	 <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <%@include file="/back-end/includeFile/sidebarBack.file"%>

         <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

				<!-- Topbar -->
                <%@include file="/back-end/includeFile/topbarBack.file"%>

                <!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
                <div class="container-fluid">
						<form class="user" action="<%=request.getContextPath() %>/house/houseAdm.do">
						 <div class="card shadow mb-4">
						 <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">物件標題</h6>
                        </div>
                        <div class="card-body">
                                <div class="form-group row">
                                    <div class="col-sm-6">
                                    	<label for="title">物件標頭</label>
                                        <input type="text" class="form-control" id="title"
                                            name="hos_name" value="${houseVO.hos_name}">
                                    </div>
                                </div>
                        </div>
                        </div>
                            
                        <div class="card shadow mb-4">
						<div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">物件內文</h6>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
								    <label for="content">詳細物件描述</label>
								    <textarea name="hos_info" class="form-control" id="content" rows="3" >${houseVO.hos_info}</textarea>
							</div>
                        </div>
                        </div>
                        <input type="hidden" name="action" value="sendChangeContent">
                        <input type="hidden" name="hos_state" value="${param.state}">
                        <input type="hidden" name="hos_status" value="${param.status}">
                        <input type="hidden" name="houseno" value="${param.houseno}">
                        <input type="submit" class="btn btn-primary  btn-block" value="確定送出">
                        <a href="<%=request.getContextPath() %>/house/houseAdm.do?action=listAllHouseByState&state=${houseVO.hos_state}&status=${houseVO.hos_status}" class="btn btn-primary  btn-block">
                                    	取消
                        </a>   
						</form>
					
                </div>
                <!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@include file="/back-end/includeFile/footerBack.file"%>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->
	
    <%@include file="/back-end/includeFile/otherBack.file" %>
    
  
    
    
<!--     Bootstrap core JavaScript -->
   
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!--     Core plugin JavaScript -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

<!--     Custom scripts for all pages -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

<!--     Page level plugins -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

<!--     Page level custom scripts -->
 
</body>
  			
</html>
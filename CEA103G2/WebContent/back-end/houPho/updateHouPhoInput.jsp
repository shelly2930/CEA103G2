<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>後台空頁</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
	<style>
	.card-colums .card{
		display:inline-block;
		width:100%;
	}
	@media (min-width: 576px) {  .card-columns { column-count: 2; } } 
	@media (min-width: 768px) { .card-columns {  column-count: 2; } }  
	@media (min-width: 992px) { .card-columns {  column-count: 3; } }  
	@media (min-width: 1200px) { .card-columns {  column-count: 4; } }
	
	
	</style>
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
                	<div class="card shadow mb-4">
                		<div class="card-header py-3">
                			<h2 class="text-gray">更換照片</h2>
                		</div>
                		<div class="card-body">
                		
							<!-- ===============SHOW照片 -->
						
							<div class="card-columns">
							<form method="post" action="<%=request.getContextPath()%>/houPho/houPho.do" enctype="multipart/form-data">
							<c:forEach var="HouPhono" items="${paramValues.pickHousePic}" varStatus="amount">
							<div class="card text-center" style="width: 18rem;" >
								  <label for="${HouPhono}">
								  <img src="<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno=${param.houseno}&hos_pic_no=${HouPhono}" class="card-img-top" alt="...">
								  </label>
								  <div class="card-body">
									    
									    <label>
									    <i class="fas fa-upload fa-5"> 上傳要更新的圖片</i>
									    <i style="display:none" class="far fa-check-circle">
									    </i>
									    <p></p>
									    
									    <input id="${HouPhono}" type="file" style="display:none" name="${HouPhono}" value="${HouPhono}">
									    </label>
									    
								  </div>
							</div>
							</c:forEach>
							
							</div>
						</div>
						
						
							<!-- ===============SHOW照片 -->
						<div class="card-footer py-3">
                			<input type="hidden" name="action" value="updateMoreHouPho">
							<input type="hidden" name="houseno" value="${param.houseno}">
							<input class="btn btn-info btn-sm" type="submit" value="更改多張圖片">
							</form>
							<a class="btn btn-info btn-sm" href="${pageContext.request.contextPath}/house/house.do?action=listHouPhoEmp&houseno=${param.houseno}">取消更新</a>
                		</div>
                		<div id="test"><img></div>
					</div>	
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

    <%@include file="/back-end/includeFile/otherBack.file"%>
    
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
	<script>
    	$(function(){
	       	$("input[type='file']").change(function(){
	       		let x = $(this).prop('files');
	       		$("i[class='far fa-check-circle']").css('display','inline');
	       		$(this).prev().html("<p>"+x[0].name+"<br>"+x[0].type+"</p>");
	       	})
	       	
         })
    	</script>
</body>

</html>
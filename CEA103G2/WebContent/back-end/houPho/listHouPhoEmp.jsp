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
     <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
	<style>
	.carousel .carousel-item {
 	 height: 300px;
	}
	.carousel-control-prev-icon {
	 	width: 40px;
	    height: 40px;
		background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='%23c593d8' width='8' height='8' viewBox='0 0 8 8'%3e%3cpath d='M5.25 0l-4 4 4 4 1.5-1.5L4.25 4l2.5-2.5L5.25 0z'/%3e%3c/svg%3e");
	
	}
	.carousel-control-next-icon {
		width: 40px;
	    height: 40px;
		background-image:url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='%23c593d8' width='8' height='8' viewBox='0 0 8 8'%3e%3cpath d='M2.75 0l-1.5 1.5L3.75 4l-2.5 2.5L2.75 8l4-4-4-4z'/%3e%3c/svg%3e");
	
	}
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
                			<h2 class="text-gray">照片管理</h2>
                		</div>
                		<div class="card-body">
                
							<form method="post" action="<%=request.getContextPath()%>/houPho/houPho.do">
							<!-- 輪播 -->							
							<div id="carouselExampleControls" class="carousel slide" data-ride="carousel" w>
							  <div class="carousel-inner">
							  
							  	<c:forEach var="HouPhoVO" items="${listHouPho_ByHouseNo}" varStatus="amount">
							    <div class="carousel-item ${amount.index==0?'active':''}">
							    	<img src="<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno=${param.houseno}&hos_pic_no=${HouPhoVO.hos_pic_no}" class="d-block "  style="height:300px;margin:0 auto;">
									<div class="carousel-caption d-md-block d-none">
									<input id="${HouPhoVO.hos_pic_no}" type="checkbox" name="pickHousePic" value="${HouPhoVO.hos_pic_no}"> 
								         <label for="${HouPhoVO.hos_pic_no}"><h1>照片編號${HouPhoVO.hos_pic_no}</h1></label>	
								    </div>			    
							    </div>
							    
							    </c:forEach>
							    
							    
							  </div>
							  <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
							    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
							    <span class="sr-only">Previous</span>
							  </a>
							  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
							    <span class="carousel-control-next-icon" aria-hidden="true"></span>
							    <span class="sr-only">Next</span>
							  </a>
							</div>
							
							
							
							<hr>
							<input type="hidden" name="action" value="delete">
							<input type="hidden" name="houseno" value="${param.houseno}">
							<input class="btn btn-info btn-sm" type="submit" value="刪除選取圖片">
							<input class="btn btn-info btn-sm" type="submit" value="更改選取圖片">
							</form>
							<!-- ===============SHOW照片 -->
							<hr>
							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/houPho/houPho.do" enctype="multipart/form-data"  name="form1">
							
							<label>
							<i class="fas fa-camera"> 選我-新增多張照片<p id="showsize"></p></i>
							<input type="file"  id="load" name="hos_pic" size="45" multiple style="display:none" />
							</label>
							</td>
							<input type="hidden" name="action"  value="insert">
							<input type="hidden" name="houseno" value="${param.houseno}">
							<br>
							<input type="submit" class="btn btn-secondary btn-sm" value="送出新增">
							</FORM>
						</div>	
					</div>		
                </div>
                <!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
					<!-- Modal -->
					<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="ModalLabel">操作錯誤!!</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					        	請選取圖片
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					        <button type="button" class="btn btn-primary">Save changes</button>
					      </div>
					    </div>
					  </div>
					</div>
			<!--　　　↑↑↑↑↑↑↑↑↑↑彈出窗↑↑↑↑↑↑↑↑↑↑　　　-->
			<script>
				$(function(){
					if(${not empty ErrorMessage}){
						$('#Modal').modal({
							  show: true
						})
					}
				})
			</script>
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@include file="/back-end/includeFile/footerBack.file"%>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <%@include file="/back-end/includeFile/otherBack.file"%>
    
   
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
// 		顯示選取幾張
		$("input[type='file']").change(function(){
			let size = $(this).prop('files').length;
			$("#showsize").html("<p style='color:purple'>已選"+size+"張...還沒做預覽拉QQ</p>");
		})
// 		重要!更換參數
		$(document).ready(function(){
			$("input[value='更改選取圖片']").click(function(){
			$("input[value='delete']").val("getMoreForUpdate");
			})
		});
		</script>
</body>

</html>



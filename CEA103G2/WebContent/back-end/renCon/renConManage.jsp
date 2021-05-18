<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>��x�ŭ�</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
	 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
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
                		<input type='file' id="file" accept=".pdf">
						<button id="upload">�W���ɮ�</button>
                		<table class="table">
						  <thead>
						    <tr>
						      <th scope="col">�X��</th>
						      <th scope="col">�X���ɦW</th>
						      <th scope="col">�R��</th>
						    </tr>
						  </thead>
						  <tbody id='show'>
						  </tbody>
						</table>
                
						
						
<!-- 						SHOW PDF -->
						<embed id="q" src= "" width= "100%" height= "800px" type="application/pdf">
						
						
						<script type="text/javascript">
						showRenCon();
						function showRenCon(){
							$.ajax({
								url:'<%=request.getContextPath()%>/RenConCRUDServlet',
								type: 'post',
								data:{
									action:'list',
								},
								success:function(filename){
									let count = 1;
									$('#show').empty();
									for(let i of filename){
										console.log(i);
										let str="<tr id='"+i+"'>";
										str+="<th scope='row'>"+(count++)+"</th>";
										str+="<td>";
										str+="<a href='' class='listone'>"+i+"</a>";
										str+="</td>";
										str+="<td><a href=''  class='delete'>�R��</a></td>";  
										str+="</tr>";  
										$('#show').append(str);
									}
									$(".listone").click(function(e){
										e.preventDefault();
										//�n�Ҽ{�줣�쪺��
										alert($(this).parents('tr').attr('id'));
										//ajax SHOW �XPDF
										let name = $(this).parents('tr').attr('id');
										var xhr = new XMLHttpRequest(); 
										let goURL = '<%=request.getContextPath()%>/RenConPdfServlet?name='+name;
										xhr.open('GET', goURL , true); 
										xhr.responseType = 'blob'; 
										xhr.onload = function(e) {
											alert(this.status)
										    if (this.status == 200) { 
										    var blob = new Blob([this.response], {type: 'application/pdf'}), 
										    fileURL = URL.createObjectURL(blob);
										    console.log(fileURL)
										    $("#q").attr('src',fileURL);
//				 						    window.open(fileURL,'_blank');�u��������
										    } 
										}; 
										xhr.send(); 
										//ajax SHOW �XPDF
									})
									$(".delete").click(function(e){
										$.ajax({ 
											type: 'post', 
											url: "<%=request.getContextPath()%>/RenConCRUDServlet", 
											data:{
												action:'del',
												name:$(this).parents('tr').attr('id'),
											}, 
											success:function(r){
												console.log('�R�����\')	
											}
										}); 
									})
								}
							})
						}
						

						
						//�W���ɮ�
						var uploadFile;
						$('#file').on('change', function() {
							var files = this.files;
							if (files.length == 0) {
								return;
							}
							uploadFile = files[0];
						});
						$(function () { 
							$("#upload").click(function () { 
							var formData = new FormData(); 
							formData.append("file", uploadFile); 
							console.log(uploadFile);
								$.ajax({ 
									type: 'post', 
									url: "<%=request.getContextPath()%>/RenConAjaxServlet", 
									data: formData, 
									cache: false, 
									processData: false, 
									contentType: false, 
									success:function(r){
										showRenCon();
									}
								}); 
							}); 
						}); 
						//�W���ɮ�
						</script>
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
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>

</body>

</html>
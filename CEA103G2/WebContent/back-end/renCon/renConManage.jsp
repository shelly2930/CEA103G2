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
	
    <title>後台空頁</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
	 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
                <div class="card-header py-3">
                	<h2><p class='text-gary'>合約管理</p></h2>
                </div>
         		<div class="card-body">
         		<div class="card shadow mb-4">
                     <div class="table-responsive">
						<div id='mem'>
	                		<table class="table">
							  <thead>
							 	<tr>
	                		  		<th  colspan='2' >
	                		  		<span>選取會員</span>
	                		  		</th>
	                		  	</tr>
							    <tr>
							      <th scope="col" class='text-center'>筆數</th>
							      <th scope="col" class='text-center'>會員編號</th>
							    </tr>
							  </thead>
							  <tbody id='showmem'>
							  </tbody>
							</table>
                		</div>
                		<div id='memhou'>
	                		<table class="table">
							  <thead>
							  	<tr>
	                		  		<th  colspan='2' >
	                		  		<a href=''>選取會員<span id='i2_no'></span></a> >
	                		  		<a href=''>會員編號<span id='m2_no'>2</span></a>
	                		  		</th>
	                		  	</tr>
							    <tr>
							      <th scope="col" class='text-center'>筆數</th>
							      <th scope="col" class='text-center'>物件編號</th>
							    </tr>
							  </thead>
							  <tbody id='showmemhou'>
							  </tbody>
							</table>
                		</div>
                		<div id='memhoucon'>
	                		<table class="table">
	                		
							  <thead>
							  	<tr>
	                		  		<th  colspan='2' >
	                		  		<a href=''>選取會員<span id='i1_no'></span></a> >
	                		  		<a href=''>會員編號<span id='m1_no'>2</span></a> > 
	                		  		<a href=''>物件編號<span id='h1_no'>5</span></a></th>
	                		  	</tr>
							    <tr>
							      <th scope="col" class='text-center'>筆數</th>
							      <th scope="col" class='text-center'>合約編號</th>
							    </tr>
							  </thead>
							  <tbody id='showmemhoucon'>
							  </tbody>
							</table>
                		</div>
                		<div id='con'>
                			
	                		
	                		<table class="table">
							  <thead>
							  	<tr>
							  		<th scope="col" class='text-center'>
							  		<div id='conmanager'>
	                				</div>
	                				</th>	
							  	</tr>
							  	<tr>
	                		  		<th  colspan='2' >
	                		  		<a href=''>選取會員<span id='i_no'></span></a> > 
	                		  		<a href=''>會員編號<span id='m_no'></span></a> > 
	                		  		<a href=''>物件編號<span id='h_no'></span></a> >
	                		  		<a href=''>合約編號<span id='c_no'></span></a> 
	                		  		</th>
	                		  	</tr>
							    <tr>
							      <th scope="col" class='text-center'>筆數</th>
							      <th scope="col" class='text-center'>合約PDF</th>
							    </tr>
							  </thead>
							  <tbody id='showcon'>
							  </tbody>
							</table>
                		</div>
						
						
<!-- 						SHOW PDF -->
						
						
						
						
						
						<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						  <div class="modal-dialog modal-xl" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="exampleModalLabel">合約內容</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						        <embed id="q" src= "" width= "100%" height= "800px" type="application/pdf">
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						      </div>
						    </div>
						  </div>
						</div>
						
						
						
					<script type="text/javascript">
						var uploadFile;
						$("#conmanager").hide();
						$("#mem").hide();
						$("#memhou").hide();
						$("#memhoucon").hide();						
						$("#con").hide();						
						
						
						showmem();
						function showmem(){
							$("#mem").show();
							$.ajax({
								url:'<%=request.getContextPath()%>/RenConCRUDServlet',
								type: 'post',
								data:{
									action:'getMem',
									status:"1",
								},
								success:function(mem){
									$('#showmem').empty();
									if(mem=="none"){
										let str="<tr>";
										str+="<th colspan='2' scope='row' class='text-center'>沒有任何合約</th>";
										str+="</tr>";  
										$('#showmem').append(str);
									}else{
										let count = 1;
										for(let i of mem){
											let str="<tr id='mem"+i+"'>";
											str+="<th scope='row' class='text-center'>"+(count++)+"</th>";
											str+="<td class='text-center'>";
											str+="<a href='' class='listmemhou'>"+i+getMem(i);+"</a>";
											str+="</td>";
											str+="</tr>";  
											$('#showmem').append(str);
										}
										$(".listmemhou").click(function(e){
											e.preventDefault();
											$("#mem").hide();
											showmemhou($(this).parents('tr').attr('id').substring(3));
											$("#memhou").show();
										})
									}
								}
							})
						}
						$("#i2_no").parent().click(function(e){
							e.preventDefault();
							$("#memhou").hide();
							showmem();
						})
						$("#m2_no").parent().click(function(e){
							e.preventDefault();
							$("#memhou").hide();
							showmemhou(parseInt($("#m2_no").text()));
						})
						function showmemhou(mem_no){
							$("#memhou").show();
							$("#m2_no").text(mem_no);
							$.ajax({
								url:'<%=request.getContextPath()%>/RenConCRUDServlet',
								type: 'post',
								data:{
									action:'getMemHou',
									mem_no:mem_no,
									status:"1",
								},
								success:function(memhou){
									if(memhou==null){
										alert('查無物件');
									}
									$('#showmemhou').empty();
									let count = 1;
									for(let i of memhou){
										let str="<tr name='"+mem_no+"' id='memhou"+i+"'>";
										str+="<th scope='row' class='text-center'>"+(count++)+"</th>";
										str+="<td class='text-center'>";
										str+="<a href='' class='listmemhoucon'>"+i+getHouse(i)+"</a>";
										str+="</td>";
										str+="</tr>";  
										$('#showmemhou').append(str);
									}
									$(".listmemhoucon").click(function(e){
										e.preventDefault();
										$("#memhou").hide();
										showmemhoucon($(this).parents('tr').attr('name'),$(this).parents('tr').attr('id').substring(6));
										$("#memhoucon").show();
										
									})
								}
							})
						}
						$("#i1_no").parent().click(function(e){
							e.preventDefault();
							$("#memhoucon").hide();
							showmem();
						})
						$("#m1_no").parent().click(function(e){
							e.preventDefault();
							$("#memhoucon").hide();
							showmemhou(parseInt($("#m1_no").text()));
						})
						$("#h1_no").parent().click(function(e){
							e.preventDefault();
							$("#memhoucon").hide();
							showmemhoucon($("#m1_no").text(),$("#h1_no").text());
						})
						function showmemhoucon(mem_no,hou){
							$("#memhoucon").show();
							$("#m1_no").text(mem_no);
							$("#h1_no").text(hou);
							$.ajax({
								url:'<%=request.getContextPath()%>/RenConCRUDServlet',
								type: 'post',
								data:{
									action:'getMemHouCon',
									mem_no:mem_no,
									hos_no:hou,
									status:"1",
								},
								success:function(memhoucon){
									
									if(memhoucon==null){
										alert('查無合約');
									}
									$('#showmemhoucon').empty();
									let count = 1;
									for(let i of memhoucon){
										let str="<tr name='"+mem_no+"' class='memhou"+hou+"'>";
										str+="<th scope='row' class='text-center'>"+(count++)+"</th>";
										str+="<td class='text-center'>";
										str+="<a href='' id='"+i+"' class='listmemhoucon'>"+i+"</a>";
										str+="</td>";
										str+="</tr>";  
										$('#showmemhoucon').append(str);
									}
									$(".listmemhoucon").click(function(e){
										e.preventDefault();
										$("#conmanager").show();
										$("#memhoucon").hide();
										showcon($(this).parents('tr').attr('name'),$(this).parents('tr').attr('class').substring(6),$(this).attr('id'));
										$("#con").show();
									})
								}
							})
						}
						$("#i_no").parent().click(function(e){
							e.preventDefault();
							$('#con').hide();
							showmem();
						})
						$("#m_no").parent().click(function(e){
							e.preventDefault();
							$('#con').hide();
							showmemhou(parseInt($("#m_no").text()));
						})
						$("#h_no").parent().click(function(e){
							e.preventDefault();
							$('#con').hide();
							showmemhoucon($("#m_no").text(),$("#h_no").text());
						})
						$("#c_no").parent().click(function(e){
							e.preventDefault();
							$('#con').hide();
							showcon($("#m_no").text(),$("#h_no").text(),$("#c_no").text());
						})
						function showcon(mem_no,hou,con_no){
							$("#con").show();
							$("#m_no").text(mem_no);
							$("#h_no").text(hou);
							$("#c_no").text(con_no);

							$.ajax({
								url:'<%=request.getContextPath()%>/RenConCRUDServlet',
								type: 'post',
								data:{
									action:'list',
									mem_no:mem_no,
									hos_no:hou,
									con_no:con_no,
								},
								success:function(con){
									
									$('#showcon').empty();
									let count = 1;
									manager_str = "<label><h5><i class='fas fa-cloud-upload-alt'><input style='display:none' type='file' id='file' accept='.pdf'>&nbsp;選擇上傳合約PDF</i></h5></label>&nbsp;&nbsp;&nbsp;";
									manager_str+= "<button class='btn btn-sm btn-outline-info' id='upload'>新增合約</button>";
									$("#conmanager").html(manager_str);
									
									
									$('#file').on('change', function() {
										var files = this.files;
										if (files.length == 0) {
											return;
										}
										uploadFile = files[0];
									});
									$("#upload").click(function () { 
									var formData = new FormData(); 
									formData.append("file", uploadFile);
									formData.append("mem_no", $("#m_no").text());
									formData.append("hos_no", $("#h_no").text());
									formData.append("con_no", $("#c_no").text());
									console.log(uploadFile);
										$.ajax({ 
											type: 'post', 
											url: "<%=request.getContextPath()%>/RenConAjaxServlet", 
											data: formData, 
											cache: false, 
											processData: false, 
											contentType: false, 
											success:function(r){
												console.log(r);
												if(r==="same"){
													Swal.fire({
														  title: '相同檔名',
														  text: '已經覆蓋原本檔案',
														  icon: 'warning',
													});
												}
												showcon($("#m_no").text(),$("#h_no").text(),$("#c_no").text());
											}
										}); 
									}); 
									if(con =="none"){
										let str="<tr name='"+mem_no+"' class='"+hou+"'>";										
										str+="<td class='text-center' colspan='2'>";
										str+="<span>尚未新增合約</span>";
										str+="</td>";
										str+="</tr>";  
										$('#showcon').append(str);
									}else{
										for(let i of con){
											let str="<tr name='"+mem_no+"' class='"+hou+"'>";										
											str+="<th scope='row' class='text-center'>"+(count++)+"</th>";
											str+="<td class='text-center'>";
											str+="<a href='' name='"+con_no+"' id='"+i+"' class='con'>"+i+"</a>";
											str+="</td>";
											str+="<td class='text-center'>";
											str+="<button class='del btn btn-outline-danger' >Deleted</button>";
											str+="</td>";
											str+="</tr>";  
											$('#showcon').append(str);
										}
										$(".del").click(function(){
											let mem_no =$(this).parents('tr').attr('name') ;
											let hos_no =$(this).parents('tr').attr('class') ;
											let con_no = $(this).parent().prev().children().attr('name');
											let filename = $(this).parent().prev().children().attr('id');
	 										$.ajax({ 
	 											type: 'post', 
												url: "<%=request.getContextPath()%>/RenConCRUDServlet", 
	 											data:{
	 												action:'del',
	 												mem_no:mem_no,
	 												hos_no:hos_no,
	 												con_no:con_no,
	 												name:filename,
	 											}, 
	 											success:function(r){
	 												console.log('刪除成功');
	 												showcon($("#m_no").text(),$("#h_no").text(),$("#c_no").text());
	 											}
	 										}); 
											
										})
										$(".con").click(function(e){
											e.preventDefault();
											$("#conmanager").show();
											$("#memhoucon").hide();
											let mem_no =$(this).parents('tr').attr('name') ;
											let hos_no =$(this).parents('tr').attr('class') ;
											let con_no = $(this).attr('name');
											let filename = $(this).attr('id');
											var xhr = new XMLHttpRequest(); 
											let goURL = "<%=request.getContextPath()%>/RenConPdfServlet?mem_no="+mem_no+"&hos_no="+hos_no+"&con_no="+con_no+"&name="+filename;
											xhr.open('GET', goURL , true); 
											xhr.responseType = 'blob'; 
											xhr.onload = function(e) {
											    if (this.status == 200) { 
											    var blob = new Blob([this.response], {type: 'application/pdf'}), 
											    fileURL = URL.createObjectURL(blob);
											    $("#q").attr('src',fileURL);
	// 				 						    window.open(fileURL,'_blank');彈跳視窗用
												$("#exampleModal").modal('show');
											    } 
											}; 
											xhr.send(); 
										})
										
									}
									
									
									
								}
								})
							}
							function getMem(mem_no){
								let name = "";
								$.ajax({
									url:'<%=request.getContextPath()%>/RenConCRUDServlet',
									type: 'post',
									data:{
										action:'getOneMemten',
										mem_no:mem_no,
									},
									async:false,
									success:function(mem){
										name = mem.mem_name;
									}
								})
								return name;
							}
							function getHouse(hos_no){
								let hos_name ="";
								$.ajax({
									url:'<%=request.getContextPath()%>/RenConCRUDServlet',
									type: 'post',
									data:{
										action:'getOneHouse',
										houseno:hos_no,
									},
									async:false,
									success:function(hos){
										hos_name = hos.hos_name;
									}
								})
								return hos_name;
							}
						</script>
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
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>

</body>

</html>
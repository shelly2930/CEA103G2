<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
	<link href="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
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
                	<div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>����s��</th>
                                            <th>����W��</th>
                                            <th>����a�}</th>
                                            <th>�d�ݹw���ɶ�</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th colspan='6' class="text-center"	>����</th>
                                        </tr>
                                    </tfoot>
                                    <tbody id="showhouse">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                
                </div>
                <!--�@�@�@�����������������������e���������������������@�@�@-->

            </div>
            <!-- End of Main Content -->
			<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">����Խ�</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        	<table>
			        		<thead>
			        		<tr>
			        			<th>���D</th>
			        			<th>����</th>
			        		</tr>
			        		</thead>
			        		<tbody id = "showonehouse">
			        		
			        		</tbody>
			        	</table>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">CLOSE</button>
			      </div>
			    </div>
			  </div>
			</div>
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

    <!-- Page level custom scripts -->
    <!-- Page level custom scripts -->
	<script>
	
	$(document).ready(function(){
		$.ajax({
			url:"<%=request.getContextPath()%>/HouseJsonServlet",
			type:"post",
			data:{
				action:'getAllHouseOnLine',
			},
			success:function(data){
				for(let house of data){
					let tr = $("<tr></tr>").appendTo("#showhouse");
					tr.append("<td><button name='house' id='"+house.hos_no+"' class='btn btn-success btn-sm'>"+house.hos_no+"</button></td>").append("<td>"+house.hos_name+"</td>").append("<td>"+house.hos_address+"</td>").append("<td><button name='roovieapp' class='btn btn-primary btn-sm'>�d�ݹw��</button></td>");
				}	
			}
		})
	});
	
	let house_key = ['����s��',
		'�ЪF�s��',
		'����W��',
		'���󯲪�',
		'�޲z�O',
		'�Z�n���',
		'�s������',
		'����',
		'�m��[��]��',
		'�a�}',
		'�g��',
		'�n��',
		'�Ы�',
		'����',
		'����',
		'�Ӽh',
		'�q��P�_',
		'������P�_',
		'�d���P�_',
		'�N���P�_',
		'�W��',
		'�ʧO����',
		'���O/�@��',
		'�q�O/�@��',
		'�����O',
		'�ӽЮɶ�',
		'�w���ɶ�',
		'���u�s��',
		'�ӽжi��',
		'�f�ֵ��G',
		'�Ҧ��v���Ӥ�',
		'�Z�n���A',
		'���q�L��]'];
	
	$(window).on('load',function(){
		$("button[name='house']").click(function(){
			$.ajax({
				url:"<%=request.getContextPath()%>/HouseJsonServlet",
				type:"post",
				data:{
					action:'getOneHouse',
					houseno: $(this).attr("id"),
				},
				success:function(data){
					let count = 0;
					for(let x in data){
						let tr = $("<tr></tr><hr>").appendTo("#showonehouse");
						tr.append("<th>"+house_key[count++]+"</th>").append("<th>"+data[x]+"</th>")
					}
					
					
				}
			})
			
			
			$("#exampleModalLong").modal({
				show:true,
			});
		})
		$("button[name='roovieapp']").click(function(){
			let houseno = $(this).parents("tr").find('button').attr('id');
			document.location.href="<%=request.getContextPath()%>/back-end/rooVieApp/controlTime.jsp?houseno="+houseno;
		})
	})
	</script>
</body>

</html>
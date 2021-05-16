<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>未指派預約</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js" integrity="sha256-0YPKAwZP7Mp3ALMRVB2i8GXeEndvCq3eSl/WsAl1Ryk=" crossorigin="anonymous"></script>
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

                    <div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">查看最新預約情況</h1>
                    <p class="mb-4">新案件<a target="_blank" href="https://datatables.net"></a>.</p>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">點選物件編號 可以查看物件預約情況</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                            	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            			<div id="freeEmp">
										<!-- 	之後可以用js老師作業的隨機顏色耶XD -->
										</div>
                            	</table>
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>物件編號</th>
                                            <th>目前預約人數</th>
                                            <th>最新預約時間</th>
                                        </tr>
                                    </thead>
                                    <tbody id="showData">
                                    </tbody>
                                </table>
                            </div>
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
          
          
//           $.ajax({
<%--         	  url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do", --%>
//         	  type:'post',
//         	  data:{
//         		  action:'listNewRooVieApp',
//         	  },
//         	  success:function(list){
// 					for(let key in list){
// 						let str = '<tr>';
// 						str+='<th>'+'<button class=\'btn btn-outline-secondary btn-sm controltime\' id=\"'+key+'\">'+"control "+key+'</button>'+'</th>';
// 		        		str+='<th>'+dateformat(list[key])+'</th>';
// 		        		str+='</tr>';
// 		        		$("#showData").append(str);
// 					}
// 					$(".controltime").click(function(){
<%-- 						document.location.href="<%=request.getContextPath()%>/back-end/rooVieApp/controlTime.jsp?houseno="+$(this).attr("id"); --%>
// 					})
//         	  }
//           })

//           $.ajax({
<%-- 				url:"<%=request.getContextPath()%>/HouseJsonServlet", --%>
// 				type:'post',
// 				data:{
// 					action:'getAllEmp',
// 				},
// 				async: false,
// 				success:function(str){
// 					for(let obj of str){
// 						console.log(obj.emp_name+obj.emp_no	);
// 						let empString = "<button class='emp btn btn-info btn-sm'>"+obj.emp_no+" "+obj.emp_name+"";
// 						empString+="<input type='hidden' name='emp_no' value='"+obj.emp_no+"'></button>&nbsp; ";
// 						$("#freeEmp").append(empString);
// 					}
					
// 				}
				
// 			})

//           })
		let empno = ${employeeVO.emp_no};
		let rva_status = 1;
		listTheEmpApp(2,1);
		listTheEmpApp(1,1);
		function listTheEmpApp(emp_no,rva_status){
			$.ajax({
	        	  url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
	        	  type:'post',
	        	  data:{
	        		  action:'listTheEmpApp',
	        		  emp_no:emp_no,
	        		  rva_status:'1',
	        	  },
	        	  success:function(map){
	        		 $("#showData").empty();
					for(let x in map){
						let str = '<tr>';
						str+='<th><button class=\'btn btn-outline-secondary btn-sm housno\' id=\"'+JSON.parse(x).hos_no+'\">'+JSON.parse(x).hos_no+'</button></th>';
		        		str+='<th>'+map[x]+'</th>';
		        		str+='<th>'+dateformat(JSON.parse(x).rva_order_time)+'</th>';
		        		str+='</tr>'; 
						$("#showData").append(str);
					}
	        	  }
	        })
		}
		
		function dateformat(str){
			 let year = new Date(str).getFullYear();
			 let month = new Date(str).getMonth()+1;
			 let date = new Date(str).getDate();
			 let hour = new Date(str).getHours();
			 let isAm = "上午";
			 if((Math.floor(hour/12)==1)){
				 isAm = "下午";
			 }
			 let minutes = new Date(str).getMinutes();
			 let second = new Date(str).getSeconds();
			 return year+"年"+month+"月"+date+"日" +" "+isAm+hour+"時"
		//	 +minutes+"分"+second+"秒";
	 	}
			
    </script>	
</body>

</html>
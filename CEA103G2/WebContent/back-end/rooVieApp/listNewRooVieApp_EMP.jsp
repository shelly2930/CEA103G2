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
                    <h1 class="h3 mb-2 text-gray-800">預約申請單</h1>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                        	<button class='btn btn-outline-info btn-sm' id='now'>申請單</button>
                        	<button class='btn btn-outline-info btn-sm' id='history'>歷史申請案件</button>
                        	<hr>
                            <h6 class="m-0 font-weight-bold text-primary">預約處理表單</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <div id='app'>
                                	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>物件編號</th>
                                            <th>物件名稱</th>
                                            <th>預約會員</th>
                                            <th>預約時間</th>
                                            <th>預約地點</th>
                                            <th>聯絡方式</th>
                                            <th id='casestatus'>結案</th>
                                        </tr>
                                    </thead>
                                    <tbody id="showApp">
                                    </tbody>
                                </table>
                                </div>
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
          

		let empno = ${employeeVO.emp_no};
		let nowStatus = 1;
		$("#now").click(function(){
			$("#now").removeClass('btn-outline-info');
			$("#now").addClass('btn-info');
			$("#history").removeClass('btn-info');
			$("#history").addClass('btn-outline-info');
			$("#app").hide();
			nowStatus=1;
			listTheEmpApp(empno,nowStatus);
		})
		$("#history").click(function(){
			$("#history").removeClass('btn-outline-info');
			$("#history").addClass('btn-info');
			$("#now").removeClass('btn-info');
			$("#now").addClass('btn-outline-info');
			$("#app").hide();
			nowStatus=2;
			listTheEmpApp(empno,nowStatus);
		})
		
		$("#app").hide();
		listTheEmpApp(empno,nowStatus);
		function listTheEmpApp(emp_no,rva_status){
			$("#showApp").empty();
			$("#app").hide();
			$.ajax({
	        	  url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
	        	  type:'post',
	        	  data:{
	        		  action:'showTheEmpApp',
	        		  'emp_no':emp_no,
	        		  'rva_status':rva_status,
	        	  },
	        	  success:function(list){
	        		  console.log(list);
	        		  console.log(rva_status);
	        		if(list.length==0){
	        			let str = "<tr>";
		        		str+="<td class='text-center' colspan='7'>沒有新案件</td>";
		        		str+="</tr>";
		        		$("#showApp").append(str);
	        		}else{
	        			let sameMem = "";
	        			for(let ap of list){
	        				console.log(ap.rva_end_time)
			        		let str = "<tr>";
			        		str+="<td>"+ap.hos_no+"</td>";
			        		str+="<td>"+getHos(ap.hos_no).hos_name+"</td>";
			        		str+="<td>"+getMem(ap.mem_no).mem_name+"</td>";
			        		str+="<td>"+dateformat(ap.rva_order_time)+"</td>";
			        		str+="<td>"+getHos(ap.hos_no).hos_address+"</td>";
			        		str+="<td >"+getMem(ap.mem_no).mem_mobile+"</td>";
			        		if(nowStatus==1){
				        		str+="<td id='"+ap.rva_no+"'>";
				        		str+="<button class='cancel btn btn-outline-primary btn-sm'>取消預約</button>&nbsp; ";
				        		str+="<button class='end btn btn-outline-success btn-sm'>結案</button>";
				        		str+="</td>";
			        		}else{
			        			str+="<td>";
			        			if(!ap.rva_end_time){
			        				str+="系統取消";
			        			}else{
			        				str+="已帶看";
			        			}
				        		str+="</td>";
			        		}
			        		str+="</tr>";
			        		
			        		$("#showApp").append(str);
			        		if(sameMem==ap.mem_no){
			        			let catchid = "#"+ap.rva_no;
	        					$(catchid).parent().css('background','#FFDEDE')
	        					$(catchid).parent().children().eq(2).append("<br><p style='color:#FF7878'>(重複)</p>");
	        				}
	        				sameMem = ap.mem_no;
	        			}
	        			
	        			$(".cancel").click(function(){
	        				let rva_no = $(this).parent().attr('id');
	        				let status = 2;
	        				updateStatus(empno,rva_no,status);
	        				listTheEmpApp(empno,nowStatus);
	        			})
	        			$(".end").click(function(){
	        				let rva_no = $(this).parent().attr('id');
	        				let status = 2;
	        				updateStatus(empno,rva_no,status);
	        				updateEndTime(rva_no);
	        				listTheEmpApp(empno,nowStatus);
	        			})
	        		}
	        		$("#app").slideDown();
	        	  }
	        })
		}
		//緊急，借用RenCon sevlet救援~
		function getMem(mem_no){
			let mem = {};
			$.ajax({
				url:'<%=request.getContextPath()%>/RenConCRUDServlet',
				type: 'post',
				data:{
					action:'getOneMemten',
					mem_no:mem_no,
				},
				async:false,
				success:function(memvo){
					for(let key in memvo){
						mem[key]=memvo[key];
					}
					console.log(memvo)
				}
			})
			return mem;
		}
		function getHos(hos_no){
			let hos ={};
			$.ajax({
				url:'<%=request.getContextPath()%>/RenConCRUDServlet',
				type: 'post',
				data:{
					action:'getOneHouse',
					houseno:hos_no,
				},
				async:false,
				success:function(hosvo){
					for(let key in hosvo){
						hos[key]=hosvo[key];
					}
				}
			})
			return hos;
		}
		function updateStatus(emp_no,rva_no,status){
			$.ajax({
  		    	url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
  		    	type:'post',
  		    	data:{
  		    		'action':'updateStatus',
  		    		'emp_no':emp_no,
					'rva_no':rva_no,
					'status':status
  		    	},
  		    	async:false,
  		    	success:function(result){
  		    		console.log('成功更改');
  		    	}
  		    	
  		    }); 
		}
		function updateEndTime(rva_no){
			$.ajax({
  		    	url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
  		    	type:'post',
  		    	data:{
  		    		'action':'updateEndTime',
					'rva_no':rva_no,
  		    	},
  		    	async:false,
  		    	success:function(result){
  		    		console.log('成功更改'+result);
  		    	}
  		    	
  		    }); 
		}
		function checkthehousecon(hos){
			let con ={};
			$.ajax({
  		    	url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
  		    	type:'post',
  		    	data:{
  		    		'action':'checkthehousecon',
					'houseno':hos,
  		    	},
  		    	async:false,
  		    	success:function(result){
  		    		
  		    		for(let key in result){
  		    			con[key]=result[key];
					}
  		    		console.log(con)
  		    	}
  		    });
			return con;
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
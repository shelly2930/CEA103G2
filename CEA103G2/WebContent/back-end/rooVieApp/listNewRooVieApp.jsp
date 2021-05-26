<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>後台空頁</title>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
                    <p class="mb-4">預約看房申請進行指派<a target="_blank" href="https://datatables.net"></a>.</p>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <ul>
                            	<li>
	                            	<h6 class="h6 mb-6 " style='color:red;font-weight:bold'>(提示) 點選員工-可查看目前員工已指派時間
	                            	</h6>
                            	</li>
                            </ul>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                            	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            				<div id="freeEmp">
												
											</div>
                            	</table>
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                        	<th>全部申請單</th>
											<th>未指派申請單</th>
                                            <th>物件編號</th>
                                            <th>最新預約時間</th>
                                            <th>查看預約情況</th>
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
                
<!--                 指派 -->
				<div class="modal" id="test" tabindex="-1" role="dialog">
				  <div class="modal-dialog modal-xl" role="document">
				    <div class="modal-content ">
				      <div class="modal-header">
				        <h5 class="modal-title">物件預約時間</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				      <div class="container-fluid">
   						 <div class="row">
   						 	<div class='col-12'>
   						 		<div id="freeEmp_single">
												
								</div>
   						 	</div>
   						 	<div class="col-12">
					        <table class="table table-striped">
							  <thead>
							    <tr>
							      <th scope="col">指派</th>
							      <th scope="col">申請編號</th>
							  	  <th scope="col">會員</th>
							      <th scope="col">預約物件</th>
							      <th scope="col">員工</th>
							      <th scope="col">申請時間</th>
							      <th scope="col">預約時間</th>
							    </tr>
							  </thead>
							  <tbody id="showthishouseapp">
							  </tbody>
							</table>
							</div>
							</div>
							</div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				      </div>
				    </div>
				  </div>
				</div> 
                
                
                <div class="modal fade" id="empapp" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-lg" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">員工 班表</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">               
                
                
                
                
                
                
                
                
                <table  class="table table-borderless">
                                <thead>
                               		 <tr class="table-primary">
                               		 	<th id="prev" class="text-center">&lt;&lt;</th>
                                        <th id="month" scope="col" colspan="5" class="text-center">月份</th>
                                        <th id="next" class="text-center">&gt;&gt;</th>
                                    </tr>
                                    <tr class="table-primary">
                                        <th class="text-center">星期日</th>
                                        <th class="text-center">星期一</th>
                                        <th class="text-center">星期二</th>
                                        <th class="text-center">星期三</th>
                                        <th class="text-center">星期四</th>
                                        <th class="text-center">星期五</th>
                                        <th class="text-center">星期六</th>
                                    </tr>
                                </thead>
                                <tbody>
                               		 <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th scope="col" colspan="7" class="text-center">Date</th>
                                    </tr>
                                </tfoot>
                            </table>
                
                			<div id="hidden">
                			<table  class="table table-borderless">
                                <thead>
                                    <tr class="table-primary">
                                        <th id='timetitle' class="text-center" colspan="2">時段</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                     </tr>
                                     <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                     </tr>
                                     <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="picktime" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th scope="col" colspan="8" class="text-center">Time</th>
                                    </tr>
                                </tfoot>
                            </table>
                            </div>
				        	
				        	
				        
				        
				        
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
	
	
	
	//分頁 重寫版
	let total = 22;//之後填寫
	let number = 4;
	let pageMap = new Map();
	
	function page(total,number){
		let tempMap = new Map();
		let page = Math.ceil(total/number);
		
		for(let i =1;i<page;i++){
			tempMap.set(i,number*(i-1));
		}
		tempMap.set(page,total);
		
		let pagekey = tempMap.keys();
		for(let x of pagekey){
			console.log(x+tempMap.get(x))
		}
		return tempMap;
	}
	
	console.log(pageMap);
	
	//分頁 重寫版
	
	
    //存放員工物件
    let emp = [];
    let chooseEmp = null;
    let empMap = new Map();//set emp[no,name]
	//日曆生成
		spancalender();
		function spancalender(){
			let choose = new Date();
	//			今年
			let currentYear = choose.getFullYear();
	//			這個月
			let currentMonth = choose.getMonth()+1;
	//			今日
			let currentDate = choose.getDate();
	//			這個月第一天
			let currentMonthFirstDay = new Date(""+currentYear+"-"+currentMonth+"-1").getDay();//0對應到星期日 其餘1對禮拜一
	//			今年這個月有幾天
			let currentTotalDay = judgeDay(currentYear,currentMonth);
	//			count用途
			let week = 0;
			$("#prev").click(function(){
				freshPickDateTB();
				if(currentMonth==1){
					currentYear--;
					currentMonth=13;
				}
				currentMonth--;
				let d = ""+currentYear+"-"+currentMonth+"-1";
				currentMonthFirstDay = new Date(d).getDay();
				currentTotalDay = judgeDay(currentYear,currentMonth);
				
				$("#month").html("<span>"+currentYear+"年"+currentMonth+"月</span>")
				for(let i = 1;i<=currentTotalDay;i++){
					let pickdate = currentYear+"-"+currentMonth+"-"+(i);
					let compare = currentYear+"-"+currentMonth+"-"+(i);
					if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
						$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
					}
					$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
					$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
					currentMonthFirstDay = currentMonthFirstDay+1;
				}
				//隱藏時間
				$("#hidden").hide();getTime(chooseEmp);
			})
			$("#next").click(function(){
				freshPickDateTB();
				
				if(currentMonth==12){
					currentYear++;
					currentMonth=0;
				}
				
				currentMonth++;
				currentMonthFirstDay = new Date(""+currentYear+"-"+currentMonth+"-1").getDay();
				currentTotalDay = judgeDay(currentYear,currentMonth);
				
				$("#month").html("<span>"+currentYear+"年"+currentMonth+"月</span>")
				for(let i = 1;i<=currentTotalDay;i++){
					let pickdate = currentYear+"-"+currentMonth+"-"+(i);
					let compare = currentYear+"-"+currentMonth+"-"+(i);
					if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
						$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
					}
					$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
					$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
					currentMonthFirstDay = currentMonthFirstDay+1;
				}
				//隱藏時間
				$("#hidden").hide();getTime(chooseEmp);
		})
		function freshPickDateTB(){
			$("button[name='pickdate']").each(function(){
					$(this).css('display','none');
					$(this).prop('disabled',false);
					$(this).attr("id","").children().remove();
					$(this).removeClass("btn-secondary");
					$(this).removeClass("btn-warning");
			})
		}
		
		//初始
			$("#month").html("<span>"+currentYear+"年"+currentMonth+"月</span>")
			for(let i = 1;i<=currentTotalDay;i++){
				let pickdate = currentYear+"-"+currentMonth+"-"+(i);
				let compare = currentYear+"-"+currentMonth+"-"+(i+1);
				$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
				if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
					$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
				}
				$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
				currentMonthFirstDay = currentMonthFirstDay+1;
			}
		}
		//判斷幾天 包含閏年天數
		function judgeDay(year,month){
			let maybe =["28","29","30","31","32"];
			let recordMonth = month;
			for(let i=0;i<maybe.length;i++){
				let judgemonth = new Date(year+"-"+month+"-"+maybe[i]);
				if((judgemonth.getMonth()+1)!=month || "Invalid Date"==judgemonth){
					return maybe[i-1];
				}
			}
		} 
		//生成時段前 隱藏
		$("#hidden").hide();
		
		function spantime(){
			$("#timetitle").attr('colspan','8');
			$("button[name='picktime']").each(function(index){
				
				$(this).css('display','block');
				$(this).html("<p>時段"+index+"</p>");
			})
			$("#hidden").show();
		}
			
		//預約訂單	
		let listNewRooVieApp= 'listNewRooVieApp';
		  refresh(listNewRooVieApp);
          function refresh(listNewRooVieApp){
        	  $.ajax({
            	  url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
            	  type:'post',
            	  data:{
            		  action:listNewRooVieApp,
            	  },
            	  success:function(list){
    					for(let key in list){
    						let str = '<tr id=\"'+key+'\">';
    						str+='<th><button class=\'btn btn-outline-secondary btn-sm reassign\' >所有申請</button></th>';
    						str+="<th><button class=\'btn btn-outline-secondary btn-sm assign\' >尚未指派預約申請</button></th>";
    						str+="<th class='text-primary'>"+getHouse(key).hos_name+'</th>';
    						str+='<th>'+dateformat(list[key])+'</th>';
    						str+='<th>'+'<button class=\'btn btn-outline-secondary btn-sm controltime\' >'+'查看預約情況</button></th>';
    		        		str+='</tr>';
    		        		$("#showData").append(str);
    					}
    					$(".controltime").click(function(){
    						document.location.href="<%=request.getContextPath()%>/back-end/rooVieApp/controlTime.jsp?houseno="+$(this).parents('tr').attr("id");
    					})
    					//註冊物件編號 
    					$(".assign").click(function(){
    						let action = 'listallpickTime_noassign'
    						let thishouseno = $(this).parents('tr').attr('id');
    						showThisHouesApp(thishouseno,action);
    					});
    					$(".reassign").click(function(){
    						let action = 'listallpickTime'
    						let thishouseno = $(this).parents('tr').attr('id');
    						showThisHouesApp(thishouseno,action);
    					});
    					
    					//註冊可丟
    			        $(".target").droppable({
    			  	       accept: ".emp",
    			  	       drop: function(ev, vi) {
    			  				$(this).empty();
    			  	            var item = $(vi.draggable).clone();
    			  	            $(this).append(item);
    			  	           $(document.createElement('input')).attr({
    			              		'type':'hidden',
    			  	            	'name':'houseno',
    			  		            'value':$(this).parents("tr").attr("id")
    			  		       }) .appendTo(this);
    			  	          
    			  		  }
    			          
    			  		})
            	  }
              })
        	  
          }
          
         
       	function showThisHouesApp(thishouseno,action){
       		  //this --->click button assign
	       	 getThisHouseApp(thishouseno,action);
	       	 $("#test").modal('show');
	    }
       	//生成個別物件預約申請
       	function getThisHouseApp(assignnum,action){
			$.ajax({
	        	  url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
	        	  type:'post',
	        	  data:{
	        		  action:action,
	        		  houseno:assignnum,
	        	  },
	        	  async: false,
	        	  success:function(list){
	        		  if(list.length==0){
	        			  Swal.fire({
						    	icon:'error',
						    	confirmButtonColor:'lightblue',
						    	title:'該物件已全部指派'
						  })
	        		  }
	        		 $("#showthishouseapp").empty();
	        		total = list.length;
					pageMap = page(total,number);
					for(let i=0;i<list.length;i++){
						let key = list[i];
						
						let str = "<tr id=\'"+key.rva_no+"\'>";
						str+="<td class='target_single'></td>";
						str+="<td>"+key.rva_no+"</td>";
					  	str+="<td>"+key.mem_no+"</td>";
					  	str+="<td>"+key.hos_no+"</td>";
					  	str+="<td>"+(key.emp_no==0||key.emp_no=='undefined'?'未指派':empMap.get(key.emp_no))+"</td>";
					  	str+="<td>"+dateformat(key.rva_app_time)+"</td>";
					  	str+="<td>"+dateformat(key.rva_order_time)+"</td>";
					  	str+="</td>";
					  	
					  	$("#showthishouseapp").append(str);
					  	$(".target_single").droppable({
	    			  	       accept: ".emp",
	    			  	       drop: function(ev, vi) {
	    			  			$(this).empty();
	    			  	        var item = $(vi.draggable).clone();
	    			  	        $(this).append(item);
	    			  	        $(document.createElement('input')).attr({
	    			              		'type':'hidden',
	    			  	            	'name':'houseno',
	    			  		            'value':$(this).parents("tr").attr("id")
	    			  		    }) .appendTo(this);
	    			  	        //針對單筆訂單指派
	    			  		    $.ajax({
	    			  		    	url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
	    			  		    	type:'post',
	    			  		    	data:{
	    			  		    		'action':'changeEmp',
	    			  		    		'emp_no':$(vi.draggable).children().attr('value'),
										'rva_no':$(this).parents().attr('id'),
	    			  		    	},
	    			  		    	success:function(result){
	    			  		    		//show change Emp
	    			  		    		let noticeemp = getEmp($(vi.draggable).children().attr('value'))+"已被指派處理 預約申請"
	    			  		    		pick(noticeemp);
	    			  		    		let empkey = $(vi.draggable).children().attr('value');
	    			  		    		$("#"+result).children().eq(4).html(empMap.get(parseInt(empkey)));
	    			  		    	}
	    			  		    });  
	    			  		  },
	    			  		 
	    			  	})
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
        	 return year+"年"+month+"月"+date+"日" +" <br>"+isAm+hour%12+"時"
//         	 +minutes+"分"+second+"秒";
          }

          $.ajax({
				url:"<%=request.getContextPath()%>/HouseJsonServlet",
				type:'post',
				data:{
					action:'getAllEmp',
				},
				async: false,
				success:function(str){
					for(let obj of str){
						emp.push(obj);
						empMap.set(obj.emp_no,obj.emp_name)
					}
					
				}
		})

		
		for(let obj of emp){
			let empString = "<button class='emp btn btn-info btn-sm'>"+obj.emp_no+" "+obj.emp_name+"";
			empString+="<input type='hidden' name='emp_no' value='"+obj.emp_no+"'></button>&nbsp; ";
			$("#freeEmp").append(empString);
			$("#freeEmp_single").append(empString);
		}
        $(".emp").css('margin','5px auto');
        $(".emp").draggable({
			cancel:false,//取消button預設的click事件 才不會事件傳遞 導致不能draggable
		    helper: 'clone',
		    opacity: 0.35,
		});
		$(".emp").click(function(){
			chooseEmp=$(this).children().attr('value');
			$("#hidden").hide();
			getTime(chooseEmp);
			$("button[name='pickdate']").not('.btn-warning').click(function(){
				$("#hidden").hide();
				$('.btn-secondary').each(function(){
					$(this).removeClass('btn-secondary');
				})
			})
		})
		function getTime(chooseEmp){
			$.ajax({
				url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
				type:'post',
				data:{
					action:'getEmpApp',
					emp_no:chooseEmp,
				},
				success:function(empapplist){
					let list = empapplist;
					$("button[name='pickdate']").each(function(index){
						
						for(let empapp of list){
							let tempjudge = compareDate($(this).attr('id'),empapp.rva_order_time)==0;
							
							if(tempjudge){
								$(this).addClass('btn-warning');
								$(this).click(function(e){
									
									spantime();
									
									
									$("button[name='picktime']").each(function(index){
										if(new Date(empapp.rva_order_time).getHours()==index){
											console.log(index);
											console.log($(this).html())
											$(this).addClass('btn-secondary');
											$("#hidden").show();
										}
									})
								})
							}
							
						}
					})
					
					
					$("#empapp").modal('show');
					$('#empapp').on('hidden.bs.modal', function (e) {
						$("button[name='pickdate']").each(function(){
							$(this).removeClass("btn-warning");
// 							$(this).unbind();//取消傳遞
						})
					})
// 					$("button[name='pickdate']").click(function(){
// 						spantime();
// 					})
				}
			})
		}
		//判斷日期是否相同
		function compareDate(date1,date2){
			return new Date(date1).setHours(0, 0, 0, 0)-new Date(date2).setHours(0, 0, 0, 0);
		}
		function getEmp(emp){
			let name= '';
			$.ajax({
				url:"<%=request.getContextPath()%>/HouseJsonServlet",
				type:'post',
				data:{
					action:'getEmpName',
					empno:emp,
				},
				async:false,
				success:function(str){
					name=str.emp_name;
				}
					
			})
			return name;
		}
		function getHouse(hos_no){
			let hosvo={};
			$.ajax({
				url:'<%=request.getContextPath()%>/RenConCRUDServlet',
				type: 'post',
				data:{
					action:'getOneHouse',
					houseno:hos_no,
				},
				async:false,
				success:function(hos){
					hosvo= hos;
				}
			})
			return hosvo;
		}
    </script>	
</body>

</html>
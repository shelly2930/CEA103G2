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
					<h1 class="h3 mb-2 text-gray-800">平台管理員</h1>
                    	<p class="mb-4">物件上下架處理</p>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <a href="${pageContext.request.contextPath}/house/houseAdm.do?action=listAllHouseByState&state=0&status=2">
<!--                        電腦邏輯判斷為(A且B)或C -->
                            <button class="btn-sm btn btn${not empty list &&list.get(0).hos_state==0||param.state==0?'':'-outline'}-info">	
                            	未上架案件
                            </button>
                            </a>
                            <a href="${pageContext.request.contextPath}/house/houseAdm.do?action=listAllHouseByState&state=1&status=2">
                           	<button class="btn-sm btn btn${not empty list && list.get(0).hos_state==1||(param.state==1)?'':'-outline'}-info">上架中
                            </button>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/house/houseAdm.do?action=listAllHouseByState&state=2&status=2">
                            <button class="btn-sm btn btn${not empty list && list.get(0).hos_state==2||param.state==2?'':'-outline'}-info">重新上架
                            </button>
                            </a>
                            
                            
                            <a href="${pageContext.request.contextPath}/house/houseAdm.do?action=listAllHouseByState&state=3&status=2">
                            <button class="btn-sm btn btn${not empty list && list.get(0).hos_state==3||param.state==3?'':'-outline'}-info">過期案件
                            </button>
                            </a>
                            
                            
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>物件編號</th>
                                            <th ${empty list || list.get(0).hos_state==1 || list.get(0).hos_state==3?"style='display:none'":""}>上架</th>
                                            <th ${empty list || list.get(0).hos_state==0 || list.get(0).hos_state==2|| list.get(0).hos_state==3?"style='display:none'":""}>下架</th>
                                            <th>刊登狀態</th>
                                            <th>刊登日期</th>
                                            <th>編輯照片</th>
                                            <th>編輯內文</th>
                                            <th>物件名稱</th>
                                            <th>介紹</th>
                                            <th>員工編號 </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="houseVO" items="${list}" varStatus="counter">
                                        <tr id="${houseVO.hos_no}" ${not empty param.houseno && (param.houseno==houseVO.hos_no) ?"class='border-left-primary'":""}>
                                            <th>
                                            <a href="" data-toggle="modal" data-target="#a">
					 						 SHOW 物件
                                            ${houseVO.hos_no}</a>
                                            </th>
                                            <th ${empty list || list.get(0).hos_state==1 || list.get(0).hos_state==3?"style='display:none'":""}>
                                            
                                            <a href="<%=request.getContextPath()%>/house/houseAdm.do?action=pushHouse&houseno=${houseVO.hos_no}">
                                            <button class="btn btn-sm btn-warning">上架
                                            </button>
                                            </a>
                                            
                                            </th>
                                            <th ${empty list || list.get(0).hos_state==0 || list.get(0).hos_state==2|| list.get(0).hos_state==3?"style='display:none'":""}>
                                            
                                            <a href="<%=request.getContextPath() %>/house/houseAdm.do?action=pullHouse&houseno=${houseVO.hos_no}&housedate=${houseVO.hos_date}">
                                            <button class="btn btn-sm btn-warning">下架
                                            </button>
                                            </a>
                                            </th>
                                            <th>${houseVO.hos_state==0?'未處理':''}${houseVO.hos_state==1?'上架中':''}${houseVO.hos_state==2?'下架中':''}</th>
                                             <th name="dateformat">${houseVO.hos_date}</th>
                                             
                                             <th>
                                             <a href="<%=request.getContextPath() %>/house/house.do?action=listHouPhoEmp&houseno=${houseVO.hos_no}">
                                             <button class="btn btn-sm btn-secondary">照片管理
                                             </button>
                                             </a>
                                             
                                             </th>
                                             <th>
                                             
                                             <a href="<%=request.getContextPath() %>/house/houseAdm.do?action=changeContent&houseno=${houseVO.hos_no}&state=${houseVO.hos_state}&status=${houseVO.hos_status}">
                                             <button class="btn btn-primary btn-sm">編輯內文</button></a>
                                             
                                             </th>
                                            <th>
                                            <button type="button" id="title" class="btn btn-primary btn-sm"  data-toggle="modal" data-target="#exampleModal">
				  							物件標題
											</button>
                                            </th>
                                            <th>
                                            <button type="button" id="content" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#exampleModal">
				  							物件內文
											</button>
                                            </th>
                                            <th>${houseVO.emp_no}</th>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>	

                </div>
                <!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
               
				
				<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">物件標題</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        	<span id="show" style="white-space: pre-wrap;">
				        	</span>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!--　　　↑↑↑↑↑↑↑↑↑↑彈出↑↑↑↑↑↑↑↑↑↑　　　-->
				
				<!--　　　↑↑↑↑↑↑↑↑↑↑彈出窗↑↑↑↑↑↑↑↑↑↑　　　-->
					<!-- Button trigger modal -->
					
					<!-- Modal -->
					<div class="modal fade" id="a" tabindex="-1" role="dialog" aria-labelledby="#b" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="b">Modal title</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					      <table class="table table-bordered">
					      	<thead>
                            <tr>
                               <th>物件編號</th>
                               <th>刊登狀態</th>
                            </tr>
                            </thead>
					        <tbody id="showOneHouse">
                            <tr>
                            </tr>
                            </tbody>
                           </table>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					        <button type="button" class="btn btn-primary">Save changes</button>
					      </div>
					    </div>
					  </div>
					</div>
				 <!--　　　↑↑↑↑↑↑↑↑↑↑彈出窗↑↑↑↑↑↑↑↑↑↑　　　-->
				
				
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
    
	<script>
	
	
// 	日期格式化
		$(function(){
			$("th[name='dateformat']").each(function(){
				let date = new Date($(this).html());
	            let dateFormat = date.getFullYear()+'年'+(date.getMonth()+1)+'月'+date.getDate()+'日 '+(date.getHours())+'時'+date.getMinutes()+'分';
	            $(this).html(dateFormat);
			})
		})
		$("button[id='content']").click(function(){
			let hos_no = $(this).parents("tr").attr("id");
			$.get({
				url:"<%=request.getContextPath()%>/HouseJsonServlet",
				type:"post",
				data:{
					action:'getOneHouse',
					houseno:hos_no,
				},
				success:function(jsonStr){
					$("#exampleModalLabel").html('<p>物件內文</p>');
					$("#show").prepend(jsonStr.hos_info);
				}
			});
		})
		
		$("button[id='title']").click(function(){
			let hos_no = $(this).parents("tr").attr("id");
			$.get({
				url:"<%=request.getContextPath()%>/HouseJsonServlet",
				type:"post",
				data:{
					action:'getOneHouse',
					houseno:hos_no,
				},
				success:function(jsonStr){
					$("#exampleModalLabel").html('<p>物件標題</p>')
					$("#show").prepend(jsonStr.hos_name);
				}
			});
		})
		
		let house_value = ['hos_no',
			'lld_no',
			'hos_name',
			'hos_rent',
			'hos_expense',
			'hos_date',
			'hos_views',
			'hos_city',
			'hos_dist',
			'hos_address',
			'hos_lon',
			'hos_lat',
			'hos_type',
			'hos_info',
			'hos_age',
			'hos_floor',
			'hos_ele',
			'hos_parking',
			'hos_pet',
			'hos_cook',
			'hos_squares',
			'hos_gender',
			'hos_water',
			'hos_power',
			'hos_internet',
			'hos_apptime',
			'hos_order_date',
			'emp_no',
			'hos_status',
			'hos_result',
			'hos_loc_pic',
			'hos_state',
			'hos_refuse'];
		
		let house_key = ['物件編號',
			'房東編號',
			'物件名稱',
			'物件租金',
			'管理費',
			'刊登日期',
			'瀏覽次數',
			'縣市',
			'鄉鎮[市]區',
			'地址',
			'經度',
			'緯度',
			'房型',
			'介紹',
			'屋齡',
			'樓層',
			'電梯與否',
			'停車位與否',
			'寵物與否',
			'煮飯與否',
			'坪數',
			'性別限制',
			'水費/一度',
			'電費/一度',
			'網路費',
			'申請時間',
			'預約時間',
			'員工編號',
			'申請進度',
			'審核結果',
			'所有權狀照片',
			'刊登狀態',
			'未通過原因'];
		$("a[data-toggle='modal']").click(function(){
			$("#b").text('編號'+$(this).parent().parent().attr('id')+'物件詳請');
			$.ajax({
				url:"<%=request.getContextPath()%>/HouseJsonServlet",
				type:"post",
				data:{
					action:'getOneHouse',
					houseno:$(this).parent().parent().attr('id'),
				},
				success:function(jsonStr){
					for(let i =0;i<house_key.length;i++){
						$("#showOneHouse tr:last-child").after('<tr><th>'+house_key[i]+'</th><th>'+jsonStr[house_value[i]]+'</th></tr>');
					}
				}
				});
		})
	
 		
 </script>
	

</body>

</html>
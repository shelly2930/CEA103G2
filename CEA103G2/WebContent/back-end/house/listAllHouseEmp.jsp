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

                <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">服務代管-申請處理</h1>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            
                            <a href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp&hos_status=0&hos_state=0">
			   				 <button type="button" class="btn-sm btn btn-outline-info">員工-未處理案件</button>
							</a>
							<a href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp&hos_status=1&hos_state=0">
			    			 <button type="button" class="btn-sm btn btn-outline-info">員工-處理中案件</button>
							</a>
							<a href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp&hos_status=2">
			     			<button type="button" class="btn-sm btn btn-outline-info">員工-已結束案件</button>
							</a>
							<a href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp&hos_status=3&hos_state=0">
			   				 <button type="button" class="btn-sm btn btn-outline-info">員工-已廢棄案件</button>
							</a>
                         
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                            	<form action="<%=request.getContextPath()%>/house/house.do">
                            	<%@ include file="pages/page1.file"%>	
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr id='num'>
                                            <th scope="col" id="put" >上架</th>
                                            <th scope="col">物件編號</th>
                                            <th scope="col" ${param.hos_status==2||param.hos_status==3||param.action=='changeHouseStatus'?"style='display:none'":''}>修改物件</th>
                                            
											<th scope="col">負責員工</th>
                                            <th scope="col">房東姓名</th>
											<th scope="col">所有權狀照片</th>
											<th scope="col">申請時間</th>
											<th scope="col">預約時間</th>
											<th scope="col">申請進度</th>
                                            <th scope="col">聯絡方式</th>
                                        </tr>
                                    </thead>
                                    
                                    <tbody id='check'>
                                        <c:forEach var="houseVO" items="${listAllHouse_Backend_list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="counter">
											<c:if test="${houseVO.emp_no == employeeVO.emp_no}">
												<tr id ="${houseVO.hos_no}">
													<td  style="${houseVO.hos_status == 0 || houseVO.hos_status == 2 || houseVO.hos_status == 3 ?'display:none':''}">
														<label for="${houseVO.hos_no}input">CLICK ME!
														<input type="checkbox" id="${houseVO.hos_no}input" name="houseno" value="${houseVO.hos_no}">
														</label>
													</td>
													
													<td>
														<h3>${houseVO.hos_no}</h3>
													</td>
													
													<td  ${param.hos_status==2||param.hos_status==3||param.action=='changeHouseStatus'?"style='display:none'":""}>
														<a href="<%=request.getContextPath()%>/house/house.do?action=getOneHouseForUpdate&houseno=${houseVO.hos_no}&requestURL=<%=request.getRequestURL()%>">
														<button type="button"   class="btn-sm btn ${houseVO.hos_state==1?'btn-outline-danger':'btn-outline-info'}">修改物件</button></a>
													</td>
													
													<td class='emp'>${houseVO.emp_no}</td>
													
													<td class='lld'>${houseVO.lld_no}</td>
													
													<td>${'所有權狀照片'}<img src="<%=request.getContextPath()%>/house/houseImg.do?action=getOneContractImg&houseno=${houseVO.hos_no}" width="100px"></td>
													
													<td class='time'>${houseVO.hos_apptime}</td>
													
													<td class='time'>${houseVO.hos_order_date}</td>
													
													<td>
														<c:choose>
															<c:when test="${houseVO.hos_status==0}">未處理案件</c:when>
															<c:when test="${houseVO.hos_status==1}">處理中案件</c:when>
															<c:when test="${houseVO.hos_status==2}">已完成案件</c:when>
															<c:when test="${houseVO.hos_status==3}">廢棄案件</c:when>
														</c:choose>
													</td>
													<td>
														<a  class='contact btn btn-info btn-sm'>聯絡方式</a>
													</td>
												</tr>
											</c:if>
									</c:forEach>
                                    </tbody>
                                    
                                    <tfoot>
                                        <tr>
                                         
                                        </tr>
                                    </tfoot>
                                   
                                </table>
                                	 <input type="hidden" name="action" value="changeHouseStatus">
									<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
									<input type='submit' class='btn btn-outline-primary btn-sm' value='確認送出'>
									<input type='submit' class='btn btn-outline-primary btn-sm' value='案件廢棄'><hr>
									
									</form>
								<%@ include file="pages/page3.file"%>
                            </div>
                        </div>
                    </div>

                </div>
                
                <!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
				

            </div>
            <!-- End of Main Content -->
			<div class="modal fade" id="click" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">聯絡資訊</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body" >
			      			<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th scope="col">房東編號</th>
                                            <th scope="col">房東姓名</th>
											<th scope="col">連絡電話</th>
                                            <th scope="col">地址</th>
											<th scope="col">信箱</th>
                                        </tr>
                                    </thead>
                                    <tbody id='showcontract'>
                                    	
                                    </tbody>
                          </table>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			      </div>
			    </div>
			  </div>
			</div>
            <!-- Footer -->
            <%@include file="/back-end/includeFile/footerBack.file"%>

        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->
	<script src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!--     Core plugin JavaScript -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

<!--     Custom scripts for all pages -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

<!--     Page level plugins -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>
    <%@include file="/back-end/includeFile/otherBack.file" %>
    
  
    
    
<!--     Bootstrap core JavaScript -->
   

<!--     Page level custom scripts -->
 <script>
 			$(".contact").click(function(){
 				$("#showcontract").empty();
 				let hosnum = $(this).parents('tr').attr('id');
 				let address = getHos(hosnum).hos_address;
 				let lld = getHos(hosnum).lld_no;
 				let mem =getlld(lld).mem_no;
 				let str = "<tr>";
 				str+="<td scope='col'>"+lld+"</td>";
 				str+="<td scope='col'>"+getMem(mem).mem_name+"</td>";
 				str+="<td scope='col'>"+getMem(mem).mem_mobile+"</td>";
 				str+="<td scope='col'>"+address+"</td>";
 				str+="<td scope='col'>"+getMem(mem).mem_email+"</td>";
 				str+="</tr>";
 				$("#showcontract").append(str);
 				$("#click").modal('show');
 			})
			if($("#check").children().length==0){
				let str = "<tr><th class='text-center' colspan='"+$("#num").children().length+"'>查無案件</th></tr>";
				$("#check").append(str);
			}
			$(document).ready(function(){
				$(".hidden").hide();
				$(".show").show;
				$(".show").click(function(){
					$(".hidden").css("color","blue");
					$(this).siblings("p").show();
					$(this).hide();
				})
				$(".hidden").click(function(){
					$(this).hide();
					$(this).siblings("div").show();
				})
				$("input[value='案件廢棄']").click(function(){
					$(this).before("<input type='hidden' name='delete' value='3'>");
				})
				if(${(empty listAllHouse_Backend_list)||(listAllHouse_Backend_list[0].hos_status!='1')}){
					$("#put").attr("style",'display:none');
					$("input[value='確認送出']").attr("style",'display:none');
					$("input[value='案件廢棄']").attr("style",'display:none');
				}
				//參考 未完善功能
				${empty houseno_list ? '' :"let list="+=houseno_list+=";for(let h of list){let x= '#'+h;$(x).css('background-color','#D6D6FF');}"}
			})
			$(".emp").each(function(){
				let empno = $(this).text();
				$(this).text(getEmp(empno));
			})
			$(".lld").each(function(){
				let lld = $(this).text();
				$(this).text(getMem(getlld(lld).mem_no).mem_name);
			})
			$(".time").each(function(){
				let time = $(this).text();
				$(this).text(dateformat(time));
			})
			function getlld(lld_no){
				let lldvo={}
				$.ajax({
					url:"<%=request.getContextPath()%>/HouseJsonServlet",
					type:'post',
					data:{
						action:'getLanlord',
						'lld_no':lld_no,
					},
					async:false,
					success:function(data){
						for(let key in data){
							lldvo[key]=data[key];
						}
					}
				})
				return lldvo;
			}
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
					}
				})
				return mem;
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
			</script>
</body>
  			
</html>
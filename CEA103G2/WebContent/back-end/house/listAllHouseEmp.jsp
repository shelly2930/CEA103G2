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

    <title>��x�ŭ�</title>

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

                <!--�@�@�@�����������������������e���������������������@�@�@-->
                <div class="container-fluid">

                <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">�A�ȥN��-�ӽгB�z</h1>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            
                            <a href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp&hos_status=0&hos_state=0">
			   				 <button type="button" class="btn-sm btn btn-outline-info">���u-���B�z�ץ�</button>
							</a>
							<a href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp&hos_status=1&hos_state=0">
			    			 <button type="button" class="btn-sm btn btn-outline-info">���u-�B�z���ץ�</button>
							</a>
							<a href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp&hos_status=2">
			     			<button type="button" class="btn-sm btn btn-outline-info">���u-�w�����ץ�</button>
							</a>
							<a href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp&hos_status=3&hos_state=0">
			   				 <button type="button" class="btn-sm btn btn-outline-info">���u-�w�o��ץ�</button>
							</a>
                         
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                            	<form action="<%=request.getContextPath()%>/house/house.do">
                            	<%@ include file="pages/page1.file"%>	
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th scope="col" id="put" >�W�[</th>
                                            <th scope="col">����s��</th>
                                            <th scope="col" ${param.hos_status==2||param.hos_status==3||param.action=='changeHouseStatus'?"style='display:none'":''}>�ק磌��</th>
                                            
											<th scope="col">�t�d���u</th>
                                            <th scope="col">�ЪF�m�W</th>
											<th scope="col">�Ҧ��v���Ӥ�</th>
											<th scope="col">�ӽЮɶ�</th>
											<th scope="col">�w���ɶ�</th>
											<th scope="col">�ӽжi��</th>
											<th scope="col">���q�L��]</th>
                                            
                                        </tr>
                                    </thead>
                                    
                                    <tbody>
                                        <c:forEach var="houseVO" items="${listAllHouse_Backend_list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="counter">
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
												<button type="button"   class="btn-sm btn ${houseVO.hos_state==1?'btn-outline-danger':'btn-outline-info'}">�ק磌��</button></a>
											</td>
											
											<td>${houseVO.emp_no}</td>
											
											<td>${houseVO.lld_no}</td>
											
											<td>${'�Ҧ��v���Ӥ�'}<img src="<%=request.getContextPath()%>/house/houseImg.do?action=getOneContractImg&houseno=${houseVO.hos_no}" width="100px"></td>
											
											<td>${houseVO.hos_apptime}</td>
											
											<td>${houseVO.hos_order_date}</td>
											
											<td>
												<c:choose>
													<c:when test="${houseVO.hos_status==0}">���B�z�ץ�</c:when>
													<c:when test="${houseVO.hos_status==1}">�B�z���ץ�</c:when>
													<c:when test="${houseVO.hos_status==2}">�w�����ץ�</c:when>
													<c:when test="${houseVO.hos_status==3}">�o��ץ�</c:when>
												</c:choose>
											</td>
											
											<td>
												<c:choose>
													<c:when test="${houseVO.hos_refuse.trim().length()==0||houseVO.hos_refuse==null}">����</c:when>	
													<c:when test="${houseVO.hos_refuse.trim().length()!=0}">
														${houseVO.hos_refuse}
													</c:when>			
												</c:choose>
											</td>
											
										</tr>
									</c:forEach>
                                    </tbody>
                                    
                                    <tfoot>
                                        <tr>
                                         
                                        </tr>
                                    </tfoot>
                                   
                                </table>
                                 <input type="hidden" name="action" value="changeHouseStatus">
									<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
									<input type="submit" class="btn btn-primary" value="�T�{�e�X">
									<input type="submit" class="btn btn-primary" value="�ץ�o��">
									</form>
								<%@ include file="pages/page3.file"%>
                            </div>
                        </div>
                    </div>

                </div>
                <!--�@�@�@�����������������������e���������������������@�@�@-->

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

<!--     Page level custom scripts -->
 
			<script>
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
				$("input[value='�ץ�o��']").click(function(){
					$(this).before("<input type='hidden' name='delete' value='3'>");
					alert($("input[name='delete']").html());
				})
				if(${(empty listAllHouse_Backend_list)||(listAllHouse_Backend_list[0].hos_status!='1')}){
					$("#put").attr("style",'display:none');
					$("input[value='�T�{�e�X']").attr("style",'display:none');
					$("input[value='�ץ�o��']").attr("style",'display:none');
				}
				//�Ѧ� �������\��
				${empty houseno_list ? '' :"let list="+=houseno_list+=";for(let h of list){let x= '#'+h;$(x).css('background-color','yellow');}"}
			})
			</script>
</body>
  			
</html>
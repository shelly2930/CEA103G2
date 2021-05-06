<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ page import="java.util.*"%>
<%@ page import="com.houPho.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>��x�ŭ�</title>
	<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	
		<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
	
    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
	
    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
		
		<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js" integrity="sha256-0YPKAwZP7Mp3ALMRVB2i8GXeEndvCq3eSl/WsAl1Ryk=" crossorigin="anonymous"></script>
	
		<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
	
	
	
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
                    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                    <p class="mb-4"><p>�I�u����  1.�٤��୫�s���� 2.�h���ٯ� �P�ɫ���3.�٭n�h����s�A�����w�����Υ�����
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                            
                            	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/house/house.do" style="margin-bottom: 0px;">
                            	<%@ include file="pages/page1.file"%>	
                            	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            				<div id="freeEmp">
										<!-- 	����i�H��js�Ѯv�@�~���H���C��CXD -->
												<button class="emp btn btn-info" style="background-color:#6E6EFF" type="button">
													<p style="color:#0000AD">�q�F</p>
													<input type="number" name="emp_no" 	value="10" style="width:50px">
												</button>
												<button class="emp btn btn-info" style="background-color:#00EBEB" type="button">
													<p style="color:#0000AD">�F�n</p>
													<input type="number" name="emp_no" 	value="20" style="width:50px">
												</button>
												<button class="emp btn btn-info" style="background-color:#FF96FF" type="button">
													<p style="color:#0000AD">���v</p>
													<input type="number" name="emp_no" 	value="30" style="width:50px">
												</button>
												<button class="emp btn btn-info" style="background-color:#8CFF8C" type="button">
													<p style="color:#0000AD">���</p>
													<input type="number" name="emp_no" 	value="40" style="width:50px">
												</button>
												<button class="emp btn btn-info" style="background-color:#FF7878" type="button">
													<p style="color:#0000AD">����</p>
													<input type="number" name="emp_no" 	value="50" style="width:50px">
												</button>
											</div>
                            	</table>
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th scope="col">(�ק�)�������u</th>
											<th scope="col">����s��</th>
											<th scope="col">�t�d���u</th>
											<th scope="col">�ЪF�m�W</th>
							<!-- �O��				================================================= -->				
											<th scope="col">���󯲪�</th>
											<th scope="col">�޲z�O</th>
							<!-- �޲z				================================================= -->				
											<th scope="col">�ӽЮɶ�</th>
											<th scope="col">�w���ɶ�</th>
							<!-- ��				================================================= -->
                                        </tr>
                                    </thead>
                                    
                                    <tbody>
                                    	<c:forEach var="houseVO" items="${listAllHouse_Backend_list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="counter">
                                        <tr id ="${houseVO.hos_no}">
                                            <td class="target">
                                            <div>
				    						</div>
				    						</td>
                                            <td>${houseVO.hos_no}</td>
											<td>${houseVO.emp_no}</td>
											<td>${houseVO.lld_no}</td>
                                            <td>${houseVO.hos_rent}</td>
											<td>${houseVO.hos_expense}</td>
                                            <td>${houseVO.hos_apptime}</td>
											<td>${houseVO.hos_order_date}</td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <input type="submit" class="btn btn-primary" style="background-color:#9999FF" value="�������u">
								<input type="hidden" name="whichPage"	value="<%=whichPage%>">
								<input type="hidden" name="listSize"	value="${listSize}">
								<input type="hidden" name="comeBack"	    value="listAllHouse_Backend">
								<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
								<input type="hidden" name="action"	    value="change_Emp">
                                </FORM>
                                <%@ include file="pages/page2.file"%>
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

    <%@include file="/back-end/includeFile/otherBack.file"%>
    
    


<!--     Custom scripts for all pages -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

<!--     Page level plugins -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

<!--     Page level custom scripts -->
	
	<script>
			$(document).ready(function(){
				let hoseno =  ${empty houseno_list ? '[]' : houseno_list};
				for(let i of hoseno){
					$("#"+i).css({
						"backgroundColor":"##BABABA",
						"color":"#0000B2"
						});
				}
				$(".emp").draggable({
					cancel:false,//����button�w�]��click�ƥ� �~���|�ƥ�ǻ� �ɭP����draggable
			        helper: 'clone'
			    });
			  
			    $(".target").droppable({
			        accept: ".emp",
			        drop: function(ev, vi) {
 			        	console.log($(vi.draggable).html());//�o�O��� ���u
 						console.log($(this).parents("tr").attr("id"));//��줸���s��
			            var item = $(vi.draggable).clone();
			            $(this).append(item);
			            $(document.createElement('input')).attr({
			            	'type':'hidden',
			            	'name':'houseno',
			            	'value':$(this).parents("tr").attr("id")
			            }) .appendTo(this);
			        }
			    })
			})
		</script>		
	
</body>

</html>
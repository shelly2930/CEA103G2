<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.lanlord.model.*"%>


<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>審核房東</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

	<!-- Custom styles for this page -->
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

                <!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
                <div class="container-fluid">
					
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<a href="${pageContext.request.contextPath}/lanlord/lanlord.do?action=findByLldStatus&lld_status=0">
                           	<button class="btn-sm btn btn${not empty list &&list.get(0).lld_status == 0 ? '' : '-outline'}-info">未審核
                            </button>
                            </a>
                            <a href="${pageContext.request.contextPath}/lanlord/lanlord.do?action=findByLldStatus&lld_status=1">
                           	<button class="btn-sm btn btn${not empty list &&list.get(0).lld_status == 1 ? '' : '-outline'}-info">通過
                            </button>
                            </a>
                            <a href="${pageContext.request.contextPath}/lanlord/lanlord.do?action=findByLldStatus&lld_status=2">
                           	<button class="btn-sm btn btn${not empty list &&list.get(0).lld_status == 2 ? '' : '-outline'}-info">未通過
                            </button>
                            </a>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>房東編號</th>
											<th>會員編號</th>
											<th>申請時間</th>
											<th>審核狀態</th>
											<th>通過時間</th>
											<th>審核</th>
<%-- 											<th ${empty list || list.get(0).lld_status == 1 ? "style='display:none'" : ""}>通過</th> --%>
<%--                                             <th ${empty list || list.get(0).lld_status == 2 ? "style='display:none'" : ""}>不通過</th> --%>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="lanlordVO" items="${list}">

											<tr>
												<td>${lanlordVO.lld_no}</td>
												<td>${lanlordVO.mem_no}</td>
												<td><fmt:formatDate value="${lanlordVO.lld_apptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>
													<c:choose>
														<c:when test="${lanlordVO.lld_status == 0}">未審核</c:when>
														<c:when test="${lanlordVO.lld_status == 1}">審核通過</c:when>
														<c:when test="${lanlordVO.lld_status == 2}">審核不通過</c:when>
														<c:when test="${lanlordVO.lld_status == 3}">停權</c:when>
													</c:choose>
												</td>
												<td><fmt:formatDate value="${lanlordVO.lld_id_isvrfed}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td align="center">
													<button type="submit" class="btn btn-outline-info" data-toggle="modal" data-target="#lanlordModal">審核</button>
												</td>
<%-- 												<td align="center"  ${empty list || list.get(0).lld_status == 1 ? "style='display:none'" : ""}> --%>
<!-- 													<FORM METHOD="post" -->
<%-- 														ACTION="<%=request.getContextPath()%>/lanlord/lanlord.do?action=updateStatus&lld_status=1" --%>
<!-- 														style="margin-bottom: 0px;"> -->
<!-- 														<button type="submit" class="btn btn-outline-info">通過</button> -->
<%-- 														<input type="hidden" name="lld_no" value="${lanlordVO.lld_no}"> --%>
<!-- 														<input type="hidden" name="action" value="updateStatus"> -->
<!-- 													</FORM> -->
<!-- 												</td> -->
<%-- 												<td align="center"  ${empty list || list.get(0).lld_status == 2 ? "style='display:none'" : ""}> --%>
<!-- 													<FORM METHOD="post" -->
<%-- 														ACTION="<%=request.getContextPath()%>/lanlord/lanlord.do?action=updateStatus&lld_status=2" --%>
<!-- 														style="margin-bottom: 0px;"> -->
<!-- 														<button type="submit" class="btn btn-outline-info">不通過</button> -->
<%-- 														<input type="hidden" name="lld_no" value="${lanlordVO.lld_no}"> --%>
<!-- 														<input type="hidden" name="action" value="updateStatus"> -->
<!-- 													</FORM> -->
<!-- 												</td> -->
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
                	

                </div>
                <!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

            </div>
            <!-- End of Main Content -->

<!--  Modal-->
    <div class="modal fade" id="lanlordModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">房東申請詳情</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                	<jsp:include page="authOneLanlord.jsp"/>
                </div>
                <div class="modal-footer">
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/lanlord/lanlord.do?action=updateStatus&lld_status=2">不通過</a>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/lanlord/lanlord.do?action=updateStatus&lld_status=1">通過</a>
                </div>
            </div>
        </div>
    </div>
<!--  Modal-->

<script>
// $("a[data-toggle='modal']").click(function(){
// 	$.ajax({
<%-- 		url:"<%=request.getContextPath()%>/HouseJsonServlet", --%>
// 		type:"post",
// 		data:{
// 			action:'getOneHouse',
// 			houseno:$(this).parent().parent().attr('id'),
// 		},
// 		success:function(jsonStr){
// 			for(let i =0;i<house_key.length;i++){
// 				$("#showOneHouse tr:last-child").after('<tr><th>'+house_key[i]+'</th><th>'+jsonStr[house_value[i]]+'</th></tr>');
// 			}
// 		}
// 		});
// })
</script>

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
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/datatables-demo.js"></script>
     
</body>

</html>
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

    <title>�f�֩ЪF</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

	<!-- Custom styles for this page -->
	<link href="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<style>
#lld_no {
	border:0px;	
}
img.lld_acc_pic {
  	height: 200px;
  	width: auto;
  }
</style>
	
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
					
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<a href="${pageContext.request.contextPath}/lanlord/lanlord.do?action=findByLldStatus&lld_status=0">
                           	<button class="btn-sm btn btn${not empty list &&list.get(0).lld_status == 0 ? '' : '-outline'}-info">���f��
                            </button>
                            </a>
                            <a href="${pageContext.request.contextPath}/lanlord/lanlord.do?action=findByLldStatus&lld_status=1">
                           	<button class="btn-sm btn btn${not empty list &&list.get(0).lld_status == 1 ? '' : '-outline'}-info">�q�L
                            </button>
                            </a>
                            <a href="${pageContext.request.contextPath}/lanlord/lanlord.do?action=findByLldStatus&lld_status=2">
                           	<button class="btn-sm btn btn${not empty list &&list.get(0).lld_status == 2 ? '' : '-outline'}-info">���q�L
                            </button>
                            </a>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>�ЪF�s��</th>
											<th>�|���s��</th>
											<th>�ӽЮɶ�</th>
											<th>�f�֪��A</th>
											<th>�q�L�ɶ�</th>
											<th>�f��</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="lanlordVO" items="${list}" varStatus="count">
											<tr ${(lanlordVO.lld_no==param.lld_no || lanlordVO.lld_no==lld_no) ? 'bgcolor=#eee' : '' }>
												<td>${lanlordVO.lld_no}</td>
												<td>${lanlordVO.mem_no}</td>
												<td><fmt:formatDate value="${lanlordVO.lld_apptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>
													<c:choose>
														<c:when test="${lanlordVO.lld_status == 0}">���f��</c:when>
														<c:when test="${lanlordVO.lld_status == 1}">�f�ֳq�L</c:when>
														<c:when test="${lanlordVO.lld_status == 2}">�f�֤��q�L</c:when>
														<c:when test="${lanlordVO.lld_status == 3}">���v</c:when>
													</c:choose>
												</td>
												<td><fmt:formatDate value="${lanlordVO.lld_id_isvrfed}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td><button class="btn-sm btn btn-info" onclick="showModal${lanlordVO.lld_no}()" value="">�f��</button></td>
												<!--  Modal  -->
												
												
												
												<td class="modal" tabindex="-1" role="dialog" id="Modal${lanlordVO.lld_no}">
												     <div class="modal-dialog" role="document"> 
												        <div class="modal-content">
												            <div class="modal-header">
												                <h5 class="modal-title">�f��</h5>
												                <button type="button" class="close" data-dismiss="modal" aria-label="Close">x</button> 
												            </div>
												            
												            <form method="post" action="<%=request.getContextPath()%>/lanlord/lanlord.do">
												            <div class="modal-body">
															
															<!-- authOneLanlord�̪����e -->
															<div class="table-responsive">
																<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
																		<tr>
																			<th>�ЪF�s��</th>
																			<td><input type="text" id="lld_no" name="lld_no" value="${lanlordVO.lld_no}"></td>
																		</tr>
																		<tr>
																			<th>�|���s��</th>
																			<td>${lanlordVO.mem_no}</td>
																		</tr>
																		<tr>
																			<th>�ӽЮɶ�</th>
																			<td><fmt:formatDate value="${lanlordVO.lld_apptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
																		</tr>
																		<tr>
																			<th>�Ȧ�N�X</th>
																			<td>${lanlordVO.lld_bank}</td>
																		</tr>
																		<tr>
																			<th>�״ڱb��</th>
																			<td>${lanlordVO.lld_account}</td>
																		</tr>
																		<tr>
																			<th>�b���ҩ�</th>
																			<td><img src="${pageContext.request.contextPath}/LanlordPicReadServlet?lld_no=${lanlordVO.lld_no}"  class="lld_acc_pic"></td>
																		</tr>
																		<tr>
																			<th>�f�֪��A</th>
																			<td>
																				<c:choose>
																					<c:when test="${lanlordVO.lld_status == 0}">���f��</c:when>
																					<c:when test="${lanlordVO.lld_status == 1}">�f�ֳq�L</c:when>
																					<c:when test="${lanlordVO.lld_status == 2}">�f�֤��q�L</c:when>
																					<c:when test="${lanlordVO.lld_status == 3}">���v</c:when>
																				</c:choose>
																			</td>
																		</tr>
																		<tr>
																			<th>�q�L�ɶ�</th>
																			<td><fmt:formatDate value="${lanlordVO.lld_id_isvrfed}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
																		</tr>
																		<tr>
																			<th>���q�L��]</th>
																			<td>
																				<input type="text" id="a${count.index}" class="aim" name="lld_id_disapprove" value="${lanlordVO.lld_id_disapprove}">
																			</td>
																		</tr>
																</table>
															</div>
										            		</div>
										            		<!-- authOneLanlord�̪����e -->
										            		
												            <div class="modal-footer">
<!-- 												                <input type="hidden" name="pass" value="pass"> -->
																<input type="submit" value="�q�L" name="pass">
												                
<!-- 												                <input type="hidden" name="fail" value="fail"> -->
																<input type="submit" value="���q�L" id="${count.index}" name="fail">
<%-- 												                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/lanlord/lanlord.do?action=fail&lld_status=2">���q�L</a> --%>
<%-- 											                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/lanlord/lanlord.do?action=pass&lld_status=1">�q�L</a> --%>
												            </div>
												            </form>
												       </div>
												     </div>
												</td>
												<script>
													function showModal${lanlordVO.lld_no}() {
														$('#Modal${lanlordVO.lld_no}').modal('show'); 
													}
												</script>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
                	

                </div>
                <!--�@�@�@�����������������������e���������������������@�@�@-->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
<%--             <%@ include file="/back-end/includeFile/footerBack.file" %> --%>

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

<%@ include file="/back-end/includeFile/footerBack.file" %>
    
    <script>
    let judge = false;
    $(".aim").change(function(){
		$(this).attr('value',this.value);
	})
    $("input[name='fail']").click(function(e){
    	let get= "#a"+$(this).attr('id');
		if(!$(get).val()){
			e.preventDefault();
			alert('�ж���');
		}
    })
    
    </script>
</body>

</html>
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

                    <form method="post" action="<%=request.getContextPath()%>/employee/employee.do">

						<div class="form-row">
						    <div class="form-group">
						      <label for="emp_username">���u�N��</label>
						      <input type="text" class="form-control" id="emp_username" name="emp_username" value="${employeeVO.emp_username}">
						    </div>
						</div>

						<div class="form-row">
						    <div class="form-group">
						    	<label for="emp_name">�m�W</label>
						      	<input type="text" class="form-control" id="emp_name" name="emp_name" value="${employeeVO.emp_name}">
						      	<div class="errorMsgs ${(errorMsgs.emp_name == null) ? "" : "border-left-warning"}">
									<small>${errorMsgs.emp_name}</small>
								</div>
						    </div>
						</div>
						
						<div class="form-group row">
							<label for="emp_email" class="col-md-2 col-form-label">�q�l�H�c</label>
							<div class="input-group col-md-5">
							  	<input type="text" class="form-control" id="emp_email" name="emp_email" value="${employeeVO.emp_email}">
							  	<div class="input-group-append">
							    		<button class="btn btn-secondary" type="button" id="sendEmail">���s�o�e�n�J�q��</button>
							  	</div>
							</div>
							<div class="col-md-5 errorMsgs ${(errorMsgs.emp_email == null) ? "" : "border-left-warning"}">
								<small id="emp_email-errorMsg">${errorMsgs.emp_email}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_job" class="col-md-2 col-form-label">¾��</label>
							<div class="col-md-5">
								<select class="form-control" id="emp_job" name="emp_job">
									<option value="" ${(employeeVO.emp_job eq "") ? "selected" : ""}>�п��</option>
									<option value="�@����u" ${(employeeVO.emp_job eq "�@����u") ? "selected" : ""}>�@����u</option>
									<option value="���x�޲z��" ${(employeeVO.emp_job eq "���x�޲z��") ? "selected" : ""}>���x�޲z��</option>
									<option value="�D��" ${(employeeVO.emp_job eq "�D��") ? "selected" : ""}>�D��</option>
								</select>
							</div>
							<div class="col-md-5 errorMsgs ${(errorMsgs.emp_job == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_job}</small>
							</div>
						</div>
						
						<div class="form-row">
						    <div class="form-group col-md-6">
						    	<label for="emp_sal">�~��</label>
						      	<input type="text" class="form-control" id="emp_sal" name="emp_sal" value="${employeeVO.emp_sal}">
						      	<div class="errorMsgs ${(errorMsgs.emp_sal == null) ? "" : "border-left-warning"}">
									<small>${errorMsgs.emp_sal}</small>
								</div>
						    </div>
						    <div class="form-group col-md-6">
						      	<label for="emp_bonus">�~��</label>
						      	<input type="text" class="form-control" id="emp_bonus" name="emp_bonus" value="${employeeVO.emp_bonus}">
						      	<div class="errorMsgs ${(errorMsgs.emp_bonus == null) ? "" : "border-left-warning"}">
									<small>${errorMsgs.emp_bonus}</small>
								</div>
						    </div>
						</div>
						
						<div class="form-group row">
							<label for="emp_hiredate" class="col-md-2 col-form-label">��¾��</label>
							<div class="col-md-5">
								<input type="date" class="form-control" id="emp_hiredate" name="emp_hiredate" value="${employeeVO.emp_hiredate}">
							</div>
							<div class="col-md-5 errorMsgs ${(errorMsgs.emp_hiredate == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_hiredate}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_quitdate" class="col-md-2 col-form-label">��¾��</label>
							<div class="col-md-5">
								<input type="date" class="form-control" id="emp_quitdate" name="emp_quitdate" value="${employeeVO.emp_quitdate}">
							</div>
							<div class="col-md-5 errorMsgs ${(errorMsgs.emp_quitdate == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_quitdate}</small>
							</div>
						</div>
						
						<div class="form-group row">
						    <div class="col-md-2">�v��</div>
						    <div class="col-md-10">
								<jsp:useBean id="StaFunService" scope="page" class="com.staFun.model.StaFunService" />
						    	<c:forEach var="StaFunVO" items="${StaFunService.allStaFun}" >
						    		<div class="form-check">
						          		<label class="form-check-label">
						          			<input class="form-check-input" type="checkbox" name="staFun" value="${StaFunVO.fun_no}" id="staFun${StaFunVO.fun_no}">
						          			${StaFunVO.fun_name}
						          		</label>
						          	</div>
						        </c:forEach>
						    </div>
						</div>
						
						<div class="form-group row mt-5 ml-3">
							<button id="sub" type="submit" class="btn btn-success btn-icon-split">
	                            <span class="icon text-white-50">
	                                <i class="fas fa-check"></i>
	                            </span>
	                            <span class="text">��s���u���</span>
	                        </button>
                        </div>

						<input type="hidden" name="action" value="updateBySup">
						<input type="hidden" name="emp_no" value="${employeeVO.emp_no}">
						<input type="hidden" id="emp_password" value="${employeeVO.emp_password}">
					</form>

                </div>
                <!--�@�@�@�����������������������e���������������������@�@�@-->

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
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
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

</body>

</html>
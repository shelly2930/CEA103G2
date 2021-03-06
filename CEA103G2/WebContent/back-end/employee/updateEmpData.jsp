<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>修改員工資料</title>

<!-- Custom fonts for this template-->
<link
	href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link
	href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css"
	rel="stylesheet">
<style>
	.errorMsgs {
		color: #1cc88a;
/* 		line-height: 36px; */
	}
	@media (min-width: 768px) {
		.col-form-label{
	 		text-align: right;
		}
	}
	.pageTitle{
		color: #d4dedd;
		letter-spacing: 1rem;
		text-shadow: 1px 1px 2px #233559;
	}
</style>
</head>

<body id="page-top">

	<!-- Bootstrap core JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>
		
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

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
					
					<div class="mx-auto text-center pageTitle">
				        <h1 class="mx-auto mb-4 text-uppercase">修改員工資料</h1>
				    </div>

					<form method="post" action="<%=request.getContextPath()%>/employee/employee.do" id="form1">

						<div class="form-group row">
							<label for="emp_username" class="col-md-4 col-form-label">員工代號</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="emp_username" name="emp_username" value="${employeeVO.emp_username}"  readonly>
<%-- 								<div class="form-control" id="emp_username" name="emp_username">${employeeVO.emp_username}</div> --%>
							</div>
							<div class="col-md-4"></div>
						</div>
						
						<div class="form-group row">
							<label for="emp_email" class="col-md-4 col-form-label">電子信箱</label>
							<div class="input-group col-md-4">
							  	<input type="text" class="form-control" id="emp_email" name="emp_email" value="${employeeVO.emp_email}">
							  	<div class="input-group-append">
							    		<button class="btn btn-secondary" type="button" id="sendEmail">重新發送登入通知</button>
							  	</div>
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_email == null) ? "" : "border-left-warning"}">
								<small id="emp_email-errorMsg">${errorMsgs.emp_email}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_job" class="col-md-4 col-form-label">職位</label>
							<div class="col-md-4">
								<select class="form-control" id="emp_job" name="emp_job">
									<option value="一般員工" ${(employeeVO.emp_job eq "一般員工") ? "selected" : ""}>一般員工</option>
									<option value="平台管理員" ${(employeeVO.emp_job eq "平台管理員") ? "selected" : ""}>平台管理員</option>
									<option value="主管" ${(employeeVO.emp_job eq "主管") ? "selected" : ""}>主管</option>
								</select>
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_job == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_job}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_sal" class="col-md-4 col-form-label">薪資</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="emp_sal" name="emp_sal" value="${employeeVO.emp_sal}">
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_sal == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_sal}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_bonus" class="col-md-4 col-form-label">獎金</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="emp_bonus" name="emp_bonus" value="${employeeVO.emp_bonus}">
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_bonus == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_bonus}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_hiredate" class="col-md-4 col-form-label">到職日</label>
							<div class="col-md-4">
								<input type="date" class="form-control" id="emp_hiredate" name="emp_hiredate" value="${employeeVO.emp_hiredate}">
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_hiredate == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_hiredate}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_quitdate" class="col-md-4 col-form-label">離職日</label>
							<div class="col-md-4">
								<input type="date" class="form-control" id="emp_quitdate" name="emp_quitdate" value="${employeeVO.emp_quitdate}">
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_quitdate == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_quitdate}</small>
							</div>
						</div>
						
						<div class="form-group row">
						    <div class="col-md-4 col-form-label">權限</div>
						    <div class="col-md-8">
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
						
						<div class="form-group row justify-content-center mt-3">
							<button id="sub" type="button" class="btn btn-success btn-icon-split">
	                            <span class="icon text-white-50">
	                                <i class="fas fa-check"></i>
	                            </span>
	                            <span class="text">修改員工資料</span>
	                        </button>
                        </div>

						<input type="hidden" name="action" value="updateBySup">
						<input type="hidden" name="emp_no" id="emp_no" value="${employeeVO.emp_no}">
					</form>

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

<script>

$("#sendEmail").click(function(){
	$.ajax({
		url: "${pageContext.request.contextPath}/employee/employee.do",
		type: "post",
		data: {
			action: "sendEmail",
			emp_no: $("#emp_no").val(),
			emp_email: $("#emp_email").val(),
			emp_username: $("#emp_username").val()
		},
		success: function(data){
			if(data === "發送成功"){
				$("#emp_email-errorMsg").parent().removeClass("border-left-warning");
				$("#emp_email-errorMsg").css("color", "#28a745");
			}else {
				$("#emp_email-errorMsg").parent().addClass("border-left-warning");
				$("#emp_email-errorMsg").css("color", "");
			}
			$("#emp_email-errorMsg").html(data);
		}
	});
});

// 如驗證失敗,keep原勾選的權限
<c:forEach var="fun_no" items="${paramValues.staFun}">
	$("#staFun${fun_no}").prop("checked", true);
</c:forEach>

// 預設職位會勾選的權限
$("#emp_job").change(function(){
	if($("#emp_job").val() === ""){
		$("input[name='staFun']").prop("checked", false);
	}
	if($("#emp_job").val() === "一般員工"){
		$("input[name='staFun']").prop("checked", false);
		$("#staFun1").prop("checked", true);
		$("#staFun3").prop("checked", true);
		$("#staFun5").prop("checked", true);
	}
	if($("#emp_job").val() === "平台管理員"){
		$("input[name='staFun']").prop("checked", false);
		$("#staFun2").prop("checked", true);
		$("#staFun4").prop("checked", true);
		$("#staFun6").prop("checked", true);
		$("#staFun7").prop("checked", true);
		$("#staFun8").prop("checked", true);
		$("#staFun9").prop("checked", true);
		$("#staFun10").prop("checked", true);
	}
	if($("#emp_job").val() === "主管"){
		$("input[name='staFun']").prop("checked", true);
	}
})

// 勾選該員工的權限
<c:forEach var="StaRigVO" items="${list_StaRigVO}">
	$("#staFun${StaRigVO.fun_no}").prop("checked", true);
</c:forEach>

$("#sub").click(function(){
	Swal.fire({
		  title: '確定修改？',
// 		  text: "此修改送出將無法復原！",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '確定',
		  cancelButtonText: '取消'
		}).then((result) => {
			if (result.isConfirmed) {
				$("#form1").submit();
			}
		})
})

<c:if test="${errorMsgs.size() != 0}">
	Swal.fire({
    	icon:'warning',
    	title:'資料有誤',
    	showConfirmButton: false,
		timer: 1000
    });
</c:if>
   	
<c:if test="${not empty requestScope.updateSuccess}">
	Swal.fire({
    	icon:'success',
    	title:'修改成功',
    	showConfirmButton: false,
		timer: 1000
    });
</c:if>

</script>
</body>

</html>
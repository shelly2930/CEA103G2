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

<title>後台空頁</title>

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
				        <h1 class="mx-auto mb-4 text-uppercase">新增員工</h1>
				    </div>

					<form method="post" action="<%=request.getContextPath()%>/employee/employee.do">

						<div class="form-group row">
							<label for="emp_username" class="col-md-4 col-form-label">員工代號</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="emp_username" name="emp_username" value="${param.emp_username}">
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_username == null) ? "" : "border-left-warning"}">
								<small id="emp_username-errorMsg">${errorMsgs.emp_username}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_email" class="col-md-4 col-form-label">電子信箱</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="emp_email" name="emp_email" value="${param.emp_email}">
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_email == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_email}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_job" class="col-md-4 col-form-label">職位</label>
							<div class="col-md-4">
								<select class="form-control" id="emp_job" name="emp_job">
									<option value="" ${(param.emp_job eq "") ? "selected" : ""}>請選擇</option>
									<option value="一般員工" ${(param.emp_job eq "一般員工") ? "selected" : ""}>一般員工</option>
									<option value="平台管理員" ${(param.emp_job eq "平台管理員") ? "selected" : ""}>平台管理員</option>
									<option value="主管" ${(param.emp_job eq "主管") ? "selected" : ""}>主管</option>
								</select>
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_job == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_job}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_sal" class="col-md-4 col-form-label">薪資</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="emp_sal" name="emp_sal" value="${param.emp_sal}">
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_sal == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_sal}</small>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="emp_hiredate" class="col-md-4 col-form-label">到職日</label>
							<div class="col-md-4">
								<input type="date" class="form-control" id="emp_hiredate" name="emp_hiredate" value="${requestScope.employeeVO.emp_hiredate}">
							</div>
							<div class="col-md-4 errorMsgs ${(errorMsgs.emp_hiredate == null) ? "" : "border-left-warning"}">
								<small>${errorMsgs.emp_hiredate}</small>
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
							<button id="sub" type="submit" class="btn btn-success btn-icon-split">
	                            <span class="icon text-white-50">
	                                <i class="fas fa-check"></i>
	                            </span>
	                            <span class="text">新增員工</span>
	                        </button>
                        </div>

						<input type="hidden" name="action" value="insert">
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
// 當emp_username欄位blur時及時驗證(Ajax)
window.addEventListener("load", function() {
	document.getElementsByName("emp_username")[0].onblur = getInfo;
	}, false);

function getInfo(){ 
	var xhr = new XMLHttpRequest();
	xhr.onload = function() {
		if(xhr.status == 200){
		    if(xhr.responseText === "可使用") {
		    	document.getElementById("emp_username-errorMsg").innerHTML = "";
		    	document.getElementById("emp_username").classList.remove("is-invalid");
		    	document.getElementById("emp_username").classList.add("is-valid");
		    	document.getElementById("emp_username-errorMsg").parentElement.classList.remove("border-left-warning");
		    }
	      	else {
	      		document.getElementById("emp_username-errorMsg").innerHTML = xhr.responseText;
	      		document.getElementById("emp_username").classList.remove("is-valid");
	      		document.getElementById("emp_username").classList.add("is-invalid");
		    	document.getElementById("emp_username-errorMsg").parentElement.classList.add("border-left-warning");
	     	}
	    }else {
	      alert(xhr.status);
	    }
	}

	xhr.open("post", "<%=request.getContextPath()%>/employee/employee.do", true);
	xhr.setRequestHeader("content-type", "application/x-www-form-urlencoded");
	let input = document.getElementsByName("emp_username")[0].value;
	let data_info = "action=checkEmp_username&emp_username=" + input;
	xhr.send(data_info);
}

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

<c:if test="${not empty errorMsgs}">
	Swal.fire({
    	icon:'warning',
    	title:'資料有誤'
    });
</c:if>
    	
<c:if test="${not empty requestScope.insertSuccess}">
	Swal.fire({
	   	icon:'success',
	   	title:'新增成功'
	});
</c:if>


</script>
</body>

</html>
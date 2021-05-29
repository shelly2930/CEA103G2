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

    <title>�ӤH���</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

	<style type="text/css">
		img{
   			width: 100rem;
			border-radius: 15% !important;
		}
		@media (max-width: 576px){
			img{
	   			margin: 0 auto;
			}
		}
		.errorMsgs {
			color: #1cc88a;
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
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	
    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
		<c:if test="${sessionScope.employeeVO.emp_id != null}">
        <%@ include file="/back-end/includeFile/sidebarBack.file" %>
        </c:if>

         <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

				<!-- Topbar -->
                <%@ include file="/back-end/includeFile/topbarBack.file" %>

                <!--�@�@�@�����������������������e���������������������@�@�@-->
                <div class="container-fluid">
${errorMsgs.Exception}
					<div class="mx-auto text-center pageTitle">
						<c:if test="${sessionScope.employeeVO.emp_id != null}">
				        <h1 class="mx-auto mb-4 text-uppercase">�ӤH���</h1>
				        </c:if>
						<c:if test="${sessionScope.employeeVO.emp_id == null}">
				        <h1 class="mx-auto mb-4 text-uppercase">�Ч����򥻸�ƶ�g</h1>
				        </c:if>
	                </div>
<!-- 					<div class="row justify-content-center mt-5 mb-5"> -->
<%-- 						<c:if test="${sessionScope.employeeVO.emp_id == null}"> --%>
<!-- 				        <div class="h1 border-bottom-primary">�Ч����򥻸�ƶ�g</div> -->
<%-- 				        </c:if> --%>
<!-- 					</div> -->
					
                    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/employee/employee.do" ENCTYPE="multipart/form-data">
                    <div class="row justify-content-center">
                    
                    	<!-- �e�����b�� -->
                    	<div class="col-sm-4 <c:if test="${not empty requestScope.employeeVO and empty errorMsgs}">order-sm-2</c:if>">
                    		<div class="form-group row">
								<label for="emp_pic" class="col-4">�Y��</label>
								<input type="file" class="form-control-file col" id="emp_pic" name="emp_pic" style="display:none" disabled>
							</div>
	                    	<div class="form-row">
								<img class="img-fluid img-thumbnail" id="preview" src="<%=request.getContextPath()%>/employee/PhotoReader.do?emp_no=${employeeVO.emp_no}"/>
	                    	</div>
	                    </div>
                    	<!-- �e�����b�䵲�� -->
                    	
                    	<!-- �e���k�b�� -->
                    	<div class="col-sm-6 <c:if test="${not empty requestScope.employeeVO and empty errorMsgs}">order-sm-1</c:if>">
							<div class="form-row">
							    <div class="form-group col-lg-6">
							    	<label for="emp_name">�m�W</label>
							      	<input type="text" class="form-control" id="emp_name" name="emp_name" value="${employeeVO.emp_name}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_name == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_name}</small>
									</div>
							    </div>
							    <div class="form-group col-lg-6">
							      	<label for="emp_gender">�ʧO</label>
							      	<select class="form-control" id="emp_gender" name="emp_gender" disabled>
										<option value="0" ${(employeeVO.emp_gender eq 0) ? "selected" : ""}>�п��</option>
										<option value="1" ${(employeeVO.emp_gender eq 1) ? "selected" : ""}>�k</option>
										<option value="2" ${(employeeVO.emp_gender eq 2) ? "selected" : ""}>�k</option>
									</select>
							    </div>
							</div>
							
							<div class="form-row">
							    <div class="form-group col-lg-6">
							    	<label for="emp_id">�����Ҧr��</label>
							      	<input type="text" class="form-control" id="emp_id" name="emp_id" value="${employeeVO.emp_id}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_id == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_id}</small>
									</div>
							    </div>
							    <div class="form-group col-lg-6">
							      	<label for="emp_birthday">�ͤ�</label>
							      	<input type="date" class="form-control" id="emp_birthday" name="emp_birthday" value="${employeeVO.emp_birthday}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_birthday == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_birthday}</small>
									</div>
							    </div>
							</div>
							
							<div class="form-row">
								<div class="form-group col">
									<label for="emp_email">�q�l�H�c</label>
									<input type="text" class="form-control" id="emp_email" name="emp_email" value="${employeeVO.emp_email}" readonly>
									<div class="errorMsgs ${(errorMsgs.emp_email == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_email}</small>
									</div>
								</div>
							</div>
							
							<div class="form-row">
								<div class="form-group col">
									<label for="emp_addr">�a�}</label>
									<input type="text" class="form-control" id="emp_addr" name="emp_addr" value="${employeeVO.emp_addr}" readonly>
									<div class="errorMsgs ${(errorMsgs.emp_addr == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_addr}</small>
									</div>
								</div>
							</div>
							
							<div class="form-row">
							    <div class="form-group col-lg-6">
							    	<label for="emp_phone">�s���q��</label>
							      	<input type="text" class="form-control" id="emp_phone" name="emp_phone" value="${employeeVO.emp_phone}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_phone == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_phone}</small>
									</div>
							    </div>
							    <div class="form-group col-lg-6">
							      	<label for="emp_mobile">��ʹq��</label>
							      	<input type="text" class="form-control" id="emp_mobile" name="emp_mobile" value="${employeeVO.emp_mobile}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_mobile == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_mobile}</small>
									</div>
							    </div>
							</div>
							
							<div class="form-row">
							    <div class="form-group col-lg-6">
							    	<label for="emp_bank">�Ȧ�N��</label>
							      	<input type="text" class="form-control" id="emp_bank" name="emp_bank" value="${employeeVO.emp_bank}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_bank == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_bank}</small>
									</div>
							    </div>
							    <div class="form-group col-lg-6">
							      	<label for="emp_account">�״ڱb��</label>
							      	<input type="text" class="form-control" id="emp_account" name="emp_account" value="${employeeVO.emp_account}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_account == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_account}</small>
									</div>
							    </div>
							</div>
							
							<c:if test="${not empty requestScope.employeeVO and sessionScope.employeeVO.emp_job eq '�D��' and empty errorMsgs}">
							<div class="form-row">
							    <div class="form-group col-lg-6">
							    	<label for="emp_sal">�~��</label>
							      	<input type="text" class="form-control" id="emp_sal" name="emp_sal" value="${employeeVO.emp_sal}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_sal == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_sal}</small>
									</div>
							    </div>
							    <div class="form-group col-lg-6">
							      	<label for="emp_bonus">����</label>
							      	<input type="text" class="form-control" id="emp_bonus" name="emp_bonus" value="${employeeVO.emp_bonus}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_bonus == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_bonus}</small>
									</div>
							    </div>
							</div>
							
							<div class="form-row">
							    <div class="form-group col-lg-6">
							    	<label for="emp_hiredate">��¾��</label>
							      	<input type="date" class="form-control" id="emp_hiredate" name="emp_hiredate" value="${employeeVO.emp_hiredate}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_hiredate == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_hiredate}</small>
									</div>
							    </div>
							    <div class="form-group col-lg-6">
							      	<label for="emp_quitdate">��¾��</label>
							      	<input type="date" class="form-control" id="emp_quitdate" name="emp_quitdate" value="${employeeVO.emp_quitdate}" readonly>
							      	<div class="errorMsgs ${(errorMsgs.emp_quitdate == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_quitdate}</small>
									</div>
							    </div>
							</div>
							</c:if>
							
							<div class="form-row mt-4 mb-4">
								<div class="form-group col">
								<c:if test="${empty requestScope.employeeVO || not empty errorMsgs}">
									<button type="button" class="btn btn-outline-info" id="updateInfo">�ק���</button>
									<button type="submit" class="btn btn-outline-info" id="updateSubmit" style="display:none;">�e�X�ק�</button>
									
									<!-- Button trigger modal -->
									<button type="button" class="btn btn-outline-danger ml-4" data-toggle="modal" data-target="#exampleModalCenter">
										���K�X
									</button>
									<!-- Modal -->
									<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
									  <div class="modal-dialog modal-dialog-centered" role="document">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h5 class="modal-title" id="exampleModalCenterTitle">���K�X</h5>
									        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span id="span_x" aria-hidden="true">&times;</span>
									        </button>
									      </div>
									      <div class="modal-body">
									       	<div class="form-group row justify-content-center">
									      	 	<label for="oldPassword" class="col-3 col-form-label">�±K�X</label>
											  	<div class="col-7">
									      	 	  <div class="row">
													<div class="input-group">
													  	<input type="password" class="form-control" id="oldPassword" name="oldPassword">
													  	<div class="input-group-append">
													    		<button class="btn btn-outline-dark showMe" type="button">���</button>
													  	</div>
													</div>
													<div class="errorMsgs">
														<small name="oldPassword"></small>
													</div>
												  </div>
												</div>
											</div>
											<div class="form-group row justify-content-center">
									      	 	<label for="newPassword" class="col-3 col-form-label">�s�K�X</label>
											  	<div class="col-7">
									      	 	  <div class="row">
													<div class="input-group">
													  	<input type="password" class="form-control" id="newPassword" name="newPassword">
													  	<div class="input-group-append">
													    		<button class="btn btn-outline-dark showMe" type="button">���</button>
													  	</div>
													</div>
													<div class="errorMsgs">
														<small name="newPassword"></small>
													</div>
												  </div>
												</div>
											</div>
											<div class="form-group row justify-content-center">
									      	 	<label for="newPasswordCheck" class="col-3 col-form-label">�T�{�s�K�X</label>
									      	 	<div class="col-7">
									      	 	  <div class="row">
													<div class="input-group">
													  	<input type="password" class="form-control" id="newPasswordCheck" name="newPasswordCheck">
													  	<div class="input-group-append">
													    		<button class="btn btn-outline-dark showMe" type="button">���</button>
													  	</div>
													</div>
													<div class="errorMsgs">
														<small name="newPasswordCheck"></small>
													</div>
												  </div>
												</div>
											</div>
									      </div>
									      <div class="modal-footer">
									        <button id="updatePassword" type="button" class="btn btn-primary">�T�w</button>
									        <button id="close" type="button" class="btn btn-secondary" data-dismiss="modal">����</button>
									      </div>
									    </div>
									  </div>
									</div>
								</c:if>
								<c:if test="${not empty requestScope.employeeVO and sessionScope.employeeVO.emp_job eq '�D��' and sessionScope.employeeVO.emp_no != requestScope.employeeVO.emp_no}">
										<button id="getOne_For_Update" type="submit" class="btn btn-outline-info">�ק���u���</button>
								</c:if>
								</div>
	                        </div>
						<input type="hidden" name="action" value="updateByEmp">
						<input type="hidden" name="emp_no" value="${employeeVO.emp_no}">
						<input type="hidden" name="emp_password" value="${employeeVO.emp_password}">
                    	</div>
                    	<!-- �e���k�b�䵲�� -->
                    </div>
                    
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
    
    <script>
		let emp_pic = document.getElementsByName("emp_pic")[0];
		let preview = document.getElementById("preview");
		emp_pic.addEventListener('change', function(e) {
		    let files = e.target.files;
		    if (files) {
		        let file = files[0];
		        if (file.type.indexOf('image') > -1) {
		            let reader = new FileReader();
		            reader.addEventListener('load', function(e) {
		                let result = e.target.result;
		                preview.src = result;
		            });
		            reader.readAsDataURL(file);
		        } else {
		            alert('�ФW�ǹϤ��I');
		        }
		    }
		});
		
		$("small").addClass("ml-2");
		
		//�Ѷ}�Ҧ�input,����'�ק���'���s��'�e�X�ק�'
		function update() {
			$("input").prop("readonly", false);
			$("select").prop("disabled", false);
			$("#emp_pic").prop("disabled", false);
// 			$("#emp_pic").css("display", "inline-block");
			$("#updateInfo").css("display", "none");
			$("#updateSubmit").css("display", "inline-block");
		}
		
		$("#updateInfo").click(function() {
			Swal.fire({
				  title: '�O�_�n�ק�򥻸��?',
				  icon: 'question',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '�T�w',
				  cancelButtonText: '����'
				}).then((result) => {
				  if (result.isConfirmed) {
					 update();
				  }
				})
		});
		
		// ���U'�e�X�ק�',controller���Ҹ��forword�^�Ӧp��errorMsgs,�h����update�禡
		if(${not empty errorMsgs}) {update();}
		
		// �Ĥ@���n�J
		<c:if test="${sessionScope.employeeVO.emp_id == null}">
        	update();
        </c:if>
		
		$("#preview").click(function(){
			$("#emp_pic").click();
		});
		
		// ��'���K�X'������_���
		function updatePassword_return(){
			$(".showMe").parent().prev().attr("type","password");
			$(".showMe").text("���");
			$("#oldPassword").val("");
			$("#newPassword").val("");
			$("#newPasswordCheck").val("");
			$("small[name='oldPassword']").text("");
			$("small[name='oldPassword']").parent().removeClass("border-left-warning");
			$("small[name='newPassword']").text("");
			$("small[name='newPassword']").parent().removeClass("border-left-warning");
			$("small[name='newPasswordCheck']").text("");
			$("small[name='newPasswordCheck']").parent().removeClass("border-left-warning");
		}
		
		$("#close").click(updatePassword_return);
		$("#span_x").click(updatePassword_return);
		
		// '���K�X'����,��ܤ����ñK�X�\��
		$(".showMe").click(function(){
			if($(this).parent().prev().attr("type") == "password"){
				$(this).parent().prev().attr("type","text");
				$(this).text("����");
				$(this).removeClass("btn-outline-dark");
				$(this).addClass("btn-dark");
			}else{
				$(this).parent().prev().attr("type","password");
				$(this).text("���");
				$(this).removeClass("btn-dark");
				$(this).addClass("btn-outline-dark");
			}
		});
		
// 		�����Ҧ�input���Uenter�w�]��submit�ʧ@
// 		$(document).keypress(function(e){
// 			if(e.keyCode == 13)
// 				return false;
// 		});
		
		$("#updatePassword").click(function(){
			$.ajax({
				url: "${pageContext.request.contextPath}/employee/employee.do",
				type: "post",
				data: {
					action: "updatePassword",
					emp_no: "${employeeVO.emp_no}",
					oldPassword: $("#oldPassword").val(),
					newPassword: $("#newPassword").val(),
					newPasswordCheck: $("#newPasswordCheck").val()
				},
				success: function(data){
					var data_json = JSON.parse(data);
					
					if(data_json.oldPassword){
						$("small[name='oldPassword']").text(data_json.oldPassword);
						$("small[name='oldPassword']").parent().addClass("border-left-warning");
					}else{
						$("small[name='oldPassword']").text("");
						$("small[name='oldPassword']").parent().removeClass("border-left-warning");
					}
					
					if(data_json.newPassword){
						$("small[name='newPassword']").text(data_json.newPassword);
						$("small[name='newPassword']").parent().addClass("border-left-warning");
					}else{
						$("small[name='newPassword']").text("");
						$("small[name='newPassword']").parent().removeClass("border-left-warning");
					}
					
					if(data_json.newPasswordCheck){
						$("small[name='newPasswordCheck']").text(data_json.newPasswordCheck);
						$("small[name='newPasswordCheck']").parent().addClass("border-left-warning");
					}else{
						$("small[name='newPasswordCheck']").text("");
						$("small[name='newPasswordCheck']").parent().removeClass("border-left-warning");
					}
					
					if(data_json.success){
						Swal.fire({
					    	icon:'success',
					    	title:'��令�\'
					    });
						$("#close").click();
					} else{
						Swal.fire({
							icon:'warning',
					    	title:'��Ʀ��~'
					    });
					}
				}
			});
		})
		
		// �p��L���Uenter��,�e�X���K�X�T�{,�è���input���ҹw�]��submit�欰
		function updatePassword_enter(e){
			if(e.keyCode == 13){
				$("#updatePassword").click();
				return false;
			}
		}
		
		$("#oldPassword").keypress(updatePassword_enter);
		$("#newPassword").keypress(updatePassword_enter);
		$("#newPasswordCheck").keypress(updatePassword_enter);
		
		// �D�ޫ��U'�ק���u���'�ɧ���action,��controller����'getOne_For_Update',�ӫD�쥻��'updateByEmp'
		$("#getOne_For_Update").click(function(){
			$("input[name='action']").val("getOne_For_Update");
		});
		
		<c:if test="${not empty requestScope.employeeVO && not empty errorMsgs}">
		Swal.fire({
	    	icon:'warning',
	    	title:'��Ʀ��~',
	    	showConfirmButton: false,
			timer: 1000
	    });
    	</c:if>
    	
    	<c:if test="${not empty requestScope.updateSuccess}">
		Swal.fire({
	    	icon:'success',
	    	title:'�ק令�\',
	    	showConfirmButton: false,
			timer: 1000
	    });
    	</c:if>
		
	</script>

</body>

</html>
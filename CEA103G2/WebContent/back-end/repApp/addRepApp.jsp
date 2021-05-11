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

                <!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
                <div class="container-fluid">
${errorMsgs.Exception}
                    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/repApp/repApp.do" ENCTYPE="multipart/form-data">
                    <div class="row justify-content-center">
                    
                    	<!-- 畫面左半邊 -->
                    	<div class="col-sm-4">
                    		<div class="form-group row">
								<label for="rap_photo" class="col-4">頭像</label>
								<input type="file" class="form-control-file col" id="rap_photo" name="rap_photo">
							</div>
	                    	<div class="form-row">
								<img class="img-fluid img-thumbnail" id="preview" src="<%=request.getContextPath()%>/repAppPho/PhotoReader.do?emp_no=${repAppPhoVO.rap_no}"/>
	                    	</div>
	                    </div>
                    	<!-- 畫面左半邊結束 -->
                    	
                    	<!-- 畫面右半邊 -->
                    	<div class="col-sm-6">
							<div class="form-row">
							    <div class="form-group col-lg-6">
							    	<label for="mem_no">會員編號</label>
							      	<input type="text" class="form-control" id="mem_no" name="mem_no">
							      	<div class="errorMsgs ${(errorMsgs.emp_name == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_name}</small>
									</div>
							    </div>
							    <div class="form-group col-lg-6">
							      	<label for="rtct_no">合約編號</label>
							      	<input type="text" class="form-control" id="rtct_no" name="rtct_no">
							    </div>
							</div>
							
							<div class="form-row">
							    <div class="form-group col-lg-6">
							      	<label for="ra_order_time">預約修繕時間</label>
							      	<input type="datetime-local" class="form-control" id="ra_order_time" name="ra_order_time">
							      	<div class="errorMsgs ${(errorMsgs.emp_birthday == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_birthday}</small>
									</div>
							    </div>
							    <div class="form-group col-lg-6">
							    	<label for="ra_no">申請單編號</label>
							      	<input type="text" class="form-control" id="ra_no" name="ra_no">
							      	<div class="errorMsgs ${(errorMsgs.emp_id == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_id}</small>
									</div>
							    </div>
							</div>
							
							<div class="form-row">
								<div class="form-group col">
									<label for="rad_dmg">修繕物品</label>
									<input type="text" class="form-control" id="rad_dmg" name="rad_dmg">
									<div class="errorMsgs ${(errorMsgs.emp_email == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_email}</small>
									</div>
								</div>
							</div>
							
							<div class="form-row">
								<div class="form-group col">
									<label for="rad_dsc">修繕描述</label>
									<input type="text" class="form-control" id="rad_dsc" name="rad_dsc">
									<div class="errorMsgs ${(errorMsgs.emp_addr == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_addr}</small>
									</div>
								</div>
							</div>
							
							<div class="form-row">
								<div class="form-group col">
									<label for="rad_no">明細編號</label>
									<input type="text" class="form-control" id="rad_no" name="rad_no">
									<div class="errorMsgs ${(errorMsgs.emp_addr == null) ? "" : "border-left-warning"}">
										<small>${errorMsgs.emp_addr}</small>
									</div>
								</div>
							</div>
							
							
							<div class="form-row mt-4 mb-4">
								<div class="form-group col">
									<button type="submit" class="btn btn-outline-info" id="updateSubmit">送出修改</button>
								</div>
	                        </div>
						<input type="hidden" name="action" value="insert">
                    	</div>
                    	<!-- 畫面右半邊結束 -->
                    </div>
                    
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
    
    <script>
		let emp_pic = document.getElementsByName("rap_photo")[0];
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
		            alert('請上傳圖片！');
		        }
		    }
		});
		
		$("small").addClass("ml-2");
		
		
		$("#preview").click(function(){
			$("#rap_photo").click();
		})
		
		
	</script>

</body>

</html>
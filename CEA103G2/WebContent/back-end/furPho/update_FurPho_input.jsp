<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furPho.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%
FurPhoVO furPhoVO = (FurPhoVO) request.getAttribute("furPhoVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
FurIteService furIteSvc = new FurIteService();
FurIteVO furIteVO=new FurIteVO();
furIteVO=furIteSvc.getOneFurIte(furPhoVO.getFnt_it_no());
pageContext.setAttribute("furIteVO",furIteVO);
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>家具照片更改</title>

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
  img {
            margin: 10px;
            height: 240px;
            width: 360px;
        }
 </style>
</head>

<body id="page-top"> 

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
<%-- 		<%@ include file="/back-end/includeFile/sidebarBack.file"%> --%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
<%-- 				<%@ include file="/back-end/includeFile/topbarBack.file"%> --%>

				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
				<div class="container-fluid">

							<div class="card-body">
								<div class="table-responsive">
									<%-- 錯誤表列 --%>
									<c:if test="${not empty errorMsgs}">
										<font style="color: red">請修正以下錯誤:</font>
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color: red">${message}</li>
											</c:forEach>
										</ul>
									</c:if>
									
										<div class="col-lg-12">
										<table class="table table-bordered" id="dataTable"
											width="100%" cellspacing="0">
											<!--                  ↓↓↓       表單擺放位置↓↓↓↓ -->
					  <section class="checkout_area padding_top">
						    <div class="container">
						
						      <div class="billing_details">
						        <div class="row">
						          <div class="col-lg-12">
						            <h3>家具照片更改</h3>
						 <FORM class="row contact_form"  ACTION="<%=request.getContextPath()%>/furPho/furPho.do"   enctype="multipart/form-data"  name="form1" method="post" novalidate="novalidate">
								<table>
								 <div class="col-md-12 form-group">
								     <label for="fnt_ctgr_no"  class="col-md-12 col-form-lgroup" >照片編號：${furPhoVO.fnt_pic_no}</label>
						             <div class="col-sm-10">
						              </div>			             
									</div>
								 <div class="col-md-12 form-group">
								     <label for="fnt_ctgr_no"  class="col-md-12 col-form-lgroup" >家具品項名稱：${furIteVO.fnt_name}</label>
						             <div class="col-sm-10">
						              </div>			             
									</div>
									
									<div class="col-md-12 form-group">
								     <label for=fnt_name  class="col-md-5 col-form-lgroup" >家具照片：</label>
						             <div class="col-sm-12">
						             				<img id="img" src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}" 	height="100">
						   					  <input type="file" id="fnt_pic" name="fnt_pic" size="45" />
											<div id="preview"></div>
						              </div>			             
									</div>		
								
										 <div class="col-lg-12">
										 <div class="col-lg-10">
										<input type="hidden" name="action" value="update" >
										<input type="hidden" name="fnt_pic_no"  value="<%=furPhoVO.getFnt_pic_no()%>">
										<input type="hidden" name="fnt_it_no"  value="<%=furPhoVO.getFnt_it_no()%>">
										<button	class="btn btn-info btn-icon-split" type="submit"> <span class="text">送出修改</span></button>
								</div>
								</div>
				           </table>
				            </form>
				          </div>
				        
				        </div>
				      </div>
				    </div>
<!--   </section> -->
											      
											<!--                  ↑↑↑       表單擺放位置↑↑↑↑ -->

										</table>
										 </div>
									</FORM>
									  </section>
								</div>
							</div>
						</div>

					</div>
					<!-- /.container-fluid -->
				
				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

			</div>
			<!-- End of Main Content -->
<script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
			<!-- Footer -->
			<%@ include file="/back-end/includeFile/footerBack.file"%>

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<%@ include file="/back-end/includeFile/otherBack.file"%>

	<!-- Bootstrap core JavaScript-->
	
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script>
window.onload=function(){
    let myFile = document.getElementById("fnt_pic");
    let preview = document.getElementById("preview");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                	let result = e.target.result;
                    let img = document.getElementById('img');
                    img.src = result;
                    preview.append(img);
//                     $("img:first").remove(); // 預覽只會保留最新上傳的
                });
                reader.readAsDataURL(file);
            } else {
                alert('請上傳圖片！');
            }
        }
    });    
}
</script>
	<!-- Page level plugins -->
<!-- 	<script -->
<%-- 		src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script> --%>

	<!-- Page level custom scripts -->
<!-- 	<script -->
<%-- 		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script> --%>
<!-- 	<script -->
<%-- 		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script> --%>

</body>
</html>
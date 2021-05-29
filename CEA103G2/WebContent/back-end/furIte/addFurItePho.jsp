<%-- <%@page import="com.mysql.fabric.xmlrpc.base.Param"%> --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furPho.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%
Integer fnt_it_no=null;
if(request.getParameter("fnt_it_no")==null){
	//�Ӧۤ@�}�l�s�W�~���� �U�@������̫�@�ӽs�� �Hattribute�覡�e�Ӧܦ�����fnt_it_no
	fnt_it_no=(Integer)(request.getAttribute("fnt_it_no"));
}else{
	//�Ӧ�ListAllFurIte�����X�������s�W�Ӥ��s �H����get?=�ǰe�Ѽƪ��覡�Ө즹��
	fnt_it_no=new Integer(request.getParameter("fnt_it_no"));
	}
FurIteService furIteSvc = new FurIteService();
FurIteVO furIteVO=new FurIteVO();
furIteVO=furIteSvc.getOneFurIte(fnt_it_no);
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

<title>�a��Ӥ��s�W</title>

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

				<!--�@�@�@�����������������������e���������������������@�@�@-->
				<div class="container-fluid">

							<div class="card-body">
								<div class="table-responsive">
									<%-- ���~��C --%>
									<c:if test="${not empty errorMsgs}">
										<font style="color: red">�Эץ��H�U���~:</font>
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color: red">${message}</li>
											</c:forEach>
										</ul>
									</c:if>
									
										<div class="col-lg-12">
										<table class="table table-bordered" id="dataTable"
											width="100%" cellspacing="0">
											<!--                  ������       ����\���m�������� -->
					  <section class="checkout_area padding_top">
						    <div class="container">
						
						      <div class="billing_details">
						        <div class="row">
						          <div class="col-lg-12">
						            <h3>�a��~���Ӥ��s�W</h3>
						 <FORM class="row contact_form"  ACTION="<%=request.getContextPath()%>/furPho/furPho.do"   enctype="multipart/form-data"  name="form1" method="post" novalidate="novalidate">
								<table>
								 <div class="col-md-12 form-group">
								     <label for="fnt_ctgr_no"  class="col-md-12 col-form-lgroup" >�a��~���W�١G${furIteVO.fnt_name}</label>
						             <div class="col-sm-10">
						              </div>			             
									</div>
									
									<div class="col-md-12 form-group">
								     <label for=fnt_name  class="col-md-5 col-form-lgroup" >�a��Ӥ��G</label>
						             <div class="col-sm-12">
						   					  <input type="file" id="myFile" name="fnt_pic" size="45"  multiple/>
											 <div class="row" style="display:none;">
												    <label>�ɮצW�١G</label>
												    <input type="text" name="filename" id="filename">
												</div>
											<div id="preview">
											</div>
						              </div>			             
									</div>		
								
										 <div class="col-lg-12">
										 <div class="col-lg-10">
									
										<input type="hidden" name="action" value="insert_pic" >
										<input type="hidden" name="fnt_it_no" value="${fnt_it_no}">
										<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--������e�X�ק諸�ӷ��������|��,�A�e��Controller�ǳ���椧��-->
<%-- 										<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--�u�Ω�:istAllEmp.jsp--> --%>
										<button	class="btn btn-info btn-icon-split" type="submit"> <span class="text">�e�X�s�W</span></button>
								</div>
								</div>
								
								
				           </table>
				            </form>
				          </div>
				        
				        </div>
				      </div>
				    </div>
<!--   </section> -->
											      
											<!--                  ������       ����\���m�������� -->

										</table>
										 </div>
									</FORM>
									  </section>
								</div>
							</div>
						</div>

					</div>
					<!-- /.container-fluid -->
				
				<!--�@�@�@�����������������������e���������������������@�@�@-->

			</div>
			<!-- End of Main Content -->
<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
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
<script>
window.onload=function(){
    let myFile = document.getElementById("myFile");
    let preview = document.getElementById("preview");
    let filename = document.getElementById("filename");
    myFile.addEventListener('change', function(e) {
        let files = e.target.files;

        if (files !== null) {
            for (let i = 0; i < files.length; i++) {
                let file = files[i];
                if (file.type.indexOf('image') > -1) {
                    filename.value = file.name;
                    let reader = new FileReader();
                    reader.addEventListener('load', function(e) {
                        let result = e.target.result;
                        let div = document.createElement('div');
                        let img = document.createElement('img');
                        img.src = result;
                        div.append(img);
                        preview.append(div);
                    });
                    reader.readAsDataURL(file);
                } else {
                    alert('�ФW�ǹϤ��I');
                }
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
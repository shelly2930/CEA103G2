<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<title></title>

<style>
body { 
background-color: #dddddd !important;
}

/* .breadcrumb_bg { */
<%--     background-image: url(<%=request.getContextPath()%>/unprotected/furniture/images/FurniturePage.jpg)!important; --%>
/*     background-position: bottom -300px right 0px!important;  */
/*     background-repeat: no-repeat; */
/*     background-size: cover; */
/* } */
</style>

</head>
<body>
<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>
<section class="breadcrumb breadcrumb_bg" >
<!--     <div class="container"> -->
<!--         <div class="row justify-content-center"> -->
<!--             <div class="col-lg-8"> -->
<!--                 <div class="breadcrumb_iner"> -->
<!--                     <div class="breadcrumb_iner_item"> -->
<!--                         <h2>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Welcome  �n��a��M��</h2> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </div> -->
</section>
<!--================ Content Area start =================-->
<div id="wrapper">
 <%@ include file="/back-end/includeFile/sidebarBack_DONG.file" %>
 <div id="content-wrapper" class="d-flex flex-column" style="background-color: #dddddd;">
  <div id="content">
            
<section class="cat_product_area" style="padding-top:84px">
	<div class="container">
		<div class="row">
                
            <div class="col-lg content">
                
                <!--================ ���n���ܦۤv�R�� =================-->
                <div class="pagetitle">�|���M��</div>
				
				<!--�@�@�@�����������������������e���������������������@�@�@-->

					���e��o��


				<!--�@�@�@�����������������������e���������������������@�@�@-->
							
            </div>
        </div>
	</div>
</section>
  </div>
 </div>
</div>
<!--================ Content Area end =================-->

</body>

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�A�[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
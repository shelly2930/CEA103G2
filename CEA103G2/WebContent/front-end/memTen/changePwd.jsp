<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<title></title>

<style>
body { 
background-color: #dddddd !important;
}
</style>

</head>
<body>
<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>

<!--================ Content Area start =================-->
<section class="cat_product_area section_padding">
	<div class="container">
		<div class="row">
            <!--================ Sidebar =================-->    
			<%@include file="/front-end/sidebarFront.file"%>
                
            <div class="col-lg-10 content">
                
                <!--================ ���n���ܦۤv�R�� =================-->
                <div class="pagetitle">�ק�K�X</div>
				
				<!--�@�@�@�����������������������e���������������������@�@�@-->

				<table class="table">
	
					<tbody>
						<tr>
							<th>�п�J�±K�X</th>
						    <td><input type="text" name="mem_password" placeholder="password" required class="single-input" value="${memTenVO.mem_username}"></td>
						</tr>
						<tr>
							<th>�п�J�s�K�X</th>
						    <td></td>
						</tr>
						<tr>
							<th>�ЦA����J�s�K�X</th>
						    <td></td>
						</tr>
					</tbody>	
				</table>


				<!--�@�@�@�����������������������e���������������������@�@�@-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

</body>

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�A�[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
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
					<FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" id="form1">
					<tbody>
						<tr>
							<th>�п�J�±K�X</th>
						    <td>
						    	<input type="text" name="mem_password" required class="single-input" value="">
						    	<p class="errorMsgs" style="color:red">${errorMsgs.mem_password}</p>
						    </td>
						</tr>
						<tr>
							<th>�п�J�s�K�X</th>
						    <td><input type="text" name="newpwd" required class="single-input" value=""></td>
						</tr>
						<tr>
							<th>�ЦA����J�s�K�X</th>
						    <td>
						    	<input type="text" name="insertstr" required class="single-input" value="">
						    	<p class="errorMsgs" style="color:red">${errorMsgs.insertstr}</p>
						    </td>
						</tr>
						<tr>
					    	<th></th>
					    	<td>
					    		<input type="hidden" name="action" value="changepwd">
					    		<input type="hidden" name="mem_username" value="${MemTenVO.mem_username}">
								<input type="submit" value="�T�{">
					    	</td>
					    </tr>
					</tbody>
					</form>	
				</table>


				<!--�@�@�@�����������������������e���������������������@�@�@-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

</body>



<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
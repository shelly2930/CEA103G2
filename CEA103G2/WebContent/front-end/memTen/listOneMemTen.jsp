<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>�d�ݷ|�����</title>



<style>
body { 
	background-color: #dddddd !important;
}

img.mem_pic {
  	height: 200px;
  	width: auto;
  }

.table td, .table th {
    padding: .75rem !important;
    vertical-align: middle !important;
    border-top: 2px solid #fff !important;
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
                
            <div class="col-lg-9 content">
                
                <!--================ ���n���ܦۤv�R�� =================-->
                <div class="pagetitle">�|�����</div>



<table class="table">
	
<tbody>
					  	<tr>
					    	<th>�|���s��</th>
					    	<td>${MemTenVO.mem_no}</td>
					    </tr>
					    <tr>
					    	<th>�b��</th>
					    	<td>${MemTenVO.mem_username}</td>
					    </tr>
<!-- 					    <tr> -->
<!-- 					    	<th>�K�X</th> -->
<!-- 					    	<td> -->
<%-- 					    		<input type="button" value="�ק�K�X" onclick="location.href='<%=request.getContextPath()%>/front-end/memTen/changePwd.jsp'"> --%>
<!-- 							</td> -->
<!-- 					    </tr> -->
					    <tr>
					    	<th>�Ӥ�</th>
					    	<td>
					    		<img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?action=getmempic&mem_no=${MemTenVO.mem_no}"  class="mem_pic">
					    	</td>
					    </tr>
					    <tr>
					    	<th>�m�W</th>
							<td>
								${MemTenVO.mem_name}
							</td>
					    </tr>
					    <tr>
					    	<th>�ʧO</th>
							<td>
								${MemTenVO.mem_gender == 0 ? '�k':'�k'}
        					</td>
					    </tr>
					    <tr>
					    	<th>�����Ҧr��</th>
							<td>
								${MemTenVO.mem_id}
							</td>
					    </tr>
					    <tr>
					    	<th>�X�ͦ~���</th>
							<td>
								${MemTenVO.mem_birthday}
							</td>
					    </tr>
					    <tr>
					    	<th>�s���q��</th>
							<td>
								${MemTenVO.mem_phone}
							</td>
					    </tr>
					    <tr>
					    	<th>��ʹq��</th>
							<td>
								${MemTenVO.mem_mobile}
							</td>
					    </tr>
					    <tr>
					    	<th>�q�l�H�c</th>
							<td>
								${MemTenVO.mem_email}
							</td>
					    </tr>
					    <tr>
					    	<th>����</th>
							<td>
								${MemTenVO.mem_city}
							</td>
					    </tr>
					    <tr>
					    	<th>�m����</th>
							<td>
								${MemTenVO.mem_dist}
							</td>
					    </tr>
					    <tr>
					    	<th>�a�}</th>
							<td>
								${MemTenVO.mem_addr}
							</td>
					    </tr>
					    <tr>
					    	<th>�����ҥ���</th>
					    	<td>
					    		<img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?action=getidcardf&mem_no=${MemTenVO.mem_no}"  class="mem_pic">
					    	</td>
					    </tr>
					    <tr>
					    	<th>�����ҭI��</th>
					    	<td>
					    		<img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?action=getidcardr&mem_no=${MemTenVO.mem_no}"  class="mem_pic">
					    	</td>
					    </tr>
					    <tr>
							<th>�ק�</th>
							<td>
								<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" style="margin-bottom: 0px;">
								<input type="hidden" name="action" value="getOne_For_Update">
								<input type="hidden" name="mem_no" value="${MemTenVO.mem_no}">
								<input type="submit" value="�ק�"></FORM>
							</td>
						</tr>
					 </tbody>	
				</table>


				<!--�@�@�@�����������������������e���������������������@�@�@-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->


<!--================ footer =================-->
<%@include file="/front-end/footer.file"%> 

</body>
</html>
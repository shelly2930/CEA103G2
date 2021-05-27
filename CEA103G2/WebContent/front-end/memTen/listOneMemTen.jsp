<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>查看會員資料</title>



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
                
                <!--================ 不要的話自己刪掉 =================-->
                <div class="pagetitle">會員資料</div>



<table class="table">
	
<tbody>
					  	<tr>
					    	<th>會員編號</th>
					    	<td>${MemTenVO.mem_no}</td>
					    </tr>
					    <tr>
					    	<th>帳號</th>
					    	<td>${MemTenVO.mem_username}</td>
					    </tr>
<!-- 					    <tr> -->
<!-- 					    	<th>密碼</th> -->
<!-- 					    	<td> -->
<%-- 					    		<input type="button" value="修改密碼" onclick="location.href='<%=request.getContextPath()%>/front-end/memTen/changePwd.jsp'"> --%>
<!-- 							</td> -->
<!-- 					    </tr> -->
					    <tr>
					    	<th>照片</th>
					    	<td>
					    		<img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?action=getmempic&mem_no=${MemTenVO.mem_no}"  class="mem_pic">
					    	</td>
					    </tr>
					    <tr>
					    	<th>姓名</th>
							<td>
								${MemTenVO.mem_name}
							</td>
					    </tr>
					    <tr>
					    	<th>性別</th>
							<td>
								${MemTenVO.mem_gender == 0 ? '男':'女'}
        					</td>
					    </tr>
					    <tr>
					    	<th>身分證字號</th>
							<td>
								${MemTenVO.mem_id}
							</td>
					    </tr>
					    <tr>
					    	<th>出生年月日</th>
							<td>
								${MemTenVO.mem_birthday}
							</td>
					    </tr>
					    <tr>
					    	<th>連絡電話</th>
							<td>
								${MemTenVO.mem_phone}
							</td>
					    </tr>
					    <tr>
					    	<th>行動電話</th>
							<td>
								${MemTenVO.mem_mobile}
							</td>
					    </tr>
					    <tr>
					    	<th>電子信箱</th>
							<td>
								${MemTenVO.mem_email}
							</td>
					    </tr>
					    <tr>
					    	<th>縣市</th>
							<td>
								${MemTenVO.mem_city}
							</td>
					    </tr>
					    <tr>
					    	<th>鄉鎮市區</th>
							<td>
								${MemTenVO.mem_dist}
							</td>
					    </tr>
					    <tr>
					    	<th>地址</th>
							<td>
								${MemTenVO.mem_addr}
							</td>
					    </tr>
					    <tr>
					    	<th>身分證正面</th>
					    	<td>
					    		<img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?action=getidcardf&mem_no=${MemTenVO.mem_no}"  class="mem_pic">
					    	</td>
					    </tr>
					    <tr>
					    	<th>身分證背面</th>
					    	<td>
					    		<img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?action=getidcardr&mem_no=${MemTenVO.mem_no}"  class="mem_pic">
					    	</td>
					    </tr>
					    <tr>
							<th>修改</th>
							<td>
								<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" style="margin-bottom: 0px;">
								<input type="hidden" name="action" value="getOne_For_Update">
								<input type="hidden" name="mem_no" value="${MemTenVO.mem_no}">
								<input type="submit" value="修改"></FORM>
							</td>
						</tr>
					 </tbody>	
				</table>


				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->


<!--================ footer =================-->
<%@include file="/front-end/footer.file"%> 

</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.memTen.model.*"%>

<%
MemTenVO memTenVO = (MemTenVO)session.getAttribute("MemTenVO");
%>
<jsp:useBean id="lanlordSvc" class="com.lanlord.model.LanlordService"/>

<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/nice-select.css">


<title></title>

<style>
body { 
	background-color: #dddddd !important;
}

img.lld_acc_pic {
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
                <div class="pagetitle">房東資料查看與修改${memTenVO.mem_username}</div>
				
				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
					<%-- 錯誤表列 --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color:red">請修正以下錯誤:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color:red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>
					
					
					<table class="table">
						<tbody>
					  		<tr>
									<th>房東編號</th>
									<td>${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_no}</td>
								</tr>
								<tr>
									<th>會員編號</th>
									<td>${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).mem_no}</td>
								</tr>
								<tr>
									<th>申請時間</th>
									<td><fmt:formatDate value="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_apptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								</tr>
								<tr>
									<th>銀行代碼</th>
									<td>${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_bank}</td>
								</tr>
								<tr>
									<th>匯款帳號</th>
									<td>${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_account}</td>
								</tr>
								<tr>
									<th>帳戶證明</th>
									<td><img src="${pageContext.request.contextPath}/LanlordPicReadServlet?lld_no=${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_no}"  class="lld_acc_pic"></td>
								</tr>
								<tr>
									<th>審核狀態</th>
									<td>
										<c:choose>
											<c:when test="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_status == 0}">未審核</c:when>
											<c:when test="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_status == 1}">審核通過</c:when>
											<c:when test="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_status == 2}">審核不通過</c:when>
											<c:when test="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_status == 3}">停權</c:when>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>通過時間</th>
									<td><fmt:formatDate value="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_id_isvrfed}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								</tr>
								<tr>
									<th>未通過原因</th>
									<td>${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_id_disapprove}</td>
								</tr>
								<c:if test="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_status != 0}">
								<tr>
									<th>再次提出申請</th>
									<td>
										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/lanlord/lanlord.do" style="margin-bottom: 0px;">
			     						<input type="submit" value="再次提出申請">
			     						<input type="hidden" name="lld_no"  value="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_no}">
			     						<input type="hidden" name="action"	value="getOneForApp"></FORM>
			     					</td>
								</tr>
								</c:if>
								
					  </tbody>
					</table>

				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

<!-- 上傳圖片可預覽 -->
<script>
window.onload=function(){

	let myFile = document.getElementById("lld_acc_pic");
    let preview = document.getElementById("previewp");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgp');
                    img.src = result;
                    preview.append(img);
                    $("imgp:first").remove(); // 預覽只會保留最新上傳的
                });
                reader.readAsDataURL(file);
            } else {
                alert('請上傳圖片！');
            }
        }
    });
	
}



</script>

</body>


<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
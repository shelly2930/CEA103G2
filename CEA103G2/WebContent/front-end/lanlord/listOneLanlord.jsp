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
                
                <!--================ ���n���ܦۤv�R�� =================-->
                <div class="pagetitle">�ЪF��Ƭd�ݻP�ק�${memTenVO.mem_username}</div>
				
				<!--�@�@�@�����������������������e���������������������@�@�@-->
					<%-- ���~��C --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color:red">�Эץ��H�U���~:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color:red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>
					
					
					<table class="table">
						<tbody>
					  		<tr>
									<th>�ЪF�s��</th>
									<td>${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_no}</td>
								</tr>
								<tr>
									<th>�|���s��</th>
									<td>${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).mem_no}</td>
								</tr>
								<tr>
									<th>�ӽЮɶ�</th>
									<td><fmt:formatDate value="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_apptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								</tr>
								<tr>
									<th>�Ȧ�N�X</th>
									<td>${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_bank}</td>
								</tr>
								<tr>
									<th>�״ڱb��</th>
									<td>${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_account}</td>
								</tr>
								<tr>
									<th>�b���ҩ�</th>
									<td><img src="${pageContext.request.contextPath}/LanlordPicReadServlet?lld_no=${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_no}"  class="lld_acc_pic"></td>
								</tr>
								<tr>
									<th>�f�֪��A</th>
									<td>
										<c:choose>
											<c:when test="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_status == 0}">���f��</c:when>
											<c:when test="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_status == 1}">�f�ֳq�L</c:when>
											<c:when test="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_status == 2}">�f�֤��q�L</c:when>
											<c:when test="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_status == 3}">���v</c:when>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>�q�L�ɶ�</th>
									<td><fmt:formatDate value="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_id_isvrfed}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								</tr>
								<tr>
									<th>���q�L��]</th>
									<td>${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_id_disapprove}</td>
								</tr>
								<c:if test="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_status != 0}">
								<tr>
									<th>�A�����X�ӽ�</th>
									<td>
										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/lanlord/lanlord.do" style="margin-bottom: 0px;">
			     						<input type="submit" value="�A�����X�ӽ�">
			     						<input type="hidden" name="lld_no"  value="${lanlordSvc.getOneLanlordByMemTen(MemTenVO.mem_no).lld_no}">
			     						<input type="hidden" name="action"	value="getOneForApp"></FORM>
			     					</td>
								</tr>
								</c:if>
								
					  </tbody>
					</table>

				<!--�@�@�@�����������������������e���������������������@�@�@-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

<!-- �W�ǹϤ��i�w�� -->
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
                    $("imgp:first").remove(); // �w���u�|�O�d�̷s�W�Ǫ�
                });
                reader.readAsDataURL(file);
            } else {
                alert('�ФW�ǹϤ��I');
            }
        }
    });
	
}



</script>

</body>


<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lanlord.model.*"%>

<%
	LanlordVO lanlordVO = (LanlordVO) request.getAttribute("lanlordVO");
%>

<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/nice-select.css">

<title></title>

<style>
body { 
	background-color: #dddddd !important;
}

img.mem_pic {
  	height: 200px;
  	width: auto;
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
                <div class="pagetitle">���s���X�ӽ�</div>
				
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
					
					--${lanlordSession.lld_no }--${lanlordVO.lld_no }--
					<FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/lanlord/lanlord.do" name="form1">
					<table class="table">
					  <tbody>
					  	<tr>
					    	<th>�ЪF�s��</th>
					    	<td><%=lanlordVO.getLld_no()%></td>
					    </tr>
					  	<tr>
					    	<th>�|���s��</th>
					    	<td><%=lanlordVO.getMem_no()%></td>
					    </tr>
					    <tr>
					    	<th>�Ȧ�N�X</th>
					    	<td><input type="TEXT" name="lld_bank" size="45" required class="single-input" value="<%=lanlordVO.getLld_bank()%>" /></td>
					    </tr>
					    <tr>
					    	<th>�״ڱb��</th>
					    	<td>
					    		<input type="TEXT" name="lld_account" size="45" required class="single-input" value="<%=lanlordVO.getLld_account()%>" />
							</td>
					    </tr>
					    <tr>
					    	<th>�b���ҩ�</th>
					    	<td>
					    		<div id="previewp"></div>
					    		<img id="imgp"  src="<%=request.getContextPath()%>/LanlordPicReadServlet?lld_no=${lanlordVO.lld_no}"  class="lld_acc_pic">
					    		<input type="file" name="lld_acc_pic" id="lld_acc_pic" size="45">
					    	</td>
					    </tr>
					    <tr>
							<th>�e�X�ӽ�</th>
							<td>
								<input type="hidden" name="action" value="authagain">
								<input type="hidden" name="mem_no" value="<%=lanlordVO.getLld_no()%>">
								<input type="submit" value="�e�X�ӽ�">
							</td>
						</tr>
					  </tbody>
					</table>
					</FORM>

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
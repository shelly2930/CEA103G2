<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lanlord.model.*"%>

<%
	LanlordVO lanlordVO = (LanlordVO) request.getAttribute("lanlordVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>


<title>�����ЪF - addLanlord.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  form {
    display: block;
    padding-top:90px;   
}
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
  img {
  	width: 200px;
  	height: auto;
  }
</style>

</head>
<body>

<%@include file="/front-end/header.file"%>


<!-- <table id="table-1"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>�����ЪF - addLanlord.jsp</h3></td><td> -->
<%-- 		 <h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="<%=request.getContextPath()%>/images/tomcat.png" width="100" height="100" border="0">�^����</a></h4> --%>
<!-- 	</td></tr> -->
<!-- </table> -->

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>


<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/lanlord/lanlord.do" name="form1">
<table>
	<tr>
		<td>�|���s��:</td>
		<td>${MemTenVO.mem_no}</td>
	</tr>
	<tr>
		<td>�Ȧ�N�X:</td>
		<td><input type="TEXT" name="lld_bank" size="45"
			 value="<%= (lanlordVO==null)? "012" : lanlordVO.getLld_bank()%>" /></td>
	</tr>
	<tr>
		<td>�״ڱb��:</td>
		<td><input type="TEXT" name="lld_account" size="45"
			 value="<%= (lanlordVO==null)? "706168803737" : lanlordVO.getLld_account()%>" /></td>
	</tr>
	<tr>
		<td>�b���ҩ�:</td>
		<td><div id="preview"></div><input type="file" name="lld_acc_pic" id="lld_acc_pic" size="45" /></td>
	</tr>
	

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>

<!-- �W�ǹϤ��i�w�� -->
<script>
function init() {

    let myFile = document.getElementById("lld_acc_pic");
    let preview = document.getElementById("preview");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.createElement('img');
                    img.src = result;
                    preview.append(img);
                    $("img:first").remove(); // �w���u�|�O�d�̷s�W�Ǫ�
                });
                reader.readAsDataURL(file);
            } else {
                alert('�ФW�ǹϤ��I');
            }
        }
    });
}

window.onload = init;
</script>

</body>


<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�A�[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<!-- �n��b�̤U�� -->
<%@include file="/front-end/footer.file"%>

</html>
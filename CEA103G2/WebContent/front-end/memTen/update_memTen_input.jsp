<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memTen.model.*"%>

<%
// 	MemTenVO memTenVO = (MemTenVO) request.getAttribute("memTenVO"); //EmpServlet.java (Concroller) �s�Jreq��memTenVO���� (�]�A�������X��memTenVO, �]�]�A��J��ƿ��~�ɪ�memTenVO����)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�A�[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<script src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.1/dist/tw-city-selector.min.js"></script>

<title>���Ϋe��ƭק� - update_memTen_input.jsp</title>

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
  img.pic {
  	height: auto;
  	width: 200px;
  }
</style>

</head>
<body bgcolor='white'>

<!-- �a�}�s�ʿ�� -->
<script>
	new TwCitySelector();	
</script>

<table id="table-1">
	<tr><td>
		 <h3>�|����ƭק� - update_memTen_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="<%=request.getContextPath()%>/front-end/memTen/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��ƭק�:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" name="form1">
<table>
	<tr>
		<td>�|���s��:<font color=red><b>*</b></font></td>
		<td>${MemTenVO.mem_no}</td>
	</tr>
	<tr>
		<td>�m�W:</td>
		<td><input type="TEXT" name="mem_name" size="45" value="${MemTenVO.mem_name}" /></td>
	</tr>
	<tr>
		<td>�����Ҧr��:</td>
		<td><input type="TEXT" name="mem_id" size="45"	value="${MemTenVO.mem_id}" /></td>
	</tr>
	<tr>
		<td>��ʹq��:</td>
		<td><input type="TEXT" name="mem_mobile" size="45"	value="${MemTenVO.mem_mobile}" /></td>
	</tr>
	<tr>
		<td>�a�}:</td>
		<td>
			<div role="tw-city-selector" data-has-zipcode data-hidden-zipcode data-county-value="${MemTenVO.mem_city}"
     			data-district-value="${MemTenVO.mem_dist}"></div>
			<input type="TEXT" name="mem_addr" size="45" value="${MemTenVO.mem_addr}"/>
		</td>
	</tr>
	<tr>
		<td>�����ҥ���:</td>
		<td><div id="previewf"></div><img id="imgf" src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?action=getidcardf&mem_no=${memTenVO.mem_no}" class="mem_pic">
		<input type="file" name="mem_idcard_f" id="idcardf"></td>
	</tr>
	<tr>
		<td>�����ҭI��:</td>
		<td><div id="previewr"></div><img id="imgr" src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?action=getidcardr&.do?mem_no=${memTenVO.mem_no}" class="mem_pic">
		<input type="file" name="mem_idcard_r" id="idcardr"></td>
	</tr>
	
	


</table>
<br>
<input type="hidden" name="action" value="rentalConfirm">
<input type="hidden" name="mem_no" value="${MemTenVO.mem_no}">
<input type="submit" value="�e�X�ӽ�"></FORM>


<!-- �W�ǹϤ��i�w�� -->
<script>
window.onload=function(){

    let myFile = document.getElementById("idcardf");
    let preview = document.getElementById("previewf");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgf');
                    img.src = result;
                    preview.append(img);
                    $("imgf:first").remove(); // �w���u�|�O�d�̷s�W�Ǫ�
                });
                reader.readAsDataURL(file);
            } else {
                alert('�ФW�ǹϤ��I');
            }
        }
    });
    
    let myFiler = document.getElementById("idcardr");
    let previewr = document.getElementById("previewr");

    myFiler.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgr');
                    img.src = result;
                    previewr.append(img);
                    $("imgr:first").remove(); // �w���u�|�O�d�̷s�W�Ǫ�
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
</html>
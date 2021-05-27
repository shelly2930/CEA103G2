<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furPho.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%
  FurPhoVO furPhoVO = (FurPhoVO) request.getAttribute("furPhoVO"); //EmpServlet.java (Concroller) �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
  FurIteService furIteSvc = new FurIteService();
  FurIteVO furIteVO=new FurIteVO();
  furIteVO=furIteSvc.getOneFurIte(furPhoVO.getFnt_it_no());
  pageContext.setAttribute("furIteVO",furIteVO);
%>

�ݳB�z�󴫷Ӥ����D

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�a��Ӥ��ק� </title>

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

  table {
	width: 630px;
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
</style>

</head>


<body bgcolor='white'>
<table id="table-1">
	<tr><td>
		 <h3>�a��~���Ӥ��ק� - update_FurPho_input.jsp</h3>
		 </td>
	<td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furPho/listAllFurPho.jsp?fnt_it_no=10"><img src="images/tomcat.png" width="100" height="100" border="0">��^�a��Ӥ��޲z</a></h4>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furPho/furPho.do" enctype="multipart/form-data" name="form1">
<table>
<tr>
	<th>�Ӥ��s��:</th>
	<td>${furPhoVO.fnt_pic_no}</td>
	
</tr>

	<tr>
		<th>�~���W�١G</th>
			<td>${furIteVO.fnt_name}</td>
	</tr>
	<tr>
		<th>�a��Ӥ��G</th>
		<td>
		<img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}"
					height="100">
		<input type="file" id="load" name="fnt_pic" size="45" />
		</td>
	</tr>


</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="fnt_pic_no"  value="<%=furPhoVO.getFnt_pic_no()%>">
<input type="hidden" name="fnt_it_no"  value="<%=furPhoVO.getFnt_it_no()%>">
<input type="submit" value="�e�X�ק�"></FORM>
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->


</html>
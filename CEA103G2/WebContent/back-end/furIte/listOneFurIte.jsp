<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furCat.model.*"%>
�ݳB�z�Ϥ���ܤΤޤJ�a�����O�W�� �L�k����Ȱ��D

<%
  FurIteVO furIteVO = (FurIteVO) request.getAttribute("furIteVO"); //EmpServlet.java(Concroller), �s�Jreq��furIteVO����
%>

<html>
<head><!--  -->
<title>�a��~����� - listOneFurIte.jsp</title>

<style>
  table#table-1 {
  width: 610px;
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
   table th {
	width: 130px;
  }
  table td {
  width: 450px;}
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
 
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align:left;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>�a��~����� - ListOneFurIte.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furIte/listAllFurIte.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">��^�~���޲z</a></h4>
	</td></tr>
</table>

<table>
	<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
	<tr>
		<th>�a��~���s��:</th>
		<td><%=furIteVO.getFnt_it_no()%></td>
	</tr>
	<tr>
		<th>�a�����O�W��:</th>
		<td>
			<c:forEach var="furCatVO" items="${furCatSvc.all}">
			${(furCatVO.fnt_ctgr_no==furIteVO.fnt_ctgr_no)? furCatVO.fnt_ctgr_name:''} 
			</c:forEach> 
			</td> 
 <!-- 		�إ߷s�W�a�����O���s --> 
	</tr>
	<tr>
		<th>�a��~���W��:</th>
		<td>${furIteVO.fnt_name}</td>
	</tr>
<!-- 	<tr> -->
<!-- 		<th>�a��Ϥ�:</th> -->
<!-- 		<td></td> -->
<!-- 	</tr> -->
	<tr>
		<th>�i���ƶq:</th>
		<td>${furIteVO.fnt_unrent}</td>
	</tr>
	<tr>
		<th>���׼ƶq:</th>
		<td>${furIteVO.fnt_repair}</td>
	</tr>
	<tr>
		<th>�`�ƶq:</th>
		<td>${furIteVO.fnt_total}</td>
	</tr>
	<tr>
		<th>�X������:</th>
		<td>${furIteVO.fnt_price}</td>
	</tr>
	<tr>
		<th>����:</th>
		<td>${furIteVO.fnt_length}</td>
	</tr>
	<tr>
		<th>�e��:</th>
		<td>${furIteVO.fnt_width}</td>
	</tr>
	<tr>
		<th>����:</th>
		<td>${furIteVO.fnt_height}</td>
	</tr>
	<tr>
		<th>���q:</th>
		<td>${furIteVO.fnt_weight}</td>
	</tr>
	<tr>
		<th>�W��:</th>
		<td>${furIteVO.fnt_standard}</td>
	</tr>
		<tr>
		<th>�~������:</th>
 		<td>${furIteVO.fnt_info}</td>
	</tr>
	<tr>
		<th>�s������:</th>
		<td>${furIteVO.fnt_views}</td>
	</tr>	
	
</table>
 
</body>
</html>
<%@page import="com.mysql.fabric.xmlrpc.base.Param"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furPho.model.*"%>
<%@ page import="com.furIte.model.*"%>

<%
Integer fnt_it_no=null;
if(request.getParameter("fnt_it_no")==null){
	//�Ӧۤ@�}�l�s�W�~���� �U�@������̫�@�ӽs�� �Hattribute�覡�e�Ӧܦ�����fnt_it_no
	fnt_it_no=(Integer)(request.getAttribute("fnt_it_no"));
}else{
	//�Ӧ�ListAllFurIte�����X�������s�W�Ӥ��s �H����get?=�ǰe�Ѽƪ��覡�Ө즹��
	fnt_it_no=new Integer(request.getParameter("fnt_it_no"));
	}
FurIteService furIteSvc = new FurIteService();
FurIteVO furIteVO=new FurIteVO();
furIteVO=furIteSvc.getOneFurIte(fnt_it_no);
pageContext.setAttribute("furIteVO",furIteVO);

%>

 �ݸѨM���Ӥ����D ���n����^�W�@���~�����e�\��??  �w�dh4
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�a��Ӥ��s�W</title>

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
	width: 600px;
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
		 <h3>�a��~���Ӥ��s�W - addFurPho.jsp</h3>
		 </td>
	<td>
<!-- 	���n����^�W�@���~�����e�\��??  �w�d-->
		 <h4></h4>
	</td></tr>
</table>

<h3>�a��~���Ӥ��s�W:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post"  ACTION="<%=request.getContextPath()%>/furPho/furPho.do"  enctype="multipart/form-data"  name="form1">
<table>
<%-- 	<jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" /> --%>
	<tr>
		<th>�a��~���W�١G</th>
     	<td>${furIteVO.fnt_name}</td>
	</tr>	
	
	<tr>
		<th>�a��Ӥ��G</th>
		<td>
		<input type="file" id="load" name="fnt_pic" size="45"  multiple/>
		<div id="picView">
		</div>
		</td>
	</tr>

</table>
<br>
<p>   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b></p>

<input type="hidden"  name="action"  value="insert_pic">
<input type="hidden"  name="fnt_it_no"  value="${fnt_it_no}">
<input type="submit" value="�e�X�s�W"></FORM>
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furCat.model.*"%>

<%
   FurCatVO furCatVO = (FurCatVO) request.getAttribute("furCatVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�a�����O��Ʒs�W - addFurCat.jsp</title>


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
		 <h3>�a�����O��Ʒs�W - addFurCat.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furCat/listAllFurCat.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">��^���O�޲z</a></h4>
	</td></tr>
</table>

<h3>��Ʒs�W:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCat/furCat.do" name="form1">
<table>
	<tr>
		<td>�a�����O�W��:</td>
		<td><input type="TEXT" name="fnt_ctgr_name" size="45" 
			 value="<%= (furCatVO==null)? "" : furCatVO.getFnt_ctgr_name()%>" /></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>
</body>
</html>
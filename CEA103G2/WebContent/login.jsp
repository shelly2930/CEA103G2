<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>�|���n�J</title>
<style>
	body {
		text-align: center;
	}
	table {
		margin: 50px auto 0px;
		border-collapse: collapse;
	}
	table td, table th {
		border: 1px solid #ddd;
 		padding: 8px;
	}
</style>
</head>

<body>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<form method="post" action="<%=request.getContextPath()%>/memTen/memTen.do" name="form1">

<table>
	<tr>
		<th>�|���n�J</th>
		<th>�ߧY���U</th>
	</tr>
	<tr>
		<td>�b���G</td>
		<td><input type="text" name="mem_username"></td>
	</tr>
	<tr>
		<td>�K�X�G</td>
		<td><input type="password" name="mem_password"></td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="login">
<input type="submit" value="�n�J">

</form>


</body>
</html>
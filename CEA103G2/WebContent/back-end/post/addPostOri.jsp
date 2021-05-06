<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.post.model.*"%>

<%
	PostVO postVO = (PostVO) request.getAttribute("postVO");
%>

<%=postVO == null%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>���u��Ʒs�W - addPost.jsp</title>

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
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>���u��Ʒs�W - addPost.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/indexBack.jsp">
						<img src="<%=request.getContextPath() %>/back-end/post/images/house.jpg" width="100" height="100" border="0">�^����</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>��Ʒs�W:</h3>

	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/post/post.do" name="form1">
		<table>
			<tr>
				<td>���i���D:</td>
				<td><input type="TEXT" name="post_title" size="45"
					value="<%=(postVO == null) ? "�п�J���i���D" : postVO.getPost_title()%>" /></td>
			</tr>
			<tr>
				<td>���i���e:</td>
				<td><textarea rows="5" cols="50" name="post_content"><%=(postVO == null) ? "�п�J���i���e" : postVO.getPost_content()%></textarea></td>
			</tr>

			<jsp:useBean id="postSvc" scope="page"
				class="com.post.model.PostService" />
			<tr>

				<td>���i���A:<font color=red><b>*</b></font></td>
				<td><select name="post_status">
						<option value="0">�U�[</option>
						<option value="1">�W�[</option>
				</select></td>
			</tr>




		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="�e�X�s�W">
	</FORM>
</body>

</html>
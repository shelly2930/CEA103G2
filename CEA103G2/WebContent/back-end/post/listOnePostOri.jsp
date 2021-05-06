<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.post.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>

<%
	PostVO postVO = (PostVO) request.getAttribute("postVO");
%>

<html>
<head>
<title>個別公告 - listOnePost.jsp</title>

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
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
	width: 50px;
}
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>員工資料 - ListOnePost.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/post/select_page.jsp"><img
						src="<%=request.getContextPath()%>/back-end/post/images/house.jpg"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>公告編號</th>
			<th>公告日期</th>
			<th>公告標題</th>
			<th>公告內文</th>
			<th>公告狀態</th>
		</tr>
		<tr>
			<td><%=postVO.getPost_no()%></td>
			<td><fmt:formatDate value="${postVO.post_time}"
					pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td><%=postVO.getPost_title()%></td>
			<td><%=postVO.getPost_content()%></td>
			<td>			
			<c:choose>
				<c:when test="${postVO.post_status==0}">下架</c:when>
				<c:when test="${postVO.post_status==1}">上架</c:when>
				<c:when test="${postVO.post_status==2}">錯誤</c:when>
			</c:choose>
			</td> 

		</tr>
	</table>

</body>
</html>
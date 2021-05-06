<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	List<PostVO> list = (ArrayList<PostVO>) (request.getAttribute("list"));
%>


<html>
<head>
<title>所有公告資料 - listAllPost.jsp</title>


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
	width: 800px;
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
				<h3>所有表格資料 - listAllPost.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/sidebarBack.jsp"><img
						src="<%=request.getContextPath()%>/back-end/post/images/house.jpg"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table >
		<tr>
			<th>公告編號</th>
			<th>公告日期</th>
			<th>公告標題</th>
			<th>公告內文</th>
			<th>公告狀態</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="postVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${postVO.post_no}</td>
				<td><fmt:formatDate value="${postVO.post_time}"
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>${postVO.post_title}</td>

				<td>${postVO.post_content}</td>
				<td><c:choose>
						<c:when test="${postVO.post_status==0}">下架</c:when>
						<c:when test="${postVO.post_status==1}">上架</c:when>
						<c:when test="${postVO.post_status==2}">錯誤</c:when>
					</c:choose></td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/post/post.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> <input type="hidden"
							name="post_no" value="${postVO.post_no}"> <input
							type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/post/post.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="post_no" value="${postVO.post_no}"> <input
							type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>
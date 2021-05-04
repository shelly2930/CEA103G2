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

<%@include file="/front-end/header.file"%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template_front-end/css/all.css">
<title>所有員工資料 - listAllPost.jsp</title>
<script
	src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<style>
div a {
	color: #0000EE;
	text-decoration: none;
}

</style>

<style>
table {
	width: 800px;
	background-color: white;
	margin-top: 100px;
	margin-bottom: 5px;
	margin-left: auto;
	margin-right: auto;
}

table, th, td {
	border: 1px solid black;
}

th, td {
	padding: 5px;
	text-align: center;
	width: 50px;
}
</style>

</head>
<body bgcolor='white'>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table>
		<tr>
			<th>公告標題</th>
			<th><div id="desc">
					<a
						href="<%=request.getContextPath()%>/post/post.do?action=listAllFront&status=0">
						公告日期<i class="fas fa-sort-up"></i>
					</a>
				</div>
				<div id="asc">
					<a
						href="<%=request.getContextPath()%>/post/post.do?action=listAllFront&status=1">
						公告日期<i class="fas fa-sort-down"></i>
					</a>
				</div></th>



		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="postVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td><a
					href="<%=request.getContextPath() %>/post/post.do?action=GoToOneContent&post_no=${postVO.post_no}">${postVO.post_title}</a></td>
				<td><fmt:formatDate value="${postVO.post_time}"
						pattern="yyyy-MM-dd HH:mm:ss" /></td>


			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

	<script>
		$(function(){
			if(${param.status}==0){
				$("#desc").hide();
			}else{
				$("#asc").hide();
			}
		})
	</script>
<%@ include file="/front-end/footer.file"%>
</body>
</html>
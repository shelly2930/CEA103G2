<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.post.model.*"%>

<%
	PostVO postVO = (PostVO) request.getAttribute("postVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>後台公告修改 - update_post_input.jsp</title>

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
				<h3>公告修改 - update_post_input.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/post/select_page.jsp"><img
						src="<%=request.getContextPath() %>/back-end/post/images/house.jpg" width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
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
				<td>公告編號:<font color=red><b>*</b></font></td>
				<td><%=postVO.getPost_no()%></td>
			</tr>
			<tr>
				<td>公告時間:</td>
				<td><%=postVO.getPost_time()%></td>
			</tr>
			<tr>
				<td>公告標題:</td>
				<td><input type="TEXT" name="post_title" size="45"
					value="<%=postVO.getPost_title()%>" /></td>
			</tr>
			<tr>
				<td>公告內容:</td>
				<td><textarea rows="5" cols="50" name="post_content"><%=(postVO == null) ? "請輸入公告內容" : postVO.getPost_content()%></textarea></td>
			</tr>
			<tr>
				<td>公告狀態:</td>
				<td><select name="post_status">
					<option value="0">下架</option>
					<option value="1">上架</option>	
					</select>
					</td>
			</tr>

			<jsp:useBean id="postSvc" scope="page"
				class="com.post.model.PostService" />
			

		</table>
		<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="post_no" value="<%=postVO.getPost_no()%>">
		<input type="submit" value="送出修改">
	</FORM>
</body>

</html>
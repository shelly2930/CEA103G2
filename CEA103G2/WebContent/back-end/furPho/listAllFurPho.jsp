<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furPho.model.*"%>
<%@ page import="com.furCat.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="java.io.*"%>
家具待處理 照片預覽及照片更換後即時呈現在更換家具品項(update_furIte)頁面
<%
    Integer fnt_it_no=new Integer(request.getParameter("fnt_it_no"));
	FurPhoService furPhoSvc = new FurPhoService();
	List<FurPhoVO> list = furPhoSvc.getOneFntItePics(fnt_it_no);
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="furIteDAO" scope="page"
	class="com.furIte.model.FurIteDAO" />
<jsp:useBean id="furCatDAO" scope="page"
	class="com.furCat.model.FurCatDAO" />

<html>
<head>
<title>所有家具品項照片 - listAllFurPho.jsp</title>

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

#searchButton {
	border: 0;
	background-color: #628AC0;
	color: #fff;
	border-radius: 10px;
	height: 35px;
	width: 150px;
	font-size: 20px;
	text-align: center;
}

table {
	width: 700px;
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
}
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>
					家具照片管理<br>
					<font color=blue>listAllFntPho</font>
				</h3>
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

	<a href="<%=request.getContextPath()%>/back-end/furPho/addFurPho.jsp?fnt_it_no=${param.fnt_it_no}">
		<input type="button" value="新增品項照片" id="searchButton">
	</a>
	<br>

<%-- 	<%@ include file="page1.file"%> --%>
	<table>
		<tr>
			<th>照片<br>編號
			</th>
<!-- 			<th>家具類別<br>名稱 -->
<!-- 			</th> -->
			<th>品項名稱</th>
			<th>家具照片</th>
			<th>更換</th>
			<th>刪除</th>
		</tr>

				<%@ include file="page1_furPho.file"%>
		<c:forEach var="furPhoVO" items="${list}"  begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
<%-- 頁面拿掉		begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" --%>
			<tr>
				<td>${furPhoVO.fnt_pic_no}</td>
				<!-- 		雙層join取值 -->
				<!-- 			家具類別名稱 -->
<%-- 				<td><c:forEach var="furIteVO" items="${furIteDAO.all}"> --%>
<%-- 						<c:if test="${furPhoVO.fnt_it_no==furIteVO.fnt_it_no}"> --%>
<%-- 							<c:forEach var="furCatVO" items="${furCatDAO.all}"> --%>
<%-- 								<c:if test="${furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no}"> --%>
<%--                     ${furCatVO.fnt_ctgr_name} --%>
<%--                     </c:if> --%>
<%-- 							</c:forEach> --%>
<%-- 						</c:if> --%>
<%-- 					</c:forEach></td> --%>
				<!-- 			家具品項名稱 -->
				<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
						<c:if test="${furPhoVO.fnt_it_no==furIteVO.fnt_it_no}">
	                    ${furIteVO.fnt_name}
                    </c:if>
					</c:forEach></td>
				<!-- 			家具照片 -->
				<td><img
					src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}"
					height="100"></td>
				<!-- 			修改 -->
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/furPho/furPho.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="更換"> <input type="hidden"
							name="fnt_pic_no" value="${furPhoVO.fnt_pic_no}"> <input
							type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<!-- 				刪除 -->
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/furPho/furPho.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="fnt_pic_no" value="${furPhoVO.fnt_pic_no}">
							<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
							<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2_furPho.file"%>

</body>
</html>
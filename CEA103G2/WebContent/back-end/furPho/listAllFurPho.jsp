<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furPho.model.*"%>
<%@ page import="com.furCat.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="java.io.*"%>
�a��ݳB�z �Ӥ��w���ηӤ��󴫫�Y�ɧe�{�b�󴫮a��~��(update_furIte)����
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
<title>�Ҧ��a��~���Ӥ� - listAllFurPho.jsp</title>

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
					�a��Ӥ��޲z<br>
					<font color=blue>listAllFntPho</font>
				</h3>
			</td>
		</tr>

	</table>



	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<a href="<%=request.getContextPath()%>/back-end/furPho/addFurPho.jsp?fnt_it_no=${param.fnt_it_no}">
		<input type="button" value="�s�W�~���Ӥ�" id="searchButton">
	</a>
	<br>

<%-- 	<%@ include file="page1.file"%> --%>
	<table>
		<tr>
			<th>�Ӥ�<br>�s��
			</th>
<!-- 			<th>�a�����O<br>�W�� -->
<!-- 			</th> -->
			<th>�~���W��</th>
			<th>�a��Ӥ�</th>
			<th>��</th>
			<th>�R��</th>
		</tr>

				<%@ include file="page1_furPho.file"%>
		<c:forEach var="furPhoVO" items="${list}"  begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
<%-- ��������		begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" --%>
			<tr>
				<td>${furPhoVO.fnt_pic_no}</td>
				<!-- 		���hjoin���� -->
				<!-- 			�a�����O�W�� -->
<%-- 				<td><c:forEach var="furIteVO" items="${furIteDAO.all}"> --%>
<%-- 						<c:if test="${furPhoVO.fnt_it_no==furIteVO.fnt_it_no}"> --%>
<%-- 							<c:forEach var="furCatVO" items="${furCatDAO.all}"> --%>
<%-- 								<c:if test="${furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no}"> --%>
<%--                     ${furCatVO.fnt_ctgr_name} --%>
<%--                     </c:if> --%>
<%-- 							</c:forEach> --%>
<%-- 						</c:if> --%>
<%-- 					</c:forEach></td> --%>
				<!-- 			�a��~���W�� -->
				<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
						<c:if test="${furPhoVO.fnt_it_no==furIteVO.fnt_it_no}">
	                    ${furIteVO.fnt_name}
                    </c:if>
					</c:forEach></td>
				<!-- 			�a��Ӥ� -->
				<td><img
					src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}"
					height="100"></td>
				<!-- 			�ק� -->
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/furPho/furPho.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="��"> <input type="hidden"
							name="fnt_pic_no" value="${furPhoVO.fnt_pic_no}"> <input
							type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<!-- 				�R�� -->
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/furPho/furPho.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="�R��"> <input type="hidden"
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
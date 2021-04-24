<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memTen.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	MemTenVO memTenVO = (MemTenVO) request.getAttribute("memTenVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>會員資料 - listOneMemTen.jsp</title>

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
  }
  img.mem_pic {
  	height: 200px;
  	width: auto;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>會員資料 - ListOneMemTen.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/memTen/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>會員編號</th>
		<th>帳號</th>
		<th>密碼</th>
		<th>照片</th>
		<th>姓名</th>
		<th>性別</th>
		<th>身分證字號</th>
		<th>出生年月日</th>
		<th>連絡電話</th>
		<th>行動電話</th>
		<th>電子信箱</th>
		<th>地址</th>
		<th>身分證正面</th>
		<th>身分證背面</th>		
	</tr>
	<tr>
		<td><%=memTenVO.getMem_no()%></td>
		<td><%=memTenVO.getMem_username()%></td>
		<td><%=memTenVO.getMem_password()%></td>
<%-- 		<td><%=memTenVO.getMem_pic()%></td> --%>
		<td><img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?mem_no=${memTenVO.mem_no}"  class="mem_pic"></td>
		<td><%=memTenVO.getMem_name()%></td>
		<td>
			<c:choose>
				<c:when test="${memTenVO.mem_gender == 0}">男</c:when>
				<c:when test="${memTenVO.mem_gender == 1}">女</c:when>
			</c:choose>
		</td>
		<td><%=memTenVO.getMem_id()%></td>
		<td><%=memTenVO.getMem_birthday()%></td>
		<td><%=memTenVO.getMem_phone()%></td>
		<td><%=memTenVO.getMem_mobile()%></td>
		<td><%=memTenVO.getMem_email()%></td>
		<td><%=memTenVO.getMem_addr()%></td>
		<td><%=memTenVO.getMem_idcard_f()%></td>
		<td><%=memTenVO.getMem_idcard_r()%></td>
	</tr>
</table>

</body>
</html>
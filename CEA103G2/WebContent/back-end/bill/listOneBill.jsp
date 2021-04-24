<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.bill.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  BillVO billVO = (BillVO) request.getAttribute("billVO"); //EmpServlet.java(Concroller), 存入req的billVO物件
%>

<html>
<head>
<title>每月房客帳單資料 - listOneBill.jsp</title>

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
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>每月房客帳單資料 - listOneBill.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/bill/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/bill/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>房客帳單編號</th>
		<th>會員編號</th>
		<th>物件編號</th>
		<th>帳單日期</th>
		<th>繳費期限</th>
		<th>本月用電量</th>
		<th>本月用水量</th>
		<th>房客繳費狀態</th>
		<th>房東撥款狀態</th>
	</tr>
	<tr>
		<td><%=billVO.getBill_no()%></td>
		<td><%=billVO.getMem_no()%></td>		
		<td><%=billVO.getHos_no()%></td>
		<td><fmt:formatDate value="<%=billVO.getBill_date()%>" pattern="yyyy-MM"/></td>
		<td><%=billVO.getBill_due()%></td>
		<td><%=billVO.getBill_power()%></td>
		<td><%=billVO.getBill_water()%></td>
<!-- 		script的寫法還沒想到 -->
		<td>
			<c:choose>
					<c:when test="${billVO.bill_p_status == 0}">未繳費</c:when>
					<c:when test="${billVO.bill_p_status == 1}">已繳費</c:when>
			</c:choose>
		</td>
		<td>
			<c:choose>
					<c:when test="${billVO.bill_r_status == 0}">未繳費</c:when>
					<c:when test="${billVO.bill_r_status == 1}">已繳費</c:when>
			</c:choose>
		</td>
	</tr>
</table>

</body>
</html>
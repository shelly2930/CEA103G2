<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.bill.model.*"%>
<!DOCTYPE html>

<%
    BillService billSvc = new BillService();
    List<BillVO> list = billSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>所有每月房客帳單資料 - listAllBill.jsp</title>

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
  }
</style>

</head>
<body>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有每月房客帳單資料 - listAllBill.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/bill/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

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
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="billVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
<!-- line93、94參formatDate.jsp 自訂時間格式 -->
		<tr>
			<td>${billVO.bill_no}</td>
			<td>${billVO.mem_no}</td>
			<td>${billVO.hos_no}</td>
			<td><fmt:formatDate value="${billVO.bill_date}" pattern="yyyy-MM"/></td>
			<td><fmt:formatDate value="${billVO.bill_due}" pattern="yyyy-MM-dd"/></td>
			<td>${billVO.bill_power}</td>
			<td>${billVO.bill_water}</td> 
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
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/bill/bill.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="bill_no"  value="${billVO.bill_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/bill/bill.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="bill_no"  value="${billVO.bill_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>
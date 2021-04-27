<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.employee.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    EmployeeService employeeSvc = new EmployeeService();
    List<EmployeeVO> list = employeeSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有員工資料 - listAllEmp.jsp</title>

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
	width: 1000px;
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

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有員工資料 - listAllEmp.jsp</h3>
		 <h4><a href="/CEA103G2/back-end/employee/select_page.jsp"><img src="/CEA103G2/back-end/employee/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message.value}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>員工編號</th>
		<th>員工代號</th>
		<th>姓名</th>
		<th>性別</th>
		<th>行動電話</th>
		<th>職位</th>
		<th>薪資</th>
		<th>獎金</th>
		<th>到職日</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="employeeVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${employeeVO.emp_no}</td>
			<td>${employeeVO.emp_username}</td>
			<td>${employeeVO.emp_name}</td>
			<c:choose>
				<c:when test="${employeeVO.emp_gender == 0}"> <td></td>  </c:when>
				<c:when test="${employeeVO.emp_gender == 1}"> <td>男</td> </c:when>
				<c:when test="${employeeVO.emp_gender == 2}"> <td>女</td> </c:when>
			</c:choose>
			<td>${employeeVO.emp_mobile}</td>
			<td>${employeeVO.emp_job}</td>
			<td>${employeeVO.emp_sal}</td>
			<td>${employeeVO.emp_bonus}</td>
			<td>${employeeVO.emp_hiredate}</td>
<%-- 			<td><fmt:formatDate value="${employeeVO.hiredate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> 可更改時間顯示樣式 --%>

			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/employee/employee.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="emp_no" value="${employeeVO.emp_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/employee/employee.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="emp_no" value="${employeeVO.emp_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>
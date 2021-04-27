<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  EmployeeVO employeeVO = (EmployeeVO) request.getAttribute("employeeVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>員工資料 - listOneEmp.jsp</title>

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
  table {
	width: 500px;
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
  img {
  	width: 350px;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - ListOneEmp.jsp</h3>
		 <h4><a href="/CEA103G2/back-end/employee/select_page.jsp"><img src="/CEA103G2/back-end/employee/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>頭像</th>
		<td><img src="<%=request.getContextPath()%>/employee/PhotoReader.do?emp_no=${employeeVO.emp_no}"></td>
	</tr>
	<tr>
		<th>員工編號</th>
		<td>${employeeVO.emp_no}</td>
	</tr>
	<tr>
		<th>員工代號</th>
		<td>${employeeVO.emp_username}</td>
	</tr>
	<tr>
		<th>姓名</th>
		<td>${employeeVO.emp_name}</td>
	</tr>
	<tr>
		<th>性別</th>
		<c:choose>
			<c:when test="${employeeVO.emp_gender == 0}"> <td></td>  </c:when>
			<c:when test="${employeeVO.emp_gender == 1}"> <td>男</td> </c:when>
			<c:when test="${employeeVO.emp_gender == 2}"> <td>女</td> </c:when>
		</c:choose>
	</tr>
	<tr>
		<th>出生年月日</th>
		<td>${employeeVO.emp_birthday}</td>
	</tr>
	<tr>
		<th>身分證字號</th>
		<td>${employeeVO.emp_id}</td>
	</tr>
	<tr>
		<th>連絡電話</th>
		<td>${employeeVO.emp_phone}</td>
		<th>行動電話</th>
		<td>${employeeVO.emp_mobile}</td>
	</tr>
	<tr>
		<th>地址</th>
		<td>${employeeVO.emp_addr}</td>
	</tr>
	<tr>
		<th>電子信箱</th>
		<td>${employeeVO.emp_email}</td>
	</tr>
	<tr>
		<th>職位</th>
		<td>${employeeVO.emp_job}</td>
	</tr>
	<tr>
		<th>薪資</th>
		<td>${employeeVO.emp_sal}</td>
		<th>獎金</th>
		<td>${employeeVO.emp_bonus}</td>
	</tr>
	<tr>
		<th>銀行代碼</th>
		<td>${employeeVO.emp_bank}</td>
		<th>匯款帳號</th>
		<td>${employeeVO.emp_account}</td>
	</tr>
	<tr>
		<th>到職日</th>
<%-- 		<td><fmt:formatDate value="${employeeVO.hiredate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> 可更改時間顯示樣式 --%>
		<td>${employeeVO.emp_hiredate}</td>
		<th>離職日</th>
		<td>${employeeVO.emp_quitdate}</td>
	</tr>
</table>

</body>
</html>
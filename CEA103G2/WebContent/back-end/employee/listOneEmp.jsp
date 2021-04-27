<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
  EmployeeVO employeeVO = (EmployeeVO) request.getAttribute("employeeVO"); //EmpServlet.java(Concroller), �s�Jreq��empVO����
%>

<html>
<head>
<title>���u��� - listOneEmp.jsp</title>

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

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>���u��� - ListOneEmp.jsp</h3>
		 <h4><a href="/CEA103G2/back-end/employee/select_page.jsp"><img src="/CEA103G2/back-end/employee/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>�Y��</th>
		<td><img src="<%=request.getContextPath()%>/employee/PhotoReader.do?emp_no=${employeeVO.emp_no}"></td>
	</tr>
	<tr>
		<th>���u�s��</th>
		<td>${employeeVO.emp_no}</td>
	</tr>
	<tr>
		<th>���u�N��</th>
		<td>${employeeVO.emp_username}</td>
	</tr>
	<tr>
		<th>�m�W</th>
		<td>${employeeVO.emp_name}</td>
	</tr>
	<tr>
		<th>�ʧO</th>
		<c:choose>
			<c:when test="${employeeVO.emp_gender == 0}"> <td></td>  </c:when>
			<c:when test="${employeeVO.emp_gender == 1}"> <td>�k</td> </c:when>
			<c:when test="${employeeVO.emp_gender == 2}"> <td>�k</td> </c:when>
		</c:choose>
	</tr>
	<tr>
		<th>�X�ͦ~���</th>
		<td>${employeeVO.emp_birthday}</td>
	</tr>
	<tr>
		<th>�����Ҧr��</th>
		<td>${employeeVO.emp_id}</td>
	</tr>
	<tr>
		<th>�s���q��</th>
		<td>${employeeVO.emp_phone}</td>
		<th>��ʹq��</th>
		<td>${employeeVO.emp_mobile}</td>
	</tr>
	<tr>
		<th>�a�}</th>
		<td>${employeeVO.emp_addr}</td>
	</tr>
	<tr>
		<th>�q�l�H�c</th>
		<td>${employeeVO.emp_email}</td>
	</tr>
	<tr>
		<th>¾��</th>
		<td>${employeeVO.emp_job}</td>
	</tr>
	<tr>
		<th>�~��</th>
		<td>${employeeVO.emp_sal}</td>
		<th>����</th>
		<td>${employeeVO.emp_bonus}</td>
	</tr>
	<tr>
		<th>�Ȧ�N�X</th>
		<td>${employeeVO.emp_bank}</td>
		<th>�״ڱb��</th>
		<td>${employeeVO.emp_account}</td>
	</tr>
	<tr>
		<th>��¾��</th>
<%-- 		<td><fmt:formatDate value="${employeeVO.hiredate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> �i���ɶ���ܼ˦� --%>
		<td>${employeeVO.emp_hiredate}</td>
		<th>��¾��</th>
		<td>${employeeVO.emp_quitdate}</td>
	</tr>
</table>

</body>
</html>
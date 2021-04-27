<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Employee: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM Employee: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Employee: Home</p>

<h3>��Ƭd��:</h3>
	
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message.value}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href="<%=request.getContextPath()%>/back-end/employee/listAllEmp.jsp">List</a> all Emps.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/employee/employee.do" >
        <b>��J���u�s�� (�p7001):</b>
        <input type="text" name="emp_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="employeeSvc" scope="page" class="com.employee.model.EmployeeService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/employee/employee.do" >
       <b>��ܭ��u�s��:</b>
       <select size="1" name="emp_no">
         <c:forEach var="employeeVO" items="${employeeSvc.all}" > 
          <option value="${employeeVO.emp_no}">${employeeVO.emp_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/employee/employee.do" >
       <b>��ܭ��u�m�W:</b>
       <select size="1" name="emp_no">
         <c:forEach var="employeeVO" items="${employeeSvc.all}" > 
          <option value="${employeeVO.emp_no}">${employeeVO.emp_name}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
     </FORM>
  </li>
</ul>


<h3>���u�޲z</h3>

<ul>
  <li><a href="<%=request.getContextPath()%>/back-end/employee/addEmp.jsp">Add</a> a new Employee.</li>
</ul>

</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>

<%
  EmployeeVO employeeVO = (EmployeeVO) request.getAttribute("employeeVO");
%>
<%= employeeVO==null %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>���u��Ʒs�W - addEmp.jsp</title>

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
	width: 600px;
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
  .errorMsgs {
  	color: red;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>���u��Ʒs�W - addEmp.jsp</h3></td><td>
		 <h4><a href="/CEA103G2/back-end/employee/select_page.jsp"><img src="/CEA103G2/back-end/employee/images/tomcat.png" width="100" height="100" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��Ʒs�W:</h3>

<%-- ���~��C --%>
<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<font style="color:red">�Эץ��H�U���~:</font> -->
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 			<li style="color:red">${message.value}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>
<font style="color:red">${errorMsgs.Exception}</font>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/employee/employee.do" name="form1">
<table>
<!-- 	<tr> -->
<!-- 		<td>���u�m�W:</td> -->
<!-- 		<td><input type="TEXT" name="emp_name" size="45"  -->
<%-- 			 value="<%= (employeeVO==null)? "���F�n" : employeeVO.getEmp_name()%>" /></td> --%>
<!-- 	</tr> -->
	<tr>
		<td>���u�N��:</td>
		<td><input type="TEXT" name="emp_username" size="45"
			 value="<%= (employeeVO==null)? "" : employeeVO.getEmp_username()%>" /></td>
		<td class="errorMsgs emp_username">${errorMsgs.emp_username}</td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>�K�X:</td> -->
<!-- 		<td><input type="TEXT" name="emp_password" size="45" -->
<%-- 			 value="<%= (employeeVO==null)? "password123" : employeeVO.getEmp_password()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>�ʧO:</td> -->
<!-- 		<td><input type="TEXT" name="emp_gender" size="45" -->
<%-- 			 value="<%= (employeeVO==null)? "0" : employeeVO.getEmp_gender()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>�����Ҧr��:</td> -->
<!-- 		<td><input type="TEXT" name="emp_id" size="45" -->
<%-- 			 value="<%= (employeeVO==null)? "" : employeeVO.getEmp_id()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>��ʹq��:</td> -->
<!-- 		<td><input type="TEXT" name="emp_mobile" size="45" -->
<%-- 			 value="<%= (employeeVO==null)? "" : employeeVO.getEmp_mobile()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>�a�}:</td> -->
<!-- 		<td><input type="TEXT" name="emp_addr" size="45" -->
<%-- 			 value="<%= (employeeVO==null)? "" : employeeVO.getEmp_addr()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>��¾��:</td> -->
<!-- 		<td><input type="text" name="emp_quitdate" id="f_date2"></td> -->
<!-- 	</tr> -->
	<tr>
		<td>�q�l�H�c:</td>
		<td><input type="text" name="emp_email" size="45"
			 value="<%= (employeeVO==null)? "" : employeeVO.getEmp_email()%>" /></td>
		<td class="errorMsgs">${errorMsgs.emp_email}</td>
	</tr>
	<tr>
		<td>¾��:</td>
		<td>
<%-- 			<input type="text" name="emp_job" size="45" value="<%= (employeeVO==null)? "" : employeeVO.getEmp_job()%>" /> --%>
			<select name="emp_job">
				<option value="�@����u" ${(employeeVO.emp_job eq "�@����u") ? "selected" : ""}>�@����u</option>
				<option value="���x�޲z��" ${(employeeVO.emp_job eq "���x�޲z��") ? "selected" : ""}>���x�޲z��</option>
				<option value="�D��" ${(employeeVO.emp_job eq "�D��") ? "selected" : ""}>�D��</option>
			</select>
		</td>
		<td class="errorMsgs">${errorMsgs.emp_job}</td>
	</tr>
	<tr>
		<td>�~��:</td>
		<td><input type="text" name="emp_sal" size="45"
			 value="<%= (employeeVO==null)? "" : employeeVO.getEmp_sal()%>" /></td>
		<td class="errorMsgs">${errorMsgs.emp_sal}</td>
	</tr>
	<tr>
		<td>��¾��:</td>
		<td><input type="text" name="emp_hiredate" id="f_date1"></td>
		<td class="errorMsgs">${errorMsgs.emp_hiredate}</td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input id="sub" type="submit" value="�e�X�s�W" disabled></FORM>

<script type="text/javascript">
function getInfo(){ 
	  var xhr = new XMLHttpRequest();
	  
	  xhr.onload = function() {
	    if(xhr.status == 200){
	      document.getElementsByClassName("emp_username")[0].innerHTML = xhr.responseText;
	      if(xhr.responseText === "�i�ϥ�")
	    	  document.getElementById("sub").disabled = false;
	      else
	    	  document.getElementById("sub").disabled = true;
	    }else{
	      alert(xhr.status);
	    }
	  }

	  xhr.open("post", "<%=request.getContextPath()%>/employee/employee.do", true);
	  xhr.setRequestHeader("content-type", "application/x-www-form-urlencoded");
	  let input = document.getElementsByName("emp_username")[0].value;
	  let data_info = "action=checkEmp_username&emp_username=" + input;
	  xhr.send(data_info);

}

window.addEventListener("load",function (){
	document.getElementsByName("emp_username")[0].onblur=getInfo;
}, false);
</script>

</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

<% 
  java.sql.Date emp_hiredate = null;
  try {
	    emp_hiredate = employeeVO.getEmp_hiredate();
   } catch (Exception e) {
	    emp_hiredate = new java.sql.Date(System.currentTimeMillis());
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=emp_hiredate%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });


        // ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

        //      1.�H�U���Y�@�Ѥ��e������L�k���
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.�H�U���Y�@�Ѥ��᪺����L�k���
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.�H�U����Ӥ�����~������L�k��� (�]�i���ݭn������L���)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>
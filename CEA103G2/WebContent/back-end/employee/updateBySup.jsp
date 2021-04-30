<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>

<%
  EmployeeVO employeeVO = (EmployeeVO) request.getAttribute("employeeVO"); //EmpServlet.java (Concroller) �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>
<%= employeeVO==null %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>���u��ƭק� - updateBySup.jsp</title>

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
	width: 450px;
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
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>���u��ƭק� - updateBySup.jsp</h3>
		 <h4><a href="/CEA103G2/back-end/employee/select_page.jsp"><img src="/CEA103G2/back-end/employee/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
<%-- 		 <h4><a href="<%=request.getContextPath()%>/back-end/employee/select_page.jsp"><img src="/CEA103G2/back-end/employee/images/back1.gif" width="100" height="32" border="0">�^����</a></h4> --%>
	</td></tr>
</table>

<h3>��ƭק�:</h3>

<%-- ���~���C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<%-- <font style="color:red">${errorMsgs.Exception}</font> --%>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/employee/employee.do" name="form1">
<table>
	<tr>
		<td>���u�s��:<font color=red><b>*</b></font></td>
		<td><%=employeeVO.getEmp_no()%></td>
	</tr>
	<tr>
		<td>�H�c:</td>
		<td><input type="text" name="emp_email" size="45" value="<%= employeeVO.getEmp_email()%>" /></td>
		<td class="errorMsgs">${errorMsgs.emp_email}</td>
	</tr>
	<tr>
		<td>¾��:</td>
		<td>
<%-- 		<input type="text" name="emp_job" size="45" value="<%= employeeVO.getEmp_job()%>" /> --%>
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
		<td><input type="text" name="emp_sal" size="45" value="<%= employeeVO.getEmp_sal()%>" /></td>
		<td class="errorMsgs">${errorMsgs.emp_sal}</td>
	</tr>
	<tr>
		<td>����:</td>
		<td><input type="text" name="emp_bonus" size="45" value="<%= employeeVO.getEmp_bonus()%>" /></td>
		<td class="errorMsgs">${errorMsgs.emp_bonus}</td>
	</tr>
	<tr>
		<td>��¾��:</td>
		<td><input type="text" name="emp_hiredate" id="f_date1"></td>
		<td class="errorMsgs">${errorMsgs.emp_hiredate}</td>
	</tr>
	<tr>
		<td>��¾��:</td>
		<td><input type="text" name="emp_quitdate" id="f_date2"></td>
		<td class="errorMsgs">${errorMsgs.emp_quitdate}</td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="updateBySup">
<input type="hidden" name="emp_no" value="<%=employeeVO.getEmp_no()%>">
<input type="submit" value="�e�X�ק�"></FORM>
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

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
 		   value: '<%=employeeVO.getEmp_hiredate()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        $('#f_date2').datetimepicker({
            theme: '',              //theme: 'dark',
  	       timepicker:false,       //timepicker:true,
  	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
  	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
  		   value: '<%=employeeVO.getEmp_quitdate()%>', // value:   new Date(),
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
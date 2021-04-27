<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>

<%
  EmployeeVO employeeVO = (EmployeeVO) request.getAttribute("employeeVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>
<%= employeeVO==null %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>員工資料修改 - updateBySup.jsp</title>

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
		 <h3>員工資料修改 - updateBySup.jsp</h3>
		 <h4><a href="/CEA103G2/back-end/employee/select_page.jsp"><img src="/CEA103G2/back-end/employee/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
<%-- 		 <h4><a href="<%=request.getContextPath()%>/back-end/employee/select_page.jsp"><img src="/CEA103G2/back-end/employee/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4> --%>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
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
		<td>員工編號:<font color=red><b>*</b></font></td>
		<td><%=employeeVO.getEmp_no()%></td>
	</tr>
	<tr>
		<td>信箱:</td>
		<td><input type="text" name="emp_email" size="45" value="<%= employeeVO.getEmp_email()%>" /></td>
		<td class="errorMsgs">${errorMsgs.emp_email}</td>
	</tr>
	<tr>
		<td>職位:</td>
		<td>
<%-- 		<input type="text" name="emp_job" size="45" value="<%= employeeVO.getEmp_job()%>" /> --%>
			<select name="emp_job">
				<option value="一般員工" ${(employeeVO.emp_job eq "一般員工") ? "selected" : ""}>一般員工</option>
				<option value="平台管理員" ${(employeeVO.emp_job eq "平台管理員") ? "selected" : ""}>平台管理員</option>
				<option value="主管" ${(employeeVO.emp_job eq "主管") ? "selected" : ""}>主管</option>
			</select>
		</td>
		<td class="errorMsgs">${errorMsgs.emp_job}</td>
	</tr>
	<tr>
		<td>薪資:</td>
		<td><input type="text" name="emp_sal" size="45" value="<%= employeeVO.getEmp_sal()%>" /></td>
		<td class="errorMsgs">${errorMsgs.emp_sal}</td>
	</tr>
	<tr>
		<td>獎金:</td>
		<td><input type="text" name="emp_bonus" size="45" value="<%= employeeVO.getEmp_bonus()%>" /></td>
		<td class="errorMsgs">${errorMsgs.emp_bonus}</td>
	</tr>
	<tr>
		<td>到職日:</td>
		<td><input type="text" name="emp_hiredate" id="f_date1"></td>
		<td class="errorMsgs">${errorMsgs.emp_hiredate}</td>
	</tr>
	<tr>
		<td>離職日:</td>
		<td><input type="text" name="emp_quitdate" id="f_date2"></td>
		<td class="errorMsgs">${errorMsgs.emp_quitdate}</td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="updateBySup">
<input type="hidden" name="emp_no" value="<%=employeeVO.getEmp_no()%>">
<input type="submit" value="送出修改"></FORM>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

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
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: '<%=employeeVO.getEmp_hiredate()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        $('#f_date2').datetimepicker({
            theme: '',              //theme: 'dark',
  	       timepicker:false,       //timepicker:true,
  	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
  	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
  		   value: '<%=employeeVO.getEmp_quitdate()%>', // value:   new Date(),
            //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
            //startDate:	            '2017/07/10',  // 起始日
            //minDate:               '-1970-01-01', // 去除今日(不含)之前
            //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
         });
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
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

        
        //      2.以下為某一天之後的日期無法選擇
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


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
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
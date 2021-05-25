<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.bill.model.*"%>

<%
	BillVO billVO = (BillVO) request.getAttribute("billVO");  
	
%>

<jsp:useBean id="memTenSvc" class="com.memTen.model.MemTenService"/>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>每月房客帳單資料新增 - addBill.jsp</title>

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
		 <h3>每月房客帳單資料新增 - addBill.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/bill/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/bill/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/bill/bill.do" name="form1">
<table>
	<c:forEach var="map" items="${memTenSvc.findBill()}" >
	<tr>
		<td>會員編號:</td>
		<td>
			<select size="1" name="mem_no" onchange="func()">
<%-- 	         <c:forEach var="renConVO" items="${memTenSvc.findBillMem()}" >  --%>
	          <option value="${map.renConVO.mem_no}">${map.renConVO.mem_no}
<%-- 	         </c:forEach>    --%>
	       </select>
       </td>
	</tr>
	<tr>
		<td>物件編號:</td>
		<td>
			<select size="1" name="mem_no" class="house">
<%-- 			<c:forEach var="renConVO" items="${memTenSvc.findBillMem()}" > --%>
				<option value="${map.renConVO.hos_no}">${map.renConVO.hos_no}
<%-- 			</c:forEach> --%>
			</select>
		</td>
	</tr>
	</c:forEach>
	<tr>
		<td>帳單日期:</td>
		<td><input class="single-input" name="bill_date" id="bill_date" type="text" required></td>
	</tr>
	<tr>
		<td>繳費期限:</td>
		<td><input class="single-input" name="bill_due" id="bill_due" type="text" required></td>
	</tr>
	<tr>
		<td>本月用電量:</td>
		<td><input type="TEXT" name="bill_power" size="45"
			 value="${billVO.bill_power}" /></td>
	</tr>
	<tr>
		<td>本月用水量:</td>
		<td><input type="TEXT" name="bill_water" size="45"
			 value="${billVO.bill_water}" /></td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>房客繳費狀態:</td> -->
<!-- 		<td><input type="TEXT" name="bill_p_status" size="45" -->
<%-- 			 value="<%= (billVO==null)? "10000" : billVO.getBill_p_status()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>房東撥款狀態:</td> -->
<!-- 		<td><input type="TEXT" name="bill_r_status" size="45" -->
<%-- 			 value="<%= (billVO==null)? "10000" : billVO.getBill_r_status()%>" /></td> --%>
<!-- 	</tr> -->
	

<%-- 	<jsp:useBean id="deptSvc" scope="page" class="com.dept.model.DeptService" /> --%>
<!-- 	<tr> -->
<!-- 		<td>部門:<font color=red><b>*</b></font></td> -->
<!-- 		<td><select size="1" name="deptno"> -->
<%-- 			<c:forEach var="deptVO" items="${deptSvc.all}"> --%>
<%-- 				<option value="${deptVO.deptno}" ${(billVO.deptno==deptVO.deptno)? 'selected':'' } >${deptVO.dname} --%>
<%-- 			</c:forEach> --%>
<!-- 		</select></td> -->
<!-- 	</tr> -->

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Date bill_date = null;
  try {
	  bill_date = billVO.getBill_date();
   } catch (Exception e) {
	   bill_date = new java.sql.Date(System.currentTimeMillis());
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
        $('#bill_date').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '${bill_date}', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $('#bill_date').change(function(){
        	let date =$(this).val();
        	let youwantdelayhowmanyday = 14;
        	let valuedue = new Date(date).getTime()+(1000*60*60*24*youwantdelayhowmanyday);
        	$('#bill_due').datetimepicker({value:new Date(valuedue)});
        })
        
        $.datetimepicker.setLocale('zh');
        $('#bill_due').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '${bill_due}', // value:   new Date(),
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

<script>


</script>

</html>
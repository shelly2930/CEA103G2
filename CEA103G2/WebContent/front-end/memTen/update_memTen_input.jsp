<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memTen.model.*"%>

<%
	MemTenVO memTenVO = (MemTenVO) request.getAttribute("memTenVO"); //EmpServlet.java (Concroller) 存入req的memTenVO物件 (包括幫忙取出的memTenVO, 也包括輸入資料錯誤時的memTenVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<!-- Required source start -->
	<!-- jquery 這行有需要的人再加 -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<script src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.1/dist/tw-city-selector.min.js"></script>

<title>員工資料修改 - update_memTen_input.jsp</title>

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
  img.mem_pic {
  	height: 280px;
  	width: 200px;
  }
</style>

</head>
<body bgcolor='white'>

<!-- 地址連動選單 -->
<script>
	new TwCitySelector();	
</script>

<table id="table-1">
	<tr><td>
		 <h3>會員資料修改 - update_memTen_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="<%=request.getContextPath()%>/front-end/memTen/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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

<FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" name="form1">
<table>
	<tr>
		<td>會員編號:<font color=red><b>*</b></font></td>
		<td><%=memTenVO.getMem_no()%></td>
	</tr>
	<tr>
		<td>帳號:</td>
		<td><input type="TEXT" name="mem_username" size="45" value="<%=memTenVO.getMem_username()%>" /></td>
	</tr>
	<tr>
		<td>密碼:</td>
		<td><input type="TEXT" name="mem_password" size="45"	value="<%=memTenVO.getMem_password()%>" /></td>
	</tr>
	<tr>
		<td>照片:</td>
		<td><img src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?mem_no=${memTenVO.mem_no}" class="mem_pic">
		<input type="file" name="mem_pic" size="45" value="<%=memTenVO.getMem_pic()%>"></td>
	</tr>
	<tr>
		<td>姓名:</td>
		<td><input type="TEXT" name="mem_name" size="45"	value="<%=memTenVO.getMem_name()%>" /></td>
	</tr>
	<tr>
		<td>性別:</td>
		<td>
			<select size="1" name="mem_gender" >
           		<option value="0" <%=memTenVO.getMem_gender() == 0 ? "selected" : ""%>>男</option>
           		<option value="1" <%=memTenVO.getMem_gender() == 1 ? "selected" : ""%>>女</option>     
       		</select>
       	</td>
	</tr>
	<tr>
		<td>身分證字號:</td>
		<td><input type="TEXT" name="mem_id" size="45"	value="<%=memTenVO.getMem_id()%>" /></td>
	</tr>
	<tr>
		<td>出生年月日:</td>
		<td><input name="mem_birthday" id="birthday_date" type="text" ></td>
	</tr>
	<tr>
		<td>連絡電話:</td>
		<td><input type="TEXT" name="mem_phone" size="45"	value="<%=memTenVO.getMem_phone()%>" /></td>
	</tr>
	<tr>
		<td>行動電話:</td>
		<td><input type="TEXT" name="mem_mobile" size="45"	value="<%=memTenVO.getMem_mobile()%>" /></td>
	</tr>
	<tr>
		<td>電子信箱:</td>
		<td><input type="TEXT" name="mem_email" size="45"	value="<%=memTenVO.getMem_email()%>" /></td>
	</tr>
	<tr>
		<td>地址:</td>
		<td>
			<div role="tw-city-selector" data-has-zipcode data-hidden-zipcode data-county-value="${memTenVO.mem_city}"
     			data-district-value="${memTenVO.mem_dist}"></div>
			<input type="TEXT" name="mem_addr" size="45" value="${memTenVO.mem_addr}"/>
		</td>
	</tr>


</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="mem_no" value="<%=memTenVO.getMem_no()%>">
<input type="submit" value="送出修改"></FORM>

</body>

<!-- 地址選單返回值 -->
<script>
// 	$(window).load(function(){
// 		$("option[value='${county}']").prop("selected",true);
// 		$("select[name='district']").children().html("${dist}");
// // 		$("[name='addr']").val("${addr}");
// 	})
</script> 	



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
        $('#birthday_date').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: '<%=memTenVO.getMem_birthday()%>', // value:   new Date(),
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
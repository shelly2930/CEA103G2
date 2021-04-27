<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>員工資料修改 - updateByEmp.jsp</title>

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
  #preview {
  	width: 350px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>員工資料修改 - updateByEmp.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/employee/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/employee/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/employee/employee.do" name="form1" ENCTYPE="multipart/form-data">
<table>
	<tr>
		<td>頭像:</td>
		<td><input type="file" name="emp_pic" /></td>
	</tr>
	<tr class="container">
		<td></td>
		<td><img id="preview" src="<%=request.getContextPath()%>/employee/PhotoReader.do?emp_no=${employeeVO.emp_no}"/></td>
	</tr>
	<tr>
		<td>員工編號:<font color=red><b>*</b></font></td>
		<td>${employeeVO.emp_no}</td>
	</tr>
	<tr>
		<td>員工代號:<font color=red><b>*</b></font></td>
		<td>${employeeVO.emp_username}</td>
	</tr>
	<tr>
		<td>密碼:</td>
		<td><input type="text" name="emp_password" size="45" value="${employeeVO.emp_password}" /></td>
	</tr>
	<tr>
		<td>員工姓名:</td>
		<td><input type="text" name="emp_name" size="45" value="${employeeVO.emp_name}" /></td>
	</tr>
	<tr>
		<td>性別:</td>
<%-- 		<td><input type="text" name="emp_gender" size="45" value="${employeeVO.emp_gender}" /></td> --%>
		<td>
<!-- 			<select name="emp_gender"> -->
<%-- 			  <option value="0" ${(employeeVO.emp_gender == 0) ? "selected" : ""}></option> --%>
<%-- 			  <option value="1" ${(employeeVO.emp_gender == 1) ? "selected" : ""}>男</option> --%>
<%-- 			  <option value="2" ${(employeeVO.emp_gender == 2) ? "selected" : ""}>女</option> --%>
<!-- 			</select> -->
			<label><input type="radio" name="emp_gender" value="0" ${(employeeVO.emp_gender == 0) ? "checked" : ""}>未填</label>
			<label><input type="radio" name="emp_gender" value="1" ${(employeeVO.emp_gender == 1) ? "checked" : ""}>男</label>
			<label><input type="radio" name="emp_gender" value="2" ${(employeeVO.emp_gender == 2) ? "checked" : ""}>女</label>
		</td>
	</tr>
<%-- 			  <c:if test="${employeeVO.emp_gender == 0}">selected</c:if> --%>
	<tr>
		<td>出生年月日:</td>
		<td><input type="text" name="emp_birthday" id="f_date1" /></td>
	</tr>
	<tr>
		<td>身分證字號:</td>
		<td><input type="text" name="emp_id" size="45" value="${employeeVO.emp_id}" /></td>
	</tr>
	<tr>
		<td>連絡電話:</td>
		<td><input type="text" name="emp_phone" size="45" value="${employeeVO.emp_phone}" /></td>
	</tr>
	<tr>
		<td>行動電話:</td>
		<td><input type="text" name="emp_mobile" size="45" value="${employeeVO.emp_mobile}" /></td>
	</tr>
	<tr>
		<td>地址:</td>
		<td><input type="text" name="emp_addr" size="45" value="${employeeVO.emp_addr}" /></td>
	</tr>
	<tr>
		<td>電子信箱:</td>
		<td><input type="text" name="emp_email" size="45" value="${employeeVO.emp_email}" /></td>
	</tr>
	<tr>
		<td>銀行代碼:</td>
		<td><input type="text" name="emp_bank" size="45" value="${employeeVO.emp_bank}" /></td>
	</tr>
	<tr>
		<td>匯款帳號:</td>
		<td><input type="text" name="emp_account" size="45" value="${employeeVO.emp_account}" /></td>
	</tr>
	<tr>
		<td>到職日:<font color=red><b>*</b></font></td>
		<td>${employeeVO.emp_hiredate}</td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="updateByEmp">
<input type="hidden" name="emp_no" value="${employeeVO.emp_no}">
<input type="submit" value="送出修改">
</FORM>

<script type="text/javascript">
let emp_pic = document.getElementsByName("emp_pic")[0];
let preview = document.getElementById("preview");
emp_pic.addEventListener('change', function(e) {
    let files = e.target.files;
    if (files) {
        let file = files[0];
        if (file.type.indexOf('image') > -1) {
            let reader = new FileReader();
            reader.addEventListener('load', function(e) {
                let result = e.target.result;
                preview.src = result;
            });
            reader.readAsDataURL(file);
        } else {
            alert('請上傳圖片！');
        }
    }
});
</script>

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
 		   value: '${employeeVO.emp_birthday}', // value:   new Date(),
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
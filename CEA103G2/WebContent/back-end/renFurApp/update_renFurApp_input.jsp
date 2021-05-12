<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.renFurApp.model.*"%>
無法正常送出修改值(進不了controller)

<%
   RenFurAppVO renFurAppVO = (RenFurAppVO) request.getAttribute("renFurAppVO");
//    FurCatService furCatSvc=new FurCatService();
//    FurIteService furIteSvc=new FurIteService();
//    FurIteVO furIteVO=furIteSvc.getOneFurIte(renFurAppVO.fnt_it_no);
//    String fnt_ctgr_name=furCatSvc.getOneFurCat(furIteVO.fnt_ctgr_no).fnt_ctgr_name;
%>

<!-- 從套日期開始 -->
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>租家具申請單修改 -update_renFurApp_input.jsp</title>
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
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
	width: 700px;
	height:100px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
    text-align: left;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>租家具申請單資料修改 -update_renFurApp_input.jsp</h3></td><td><br>
		 <h4><a href="<%=request.getContextPath()%>/back-end/renFurApp/listAllRenFurApp.jsp">返回租家具申請單管理</a></h4>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do" name="form1">
<table>
	<tr>
		<th>申請單編號:</th>
		<td colspan="3">No.${renFurAppVO.rfa_no}</td>
	</tr>
	<tr>
  		<th>會員姓名:</th>
  		<jsp:useBean id="memTenSvc" scope="page" class="com.memTen.model.MemTenService" />
		<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_name}	</td>
		<th>性&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp別:</th>
		<td>
		<c:choose>
						<c:when test="${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_gender==0}"> 男 </c:when>
						<c:otherwise> 女</c:otherwise>
					</c:choose>
		</td>
	</tr>
	<tr>
		<th>連絡電話: </th>
		<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_phone}</td>
		<th>行動電話: </th>
		<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_mobile}</td>
	</tr>
	<tr>
		<th>電子信箱:</th>
		<td colspan="3">${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_email}</td>
	</tr>
	<tr>
		<th>物件地址:</th>
		 <jsp:useBean id="houseSvc" scope="page" class="com.house.model.HouseService" />
		 <jsp:useBean id="renFurAppSvc" scope="page" class="com.renFurApp.model.RenFurAppService" />
		 <jsp:useBean id="renConSvc" scope="page" class="com.renCon.model.RenConService" />
		 <td colspan="3">
<%-- 		${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_city} --%>
<%-- 				${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_dist}		 --%>
				${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_address}${
				houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_floor}樓		

		</td>
	</tr>
	<tr>
		<th>房&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp型:</th>
		<td>
		<c:choose>
							<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==1}">獨立套房</c:when>
							<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==2}">分租套房</c:when>
							<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==3}">雅房</c:when>
							<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==4}">整層住家</c:when>
							<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==5}">車位</c:when>
							<c:otherwise> 其他</c:otherwise>
						</c:choose>
		</td>
		<th>電梯與否:</th>
		<td>
		<c:choose>
				<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_ele==0}"> 否 </c:when>
				<c:otherwise> 是</c:otherwise>
		</c:choose>
		</td>
	</tr>
	<tr>
	<th>申請時間:</th>
	    <td><fmt:formatDate value="${renFurAppVO.rfa_apct_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
	<th>預約時間:</th>
	    <td><input name="rfa_order_date" id="f_date1" type="text"></td>
	</tr>
	<tr>
<!-- 	include內的編輯鈕 action2 非action 避免與下方送出修改鈕之action衝突 -->
		<td colspan="4">
		<%if (request.getAttribute("listDets_ByRenFurApp")!=null){%>
       <jsp:include page="listDets_ByRenFurApp_edit.jsp" />
<%} %>
		</td>
	</tr>
	<tr>
	    <th>申請進度:</th>
		<td><c:choose>
							<c:when test="${renFurAppVO.rfa_status==0}"> 未處理 </c:when>
							<c:when test="${renFurAppVO.rfa_status==1}"> 處理中</c:when>
							<c:otherwise> 已完成</c:otherwise>
						</c:choose>
				</td>
		<th>負責員工:</th>
		<jsp:useBean id="empSvc" scope="page" class="com.employee.model.EmployeeService" />
	<td><select size="1" name="emp_no"  id="empSelect">
				<option value="0">尚未指派</option>
			<c:forEach var="empVO" items="${empSvc.all}">
				<option value="${empVO.emp_no}" ${(renFurAppVO.emp_no==empVO.emp_no)? 'selected':'' } >${empVO.emp_name}
			</c:forEach>
		</select></td>
	</tr>	
	<tr>
		<th>租金合計:</th>
		<td>${renFurAppVO.rfa_total} 元</td>
		<th>租借狀態:</th>
		<td><c:choose>
				<c:when test="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0}"> 已退租 </c:when>
				<c:when test="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==1}"> 未租用 </c:when>
				<c:otherwise>租用中</c:otherwise>
			</c:choose>
		</td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action"  value="update">
<input type="submit" value="送出修改"  id="update">
<input type="hidden" name="rfa_no" value="<%=renFurAppVO.getRfa_no()%>">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllEmp.jsp-->

<script>
	$("input[type='submit']").click(function(e){
		if($("select").val()==0){
			alert("尚未指派負責員工 !!!");
		}
		e.preventDefault(); //阻止下個動作
	})
	
</script>
<!-- 在此引入明細內頁 -->
<%-- <%if (request.getAttribute("listDets_ByRenFurApp")!=null){%> --%>
<%--        <jsp:include page="listDets_ByRenFurApp_edit.jsp" /> --%>
<%-- <%} %> --%>

</FORM>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
Timestamp rfa_order_date = null;
try {
	rfa_order_date =renFurAppVO.getRfa_order_date();
 } catch (Exception e) {
	 e.getMessage();
 }


%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<!-- <style> -->
<!-- /*   .xdsoft_datetimepicker .xdsoft_datepicker { */ -->
<!-- /*            width:  300px;   /* width:  300px; */ */ -->
<!-- /*   } */ -->
<!-- /*   .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box { */ -->
<!-- /*            height: 151px;   /* height:  151px; */ */ -->
<!-- /*   } */ -->
<!-- </style> -->

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '${empty renFurAppVO ? '' :renFurAppVO.rfa_order_date}', 
// 		   // value:   new Date(),
//            //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
//            //startDate:	            '2017/07/10',  // 起始日
//            //minDate:               '-1970-01-01', // 去除今日(不含)之前
// //            maxDate:               '+1970-01-01'  // 去除今日(不含)之後
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
        //	           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
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
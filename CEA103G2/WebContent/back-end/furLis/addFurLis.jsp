<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furLis.model.*"%>


<%
   FurLisVO furLisVO = (FurLisVO) request.getAttribute("furLisVO");
   Integer fnt_ctgr_no=(Integer) request.getAttribute("fnt_ctgr_no");
%>

<!-- 從套日期開始 -->
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>家具資料新增 - addFurCat.jsp</title>

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
</style>



<!-- 處理下拉式選單連動取值 -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script type="text/javascript">

function getFurCat(e){ 
    $("#furIteSelect option:not(:first)").remove();
    var fnt_ctgr_no=(e.target.value);
    console.log(fnt_ctgr_no);
    if(fnt_ctgr_no !="" && fnt_ctgr_no !="家具類別"){
        $.ajax({
            url:"<%=request.getContextPath()%>/furIte/furIte.do",
            type:"POST",
            data:{
            	"action":"getFurIteSelect",
            	"fnt_ctgr_no":fnt_ctgr_no,
           },
            success: function(data){
            	 console.log(data);
               showFurItes(data);
                }
            });
    }else {
    	  $.ajax({
              url:"<%=request.getContextPath()%>/furIte/furIte.do",
              type:"POST",
              data:{
              	"action":"getFurIteSelect",
             },
              success: function(data){
              	 console.log(data);
                 showFurItes(data);
                  }
              });
    }
}

function showFurItes(data){
    var fnt_data=data.split(",");
    var txt="";

    if(fnt_data===""){
    	txt+="<option value=\"none\">此類別尚無家具品項</option>";
    
    }else{
    	for(i in fnt_data){
       	 var cut = fnt_data[i].indexOf('-');
        	 txt+="<option value="+fnt_data[i].slice(0,cut)+">"+fnt_data[i].slice(cut+1)+"</option>";
        }  
    }
    $("#furIteSelect").append(txt); 
}



window.addEventListener("load",function (){
 document.getElementById("furCatSelect").onchange=getFurCat;}, false);
</script>
</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>家具資料新增 - addFurIte.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">返回家具管理</a></h4>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furLis/furLis.do" name="form1">
<table>
	<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
	 <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />
	<tr>
	
<%--        <jsp:useBean id="furIteSvc2" scope="page" class="com.furIte.model.FurIteService" /> --%>
  		<th>家具類別名稱:</th>
		<td><select size="1" name="fnt_ctgr_no"  id="furCatSelect" style="width:90px; height:30px;">
	      <option>請選擇</option>
         <c:forEach var="furCatVO" items="${furCatSvc.all}" > 
        				<option value="${furCatVO.fnt_ctgr_no}" ${(fnt_ctgr_no==furCatVO.fnt_ctgr_no)? 'selected':'' } >${furCatVO.fnt_ctgr_name}
        				</option>
         </c:forEach>   
       </select>
			</td>
<!-- 		建立新增家具類別按鈕 -->
	</tr>

	<tr>
		<th>家具品項名稱:  <% %></th>
		<td>
	    <select size="1" name="fnt_it_no" id="furIteSelect"  style="width:170px; height:30px;">
	      <option >請選擇</option>
        	 <c:forEach var="furIteVO"  items="${furIteSvc.all}" > 
         		<c:if test="${fnt_ctgr_no==furIteVO.fnt_ctgr_no}">
         		 <option value="${furIteVO.fnt_it_no}"  ${(furLisVO.fnt_it_no==furIteVO.fnt_it_no)? 'selected':'' }>${furIteVO.fnt_name}</option>
         		</c:if>
         </c:forEach>   
       </select>
       </td>
	</tr>
	
	<tr>
		<th>購置日期:</th>
		<td><input name="fnt_acq_date" id="f_date1" type="text"></td>
	</tr>
	
	<tr>
		<th>家具狀態:</th><%=((furLisVO == null) ? "" : (furLisVO.getFnt_status().equals("0") ? "checked=true" : ""))%>
		<td>
		         <input type="radio" name="fnt_status" value="0"  ${(furLisVO.fnt_status==0)? 'checked':''}>正常
		         <input type="radio" name="fnt_status" value="1"  ${(furLisVO.fnt_status==1)? 'checked':''}>維修
		         <input type="radio" name="fnt_status" value="2"   ${(furLisVO.fnt_status==2)? 'checked':''}>報廢
		</td>
	</tr>
	
	
	
	
	
	<tr>
		<th>租借狀態:</th>
		<td>
		<input type="radio" name="fnt_rent_status" value="0"  ${(furLisVO.fnt_status==0)? 'checked':''}>未出租
		<input type="radio" name="fnt_rent_status" value="1"  ${(furLisVO.fnt_status==1)? 'checked':''}>出租中
		</td>
	</tr>
	<tr>
		<th>報廢日期:</th>
		<td><input name="fnt_unusable_date" id="f_date2" type="text"></td>
	</tr>
	
</table>

<br>
<input type="submit" value="送出新增"  id="insert">
<input type="hidden" name="action"  value="insert">
</FORM>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
Timestamp fnt_acq_date = null;
try {
	    fnt_acq_date =furLisVO.getFnt_acq_date();
 } catch (Exception e) {
	 e.getMessage();
 }

Timestamp fnt_unusable_date = null;
  try {
	    fnt_unusable_date =furLisVO.getFnt_unusable_date();	   
   } catch (Exception e) {
	   e.getMessage();
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
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value:  '${empty furLisVO ? '' :furLisVO.fnt_unusable_date}', 
		   // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
//            maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });

        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '${empty furLisVO ? '' :furLisVO.fnt_acq_date}', 
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
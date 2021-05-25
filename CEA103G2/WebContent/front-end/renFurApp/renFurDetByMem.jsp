<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.renFurApp.model.*"%>

<%
   RenFurAppVO renFurAppVO = (RenFurAppVO) request.getAttribute("renFurAppVO");
//    FurCatService furCatSvc=new FurCatService();
//    FurIteService furIteSvc=new FurIteService();
//    FurIteVO furIteVO=furIteSvc.getOneFurIte(renFurAppVO.fnt_it_no);
//    String fnt_ctgr_name=furCatSvc.getOneFurCat(furIteVO.fnt_ctgr_no).fnt_ctgr_name;
%>


<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<title>租家具申請單明細</title>

<style>
/* body {  */
/* background-color: #dddddd !important; */
/* } */

.genric-btn.info {
    color: #fff;
    background: #61d2b4 !important;
    border: 1px solid transparent;
    font-size: 16px;
    width: 80px;
    height: 40px;
    margin: 5px;

}

.genric-btn.radius {
    border-radius: 20px !important;
}

.genric-btn {
	line-height:2 !important;
}

.genric-btn.info:hover {
    color: #38a4ff;
    border: 1px solid #38a4ff;
    background: #fff !important;
}

</style>

</head>
<body>
<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>

<!--================ Content Area start =================-->
<section class="cat_product_area section_padding">
	<div class="container">
		<div class="row">
            <!--================ Sidebar =================-->    
			<%@include file="/front-end/sidebarFront.file"%>
                
            <div class="col-lg-10 content">
                
                <!--================ 不要的話自己刪掉 =================-->
                <div class="pagetitle">租家具申請單明細
                	<a href="<%=request.getContextPath()%>/front-end/renFurApp/listRenFurAppByMem.jsp" class="genric-btn info radius">返回</a>
                </div>
				
				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
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
	    <td><fmt:formatDate value="${renFurAppVO.rfa_order_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
		<th>租金合計:</th>
		
	<td>${renFurAppVO.rfa_total} 元</td>
	</tr>	
	
	
</table>
<!-- <br> -->
<!-- <input type="hidden" name="action"  value="update"> -->
<!-- <input type="submit" value="送出修改"  id="update"> -->
<%-- <input type="hidden" name="rfa_no" value="<%=renFurAppVO.getRfa_no()%>"> --%>
<%-- <input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用--> --%>
<%-- <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllEmp.jsp--> --%>

<script>
// 	$("input[type='submit']").click(function(e){
// 		if($("select").val()==0){
// 			alert("尚未指派負責員工 !!!");
// 		}
// 		e.preventDefault(); //阻止下個動作
// 	})
	
</script>
<!-- 在此引入明細內頁 -->
<%-- <%if (request.getAttribute("listDets_ByRenFurApp")!=null){%> --%>
<%--        <jsp:include page="listDets_ByRenFurApp_edit.jsp" /> --%>
<%-- <%} %> --%>

</FORM>
					


				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

</body>

<!-- Required source start -->
	<!-- jquery 這行有需要的人再加 -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->




<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

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



<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
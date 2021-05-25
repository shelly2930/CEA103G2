<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="com.renFurDet.model.*"%>
<%@ page import="java.util.*"%>

<!-- 在此收到renFurAPP controller的轉交內容  並引用印出-->
<jsp:useBean id="listDets_ByRenFurApp" scope="request" type="java.util.List<RenFurDetVO>" /> <!-- 於EL此行可省略 -->

<!-- Required source start -->
	<!-- jquery 這行有需要的人再加 -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<html>
<head><title>申請單明細</title>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }

.choosetime {
	font-weight:700;
	margin:30px;
	color:red;
}

</style>

</head>
<body bgcolor='white'>

<h4 style="color:black;text-align:left;">申請單明細: </h4>


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/MemRenFurAppServlet" >
<table>
	<tr>
		<th></th>
		<th>家具<br>序號</th>
		<th>家具名稱</th>
		<th>家具租金</th>
		<th>出租日期</th>
		<th>終止日期</th>
		<th>解租日期</th>
<!-- 		<th>編輯</th> -->
<!-- 		<th>刪除</th> -->
	</tr>
	<c:forEach var="renFurDetVO" items="${listDets_ByRenFurApp}">
  <jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" />
  <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />
  <jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" />
<%-- 						<c:forEach var="renFurDetVO" items="${renFurDetSvc.all}" > --%>
	<tr>
			<c:if test="${renFurAppVO.rfa_no==renFurDetVO.rfa_no}">
					
<%-- 	測試用 展開不顯示申請單編號		<td>${renFurDetVO.rfa_no}</td> --%>
			<td>
				<input type="checkbox" id="${renFurDetVO.fnt_id}input" name="no" value="${renFurDetVO.fnt_id}" ${renFurDetVO.rent_tmt_date!=null? 'disabled':''}>
			</td>						
			<td>${renFurDetVO.fnt_id}</td>
			<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_name}</td>
			 <td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price} 元</td>
			<td id="rentdate"><fmt:formatDate value="${renFurDetVO.rent_date}"	pattern="yyyy-MM-dd" /></td>
			<td><fmt:formatDate value="${renFurDetVO.rent_end_date}"	pattern="yyyy-MM-dd" /></td>
			<td><fmt:formatDate value="${renFurDetVO.rent_tmt_date}"	pattern="yyyy-MM-dd " /></td>
<!-- 			<td>  -->
<%-- 			         <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do" style="margin-bottom: 0px;"> --%>
<!-- 		             <input type="submit" value="編輯"> -->
<%-- 			         <input type="hidden" name="rfa_no"  value="${renFurDetVO.rfa_no}"> --%>
<%-- 			         <input type="hidden" name="fnt_id"  value="${renFurDetVO.fnt_id}"> --%>
<%-- 			         <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
<!--  			         <input type="hidden" name="action2" value="getOne_For_Update"></FORM>  -->
<!-- 		   </td>  -->
<!-- 		   <td>  -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do" style="margin-bottom: 0px;"> --%>
<!-- 		          <input type="submit" value="刪除"> -->
<%-- 			     <input type="hidden" name="rfa_no"  value="${renFurDetVO.rfa_no}"> --%>
<%-- 			      <input type="hidden" name="fnt_id"  value="${renFurDetVO.fnt_id}"> --%>
<%-- 			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
<!--  			     <input type="hidden" name="action2" value="delete"></FORM>  -->
<!-- 			</td> -->
		</c:if>
	</c:forEach>
</table>

<div class="choosetime">
請選擇收貨時間
	<input type="text" size="50" name="rent_tmt_date" id="rent_tmt_date" placeholder="選擇收貨時間" required style="border:red 1px solid;"/>
</div>

<input type="hidden" name="action"  value="renTerminate">
<input type="submit" class="terminate" value="退租">
<!-- <input type="button" class="show" value="退租"> -->




</FORM>
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
        var somedate1 = new Date();
        somedate1.setTime(somedate1.getTime()+24*60*60*2000);
        $('#rent_tmt_date').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
	       value: '${rent_tmt_date}',
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
            minDate:               somedate1, // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });

   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
//              var somedate1 = new Date();
//              somedate1.setTime(somedate1.getTime()+24*60*60*14000); 
//              $('#rtct_eff_date').datetimepicker({
//                  beforeShowDay: function(date) {
//                	  if (  date.getYear() <  somedate1.getYear() || 
//         		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
//         		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
//                      ) {
//                           return [false, ""]
//                      }
//                      return [true, ""];
//              }});

        
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
        


// 	$("#terminate").click(function(e){
// 		if($(":checkbox").val()==0){
// 			alert("尚未選擇要退租的家具");
// 		}
// 		e.preventDefault(); //阻止下個動作
// 	})


// 	if(!$('#rent_date').html()){ // 貨送到了才能退租
// 		alert("aaaa");
// 		return
// 	}

	$(".choosetime").hide();

	$(".terminate").prop("disabled",true);
	$("input[name='no']").change(function(){
		$(".terminate").prop("disabled",true);
		$("input[name='no']").each(function(){
			if($(this).prop("checked") == true){
				if($('#rentdate').html()){ // 貨送到了才能退租
					$(".choosetime").show();
					$(".terminate").prop("disabled",false);
				}else{
					$(".choosetime").hide();
					$(".terminate").prop("disabled",true);
				}
				
			}
		})
	})
	
	// 沒寫完的ajax
	$(".show").click(function(e){
		if($('#rent_tmt_date').val()){
			Swal.fire({
				  title: '您確定要退租嗎?',
				  text: "按下確定後將無法取消!",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#6495ed',
				  cancelButtonColor: '#fa8072',
				  confirmButtonText: '確定',
				  cancelButtonText: '我再想想'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
							url:'<%=request.getContextPath()%>/MemRenFurAppServlet',
							type: 'post',
							data:{
								action:'renTerminate',
								
							},
							async:false,
							success:function(){
								
							}
					})
				  }
			})
		}
		
		
	})
	
// 	$(".terminate").click(function(e){
// 		Swal.fire({
//   			title: '請先選擇收貨時間',
//   			html:
//     		// 無法用required驗證
//   			'<input type="text" id="rent_tmt_date" name="rent_tmt_date" class="swal2-input" placeholder="選擇收貨時間">',
//     		showCloseButton: true,
//     		showDenyButton: true,
//     		confirmButtonText: "確認",
//     		denyButtonText: "取消",
//     		onOpen: function() {
// //     			$.datetimepicker.setLocale('zh');
//     	        var somedate1 = new Date();
//     	        somedate1.setTime(somedate1.getTime()+24*60*60*2000);
//     	        $('#rent_tmt_date').datetimepicker({
//     		       theme: '',              //theme: 'dark',
//     		       timepicker:true,       //timepicker:true,
//     		       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
//     		       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
//     		       value: '${rent_tmt_date}',
//     	           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
//     	           //startDate:	            '2017/07/10',  // 起始日
//     	            minDate:               somedate1, // 去除今日(不含)之前
//     	           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
//     	        });
//     	    },
// 		}).then(function(result) {

// 		});
// 	})
	
// 	$('#button').click(() => {
//   swal({
//     title: 'Date picker',
//     html: '<input id="datepicker">',
//     showConfirmButton: false,
//     onOpen: function() {
//     	$('#datepicker').datetimepicker({});
//     },

//   }).then(function(result) {
//     swal({
//       type: 'success',
//       html: 'You entered: <strong>' + result + '</strong>'
//     });
//   });
// });
	
	
</script>

</html>
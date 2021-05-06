<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>選取預約時間</title>

</head>

<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- =================================下面是導覽列==================================================== --> 
<%@include file="/front-end/header.file"%>
<!-- =================================上面是導覽列==================================================== --> 
<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<style>
.table{
/* 	border:1px solid #000;  */
  font-family: 微軟正黑體; 
  font-size:16px; 
/*   width:200px; */
  border:1px solid #000;
/*   text-align:center; */
  border-collapse:collapse;
  
}
.table-borderless tbody+tbody, .table-borderless td, .table-borderless th, .table-borderless thead th {
    border:1px solid blue;
}
tr { 
  padding:10px;
  border:1px solid blue;
  color:#fff;
  
} 
th { 
  border:1px solid red;
  padding:5px;
  
} 
</style>
<body onload="connect();" onunload="disconnect();">
<!-- ======圖片 -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2> 預 約 看 房   Welcome</h2>
                            <h3> &nbsp;&nbsp;&nbsp; ${MemTenVO.mem_name} 你好 !</h3>
                            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H o m e <span>-</span> V i e w i n g</p>
                            <p>會員: ${MemTenVO.mem_no} <span>-</span>  選取你要預約的時間</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
<!-- ======員工控制 -->
 <section class="confirmation_part" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-4">
                	<label>現在起幾小時內不可預約
                    <input type="text" id="" style="display:inline-block;width:30%;">
                    </label>
                </div>
                <div class="col-lg-8">
                	<label><span>員工上班時段</span>:
                    <input type="number" name="gotowork" min='0' max='23' value="0" style="display:inline-block;width:20%;"><span>至</span>
                    <input type="number" name="gooffwork" min='0' max='23' value="23" style="display:inline-block;width:20%;">
                    
                    <script>
                    $("input[name='gotowork']").mouseup(function(e){
                    	$("input[name='gotowork']").attr('value',$(this).val());
                    })
                    $("input[name='gooffwork']").click(function(){
                    	$(this).attr('min',$("input[name='gotowork']").attr("value"));
                   	})
                    </script>
                    </label>
                </div>
            </div>
        </div>
    </section>
    
<!-- /****** CONTAINER *****/     -->
 	<section class="confirmation_part padding_top" style="padding-top:0px">
		<div class="container">
	            <div class="row">
					<div class="col-lg-12">
                        <div class="order_details_iner">
                            <h3>選取你要預約的日期</h3>
                            <table  class="table table-borderless">
                                <thead>
                               		 <tr class="table-primary">
                               		 	<th id="prev" class="text-center">&lt;&lt;</th>
                                        <th id="month" scope="col" colspan="5" class="text-center">月份</th>
                                        <th id="next" class="text-center">&gt;&gt;</th>
                                    </tr>
                                    <tr class="table-primary">
                                        <th class="text-center">星期日</th>
                                        <th class="text-center">星期一</th>
                                        <th class="text-center">星期二</th>
                                        <th class="text-center">星期三</th>
                                        <th class="text-center">星期四</th>
                                        <th class="text-center">星期五</th>
                                        <th class="text-center">星期六</th>
                                    </tr>
                                </thead>
                                <tbody>
                               		 <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th scope="col" colspan="7" class="text-center">Pick Date</th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
					</div>
				</div>
            </div>
    	</section>
<!-- /****** CONTAINER *****/     -->	


<!-- /****** CONTAINER *****/     -->


<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			 <div class="modal-header">
				 <div style="margin"><h5 class="modal-title " id="exampleModalLabel">選取要預約的時段</h5></div>
				   <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				      <span aria-hidden="true">&times;</span>
				   </button>
				</div>
					<div class="modal-body">
					 	<section class="confirmation_part padding_top" style="padding-top:0px">
							<div class="container">
					                        <div class="order_details_iner" style="margin-top:0px">
					                            <table  class="table table-borderless">
					                                <thead>
					                                    <tr class="table-primary">
					                                        <th class="text-center" id="showdate"><span>時段</span></th>
					                                        <th class="text-center"><span>預約</span></th>
					                                    </tr>
					                                </thead>
					                                <tbody id="picktime">
					                               		 <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                     <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                     <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                </tbody>
					                                <tfoot>
					                                    <tr>
					                                        <th scope="col" colspan="2" class="text-center">Pick Date</th>
					                                    </tr>
					                                </tfoot>
					                            </table>
					                        </div>
					            </div>
					    	</section>
		    	
				      </div>
				    </div>
				  </div>
				</div>
				<form action="<%=request.getContextPath()%>/rooVieApp/rooVieApp.do" method="post">
					<input type="text" name=rva_order_time value="">
					<input type="text" name="isPick" value="">
					<input type="text" name="mem_no" value="2">
					<input type="text" name="hos_no" value="2">
					<input type="submit">
				</form>
<!-- /****** CONTAINER *****/     -->	                       
		<script>
//日曆生成
			$(function(){
				let choose = new Date();
// 				今年
				let currentYear = choose.getFullYear();
// 				這個月
				let currentMonth = choose.getMonth()+1;
// 				今日
				let currentDate = choose.getDate();
// 				這個月第一天
				let currentMonthFirstDay = new Date(""+currentYear+"-"+currentMonth+"-1").getDay();//0對應到星期日 其餘1對禮拜一
// 				今年這個月有幾天
				let currentTotalDay = judgeDay(currentYear,currentMonth);
// 				count用途
				let week = 0;
				$("#prev").click(function(){
					freshPickDateTB();
					if(currentMonth==1){
						currentYear--;
						currentMonth=13;
					}
					currentMonth--;
					let d = ""+currentYear+"-"+currentMonth+"-1";
					currentMonthFirstDay = new Date(d).getDay();
					currentTotalDay = judgeDay(currentYear,currentMonth);
					
					$("#month").html("<span>"+currentYear+"年"+currentMonth+"月</span>")
					for(let i = 1;i<=currentTotalDay;i++){
						let pickdate = currentYear+"-"+currentMonth+"-"+i;
						let compare = currentYear+"-"+currentMonth+"-"+(i+1);
						if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
							$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
						}
						$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
						$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
						currentMonthFirstDay = currentMonthFirstDay+1;
					}
				})
				$("#next").click(function(){
					freshPickDateTB();
					
					if(currentMonth==12){
						currentYear++;
						currentMonth=0;
					}
					
					currentMonth++;
					currentMonthFirstDay = new Date(""+currentYear+"-"+currentMonth+"-1").getDay();
					currentTotalDay = judgeDay(currentYear,currentMonth);
					
					$("#month").html("<span>"+currentYear+"年"+currentMonth+"月</span>")
					for(let i = 1;i<=currentTotalDay;i++){
						let pickdate = currentYear+"-"+currentMonth+"-"+i;
						let compare = currentYear+"-"+currentMonth+"-"+(i+1);
						if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
							$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
						}
						$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
						$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
						currentMonthFirstDay = currentMonthFirstDay+1;
					}
				})
				//初始
				$("#month").html("<span>"+currentYear+"年"+currentMonth+"月</span>")
				for(let i = 1;i<=currentTotalDay;i++){
					let pickdate = currentYear+"-"+currentMonth+"-"+i;
					let compare = currentYear+"-"+currentMonth+"-"+(i+1);
					$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
					if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
						$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
					}
					$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
					currentMonthFirstDay = currentMonthFirstDay+1;
				}
			})
// 			刷新日曆
			function freshPickDateTB(){
				$("button[name='pickdate']").each(function(){
						$(this).css('display','none');
						$(this).prop('disabled',false);
						$(this).attr("id","").children().remove();
				})
			}
			//判斷幾天 包含閏年天數
			function judgeDay(year,month){
				let maybe =["28","29","30","31","32"];
				let recordMonth = month;
				for(let i=0;i<maybe.length;i++){
					let judgemonth = new Date(year+"-"+month+"-"+maybe[i]);
					if((judgemonth.getMonth()+1)!=month || "Invalid Date"==judgemonth){
						return maybe[i-1];
					}
				}
			} 
//時段選擇生成
			let prevTime = 0;
			let interval = 1;
//設定距離 現在多少小時才可以預約
			let freeTimeToSee = 10;
			let currentHours = new Date().getHours();
			//用於包裹，判斷不能選的時段
			let unchoosetime = 0;
			let isUpdate = false;
			function spanTimetitle(prevTime,interval,pickdate){
				$("span[name='timeTitle']").each(function(index){
					let nextTime = prevTime+interval;
					$(this).text(prevTime+":00-"+nextTime+":00");
					let rva_order_time =pickdate+" "+prevTime+":00:00";
					//以下設定現在(freeTimeToSee)之內的時段 不可預約
					let comparePickTime =pickdate+" "+index+":00:00";
					let nowHour = new Date().getHours()+freeTimeToSee+1;
					let nowDate = new Date().getDate();
					let nowMonth = (new Date().getMonth()+1); 
					let nowYear = new Date().getFullYear();
					let nowTotalDay = judgeDay(nowYear,nowMonth);
					if(nowHour>=24){
						nowDate++;
						nowHour-=24;
					}
					if(nowDate>nowTotalDay){
						nowMonth++;
						nowDate-=nowTotalDay;
					}
					if(nowMonth>=12){
						nowDate++;
						nowMonth-=12;
					}
					let compareNowTime = nowYear+"-"+nowMonth+"-"+nowDate+" "+nowHour+":00:00";
					if(index==1){
						isUpdate = false;
					}
					
					if(Date.parse(comparePickTime).valueOf() < Date.parse(compareNowTime).valueOf()){
						$("input[name='picktime']").eq(index).prop("disabled",true);
						unchoosetime = index;
						console.log($("input[name='picktime']").eq(index).prop("checked"));
						isUpdate =true;
					}
					$("input[name='picktime']").eq(index).next().remove();
					$("input[name='picktime']").eq(index).attr('value',rva_order_time);
					$("input[name='picktime']").eq(index).attr('id',prevTime).after("<span id='"+pickdate+"'>"+prevTime+"</span>")
					prevTime+=interval;
				})
			}
//以下websocket
			let member = ${MemTenVO.mem_no}
			let MyPoint = "/pickTime/"+member;//給WS.java接收用
			let host = window.location.host;
			let path = window.location.pathname;
			let webCtx = path.substring(0, path.indexOf('/', 1));
			let endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
			let self = member;
			let webSocket;
			let countChecked = 0 ; //計算已預約時段
			let fullCheck = 24; //設定 24的時段 滿時段，跳出通知
			function connect() {
				// create a websocket
				webSocket = new WebSocket(endPointURL);
				
				webSocket.onopen = function(event) {
					console.log("Connect Success!");
					$("#member").after("<p>"+member+"</p>");//連線成功 登入名稱
					addListener();
				};
				
				webSocket.onmessage = function(event) {
//		 			四種狀態type 登入、歷史資訊、聊天時、關閉時候
//		 			登入要更新好友列表
//		 			歷史資訊拿出舊資料
//		 			Object 存放message
					var jsonObj = JSON.parse(event.data);
					let currentClick = null;
					
					if ("open" === jsonObj.type) {//有兩種包裹
//		 				一有新連線，就更新歷史資料
						addListener();
					} else if ("history" === jsonObj.type && (self !== jsonObj.sender)) {
						// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
						var messages = JSON.parse(jsonObj.message);
						
						for (var i = 0; i < messages.length; i++) {
							let jsonObject = JSON.parse(messages[i]);
							let time = jsonObject.time;//取出被選的時間了
							let timepick = jsonObject.timepick;
							let date = jsonObject.date;//取出被選的了
							let datepick = jsonObject.datepick;
							if(isUpdate==true && time<=unchoosetime){
								continue;
							}
							
							//先篩選日期  
							if(self !== jsonObject.sender && timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
								$("input[name='picktime']").each(function(){
									if($(this).attr("id")===time){
										$(this).prop("checked",true);
										$(this).next().text("會員"+jsonObject.sender+" 已預約");
										countChecked++;
										$(this).prop("disabled",true);
									}
								})
							}else if(self !== jsonObject.sender && timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
								$("input[name='picktime']").each(function(){
									if($(this).attr("id")===time){
										$(this).prop("checked",false);
										countChecked--;
										$(this).next().text("");
										$(this).prop("disabled",false);
									}
								})
							}else if(self === jsonObject.sender && timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
								$("input[name='picktime']").each(function(){
									if($(this).attr("id")===time){
										$(this).prop("checked",true);
										$(this).next().text("會員"+jsonObject.sender+" 已預約");
										countChecked++;
									}
								})
							}else if(self === jsonObject.sender && timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
								$("input[name='picktime']").each(function(){
									if($(this).attr("id")===time){
										$(this).prop("checked",false);
										countChecked--;
										$(this).next().text("");
									}
								})
							}
						}
					}else if("chat" === jsonObj.type && self === jsonObj.sender) {//必為存被選時間的包裹
						let time = jsonObj.time;//取出被選的時間了
						let timepick = jsonObj.timepick;
						let date = jsonObj.date;//取出被選的時間了
						let datepick = jsonObj.datepick;
						//先篩選日期  
						if(timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
							$("input[name='picktime']").each(function(){
								if($(this).attr("id")===time){
									$(this).prop("checked",true);
									$(this).next().text("會員"+jsonObj.sender+" 已預約");
									countChecked++;
								}
							})
						}else if(timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
							$("input[name='picktime']").each(function(){
								if($(this).attr("id")===time){
									$(this).prop("checked",false);
									$(this).next().text("");
									countChecked--;
								}
							})
						}
					}else if ("chat" === jsonObj.type && self !== jsonObj.sender) {//必為存被選時間的包裹
						// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
						let time = jsonObj.time;//取出被選的時間了
						let timepick = jsonObj.timepick;
						let date = jsonObj.date;//取出被選的時間了
						let datepick = jsonObj.datepick;
						//先篩選日期  
						if(timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
							$("input[name='picktime']").each(function(){
								if($(this).attr("id")===time){
									$(this).prop("checked",true);
									$(this).next().text("會員"+jsonObj.sender+" 已預約");
									$(this).prop("disabled",true);
								}
							})
						}else if(timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
							$("input[name='picktime']").each(function(){
								if($(this).attr("id")===time){
									$(this).prop("checked",false);
									$(this).prop("disabled",false);
									$(this).next().text("");
								}
							})
						}
					}else if ("close" === jsonObj.type) {
						alert("BYE");
					}
					console.log("countChecked"+countChecked);
					if(countChecked==fullCheck){
						alert("該天預約滿囉");
					}
				};
				
				webSocket.onclose = function(event) {
					console.log("Disconnected!");
				};
			}
			//按下要選的時間 送出包裹
			$("input[name='picktime']").change(function(){
					let time =  $(this).attr("id");
					let timepick = null;
					let date = "";
					if($(this).next().attr('id')!='undefined'){
						date=$(this).next().attr('id');
					}
					if($(this).prop("checked")==true){
						timepick = "1";
					}else{
						timepick = "0";
					}
					var jsonObj = {
							"type" : "chat",
							"sender" : self,
							"identity" : "1",
							"date" :date,
							"datepick" :"",
							"time" :time,
							"timepick" :timepick,
						};
					webSocket.send(JSON.stringify(jsonObj));
			})
			
//		 	我要拿到歷史資料阿
			// 註冊列表點擊事件並抓取好友名字以取得歷史訊息
			function addListener() {
					let jsonObj = {
							"type" : "history",
							"sender" : "",
							"identity" : "1",
							"message" : "",
						};
					webSocket.send(JSON.stringify(jsonObj));
			}
			function disconnect() {
				webSocket.close();
			}
			
			$("button[name='pickdate']").click(function(){
				$()
				
				$("#showdate").html("<span>"+$(this).attr('id')+" 的時段 </span>")
				$("#exampleModalLabel").html("訂單需處理，請預約 \"現在起 "+freeTimeToSee+"小時 \"之後的時段");
				$("input[name='picktime']").each(function(){
					$(this).prop('checked',false);
					$(this).prop('disabled',false);
				})
				spanTimetitle(prevTime,interval,$(this).attr('id'));
				alert(isUpdate);
				
				addListener();
				countChecked=0;
				$("#Modal").modal('show');
			})
			$(window).load(function(){
				//預約 時段 成功
				$("input[name='picktime']").change(function(){
					$("input[name='rva_order_time']").val($("input[name='picktime']").attr("value"));
					$("input[name='isPick']").val($("input[name='picktime']").prop("checked"));
// 					$("input[type='submit']").click();
				})
			})
			
		</script>
</body>
<%@include file="/front-end/footer.file"%>
</html>
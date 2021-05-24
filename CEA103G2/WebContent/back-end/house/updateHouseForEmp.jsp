<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>後台空頁</title>

   <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
	 <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
	<script src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <%@include file="/back-end/includeFile/sidebarBack.file"%>

         <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

				<!-- Topbar -->
                <%@include file="/back-end/includeFile/topbarBack.file"%>

                <!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
                <div class="container-fluid">
					<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/house/house.do"
							enctype="multipart/form-data" name="form1">
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">房東姓名</span>
					  			</div>
					  			<span class='form-control' style='background-color:#D6D6FF'id='lldname'> </span>
							</div>
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text" >房東聯絡方式</span>
					  			</div>
					  			<span class='form-control' style='background-color:#D6D6FF' id='lldphone'> </span>
							</div>
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">申請代管時間</span>
					  			</div>
					  			<span class='form-control' style='background-color:#D6D6FF' id='apptime'> </span>
							</div>
							
							
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">物件名稱</span>
					  			</div>
					  				<input type="text" name="hos_name" 
					  					value="${(houseVO == null)?'高級住宅':houseVO.hos_name}" 
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>
							
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">物件租金</span>
					  			</div>
					  				<input type="text" name="hos_rent" 
					  					value="${(houseVO == null) ?'9500': houseVO.hos_rent}" 
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>
							
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">縣市鄉鎮</span>
					  			</div>
					  			<div id="twzipcode"></div>
							</div>
							
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">地址</span>
					  			</div>
					  				<input type="text" name="hos_address" 
					  					value="${(houseVO == null) ? '桃園市中壢區復興路46號' : houseVO.hos_address}" 
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>
					
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">房型</span>
					  			</div>
					  				<select class="form-control"  size="1" name="hos_type">
											<option value="0" ${(houseVO.hos_type=="0")? 'selected':''}>不限
											<option value="1" ${(houseVO.hos_type=="1")? 'selected':''}>獨立套房
											<option value="2" ${(houseVO.hos_type=="2")? 'selected':''}>分租套房
											<option value="3" ${(houseVO.hos_type=="3")? 'selected':''}>雅房
											<option value="4" ${(houseVO.hos_type=="4")? 'selected':''}>整層住家
											<option value="5" ${(houseVO.hos_type=="5")? 'selected':''}>車位
											<option value="6" ${(houseVO.hos_type=="6")? 'selected':''}>其他
									</select>
							</div>
									
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">介紹</span>
					  			</div>
					  				<input type="textarea" name="hos_info" 
					  					value="${(houseVO == null) ? '寧靜、高CP、你的絕佳選擇' : houseVO.hos_info}" 
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>			
								
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">屋齡</span>
					  			</div>
					  				<input type="text" name="hos_age" 
					  					value="${(houseVO == null) ? '25' : houseVO.hos_age}" 
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>
								
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">樓層齡</span>
					  			</div>
					  				<input type="text" name="hos_floor" 
					  					value="${(houseVO == null) ? '7' : houseVO.hos_floor}" 
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>
					
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">提供服務</span>
					  			</div>
					  			<div class="form-control" >
					  				<input type="checkbox" id="hos_ele" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_ele == "1")?'checked':''} />
									<label for="hos_ele">電梯</label>
									<input type="checkbox" id="hos_parking" name="hos_check" value="hos_parking" size="45" ${(houseVO.hos_parking == "1")?'checked':''} />
									<label for="hos_parking">停車位</label>
									<input type="checkbox" id="hos_pet" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_pet == "1")?'checked':''} /> 
									<label for="hos_pet">可養寵物</label>
									<input type="checkbox" id="hos_cook" name="hos_check" value="hos_cook" size="45" ${(houseVO.hos_cook == "1")?'checked':''} />
									<label for="hos_cook">可開伙</label>
					  			</div>
							</div>
					
								
						
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">坪數</span>
					  			</div>
					  				<input type="text" name="hos_squares" 
					  					value="${(houseVO == null) ? '9' : houseVO.hos_squares}" 
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>	
							
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">性別</span>
					  			</div>
					  				<select class="form-control"  size="1" name="hos_gender">
											<option value="0" ${(houseVO.hos_gender=="0")? 'selected':''}>不拘
											<option value="1" ${(houseVO.hos_gender=="1")? 'selected':''}>男
											<option value="2" ${(houseVO.hos_gender=="2")? 'selected':''}>女
									</select>
							</div>
										
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">水費/一度</span>
					  			</div>
					  				<input type="text" name="hos_water" 
					  					value="${(houseVO == null) ? '9' : houseVO.hos_water}" 
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>	
							
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">電費/一度</span>
					  			</div>
					  				<input type="text" name="hos_power" 
					  					value="${(houseVO == null) ? '2' : houseVO.hos_power}" 
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>	
						
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">網路費</span>
					  			</div>
					  				<input type="text" name="hos_internet" 
					  					value="${(houseVO == null) ? '600' : houseVO.hos_internet}" 
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>	
							
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">上傳所有權狀</span>
					  			</div>
					  				
					  				<input type="file" name="hos_loc_pic" 
					  					id="load"  
					  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							</div>
							
							<br> 
							<input type="hidden" name="houseno" value="${houseVO.hos_no}">
							<input type="hidden" name="action" value="updateHouseForEmp">
							<input type="hidden" name="requestURL"	value="${param.requestURL}">
							<input class='btn btn-outline-success btn-sm' type="submit" value="更改物件資料">
						</FORM>
						
					<!-- Button trigger modal -->
					<!-- 	================= -->
					
					<!-- 參考網站 https://www.wfublog.com/2017/10/taiwan-county-town-zip-address-twzipcode-jquery.html -->
						
					<!-- ====以上新增物件資料送出=== -->
 			</div>
            <!-- End of Main Content -->
	
            <!-- Footer -->
            <%@include file="/back-end/includeFile/footerBack.file"%>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <%@include file="/back-end/includeFile/otherBack.file" %>
    
<!--     Bootstrap core JavaScript -->
   
    

<!--     Core plugin JavaScript -->


<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->
<!-- =====================下面為input時間外掛============================= -->
<!-- ########    而且注意不能Ctrl+shift+F自動排版 會發生錯誤!!!!!     ########### -->
					<script>
						let lld_no = ${houseVO.lld_no};
						let num = getMem(getlld(lld_no).mem_no).mem_name;
						$("#lldname").text(getMem(getlld(lld_no).mem_no).mem_name);
						$("#lldphone").text(getMem(getlld(lld_no).mem_no).mem_mobile);
						let apptime = '${houseVO.hos_apptime}';
						$("#apptime").text(dateformat(apptime));
						function getlld(lld_no){
							let lldvo={}
							$.ajax({
								url:"<%=request.getContextPath()%>/HouseJsonServlet",
								type:'post',
								data:{
									action:'getLanlord',
									'lld_no':lld_no,
								},
								async:false,
								success:function(data){
									for(let key in data){
										lldvo[key]=data[key];
									}
								}
							})
							return lldvo;
						}

						function getMem(mem_no){
							let mem = {};
							$.ajax({
								url:'<%=request.getContextPath()%>/RenConCRUDServlet',
								type: 'post',
								data:{
									action:'getOneMemten',
									mem_no:mem_no,
								},
								async:false,
								success:function(memvo){
									for(let key in memvo){
										mem[key]=memvo[key];
									}
									console.log(memvo)
								}
							})
							return mem;
						}
						function dateformat(str){
							 let year = new Date(str).getFullYear();
							 let month = new Date(str).getMonth()+1;
							 let date = new Date(str).getDate();
							 let hour = new Date(str).getHours();
							 let isAm = "上午";
							 if((Math.floor(hour/12)==1)){
								 isAm = "下午";
							 }
							 let minutes = new Date(str).getMinutes();
							 let second = new Date(str).getSeconds();
							 return year+"年"+month+"月"+date+"日" +" "+isAm+hour+"時"
					 	}
						$("#twzipcode").twzipcode({
					        countySel: '${houseVO.hos_city}', // 城市預設值, 字串一定要用繁體的 "臺", 否則抓不到資料
					        districtSel: '${houseVO.hos_dist}', // 地區預設值
					        zipcodeIntoDistrict: true, // 郵遞區號自動顯示在地區
					        css: ["city form-control", "town form-control"], // 自訂 "城市"、"地區" class 名稱
					        countyName: "hos_city", // 自訂城市 select 標籤的 name 值
					        districtName: "hos_dist" // 自訂地區 select 標籤的 name 值
					    });
						$("#twzipcode").change(function(){
							let Str = $("select[name='hos_city']").val()+$("select[name='hos_dist']").val();
							$("input[name='hos_address']").val(Str);
							$("input[name='hos_address']").text(Str);
						})
						</script>	
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '', // value:   new Date(),
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
</body>

</html>

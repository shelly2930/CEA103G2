<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.house.model.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%
	HouseVO houseVO = (HouseVO) request.getAttribute("houseVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>房東新增物件頁面</title>


<!-- =================套用台灣縣市鄉鎮要使用以下=========================== -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<!-- 先引用jquery(老師已經含有jquery)再引用twzipcode -->
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<!-- =================套用台灣縣市鄉鎮要使用以上=========================== -->

</head>


<!-- =================================下面是導覽列==================================================== --> 
<%@include file="/front-end/header.jsp"%>
<!-- =================================上面是導覽列==================================================== --> 


<!--================Home Banner Area =================-->
  <!-- breadcrumb start-->
  <section class="breadcrumb breadcrumb_bg">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="breadcrumb_iner">
            <div class="breadcrumb_iner_item">
              <h2>房東申請代管</h2>
              <p>HowTrue <span>-</span> 好 厝</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- breadcrumb start-->

  <!--================Checkout Area =================-->
  <section class="checkout_area padding_top">
    <div class="container">
      <div class="returning_customer">
        <div class="check_title">
        <h1>服務代管-申請表</h1>
          <h2>
            	 請填寫欲托管物件內容!
          </h2>
        </div>
        <p>
          	我們將在最短時間內為您服務
        </p>
      </div>
      <div class="billing_details">
        <div class="row">
          <div class="col-lg-8">
            <h3>物件 詳細資料
             <c:if test="${not empty errorMsgs}">
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<p style="color: red"> ${message}</p>
				</c:forEach>
			</ul>
			</c:if> 
            </h3>
            <form class="row contact_form" action="<%=request.getContextPath()%>/house/house.do" method="post" novalidate="novalidate" enctype="multipart/form-data" name="form1">
              <div class="col-md-6 check_title"><h2>房東編號</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="lld_no" value="<%=(houseVO == null) ? "5" : houseVO.getLld_no()%>"/>
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>物件名稱</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_name" 
                value="<%=(houseVO == null) ? "高級住宅" : houseVO.getHos_name()%>"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>物件租金</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control"  name="hos_rent" 
                value="<%=(houseVO == null) ? "9500" : houseVO.getHos_rent()%>"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>縣市鄉鎮</h2></div>
              <div class="col-md-6 form-group">
              <div id="twzipcode"></div>
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title"><h2>物件地址</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_address" 
                value="<%=(houseVO == null) ? "桃園市中壢區復興路46號" : houseVO.getHos_address()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>物件類型</h2></div>
			  <div class="col-md-12 form-group">
              	<select name="hos_type">
                  <option value="0" ${(houseVO.hos_type=="0")? 'selected':''}>不限
						<option value="1" ${(houseVO.hos_type=="1")? 'selected':''}>獨立套房
						<option value="2" ${(houseVO.hos_type=="2")? 'selected':''}>分租套房
						<option value="3" ${(houseVO.hos_type=="3")? 'selected':''}>雅房
						<option value="4" ${(houseVO.hos_type=="4")? 'selected':''}>整層住家
						<option value="5" ${(houseVO.hos_type=="5")? 'selected':''}>車位
						<option value="6" ${(houseVO.hos_type=="6")? 'selected':''}>其他
                </select>
               </div>
              
              
              <div class="col-md-6 check_title"><h2>物件介紹</h2></div>
              <div class="col-md-6 form-group">
                <input type="textarea" class="form-control" name="hos_info"
                value="<%=(houseVO == null) ? "寧靜、高CP、你的絕佳選擇" : houseVO.getHos_info()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              
               <div class="col-md-6 check_title"><h2>物件屋齡</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_age" 
                value="<%=(houseVO == null) ? "25" : houseVO.getHos_age()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title"><h2>所在樓層</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_floor" 
                value="<%=(houseVO == null) ? "7" : houseVO.getHos_floor()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              
              <div class="col-md-6 check_title"><h2>提供服務</h2></div>
              <div class="col-md-6 form-group">
                <input type="checkbox" id="hos_ele" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_ele == "1")?'checked':''} />
					<label for="hos_ele">電梯</label>
					<input type="checkbox" id="hos_parking" name="hos_check" value="hos_parking" size="45" ${(houseVO.hos_parking == "1")?'checked':''} />
					<label for="hos_parking">停車位</label>
					<input type="checkbox" id="hos_pet" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_pet == "1")?'checked':''} /> 
					<label for="hos_pet">可養寵物</label>
					<input type="checkbox" id="hos_cook" name="hos_check" value="hos_cook" size="45" ${(houseVO.hos_cook == "1")?'checked':''} />
					<label for="hos_cook">可開伙</label>
              </div>
              
              <div class="col-md-6 check_title"><h2>物件坪數</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_floor" 
                value="<%=(houseVO == null) ? "7" : houseVO.getHos_floor()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title"><h2>所在樓層</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_squares" 
  					value="<%=(houseVO == null) ? "9" : houseVO.getHos_squares()%>" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title"><h2>限制性別</h2></div>
              <div class="col-md-6 form-group">
                <select size="1" name="hos_gender">
						<option value="0" ${(houseVO.hos_gender=="0")? 'selected':''}>不拘
						<option value="1" ${(houseVO.hos_gender=="1")? 'selected':''}>男
						<option value="2" ${(houseVO.hos_gender=="2")? 'selected':''}>女
				</select>
              </div>
              
              <div class="col-md-6 check_title"><h2>水費/一度</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_water" 
  					value="<%=(houseVO == null) ? "9" : houseVO.getHos_water()%>"  
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>電費/一度</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_power" 
  					value="<%=(houseVO == null) ? "2" : houseVO.getHos_power()%>"
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>網路費</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_internet" 
  					value="<%=(houseVO == null) ? "600" : houseVO.getHos_internet()%>"
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
               <div class="col-md-6 check_title"><h2>預約時間</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_order_date" id="f_date1"
  					value="<%=(houseVO == null) ? "600" : houseVO.getHos_order_date()%>"
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
          	<div class="col-md-6 check_title"><h2>上傳所有權狀</h2></div>
              <div class="col-md-6 form-group">
                <input type="file" name="hos_loc_pic" 
  					id="load"  
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
              </div>
          </div>
          <div class="col-lg-4">
            <div class="order_box">
              <h2>申請的物件-確認</h2>
              <ul class="list">
                <li>
                  <a>物件 租金
                    <span id="hos_rent">${empty houseVO.hos_rent?'未填':'$'+=houseVO.hos_rent}</span>
                  </a>
                </li>
                <li>
                  <a>水費/一度
                    <span id="hos_water">${empty houseVO.hos_rent?'未填':'$'+=houseVO.hos_water}</span>
                  </a>
                </li>
                <li>
                  <a>電費/一度
                    <span id="hos_power">${empty houseVO.hos_rent?'未填':'$'+=houseVO.hos_power}</span>
                  </a>
                </li>
                <li>
                  <a>網路費
                    <span id="hos_internet">${empty houseVO.hos_rent?'未填':'$'+=houseVO.hos_internet}</span>
                  </a>
                </li>
              </ul>
              <ul class="list list_2">
                <li>
                  <a>預約時間
                    <span id="hos_order_date">${empty houseVO.hos_order_date?'未填':'needFormat'}</span>
                  </a>
                </li>
              </ul>
              <ul class="list list_2">
                <li>
                  <a>地址
                    <span id="hos_address">${empty houseVO.hos_address?'未填':houseVO.hos_address}</span>
                  </a>
                </li>
              </ul>
              <div class="creat_account">
                <label for="f-option3">謝謝您的委託</label>
                <a >我們會盡速處理，並通知您</a>
              </div>
              <input  type="hidden" name="action" value="insert">
       			<input class="btn_3" type="submit" value="送出新增">
            </div>
          </div>
        </div>
		</FORM> 
      </div>
  </section>

<!-- 	================= -->
<!-- 參考網站 https://www.wfublog.com/2017/10/taiwan-county-town-zip-address-twzipcode-jquery.html -->
	<script>
	$("#twzipcode").twzipcode({
        countySel: "${houseVO.hos_city}", // 城市預設值, 字串一定要用繁體的 "臺", 否則抓不到資料
        districtSel: '${houseVO.hos_dist}', // 地區預設值
        zipcodeIntoDistrict: true, // 郵遞區號自動顯示在地區
        css: ["city form-control", "town form-control"], // 自訂 "城市"、"地區" class 名稱
        countyName: "hos_city", // 自訂城市 select 標籤的 name 值
        districtName: "hos_dist" // 自訂地區 select 標籤的 name 值
    });
	

	$(document).ready(function(){//確認時間，時間格式化
         if($("#hos_order_date").html()=="needFormat"){
            let date = new Date('${houseVO.hos_order_date}');
            let dateFormat = date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate()+' '+(date.getHours())+':'+date.getMinutes();
            $("#hos_order_date").html(dateFormat);
           }
    })
	
	$(function(){
		$("input[name='hos_rent']").change(function(){
			let rent = $("input[name='hos_rent']").val();
			$("#hos_rent").html('$ '+rent);
		})
		$("input[name='hos_water']").change(function(){
			let water = $("input[name='hos_water']").val();
			$("#hos_water").html('$ '+water);
		})
		$("input[name='hos_power']").change(function(){
			let power = $("input[name='hos_power']").val();
			$("#hos_power").html('$ '+power);
		})
		$("input[name='hos_internet']").change(function(){
			let internet = $("input[name='hos_internet']").val();
			$("#hos_internet").html('$ '+internet);
		})
		$("input[name='hos_order_date']").change(function(e){
			let date = $("input[name='hos_order_date']").val();
			$("#hos_order_date").html(date);
			e.stopPropagation();
		})
		$("input[name='hos_address']").change(function(e){
			let date = $("input[name='hos_address']").val();
			$("#hos_address").html(date);
			e.stopPropagation();
		})
	})
	let x = null;
	let z = null;
	let y = null;
	let today = null
	$(function(){
		x = new Date().getMonth()+1;
		z = new Date().getFullYear();
		y = new Date().getDate();
		today = z+'/'+x+'/'+y;//給datetimepicker用
	})
	$.datetimepicker.setLocale('zh');
    $('#f_date1').datetimepicker({
       theme: '',              //theme: 'dark',
       timepicker:true,       //timepicker:true,
       step: 60,                //step: 60 (這是timepicker的預設間隔60分鐘)
       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
	   value: new Date(), // value:   new Date(),
       //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
       startDate:	            '2021/04/30',  // 起始日
       minDate:               	-today, // 去除今日(不含)之前
       //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
    });
	</script>
<!-- ====以上新增物件資料送出=== -->

</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->
<!-- =====================下面為input時間外掛============================= -->
<!-- ########    而且注意不能Ctrl+shift+F自動排版 會發生錯誤!!!!!     ########### -->
<%
	java.sql.Timestamp hos_order_date = null;
	try {
		hos_order_date = houseVO.getHos_order_date();
	} catch (Exception e) {
		hos_order_date = new java.sql.Timestamp(System.currentTimeMillis());
	}
%>



<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
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

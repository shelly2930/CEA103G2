<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="BIG5">
<title>主管指派頁面</title>

<!-- =================套用bootstrap要使用以下=========================== -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
<!-- =================套用bootstrap要使用以下=========================== -->
<!-- =================套用台灣縣市鄉鎮要使用以下=========================== -->
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<!-- =================套用台灣縣市鄉鎮要使用以上=========================== -->
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
<body>
<!-- ===================================後臺NAV -->
	<nav class="navbar navbar-expand-lg navbar-lightblue bg-dark">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/back-end/indexBack.jsp"> <img src="${pageContext.request.contextPath}/index_img/home01.png"
			width="30" height="30" alt="">
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarTogglerDemo03"
			aria-controls="navbarTogglerDemo03" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<a class="navbar-brand" href="${pageContext.request.contextPath}/back-end/indexBack.jsp">HowTrue後台管理</a>
		<div class="collapse navbar-collapse " id="navbarTogglerDemo03">
			<ul class="navbar-nav  mr-auto mt-2 mt-lg-0">
				<li class="nav-item bg-dark  active dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> 物件管理 </a>
					<div class="dropdown-menu   bg-dark" aria-labelledby="navbarDropdown">
						<a class="dropdown-item bg-dark" href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend"><p style="color:lightblue">指派員工</p></a> 
						<a class="dropdown-item bg-dark" href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp&hos_state=0&hos_status=0"><p style="color:lightblue"> 申請處理</p></a>
						</li>
				<li class="nav-item bg-dark "><a class="nav-link disabled" href="#" aria-disabled="true">家具管理</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Action</a> <a
							class="dropdown-item" href="#">Another action</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
					</div></li>
				<li class="nav-item bg-dark"><a class="nav-link disabled"
					href="#" tabindex="-1" aria-disabled="true">員工資料管理</a></li>
				<li class="nav-item bg-dark"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp"
					tabindex="-1" aria-disabled="true">前臺傳送門</a></li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
<!-- ===================================後臺NAV -->
<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/house/house.do"
		enctype="multipart/form-data" name="form1">
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">房東姓名</span>
  			</div>
  			<span>${houseVO.lld_no}</span>
  			
  					
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
  				<select size="1" name="hos_type">
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
  				<input type="checkbox" id="hos_ele" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_ele == "1")?'checked':''} />
				<label for="hos_ele">電梯</label>
				<input type="checkbox" id="hos_parking" name="hos_check" value="hos_parking" size="45" ${(houseVO.hos_parking == "1")?'checked':''} />
				<label for="hos_parking">停車位</label>
				<input type="checkbox" id="hos_pet" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_pet == "1")?'checked':''} /> 
				<label for="hos_pet">可養寵物</label>
				<input type="checkbox" id="hos_cook" name="hos_check" value="hos_cook" size="45" ${(houseVO.hos_cook == "1")?'checked':''} />
				<label for="hos_cook">可開伙</label>
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
  				<select size="1" name="hos_gender">
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
			
	


<!-- 這裡從資料庫，table(附設家具)撈出資料，給房東填選用，填完要存，要存到table(物件附設家具) -->
<!-- 			<tr> -->
<!-- 			<td>物件已有的家具:</td> -->
<!-- 			<td> -->
<!-- <!-- 			addFurVO_list是從action = GoToInsert 拿出-->
<%-- 			<c:forEach var="addFurVO" varStatus="count" items="${addFurVO_list}"> --%>
<%-- 				<input id="${count.index}" type="checkbox" name="addfur_check" value="${addFurVO.add_fnt_no}"  --%>
<%-- 				 ${add_fnt_no_list.contains(addFurVO.add_fnt_no)?'checked':''} size="45" /> --%>
<%-- 				 <label for="${count.index}">${addFurVO.add_fnt_name}</label> --%>
<%-- 			</c:forEach>  --%>
<!-- 			</td> -->
<!-- 			</tr>  -->
<!-- 以上從資料庫，table(附設家具)撈出資料，給房東填選用，填完要存，要存到table(物件附設家具) -->	
<p>備註: 1.申請進度 要改成1</p>
		<br> 
		<input type="hidden" name="houseno" value="${houseVO.hos_no}">
		<input type="hidden" name="action" value="updateHouseForEmp">
		<input type="hidden" name="requestURL"	value="${param.requestURL}">
		<input type="submit" value="送出新增">
	</FORM>
<!-- 	================= -->
<!-- 參考網站 https://www.wfublog.com/2017/10/taiwan-county-town-zip-address-twzipcode-jquery.html -->
	<script>
	$("#twzipcode").twzipcode({
        countySel: '${houseVO.hos_city}', // 城市預設值, 字串一定要用繁體的 "臺", 否則抓不到資料
        districtSel: '${houseVO.hos_dist}', // 地區預設值
        zipcodeIntoDistrict: true, // 郵遞區號自動顯示在地區
        css: ["city form-control", "town form-control"], // 自訂 "城市"、"地區" class 名稱
        countyName: "hos_city", // 自訂城市 select 標籤的 name 值
        districtName: "hos_dist" // 自訂地區 select 標籤的 name 值
    });
	</script>
<!-- ====以上新增物件資料送出=== -->
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->
<!-- =====================下面為input時間外掛============================= -->
<!-- ########    而且注意不能Ctrl+shift+F自動排版 會發生錯誤!!!!!     ########### -->

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
</html>
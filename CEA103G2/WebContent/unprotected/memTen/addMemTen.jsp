<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ page import="com.memTen.model.*"%> --%>

<%
//   MemTenVO memTenVO = (MemTenVO) request.getAttribute("memTenVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<script src="<%=request.getContextPath()%>/template_front-end/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/nice-select.css">
<script src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.1/dist/tw-city-selector.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<title>會員註冊</title>

<style>

.single-input {
    display: block;
    width: 100%;
    line-height: 40px;
    border: none;
    outline: none;
    background: #ecfdff !important;
    padding: 0 20px;
}

.breadcrumb.breadcrumb_bg.rentalbaclground {
	margin-top:84px;
}

.breadcrumb_bg {
    background-image: url(/CEA103G2/unprotected/memTen/images/signup.jpg) !important;
}

.breadcrumb .breadcrumb_iner .breadcrumb_iner_item h2 {
    color: white !important;
    text-align: left !important;
}

.aaa {
    color: white !important;
    font-size:15px !important;
    text-align: left !important;
}

div.rentalstep {
	margin-top:20px;
}

.row {
	justify-content: center;
}

.mem_pic {
	width:200px;
	height:auto;
}

h3 {
	text-align:center;
}
</style>

</head>
<body>

<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>

<!-- 地址連動選單 -->
<script>
	new TwCitySelector();	
</script>


<section class="breadcrumb breadcrumb_bg rentalbaclground">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>HowTrue</h2>
                            <h3 class="aaa">會員註冊</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</section>

<div class="container">
	<div class="row rentalstep">
<!--         <div class="step1"> -->
<!--         	<h3>選擇合約期間</h3> -->
<!--         	<table class="table"> -->
<!-- 				<tbody> -->
<!-- 					<tr> -->
<!-- 						<th>合約起始日</th> -->
<!-- 							<td> -->
<!-- 								<div class="datealert"><i class="fas fa-exclamation-circle"></i> 只能選擇當日起算14天後</div> -->
<!-- 								<input class="single-input" name="rtct_eff_date" id="rtct_eff_date" type="text" required> -->
<!-- 							</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th>合約終止日</th> -->
<!-- 							<td> -->
<!-- 								<div class="datealert"><i class="fas fa-exclamation-circle"></i> 租期最短一個月</div> -->
<!-- 								<input class="single-input" name="rtct_end_date" id="rtct_end_date" type="text" required> -->
<!-- 							</td> -->
<!-- 					</tr> -->
<!-- 				</tbody> -->
<!-- 			</table>	 -->
<!--         </div> -->
        
<!--         <br> -->
<!--         <h3>申請會員資料</h3> -->
<!--         <h5 class="rentalalert"><i class="fas fa-exclamation-circle"></i> 請填真實資料</h5> -->
        <div class="step2">
        	<table class="table">
				<h3>請填寫以下資料</h3>
				
			
		<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/memTen/memTen.do" name="form1">
				<tbody>
					<tr>
						<th>帳號</th>
						<td>
							<input type="text" name="mem_username"  class="single-input" value="${requestScope.memVO.mem_username}">
							<p class="errorMsgs" id="username" style="color:red">${errorMsgs.mem_username}</p>
					    </tr>
					<tr>
					    <th>密碼</th>
						<td>
							<input type="password" name="mem_password"  class="single-input" value="${requestScope.memVO.mem_password}">
							<p class="errorMsgs" style="color:red">${errorMsgs.mem_password}</p>
						</td>
					</tr>
					    <tr>
					    	<th>照片</th>
							<td>
								<div id="preview"></div>
								<img id="img" class="mem_pic">
								<input type="file" name="mem_pic" id="mem_pic" size="45" />
							</td>
					    </tr>
					    <tr>
					    	<th>姓名</th>
							<td>
			 					<input type="text" name="mem_name"  class="single-input" value="${requestScope.memVO.mem_name}">
			 					<p class="errorMsgs" style="color:red">${errorMsgs.mem_name}</p>
							</td>
					    </tr>
					    <tr>
					    	<th>性別</th>
					    	<td>
					    		<select name="mem_gender" size="1" > 
									<option value="0"${requestScope.memTenVO.mem_gender == 0}>男</option>
									<option value="1"${requestScope.memTenVO.mem_gender == 1}>女</option>		
								</select>
					    	</td>
					    </tr>
					    <tr>
					    	<th>身分證字號</th>
							<td>
								<input type="text" name="mem_id"  class="single-input" value="${requestScope.memVO.mem_id}">
								<p class="errorMsgs" style="color:red">${errorMsgs.mem_id}</p>
							</td>
					    </tr>
					    <tr>
					    	<th>出生年月日</th>
							<td>
								<input class="single-input" name="mem_birthday" id="f_date1" type="text">
								<p class="errorMsgs" style="color:red">${errorMsgs.mem_birthday}</p>
							</td>
					    </tr>
					    <tr>
					    	<th>連絡電話</th>
							<td>
								<input type="text" name="mem_phone"  class="single-input" value="${requestScope.memVO.mem_phone}">
							</td>
					    </tr>
					    <tr>
					    	<th>行動電話</th>
							<td>
								<input type="text" name="mem_mobile"  class="single-input" value="${requestScope.memVO.mem_mobile}">
								<p class="errorMsgs" style="color:red">${errorMsgs.mem_mobile}</p>
							</td>
					    </tr>
					    <tr>
					    	<th>電子信箱</th>
							<td>
								<input type="text" name="mem_email"  class="single-input" value="${requestScope.memVO.mem_email}">
								<p class="errorMsgs" style="color:red">${errorMsgs.mem_email}</p>
							</td>
					    </tr>
					    <tr>
					    	<th>地址</th>
							<td>
								<div id='myaddress' role="tw-city-selector" data-has-zipcode data-hidden-zipcode data-bootstrap-style data-county-value="${requestScope.memVO.mem_city}"
						     			data-district-value="${requestScope.memVO.mem_dist}"></div>
<!-- 								<select size="1" name="mem_city" id="mem_city"> -->
<!-- 									<option value="no">請選擇縣市 -->
<!-- 								</select> -->
<!-- 								<select size="1" name="mem_dist" id="mem_dist" style="width:5em;"></select> -->
<%-- 						<input type="text" name="mem_addr" value="${memTenVO.mem_addr}" style="width:19.5em;"> --%>
<input type="hidden" name="mem_city"  class="single-input" value=""/>
<input type="hidden" name="mem_dist" class="single-input" value=""/>
								<input type="TEXT" name="mem_addr" class="single-input" value="${requestScope.memVO.mem_addr}"/>
							</td>
					    </tr>
					    
					    <tr>
					    	<th></th>
					    	<td>
					    		<input type="hidden" name="action" value="insert">
								<input type="submit" value="送出申請">
					    	</td>
					    </tr>
					</tbody>
				</table>
				</form>
          	</div>
    </div>
</div>


<!--================ footer =================-->


<!-- 上傳圖片可預覽 -->
<script>
$("#myaddress").change(function(){
	$("input[name='mem_city']").val($(this).children().eq(0).children().val());
	$("input[name='mem_dist']").val($(this).children().eq(1).children().val());
})
window.onload=function(){

    let myFile = document.getElementById("mem_pic");
    let preview = document.getElementById("preview");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        console.log(files);
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	console.log(-1);
            	let reader = new FileReader();
            	console.log(reader);
                reader.addEventListener('load', function(e) {
                	console.log("load");
                	let result = e.target.result;
                	console.log(result);
                	let img = document.getElementById('img');
//                 	let img = document.createElement('img');
                    img.src = result;
                    preview.append(img);
                    $("img:first").remove(); // 預覽只會保留最新上傳的
                });
                reader.readAsDataURL(file);
            } else {
                alert('請上傳圖片！');
            }
        }
    });    
}
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
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '${requestScope.memVO.mem_birthday}', // value:   new Date(),
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
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memTen.model.*"%>

<%
  MemTenVO memTenVO = (MemTenVO) request.getAttribute("memTenVO");
%>

<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/nice-select.css">
<script src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.1/dist/tw-city-selector.min.js"></script>

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
}

h3 {
	text-align:center;
}
</style>

</head>
<body>

<!--================ navbar =================-->

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
	        <div class="step2">
        	<table class="table">
				<h3>請填寫以下資料</h3>

<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/memTen/memTen.do" name="form1">
<table>
	<tr>
		<th>帳號:</th>
		<td><input type="TEXT" name="mem_username" size="45" 
			 value="<%= (memTenVO==null)? "" : memTenVO.getMem_username()%>" /></td>
	</tr>
	<tr>
		<th>密碼:</th>
		<td><input type="TEXT" name="mem_password" size="45"
			 value="<%= (memTenVO==null)? "" : memTenVO.getMem_password()%>" /></td>
	</tr>
	<tr>
		<th>照片:</th>
		<td><div id="preview"></div><input type="file" name="mem_pic" id="mem_pic" size="45" /></td>
	</tr>
	<tr>
		<th>姓名:</th>
		<td><input type="TEXT" name="mem_name" size="45"
			 value="<%= (memTenVO==null)? "" : memTenVO.getMem_name()%>" /></td>
	</tr>
	<tr>
		<th>性別:</th>
		<td>
			<select name="mem_gender" size="1"> 
				<option value="0"<%= ((memTenVO == null) ? "" : (memTenVO.getMem_gender() == 0 ? "selected" : ""))%>>男</option>
				<option value="1"<%= ((memTenVO == null) ? "" : (memTenVO.getMem_gender() == 1 ? "selected" : ""))%>>女</option>		
			</select>
		</td>
	</tr>
	<tr>
		<th>身分證字號:</th>
		<td><input type="TEXT" name="mem_id" size="45"
			 value="<%= (memTenVO==null)? "" : memTenVO.getMem_id()%>" /></td>
	</tr>
	<tr>
		<th>出生年月日:</th>
		<td><input name="mem_birthday" id="mem_birthday" type="text"></td>
	</tr>
	<tr>
		<th>連絡電話:</th>
		<td><input type="TEXT" name="mem_phone" size="45"
			 value="<%= (memTenVO==null)? "" : memTenVO.getMem_phone()%>" /></td>
	</tr>
	<tr>
		<th>行動電話:</th>
		<td><input type="TEXT" name="mem_mobile" size="45"
			 value="<%= (memTenVO==null)? "" : memTenVO.getMem_mobile()%>" /></td>
	</tr>
	<tr>
		<th>電子信箱:</th>
		<td><input type="TEXT" name="mem_email" size="45"
			 value="<%= (memTenVO==null)? "" : memTenVO.getMem_email()%>" /></td>
	</tr>
	<tr>
		<th>地址:</th>
		<td>
			<div role="tw-city-selector" data-has-zipcode data-hidden-zipcode data-county-value="台北市"
     			data-district-value="中山區"></div>
			<input type="TEXT" name="mem_addr" size="45" value="<%= (memTenVO==null)? "" : memTenVO.getMem_addr()%>"/>
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
<%-- <%@include file="/front-end/footer.file"%> --%>

<!-- jQuery -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
	<!-- popper js -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/popper.min.js"></script>
	<!-- bootstrap js -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/bootstrap.min.js"></script>
	<!-- easing js -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery.magnific-popup.js"></script>
	<!-- swiper js -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/lightslider.min.js"></script>
	<!-- swiper js -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/masonry.pkgd.js"></script>
	<!-- particles js -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/owl.carousel.min.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery.nice-select.min.js"></script>
	<!-- slick js -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/slick.min.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/swiper.jquery.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery.counterup.min.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/waypoints.min.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/contact.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery.ajaxchimp.min.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery.form.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery.validate.min.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/mail-script.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/stellar.js"></script>
	<!-- custom js -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/theme.js"></script>
	<script src="<%=request.getContextPath()%>/template_front-end/js/custom.js"></script>


<!-- 上傳圖片可預覽 -->
<script>
window.onload=function(){

    let myFile = document.getElementById("mem_pic");
    let preview = document.getElementById("preview");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('img');
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
        $('#mem_birthday').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '${mem_birthday}', // value:   new Date(),
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
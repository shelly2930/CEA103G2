<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memTen.model.*"%>

<%
	MemTenVO memTenVO = (MemTenVO) request.getAttribute("memTenVO"); //EmpServlet.java (Concroller) 存入req的memTenVO物件 (包括幫忙取出的memTenVO, 也包括輸入資料錯誤時的memTenVO物件)
%>

<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/nice-select.css">

<!-- Required source start -->
	<!-- jquery 這行有需要的人再加 -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<script src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.1/dist/tw-city-selector.min.js"></script>

<!-- 地址連動選單 -->
<script>
new TwCitySelector({
    el: '.city-selector-set-has-value',
    elCounty: '.county',
    elDistrict: '.district',
    bootstrapStyle: true
  });	
</script>

<title></title>

<style>
body { 
background-color: #dddddd !important;
}

img.mem_pic {
  	height: 200px;
  	width: auto;
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
                <div class="pagetitle">會員資料查看與修改</div>
				
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
					
					
					<FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" name="form1">
					<table class="table">
					  <tbody>
					  	<tr>
					    	<th>會員編號</th>
					    	<td><%=memTenVO.getMem_no()%></td>
					    </tr>
					    <tr>
					    	<th>帳號</th>
					    	<td><%=memTenVO.getMem_username()%></td>
					    </tr>
					    <tr>
					    	<th>密碼</th>
					    	<td>
					    		<input type="text" name="mem_password" placeholder="password" required class="single-input" value="<%=memTenVO.getMem_password()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>照片</th>
					    	<td>
					    		<div id="previewp"></div>
					    		<img id="imgp"  src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?action=getmempic&mem_no=${memTenVO.mem_no}"  class="mem_pic">
					    		<input type="file" name="mem_pic" id="mempic" size="45">
					    	</td>
					    </tr>
					    <tr>
					    	<th>姓名</th>
							<td>
								<input type="text" name="mem_name" placeholder="name" required class="single-input" value="<%=memTenVO.getMem_name()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>性別</th>
							<td>
								<select size="1" name="mem_gender" >
           							<option value="0" <%=memTenVO.getMem_gender() == 0 ? "selected" : ""%>>男</option>
           							<option value="1" <%=memTenVO.getMem_gender() == 1 ? "selected" : ""%>>女</option>     
       							</select>
        					</td>
					    </tr>
					    <tr>
					    	<th>身分證字號</th>
							<td>
								<input type="text" name="mem_id" placeholder="id" required class="single-input" value="<%=memTenVO.getMem_id()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>出生年月日</th>
							<td>
								<input type="text" name="mem_birthday" id="birthday_date" placeholder="birthday" required class="single-input" value="${MemTenVO.mem_birthday}">
							</td>
					    </tr>
					    <tr>
					    	<th>連絡電話</th>
							<td>
								<input type="text" name="mem_phone" placeholder="phone" class="single-input" value="<%=memTenVO.getMem_phone()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>行動電話</th>
							<td>
								<input type="text" name="mem_mobile" placeholder="mobile" required class="single-input" value="<%=memTenVO.getMem_mobile()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>電子信箱</th>
							<td>
								<input type="text" name="mem_email" placeholder="email" required class="single-input" value="<%=memTenVO.getMem_email()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>縣市</th>
							<td>
							<div class="city-selector-set-has-value">
							  <div>
							    <!-- 縣市選單 -->
							    <select class="county" data-value="<%=memTenVO.getMem_city()%>"></select>
							  </div>
							  <div>
							    <!-- 區域選單 -->
							    <select class="district" data-value="<%=memTenVO.getMem_addr()%>"></select>
							  </div>
							</div>
							</td>
					    </tr>
					    <tr>
					    	<th>地址</th>
							<td>
								<div role="tw-city-selector" data-has-zipcode data-hidden-zipcode data-county-value="<%=memTenVO.getMem_city()%>"
						     			data-district-value="<%=memTenVO.getMem_dist()%>"></div>
								<input type="TEXT" name="mem_addr" class="single-input" value="<%=memTenVO.getMem_addr()%>"/>
							</td>
					    </tr>
					    <tr>
					    	<th>身分證正面</th>
					    	<td>
					    		<div id="previewf"></div>
					    		<img id="imgf"  src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?action=getidcardf&mem_no=${memTenVO.mem_no}"  class="mem_pic">
					    		<input type="file" name="mem_idcard_f" id="idcardf" size="45">
					    	</td>
					    </tr>
					    <tr>
					    	<th>身分證背面</th>
					    	<td>
					    		<div id="previewr"></div>
					    		<img id="imgr" src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?action=getidcardr&mem_no=${memTenVO.mem_no}"  class="mem_pic">
					    		<input type="file" name="mem_idcard_r" id="idcardr" size="45">
					    	</td>
					    </tr>
					    <tr>
							<th>修改</th>
							<td>
								<input type="hidden" name="action" value="update">
								<input type="hidden" name="mem_no" value="<%=memTenVO.getMem_no()%>">
								<input type="submit" value="送出修改">
							</td>
						</tr>
					  </tbody>
					</table>
					</FORM>

				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

<!-- 上傳圖片可預覽 -->
<script>
window.onload=function(){

	let myFile = document.getElementById("mempic");
    let preview = document.getElementById("previewp");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgp');
                    img.src = result;
                    preview.append(img);
                    $("imgp:first").remove(); // 預覽只會保留最新上傳的
                });
                reader.readAsDataURL(file);
            } else {
                alert('請上傳圖片！');
            }
        }
    });
	
	
    let myFilef = document.getElementById("idcardf");
    let previewf = document.getElementById("previewf");

    myFilef.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgf');
                    img.src = result;
                    previewf.append(img);
                    $("imgf:first").remove(); // 預覽只會保留最新上傳的
                });
                reader.readAsDataURL(file);
            } else {
                alert('請上傳圖片！');
            }
        }
    });
    
    let myFiler = document.getElementById("idcardr");
    let previewr = document.getElementById("previewr");

    myFiler.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgr');
                    img.src = result;
                    previewr.append(img);
                    $("imgr:first").remove(); // 預覽只會保留最新上傳的
                });
                reader.readAsDataURL(file);
            } else {
                alert('請上傳圖片！');
            }
        }
    });
}

</script>

</body>

<%
	java.sql.Date mem_birthday = null;
	try {
		mem_birthday = memTenVO.getMem_birthday();
 	} catch (Exception e) {
		mem_birthday = new java.sql.Date(System.currentTimeMillis());
 	}
%>

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
        $('#birthday_date').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: '<%=memTenVO.getMem_birthday()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
</script>


<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
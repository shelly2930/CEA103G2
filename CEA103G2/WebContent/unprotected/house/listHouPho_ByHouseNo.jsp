<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
<title>房間照片</title>
<!-- =================套用bootstrap要使用以下=========================== -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
	<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
	
	
<!-- =================套用bootstrap要使用以上=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- <!=========================jquery===================== -->

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBzn3b0I0DFbDc6D5zc3DEtuI5kaYxAB4k&callback=initMap&libraries=&v=weekly" async></script>
<%@include file="/front-end/header.file"%>
<!-- =================地圖===================================== -->
<style>
table#table-2 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-2 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
/* 物件照片外框 */
/* .box1{ */
/*     margin: 15px; */
/*     padding: 10px;    */
/*     position:relative; */
/*     display: inline-block; */
/*     background: -webkit-gradient(linear, 0% 20%, 0% 1000%, from(#fff), to(#fff), color-stop(.1,#f3f3f3)); */
/*     border: 1px solid #ccc; */
/*     -webkit-box-shadow: 0px 3px 30px rgba(0, 0, 0, 0.1) inset; */
/*     -webkit-border-bottom-right-radius: 6px 50px;     */
/* } */
</style>

<style>
#map {
	height: 400px;           
	width: 100%;
 }
</style>

</head>
<body bgcolor='white'>


  <!--================Single Product Area =================-->
  <div class="product_image_area section_padding">
    <div class="container">
      <div class="row s_product_inner justify-content-between">
        <div class="col-lg-7 col-xl-7">
          <div class="product_slider_img">
            <div id="vertical">
         	<c:forEach var="houPhoVO" items="${listHouPho_ByHouseNo}">
				<div data-thumb="<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno=${houseVO.hos_no}&hos_pic_no=${houPhoVO.hos_pic_no}">
                <img src="<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno=${houseVO.hos_no}&hos_pic_no=${houPhoVO.hos_pic_no}" />
              </div>
			</c:forEach> 	
            </div>
          </div>
        </div>
        
        <div class="col-lg-5 col-xl-4">
          <div class="s_product_text">
            <h5>${houseVO.hos_city} <span>|</span> ${houseVO.hos_city}</h5>
            <h3>${houseVO.hos_name}</h3>
            <h2>${houseVO.hos_rent}</h2>
            <ul class="list">
              <li>
                <span>類型</span> : <c:choose>
										<c:when test="${houseVO.hos_type==0}">不限 </c:when>
										<c:when test="${houseVO.hos_type==1}">獨立套房  </c:when>
										<c:when test="${houseVO.hos_type==2}">分租套房</c:when>
										<c:when test="${houseVO.hos_type==3}">雅房</c:when>
										<c:when test="${houseVO.hos_type==4}">整層住家 </c:when>
										<c:when test="${houseVO.hos_type==5}">車位 </c:when>
										<c:when test="${houseVO.hos_type==6}">其他 </c:when>
									</c:choose>
              </li>
              <li>
                <span>坪數</span> : ${houseVO.hos_squares}
              </li>
            </ul>
            <p>
              ${houseVO.hos_address}
            </p>
            <div class="card_area d-flex justify-content-between align-items-center">
              <a href="#" class="btn_3">預約看房</a>
              <a href="#" class="like_us"><i class="ti-heart"></i>收藏</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <section class="product_description_area">
    <div class="container">
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <li class="nav-item">
          <a class="nav-link" id="info-tab" data-toggle="tab" href="#info" role="tab" aria-controls="info"
            aria-selected="true">物件介紹</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
            aria-selected="false">物件資訊</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
            aria-selected="false">相關費用</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
            aria-selected="false">地圖位置</a>
        </li>
      </ul>
      <div class="tab-content" id="myTabContent">
        <div class="tab-pane fade" id="info" role="tabpanel" aria-labelledby="home-tab">
          <p>
            ${houseVO.hos_info}
          </p>
        </div>
        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
          <div class="table-responsive">
            <table class="table">
              <tbody>
                <tr>
                  <td>
                    <h5>物件名稱</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_name}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>地址</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_address}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>房型</h5>
                  </td>
                  <td>
                    <h5><c:choose>
						<c:when test="${houseVO.hos_type==0}">不限 </c:when>
						<c:when test="${houseVO.hos_type==1}">獨立套房  </c:when>
						<c:when test="${houseVO.hos_type==2}">分租套房</c:when>
						<c:when test="${houseVO.hos_type==3}">雅房</c:when>
						<c:when test="${houseVO.hos_type==4}">整層住家 </c:when>
						<c:when test="${houseVO.hos_type==5}">車位 </c:when>
						<c:when test="${houseVO.hos_type==6}">其他 </c:when>
					</c:choose></h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>屋齡</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_age} 年</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>物件坪數</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_squares} 坪</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>性別限制</h5>
                  </td>
                  <td>
                    <h5><c:choose>
							<c:when test="${houseVO.hos_gender==0}">不拘 </c:when>
							<c:when test="${houseVO.hos_gender==1}">限制男生  </c:when>
							<c:when test="${houseVO.hos_gender==2}">限制女生</c:when>
					</c:choose></h5>
                  </td>
                </tr>
                
                <tr>
                  <td>
                    <h5>樓層 </h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_floor}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>坪數</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_squares}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>刊登日期</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_date}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>電梯與否</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_ele==1?'可':'不可'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>停車位與否</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_parking==1?'可':'不可'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>寵物與否</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_pet==1?'可':'不可'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>煮飯與否</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_cook==1?'可':'不可'}</h5>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
        <div class="table-responsive">
            <table class="table">
              <tbody>
                <tr>
                  <td>
                    <h5>物件租金</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_rent} 元 /一個月</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>水費/一度</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_water} 元/一度</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>電費/一度</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_power} 元/一度</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>網路費</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_internet==0?'不收費':'元/一個月'} </h5>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">
          <div class="row">
            <div class="col-lg-6">
            <div id ="map"></div>
		     <script>
		    function initMap() {
		        // 因為JSP優先於html Javascipt等等，所以到了javascript為字串，你要用javascript轉成數字
		        const city = { lat: parseFloat("${houseVO.hos_lat}"), 
		        				lng: parseFloat("${houseVO.hos_lon}")
		        				};
		        // The map, centered at city
		        const map = new google.maps.Map(document.getElementById("map"), {
		            zoom: 12,//地圖比例尺大小
		            center: city,
		        });
		        // The marker, positioned at city
		        const marker = new google.maps.Marker({
		            position: city,
		            map: map,
		        });
		    }
		    </script>
    
            <div class="col-lg-6">
              
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!--================End Product Description Area =================-->

  <!-- product_list part start-->
  <!-- product_list part end-->

  <!--::footer_part start::-->
  <!--::footer_part end::-->
<%@ include file="/front-end/footer.file"%>


	
</body>
</html>
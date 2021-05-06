<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
<title>�ж��Ӥ�</title>
<!-- =================�M��bootstrap�n�ϥΥH�U=========================== -->
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
	
	
<!-- =================�M��bootstrap�n�ϥΥH�W=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- <!=========================jquery===================== -->

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBzn3b0I0DFbDc6D5zc3DEtuI5kaYxAB4k&callback=initMap&libraries=&v=weekly" async></script>
<%@include file="/front-end/header.file"%>
<!-- =================�a��===================================== -->
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
/* ����Ӥ��~�� */
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
                <span>����</span> : <c:choose>
										<c:when test="${houseVO.hos_type==0}">���� </c:when>
										<c:when test="${houseVO.hos_type==1}">�W�߮M��  </c:when>
										<c:when test="${houseVO.hos_type==2}">�����M��</c:when>
										<c:when test="${houseVO.hos_type==3}">����</c:when>
										<c:when test="${houseVO.hos_type==4}">��h��a </c:when>
										<c:when test="${houseVO.hos_type==5}">���� </c:when>
										<c:when test="${houseVO.hos_type==6}">��L </c:when>
									</c:choose>
              </li>
              <li>
                <span>�W��</span> : ${houseVO.hos_squares}
              </li>
            </ul>
            <p>
              ${houseVO.hos_address}
            </p>
            <div class="card_area d-flex justify-content-between align-items-center">
              <a href="#" class="btn_3">�w���ݩ�</a>
              <a href="#" class="like_us"><i class="ti-heart"></i>����</a>
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
            aria-selected="true">���󤶲�</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
            aria-selected="false">�����T</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
            aria-selected="false">�����O��</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
            aria-selected="false">�a�Ϧ�m</a>
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
                    <h5>����W��</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_name}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�a�}</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_address}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�Ы�</h5>
                  </td>
                  <td>
                    <h5><c:choose>
						<c:when test="${houseVO.hos_type==0}">���� </c:when>
						<c:when test="${houseVO.hos_type==1}">�W�߮M��  </c:when>
						<c:when test="${houseVO.hos_type==2}">�����M��</c:when>
						<c:when test="${houseVO.hos_type==3}">����</c:when>
						<c:when test="${houseVO.hos_type==4}">��h��a </c:when>
						<c:when test="${houseVO.hos_type==5}">���� </c:when>
						<c:when test="${houseVO.hos_type==6}">��L </c:when>
					</c:choose></h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>����</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_age} �~</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>����W��</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_squares} �W</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�ʧO����</h5>
                  </td>
                  <td>
                    <h5><c:choose>
							<c:when test="${houseVO.hos_gender==0}">���� </c:when>
							<c:when test="${houseVO.hos_gender==1}">����k��  </c:when>
							<c:when test="${houseVO.hos_gender==2}">����k��</c:when>
					</c:choose></h5>
                  </td>
                </tr>
                
                <tr>
                  <td>
                    <h5>�Ӽh </h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_floor}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�W��</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_squares}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�Z�n���</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_date}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�q��P�_</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_ele==1?'�i':'���i'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>������P�_</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_parking==1?'�i':'���i'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�d���P�_</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_pet==1?'�i':'���i'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�N���P�_</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_cook==1?'�i':'���i'}</h5>
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
                    <h5>���󯲪�</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_rent} �� /�@�Ӥ�</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>���O/�@��</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_water} ��/�@��</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�q�O/�@��</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_power} ��/�@��</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�����O</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_internet==0?'�����O':'��/�@�Ӥ�'} </h5>
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
		        // �]��JSP�u����html Javascipt�����A�ҥH��Fjavascript���r��A�A�n��javascript�ন�Ʀr
		        const city = { lat: parseFloat("${houseVO.hos_lat}"), 
		        				lng: parseFloat("${houseVO.hos_lon}")
		        				};
		        // The map, centered at city
		        const map = new google.maps.Map(document.getElementById("map"), {
		            zoom: 12,//�a�Ϥ�Ҥؤj�p
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
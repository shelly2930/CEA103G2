<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.house.model.*"%>
<%@ page import="com.houPho.model.*"%>

<%
	List<HouseVO> list = (List<HouseVO>)request.getAttribute("listHouse_AllOrQuery");
	int listSize = list.size();		
%>

<html>
<head>
<title>瀏覽所有物件</title>
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!-- =========icon fontawesome -->
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<!-- ========= -->


<style>

/* 收藏 */
	#mapsearch{
		position:fixed;
		right:0;
   		top:480px;
   		z-index:2;
   		float:left; 
	}
	#collection{
		position:fixed;
		 right:0;
   		 top:400px;
   		 z-index:2;
   		 float:left; 
	}
	.bs-canvas-overlay {
   		opacity: 0;
		z-index: -1;
	}
	
	.bs-canvas-overlay.show {
   		opacity: 0.85;
		z-index: 1100;
	}
	
	.bs-canvas-overlay, .bs-canvas {
		transition: all .4s ease-out;
		-webkit-transition: all .4s ease-out;
		-moz-transition: all .4s ease-out;
		-ms-transition: all .4s ease-out;
	}
	
	.bs-canvas {
		top: 0;
		z-index: 1110;
		overflow-x: hidden;
		overflow-y: auto;
		width: 330px;		
	}
	
	.bs-canvas-left {
		left: 0;
		margin-left: -330px;
	}
	
	.bs-canvas-right {
		right: 0;
		margin-right: -330px;
	}
/* 收藏 */



.breadcrumb_bg {
    background-image:url('<%=request.getContextPath()%>/index_img/08.jpg') !important;
    background-position: center;
    background-repeat: no-repeat  !important;
    background-size: cover;
}
 
</style>

</head>
<body>

<!-- =================================上面是導覽列==================================================== -->

<%@include file="/front-end/header.file"%>	
<!-- ==================================下面是搜尋BAR=============================================	 -->

<div id="bs-canvas-right" class="bs-canvas bs-canvas-right position-fixed bg-light h-100">
	<header class="bs-canvas-header p-3 bg-info overflow-auto" style='opacity:0.5;'>
    	<button type="button" class="bs-canvas-close float-left close" aria-label="Close" aria-expanded="false"><span aria-hidden="true" class="text-light">&times;</span></button>
        <h4 class="d-inline-block text-light mb-0 float-right font-weight-bolder" >我的收藏</h4>
    </header>
    <div class="bs-canvas-content px-3 py-3" id='showcol'>
<!--     收藏區 -->
    </div>    
</div>



<!--================Home Banner Area =================-->
    <section class="breadcrumb breadcrumb_bg"  >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>HowTrue</h2>
                            <p>Rent <span>-</span> a Good House</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
	
	   <section  style='padding-top:40px'>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                        <div class="breadcrumb_iner_item">
								<div class="form-inline">
								<input style='width:80%' type="text" class="form-control" placeholder="請輸入關鍵字">
								<button type="submit" id='key' style='background-color:#EBEBFF;font-weight:bold' class="btn btn-default">關鍵字搜尋</button>
								</div>
								
                        </div>
                </div>
            </div>
        </div>
    </section> 
    <!--================Category Product Area =================-->
    <section class="cat_product_area" style='margin-top:20px'>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="left_sidebar_area">
 <!--                   搜尋列 -->      
         

                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3 style='color:#009E9E;font-weight:bold'>縣市</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=基隆">基隆</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=臺北">臺北</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=新北">新北</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=桃園">桃園</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=新竹">新竹</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=苗栗">苗栗</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=台中">台中</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=雲林">雲林</a>
                                        <span>(250)</span>
                                    </li>
                                </ul>
                            </div>
                        </aside>
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3 style='color:#009E9E;font-weight:bold'>類型</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">不限</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=1&action=listHouse_AllOrQuery">獨立套房</a>
                                    </li>
                                    <li class="active">
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=2&action=listHouse_AllOrQuery">分租套房</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=3&action=listHouse_AllOrQuery">雅房</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=4&action=listHouse_AllOrQuery">整層住家</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=5&action=listHouse_AllOrQuery">車位</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=6&action=listHouse_AllOrQuery">其他</a>
                                    </li>
                                </ul>
                            </div>
                        </aside>
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3 style='color:#009E9E;font-weight:bold'>坪數</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">不限</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=1&action=listHouse_AllOrQuery">10坪以下</a>
                                    </li>
                                    <li class="active">
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=2&action=listHouse_AllOrQuery">10坪-20坪</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=3&action=listHouse_AllOrQuery">20坪-30坪</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=4&action=listHouse_AllOrQuery">30坪-40坪</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=5&action=listHouse_AllOrQuery">40坪-50坪</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=6&action=listHouse_AllOrQuery">50坪以上</a>
                                    </li>
                                </ul>
                            </div>
                        </aside>
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3 style='color:#009E9E;font-weight:bold'>價格</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?price=0&action=listHouse_AllOrQuery">不限</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?price=1&action=listHouse_AllOrQuery">5000以下</a>
                                    </li>
                                    <li class="active">
                                        <a href="<%=request.getContextPath()%>/house/house.do?price=2&action=listHouse_AllOrQuery">5000-10000</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?price=3&action=listHouse_AllOrQuery">10000-20000</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?price=4&action=listHouse_AllOrQuery">20000-30000</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?price=5&action=listHouse_AllOrQuery">30000-40000</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?price=6&action=listHouse_AllOrQuery">40000以上</a>
                                    </li>
                                </ul>
                                
                            </div>
                        </aside>
                    </div>
                </div>
 <!--           搜尋列 -->
<!--  **********左側欄位*********************************************** -->
                <div class="col-lg-9">
                    <div class="row">
                    <div class="col-12" style="margin-bottom:5px">
			     		<a  class="genric-btn primary-border small" href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">清除查詢</a>
			     		
			     		<c:if test="${!empty map.hos_city[0]}">
			     			<a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">
			     			<button type="button" class="genric-btn success-border small">
			     			縣市:${map.hos_city[0]} x
			     			</button>
			     			</a>
			     		</c:if>
			     		
			     		<c:if test="${!empty map.hos_dist[0]}">
			     			<a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">
			     			<button type="button" class="genric-btn success-border small">
			     			鄉鎮:${map.hos_dist[0]} x
			     			</button>
			     			</a>
			     		</c:if> 
			     		 
			     		<c:if test="${!empty map.keyword[0]}">
			     			<a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">
			     			<button type="button" class="genric-btn success-border small">
			     			關鍵字:${map.keyword[0]} x
			     			</button>
			     			</a>
			     		</c:if> 
			     		
			     		<c:choose>
						<c:when test="${map.price[0]==0}">
						</c:when>
						<c:when test="${map.price[0]==1}">
							<a href="<%=request.getContextPath()%>/house/house.do?price=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								5000以下  x
								</button>
							</a>
						</c:when>
						<c:when test="${map.price[0]==2}">
							<a href="<%=request.getContextPath()%>/house/house.do?price=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								5000-10000 x
								</button>
							</a>
						</c:when>
						<c:when test="${map.price[0]==3}">
							<a href="<%=request.getContextPath()%>/house/house.do?price=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								10000-20000 x
								</button>
							</a>
						</c:when>
						<c:when test="${map.price[0]==4}">
							<a href="<%=request.getContextPath()%>/house/house.do?price=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								20000-30000 x
								</button>
							</a>
						</c:when>
						<c:when test="${map.price[0]==5}">
							<a href="<%=request.getContextPath()%>/house/house.do?price=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								30000-40000 x
								</button>
							</a>
						</c:when>
						<c:when test="${map.price[0]==6}">
							<a href="<%=request.getContextPath()%>/house/house.do?price=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								40000以上 x
								</button>
							</a>
						</c:when>
						</c:choose>
						
			     		<c:choose>
						<c:when test="${map.area[0]==0}"></c:when>
						<c:when test="${map.area[0]==1}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								10坪以下  x
								</button>
							</a>
						</c:when>
						<c:when test="${map.area[0]==2}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								10-20坪 x
								</button>
							</a>
						</c:when>
						<c:when test="${map.area[0]==3}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								20-30坪 x
								</button>
							</a>
						</c:when>
						<c:when test="${map.area[0]==4}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								30-40坪 x
								</button>
							</a>
						</c:when>
						<c:when test="${map.area[0]==5}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								40-50坪 x
								</button>
							</a>
						</c:when>
						<c:when test="${map.area[0]==6}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								50坪以上 x
								</button>
							</a>
						</c:when>
						</c:choose> 
			     	
			     		<c:choose>
						<c:when test="${map.hos_type[0]==0}"></c:when>
						<c:when test="${map.hos_type[0]==1}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								獨立套房  x
								</button>
							</a>
						</c:when>
						<c:when test="${map.hos_type[0]==2}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								分租套房 x
								</button>
							</a>
						</c:when>
						<c:when test="${map.hos_type[0]==3}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								雅房 x
								</button>
							</a>
						</c:when>
						<c:when test="${map.hos_type[0]==4}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								整層住家 x 
								</button>
							</a>
						</c:when>
						<c:when test="${map.hos_type[0]==5}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								車位 x 
								</button>
							</a>
						</c:when>
						<c:when test="${map.hos_type[0]==6}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								其他 x
								</button>
							</a>
						 </c:when>
						</c:choose> 
			     	</div>
<!--  **************以上取消搜尋*********************************************** -->
                    
                    
                    
 <!--  **************以上取消搜尋*********************************************** -->                  
                        <div class="col-lg-12">
<!--                    暫時 -->
                        <%@ include file="pages/page1_ByCompositeQuery.file"%>
                            <div class="product_top_bar d-flex justify-content-between align-items-center">
                                <div class="single_product_menu">
                                    <p style='color:#969696;font-size:18px'>共<span> <%=listSize%> </span> 筆符合搜尋結果的物件</p>
                                </div>
                                 
                                <div class="row">
	                                <div class="col-lg-12">
			                            <div class="pageination">
			                                <nav aria-label="Page navigation example">
			                                    <ul class="pagination justify-content-center">
			                                        <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_rent&orderType=asc&action=listHouse_AllOrQuery" aria-label="Previous">
			                                                <i class="fas fa-5x fa-search-dollar" style='font-size:22px'></i>
			                                                <i class="ti-angle-double-up"></i>
			                                            </a>
			                                        </li>
			                                        <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_rent&orderType=desc&action=listHouse_AllOrQuery" aria-label="Next">
			                                                <i class="fas  fa-5x fa-search-dollar" style='font-size:22px'></i>
			                                                <i class="ti-angle-double-down"></i>
			                                            </a>
			                                        </li>
			                                        <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_squares&orderType=asc&action=listHouse_AllOrQuery" aria-label="Previous">
			                                                <i class="fas  fa-5x fa-home" style='font-size:22px'></i>
			                                                <i class="ti-angle-double-up"></i>
			                                            </a>
			                                        </li>
			                                         <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_squares&orderType=desc&action=listHouse_AllOrQuery" aria-label="Next">
			                                                <i class="fas  fa-5x fa-home" style='font-size:22px'></i>
			                                                <i class="ti-angle-double-down  fa-5x"></i>
			                                            </a>
			                                        </li>
			                                          <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_state&orderType=asc&action=listHouse_AllOrQuery" aria-label="Previous">
			                                                <i class="fas  fa-5x fa-clock" style='font-size:22px'></i>
			                                                <i class="ti-angle-double-up"></i>
			                                            </a>
			                                        </li>
			                                         <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_state&orderType=desc&action=listHouse_AllOrQuery" aria-label="Next">
			                                                <i class="fas fa-clock" style='font-size:22px'></i>
			                                                <i class="ti-angle-double-down"></i>
			                                            </a>
			                                        </li>
			                                    </ul>
			                                </nav>
			                            </div>
	                        		</div>
                                </div>
                        </div>
                    </div>
<!--   <==================內容                  -->
<!-- 					//產品 -->
               		<div id='zerotext' style='padding:100px;display:none;margin:auto;' ><h3 style='color:#BABABA;margin:auto;'>查無搜尋結果</h3></div>
					<!--                     	收藏 -->
					<a class="ml-3 order-xl-last btn btn-info" style='opacity:0.5;' id="collection" data-toggle="canvas" href="#bs-canvas-right" aria-expanded="false" aria-controls="bs-canvas-right" role="button"><i class="fas fa-home" ><br><hr>收藏</i></a>
					<a class="ml-3 order-xl-last btn btn-primary" style='opacity:0.5;' id="mapsearch"  href="" ><i class="fas fa-map-marker-alt"><br><hr>地圖<br>找房</i></a>
                    <!--                     	以上收藏 -->
                    <div class="row align-items-center latest_product_inner">
                        <c:forEach var="houseVO" items="${listHouse_AllOrQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="counter">
                            <div class="col-lg-4">
	                            <div class="single_product_item">
	<!--                                 	<div class="box1"> -->
											<a href="<%=request.getContextPath()%>/house/house.do?houseno=${houseVO.hos_no}&action=listHouPho_ByHouseA">
											<img src="<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno=${houseVO.hos_no}" >
											</a>
	<!-- 									</div> -->
								<div class="single_product_text">
	                                 <h5>${houseVO.hos_name}</h5>
	                                 <h5>$${houseVO.hos_rent} | <c:choose>
										<c:when test="${houseVO.hos_type==0}">不限 </c:when>
										<c:when test="${houseVO.hos_type==1}">獨立套房  </c:when>
										<c:when test="${houseVO.hos_type==2}">分租套房</c:when>
										<c:when test="${houseVO.hos_type==3}">雅房</c:when>
										<c:when test="${houseVO.hos_type==4}">整層住家 </c:when>
										<c:when test="${houseVO.hos_type==5}">車位 </c:when>
										<c:when test="${houseVO.hos_type==6}">其他 </c:when>
										</c:choose> | ${houseVO.hos_squares}坪</h5>
	                                    <h5>${houseVO.hos_address}</h5>
	                                    <a href="" id='${houseVO.hos_no}' class="add">加入收藏<i class="far fa-heart" style='color:#FF9696;font-size:23px'></i></a>
	                                </div>
	                            </div>
                            </div>
                   		</c:forEach>
                   </div>
                   
                   
                   
                   
                   
                   
                        
                       
                        <div class="col-lg-12">
                            <div id='zerosearch' class="pageination">
                                <nav aria-label="Page navigation example">
                                    <ul id="page" class="pagination justify-content-center">
                                   		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/house/house.do?whichPage=1&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery">第一頁</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?whichPage=${(param.whichPage==0)||(param.whichPage-1)==0?'1':param.whichPage-1}&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery" aria-label="Previous">
                                                <i class="ti-angle-double-left"></i>
                                            </a>
                                        </li>
                                        <li id='thispage' class='page-item'></li>
                                        <li class="page-item">
                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?whichPage=<%=pageNumber%>&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery" aria-label="Next">
                                                <i class="ti-angle-double-right"></i>
                                            </a>
                                        </li>
                                        <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/house/house.do?whichPage=<%=pageNumber %>&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery">最後一頁</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    
    <div class="modal fade" id="controltext" tabindex="2" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Write notes</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="message-text" class="col-form-label">notes:</label>
	            <textarea class="form-control" id="message-text">dssss</textarea>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" id="sendtext" class="btn btn-primary">add notes</button>
	      </div>
	    </div>
	  </div>
	</div>
    
    
	
	<script>
		$("#mapsearch").click(function(e){
			e.preventDefault();
			$(location).attr('href',"<%=request.getContextPath()%>/unprotected/house/mapsearch.jsp");
		})
	
		$("#key").click(function(){
			if(!!$(this).prev().val()){
				$(location).attr('href',"<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&keyword="+$(this).prev().val());
			}else{
				Swal.fire({
					  title: '請輸入關鍵字',
				})
			}
		})
	
	
	
		let dist0 =['中山區','中正區','信義區','仁愛區','暖暖區','安樂區','七堵區'];
		let dist1 =['北投區' , '士林區', '內湖區' , '松山區' , '中山區' , '大同區' , '南港區' ,'信義區' , '大安區' ,'中正區' , '萬華區' , '文山區'];
		let dist2 =['板橋區','三重區','中和區','永和區','新莊區','新店區','土城區','蘆洲區','樹林區','汐止區','鶯歌區','三峽區','淡水區','瑞芳區','五股區','泰山區','林口區','深坑區','石碇區','坪林區','三芝區','石門區','八里區','平溪區','雙溪區','貢寮區','金山區','萬里區','烏來區'];
		let dist3 =['中壢區','平鎮區','龍潭區','楊梅區','新屋區','觀音區','桃園區','龜山區','八德區','大溪區','復興區','大園區','蘆竹區'];
		let dist4 =['新竹市','東區','北區','香山區'];
		let dist5 =['苗栗市','苑裡鎮','通霄鎮','竹南鎮','頭份市','後龍鎮','卓蘭鎮','大湖鄉','公館鄉','銅鑼鄉','南庄鄉','頭屋鄉','三義鄉','西湖鄉','造橋鄉','三灣鄉','獅潭鄉','泰安鄉'];
 		let dist6 =['中區','東區','西區','南區','北區','西屯區','南屯區','北屯區','豐原區','大里區','太平區','清水區','沙鹿區','大甲區','東勢區','梧棲區','烏日區','神岡區','大肚區','大雅區','后里區','霧峰區','潭子區','龍井區','外埔區','和平區','石岡區','大安區','新社區'];
		let dist7 =['麥寮鄉','崙背鄉','二崙鄉','西螺鎮','莿桐鄉','林內鄉','臺西鄉','東勢鄉','褒忠鄉','元長鄉','土庫鎮','大埤鄉','虎尾鎮','斗六市','斗南鎮','古坑鄉','四湖鄉','口湖鄉','水林鄉','北港鎮'];
 		$(".num").eq(0).click(function(e){
			e.preventDefault();
			$(".hide").each(function(index){
				$(this).remove();
			})
			let str ="";
			for(let dist of dist0){
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=基隆&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
			}
			$(this).parents('li').after(str);
			$(".hide").hide();
			$(".hide").slideDown(1000);
		})
		$(".num").eq(1).click(function(e){
			e.preventDefault();
			$(".hide").each(function(index){
				$(this).remove();
			})
			let str ="";
			for(let dist of dist1){
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=臺北&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
			}
			$(this).parents('li').after(str);
			$(".hide").hide();
			$(".hide").slideDown(1000);
		})
		$(".num").eq(2).click(function(e){
			e.preventDefault();
			$(".hide").each(function(index){
				$(this).remove();
			})
			let str ="";
			for(let dist of dist2){
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=新北&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
			}
			$(this).parents('li').after(str);
			$(".hide").hide();
			$(".hide").slideDown(1000);
		})
		$(".num").eq(3).click(function(e){
			e.preventDefault();
			let str ="";
			$(".hide").each(function(index){
				$(this).remove();
			})
			for(let dist of dist3){
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=桃園&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
			}
			$(this).parents('li').after(str);
			$(".hide").hide();
			$(".hide").slideDown(1000);
		})
		$(".num").eq(4).click(function(e){
			e.preventDefault();
			let str ="";
			$(".hide").each(function(index){
				$(this).remove();
			})
			for(let dist of dist4){
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=新竹&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
			}
			$(this).parents('li').after(str);
			$(".hide").hide();
			$(".hide").slideDown(1000);
		})
		$(".num").eq(5).click(function(e){
			e.preventDefault();
			let str ="";
			$(".hide").each(function(index){
				$(this).remove();
			})
			for(let dist of dist5){
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=苗栗&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
			}
			$(this).parents('li').after(str);
			$(".hide").hide();
			$(".hide").slideDown(1000);
		})
		
		$(".num").eq(6).click(function(e){
			e.preventDefault();
			let str ="";
			$(".hide").each(function(index){
				$(this).remove();
			})
			for(let dist of dist6){
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=台中&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
			}
			$(this).parents('li').after(str);
			$(".hide").hide();
			$(".hide").slideDown(1000);
		})
		$(".num").eq(7).click(function(e){
			e.preventDefault();
			let str ="";
			$(".hide").each(function(index){
				$(this).remove();
			})
			for(let dist of dist7){
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=雲林&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
			}
			$(this).parents('li').after(str);
			$(".hide").hide();
			$(".hide").slideDown(1000);
		})
		getNum('中壢')
		$(".num").each(function(){
			let size = getNum($(this).html());
			$(this).next().text("("+size+")");
			
		})
		function getNum(city){
				let size=0;
				$.ajax({
					url:"<%=request.getContextPath()%>/HouseJsonServlet",
					type:'post',
					data:{
						action:'mapsearch',
						hos_city:city,
					},
					async: false,
					success:function(str){
						size=str.length;						
					}
				})
				return size;
			}
	
	
	
	
	
	
	//取得會員
			let mem_no = ${empty MemTenVO.mem_no ?"null":MemTenVO.mem_no};
			
			//分頁
			let enterPage = ${empty param.whichPage?'1':param.whichPage};
			let totalPage = <%=pageNumber %>;
			if(totalPage==0){
				$("#zerosearch").hide();
				$("#zerotext").show();
			}
			$("#thispage").html("<a class='page-link' href='<%=request.getContextPath()%>/house/house.do?whichPage="+enterPage+"&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery'>"+enterPage+"</a>");
			//收藏
			function getCol(mem_no){
				if(mem_no==null){
					return;
				}
				let collection = new Set();
				$.ajax({
					url:"<%=request.getContextPath()%>/HouColServlet",
					type:'post',
					data:{
						action:'getall',
						mem_no:mem_no,
					},
					async: false,
					success:function(str){
						for(let x of str){
							collection.add(x.hos_no);
						}
						$(".fa-heart").each(function(index){
							if(collection.has(parseInt($(this).parent().attr('id')))){
								$(this).removeClass('far');
								$(this).addClass('fas');
							}else{
								$(this).removeClass('fas');
								$(this).addClass('far');
							}
							
						})
						
					}
				})
				return collection;
			}
			let colarray=null;
			//會員收藏 單筆新增修改
			if(mem_no===null){
				colarray = new Set();
			}else{
				colarray = getCol(mem_no);
			}
			
			$('.add').click(function(e){
				e.preventDefault();
				if(mem_no==null){
					Swal.fire({
						  title: '請先登入會員',
						  text: 'Go to the login page and sign in',
						  icon: 'warning',
						  showCancelButton: true,
						  confirmButtonColor: '#6495ed',
						  cancelButtonColor: '#fa8072',
						  confirmButtonText: 'Sign in',
						  cancelButtonText:'Cancel',
						  confirmButtonClass:'btn-sm',
						  cancelButtonClass:'btn btn-info btn-sm',
						}).then((result) => {
						  if (result.isConfirmed) {
							  $(location).prop('href', '<%=request.getContextPath()%>/unprotected/memTen/login.jsp');
						  }
					})
				}else{
					if(colarray.has(parseInt($(this).attr('id')))){
						$.ajax({
							url:"<%=request.getContextPath()%>/HouColServlet",
							type:'post',
							data:{
								action:'deleteCol',
								hos_no:$(this).attr('id'),
								mem_no:mem_no,
							},
							async: false,
							success:function(str){
								console.log("取消收藏");
								colarray=getCol(mem_no);
								reset(colarray);
							}
						})
						//取消收藏
					}else{
						$.ajax({
							url:"<%=request.getContextPath()%>/HouColServlet",
							type:'post',
							data:{
								action:'addHouCol',
								hos_no:$(this).attr('id'),
								mem_no:mem_no,
							},
							async: false,
							success:function(str){
								console.log('新增成功');
								getCol(mem_no);
								colarray=getCol(mem_no);
								reset(colarray);
							}
						})
						
					}
					
				}
				console.log(typeof($(this).attr("id")))
				
			})
			let addcol_hos = null;
			reset(colarray);
			function reset(colarray){
				if(colarray.size==0){
					$("#showcol").empty();
					return false;
				}
				$("#showcol").empty();
				console.log(colarray.size)
				for(let col_no of colarray){
					
					$.get({
						url:"<%=request.getContextPath()%>/HouseJsonServlet",
						type:"post",
						data:{
							action:'getOneHouse',
							houseno:col_no,
						},
						async:false,
						success:function(jsonStr){
							
							let str = "<div class='card' style='width: 18rem;'>";
							str+="<div class='card-header'>";
							str+="<h6 class='card-text text-secondary '>標題: "+jsonStr.hos_name+"</h6>";
							str+="</div>";
							str+="<div class='list-group mb-5'>";
							str+="<a href='<%=request.getContextPath()%>/house/house.do?houseno="+jsonStr.hos_no+"&action=listHouPho_ByHouseA'>"
							str+="<img src='<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno="+jsonStr.hos_no+"' class='card-img-top' alt='收藏照片'>";
							str+="</a>";
							str+="<div class='card-body'>";
							
							str+="<p class='card-text text-secondary'>租金: "+jsonStr.hos_rent+"</p>";
							str+="<p class='card-text text-secondary'>地址: "+jsonStr.hos_address+"</p>";
							str+="<p class='card-text showtext text-secondary' id='text"+jsonStr.hos_no+"' >備註: 尚未填寫</p>";
							str+="</div></div>";
							str+="<div class='card-footer' id='"+jsonStr.hos_no+"'>";
							str+="<a href=''class='cancelcol' style='display:inline-block' ><h5><i class='fas fa-window-close text-info'>取消收藏</i></h5></a>";
							str+="<a href=''class='addcoltext' style='display:inline-block' id='add"+jsonStr.hos_no+"'><h5>&nbsp; &nbsp; &nbsp; <i class='fas fa-edit text-warning'>增加備註</i></h5></a>";
							str+="</div>";
							str+="</div><hr>";
							$("#showcol").append(str);
							$.ajax({
								url:"<%=request.getContextPath()%>/HouColServlet",
								type:'post',
								data:{
									action:'getOne',
									mem_no:mem_no,
									hos_no:col_no,
								},
								async: false,
								success:function(str){
									if(str.hos_col_note.trim().length==0){
									}else{
										$("#text"+col_no).html("備註: "+str.hos_col_note);
									}
								}
							})
							$("#add"+jsonStr.hos_no).click(function(e){
								addcol_hos = $(this).parent().attr('id');
// 								新增備註
								e.preventDefault();
								$("#controltext").modal('show');
								$("#message-text").val($("#text"+jsonStr.hos_no).html().substring(4));
							})
							
						}
					});
				}
				
				
				
				
				$(".cancelcol").click(function(e){
					e.preventDefault();
					$.ajax({
						url:"<%=request.getContextPath()%>/HouColServlet",
						type:'post',
						data:{
							action:'deleteCol',
							hos_no:$(this).parent().attr('id'),
							mem_no:mem_no,
						},
						async: false,
						success:function(str){
							console.log("取消收藏");
							colarray=getCol(mem_no);
							$("#showcol").empty();
							reset(colarray);
						}
					})
				})
			}
			
			$("#sendtext").click(function(e){
				e.preventDefault();
				e.stopPropagation();
				$.ajax({
					url:"<%=request.getContextPath()%>/HouColServlet",
					type:'post',
					data:{
						action:'update',
						hos_no:addcol_hos,
						hos_col_note:$("#message-text").val(),
						mem_no:mem_no,
					},
					async: false,
					success:function(str){
						console.log(str);
						colarray=getCol(mem_no);
						reset(colarray);
					}
				})
			})
			
			
			jQuery(document).ready(function($){
				
				var bsOverlay = $('.bs-canvas-overlay');
				$('[data-toggle="canvas"]').on('click', function(){
					if(mem_no==null){
						
						Swal.fire({
							  title: '請先登入會員',
							  text: 'Go to the login page and sign in',
							  icon: 'warning',
							  showCancelButton: true,
							  confirmButtonColor: '#6495ed',
							  cancelButtonColor: '#fa8072',
							  confirmButtonText: 'Sign in',
							  cancelButtonText:'Cancel',
							  confirmButtonClass:'btn-sm',
							  cancelButtonClass:'btn btn-info btn-sm',
							}).then((result) => {
							  if (result.isConfirmed) {
								  $(location).prop('href', '<%=request.getContextPath()%>/unprotected/memTen/login.jsp');
							  }else{
								  return false;
							  }
						})
					}else{
						reset(colarray);
						var ctrl = $(this), 
							elm = ctrl.is('button') ? ctrl.data('target') : ctrl.attr('href');
						$(elm).addClass('mr-0');
						$(elm + ' .bs-canvas-close').attr('aria-expanded', "true");
						$('[data-target="' + elm + '"], a[href="' + elm + '"]').attr('aria-expanded', "true");
						if(bsOverlay.length)
							bsOverlay.addClass('show');
						return false;
						
					}
				});
				
				$('.bs-canvas-close, .bs-canvas-overlay').on('click', function(){
					var elm;
					if($(this).hasClass('bs-canvas-close')) {
						elm = $(this).closest('.bs-canvas');
						$('[data-target="' + elm + '"], a[href="' + elm + '"]').attr('aria-expanded', "false");
					} else {
						elm = $('.bs-canvas')
						$('[data-toggle="canvas"]').attr('aria-expanded', "false");	
					}
					elm.removeClass('mr-0');
					$('.bs-canvas-close', elm).attr('aria-expanded', "false");
					if(bsOverlay.length)
						bsOverlay.removeClass('show');
					return false;
				});
			});
			  
			  
			   
			  
				
	</script>

	
	
<%@ include file="/front-end/footer.file"%>
<script>


</script>
</body>
</html>
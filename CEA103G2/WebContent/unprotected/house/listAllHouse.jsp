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
<title>瀏覽所有物件(訪客看到的頁面)</title>
<!-- =================套用bootstrap要使用以下=========================== -->
<!-- <meta name="viewport" -->
<!-- 	content="width=device-width, initial-scale=1, shrink-to-fit=no"> -->
<!-- <script type="text/javascript" -->
<!-- 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> -->

<!-- <link rel="stylesheet" -->
<!-- 	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" -->
<!-- 	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" -->
<!-- 	crossorigin="anonymous"> -->

<!-- 	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" -->
<!-- 		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" -->
<!-- 		crossorigin="anonymous"></script> -->
<!-- 	<script -->
<!-- 		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" -->
<!-- 		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" -->
<!-- 		crossorigin="anonymous"></script> -->
<!-- 	<script -->
<!-- 		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" -->
<!-- 		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" -->
<!-- 		crossorigin="anonymous"></script> -->
<!-- =================套用bootstrap要使用以下=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<!-- =========icon fontawesome -->
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<!-- ========= -->


<style>
.box1{

    margin: 20px;
    padding: 10px;   
    position:relative;
    display: inline-block;
    background: -webkit-gradient(linear, 0% 20%, 0% 1000%, from(#fff), to(#fff), color-stop(.1,#f3f3f3));
    border: 1px solid #ccc;
    -webkit-box-shadow: 0px 3px 30px rgba(0, 0, 0, 0.1) inset;
    -webkit-border-bottom-right-radius: 6px 50px;    
}

</style>

</head>
<body>

<!-- ====以下導覽列=== -->
<!-- 	<nav class="navbar navbar-expand-lg navbar-light bg-light"> -->
<%-- 		<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp"> <img --%>
<%-- 			src="<%=request.getContextPath()%>/index_img/home01.png" width="30" --%>
<!-- 			height="30" alt=""> -->
<!-- 		</a> -->
<!-- 		<button class="navbar-toggler" type="button" data-toggle="collapse" -->
<!-- 			data-target="#navbarTogglerDemo03" -->
<!-- 			aria-controls="navbarTogglerDemo03" aria-expanded="false" -->
<!-- 			aria-label="Toggle navigation"> -->
<!-- 			<span class="navbar-toggler-icon"></span> -->
<!-- 		</button> -->
<%-- 		<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">HowTrue</a> --%>
<!-- 		<div class="collapse navbar-collapse" id="navbarTogglerDemo03"> -->
<!-- 			<ul class="navbar-nav mr-auto mt-2 mt-lg-0"> -->
<%-- 				<li class="nav-item active"><a class="nav-link" href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">租屋 --%>
<!-- 						<span class="sr-only">(current)</span> -->
<!-- 				</a></li> -->
<!-- 				<li class="nav-item"><a class="nav-link  disabled" href="#">租家具</a></li> -->
<%-- 				<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/house/house.do?action=goToInsert" --%>
<!-- 					tabindex="-1" aria-disabled="true">房東上傳物件</a></li> -->
<%-- 				<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/back-end/indexBack.jsp" --%>
<!-- 					tabindex="-1" aria-disabled="true">後臺傳送門</a></li> -->
<!-- 			</ul> -->
<!-- 			<form class="form-inline my-2 my-lg-0"> -->
<!-- 				<input class="form-control mr-sm-2" type="search" -->
<!-- 					placeholder="Search" aria-label="Search"> -->
<!-- 				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button> -->
<!-- 			</form> -->
<!-- 		</div> -->
<!-- 	</nav> -->
<!-- =================================上面是導覽列==================================================== -->

<%@include file="/front-end/header.jsp"%>	
<!-- ==================================下面是搜尋BAR=============================================	 -->



<!--================Home Banner Area =================-->
<!--     breadcrumb start -->
<!--     <section class="breadcrumb breadcrumb_bg"> -->
<!--         <div class="container"> -->
<!--             <div class="row justify-content-center"> -->
<!--                 <div class="col-lg-8"> -->
<!--                     <div class="breadcrumb_iner"> -->
<!--                         <div class="breadcrumb_iner_item"> -->
<!--                             <h2>HowTrue</h2> -->
<!--                             <p>Home <span>-</span> Shop Category</p> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </section> -->
<!--     breadcrumb start -->

    <!--================Category Product Area =================-->
    <section class="cat_product_area section_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="left_sidebar_area">
 <!--                   搜尋列 -->              
                    	   
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3>縣市</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=基隆">基隆</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=台北">台北</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=桃園">桃園</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=新竹">新竹</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=苗栗">苗栗</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=台中">台中</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=雲林">雲林</a>
                                        <span>(250)</span>
                                    </li>
                                </ul>
                            </div>
                        </aside>
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3>類型</h3>
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
                                <h3>坪數</h3>
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
                                <h3>價格</h3>
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
<!--  **********右側欄位*********************************************** -->
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
                                    <p>共<span> <%=listSize%> </span> 筆符合搜尋結果的物件</p>
                                </div>
                                 
                                <div class="row">
	                                <div class="col-lg-12">
			                            <div class="pageination">
			                                <nav aria-label="Page navigation example">
			                                    <ul class="pagination justify-content-center">
			                                        <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_rent&orderType=asc&action=listHouse_AllOrQuery" aria-label="Previous">
			                                                <i class="fas fa-search-dollar"></i><i class="ti-angle-double-up"></i>
			                                            </a>
			                                        </li>
			                                        <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_rent&orderType=desc&action=listHouse_AllOrQuery" aria-label="Next">
			                                                <i class="fas fa-search-dollar"></i><i class="ti-angle-double-down"></i>
			                                            </a>
			                                        </li>
			                                        <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_squares&orderType=asc&action=listHouse_AllOrQuery" aria-label="Previous">
			                                                <i class="fas fa-home"></i><i class="ti-angle-double-up"></i>
			                                            </a>
			                                        </li>
			                                         <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_squares&orderType=desc&action=listHouse_AllOrQuery" aria-label="Next">
			                                                <i class="fas fa-home"></i><i class="ti-angle-double-down"></i>
			                                            </a>
			                                        </li>
			                                          <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_state&orderType=asc&action=listHouse_AllOrQuery" aria-label="Previous">
			                                                <i class="fas fa-clock"></i><i class="ti-angle-double-up"></i>
			                                            </a>
			                                        </li>
			                                         <li class="page-item">
			                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?orderCol=hos_state&orderType=desc&action=listHouse_AllOrQuery" aria-label="Next">
			                                                <i class="fas fa-clock"></i><i class="ti-angle-double-down"></i>
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
                    <div class="row align-items-center latest_product_inner">
                        <c:forEach var="houseVO" items="${listHouse_AllOrQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="counter">
                            <div class="col-lg-4 col-sm-6">
	                            <div class="single_product_item">
	<!--                                 	<div class="box1"> -->
											<a href="<%=request.getContextPath()%>/house/house.do?houseno=${houseVO.hos_no}&action=listHouPho_ByHouseA">
											<img src="<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno=${houseVO.hos_no}" >
											</a>
	<!-- 									</div> -->
								<div class="single_product_text">
	                                 <h5>物件名稱</h5>
	                                 <h5>$${houseVO.hos_rent}.00 | <c:choose>
										<c:when test="${houseVO.hos_type==0}">不限 </c:when>
										<c:when test="${houseVO.hos_type==1}">獨立套房  </c:when>
										<c:when test="${houseVO.hos_type==2}">分租套房</c:when>
										<c:when test="${houseVO.hos_type==3}">雅房</c:when>
										<c:when test="${houseVO.hos_type==4}">整層住家 </c:when>
										<c:when test="${houseVO.hos_type==5}">車位 </c:when>
										<c:when test="${houseVO.hos_type==6}">其他 </c:when>
										</c:choose> | ${houseVO.hos_squares}</h5>
	                                    <h5>${houseVO.hos_address}</h5>
	                                    <h5>$150.00</h5>
	                                    <a href="#" class="add_cart">加入收藏<i class="ti-heart"></i></a>
	                                </div>
	                            </div>
                            </div>
                   		</c:forEach>
                   </div>
                   
                   
                   
                   
                   
                   
                        
                       
                        <div class="col-lg-12">
                            <div class="pageination">
                                <nav aria-label="Page navigation example">
                                    <ul id="page" class="pagination justify-content-center">
                                   		 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/house/house.do?whichPage=1&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery">第一頁</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="<%=request.getContextPath()%>/house/house.do?whichPage=${(param.whichPage==0)||(param.whichPage-1)==0?'1':param.whichPage-1}&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery" aria-label="Previous">
                                                <i class="ti-angle-double-left"></i>
                                            </a>
                                        </li>
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
	
	<script>
		$(document).ready(function(){
			let enterPage = ${empty param.whichPage?'1':param.whichPage};
			let totalPage = <%=pageNumber %>;
			for(let j = 1;j<6;j++){
				if((enterPage)>totalPage){
					break;
				}
				$("#page li.page-item").eq(j).after("<li class='page-item'><a class='page-link' href='<%=request.getContextPath()%>/house/house.do?whichPage="+enterPage+"&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery'>"+enterPage+"</a></li>");
				enterPage++;
				
			}
			
		})
	</script>

	
	
<%@ include file="/front-end/footer.file"%>
</body>
</html>
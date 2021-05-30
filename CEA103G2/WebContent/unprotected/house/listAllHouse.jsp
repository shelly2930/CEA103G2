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
<title>�s���Ҧ�����</title>
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!-- =========icon fontawesome -->
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<!-- ========= -->


<style>

/* ���� */
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
/* ���� */



.breadcrumb_bg {
    background-image:url('<%=request.getContextPath()%>/index_img/08.jpg') !important;
    background-position: center;
    background-repeat: no-repeat  !important;
    background-size: cover;
}
 
</style>

</head>
<body>

<!-- =================================�W���O�����C==================================================== -->

<%@include file="/front-end/header.file"%>	
<!-- ==================================�U���O�j�MBAR=============================================	 -->

<div id="bs-canvas-right" class="bs-canvas bs-canvas-right position-fixed bg-light h-100">
	<header class="bs-canvas-header p-3 bg-info overflow-auto" style='opacity:0.5;'>
    	<button type="button" class="bs-canvas-close float-left close" aria-label="Close" aria-expanded="false"><span aria-hidden="true" class="text-light">&times;</span></button>
        <h4 class="d-inline-block text-light mb-0 float-right font-weight-bolder" >�ڪ�����</h4>
    </header>
    <div class="bs-canvas-content px-3 py-3" id='showcol'>
<!--     ���ð� -->
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
								<input style='width:80%' type="text" class="form-control" placeholder="�п�J����r">
								<button type="submit" id='key' style='background-color:#EBEBFF;font-weight:bold' class="btn btn-default">����r�j�M</button>
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
 <!--                   �j�M�C -->      
         

                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3 style='color:#009E9E;font-weight:bold'>����</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=��">��</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=�O�_">�O�_</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=�s�_">�s�_</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=���">���</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=�s��">�s��</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=�]��">�]��</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=�x��">�x��</a>
                                        <span>(250)</span>
                                    </li>
                                    <li>
                                        <a class='num' href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=���L">���L</a>
                                        <span>(250)</span>
                                    </li>
                                </ul>
                            </div>
                        </aside>
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3 style='color:#009E9E;font-weight:bold'>����</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">����</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=1&action=listHouse_AllOrQuery">�W�߮M��</a>
                                    </li>
                                    <li class="active">
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=2&action=listHouse_AllOrQuery">�����M��</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=3&action=listHouse_AllOrQuery">����</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=4&action=listHouse_AllOrQuery">��h��a</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=5&action=listHouse_AllOrQuery">����</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?hos_type=6&action=listHouse_AllOrQuery">��L</a>
                                    </li>
                                </ul>
                            </div>
                        </aside>
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3 style='color:#009E9E;font-weight:bold'>�W��</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">����</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=1&action=listHouse_AllOrQuery">10�W�H�U</a>
                                    </li>
                                    <li class="active">
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=2&action=listHouse_AllOrQuery">10�W-20�W</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=3&action=listHouse_AllOrQuery">20�W-30�W</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=4&action=listHouse_AllOrQuery">30�W-40�W</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=5&action=listHouse_AllOrQuery">40�W-50�W</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?area=6&action=listHouse_AllOrQuery">50�W�H�W</a>
                                    </li>
                                </ul>
                            </div>
                        </aside>
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3 style='color:#009E9E;font-weight:bold'>����</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?price=0&action=listHouse_AllOrQuery">����</a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/house/house.do?price=1&action=listHouse_AllOrQuery">5000�H�U</a>
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
                                        <a href="<%=request.getContextPath()%>/house/house.do?price=6&action=listHouse_AllOrQuery">40000�H�W</a>
                                    </li>
                                </ul>
                                
                            </div>
                        </aside>
                    </div>
                </div>
 <!--           �j�M�C -->
<!--  **********�������*********************************************** -->
                <div class="col-lg-9">
                    <div class="row">
                    <div class="col-12" style="margin-bottom:5px">
			     		<a  class="genric-btn primary-border small" href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">�M���d��</a>
			     		
			     		<c:if test="${!empty map.hos_city[0]}">
			     			<a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">
			     			<button type="button" class="genric-btn success-border small">
			     			����:${map.hos_city[0]} x
			     			</button>
			     			</a>
			     		</c:if>
			     		
			     		<c:if test="${!empty map.hos_dist[0]}">
			     			<a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">
			     			<button type="button" class="genric-btn success-border small">
			     			�m��:${map.hos_dist[0]} x
			     			</button>
			     			</a>
			     		</c:if> 
			     		 
			     		<c:if test="${!empty map.keyword[0]}">
			     			<a href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">
			     			<button type="button" class="genric-btn success-border small">
			     			����r:${map.keyword[0]} x
			     			</button>
			     			</a>
			     		</c:if> 
			     		
			     		<c:choose>
						<c:when test="${map.price[0]==0}">
						</c:when>
						<c:when test="${map.price[0]==1}">
							<a href="<%=request.getContextPath()%>/house/house.do?price=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								5000�H�U  x
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
								40000�H�W x
								</button>
							</a>
						</c:when>
						</c:choose>
						
			     		<c:choose>
						<c:when test="${map.area[0]==0}"></c:when>
						<c:when test="${map.area[0]==1}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								10�W�H�U  x
								</button>
							</a>
						</c:when>
						<c:when test="${map.area[0]==2}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								10-20�W x
								</button>
							</a>
						</c:when>
						<c:when test="${map.area[0]==3}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								20-30�W x
								</button>
							</a>
						</c:when>
						<c:when test="${map.area[0]==4}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								30-40�W x
								</button>
							</a>
						</c:when>
						<c:when test="${map.area[0]==5}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								40-50�W x
								</button>
							</a>
						</c:when>
						<c:when test="${map.area[0]==6}">
							<a href="<%=request.getContextPath()%>/house/house.do?area=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								50�W�H�W x
								</button>
							</a>
						</c:when>
						</c:choose> 
			     	
			     		<c:choose>
						<c:when test="${map.hos_type[0]==0}"></c:when>
						<c:when test="${map.hos_type[0]==1}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								�W�߮M��  x
								</button>
							</a>
						</c:when>
						<c:when test="${map.hos_type[0]==2}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								�����M�� x
								</button>
							</a>
						</c:when>
						<c:when test="${map.hos_type[0]==3}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								���� x
								</button>
							</a>
						</c:when>
						<c:when test="${map.hos_type[0]==4}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								��h��a x 
								</button>
							</a>
						</c:when>
						<c:when test="${map.hos_type[0]==5}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								���� x 
								</button>
							</a>
						</c:when>
						<c:when test="${map.hos_type[0]==6}">
							<a href="<%=request.getContextPath()%>/house/house.do?hos_type=0&action=listHouse_AllOrQuery">
								<button type="button" class="genric-btn success-border small">
								��L x
								</button>
							</a>
						 </c:when>
						</c:choose> 
			     	</div>
<!--  **************�H�W�����j�M*********************************************** -->
                    
                    
                    
 <!--  **************�H�W�����j�M*********************************************** -->                  
                        <div class="col-lg-12">
<!--                    �Ȯ� -->
                        <%@ include file="pages/page1_ByCompositeQuery.file"%>
                            <div class="product_top_bar d-flex justify-content-between align-items-center">
                                <div class="single_product_menu">
                                    <p style='color:#969696;font-size:18px'>�@<span> <%=listSize%> </span> ���ŦX�j�M���G������</p>
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
<!--   <==================���e                  -->
<!-- 					//���~ -->
               		<div id='zerotext' style='padding:100px;display:none;margin:auto;' ><h3 style='color:#BABABA;margin:auto;'>�d�L�j�M���G</h3></div>
					<!--                     	���� -->
					<a class="ml-3 order-xl-last btn btn-info" style='opacity:0.5;' id="collection" data-toggle="canvas" href="#bs-canvas-right" aria-expanded="false" aria-controls="bs-canvas-right" role="button"><i class="fas fa-home" ><br><hr>����</i></a>
					<a class="ml-3 order-xl-last btn btn-primary" style='opacity:0.5;' id="mapsearch"  href="" ><i class="fas fa-map-marker-alt"><br><hr>�a��<br>���</i></a>
                    <!--                     	�H�W���� -->
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
										<c:when test="${houseVO.hos_type==0}">���� </c:when>
										<c:when test="${houseVO.hos_type==1}">�W�߮M��  </c:when>
										<c:when test="${houseVO.hos_type==2}">�����M��</c:when>
										<c:when test="${houseVO.hos_type==3}">����</c:when>
										<c:when test="${houseVO.hos_type==4}">��h��a </c:when>
										<c:when test="${houseVO.hos_type==5}">���� </c:when>
										<c:when test="${houseVO.hos_type==6}">��L </c:when>
										</c:choose> | ${houseVO.hos_squares}�W</h5>
	                                    <h5>${houseVO.hos_address}</h5>
	                                    <a href="" id='${houseVO.hos_no}' class="add">�[�J����<i class="far fa-heart" style='color:#FF9696;font-size:23px'></i></a>
	                                </div>
	                            </div>
                            </div>
                   		</c:forEach>
                   </div>
                   
                   
                   
                   
                   
                   
                        
                       
                        <div class="col-lg-12">
                            <div id='zerosearch' class="pageination">
                                <nav aria-label="Page navigation example">
                                    <ul id="page" class="pagination justify-content-center">
                                   		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/house/house.do?whichPage=1&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery">�Ĥ@��</a></li>
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
                                        <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/house/house.do?whichPage=<%=pageNumber %>&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery">�̫�@��</a></li>
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
					  title: '�п�J����r',
				})
			}
		})
	
	
	
		let dist0 =['���s��','������','�H�q��','���R��','�x�x��','�w�ְ�','�C����'];
		let dist1 =['�_���' , '�h�L��', '�����' , '�Q�s��' , '���s��' , '�j�P��' , '�n���' ,'�H�q��' , '�j�w��' ,'������' , '�U�ذ�' , '��s��'];
		let dist2 =['�O����','�T����','���M��','�éM��','�s����','�s����','�g����','Ī�w��','��L��','�����','�a�q��','�T�l��','�H����','��ڰ�','���Ѱ�','���s��','�L�f��','�`�|��','�����','�W�L��','�T�۰�','�۪���','�K����','���˰�','���˰�','�^�d��','���s��','�U����','�Q�Ӱ�'];
		let dist3 =['���c��','�����','�s���','������','�s�ΰ�','�[����','����','�t�s��','�K�w��','�j�˰�','�_����','�j���','Ī�˰�'];
		let dist4 =['�s�˥�','�F��','�_��','���s��'];
		let dist5 =['�]�ߥ�','�b����','�q�]��','�˫n��','�Y����','���s��','������','�j��m','���]�m','���r�m','�n�ܶm','�Y�ζm','�T�q�m','���m','�y���m','�T�W�m','���m','���w�m'];
 		let dist6 =['����','�F��','���','�n��','�_��','��ٰ�','�n�ٰ�','�_�ٰ�','�׭��','�j����','�ӥ���','�M����','�F����','�j�Ұ�','�F�հ�','��ϰ�','�Q���','������','�j�{��','�j����','�Z����','���p��','��l��','�s����','�~�H��','�M����','�۩���','�j�w��','�s����'];
		let dist7 =['���d�m','�[�I�m','�G�[�m','������','�l��m','�L���m','�O��m','�F�նm','�ǩ��m','�����m','�g�w��','�j��m','�����','�椻��','��n��','�j�|�m','�|��m','�f��m','���L�m','�_����'];
 		$(".num").eq(0).click(function(e){
			e.preventDefault();
			$(".hide").each(function(index){
				$(this).remove();
			})
			let str ="";
			for(let dist of dist0){
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=��&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
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
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=�O�_&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
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
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=�s�_&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
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
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=���&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
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
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=�s��&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
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
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=�]��&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
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
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=�x��&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
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
				str+="<li class=\'hide\'><a style=\'color:#828282\' href='<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&hos_city=���L&hos_dist="+dist+"'>&nbsp;&nbsp;&nbsp;"+dist+"</li>";
			}
			$(this).parents('li').after(str);
			$(".hide").hide();
			$(".hide").slideDown(1000);
		})
		getNum('���c')
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
	
	
	
	
	
	
	//���o�|��
			let mem_no = ${empty MemTenVO.mem_no ?"null":MemTenVO.mem_no};
			
			//����
			let enterPage = ${empty param.whichPage?'1':param.whichPage};
			let totalPage = <%=pageNumber %>;
			if(totalPage==0){
				$("#zerosearch").hide();
				$("#zerotext").show();
			}
			$("#thispage").html("<a class='page-link' href='<%=request.getContextPath()%>/house/house.do?whichPage="+enterPage+"&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery'>"+enterPage+"</a>");
			//����
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
			//�|������ �浧�s�W�ק�
			if(mem_no===null){
				colarray = new Set();
			}else{
				colarray = getCol(mem_no);
			}
			
			$('.add').click(function(e){
				e.preventDefault();
				if(mem_no==null){
					Swal.fire({
						  title: '�Х��n�J�|��',
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
								console.log("��������");
								colarray=getCol(mem_no);
								reset(colarray);
							}
						})
						//��������
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
								console.log('�s�W���\');
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
							str+="<h6 class='card-text text-secondary '>���D: "+jsonStr.hos_name+"</h6>";
							str+="</div>";
							str+="<div class='list-group mb-5'>";
							str+="<a href='<%=request.getContextPath()%>/house/house.do?houseno="+jsonStr.hos_no+"&action=listHouPho_ByHouseA'>"
							str+="<img src='<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno="+jsonStr.hos_no+"' class='card-img-top' alt='���÷Ӥ�'>";
							str+="</a>";
							str+="<div class='card-body'>";
							
							str+="<p class='card-text text-secondary'>����: "+jsonStr.hos_rent+"</p>";
							str+="<p class='card-text text-secondary'>�a�}: "+jsonStr.hos_address+"</p>";
							str+="<p class='card-text showtext text-secondary' id='text"+jsonStr.hos_no+"' >�Ƶ�: �|����g</p>";
							str+="</div></div>";
							str+="<div class='card-footer' id='"+jsonStr.hos_no+"'>";
							str+="<a href=''class='cancelcol' style='display:inline-block' ><h5><i class='fas fa-window-close text-info'>��������</i></h5></a>";
							str+="<a href=''class='addcoltext' style='display:inline-block' id='add"+jsonStr.hos_no+"'><h5>&nbsp; &nbsp; &nbsp; <i class='fas fa-edit text-warning'>�W�[�Ƶ�</i></h5></a>";
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
										$("#text"+col_no).html("�Ƶ�: "+str.hos_col_note);
									}
								}
							})
							$("#add"+jsonStr.hos_no).click(function(e){
								addcol_hos = $(this).parent().attr('id');
// 								�s�W�Ƶ�
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
							console.log("��������");
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
							  title: '�Х��n�J�|��',
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
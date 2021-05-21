<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furPho.model.*"%>
<%
FurIteVO furIteVO = (FurIteVO) request.getAttribute("furIteVO"); 
%>    

<!DOCTYPE html>
<html>
<head>
<title>家具介紹</title>
<!-- =================套用bootstrap要使用以下=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<style>

.breadcrumb_bg {
    background-image: url(<%=request.getContextPath()%>/unprotected/furniture/images/Morandi2.jpg)!important;
    background-position: bottom -300px right 0px!important;
    background-repeat: no-repeat;
    background-size: cover;
}
</style>
</head>
<body>
<!-- include導覽列 -->
<%-- <%@include file="/front-end/header.file"%>	 --%>
<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

<body onload="connect();connectNotice();" onunload="disconnect();disconnectNotice();">
<!-- 導覽列下圖片 -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Welcome  好厝家具專區</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
 <!--================End Home Banner Area =================-->

<!--↓↓↓↓ 導覽列內容 測試完後刪除 改header檔 ↓↓↓↓-->
<%-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%> --%>
<%@ page import="com.rentCart.model.RentCartItem"%>

<%
	List<RentCartItem> rentCartList = (Vector<RentCartItem>) session.getAttribute("rentCartList");
	int	rentCartListSize=0;
	if (rentCartList!=null){
	 	rentCartListSize = rentCartList.size();
	}
	pageContext.setAttribute("rentCartListSize", rentCartListSize);
%>

<head>
<style>
/*CART CSS*/
.cartQuantity{
  color:red;
  position:absolute;
  width: 15px;
  height: 15px;
  border-radius:50%;
  display: flex;
  justify-content: center;
  align-items: center;
  right:-13px;
  top:-8px;
}
/*CART CSS*/
</style>
</head>
<!-- Required meta tags -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- web icon -->
	<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.png">

<!-- Required CSS start -->	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/bootstrap.min.css">
	<!-- animate CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/animate.css">
	<!-- owl carousel CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/owl.carousel.min.css">
	<!-- font awesome CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/all.css">
	<!-- flaticon CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/flaticon.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/themify-icons.css">
	<!-- font awesome CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/magnific-popup.css">
	<!-- swiper CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/slick.css">
	<!-- style CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/style.css">

	<!-- added CSS 以下放我們新增的 -->
	<!-- overrided CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/headerCSS.css">
	<!-- product page CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/lightslider.min.css">
<!-- Required CSS end -->

<!--::header part start::-->
	<header class="main_menu home_menu">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-12">
					<nav class="navbar navbar-expand-lg navbar-light">
						<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
							<img src="<%=request.getContextPath()%>/images/logo.png"></a>
						<button class="navbar-toggler" type="button"
							data-toggle="collapse" data-target="#navbarSupportedContent"
							aria-controls="navbarSupportedContent" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class="menu_icon"><i class="fas fa-bars"></i></span>
						</button>

						<div class="collapse navbar-collapse main-menu-item"
							id="navbarSupportedContent">
							<ul class="navbar-nav">
								<li class="nav-item">
									<a class="nav-link" 
										href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">租屋</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" 
										href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte&requestURL=<%=request.getServletPath()%>">租家具</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" 
										href="<%=request.getContextPath()%>/front-end/lanlord/addLanlord.jsp">成為房東</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" 
										href="<%=request.getContextPath()%>/front-end/house/addHouse.jsp">申請代管</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" 
										href="<%=request.getContextPath()%>/post/post.do?action=listAllFront&status=0">公告</a>
								</li>
								<li class="nav-item">
									<a class="nav-link"
										href="<%=request.getContextPath()%>/back-end/indexBack.jsp">後%台</a>
								</li>
							</ul>
						</div>
						
						<div class="hearer_icon d-flex">
							 <div class="nav-item dropdown no-arrow">
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown3"
									role="button" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false">
									<span class="mr-2 d-none d-lg-inline text-gray-600 small">${empty MemTenVO.mem_name ? "你沒登入咧":MemTenVO.mem_name}</span>
									<i class="fas fa-user-circle"></i>
								</a>
							
					<!--以下是移到頭像會出現的選單-->	
							<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="<%=request.getContextPath()%>/front-end/memberBlank.jsp">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>會員專區
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                ${not empty MemTenVO ? "<a class='dropdown-item' href='"+=pageContext.request.contextPath+="/memTen/memTen.do?action=logout'>
                                	<i class='fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400'></i>登  出</a>"
                                	:"<a class='dropdown-item' href='"+=pageContext.request.contextPath+="/unprotected/memTen/login.jsp'>
                                	<i class='fas fa-sign-in-alt fa-sm fa-fw mr-2 text-gray-400'></i>登入</a>"}
                                
                                
                                	
                            </div>
					<!--以上是移到頭像會出現的選單-->	
						</div>
						
<!-- 			↓↓↓ 	購物車圖式區域開始 ↓↓↓ -->
									<a class="nav-link" 
										href="<%=request.getContextPath()%>/front-end/furIte/rentCart.jsp"><i class="fas fa-shopping-cart fa-3x"><span class="cartQuantity text-white bg-warning">${rentCartListSize}</span></i></a>
<!-- 						原購物車程式碼 -->
<!-- 							<div class="dropdown cart"> -->
<%-- 								<a class="nav-link dropdown-toggle" href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery"  id="navbarDropdown3" --%>
<!-- 									role="button" data-toggle="dropdown" aria-haspopup="true" -->
<!-- 									aria-expanded="false"> <i class="fas fa-cart-plus"></i> -->
<!-- 								</a> -->
								<!--<div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <div class="single_product"></div>
                                </div>-->
<!-- 						原購物車程式碼 -->
							</div>
<!-- 			↑↑	↑		購物車圖式區域結束 ↑↑↑-->							
							
							<a class="nav-link" href=""><i class="fas fa-bell"></i></a>
						</div>
					</nav>
				</div>
			</div>
		</div>
		<!-- <div class="search_input" id="search_input_box">
            <div class="container ">
                <form class="d-flex justify-content-between search-inner">
                    <input type="text" class="form-control" id="search_input" placeholder="Search Here">
                    <button type="submit" class="btn"></button>
                    <span class="ti-close" id="close_search" title="Close Search"></span>
                </form>
            </div>
        </div> -->
	</header>
<!-- Header part end-->
<!--↑↑↑  導覽列內容結束 (測試完後待刪 改header檔) ↑↑↑ -->

  <!--================Single Product Area =================-->
  <div class="product_image_area section_padding">
    <div class="container">
      <div class="row s_product_inner justify-content-between">
        <div class="col-lg-7 col-xl-7">
          <div class="product_slider_img">
            <div id="vertical">
<!--              照片循環區塊 ↓↓↓-->
		<c:forEach var="furPhoVO" items="${furPhoList}">
              <div data-thumb="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}">
                <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}" />
              </div>
        </c:forEach>      
<!--              照片循環區塊 ↑↑↑-->
<!--              對照用待刪 ↓↓↓-->
<!--               <div data-thumb="img/product/single-product/product_1.png"> -->
<!--                 <img src="img/product/single-product/product_1.png" /> -->
<!--               </div> -->

            </div>
          </div>
        </div>
        <div class="col-lg-5 col-xl-4">
          <div class="s_product_text">
<!-- 			前一筆 下一筆連結 或其他介紹 -->
<!--             <h5>previous <span>|</span> next</h5> -->
<!--             家具名 -->
            <h3 id="fntName" >${furIteVO.fnt_name}</h3>
<!--             租金 -->
            <h2>$<span id="fntPrice">${furIteVO.fnt_price}</span> /月</h2>
            <ul class="list">
              <li>
                
<!--             分類或規格 -->
                  <span>規格</span> : ${furIteVO.fnt_standard}</a>
              </li>
              <li>
<!--               庫存 -->
                   <span>庫存</span> : <c:choose>
					<c:when test="${furIteVO.fnt_unrent>0}">有</c:when>	
					<c:when test="${furIteVO.fnt_unrent<=0}">無</c:when>			
					</c:choose>
              </li>
                          <li>
<!--               瀏覽次數 -->
                 <span>瀏覽次數</span> : ${furIteVO.fnt_views} 次
              </li>
            </ul>

<!--             簡介 -->            
<!-- 			<p> -->
<!--               First replenish living. Creepeth image image. Creeping can't, won't called. -->
<!--               Two fruitful let days signs sea together all land fly subdue -->
<!--             </p> -->
  				<div class="card_area d-flex justify-content-between align-items-center">
<!--               加入購物車 -->
<!-- 庫存大於0時 -->
	<c:if test="${furIteVO.fnt_unrent>0}">	
            <!--              數量+-鈕 -->
          
              <div class="product_count">
                <span class="number-decrement"> <i class="ti-minus"></i></span>
                <input class="input-number" type="text" value="1" min="1" max="${furIteVO.fnt_unrent}">
                <span class="number-increment"> <i class="ti-plus"></i></span>
              </div>
              <a class="btn_3" id="${furIteVO.fnt_it_no}" style="cursor:pointer; color:white;" >加入租借</a>
<!--               收藏 -->
              <a href="#" class="like_us"> <i class="ti-heart"></i> </a>
	</c:if>
<!-- 庫存為0時 -->
	<c:if test="${furIteVO.fnt_unrent==0}">	
              <a class="btn_1 checkout_btn_1" href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte">繼續瀏覽家具</a>
<!--               收藏 -->
              <a href="#" class="like_us"> <i class="ti-heart"></i> </a>
              </div>
	</c:if>

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--================End Single Product Area =================-->

  <!--================家具介紹=================-->
  <section class="product_description_area">
    <div class="container">
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <!--         <測試 評論 待換> -->
        <li class="nav-item">
                    <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">家具特色</a>
                </li>
        <li class="nav-item">
          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
            aria-selected="false">家具規格</a>
        </li>

      </ul>
<!-- 以下接介紹及規格說明 -->
      <div class="tab-content" id="myTabContent">
                       <!-- 介紹欄開始 -->
                    <div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">
                    <p>
                    ${furIteVO.fnt_info}
                    </p>
                </div>
                      <!-- 介紹欄結束 -->
                <!-- 規格欄開始 -->
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                    <div class="table-responsive">
                        <table class="table">
                            <tbody>
  								<tr>
                                    <td>
                                        <h5>規格</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_standard}</h5>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td>
                                        <h5>長度</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_length} 公分</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>寬度</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_width} 公分</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>高度</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_height} 公分</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>重量</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_weight} 公斤</h5>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- 規格欄結束 -->
             
                <!-- 以下留 -->
            </div>
        </div>
    </section>
  <!--================End Product Description Area =================-->



<!-- JS ajax -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript">
// inumber-decrement inumber-increment input-number
$(".number-increment").click(function(e){
	let number=$(".input-number").val();
	let max=$(".input-number").attr("max");
	if(number==max){
		Swal.fire("很抱歉!<br>目前最多僅能提供"+ max+"個租用!");
	}
});
$(".btn_3").click(function(e){
	e.preventDefault();
	
	$.ajax({
		type:"POST",
		url:"<%=request.getContextPath()%>/rentCart/rentCart.do",
		data:{
			"action":"ADD",
        	"fnt_it_no":$(this).attr('id'),
        	"fnt_price":$("#fntPrice").html(),
			"fnt_name":$("#fntName").html(),
			"quantity":$("input[type='text']").val(),
		},
		success:function(data){
			$(".cartQuantity").html(data);
			Swal.fire({
				 position:'center',	 
  				  icon:'success',
  			      title:'已加入租借!',
  			      showConfirmButton:false,
  			      timer:1000});
		}
	});
});

</script>
<%@ include file="/front-end/footer.file"%>
</body>
</html>
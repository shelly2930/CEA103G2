<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="BIG5"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*"%>
	<% 	  
		List<FurIteVO> list =new ArrayList<FurIteVO>();
			FurIteService furIteSvc = new FurIteService();
		    list= furIteSvc.getAllGetOnFurIte();
		    pageContext.setAttribute("list",list);	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>index</title>

<style type="text/css">

.subscribe_area {
    background-image: url(/CEA103G2/index_img/danger.jpg) !important;
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}

.section_padding {
    padding: 160px 0px 220px 0px !important;
}

/* .section_padding.fur { */
/* 	padding: 0px 0px 0px 0px !important; */
/* } */

/*�j�M�C*/
.subscribe_area .input-group .input-group-text {
    height: 60px;
    width: auto;
    line-height: 60px;
    padding: 0px 45px;
    border: 0px solid transparent;
    background-color: #ff3368;
    color: #fff;
    text-transform: uppercase;
    border-radius: 5px;
    margin-left: 10px;
}

.btn_2 {
	box-shadow: -1.717px 8.835px 29.76px 2.24px rgb(97 210 180 / 18%) !important;
}

/* content CSS start */
.subscribe_area div.container {
	padding: 100px 0;
}
/* content CSS end */

</style>

</head>
<body>
<%@include file="/front-end/header.file"%>

	<!-- subscribe_area part start-->
	<section class="subscribe_area section_padding">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-7">
					<div class="subscribe_area_text text-center">
						<!-- <h5>Find Our Newsletter</h5>
                        <h2>Subscribe to get Updated
                            with new offers</h2> -->
						<div class="input-group">
								<input type="text" id='searchhouse' class="form-control" placeholder="��������r�j�M"
									aria-label="Recipient's username"
									aria-describedby="basic-addon2">
								<div class="input-group-append">
									<a href="#" class="input-group-text btn_2" id="basic-addon2">search</a>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--::subscribe_area part end::-->


	<!-- product_list part start-->
	<section class="product_list best_seller " style='padding-top:50px !important;'>
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-12">
					<div class="section_tittle text-center">
						<h2>��磌��</h2>
					</div>
				</div>
			</div>
			<div class="row align-items-center justify-content-between">
				<div class="col-lg-12" id='showhouse'>
				</div>
			</div>
		</div>
	</section>
	<!-- product_list part end-->


	<!-- product_list2 part start-->
	<section class="product_list best_seller  fur" style='padding:0px auto !important;'>
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-12">
					<div class="section_tittle text-center">
						<h2>���a��</h2>
					</div>
				</div>
			</div>
			<div class="row align-items-center justify-content-between">
				<div class="col-lg-12">
					<div class="best_product_slider owl-carousel">
					<jsp:useBean id="furPhoSvc" scope="page" class="com.furPho.model.FurPhoService" />
					<c:forEach var="furIteVO" items="${list}">
						<div class="single_product_item">
							<a href="<%=request.getContextPath()%>/furIte/furIte.do?fnt_it_no=${furIteVO.fnt_it_no}&action=getOneFurIteToFE" >
                                <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFirstFnt_pic_no(furIteVO.fnt_it_no)}"  width="157" height="200">
                              </a>
							<div class="single_product_text">
								<h4 id="${furIteVO.fnt_name}">${furIteVO.fnt_name}</h4>
									<h3 id="${furIteVO.fnt_price}">$${furIteVO.fnt_price} /��</h3>
							</div>
						</div>
					</c:forEach>
<!--   ������		���զ��\��R��	����			 -->
<!-- 						<div class="single_product_item"> -->
<%-- 							<img src="<%=request.getContextPath()%>/images/product/product_5.png" alt=""> --%>
<!-- 							<div class="single_product_text"> -->
<!-- 								<h4>Quartz Belt Watch</h4> -->
<!-- 								<h3>$150.00</h3> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!--  ������	 ���զ��\��R��	����			 -->
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- product_list2 part end-->

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�b�ۤv�������[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->
	<script>
		$("#basic-addon2").click(function(){
			let word = $("#searchhouse").val();
			$(location).attr('href',"<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery&keyword="+word);
		})
		$.ajax({
			url:"<%=request.getContextPath()%>/HouseJsonServlet",
			type:'post',
			data:{
				action:'getAllHouseOnLine',
			},
			success:function(list){
				let str ="<div class='best_product_slider owl-carousel'>"
				for(house of list){
					str += "<div class='single_product_item'>";
					str+="<img style='weight:150px' src='<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno="+house.hos_no+"'>";
					str+="<div class='single_product_text'>";
					str+="<h4>"+house.hos_name+"</h4>";
					str+="<h3><span>$"+house.hos_rent+"</span></h3>";
					str+="<h3><span>"+house.hos_squares+"�W</span></h3>";
					str+="<h3><span>"+house.hos_address+"</span></h3>";
					str+="</div></div>";
				}
				str+="</div>";
				$("#showhouse").append(str);
				
				
				$(".owl-carousel").owlCarousel({
					  loop: true, // �`������
					  margin: 20, // �~�Z 10px
					  autoplay:true,
					  autoplayTimeout:1500,
					  autoplayHoverPause:true,
					  responsive: {
					    0: {
					      items: 1 // �ù��j�p�� 0~600 ��� 1 �Ӷ���
					    },
					    600: {
					      items: 3 // �ù��j�p�� 600~1000 ��� 3 �Ӷ���
					    },
					    1000: {
					      items: 5 // �ù��j�p�� 1000 �H�W ��� 5 �Ӷ���
					    }
					  }
				});
				$(".owl-theme .item").css({
					'height': '10rem',
					'background': '#4dc7a0',
					'padding': '1rem'
				})
				$(".owl-carousel .item h4").css({
					'color': '10rem',
					'font-weight': '400',
					'marginTop': '0rem'
				})
				$(".owl-prev").each(function(){
					$(this).text("prev");
					$(this).css('font-size','22px');
				});
				$(".owl-next").each(function(){
					$(this).text("next");
					$(this).css('font-size','22px');
				});
				
			}
		})
			
	
	</script>
<!-- �n��b�̤U�� -->
<%@include file="/front-end/footer.file"%>
	

</body>
</html>
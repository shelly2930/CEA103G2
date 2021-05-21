<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>index</title>

<style type="text/css">

.subscribe_area {
    background-image: url(/CEA103G2/index_img/city.jpg) !important;
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}

.section_padding {
    padding: 200px 0px !important;
}
/*搜尋列*/
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
							<input type="text" class="form-control" placeholder="請輸入文字"
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
	<section class="product_list best_seller section_padding">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-12">
					<div class="section_tittle text-center">
						<h2>精選物件</h2>
					</div>
				</div>
			</div>
			<div class="row align-items-center justify-content-between">
				<div class="col-lg-12">
					<div class="best_product_slider owl-carousel">
						<div class="single_product_item">
							<img src="<%=request.getContextPath()%>/images/product/product_1.png" alt="">
							<div class="single_product_text">
								<h4>Quartz Belt Watch</h4>
								<h3>$150.00</h3>
							</div>
						</div>
						<div class="single_product_item">
							<img src="<%=request.getContextPath()%>/images/product/product_2.png" alt="">
							<div class="single_product_text">
								<h4>Quartz Belt Watch</h4>
								<h3>$150.00</h3>
							</div>
						</div>
						<div class="single_product_item">
							<img src="<%=request.getContextPath()%>/images/product/product_3.png" alt="">
							<div class="single_product_text">
								<h4>Quartz Belt Watch</h4>
								<h3>$150.00</h3>
							</div>
						</div>
						<div class="single_product_item">
							<img src="<%=request.getContextPath()%>/images/product/product_4.png" alt="">
							<div class="single_product_text">
								<h4>Quartz Belt Watch</h4>
								<h3>$150.00</h3>
							</div>
						</div>
						<div class="single_product_item">
							<img src="<%=request.getContextPath()%>/images/product/product_5.png" alt="">
							<div class="single_product_text">
								<h4>Quartz Belt Watch</h4>
								<h3>$150.00</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- product_list part end-->


	<!-- product_list2 part start-->
	<section class="product_list best_seller section_padding">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-12">
					<div class="section_tittle text-center">
						<h2>精選家具</h2>
					</div>
				</div>
			</div>
			<div class="row align-items-center justify-content-between">
				<div class="col-lg-12">
					<div class="best_product_slider owl-carousel">
						<div class="single_product_item">
							<img src="<%=request.getContextPath()%>/images/product/product_1.png" alt="">
							<div class="single_product_text">
								<h4>Quartz Belt Watch</h4>
								<h3>$150.00</h3>
							</div>
						</div>
						<div class="single_product_item">
							<img src="<%=request.getContextPath()%>/images/product/product_2.png" alt="">
							<div class="single_product_text">
								<h4>Quartz Belt Watch</h4>
								<h3>$150.00</h3>
							</div>
						</div>
						<div class="single_product_item">
							<img src="<%=request.getContextPath()%>/images/product/product_3.png" alt="">
							<div class="single_product_text">
								<h4>Quartz Belt Watch</h4>
								<h3>$150.00</h3>
							</div>
						</div>
						<div class="single_product_item">
							<img src="<%=request.getContextPath()%>/images/product/product_4.png" alt="">
							<div class="single_product_text">
								<h4>Quartz Belt Watch</h4>
								<h3>$150.00</h3>
							</div>
						</div>
						<div class="single_product_item">
							<img src="<%=request.getContextPath()%>/images/product/product_5.png" alt="">
							<div class="single_product_text">
								<h4>Quartz Belt Watch</h4>
								<h3>$150.00</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- product_list2 part end-->

<!-- Required source start -->
	<!-- jquery 這行有需要的人在自己的頁面加 -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<!-- 要放在最下面 -->
<%@include file="/front-end/footer.file"%>


</body>
</html>
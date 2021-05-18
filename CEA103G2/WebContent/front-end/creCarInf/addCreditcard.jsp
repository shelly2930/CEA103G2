<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>



<title>新增信用卡</title>

<style>
body { 
/* background-color: #dddddd !important; */
}

.genric-btn.success {
    color: #fff;
    background: #ccb78f !important;
    border: 1px solid transparent;
}

.genric-btn.success:hover {
    color: black !important;
    border: 1px solid #ccb78f !important;
    background: #fff;
}



</style>

</head>
<body>

<%@include file="/front-end/header.file"%>

<!--================End Category Product Area =================-->
<section class="cat_product_area section_padding">
        <div class="container">
            <div class="row">
                
                <%@include file="/front-end/sidebarFront.file"%>
                
                <div class="col-lg-10 content">
                	<div class="pagetitle">新增信用卡</div>
                	<div class='card-wrapper'></div>
					<script src="<%=request.getContextPath()%>/template_front-end/card-master/dist/card.js"></script>
							<br>
							<form>
							    <div class="row a align-items-center">
							    	<div class="col-4"></div>
							    	<div class="col-2 align-items-center">信用卡名稱:</div>
							    	<div class="col-2 align-items-center"><input type="text" name="name" placeholder="信用卡名稱"/></div>
							    </div>
							    <div class="row  align-items-center">
							    	<div class="col-4"></div>
							    	<div class="col-2 align-items-center">信用卡卡號:</div>
							    	<div class="col-2 align-items-center"><input type="text" name="number" placeholder="卡號" required/></div>
							    </div>
							    <div class="row  align-items-center">
							    	<div class="col-4"></div>
							    	<div class="col-2 align-items-center">到期日:</div>
							    	<div class="col-2 align-items-center"><input type="text" name="expiry" placeholder="到期日" required/></div>
							    </div>
							    <div class="row  align-items-center">
							    	<div class="col-4"></div>
							    	<div class="col-2 align-items-center">安全碼:</div>
							    	<div class="col-2 align-items-center"><input type="text" name="cvc" placeholder="安全碼" required/></div>
							    </div>
							    <div class="row  align-items-center">
							    	<div class="col-5"></div>
							    	<div class="col-3 align-items-center"><a href="#" class="genric-btn success medium">新  增</a></div>
							    	<div class="col-4 align-items-center"></div>
							    </div>
							</form>
                </div>
            </div>
        </div>
    </section>
    <!--================End Category Product Area =================-->



<!--================ creditcard =================-->
<script>
var card = new Card({
	form: 'form',
	container: '.card-wrapper',
								    
	placeholders: {
	number: '**** **** **** ****',
	name: '信用卡名稱',
	expiry: 'mm/yyyy',
	cvc: '***'
	}
});
</script>
<!--================ creditcard =================-->

</body>

<!-- Required source start -->
	<!-- jquery 這行有需要的人再加 -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<!-- 要放在最下面 -->
<%@include file="/front-end/footer.file"%>

</html>
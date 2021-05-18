<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>選取預約時間</title>

</head>








<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- =================================下面是導覽列==================================================== --> 
<%@include file="/front-end/header.file"%>
<!-- =================================上面是導覽列==================================================== --> 
<link type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/south-street/jquery-ui.css" rel="stylesheet"> 
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

<link type="text/css" href="<%=request.getContextPath()%>/template_front-end/forRenCon/css/jquery.signature.css" rel="stylesheet"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/template_front-end/forRenCon/js/jquery.signature.js"></script>

<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<style>
.kbw-signature { width: 400px; height: 200px; }
.breadcrumb_bg {
<%--     background-image: url(<%=request.getContextPath()%>/front-end/rooVieApp/images/hand01.jpg); --%>
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}
</style>
<body >
<!-- ======圖片 -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2> 預 約 看 房   Welcome</h2>
                            <h3> &nbsp;&nbsp;&nbsp; ${MemTenVO.mem_name} 你好 !</h3>
                            <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H o m e <span>-</span> V i e w i n g</h5>
                            <h5>會員: ${MemTenVO.mem_no} <span>-</span>  選取你要預約的時間</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
<!-- /****** CONTAINER *****/     -->
 	<section class="confirmation_part padding_top" style="padding-top:0px">
		<div class="container">
	            <div class="row">
					<div class="col-lg-12">
                        <div class="order_details_iner">
                            <h3>選取你要預約的日期</h3>
                           <div id='show'></div>
                               	<p style="clear: both;">
									<button id="disable">Disable</button> 
									<button id="clear">Clear</button> 
									<button id="json">To JSON</button>
									<button id="svg">To SVG</button>
								</p>
                        </div>
					</div>
				</div>
            </div>
    	</section>
		<img id='s' src=''>
    	 
    	<script>
    	var sig =$('#show').signature();
    	$('#show').signature({distance: 5});
    	$('#disable').click(function() {
    		var disable = $(this).text() === 'Disable';
    		$(this).text(disable ? 'Enable' : 'Disable');
    		sig.signature(disable ? 'disable' : 'enable');
    	});
    	$('#clear').click(function() {
    		sig.signature('clear');
    	});
    	$('#json').click(function() {
    		alert(sig.signature('toJSON'));
    		console.log(typeof(sig.signature('toDataURL', 'image/jpeg', 0.8)));
    		$("#s").attr('src',sig.signature('toDataURL', 'image/jpeg', 0.8));
    	});
    	$('#svg').click(function() {
    		alert(sig.signature('toSVG'));
    	});
    	</script>
    	

<!-- /****** CONTAINER *****/     -->	


<!-- /****** CONTAINER *****/     -->


		
<!-- /****** CONTAINER *****/     -->	                       
</body>
<%@include file="/front-end/footer.file"%>
</html>
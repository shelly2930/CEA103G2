<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.post.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>

<%
	PostVO postVO = (PostVO) request.getAttribute("postVO");
%>

<html>
<head>
<%@include file="/front-end/header.file"%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template_front-end/css/all.css">
<style>
h2 {
	text-align: center;
}

.quotes {
	text-align: justify;
	font-size: 1.2em;
	color: black;
}
.breadcrumb_bg {
	background-image: url('<%=request.getContextPath()%>/index_img/10.jpg')
		!important;
	background-position: center;
	background-repeat: no-repeat !important;
	background-size: cover;
}
.padding_top {
    padding-top: 10px !important;
}
</style>
</head>
<body>
	<!--================Home Banner Area =================-->
	<section class="breadcrumb breadcrumb_bg">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-8">
					<div class="breadcrumb_iner">
						<div class="breadcrumb_iner_item"></div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!--================Blog Area =================-->
	<section class="blog_area single-post-area padding_top">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 posts-list">
					<div class="single-post">
						<div class="blog_details">
							<h2>${postVO.post_title}</h2>
							<div class="quote-wrapper">
								<div class="quotes">
									<%=postVO.getPost_content()%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================Blog Area end =================-->
	<%@ include file="/front-end/footer.file"%>
</body>
</html>
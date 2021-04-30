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
<%@ include file="/front-end/header.jsp"%>

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
</style>
</head>
<body>

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
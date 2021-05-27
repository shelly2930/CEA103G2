<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	List<PostVO> list = (ArrayList<PostVO>) (request.getAttribute("list"));
%>

<html>
<head>
<title>公告專區</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<%@include file="/front-end/header.file"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template_front-end/css/all.css">

<style>
.breadcrumb_bg {
	background-image: url('<%=request.getContextPath()%>/index_img/10.jpg')
		!important;
	background-position: center;
	background-repeat: no-repeat !important;
	background-size: cover;
}

.justify-content-center {
	opacity: 0;
}

div#desc div#asc {
	/* 	color: #0000EE; */
	text-decoration: none;
}

.table-borderless tbody+tbody, .table-borderless td, .table-borderless th,
	.table-borderless thead th {
	border: 3px solid black;
}

.confirmation_part .order_details_iner .table thead th {
	font-size: 1.2em;
	text-align: center;
}

td#time {
	text-align: right
}

.col-xl-12 {
	top: -50px;
}

.confirmation_part .single_confirmation_details {
	padding: 0 !important;
}

.confirmation_part .order_details_iner {
	background-color: white;
	padding: 0;
	position: relative;
	box-sizing: border-box;
	left: -5%;
	width: 110%;
}

.confirmation_part .single_confirmation_details {
	background-color: white;
}

.title { 
 	color: #007bff !important; 
	
 } 
a.page{
	color: #007bff !important; 
} 
</style>
<script>
    $(document).ready(function(){
        if(${param.status}==0){
            $("#desc").hide();
        }else{
            $("#asc").hide();
        }
    });
</script>

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


	<!--================ confirmation part start =================-->
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<section class="confirmation_part padding_top">
		<div class="container">
			<div class="row">
				<div class="col-xl-12 col-xl-12">
					<div class="single_confirmation_details">
						<div class="row">
							<div class="col-xl-12">
								<div class="order_details_iner">
									<table class="table table-borderless">
										<thead>
											<tr>
												<th style="width: 70%">公告標題</th>
												<th><div id="desc">
														<a
															href="<%=request.getContextPath()%>/post/post.do?action=listAllFront&status=0">公告日期<i
															class="fas fa-sort-up"></i>
														</a>
													</div>
													<div id="asc">
														<a
															href="<%=request.getContextPath()%>/post/post.do?action=listAllFront&status=1">公告日期<i
															class="fas fa-sort-down"></i>
														</a>
													</div></th>
											</tr>
										</thead>
										<%@ include file="page1.file"%>
										<c:forEach var="postVO" items="${list}" begin="<%=pageIndex%>"
											end="<%=pageIndex+rowsPerPage-1%>">
											<tbody>
												<tr>
													<td scope="col" colspan="1" ><a class= "title"
														href="<%=request.getContextPath() %>/post/post.do?action=GoToOneContent&post_no=${postVO.post_no}">${postVO.post_title}</a></td>
													<td id="time"><fmt:formatDate
															value="${postVO.post_time}" pattern="yyyy-MM-dd HH:mm" /></td>


												</tr>
											</tbody>
										</c:forEach>
									</table>
									<%@ include file="page2.file"%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="/front-end/footer.file"%>
	<!--================ confirmation part end =================-->
</body>
</html>
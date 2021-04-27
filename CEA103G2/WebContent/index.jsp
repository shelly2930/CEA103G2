<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>index</title>
<!-- ==========icon==== -->
<link rel="icon" href="<%=request.getContextPath()%>/index_img/icon01.ico" type="image/*" sizes="16x16">
<!-- =================套用bootstrap要使用以下=========================== -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
<!-- =================套用bootstrap要使用以上=========================== -->
<style>
table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}

ul div {
	width: 100px;
	height: 100px;
	margin: 10px;
	background: lightblue;
}

.nav-item {
	background: #E3E3E3;
}

body {
	font-family: Microsoft JhengHei;
}
</style>
</head>

<body bgcolor='white'>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp"> <img
			src="<%=request.getContextPath()%>/index_img/home01.png" width="30"
			height="30" alt="">
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarTogglerDemo03"
			aria-controls="navbarTogglerDemo03" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">HowTrue</a>
		<div class="collapse navbar-collapse" id="navbarTogglerDemo03">
			<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
				<li class="nav-item active">
				<a class="nav-link" href="<%=request.getContextPath()%>/house/house.do?action=listHouse_AllOrQuery">租屋
				</a>
				</li>
				<li class="nav-item">
				<a class="nav-link" href="<%=request.getContextPath()%>/house/house.do?action=goToInsert"
					tabindex="-1" aria-disabled="true">房東上傳物件</a>
					</li>
				<li class="nav-item">
				<a class="nav-link" href="<%=request.getContextPath()%>/back-end/indexBack.jsp"
					tabindex="-1" aria-disabled="true">後臺傳送門</a>
				</li>
				<li class="nav-item">
				<a class="nav-link  disabled" href="#">租家具(尚未)</a>
				</li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
<!-- =================================上面是導覽列==================================================== -->
<!-- 這是房東上傳物件成功 -->
<c:if test="${upload eq 'success'}">
<script>alert('已經上傳成功，將回到首頁!');</script>
</c:if>

<!-- ==================================================================================================== -->
	 <div class="container-fluid">
        <div class="row no-gutters" >
            <div class="col-sm-12 ">
                <img src="<%=request.getContextPath()%>/index_img/home03.jpg" alt="" class="img-fluid img-thumbnail" >
            </div>
        </div>
    </div>


</body>
</html>
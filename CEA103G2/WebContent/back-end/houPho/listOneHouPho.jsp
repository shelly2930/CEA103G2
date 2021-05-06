<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.houPho.model.*"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%-- 取出 Concroller EmpServlet.java已存入request的EmpVO物件--%>
<%HouPhoVO houPhoVO = (HouPhoVO) request.getAttribute("houPhoVO");%>

<html>
<head>
<title>物件照片資料</title>
<!-- =================套用bootstrap要使用以下=========================== -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
<!-- =================套用bootstrap要使用以下=========================== -->
<!-- =================套用台灣縣市鄉鎮要使用以下=========================== -->
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<!-- =================套用台灣縣市鄉鎮要使用以上=========================== -->

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
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
</style>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>
<!-- ===================================後臺NAV -->
<nav class="navbar navbar-expand-lg navbar-lightblue bg-dark">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/back-end/indexBack.jsp"> <img src="${pageContext.request.contextPath}/index_img/home01.png"
			width="30" height="30" alt="">
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarTogglerDemo03"
			aria-controls="navbarTogglerDemo03" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<a class="navbar-brand" href="${pageContext.request.contextPath}/back-end/indexBack.jsp">HowTrue後台管理</a>
		<div class="collapse navbar-collapse " id="navbarTogglerDemo03">
			<ul class="navbar-nav  mr-auto mt-2 mt-lg-0">
				<li class="nav-item bg-dark  active dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> 物件管理 </a>
					<div class="dropdown-menu   bg-dark" aria-labelledby="navbarDropdown">
						<a class="dropdown-item bg-dark" href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend"><p style="color:lightblue">指派員工</p></a> 
						<a class="dropdown-item bg-dark" href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp"><p style="color:lightblue"> 申請處理</p></a>
						</li>
				<li class="nav-item bg-dark "><a class="nav-link disabled" href="#" aria-disabled="true">家具管理</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Action</a> <a
							class="dropdown-item" href="#">Another action</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
					</div></li>
				<li class="nav-item bg-dark"><a class="nav-link disabled"
					href="#" tabindex="-1" aria-disabled="true">員工資料管理</a></li>
				<li class="nav-item bg-dark"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp"
					tabindex="-1" aria-disabled="true">前臺傳送門</a></li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
<!-- ===================================後臺NAV -->
<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>物件照片 - listOneEmp.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/select_HousePhoto.jsp"><img src="<%=request.getContextPath()%>/front-end/houPho/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>照片編號</th>
		<th>物件編號</th>
		<th>物件照片</th>
	
	</tr>
	<tr>
		<td><%=houPhoVO.getHos_pic_no()%></td>
		<td><%=houPhoVO.getHos_no()%></td>
		<td><img src="<%=request.getContextPath()%>/HouPhoImgServlet?picno=${houPhoVO.hos_pic_no}"  height="100" ></td>
	</tr>
</table>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>後台首頁</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

<style>
	@media (max-width:575px) {
		.display-4 {
			font-size: 1.5rem;
		}
		.day h5 {
			background-color: #d6f8ff;
			padding: 3px 5px 5px;
			margin: -8px -8px 8px -8px;
		}
		.date {
			padding-left: 4px;
		}
	}
	@media (min-width: 576px) {
		.day {
/* 			height: 8vw; */
		}
	}

	.fc-state-default.fc-corner-left {
		border-top-left-radius: 4px;
		border-bottom-left-radius: 4px;
	}
	.fc-state-default.fc-corner-right {
		border-top-right-radius: 4px;
		border-bottom-right-radius: 4px;
	}
	.fc-header .fc-corner-right, .fc-header .ui-corner-right {
		margin-right: 0;
	}
	.fc-header .fc-button {
		margin-right: -5px;
	}
	.fc-header .fc-button {
		margin-bottom: 1em;
		margin-top: -0.5rem;
		vertical-align: top;
	}
	.fc-state-default {
		border-color: #ff3b30;
		color: #ff3b30;
	}
	.fc-state-default {
		border: 1px solid;
	}
	.fc-button {
		position: relative;
		display: inline-block;
		padding: 0 .6em;
		overflow: hidden;
		height: 1.9em;
		white-space: nowrap;
		cursor: pointer;
	}
	.fc-button-prev .fc-text-arrow, .fc-button-next .fc-text-arrow {
		font-weight: bold;
	}
	.fc-text-arrow {
		margin: 0 .4em;
		font-size: 2em;
		line-height: 23px;
		vertical-align: baseline;
	}
	.fc-header-space {
		padding-left: 10px;
	}
	.fc-button-today {
		border: 1px solid rgba(255,255,255,.0);
	}
	.fc-state-disabled {
		cursor: default;
		background-image: none;
		background-color: #FFE3E3;
		filter: alpha(opacity=65);
		box-shadow: none;
		border: 1px solid #FFE3E3;
		color: #ff3b30;
	}

	.cal-title{
		display: inline-block;
		color: #509a53;
	}
	.fc-header{
		display: inline-block;
		margin-left: 1rem;
	}
	.cal-header{
 		text-align: right;
 		padding-right: 3rem;
	}
	@media (max-width: 576px){
		.cal-header{
			text-align: center;
			padding-right: 0;
		}
	}
	.fc-button-today:hover{
		cursor: pointer;
	}
	.bg-light {
    	background-color: #aefff5!important;
	}
	.bg-dark {
	    background-color: #fba19e!important;
	}
	.text-muted {
	    color: #c1c2c8!important;
	}
	.this-month{
		color: #133331;
	}
	.done{
		filter: brightness(0.7);
	}
/* 	.unassigned{ */
/* 		border: 2px black solid; */
/* 	} */
</style>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <%@ include file="/back-end/includeFile/sidebarBack.file" %>

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <%@ include file="/back-end/includeFile/topbarBack.file" %>

                <!-- Begin Page Content -->
                <div class="container-fluid">

					<header>
						<div class="cal-header">
							<h4 class="display-4 mb-4 text-center cal-title"></h4>
							<div class="fc-header">
								<span class="fc-button fc-button-prev fc-state-default fc-corner-left" unselectable="on"><span class="fc-text-arrow">‹</span></span>
								<span class="fc-button fc-button-next fc-state-default fc-corner-right" unselectable="on"><span class="fc-text-arrow">›</span></span>
								<span class="fc-header-space"></span>
								<span class="fc-button fc-button-today fc-state-default fc-corner-left fc-corner-right fc-state-disabled" unselectable="on">today</span>
							</div>
						</div>
						<div class="row d-none d-sm-flex p-1 bg-dark text-white">
							<h5 class="col-sm p-1 text-center">日</h5>
							<h5 class="col-sm p-1 text-center">一</h5>
							<h5 class="col-sm p-1 text-center">二</h5>
							<h5 class="col-sm p-1 text-center">三</h5>
							<h5 class="col-sm p-1 text-center">四</h5>
							<h5 class="col-sm p-1 text-center">五</h5>
							<h5 class="col-sm p-1 text-center">六</h5>
						</div>
					</header>
					<div class="row border border-right-0 border-bottom-0 cal-body">
					</div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->


	<!-- Bootstrap core JavaScript-->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>
            <%@ include file="/back-end/includeFile/footerBack.file" %>
		    <%@ include file="/back-end/includeFile/otherBack.file" %>
	
<script>
show(new Date());

function show(date) {
	let year = date.getFullYear();
	let month = date.getMonth();
	let day = date.getDate();
	let dayOfWeek = (new Date(year, month, 1)).getDay();
	let daysOfMonth = [31, isLeap(year), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
	let week = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];

	$(".cal-title").text(year + " - " + (month + 1));

	let row = Math.ceil((dayOfWeek + daysOfMonth[month]) / 7);
	let str = "";
	for(let i = 0; i < dayOfWeek; i++){
		let year2 = year;
		let month2 = month;
		if(month2 == 0){
			month2 += 12;
			year2 -= 1;
		}
		let dateNum;
		if(month == 0){
			dateNum = daysOfMonth[11] - dayOfWeek + 1 + i;
		}else{
			dateNum = daysOfMonth[month - 1] - dayOfWeek + 1 + i;
		}
		str += "<div class='day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted " + year2+"-"+month2+"-"+dateNum + "'>";
		str += "<h5 class='row align-items-center'>";
		str += "<span class='date col-1'>" + dateNum + "</span>";
		str += "<small class='col d-sm-none text-center text-muted'>" + week[i] + "</small>";
		str += "<span class='col-1'></span>";
		str += "</h5>";
		// str += "<p class='d-sm-none'></p>";
		str += "</div>";
	}
	for(let i = 0; i < daysOfMonth[month]; i++){
		let weekIndex = dayOfWeek + i;
		while(weekIndex >= 7){
			weekIndex -= 7;
		}
		str += "<div class='day col-sm p-2 border border-left-0 border-top-0 text-truncate this-month " + year+"-"+(month+1)+"-"+(i+1) + "'>";
		str += "<h5 class='row align-items-center'>";
		str += "<span class='date col-1'>" + (i + 1) + "</span>";
		str += "<small class='col d-sm-none text-center text-muted'>" + week[weekIndex] + "</small>";
		str += "<span class='col-1'></span>";
		str += "</h5>";
		// str += "<p class='d-sm-none'></p>";
		str += "</div>";
		if(weekIndex == 6){
			str += "<div class='w-100'></div>";
		}
	}
	for(let i = 0; i < row * 7 - dayOfWeek - daysOfMonth[month]; i++){
		let weekIndex = (dayOfWeek + daysOfMonth[month]) % 7;
		let year2 = year;
		let month2 = month;
		if(month2 == 11){
			month2 -= 12;
			year2 += 1;
		}
		str += "<div class='day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted " + year2+"-"+(month2+2)+"-"+(i+1) + "'>";
		str += "<h5 class='row align-items-center'>";
		str += "<span class='date col-1'>" + (i + 1) + "</span>";
		str += "<small class='col d-sm-none text-center text-muted'>" + week[weekIndex] + "</small>";
		str += "<span class='col-1'></span>";
		str += "</h5>";
		// str += "<p class='d-sm-none'></p>";
		str += "</div>";
		weekIndex++;
	}

	$(".cal-body").html(str);
	addRenFurApp();
	addRooVieApp();
	addHouse();
// 	alert("!!!");
}

function isLeap(year) {
	return year % 4 === 0? (year % 100 !== 0? 29:  (year % 400 === 0? 29: 28)): 28;
}

let now = new Date();
let year = now.getFullYear();
let month = now.getMonth();
$(".fc-corner-left").click(function(){
	if(month == 0){
		month += 11;
		year -= 1;
	}else{
		month -= 1;
	}
	show(new Date(year, month));
});
$(".fc-corner-right").click(function(){
	if(month == 11){
		month -= 11;
		year += 1;
	}else{
		month += 1;
	}
	show(new Date(year, month));
});
$(".fc-button-today").click(function(){
	year = now.getFullYear();
	month = now.getMonth();
	show(now);
});

function addRenFurApp() {
	$.ajax({
		url:"<%=request.getContextPath()%>/employee/employee.do",
		type:'post',
		data:{
			action:'getAllRenFurAppJSON'
		},
		async: false,
		success:function(data){
			for(let renFurAppVO of data){
				let d = new Date(renFurAppVO.rfa_order_date);
				let year = d.getFullYear();
				let month = d.getMonth() + 1;
				let date = d.getDate();
				let hour = d.getHours();
				let min = d.getMinutes();
				$("."+year+"-"+month+"-"+date).append
					("<a class='event d-block p-1 pl-2 pr-2 mb-1 rounded text-truncate small bg-info text-white' href='<%=request.getContextPath()%>/renFurApp/renFurApp.do?rfa_no="
						+renFurAppVO.rfa_no+"&action=getOne_For_Update'>"+hour+":00 租家具申請</a>");
				if(${employeeVO.emp_job != "主管"} && renFurAppVO.emp_no != ${employeeVO.emp_no}){
					$("."+year+"-"+month+"-"+date).find("a").css("visibility","hidden");
				}
				if(renFurAppVO.rfa_status == 0){
					$("."+year+"-"+month+"-"+date).find("a").addClass("unassigned");
				}else if(renFurAppVO.rfa_status == 2){
					$("."+year+"-"+month+"-"+date).find("a").addClass("done");
				}
			}
		}
	});
}
function addRooVieApp() {
	$.ajax({
		url:"<%=request.getContextPath()%>/employee/employee.do",
		type:'post',
		data:{
			action:'getAllRooVieAppJSON'
		},
		async: false,
		success:function(data){
			for(let RooVieAppVO of data){
				let d = new Date(RooVieAppVO.rva_order_time);
				let year = d.getFullYear();
				let month = d.getMonth() + 1;
				let date = d.getDate();
				let hour = d.getHours();
				let min = d.getMinutes();
				$("."+year+"-"+month+"-"+date).append
					("<a class='event d-block p-1 pl-2 pr-2 mb-1 rounded text-truncate small bg-warning text-white'" +
							"href='<%=request.getContextPath()%>/back-end/rooVieApp/listNewRooVieApp_EMP.jsp'>"+hour+":00 預約看房申請</a>");
				if(${employeeVO.emp_job != "主管"} && RooVieAppVO.emp_no != ${employeeVO.emp_no}){
					$("."+year+"-"+month+"-"+date).find("a").css("visibility","hidden");
				}
				if(RooVieAppVO.rva_status == 0){
					$("."+year+"-"+month+"-"+date).find("a").addClass("unassigned");
				}else if(RooVieAppVO.rva_status == 2){
					$("."+year+"-"+month+"-"+date).find("a").addClass("done");
				}
			}
		}
	});
}
function addHouse() {
	$.ajax({
		url:"<%=request.getContextPath()%>/employee/employee.do",
		type:'post',
		data:{
			action:'getAllHouseJSON'
		},
		async: false,
		success:function(data){
			for(let HouseVO of data){
				let d = new Date(HouseVO.hos_order_date);
				let year = d.getFullYear();
				let month = d.getMonth() + 1;
				let date = d.getDate();
				let hour = d.getHours();
				let min = d.getMinutes();
				$("."+year+"-"+month+"-"+date).append
					("<a class='event d-block p-1 pl-2 pr-2 mb-1 rounded text-truncate small bg-success text-white' href='<%=request.getContextPath()%>/house/house.do?houseno="
						+HouseVO.hos_no+"&action=getOneHouseForUpdate'>"+hour+":00 預約代管申請</a>");
				if(${employeeVO.emp_job != "主管"} && HouseVO.emp_no != ${employeeVO.emp_no}){
					$("."+year+"-"+month+"-"+date).find("a").css("visibility","hidden");
				}
				if(HouseVO.hos_status == 0){
					$("."+year+"-"+month+"-"+date).find("a").addClass("unassigned");
				}else if(HouseVO.hos_status == 2){
					$("."+year+"-"+month+"-"+date).find("a").addClass("done");
				}
			}
		}
	});
}
</script>
</body>

</html>
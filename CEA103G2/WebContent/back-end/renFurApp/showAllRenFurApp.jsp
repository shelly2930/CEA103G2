<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="com.renFurDet.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furLis.model.*"%>
<% 	  
if(request.getAttribute("list") == null){
	List<RenFurAppVO> list =null;
	RenFurAppService renFurAppSvc = new RenFurAppService();
	list= renFurAppSvc.getAll();
	request.setAttribute("list",list);
}

// 以下按比例計算租金
// RenFurDetService renFurDetSvc = new RenFurDetService();
// FurIteService furIteSvc = new FurIteService();
// FurLisService furLisSvc = new FurLisService();
// int raf_total = 0; //每月租金合計
// for(RenFurDetVO renFurDetVO : renFurDetSvc.getOneList(list.get(3).getRfa_no())){
// 	int fnt_price = furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.getFnt_id()).getFnt_it_no()).getFnt_price(); //家具品項租金
// 	if(renFurDetVO.getRent_tmt_date() == null){ //如解約日期為空值
// 		raf_total += fnt_price;
// 	}else {
// 		Calendar cal = Calendar.getInstance();
// 		cal.setTime(renFurDetVO.getRent_tmt_date()); //將解約日期轉為Calendar
// 		int dayOfMonth = cal.get(Calendar.DATE); //解約日期為當月第幾天
// 		cal.set(Calendar.DATE, 1); //把日期設定為當月第一天
// 		cal.roll(Calendar.DATE, -1); //日期回滾一天，也就是最後一天
// 	    int totalDaysOfMonth = cal.get(Calendar.DATE); //解約日期當月總天數
// 		if((new Date().getTime() - renFurDetVO.getRent_tmt_date().getTime()) / (24*60*60*1000) < totalDaysOfMonth) { //如當下時間與解約日期相差天數小於總天數
// 		    int partOf_fnt_price = (int)Math.floor((double)dayOfMonth / (double)totalDaysOfMonth * fnt_price); //按天數計算租金,int轉為double相除才會有小數
// 		    raf_total += partOf_fnt_price;
// 		}
// 	}
// }
%>
<%-- <%=raf_total %> --%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>所有員工</title>

<!-- Custom fonts for this template-->
<link
	href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link
	href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css"
	rel="stylesheet">
	
<!-- Custom styles for this page -->
<link
	href="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

<style>
/* 	table:hover{ */
/* 		cursor: pointer; */
/* 	} */
/* 	tr:hover{ */
/* 		background-color: #eeeeee; */
/* 	} */
/* 	th:hover{ */
/* 		background-color: #aaaaaa; */
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

				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">租家具申請單</h1>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<c:if test="${employeeVO.emp_job eq '主管'}">
							<a class="btn btn-primary mr-1" href="${pageContext.request.contextPath}/renFurApp/renFurApp.do?rfa_status=0&action=getByRfa_status" role="button">未指派</a>
						    </c:if>
							<a class="btn btn-primary mr-1" href="${pageContext.request.contextPath}/renFurApp/renFurApp.do?rfa_status=1&action=getByRfa_status" role="button">未完成</a>
							<a class="btn btn-primary mr-1" href="${pageContext.request.contextPath}/renFurApp/renFurApp.do?rfa_status=2&action=getByRfa_status" role="button">已完成</a>
							<a class="btn btn-primary" href="${pageContext.request.contextPath}/back-end/renFurApp/showAllRenFurApp.jsp" role="button">全部</a>
						</div>
						<div class="card-body">
							<div class="table-responsive-lg">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
<!-- 											<th></th> -->
											<th>申請單編號</th>
											<th>會員姓名</th>
											<th>申請時間</th>
											<th>預約時間</th>
											<th>申請進度</th>
										    <th>租金合計</th>
											<th>租借狀態</th>
											<th>查看</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="renFurAppVO" items="${list}">
										<c:if test="${renFurAppVO.emp_no == employeeVO.emp_no || employeeVO.emp_job eq '主管'}">

											<tr>
<!-- 												<td width="26" align="center" bgcolor="#eeeeee"><a href="#${renFurAppVO.rfa_no}" class="plus">+</a></td> -->
												<td>${renFurAppVO.rfa_no}</td>
												<jsp:useBean id="memTenSvc" scope="page" class="com.memTen.model.MemTenService" />
												<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_name}</td>
												<td><fmt:formatDate value="${renFurAppVO.rfa_apct_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
												<td><fmt:formatDate value="${renFurAppVO.rfa_order_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
												<td class="appProgress${renFurAppVO.rfa_status}">
													<c:choose>
														<c:when test="${renFurAppVO.rfa_status==0}">未指派</c:when>
														<c:when test="${renFurAppVO.rfa_status==1}">未完成</c:when>
														<c:otherwise>已完成</c:otherwise>
													</c:choose>
												</td>
												
												<td>${renFurAppVO.rfa_total} 元</td>
												
<!-- 												以下依照租家具明細解約日期非空值才做租金合計 -->
<%-- 												<jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" /> --%>
<%-- 												<jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" /> --%>
<%--   												<jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" /> --%>
<%-- 												<c:set var="raf_total" value="0" /> --%>
<%-- 												<c:forEach var="renFurDetVO" items="${renFurDetSvc.getOneList(renFurAppVO.rfa_no)}"> --%>
<%-- 													<c:if test="${renFurDetVO.rent_tmt_date == null}"> --%>
<%-- 													<c:set var="raf_total" value="${raf_total + furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price}" /> --%>
<%-- 													</c:if> --%>
<%-- 												</c:forEach> --%>
<%-- 												<td>${raf_total}元</td> --%>
												
												<jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" />
												<c:set var="isTMT" value="true" />
												<c:forEach var="renFurDetVO" items="${renFurDetSvc.getOneList(renFurAppVO.rfa_no)}">
													<c:if test="${renFurDetVO.rent_tmt_date == null}"><c:set var="isTMT" value="false" /></c:if>
												</c:forEach>
												<td>
													<c:choose>
														<c:when test="${renFurAppVO.rfa_status != 2}">尚未出租 </c:when>
														<c:when test="${isTMT == false}">出租中</c:when>
														<c:when test="${isTMT == true}">已退租</c:when>
													</c:choose>
												</td>
												
												<td align="center">
													<a href="${pageContext.request.contextPath+="/renFurApp/renFurApp.do?rfa_no="+=renFurAppVO.rfa_no+="
													&requestURL="+=pageContext.request.requestURL+="&action=getOne_For_Update"}">查看</a>
												</td>
											</tr>
											
<!-- 											 <tr> -->
<!-- 									            <td colspan="11" class="content"> -->
<%-- 									                <div id="${renFurAppVO.rfa_no}" style="display:none;"> --%>
<!-- 									                    <table style="border: 0px; border-collapse: collapse; width:90%; margin:15px auto 15px 30px;"> -->
<!-- 									                        <tr> -->
<!-- 																<th>家具<br>編號</th> -->
<!-- 																<th>家具名稱</th> -->
<!-- 																<th>家具租金</th> -->
<!-- 																<th>出租日期</th> -->
<!-- 																<th>終止日期</th> -->
<!-- 																<th>解租日期</th> -->
<!-- 									                        </tr> -->
<%-- 									                        <jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" /> --%>
<%-- 									                        <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" /> --%>
<%-- 															<c:forEach var="renFurDetVO" items="${renFurDetSvc.all}" > --%>
<%-- 																<c:if test="${renFurAppVO.rfa_no==renFurDetVO.rfa_no}"> --%>
<!-- 																	<tr> -->
<%-- 																		<td>${renFurDetVO.fnt_id}</td> --%>
<%-- 																		<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_name}</td> --%>
<%-- 												  						<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price} 元</td> --%>
<%-- 																		<td><fmt:formatDate value="${renFurDetVO.rent_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td> --%>
<%-- 																		<td><fmt:formatDate value="${renFurDetVO.rent_end_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td> --%>
<%-- 																		<td><fmt:formatDate value="${renFurDetVO.rent_tmt_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td> --%>
																	
<!-- 																	</tr> -->
<%-- 																</c:if> --%>
<%-- 															</c:forEach> --%>
<!-- 									                    </table> -->
<!-- 									                </div> -->
<!-- 									            </td> -->
<!-- 									        </tr> -->
									    
									    </c:if>    
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<%@ include file="/back-end/includeFile/footerBack.file" %>

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<%@ include file="/back-end/includeFile/otherBack.file" %>

	<!-- Bootstrap core JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/datatables-demo.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

	<script>
// 		$("tr").click(function(){
// 			$(this).find("form").submit();
// 		});
		
// 		<c:if test="${not empty requestScope.insertSuccess}">
// 			Swal.fire({
// 			   	icon:'success',
// 			   	title:'新增成功'
// 			});
// 		</c:if>
		
		$(function(){
			$("a.plus").click(function(){ 
				var _this= $(this).attr("href");     
				if($(_this).css("display")=="none"){
					$(_this).slideDown();
					$(this).html("-");
				}else{
					$(_this).slideUp();
					$(this).html("+");
				}
			});  
		});
		
	</script>
</body>

</html>
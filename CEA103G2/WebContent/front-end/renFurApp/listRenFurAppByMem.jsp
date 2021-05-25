<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="com.renFurDet.model.*"%>
<html>
<head>

<%-- <jsp:useBean id="renFurAppSvc" scope="page" class="com.renFurApp.model.RenFurAppService" /> --%>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<title>查看租家具申請單</title>

<style>
/* body {  */
/* background-color: #dddddd !important; */
/* } */

.genric-btn.info {
    color: #fff;
    background: #61d2b4 !important;
    border: 1px solid transparent;
    font-size: 16px;
    width: 80px;
    height: 40px;
    margin: 5px;

}

.genric-btn.radius {
    border-radius: 20px !important;
}

.genric-btn {
	line-height:2 !important;
}

.genric-btn.info:hover {
    color: #38a4ff;
    border: 1px solid #38a4ff;
    background: #fff !important;
}
</style>

</head>
<body>
<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>

<!--================ Content Area start =================-->
<section class="cat_product_area section_padding">
	<div class="container">
		<div class="row">
            <!--================ Sidebar =================-->    
			<%@include file="/front-end/sidebarFront.file"%>
                
            <div class="col-lg-10 content">
                
                <!--================ 不要的話自己刪掉 =================-->
                <div class="pagetitle">租家具申請單</div>
				
				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
				<div class="table-responsive-lg">
								--${ rfastatus }--
								<%=request.getAttribute("rfastatus") %>
								<a href="<%=request.getContextPath()%>/MemRenFurAppServlet?action=listRenFurAppByMem&mem_no=${MemTenVO.mem_no}" class="genric-btn info radius">未處理</a>
								<a href="<%=request.getContextPath()%>/MemRenFurAppServlet?action=listRenFurAppByMem&mem_no=${MemTenVO.mem_no}&rfa_status=1" class="genric-btn info radius">處理中</a>
								<a href="<%=request.getContextPath()%>/MemRenFurAppServlet?action=listRenFurAppByMem&mem_no=${MemTenVO.mem_no}&rfa_status=2" class="genric-btn info radius">已完成</a>
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
<!-- 											<th></th> -->
											<th>申請單編號</th>
<!-- 											<th>會員姓名</th> -->
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
<%-- 										<c:if test="${renFurAppVO.emp_no == employeeVO.emp_no || employeeVO.emp_job eq '主管'}"> --%>

											<tr>
<!-- 												<td width="26" align="center" bgcolor="#eeeeee"><a href="#${renFurAppVO.rfa_no}" class="plus">+</a></td> -->
												<td>${renFurAppVO.rfa_no}</td>
												<jsp:useBean id="memTenSvc" scope="page" class="com.memTen.model.MemTenService" />
<%-- 												<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_name}</td> --%>
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
													<a href="<%=request.getContextPath()%>/MemRenFurAppServlet?action=getOne_For_Update&rfa_no=${renFurAppVO.rfa_no}">查看</a>
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
									    
<%-- 									    </c:if>     --%>
										</c:forEach>
									</tbody>
								</table>
							</div>
					


				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

</body>

<!-- Required source start -->
	<!-- jquery 這行有需要的人再加 -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
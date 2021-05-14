<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.List"%>
<%@ page import="com.renCon.model.*"%>
	
<%
	RenConService renConService = new RenConService();
	List<RenConVO> list = renConService.getAll();
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="houseService" scope="page" class="com.house.model.HouseService" />

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>租屋合約</title>

<style type="text/css">

/* content CSS start */
.subscribe_area div.container {
	padding: 100px 0;
}
/* content CSS end */

</style>

</head>
<body>
<%@include file="/front-end/header.file"%>
	
	<section class="breadcrumb breadcrumb_bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb_iner text-center">
						<div class="breadcrumb_iner_item">
							<h2>租屋合約</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<section>
		<div class="container">
			<div class="row mt-5">
				<table class="table table-hover">
					<thead style="background-color:#ccb78f">
						<tr>
							<th scope="col">物件名稱</th>
							<th scope="col">合約起始日</th>
							<th scope="col">合約終止日</th>
							<th scope="col">合約狀態</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="renConVO" items="${list}">
						<c:if test="${renConVO.mem_no eq MemTenVO.mem_no}">
						<tr>
							<td>${houseService.getOneHouse(renConVO.hos_no).hos_name}</td>
							<td>${renConVO.rtct_eff_date}</td>
							<td>
								<c:choose>
									<c:when test="${renConVO.rtct_tmt_date == null || renConVO.rtct_end_date == renConVO.rtct_tmt_date}">
										${renConVO.rtct_end_date}
									</c:when>
									<c:when test="${renConVO.rtct_tmt_date != null && renConVO.rtct_end_date != renConVO.rtct_tmt_date}">
										${renConVO.rtct_tmt_date}
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${renConVO.rtct_tmt_date == null}">
										有效
									</c:when>
									<c:when test="${renConVO.rtct_tmt_date != null}">
										已終止
									</c:when>
								</c:choose>
							</td>
<!-- 							<td align="center" style="display:none;"> -->
<!-- 								<FORM METHOD="post" -->
<%-- 									ACTION="<%=request.getContextPath()%>/employee/employee.do" --%>
<!-- 									style="margin-bottom: 0px;"> -->
<!-- 									<button type="submit" class="btn btn-outline-danger">查看</button> -->
<%-- 									<input type="hidden" name="emp_no" value="${employeeVO.emp_no}"> --%>
<!-- 									<input type="hidden" name="action" value="getOne_For_Display"> -->
<!-- 								</FORM> -->
<!-- 							</td> -->
						</tr>
						</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>

	<div class="button-group-area mt-40">
		<a href="#" class="genric-btn danger circle">Danger</a>
	</div>

<!-- Required source start -->
	<!-- jquery 這行有需要的人在自己的頁面加 -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<!-- 要放在最下面 -->
<%@include file="/front-end/footer.file"%>

</body>
</html>
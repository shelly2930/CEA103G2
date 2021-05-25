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

<title>�d�ݯ��a��ӽг�</title>

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
                
                <!--================ ���n���ܦۤv�R�� =================-->
                <div class="pagetitle">���a��ӽг�</div>
				
				<!--�@�@�@�����������������������e���������������������@�@�@-->
				<div class="table-responsive-lg">
								--${ rfastatus }--
								<%=request.getAttribute("rfastatus") %>
								<a href="<%=request.getContextPath()%>/MemRenFurAppServlet?action=listRenFurAppByMem&mem_no=${MemTenVO.mem_no}" class="genric-btn info radius">���B�z</a>
								<a href="<%=request.getContextPath()%>/MemRenFurAppServlet?action=listRenFurAppByMem&mem_no=${MemTenVO.mem_no}&rfa_status=1" class="genric-btn info radius">�B�z��</a>
								<a href="<%=request.getContextPath()%>/MemRenFurAppServlet?action=listRenFurAppByMem&mem_no=${MemTenVO.mem_no}&rfa_status=2" class="genric-btn info radius">�w����</a>
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
<!-- 											<th></th> -->
											<th>�ӽг�s��</th>
<!-- 											<th>�|���m�W</th> -->
											<th>�ӽЮɶ�</th>
											<th>�w���ɶ�</th>
											<th>�ӽжi��</th>
										    <th>�����X�p</th>
											<th>���ɪ��A</th>
											<th>�d��</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="renFurAppVO" items="${list}">
<%-- 										<c:if test="${renFurAppVO.emp_no == employeeVO.emp_no || employeeVO.emp_job eq '�D��'}"> --%>

											<tr>
<!-- 												<td width="26" align="center" bgcolor="#eeeeee"><a href="#${renFurAppVO.rfa_no}" class="plus">+</a></td> -->
												<td>${renFurAppVO.rfa_no}</td>
												<jsp:useBean id="memTenSvc" scope="page" class="com.memTen.model.MemTenService" />
<%-- 												<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_name}</td> --%>
												<td><fmt:formatDate value="${renFurAppVO.rfa_apct_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
												<td><fmt:formatDate value="${renFurAppVO.rfa_order_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
												<td class="appProgress${renFurAppVO.rfa_status}">
													<c:choose>
														<c:when test="${renFurAppVO.rfa_status==0}">������</c:when>
														<c:when test="${renFurAppVO.rfa_status==1}">������</c:when>
														<c:otherwise>�w����</c:otherwise>
													</c:choose>
												</td>
												
												<td>${renFurAppVO.rfa_total} ��</td>
												
<!-- 												�H�U�̷ӯ��a����ӸѬ�����D�ŭȤ~�������X�p -->
<%-- 												<jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" /> --%>
<%-- 												<jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" /> --%>
<%--   												<jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" /> --%>
<%-- 												<c:set var="raf_total" value="0" /> --%>
<%-- 												<c:forEach var="renFurDetVO" items="${renFurDetSvc.getOneList(renFurAppVO.rfa_no)}"> --%>
<%-- 													<c:if test="${renFurDetVO.rent_tmt_date == null}"> --%>
<%-- 													<c:set var="raf_total" value="${raf_total + furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price}" /> --%>
<%-- 													</c:if> --%>
<%-- 												</c:forEach> --%>
<%-- 												<td>${raf_total}��</td> --%>
												
												<jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" />
												<c:set var="isTMT" value="true" />
												<c:forEach var="renFurDetVO" items="${renFurDetSvc.getOneList(renFurAppVO.rfa_no)}">
													<c:if test="${renFurDetVO.rent_tmt_date == null}"><c:set var="isTMT" value="false" /></c:if>
												</c:forEach>
												<td>
													<c:choose>
														<c:when test="${renFurAppVO.rfa_status != 2}">�|���X�� </c:when>
														<c:when test="${isTMT == false}">�X����</c:when>
														<c:when test="${isTMT == true}">�w�h��</c:when>
													</c:choose>
												</td>
												
												<td align="center">
													<a href="<%=request.getContextPath()%>/MemRenFurAppServlet?action=getOne_For_Update&rfa_no=${renFurAppVO.rfa_no}">�d��</a>
												</td>
											</tr>
											
<!-- 											 <tr> -->
<!-- 									            <td colspan="11" class="content"> -->
<%-- 									                <div id="${renFurAppVO.rfa_no}" style="display:none;"> --%>
<!-- 									                    <table style="border: 0px; border-collapse: collapse; width:90%; margin:15px auto 15px 30px;"> -->
<!-- 									                        <tr> -->
<!-- 																<th>�a��<br>�s��</th> -->
<!-- 																<th>�a��W��</th> -->
<!-- 																<th>�a�㯲��</th> -->
<!-- 																<th>�X�����</th> -->
<!-- 																<th>�פ���</th> -->
<!-- 																<th>�ѯ����</th> -->
<!-- 									                        </tr> -->
<%-- 									                        <jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" /> --%>
<%-- 									                        <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" /> --%>
<%-- 															<c:forEach var="renFurDetVO" items="${renFurDetSvc.all}" > --%>
<%-- 																<c:if test="${renFurAppVO.rfa_no==renFurDetVO.rfa_no}"> --%>
<!-- 																	<tr> -->
<%-- 																		<td>${renFurDetVO.fnt_id}</td> --%>
<%-- 																		<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_name}</td> --%>
<%-- 												  						<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price} ��</td> --%>
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
					


				<!--�@�@�@�����������������������e���������������������@�@�@-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

</body>

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�A�[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
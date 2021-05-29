<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="memTenSvc" scope="page" class="com.memTen.model.MemTenService" />
<jsp:useBean id="houseSvc" scope="page" class="com.house.model.HouseService" />
<jsp:useBean id="billSvc" scope="page" class="com.bill.model.BillService" />
<jsp:useBean id="renFurAppSvc" scope="page" class="com.renFurApp.model.RenFurAppService" />
<jsp:useBean id="renFurDetSve" scope="page" class="com.renFurDet.model.RenFurDetService" />
<jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />
<jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" />
<jsp:useBean id="renConSvc" scope="page" class="com.renCon.model.RenConService" />
								
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>�b�����</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

	<style>
	th{
		background-color: #d2eeff;
	}
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

                <!--�@�@�@�����������������������e���������������������@�@�@-->
                <div class="container-fluid">
					
					<div class="row mb-4">
                    	<div class="col text-center"><h1>HowTrue�n��  �Ыȹq�l�b��</h1></div>
                    </div>
                    <div class="row mb-3 pl-4 pr-4">
                    	<div class="col-md-6">
                    		<h3>���O : <fmt:formatDate value="${list.get(0).bill_date}" pattern="yyyyMM"/>��<h3>
                    	</div>
                    	<div class="col-md-6"><h3>ú�O���� : ${list.get(0).bill_due}<h3></div>
                    </div>
                    <div class="row mb-3 pl-4">
                    	<div class="col"><h4>�|���m�W : ${memTenSvc.getOneMemTen(list.get(0).mem_no).mem_name}</h4></div>
                    </div>
                    <div class="row pl-4 pr-4">
                    	<table class="table table-bordered">
                    		<thead>
								<tr>
									<th colspan="5"><p class="font-weight-bold display-4 text-primary">���ζO��</p></th>
								</tr>
								<tr>
									<th scope="col">���Ϊ���W��</th>
									<th scope="col">�O�ζ���</th>
									<th scope="col">���󯲪�(�C��)/������(�C��)</th>
									<th scope="col">�p�O����/�ϥζq(��)</th>
									<th scope="col">���B����</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="billVO" items="${list}">
								<tr>
									<td rowspan="3">${houseSvc.getOneHouse(billVO.hos_no).hos_name}</td>
									<td>�Ыί���</td>
									<td>${houseSvc.getOneHouse(billVO.hos_no).hos_rent}</td>
									<td>${billSvc.getHousePeriodAndMoney(billVO).get("period")}</td>
									<td>${billSvc.getHousePeriodAndMoney(billVO).get("money")}</td>
								</tr>
								<tr>
									<td>�q�O</td>
									<td>${houseSvc.getOneHouse(billVO.hos_no).hos_power}</td>
									<td>${billVO.bill_power}
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${renFurAppVO.rfa_status == 3}">${billVO.bill_power}</c:when> --%>
<%-- 										<c:when test="${isTMT == false}">�X����</c:when> --%>
<%-- 									</c:choose> --%>
									</td>
									<td>
									<fmt:formatNumber value="${Math.round(houseSvc.getOneHouse(billVO.hos_no).hos_power * billVO.bill_power)}" pattern="#" />
									</td>
								</tr>
								<tr>
									<td>���O</td>
									<td>${houseSvc.getOneHouse(billVO.hos_no).hos_water}</td>
									<td>${billVO.bill_water}</td>
									<td>
									<fmt:formatNumber value="${Math.round(houseSvc.getOneHouse(billVO.hos_no).hos_water * billVO.bill_water)}" pattern="#" />
									
									</td>
								</tr>
								</c:forEach>
							
								<tr>
									<td></td>
									<td colspan="3" class="font-weight-bold">�p�p</td>
									<td class="house-subtotal"></td>
								</tr>
							</tbody>
							
							<c:if test="${not billSvc.getCurrentRenFurApp(list.get(0)).isEmpty()}">
							<thead>
								<tr>
									<th colspan="5"><p class="font-weight-bold display-4 text-primary">���a��O��</p></th>
								</tr>
								<tr>
									<th scope="col">���a�㪫��W��</th>
									<th scope="col">�a��W��</th>
									<th scope="col">�a�㯲��(�C��)</th>
									<th scope="col">�p�O����</th>
									<th scope="col">���B����</th>
								</tr>
							</thead>
							<tbody>
							
							<c:forEach var="renFurAppVO" items="${billSvc.getCurrentRenFurApp(list.get(0))}">
								<c:set var="first" value="true" />
								<c:forEach var="renFurDetVO" items="${renFurDetSve.getOneList(renFurAppVO.rfa_no)}">
								<tr>
									<c:if test="${first}">
									<td rowspan="${renFurDetSve.getOneList(renFurAppVO.rfa_no).size()}">
										${houseSvc.getOneHouse(renConSvc.findByPK(renFurDetVO.rtct_no).hos_no).hos_name}
									</td>
									<c:set var="first" value="false" />
									</c:if>
									
									<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_name}</td>
									<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price}</td>
									<td>${billSvc.getRenFurDetPeriodAndMoney(renFurDetVO, list.get(0)).get("period")}</td>
									<td>${billSvc.getRenFurDetPeriodAndMoney(renFurDetVO, list.get(0)).get("money")}</td>
								</tr>
								</c:forEach>
							</c:forEach>
								
								<tr>
									<td></td>
									<td colspan="3" class="font-weight-bold">�p�p</td>
									<td class="rentfur-subtotal"></td>
								</tr>
							</tbody>
							</c:if>
						</table>
                    </div>
                    
                    <div class="row mt-4 pr-5 mb-3">
                    	<div class="col text-right total"><h4></h4></div>
                    </div>
<!-- 					<div class="row mb-4"> -->
<!--                     	<div class="col text-center"> -->
<!--                     		<button type="button" class="btn btn-outline-secondary send-bill">�e�X�b��</button> -->
<!--                     	</div> -->
<!--                     </div> -->

                </div>
                <!--�@�@�@�����������������������e���������������������@�@�@-->

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
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

	<script>
	let house_subtotal = 0;
	$(".house-subtotal").parent().siblings().each(function(){
		house_subtotal += parseInt($(this).children().last().text());
	});
	$(".house-subtotal").text(house_subtotal);
	
	let rentfur_subtotal = 0;
	$(".rentfur-subtotal").parent().siblings().each(function(){
		rentfur_subtotal += parseInt($(this).children().last().text());
	});
	$(".rentfur-subtotal").text(rentfur_subtotal);
	
	let total = house_subtotal + rentfur_subtotal;
	$(".total").children().text("�`�p�G" + total + " ��");
	
	$(".send-bill").click(function(){
		Swal.fire({
			title: '�T�w�n�e�X�b��H',
			text: "�e�X��N����A�ק�",
			icon: 'question',
			showCancelButton: true,
// 			confirmButtonColor: '#d33',
// 			cancelButtonColor: '#3085d6',
			confirmButtonText: '�T�w',
			cancelButtonText: '����'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url:"<%=request.getContextPath()%>/FurColServlet",
					type:'post',
					data:{
						action:'delete_furCol',
						mem_no:mem_no,
						fnt_it_no:$(this).parent().attr('id')
					},
					async: false,
					success:function(str){
						console.log(str);
						refreshFurColBar(getFurCol(mem_no));
					}
				});
			}
		});
	})
	</script>
</body>

</html>
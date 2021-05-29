<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
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

<%@ page import="java.util.*"%>
<%@ page import="com.bill.model.*"%>
<%
// List<BillVO> list = new BillService().getMemMonthlyBill(1, new Date("2018"));
%>

<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<title>�b�����</title>

<style>
body { 
background-color: #dddddd !important;
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
				
				<!--�@�@�@�����������������������e���������������������@�@�@-->

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
                	<table class="table table-bordered" style="background-color: #eeecec;">
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
				<div class="row mb-4">
                	<div class="col text-center">
                		<button type="button" class="btn btn-outline-secondary btn-lg want-pay" data-toggle="modal" 
							data-target="#exampleModalCenter">
							ú�O
						</button>
                	</div>
                </div>
				
				<!-- Modal -->
				<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				  <div class="modal-dialog  modal-dialog-centered" data-backdrop="false" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalCenterTitle">�b��ú�O</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        <div class='card-wrapper'><span id='money'></span></div>
				    	<hr>
				    	<form>
				    		<div class="row a align-items-center">
						    	<div class="col-2"></div>
						    	<div style='display:none' class="col-4 align-items-center"><span>�H�Υd�W��:</span></div>
						    	<div style='display:none' class="col-4 align-items-center"><input type="text" name="name" placeholder="�H�Υd�W��"/></div>
						    </div>
						    <div class="row align-items-center mb-2">
						    	<div class="col-2"></div>
						    	<div class="col-3 align-items-center">�H�Υd�d��:</div>
						    	<div class="col-7 align-items-center"><input type="text" name="number" placeholder="�d��" required/></div>
						    </div>
<!-- 						    <div class='form-group row justify-content-center'> -->
<!-- 					      	 	<label for='newPassword' class='col-3 col-form-label'>�H�Υd�d��</label> -->
<!-- 							  	<div class='col-7'> -->
<!-- 									<input type='text' class='form-control' placeholder="�d��"  required> -->
<!-- 								</div> -->
<!-- 							</div> -->
						    <div class="row  align-items-center mb-2">
						    	<div class="col-2"></div>
						    	<div class="col-3 align-items-center"><span>�����:</span></div>
						    	<div class="col-5 align-items-center"><input type="text" name="expiry" placeholder="�����" required/></div>
						    </div>
						    <div class="row  align-items-center">
						    	<div class="col-2"></div>
						    	<div class="col-3 align-items-center"><span>�w���X:</span></div>
						    	<div class="col-5 align-items-center"><input type="text" name="cvc" placeholder="�w���X" required/></div>
						    </div>
						    <div class="row  align-items-center">
						    	<div class="col-5"></div>
						    	
						    	<div class="col-4 align-items-center"></div>
						    </div>
						</form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary pay-bill">ú�O</button>
				      	<button type="button" class="btn btn-secondary" id="close" data-dismiss="modal">����</button>
				      </div>
				    </div>
				  </div>
				</div>

				<!--�@�@�@�����������������������e���������������������@�@�@-->
							
            </div>
        </div>
    </div>
</section>
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<script src="<%=request.getContextPath()%>/template_front-end/card-master/dist/card.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

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

if(${list.get(0).bill_p_status == 1}){
	$(".want-pay").text("�wú�O");
	$(".want-pay").prop("disabled",true);
}

var card = new Card({
	form: 'form',
	container: '.card-wrapper',
	placeholders: {
	number: '**** **** **** ****',
	name: '�H�Υd�W��',
	expiry: 'mm/yyyy',
	cvc: '***'
	}
});
// picktimeSuccess("�e�e��");
// picktimeSuccess("��e�e�|��", "�|���s��");
// pick("��e��");

$(".pay-bill").click(function(){
	if($("input[name='number']").val() != '' && $("input[name='expiry']").val() != '' && $("input[name='cvc']").val() != ''){
		Swal.fire({
			title: '�T�wú��b����B $' + total +' ?',
	// 		text: "�`���B $" + total,
			icon: 'info',
			showCancelButton: true,
	//			confirmButtonColor: '#d33',
	//			cancelButtonColor: '#3085d6',
			confirmButtonText: '�T�w',
			cancelButtonText: '����'
		}).then((result) => {
			if (result.isConfirmed) {
				<c:forEach var="billVO" items="${list}">
				$.ajax({
					url: "${pageContext.request.contextPath}/bill/bill.do",
					type: "post",
					data: {
						action: "pay_bill",
						bill_no: ${billVO.bill_no}
					},
					success: function(data){
						console.log(data);
					}
				});
				</c:forEach>
	
				Swal.fire({
					icon:'success',
					title:'ú�O���\',
					showConfirmButton: false,
					timer: 1000
				});
				
				$(".want-pay").text("�wú�O");
				$(".want-pay").prop("disabled",true);
				$("#close").click();
				
				picktimeSuccess('${MemTenVO.mem_name}' +�@'�w����'�@+ 
						'<fmt:formatDate value="${list.get(0).bill_date}" pattern="yyyyMM"/>' + '���b��ú�O');
			}
		});
	}else{
		Swal.fire({
			icon:'warning',
			title:'�Ч����H�Υd��g'
		});
	}
});

</script>

</body>

</html>
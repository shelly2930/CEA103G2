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

<title>帳單明細</title>

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
				
				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->

				<div class="row mb-4">
                   	<div class="col text-center"><h1>HowTrue好厝  房客電子帳單</h1></div>
                </div>
                <div class="row mb-3 pl-4 pr-4">
                	<div class="col-md-6">
                		<h3>期別 : <fmt:formatDate value="${list.get(0).bill_date}" pattern="yyyyMM"/>期<h3>
                	</div>
                	<div class="col-md-6"><h3>繳費期限 : ${list.get(0).bill_due}<h3></div>
                </div>
                <div class="row mb-3 pl-4">
                	<div class="col"><h4>會員姓名 : ${memTenSvc.getOneMemTen(list.get(0).mem_no).mem_name}</h4></div>
                </div>
                <div class="row pl-4 pr-4">
                	<table class="table table-bordered" style="background-color: #eeecec;">
                		<thead>
							<tr>
								<th colspan="5"><p class="font-weight-bold display-4 text-primary">租屋費用</p></th>
							</tr>
							<tr>
								<th scope="col">租屋物件名稱</th>
								<th scope="col">費用項目</th>
								<th scope="col">物件租金(每月)/單位價格(每度)</th>
								<th scope="col">計費期間/使用量(度)</th>
								<th scope="col">金額換算</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="billVO" items="${list}">
							<tr>
								<td rowspan="3">${houseSvc.getOneHouse(billVO.hos_no).hos_name}</td>
								<td>房屋租金</td>
								<td>${houseSvc.getOneHouse(billVO.hos_no).hos_rent}</td>
								<td>${billSvc.getHousePeriodAndMoney(billVO).get("period")}</td>
								<td>${billSvc.getHousePeriodAndMoney(billVO).get("money")}</td>
							</tr>
							<tr>
								<td>電費</td>
								<td>${houseSvc.getOneHouse(billVO.hos_no).hos_power}</td>
								<td>${billVO.bill_power}
			<%-- 									<c:choose> --%>
			<%-- 										<c:when test="${renFurAppVO.rfa_status == 3}">${billVO.bill_power}</c:when> --%>
			<%-- 										<c:when test="${isTMT == false}">出租中</c:when> --%>
			<%-- 									</c:choose> --%>
								</td>
								<td>
								<fmt:formatNumber value="${Math.round(houseSvc.getOneHouse(billVO.hos_no).hos_power * billVO.bill_power)}" pattern="#" />
								</td>
							</tr>
							<tr>
								<td>水費</td>
								<td>${houseSvc.getOneHouse(billVO.hos_no).hos_water}</td>
								<td>${billVO.bill_water}</td>
								<td>
								<fmt:formatNumber value="${Math.round(houseSvc.getOneHouse(billVO.hos_no).hos_water * billVO.bill_water)}" pattern="#" />
								
								</td>
							</tr>
							</c:forEach>
						
							<tr>
								<td></td>
								<td colspan="3" class="font-weight-bold">小計</td>
								<td class="house-subtotal"></td>
							</tr>
						</tbody>
						
						<c:if test="${not billSvc.getCurrentRenFurApp(list.get(0)).isEmpty()}">
						<thead>
							<tr>
								<th colspan="5"><p class="font-weight-bold display-4 text-primary">租家具費用</p></th>
							</tr>
							<tr>
								<th scope="col">租家具物件名稱</th>
								<th scope="col">家具名稱</th>
								<th scope="col">家具租金(每月)</th>
								<th scope="col">計費期間</th>
								<th scope="col">金額換算</th>
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
								<td colspan="3" class="font-weight-bold">小計</td>
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
							繳費
						</button>
                	</div>
                </div>
				
				<!-- Modal -->
				<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				  <div class="modal-dialog  modal-dialog-centered" data-backdrop="false" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalCenterTitle">帳單繳費</h5>
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
						    	<div style='display:none' class="col-4 align-items-center"><span>信用卡名稱:</span></div>
						    	<div style='display:none' class="col-4 align-items-center"><input type="text" name="name" placeholder="信用卡名稱"/></div>
						    </div>
						    <div class="row align-items-center mb-2">
						    	<div class="col-2"></div>
						    	<div class="col-3 align-items-center">信用卡卡號:</div>
						    	<div class="col-7 align-items-center"><input type="text" name="number" placeholder="卡號" required/></div>
						    </div>
<!-- 						    <div class='form-group row justify-content-center'> -->
<!-- 					      	 	<label for='newPassword' class='col-3 col-form-label'>信用卡卡號</label> -->
<!-- 							  	<div class='col-7'> -->
<!-- 									<input type='text' class='form-control' placeholder="卡號"  required> -->
<!-- 								</div> -->
<!-- 							</div> -->
						    <div class="row  align-items-center mb-2">
						    	<div class="col-2"></div>
						    	<div class="col-3 align-items-center"><span>到期日:</span></div>
						    	<div class="col-5 align-items-center"><input type="text" name="expiry" placeholder="到期日" required/></div>
						    </div>
						    <div class="row  align-items-center">
						    	<div class="col-2"></div>
						    	<div class="col-3 align-items-center"><span>安全碼:</span></div>
						    	<div class="col-5 align-items-center"><input type="text" name="cvc" placeholder="安全碼" required/></div>
						    </div>
						    <div class="row  align-items-center">
						    	<div class="col-5"></div>
						    	
						    	<div class="col-4 align-items-center"></div>
						    </div>
						</form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary pay-bill">繳費</button>
				      	<button type="button" class="btn btn-secondary" id="close" data-dismiss="modal">取消</button>
				      </div>
				    </div>
				  </div>
				</div>

				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
							
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
$(".total").children().text("總計：" + total + " 元");

if(${list.get(0).bill_p_status == 1}){
	$(".want-pay").text("已繳費");
	$(".want-pay").prop("disabled",true);
}

var card = new Card({
	form: 'form',
	container: '.card-wrapper',
	placeholders: {
	number: '**** **** **** ****',
	name: '信用卡名稱',
	expiry: 'mm/yyyy',
	cvc: '***'
	}
});
// picktimeSuccess("前送後");
// picktimeSuccess("後送前會員", "會員編號");
// pick("後送後");

$(".pay-bill").click(function(){
	if($("input[name='number']").val() != '' && $("input[name='expiry']").val() != '' && $("input[name='cvc']").val() != ''){
		Swal.fire({
			title: '確定繳交帳單金額 $' + total +' ?',
	// 		text: "總金額 $" + total,
			icon: 'info',
			showCancelButton: true,
	//			confirmButtonColor: '#d33',
	//			cancelButtonColor: '#3085d6',
			confirmButtonText: '確定',
			cancelButtonText: '取消'
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
					title:'繳費成功',
					showConfirmButton: false,
					timer: 1000
				});
				
				$(".want-pay").text("已繳費");
				$(".want-pay").prop("disabled",true);
				$("#close").click();
				
				picktimeSuccess('${MemTenVO.mem_name}' +　'已完成'　+ 
						'<fmt:formatDate value="${list.get(0).bill_date}" pattern="yyyyMM"/>' + '期帳單繳費');
			}
		});
	}else{
		Swal.fire({
			icon:'warning',
			title:'請完成信用卡填寫'
		});
	}
});

</script>

</body>

</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*" %>

<%--    <% @SuppressWarnings("unchecked") --%>
<%--    Vector<RentCartItem> rentCartList = (Vector<RentCartItem>) session.getAttribute("rentCartList");%> --%>
    
<!DOCTYPE html>
<html>
<head>
<title>���ɩ���</title>
<!-- =================�M��bootstrap�n�ϥΥH�U=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<style>

.breadcrumb_bg {
    background-image: url(<%=request.getContextPath()%>/unprotected/furniture/images/FurniturePage.jpg)!important;
    background-position: bottom -300px right 0px!important;
    background-repeat: no-repeat;
    background-size: cover;
}

	.plus{
			cursor:pointer;
			width:10px;
			height:10px;
			background:#f2f2f2;
			border-radius:4px;
			padding:6px 5px 10px 5px;
			border:1px solid #ddd;
      		display: inline-block;
      		vertical-align: middle;
     		 text-align: center;
		}
.btn_1 {
    background-color: #61d2b4 !important;
    border: 1px solid #61d2b4 !important;
    color: #fff;
    box-shadow: -1.717px 8.835px 29.76px 2.24px rgb(97 210 180 / 18%) !important;
    border: 1px solid #61d2b4 !important;
}

.btn_1:hover {
    background-color: #fff !important;
    border: 1px solid #61d2b4 !important;
    color: #61d2b4 !important;
    box-shadow: -1.717px 8.835px 29.76px 2.24px rgb(97 210 180 / 18%) !important;
    border: 1px solid #61d2b4 !important;
}

</style>

</head>
<body>
<!-- include�����C -->
<%@include file="/front-end/header.file"%>	
<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<body>
<!-- <body onload="connect();connectNotice();" onunload="disconnect();disconnectNotice();"> -->
<!-- �����C�U�Ϥ� -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                           <h2>HowTrue</h2>
                            <p style="color:white;">Rent Furniture<span style="color:white;">-</span> for Your House</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
 <!--================End Home Banner Area =================-->
    <!--================Cart Area =================-->
    <!-- ���ɩ��� -->
    <section class="cart_area padding_top">
        <div class="container">
            <div class="cart_inner">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col" style="text-indent:150px;" colspan="2">�a��~��</th>
                                <th scope="col" style="text-indent:-10px;">�C�믲��</th>
                                <th scope="col" style="text-indent:20px;">���μƶq</th>
                                <th scope="col">�p�p</th>
                                <th scope="col">&nbsp&nbsp&nbsp�R��</th>
                            </tr>
                        </thead>
 <%if (rentCartList == null || (rentCartList.size() == 0)) {%>  
					 
					 <tr>
					 <td colspan="6" style="text-align:center;">�ثe�|�L���Ϋ~��!</td>
					 </tr>
 
 					</table>
                    <!-- �~���ʪ��ε��b�϶� �}�l -->
                    <div class="checkout_btn_inner float-right">
                        <a class="btn_1"   style="cursor:pointer;color:white;" href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte">�~���s���a��</a>
                    </div>
                    

                    <!-- �~���ʪ��ε��b�϶� ���� -->
                </div>
            </div>
    </section>
 <%@ include file="/front-end/footer.file"%>
 <%}%>                         
<%if (rentCartList != null && (rentCartList.size() > 0)) {%> 
<%-- <% --%>
<!-- // 	 for (int index = 0; index < rentCartList.size(); index++) { -->
<!-- // 	 RentCartItem rentItem = rentCartList.get(index); -->
<%-- %>                --%>
<jsp:useBean id="furPhoSvc" scope="page" class="com.furPho.model.FurPhoService" />
<c:forEach var="rentItem"  items="${rentCartList}"  varStatus="r">
                        <!-- ���ɩ��Ӷ}�l  �Ѧ��}�l�`�� -->
                        <tr>
                           <td>
                           		<a href="<%=request.getContextPath()%>/furIte/furIte.do?fnt_it_no=${rentItem.fnt_it_no}&action=getOneFurIteToFE" >
                                <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFirstFnt_pic_no(rentItem.fnt_it_no)}"  width="111" height="120">
                            </td>
                            <td>
                                <div class="media">
                                    <div class="d-flex">
                                        <img src="img/product/single-product/cart-1.jpg" alt="" />
                                    </div>
                                    <div class="media-body">
<%--                                         <p><%=rentItem.getFnt_name()%></p> --%>
                                        <p id="fntName${r.index}" >${rentItem.fnt_name}</p>
                                        <input type="hidden" id="fntNo${r.index}" value="${rentItem.fnt_it_no}">
                                    </div>
                                </div>
                            </td>
                            <td>
                                <h5 id="fntPrice${r.index}" >$${rentItem.fnt_price}</h5>
                            </td>
<!--        ������              ���Ϭ��վ�a��~���ƶq ������   -->
                            <td>
                            
                            <jsp:useBean id="furIteSvc" scope="page" 	class="com.furIte.model.FurIteService" />
                            <div>
									<span class="minus"  id="down${r.index}" style="	cursor:pointer;width:10px;height:10px;background:#f2f2f2;	border-radius:4px;padding:4px 20px 20px 6px;border:1px solid #ddd;display: inline-block;vertical-align: middle;text-align: center;">�@</span>
									<input class="number" id="quan${r.index}" type="text" 	disabled="disabled" value="${rentItem.quantity>furIteSvc.getOneFurIte(rentItem.fnt_it_no).fnt_unrent?furIteSvc.getOneFurIte(rentItem.fnt_it_no).fnt_unrent:rentItem.quantity}" 
									             style="background:white;height:28px;width:40px;text-align:center;font-size:15px;border:1px solid #ddd;border-radius:4px;display: inline-block;vertical-align: middle;">
										<input type="hidden" id="max${r.index}" value="${furIteSvc.getOneFurIte(rentItem.fnt_it_no).fnt_unrent}">
									<span class="plus"   id="up${r.index}" style="cursor:pointer;width:20px;height:10px;background:#f2f2f2;border-radius:4px;padding:4px 20px 20px 6px;border:1px solid #ddd;display: inline-block;vertical-align: middle;text-align: center;">�Q</span>
							</div>
                            </td>
 <!--        ������             ���Ϭ��վ�a��~���ƶq   ������ -->
                            <td>
                                <h5 id="subtotal${r.index}"></h5>
                            </td>
                            <!-- �������� �[�J�U������ �������� -->
                            <td>
                                <div class="">
                                    <ul class="list-inline justify-content-center">
                                        <span>&nbsp&nbsp&nbsp&nbsp<span>
                                                <li class="list-inline-item">
                                                    <input type="hidden" id="${r.index}">
                                                    <a data-toggle="tooltip" data-placement="top" title="�R�����~��" class="delete"  data-original-title="Delete" id="del${r.index}" style="color:pink;cursor:pointer;">
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </li>
                                    </ul>
                                </div>
                            </td>
                            <!-- ���������� �[�J�U������ �������� -->
                        </tr>
</c:forEach>

                        <!-- �������}�l��ܩ��ӦX�p -->
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <h5>�믲���X�p</h5>
                            </td>
                            <td>
                                <h5 id="getTotal"></h5>
                            </td>
                            <td>
                                        <div class="">
                                    <ul class="list-inline justify-content-center">
                                        <span>&nbsp&nbsp&nbsp&nbsp<span>
                                                <li class="list-inline-item">
                                                    <a data-toggle="tooltip" data-placement="top" title="�����R��" class="deleteAll"  data-original-title="Delete" id="deleteAll" style="color:pink;cursor:pointer;">
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </li>
                                    </ul>
                                </div>
                             </td>
                        </tr>
                        <!-- ��ܩ��ӦX�p���� -->
<!--                         </tbody> -->
                    </table>
                    <!-- �~���ʪ��ε��b�϶� �}�l -->

                    <div class="checkout_btn_inner float-right">
                        <a class="btn_1" href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte" style="color:white;" >�~���s���a��</a>
                        <a class="btn_1 checkout_btn_1" style="cursor:pointer;color:white;"  id="nextStep">�U�@�B</a>
                         <jsp:useBean id="renConSvc" scope="page" class="com.renCon.model.RenConService" />
                         <input type="hidden" id="mem_rent_qua" value="${renConSvc.getMemRentQua(MemTenVO.mem_no)}">
                         <input type="hidden" id="rent_mem_no" value="${MemTenVO.mem_no}">
                    </div>
                    

                    <!-- �~���ʪ��ε��b�϶� ���� -->
                </div>
            </div>
    </section>
    <%@ include file="/front-end/footer.file"%>
<%}%>
<%-- <%@ include file="/front-end/footer.file"%> --%>


<!-- JS ajax -->
<!-- <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript">
$(document).ready(function(){
		getOrinSubtotal(); 
		getTotalPrice();
	$(".delete").each(function(index){
		$("#del"+index+"").click(function(e){
			let delNo=$("#del"+index+"").prev().attr("id");
			
			Swal.fire({
				  title: '�T�w�R�����~��?',
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '�T�w',
				  cancelButtonText: "����"
				}).then((result) => {
				 
					if (result.isConfirmed) {
						if (result.value) {
							$.ajax({
								type: "POST",
								url: "<%=request.getContextPath()%>/rentCart/rentCart.do",	
								data: {					
									del: delNo,
									action: "DELETE",
								},
								success:function(){
									Swal.fire({
						   				 position:'center',	 
						   				  icon:'success',
						   			      title:'�w�������~��!',
						   			      showConfirmButton:false,
						   			      timer:1500
									});
									setTimeout(function(){
										$(location).prop('href', '<%=request.getContextPath()%>/front-end/furIte/rentCart.jsp'); 
									},1500);
					   			 }
				  			})
						 }
					}
				})
			})
		})	
	$("#deleteAll").click(function(e){
		Swal.fire({
			  title: '�T�w�R���Ҧ�����?',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '�T�w',
			  cancelButtonText: "����"
			}).then((result) => {
				
				if (result.isConfirmed) {
					if (result.value) {
						$.ajax({
							type: "POST",
							url: "<%=request.getContextPath()%>/rentCart/rentCart.do",	
							data: {					
								action: "DeleteAll",
							},
							success:function(){
								Swal.fire({
									position:'center',	 
						   		    icon:'success',
						   			title:'�w�R���Ҧ��~��!',
						   			showConfirmButton:false,
						   			timer:1500
						   			});
								
								setTimeout(function(){
									$(location).prop('href', '<%=request.getContextPath()%>/front-end/furIte/rentCart.jsp'); 
									},1500);
				   			 }
			  			})
					 }
				}
			})
	});
		
	
	$(".number").each(function(index){
		$("#down"+index+"").click(function(e){
			var count=parseInt($("#quan"+index+"").val())-1;
			count=count<1?1:count;
			$("#quan"+index+"").val(count);
			let fntNoMinus=$("#fntNo"+index+"").val();
			let fntPrice=$("#fntPrice"+index+"").html().substring(1);
			let newQuantity=$("#quan"+index+"").val();
			getOrinSubtotal();
			getTotalPrice();
			
			$.ajax({
				type:"POST",
				url:"<%=request.getContextPath()%>/rentCart/rentCart.do",
				data:{
					"action":"changeQuantity",
		        	"fnt_it_no":fntNoMinus,
					"newQuantity":newQuantity,
				},
			});
		});	
	});	
	$(".number").each(function(index){
		$("#up"+index+"").click(function(e){
			var max=$("#max"+index+"").val();
			var count=parseInt($("#quan"+index+"").val())+1;
			let fntNoPlus=$("#fntNo"+index+"").val();
			let fntPrice=$("#fntPrice"+index+"").html().substring(1);
			$("#quan"+index+"").val(count);
			let newQuantity=$("#quan"+index+"").val();

			if (count> max) {
				$("#quan"+index+"").val(max);
				newQuantity=$("#quan"+index+"").val();
	    		Swal.fire("�ܩ�p!<br>�ثe�̦h�ȯണ��"+ max+"�ӯ���!");
	    	}
			getOrinSubtotal();	
			getTotalPrice()
			
			$.ajax({
				type:"POST",
				url:"<%=request.getContextPath()%>/rentCart/rentCart.do",
				data:{
					"action":"changeQuantity",
		        	"fnt_it_no":fntNoPlus,
					"newQuantity":newQuantity,
				},
			});
		});	
	});	
	$("#nextStep").click(function(e){
		let status=parseInt($("#mem_rent_qua").val());
		if(status===2){
			let rent_mem_no=parseInt($("#rent_mem_no").val());
			$.ajax({
				type:"POST",
				url:"<%=request.getContextPath()%>/rentCart/rentCart.do",
				data:{
					"action":"CHECKOUT",
		        	"rent_mem_no":rent_mem_no,
				},
				success:function(data){
						if(data==1){					
						setTimeout(function(){
							$(location).prop('href', '<%=request.getContextPath()%>/front-end/furIte/checkout.jsp'); 
						},300);
					}else{
						Swal.fire("�ܩ�p�I<br>�a�㯲�ɶȴ��Ѥ@�P���w���A�Щ�J���@�P���A���X�ӽСA���¡I");
					}
	   			 }
			});
		}else if(status==1){
			Swal.fire("�ܩ�p�I<br>�Х��������ΦX��ú�O����A�A���ήa��A���¡I");
		}else if(status==0){
			Swal.fire("�ܩ�p�I<br>�ѩ�z�����ΥӽХ��b�f�֤��A�Ыݧ����f�֤ΦX��ú�O�����A�A���ήa��A���¡I");
		}else{
			Swal.fire("�ܩ�p�I<br>�Х��������Τ���A�A���ήa��A���¡I");
		}
	})
	
// 	mem_rent_qua
});

	
	//���J�ɤp�p
	function getOrinSubtotal(){
		$('.number').each(function(index){
			let fntPrice=$("#fntPrice"+index+"").html().substring(1);
			let orinQuan=$("#quan"+index+"").val();
			let OrinSubtotal = orinQuan*fntPrice;
			$("#subtotal"+index+"").html("$"+OrinSubtotal);
		})
	}
	
	function getTotalPrice(){
	var totalprice = 0;
	$('.number').each(function(index){
		var eachSubtotal = parseInt($("#subtotal"+index+"").html().substring(1));
		totalprice = totalprice +eachSubtotal;
		$("#getTotal").html("$"+totalprice);
	})
	}	


</script>



</body>
</html>
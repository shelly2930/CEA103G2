<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*" %>

<%--    <% @SuppressWarnings("unchecked") --%>
<%--    Vector<RentCartItem> rentCartList = (Vector<RentCartItem>) session.getAttribute("rentCartList");%> --%>
    
<!DOCTYPE html>
<html>
<head>
<title>租借明細</title>
<!-- =================套用bootstrap要使用以下=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<style>

.breadcrumb_bg {
    background-image: url(<%=request.getContextPath()%>/unprotected/furniture/images/Morandi2.jpg)!important;
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

</style>

</head>
<body>
<!-- include導覽列 -->
<%@include file="/front-end/header.file"%>	
<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<body>
<!-- <body onload="connect();connectNotice();" onunload="disconnect();disconnectNotice();"> -->
<!-- 導覽列下圖片 -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Welcome  好厝家具專區</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
 <!--================End Home Banner Area =================-->
    <!--================Cart Area =================-->
    <!-- 租借明細 -->
    <section class="cart_area padding_top">
        <div class="container">
            <div class="cart_inner">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col" style="text-indent:150px;" colspan="2">家具品項</th>
                                <th scope="col" style="text-indent:-10px;">每月租金</th>
                                <th scope="col" style="text-indent:20px;">租用數量</th>
                                <th scope="col">小計</th>
                                <th scope="col">&nbsp&nbsp&nbsp刪除</th>
                            </tr>
                        </thead>
 <%if (rentCartList == null || (rentCartList.size() == 0)) {%>  
					 
					 <tr>
					 <td colspan="6" style="text-align:center;">目前尚無租用品項!</td>
					 </tr>
 
 					</table>
                    <!-- 繼續購物或結帳區塊 開始 -->
                    <div class="checkout_btn_inner float-right">
                        <a class="btn_1" href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte">繼續瀏覽家具</a>
                    </div>
                    

                    <!-- 繼續購物或結帳區塊 結束 -->
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
                        <!-- 租借明細開始  由此開始循環 -->
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
<!--        ↓↓↓              此區為調整家具品項數量 ↓↓↓   -->
                            <td>
                            
                            <jsp:useBean id="furIteSvc" scope="page" 	class="com.furIte.model.FurIteService" />
                            <div>
									<span class="minus"  id="down${r.index}" style="	cursor:pointer;width:10px;height:10px;background:#f2f2f2;	border-radius:4px;padding:4px 20px 20px 6px;border:1px solid #ddd;display: inline-block;vertical-align: middle;text-align: center;">一</span>
									<input class="number" id="quan${r.index}" type="text" 	disabled="disabled" value="${rentItem.quantity>furIteSvc.getOneFurIte(rentItem.fnt_it_no).fnt_unrent?furIteSvc.getOneFurIte(rentItem.fnt_it_no).fnt_unrent:rentItem.quantity}" 
									             style="background:white;height:28px;width:40px;text-align:center;font-size:15px;border:1px solid #ddd;border-radius:4px;display: inline-block;vertical-align: middle;">
										<input type="hidden" id="max${r.index}" value="${furIteSvc.getOneFurIte(rentItem.fnt_it_no).fnt_unrent}">
<!-- 									<input class="number"  type="text" 	value="1" style="height:24px;width:20px;text-align:center;"> -->
									<span class="plus"   id="up${r.index}" style="cursor:pointer;width:20px;height:10px;background:#f2f2f2;border-radius:4px;padding:4px 20px 20px 6px;border:1px solid #ddd;display: inline-block;vertical-align: middle;text-align: center;">十</span>
							</div>
<!--                                 <div class="product_count"> -->
<!-- <!--                                 減少數量 --> 
<%--                                     <span class="input-number-decrement"  id="ti-angle-down${r.index}"> <i class="ti-angle-down"></i></span> --%>
<%--                                     <input class="input-number" type="text" value="${rentItem.quantity}" min="0" max="${furIteSvc.getOneFurIte(rentItem.fnt_it_no).fnt_unrent}"> --%>
<%-- <%--                                     <input class="input-number" type="text" value="<%=rentItem.getQuantity()%>" min="0" max=""> --%>
<!-- <!--                                     增加數量 --> 
<%--                                     <span class="input-number-increment" id="ti-angle-up${r.index}"> <i class="ti-angle-up" ></i></span> --%>
<!--                                 </div> -->
                            </td>
 <!--        ↑↑↑             此區為調整家具品項數量   ↑↑↑ -->
                            <td>
                                <h5 id="subtotal${r.index}"></h5>
                            </td>
                            <!-- ↓↓↓↓ 加入垃圾桶元件 ↓↓↓↓ -->
                            <td>
                                <div class="">
                                    <ul class="list-inline justify-content-center">
                                        <span>&nbsp&nbsp&nbsp&nbsp<span>
                                                <li class="list-inline-item">
                                                    <input type="hidden" id="${r.index}">
                                                    <a data-toggle="tooltip" data-placement="top" title="刪除此品項" class="delete"  data-original-title="Delete" id="del${r.index}" style="color:pink;cursor:pointer;">
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </li>
                                    </ul>
                                </div>
                            </td>
                            <!-- ↑↑↑↑↑ 加入垃圾桶元件 ↑↑↑↑ -->
                        </tr>
</c:forEach>

                        <!-- 此部分開始顯示明細合計 -->
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <h5>月租金合計</h5>
                            </td>
                            <td>
                                <h5 id="getTotal"></h5>
                            </td>
                            <td>
                                        <div class="">
                                    <ul class="list-inline justify-content-center">
                                        <span>&nbsp&nbsp&nbsp&nbsp<span>
                                                <li class="list-inline-item">
                                                    <a data-toggle="tooltip" data-placement="top" title="全部刪除" class="deleteAll"  data-original-title="Delete" id="deleteAll" style="color:pink;cursor:pointer;">
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </li>
                                    </ul>
                                </div>
<!--                             		<a href="#" class="btn btn-danger btn-icon-split"> -->
<!--                                         <span class="icon text-white-50"> -->
<!--                                             <i class="fas fa-trash"></i> -->
<!--                                         </span> -->
<!--                                         <span class="text" style="color:white;">清空</span> -->
<!--                                     </a> -->
                             </td>
                        </tr>
                        <!-- 顯示明細合計結束 -->
<!--                         </tbody> -->
                    </table>
                    <!-- 繼續購物或結帳區塊 開始 -->
                    <div class="checkout_btn_inner float-right">
                        <a class="btn_1" href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte">繼續瀏覽家具</a>
                        <a class="btn_1 checkout_btn_1" href="#">下一步</a>
                    </div>
                    

                    <!-- 繼續購物或結帳區塊 結束 -->
                </div>
            </div>
    </section>
    <%@ include file="/front-end/footer.file"%>
<%}%>
<%-- <%@ include file="/front-end/footer.file"%> --%>


<!-- JS ajax -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript">
$(document).ready(function(){
		getOrinSubtotal(); 
		getTotalPrice();
	$(".delete").each(function(index){
		$("#del"+index+"").click(function(e){
			let delNo=$("#del"+index+"").prev().attr("id");
			
			Swal.fire({
				  title: '確定刪除此品項?',
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '確定',
				  cancelButtonText: "取消"
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
						   			      title:'已移除此品項!',
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
			  title: '確定刪除所有項目?',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '確定',
			  cancelButtonText: "取消"
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
						   			title:'已刪除所有品項!',
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
			alert(count);
			alert(newQuantity);
			if (count> max) {
				$("#quan"+index+"").val(max);
				newQuantity=$("#quan"+index+"").val();
	    		Swal.fire("很抱歉!<br>目前最多僅能提供"+ max+"個租用!");
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
	
});

	
	//載入時小計
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
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*" %>
<%@ page import="com.renCon.model.*" %>
<%@ page import="com.memTen.model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
		RenConService renConSvc=new RenConService();
		List<RenConVO> memHouList=new ArrayList<RenConVO>();
		SimpleDateFormat df = new SimpleDateFormat( "yyyy-MM-dd" );
		java.sql.Timestamp rent_app_due = new java.sql.Timestamp(System.currentTimeMillis() + 7 * 24 * 60 * 60 * 1000);
		String strRent_app_due=df.format(rent_app_due);
		MemTenVO memTenVO=(MemTenVO) session.getAttribute("MemTenVO");
		Integer mem_no=memTenVO.getMem_no();
		memHouList=renConSvc.getDelHosNo(mem_no,strRent_app_due);
		pageContext.setAttribute("memHouList",memHouList);
%>
    
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

	  .xdsoft_datetimepicker .xdsoft_datepicker{
	           width:  300px;   /* width:  300px; */
	  }
	  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box{
	           height: 151px;   /* height:  151px; */
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
                            <h2>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Welcome  �n��a��M��</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
 <!--================End Home Banner Area =================-->
<%if (rentCartList != null && (rentCartList.size() > 0)) {%> 

<section class="checkout_area padding_top">
    <div class="container">
      <div class="returning_customer">
       
            <p> 
         �˷R�� ${MemTenVO.mem_name} �z�n�G<br>
         
         �п�ܮa��B�e�a�I�ΰt�e�ɶ��A�ýT�{�U�C���ɫ~����T�O�_���T�G
        </p>
     
              <div class="col-md-12 form-group p_star">
	              <div class="col-lg-8">
	                <input type="hidden" id="memTenNo" value="${MemTenVO.mem_no}">
						 <jsp:useBean id="houseSvc" scope="page" class="com.house.model.HouseService" />
		 				  <jsp:useBean id="renConSvc2" scope="page" class="com.renCon.model.RenConService" />
					<select class="form-control" name="county">     
	              			<option value="0">��ܹB�e�a�I</option>
	              		<c:forEach var="renConVO" items="${memHouList}" >
	              			<option value="${renConVO.rtct_no}" data-index="0">	
	              			${houseSvc.getOneHouse(renConSvc2.getOneRenCon(renConVO.rtct_no).hos_no).hos_address}${houseSvc.getOneHouse(renConSvc2.getOneRenCon(renConVO.rtct_no).hos_no).hos_floor}��	
							</option>  
	        			</c:forEach>
	        		</select>
	        		</div>
	        		<br>
		      		<div class="col-lg-8">
		      		<input type="text" name="rfa_order_date" id="rfa_order_date" placeholder="��ܰt�e�ɶ�" required="" class="form-control" >
		      		</div>
      		</div>
      
        <div class="row">
        <div class="col-lg-12">
          <div class="order_box">
            <h3>���ɩ���</h3>
            <table class="table table-borderless">
              <thead>
                <tr>
                  <th scope="col" colspan="2">�a��~��</th>
                  <th scope="col">���μƶq</th>
                  <th scope="col">�C�믲��</th>
                  <th scope="col">�p�p</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="rentItem"  items="${rentCartList}"  varStatus="r">
	                <tr>
	                  <td colspan="2"><a class="number"  href="<%=request.getContextPath()%>/furIte/furIte.do?fnt_it_no=${rentItem.fnt_it_no}&action=getOneFurIteToFE" id="fntName${r.index}" >${rentItem.fnt_name}</a></td>
	                  <td id="quan${r.index}" >x${rentItem.quantity}</td>
	                  <td id="fntPrice${r.index}" >$${rentItem.fnt_price}</td>
	                  <td id="subtotal${r.index}"></td>
	                  <input type="hidden" id="fntNo${r.index}" value="${rentItem.fnt_it_no}">
	                </tr>
               </c:forEach>
              </tbody>
              <tfoot>
             <tr>
                  <th colspan="3"></th>
                  <th><b><span style="color:black;">�믲���X�p</span></b></th>
                  <th><b><span id="getTotal" style="color:black;"></span></b></th>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>
      </div>
      
      <br>
      	<div class="col-lg-2" style="float:right;"> 
             	<a class="btn_3" href="#" id="submitRentApp">�e�X�q��</a> 
        </div> 
      	<div class="col-lg-2" style="float:right;"> 
             	<a class="btn_3" href="<%=request.getContextPath()%>/front-end/furIte/rentCart.jsp">�W�@�B</a> 
       	</div> 
             
    </div>
    
  </section>


    <%@ include file="/front-end/footer.file"%>
<%}%>

<!-- JS ajax -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
$(document).ready(function(){
		getOrinSubtotal(); 
		getTotalPrice();
});
	$("#submitRentApp").click(function(e){
		let memTenNo=$("#memTenNo").val();	
		let rfa_order_date=$("#rfa_order_date").val();
		let rfa_total=parseInt($("#getTotal").html().substring(1));
		let  rfa_apct_date = getRfa_apct_date();
		
		if($("select").val()==0){
			Swal.fire({
				  icon: 'error',
				  title: '�п�ܮa��t�e�a�}�I',
				})
		}else if(!$("#rfa_order_date").val()){
			Swal.fire({
				  icon: 'error',
				  title: '�п�ܮa��t�e�ɶ��I',
				})
		}else{
			Swal.fire({
				  title: '�T�w�e�X���ɭq��H',
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
								type:"POST",
								url:"<%=request.getContextPath()%>/rentCart/rentCart.do",
								data:{
									"action":"submitRentApp",
						        	"memTen_no":memTenNo,
						        	"rfa_order_date":rfa_order_date,
						        	"rfa_total":rfa_total,
						        	"rfa_apct_date":rfa_apct_date,
						        	"rfa_status":'0',
								},
								success:function(){
									Swal.fire({
										position:'center',	 
							   		    icon:'success',
							   			title:'���ɭq��w�e�X�I',
							   			showConfirmButton:false,
							   			timer:1500
							   			});
									
									setTimeout(function(){
										$(location).prop('href', '<%=request.getContextPath()%>/index.jsp'); 
										},1500);
					   			 }
				  			})
						 }
					}
				})
			
			
		}

		
	})
	
	//���J�ɤp�p
	function getOrinSubtotal(){
		$('.number').each(function(index){
			let fntPrice=$("#fntPrice"+index+"").html().substring(1);
			let orinQuan=$("#quan"+index+"").html().substring(1);
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

	function getRfa_apct_date() {  
	    var date=new Date();
		var y = date.getFullYear();  
	    var m = date.getMonth() + 1;  
	    m = m < 10 ? ('0' + m) : m;  
	    var d = date.getDate();  
	    d = d < 10 ? ('0' + d) : d;  
	    var h = date.getHours();  
	    var minute = date.getMinutes();  
	    minute = minute < 10 ? ('0' + minute) : minute;  
	    return y + '/' + m + '/' + d+' '+h+':'+minute;  
	};  
<!-- ====�H�U�� datetimepicker �������]�w====-->
      
        $.datetimepicker.setLocale('zh');
        var appStartDate = new Date();
        appStartDate.setTime(appStartDate.getTime()+2*24*60*60*1000);
        var appDueDate = new Date();
        appDueDate.setTime(appDueDate.getTime()+7*24*60*60*1000);
        $('#rfa_order_date').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:true,       //timepicker:true,
 	       step: 60,                //step: 60 (�o�Otimepicker���w�]���j60����)
 	       ormat:'Y-m-d H:i:s',      //format:'Y-m-d H:i:s',
<%--  		   value: '<%=memTenVO.getMem_birthday()%>', // value:   new Date(), --%>
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           startDate:	           appStartDate,  // �_�l��
           minDate:               appStartDate, // �h������(���t)���e
           maxDate:               appDueDate // �h������(���t)����
        });
        
</script>
</body>
</html>
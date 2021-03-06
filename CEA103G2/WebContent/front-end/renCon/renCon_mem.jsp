<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>合約</title>

</head>









<!-- =================================下面是導覽列==================================================== --> 
<%@include file="/front-end/header.file"%>
<!-- =================================上面是導覽列==================================================== --> 

<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<link type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/south-street/jquery-ui.css" rel="stylesheet"> 
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

<link type="text/css" href="<%=request.getContextPath()%>/template_front-end/forRenCon/css/jquery.signature.css" rel="stylesheet"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/template_front-end/forRenCon/js/jquery.signature.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="<%=request.getContextPath()%>/template_front-end/card-master/dist/card.js"></script>
<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<style>
.kbw-signature { width: 400px; height: 200px; }
.breadcrumb_bg {
    background-image: url(<%=request.getContextPath()%>/front-end/renCon/image/contract02.jpg);
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}
</style>
<body >
<!-- ======圖片 -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2 class='text-center text-white'>Signature </h2>
                            <h5 class='text-center text-white'>會員</h5>
                            <h3 class='text-center text-white'>${MemTenVO.mem_name} 你好 !</h3>
                            <h5 class='text-center text-white'> 確認後簽名 </h5>
                            <h5 class='text-center text-white'>並繳費</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
<!-- /****** CONTAINER *****/     -->
 	<section class="confirmation_part padding_top" style="padding-top:0px">
		<div class="container">
	            <div class="row">
					<div class="col-lg-12">
                        <div class="order_details_iner text-center">
                            <h3 style='font-weight:bold'>確認後 簽名 
                            </h3>
                           <div id='show'></div>
                               	<p style="clear: both;">
									<button class='btn-outline-success btn btn-sm' id="clear">Clear</button> 
									<button class='btn-outline-success btn btn-sm' id="send">確認送出</button>
								</p>
                        </div>
					</div>
				</div>
            </div>
    	</section>
    	
		        
		        
		        
    	
		<!-- Modal -->
		<div class="modal fade" id="showcard" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog  modal-dialog-centered" data-backdrop="false" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalCenterTitle">Credit Crad 繳 費</h5>
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
				    <div class="row  align-items-center">
				    	<div class="col-2"></div>
				    	<div class="col-4 align-items-center"><span>信用卡卡號:</span></div>
				    	<div class="col-4 align-items-center"><input type="text" name="number" placeholder="卡號" required/></div>
				    </div>
				    <div class="row  align-items-center">
				    	<div class="col-2"></div>
				    	<div class="col-4 align-items-center"><span>到期日:</span></div>
				    	<div class="col-4 align-items-center"><input type="text" name="expiry" placeholder="到期日" required/></div>
				    </div>
				    <div class="row  align-items-center">
				    	<div class="col-2"></div>
				    	<div class="col-4 align-items-center"><span>安全碼:</span></div>
				    	<div class="col-4 align-items-center"><input type="text" name="cvc" placeholder="安全碼" required/></div>
				    </div>
				    <div class="row  align-items-center">
				    	<div class="col-5"></div>
				    	
				    	<div class="col-4 align-items-center"></div>
				    </div>
				</form>
		      </div>
		      <div class="modal-footer">
		      	<div class='col-8'></div>
		        <div class="col-4 align-items-center">
		        <button id='cancelcard' style="display:inline-block;" class="btn btn-outline-success btn-sm">取 消</button>
		        <button id='sendcard' style="display:inline-block;" class="btn btn-outline-success btn-sm">繳 費</button>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
	    	
    	<script>

    	</script>
    	
		<img id='s' src=''>
    	 
    	<script type="text/javascript">
    	
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
    	let url = location.href;
    	let con_no = url.substring(url.indexOf('?')+8);
    	var sig =$('#show').signature();
    	
    	$('#clear').click(function() {
    		sig.signature('clear');
    	});
    	$('#send').click(function() {
    		Swal.fire({
				  title: 'Recheck',
				  text: "結帳後將不能修改",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#6495ed',
				  cancelButtonColor: '#fa8072',
				  confirmButtonText: '確定送出',
				  cancelButtonText:'返回',
				  confirmButtonClass:'btn-sm',
				  cancelButtonClass:'btn btn-info btn-sm',
				}).then((result) => {
				  if (result.isConfirmed) {
		    		$.ajax({
		    			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
		    			type:'post',
		    			data:{
		    				action:'savePic',
		    				con_no:con_no,
		    				base:sig.signature('toDataURL', 'image/jpeg', 0.8).substring(23),
		    			},
		    			success:function(){
		    				console.log($(this).status)
		    			}
		    		})
		    		let str = "請再次確認以下，確認後繳費<br><p style='color:red;font-weight:bold'>物件名稱: "+getHouse(getCon(con_no).hos_no).hos_name+"</p>";
		    		str+="<p style='color:red;font-weight:bold'>物件金額: "+getHouse(getCon(con_no).hos_no).hos_rent+" 元</p>";
		    		
		    		$("#money").html(str);
		    		$('#showcard').modal('show');
		    		$('#cancelcard').click(function(){
		    			document.location.href = "<%=request.getContextPath()%>/index.jsp";
		    		})
		    		$('#sendcard').click(function(){
		    			$.ajax({
			    			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
			    			type:'post',
			    			data:{
			    				action:'updateStatus',
			    				con_no:con_no,
			    				status:'2'
			    			},
			    			success:function(){
			    				let hos = getCon(con_no).hos_no;
			    				pullorpush(hos,"2");
			    				updateTheHouseStatus(hos);
			    				console.log("繳費成功");
			    				let mm = ${MemTenVO.mem_no};
			    				let mes ="會員:"+mm+"對物件"+hos+"已經簽約並繳費完成";
			    				picktimeSuccess(mes);
			    			}
			    		});
		    			 
		    			
			    		Swal.fire({
									  title: '已成功租屋!',
									  html:'將可在預定日期入住<br>將再5秒後回首頁',
									  confirmButtonColor: '#6495ed',
									  confirmButtonText: '確定預約',
									  confirmButtonClass:'btn-sm ',
						})
						window.setTimeout(function(){
							document.location.href = "<%=request.getContextPath()%>/index.jsp";
						},5000);
		    			
		    		})
				  }else{
				  	
				  }
			})
//     		$("#s").attr('src',sig.signature('toDataURL', 'image/jpeg', 0.8));
    	});
    	
    	function pullorpush(hos_no,hos_state){
    		$.ajax({
        		url:"<%=request.getContextPath()%>/HouseJsonServlet",
         		type:'post',
         		data:{
         			action:'pullorpush',
         			houseno:hos_no,
         			state:hos_state
         		},
         		success:function(b){
         			console.log(b);
         		}
         	})
    	}
    	function getCon(conno){
    		let convo={};
    		$.ajax({
    			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
    			type: 'post',
    			data:{
    				action:'getOneCon',
    				con_no:conno,
    			},
    			async:false,
    			success:function(con){
    				convo= con;
    			}
    		})
    		return convo;
    	}
    	function getMem(mem_no){
    		let mem = {};
    		$.ajax({
    			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
    			type: 'post',
    			data:{
    				action:'getOneMemten',
    				mem_no:mem_no,
    			},
    			async:false,
    			success:function(memvo){
    				for(let key in memvo){
    					mem[key]=memvo[key];
    				}
    				console.log(memvo)
    			}
    		})
    		return mem;
    	}
    	function getHouse(hos_no){
    		let hosvo={};
    		$.ajax({
    			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
    			type: 'post',
    			data:{
    				action:'getOneHouse',
    				houseno:hos_no,
    			},
    			async:false,
    			success:function(hos){
    				hosvo= hos;
    			}
    		})
    		return hosvo;
    	}
    	function updateTheHouseStatus(hos_no){
    		$.ajax({
    			url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
  		    	type:'post',
  		    	data:{
  		    		'action':'updateTheHouseStatus',
					'hos_no':hos_no,
  		    	},
  		    	success:function(result){
  		    		
  		    		console.log(result);
  		    	}
    		})
    	}
    	</script>
    	

<!-- /****** CONTAINER *****/     -->	


<!-- /****** CONTAINER *****/     -->


		
<!-- /****** CONTAINER *****/     -->	                       
</body>
<%@include file="/front-end/footer.file"%>
</html>
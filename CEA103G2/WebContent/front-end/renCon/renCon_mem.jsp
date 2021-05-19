<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>����w���ɶ�</title>

</head>









<!-- =================================�U���O�����C==================================================== --> 
<%@include file="/front-end/header.file"%>
<!-- =================================�W���O�����C==================================================== --> 

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
<!-- ======�Ϥ� -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2 class='text-center text-white'>Signature </h2>
                            <h5 class='text-center text-white'>�|��</h5>
                            <h3 class='text-center text-white'>${MemTenVO.mem_name} �A�n !</h3>
                            <h5 class='text-center text-white'> �T�{��ñ�W </h5>
                            <h5 class='text-center text-white'>��ú�O</h5>
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
                            <h3 style='font-weight:bold'>�T�{�� ñ�W 
                            </h3>
                           <div id='show'></div>
                               	<p style="clear: both;">
									<button class='btn-outline-success btn btn-sm' id="clear">Clear</button> 
									<button class='btn-outline-success btn btn-sm' id="send">�T�{�e�X</button>
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
		        <h5 class="modal-title" id="exampleModalCenterTitle">Credit Crad ú �O</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <div class='card-wrapper'></div>
		    	<hr>
		    	<form>
				    <div class="row a align-items-center">
				    	<div class="col-2"></div>
				    	<div class="col-4 align-items-center"><span>�H�Υd�W��:</span></div>
				    	<div class="col-4 align-items-center"><input type="text" name="name" placeholder="�H�Υd�W��"/></div>
				    </div>
				    <div class="row  align-items-center">
				    	<div class="col-2"></div>
				    	<div class="col-4 align-items-center"><span>�H�Υd�d��:</span></div>
				    	<div class="col-4 align-items-center"><input type="text" name="number" placeholder="�d��" required/></div>
				    </div>
				    <div class="row  align-items-center">
				    	<div class="col-2"></div>
				    	<div class="col-4 align-items-center"><span>�����:</span></div>
				    	<div class="col-4 align-items-center"><input type="text" name="expiry" placeholder="�����" required/></div>
				    </div>
				    <div class="row  align-items-center">
				    	<div class="col-2"></div>
				    	<div class="col-4 align-items-center"><span>�w���X:</span></div>
				    	<div class="col-4 align-items-center"><input type="text" name="cvc" placeholder="�w���X" required/></div>
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
		        <button id='cancelcard' style="display:inline-block;" class="btn btn-outline-success btn-sm">�� ��</button>
		        <button id='sendcard' style="display:inline-block;" class="btn btn-outline-success btn-sm">ú �O</button>
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
    		name: '�H�Υd�W��',
    		expiry: 'mm/yyyy',
    		cvc: '***'
    		}
    	});
    	$("#sk").click(function(){
    		
    	})
    	let url = location.href;
    	let con_no = url.substring(url.indexOf('?')+8);
    	var sig =$('#show').signature();
    	
    	$('#clear').click(function() {
    		sig.signature('clear');
    	});
    	$('#send').click(function() {
    		Swal.fire({
				  title: 'Recheck',
				  text: "���b��N����ק�",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#6495ed',
				  cancelButtonColor: '#fa8072',
				  confirmButtonText: '�T�w�e�X',
				  cancelButtonText:'��^',
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
			    			},
			    			success:function(){
			    				console.log("ú�O���\");
			    			}
			    		})
			    		Swal.fire({
									  title: '�w���\����!',
									  html:'�N�i�b�w�w����J��<br>�N�A5���^����',
									  confirmButtonColor: '#6495ed',
									  confirmButtonText: '�T�w�w��',
									  confirmButtonClass:'btn-sm ',
						})
						window.setTimeout(function(){
							document.location.href = "<%=request.getContextPath()%>/index.jsp";
						},5000);
		    			
		    		})
				  }else{
				  	
				  }
			})
    		console.log(sig.signature('toDataURL', 'image/jpeg', 0.8));
//     		$("#s").attr('src',sig.signature('toDataURL', 'image/jpeg', 0.8));
    	});
    	
    	
//     	$.ajax({
<%--     		url:"<%=request.getContextPath()%>/RenConCRUDServlet", --%>
//     		type:'post',
//     		data:{
//     			action:'getPic',
//     			con_no:'6',
//     		},
//     		success:function(e){
//     			console.log(e);
//     			$("#s").attr('src','data:image/gif;base64,'+e);
//     		}
//     	})
    	</script>
    	

<!-- /****** CONTAINER *****/     -->	


<!-- /****** CONTAINER *****/     -->


		
<!-- /****** CONTAINER *****/     -->	                       
</body>
<%@include file="/front-end/footer.file"%>
</html>
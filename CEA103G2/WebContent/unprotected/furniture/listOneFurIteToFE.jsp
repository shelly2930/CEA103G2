<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furPho.model.*"%>
<%
FurIteVO furIteVO = (FurIteVO) request.getAttribute("furIteVO"); 
%>    

<!DOCTYPE html>
<html>
<head>
<title>�a�㤶��</title>
<!-- =================�M��bootstrap�n�ϥΥH�U=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>

<style>

/* ���� */
	#collection{
		position:fixed;
		 right:0;
   		 top:45%;
   		 z-index:2;
   		 float:left; 
	}
	.bs-canvas-overlay {
   		opacity: 0;
		z-index: -1;
	}
	
	.bs-canvas-overlay.show {
   		opacity: 0.85;
		z-index: 1100;
	}
	
	.bs-canvas-overlay, .bs-canvas {
		transition: all .4s ease-out;
		-webkit-transition: all .4s ease-out;
		-moz-transition: all .4s ease-out;
		-ms-transition: all .4s ease-out;
	}
	
	.bs-canvas {
		top: 0;
		z-index: 1000;
		overflow-x: hidden;
		overflow-y: auto;
		width: 330px;		
	}
	
	.bs-canvas-left {
		left: 0;
		margin-left: -330px;
	}
	
	.bs-canvas-right {
		right: 0;
		margin-right: -330px;
	}
	.card-body{
		padding: 1rem !important;
	}
/* ���� */

.breadcrumb_bg {
    background-image: url('<%=request.getContextPath()%>/unprotected/furniture/images/FurniturePage.jpg')!important;
    background-position: bottom -300px right 0px!important;
    background-repeat: no-repeat;
    background-size: cover;
}

</style>

<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

</head>
<body>

<!-- include�����C -->
<%@include file="/front-end/header.file"%>	

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


  <!--================Single Product Area =================-->
  <div class="product_image_area section_padding">
    <div class="container">
      <div class="row s_product_inner justify-content-between">
        <div class="col-lg-7 col-xl-7">
          <div class="product_slider_img">
            <div id="vertical">
<!--              �Ӥ��`���϶� ������-->
		<c:forEach var="furPhoVO" items="${furPhoList}">
              <div data-thumb="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}">
                <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}" />
              </div>
        </c:forEach>      
<!--              �Ӥ��`���϶� ������-->
<!--              ��ӥΫݧR ������-->
<!--               <div data-thumb="img/product/single-product/product_1.png"> -->
<!--                 <img src="img/product/single-product/product_1.png" /> -->
<!--               </div> -->

            </div>
          </div>
        </div>
        <div class="col-lg-5 col-xl-4">
          <div class="s_product_text">
<!-- 			�e�@�� �U�@���s�� �Ψ�L���� -->
<!--             <h5>previous <span>|</span> next</h5> -->
<!--             �a��W -->
            <h3 id="fntName" >${furIteVO.fnt_name}</h3>
<!--             ���� -->
            <h2>$<span id="fntPrice">${furIteVO.fnt_price}</span> /��</h2>
            <ul class="list">
              <li>
                
<!--             �����γW�� -->
                  <span>�W��</span> : ${furIteVO.fnt_standard}</a>
              </li>
              <li>
<!--               �w�s -->
                   <span>�w�s</span> : <c:choose>
					<c:when test="${furIteVO.fnt_unrent>0}">${furIteVO.fnt_unrent}</c:when>	
					<c:when test="${furIteVO.fnt_unrent<=0}">�L</c:when>			
					</c:choose>
              </li>
                          <li>
<!--               �s������ -->
                 <span>�s������</span> : ${furIteVO.fnt_views} ��
              </li>
            </ul>

<!--             ²�� -->            
<!-- 			<p> -->
<!--               First replenish living. Creepeth image image. Creeping can't, won't called. -->
<!--               Two fruitful let days signs sea together all land fly subdue -->
<!--             </p> -->
  				<div class="card_area d-flex justify-content-between align-items-center">
<!--               �[�J�ʪ��� -->
<!-- �w�s�j��0�� -->
	<c:if test="${furIteVO.fnt_unrent>0}">	
            <!--              �ƶq+-�s -->
          
              <div class="product_count">
                <span class="number-decrement"> <i class="ti-minus"></i></span>
                <input class="input-number" type="text" value="1" min="1" max="${furIteVO.fnt_unrent}">
                <span class="number-increment"> <i class="ti-plus"></i></span>
              </div>
              <a class="btn_3" id="${furIteVO.fnt_it_no}" style="cursor:pointer; color:white;" >�[�J����</a>
<!--               ���� -->
              <a href="#" class="like_us"> <i class="far fa-heart"></i> </a>
	</c:if>
<!-- �w�s��0�� -->
	<c:if test="${furIteVO.fnt_unrent==0}">	
              <a class="btn_1 checkout_btn_1" href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte">�~���s���a��</a>
<!--               ���� -->
              <a class="like_us"> <i class="far fa-heart"></i> </a>
              </div>
	</c:if>

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--================End Single Product Area =================-->

  <!--================�a�㤶��=================-->
  <section class="product_description_area">
    <div class="container">
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <!--         <���� ���� �ݴ�> -->
        <li class="nav-item">
                    <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">�a��S��</a>
                </li>
        <li class="nav-item">
          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
            aria-selected="false">�a��W��</a>
        </li>

      </ul>
<!-- �H�U�����ФγW�满�� -->
      <div class="tab-content" id="myTabContent">
                       <!-- ������}�l -->
                    <div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">
                    <p>
                    ${furIteVO.fnt_info}
                    </p>
                </div>
                      <!-- �����浲�� -->
                <!-- �W����}�l -->
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                    <div class="table-responsive">
                        <table class="table">
                            <tbody>
  								<tr>
                                    <td>
                                        <h5>�W��</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_standard}</h5>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td>
                                        <h5>����</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_length} ����</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>�e��</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_width} ����</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>����</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_height} ����</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>���q</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_weight} ����</h5>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- �W���浲�� -->
             
                <!-- �H�U�d -->
            </div>
        </div>
    </section>
  <!--================End Product Description Area =================-->

					<!-- �����á� -->
<a class="ml-3 order-xl-last btn btn-info" style='opacity:0.5;' id="collection" data-toggle="canvas" href="#bs-canvas-right" aria-expanded="false" aria-controls="bs-canvas-right" role="button"><i class="fas fa-couch" ><br><br>�a��<br>����</i></a>
                    
<div id="bs-canvas-right" class="bs-canvas bs-canvas-right position-fixed bg-light h-100">
	<header class="bs-canvas-header p-3 bg-info overflow-auto" style='opacity:0.5;'>
    	<button type="button" class="bs-canvas-close float-left close" aria-label="Close" aria-expanded="false" style="font-family: Arial;"><span aria-hidden="true" class="text-light">&times;</span></button>
        <h4 class="d-inline-block text-light mb-0 float-right font-weight-bolder" >�ڪ�����</h4>
    </header>
    <div class="bs-canvas-content px-3 py-3" id='showcol'>
    </div>    
</div>
                    <!-- �����á� -->

<!-- JS ajax -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script type="text/javascript">

let mem_no = ${empty MemTenVO.mem_no? "null" : MemTenVO.mem_no};
getFurCol(mem_no);

function getFurCol(mem_no){
	let json_FurColVO;
	$.ajax({
		url:"<%=request.getContextPath()%>/FurColServlet",
		type:'post',
		data:{
			action:'getAll_furCol',
			mem_no:mem_no
		},
		async: false,
		success:function(data){
			json_FurColVO = data;
			$(".fa-heart").addClass('far');
			$(".fa-heart").removeClass('fas');
			for(let furColVO of data){
				if(furColVO.fnt_it_no == ${furIteVO.fnt_it_no}){
					$(".fa-heart").addClass('fas');
					$(".fa-heart").removeClass('far');
				}
			}
		}
	});
	return json_FurColVO;
}

$(".like_us").click(async function(e){
	e.preventDefault();
	
	if(mem_no == null) {
		Swal.fire({
			  title: '�Х��n�J�|��',
			  text: 'Go to the login page and sign in',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#6495ed',
			  cancelButtonColor: '#fa8072',
			  confirmButtonText: 'Sign in',
			  cancelButtonText:'Cancel',
			  confirmButtonClass:'btn-sm',
			  cancelButtonClass:'btn btn-info btn-sm',
		}).then( (result) => {
			  if (result.isConfirmed) {
				  $.ajax({
						url:"<%=request.getContextPath()%>/FurColServlet",
						type:'post',
						data:{
							action:'set_location',
							URIaction:'getOneFurIteToFE',
							fnt_it_no:${furIteVO.fnt_it_no}
						},
						async: false,
						success:function(){
							$(location).prop('href', '<%=request.getContextPath()%>/unprotected/memTen/login.jsp');
						}
					});
			  }
		})
		return;
	}
	
	if($(".fa-heart").attr('class').search(/far/) != -1){
		const { value: text } = await Swal.fire({
			input: 'textarea',
			inputLabel: '�[�J����',
			inputPlaceholder: '��J�Ƶ��D�D�D',
			inputAttributes: {
				'aria-label': 'Type your message here'
			},
			showCancelButton: true,
			confirmButtonText: '�T�w',
			cancelButtonText: '����',
			inputValidator: (value) => {
				$.ajax({
					url:"<%=request.getContextPath()%>/FurColServlet",
					type:'post',
					data:{
						action:'add_furCol',
						mem_no:mem_no,
						fnt_it_no:${furIteVO.fnt_it_no},
						fnt_col_note:value
					},
					async: false,
					success:function(str){
						console.log(str);
						refreshFurColBar(getFurCol(mem_no));
					}
				});
			}
		});
	}
	else{
		Swal.fire({
			title: '�T�w�n�������áH',
			text: "�Ƶ������e�N���|�O�d",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#d33',
			cancelButtonColor: '#3085d6',
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
						fnt_it_no:${furIteVO.fnt_it_no}
					},
					async: false,
					success:function(str){
						console.log(str);
						refreshFurColBar(getFurCol(mem_no));
					}
				});
			}
		});
	}
});


function refreshFurColBar(furCol){
	$("#showcol").empty();
	for(let furColVO of furCol){
		$.ajax({
			url:"<%=request.getContextPath()%>/FurIteJsonServlet",
			type:"post",
			data:{
				action : 'getOneFurIte',
				fnt_it_no : furColVO.fnt_it_no
			},
			async: false,
			success:function(furIteVO){
				let str = "<div class='card' style='width: 18rem;'>";
				str+="<a class='card-header' href='<%=request.getContextPath()%>/furIte/furIte.do?fnt_it_no=" + furIteVO.fnt_it_no + "&action=getOneFurIteToFE'>";
				str+="<h6 class='card-text text-secondary '>�a��~���G"+furIteVO.fnt_name+"</h6>";
				str+="</a>";
				str+="<div class='list-group'>";
				
				$.ajax({
					url:"<%=request.getContextPath()%>/furPho/furPho.do",
					type:'post',
					data:{
						action:'getFnt_pic_noByFK',
						fnt_it_no:furIteVO.fnt_it_no
					},
					async: false,
					success:function(list_Fnt_pic_no){
						str+="<div id='carousel" + furIteVO.fnt_it_no + "' class='carousel slide' data-ride='carousel' data-interval=false style='height:286px;overflow:hidden;'>";
						str+="<ol class='carousel-indicators'>";
						for(let i = 0; i < list_Fnt_pic_no.length; i++){
							if(i == 0)
								str+="<li data-target='#carousel" + furIteVO.fnt_it_no + "' data-slide-to='0' class='active'></li>";
							else
								str+="<li data-target='#carousel" + furIteVO.fnt_it_no + "' data-slide-to='" + i + "'></li>";
						}
						str+="</ol>";
						str+="<div class='carousel-inner'>"
						
						if(list_Fnt_pic_no.length == 0){
							str+="<div class='carousel-item active'>";
							str+="<a href='<%=request.getContextPath()%>/furIte/furIte.do?fnt_it_no=" + furIteVO.fnt_it_no + "&action=getOneFurIteToFE'>";
							str+="<img src='<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=' class='d-block w-100'>";
							str+="</a>";
							str+="</div>";
						}else{
							let count = 0;
							for(let fnt_pic_no of list_Fnt_pic_no){
								if(count == 0){
									str+="<div class='carousel-item active'>";
								}else {
									str+="<div class='carousel-item'>";
								}
								str+="<a href='<%=request.getContextPath()%>/furIte/furIte.do?fnt_it_no=" + furIteVO.fnt_it_no + "&action=getOneFurIteToFE'>";
								str+="<img src='<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=" + fnt_pic_no + "' class='d-block w-100'>";
								str+="</a>";
								str+="</div>";
								count++;
							}
						}
						
						str+="</div>";
						str+="<a class='carousel-control-prev' href='#carousel" + furIteVO.fnt_it_no + "' role='button' data-slide='prev'>";
						str+="<span class='carousel-control-prev-icon' aria-hidden='true'></span>";
						str+="<span class='sr-only'>Previous</span>";
						str+="</a>";
						str+="<a class='carousel-control-next' href='#carousel" + furIteVO.fnt_it_no + "' role='button' data-slide='next'>";
						str+="<span class='carousel-control-next-icon' aria-hidden='true'></span>";
						str+="<span class='sr-only'>Next</span>";
						str+="</a>";
						str+="</div>";
					}
				});
				
				str+="<div class='card-body'>�Ƶ�";
				
				$.ajax({
					url:"<%=request.getContextPath()%>/FurColServlet",
					type:'post',
					data:{
						action:'getOne_furCol',
						mem_no:mem_no,
						fnt_it_no:furIteVO.fnt_it_no
					},
					async: false,
					success:function(furColVO){
						if(furColVO.fnt_col_note.trim().length == 0){
							str+="<p class='card-text showtext text-secondary'>�L</p>";
						}else{
							str+="<p class='card-text showtext text-secondary'>" + furColVO.fnt_col_note + "</p>";
						}
					}
				});
				
				str+="</div></div>";
				str+="<div class='card-footer'>";
				str+="<a href=''class='addcoltext' style='display:inline-block' id='updateFurCol" + furIteVO.fnt_it_no + "'><h5>&nbsp; &nbsp; <i class='fas fa-edit text-warning'>�ק�Ƶ�</i></h5></a>";
				str+="<a href=''class='cancelcol' style='display:inline-block' id='deleteFurCol" + furIteVO.fnt_it_no + "'><h5>&nbsp; &nbsp; &nbsp; &nbsp; <i class='fas fa-window-close text-info'>��������</i></h5></a>";
				str+="</div>";
				str+="</div><hr>";
				$("#showcol").append(str);
				
				$("#updateFurCol" + furIteVO.fnt_it_no).click(async function(e){
					e.preventDefault();
					const { value: text } = await Swal.fire({
// 						position: 'center-start',
// 						width: '60%',
						input: 'textarea',
						inputLabel: '�ק�Ƶ�',
						inputValue: furColVO.fnt_col_note,
						inputAttributes: {
						  'aria-label': 'Type your message here',
						},
						showCancelButton: true,
						confirmButtonText: '�T�w',
						cancelButtonText: '����',
						inputValidator: (value) => {
							$.ajax({
								url:"<%=request.getContextPath()%>/FurColServlet",
								type:'post',
								data:{
									action:'update_furCol',
									mem_no:mem_no,
									fnt_it_no:furColVO.fnt_it_no,
									fnt_col_note:value
								},
								async: false,
								success:function(str){
									console.log(str);
									refreshFurColBar(getFurCol(mem_no));
								}
							});
						}
					});
				});
				
				$("#deleteFurCol" + furIteVO.fnt_it_no).click(function(e){
					e.preventDefault();
					Swal.fire({
						title: '�T�w�n�������áH',
						text: "�Ƶ������e�N���|�O�d",
						icon: 'warning',
						showCancelButton: true,
						confirmButtonColor: '#d33',
						cancelButtonColor: '#3085d6',
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
									fnt_it_no:furColVO.fnt_it_no
								},
								async: false,
								success:function(str){
									console.log(str);
									refreshFurColBar(getFurCol(mem_no));
								}
							});
						}
					});
				});
			}
		});
	}
}


if(mem_no == null) {
	$('[data-toggle="canvas"]').hide();
}else {
	var bsOverlay = $('.bs-canvas-overlay');
	$('[data-toggle="canvas"]').on('click', function(){
		if(mem_no==null){
			Swal.fire({
				  title: '�Х��n�J�|��',
				  text: 'Go to the login page and sign in',
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#6495ed',
				  cancelButtonColor: '#fa8072',
				  confirmButtonText: 'Sign in',
				  cancelButtonText:'Cancel',
				  confirmButtonClass:'btn-sm',
				  cancelButtonClass:'btn btn-info btn-sm',
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
							url:"<%=request.getContextPath()%>/FurColServlet",
							type:'post',
							data:{
								action:'set_location',
								URIaction:'getOneFurIteToFE',
								fnt_it_no:${furIteVO.fnt_it_no}
							},
							async: false,
							success:function(){
								$(location).prop('href', '<%=request.getContextPath()%>/unprotected/memTen/login.jsp');
							}
						});
				  }else{
					  return false;
				  }
			})
		}else{
			refreshFurColBar(getFurCol(mem_no));
			var ctrl = $(this), 
				elm = ctrl.is('button') ? ctrl.data('target') : ctrl.attr('href');
			$(elm).addClass('mr-0');
			$(elm + ' .bs-canvas-close').attr('aria-expanded', "true");
			$('[data-target="' + elm + '"], a[href="' + elm + '"]').attr('aria-expanded', "true");
			if(bsOverlay.length)
				bsOverlay.addClass('show');
			return false;
			
		}
	});
	
	$('.bs-canvas-close, .bs-canvas-overlay').on('click', function(){
		var elm;
		if($(this).hasClass('bs-canvas-close')) {
			elm = $(this).closest('.bs-canvas');
			$('[data-target="' + elm + '"], a[href="' + elm + '"]').attr('aria-expanded', "false");
		} else {
			elm = $('.bs-canvas')
			$('[data-toggle="canvas"]').attr('aria-expanded', "false");	
		}
		elm.removeClass('mr-0');
		$('.bs-canvas-close', elm).attr('aria-expanded', "false");
		if(bsOverlay.length)
			bsOverlay.removeClass('show');
		return false;
	});
}

// inumber-decrement inumber-increment input-number
$(".number-increment").click(function(e){
	let number=$(".input-number").val();
	let max=$(".input-number").attr("max");
	if(number==max){
		Swal.fire("�ܩ�p!<br>�ثe�̦h�ȯണ��"+ max+"�ӯ���!");
	}
});
$(".btn_3").click(function(e){
	e.preventDefault();
	
	$.ajax({
		type:"POST",
		url:"<%=request.getContextPath()%>/rentCart/rentCart.do",
		data:{
			"action":"ADD",
        	"fnt_it_no":$(this).attr('id'),
        	"fnt_price":$("#fntPrice").html(),
			"fnt_name":$("#fntName").html(),
			"quantity":$("input[type='text']").val(),
		},
		success:function(data){
			$(".cartQuantity").html(data);
			Swal.fire({
				 position:'center',	 
  				  icon:'success',
  			      title:'�w�[�J����!',
  			      showConfirmButton:false,
  			      timer:1000});
		}
	});
});

</script>
<%@ include file="/front-end/footer.file"%>
</body>
</html>
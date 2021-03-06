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
<title>家具介紹</title>
<!-- =================套用bootstrap要使用以下=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>

<style>

/* 收藏 */
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
/* 收藏 */

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

<!-- include導覽列 -->
<%@include file="/front-end/header.file"%>	

<!-- 導覽列下圖片 -->
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


  <!--================Single Product Area =================-->
  <div class="product_image_area section_padding"  style='padding:0px auto !important;'>
    <div class="container">
      <div class="row s_product_inner justify-content-between">
        <div class="col-lg-7 col-xl-7">
          <div class="product_slider_img">
            <div id="vertical">
<!--              照片循環區塊 ↓↓↓-->
		<c:forEach var="furPhoVO" items="${furPhoList}">
              <div data-thumb="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}">
                <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}" />
              </div>
        </c:forEach>      
<!--              照片循環區塊 ↑↑↑-->
<!--              對照用待刪 ↓↓↓-->
<!--               <div data-thumb="img/product/single-product/product_1.png"> -->
<!--                 <img src="img/product/single-product/product_1.png" /> -->
<!--               </div> -->

            </div>
          </div>
        </div>
        <div class="col-lg-5 col-xl-4">
          <div class="s_product_text">
<!-- 			前一筆 下一筆連結 或其他介紹 -->
<!--             <h5>previous <span>|</span> next</h5> -->
<!--             家具名 -->
            <h3 id="fntName" >${furIteVO.fnt_name}</h3>
<!--             租金 -->
            <h2>$<span id="fntPrice">${furIteVO.fnt_price}</span> /月</h2>
            <ul class="list">
              <li>
                
<!--             分類或規格 -->
                  <span>規格</span> : ${furIteVO.fnt_standard}</a>
              </li>
              <li>
<!--               庫存 -->
                   <span>庫存</span> : <c:choose>
					<c:when test="${furIteVO.fnt_unrent>0}">${furIteVO.fnt_unrent}</c:when>	
					<c:when test="${furIteVO.fnt_unrent<=0}">無</c:when>			
					</c:choose>
              </li>
                          <li style="display:none;">
<!--               瀏覽次數 -->
                 <span>瀏覽次數</span> : ${furIteVO.fnt_views} 次
              </li>
            </ul>

<!--             簡介 -->            
<!-- 			<p> -->
<!--               First replenish living. Creepeth image image. Creeping can't, won't called. -->
<!--               Two fruitful let days signs sea together all land fly subdue -->
<!--             </p> -->
  				<div class="card_area d-flex justify-content-between align-items-center">
<!--               加入購物車 -->
<!-- 庫存大於0時 -->
	<c:if test="${furIteVO.fnt_unrent>0}">	
            <!--              數量+-鈕 -->
          
              <div class="product_count">
                <span class="number-decrement"> <i class="ti-minus"></i></span>
                <input class="input-number" type="text" value="1" min="1" max="${furIteVO.fnt_unrent}">
                <span class="number-increment"> <i class="ti-plus"></i></span>
              </div>
              <a class="btn_3" id="${furIteVO.fnt_it_no}" style="cursor:pointer; color:white;" >加入租借</a>
<!--               收藏 -->
              <a href="#" class="like_us"> <i class="far fa-heart"></i> </a>
	</c:if>
<!-- 庫存為0時 -->
	<c:if test="${furIteVO.fnt_unrent==0}">	
              <a class="btn_1 checkout_btn_1" href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte">繼續瀏覽家具</a>
<!--               收藏 -->
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

  <!--================家具介紹=================-->
  <section class="product_description_area">
    <div class="container">
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <!--         <測試 評論 待換> -->
        <li class="nav-item">
                    <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">家具特色</a>
                </li>
        <li class="nav-item">
          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
            aria-selected="false">家具規格</a>
        </li>

      </ul>
<!-- 以下接介紹及規格說明 -->
      <div class="tab-content" id="myTabContent">
                       <!-- 介紹欄開始 -->
                    <div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">
                    <p>
                    ${furIteVO.fnt_info}
                    </p>
                </div>
                      <!-- 介紹欄結束 -->
                <!-- 規格欄開始 -->
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                    <div class="table-responsive">
                        <table class="table">
                            <tbody>
  								<tr>
                                    <td>
                                        <h5>規格</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_standard}</h5>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td>
                                        <h5>長度</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_length} 公分</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>寬度</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_width} 公分</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>高度</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_height} 公分</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>重量</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_weight} 公斤</h5>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- 規格欄結束 -->
             
                <!-- 以下留 -->
            </div>
        </div>
    </section>
  <!--================End Product Description Area =================-->

					<!-- ↓收藏↓ -->
<a class="ml-3 order-xl-last btn btn-info" style='opacity:0.5;' id="collection" data-toggle="canvas" href="#bs-canvas-right" aria-expanded="false" aria-controls="bs-canvas-right" role="button"><i class="fas fa-couch" ><br><br>家具<br>收藏</i></a>
                    
<div id="bs-canvas-right" class="bs-canvas bs-canvas-right position-fixed bg-light h-100">
	<header class="bs-canvas-header p-3 bg-info overflow-auto" style='opacity:0.5;'>
    	<button type="button" class="bs-canvas-close float-left close" aria-label="Close" aria-expanded="false" style="font-family: Arial;"><span aria-hidden="true" class="text-light">&times;</span></button>
        <h4 class="d-inline-block text-light mb-0 float-right font-weight-bolder" >我的收藏</h4>
    </header>
    <div class="bs-canvas-content px-3 py-3" id='showcol'>
    </div>    
</div>
                    <!-- ↑收藏↑ -->

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
			  title: '請先登入會員',
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
			inputLabel: '加入收藏',
			inputPlaceholder: '輸入備註．．．',
			inputAttributes: {
				'aria-label': 'Type your message here'
			},
			showCancelButton: true,
			confirmButtonText: '確定',
			cancelButtonText: '取消',
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
			title: '確定要取消收藏？',
			text: "備註的內容將不會保留",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#d33',
			cancelButtonColor: '#3085d6',
			confirmButtonText: '確定',
			cancelButtonText: '取消'
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
				str+="<h6 class='card-text text-secondary '>家具品項："+furIteVO.fnt_name+"</h6>";
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
				
				str+="<div class='card-body'>備註";
				
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
							str+="<p class='card-text showtext text-secondary'>無</p>";
						}else{
							str+="<p class='card-text showtext text-secondary'>" + furColVO.fnt_col_note + "</p>";
						}
					}
				});
				
				str+="</div></div>";
				str+="<div class='card-footer'>";
				str+="<a href=''class='addcoltext' style='display:inline-block' id='updateFurCol" + furIteVO.fnt_it_no + "'><h5>&nbsp; &nbsp; <i class='fas fa-edit text-warning'>修改備註</i></h5></a>";
				str+="<a href=''class='cancelcol' style='display:inline-block' id='deleteFurCol" + furIteVO.fnt_it_no + "'><h5>&nbsp; &nbsp; &nbsp; &nbsp; <i class='fas fa-window-close text-info'>取消收藏</i></h5></a>";
				str+="</div>";
				str+="</div><hr>";
				$("#showcol").append(str);
				
				$("#updateFurCol" + furIteVO.fnt_it_no).click(async function(e){
					e.preventDefault();
					const { value: text } = await Swal.fire({
// 						position: 'center-start',
// 						width: '60%',
						input: 'textarea',
						inputLabel: '修改備註',
						inputValue: furColVO.fnt_col_note,
						inputAttributes: {
						  'aria-label': 'Type your message here',
						},
						showCancelButton: true,
						confirmButtonText: '確定',
						cancelButtonText: '取消',
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
						title: '確定要取消收藏？',
						text: "備註的內容將不會保留",
						icon: 'warning',
						showCancelButton: true,
						confirmButtonColor: '#d33',
						cancelButtonColor: '#3085d6',
						confirmButtonText: '確定',
						cancelButtonText: '取消'
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
				  title: '請先登入會員',
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
		Swal.fire("很抱歉!<br>目前最多僅能提供"+ max+"個租用!");
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
			document.styleSheets[0].addRule('.main_menu .cart i::after','visibility: visible');
			$(".fa-cart-plus").attr("data-count",data);
			$(".cartQuantity").html(data);
			Swal.fire({
				 position:'center',	 
  				  icon:'success',
  			      title:'已加入租借!',
  			      showConfirmButton:false,
  			      timer:1000});
		}
	});
});

</script>
<%@ include file="/front-end/footer.file"%>
</body>
</html>
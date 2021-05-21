<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.house.model.*"%>

<html>
<head>
<title>房間照片</title>
<!-- =================套用bootstrap要使用以下=========================== -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
	<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
	
	
<!-- =================套用bootstrap要使用以上=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!-- <!=========================jquery===================== -->

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBzn3b0I0DFbDc6D5zc3DEtuI5kaYxAB4k&callback=initMap&libraries=&v=weekly" async></script>
<%@include file="/front-end/header.file"%>
<!-- =================地圖===================================== -->
<style>
/* 收藏 */
	#collection{
		position:fixed;
		 right:0;
   		 top:400px;
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
		z-index: 1110;
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

/* 收藏 */

table#table-2 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-2 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
/* 物件照片外框 */
/* .box1{ */
/*     margin: 15px; */
/*     padding: 10px;    */
/*     position:relative; */
/*     display: inline-block; */
/*     background: -webkit-gradient(linear, 0% 20%, 0% 1000%, from(#fff), to(#fff), color-stop(.1,#f3f3f3)); */
/*     border: 1px solid #ccc; */
/*     -webkit-box-shadow: 0px 3px 30px rgba(0, 0, 0, 0.1) inset; */
/*     -webkit-border-bottom-right-radius: 6px 50px;     */
/* } */

/******蔡佳******/
/* body { */
/* 	background-color:#dddddd; */
/* } */

.s_product_text h2 {
    color: #61d2b4;
}

.s_product_text .btn_3 {
    box-shadow: -1.717px 8.835px 29.76px 2.24px rgb(97 210 180 / 18%);
    border: 1px solid #61d2b4;
    background-color: #61d2b4;
}

.product_description_area .nav.nav-tabs li a.active {
    background: #ccb78f;
    color: #fff;
    border-color: #ccb78f;
    box-shadow: -1.717px 8.835px 29.76px 2.24px rgb(204 183 143 / 18%);
}
/******蔡佳******/
</style>

<style>
#map {
	height: 400px;           
	width: 100%;
 }
</style>

</head>
<body bgcolor='white'>

<div id="bs-canvas-right" class="bs-canvas bs-canvas-right position-fixed bg-light h-100">
	<header class="bs-canvas-header p-3 bg-info overflow-auto" style='opacity:0.5;'>
    	<button type="button" class="bs-canvas-close float-left close" aria-label="Close" aria-expanded="false"><span aria-hidden="true" class="text-light">&times;</span></button>
        <h4 class="d-inline-block text-light mb-0 float-right font-weight-bolder" >我的收藏</h4>
    </header>
    <div class="bs-canvas-content px-3 py-3" id='showcol'>
<!--     收藏區 -->
    </div>    
</div>
  <!--================Single Product Area =================-->
  <div class="product_image_area section_padding">
    <div class="container">
      <div class="row s_product_inner justify-content-between">
        <div class="col-lg-7 col-xl-7">
          <div class="product_slider_img">
            <div id="vertical">
         	<c:forEach var="houPhoVO" items="${listHouPho_ByHouseNo}">
				<div data-thumb="<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno=${houseVO.hos_no}&hos_pic_no=${houPhoVO.hos_pic_no}">
                <img src="<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno=${houseVO.hos_no}&hos_pic_no=${houPhoVO.hos_pic_no}" />
              </div>
			</c:forEach> 	
            </div>
          </div>
        </div>
        
        <div class="col-lg-5 col-xl-4">
          <div class="s_product_text">
            <h5>${houseVO.hos_city} <span>|</span> ${houseVO.hos_city}</h5>
            <h3>${houseVO.hos_name}</h3>
            <h2>${houseVO.hos_rent}</h2>
            <ul class="list">
              <li>
                <span>類型</span> : <c:choose>
										<c:when test="${houseVO.hos_type==0}">不限 </c:when>
										<c:when test="${houseVO.hos_type==1}">獨立套房  </c:when>
										<c:when test="${houseVO.hos_type==2}">分租套房</c:when>
										<c:when test="${houseVO.hos_type==3}">雅房</c:when>
										<c:when test="${houseVO.hos_type==4}">整層住家 </c:when>
										<c:when test="${houseVO.hos_type==5}">車位 </c:when>
										<c:when test="${houseVO.hos_type==6}">其他 </c:when>
									</c:choose>
              </li>
              <li>
                <span>坪數</span> : ${houseVO.hos_squares}
              </li>
            </ul>
            <p>
              ${houseVO.hos_address}
            </p>
            <div class="card_area d-flex justify-content-between align-items-center">
              <a href="${pageContext.request.contextPath}/front-end/rooVieApp/pickTime.jsp?houseno=${houseVO.hos_no}" class="btn_3">預約看房</a>
              <a href="${pageContext.request.contextPath}/memTen/memTen.do?action=getOne_For_Rental&hos_no=${houseVO.hos_no}" class="btn_3 rental">我要租房</a>
              <a href="#" class="btn_3 rentallogin">我要租房</a>
              <a href="#" class="like_us btn add"><i class="far fa-heart" style='color:#FF9696;font-size:23px;margin:auto;'></i></a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <section class="product_description_area">
    <div class="container">
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <li class="nav-item">
          <a class="nav-link" id="info-tab" data-toggle="tab" href="#info" role="tab" aria-controls="info"
            aria-selected="true">物件介紹</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
            aria-selected="false">物件資訊</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
            aria-selected="false">相關費用</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
            aria-selected="false">地圖位置</a>
        </li>
      </ul>
      <div class="tab-content" id="myTabContent">
        <div class="tab-pane fade" id="info" role="tabpanel" aria-labelledby="home-tab">
          <p>
            ${houseVO.hos_info}
          </p>
        </div>
        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
          <div class="table-responsive">
            <table class="table">
              <tbody>
                <tr>
                  <td>
                    <h5>物件名稱</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_name}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>地址</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_address}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>房型</h5>
                  </td>
                  <td>
                    <h5><c:choose>
						<c:when test="${houseVO.hos_type==0}">不限 </c:when>
						<c:when test="${houseVO.hos_type==1}">獨立套房  </c:when>
						<c:when test="${houseVO.hos_type==2}">分租套房</c:when>
						<c:when test="${houseVO.hos_type==3}">雅房</c:when>
						<c:when test="${houseVO.hos_type==4}">整層住家 </c:when>
						<c:when test="${houseVO.hos_type==5}">車位 </c:when>
						<c:when test="${houseVO.hos_type==6}">其他 </c:when>
					</c:choose></h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>屋齡</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_age} 年</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>物件坪數</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_squares} 坪</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>性別限制</h5>
                  </td>
                  <td>
                    <h5><c:choose>
							<c:when test="${houseVO.hos_gender==0}">不拘 </c:when>
							<c:when test="${houseVO.hos_gender==1}">限制男生  </c:when>
							<c:when test="${houseVO.hos_gender==2}">限制女生</c:when>
					</c:choose></h5>
                  </td>
                </tr>
                
                <tr>
                  <td>
                    <h5>樓層 </h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_floor}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>坪數</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_squares}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>刊登日期</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_date}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>電梯與否</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_ele==1?'可':'不可'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>停車位與否</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_parking==1?'可':'不可'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>寵物與否</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_pet==1?'可':'不可'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>煮飯與否</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_cook==1?'可':'不可'}</h5>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
        <div class="table-responsive">
            <table class="table">
              <tbody>
                <tr>
                  <td>
                    <h5>物件租金</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_rent} 元 /一個月</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>水費/一度</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_water} 元/一度</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>電費/一度</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_power} 元/一度</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>網路費</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_internet==0?'不收費':'元/一個月'} </h5>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">
          <div class="row">
            <div class="col-lg-6">
            <div id ="map"></div>
		     <script>
		    function initMap() {
		        // 因為JSP優先於html Javascipt等等，所以到了javascript為字串，你要用javascript轉成數字
		        const city = { lat: parseFloat("${houseVO.hos_lat}"), 
		        				lng: parseFloat("${houseVO.hos_lon}")
		        				};
		        // The map, centered at city
		        const map = new google.maps.Map(document.getElementById("map"), {
		            zoom: 12,//地圖比例尺大小
		            center: city,
		        });
		        // The marker, positioned at city
		        const marker = new google.maps.Marker({
		            position: city,
		            map: map,
		        });
		    }
		    </script>
    
            <div class="col-lg-6">
              
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  
      <div class="modal fade" id="controltext" tabindex="2" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Write notes</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="message-text" class="col-form-label">notes:</label>
	            <textarea class="form-control" id="message-text">dssss</textarea>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" id="sendtext" class="btn btn-primary">add notes</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!--                     	收藏 -->
	<a class="ml-3 order-xl-last btn btn-info" style='opacity:0.5;' id="collection" data-toggle="canvas" href="#bs-canvas-right" aria-expanded="false" aria-controls="bs-canvas-right" role="button"><i class="fas fa-home" ><br><hr>收藏</i></a>
	<!--                     	以上收藏 -->
  <!--================End Product Description Area =================-->

  <!-- product_list part start-->
  <!-- product_list part end-->

  <!--::footer_part start::-->
  <!--::footer_part end::-->
<%@ include file="/front-end/footer.file"%>

<script>
	let mem_no = ${empty MemTenVO.mem_no ?"null":MemTenVO.mem_no};
	let housno = ${empty houseVO.hos_no ?"null" :houseVO.hos_no};
	//收藏
	function getCol(mem_no){
		if(mem_no==null){
			return;
		}
		let collection = new Set();
		$.ajax({
			url:"<%=request.getContextPath()%>/HouColServlet",
			type:'post',
			data:{
				action:'getall',
				mem_no:mem_no,
			},
			async: false,
			success:function(str){
				for(let x of str){
					collection.add(x.hos_no);
				}
				$(".fa-heart").each(function(index){
					if(collection.has(parseInt(housno))){
						$(this).removeClass('far');
						$(this).addClass('fas');
					}else{
						$(this).removeClass('fas');
						$(this).addClass('far');
					}
					
				})
			}
		})
		return collection;
	}
	
	if(mem_no===null){
		colarray = new Set();
	}else{
		colarray = getCol(mem_no);
	}
	
	$('.add').click(function(e){
		e.preventDefault();
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
					  $(location).prop('href', '<%=request.getContextPath()%>/unprotected/memTen/login.jsp');
				  }
			})
		}else{
			if(colarray.has(parseInt(housno))){
				$.ajax({
					url:"<%=request.getContextPath()%>/HouColServlet",
					type:'post',
					data:{
						action:'deleteCol',
						hos_no:housno,
						mem_no:mem_no,
					},
					async: false,
					success:function(str){
						console.log("取消收藏");
						colarray=getCol(mem_no);
						reset(colarray);
					}
				})
				//取消收藏
			}else{
				$.ajax({
					url:"<%=request.getContextPath()%>/HouColServlet",
					type:'post',
					data:{
						action:'addHouCol',
						hos_no:housno,
						mem_no:mem_no,
					},
					async: false,
					success:function(str){
						console.log('新增成功');
						getCol(mem_no);
						colarray=getCol(mem_no);
						reset(colarray);
					}
				})
				
			}
			
		}
		
	})
	let addcol_hos = null;
	reset(colarray);
	function reset(colarray){
		for(let col_no of colarray){
			$("#showcol").empty();
			$.get({
				url:"<%=request.getContextPath()%>/HouseJsonServlet",
				type:"post",
				data:{
					action:'getOneHouse',
					houseno:col_no,
				},
				success:function(jsonStr){
					
					let str = "<div class='card' style='width: 18rem;'>";
					str+="<div class='list-group mb-5'>";
					str+="<a href='<%=request.getContextPath()%>/house/house.do?houseno="+jsonStr.hos_no+"&action=listHouPho_ByHouseA'>"
					str+="<img src='<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno='"+jsonStr.hos_no+" class='card-img-top' alt='收藏照片'>";
					str+="</a>";
					str+="<div class='card-body'>";
					str+="<p class='card-text text-secondary'>租金: "+jsonStr.hos_rent+"</p>";
					str+="<p class='card-text text-secondary'>地址: "+jsonStr.hos_address+"</p>";
					str+="<p class='card-text showtext text-secondary' id='text"+jsonStr.hos_no+"' >備註: 尚未填寫</p>";
					str+="</div></div>";
					str+="<div class='card-footer' id='"+jsonStr.hos_no+"'>";
					str+="<a href=''class='cancelcol' style='display:inline-block' ><h5><i class='fas fa-window-close text-info'>取消收藏</i></h5></a>";
					str+="<a href=''class='addcoltext' style='display:inline-block'><h5>&nbsp; &nbsp; &nbsp; <i class='fas fa-edit text-warning'>增加備註</i></h5></a>";
					str+="</div>";
					str+="</div><hr>";
					$("#showcol").append(str);
					$.ajax({
						url:"<%=request.getContextPath()%>/HouColServlet",
						type:'post',
						data:{
							action:'getOne',
							mem_no:mem_no,
							hos_no:col_no,
						},
						async: false,
						success:function(str){
							if(str.hos_col_note.trim().length==0){
							}else{
								$("#text"+jsonStr.hos_no).html("備註: "+str.hos_col_note);
							}
						}
					})
					$(".addcoltext").click(function(e){
//						新增備註
						addcol_hos = $(this).parent().attr('id');
						e.preventDefault();
						$("#controltext").modal('show');
						$("#message-text").val($("#text"+jsonStr.hos_no).html().substring(4));
						
					})
					$(".cancelcol").click(function(e){
						e.preventDefault();
						$.ajax({
							url:"<%=request.getContextPath()%>/HouColServlet",
							type:'post',
							data:{
								action:'deleteCol',
								hos_no:$(this).parent().attr('id'),
								mem_no:mem_no,
							},
							async: false,
							success:function(str){
								console.log("取消收藏");
								colarray=getCol(mem_no);
								reset(colarray);
							}
						})
					})
				}
			});
		}
	}
	
	$("#sendtext").click(function(e){
		e.preventDefault();
		e.stopPropagation();
		$.ajax({
			url:"<%=request.getContextPath()%>/HouColServlet",
			type:'post',
			data:{
				action:'update',
				hos_no:addcol_hos,
				hos_col_note:$("#message-text").val(),
				mem_no:mem_no,
			},
			async: false,
			success:function(str){
				console.log(str);
				colarray=getCol(mem_no);
				reset(colarray);
			}
		})
	})
	
	
	jQuery(document).ready(function($){
		
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
						  $(location).prop('href', '<%=request.getContextPath()%>/unprotected/memTen/login.jsp');
					  }else{
						  return false;
					  }
				})
			}else{
				reset(colarray);
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
	});

	<!--======== 蔡佳新增登入燈箱 =======-->
	if(mem_no === null){
		$(".rental").hide();
	} else {
		$('.rentallogin').hide();
	}
	
	$(".rentallogin").on('click', function() {
		login_ajax();
	});
	  
	function login_ajax(){
		Swal.fire({
  			title: '請先登入會員',
  			html:
    		// 無法用required驗證
  			'<input type="text" id="mem_username" class="swal2-input" placeholder="USERNAME">' +
    		'<input type="password" id="mem_password" class="swal2-input" placeholder="PASSWORD">',
    		showCloseButton: true,
    		showDenyButton: true,
    		confirmButtonText: "LOGIN",
    		denyButtonText: "SIGN UP"
		})
		// SIGN UP
		$(".swal2-deny").on("click", function(){
				$(location).prop('href', '<%=request.getContextPath()%>/unprotected/memTen/addMemTen.jsp');
		})	
		// LOGIN	
		$(".swal2-confirm").on("click", function(){
				if($("#mem_username").val().trim().length != 0 && $("#mem_password").val().trim().length != 0){				
	  			$.ajax({ 
		  			  url:"<%=request.getContextPath()%>/AjaxLoginServlet",
		  			  type:"POST", 
		  			  data:{
		  				  "mem_username":$("#mem_username").val(),
		  				  "mem_password":$("#mem_password").val(),
		  				  "action": "login_ajax"
		  			  },
		  			  success: function(str) {
		  				if (str.length === 0 || str === ""){
				  			Swal.fire({
					  			  icon: 'error',
					  			  title: '帳號或密碼有誤,請重新輸入',
					  			  showConfirmButton: true,
					  			  confirmButtonText: "我知道了"
					  			});
		  				} else {
		  					Swal.fire({
		  						 icon: 'success',
		  						 title: '您已成功登入，歡迎回來',
		  						 showConfirmButton: true,
		  						 confirmButtonText: "我知道了"
		  					}).then((result) => {
		  					  if (result.isConfirmed) {
		  						window.location.reload();// 按下我知道了即刷新頁面
		  					  }
		  					})
		  				}
		  			}, 	  
	  			});
				} else {
					Swal.fire({
						 icon: 'error',
						 title: '帳號或密碼請勿空白',
						 showConfirmButton: true,
			  			 confirmButtonText: "我知道了"
					});
				}
			});
	};
	<!--======== 蔡佳新增登入燈箱 =======-->
</script>

	
</body>
</html>
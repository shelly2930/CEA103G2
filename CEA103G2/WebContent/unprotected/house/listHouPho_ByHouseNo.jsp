<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.house.model.*"%>

<html>
<head>
<title>�ж��Ӥ�</title>
<!-- =================�M��bootstrap�n�ϥΥH�U=========================== -->
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
	
	
<!-- =================�M��bootstrap�n�ϥΥH�W=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!-- <!=========================jquery===================== -->

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBzn3b0I0DFbDc6D5zc3DEtuI5kaYxAB4k&callback=initMap&libraries=&v=weekly" async></script>
<%@include file="/front-end/header.file"%>
<!-- =================�a��===================================== -->
<style>
/* ���� */
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

/* ���� */

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
/* ����Ӥ��~�� */
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

/******����******/
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
/******����******/
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
        <h4 class="d-inline-block text-light mb-0 float-right font-weight-bolder" >�ڪ�����</h4>
    </header>
    <div class="bs-canvas-content px-3 py-3" id='showcol'>
<!--     ���ð� -->
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
                <span>����</span> : <c:choose>
										<c:when test="${houseVO.hos_type==0}">���� </c:when>
										<c:when test="${houseVO.hos_type==1}">�W�߮M��  </c:when>
										<c:when test="${houseVO.hos_type==2}">�����M��</c:when>
										<c:when test="${houseVO.hos_type==3}">����</c:when>
										<c:when test="${houseVO.hos_type==4}">��h��a </c:when>
										<c:when test="${houseVO.hos_type==5}">���� </c:when>
										<c:when test="${houseVO.hos_type==6}">��L </c:when>
									</c:choose>
              </li>
              <li>
                <span>�W��</span> : ${houseVO.hos_squares}
              </li>
            </ul>
            <p>
              ${houseVO.hos_address}
            </p>
            <div class="card_area d-flex justify-content-between align-items-center">
              <a href="${pageContext.request.contextPath}/front-end/rooVieApp/pickTime.jsp?houseno=${houseVO.hos_no}" class="btn_3">�w���ݩ�</a>
              <a href="${pageContext.request.contextPath}/memTen/memTen.do?action=getOne_For_Rental&hos_no=${houseVO.hos_no}" class="btn_3 rental">�ڭn����</a>
              <a href="#" class="btn_3 rentallogin">�ڭn����</a>
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
            aria-selected="true">���󤶲�</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
            aria-selected="false">�����T</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
            aria-selected="false">�����O��</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
            aria-selected="false">�a�Ϧ�m</a>
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
                    <h5>����W��</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_name}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�a�}</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_address}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�Ы�</h5>
                  </td>
                  <td>
                    <h5><c:choose>
						<c:when test="${houseVO.hos_type==0}">���� </c:when>
						<c:when test="${houseVO.hos_type==1}">�W�߮M��  </c:when>
						<c:when test="${houseVO.hos_type==2}">�����M��</c:when>
						<c:when test="${houseVO.hos_type==3}">����</c:when>
						<c:when test="${houseVO.hos_type==4}">��h��a </c:when>
						<c:when test="${houseVO.hos_type==5}">���� </c:when>
						<c:when test="${houseVO.hos_type==6}">��L </c:when>
					</c:choose></h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>����</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_age} �~</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>����W��</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_squares} �W</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�ʧO����</h5>
                  </td>
                  <td>
                    <h5><c:choose>
							<c:when test="${houseVO.hos_gender==0}">���� </c:when>
							<c:when test="${houseVO.hos_gender==1}">����k��  </c:when>
							<c:when test="${houseVO.hos_gender==2}">����k��</c:when>
					</c:choose></h5>
                  </td>
                </tr>
                
                <tr>
                  <td>
                    <h5>�Ӽh </h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_floor}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�W��</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_squares}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�Z�n���</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_date}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�q��P�_</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_ele==1?'�i':'���i'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>������P�_</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_parking==1?'�i':'���i'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�d���P�_</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_pet==1?'�i':'���i'}</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�N���P�_</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_cook==1?'�i':'���i'}</h5>
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
                    <h5>���󯲪�</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_rent} �� /�@�Ӥ�</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>���O/�@��</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_water} ��/�@��</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�q�O/�@��</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_power} ��/�@��</h5>
                  </td>
                </tr>
                <tr>
                  <td>
                    <h5>�����O</h5>
                  </td>
                  <td>
                    <h5>${houseVO.hos_internet==0?'�����O':'��/�@�Ӥ�'} </h5>
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
		        // �]��JSP�u����html Javascipt�����A�ҥH��Fjavascript���r��A�A�n��javascript�ন�Ʀr
		        const city = { lat: parseFloat("${houseVO.hos_lat}"), 
		        				lng: parseFloat("${houseVO.hos_lon}")
		        				};
		        // The map, centered at city
		        const map = new google.maps.Map(document.getElementById("map"), {
		            zoom: 12,//�a�Ϥ�Ҥؤj�p
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
	<!--                     	���� -->
	<a class="ml-3 order-xl-last btn btn-info" style='opacity:0.5;' id="collection" data-toggle="canvas" href="#bs-canvas-right" aria-expanded="false" aria-controls="bs-canvas-right" role="button"><i class="fas fa-home" ><br><hr>����</i></a>
	<!--                     	�H�W���� -->
  <!--================End Product Description Area =================-->

  <!-- product_list part start-->
  <!-- product_list part end-->

  <!--::footer_part start::-->
  <!--::footer_part end::-->
<%@ include file="/front-end/footer.file"%>

<script>
	let mem_no = ${empty MemTenVO.mem_no ?"null":MemTenVO.mem_no};
	let housno = ${empty houseVO.hos_no ?"null" :houseVO.hos_no};
	//����
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
						console.log("��������");
						colarray=getCol(mem_no);
						reset(colarray);
					}
				})
				//��������
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
						console.log('�s�W���\');
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
					str+="<img src='<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno='"+jsonStr.hos_no+" class='card-img-top' alt='���÷Ӥ�'>";
					str+="</a>";
					str+="<div class='card-body'>";
					str+="<p class='card-text text-secondary'>����: "+jsonStr.hos_rent+"</p>";
					str+="<p class='card-text text-secondary'>�a�}: "+jsonStr.hos_address+"</p>";
					str+="<p class='card-text showtext text-secondary' id='text"+jsonStr.hos_no+"' >�Ƶ�: �|����g</p>";
					str+="</div></div>";
					str+="<div class='card-footer' id='"+jsonStr.hos_no+"'>";
					str+="<a href=''class='cancelcol' style='display:inline-block' ><h5><i class='fas fa-window-close text-info'>��������</i></h5></a>";
					str+="<a href=''class='addcoltext' style='display:inline-block'><h5>&nbsp; &nbsp; &nbsp; <i class='fas fa-edit text-warning'>�W�[�Ƶ�</i></h5></a>";
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
								$("#text"+jsonStr.hos_no).html("�Ƶ�: "+str.hos_col_note);
							}
						}
					})
					$(".addcoltext").click(function(e){
//						�s�W�Ƶ�
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
								console.log("��������");
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

	<!--======== ���ηs�W�n�J�O�c =======-->
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
  			title: '�Х��n�J�|��',
  			html:
    		// �L�k��required����
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
					  			  title: '�b���αK�X���~,�Э��s��J',
					  			  showConfirmButton: true,
					  			  confirmButtonText: "�ڪ��D�F"
					  			});
		  				} else {
		  					Swal.fire({
		  						 icon: 'success',
		  						 title: '�z�w���\�n�J�A�w��^��',
		  						 showConfirmButton: true,
		  						 confirmButtonText: "�ڪ��D�F"
		  					}).then((result) => {
		  					  if (result.isConfirmed) {
		  						window.location.reload();// ���U�ڪ��D�F�Y��s����
		  					  }
		  					})
		  				}
		  			}, 	  
	  			});
				} else {
					Swal.fire({
						 icon: 'error',
						 title: '�b���αK�X�ФŪť�',
						 showConfirmButton: true,
			  			 confirmButtonText: "�ڪ��D�F"
					});
				}
			});
	};
	<!--======== ���ηs�W�n�J�O�c =======-->
</script>

	
</body>
</html>
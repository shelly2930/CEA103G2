<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furCat.model.*"%>
<%@ page import="com.furIte.model.*"%>    
  
  
<% 	  
		List<FurIteVO> list = (List<FurIteVO>)request.getAttribute("QueryResultList");
		pageContext.setAttribute("list",list);		
		int listSize=list.size();
		
%>
<% 	  
// 		List<FurIteVO> list =new ArrayList<FurIteVO>();
// 		if(request.getParameter("fnt_ctgr_no")==null){
// 				FurIteService furIteSvc = new FurIteService();
// 			    list= furIteSvc.getAll();
// 			    pageContext.setAttribute("list",list);
// 		}else {
// 			FurIteService furIteSvc = new FurIteService(); 
// 			Integer fnt_ctgr_no = new Integer(request.getParameter("fnt_ctgr_no"));
// 			 list = furIteSvc.getOneFurCat_Item(fnt_ctgr_no); 
// 			pageContext.setAttribute("list",list);
// 		}
%>

<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
<jsp:useBean id="furCatSvc2" scope="page" class="com.furCat.model.FurCatService" />
<jsp:useBean id="furPhoSvc" scope="page" class="com.furPho.model.FurPhoService" />    
<!DOCTYPE html>
<html>
<head>
<title>�a���s������</title>
<!-- =================�M��bootstrap�n�ϥΥH�U=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
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
	    background-image: url(<%=request.getContextPath()%>/unprotected/furniture/images/Morandi2.jpg)!important;
	    background-position: bottom -300px right 0px;
	    background-repeat: no-repeat;
	    background-size: cover;
	}
	
</style>
</head>

<body>

<!-- ���ð� -->
<div id="bs-canvas-right" class="bs-canvas bs-canvas-right position-fixed bg-light h-100">
	<header class="bs-canvas-header p-3 bg-info overflow-auto" style='opacity:0.5;'>
    	<button type="button" class="bs-canvas-close float-left close" aria-label="Close" aria-expanded="false" style="font-family: Arial;"><span aria-hidden="true" class="text-light">&times;</span></button>
        <h4 class="d-inline-block text-light mb-0 float-right font-weight-bolder" >�ڪ�����</h4>
    </header>
    <div class="bs-canvas-content px-3 py-3" id='showcol'>
    </div>    
</div>

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

<!-- breadcrumb start-->
<!--     <section class="breadcrumb breadcrumb_bg"> -->
<!--         <div class="container"> -->
<!--             <div class="row justify-content-center"> -->
<!--                 <div class="col-lg-8"> -->
<!--                     <div class="breadcrumb_iner"> -->
<!--                         <div class="breadcrumb_iner_item"> -->
<!--                             <h2>Shop Category</h2> -->
<!--                             <p>Home <span>-</span> Shop Category</p> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </section> -->
    <!-- breadcrumb start-->

<!-- ������ �a����� -->
  <section class="cat_product_area section_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="left_sidebar_area">
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3>�a�����</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <!--        ���ʺA���ͤ����ﶵ ������ -->
                        	<c:forEach var="furCatVO" items="${furCatSvc.all}" >
                                <li>
                                	<a href="<%=request.getContextPath()%>/furIte/furIte.do?action=listGetOnFurIteByCat&fnt_ctgr_no=${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</a>
     <!--                                         <span>(250)</span> -->
                                </li>
                            </c:forEach>        
                                <!--        ���ʺA���ͤ����ﶵ������-->
                                </ul>
                            </div>
                        </aside>
                  
                    </div>
                </div>
                <!-- ��ܥk�����G �Υk�W�j�M�C -->
                <div class="col-lg-9">
                    <!-- �W��j�M�C -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="product_top_bar d-flex justify-content-between align-items-center">
                                <div class="single_product_menu">
                                    <a href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte" class="genric-btn default"  style="font-size:16px;">�Ҧ��a�� </a> 
<!-- �ݳB�z�L�k��ܤ��a�����O�W -->
                                    <span style="font-size:15px;">/ <c:if test="${not empty param.fnt_ctgr_no}"> ${furCatSvc2.getOneFurCat(param.fnt_ctgr_no).fnt_ctgr_name}</c:if></span>
                                    <%-- ���~��C --%>
									<c:if test="${not empty errorMsgs}">
											<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color:red">${message}</li>
										</c:forEach>
									</ul>
								</c:if>
                                    <p>�@ <span><%=listSize%></span> ���ŦX�j�M���G���a��</p>
                                </div>
<!--                                 <div class="single_product_menu d-flex"> -->
<!--                                     <h5>short by : </h5> -->
<!--                                     <select> -->
<!--                                         <option data-display="Select">name</option> -->
<!--                                         <option value="1">price</option> -->
<!--                                         <option value="2">product</option> -->
<!--                                     </select> -->
<!--                                 </div> -->
<!-- �W��j�M����������  -->
<!--                                 <div class="single_product_menu d-flex"> -->
<!--                                     <h5>show :</h5> -->
<!--                                     <div class="top_pageniation"> -->
<!--                                         <ul> -->
<!--                                             <li>1</li> -->
<!--                                             <li>2</li> -->
<!--                                             <li>3</li> -->
<!--                                         </ul> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!-- �W��j�M���������� -->                          

<!-- �W��j�M����-�ҽk�d�߮� ������  -->      
                            <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furIte/furIte.do">
                                <div class="single_product_menu d-flex">
                                    <div class="input-group">
                                        <input type="text"  name="keyword" class="form-control" placeholder="search" aria-describedby="inputGroupPrepend">
                                        <div class="input-group-prepend">
<!--                                             <span class="input-group-text" id="inputGroupPrepend" ><i class="ti-search"></i></span> -->
                                            <button class="input-group-text" id="inputGroupPrepend"  type="submit"><i class="ti-search" ></i></button>
                                        </div>
                                          <input type="hidden" name="action" value="keywordSearchFromFE">
                                    </div>
                                </div>
                             </FORM>
                          <!-- �W��j�M����-�ҽk�d�߮� ������  -->   
                            </div>
                        </div>
                    </div>
                    
<%--                     <td><a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp?fnt_it_no=${furIteVO.fnt_it_no}">${furIteVO.fnt_name}</a></td>  --%>
<!-- 			<td> -->
<%-- 				<img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFurPho(furIteVO.fnt_it_no).fnt_pic_no}" --%>
<!-- 					height="100"> -->

                    
                    <!-- ���h�~���`��(9��) -->
                    <div class="row align-items-center latest_product_inner">
                        <!-- �U�p�����e �����`���C�X���G������  -->
             <c:forEach var="furIteVO" items="${list}" >
                        <div class="col-lg-4 col-sm-6">
                            <div class="single_product_item">
                               <a href="<%=request.getContextPath()%>/furIte/furIte.do?fnt_it_no=${furIteVO.fnt_it_no}&action=getOneFurIteToFE" >
<%--                                 <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFurPho(furIteVO.fnt_it_no).fnt_pic_no}"  width="222" height="240"> --%>
                                <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFirstFnt_pic_no(furIteVO.fnt_it_no)}"  width="222" height="240">
                                </a>
                                <div class="single_product_text">
<!--                               �H�U  h4�W�s���ݧ令�U�a�㭶�����жW�s�� -->
                                    <h4>${furIteVO.fnt_name}</h4>
                                    <h3>$${furIteVO.fnt_price} /��</h3>
<!--                                   <�H�U�[���ʪ���> -->
                                    <a class="add_cart">+ �[�J����<i class="far fa-heart" id="${furIteVO.fnt_it_no}" style="color: red"></i></a>
                                </div>
                            </div>
                        </div>
              </c:forEach>          
                        <!-- �U�p�����e �����`���C�X���G ������ -->
<!-- �����ݳW�ߥ� �ݧR ������ -->
<!--                         <div class="col-lg-4 col-sm-6"> -->
<!--                             <div class="single_product_item"> -->
<!--                                 <img src="img/product/product_2.png" alt=""> -->
<!--                                 <div class="single_product_text"> -->
<!--                                     <h4>Quartz Belt Watch</h4> -->
<!--                                     <h3>$150.00</h3> -->
<!--                                     <a href="#" class="add_cart">+ add to cart<i class="ti-heart"></i></a> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!-- �����ݳW�ߥ� �ݧR������ -->
                        <!-- �U����� ������-->
<!--                         <div class="col-lg-12"> -->
<!--                             <div class="pageination"> -->
<!--                                 <nav aria-label="Page navigation example"> -->
<!--                                     <ul class="pagination justify-content-center"> -->
<!--                                         <li class="page-item"> -->
<!--                                             <a class="page-link" href="#" aria-label="Previous"> -->
<!--                                                 <i class="ti-angle-double-left"></i> -->
<!--                                             </a> -->
<!--                                         </li> -->
<!--                                         <li class="page-item"><a class="page-link" href="#">1</a></li> -->
<!--                                         <li class="page-item"><a class="page-link" href="#">2</a></li> -->
<!--                                         <li class="page-item"><a class="page-link" href="#">3</a></li> -->
<!--                                         <li class="page-item"><a class="page-link" href="#">4</a></li> -->
<!--                                         <li class="page-item"><a class="page-link" href="#">5</a></li> -->
<!--                                         <li class="page-item"><a class="page-link" href="#">6</a></li> -->
<!--                                         <li class="page-item"> -->
<!--                                             <a class="page-link" href="#" aria-label="Next"> -->
<!--                                                 <i class="ti-angle-double-right"></i> -->
<!--                                             </a> -->
<!--                                         </li> -->
<!--                                     </ul> -->
<!--                                 </nav> -->
<!--                             </div> -->
<!--                         </div> -->
                             <!-- �U����� ������ -->
                    </div>
              
                </div>
            </div>
        </div>
    </section>
    
    <div class="modal fade" id="controltext" tabindex="2" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">�ק�Ƶ�</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
<!-- 	            <label for="message-text" class="col-form-label">notes:</label> -->
	            <textarea class="form-control" id="message-text"></textarea>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">����</button>
	        <button type="button" id="sendtext" class="btn btn-primary">�e�X</button>
	      </div>
	    </div>
	  </div>
	</div>

    <!--================End Category Product Area =================-->
    
                    <!-- �����á� -->
<a class="ml-3 order-xl-last btn btn-info" style='opacity:0.5;' id="collection" data-toggle="canvas" href="#bs-canvas-right" aria-expanded="false" aria-controls="bs-canvas-right" role="button"><i class="fas fa-couch" ><br><br>�a��<br>����</i></a>
                    <!-- �����á� -->

<!-- JS ajax -->

<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>

//����
// let enterPage = ${empty param.whichPage?'1':param.whichPage};
<%-- let totalPage = <%=pageNumber %>; --%>
// for(let j = 1;j<6;j++){
// 	if((enterPage)>totalPage){
// 		break;
// 	}
<%-- 	$("#page li.page-item").eq(j).after("<li class='page-item'><a class='page-link' href='<%=request.getContextPath()%>/house/house.do?whichPage="+enterPage+"&orderCol=${param.orderCol}&orderType=${param.orderType}&action=listHouse_AllOrQuery'>"+enterPage+"</a></li>"); --%>
// 	enterPage++;
// }

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
				$("#" +�@furColVO.fnt_it_no).addClass('fas');
				$("#" +�@furColVO.fnt_it_no).removeClass('far');
			}
		}
	});
	return json_FurColVO;
}

$(".fa-heart").click(async function(e){
	e.preventDefault();
	e.stopPropagation();
	
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
				  $(location).prop('href', '<%=request.getContextPath()%>/unprotected/memTen/login.jsp');
			  }
		})
		return;
	}
	
	if($(this).attr('class').search(/far/) != -1){
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
						fnt_it_no:$(this).attr('id'),
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
						fnt_it_no:$(this).attr('id')
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
					  $(location).prop('href', '<%=request.getContextPath()%>/unprotected/memTen/login.jsp');
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

$(".add_cart").click(function() {
	alert("�[�J����");
})

</script>
<%@ include file="/front-end/footer.file"%>
</body>
</html>
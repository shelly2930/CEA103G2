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
<title>家具瀏覽首頁</title>
<!-- =================套用bootstrap要使用以下=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
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
	    background-image: url(<%=request.getContextPath()%>/unprotected/furniture/images/Morandi2.jpg)!important;
	    background-position: bottom -300px right 0px;
	    background-repeat: no-repeat;
	    background-size: cover;
	}
	
</style>
</head>

<body>

<!-- 收藏區 -->
<div id="bs-canvas-right" class="bs-canvas bs-canvas-right position-fixed bg-light h-100">
	<header class="bs-canvas-header p-3 bg-info overflow-auto" style='opacity:0.5;'>
    	<button type="button" class="bs-canvas-close float-left close" aria-label="Close" aria-expanded="false" style="font-family: Arial;"><span aria-hidden="true" class="text-light">&times;</span></button>
        <h4 class="d-inline-block text-light mb-0 float-right font-weight-bolder" >我的收藏</h4>
    </header>
    <div class="bs-canvas-content px-3 py-3" id='showcol'>
    </div>    
</div>

<!-- include導覽列 -->
<%@include file="/front-end/header.file"%>

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

<!-- 左側欄 家具分類 -->
  <section class="cat_product_area section_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="left_sidebar_area">
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3>家具分類</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <!--        此動態產生分類選項 ↓↓↓ -->
                        	<c:forEach var="furCatVO" items="${furCatSvc.all}" >
                                <li>
                                	<a href="<%=request.getContextPath()%>/furIte/furIte.do?action=listGetOnFurIteByCat&fnt_ctgr_no=${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</a>
     <!--                                         <span>(250)</span> -->
                                </li>
                            </c:forEach>        
                                <!--        此動態產生分類選項↑↑↑-->
                                </ul>
                            </div>
                        </aside>
                  
                    </div>
                </div>
                <!-- 顯示右側結果 及右上搜尋列 -->
                <div class="col-lg-9">
                    <!-- 上方搜尋列 -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="product_top_bar d-flex justify-content-between align-items-center">
                                <div class="single_product_menu">
                                    <a href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte" class="genric-btn default"  style="font-size:16px;">所有家具 </a> 
<!-- 待處理無法顯示之家具類別名 -->
                                    <span style="font-size:15px;">/ <c:if test="${not empty param.fnt_ctgr_no}"> ${furCatSvc2.getOneFurCat(param.fnt_ctgr_no).fnt_ctgr_name}</c:if></span>
                                    <%-- 錯誤表列 --%>
									<c:if test="${not empty errorMsgs}">
											<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color:red">${message}</li>
										</c:forEach>
									</ul>
								</c:if>
                                    <p>共 <span><%=listSize%></span> 筆符合搜尋結果的家具</p>
                                </div>
<!--                                 <div class="single_product_menu d-flex"> -->
<!--                                     <h5>short by : </h5> -->
<!--                                     <select> -->
<!--                                         <option data-display="Select">name</option> -->
<!--                                         <option value="1">price</option> -->
<!--                                         <option value="2">product</option> -->
<!--                                     </select> -->
<!--                                 </div> -->
<!-- 上方搜尋分頁↓↓↓  -->
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
<!-- 上方搜尋分頁↑↑↑ -->                          

<!-- 上方搜尋分頁-模糊查詢框 ↓↓↓  -->      
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
                          <!-- 上方搜尋分頁-模糊查詢框 ↑↑↑  -->   
                            </div>
                        </div>
                    </div>
                    
<%--                     <td><a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp?fnt_it_no=${furIteVO.fnt_it_no}">${furIteVO.fnt_name}</a></td>  --%>
<!-- 			<td> -->
<%-- 				<img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFurPho(furIteVO.fnt_it_no).fnt_pic_no}" --%>
<!-- 					height="100"> -->

                    
                    <!-- 內層品項總攬(9塊) -->
                    <div class="row align-items-center latest_product_inner">
                        <!-- 各小塊內容 此塊循環列出結果↓↓↓  -->
             <c:forEach var="furIteVO" items="${list}" >
                        <div class="col-lg-4 col-sm-6">
                            <div class="single_product_item">
                               <a href="<%=request.getContextPath()%>/furIte/furIte.do?fnt_it_no=${furIteVO.fnt_it_no}&action=getOneFurIteToFE" >
<%--                                 <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFurPho(furIteVO.fnt_it_no).fnt_pic_no}"  width="222" height="240"> --%>
                                <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFirstFnt_pic_no(furIteVO.fnt_it_no)}"  width="222" height="240">
                                </a>
                                <div class="single_product_text">
<!--                               以下  h4超連結待改成各家具頁面介紹超連結 -->
                                    <h4>${furIteVO.fnt_name}</h4>
                                    <h3>$${furIteVO.fnt_price} /月</h3>
<!--                                   <以下加到購物車> -->
                                    <a class="add_cart">+ 加入租借<i class="far fa-heart" id="${furIteVO.fnt_it_no}" style="color: red"></i></a>
                                </div>
                            </div>
                        </div>
              </c:forEach>          
                        <!-- 各小塊內容 此塊循環列出結果 ↑↑↑ -->
<!-- 此塊看規律用 待刪 ↓↓↓ -->
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
<!-- 此塊看規律用 待刪↑↑↑ -->
                        <!-- 下方分頁 ↓↓↓-->
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
                             <!-- 下方分頁 ↑↑↑ -->
                    </div>
              
                </div>
            </div>
        </div>
    </section>
    
    <div class="modal fade" id="controltext" tabindex="2" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">修改備註</h5>
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
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
	        <button type="button" id="sendtext" class="btn btn-primary">送出</button>
	      </div>
	    </div>
	  </div>
	</div>

    <!--================End Category Product Area =================-->
    
                    <!-- ↓收藏↓ -->
<a class="ml-3 order-xl-last btn btn-info" style='opacity:0.5;' id="collection" data-toggle="canvas" href="#bs-canvas-right" aria-expanded="false" aria-controls="bs-canvas-right" role="button"><i class="fas fa-couch" ><br><br>家具<br>收藏</i></a>
                    <!-- ↑收藏↑ -->

<!-- JS ajax -->

<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>

//分頁
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
				$("#" +　furColVO.fnt_it_no).addClass('fas');
				$("#" +　furColVO.fnt_it_no).removeClass('far');
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
				  $(location).prop('href', '<%=request.getContextPath()%>/unprotected/memTen/login.jsp');
			  }
		})
		return;
	}
	
	if($(this).attr('class').search(/far/) != -1){
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
	alert("加入租借");
})

</script>
<%@ include file="/front-end/footer.file"%>
</body>
</html>
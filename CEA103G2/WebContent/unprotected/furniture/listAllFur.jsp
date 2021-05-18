<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furCat.model.*"%>
<%@ page import="com.furIte.model.*"%>


<%
	List<FurIteVO> list = (List<FurIteVO>) request.getAttribute("QueryResultList");
	pageContext.setAttribute("list", list);
	int listSize = list.size();
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

<jsp:useBean id="furCatSvc" scope="page"
	class="com.furCat.model.FurCatService" />
<jsp:useBean id="furCatSvc2" scope="page"
	class="com.furCat.model.FurCatService" />
<jsp:useBean id="furPhoSvc" scope="page"
	class="com.furPho.model.FurPhoService" />
<!DOCTYPE html>
<html>
<head>
<title>�a���s������</title>
<!-- =================�M��bootstrap�n�ϥΥH�U=========================== -->
<script
	src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<style>
</style>

</head>
<body>
	<!-- include�����C -->
	<%@include file="/front-end/header.file"%>
	<link
		href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css"
		rel="stylesheet" type="text/css">
	<style>
.breadcrumb_bg {
	background-image: url(<%=request.getContextPath()%>/unprotected/furniture/images/Morandi2.jpg);
	background-position: bottom -300px right 0px;
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
<body onload="connect();connectNotice();"
	onunload="disconnect();disconnectNotice();">
	<!-- �����C�U�Ϥ� -->
	<section class="breadcrumb breadcrumb_bg">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-8">
					<div class="breadcrumb_iner">
						<div class="breadcrumb_iner_item">
							<h2>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
								Welcome �n��a��M��</h2>
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
									<c:forEach var="furCatVO" items="${furCatSvc.all}">
										<li><a
											href="<%=request.getContextPath()%>/furIte/furIte.do?action=listGetOnFurIteByCat&fnt_ctgr_no=${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</a>
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
							<div
								class="product_top_bar d-flex justify-content-between align-items-center">
								<div class="single_product_menu">
									<a
										href="<%=request.getContextPath()%>/furIte/furIte.do?action=listAllGetOnFurIte"
										class="genric-btn default" style="font-size: 16px;">�Ҧ��a�� </a>
									<!-- �ݳB�z�L�k��ܤ��a�����O�W -->
									<span style="font-size: 15px;">/ <c:if
											test="${not empty param.fnt_ctgr_no}"> ${furCatSvc2.getOneFurCat(param.fnt_ctgr_no).fnt_ctgr_name}</c:if></span>
									<%-- ���~��C --%>
									<c:if test="${not empty errorMsgs}">
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color: red">${message}</li>
											</c:forEach>
										</ul>
									</c:if>
									<p>
										�@ <span><%=listSize%></span> ���ŦX�j�M���G���a��
									</p>
									<a
										href="<%=request.getContextPath()%>/rentCart/rentCart.do?action=ADD">����</a>
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
								<FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/furIte/furIte.do">
									<div class="single_product_menu d-flex">
										<div class="input-group">
											<input type="text" name="keyword" class="form-control"
												placeholder="search" aria-describedby="inputGroupPrepend">
											<div class="input-group-prepend">
												<!--                                             <span class="input-group-text" id="inputGroupPrepend" ><i class="ti-search"></i></span> -->
												<button class="input-group-text" id="inputGroupPrepend"
													type="submit">
													<i class="ti-search"></i>
												</button>
											</div>
											<input type="hidden" name="action"
												value="keywordSearchFromFE">
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
						<c:forEach var="furIteVO" items="${list}">
							<div class="col-lg-4 col-sm-6">
								<div class="single_product_item">
									<a
										href="<%=request.getContextPath()%>/furIte/furIte.do?fnt_it_no=${furIteVO.fnt_it_no}&action=getOneFurIteToFE">
										<img
										src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFurPho(furIteVO.fnt_it_no).fnt_pic_no}"
										width="222" height="240">
									</a>
									<div class="single_product_text">
										<!--                               �H�U  h4�W�s���ݧ令�U�a�㭶�����жW�s�� -->
										<h4 id="${furIteVO.fnt_name}">${furIteVO.fnt_name}</h4>
										<h3 id="${furIteVO.fnt_price}">$${furIteVO.fnt_price} /��</h3>
										<!--                                   <�H�U�[���ʪ���> -->
										<%--                                     <a href="<%=request.getContextPath()%>/rentCart/rentCart.do?fnt_it_no=${furIteVO.fnt_it_no}&action=ADD&fnt_name=${furIteVO.fnt_name}&requestURL=<%=request.getServletPath()%>&fnt_price=${furIteVO.fnt_price}&quantity=1" class="add_cart">+ �[�J����<i class="ti-heart"></i></a> --%>
										<a href=" "   id="${furIteVO.fnt_it_no}" name="cartButton" class="btn btn-info btn-icon-split" style="color:#46BBA2; background-color:#ffffff; border-color:#46BBA2;">
											�[�J����
										</a>
										<a href=" "  class="add_cart">+
											�[�J����<i class="ti-heart"></i>
										</a>
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

	<!--================End Category Product Area =================-->



	<!-- JS ajax -->

	<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
	<script type="text/javascript">
$("[name*='cartButton']").click(function(e){
	e.preventDefault();
	alert("SUCCESS");
	$.ajax({
		type:"POST",
		url:"<%=request.getContextPath()%>/rentCart/rentCart.do",
		data:{
			"action":"ADD",
        	"fnt_it_no":$(this).attr('id'),
        	"fnt_name":$(this).prev().attr('id'),
			"fnt_price":$(this).prev().prev().attr('id'),
			"quantity":"1",
		},
		success:function(){
			alert("YA! SUCCESS!!!!");
		}
	});
});
// 	e.preventDefault();
	
// 	$(this).prev().attr('id');
// 	$(this).prev().prev().attr('id');
// 	alert($(this).prev().attr('id'));
// 	alert($(this).prev().prev().attr('id'));
// 	});





</script>
	<%@ include file="/front-end/footer.file"%>
</body>
</html>
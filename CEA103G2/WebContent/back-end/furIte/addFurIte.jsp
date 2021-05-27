<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*"%>
<%
	FurIteVO furIteVO = (FurIteVO) request.getAttribute("furIteVO");
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>家具品項資料新增</title>

<!-- Custom fonts for this template-->
<link
	href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link
	href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css"
	rel="stylesheet">

</head>

<body id="page-top"> 

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/back-end/includeFile/sidebarBack.file"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<%@ include file="/back-end/includeFile/topbarBack.file"%>

				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
				<div class="container-fluid">

							<div class="card-body">
								<div class="table-responsive">
									<%-- 錯誤表列 --%>
									<c:if test="${not empty errorMsgs}">
										<font style="color: red">請修正以下錯誤:</font>
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color: red">${message}</li>
											</c:forEach>
										</ul>
									</c:if>
									
										<div class="col-lg-12">
										<table class="table table-bordered" id="dataTable"
											width="100%" cellspacing="0">
											<!--                  ↓↓↓       表單擺放位置↓↓↓↓ -->
					  <section class="checkout_area padding_top">
						    <div class="container">
						
						      <div class="billing_details">
						        <div class="row">
						          <div class="col-lg-12">
						            <h3>家具品項資料新增</h3>
						 <FORM class="row contact_form"  ACTION="<%=request.getContextPath()%>/furIte/furIte.do" name="form1" method="post" novalidate="novalidate">
								<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
								<table>
								 <div class="col-md-7 form-group">
						<!-- 		   <div class="col-md-9 form-group p_star"> -->
								     <label for="fnt_ctgr_no"  class="col-md-5 col-form-lgroup" >家具類別名稱：</label>
						             <div class="col-sm-10">
						                <select class="form-control" name="fnt_ctgr_no">
						                 <option>請選擇</option>
									<c:forEach var="furCatVO" items="${furCatSvc.all}">
										<option value="${furCatVO.fnt_ctgr_no}" ${(furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no)? 'selected':'' } >${furCatVO.fnt_ctgr_name}
									</c:forEach>
						                </select>
						              </div>			             
									</div>
									
									<div class="col-md-7 form-group">
								     <label for=fnt_name  class="col-md-5 col-form-lgroup" >家具品項名稱：</label>
						             <div class="col-sm-10">
						   					  <input type="text" class="form-control" name="fnt_name"  id="inputPassword" placeholder="" value="<%= (furIteVO==null)? "" : furIteVO.getFnt_name()%>">
						              </div>			             
									</div>
									
									
								<div class="col-md-7 form-group"  style="display:none">
								     <label for="fnt_unrent"  class="col-md-5 col-form-lgroup" >可租數量：</label>
						             <div class="col-sm-10">
						   					  <input type="text"  name="fnt_unrent" class="form-control" id="inputPassword" placeholder=""  value="<%= (furIteVO==null)? "0" : furIteVO.getFnt_unrent()%>">
						              </div>			             
								</div>
									
								<div class="col-md-7 form-group"  style="display:none">
								     <label for="fnt_repair"  class="col-md-5 col-form-lgroup" >維修數量：</label>
						             <div class="col-sm-10">
						   					  <input type="text"  name="fnt_repair" class="form-control" id="inputPassword" placeholder=""  value="<%= (furIteVO==null)? "0" : furIteVO.getFnt_repair()%>" >
						              </div>			             
								</div>	
								
								<div class="col-md-7 form-group"  style="display:none">
								     <label for="fnt_total"  class="col-md-5 col-form-lgroup" >總數量：</label>
						             <div class="col-sm-10">
						   					  <input type="text" name="fnt_total"   class="form-control"  value="<%= (furIteVO==null)? "0" : furIteVO.getFnt_total()%>"  placeholder="">
						              </div>			             
								</div>	
									
								<div class="col-md-7 form-group" >
								     <label for="fnt_price"  class="col-md-5 col-form-lgroup" >出租價格：</label>
						             <div class="col-sm-10">
						   					  <input type="text"  name="fnt_price"  class="form-control" value="<%= (furIteVO==null)? "" : furIteVO.getFnt_price()%>" placeholder="">
						              </div>			             
								</div>	
								
								<div class="col-md-7 form-group" >
								     <label for="fnt_length"  class="col-md-5 col-form-lgroup" >長度：</label>
						             <div class="col-sm-10">
						   					  <input type="text"  name="fnt_length" class="form-control"  value="<%= (furIteVO==null)? "" : furIteVO.getFnt_length()%>"  placeholder="">
						              </div>			             
								</div>	
								
									<div class="col-md-7 form-group" >
								     <label for="fnt_width"  class="col-md-5 col-form-lgroup" >寬度：</label>
						             <div class="col-sm-10">
						   					  <input type="text" class="form-control"  name="fnt_width"  value="<%= (furIteVO==null)? "" : furIteVO.getFnt_width()%>"  placeholder="">
						              </div>			             
								</div>	
								
									<div class="col-md-7 form-group" >
								     <label for="fnt_height"  class="col-md-5 col-form-lgroup" >高度：</label>
						             <div class="col-sm-10">
						   					  <input type="text" class="form-control"  name="fnt_height"  value="<%= (furIteVO==null)? "" : furIteVO.getFnt_height()%>"   placeholder="">
						              </div>			             
								</div>	
								
									<div class="col-md-7 form-group" >
								     <label for="fnt_weight"  class="col-md-5 col-form-lgroup" >重量：</label>
						             <div class="col-sm-10">
						   					  <input type="text"  name="fnt_weight" class="form-control"   value="<%= (furIteVO==null)? "" : furIteVO.getFnt_weight()%>"  placeholder="">
						              </div>			             
								</div>	
								
									<div class="col-md-7 form-group" >
								     <label for="fnt_standard"  class="col-md-5 col-form-lgroup" >規格：</label>
						             <div class="col-sm-10">
						   					  <input type="text"  name="fnt_standard" class="form-control"  value="<%= (furIteVO==null)? "" : furIteVO.getFnt_standard()%>"  placeholder="">
						              </div>			             
								</div>	
								
									<div class="col-md-7 form-group" >
								     <label for="fnt_info"  class="col-md-5 col-form-lgroup" >品項介紹：</label>
						             <div class="col-sm-10">
								   		 <textarea class="form-control" name="fnt_info" id="message" rows="3"
						                  placeholder=""></textarea>
						              </div>			             
								</div>	
								
								<div class="col-md-7 form-group"  style="display:none">
								     <label for="fnt_views"  class="col-md-5 col-form-lgroup" >瀏覽次數：</label>
						             <div class="col-sm-10">
						   					  <input type="text" class="form-control"  name="fnt_views"  value="<%= (furIteVO==null)? "0" : furIteVO.getFnt_views()%>"  placeholder="">
						              </div>			             
								</div>
								
										<div class="col-md-7 form-group" >
								     <label for="fnt_post_status"  class="col-md-5 col-form-lgroup" >刊登狀態：</label>
						             <div class="col-sm-10">
								   		   <div class="radion_btn">
						                  <input type="radio" id="f-option6" name="fnt_post_status" value="1"  ${(furIteVO.fnt_post_status==1)? 'checked':''}>
						                  <label for="f-option6">上架 </label>
						                  <img src="img/product/single-product/card.jpg" alt="">
						                  <div class="check"></div>
						                </div>
						                   <div class="radion_btn">
						                  <input type="radio" id="f-option6" name="fnt_post_status" value="0"  ${(furIteVO.fnt_post_status==0)? 'checked':''}>
						                  <label for="f-option6">下架 </label>
						                  <img src="img/product/single-product/card.jpg" alt="">
						                  <div class="check"></div>
						                </div>
						              </div>			             
								</div>	
								 <div class="col-lg-12">
										 <div class="col-lg-10">
										 <a href="<%=request.getContextPath()%>/back-end/furIte/listAllFurIte.jsp" 	class="btn btn-light btn-icon-split"  style="background-color:#F5E5AE">
                                        <span class="text">返回上頁</span>
                                    </a>
										<input type="hidden" name="action" value="insert" >
										<button	class="btn btn-info btn-icon-split" type="submit"> <span class="text">下一步</span></button>
								</div>
								</div>
				           </table>
				            </form>
				          </div>
				        
				        </div>
				      </div>
				    </div>
<!--   </section> -->
											      
											<!--                  ↑↑↑       表單擺放位置↑↑↑↑ -->

										</table>
										 </div>
									</FORM>
									  </section>
								</div>
							</div>
						</div>

					</div>
					<!-- /.container-fluid -->
				
				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<%@ include file="/back-end/includeFile/footerBack.file"%>

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<%@ include file="/back-end/includeFile/otherBack.file"%>

	<!-- Bootstrap core JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>

</body>

</html>
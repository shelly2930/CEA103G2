<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.sql.Timestamp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.furLis.model.*"%>
<%
	FurLisVO furLisVO = (FurLisVO) request.getAttribute("furLisVO");
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

<title>家具資料修改</title>

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
<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>



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
						            <h3>家具資料</h3>
						 <FORM class="row contact_form"  ACTION="<%=request.getContextPath()%>/furLis/furLis.do" name="form1" method="post" novalidate="novalidate">
									<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
										 <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />
								<table>
								
								<div class="col-md-12 form-group" >
								     <label for="fnt_unrent"  class="col-md-5 col-form-lgroup" >家具編號：<%=furLisVO.getFnt_id()%></label>
						             <div class="col-sm-10">
						   					  <span></span>
						              </div>			             
								</div>
								<div class="col-md-12 form-group" >
								     <label for="fnt_unrent"  class="col-md-12 col-form-lgroup" >類別名稱：${furCatSvc.getOneFurCat(furIteSvc.getOneFurIte(furLisVO.fnt_it_no).fnt_ctgr_no).fnt_ctgr_name}</label>
								</div>
								<div class="col-md-12 form-group" >
								     <label for="fnt_unrent"  class="col-md-12 col-form-lgroup" >品項名稱：${furIteSvc.getOneFurIte(furLisVO.fnt_it_no).fnt_name}</label>
								</div>
								
								<!-- 	狀態非報廢時的顯示 -->
								 <c:if test="${(furLisVO.fnt_status!=2)}">
									<div class="col-md-7 form-group">
								     <label for=fnt_name  class="col-md-5 col-form-lgroup" >購置日期：</label>
						             <div class="col-sm-10">
						   					  <input type="text" class="form-control" name="fnt_acq_date"  id="f_date1" placeholder="" >
						              </div>			             
									</div>	
										<input type="hidden" name="ori_fnt_status"  id="ori_fnt_status"  value="${furLisVO.fnt_status}">
										<div class="col-md-7 form-group" >
								     <label for="fnt_status"  class="col-md-5 col-form-lgroup" >家具狀態：</label>
						             <div class="col-sm-10">
								   		   <div class="radion_btn">
						                  <input type="radio" name="fnt_status" value="0"  ${(furLisVO.fnt_status==0)? 'checked':''}>
						                  <label for="f-option6">正常 </label>
						                  <img src="img/product/single-product/card.jpg" alt="">
						                  <div class="check"></div>
						                </div>
						                   <div class="radion_btn">
						                  <input type="radio" name="fnt_status" value="1"  ${(furLisVO.fnt_status==1)? 'checked':''}>
						                  <label for="f-option6">維修 </label>
						                  <img src="img/product/single-product/card.jpg" alt="">
						                  <div class="check"></div>
						                </div>
						                   <div class="radion_btn">
						                  <input type="radio"  name="fnt_status"   id="unusable"  value="2"   ${(furLisVO.fnt_status==2)? 'checked':''}>
						                  <label for="f-option6">報廢 </label>
						                  <img src="img/product/single-product/card.jpg" alt="">
						                  <div class="check"></div>
						                </div>
						              </div>			             
								</div>	
									<input type="hidden" name="ori_fnt_status"  id="fnt_rent_status"  value="${furLisVO.fnt_rent_status}">
										<div class="col-md-7 form-group"  style="display:none">
								     <label for="fnt_rent_status"  class="col-md-5 col-form-lgroup" >租借狀態：</label>
						             <div class="col-sm-10">
								   		   <div class="radion_btn">
						                  <input type="radio" name="fnt_rent_status" value="0"   ${(furLisVO.fnt_status==0)? 'checked':''}>
						                  <label for="f-option6">未出租 </label>
						                  <img src="img/product/single-product/card.jpg" alt="">
						                  <div class="check"></div>
						                </div>
						                   <div class="radion_btn">
						                  <input type="radio"  name="fnt_rent_status" value="1"  ${(furLisVO.fnt_status==1)? 'checked':''}>
						                  <label for="f-option6">出租中</label>
						                  <img src="img/product/single-product/card.jpg" alt="">
						                  <div class="check"></div>
						                </div>
						              </div>			             
								</div>
								<div class="col-md-7 form-group" id="hide">
								     <label for="fnt_name"  class="col-md-5 col-form-lgroup" >報廢日期：</label>
						             <div class="col-sm-10">
						   					  <input type="text" class="form-control" name="fnt_unusable_date"  id="f_date2" placeholder="" >
						              </div>			             
									</div>	
								 <div class="col-lg-12">
										 <div class="col-lg-10">
										 <a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp" 	class="btn btn-light btn-icon-split"  style="background-color:#F5E5AE">
                                        <span class="text">返回上頁</span>
                                    </a>
										<input type="hidden" name="action" value="update" >
										<input type="hidden" name="fnt_id" value="<%=furLisVO.getFnt_id()%>">
										<input type="hidden" name="fnt_it_no" value="<%=furLisVO.getFnt_it_no()%>">
										<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
										<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllEmp.jsp-->
										<button	class="btn btn-info btn-icon-split" type="submit"  id="update"> <span class="text">送出修改</span></button>
								</div>
								</div>
				           </table>
				            </form>
								</c:if>
								<!-- 報廢時顯示頁面 -->
							<c:if test="${(furLisVO.fnt_status==2)}">
							<div class="col-md-12 form-group" >
								     <label for="fnt_unrent"  class="col-md-5 col-form-lgroup" >購置日期：<fmt:formatDate value="${furLisVO.fnt_acq_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></label>
								</div>
							<div class="col-md-12 form-group" >
								     <label for="fnt_unrent"  class="col-md-5 col-form-lgroup" >家具狀態：
								     		<c:choose>
												<c:when test="${furLisVO.fnt_status==0}"> 正常 </c:when>
												<c:when test="${furLisVO.fnt_status==1}"> 維修 </c:when>
												<c:otherwise> 報廢</c:otherwise>
											</c:choose>
								     </label>
								</div>
							<div class="col-md-7 form-group"  style="display:none">
								     <label for="fnt_unrent"  class="col-md-5 col-form-lgroup" >租借狀態：<span>${furLisVO.fnt_rent_status}</span></label>
								</div>
									<div class="col-md-12 form-group" >
								     <label for="fnt_unrent"  class="col-md-5 col-form-lgroup" >報廢日期：<fmt:formatDate value="${furLisVO.fnt_unusable_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></label>
								</div>
	 							<div class="col-lg-12">
										 <div class="col-lg-10">
										 <a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp" 	class="btn btn-light btn-icon-split"  style="background-color:#F5E5AE">
                                        <span class="text">返回上頁</span>
                                    </a>
								</div>
								</div>
									</FORM>
							</c:if>
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
<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
			<!-- Footer -->
			<%@ include file="/back-end/includeFile/footerBack.file"%>

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<%@ include file="/back-end/includeFile/otherBack.file"%>

	<!-- Bootstrap core JavaScript-->
	
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
<!-- 	<script -->
<%-- 		src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script> --%>

	<!-- Page level custom scripts -->
<!-- 	<script -->
<%-- 		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script> --%>
<!-- 	<script -->
<%-- 		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script> --%>

</body>
<% 
Timestamp fnt_acq_date = null;
try {
	    fnt_acq_date =furLisVO.getFnt_acq_date();
 } catch (Exception e) {
	 e.getMessage();
 }

Timestamp fnt_unusable_date = null;
  try {
	    fnt_unusable_date =furLisVO.getFnt_unusable_date();	   
   } catch (Exception e) {
	   e.getMessage();
   }
%>

<script>

$('#hide').hide();
$("#update").prop("disabled",true);
let a = $("#ori_fnt_status").val();
let b = $('#fnt_rent_status').val();
		$('input[name=fnt_status]').change(function(){
			if($("#unusable").prop('checked')){
				$('#hide').show();
			}else{
				$('#hide').hide();
			}
			if($(this).val() == a || $('#fnt_rent_status').val()==1){
				$("#update").prop("disabled",true);
			}else{
				$("#update").prop("disabled",false);
			}
		});
if(b == 1){
	$("input[name='fnt_status']").prop("disabled",true);
}
</script>

<!-- <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>  -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<script type="text/javascript">



function getFurCat(e){ 
    $("#furIteSelect option:not(:first)").remove();
    var fnt_ctgr_no=(e.target.value);
    console.log(fnt_ctgr_no);
    if(fnt_ctgr_no !="" && fnt_ctgr_no !="家具類別"){
        $.ajax({
            url:"<%=request.getContextPath()%>/furIte/furIte.do",
            type:"POST",
            data:{
            	"action":"getFurIteSelect",
            	"fnt_ctgr_no":fnt_ctgr_no,
           },
            success: function(data){
            	 console.log(data);
               showFurItes(data);
                }
            });
    }else {
    	  $.ajax({
              url:"<%=request.getContextPath()%>/furIte/furIte.do",
              type:"POST",
              data:{
              	"action":"getFurIteSelect",
             },
              success: function(data){
              	 console.log(data);
                 showFurItes(data);
                  }
              });
    }
}

function showFurItes(data){
    var fnt_data=data.split(",");
    var txt="";

    if(fnt_data===""){
    	txt+="<option value=\"none\">此類別尚無家具品項</option>";
    
    }else{
    	for(i in fnt_data){
       	 var cut = fnt_data[i].indexOf('-');
        	 txt+="<option value="+fnt_data[i].slice(0,cut)+">"+fnt_data[i].slice(cut+1)+"</option>";
        }  
    }
    $("#furIteSelect").append(txt); 
}

window.addEventListener("load",function (){
 document.getElementById("furCatSelect").onchange=getFurCat;}, false);

		
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value:  '${empty furLisVO ? '' :furLisVO.fnt_unusable_date}', 
        });

        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '${empty furLisVO ? '' :furLisVO.fnt_acq_date}', 
        });
        
</script>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="com.renFurApp.model.*"%>
<!-- 主管看到的頁面 -->
<%
   RenFurAppVO renFurAppVO = (RenFurAppVO) request.getAttribute("renFurAppVO");
//    FurCatService furCatSvc=new FurCatService();
//    FurIteService furIteSvc=new FurIteService();
//    FurIteVO furIteVO=furIteSvc.getOneFurIte(renFurAppVO.fnt_it_no);
//    String fnt_ctgr_name=furCatSvc.getOneFurCat(furIteVO.fnt_ctgr_no).fnt_ctgr_name;
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>租家具申請單修改</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
  table {
	width: 700px;
	height:100px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
    text-align: left;
  }
  	.pageTitle{
		color: #d4dedd;
		letter-spacing: 1rem;
		text-shadow: 1px 1px 2px #233559;
	}
</style>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
       <%@ include file="/back-end/includeFile/sidebarBack.file" %>

         <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

				<!-- Topbar -->
                <%@ include file="/back-end/includeFile/topbarBack.file" %>

                <!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
                <div class="container-fluid">
					
					<div class="mx-auto text-left pageTitle" style="display:inline-block;">
				        <h1 class="mx-auto mb-4 text-uppercase">租家具申請單</h1>
				    </div>
					<a class="btn btn-primary ml-5 btn-lg" href="${pageContext.request.contextPath}/back-end/renFurApp/showAllRenFurApp.jsp" 
						role="button" style="display:inline-block;">返回</a>
					<%-- 錯誤表列 --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color:red">請修正以下錯誤:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color:red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>
					
					
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do" id="form1">
					<table>
						<tr>
							<th>申請單編號:</th>
							<td colspan="3">No.${renFurAppVO.rfa_no}</td>
						</tr>
						<tr>
					  		<th>會員姓名:</th>
					  		<jsp:useBean id="memTenSvc" scope="page" class="com.memTen.model.MemTenService" />
							<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_name}	</td>
							<th>性&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp別:</th>
							<td>
							<c:choose>
								<c:when test="${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_gender==0}"> 男 </c:when>
								<c:otherwise> 女</c:otherwise>
							</c:choose>
							</td>
						</tr>
						<tr>
							<th>連絡電話: </th>
							<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_phone}</td>
							<th>行動電話: </th>
							<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_mobile}</td>
						</tr>
						<tr>
							<th>電子信箱:</th>
							<td colspan="3">${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_email}</td>
						</tr>
						<tr>
							<th>物件地址:</th>
							 <jsp:useBean id="houseSvc" scope="page" class="com.house.model.HouseService" />
							 <jsp:useBean id="renFurAppSvc" scope="page" class="com.renFurApp.model.RenFurAppService" />
							 <jsp:useBean id="renConSvc" scope="page" class="com.renCon.model.RenConService" />
							 <td colspan="3">
								${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_address}${
								houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_floor}樓		
							</td>
						</tr>
						<tr>
							<th>房&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp型:</th>
							<td>
							<c:choose>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==1}">獨立套房</c:when>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==2}">分租套房</c:when>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==3}">雅房</c:when>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==4}">整層住家</c:when>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==5}">車位</c:when>
								<c:otherwise> 其他</c:otherwise>
							</c:choose>
							</td>
							<th>電梯與否:</th>
							<td>
							<c:choose>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_ele==0}"> 否 </c:when>
								<c:otherwise> 是</c:otherwise>
							</c:choose>
							</td>
						</tr>
						<tr>
						<th>申請時間:</th>
						    <td><fmt:formatDate value="${renFurAppVO.rfa_apct_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th>預約時間:</th>
						    <td>
						    	<c:if test="${employeeVO.emp_job eq '主管'}">
						    	<div class="col-md-12 form-group" style="margin-bottom: 0;">
						            <div class="col-sm-12">
						   				<input type="text" class="form-control" name="rfa_order_date"  id="f_date1" placeholder="" >
						            </div>			             
								</div>	
						    	</c:if>
						    	
						    	<c:if test="${employeeVO.emp_job eq '一般員工'}">
						    	${renFurAppVO.rfa_order_date}
						    	<input type="hidden" name="rfa_order_date" value="${renFurAppVO.rfa_order_date}">
						    	</c:if>
						    </td>
						</tr>
						<tr>
					<!-- 	include內的編輯鈕 action2 非action 避免與下方送出修改鈕之action衝突 -->
							<td colspan="4">
							<%if (request.getAttribute("listDets_ByRenFurApp")!=null){%>
								<jsp:include page="listDets_ByRenFurApp_edit.jsp" />
							<%} %>
							</td>
						</tr>
						<tr>
						    <th>申請進度:</th>
							<td>
								<c:if test="${employeeVO.emp_job eq '主管'}">
								<c:choose>
									<c:when test="${renFurAppVO.rfa_status==0}">未指派 </c:when>
									<c:when test="${renFurAppVO.rfa_status==1}">未完成</c:when>
									<c:when test="${renFurAppVO.rfa_status==3}">提早退租</c:when>
									<c:otherwise>已完成</c:otherwise>
								</c:choose>
								<input type="hidden" name="rfa_status" value="${renFurAppVO.rfa_status}">
								</c:if>
							
									 
				
								<c:if test="${employeeVO.emp_job eq '一般員工'}"> 
								<div class="col-md-12 form-group" style="margin-bottom: 0;">
									<div class="col-sm-12">
									   <select class="form-control" name="rfa_status" id="rfa_status"  ${renFurAppVO.rfa_status==2 ? 'disabled':''}>
											<c:if test="${renFurAppVO.rfa_status==1}">
											<option value="1" ${renFurAppVO.rfa_status==1 ? 'selected':''}>未完成</option>
											</c:if>
											<c:if test="${renFurAppVO.rfa_status==3}">
											<option value="3" ${renFurAppVO.rfa_status==3 ? 'selected':''}>提前退租</option>
											</c:if>
											<option value="2" ${renFurAppVO.rfa_status==2 ? 'selected':''}>已完成</option>
								      </select>
									</div>			             
								</div>
								</c:if>
							</td>
							
							<jsp:useBean id="empSvc" scope="page" class="com.employee.model.EmployeeService" />
							<th>負責員工:</th>
							<td>
								<c:if test="${employeeVO.emp_job eq '主管'}">
						        <div class="col-md-12 form-group" style="margin-bottom: 0;">
						            <div class="col-sm-12">
						                <select class="form-control" name="emp_no" id="empSelect" >
				        					<option value="0" ${(renFurAppVO.emp_no == null)? 'selected':''}>尚未指派</option> 
											<c:forEach var="empVO" items="${empSvc.all}">
											<c:if test="${empVO.emp_job eq '一般員工' && empVO.emp_quitdate == null}">
											<option value="${empVO.emp_no}" ${(renFurAppVO.emp_no==empVO.emp_no)? 'selected':'' } >${empVO.emp_name}
											</c:if>
											</c:forEach>
								       </select>
						            </div>			             
								</div>
								</c:if>
								
								<c:if test="${employeeVO.emp_job eq '一般員工'}">
									${empSvc.getOneEmp(renFurAppVO.emp_no).emp_name}
									<input type="hidden" name="emp_no" value="${renFurAppVO.emp_no}">
								</c:if>
							</td>
						</tr>	
						<tr>
							<th>租金合計:</th>
							<td>${renFurAppVO.rfa_total} 元</td>
							
							<jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" />
							<th>租借狀態:</th>
							
							<c:set var="isTMT" value="true" />
							<c:forEach var="renFurDetVO" items="${renFurDetSvc.getOneList(renFurAppVO.rfa_no)}">
								<c:if test="${renFurDetVO.rent_tmt_date == null}"><c:set var="isTMT" value="false" /></c:if>
							</c:forEach>
							
							<td>
								<c:choose>
									<c:when test="${renFurAppVO.rfa_status == 0 || renFurAppVO.rfa_status == 1}">尚未出租 </c:when>
									<c:when test="${isTMT == false}">出租中</c:when>
									<c:when test="${isTMT == true}">已退租</c:when>
								</c:choose>
							</td>
						</tr>
					</table>
					<br>
					<div class="col-lg-12">
						<div class="col-lg-10">
							<button	class="btn btn-info btn-icon-split" type="button" id="update"> <span class="text">送出修改</span></button>
						</div>
					</div>
					<input type="hidden" name="action" value="update" >
					<input type="hidden" name="rfa_no"  value="<%=renFurAppVO.getRfa_no()%>">
					<input type="hidden" name="requestURL"  value="<%=request.getParameter("requestURL")%>">
					<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">
<%-- 					<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用--> --%>
<%-- 					<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllEmp.jsp--> --%>
					</FORM>
					
                </div>
                <!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@ include file="/back-end/includeFile/footerBack.file" %>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <%@ include file="/back-end/includeFile/otherBack.file" %>
    
    <!-- Bootstrap core JavaScript-->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    
    <% 
	Timestamp rfa_order_date = null;
	try {
		rfa_order_date =renFurAppVO.getRfa_order_date();
	 } catch (Exception e) {
		 e.getMessage();
	 }
	%>
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
	<script>
    $.datetimepicker.setLocale('zh');
    $('#f_date1').datetimepicker({
       theme: '',              //theme: 'dark',
       timepicker:true,       //timepicker:true,
       step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
	   value: '${empty renFurAppVO ? '' :renFurAppVO.rfa_order_date}', 
// 		value:   new Date(),
// 		disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
// 		startDate:	            '2017/07/10',  // 起始日
// 		minDate:               '-1970-01-01', // 去除今日(不含)之前
// 		maxDate:               '+1970-01-01'  // 去除今日(不含)之後
    });
    
    if($("#rfa_status").val() == 2){
    	$("#update").prop("disabled",true);
    }

    if($("#rfa_status").val() == 1){
    	$("#update").prop("disabled",true);
    }
    
    $("#rfa_status").change(function(){
	    if($("#rfa_status").val() == 2){
	    	$("#update").prop("disabled",false);
	    }else {
	    	$("#update").prop("disabled",true);
	    }
    });
    
    if($("#empSelect").val() == 0){
    	$("#update").prop("disabled",true);
    }
    
    $("#empSelect").change(function(){
    	
    	if($(this).val() != 0) {
    		$("#update").prop("disabled",false);
    	}else {
    		$("#update").prop("disabled",true);
    	}
    });
    
    let emp_name;
    $("option").each(function(){
		if($(this).prop("selected")){
			emp_name = $(this).text();
		}
	});
    $("#empSelect").change(function(){
    	$("option").each(function(){
    		if($(this).prop("selected")){
    			emp_name = $(this).text();
    		}
    	})
    });
    $("#update").click(function() {
		Swal.fire({
			<c:if test="${employeeVO.emp_job eq '主管'}">
			  title: '確定送出指派？',
			  text: "指派員工：" + emp_name,
			  icon: 'question',
			</c:if>
			<c:if test="${employeeVO.emp_job eq '一般員工'}">
			  title: '確定修改？',
			  text: "此修改送出將無法復原！",
			  icon: 'warning',
			</c:if>
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '確定',
			  cancelButtonText: '取消'
			}).then((result) => {
				if (result.isConfirmed) {
					Swal.fire({
					   	icon:'success',
					   	title:'修改成功',
					   	showConfirmButton: false,
						timer: 1000
					});
					setTimeout(function(){
						$("#form1").submit();
				  	},1000);
				}
			})
	});
    
//     <c:if test="${not empty requestScope.updateSuccess}">
// 	Swal.fire({
//     	icon:'success',
//     	title:'修改成功'
//     });
// 	</c:if>
 	</script>

</body>

</html>
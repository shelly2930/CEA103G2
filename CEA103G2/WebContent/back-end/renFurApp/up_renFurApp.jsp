<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="com.renFurApp.model.*"%>
<!-- �D�ެݨ쪺���� -->
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

    <title>���a��ӽг�ק�</title>

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

                <!--�@�@�@�����������������������e���������������������@�@�@-->
                <div class="container-fluid">
					
					<div class="mx-auto text-left pageTitle" style="display:inline-block;">
				        <h1 class="mx-auto mb-4 text-uppercase">���a��ӽг�</h1>
				    </div>
					<a class="btn btn-primary ml-5 btn-lg" href="${pageContext.request.contextPath}/back-end/renFurApp/showAllRenFurApp.jsp" 
						role="button" style="display:inline-block;">��^</a>
					<%-- ���~��C --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color:red">�Эץ��H�U���~:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color:red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>
					
					
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do" id="form1">
					<table>
						<tr>
							<th>�ӽг�s��:</th>
							<td colspan="3">No.${renFurAppVO.rfa_no}</td>
						</tr>
						<tr>
					  		<th>�|���m�W:</th>
					  		<jsp:useBean id="memTenSvc" scope="page" class="com.memTen.model.MemTenService" />
							<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_name}	</td>
							<th>��&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp�O:</th>
							<td>
							<c:choose>
								<c:when test="${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_gender==0}"> �k </c:when>
								<c:otherwise> �k</c:otherwise>
							</c:choose>
							</td>
						</tr>
						<tr>
							<th>�s���q��: </th>
							<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_phone}</td>
							<th>��ʹq��: </th>
							<td>${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_mobile}</td>
						</tr>
						<tr>
							<th>�q�l�H�c:</th>
							<td colspan="3">${memTenSvc.getOneMemTen(renFurAppVO.mem_no).mem_email}</td>
						</tr>
						<tr>
							<th>����a�}:</th>
							 <jsp:useBean id="houseSvc" scope="page" class="com.house.model.HouseService" />
							 <jsp:useBean id="renFurAppSvc" scope="page" class="com.renFurApp.model.RenFurAppService" />
							 <jsp:useBean id="renConSvc" scope="page" class="com.renCon.model.RenConService" />
							 <td colspan="3">
								${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_address}${
								houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_floor}��		
							</td>
						</tr>
						<tr>
							<th>��&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp��:</th>
							<td>
							<c:choose>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==1}">�W�߮M��</c:when>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==2}">�����M��</c:when>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==3}">����</c:when>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==4}">��h��a</c:when>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_type==5}">����</c:when>
								<c:otherwise> ��L</c:otherwise>
							</c:choose>
							</td>
							<th>�q��P�_:</th>
							<td>
							<c:choose>
								<c:when test="${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_ele==0}"> �_ </c:when>
								<c:otherwise> �O</c:otherwise>
							</c:choose>
							</td>
						</tr>
						<tr>
						<th>�ӽЮɶ�:</th>
						    <td><fmt:formatDate value="${renFurAppVO.rfa_apct_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th>�w���ɶ�:</th>
						    <td>
						    	<c:if test="${employeeVO.emp_job eq '�D��'}">
						    	<div class="col-md-12 form-group" style="margin-bottom: 0;">
						            <div class="col-sm-12">
						   				<input type="text" class="form-control" name="rfa_order_date"  id="f_date1" placeholder="" >
						            </div>			             
								</div>	
						    	</c:if>
						    	
						    	<c:if test="${employeeVO.emp_job eq '�@����u'}">
						    	${renFurAppVO.rfa_order_date}
						    	<input type="hidden" name="rfa_order_date" value="${renFurAppVO.rfa_order_date}">
						    	</c:if>
						    </td>
						</tr>
						<tr>
					<!-- 	include�����s��s action2 �Daction �קK�P�U��e�X�ק�s��action�Ĭ� -->
							<td colspan="4">
							<%if (request.getAttribute("listDets_ByRenFurApp")!=null){%>
								<jsp:include page="listDets_ByRenFurApp_edit.jsp" />
							<%} %>
							</td>
						</tr>
						<tr>
						    <th>�ӽжi��:</th>
							<td>
								<c:if test="${employeeVO.emp_job eq '�D��'}">
								<c:choose>
									<c:when test="${renFurAppVO.rfa_status==0}">������ </c:when>
									<c:when test="${renFurAppVO.rfa_status==1}">������</c:when>
									<c:when test="${renFurAppVO.rfa_status==3}">�����h��</c:when>
									<c:otherwise>�w����</c:otherwise>
								</c:choose>
								<input type="hidden" name="rfa_status" value="${renFurAppVO.rfa_status}">
								</c:if>
							
									 
				
								<c:if test="${employeeVO.emp_job eq '�@����u'}"> 
								<div class="col-md-12 form-group" style="margin-bottom: 0;">
									<div class="col-sm-12">
									   <select class="form-control" name="rfa_status" id="rfa_status"  ${renFurAppVO.rfa_status==2 ? 'disabled':''}>
											<c:if test="${renFurAppVO.rfa_status==1}">
											<option value="1" ${renFurAppVO.rfa_status==1 ? 'selected':''}>������</option>
											</c:if>
											<c:if test="${renFurAppVO.rfa_status==3}">
											<option value="3" ${renFurAppVO.rfa_status==3 ? 'selected':''}>���e�h��</option>
											</c:if>
											<option value="2" ${renFurAppVO.rfa_status==2 ? 'selected':''}>�w����</option>
								      </select>
									</div>			             
								</div>
								</c:if>
							</td>
							
							<jsp:useBean id="empSvc" scope="page" class="com.employee.model.EmployeeService" />
							<th>�t�d���u:</th>
							<td>
								<c:if test="${employeeVO.emp_job eq '�D��'}">
						        <div class="col-md-12 form-group" style="margin-bottom: 0;">
						            <div class="col-sm-12">
						                <select class="form-control" name="emp_no" id="empSelect" >
				        					<option value="0" ${(renFurAppVO.emp_no == null)? 'selected':''}>�|������</option> 
											<c:forEach var="empVO" items="${empSvc.all}">
											<c:if test="${empVO.emp_job eq '�@����u' && empVO.emp_quitdate == null}">
											<option value="${empVO.emp_no}" ${(renFurAppVO.emp_no==empVO.emp_no)? 'selected':'' } >${empVO.emp_name}
											</c:if>
											</c:forEach>
								       </select>
						            </div>			             
								</div>
								</c:if>
								
								<c:if test="${employeeVO.emp_job eq '�@����u'}">
									${empSvc.getOneEmp(renFurAppVO.emp_no).emp_name}
									<input type="hidden" name="emp_no" value="${renFurAppVO.emp_no}">
								</c:if>
							</td>
						</tr>	
						<tr>
							<th>�����X�p:</th>
							<td>${renFurAppVO.rfa_total} ��</td>
							
							<jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" />
							<th>���ɪ��A:</th>
							
							<c:set var="isTMT" value="true" />
							<c:forEach var="renFurDetVO" items="${renFurDetSvc.getOneList(renFurAppVO.rfa_no)}">
								<c:if test="${renFurDetVO.rent_tmt_date == null}"><c:set var="isTMT" value="false" /></c:if>
							</c:forEach>
							
							<td>
								<c:choose>
									<c:when test="${renFurAppVO.rfa_status == 0 || renFurAppVO.rfa_status == 1}">�|���X�� </c:when>
									<c:when test="${isTMT == false}">�X����</c:when>
									<c:when test="${isTMT == true}">�w�h��</c:when>
								</c:choose>
							</td>
						</tr>
					</table>
					<br>
					<div class="col-lg-12">
						<div class="col-lg-10">
							<button	class="btn btn-info btn-icon-split" type="button" id="update"> <span class="text">�e�X�ק�</span></button>
						</div>
					</div>
					<input type="hidden" name="action" value="update" >
					<input type="hidden" name="rfa_no"  value="<%=renFurAppVO.getRfa_no()%>">
					<input type="hidden" name="requestURL"  value="<%=request.getParameter("requestURL")%>">
					<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">
<%-- 					<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--������e�X�ק諸�ӷ��������|��,�A�e��Controller�ǳ���椧��--> --%>
<%-- 					<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--�u�Ω�:istAllEmp.jsp--> --%>
					</FORM>
					
                </div>
                <!--�@�@�@�����������������������e���������������������@�@�@-->

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
       step: 30,                //step: 60 (�o�Otimepicker���w�]���j60����)
       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
	   value: '${empty renFurAppVO ? '' :renFurAppVO.rfa_order_date}', 
// 		value:   new Date(),
// 		disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
// 		startDate:	            '2017/07/10',  // �_�l��
// 		minDate:               '-1970-01-01', // �h������(���t)���e
// 		maxDate:               '+1970-01-01'  // �h������(���t)����
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
			<c:if test="${employeeVO.emp_job eq '�D��'}">
			  title: '�T�w�e�X�����H',
			  text: "�������u�G" + emp_name,
			  icon: 'question',
			</c:if>
			<c:if test="${employeeVO.emp_job eq '�@����u'}">
			  title: '�T�w�ק�H',
			  text: "���ק�e�X�N�L�k�_��I",
			  icon: 'warning',
			</c:if>
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '�T�w',
			  cancelButtonText: '����'
			}).then((result) => {
				if (result.isConfirmed) {
					Swal.fire({
					   	icon:'success',
					   	title:'�ק令�\',
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
//     	title:'�ק令�\'
//     });
// 	</c:if>
 	</script>

</body>

</html>
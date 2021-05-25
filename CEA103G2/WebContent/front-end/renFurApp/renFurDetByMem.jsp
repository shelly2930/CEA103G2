<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.renFurApp.model.*"%>

<%
   RenFurAppVO renFurAppVO = (RenFurAppVO) request.getAttribute("renFurAppVO");
//    FurCatService furCatSvc=new FurCatService();
//    FurIteService furIteSvc=new FurIteService();
//    FurIteVO furIteVO=furIteSvc.getOneFurIte(renFurAppVO.fnt_it_no);
//    String fnt_ctgr_name=furCatSvc.getOneFurCat(furIteVO.fnt_ctgr_no).fnt_ctgr_name;
%>


<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<title>���a��ӽг����</title>

<style>
/* body {  */
/* background-color: #dddddd !important; */
/* } */

.genric-btn.info {
    color: #fff;
    background: #61d2b4 !important;
    border: 1px solid transparent;
    font-size: 16px;
    width: 80px;
    height: 40px;
    margin: 5px;

}

.genric-btn.radius {
    border-radius: 20px !important;
}

.genric-btn {
	line-height:2 !important;
}

.genric-btn.info:hover {
    color: #38a4ff;
    border: 1px solid #38a4ff;
    background: #fff !important;
}

</style>

</head>
<body>
<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>

<!--================ Content Area start =================-->
<section class="cat_product_area section_padding">
	<div class="container">
		<div class="row">
            <!--================ Sidebar =================-->    
			<%@include file="/front-end/sidebarFront.file"%>
                
            <div class="col-lg-10 content">
                
                <!--================ ���n���ܦۤv�R�� =================-->
                <div class="pagetitle">���a��ӽг����
                	<a href="<%=request.getContextPath()%>/front-end/renFurApp/listRenFurAppByMem.jsp" class="genric-btn info radius">��^</a>
                </div>
				
				<!--�@�@�@�����������������������e���������������������@�@�@-->
				<%-- ���~��C --%>
				<c:if test="${not empty errorMsgs}">
					<font style="color:red">�Эץ��H�U���~:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color:red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
				
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do" name="form1">
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
<%-- 		${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_city} --%>
<%-- 				${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_dist}		 --%>
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
	    <td><fmt:formatDate value="${renFurAppVO.rfa_apct_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
	<th>�w���ɶ�:</th>
	    <td><fmt:formatDate value="${renFurAppVO.rfa_order_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
		<td><c:choose>
							<c:when test="${renFurAppVO.rfa_status==0}"> ���B�z </c:when>
							<c:when test="${renFurAppVO.rfa_status==1}"> �B�z��</c:when>
							<c:otherwise> �w����</c:otherwise>
						</c:choose>
				</td>
		<th>�����X�p:</th>
		
	<td>${renFurAppVO.rfa_total} ��</td>
	</tr>	
	
	
</table>
<!-- <br> -->
<!-- <input type="hidden" name="action"  value="update"> -->
<!-- <input type="submit" value="�e�X�ק�"  id="update"> -->
<%-- <input type="hidden" name="rfa_no" value="<%=renFurAppVO.getRfa_no()%>"> --%>
<%-- <input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--������e�X�ק諸�ӷ��������|��,�A�e��Controller�ǳ���椧��--> --%>
<%-- <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--�u�Ω�:istAllEmp.jsp--> --%>

<script>
// 	$("input[type='submit']").click(function(e){
// 		if($("select").val()==0){
// 			alert("�|�������t�d���u !!!");
// 		}
// 		e.preventDefault(); //����U�Ӱʧ@
// 	})
	
</script>
<!-- �b���ޤJ���Ӥ��� -->
<%-- <%if (request.getAttribute("listDets_ByRenFurApp")!=null){%> --%>
<%--        <jsp:include page="listDets_ByRenFurApp_edit.jsp" /> --%>
<%-- <%} %> --%>

</FORM>
					


				<!--�@�@�@�����������������������e���������������������@�@�@-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

</body>

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�A�[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->




<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<!-- <style> -->
<!-- /*   .xdsoft_datetimepicker .xdsoft_datepicker { */ -->
<!-- /*            width:  300px;   /* width:  300px; */ */ -->
<!-- /*   } */ -->
<!-- /*   .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box { */ -->
<!-- /*            height: 151px;   /* height:  151px; */ */ -->
<!-- /*   } */ -->
<!-- </style> -->

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '${empty renFurAppVO ? '' :renFurAppVO.rfa_order_date}', 
// 		   // value:   new Date(),
//            //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
//            //startDate:	            '2017/07/10',  // �_�l��
//            //minDate:               '-1970-01-01', // �h������(���t)���e
// //            maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        
   
        // ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

        //      1.�H�U���Y�@�Ѥ��e������L�k���
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.�H�U���Y�@�Ѥ��᪺����L�k���
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.�H�U����Ӥ�����~������L�k��� (�]�i���ݭn������L���)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //	           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>



<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
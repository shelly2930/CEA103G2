<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.furLis.model.*"%>
<%-- <%@ page import="com.furIte.model.*"%> --%>
<%-- <%@ page import="com.furCat.model.*"%> --%>

	<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
	 <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />

<%
   FurLisVO furLisVO = (FurLisVO) request.getAttribute("furLisVO");
//    FurCatService furCatSvc=new FurCatService();
//    FurIteService furIteSvc=new FurIteService();
//    FurIteVO furIteVO=furIteSvc.getOneFurIte(furLisVO.fnt_it_no);
//    String fnt_ctgr_name=furCatSvc.getOneFurCat(furIteVO.fnt_ctgr_no).fnt_ctgr_name;
%>

<!-- �q�M����}�l -->
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�a���ƭק� - update_furLis_input.jsp</title>

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
	width: 600px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3 id="editOrLook">�a���� - updateFurIte.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">��^�a��޲z</a></h4>
	</td></tr>
</table>

<h3>�a����:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furLis/furLis.do" name="form1">
<table>
	<tr>
		<th>�a��s��:</th>
		<td><%=furLisVO.getFnt_id()%></td>
	</tr>
	<tr>
  		<th>�a�����O�W��:</th>
		<td>${furCatSvc.getOneFurCat(furIteSvc.getOneFurIte(furLisVO.fnt_it_no).fnt_ctgr_no).fnt_ctgr_name}
		</td>
	</tr>
	<tr>
		<th>�a��~���W��: </th>
		<td> ${furIteSvc.getOneFurIte(furLisVO.fnt_it_no).fnt_name}</td>
	</tr>
<!-- 	���A�D���o�ɪ���� -->
 <c:if test="${(furLisVO.fnt_status!=2)}">
	<tr>
		<th>�ʸm���:</th>
		<td><input name="fnt_acq_date" id="f_date1" type="text"></td>
	</tr>
	
	<tr>
		<th>�a�㪬�A:</th>
		<td>
				<input type="hidden" name="ori_fnt_status"  id="ori_fnt_status"  value="${furLisVO.fnt_status}">
		         <input type="radio" name="fnt_status" value="0"  ${(furLisVO.fnt_status==0)? 'checked':''}>���`
		         <input type="radio" name="fnt_status" value="1"  ${(furLisVO.fnt_status==1)? 'checked':''}>����
		         <input type="radio" name="fnt_status"  id="unusable"  value="2"  ${(furLisVO.fnt_status==2)? 'checked':''}>���o
		</td>
	</tr>

	<tr style="display:none">
		<th>���ɪ��A:</th>
		<td>
		<input type="radio" name="fnt_rent_status" value="0"  ${(furLisVO.fnt_rent_status==0)? 'checked':''}>���X��
		<input type="radio" name="fnt_rent_status" value="1"  ${(furLisVO.fnt_rent_status==1)? 'checked':''}>�X����
		</td>
	</tr>
	<tr id="hide">
		<th>���o���:</th>
		<td><input name="fnt_unusable_date" id="f_date2" type="text"></td>
	</tr>
	
</table>
<br>
<input type="submit" value="�e�X�ק�"  id="update">
<input type="hidden" name="fnt_id" value="<%=furLisVO.getFnt_id()%>">
<input type="hidden" name="fnt_it_no" value="<%=furLisVO.getFnt_it_no()%>">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--������e�X�ק諸�ӷ��������|��,�A�e��Controller�ǳ���椧��-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--�u�Ω�:istAllEmp.jsp-->
<input type="hidden" name="action"  value="update">
</FORM>
</c:if>	

<!-- ���o����ܭ��� -->
<c:if test="${(furLisVO.fnt_status==2)}">
			<tr>
				<th>�ʸm���:</th>
				<td><fmt:formatDate value="${furLisVO.fnt_acq_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			
			<tr>
				<th>�a�㪬�A:</th>
				<td>${furLisVO.fnt_status}</td>
			</tr>
		
			<tr style="display:none">
				<th>���ɪ��A:</th>
				<td>${furLisVO.fnt_rent_status}</td>
			</tr>
			<tr>
				<th>���o���:</th>
				<td><fmt:formatDate value="${furLisVO.fnt_unusable_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			
		</table>
		<br>
		</FORM>
</c:if>
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

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

<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
// ���A����
$('#hide').hide();
$("#update").prop("disabled",true);
let a = $("#ori_fnt_status").val();
	
		$('input[name=fnt_status]').change(function(){
			if($("#unusable").prop('checked')){
				$('#hide').show();
			}else{
				$('#hide').hide();
			}
			if($(this).val() != a){
				$("#update").prop("disabled",false);
			}else{
				$("#update").prop("disabled",true);
			}
		});

		$.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value:  '${empty furLisVO ? '' :furLisVO.fnt_unusable_date}', 
		   // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
//            maxDate:               '+1970-01-01'  // �h������(���t)����
        });

        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '${empty furLisVO ? '' :furLisVO.fnt_acq_date}', 
// 		   // value:   new Date(),
//            //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
//            //startDate:	            '2017/07/10',  // �_�l��
//            //minDate:               '-1970-01-01', // �h������(���t)���e
// //            maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        

        
</script>
</html>
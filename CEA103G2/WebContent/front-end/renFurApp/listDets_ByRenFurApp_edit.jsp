<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="com.renFurDet.model.*"%>
<%@ page import="java.util.*"%>

<!-- �b������renFurAPP controller����椺�e  �äޥΦL�X-->
<jsp:useBean id="listDets_ByRenFurApp" scope="request" type="java.util.List<RenFurDetVO>" /> <!-- ��EL����i�ٲ� -->

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�A�[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<html>
<head><title>�ӽг����</title>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }

.choosetime {
	font-weight:700;
	margin:30px;
	color:red;
}

</style>

</head>
<body bgcolor='white'>

<h4 style="color:black;text-align:left;">�ӽг����: </h4>


<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/MemRenFurAppServlet" >
<table>
	<tr>
		<th></th>
		<th>�a��<br>�Ǹ�</th>
		<th>�a��W��</th>
		<th>�a�㯲��</th>
		<th>�X�����</th>
		<th>�פ���</th>
		<th>�ѯ����</th>
<!-- 		<th>�s��</th> -->
<!-- 		<th>�R��</th> -->
	</tr>
	<c:forEach var="renFurDetVO" items="${listDets_ByRenFurApp}">
  <jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" />
  <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />
  <jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" />
<%-- 						<c:forEach var="renFurDetVO" items="${renFurDetSvc.all}" > --%>
	<tr>
			<c:if test="${renFurAppVO.rfa_no==renFurDetVO.rfa_no}">
					
<%-- 	���ե� �i�}����ܥӽг�s��		<td>${renFurDetVO.rfa_no}</td> --%>
			<td>
				<input type="checkbox" id="${renFurDetVO.fnt_id}input" name="no" value="${renFurDetVO.fnt_id}" ${renFurDetVO.rent_tmt_date!=null? 'disabled':''}>
			</td>						
			<td>${renFurDetVO.fnt_id}</td>
			<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_name}</td>
			 <td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price} ��</td>
			<td id="rentdate"><fmt:formatDate value="${renFurDetVO.rent_date}"	pattern="yyyy-MM-dd" /></td>
			<td><fmt:formatDate value="${renFurDetVO.rent_end_date}"	pattern="yyyy-MM-dd" /></td>
			<td><fmt:formatDate value="${renFurDetVO.rent_tmt_date}"	pattern="yyyy-MM-dd " /></td>
<!-- 			<td>  -->
<%-- 			         <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do" style="margin-bottom: 0px;"> --%>
<!-- 		             <input type="submit" value="�s��"> -->
<%-- 			         <input type="hidden" name="rfa_no"  value="${renFurDetVO.rfa_no}"> --%>
<%-- 			         <input type="hidden" name="fnt_id"  value="${renFurDetVO.fnt_id}"> --%>
<%-- 			         <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller--> --%>
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
<!--  			         <input type="hidden" name="action2" value="getOne_For_Update"></FORM>  -->
<!-- 		   </td>  -->
<!-- 		   <td>  -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do" style="margin-bottom: 0px;"> --%>
<!-- 		          <input type="submit" value="�R��"> -->
<%-- 			     <input type="hidden" name="rfa_no"  value="${renFurDetVO.rfa_no}"> --%>
<%-- 			      <input type="hidden" name="fnt_id"  value="${renFurDetVO.fnt_id}"> --%>
<%-- 			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller--> --%>
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
<!--  			     <input type="hidden" name="action2" value="delete"></FORM>  -->
<!-- 			</td> -->
		</c:if>
	</c:forEach>
</table>

<div class="choosetime">
�п�ܦ��f�ɶ�
	<input type="text" size="50" name="rent_tmt_date" id="rent_tmt_date" placeholder="��ܦ��f�ɶ�" required style="border:red 1px solid;"/>
</div>

<input type="hidden" name="action"  value="renTerminate">
<input type="submit" class="terminate" value="�h��">
<!-- <input type="button" class="show" value="�h��"> -->




</FORM>
</body>




<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

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
        $.datetimepicker.setLocale('zh');
        var somedate1 = new Date();
        somedate1.setTime(somedate1.getTime()+24*60*60*2000);
        $('#rent_tmt_date').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
	       value: '${rent_tmt_date}',
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
            minDate:               somedate1, // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });

   
        // ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

        //      1.�H�U���Y�@�Ѥ��e������L�k���
//              var somedate1 = new Date();
//              somedate1.setTime(somedate1.getTime()+24*60*60*14000); 
//              $('#rtct_eff_date').datetimepicker({
//                  beforeShowDay: function(date) {
//                	  if (  date.getYear() <  somedate1.getYear() || 
//         		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
//         		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
//                      ) {
//                           return [false, ""]
//                      }
//                      return [true, ""];
//              }});

        
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
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        


// 	$("#terminate").click(function(e){
// 		if($(":checkbox").val()==0){
// 			alert("�|����ܭn�h�����a��");
// 		}
// 		e.preventDefault(); //����U�Ӱʧ@
// 	})


// 	if(!$('#rent_date').html()){ // �f�e��F�~��h��
// 		alert("aaaa");
// 		return
// 	}

	$(".choosetime").hide();

	$(".terminate").prop("disabled",true);
	$("input[name='no']").change(function(){
		$(".terminate").prop("disabled",true);
		$("input[name='no']").each(function(){
			if($(this).prop("checked") == true){
				if($('#rentdate').html()){ // �f�e��F�~��h��
					$(".choosetime").show();
					$(".terminate").prop("disabled",false);
				}else{
					$(".choosetime").hide();
					$(".terminate").prop("disabled",true);
				}
				
			}
		})
	})
	
	// �S�g����ajax
	$(".show").click(function(e){
		if($('#rent_tmt_date').val()){
			Swal.fire({
				  title: '�z�T�w�n�h����?',
				  text: "���U�T�w��N�L�k����!",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#6495ed',
				  cancelButtonColor: '#fa8072',
				  confirmButtonText: '�T�w',
				  cancelButtonText: '�ڦA�Q�Q'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
							url:'<%=request.getContextPath()%>/MemRenFurAppServlet',
							type: 'post',
							data:{
								action:'renTerminate',
								
							},
							async:false,
							success:function(){
								
							}
					})
				  }
			})
		}
		
		
	})
	
// 	$(".terminate").click(function(e){
// 		Swal.fire({
//   			title: '�Х���ܦ��f�ɶ�',
//   			html:
//     		// �L�k��required����
//   			'<input type="text" id="rent_tmt_date" name="rent_tmt_date" class="swal2-input" placeholder="��ܦ��f�ɶ�">',
//     		showCloseButton: true,
//     		showDenyButton: true,
//     		confirmButtonText: "�T�{",
//     		denyButtonText: "����",
//     		onOpen: function() {
// //     			$.datetimepicker.setLocale('zh');
//     	        var somedate1 = new Date();
//     	        somedate1.setTime(somedate1.getTime()+24*60*60*2000);
//     	        $('#rent_tmt_date').datetimepicker({
//     		       theme: '',              //theme: 'dark',
//     		       timepicker:true,       //timepicker:true,
//     		       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
//     		       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
//     		       value: '${rent_tmt_date}',
//     	           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
//     	           //startDate:	            '2017/07/10',  // �_�l��
//     	            minDate:               somedate1, // �h������(���t)���e
//     	           //maxDate:               '+1970-01-01'  // �h������(���t)����
//     	        });
//     	    },
// 		}).then(function(result) {

// 		});
// 	})
	
// 	$('#button').click(() => {
//   swal({
//     title: 'Date picker',
//     html: '<input id="datepicker">',
//     showConfirmButton: false,
//     onOpen: function() {
//     	$('#datepicker').datetimepicker({});
//     },

//   }).then(function(result) {
//     swal({
//       type: 'success',
//       html: 'You entered: <strong>' + result + '</strong>'
//     });
//   });
// });
	
	
</script>

</html>
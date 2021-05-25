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
				<input type="checkbox" id="${renFurDetVO.fnt_id}input" name="no" value="${renFurDetVO.fnt_id}" ${renFurDetVO.rent_tmt_date!=null?'disabled':''}>
			</td>						
			<td>${renFurDetVO.fnt_id}</td>
			<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_name}</td>
			 <td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price} ��</td>
			<td><fmt:formatDate value="${renFurDetVO.rent_date}"	pattern="yyyy-MM-dd" /></td>
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
<input type="button" class="terminate" value="�h��">
<a href="#" class="genric-btn info radius" id="terminate">�h��</a>
</body>

<script>
// 	$("#terminate").click(function(e){
// 		if($(":checkbox").val()==0){
// 			alert("�|����ܭn�h�����a��");
// 		}
// 		e.preventDefault(); //����U�Ӱʧ@
// 	})
	$(".terminate").prop("disabled",true);
	$("input[name='no']").change(function(){
		$(".terminate").prop("disabled",true);
		$("input[name='no']").each(function(){
			if($(this).prop("checked") == true){
				$(".terminate").prop("disabled",false);
			}
		})
	})
</script>




</html>
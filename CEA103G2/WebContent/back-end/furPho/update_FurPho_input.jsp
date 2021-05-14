<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furPho.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%
  FurPhoVO furPhoVO = (FurPhoVO) request.getAttribute("furPhoVO"); //EmpServlet.java (Concroller) �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
  FurIteService furIteSvc = new FurIteService();
  FurIteVO furIteVO=new FurIteVO();
  furIteVO=furIteSvc.getOneFurIte(furPhoVO.getFnt_it_no());
  pageContext.setAttribute("furIteVO",furIteVO);
%>

�ݳB�z�󴫷Ӥ����D

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�a��Ӥ��ק� </title>

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
	width: 630px;
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
		 <h3>�a��~���Ӥ��ק� - update_FurPho_input.jsp</h3>
		 </td>
	<td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furPho/listAllFurPho.jsp?fnt_it_no=10"><img src="images/tomcat.png" width="100" height="100" border="0">��^�a��Ӥ��޲z</a></h4>
	</td></tr>
</table>

<h3>��ƭק�:</h3>

<%-- ���~���C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furPho/furPho.do" enctype="multipart/form-data" name="form1">
<table>
<tr>
	<th>�Ӥ��s��:</th>
	<td>${furPhoVO.fnt_pic_no}</td>
	
</tr>

<!-- 	<tr> -->
<!-- 		<th>�a�����O�W�١G</th> -->
<%-- 		<td>${furIteVO.fnt_name}</td> --%>
<!-- 			����ݧ� -->
<!-- ��l�Ѹ�Ʈw�a�J������ �ѷӤ�VO���~���s�� ���^�P�~���s�� �A�ѫ~���s���������s�� �a�^�����W�� -->
<%-- <c:if test="${not empty  furPhoVO}"> --%>
<%-- <c:forEach var="furIteVO" items="${furIteDAO.all}"> --%>
<%-- 						<c:if test="${furPhoVO.fnt_it_no==furIteVO.fnt_it_no}"> --%>
<%-- 							<c:forEach var="furCatVO" items="${furCatDAO.all}"> --%>
<%-- 								<c:if test="${furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no}"> --%>
<%--                    <option> ${furCatVO.fnt_ctgr_name}</option> --%>
<%--                     </c:if> --%>
<%-- 							</c:forEach> --%>
<%-- 						</c:if> --%>
<%-- 					</c:forEach> --%>
<%-- 					</c:if> --%>
<!-- 				updTE -->
<%-- 				<c:if test="${not empty  furPhoVO}"> --%>
<%-- 						<c:forEach  var="furIteVO"  items="${furIteSvc.all}"> --%>
<%-- 						<c:if test="${furPhoVO.fnt_it_no==furIteVO.fnt_it_no}"> --%>
<%-- 							<c:forEach var="furCatVO" items="${furCatSvc.all}"> --%>
<%-- 							<option value="${furCatVO.fnt_ctgr_no}" ${(furCatVO.fnt_ctgr_no==furIteVO.fnt_ctgr_no)? 'selected':'' } > ${furCatVO.fnt_ctgr_name} --%>
<%-- 							</c:forEach> --%>
<%-- 						</c:if> --%>
<%-- 					</c:forEach> --%>
<%-- 				</c:if> --%>
				
				<!-- 				����ɪ����p -->
<%-- 				<c:if test="${not empty  fnt_ctgr_no}"> --%>
<%-- 				<c:forEach var="furCatVO" items="${furCatSvc.all}"> --%>
<%-- 				<option value="${furCatVO.fnt_ctgr_no}" ${(fnt_ctgr_no==furCatVO.fnt_ctgr_no)? 'selected':'' } > ${furCatVO.fnt_ctgr_name}</option> --%>
<%-- 			</c:forEach>       --%>
<%-- 				</c:if> --%>

<!-- �Ȯɴ��� �ݧ令ajax onchange���� -->
		
	<tr>
		<th>�~���W�١G</th>
			<td>${furIteVO.fnt_name}</td>
<!-- 		<td><select size="1" name="fnt_it_no" size="20" id="furIteSelect"> -->
<!-- 				<option>�п��</option> -->
<!-- 			�ק�S���� -->
<%-- 				<c:if test="${not empty fnt_ctgr_no}">  --%>
<%-- 				<c:forEach var="furIteVO" items="${furIteSvc.all}"> --%>
<%-- 				<option value="${furIteVO.fnt_it_no}" ${(furIteVO.fnt_it_no==furPhoVO.fnt_it_no)? 'selected':'' } >${furIteVO.fnt_name}</option> --%>
<%-- 			</c:forEach> --%>
<%-- 			</c:if> --%>
<!-- 				�q��ݰe�Ӫ���ﶵ -->
<!-- <�Ѧ��}�l��> -->
<%-- 				<c:if test="${not empty  furPhoVO}">  --%>
<%-- 			<c:forEach  var="furIteVO"  items="${furIteSvc.all}"> --%>
<%-- 						<c:if test="${(furIteVO.fnt_it_no==furPhoVO.fnt_it_no)}"> --%>
<%-- 							<c:forEach var="furCatVO" items="${furCatSvc.all}">						 --%>
<%-- 							<option value="${furIteVO.fnt_it_no}" ${(furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no)? 'selected':'' } > ${furIteVO.fnt_name}</option>							 --%>
<%-- 							</c:forEach> --%>
<%-- 						</c:if> --%>
<%-- 					</c:forEach> --%>
<%-- 			</c:if>     --%>
<!-- 		</select></td> -->
<!-- 		�إ߷s�W�a�����O���s -->
	</tr>
	
	<tr>
		<th>�a��Ӥ��G</th>
		<td>
		<img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}"
					height="100">
		<input type="file" id="load" name="fnt_pic" size="45" />
		</td>
	</tr>


</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="fnt_pic_no"  value="<%=furPhoVO.getFnt_pic_no()%>">
<input type="hidden" name="fnt_it_no"  value="<%=furPhoVO.getFnt_it_no()%>">
<input type="submit" value="�e�X�ק�"></FORM>
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->


</html>
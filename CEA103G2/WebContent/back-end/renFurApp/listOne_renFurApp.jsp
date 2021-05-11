<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="java.util.*"%>


<%
   RenFurAppVO renFurAppVO = (RenFurAppVO) request.getAttribute("renFurAppVO");
//    FurCatService furCatSvc=new FurCatService();
//    FurIteService furIteSvc=new FurIteService();
//    FurIteVO furIteVO=furIteSvc.getOneFurIte(renFurAppVO.fnt_it_no);
//    String fnt_ctgr_name=furCatSvc.getOneFurCat(furIteVO.fnt_ctgr_no).fnt_ctgr_name;
%>

<!-- �q�M����}�l -->
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>���a��ӽг�ק� -listOne_renFurApp.jsp</title>

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
  #getAllButton{
       border: 0;
            background-color: #628AC0;
            color: #fff;
            border-radius: 10px;
            height: 30px;
            width: 80px;
            font-size: 16px;
            text-align: center;
   }
   #back{
  margin:auto;
   }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>���a��ӽг��� -update_renFurApp_input.jsp</h3></td><td><br>
		 <h4><a href="<%=request.getContextPath()%>/back-end/renFurApp/listAllRenFurApp.jsp">��^���a��ӽг�޲z</a></h4>
	</td></tr>
</table>

<h3>��ƭק�:</h3>

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
	    <td><fmt:formatDate value="${renFurAppVO.rfa_order_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
	<tr>
	<td colspan="4">
	<!-- �b���ޤJ���Ӥ��� -->
			<%if (request.getAttribute("listDets_ByRenFurApp")!=null){%>
			       <jsp:include page="listDets_ByRenFurApp.jsp" />
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
		<th>�t�d���u:</th>
		<jsp:useBean id="empSvc" scope="page" class="com.employee.model.EmployeeService" />
		<td>
			<c:if test="${not empty renFurAppVO.emp_no}">
							<c:forEach var="empVO" items="${empSvc.all}">
								<c:if test="${renFurAppVO.emp_no==empVO.emp_no}">${empVO.emp_name}</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${renFurAppVO.emp_no==0}">�|������</c:if></td>
	</tr>	
	<tr>
		<th>�����X�p:</th>
		<td>${renFurAppVO.rfa_total} ��</td>
		<th>���ɪ��A:</th>
		<td><c:choose>
				<c:when test="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0}"> �w�h�� </c:when>
				<c:when test="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==1}"> ������ </c:when>
				<c:otherwise>���Τ�</c:otherwise>
			</c:choose></td>
	</tr>
	

	
</table>
<div id="back">
 <a href="<%=request.getContextPath()%>/back-end/renFurApp/listAllRenFurApp.jsp">
    <input type="button" value="��^�W��" id="getAllButton"></a>
    </div>
<br>



</FORM>
</body>
</html>
<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="java.util.*"%>
<!-- 員工看到的頁面 -->

<%
   RenFurAppVO renFurAppVO = (RenFurAppVO) request.getAttribute("renFurAppVO");
//    FurCatService furCatSvc=new FurCatService();
//    FurIteService furIteSvc=new FurIteService();
//    FurIteVO furIteVO=furIteSvc.getOneFurIte(renFurAppVO.fnt_it_no);
//    String fnt_ctgr_name=furCatSvc.getOneFurCat(furIteVO.fnt_ctgr_no).fnt_ctgr_name;
%>

<!-- 從套日期開始 -->
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>租家具申請單修改 -listOne_renFurApp.jsp</title>

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
		 <h3>租家具申請單資料 -update_renFurApp_input.jsp</h3></td><td><br>
		 <h4><a href="<%=request.getContextPath()%>/back-end/renFurApp/listAllRenFurApp.jsp">返回租家具申請單管理</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do" name="form1">
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
<%-- 		${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_city} --%>
<%-- 				${houseSvc.getOneHouse(renConSvc.getOneRenCon(renFurAppSvc.getRentCon(renFurAppVO.rfa_no)).hos_no).hos_dist}		 --%>
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
	    <td><fmt:formatDate value="${renFurAppVO.rfa_apct_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
	<th>預約時間:</th>
	    <td><fmt:formatDate value="${renFurAppVO.rfa_order_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
	<tr>
	<td colspan="4">
	<!-- 在此引入明細內頁 -->
			<%if (request.getAttribute("listDets_ByRenFurApp")!=null){%>
			       <jsp:include page="listDets_ByRenFurApp.jsp" />
			<%} %>
	</td>
	</tr>
	<tr>
	    <th>申請進度:</th>
		<td><c:choose>
							<c:when test="${renFurAppVO.rfa_status==0}"> 未處理 </c:when>
							<c:when test="${renFurAppVO.rfa_status==1}"> 處理中</c:when>
							<c:otherwise> 已完成</c:otherwise>
						</c:choose>
				</td>
		<th>負責員工:</th>
		<jsp:useBean id="empSvc" scope="page" class="com.employee.model.EmployeeService" />
		<td>
			<c:if test="${not empty renFurAppVO.emp_no}">
							<c:forEach var="empVO" items="${empSvc.all}">
								<c:if test="${renFurAppVO.emp_no==empVO.emp_no}">${empVO.emp_name}</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${renFurAppVO.emp_no==0}">尚未指派</c:if></td>
	</tr>	
	<tr>
		<th>租金合計:</th>
		<td>${renFurAppVO.rfa_total} 元</td>
		<th>租借狀態:</th>
		<td><c:choose>
				<c:when test="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0}"> 已退租 </c:when>
				<c:when test="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==1}"> 未租用 </c:when>
				<c:otherwise>租用中</c:otherwise>
			</c:choose></td>
	</tr>
	

	
</table>
<div id="back">
 <a href="<%=request.getContextPath()%>/back-end/renFurApp/listAllRenFurApp.jsp">
    <input type="button" value="返回上頁" id="getAllButton"></a>
    </div>
<br>



</FORM>
</body>
</html>
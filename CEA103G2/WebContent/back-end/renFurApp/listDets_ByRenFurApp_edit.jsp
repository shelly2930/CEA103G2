<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="com.renFurDet.model.*"%>
<%@ page import="java.util.*"%>

<!-- 在此收到renFurAPP controller的轉交內容  並引用印出-->
<jsp:useBean id="listDets_ByRenFurApp" scope="request" type="java.util.List<RenFurDetVO>" /> <!-- 於EL此行可省略 -->


<html>
<head><title>申請單明細</title>

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

<h4 style="color:black;text-align:left;">申請單明細: </h4>


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>家具<br>編號</th>
		<th>家具名稱</th>
		<th>家具租金</th>
		<th>出租日期</th>
		<th>終止日期</th>
		<th>解租日期</th>
		<th>編輯</th>
		<th>刪除</th>
	</tr>
	
	<c:forEach var="renFurDetVO" items="${listDets_ByRenFurApp}">
 <jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" />
  <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />
  <jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" />
<%-- 						<c:forEach var="renFurDetVO" items="${renFurDetSvc.all}" > --%>
	<tr>
			<c:if test="${renFurAppVO.rfa_no==renFurDetVO.rfa_no}">
					
<%-- 	測試用 展開不顯示申請單編號		<td>${renFurDetVO.rfa_no}</td> --%>
									
			<td>${renFurDetVO.fnt_id}</td>
			<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_name}</td>
			 <td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price} 元</td>
			<td><fmt:formatDate value="${renFurDetVO.rent_date}"	pattern="yyyy-MM-dd" /></td>
			<td><fmt:formatDate value="${renFurDetVO.rent_end_date}"	pattern="yyyy-MM-dd" /></td>
			<td><fmt:formatDate value="${renFurDetVO.rent_tmt_date}"	pattern="yyyy-MM-dd " /></td>
			<td> 
			         <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do" style="margin-bottom: 0px;">
		             <input type="submit" value="編輯">
			         <input type="hidden" name="rfa_no"  value="${renFurDetVO.rfa_no}">
			         <input type="hidden" name="fnt_id"  value="${renFurDetVO.fnt_id}">
			         <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
 			         <input type="hidden" name="action2" value="getOne_For_Update"></FORM> 
		   </td> 
		   <td> 
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do" style="margin-bottom: 0px;">
		          <input type="submit" value="刪除">
			     <input type="hidden" name="rfa_no"  value="${renFurDetVO.rfa_no}">
			      <input type="hidden" name="fnt_id"  value="${renFurDetVO.fnt_id}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
 			     <input type="hidden" name="action2" value="delete"></FORM> 
			</td>
		</c:if>
	</c:forEach>
	</tr>
</table>

</body>
</html>
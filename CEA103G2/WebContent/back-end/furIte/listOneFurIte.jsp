<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furCat.model.*"%>
待處理圖片顯示及引入家具類別名稱 無法取到值問題

<%
  FurIteVO furIteVO = (FurIteVO) request.getAttribute("furIteVO"); //EmpServlet.java(Concroller), 存入req的furIteVO物件
%>

<html>
<head><!--  -->
<title>家具品項資料 - listOneFurIte.jsp</title>

<style>
  table#table-1 {
  width: 610px;
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
   table th {
	width: 130px;
  }
  table td {
  width: 450px;}
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
 
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align:left;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>家具品項資料 - ListOneFurIte.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furIte/listAllFurIte.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">返回品項管理</a></h4>
	</td></tr>
</table>

<table>
	<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
	<tr>
		<th>家具品項編號:</th>
		<td><%=furIteVO.getFnt_it_no()%></td>
	</tr>
	<tr>
		<th>家具類別名稱:</th>
		<td>
			<c:forEach var="furCatVO" items="${furCatSvc.all}">
			${(furCatVO.fnt_ctgr_no==furIteVO.fnt_ctgr_no)? furCatVO.fnt_ctgr_name:''} 
			</c:forEach> 
			</td> 
 <!-- 		建立新增家具類別按鈕 --> 
	</tr>
	<tr>
		<th>家具品項名稱:</th>
		<td>${furIteVO.fnt_name}</td>
	</tr>
<!-- 	<tr> -->
<!-- 		<th>家具圖片:</th> -->
<!-- 		<td></td> -->
<!-- 	</tr> -->
	<tr>
		<th>可租數量:</th>
		<td>${furIteVO.fnt_unrent}</td>
	</tr>
	<tr>
		<th>維修數量:</th>
		<td>${furIteVO.fnt_repair}</td>
	</tr>
	<tr>
		<th>總數量:</th>
		<td>${furIteVO.fnt_total}</td>
	</tr>
	<tr>
		<th>出租價格:</th>
		<td>${furIteVO.fnt_price}</td>
	</tr>
	<tr>
		<th>長度:</th>
		<td>${furIteVO.fnt_length}</td>
	</tr>
	<tr>
		<th>寬度:</th>
		<td>${furIteVO.fnt_width}</td>
	</tr>
	<tr>
		<th>高度:</th>
		<td>${furIteVO.fnt_height}</td>
	</tr>
	<tr>
		<th>重量:</th>
		<td>${furIteVO.fnt_weight}</td>
	</tr>
	<tr>
		<th>規格:</th>
		<td>${furIteVO.fnt_standard}</td>
	</tr>
		<tr>
		<th>品項介紹:</th>
 		<td>${furIteVO.fnt_info}</td>
	</tr>
	<tr>
		<th>瀏覽次數:</th>
		<td>${furIteVO.fnt_views}</td>
	</tr>	
	
</table>
 
</body>
</html>
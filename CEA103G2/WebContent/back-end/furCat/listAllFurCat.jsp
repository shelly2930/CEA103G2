<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furCat.model.*"%>

<%
    FurCatService furCatSvc = new FurCatService();
    List<FurCatVO> list = furCatSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有家具類別資料 - listAllFurCat.jsp</title>

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
  #addButton {
	border: 0;
	background-color: #628AC0;
	color: #fff;
	border-radius: 10px;
	height: 30px;
	width: 120px;
	font-size: 20px;
	text-align: center;
}
 #getAllButton{
	border: 0;
	background-color: #628AC0;
	color: #fff;
	border-radius: 10px;
	height: 30px;
	width: 60px;
	font-size: 20px;
	text-align: center;
}
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
  a:link{
  	color:blue;
  	text-decoration:none;
  }
  a:hover{
   	color:purple;
  	text-decoration:underline;
  	cursor:pointer;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>家具類別管理</h3>
		 <img src="images/back1.gif" width="100" height="32" border="0">
	</td></tr>
</table>

<%-- 錯誤表列 --%>

<a href="<%=request.getContextPath()%>/back-end/furCat/listAllFurCat.jsp">
			<input type="button" value="全部" id="getAllButton"></a>
			<a href="<%=request.getContextPath()%>/back-end/furCat/addFurCat.jsp">
			<input type="button" value="新增資料" id="addButton">
		</a>
<br>
<!-- 測試用 -->
<!-- <a href="http://localhost:8081/CEA103G2/back-end/furIte/listAllFurIte.jsp?fnt_ctgr_no=1">希望全部!!!!</a> -->
<!-- fnt_ctgr_no -->
<table>
	<tr>
		<th>家具類別編號</th>
		<th>家具類別名稱</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1_furCat.file" %> 
	<c:forEach var="furCatVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${furCatVO.fnt_ctgr_no}</td>
<!-- 			過controller寫法 -->
<%-- 			<td><a href="<%=request.getContextPath()%>/furCat/furCat.do?fnt_ctgr_no=${furCatVO.fnt_ctgr_no}&action=getOne_furCat">${furCatVO.fnt_ctgr_name}</a></td> --%>
<!-- 			直接從連結取值寫法 -->
			<td><a href="<%=request.getContextPath()%>/back-end/furIte/listAllFurIte.jsp?fnt_ctgr_no=${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</a></td>
	
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCat/furCat.do" style="margin-bottom: 0px;">
			     <input type="submit" value="編輯">
			     <input type="hidden" name="fnt_ctgr_no"  value="${furCatVO.fnt_ctgr_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCat/furCat.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="fnt_ctgr_no"  value="${furCatVO.fnt_ctgr_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2_furCat.file" %>

</body>
</html>
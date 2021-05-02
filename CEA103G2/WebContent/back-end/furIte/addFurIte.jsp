<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*"%>


<%
   FurIteVO furIteVO = (FurIteVO) request.getAttribute("furIteVO");
%>
待建立新增家具類別按鈕並跳轉?! 
待建立新增家具照片連結  多張照片新增刪除更換
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>家具品項資料新增 - addFurCat.jsp</title>

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
		 <h3>家具品項資料新增 - addFurIte.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furIte/listAllFurIte.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">返回品項管理</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furIte/furIte.do" name="form1">
<table>
	<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
	<tr>
		<td>家具類別名稱:</td>
		<td><select size="1" name="fnt_ctgr_no" size="20">
				<option>請選擇</option>
			<c:forEach var="furCatVO" items="${furCatSvc.all}">
				<option value="${furCatVO.fnt_ctgr_no}" ${(furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no)? 'selected':'' } >${furCatVO.fnt_ctgr_name}
			</c:forEach>
		</select></td>
<!-- 		建立新增家具類別按鈕 -->
	</tr>
	<tr>
		<td>家具品項名稱:</td>
		<td><input type="TEXT" name="fnt_name" size="45" 
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_name()%>" /></td>
	</tr>
	<tr>
		<td>可租數量:</td>
		<td><input type="TEXT" name="fnt_unrent" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_unrent()%>" /></td>
	</tr>
	<tr>
		<td>維修數量:</td>
		<td><input type="TEXT" name="fnt_repair" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_repair()%>" /></td>
	</tr>
	<tr>
		<td>總數量:</td>
		<td><input type="TEXT" name="fnt_total" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_total()%>" /></td>
	</tr>
	<tr>
		<td>出租價格:</td>
		<td><input type="TEXT" name="fnt_price" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_price()%>" /></td>
	</tr>
	<tr>
		<td>長度:</td>
		<td><input type="TEXT" name="fnt_length" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_length()%>" /></td>
	</tr>
	<tr>
		<td>寬度:</td>
		<td><input type="TEXT" name="fnt_width" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_width()%>" /></td>
	</tr>
	<tr>
		<td>高度:</td>
		<td><input type="TEXT" name="fnt_height" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_height()%>" /></td>
	</tr>
	<tr>
		<td>重量:</td>
		<td><input type="TEXT" name="fnt_weight" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_weight()%>" /></td>
	</tr>
		<tr>
		<td>規格:</td>
		<td><input type="TEXT" name="fnt_standard" size="45" 
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_standard()%>" /></td>
	</tr>
		<tr>
		<td>品項介紹:</td>
		<td>
		<textarea name="fnt_info" cols="43" rows="5"><%= (furIteVO==null)? "" : furIteVO.getFnt_info()%></textarea>
        </td>
	</tr>
	<tr>
		<td>瀏覽次數:</td>
		<td><input type="TEXT" name="fnt_views" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_views()%>" /></td>
	</tr>	
	
</table>
<br>
<input type="submit" value="下一步"  id="insert">
<input type="hidden" name="action"  value="insert">
</FORM>

</body>
</html>
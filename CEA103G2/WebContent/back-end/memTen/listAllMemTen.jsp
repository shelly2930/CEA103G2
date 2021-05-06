<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.memTen.model.*"%>
<!DOCTYPE html>

<%
    MemTenService memTenSvc = new MemTenService();
    List<MemTenVO> list = memTenSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>

<!-- Required source start -->
	<!-- jquery 這行有需要的人再加 -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<title>所有每月房客帳單資料 - listAllBill.jsp</title>

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
</style>

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
  img.mem_pic {
  	height: 200px;
  	width: auto;
  }
</style>

</head>
<body>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有每月房客帳單資料 - listAllMemTen.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

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
		<th>會員編號</th>
		<th>帳號</th>
		<th>密碼</th>
		<th>照片</th>
		<th>姓名</th>
		<th>性別</th>
		<th>身分證字號</th>
		<th>出生年月日</th>
		<th>連絡電話</th>
		<th>行動電話</th>
		<th>電子信箱</th>
		<th>縣市</th>
		<th>鄉鎮市區</th>
		<th>地址</th>
		<th>帳號啟用狀態</th>
		<th>身分證正面</th>
		<th>身分證背面</th>
		<th>身份審核狀態</th>
		<th>停權原因</th>
		<th>審核未通過原因</th>	
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="memTenVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
<!-- line93、94參formatDate.jsp 自訂時間格式 -->
		<tr>
			<td>${memTenVO.mem_no}</td>
			<td>${memTenVO.mem_username}</td>
			<td>${memTenVO.mem_password}</td>			
			<td><img src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?mem_no=${memTenVO.mem_no}" class="mem_pic"></td>
<%-- 			<td><img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?mem_no=${memTenVO.mem_no}"></td> --%>
			<td>${memTenVO.mem_name}</td>
			<td>
				<c:choose>
					<c:when test="${memTenVO.mem_gender == 0}">男</c:when>
					<c:when test="${memTenVO.mem_gender == 1}">女</c:when>
				</c:choose>
			</td>
			<td>${memTenVO.mem_id}</td>
			<td><fmt:formatDate value="${memTenVO.mem_birthday}" pattern="yyyy-MM-dd"/></td> 
			<td>${memTenVO.mem_phone}</td>
			<td>${memTenVO.mem_mobile}</td>
			<td>${memTenVO.mem_email}</td>
			<td>${memTenVO.mem_city}</td>
			<td>${memTenVO.mem_dist}</td>			
			<td>${memTenVO.mem_addr}</td>
			<td>
				<c:choose>
					<c:when test="${memTenVO.mem_status == 0}">未驗證</c:when>
					<c:when test="${memTenVO.mem_status == 1}">已驗證</c:when>
					<c:when test="${memTenVO.mem_status == 2}">停權</c:when>
				</c:choose>
			</td>
			<td>${memTenVO.mem_idcard_f}</td>			
			<td>${memTenVO.mem_idcard_r}</td>
			<td>
				<c:choose>
					<c:when test="${memTenVO.mem_id_status == 0}">未上傳</c:when>
					<c:when test="${memTenVO.mem_id_status == 1}">未審核</c:when>
					<c:when test="${memTenVO.mem_id_status == 2}">通過</c:when>
					<c:when test="${memTenVO.mem_id_status == 3}">未通過</c:when>
				</c:choose>
			</td>
			<td>${memTenVO.mem_suspend}</td>
			<td>${memTenVO.mem_refuse}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="mem_no"  value="${memTenVO.mem_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="mem_no"  value="${memTenVO.mem_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<script>
// 	$(window).load(function(){
// 		alert()
// // 		$(".addrclean").html("${addrclean}");
// 	})
</script>

<%@ include file="page2.file" %>

</body>
</html>
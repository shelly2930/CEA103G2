<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>會員資料 - listOneMemTen.jsp</title>

<!-- Required source start -->
	<!-- jquery 這行有需要的人再加 -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

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
	width: 600px;
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
<body bgcolor='white'>
${reuestScope.MemTenVO.mem_name}
<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>會員資料 - ListOneMemTen.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/index.jsp"><img src="<%=request.getContextPath()%>/back-end/memTen/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

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
		<th>身分證正面</th>
		<th>身分證背面</th>
		<th>修改</th>		
	</tr>
	<tr>
		<td>${MemTenVO.mem_no}</td>
		<td>${MemTenVO.mem_username}</td>
		<td>${MemTenVO.mem_password}</td>
		<td><img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?action=getmempic&mem_no=${memTenVO.mem_no}"  class="mem_pic"></td>
		<td>${MemTenVO.mem_name}</td>
		<td>
			${MemTenVO.mem_gender == 0 ? '男':'女'}
<%-- 			<c:choose> --%>
<%-- 					<c:when test="${memTenVO.mem_gender == 0}">男</c:when> --%>
<%-- 					<c:when test="${memTenVO.mem_gender == 1}">女</c:when> --%>
<%-- 				</c:choose> --%>
		</td>
		<td>${MemTenVO.mem_id}</td>
		<td>${MemTenVO.mem_birthday}</td>
		<td>${MemTenVO.mem_phone}</td>
		<td>${MemTenVO.mem_mobile}</td>
		<td>${MemTenVO.mem_email}</td>
		<td>${MemTenVO.mem_city}</td>
		<td>${MemTenVO.mem_dist}</td>
		<td>${MemTenVO.mem_addr}</td>
		<td>${MemTenVO.mem_idcard_f}</td>
		<td>${MemTenVO.mem_idcard_r}</td>
		<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" style="margin-bottom: 0px;">
				<input type="submit" value="修改">
			    <input type="hidden" name="mem_no"  value="${MemTenVO.mem_no}">
			    <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
		</td>
	</tr>
	
</table>



<script>
// 	$(window).load(function(){
// 		alert("${addrclean}");
// 	})
</script> 

</body>
</html>
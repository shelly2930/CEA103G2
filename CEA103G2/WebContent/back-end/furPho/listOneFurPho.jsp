<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.houPho.model.*"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%-- 取出 Concroller EmpServlet.java已存入request的EmpVO物件--%>
<%HouPhoVO houPhoVO = (HouPhoVO) request.getAttribute("houPhoVO");%>

<html>
<head>
<title>物件照片資料</title>

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
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>物件照片 - listOneEmp.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/select_HousePhoto.jsp"><img src="<%=request.getContextPath()%>/front-end/houPho/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>照片編號</th>
		<th>物件編號</th>
		<th>物件照片</th>
	
	</tr>
	<tr>
		<td><%=houPhoVO.getHos_pic_no()%></td>
		<td><%=houPhoVO.getHos_no()%></td>
		<td><img src="<%=request.getContextPath()%>/HouPhoImgServlet?picno=${houPhoVO.hos_pic_no}"  height="100" ></td>
	</tr>
</table>

</body>
</html>
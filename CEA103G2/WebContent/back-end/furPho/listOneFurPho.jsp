<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.houPho.model.*"%>

<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%-- ���X Concroller EmpServlet.java�w�s�Jrequest��EmpVO����--%>
<%HouPhoVO houPhoVO = (HouPhoVO) request.getAttribute("houPhoVO");%>

<html>
<head>
<title>����Ӥ����</title>

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

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>����Ӥ� - listOneEmp.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/select_HousePhoto.jsp"><img src="<%=request.getContextPath()%>/front-end/houPho/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>�Ӥ��s��</th>
		<th>����s��</th>
		<th>����Ӥ�</th>
	
	</tr>
	<tr>
		<td><%=houPhoVO.getHos_pic_no()%></td>
		<td><%=houPhoVO.getHos_no()%></td>
		<td><img src="<%=request.getContextPath()%>/HouPhoImgServlet?picno=${houPhoVO.hos_pic_no}"  height="100" ></td>
	</tr>
</table>

</body>
</html>
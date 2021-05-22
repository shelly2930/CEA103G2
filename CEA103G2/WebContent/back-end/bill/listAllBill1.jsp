<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.bill.model.*"%>
<!DOCTYPE html>

<%
    BillService billSvc = new BillService();
    List<BillVO> list = billSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>�Ҧ��C��Ыȱb���� - listAllBill.jsp</title>

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
<body>

<h4>�����m�߱ĥ� EL ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>�Ҧ��C��Ыȱb���� - listAllBill.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/bill/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>�Ыȱb��s��</th>
		<th>�|���s��</th>
		<th>����s��</th>
		<th>�b����</th>
		<th>ú�O����</th>
		<th>����ιq�q</th>
		<th>����Τ��q</th>
		<th>�Ы�ú�O���A</th>
		<th>�ЪF���ڪ��A</th>
		<th>�ק�</th>
		<th>�R��</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="billVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
<!-- line93�B94��formatDate.jsp �ۭq�ɶ��榡 -->
		<tr>
			<td>${billVO.bill_no}</td>
			<td>${billVO.mem_no}</td>
			<td>${billVO.hos_no}</td>
			<td><fmt:formatDate value="${billVO.bill_date}" pattern="yyyy-MM"/></td>
			<td><fmt:formatDate value="${billVO.bill_due}" pattern="yyyy-MM-dd"/></td>
			<td>${billVO.bill_power}</td>
			<td>${billVO.bill_water}</td> 
			<td>
				<c:choose>
					<c:when test="${billVO.bill_p_status == 0}">��ú�O</c:when>
					<c:when test="${billVO.bill_p_status == 1}">�wú�O</c:when>
				</c:choose>
			</td>
			<td>
				<c:choose>
					<c:when test="${billVO.bill_r_status == 0}">��ú�O</c:when>
					<c:when test="${billVO.bill_r_status == 1}">�wú�O</c:when>
				</c:choose>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/bill/bill.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="bill_no"  value="${billVO.bill_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/bill/bill.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="bill_no"  value="${billVO.bill_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>
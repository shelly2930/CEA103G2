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
	<!-- jquery �o�榳�ݭn���H�A�[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

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
  img.mem_pic {
  	height: 200px;
  	width: auto;
  }
</style>

</head>
<body>

<h4>�����m�߱ĥ� EL ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>�Ҧ��C��Ыȱb���� - listAllMemTen.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
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
		<th>�|���s��</th>
		<th>�b��</th>
		<th>�K�X</th>
		<th>�Ӥ�</th>
		<th>�m�W</th>
		<th>�ʧO</th>
		<th>�����Ҧr��</th>
		<th>�X�ͦ~���</th>
		<th>�s���q��</th>
		<th>��ʹq��</th>
		<th>�q�l�H�c</th>
		<th>����</th>
		<th>�m����</th>
		<th>�a�}</th>
		<th>�b���ҥΪ��A</th>
		<th>�����ҥ���</th>
		<th>�����ҭI��</th>
		<th>�����f�֪��A</th>
		<th>���v��]</th>
		<th>�f�֥��q�L��]</th>	
		<th>�ק�</th>
		<th>�R��</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="memTenVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
<!-- line93�B94��formatDate.jsp �ۭq�ɶ��榡 -->
		<tr>
			<td>${memTenVO.mem_no}</td>
			<td>${memTenVO.mem_username}</td>
			<td>${memTenVO.mem_password}</td>			
			<td><img src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?mem_no=${memTenVO.mem_no}" class="mem_pic"></td>
<%-- 			<td><img src="${pageContext.request.contextPath}/memTen/memPicReadServlet.do?mem_no=${memTenVO.mem_no}"></td> --%>
			<td>${memTenVO.mem_name}</td>
			<td>
				<c:choose>
					<c:when test="${memTenVO.mem_gender == 0}">�k</c:when>
					<c:when test="${memTenVO.mem_gender == 1}">�k</c:when>
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
					<c:when test="${memTenVO.mem_status == 0}">������</c:when>
					<c:when test="${memTenVO.mem_status == 1}">�w����</c:when>
					<c:when test="${memTenVO.mem_status == 2}">���v</c:when>
				</c:choose>
			</td>
			<td>${memTenVO.mem_idcard_f}</td>			
			<td>${memTenVO.mem_idcard_r}</td>
			<td>
				<c:choose>
					<c:when test="${memTenVO.mem_id_status == 0}">���W��</c:when>
					<c:when test="${memTenVO.mem_id_status == 1}">���f��</c:when>
					<c:when test="${memTenVO.mem_id_status == 2}">�q�L</c:when>
					<c:when test="${memTenVO.mem_id_status == 3}">���q�L</c:when>
				</c:choose>
			</td>
			<td>${memTenVO.mem_suspend}</td>
			<td>${memTenVO.mem_refuse}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="mem_no"  value="${memTenVO.mem_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
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
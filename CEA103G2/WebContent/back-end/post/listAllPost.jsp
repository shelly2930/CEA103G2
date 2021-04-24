<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
    PostService postSvc = new PostService();
    List<PostVO> list = postSvc.getAll();
    pageContext.setAttribute("list",list);
   
%>


<html>
<head>
<title>�Ҧ����u��� - listAllPost.jsp</title>


<script src="sorttable.js"></script>
<style type="text/css">
/* Sortable tables */
table.sortable thead {
    background-color:#eee;
    color:#666666;
    font-weight: bold;
    cursor: default;
}





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
    width: 50px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>�Ҧ������ - listAllPost.jsp</h3>
		 <h4><a href="<%=request.getContextPath() %>/back-end/post/select_page.jsp"><img src="<%=request.getContextPath() %>/back-end/post/images/house.jpg" width="100" height="32" border="0">�^����</a></h4>
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

<table class="sortable">
	<tr>
		<th>���i�s��</th>
		<th >���i���</th>
		<th class="sorttable_nosort">���i���D</th>
		<th class="sorttable_nosort">���i����</th>
		<th class="sorttable_nosort">���i���A</th>
		<th class="sorttable_nosort">�ק�</th>
		<th class="sorttable_nosort">�R��</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="postVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${postVO.post_no}</td>
			<td><fmt:formatDate value="${postVO.post_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${postVO.post_title}</td>

			<td>${postVO.post_content}</td>
			<td>			
			<c:choose>
				<c:when test="${postVO.post_status==0}">�U�[</c:when>
				<c:when test="${postVO.post_status==1}">�W�[</c:when>
				<c:when test="${postVO.post_status==2}">���~</c:when>
			</c:choose>
			</td> 
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="post_no"  value="${postVO.post_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="post_no"  value="${postVO.post_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>
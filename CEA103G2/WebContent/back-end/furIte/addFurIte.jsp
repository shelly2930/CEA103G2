<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*"%>


<%
   FurIteVO furIteVO = (FurIteVO) request.getAttribute("furIteVO");
%>
�ݫإ߷s�W�a�����O���s�ø���?! 
�ݫإ߷s�W�a��Ӥ��s��  �h�i�Ӥ��s�W�R����
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�a��~����Ʒs�W - addFurCat.jsp</title>

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
		 <h3>�a��~����Ʒs�W - addFurIte.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furIte/listAllFurIte.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">��^�~���޲z</a></h4>
	</td></tr>
</table>

<h3>��Ʒs�W:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
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
		<td>�a�����O�W��:</td>
		<td><select size="1" name="fnt_ctgr_no" size="20">
				<option>�п��</option>
			<c:forEach var="furCatVO" items="${furCatSvc.all}">
				<option value="${furCatVO.fnt_ctgr_no}" ${(furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no)? 'selected':'' } >${furCatVO.fnt_ctgr_name}
			</c:forEach>
		</select></td>
<!-- 		�إ߷s�W�a�����O���s -->
	</tr>
	<tr>
		<td>�a��~���W��:</td>
		<td><input type="TEXT" name="fnt_name" size="45" 
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_name()%>" /></td>
	</tr>
	<tr>
		<td>�i���ƶq:</td>
		<td><input type="TEXT" name="fnt_unrent" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_unrent()%>" /></td>
	</tr>
	<tr>
		<td>���׼ƶq:</td>
		<td><input type="TEXT" name="fnt_repair" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_repair()%>" /></td>
	</tr>
	<tr>
		<td>�`�ƶq:</td>
		<td><input type="TEXT" name="fnt_total" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_total()%>" /></td>
	</tr>
	<tr>
		<td>�X������:</td>
		<td><input type="TEXT" name="fnt_price" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_price()%>" /></td>
	</tr>
	<tr>
		<td>����:</td>
		<td><input type="TEXT" name="fnt_length" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_length()%>" /></td>
	</tr>
	<tr>
		<td>�e��:</td>
		<td><input type="TEXT" name="fnt_width" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_width()%>" /></td>
	</tr>
	<tr>
		<td>����:</td>
		<td><input type="TEXT" name="fnt_height" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_height()%>" /></td>
	</tr>
	<tr>
		<td>���q:</td>
		<td><input type="TEXT" name="fnt_weight" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_weight()%>" /></td>
	</tr>
		<tr>
		<td>�W��:</td>
		<td><input type="TEXT" name="fnt_standard" size="45" 
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_standard()%>" /></td>
	</tr>
		<tr>
		<td>�~������:</td>
		<td>
		<textarea name="fnt_info" cols="43" rows="5"><%= (furIteVO==null)? "" : furIteVO.getFnt_info()%></textarea>
        </td>
	</tr>
	<tr>
		<td>�s������:</td>
		<td><input type="TEXT" name="fnt_views" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_views()%>" /></td>
	</tr>	
	
</table>
<br>
<input type="submit" value="�U�@�B"  id="insert">
<input type="hidden" name="action"  value="insert">
</FORM>

</body>
</html>
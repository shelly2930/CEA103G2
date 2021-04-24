<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>CEA103G2 MemTen: front-end Home</title>
<!-- �٨S�令�e�x���� -->
<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>CEA103G2 MemTen: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for CEA103G2 MemTen: Home</p>

<h3>��Ƭd��:</h3>
	
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/memTen/listAllMemTen.jsp'>List</a> all MemTens.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="/CEA103G2/memTen/memTen.do" >
        <b>��J�|���s�� (�p1):</b>
        <input type="text" name="mem_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="memTenSvc" scope="page" class="com.memTen.model.MemTenService" />

  <li>
     <FORM METHOD="post" ACTION="/CEA103G2/memTen/memTen.do" >
       <b>��ܷ|���s��:</b>
       <select size="1" name="mem_no">
         <c:forEach var="memTenVO" items="${memTenSvc.all}" > 
          <option value="${memTenVO.mem_no}">${memTenVO.mem_no} 
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
  
  
<!--   <li> -->
<!--      <FORM METHOD="post" ACTION="memTen.do" > -->
<!--        <b>��ܭ��u�m�W:</b> -->
<!--        <select size="1" name="memTen_no"> -->
<%--          <c:forEach var="memTenVO" items="${memTenSvc.all}" >  --%>
<%--           <option value="${memTenVO.memTen_no}">${memTenVO.ename} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="�e�X"> -->
<!--      </FORM> -->
<!--   </li> -->
</ul>


<h3><a href='addMemTen.jsp'>���U�|��</a></h3>

</body>
</html>
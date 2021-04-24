<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>CEA103G2 Bill: Home</title>

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
   <tr><td><h3>CEA103G2 Bill: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for CEA103G2 Bill: Home</p>

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
  <li><a href='listAllBill.jsp'>List</a> all Bills.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="/CEA103G2/bill/bill.do" >
        <b>��J�b��s�� (�p1):</b>
        <input type="text" name="bill_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="billSvc" scope="page" class="com.bill.model.BillService" />

  <li>
     <FORM METHOD="post" ACTION="/CEA103G2/bill/bill.do" >
       <b>��ܱb��s��:</b>
       <select size="1" name="bill_no">
         <c:forEach var="billVO" items="${billSvc.all}" > 
          <option value="${billVO.bill_no}">${billVO.bill_no} 
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
  
  
<!--   <li> -->
<!--      <FORM METHOD="post" ACTION="bill.do" > -->
<!--        <b>��ܭ��u�m�W:</b> -->
<!--        <select size="1" name="bill_no"> -->
<%--          <c:forEach var="billVO" items="${billSvc.all}" >  --%>
<%--           <option value="${billVO.bill_no}">${billVO.ename} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="�e�X"> -->
<!--      </FORM> -->
<!--   </li> -->
</ul>


<h3>�b��޲z</h3>

<ul>
  <li><a href='addBill.jsp'>Add</a> a new Bill.</li>
</ul>

</body>
</html>
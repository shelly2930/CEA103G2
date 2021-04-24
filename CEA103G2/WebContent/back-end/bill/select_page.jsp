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

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
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
        <b>輸入帳單編號 (如1):</b>
        <input type="text" name="bill_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="billSvc" scope="page" class="com.bill.model.BillService" />

  <li>
     <FORM METHOD="post" ACTION="/CEA103G2/bill/bill.do" >
       <b>選擇帳單編號:</b>
       <select size="1" name="bill_no">
         <c:forEach var="billVO" items="${billSvc.all}" > 
          <option value="${billVO.bill_no}">${billVO.bill_no} 
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  
<!--   <li> -->
<!--      <FORM METHOD="post" ACTION="bill.do" > -->
<!--        <b>選擇員工姓名:</b> -->
<!--        <select size="1" name="bill_no"> -->
<%--          <c:forEach var="billVO" items="${billSvc.all}" >  --%>
<%--           <option value="${billVO.bill_no}">${billVO.ename} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="送出"> -->
<!--      </FORM> -->
<!--   </li> -->
</ul>


<h3>帳單管理</h3>

<ul>
  <li><a href='addBill.jsp'>Add</a> a new Bill.</li>
</ul>

</body>
</html>
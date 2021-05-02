<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>HowTrue 家具類別：首頁</title>

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
   <tr><td><h3>HowTrue 家具類別：首頁</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for HowTrue FurCat: Home</p>

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
  <li><a href='listAllFurCat.jsp'>List</a> all FurCats.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCat/furCat.do" >
        <b>輸入家具類別編號 (如1、2、3):</b>
        <input type="text" name="fnt_ctgr_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCat/furCat.do" >
       <b>選擇家具類別編號:</b>
       <select size="1" name="fnt_ctgr_no">
         <c:forEach var="furCatVO" items="${furCatSvc.all}" > 
          <option value="${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCat/furCat.do" >
       <b>選擇家具類別名稱:</b>
       <select size="1" name="fnt_ctgr_no">
         <c:forEach var="furCatVO" items="${furCatSvc.all}" > 
          <option value="${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>家具類別管理</h3>

<ul>
  <li><a href='addFurCat.jsp'>Add</a> a new FurCat.</li>
</ul>

</body>
</html>
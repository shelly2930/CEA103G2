<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Post:front Home</title>

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
   <tr><td><h3>前台公告</h3></td></tr>
</table>

<h3>公告查詢:</h3>
	
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
  <li><a href='<%=request.getContextPath()%>/post/post.do?action=listAllFront&status=0'>List</a> all Posts.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/post/post.do" >
        <b>輸入公告編號 :</b>
        <input type="text" name="post_no">
        <input type="hidden" name="action" value="GoToOneContent">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="postSvc" scope="page" class="com.post.model.PostService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/post/post.do" >
       <b>選擇公告標題:</b>
       <select size="1" name="post_no">
         <c:forEach var="postVO" items="${postSvc.allAsc}" > 
          <option value="${postVO.post_no}">${postVO.post_title}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="GoToOneContent">
       <input type="submit" value="送出">
    </FORM>
  </li>
 
</ul>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Post:backEnd Home</title>

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
   <tr><td><h3>IBM Post: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Post:backEnd Home</p>

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
  <li><a href='<%=request.getContextPath() %>/back-end/post/listAllPost.jsp'>List</a> all Posts.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/post/post.do" >
        <b>��J���i�s�� :</b>
        <input type="text" name="post_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="postSvc" scope="page" class="com.post.model.PostService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/post/post.do" >
       <b>��ܤ��i���D:</b>
       <select size="1" name="post_no">
         <c:forEach var="postVO" items="${postSvc.all}" > 
          <option value="${postVO.post_no}">${postVO.post_title}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
  

</ul>


<h3>���i�޲z</h3>   

<ul>
  <li><a href='<%=request.getContextPath() %>/back-end/post/addPost.jsp'>Add</a> a new Post.</li>
  <li><a href='addPost.jsp'>Add</a> a new Post.</li>
</ul>

</body>
</html>
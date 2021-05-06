<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>

<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
	<li><a href='' id="post">List</a>
		all Posts. <br>
	<br></li>
<script>
$("#post").click(function(){
	$.ajax({
		url:"<%=request.getContextPath()%>/post/post.do",
		type:"POST",
		data:{
			action:"listAll",
			status:"0"
		},
		//我拿到東西了
		success:function(list){
	req.getAttribute("list");
	console.log("FQA");
	${list}
			
			
		}
	});
});

</script>
</body>
</html>
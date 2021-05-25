<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>


<title>租房申請成功</title>

<style>


div.rentalstep {
	margin-top:200px;
	margin-bottom:250px;
}

.row {
	justify-content: center;
}

table {
	border:2px solid #ccb78f;
	font-size:20px;
	text-align:center;
}

table td {
	height:100px;
	width:700px;
}

a.member {
	font-size:20px;
	text-decoration: underline ;
	color: blue;
}

</style>

</head>
<body>

<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>

<div class="container">
	<div class="row rentalstep">
        <table>
        	<tr>
        		<td>
        			您已成功送出租房申請，請至<a href="<%=request.getContextPath()%>/front-end/renCon/renCon_view.jsp" class="member">會員專區</a>查看，謝謝。
        		</td>
        	</tr>
        </table>
    </div>
</div>




<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</body> 	
</html>
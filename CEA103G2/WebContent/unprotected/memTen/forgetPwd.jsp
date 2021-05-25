<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>

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
	height:60px;
	width:700px;
}

a.member {
	font-size:20px;
	text-decoration: underline ;
	color: blue;
}

td.title {
	font-size:20px;
}

td.result {
	font-size:30px;
}

.btn-primary {
    color: #fff;
    background-color: #ccb78f !important;
    border-color: #ccb78f !important;
}

.btn-primary:hover {
    color: #ccb78f !important;
    background-color: #fff !important;
    border-color: #ccb78f !important;
}

</style>


</head>
<body>

<%@include file="/front-end/header.file"%>

<div class="container">
	<div class="row rentalstep">
        <form method="post" action="<%=request.getContextPath()%>/memTen/memTen.do">
        <table>
        	<tr>
        		<td class="title">�ѰO�K�X</td>
			</tr>
			<tr>
				<td class="result">	
					<input type="email" id="mem_email" placeholder="�п�J�q�l�H�c" required autofocus autocomplete="off" name="mem_email">
				<input type="hidden" name="action" value="forgetPwd">
				</td>
			</tr>
			<tr>
				<td>
					<button id="success" class="btn btn-lg btn-primary" type="submit">�e�X</button>	
        		</td>
        	</tr>
        </table>
        </form>
    </div>
</div>



<%@include file="/front-end/footer.file"%>

</body>
</html>
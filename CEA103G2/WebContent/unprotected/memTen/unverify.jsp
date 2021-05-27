<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>尚未驗證</title>

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

<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>

<div class="container">
	<div class="row rentalstep">
        <table>
        	<tr>
        		<td class="title"></td>
			</tr>
			<tr>
				<td class="result">	
					<form action="<%=request.getContextPath()%>/memTen/memTen.do" class="" name="">
						<h4>信箱尚未驗證，請盡速至您的信箱點選驗證連結。</h2>	
						<input type="hidden" name="action" value="sendAuthMail">
						<input type="hidden" name="mem_username" value="${param.mem_username}"> 
						<input type="submit" value="重寄驗證信" id="success" class="btn btn-sm btn-primary">
					</form>
				</td>
			</tr>
			<tr>
        		<td class="title"></td>
			</tr>
        </table>
    </div>
</div>




<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>
	
</body>
</html>
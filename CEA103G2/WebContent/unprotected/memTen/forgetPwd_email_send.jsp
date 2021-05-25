<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>已發送信件</title>

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

td.member {
	font-size:20px;
}

</style>

</head>
<body>

<%@include file="/front-end/header.file"%>

	<div class="container">
	<div class="row rentalstep">
        <table>
        	<tr>
        		<td class="member">
        			臨時密碼已發送至您的信箱，請用此密碼登入後，至會員專區重設您的密碼，謝謝!
        		</td>
        	</tr>
        </table>
    </div>
</div>

<%@include file="/front-end/footer.file"%>
</body>
</html>
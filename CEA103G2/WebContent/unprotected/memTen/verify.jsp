<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>�|���b������</title>

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�b�ۤv�������[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

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
        		<td class="title">�b������</td>
			</tr>
			<tr>
				<td class="result">	
					<c:if test="${not empty errorMsgs}">
						<c:forEach var="message" items="${errorMsgs}">
							<div align="center" style="color:red">${message}</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty errorMsgs}">���\</c:if>
				</td>
			</tr>
			<tr>
				<td>
						<button id="success" class="btn btn-lg btn-primary" 
							onclick="location='<%=request.getContextPath()%>/unprotected/memTen/login.jsp'">��^�n�J��
						</button>
						<button id="failure" class="btn btn-lg btn-primary" 
							onclick="location='<%=request.getContextPath()%>/unprotected/memTen/unverified.jsp?memEmail=${param.memEmail}'">���H���ҫH
						</button>
        		</td>
        	</tr>
        </table>
    </div>
</div>




<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

<script>
	if(${empty errorMsgs}){
		$('#failure').hide();	
	}else if(${not empty errorMsgs}) {
		$('#success').hide();
	}
</script>	

</body>
</html>
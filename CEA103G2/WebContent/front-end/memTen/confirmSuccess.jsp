<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�A�[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<title>���ХӽЦ��\</title>

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
        			�z�w���\�e�X���ХӽСA�Ц�<a href="" class="member">�|���M��</a>�d�ݡA���¡C
        		</td>
        	</tr>
        </table>
    </div>
</div>




<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</body> 	
</html>
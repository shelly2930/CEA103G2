<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�b�ۤv�������[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->
</head>
<body>

<h2 align="center">�b������</h2>
			<br>
			<c:if test="${not empty errorMsgs}">
				<c:forEach var="message" items="${errorMsgs}">
					<h4 align="center" style="color:red">${message}</h4>
				</c:forEach>
				<script>
// 					if(${not empty errorMsgs}){
// 						console.log("AAAAAA");
// 						$('#successVerify').hide();
// 					} else {
// 						console.log("FFFFFFFFF");
// 						$('#failureVerify').show();	
// 					}
					
// 					console.log($('#successVerify'));
// 					console.log($('#failureVerify'));
								
				</script>	
			</c:if>
			<c:if test="${empty errorMsgs}">
				<h4 align="center">���\</h4>		
			</c:if>
			
			<br>
				<button id="successVerify" class="btn btn-lg btn-primary btn-block btn-signin" 
					onclick="location='<%=request.getContextPath()%>/unprotected/login.jsp'">��^�n�J��
				</button>
				<button id="failureVerify" class="btn btn-lg btn-primary btn-block btn-signin" 
					onclick="location='<%=request.getContextPath()%>/unprotected/unverified.jsp?memEmail=${param.memEmail}'">���H���ҫH
				</button>
				


		</div>

	</div>
	
			<script>
					if(${empty errorMsgs}){
						$('#failureVerify').hide();	
					}else if(${not empty errorMsgs}) {
						$('#successVerify').hide();
					}
			</script>	



</body>
</html>
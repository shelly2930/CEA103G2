<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>login_success.jsp</title>
</head>
<body>

	<br>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='orange' align='center' valign='middle' height='20'>
			 <td>   
			       <h3> �n�J���\������ - login_success.jsp           </h3> 
				   <h3> �w��:<font color=red> ${MemTenVO.mem_name} </font>�z�n</h3>
				   <form method="post" action="<%=request.getContextPath()%>/memTen/memTen.do">
				   <input type="submit" value="�n�X">
		           <input type="hidden" name="action" value="logout">
		           </form>
		           <input type="button" value="�d�ݷ|�����" onclick="location.href='<%=request.getContextPath()%>/front-end/memTen/listOneMemTen.jsp'">
			 </td>
		</tr>
	</table>
	<b> <br>
	<br>                �H�U�d��....
	</b>
</body>
</html>

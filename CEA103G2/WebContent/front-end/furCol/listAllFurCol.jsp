<%@page import="com.memTen.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furCol.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furPho.model.*"%>

1.�ݳB�z�|���I�怜�îa��Ϥ��ήa��W�ٮ� �i�s��a�㪺���Э���
2.�B�z���ڭn���ɮ� �i�H�e���ʪ������� (�L�w�s�� �ڭn���� �L�k�I��)
3.session���|����ƫ� ��|���s�����R��
4.�ݳB�z�L�w�s�� �[�J���ɶs�L�k�I��
<% 
// List<FurColVO> list=null;
// MemTenVO memTenVO=new MemTenVO();
// memTenVO=(MemTenVO)request.getSession();
// FurColService furCoISvc = new FurCoIService();
// list= furColSvc.getOneMemCol(memTenVO.getMem_no());
// pageContext.setAttribute("list",list);
%>
<% 	  
		List<FurColVO> list =null;
// 		if(request.getParameter("fnt_ctgr_no")==null){
			FurColService furCoISvc = new FurColService();
			    list= furCoISvc.getAll();
			    pageContext.setAttribute("list",list);
// 		}else {
// 			FurCoIService furCoISvc = new FurCoIService();
// 			Integer fnt_ctgr_no = new Integer(request.getParameter("fnt_ctgr_no"));
// 			 list = furIteSvc.getOneFurCat_Item(fnt_ctgr_no); 
// 			pageContext.setAttribute("list",list);
// 		}
%>

<jsp:useBean id="furPhoSvc" scope="page" class="com.furPho.model.FurPhoService" />
<jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>�ڪ��a�㦬��</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    margin-bottom: 15px;
    text-align: center;
  }
  table#table-1 h3 {
    color: black;
    display: block;
    margin: 5px;
  }
  h4 {
    color: blue;
    display: inline;
  }

  table {
	width: 900px;
	background-color: white;
/* 	margin-top: 5px; */
/* 	margin-bottom: 5px; */
  }
/*   �W�s���B�z */
/*      a:link{ */
/*   	color:blue; */
/*   	text-decoration:none; */
/*   } */
/*   a:hover{ */
/*    	color:purple; */
/*   	text-decoration:underline; */
/*   	cursor:pointer; */
/*   } */
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
    text-align: center;
  }
   #addButton{
            border: 0;
            background-color: #628AC0;
            color: #fff;
            border-radius: 10px;
            height: 30px;
            width: 120px;
            font-size: 20px;
            text-align: center;
        }
   #keywordSearch, #multiSearch,#getAllButton{
       border: 0;
            background-color: #628AC0;
            color: #fff;
            border-radius: 10px;
            height: 30px;
            width: 60px;
            font-size: 20px;
            text-align: center;
   }
#rentNow{
       border: 0;
            background-color: #628AC0;
            color: #fff;
            border-radius: 10px;
            height: 30px;
            width: 70px;
            font-size: 14px;
            text-align: center;
   }
  .fnt_pic{
			
  			   width: 170px;
/*    			 border:1px solid green; */
   }
.fnt_info{
			   text-indent:15px;
  			   width: 250px;
  			   text-align:left;
/*    			 border:1px solid green; */
   }
 .col_note{
			   text-indent:15px;
  			   width: 200px;
  			   text-align:left;
/*    			 border:1px solid green; */
   }
</style>



</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>�ڪ��a�㦬��<br><font color=blue>My FUR COL</font></h3>
	</td></tr>
</table>
 

<br>
<table>
<!-- 	�]�p��п��W�ٮ�  �i�ۦ�s����U�~���M�歶��-->
	<tr>
<!-- 	�|���s�����ե� ���ᤣ�e�{ -->
		<th>�|��<br>�s��</th>
		<th>�a��Ϥ�</th>
		<th>�a��W��</th>
		<th>�Ƶ�</th>
		<th>�w�s</th>
		<th>����</th>
		<th>�ܧ�</th>
	</tr>
<!-- 	//here -->
	<%@ include file="page1_furCol.file"%>		    
<%-- <c:forEach var="furCoIVO" items="${list}" > --%>
<c:forEach var="furCoIVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${furCoIVO.fnt_it_no}</td>
<!-- 			���q�W�s��������O�d �ݤ���i�����I��a��~�����Э����� -->
<%-- 			<td><a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp?fnt_it_no=${furCoIVO.fnt_it_no}">${furIteSvc.getOneFurIte(furCoIVO.fnt_it_no).fnt_name}</a></td>  --%>
			
			<td class="fnt_pic">
				<img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFurPho(furCoIVO.fnt_it_no).fnt_pic_no}"
					height="100">
			</td>
			<td class="fnt_info">${furIteSvc.getOneFurIte(furCoIVO.fnt_it_no).fnt_name}
					<br>
					<p>���îɶ��G<fmt:formatDate value="${furCoIVO.fnt_col_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></p>
			</td>
			<td class="col_note">${furCoIVO.fnt_col_note}</td>
		<td>
		<c:choose>
	<c:when test="${furIteSvc.getOneFurIte(furCoIVO.fnt_it_no).fnt_unrent>0}">��</c:when>	
	<c:when test="${furIteSvc.getOneFurIte(furCoIVO.fnt_it_no).fnt_unrent<=0}">�L</c:when>			
</c:choose>
		</td>
		<td> <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCol/furCol.do" style="margin-bottom: 0px;">
				<a href="<%=request.getContextPath()%>/back-end/renFurDet/listAllRenFurDet.jsp">
   				 <input type="button" value="�[�J����"  id="rentNow"></a>
   				  <input type="hidden" name="mem_no"  value="${furColVO.mem_no}">
			     <input type="hidden" name="fnt_it_no"  value="${furColVO.fnt_it_no}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
 			     <input type="hidden" name="action" value="rentNow"></FORM>
   		</td>
 		<td> 
<!-- 			�s�� -->
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCol/furCol.do" style="margin-bottom: 0px;">
		     <input type="submit" value="�s��">
			     <input type="hidden" name="mem_no"  value="${furColVO.mem_no}">
			     <input type="hidden" name="fnt_it_no"  value="${furColVO.fnt_it_no}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
 			     <input type="hidden" name="action" value="getOne_For_Update"></FORM> 
				<br>
<!-- 		�R�� -->
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCol/furCol.do" style="margin-bottom: 0px;">
		     <input type="submit" value="�R��">
			     <input type="hidden" name="mem_no"  value="${furColVO.mem_no}">
			      <input type="hidden" name="fnt_it_no"  value="${furColVO.fnt_it_no}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
 			     <input type="hidden" name="action" value="delete"></FORM> 
			</td>
 		</tr> 
	</c:forEach>
</table>
<!-- �ݳB�z�������D -->
 <%@ include file="page2_furCol.file" %>
 </div>
</body>
</html>
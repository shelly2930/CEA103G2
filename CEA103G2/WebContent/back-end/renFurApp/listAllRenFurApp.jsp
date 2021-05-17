 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="com.renFurDet.model.*"%>
<%@ page import="com.furLis.model.*"%>
<%@ page import="com.furIte.model.*"%>
�ݳB�z���ɮa����ӥX������X�p(�ثe�ȥθ�Ʈw�g�w���ۥ[�� �D�Ӷ��ʺA�۰ʬۥ[��)
<% 	  
List<RenFurAppVO> list =new ArrayList<RenFurAppVO>();
if(request.getAttribute("QueryResultList")!=null){
	list=(ArrayList<RenFurAppVO>) request.getAttribute("QueryResultList");	
		 pageContext.setAttribute("list",list);				
}else{
RenFurAppService renFurAppSvc = new RenFurAppService();
list= renFurAppSvc.getAll();
pageContext.setAttribute("list",list);}

// �����ɥi��|�Ψ������޿� ���d
// 		List<RenFurAppVO> list =null;
// 		if(request.getParameter("fnt_ctgr_no")==null){
// 				FurIteService furIteSvc = new FurIteService();
// 			    list= furIteSvc.getAll();
// 			    pageContext.setAttribute("list",list);
// 		}else {
// 			FurIteService furIteSvc = new FurIteService(); 
// 			Integer fnt_ctgr_no = new Integer(request.getParameter("fnt_ctgr_no"));
// 			 list = furIteSvc.getOneFurCat_Item(fnt_ctgr_no); 
// 			pageContext.setAttribute("list",list);
// 		}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <title>���a��ӽг���</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.pack.js"></script>
    <script>
        $(function(){
  $("a.plus").click(function(){ 
   var _this= $(this).attr("href");     
   if($(_this).css("display")=="none"){
    $(_this).slideDown();
    $(this).html("-");
   }else{
    $(_this).slideUp();
    $(this).html("+");
   }
  });  
 });
</script>
    <style type="text/css">
        body {
            font-size: 15px;
        }
        a.plus {
            color: #333333;
            text-decoration: none;
            font-size: 15px;
            display: block;
        }
    
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
            margin-left:10px;
        }
   #pendingButton,#processingButton,#solvedButton,#getAllButton,#keywordSearch{
       border: 0;
            background-color: #628AC0;
            color: #fff;
            border-radius: 10px;
            height: 30px;
            width: 60px;
            font-size: 16px;
            text-align: center;
   }
   #pendingButton,#processingButton,#solvedButton{
       border: 0;
            background-color: #628AC0;
            color: #fff;
            border-radius: 10px;
            height: 30px;
            width: 60px;
            font-size: 16px;
            text-align: center;
   }
   #keywordSearchArea, #searchArea{
			float:left;
			margin-right:50px;
			margin-left:10px;
/*    			 border:1px solid green; */
   }
    #addArea{
			margin-right:50px;
			margin-left:10px;
			margin-top:5px;
/*    			 border:1px solid green; */
   }

  a.plus {
            color: #333333;
            text-decoration: none;
            font-size: 15px;
            display: block;
        }
  a:link{
  	color:blue;
  	text-decoration:none;
  }
  a:hover{
   	color:purple;
  	text-decoration:underline;
  	cursor:pointer;
  }
  </style>
</head>

<body>

<table id="table-1">
	<tr><td>
		 <h3>���a��ӽг�޲z<br><font color=blue>listAllRenFurApp</font></h3>
	</td></tr>
</table>
 
<div id="addArea">
<a href="<%=request.getContextPath()%>/back-end/renFurApp/addRenFurApp.jsp">
    <input type="button" value="�s�W���" id="addButton"></a>
</div>
<br>
<div id="searchArea">
    <a href="<%=request.getContextPath()%>/back-end/renFurApp/listAllRenFurApp.jsp">
    <input type="button" value="����" id="getAllButton"></a>
    <a href="<%=request.getContextPath()%>/renFurApp/renFurApp.do?action=pending">
    <input type="button" value="���B�z" id="pendingButton"></a>
    <a href="<%=request.getContextPath()%>/renFurApp/renFurApp.do?action=processing">
    <input type="button" value="�B�z��" id="processingButton"></a>
    <a href="<%=request.getContextPath()%>/renFurApp/renFurApp.do?action=solved">
    <input type="button" value="�w����" id="solvedButton"></a>
</div>
<div id="keywordSearchArea">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do"  name="form1">
        <b>��J����r:</b>
        <input type="text" name="keyword"  style="width:130px; height:25px;" >
       <input type="submit" value="�d��"  id="keywordSearch">
        <input type="hidden" name="action" value="keywordSearch">
        </FORM>
</div>  
<br>
<br>
<br>

    <table>
    <tr>
		<th></th>
		<th>�ӽг�<br>�s��</th>
		<th>�|���m�W</th>
		<th>�ӽЮɶ�</th>
		<th>�w���ɶ�</th>
		<th>�ӽжi��</th>
		<th>�t�d���u</th>
	    <th>�����X�p</th>
		<th>���ɪ��A</th>
		<th colspan="2">�ާ@</th>
	</tr>
	<%@include file="page1_renFurApp.file"%>		    
<jsp:useBean id="empSvc" scope="page" class="com.employee.model.EmployeeService" />
<jsp:useBean id="memTenSvc" scope="page" class="com.memTen.model.MemTenService" />
<c:forEach var="renFurAppVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
        <tr>
            <td width="26" align="center" bgcolor="#eeeeee"><a href="#${renFurAppVO.rfa_no}" class="plus">+</a></td>
<!--             <td width="474">�@�q��01</td> -->
     	<td>${renFurAppVO.rfa_no}</td>
				<td><c:forEach var="memTenVO" items="${memTenSvc.all}">
							<c:if test="${renFurAppVO.mem_no==memTenVO.mem_no}">
		                    ${memTenVO.mem_name}
	                    </c:if>	</c:forEach></td>
				<td><fmt:formatDate value="${renFurAppVO.rfa_apct_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td><fmt:formatDate value="${renFurAppVO.rfa_order_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td><c:choose>
							<c:when test="${renFurAppVO.rfa_status==0}"> ���B�z </c:when>
							<c:when test="${renFurAppVO.rfa_status==1}"> �B�z��</c:when>
							<c:otherwise> �w����</c:otherwise>
						</c:choose>
				</td>
				<td><c:if test="${not empty renFurAppVO.emp_no}">
							<c:forEach var="empVO" items="${empSvc.all}">
								<c:if test="${renFurAppVO.emp_no==empVO.emp_no}">${empVO.emp_name}</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${renFurAppVO.emp_no==0}">�|������</c:if>
				</td>
			
				<td>${renFurAppVO.rfa_total} ��</td>
				
					<!-- 				�A���ޥ�renFurAppSvc2�O���F�����Ϊ��A�P�_��			 -->
 					<jsp:useBean id="renFurAppSvc2" scope="page" class="com.renFurApp.model.RenFurAppService" />
<%-- 				<td><span class="furRenStatus">${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)}<span></td> --%>
				<td><c:choose>
						<c:when test="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0}"> �w�h�� </c:when>
						<c:when test="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==1}"> ������ </c:when>
						<c:otherwise>���Τ�</c:otherwise>
					</c:choose>
				</td>
				<td><a href="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0? pageContext.request.contextPath+="/renFurApp/renFurApp.do?rfa_no="+=renFurAppVO.rfa_no+="&requestURL="+=pageContext.request.requestURL+="&action=getOne_For_Look":pageContext.request.contextPath+="/renFurApp/renFurApp.do?rfa_no="+=renFurAppVO.rfa_no+="&requestURL="+=pageContext.request.requestURL+="&action=getOne_For_Update"}">
				${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0? "�d��":"�s��"}</a></td> 
<!-- �d�ݽs����s����				 -->
<!-- 		 		<td>  -->
<%-- 					  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do" style="margin-bottom: 0px;"> --%>
<!-- <!-- 		 			     �Y�ӽг毲�ɪ��A���w�h�� ����s�Ȭ�"�d��" --> 

<%-- 				     <input type="submit" value="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0? "�d��":"�s��"}"> --%>
<%-- 					     <input type="hidden" name="rfa_no"  value="${renFurAppVO.rfa_no}"> --%>
<%-- 					      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller--> --%>
<%-- 					     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
<!-- <!-- 		 			     �Y�ӽг毲�ɪ��A���w�h�� ��action�Ȭ�"�d�� getOne_For_Look" --> 
<%-- 		 			     <input type="hidden" name="action" value="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0? "getOne_For_Look":"getOne_For_Update"}"></FORM>  --%>
<!-- 				</td>  -->
				<td> 
				  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do" style="margin-bottom: 0px;">
			    	 <input type="submit" value="�R��">
				     <input type="hidden" name="rfa_no"  value="${renFurAppVO.rfa_no}">
				      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
	 			     <input type="hidden" name="action" value="delete"></FORM> 
				</td>
 		</tr> 
<!--  �i�Q�i�}�����Ӥ��e        -->
        <tr>
            <td colspan="11" class="content">
                <div id="${renFurAppVO.rfa_no}" style="display:none;">
                    <table style="border: 0px; border-collapse: collapse; width:90%; margin:15px auto 15px 30px;">
                        <tr>
<!-- 	���ե� �i�}����ܥӽг�s��         	<th>�ӽг�<br>�s��</th> -->
							<th>�a��<br>�s��</th>
							<th>�a��W��</th>
							<th>�a�㯲��</th>
							<th>�X�����</th>
							<th>�פ���</th>
							<th>�ѯ����</th>
                        </tr>
                        <jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" />
                        <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />
                        <jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" />
						<c:forEach var="renFurDetVO" items="${renFurDetSvc.all}" >
							<c:if test="${renFurAppVO.rfa_no==renFurDetVO.rfa_no}">
								<tr>
<%-- 	���ե� �i�}����ܥӽг�s��		<td>${renFurDetVO.rfa_no}</td> --%>
									<td>${renFurDetVO.fnt_id}</td>
									<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_name}</td>
			  						<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price} ��</td>
									<td><fmt:formatDate value="${renFurDetVO.rent_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td><fmt:formatDate value="${renFurDetVO.rent_end_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td><fmt:formatDate value="${renFurDetVO.rent_tmt_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
								
								</tr>
							</c:if>
						</c:forEach>
                    </table>
                </div>
            </td>
        </tr>
        	</c:forEach>
    </table>
     <%@include file="page2_renFurApp.file" %>
</body>

</html>
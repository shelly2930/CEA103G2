<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furPho.model.*"%>

<%
  FurPhoVO furPhoVO = (FurPhoVO) request.getAttribute("furPhoVO");
  Integer fnt_ctgr_no=(Integer) request.getAttribute("fnt_ctgr_no");
%>

<%=fnt_ctgr_no %>
 �ݸѨM��^�п�ܮɡA�|�X�{�Ҧ��~���� ���Ӥ����D
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�a��Ӥ��s�W</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }

  table {
	width: 600px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>
<!-- �B�z�U�Ԧ����s�ʨ��� -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script type="text/javascript">

function getFurCat(e){ 
    $("#furIteSelect option:not(:first)").remove();
    var fnt_ctgr_no=(e.target.value);
    console.log(fnt_ctgr_no);
    if(fnt_ctgr_no !="" && fnt_ctgr_no !="�a�����O"){
        $.ajax({
            url:"http://localhost:8081/CEA103G2/furIte/furIte.do",
            type:"POST",
            data:{
            	"action":"getFurIteSelect",
            	"fnt_ctgr_no":fnt_ctgr_no,
           },
            success: function(data){
            	 console.log(data);
               showFurItes(data);
                }
            });
    }
//     else {
//     	  $.ajax({
//               url:"http://localhost:8081/CEA103G2/furIte/furIte.do",
//               type:"POST",
//               data:{
//               	"action":"getFurIteSelect",
//              },
//               success: function(data){
//               	 console.log(data);
//                  showFurItes(data);
//                   }
//               });
//     }
}

function showFurItes(data){
    var fnt_name=data.split(",");
    var txt="";

//     if(fnt_name===""){
//     	txt+="<option value=\"none\">�����O�|�L�a��~��</option>";
    
//     }else{
	{ for(i in fnt_name)
         	 txt+="<option value="+fnt_name[i]+">"+fnt_name[i]+"</option>";
    }
    $("#furIteSelect").append(txt); 
}

window.addEventListener("load",function (){
 document.getElementById("furCatSelect").onchange=getFurCat;}, false);
</script>

</head>




<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>�a��~���Ӥ��s�W - addFurPho.jsp</h3>
		 </td>
	<td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furPho/listAllFurPho.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">��^�a��Ӥ��޲z</a></h4>
	</td></tr>
</table>

<h3>�a��Ӥ��s�W:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furPho/furPho.do" enctype="multipart/form-data"  name="form1">
<table>
	<jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />
	<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
	<tr>
		<th>�a�����O�W�١G</th>
		<td><select size="1" name="fnt_ctgr_no"  id="furCatSelect">
			<option>�п��</option>
<!-- 			�Ĥ@����ɪ����p -->
				<c:if test="${empty fnt_ctgr_no}">
						<c:forEach  var="furCatVO"  items="${furCatSvc.all}">
							<option value="${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</option>
				    	</c:forEach>
				</c:if>
<!-- 				����ɪ����p -->
				<c:if test="${not empty  fnt_ctgr_no}">
				<c:forEach var="furCatVO" items="${furCatSvc.all}">
				<option value="${furCatVO.fnt_ctgr_no}" ${(fnt_ctgr_no==furCatVO.fnt_ctgr_no)? 'selected':'' } > ${furCatVO.fnt_ctgr_name}</option>
			</c:forEach>      
<%-- 				<c:forEach var="furIteVO" items="${furIteDAO.all}"> --%>
<%--                     <c:if test="${furPhoVO.fnt_it_no==furIteVO.fnt_it_no}"> --%>
<%--                     <c:forEach var="furCatVO" items="${furCatDAO.all}"> --%>
<!--                     <select size="1" name="fnt_ctgr_no"> -->
<%-- 				<option value="${furCatVO.fnt_ctgr_no}" ${(fnt_ctgr_no==furCatVO.fnt_ctgr_no)? 'selected':'' } > ${furCatVO.fnt_ctgr_name} --%>
<%-- 			</c:forEach>       --%>
<%--                 </c:if> --%>
<%--                 </c:forEach> --%>
					</c:if>
		</select></td>
	</tr>

<!-- �Ȯɴ��� �ݧ令ajax onchange���� -->
	
		
	<tr>
		<th>�~���W�١G</th>
		<td><select size="1" name="fnt_it_no" size="20" id="furIteSelect" >
				<option>�п��</option>
				<!-- 			�Ĥ@����ɪ����p -->
<%-- 				<c:if test="${empty fnt_ctgr_no}"> --%>
<%-- 			<c:forEach var="furIteVO" items="${furIteSvc.all}"> --%>
<%-- 				<option value="${furIteVO.fnt_it_no}" ${(furIteVO.fnt_it_no==furPhoVO.fnt_it_no)? 'selected':'' } >${furIteVO.fnt_name} --%>
<%-- 			</c:forEach> --%>
<%-- 			</c:if> --%>
			<!-- 				����ɪ����p -->
				<c:if test="${not empty  fnt_ctgr_no}">
				<c:forEach var="furIteVO" items="${furIteSvc.all}">
				<c:if test="${fnt_ctgr_no==furIteVO.fnt_ctgr_no}"> 
				<option value="${furIteVO.fnt_it_no}" ${(furPhoVO.fnt_it_no==furIteVO.fnt_it_no)? 'selected':''}> ${furIteVO.fnt_name}</option>
				</c:if>
			</c:forEach>
			</c:if>    
		</select></td>
<!-- 		�إ߷s�W�a�����O���s -->
	</tr>
	
	<tr>
		<th>�a��Ӥ��G</th>
		<td>
		<input type="file" id="load" name="fnt_pic" size="45" />
		<div id="picView">
		</div>
		</td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

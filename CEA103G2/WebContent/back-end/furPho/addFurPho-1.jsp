<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furPho.model.*"%>

<%
  FurPhoVO furPhoVO = (FurPhoVO) request.getAttribute("furPhoVO");
  Integer fnt_ctgr_no=(Integer) request.getAttribute("fnt_ctgr_no");
%>

<%=fnt_ctgr_no %>
 待解決選回請選擇時，會出現所有品項及 更改照片問題
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>家具照片新增</title>

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
<!-- 處理下拉式選單連動取值 -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script type="text/javascript">

function getFurCat(e){ 
    $("#furIteSelect option:not(:first)").remove();
    var fnt_ctgr_no=(e.target.value);
    console.log(fnt_ctgr_no);
    if(fnt_ctgr_no !="" && fnt_ctgr_no !="家具類別"){
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
//     	txt+="<option value=\"none\">此類別尚無家具品項</option>";
    
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
		 <h3>家具品項照片新增 - addFurPho.jsp</h3>
		 </td>
	<td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/furPho/listAllFurPho.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">返回家具照片管理</a></h4>
	</td></tr>
</table>

<h3>家具照片新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
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
		<th>家具類別名稱：</th>
		<td><select size="1" name="fnt_ctgr_no"  id="furCatSelect">
			<option>請選擇</option>
<!-- 			第一次填時的狀況 -->
				<c:if test="${empty fnt_ctgr_no}">
						<c:forEach  var="furCatVO"  items="${furCatSvc.all}">
							<option value="${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</option>
				    	</c:forEach>
				</c:if>
<!-- 				填錯時的狀況 -->
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

<!-- 暫時測試 待改成ajax onchange版本 -->
	
		
	<tr>
		<th>品項名稱：</th>
		<td><select size="1" name="fnt_it_no" size="20" id="furIteSelect" >
				<option>請選擇</option>
				<!-- 			第一次填時的狀況 -->
<%-- 				<c:if test="${empty fnt_ctgr_no}"> --%>
<%-- 			<c:forEach var="furIteVO" items="${furIteSvc.all}"> --%>
<%-- 				<option value="${furIteVO.fnt_it_no}" ${(furIteVO.fnt_it_no==furPhoVO.fnt_it_no)? 'selected':'' } >${furIteVO.fnt_name} --%>
<%-- 			</c:forEach> --%>
<%-- 			</c:if> --%>
			<!-- 				填錯時的狀況 -->
				<c:if test="${not empty  fnt_ctgr_no}">
				<c:forEach var="furIteVO" items="${furIteSvc.all}">
				<c:if test="${fnt_ctgr_no==furIteVO.fnt_ctgr_no}"> 
				<option value="${furIteVO.fnt_it_no}" ${(furPhoVO.fnt_it_no==furIteVO.fnt_it_no)? 'selected':''}> ${furIteVO.fnt_name}</option>
				</c:if>
			</c:forEach>
			</c:if>    
		</select></td>
<!-- 		建立新增家具類別按鈕 -->
	</tr>
	
	<tr>
		<th>家具照片：</th>
		<td>
		<input type="file" id="load" name="fnt_pic" size="45" />
		<div id="picView">
		</div>
		</td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

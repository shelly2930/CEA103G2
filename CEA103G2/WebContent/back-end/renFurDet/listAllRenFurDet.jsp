<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.renFurDet.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furLis.model.*"%>
<%@ page import="com.furCat.model.*"%>
 <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />
 <jsp:useBean id="furCatSvc" scope="page" 	class="com.furCat.model.FurCatService" />
<%-- <jsp:useBean id="furIteDAO" scope="page" 	class="com.furIte.model.FurIteDAO" /> --%>
待處理值會顯示毫秒.0問題 (處理複合查詢的list值)
<% 	  
List<RenFurDetVO> list =null;
RenFurDetService renFurDetSvc = new RenFurDetService();
list= renFurDetSvc.getAll();
pageContext.setAttribute("list",list);

// 指派時可能會用到類似邏輯 先留
// 		List<RenFurDetVO> list =null;
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>租家具申請單明細資料</title>

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
  
#keywordSearchArea,#multiArea,#listAllButton{
			float:left;
			margin-right:10px;
			margin-left:10px;
/*   			 border:1px solid green; */
   }

/*    #multiArea{ */
/* display: inline;  */
/*   			 padding:20px; */
/*   			 border:1px solid blue; */
/*    } */
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
            url:"<%=request.getContextPath()%>/furIte/furIte.do",
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
    }else {
    	  $.ajax({
              url:"<%=request.getContextPath()%>/furIte/furIte.do",
              type:"POST",
              data:{
              	"action":"getFurIteSelect",
             },
              success: function(data){
              	 console.log(data);
                 showFurItes(data);
                  }
              });
    }
}

function showFurItes(data){
	   var fnt_data=data.split(",");
	    var txt="";

	    if(fnt_data===""){
	    	txt+="<option value=\"none\">此類別尚無家具品項</option>";
	    
	    }else{
	    	for(i in fnt_data){
	          	 var cut = fnt_data[i].indexOf('-');
	           	 txt+="<option value="+fnt_data[i].slice(0,cut)+">"+fnt_data[i].slice(cut+1)+"</option>";
	           }
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
		 <h3>家具申請單明細管理<br><font color=blue>listAllRenFurDet</font></h3>
	</td></tr>
</table>
<!-- 目前會從申請單頁面建立新增功能  暫不再此新增-->
<!-- <div id="addArea"> -->
<%-- <a href="<%=request.getContextPath()%>/back-end/renFurDet/addRenFurDet.jsp"> --%>
<!--     <input type="button" value="新增資料" id="addButton"></a> -->
<!-- </div> -->
<!-- <br> -->
<div id="listAllButton">
    <a href="<%=request.getContextPath()%>/back-end/renFurDet/listAllRenFurDet.jsp">
    <input type="button" value="全部" id="getAllButton"></a>
</div>    
<div id="keywordSearchArea">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do"  name="form1">
        <b>輸入關鍵字:</b>
        <input type="text" name="keyword"  style="width:130px; height:25px;" >
       <input type="submit" value="查詢"  id="keywordSearch">
        <input type="hidden" name="action" value="keywordSearch">
        </FORM>
</div>  
<div id="multiArea">
	 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furIte/furIte.do" name="form1">
	   <select size="1" name="fnt_ctgr_no"  id="furCatSelect" style="width:80px; height:30px;">
	      <option >家具類別</option>
         <c:forEach var="furCatVO" items="${furCatSvc.all}" > 
          <option value="${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</option>
         </c:forEach>   
       </select>
<%--        <jsp:useBean id="furIteSvc2" scope="page" class="com.furIte.model.FurIteService" /> --%>
          <select size="1" name="fnt_it_no" id="furIteSelect"  style="width:150px; height:30px;">
	      <option >家具品項</option>
         <c:forEach var="furIteVO"  items="${furIteSvc.all}" > 
          <option value="${furIteVO.fnt_it_no}">${furIteVO.fnt_name}</option>
         </c:forEach>   
       </select>
       <input type="submit" value="查詢"  id="multiSearch">
       <input type="hidden" name="action" value="multiSearch">
	 </FORM>
</div>
<br>
<br>
<br>
<table>
<!-- 	設計游標選到名稱時  可自行連結到各品項清單頁面-->
	<tr>
<!-- 	測試時先顯示租家具申請單編號 之後display none -->
		<th>申請單<br>編號</th>
		<th>家具<br>編號</th>
		<th>家具名稱</th>
		<th>每月租金</th>
		<th>出租日期</th>
		<th>終止日期</th>
		<th>解租日期</th>
<!-- 		編輯及刪除 先測試 之後到展開細項不顯示 -->
		<th>編輯</th>
		<th>刪除</th>
	</tr>

	<%@ include file="page1_renFurDet.file"%>		    
<jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" />
<c:forEach var="renFurDetVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${renFurDetVO.rfa_no}</td>
			<td>${renFurDetVO.fnt_id}</td>
			<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_name}</td>
			  <td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price}</td>
			<td><fmt:formatDate value="${renFurDetVO.rent_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td><fmt:formatDate value="${renFurDetVO.rent_end_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td><fmt:formatDate value="${renFurDetVO.rent_tmt_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
 		<td> 
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do" style="margin-bottom: 0px;">
		     <input type="submit" value="編輯">
			     <input type="hidden" name="rfa_no"  value="${renFurDetVO.rfa_no}">
			     <input type="hidden" name="fnt_id"  value="${renFurDetVO.fnt_id}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
 			     <input type="hidden" name="action" value="getOne_For_Update"></FORM> 
		</td> 
		<td> 
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do" style="margin-bottom: 0px;">
		     <input type="submit" value="刪除">
			     <input type="hidden" name="rfa_no"  value="${renFurDetVO.rfa_no}">
			      <input type="hidden" name="fnt_id"  value="${renFurDetVO.fnt_id}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
 			     <input type="hidden" name="action" value="delete"></FORM> 
			</td>
 		</tr> 
	</c:forEach>
</table>
<!-- 待處理分頁問題 -->
 <%@ include file="page2_renFurDet.file" %>

</body>
</html>
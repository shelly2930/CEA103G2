<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furIte.model.*"%>

待處理圖片預覽問題
家具大類及規格複合查詢 上架及下架鈕搜尋超連結內容

<% 	  
		List<FurIteVO> list =new ArrayList<FurIteVO>();
		if(request.getAttribute("QueryResultList")!=null && request.getParameter("fnt_ctgr_no")==null){
			list=(ArrayList<FurIteVO>) request.getAttribute("QueryResultList");	
				 pageContext.setAttribute("list",list);				
		}else if(request.getParameter("fnt_ctgr_no")==null){
			FurIteService furIteSvc = new FurIteService();
		    list= furIteSvc.getAll();
		    pageContext.setAttribute("list",list);	
		} 
		else{
			FurIteService furIteSvc = new FurIteService(); 
			Integer fnt_ctgr_no = new Integer(request.getParameter("fnt_ctgr_no"));
			 list = furIteSvc.getOneFurCat_Item(fnt_ctgr_no); 
			pageContext.setAttribute("list",list);
		}
%>


<% 	  
// 		List<FurIteVO> list =new ArrayList<FurIteVO>();
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

<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
<jsp:useBean id="furPhoSvc" scope="page" class="com.furPho.model.FurPhoService" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>家具品項資料</title>

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
   a:link{
  	color:blue;
  	text-decoration:none;
  }
  a:hover{
   	color:purple;
  	text-decoration:underline;
  	cursor:pointer;
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
             margin-left: 10px;
            background-color: #628AC0;
            color: #fff;
            border-radius: 10px;
            height: 30px;
            width: 120px;
            font-size: 20px;
            text-align: center;
        }
 #getOnItemButton,#getOffItemButton{
            border: 0;
            background-color: #628AC0;
            color: #fff;
            border-radius: 10px;
            height: 30px;
            width: 90px;
            font-size: 18px;
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
   #searchArea,#multiArea,#keywordSearArea{
			float:left;
  			 margin-left: 5px;
  			 margin-right:15px;
  			 margin-top:5px;
  			 margin-buttom:0px;
  			 
/* border:1px solid green;  */
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
		 <h3>家具品項管理<br><font color=blue>listAllFntItem</font></h3>
	</td></tr>
</table>
 
<div id="addArea">
<a href="<%=request.getContextPath()%>/back-end/furIte/addFurIte.jsp">
    <input type="button" value="新增資料" id="addButton"></a>
</div>
<div id="searchArea">
<a href="<%=request.getContextPath()%>/back-end/furIte/listAllFurIte.jsp">
    <input type="button" value="全部" id="getAllButton"></a>
    <a href="<%=request.getContextPath()%>/furIte/furIte.do?action=getOnItem&requestURL=<%=request.getServletPath()%>">
    <input type="button" value="上架品項" id="getOnItemButton"></a>
    <a href="<%=request.getContextPath()%>/furIte/furIte.do?action=getOffItem&requestURL=<%=request.getServletPath()%>"">
    <input type="button" value="下架品項" id="getOffItemButton"></a>
</div>

<div id="keywordSearArea">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furIte/furIte.do"" name="form1">
        <b>輸入關鍵字:</b>
        <input type="text" name="keyword"  style="width:130px; height:30px;" >
       <input type="submit" value="查詢"  id="keywordSearch">
<%--  待處理分頁問題       <input type="hidden" name="whichPage" value="<%=whichPage%>"> --%>
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
         <c:forEach var="furIteVO"  items="${list}" > 
          <option value="${furIteVO.fnt_it_no}">${furIteVO.fnt_name}</option>
         </c:forEach>   
       </select>
       <input type="submit" value="查詢"  id="multiSearch">
       <input type="hidden" name="action" value="multiSearch">
	 </FORM>
</div>
<br>
<br>

<table>
<!-- 	設計游標選到名稱時  可自行連結到各品項清單頁面-->
	<tr>
		<th>品項<br>編號</th>
		<th>品項名稱</th>
		<th>家具圖片</th>
		<th>可租<br>數量</th>
		<th>租用<br>數量</th>
		<th>維修<br>數量</th>
		<th>總數量</th>
		<th>出租<br>價格</th>
		<th>規格</th>
		<th>瀏覽<br>次數</th>
		<th>刊登<br>狀態</th>
		<th>編輯</th>
		<th>刪除</th>
	</tr>
<br>
<br>
<%-- 	<%@ include file="page1_furIte.file"%>	 --%>
<c:forEach var="furIteVO" items="${list}" >
<%-- <c:forEach var="furIteVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"> --%>
		<tr>
			<td>${furIteVO.fnt_it_no}</td>
			<td><a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp?fnt_it_no=${furIteVO.fnt_it_no}">${furIteVO.fnt_name}</a></td> 
			<td>
				<img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFurPho(furIteVO.fnt_it_no).fnt_pic_no}"
					height="100">
				<a href="<%=request.getContextPath()%>/back-end/furPho/listAllFurPho.jsp?fnt_it_no=${furIteVO.fnt_it_no}"  onClick="window.open('<%=request.getContextPath()%>/back-end/furPho/listAllFurPho.jsp?fnt_it_no=${furIteVO.fnt_it_no}','update_fnt_pic','width=780,height=500,directories=no,location=no,menubar=no,scrollbars=yes,status=no,toolbar=no,resizable=no,left=5,top=0,screenX=250,screenY=50');return false">
		<img src="<%=request.getContextPath()%>/back-end/furIte/images/pic.png" style="width:20px; height:20px;"></a>
			
			</td>
			<td>${furIteVO.fnt_unrent}</td>
			<td>${furIteVO.fnt_total-furIteVO.fnt_unrent-furIteVO.fnt_repair}</td>
			<td>${furIteVO.fnt_repair}</td>
			<td>${furIteVO.fnt_total}</td>
			<td>${furIteVO.fnt_price}</td>
			<td>${furIteVO.fnt_standard}</td>
			<td>${furIteVO.fnt_views}</td>	
			<td><c:choose>
						<c:when test="${furIteVO.fnt_post_status==0}"> 已下架</c:when>
						<c:otherwise> 已上架</c:otherwise>
					</c:choose></td>	
 		<td> 
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furIte/furIte.do" style="margin-bottom: 0px;">
		     <input type="submit" value="編輯">
			     <input type="hidden" name="fnt_it_no"  value="${furIteVO.fnt_it_no}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
 			     <input type="hidden" name="action" value="getOne_For_Update"></FORM> 
		</td> 
		<td> 
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furIte/furIte.do" style="margin-bottom: 0px;">
		     <input type="submit" value="刪除">
			     <input type="hidden" name="fnt_it_no"  value="${furIteVO.fnt_it_no}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
 			     <input type="hidden" name="action" value="delete"></FORM> 
			</td>
 		</tr> 
	</c:forEach>
</table>
<!-- 待處理分頁問題 -->
<%--  <%@ include file="page2_furIte.file" %> --%>
 </div>
</body>
</html>
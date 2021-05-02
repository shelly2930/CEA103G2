<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furLis.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furCat.model.*"%>

待處理家具大類 、品項、狀態及規格複合查詢

<%
	List<FurLisVO> list = null;
	if (request.getParameter("fnt_it_no") == null) {
		FurLisService furLisSvc = new FurLisService();
		list = furLisSvc.getAll();
		pageContext.setAttribute("list", list);
	} else {
		FurLisService furLisSvc = new FurLisService();
		Integer fnt_it_no = new Integer(request.getParameter("fnt_it_no"));
		list = furLisSvc.getOneFur_Item_Lis(fnt_it_no);
		pageContext.setAttribute("list", list);
	}
%>

<jsp:useBean id="furCatDAO" scope="page"
	class="com.furCat.model.FurCatDAO" />
<jsp:useBean id="furIteDAO" scope="page"
	class="com.furIte.model.FurIteDAO" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>家具品項清單</title>

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

a:link {
	color: blue;
	text-decoration: none;
}

a:hover {
	color: purple;
	text-decoration: underline;
	cursor: pointer;
}

#addButton {
	border: 0;
	background-color: #628AC0;
	color: #fff;
	border-radius: 10px;
	height: 30px;
	width: 120px;
	font-size: 20px;
	text-align: center;
}

#keywordSearch, #multiSearch, #getAllButton {
	border: 0;
	background-color: #628AC0;
	color: #fff;
	border-radius: 10px;
	height: 30px;
	width: 60px;
	font-size: 20px;
	text-align: center;
}

#searchArea, #multiArea {
	display: inline-block;
	margin-top: 5px;
	margin-left:50px;
	/*    			 border:1px solid green; */
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
		<tr>
			<td>
				<h3>
					家具清單管理<br> <font color=blue>listAllFntList</font>
				</h3>
			</td>
		</tr>
	</table>
	<div id="addArea">

		<a
			href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp">
			<input type="button" value="全部" id="getAllButton">
		</a> <a href="<%=request.getContextPath()%>/back-end/furLis/addFurLis.jsp">
			<input type="button" value="新增資料" id="addButton">
		</a>
	</div>
	<div id="searchArea">
		<FORM METHOD="post"
			ACTION="<%=request.getContextPath()%>/furLis/furLis.do" name="form1">
			<b>輸入關鍵字:</b> <input type="text" name="keyword"
				style="width: 130px; height: 30px;"> <input type="submit"
				value="查詢" id="keywordSearch"> <input type="hidden"
				name="action" value="keywordSearch">
		</FORM>
	</div>
	<div id="multiArea">
		<FORM METHOD="post"
			ACTION="<%=request.getContextPath()%>/furLis/furLis.do" name="form1">

			<select size="1" name="fnt_ctgr_no"  id="furCatSelect" 
				style="width: 80px; height: 30px;">
				<option>家具類別</option>
				<c:forEach var="furCatVO" items="${furCatDAO.all}">
					<option value="${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</option>
				</c:forEach>
			</select>
			<%--        <jsp:useBean id="furIteSvc2" scope="page" class="com.furIte.model.FurIteService" /> --%>
			<select size="1" name="fnt_it_no" style="width: 150px; height: 30px;" id="furIteSelect">
				<option>家具品項</option>
				<c:forEach var="furIteVO" items="${furIteDAO.all}">
					<option value="${furIteVO.fnt_it_no}">${furIteVO.fnt_name}</option>
				</c:forEach>
			</select> <select size="1" name="fnt_status"
				style="width: 80px; height: 30px;">
				<option>家具狀態</option>
				<option value="0">正常</option>
				<option value="1">維修</option>
				<option value="2">報廢</option>
			</select> <select size="1" name="fnt_rent_status"
				style="width: 80px; height: 30px;">
				<option>出租狀態</option>
				<option value="0">未出租</option>
				<option value="1">出租中</option>
			</select> <input type="submit" value="查詢" id="multiSearch"> 
							<input type="hidden" name="action" value="compositeQuery">
		</FORM>
	</div>
	<div id="showResult"></div>
	<%@ include file="page1.file"%>
	<table>
		<!-- 	設計游標選到名稱時  可自行連結到各品項清單頁面-->
		<tr>
			<th>家具<br>序號</th>
			<th>類別名稱</th>
			<th>品項名稱</th>
			<th>規格</th>
			<th>家具狀態</th>
			<th>租借狀態</th>
			<th>編輯</th>
			<th>刪除</th>
		</tr>

		<c:forEach var="furLisVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<!-- 		家具序號 -->
				<td>${furLisVO.fnt_id}</td>
				<!-- 			家具類別名稱 -->
				<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
						<c:if test="${furLisVO.fnt_it_no==furIteVO.fnt_it_no}">
							<c:forEach var="furCatVO" items="${furCatDAO.all}">
								<c:if test="${furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no}">
                    ${furCatVO.fnt_ctgr_name}
                    </c:if>
							</c:forEach>
						</c:if>
					</c:forEach></td>
				<!-- 			家具品項名稱 -->
				<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
						<c:if test="${furLisVO.fnt_it_no==furIteVO.fnt_it_no}">
	                    ${furIteVO.fnt_name}
                    </c:if>
					</c:forEach></td>
				<!-- 		規格		  -->
				<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
						<c:if test="${furLisVO.fnt_it_no==furIteVO.fnt_it_no}">
	                    ${furIteVO.fnt_standard}
                    </c:if>
					</c:forEach></td>
				<!-- 			家具狀態 -->
				<td><c:choose>
						<c:when test="${furLisVO.fnt_status==0}"> 正常 </c:when>
						<c:when test="${furLisVO.fnt_status==1}"> 維修 </c:when>
						<c:otherwise> 報廢</c:otherwise>
					</c:choose></td>
				<!-- 		租借狀態 -->
				<td><c:choose>
						<c:when test="${furLisVO.fnt_rent_status==0}"> 未出租</c:when>
						<c:otherwise> 出租中</c:otherwise>
					</c:choose></td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/furLis/furLis.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="編輯"> 
						<input type="hidden" name="fnt_id" value="${furLisVO.fnt_id}">
						 <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			             <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
						 <input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post" 	ACTION="<%=request.getContextPath()%>/furLis/furLis.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> 
						<input type="hidden" name="fnt_id" value="${furLisVO.fnt_id}">
					 <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
							 <input type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>

	<%@ include file="page2.file"%>
</body>
</html>
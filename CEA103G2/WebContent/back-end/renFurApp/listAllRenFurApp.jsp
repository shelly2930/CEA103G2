 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="com.renFurDet.model.*"%>
<%@ page import="com.furLis.model.*"%>
<%@ page import="com.furIte.model.*"%>
待處理租借家具明細出租價格合計(目前暫用資料庫寫定的相加值 非細項動態自動相加值)
<% 	  
List<RenFurAppVO> list =new ArrayList<RenFurAppVO>();
if(request.getAttribute("QueryResultList")!=null){
	list=(ArrayList<RenFurAppVO>) request.getAttribute("QueryResultList");	
		 pageContext.setAttribute("list",list);				
}else{
RenFurAppService renFurAppSvc = new RenFurAppService();
list= renFurAppSvc.getAll();
pageContext.setAttribute("list",list);}

// 指派時可能會用到類似邏輯 先留
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
 <title>租家具申請單資料</title>
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
		 <h3>租家具申請單管理<br><font color=blue>listAllRenFurApp</font></h3>
	</td></tr>
</table>
 
<div id="addArea">
<a href="<%=request.getContextPath()%>/back-end/renFurApp/addRenFurApp.jsp">
    <input type="button" value="新增資料" id="addButton"></a>
</div>
<br>
<div id="searchArea">
    <a href="<%=request.getContextPath()%>/back-end/renFurApp/listAllRenFurApp.jsp">
    <input type="button" value="全部" id="getAllButton"></a>
    <a href="<%=request.getContextPath()%>/renFurApp/renFurApp.do?action=pending">
    <input type="button" value="未處理" id="pendingButton"></a>
    <a href="<%=request.getContextPath()%>/renFurApp/renFurApp.do?action=processing">
    <input type="button" value="處理中" id="processingButton"></a>
    <a href="<%=request.getContextPath()%>/renFurApp/renFurApp.do?action=solved">
    <input type="button" value="已完成" id="solvedButton"></a>
</div>
<div id="keywordSearchArea">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do"  name="form1">
        <b>輸入關鍵字:</b>
        <input type="text" name="keyword"  style="width:130px; height:25px;" >
       <input type="submit" value="查詢"  id="keywordSearch">
        <input type="hidden" name="action" value="keywordSearch">
        </FORM>
</div>  
<br>
<br>
<br>

    <table>
    <tr>
		<th></th>
		<th>申請單<br>編號</th>
		<th>會員姓名</th>
		<th>申請時間</th>
		<th>預約時間</th>
		<th>申請進度</th>
		<th>負責員工</th>
	    <th>租金合計</th>
		<th>租借狀態</th>
		<th colspan="2">操作</th>
	</tr>
	<%@include file="page1_renFurApp.file"%>		    
<jsp:useBean id="empSvc" scope="page" class="com.employee.model.EmployeeService" />
<jsp:useBean id="memTenSvc" scope="page" class="com.memTen.model.MemTenService" />
<c:forEach var="renFurAppVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
        <tr>
            <td width="26" align="center" bgcolor="#eeeeee"><a href="#${renFurAppVO.rfa_no}" class="plus">+</a></td>
<!--             <td width="474">　訂單01</td> -->
     	<td>${renFurAppVO.rfa_no}</td>
				<td><c:forEach var="memTenVO" items="${memTenSvc.all}">
							<c:if test="${renFurAppVO.mem_no==memTenVO.mem_no}">
		                    ${memTenVO.mem_name}
	                    </c:if>	</c:forEach></td>
				<td><fmt:formatDate value="${renFurAppVO.rfa_apct_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td><fmt:formatDate value="${renFurAppVO.rfa_order_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td><c:choose>
							<c:when test="${renFurAppVO.rfa_status==0}"> 未處理 </c:when>
							<c:when test="${renFurAppVO.rfa_status==1}"> 處理中</c:when>
							<c:otherwise> 已完成</c:otherwise>
						</c:choose>
				</td>
				<td><c:if test="${not empty renFurAppVO.emp_no}">
							<c:forEach var="empVO" items="${empSvc.all}">
								<c:if test="${renFurAppVO.emp_no==empVO.emp_no}">${empVO.emp_name}</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${renFurAppVO.emp_no==0}">尚未指派</c:if>
				</td>
			
				<td>${renFurAppVO.rfa_total} 元</td>
				
					<!-- 				再次引用renFurAppSvc2是為了做租用狀態判斷用			 -->
 					<jsp:useBean id="renFurAppSvc2" scope="page" class="com.renFurApp.model.RenFurAppService" />
<%-- 				<td><span class="furRenStatus">${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)}<span></td> --%>
				<td><c:choose>
						<c:when test="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0}"> 已退租 </c:when>
						<c:when test="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==1}"> 未租用 </c:when>
						<c:otherwise>租用中</c:otherwise>
					</c:choose>
				</td>
				<td><a href="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0? pageContext.request.contextPath+="/renFurApp/renFurApp.do?rfa_no="+=renFurAppVO.rfa_no+="&requestURL="+=pageContext.request.requestURL+="&action=getOne_For_Look":pageContext.request.contextPath+="/renFurApp/renFurApp.do?rfa_no="+=renFurAppVO.rfa_no+="&requestURL="+=pageContext.request.requestURL+="&action=getOne_For_Update"}">
				${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0? "查看":"編輯"}</a></td> 
<!-- 查看編輯按鈕切換				 -->
<!-- 		 		<td>  -->
<%-- 					  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do" style="margin-bottom: 0px;"> --%>
<!-- <!-- 		 			     若申請單租借狀態為已退租 改按鈕值為"查看" --> 

<%-- 				     <input type="submit" value="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0? "查看":"編輯"}"> --%>
<%-- 					     <input type="hidden" name="rfa_no"  value="${renFurAppVO.rfa_no}"> --%>
<%-- 					      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<%-- 					     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
<!-- <!-- 		 			     若申請單租借狀態為已退租 改action值為"查看 getOne_For_Look" --> 
<%-- 		 			     <input type="hidden" name="action" value="${renFurAppSvc2.getRenFurAppStatus(renFurAppVO.rfa_no)==0? "getOne_For_Look":"getOne_For_Update"}"></FORM>  --%>
<!-- 				</td>  -->
				<td> 
				  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurApp/renFurApp.do" style="margin-bottom: 0px;">
			    	 <input type="submit" value="刪除">
				     <input type="hidden" name="rfa_no"  value="${renFurAppVO.rfa_no}">
				      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
	 			     <input type="hidden" name="action" value="delete"></FORM> 
				</td>
 		</tr> 
<!--  可被展開的明細內容        -->
        <tr>
            <td colspan="11" class="content">
                <div id="${renFurAppVO.rfa_no}" style="display:none;">
                    <table style="border: 0px; border-collapse: collapse; width:90%; margin:15px auto 15px 30px;">
                        <tr>
<!-- 	測試用 展開不顯示申請單編號         	<th>申請單<br>編號</th> -->
							<th>家具<br>編號</th>
							<th>家具名稱</th>
							<th>家具租金</th>
							<th>出租日期</th>
							<th>終止日期</th>
							<th>解租日期</th>
                        </tr>
                        <jsp:useBean id="furLisSvc" scope="page" class="com.furLis.model.FurLisService" />
                        <jsp:useBean id="furIteSvc" scope="page" class="com.furIte.model.FurIteService" />
                        <jsp:useBean id="renFurDetSvc" scope="page" class="com.renFurDet.model.RenFurDetService" />
						<c:forEach var="renFurDetVO" items="${renFurDetSvc.all}" >
							<c:if test="${renFurAppVO.rfa_no==renFurDetVO.rfa_no}">
								<tr>
<%-- 	測試用 展開不顯示申請單編號		<td>${renFurDetVO.rfa_no}</td> --%>
									<td>${renFurDetVO.fnt_id}</td>
									<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_name}</td>
			  						<td>${furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.fnt_id).fnt_it_no).fnt_price} 元</td>
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
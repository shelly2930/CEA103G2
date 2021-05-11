<%@page import="com.memTen.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furCol.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furPho.model.*"%>

1.待處理會員點選收藏家具圖片或家具名稱時 可連到家具的介紹頁面
2.處理按我要租借時 可以前往購物車頁面 (無庫存時 我要租借 無法點選)
3.session取會員資料後 把會員編號欄位刪除
4.待處理無庫存時 加入租借鈕無法點選
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
<title>我的家具收藏</title>

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
/*   超連結處理 */
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
		 <h3>我的家具收藏<br><font color=blue>My FUR COL</font></h3>
	</td></tr>
</table>
 

<br>
<table>
<!-- 	設計游標選到名稱時  可自行連結到各品項清單頁面-->
	<tr>
<!-- 	會員編號測試用 之後不呈現 -->
		<th>會員<br>編號</th>
		<th>家具圖片</th>
		<th>家具名稱</th>
		<th>備註</th>
		<th>庫存</th>
		<th>租借</th>
		<th>變更</th>
	</tr>
<!-- 	//here -->
	<%@ include file="page1_furCol.file"%>		    
<%-- <c:forEach var="furCoIVO" items="${list}" > --%>
<c:forEach var="furCoIVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${furCoIVO.fnt_it_no}</td>
<!-- 			此段超連結跳轉先保留 待之後可直接點到家具品項介紹頁面用 -->
<%-- 			<td><a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp?fnt_it_no=${furCoIVO.fnt_it_no}">${furIteSvc.getOneFurIte(furCoIVO.fnt_it_no).fnt_name}</a></td>  --%>
			
			<td class="fnt_pic">
				<img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFurPho(furCoIVO.fnt_it_no).fnt_pic_no}"
					height="100">
			</td>
			<td class="fnt_info">${furIteSvc.getOneFurIte(furCoIVO.fnt_it_no).fnt_name}
					<br>
					<p>收藏時間：<fmt:formatDate value="${furCoIVO.fnt_col_date}"	pattern="yyyy-MM-dd HH:mm:ss" /></p>
			</td>
			<td class="col_note">${furCoIVO.fnt_col_note}</td>
		<td>
		<c:choose>
	<c:when test="${furIteSvc.getOneFurIte(furCoIVO.fnt_it_no).fnt_unrent>0}">有</c:when>	
	<c:when test="${furIteSvc.getOneFurIte(furCoIVO.fnt_it_no).fnt_unrent<=0}">無</c:when>			
</c:choose>
		</td>
		<td> <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCol/furCol.do" style="margin-bottom: 0px;">
				<a href="<%=request.getContextPath()%>/back-end/renFurDet/listAllRenFurDet.jsp">
   				 <input type="button" value="加入租借"  id="rentNow"></a>
   				  <input type="hidden" name="mem_no"  value="${furColVO.mem_no}">
			     <input type="hidden" name="fnt_it_no"  value="${furColVO.fnt_it_no}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
 			     <input type="hidden" name="action" value="rentNow"></FORM>
   		</td>
 		<td> 
<!-- 			編輯 -->
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCol/furCol.do" style="margin-bottom: 0px;">
		     <input type="submit" value="編輯">
			     <input type="hidden" name="mem_no"  value="${furColVO.mem_no}">
			     <input type="hidden" name="fnt_it_no"  value="${furColVO.fnt_it_no}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
 			     <input type="hidden" name="action" value="getOne_For_Update"></FORM> 
				<br>
<!-- 		刪除 -->
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furCol/furCol.do" style="margin-bottom: 0px;">
		     <input type="submit" value="刪除">
			     <input type="hidden" name="mem_no"  value="${furColVO.mem_no}">
			      <input type="hidden" name="fnt_it_no"  value="${furColVO.fnt_it_no}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
 			     <input type="hidden" name="action" value="delete"></FORM> 
			</td>
 		</tr> 
	</c:forEach>
</table>
<!-- 待處理分頁問題 -->
 <%@ include file="page2_furCol.file" %>
 </div>
</body>
</html>
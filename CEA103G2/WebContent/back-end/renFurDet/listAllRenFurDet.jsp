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
�ݳB�z�ȷ|��ܲ@��.0���D (�B�z�ƦX�d�ߪ�list��)
<% 	  
List<RenFurDetVO> list =null;
RenFurDetService renFurDetSvc = new RenFurDetService();
list= renFurDetSvc.getAll();
pageContext.setAttribute("list",list);

// �����ɥi��|�Ψ������޿� ���d
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
<title>���a��ӽг���Ӹ��</title>

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
<!-- �B�z�U�Ԧ����s�ʨ��� -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script type="text/javascript">

function getFurCat(e){ 
    $("#furIteSelect option:not(:first)").remove();
    var fnt_ctgr_no=(e.target.value);
    console.log(fnt_ctgr_no);
    if(fnt_ctgr_no !="" && fnt_ctgr_no !="�a�����O"){
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
	    	txt+="<option value=\"none\">�����O�|�L�a��~��</option>";
	    
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
		 <h3>�a��ӽг���Ӻ޲z<br><font color=blue>listAllRenFurDet</font></h3>
	</td></tr>
</table>
<!-- �ثe�|�q�ӽг歶���إ߷s�W�\��  �Ȥ��A���s�W-->
<!-- <div id="addArea"> -->
<%-- <a href="<%=request.getContextPath()%>/back-end/renFurDet/addRenFurDet.jsp"> --%>
<!--     <input type="button" value="�s�W���" id="addButton"></a> -->
<!-- </div> -->
<!-- <br> -->
<div id="listAllButton">
    <a href="<%=request.getContextPath()%>/back-end/renFurDet/listAllRenFurDet.jsp">
    <input type="button" value="����" id="getAllButton"></a>
</div>    
<div id="keywordSearchArea">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do"  name="form1">
        <b>��J����r:</b>
        <input type="text" name="keyword"  style="width:130px; height:25px;" >
       <input type="submit" value="�d��"  id="keywordSearch">
        <input type="hidden" name="action" value="keywordSearch">
        </FORM>
</div>  
<div id="multiArea">
	 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furIte/furIte.do" name="form1">
	   <select size="1" name="fnt_ctgr_no"  id="furCatSelect" style="width:80px; height:30px;">
	      <option >�a�����O</option>
         <c:forEach var="furCatVO" items="${furCatSvc.all}" > 
          <option value="${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</option>
         </c:forEach>   
       </select>
<%--        <jsp:useBean id="furIteSvc2" scope="page" class="com.furIte.model.FurIteService" /> --%>
          <select size="1" name="fnt_it_no" id="furIteSelect"  style="width:150px; height:30px;">
	      <option >�a��~��</option>
         <c:forEach var="furIteVO"  items="${furIteSvc.all}" > 
          <option value="${furIteVO.fnt_it_no}">${furIteVO.fnt_name}</option>
         </c:forEach>   
       </select>
       <input type="submit" value="�d��"  id="multiSearch">
       <input type="hidden" name="action" value="multiSearch">
	 </FORM>
</div>
<br>
<br>
<br>
<table>
<!-- 	�]�p��п��W�ٮ�  �i�ۦ�s����U�~���M�歶��-->
	<tr>
<!-- 	���ծɥ���ܯ��a��ӽг�s�� ����display none -->
		<th>�ӽг�<br>�s��</th>
		<th>�a��<br>�s��</th>
		<th>�a��W��</th>
		<th>�C�믲��</th>
		<th>�X�����</th>
		<th>�פ���</th>
		<th>�ѯ����</th>
<!-- 		�s��ΧR�� ������ �����i�}�Ӷ������ -->
		<th>�s��</th>
		<th>�R��</th>
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
		     <input type="submit" value="�s��">
			     <input type="hidden" name="rfa_no"  value="${renFurDetVO.rfa_no}">
			     <input type="hidden" name="fnt_id"  value="${renFurDetVO.fnt_id}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
 			     <input type="hidden" name="action" value="getOne_For_Update"></FORM> 
		</td> 
		<td> 
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/renFurDet/renFurDet.do" style="margin-bottom: 0px;">
		     <input type="submit" value="�R��">
			     <input type="hidden" name="rfa_no"  value="${renFurDetVO.rfa_no}">
			      <input type="hidden" name="fnt_id"  value="${renFurDetVO.fnt_id}">
			      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
 			     <input type="hidden" name="action" value="delete"></FORM> 
			</td>
 		</tr> 
	</c:forEach>
</table>
<!-- �ݳB�z�������D -->
 <%@ include file="page2_renFurDet.file" %>

</body>
</html>
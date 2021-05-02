<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furLis.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furCat.model.*"%>

�ݳB�z�a��j�� �B�~���B���A�γW��ƦX�d��

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
<title>�a��~���M��</title>

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
		<tr>
			<td>
				<h3>
					�a��M��޲z<br> <font color=blue>listAllFntList</font>
				</h3>
			</td>
		</tr>
	</table>
	<div id="addArea">

		<a
			href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp">
			<input type="button" value="����" id="getAllButton">
		</a> <a href="<%=request.getContextPath()%>/back-end/furLis/addFurLis.jsp">
			<input type="button" value="�s�W���" id="addButton">
		</a>
	</div>
	<div id="searchArea">
		<FORM METHOD="post"
			ACTION="<%=request.getContextPath()%>/furLis/furLis.do" name="form1">
			<b>��J����r:</b> <input type="text" name="keyword"
				style="width: 130px; height: 30px;"> <input type="submit"
				value="�d��" id="keywordSearch"> <input type="hidden"
				name="action" value="keywordSearch">
		</FORM>
	</div>
	<div id="multiArea">
		<FORM METHOD="post"
			ACTION="<%=request.getContextPath()%>/furLis/furLis.do" name="form1">

			<select size="1" name="fnt_ctgr_no"  id="furCatSelect" 
				style="width: 80px; height: 30px;">
				<option>�a�����O</option>
				<c:forEach var="furCatVO" items="${furCatDAO.all}">
					<option value="${furCatVO.fnt_ctgr_no}">${furCatVO.fnt_ctgr_name}</option>
				</c:forEach>
			</select>
			<%--        <jsp:useBean id="furIteSvc2" scope="page" class="com.furIte.model.FurIteService" /> --%>
			<select size="1" name="fnt_it_no" style="width: 150px; height: 30px;" id="furIteSelect">
				<option>�a��~��</option>
				<c:forEach var="furIteVO" items="${furIteDAO.all}">
					<option value="${furIteVO.fnt_it_no}">${furIteVO.fnt_name}</option>
				</c:forEach>
			</select> <select size="1" name="fnt_status"
				style="width: 80px; height: 30px;">
				<option>�a�㪬�A</option>
				<option value="0">���`</option>
				<option value="1">����</option>
				<option value="2">���o</option>
			</select> <select size="1" name="fnt_rent_status"
				style="width: 80px; height: 30px;">
				<option>�X�����A</option>
				<option value="0">���X��</option>
				<option value="1">�X����</option>
			</select> <input type="submit" value="�d��" id="multiSearch"> 
							<input type="hidden" name="action" value="compositeQuery">
		</FORM>
	</div>
	<div id="showResult"></div>
	<%@ include file="page1.file"%>
	<table>
		<!-- 	�]�p��п��W�ٮ�  �i�ۦ�s����U�~���M�歶��-->
		<tr>
			<th>�a��<br>�Ǹ�</th>
			<th>���O�W��</th>
			<th>�~���W��</th>
			<th>�W��</th>
			<th>�a�㪬�A</th>
			<th>���ɪ��A</th>
			<th>�s��</th>
			<th>�R��</th>
		</tr>

		<c:forEach var="furLisVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<!-- 		�a��Ǹ� -->
				<td>${furLisVO.fnt_id}</td>
				<!-- 			�a�����O�W�� -->
				<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
						<c:if test="${furLisVO.fnt_it_no==furIteVO.fnt_it_no}">
							<c:forEach var="furCatVO" items="${furCatDAO.all}">
								<c:if test="${furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no}">
                    ${furCatVO.fnt_ctgr_name}
                    </c:if>
							</c:forEach>
						</c:if>
					</c:forEach></td>
				<!-- 			�a��~���W�� -->
				<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
						<c:if test="${furLisVO.fnt_it_no==furIteVO.fnt_it_no}">
	                    ${furIteVO.fnt_name}
                    </c:if>
					</c:forEach></td>
				<!-- 		�W��		  -->
				<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
						<c:if test="${furLisVO.fnt_it_no==furIteVO.fnt_it_no}">
	                    ${furIteVO.fnt_standard}
                    </c:if>
					</c:forEach></td>
				<!-- 			�a�㪬�A -->
				<td><c:choose>
						<c:when test="${furLisVO.fnt_status==0}"> ���` </c:when>
						<c:when test="${furLisVO.fnt_status==1}"> ���� </c:when>
						<c:otherwise> ���o</c:otherwise>
					</c:choose></td>
				<!-- 		���ɪ��A -->
				<td><c:choose>
						<c:when test="${furLisVO.fnt_rent_status==0}"> ���X��</c:when>
						<c:otherwise> �X����</c:otherwise>
					</c:choose></td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/furLis/furLis.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="�s��"> 
						<input type="hidden" name="fnt_id" value="${furLisVO.fnt_id}">
						 <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			             <input type="hidden" name="whichPage"	value="<%=whichPage%>">       
						 <input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post" 	ACTION="<%=request.getContextPath()%>/furLis/furLis.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="�R��"> 
						<input type="hidden" name="fnt_id" value="${furLisVO.fnt_id}">
					 <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
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
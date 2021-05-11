<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="java.util.*"%>

<%
  FurIteVO furIteVO = (FurIteVO) request.getAttribute("furIteVO"); //FurCatServlet.java (Concroller) �s�Jreq��furIteVO���� (�]�A�������X��furIteVO, �]�]�A��J��ƿ��~�ɪ�furIteVO����)
  FurIteService furIteSvc = new FurIteService();
  List<FurIteVO> list= furIteSvc.getAll();
  pageContext.setAttribute("list",list);
%>
�ݫإ߳B�z�󴫷Ӥ����D �L��Ӥ�����Ʈw��� �h�i�Ӥ��s�W�R����
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�a��~����ƭק� - update_furIte_input.jsp</title>

<style>
  textarea{
  	vertical-align:top
  }
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
  textarea{resize:none;}
</style>

<style>
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
}

function showFurItes(data){
    var fnt_name=data.split(",");
    var txt="";

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
		 <h3>�a��~����ƭק� - update_furIte_input.jsp</h3>
		 
 <h4><a href="<%=request.getContextPath()%>/back-end/furIte/listAllFurIte.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">��^�~���޲z</a></h4>
	</td></tr>
</table>

<h3>�~����ƭק�:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>


<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furIte/furIte.do" name="form1">
<table>
	
		<tr>
		<th>�a��~���s��:</th>
		<td><%=furIteVO.getFnt_it_no()%></td>
	</tr>
	<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
	<jsp:useBean id="furPhoSvc" scope="page" class="com.furPho.model.FurPhoService" />
	<tr>
		<th>�a�����O�W��:</th>
		<td><select size="1" name="fnt_ctgr_no"  id="furCatSelect">
				<option>�п��</option>
			<c:forEach var="furCatVO" items="${furCatSvc.all}">
				<option value="${furCatVO.fnt_ctgr_no}" ${(furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no)? 'selected':'' } >${furCatVO.fnt_ctgr_name}
			</c:forEach>
		</select></td>
    <!-- �إ߷s�W�a�����O���s--> 
	</tr>
		<tr>
		<th>�a��~���W��:</th>
		<td><input type="TEXT" name="fnt_name" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_name()%>" /></td>
	</tr>
	<tr>
		<th>�a��Ϥ�:</th>
		<td><div><c:forEach var="furPhoVO" items="${furPhoSvc.getOneFntItePics(furIteVO.fnt_it_no)}">
		<img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}"
					height="100"></c:forEach></div><br>
		<a href="<%=request.getContextPath()%>/back-end/furPho/listAllFurPho.jsp?fnt_it_no=${furIteVO.fnt_it_no}"  onClick="window.open('<%=request.getContextPath()%>/back-end/furPho/listAllFurPho.jsp?fnt_it_no=${furIteVO.fnt_it_no}','update_fnt_pic','width=780,height=500,directories=no,location=no,menubar=no,scrollbars=yes,status=no,toolbar=no,resizable=no,left=5,top=0,screenX=250,screenY=50');return false">
		<img src="<%=request.getContextPath()%>/back-end/furIte/images/pic.png" style="width:20px; height:20px;"></a>
		</td>
	</tr>
	<tr>
		<th>�i���ƶq:</th>
		<td><input type="TEXT" name="fnt_unrent" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_unrent()%>" /></td>
	</tr>
	<tr>
		<th>���׼ƶq:</th>
		<td><input type="TEXT" name="fnt_repair" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_repair()%>" /></td>
	</tr>
	<tr>
		<th>�`�ƶq:</th>
		<td><input type="TEXT" name="fnt_total" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_total()%>" /></td>
	</tr>
	<tr>
		<th>�X������:</th>
		<td><input type="TEXT" name="fnt_price" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_price()%>" /></td>
	</tr>
	<tr>
		<th>����:</th>
		<td><input type="TEXT" name="fnt_length" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_length()%>" /></td>
	</tr>
	<tr>
		<th>�e��:</th>
		<td><input type="TEXT" name="fnt_width" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_width()%>" /></td>
	</tr>
	<tr>
		<th>����:</th>
		<td><input type="TEXT" name="fnt_height" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_height()%>" /></td>
	</tr>
	<tr>
		<th>���q:</th>
		<td><input type="TEXT" name="fnt_weight" size="45"
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_weight()%>" /></td>
	</tr>
		<tr>
		<th>�W��:</th>
		<td><input type="TEXT" name="fnt_standard" size="45" 
			 value="<%= (furIteVO==null)? "" : furIteVO.getFnt_standard()%>" /></td>
	</tr>
	<tr>
		<th>�~������:</th>
 		<td>
 		<textarea name="fnt_info" cols="43" rows="7"><%=(furIteVO==null)? "" :furIteVO.getFnt_info()%></textarea></td> 
	</tr>
	<tr>
		<th>�s������:</th>
		<td><input type="TEXT" name="fnt_views" size="45"
			 value="<%=(furIteVO==null)? "" :furIteVO.getFnt_views()%>" /></td>
	</tr>	
	<tr>
		<th>�Z�n���A:</th>
		<td>
		<input type="radio" name="fnt_post_status" value="0"  ${(furIteVO.fnt_post_status==0)? 'checked':''}>�w�U�[
		<input type="radio" name="fnt_post_status" value="1"  ${(furIteVO.fnt_post_status==1)? 'checked':''}>�w�W�[
		</td>
	</tr>
	
</table>


<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="fnt_it_no" value="<%=furIteVO.getFnt_it_no()%>">
<input type="submit" value="�e�X�ק�"></FORM>
</body>
</html>
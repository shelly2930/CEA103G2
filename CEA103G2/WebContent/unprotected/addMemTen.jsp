<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memTen.model.*"%>

<%
  MemTenVO memTenVO = (MemTenVO) request.getAttribute("memTenVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�|����Ʒs�W - addMemTen.jsp</title>

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
</style>

<style>
  table {
	width: 450px;
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
  img {
  	width: 200px;
  	height: auto;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>�|����Ʒs�W - addMemTen.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="<%=request.getContextPath()%>/images/tomcat.png" width="100" height="100" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>�ж�g�|�����:</h3>

<%-- ���~���C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" name="form1">
<table>
	<tr>
		<td>�b��:</td>
		<td><input type="TEXT" name="mem_username" size="45" 
			 value="<%= (memTenVO==null)? "peter1" : memTenVO.getMem_username()%>" /></td>
	</tr>
	<tr>
		<td>�K�X:</td>
		<td><input type="TEXT" name="mem_password" size="45"
			 value="<%= (memTenVO==null)? "peter0101" : memTenVO.getMem_password()%>" /></td>
	</tr>
	<tr>
		<td>�Ӥ�:</td>
		<td><div id="preview"></div><input type="file" name="mem_pic" id="mem_pic" size="45" /></td>
	</tr>
	<tr>
		<td>�m�W:</td>
		<td><input type="TEXT" name="mem_name" size="45"
			 value="<%= (memTenVO==null)? "�d�ç�" : memTenVO.getMem_name()%>" /></td>
	</tr>
	<tr>
		<td>�ʧO:</td>
		<td>
			<select name="mem_gender" size="1"> 
				<option value="0"<%= ((memTenVO == null) ? "" : (memTenVO.getMem_gender() == 0 ? "selected" : ""))%>>�k</option>
				<option value="1"<%= ((memTenVO == null) ? "" : (memTenVO.getMem_gender() == 1 ? "selected" : ""))%>>�k</option>		
			</select>
		</td>
	</tr>
	<tr>
		<td>�����Ҧr��:</td>
		<td><input type="TEXT" name="mem_id" size="45"
			 value="<%= (memTenVO==null)? "A192685483" : memTenVO.getMem_id()%>" /></td>
	</tr>
	<tr>
		<td>�X�ͦ~���:</td>
		<td><input name="mem_birthday" id="birthday_date" type="text"></td>
	</tr>
	<tr>
		<td>�s���q��:</td>
		<td><input type="TEXT" name="mem_phone" size="45"
			 value="<%= (memTenVO==null)? "0225024654" : memTenVO.getMem_phone()%>" /></td>
	</tr>
	<tr>
		<td>��ʹq��:</td>
		<td><input type="TEXT" name="mem_mobile" size="45"
			 value="<%= (memTenVO==null)? "0955162239" : memTenVO.getMem_mobile()%>" /></td>
	</tr>
	<tr>
		<td>�q�l�H�c:</td>
		<td><input type="TEXT" name="mem_email" size="45"
			 value="<%= (memTenVO==null)? "peterwu1@gmail.com" : memTenVO.getMem_email()%>" /></td>
	</tr>
	<tr>
		<td>�a�}:</td>
		<td><input type="TEXT" name="mem_addr" size="45"
			 value="<%= (memTenVO==null)? "�x�_�����s�ϥ��ͪF���T�q67��" : memTenVO.getMem_addr()%>" /></td>
	</tr>
	

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>

<!-- �W�ǹϤ��i�w�� -->
<script>
function init() {

    let myFile = document.getElementById("mem_pic");
    let preview = document.getElementById("preview");

    myFile.addEventListener('change', function(e) {
        // ���o�ɮת��󪺨�ؤ覡
        // 1. �����qmyFile����W���o�ɮת��� (�]���D�P�B�A�@�ˡA�h��classname���U�ɷ|�����D)
        // 2. �qevent���󤤨��o�L��soure target�A�]�N�OmyFile����A�A���o�ɮת��� 
        // �ɮת��򥻸�T�A�]�A�G�ɮת��W�١B�j�p�P��󫬺A
        let files = e.target.files;
        // �P�_files����O�_�s�b
        if (files !== null) {
            // ���Xfiles���󪺲Ĥ@��
            let file = files[0];
            // �P�_file.type�����O�O�_�]�t'image'
            if (file.type.indexOf('image') > -1) {
                // new a FileReader
                let reader = new FileReader();
                // �bFileReader����W���Uload�ƥ� - ���J�ɮת��N��
                reader.addEventListener('load', function(e) {
                    // ���o���G ���ܡG�qe.target.result���oŪ���쵲�G
                    let result = e.target.result;
                    // console.log(result) �T�{Ū���쵲�G
                    // �s�Wimg����
                    let img = document.createElement('img');
                    // �ᤩsrc�ݩ�
                    img.src = result;
                    // ���div�̭�
                    preview.append(img);
                });
                // �ϥ�FileReader����W�� readAsDataURL(file) ����k�A�ǤJ�nŪ�����ɮסA�ö}�l�i��Ū��
                reader.readAsDataURL(file); // trigger!!!!
            } else {
                // �u�Xĵ�i���� alert('�ФW�ǹϤ��I');
                alert('�ФW�ǹϤ��I');
            }
        }
    });
}

window.onload = init;
</script>

</body>


<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

<%
	java.sql.Date mem_birthday = null;
	try {
		mem_birthday = memTenVO.getMem_birthday();
 	} catch (Exception e) {
		mem_birthday = new java.sql.Date(System.currentTimeMillis());
 	}
%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#birthday_date').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=mem_birthday%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        
        
   
        // ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

        //      1.�H�U���Y�@�Ѥ��e������L�k���
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.�H�U���Y�@�Ѥ��᪺����L�k���
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.�H�U����Ӥ�����~������L�k��� (�]�i���ݭn������L���)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>
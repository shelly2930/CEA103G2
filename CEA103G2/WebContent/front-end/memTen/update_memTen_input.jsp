<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memTen.model.*"%>

<%
	MemTenVO memTenVO = (MemTenVO) request.getAttribute("memTenVO"); //EmpServlet.java (Concroller) �s�Jreq��memTenVO���� (�]�A�������X��memTenVO, �]�]�A��J��ƿ��~�ɪ�memTenVO����)
%>

<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/nice-select.css">

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�A�[ -->
	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- Required source end -->

<script src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.1/dist/tw-city-selector.min.js"></script>

<!-- �a�}�s�ʿ�� -->
<script>
new TwCitySelector({
    el: '.city-selector-set-has-value',
    elCounty: '.county',
    elDistrict: '.district',
    bootstrapStyle: true
  });	
</script>

<title></title>

<style>
body { 
background-color: #dddddd !important;
}

img.mem_pic {
  	height: 200px;
  	width: auto;
  }
</style>

</head>
<body>



<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>

<!--================ Content Area start =================-->
<section class="cat_product_area section_padding">
	<div class="container">
		<div class="row">
            <!--================ Sidebar =================-->    
			<%@include file="/front-end/sidebarFront.file"%>
                
            <div class="col-lg-10 content">
                
                <!--================ ���n���ܦۤv�R�� =================-->
                <div class="pagetitle">�|����Ƭd�ݻP�ק�</div>
				
				<!--�@�@�@�����������������������e���������������������@�@�@-->
					<%-- ���~��C --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color:red">�Эץ��H�U���~:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color:red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>
					
					
					<FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" name="form1">
					<table class="table">
					  <tbody>
					  	<tr>
					    	<th>�|���s��</th>
					    	<td><%=memTenVO.getMem_no()%></td>
					    </tr>
					    <tr>
					    	<th>�b��</th>
					    	<td><%=memTenVO.getMem_username()%></td>
					    </tr>
					    <tr>
					    	<th>�K�X</th>
					    	<td>
					    		<input type="text" name="mem_password" placeholder="password" required class="single-input" value="<%=memTenVO.getMem_password()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>�Ӥ�</th>
					    	<td>
					    		<div id="previewp"></div>
					    		<img id="imgp"  src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?action=getmempic&mem_no=${memTenVO.mem_no}"  class="mem_pic">
					    		<input type="file" name="mem_pic" id="mempic" size="45">
					    	</td>
					    </tr>
					    <tr>
					    	<th>�m�W</th>
							<td>
								<input type="text" name="mem_name" placeholder="name" required class="single-input" value="<%=memTenVO.getMem_name()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>�ʧO</th>
							<td>
								<select size="1" name="mem_gender" >
           							<option value="0" <%=memTenVO.getMem_gender() == 0 ? "selected" : ""%>>�k</option>
           							<option value="1" <%=memTenVO.getMem_gender() == 1 ? "selected" : ""%>>�k</option>     
       							</select>
        					</td>
					    </tr>
					    <tr>
					    	<th>�����Ҧr��</th>
							<td>
								<input type="text" name="mem_id" placeholder="id" required class="single-input" value="<%=memTenVO.getMem_id()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>�X�ͦ~���</th>
							<td>
								<input type="text" name="mem_birthday" id="birthday_date" placeholder="birthday" required class="single-input" value="${MemTenVO.mem_birthday}">
							</td>
					    </tr>
					    <tr>
					    	<th>�s���q��</th>
							<td>
								<input type="text" name="mem_phone" placeholder="phone" class="single-input" value="<%=memTenVO.getMem_phone()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>��ʹq��</th>
							<td>
								<input type="text" name="mem_mobile" placeholder="mobile" required class="single-input" value="<%=memTenVO.getMem_mobile()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>�q�l�H�c</th>
							<td>
								<input type="text" name="mem_email" placeholder="email" required class="single-input" value="<%=memTenVO.getMem_email()%>">
							</td>
					    </tr>
					    <tr>
					    	<th>����</th>
							<td>
							<div class="city-selector-set-has-value">
							  <div>
							    <!-- ������� -->
							    <select class="county" data-value="<%=memTenVO.getMem_city()%>"></select>
							  </div>
							  <div>
							    <!-- �ϰ��� -->
							    <select class="district" data-value="<%=memTenVO.getMem_addr()%>"></select>
							  </div>
							</div>
							</td>
					    </tr>
					    <tr>
					    	<th>�a�}</th>
							<td>
								<div role="tw-city-selector" data-has-zipcode data-hidden-zipcode data-county-value="<%=memTenVO.getMem_city()%>"
						     			data-district-value="<%=memTenVO.getMem_dist()%>"></div>
								<input type="TEXT" name="mem_addr" class="single-input" value="<%=memTenVO.getMem_addr()%>"/>
							</td>
					    </tr>
					    <tr>
					    	<th>�����ҥ���</th>
					    	<td>
					    		<div id="previewf"></div>
					    		<img id="imgf"  src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?action=getidcardf&mem_no=${memTenVO.mem_no}"  class="mem_pic">
					    		<input type="file" name="mem_idcard_f" id="idcardf" size="45">
					    	</td>
					    </tr>
					    <tr>
					    	<th>�����ҭI��</th>
					    	<td>
					    		<div id="previewr"></div>
					    		<img id="imgr" src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?action=getidcardr&mem_no=${memTenVO.mem_no}"  class="mem_pic">
					    		<input type="file" name="mem_idcard_r" id="idcardr" size="45">
					    	</td>
					    </tr>
					    <tr>
							<th>�ק�</th>
							<td>
								<input type="hidden" name="action" value="update">
								<input type="hidden" name="mem_no" value="<%=memTenVO.getMem_no()%>">
								<input type="submit" value="�e�X�ק�">
							</td>
						</tr>
					  </tbody>
					</table>
					</FORM>

				<!--�@�@�@�����������������������e���������������������@�@�@-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

<!-- �W�ǹϤ��i�w�� -->
<script>
window.onload=function(){

	let myFile = document.getElementById("mempic");
    let preview = document.getElementById("previewp");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgp');
                    img.src = result;
                    preview.append(img);
                    $("imgp:first").remove(); // �w���u�|�O�d�̷s�W�Ǫ�
                });
                reader.readAsDataURL(file);
            } else {
                alert('�ФW�ǹϤ��I');
            }
        }
    });
	
	
    let myFilef = document.getElementById("idcardf");
    let previewf = document.getElementById("previewf");

    myFilef.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgf');
                    img.src = result;
                    previewf.append(img);
                    $("imgf:first").remove(); // �w���u�|�O�d�̷s�W�Ǫ�
                });
                reader.readAsDataURL(file);
            } else {
                alert('�ФW�ǹϤ��I');
            }
        }
    });
    
    let myFiler = document.getElementById("idcardr");
    let previewr = document.getElementById("previewr");

    myFiler.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgr');
                    img.src = result;
                    previewr.append(img);
                    $("imgr:first").remove(); // �w���u�|�O�d�̷s�W�Ǫ�
                });
                reader.readAsDataURL(file);
            } else {
                alert('�ФW�ǹϤ��I');
            }
        }
    });
}

</script>

</body>

<%
	java.sql.Date mem_birthday = null;
	try {
		mem_birthday = memTenVO.getMem_birthday();
 	} catch (Exception e) {
		mem_birthday = new java.sql.Date(System.currentTimeMillis());
 	}
%>

<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

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
 		   value: '<%=memTenVO.getMem_birthday()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        
</script>


<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
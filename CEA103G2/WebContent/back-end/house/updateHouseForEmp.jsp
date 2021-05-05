<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="BIG5">
<title>�D�ޫ�������</title>

<!-- =================�M��bootstrap�n�ϥΥH�U=========================== -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
<!-- =================�M��bootstrap�n�ϥΥH�U=========================== -->
<!-- =================�M�Υx�W�����m��n�ϥΥH�U=========================== -->
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<!-- =================�M�Υx�W�����m��n�ϥΥH�W=========================== -->
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
</style>

</head>
<body>
<!-- ===================================��ONAV -->
	<nav class="navbar navbar-expand-lg navbar-lightblue bg-dark">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/back-end/indexBack.jsp"> <img src="${pageContext.request.contextPath}/index_img/home01.png"
			width="30" height="30" alt="">
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarTogglerDemo03"
			aria-controls="navbarTogglerDemo03" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<a class="navbar-brand" href="${pageContext.request.contextPath}/back-end/indexBack.jsp">HowTrue��x�޲z</a>
		<div class="collapse navbar-collapse " id="navbarTogglerDemo03">
			<ul class="navbar-nav  mr-auto mt-2 mt-lg-0">
				<li class="nav-item bg-dark  active dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> ����޲z </a>
					<div class="dropdown-menu   bg-dark" aria-labelledby="navbarDropdown">
						<a class="dropdown-item bg-dark" href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend"><p style="color:lightblue">�������u</p></a> 
						<a class="dropdown-item bg-dark" href="<%=request.getContextPath()%>/house/house.do?action=listAllHouse_Backend_Emp&hos_state=0&hos_status=0"><p style="color:lightblue"> �ӽгB�z</p></a>
						</li>
				<li class="nav-item bg-dark "><a class="nav-link disabled" href="#" aria-disabled="true">�a��޲z</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Action</a> <a
							class="dropdown-item" href="#">Another action</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
					</div></li>
				<li class="nav-item bg-dark"><a class="nav-link disabled"
					href="#" tabindex="-1" aria-disabled="true">���u��ƺ޲z</a></li>
				<li class="nav-item bg-dark"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp"
					tabindex="-1" aria-disabled="true">�e�O�ǰe��</a></li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
<!-- ===================================��ONAV -->
<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/house/house.do"
		enctype="multipart/form-data" name="form1">
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">�ЪF�m�W</span>
  			</div>
  			<span>${houseVO.lld_no}</span>
  			
  					
		</div>
		
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">����W��</span>
  			</div>
  				<input type="text" name="hos_name" 
  					value="${(houseVO == null)?'���Ŧ�v':houseVO.hos_name}" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>
		
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">���󯲪�</span>
  			</div>
  				<input type="text" name="hos_rent" 
  					value="${(houseVO == null) ?'9500': houseVO.hos_rent}" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>
		
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">�����m��</span>
  			</div>
  			<div id="twzipcode"></div>
		</div>
		
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">�a�}</span>
  			</div>
  				<input type="text" name="hos_address" 
  					value="${(houseVO == null) ? '��饫���c�ϴ_����46��' : houseVO.hos_address}" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>

		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">�Ы�</span>
  			</div>
  				<select size="1" name="hos_type">
						<option value="0" ${(houseVO.hos_type=="0")? 'selected':''}>����
						<option value="1" ${(houseVO.hos_type=="1")? 'selected':''}>�W�߮M��
						<option value="2" ${(houseVO.hos_type=="2")? 'selected':''}>�����M��
						<option value="3" ${(houseVO.hos_type=="3")? 'selected':''}>����
						<option value="4" ${(houseVO.hos_type=="4")? 'selected':''}>��h��a
						<option value="5" ${(houseVO.hos_type=="5")? 'selected':''}>����
						<option value="6" ${(houseVO.hos_type=="6")? 'selected':''}>��L
				</select>
		</div>
				
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">����</span>
  			</div>
  				<input type="textarea" name="hos_info" 
  					value="${(houseVO == null) ? '���R�B��CP�B�A�����ο��' : houseVO.hos_info}" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>			
			
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">����</span>
  			</div>
  				<input type="text" name="hos_age" 
  					value="${(houseVO == null) ? '25' : houseVO.hos_age}" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>
			
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">�Ӽh��</span>
  			</div>
  				<input type="text" name="hos_floor" 
  					value="${(houseVO == null) ? '7' : houseVO.hos_floor}" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>

		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">���ѪA��</span>
  			</div>
  				<input type="checkbox" id="hos_ele" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_ele == "1")?'checked':''} />
				<label for="hos_ele">�q��</label>
				<input type="checkbox" id="hos_parking" name="hos_check" value="hos_parking" size="45" ${(houseVO.hos_parking == "1")?'checked':''} />
				<label for="hos_parking">������</label>
				<input type="checkbox" id="hos_pet" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_pet == "1")?'checked':''} /> 
				<label for="hos_pet">�i�i�d��</label>
				<input type="checkbox" id="hos_cook" name="hos_check" value="hos_cook" size="45" ${(houseVO.hos_cook == "1")?'checked':''} />
				<label for="hos_cook">�i�}��</label>
		</div>

			
	
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">�W��</span>
  			</div>
  				<input type="text" name="hos_squares" 
  					value="${(houseVO == null) ? '9' : houseVO.hos_squares}" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>	
		
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">�ʧO</span>
  			</div>
  				<select size="1" name="hos_gender">
						<option value="0" ${(houseVO.hos_gender=="0")? 'selected':''}>����
						<option value="1" ${(houseVO.hos_gender=="1")? 'selected':''}>�k
						<option value="2" ${(houseVO.hos_gender=="2")? 'selected':''}>�k
				</select>
		</div>
					
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">���O/�@��</span>
  			</div>
  				<input type="text" name="hos_water" 
  					value="${(houseVO == null) ? '9' : houseVO.hos_water}" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>	
		
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">�q�O/�@��</span>
  			</div>
  				<input type="text" name="hos_power" 
  					value="${(houseVO == null) ? '2' : houseVO.hos_power}" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>	
	
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">�����O</span>
  			</div>
  				<input type="text" name="hos_internet" 
  					value="${(houseVO == null) ? '600' : houseVO.hos_internet}" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>	
		
		<div class="input-group input-group-sm mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">�W�ǩҦ��v��</span>
  			</div>
  				<input type="file" name="hos_loc_pic" 
  					id="load"  
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
		</div>
			
	


<!-- �o�̱q��Ʈw�Atable(���]�a��)���X��ơA���ЪF���ΡA�񧹭n�s�A�n�s��table(������]�a��) -->
<!-- 			<tr> -->
<!-- 			<td>����w�����a��:</td> -->
<!-- 			<td> -->
<!-- <!-- 			addFurVO_list�O�qaction = GoToInsert ���X-->
<%-- 			<c:forEach var="addFurVO" varStatus="count" items="${addFurVO_list}"> --%>
<%-- 				<input id="${count.index}" type="checkbox" name="addfur_check" value="${addFurVO.add_fnt_no}"  --%>
<%-- 				 ${add_fnt_no_list.contains(addFurVO.add_fnt_no)?'checked':''} size="45" /> --%>
<%-- 				 <label for="${count.index}">${addFurVO.add_fnt_name}</label> --%>
<%-- 			</c:forEach>  --%>
<!-- 			</td> -->
<!-- 			</tr>  -->
<!-- �H�W�q��Ʈw�Atable(���]�a��)���X��ơA���ЪF���ΡA�񧹭n�s�A�n�s��table(������]�a��) -->	
<p>�Ƶ�: 1.�ӽжi�� �n�令1</p>
		<br> 
		<input type="hidden" name="houseno" value="${houseVO.hos_no}">
		<input type="hidden" name="action" value="updateHouseForEmp">
		<input type="hidden" name="requestURL"	value="${param.requestURL}">
		<input type="submit" value="�e�X�s�W">
	</FORM>
<!-- 	================= -->
<!-- �ѦҺ��� https://www.wfublog.com/2017/10/taiwan-county-town-zip-address-twzipcode-jquery.html -->
	<script>
	$("#twzipcode").twzipcode({
        countySel: '${houseVO.hos_city}', // �����w�]��, �r��@�w�n���c�骺 "�O", �_�h�줣����
        districtSel: '${houseVO.hos_dist}', // �a�Ϲw�]��
        zipcodeIntoDistrict: true, // �l���ϸ��۰���ܦb�a��
        css: ["city form-control", "town form-control"], // �ۭq "����"�B"�a��" class �W��
        countyName: "hos_city", // �ۭq���� select ���Ҫ� name ��
        districtName: "hos_dist" // �ۭq�a�� select ���Ҫ� name ��
    });
	</script>
<!-- ====�H�W�s�W�����ưe�X=== -->
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->
<!-- =====================�U����input�ɶ��~��============================= -->
<!-- ########    �ӥB�`�N����Ctrl+shift+F�۰ʱƪ� �|�o�Ϳ��~!!!!!     ########### -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '', // value:   new Date(),
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
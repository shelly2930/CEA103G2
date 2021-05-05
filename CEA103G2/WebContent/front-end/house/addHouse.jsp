<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.house.model.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%
	HouseVO houseVO = (HouseVO) request.getAttribute("houseVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>�ЪF�s�W���󭶭�</title>


<!-- =================�M�Υx�W�����m��n�ϥΥH�U=========================== -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<!-- ���ޥ�jquery(�Ѯv�w�g�t��jquery)�A�ޥ�twzipcode -->
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<!-- =================�M�Υx�W�����m��n�ϥΥH�W=========================== -->

</head>


<!-- =================================�U���O�����C==================================================== --> 
<%@include file="/front-end/header.jsp"%>
<!-- =================================�W���O�����C==================================================== --> 


<!--================Home Banner Area =================-->
  <!-- breadcrumb start-->
  <section class="breadcrumb breadcrumb_bg">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="breadcrumb_iner">
            <div class="breadcrumb_iner_item">
              <h2>�ЪF�ӽХN��</h2>
              <p>HowTrue <span>-</span> �n ��</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- breadcrumb start-->

  <!--================Checkout Area =================-->
  <section class="checkout_area padding_top">
    <div class="container">
      <div class="returning_customer">
        <div class="check_title">
        <h1>�A�ȥN��-�ӽЪ�</h1>
          <h2>
            	 �ж�g�����ު��󤺮e!
          </h2>
        </div>
        <p>
          	�ڭ̱N�b�̵u�ɶ������z�A��
        </p>
      </div>
      <div class="billing_details">
        <div class="row">
          <div class="col-lg-8">
            <h3>���� �ԲӸ��
             <c:if test="${not empty errorMsgs}">
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<p style="color: red"> ${message}</p>
				</c:forEach>
			</ul>
			</c:if> 
            </h3>
            <form class="row contact_form" action="<%=request.getContextPath()%>/house/house.do" method="post" novalidate="novalidate" enctype="multipart/form-data" name="form1">
              <div class="col-md-6 check_title"><h2>�ЪF�s��</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="lld_no" value="<%=(houseVO == null) ? "5" : houseVO.getLld_no()%>"/>
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>����W��</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_name" 
                value="<%=(houseVO == null) ? "���Ŧ�v" : houseVO.getHos_name()%>"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>���󯲪�</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control"  name="hos_rent" 
                value="<%=(houseVO == null) ? "9500" : houseVO.getHos_rent()%>"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>�����m��</h2></div>
              <div class="col-md-6 form-group">
              <div id="twzipcode"></div>
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title"><h2>����a�}</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_address" 
                value="<%=(houseVO == null) ? "��饫���c�ϴ_����46��" : houseVO.getHos_address()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>��������</h2></div>
			  <div class="col-md-12 form-group">
              	<select name="hos_type">
                  <option value="0" ${(houseVO.hos_type=="0")? 'selected':''}>����
						<option value="1" ${(houseVO.hos_type=="1")? 'selected':''}>�W�߮M��
						<option value="2" ${(houseVO.hos_type=="2")? 'selected':''}>�����M��
						<option value="3" ${(houseVO.hos_type=="3")? 'selected':''}>����
						<option value="4" ${(houseVO.hos_type=="4")? 'selected':''}>��h��a
						<option value="5" ${(houseVO.hos_type=="5")? 'selected':''}>����
						<option value="6" ${(houseVO.hos_type=="6")? 'selected':''}>��L
                </select>
               </div>
              
              
              <div class="col-md-6 check_title"><h2>���󤶲�</h2></div>
              <div class="col-md-6 form-group">
                <input type="textarea" class="form-control" name="hos_info"
                value="<%=(houseVO == null) ? "���R�B��CP�B�A�����ο��" : houseVO.getHos_info()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              
               <div class="col-md-6 check_title"><h2>�������</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_age" 
                value="<%=(houseVO == null) ? "25" : houseVO.getHos_age()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title"><h2>�Ҧb�Ӽh</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_floor" 
                value="<%=(houseVO == null) ? "7" : houseVO.getHos_floor()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              
              <div class="col-md-6 check_title"><h2>���ѪA��</h2></div>
              <div class="col-md-6 form-group">
                <input type="checkbox" id="hos_ele" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_ele == "1")?'checked':''} />
					<label for="hos_ele">�q��</label>
					<input type="checkbox" id="hos_parking" name="hos_check" value="hos_parking" size="45" ${(houseVO.hos_parking == "1")?'checked':''} />
					<label for="hos_parking">������</label>
					<input type="checkbox" id="hos_pet" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_pet == "1")?'checked':''} /> 
					<label for="hos_pet">�i�i�d��</label>
					<input type="checkbox" id="hos_cook" name="hos_check" value="hos_cook" size="45" ${(houseVO.hos_cook == "1")?'checked':''} />
					<label for="hos_cook">�i�}��</label>
              </div>
              
              <div class="col-md-6 check_title"><h2>����W��</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_floor" 
                value="<%=(houseVO == null) ? "7" : houseVO.getHos_floor()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title"><h2>�Ҧb�Ӽh</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_squares" 
  					value="<%=(houseVO == null) ? "9" : houseVO.getHos_squares()%>" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title"><h2>����ʧO</h2></div>
              <div class="col-md-6 form-group">
                <select size="1" name="hos_gender">
						<option value="0" ${(houseVO.hos_gender=="0")? 'selected':''}>����
						<option value="1" ${(houseVO.hos_gender=="1")? 'selected':''}>�k
						<option value="2" ${(houseVO.hos_gender=="2")? 'selected':''}>�k
				</select>
              </div>
              
              <div class="col-md-6 check_title"><h2>���O/�@��</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_water" 
  					value="<%=(houseVO == null) ? "9" : houseVO.getHos_water()%>"  
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>�q�O/�@��</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_power" 
  					value="<%=(houseVO == null) ? "2" : houseVO.getHos_power()%>"
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title"><h2>�����O</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_internet" 
  					value="<%=(houseVO == null) ? "600" : houseVO.getHos_internet()%>"
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
               <div class="col-md-6 check_title"><h2>�w���ɶ�</h2></div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_order_date" id="f_date1"
  					value="<%=(houseVO == null) ? "600" : houseVO.getHos_order_date()%>"
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
          	<div class="col-md-6 check_title"><h2>�W�ǩҦ��v��</h2></div>
              <div class="col-md-6 form-group">
                <input type="file" name="hos_loc_pic" 
  					id="load"  
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
              </div>
          </div>
          <div class="col-lg-4">
            <div class="order_box">
              <h2>�ӽЪ�����-�T�{</h2>
              <ul class="list">
                <li>
                  <a>���� ����
                    <span id="hos_rent">${empty houseVO.hos_rent?'����':'$'+=houseVO.hos_rent}</span>
                  </a>
                </li>
                <li>
                  <a>���O/�@��
                    <span id="hos_water">${empty houseVO.hos_rent?'����':'$'+=houseVO.hos_water}</span>
                  </a>
                </li>
                <li>
                  <a>�q�O/�@��
                    <span id="hos_power">${empty houseVO.hos_rent?'����':'$'+=houseVO.hos_power}</span>
                  </a>
                </li>
                <li>
                  <a>�����O
                    <span id="hos_internet">${empty houseVO.hos_rent?'����':'$'+=houseVO.hos_internet}</span>
                  </a>
                </li>
              </ul>
              <ul class="list list_2">
                <li>
                  <a>�w���ɶ�
                    <span id="hos_order_date">${empty houseVO.hos_order_date?'����':'needFormat'}</span>
                  </a>
                </li>
              </ul>
              <ul class="list list_2">
                <li>
                  <a>�a�}
                    <span id="hos_address">${empty houseVO.hos_address?'����':houseVO.hos_address}</span>
                  </a>
                </li>
              </ul>
              <div class="creat_account">
                <label for="f-option3">���±z���e�U</label>
                <a >�ڭ̷|�ɳt�B�z�A�óq���z</a>
              </div>
              <input  type="hidden" name="action" value="insert">
       			<input class="btn_3" type="submit" value="�e�X�s�W">
            </div>
          </div>
        </div>
		</FORM> 
      </div>
  </section>

<!-- 	================= -->
<!-- �ѦҺ��� https://www.wfublog.com/2017/10/taiwan-county-town-zip-address-twzipcode-jquery.html -->
	<script>
	$("#twzipcode").twzipcode({
        countySel: "${houseVO.hos_city}", // �����w�]��, �r��@�w�n���c�骺 "�O", �_�h�줣����
        districtSel: '${houseVO.hos_dist}', // �a�Ϲw�]��
        zipcodeIntoDistrict: true, // �l���ϸ��۰���ܦb�a��
        css: ["city form-control", "town form-control"], // �ۭq "����"�B"�a��" class �W��
        countyName: "hos_city", // �ۭq���� select ���Ҫ� name ��
        districtName: "hos_dist" // �ۭq�a�� select ���Ҫ� name ��
    });
	

	$(document).ready(function(){//�T�{�ɶ��A�ɶ��榡��
         if($("#hos_order_date").html()=="needFormat"){
            let date = new Date('${houseVO.hos_order_date}');
            let dateFormat = date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate()+' '+(date.getHours())+':'+date.getMinutes();
            $("#hos_order_date").html(dateFormat);
           }
    })
	
	$(function(){
		$("input[name='hos_rent']").change(function(){
			let rent = $("input[name='hos_rent']").val();
			$("#hos_rent").html('$ '+rent);
		})
		$("input[name='hos_water']").change(function(){
			let water = $("input[name='hos_water']").val();
			$("#hos_water").html('$ '+water);
		})
		$("input[name='hos_power']").change(function(){
			let power = $("input[name='hos_power']").val();
			$("#hos_power").html('$ '+power);
		})
		$("input[name='hos_internet']").change(function(){
			let internet = $("input[name='hos_internet']").val();
			$("#hos_internet").html('$ '+internet);
		})
		$("input[name='hos_order_date']").change(function(e){
			let date = $("input[name='hos_order_date']").val();
			$("#hos_order_date").html(date);
			e.stopPropagation();
		})
		$("input[name='hos_address']").change(function(e){
			let date = $("input[name='hos_address']").val();
			$("#hos_address").html(date);
			e.stopPropagation();
		})
	})
	let x = null;
	let z = null;
	let y = null;
	let today = null
	$(function(){
		x = new Date().getMonth()+1;
		z = new Date().getFullYear();
		y = new Date().getDate();
		today = z+'/'+x+'/'+y;//��datetimepicker��
	})
	$.datetimepicker.setLocale('zh');
    $('#f_date1').datetimepicker({
       theme: '',              //theme: 'dark',
       timepicker:true,       //timepicker:true,
       step: 60,                //step: 60 (�o�Otimepicker���w�]���j60����)
       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
	   value: new Date(), // value:   new Date(),
       //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
       startDate:	            '2021/04/30',  // �_�l��
       minDate:               	-today, // �h������(���t)���e
       //maxDate:               '+1970-01-01'  // �h������(���t)����
    });
	</script>
<!-- ====�H�W�s�W�����ưe�X=== -->

</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->
<!-- =====================�U����input�ɶ��~��============================= -->
<!-- ########    �ӥB�`�N����Ctrl+shift+F�۰ʱƪ� �|�o�Ϳ��~!!!!!     ########### -->
<%
	java.sql.Timestamp hos_order_date = null;
	try {
		hos_order_date = houseVO.getHos_order_date();
	} catch (Exception e) {
		hos_order_date = new java.sql.Timestamp(System.currentTimeMillis());
	}
%>



<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
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

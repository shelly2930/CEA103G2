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

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!-- =================�M�Υx�W�����m��n�ϥΥH�W=========================== -->
<style>
.breadcrumb_bg {
    background-image:url('<%=request.getContextPath()%>/front-end/house/image/decoration.jpg') !important;
    background-position: center;
    background-repeat: no-repeat  !important;
    background-size: cover;
}

</style>
</head>


<!-- =================================�U���O�����C==================================================== --> 
<%@include file="/front-end/header.file"%>
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
  <section class="checkout_area padding_top" style='padding-top:50px'>
    <div class="container">
      <div class="returning_customer">
        <div class="check_title text-center"  >
        <h1 style='background-color:#BFFFBF;padding:5px'>�A�ȥN��-�ӽЪ�</h1>
          <h2 style='font-weight:bold;color:#787878'>
            	 �ж�g�����ު���򥻸�� !
          </h2>
        <p>
          	�ڭ̱N�b�̵u�ɶ������z�A��
        </p>
        </div>
      </div>
      <div class="billing_details">
        <div class="row">
          <div class="col-lg-8 " style='overflow-x:hidden;height:500px'>
             <c:if test="${not empty errorMsgs}">
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<p style="color: red"> ${message}</p>
				</c:forEach>
			</ul>
			</c:if> 
            <div>
            <form class="row contact_form" action="<%=request.getContextPath()%>/house/house.do" method="post" novalidate="novalidate" enctype="multipart/form-data" name="form1">
              <div class="col-md-6 check_title text-center" >
              	<h2 style='background-color:#DEFFDE;'>�ЪF�s��</h2>
              </div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="lld_no" value="<%=(houseVO == null) ? "5" : houseVO.getLld_no()%>"/>
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title text-center">
              	<h2 style='background-color:#DEFFDE;'>����W��</h2>
              </div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_name" 
                	value="<%=(houseVO == null) ? "���Ŧ�v" : houseVO.getHos_name()%>"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title text-center">
              	<h2 style='background-color:#DEFFDE;'>���󯲪�</h2>
              </div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control"  name="hos_rent" 
                value="<%=(houseVO == null) ? "9500" : houseVO.getHos_rent()%>"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title text-center">
              	<h2 style='background-color:#DEFFDE;'>�����m��</h2>
              </div>
              <div class="col-md-6 form-group">
              	<div id="twzipcode"></div>
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title text-center">
              	<h2 style='background-color:#DEFFDE;'>����a�}</h2>
              </div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_address" 
                value="<%=(houseVO == null) ? "��饫���c�ϴ_����46��" : houseVO.getHos_address()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title text-center">
              	<h2 style='background-color:#DEFFDE;'>��������</h2>
              </div>
			  <div class="col-md-6 form-group">
              	<select name="hos_type" class="form-control">
                  <option value="0" ${(houseVO.hos_type=="0")? 'selected':''}>����
						<option value="1" ${(houseVO.hos_type=="1")? 'selected':''}>�W�߮M��
						<option value="2" ${(houseVO.hos_type=="2")? 'selected':''}>�����M��
						<option value="3" ${(houseVO.hos_type=="3")? 'selected':''}>����
						<option value="4" ${(houseVO.hos_type=="4")? 'selected':''}>��h��a
						<option value="5" ${(houseVO.hos_type=="5")? 'selected':''}>����
						<option value="6" ${(houseVO.hos_type=="6")? 'selected':''}>��L
                </select>
               </div>
              
              
              <div class="col-md-6 check_title text-center">
              	<h2 style='background-color:#DEFFDE;'>���󤶲�</h2>
              </div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_info"
                value="<%=(houseVO == null) ? "���R�B��CP�B�A�����ο��" : houseVO.getHos_info()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              
              <div class="col-md-6 check_title text-center">
               	<h2 style='background-color:#DEFFDE;'>�������</h2>
               </div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_age" 
                value="<%=(houseVO == null) ? "25" : houseVO.getHos_age()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title text-center">
              	<h2 style='background-color:#DEFFDE;'>�Ҧb�Ӽh</h2>
              </div>
              <div class="col-md-6 form-group">
                <input type="text" class="form-control" name="hos_floor" 
                value="<%=(houseVO == null) ? "7" : houseVO.getHos_floor()%>" > 
                <span class="placeholder" ></span>
              </div>
              
              
              
              <div class="col-md-6 check_title text-center">
              	<h2 style='background-color:#DEFFDE;'>���ѪA��</h2>
              </div>
              <div class="col-md-6 form-group form-control">
                	<input type="checkbox"  id="hos_ele" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_ele == "1")?'checked':''} />
					<label for="hos_ele">�q��</label>
					<input type="checkbox" id="hos_parking" name="hos_check" value="hos_parking" size="45" ${(houseVO.hos_parking == "1")?'checked':''} />
					<label for="hos_parking">������</label>
					<input type="checkbox" id="hos_pet" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_pet == "1")?'checked':''} /> 
					<label for="hos_pet">�i�i�d��</label>
					<input type="checkbox" id="hos_cook" name="hos_check" value="hos_cook" size="45" ${(houseVO.hos_cook == "1")?'checked':''} />
					<label for="hos_cook">�i�}��</label>
              </div>
              
              
              <div class="col-md-6 check_title text-center">
              	<h2 style='background-color:#DEFFDE;'>����W��</h2>
              </div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_squares" 
  					value="<%=(houseVO == null) ? "9" : houseVO.getHos_squares()%>" 
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
              
              <div class="col-md-6 check_title text-center">
              <h2 style='background-color:#DEFFDE;'>����ʧO</h2>
              </div>
              <div class="col-md-6 form-group">
                <select size="1" name="hos_gender" class='form-control'>
						<option value="0" ${(houseVO.hos_gender=="0")? 'selected':''}>����
						<option value="1" ${(houseVO.hos_gender=="1")? 'selected':''}>�k
						<option value="2" ${(houseVO.hos_gender=="2")? 'selected':''}>�k
				</select>
              </div>
              
              <div class="col-md-6 check_title text-center">
             	 <h2 style='background-color:#DEFFDE;'>���O/�@��</h2>
              </div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_water" 
  					value="<%=(houseVO == null) ? "9" : houseVO.getHos_water()%>"  
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title text-center">
              <h2 style='background-color:#DEFFDE;'>�q�O/�@��</h2>
              </div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_power" 
  					value="<%=(houseVO == null) ? "2" : houseVO.getHos_power()%>"
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
              <div class="col-md-6 check_title text-center">
              <h2 style='background-color:#DEFFDE;'>�����O</h2>
              </div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_internet" 
  					value="<%=(houseVO == null) ? "600" : houseVO.getHos_internet()%>"
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
               <div class="col-md-6 check_title text-center">
               <h2 style='background-color:#DEFFDE;'>�w���ɶ�</h2>
               </div>
              <div class="col-md-6 form-group">
                <input type="text" name="hos_order_date" id="f_date1"
  					value="<%=(houseVO == null) ? "" : houseVO.getHos_order_date()%>"
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"> 
                <span class="placeholder" ></span>
              </div>
              
          	<div class="col-md-6 check_title text-center">
          	<h2 style='background-color:#DEFFDE;'>�Ҧ��v��</h2>
          	</div>
              <div class="col-md-6 form-group text-center">
              	<label for='load'>
              	<i class="fas fa-file-upload" style='color:#9C9C9C;font-size:20px'></i>
              	<span  style='color:#9C9C9C;font-size:20px;cursor:pointer'>�W�ǩҦ��v��</span>
                <input type="file" style='display:none' name="hos_loc_pic" 
  					id="load"  
  					class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
              	</label>
              </div>
          </div>
          </div>
          
          
          <div class="col-lg-4">
            <div class="order_box" style='background-color:#DEFFDE;'>
              <h2 >�ӽи�ƽT�{</h2>
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
                <label for="f-option3">�е��Գq��</label>
                <a >�ڭ̷|�ɳt�B�z�A�óq���z</a>
              </div>
              <input  type="hidden" name="action" value="insert">
       			<input class="btn_3" type="submit" value="�e�X�s�W">
            </div>
          </div>
        </div>
		</FORM> 
      </div>
      
      <div id='appendnotice' aria-live="polite" aria-atomic="true" style="position: fixed;z-index:9; top:12%; left: 84%;min-height: 200px;">
	    <div id='shownotice'>
		  <div class="toast" data-animation='true' data-delay='3000' style="position: relative; z-index:3;">
	    	<div class="toast-header">
		      <strong class="mr-auto">�q ��</strong>
		      <small class='noticetime'>11 mins ago</small>
		      <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
		        <span aria-hidden="true">&times;</span>
		      </button>
		    </div>
		    <div class="toast-body">
		      Hello, world! This is a toast message.
		    </div>
	    </div>
	  </div>
	</div>
      
  </section>
 	<script>
 	$("input[type='submit']").click(function(){
 		picktimeSuccess("�ЪF�ӽЬݫ�");
 	})
 	
	let mem_no = ${MemTenVO.mem_no};
	if(judge(mem_no)==0){
		Swal.fire({
	    	icon:'error',
	    	confirmButtonColor:'red',
	    	title:'�Х����U�����ЪF',
	    	text:'���z�ɦV�����ЪF'
	  	})
	  	setTimeout(function(){
	  		$(location).attr('href',"<%=request.getContextPath()%>/front-end/lanlord/addLanlord.jsp");
	  	},2000);
	}
	function judge(mem_no){
		let judge = 0;
		$.ajax({
			url:"<%=request.getContextPath()%>/HouseJsonServlet",
			type:'post',
			data:{
				action:'judgelld',
				'mem_no':mem_no
			},
			async:false,
			success:function(e){
				judge=e;
			}
		})
		return judge;
	}
	$("#twzipcode").twzipcode({
        countySel: "${houseVO.hos_city}", // �����w�]��, �r��@�w�n���c�骺 "�O", �_�h�줣����
        districtSel: '${houseVO.hos_dist}', // �a�Ϲw�]��
        zipcodeIntoDistrict: false, // �l���ϸ��۰���ܦb�a��
        css: ["city form-control", "town form-control"], // �ۭq "����"�B"�a��" class �W��
        countyName: "hos_city", // �ۭq���� select ���Ҫ� name ��
        districtName: "hos_dist", // �ۭq�a�� select ���Ҫ� name ��
        zipcodeIntoDistrict:true,	
    });
	$(".city").css('margin-top','2px');
	$(".town").css('margin-top','10px');
	$("#twzipcode").change(function(){
		let Str = $("select[name='hos_city']").val()+$("select[name='hos_dist']").val();
		$("input[name='hos_address']").val(Str);
		$("input[name='hos_address']").text(Str);
	})
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
	x = new Date(new Date().getTime()+(7*24*60*60*1000)).getMonth()+1;
	z = new Date(new Date().getTime()+(7*24*60*60*1000)).getFullYear();
	y = new Date(new Date().getTime()+(7*24*60*60*1000)).getDate();
	today = z+'-'+x+'-'+y;//��datetimepicker��
	$.datetimepicker.setLocale('zh');
    $('#f_date1').datetimepicker({
       theme: '',              //theme: 'dark',
       timepicker:true,       //timepicker:true,
       step: 60,                //step: 60 (�o�Otimepicker���w�]���j60����)
       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
	   value: today, // value:   new Date(),
       //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
       startDate:	            today,  // �_�l��
       minDate:               	today, // �h������(���t)���e
       //maxDate:               '+1970-01-01'  // �h������(���t)����
    });
   
    
	
	



<!-- 	================= -->
<!-- �ѦҺ��� https://www.wfublog.com/2017/10/taiwan-county-town-zip-address-twzipcode-jquery.html -->

<!-- ====�H�W�s�W�����ưe�X=== -->

	
	
		
	
	$(document).ready(function(){
		connectNotice();
	})
	//�ڬO�e�x�q��
	let webSocket_notice;	
	let MyPoint_notice = "/test/${MemTenVO.mem_no}/0";
	let endPointURL1 = "ws://" + window.location.host + (window.location.pathname).substring(0, (window.location.pathname).indexOf('/', 1))  + MyPoint_notice;
	function connectNotice() {
		webSocket_notice = new WebSocket(endPointURL1);
		webSocket_notice.onopen = function(event) {
			console.log("Connect Success!");
		};
		webSocket_notice.onmessage = function(event) {
			let initobj = {
				type:'open',
				identity:'0',
				username:'${MemTenVO.mem_no}',
				currentTime:new Date(),
				message:'',
			}
			webSocket_notice.send(JSON.stringify(initobj));
			let notice = JSON.parse(event.data);
			if(notice.type=="receive"){
				let revJSON = JSON.parse(notice.message);
				shownotice(revJSON);
				
			}
		};
		webSocket_notice.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	function disconnectNotice() {
		webSocket_notice.close();
	}
	function picktimeSuccess(message){
		let obj = {
				type:'send',
				identity:'0',
				username:'${MemTenVO.mem_no}',
				currentTime:new Date(),
				'message':JSON.stringify(message),
		}
		setTimeout(function(){
			webSocket_notice.send(JSON.stringify(obj));
			},1000
		)
	}
	function shownotice(mes){
		let a = $("#shownotice").clone();
		$("#appendnotice").append($(a));
		$(a).children().children().eq(0).children().eq(1).text(dateformat(new Date()));
		$(a).children().children().eq(1).text(mes);
		$(".toast").toast('show',8000);
	}
	
	function dateformat(str){
			 let year = new Date(str).getFullYear();
			 let month = new Date(str).getMonth()+1;
			 let date = new Date(str).getDate();
			 let hour = new Date(str).getHours();
			 let isAm = "�W��";
			 if((Math.floor(hour/12)==1)){
				 isAm = "�U��";
			 }
			 let minutes = new Date(str).getMinutes();
			 let second = new Date(str).getSeconds();
			 return year+"�~"+month+"��"+date+"��" +" "+isAm+hour+"��"
 	}
	
	</script>

</body>


<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->
<!-- =====================�U����input�ɶ��~��============================= -->
<!-- ########    �ӥB�`�N����Ctrl+shift+F�۰ʱƪ� �|�o�Ϳ��~!!!!!     ########### -->


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

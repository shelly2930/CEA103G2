<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<!-- Required source start -->
	<!-- jquery �o�榳�ݭn���H�A�[ -->
<%-- 	<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script> --%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/nice-select.css">
<script src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.1/dist/tw-city-selector.min.js"></script>
<!-- Required source end -->

<title>���Хӽ�</title>

<style>

.breadcrumb.breadcrumb_bg.rentalbaclground {
	margin-top:84px;
}

.breadcrumb_bg {
    background-image: url(/CEA103G2/front-end/memTen/images/home.jpg) !important;
}

.breadcrumb .breadcrumb_iner .breadcrumb_iner_item h2 {
    color: white !important;
    text-align: right !important;
}

.aaa {
    color: white !important;
    font-size:15px !important;
    text-align: right !important;
}

div.rentalstep {
	margin-top:20px;
}

.row {
	justify-content: center;
}

.datealert {
	font-size:16px;
	color:red;
}

.rentalalert {
	color:red;
}
</style>

</head>
<body>

<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>

<!-- �a�}�s�ʿ�� -->
<script>
	new TwCitySelector();	
</script>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<section class="breadcrumb breadcrumb_bg rentalbaclground">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>HowTrue</h2>
                            <h3 class="aaa">���Хӽ�</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</section>

<div class="container">
	<div class="row rentalstep">
        <FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" name="form1">
        <div class="step1">
        	<h3>��ܦX������</h3>
        	<table class="table">
				<tbody>
					<tr>
						<th>�X���_�l��</th>
							<td>
								<div class="datealert"><i class="fas fa-exclamation-circle"></i> �u���ܷ��_��14�ѫ�</div>
								<input class="single-input" name="rtct_eff_date" id="rtct_eff_date" type="text" required>
							</td>
					</tr>
					<tr>
						<th>�X���פ��</th>
							<td>
								<div class="datealert"><i class="fas fa-exclamation-circle"></i> �����̵u�@�Ӥ�</div>
								<input class="single-input" name="rtct_end_date" id="rtct_end_date" type="text" required>
							</td>
					</tr>
				</tbody>
			</table>	
        </div>
        
        <br>
        <h3>�ӽз|�����</h3>
        <h5 class="rentalalert"><i class="fas fa-exclamation-circle"></i> �ж�u����</h5>
        <div class="step2">
        	<table class="table">
				<tbody>
					<tr>
						<th>�m�W</th>
							<td>
								<input type="text" name="mem_name" placeholder="name" required class="single-input" value="${MemTenVO.mem_name}">
							</td>
					    </tr>
					    <tr>
					    	<th>�����Ҧr��</th>
							<td>
								<input type="text" name="mem_id" placeholder="id" required class="single-input" value="${MemTenVO.mem_id}">
							</td>
					    </tr>
					    <tr>
					    	<th>��ʹq��</th>
							<td>
								<input type="text" name="mem_mobile" placeholder="mobile" required class="single-input" value="${MemTenVO.mem_mobile}">
							</td>
					    </tr>
					    <tr>
					    	<th>�a�}</th>
							<td>
								<div role="tw-city-selector" data-has-zipcode data-hidden-zipcode data-bootstrap-style data-county-value="${MemTenVO.mem_city}"
						     			data-district-value="${MemTenVO.mem_dist}"></div>
								<input type="TEXT" name="mem_addr" class="single-input" value="${MemTenVO.mem_addr}"/>
							</td>
					    </tr>
					    <tr>
					    	<th>�����ҥ���</th>
					    	<td>
					    		<div id="previewf"></div>
					    		<img id="imgf"  src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?action=getidcardf&mem_no=${memTenVO.mem_no}"  class="mem_pic">
					    		<input type="file" name="mem_idcard_f" id="idcardf" size="45" required>
					    	</td>
					    </tr>
					    <tr>
					    	<th>�����ҭI��</th>
					    	<td>
					    		<div id="previewr"></div>
					    		<img id="imgr" src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?action=getidcardr&mem_no=${memTenVO.mem_no}"  class="mem_pic">
					    		<input type="file" name="mem_idcard_r" id="idcardr" size="45" required>
					    	</td>
					    </tr>
					    <tr>
					    	<th></th>
					    	<td>
					    		<input type="hidden" name="action" value="rentalConfirm">
								<input type="hidden" name="mem_no" value="${MemTenVO.mem_no}">
								<input type="hidden" name="hos_no" value="${houseVO.hos_no}">
								<input type="hidden" name="hos_rent" value="${houseVO.hos_rent}">
								<input type="submit" value="�e�X�ӽ�">
					    	</td>
					    </tr>
					</tbody>
				</table>
          	</div>
        </form>
    </div>
</div>


<!-- �W�ǹϤ��i�w�� -->
<script>
window.onload=function(){

    let myFile = document.getElementById("idcardf");
    let preview = document.getElementById("previewf");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgf');
                    img.src = result;
                    preview.append(img);
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
        var somedate1 = new Date();
        somedate1.setTime(somedate1.getTime()+24*60*60*14000);
        $('#rtct_eff_date').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
	       value: '${rtct_eff_date}',
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
            minDate:               somedate1, // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });

        $('#rtct_eff_date').change(function(){
        	let date =$(this).val();
        	let youwantdelayhowmanyday = 30;
        	let mindate = new Date(date).getTime()+(1000*60*60*24*youwantdelayhowmanyday);
        	$('#rtct_end_date').datetimepicker({minDate:new Date(mindate)});
        })

        $.datetimepicker.setLocale('zh');
        $('#rtct_end_date').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '${rtct_end_date}', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        	})
        
        
   
        // ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

        //      1.�H�U���Y�@�Ѥ��e������L�k���
//              var somedate1 = new Date();
//              somedate1.setTime(somedate1.getTime()+24*60*60*14000); 
//              $('#rtct_eff_date').datetimepicker({
//                  beforeShowDay: function(date) {
//                	  if (  date.getYear() <  somedate1.getYear() || 
//         		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
//         		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
//                      ) {
//                           return [false, ""]
//                      }
//                      return [true, ""];
//              }});

        
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


<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</body> 	
</html>
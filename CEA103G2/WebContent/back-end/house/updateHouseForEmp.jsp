<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>��x�ŭ�</title>

   <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
	 <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
	<script src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <%@include file="/back-end/includeFile/sidebarBack.file"%>

         <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

				<!-- Topbar -->
                <%@include file="/back-end/includeFile/topbarBack.file"%>

                <!--�@�@�@�����������������������e���������������������@�@�@-->
                <div class="container-fluid">
					<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/house/house.do"
							enctype="multipart/form-data" name="form1">
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">�ЪF�m�W</span>
					  			</div>
					  			<span class='form-control' style='background-color:#D6D6FF'id='lldname'> </span>
							</div>
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text" >�ЪF�p���覡</span>
					  			</div>
					  			<span class='form-control' style='background-color:#D6D6FF' id='lldphone'> </span>
							</div>
							<div class="input-group input-group-sm mb-3">
					  			<div class="input-group-prepend">
					    			<span class="input-group-text">�ӽХN�ޮɶ�</span>
					  			</div>
					  			<span class='form-control' style='background-color:#D6D6FF' id='apptime'> </span>
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
					  				<select class="form-control"  size="1" name="hos_type">
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
					  			<div class="form-control" >
					  				<input type="checkbox" id="hos_ele" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_ele == "1")?'checked':''} />
									<label for="hos_ele">�q��</label>
									<input type="checkbox" id="hos_parking" name="hos_check" value="hos_parking" size="45" ${(houseVO.hos_parking == "1")?'checked':''} />
									<label for="hos_parking">������</label>
									<input type="checkbox" id="hos_pet" name="hos_check" value="hos_ele" size="45" ${(houseVO.hos_pet == "1")?'checked':''} /> 
									<label for="hos_pet">�i�i�d��</label>
									<input type="checkbox" id="hos_cook" name="hos_check" value="hos_cook" size="45" ${(houseVO.hos_cook == "1")?'checked':''} />
									<label for="hos_cook">�i�}��</label>
					  			</div>
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
					  				<select class="form-control"  size="1" name="hos_gender">
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
							
							<br> 
							<input type="hidden" name="houseno" value="${houseVO.hos_no}">
							<input type="hidden" name="action" value="updateHouseForEmp">
							<input type="hidden" name="requestURL"	value="${param.requestURL}">
							<input class='btn btn-outline-success btn-sm' type="submit" value="��磌����">
						</FORM>
						
					<!-- Button trigger modal -->
					<!-- 	================= -->
					
					<!-- �ѦҺ��� https://www.wfublog.com/2017/10/taiwan-county-town-zip-address-twzipcode-jquery.html -->
						
					<!-- ====�H�W�s�W�����ưe�X=== -->
 			</div>
            <!-- End of Main Content -->
	
            <!-- Footer -->
            <%@include file="/back-end/includeFile/footerBack.file"%>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <%@include file="/back-end/includeFile/otherBack.file" %>
    
<!--     Bootstrap core JavaScript -->
   
    

<!--     Core plugin JavaScript -->


<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->
<!-- =====================�U����input�ɶ��~��============================= -->
<!-- ########    �ӥB�`�N����Ctrl+shift+F�۰ʱƪ� �|�o�Ϳ��~!!!!!     ########### -->
					<script>
						let lld_no = ${houseVO.lld_no};
						let num = getMem(getlld(lld_no).mem_no).mem_name;
						$("#lldname").text(getMem(getlld(lld_no).mem_no).mem_name);
						$("#lldphone").text(getMem(getlld(lld_no).mem_no).mem_mobile);
						let apptime = '${houseVO.hos_apptime}';
						$("#apptime").text(dateformat(apptime));
						function getlld(lld_no){
							let lldvo={}
							$.ajax({
								url:"<%=request.getContextPath()%>/HouseJsonServlet",
								type:'post',
								data:{
									action:'getLanlord',
									'lld_no':lld_no,
								},
								async:false,
								success:function(data){
									for(let key in data){
										lldvo[key]=data[key];
									}
								}
							})
							return lldvo;
						}

						function getMem(mem_no){
							let mem = {};
							$.ajax({
								url:'<%=request.getContextPath()%>/RenConCRUDServlet',
								type: 'post',
								data:{
									action:'getOneMemten',
									mem_no:mem_no,
								},
								async:false,
								success:function(memvo){
									for(let key in memvo){
										mem[key]=memvo[key];
									}
									console.log(memvo)
								}
							})
							return mem;
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
						$("#twzipcode").twzipcode({
					        countySel: '${houseVO.hos_city}', // �����w�]��, �r��@�w�n���c�骺 "�O", �_�h�줣����
					        districtSel: '${houseVO.hos_dist}', // �a�Ϲw�]��
					        zipcodeIntoDistrict: true, // �l���ϸ��۰���ܦb�a��
					        css: ["city form-control", "town form-control"], // �ۭq "����"�B"�a��" class �W��
					        countyName: "hos_city", // �ۭq���� select ���Ҫ� name ��
					        districtName: "hos_dist" // �ۭq�a�� select ���Ҫ� name ��
					    });
						$("#twzipcode").change(function(){
							let Str = $("select[name='hos_city']").val()+$("select[name='hos_dist']").val();
							$("input[name='hos_address']").val(Str);
							$("input[name='hos_address']").text(Str);
						})
						</script>	
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
</body>

</html>

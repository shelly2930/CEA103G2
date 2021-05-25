<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>����w���ɶ�</title>

</head>

<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- =================================�U���O�����C==================================================== --> 
<%@include file="/front-end/header.file"%>
<!-- =================================�W���O�����C==================================================== --> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<style>

.breadcrumb_bg {
    background-image: url(<%=request.getContextPath()%>/front-end/rooVieApp/images/hand01.jpg);
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}
</style>
<body onload="connect();" onunload="disconnect();disconnectNotice();">
<!-- ======�Ϥ� -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2> �w �� �� ��   Welcome</h2>
                            <h3> &nbsp;&nbsp;&nbsp; ${MemTenVO.mem_name} �A�n !</h3>
                            <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H o m e <span>-</span> V i e w i n g</h5>
                            <h5>�|��: ${MemTenVO.mem_no} <span>-</span>  ����A�n�w�����ɶ�</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
<!-- /****** CONTAINER *****/     -->
 	<section class="confirmation_part padding_top" style="padding-top:0px">
		<div class="container">
	            <div class="row">
					<div class="col-lg-12">
                        <div class="order_details_iner">
                            <h3>����A�n�w�������</h3>
                            <table  class="table table-striped table-bordered">
                                <thead>
                               		 <tr class="table-info">
                               		 	<th id="prev" class="text-center">&lt;&lt;</th>
                                        <th id="month" scope="col" colspan="5" class="text-center">���</th>
                                        <th id="next" class="text-center">&gt;&gt;</th>
                                    </tr>
                                    <tr class="table-info">
                                        <th class="text-center">�P����</th>
                                        <th class="text-center">�P���@</th>
                                        <th class="text-center">�P���G</th>
                                        <th class="text-center">�P���T</th>
                                        <th class="text-center">�P���|</th>
                                        <th class="text-center">�P����</th>
                                        <th class="text-center">�P����</th>
                                    </tr>
                                </thead>
                                <tbody>
                               		 <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th scope="col" colspan="7" class="text-center">Pick Date</th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
					</div>
				</div>
            </div>
    	</section>
<!-- /****** CONTAINER *****/     -->	


<!-- /****** CONTAINER *****/     -->


<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			 <div class="modal-header">
				 <div style="margin"><h5 class="modal-title " id="exampleModalLabel">����n�w�����ɬq</h5></div>
				   <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				      <span aria-hidden="true">&times;</span>
				   </button>
				</div>
					<div class="modal-body">
					 	<section class="confirmation_part padding_top" style="padding-top:0px">
							<div class="container">
					                        <div class="order_details_iner" style="margin-top:0px">
					                            <table  class="table table-borderless">
					                                <thead>
					                                    <tr class="table-info">
					                                        <th class="text-center" id="showdate"><span>�ɬq</span></th>
					                                        <th class="text-center"><span>�w��</span></th>
					                                    </tr>
					                                </thead>
					                                <tbody id="picktime">
					                               		 <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                     <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                     <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                </tbody>
					                                <tfoot>
					                                    <tr>
					                                        <th scope="col" colspan="2" class="text-center">${empty param.houseno}Pick Date</th>
					                                    </tr>
					                                </tfoot>
					                            </table>
					                        </div>
					            </div>
					    	</section>
		    				
				      </div>
				    </div>
				  </div>
				</div>
				<%@include file="/front-end/footer.file"%>
<!-- /****** CONTAINER *****/     -->	                       
		<script>

		//���W�@�Ӻ����Ǫ�querystring �ثe�u�ahouseno �Y�n�W�[�гB�z
		let queryString=location.search;
		let firstequalindex = queryString.indexOf("=");
		let houseno = queryString.substring(queryString.indexOf("=")+1);
		//�d�߳o����ثe�]�w�ɶ� //**
		let obj = getlistcontroltime(houseno);
		function getlistcontroltime(houseno){
			let obj = {};
			$.ajax({
		    	url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
		    	type:"post",
		    	data:{
		    		action:"listControlTime",
		    		identity:""+houseno,
		    	},
		    	async: false,//�o��?
		    	success:function(jsonobj){
		    		let empno = jsonobj.sneder;
		    		if(empno==undefined){
		    			empno='���]�w'
		    		}
		    		obj.empno = empno;
		    		let freeTimeToSee = jsonobj.freeTimeToSee;
		    		obj.freeTimeToSee=freeTimeToSee;
		    		let gotowork = jsonobj.gotowork;
		    		obj.gotowork = gotowork;
		    		let gooffwork = jsonobj.gooffwork;
		    		obj.gooffwork= gooffwork;
		    		//set
		    		let freedate = jsonobj.freedate;
		    		$("#roovieapp_title").text("�ثe ����s��: "+houseno+" �w�����p");
		    		let text = "<p> �t�d���u : "+empno+"</p>"+
		    		"<p> �ثe�]�w�{�b�ɶ� : "+freeTimeToSee+" �p�ɥH�ᤣ�i�H�w��</p>"+
		    		"<p> ���u�W�Z�ɶ� : "+gotowork+" �� - "+gooffwork+" ��</p>";
		    		for(let x in freedate){
		    			if(freedate[x]!==""){
		    				text+="<p>�w�g�w���ɶ� :"+freedate[x]+"</p>";
		    			}
		    		}
		    		$("#roovieapp_content").html(text);
		    		$("input[name='freeTimeToSee']").attr('value',freeTimeToSee);
		    		$("input[name='gotowork']").attr('value',gotowork);
		    		$("input[name='gooffwork']").attr('value',gooffwork);
		    	}
		    });
			return obj;
		}		
		
			
//���ͦ�
		
			let choose = new Date();
// 			���~
			let currentYear = choose.getFullYear();
// 			�o�Ӥ�
			let currentMonth = choose.getMonth()+1;
// 			����
			let currentDate = choose.getDate();
// 			�o�Ӥ�Ĥ@��
			let currentMonthFirstDay = new Date(""+currentYear+"-"+currentMonth+"-1").getDay();//0������P���� ��l1��§���@
// 			���~�o�Ӥ릳�X��
			let currentTotalDay = judgeDay(currentYear,currentMonth);
// 			count�γ~
			let week = 0;
			$("#prev").click(function(){
					freshPickDateTB();
					if(currentMonth==1){
						currentYear--;
						currentMonth=13;
					}
					currentMonth--;
					let d = ""+currentYear+"-"+currentMonth+"-1";
					currentMonthFirstDay = new Date(d).getDay();
					currentTotalDay = judgeDay(currentYear,currentMonth);
					
					$("#month").html("<span>"+currentYear+"�~"+currentMonth+"��</span>")
					for(let i = 1;i<=currentTotalDay;i++){
						let pickdate = currentYear+"-"+currentMonth+"-"+i;
						let compare = currentYear+"-"+currentMonth+"-"+(i+1);
						if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
							$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
						}
						$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
						$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
						currentMonthFirstDay = currentMonthFirstDay+1;
					}
			})
			$("#next").click(function(){
					freshPickDateTB();
					
					if(currentMonth==12){
						currentYear++;
						currentMonth=0;
					}
					
					currentMonth++;
					currentMonthFirstDay = new Date(""+currentYear+"-"+currentMonth+"-1").getDay();
					currentTotalDay = judgeDay(currentYear,currentMonth);
					
					$("#month").html("<span>"+currentYear+"�~"+currentMonth+"��</span>")
					for(let i = 1;i<=currentTotalDay;i++){
						let pickdate = currentYear+"-"+currentMonth+"-"+i;
						let compare = currentYear+"-"+currentMonth+"-"+(i+1);
						if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
							$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
						}
						$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
						$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
						currentMonthFirstDay = currentMonthFirstDay+1;
					}
			})
				//��l
			$("#month").html("<span>"+currentYear+"�~"+currentMonth+"��</span>")
			for(let i = 1;i<=currentTotalDay;i++){
					let pickdate = currentYear+"-"+currentMonth+"-"+i;
					let compare = currentYear+"-"+currentMonth+"-"+(i+1);
					$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
					if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
						$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
					}
					$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
					currentMonthFirstDay = currentMonthFirstDay+1;
			}
// 			��s���
			function freshPickDateTB(){
				$("button[name='pickdate']").each(function(){
						$(this).css('display','none');
						$(this).prop('disabled',false);
						$(this).attr("id","").children().remove();
				})
			}
			//�P�_�X�� �]�t�|�~�Ѽ�
			function judgeDay(year,month){
				let maybe =["28","29","30","31","32"];
				let recordMonth = month;
				for(let i=0;i<maybe.length;i++){
					let judgemonth = new Date(year+"-"+month+"-"+maybe[i]);
					if((judgemonth.getMonth()+1)!=month || "Invalid Date"==judgemonth){
						return maybe[i-1];
					}
				}
			} 
//�ɬq��ܥͦ�
			let prevTime = 0;
			let interval = 1;
//�]�w�Z�� �{�b�h�֤p�ɤ~�i�H�w��
//$("#freeTimeToSee").val();
			let currentHours = new Date().getHours();
			//�Ω�]�q�A�P�_����諸�ɬq
			let unchoosetime = 0;
			let isUpdate = false;
			function spanTimetitle(prevTime,interval,pickdate,freeTimeToSee){
				$("span[name='timeTitle']").each(function(index){
					let nextTime = prevTime+interval;
					$(this).text(prevTime+":00-"+nextTime+":00");
					let rva_order_time =pickdate+" "+prevTime+":00:00";
					//�H�U�]�w�{�b(freeTimeToSee)�������ɬq ���i�w��
					let comparePickTime =pickdate+" "+index+":00:00";
					let nowHour = new Date().getHours()+parseInt(freeTimeToSee)+1;
					let nowDate = new Date().getDate();
					let nowMonth = (new Date().getMonth()+1); 
					let nowYear = new Date().getFullYear();
					let nowTotalDay = judgeDay(nowYear,nowMonth);
					if(nowHour>=24){
						nowDate++;
						nowHour%=24;
					}
					if(nowDate>nowTotalDay){
						nowMonth++;
						nowDate%=nowTotalDay;
					}
					if(nowMonth>=12){
						nowDate++;
						nowMonth-=12;
					}
					
					let compareNowTime = nowYear+"-"+nowMonth+"-"+nowDate+" "+nowHour+":00:00";
					if(index==1){
						isUpdate = false;
					}
					if(index<=obj.gotowork){
						$("input[name='picktime']").eq(index).prop("disabled",true);
					}
					if(obj.gooffwork<=index){
						$("input[name='picktime']").eq(index).prop("disabled",true);
					}
					if(Date.parse(comparePickTime).valueOf() < Date.parse(compareNowTime).valueOf()){
						$("input[name='picktime']").eq(index).prop("disabled",true);
						unchoosetime = index;
						isUpdate =true;
					}
					$("input[name='picktime']").eq(index).next().remove();
					$("input[name='picktime']").eq(index).attr('value',rva_order_time);
					$("input[name='picktime']").eq(index).attr('id',prevTime).after("<span id='"+pickdate+"'></span>");
					prevTime+=interval;
				})
			}
			
			
			
//�H�Uwebsocket


			let member = "�|���s��"+${MemTenVO.mem_no}
			let MyPoint = "/pickTime/"+member+"/"+houseno;//��WS.java������
			let host = window.location.host;
			let path = window.location.pathname;
			let webCtx = path.substring(0, path.indexOf('/', 1));
			let endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
			console.log(endPointURL);
			let self = member;
			let webSocket;
			let countChecked = 0 ; //�p��w�w���ɬq
			let fullCheck = 24; //�]�w 24���ɬq ���ɬq�A���X�q��
			function connect() {
				// create a websocket
				webSocket = new WebSocket(endPointURL);
				webSocket.onopen = function(event) {
					console.log("Connect Success!");
					$("#member").after("<p>"+member+"</p>");//�s�u���\ �n�J�W��
					addListener();
				};
				webSocket.onmessage = function(event) {
//		 			�|�ت��Atype �n�J�B���v��T�B��ѮɡB�����ɭ�
//		 			�n�J�n��s�n�ͦC��
//		 			���v��T���X�¸��
//		 			Object �s��message
					var jsonObj = JSON.parse(event.data);
					let currentClick = null;
					
					if ("open" === jsonObj.type) {//����إ]�q
//		 				�@���s�s�u�A�N��s���v���
						addListener();
					} else if ("history" === jsonObj.type && (self !== jsonObj.sender)) {
						
						// �o�檺jsonObj.message�O�qredis���X��n�ͪ����v�T���A�Aparse��JSON�榡�B�z
						var messages = JSON.parse(jsonObj.message);
						for (var i = 0; i < messages.length; i++) {
							let jsonObject = JSON.parse(messages[i]);
							let time = jsonObject.time;//���X�Q�諸�ɶ��F
							let timepick = jsonObject.timepick;
							let date = jsonObject.date;//���X�Q�諸�F
							let datepick = jsonObject.datepick;
							if(isUpdate==true && time<=unchoosetime){
								continue;
							}
							//���z����  
							if(self !== jsonObject.sender && timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
								$("input[name='picktime']").each(function(){
									if($(this).attr("id")===time){
										$(this).prop("checked",true);
										if(jsonObject.sender.indexOf("���u")==0){
											$(this).next().text("�|���}��w��");
										}else{
											$(this).next().text(jsonObject.sender+" �w�w��");
										}
										$(this).prop("disabled",true);
									}
								})
							}else if(self !== jsonObject.sender && timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
								$("input[name='picktime']").each(function(){
									if($(this).attr("id")===time){
										$(this).prop("checked",false);
										$(this).next().text("");
										$(this).prop("disabled",false);
									}
								})
							}else if(self === jsonObject.sender && timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
								$("input[name='picktime']").each(function(){
									if($(this).attr("id")===time){
										$(this).prop("checked",true);
										$(this).next().text(jsonObject.sender+" �w�w��");
									}
								})
							}else if(self === jsonObject.sender && timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
								$("input[name='picktime']").each(function(){
									if($(this).attr("id")===time){
										console.log("SSSSSF");
										$(this).prop("checked",false);
										$(this).next().text("");
									}
								})
							}
						}
					}else if("chat" === jsonObj.type && self === jsonObj.sender && houseno==jsonObj.identity) {//�����s�Q��ɶ����]�q
						let time = jsonObj.time;//���X�Q�諸�ɶ��F
						let timepick = jsonObj.timepick;
						let date = jsonObj.date;//���X�Q�諸�ɶ��F
						let datepick = jsonObj.datepick;
						//���z����  
						if(timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
							$("input[name='picktime']").each(function(){
								if($(this).attr("id")===time){
									$(this).prop("checked",true);
									$(this).next().text(jsonObj.sender+" �w�w��");
									countChecked++;
								}
							})
						}else if(timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
							$("input[name='picktime']").each(function(){
								if($(this).attr("id")===time){
									$(this).prop("checked",false);
									$(this).next().text("");
									countChecked--;
								}
							})
						}
					}else if ("chat" === jsonObj.type && self !== jsonObj.sender && houseno==jsonObj.identity) {//�����s�Q��ɶ����]�q
						// �o�檺jsonObj.message�O�qredis���X��n�ͪ����v�T���A�Aparse��JSON�榡�B�z
						let time = jsonObj.time;//���X�Q�諸�ɶ��F
						let timepick = jsonObj.timepick;
						let date = jsonObj.date;//���X�Q�諸�ɶ��F
						let datepick = jsonObj.datepick;
						//���z����  
						if(timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
							$("input[name='picktime']").each(function(){
								if($(this).attr("id")===time){
									$(this).prop("checked",true);
									if(jsonObj.sender.indexOf("���u")==0){
										$(this).next().text("�|���}��w��");
									}else{
										$(this).next().text(jsonObj.sender+" �w�w��");
									}
									$(this).prop("disabled",true);
								}
							})
						}else if(timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
							$("input[name='picktime']").each(function(){
								if($(this).attr("id")===time){
									$(this).prop("checked",false);
									$(this).prop("disabled",false);
									$(this).next().text("");
								}
							})
						}
					}else if ("close" === jsonObj.type) {
						console.log("BYE");
					}else if ("control" === jsonObj.type){
						 obj = getlistcontroltime(houseno);
						 $("input[name='picktime']").each(function(index){
							 	if(index<obj.gotowork){
									$("input[name='picktime']").eq(index).prop("disabled",true);
								}
								if(obj.gooffwork<index){
									$("input[name='picktime']").eq(index).prop("disabled",true);
								}
								if(obj.gotowork<=index && obj.gooffwork>=index){
									$("input[name='picktime']").eq(index).prop("disabled",false);
								}
						})
					}
					
					if(countChecked==fullCheck){
						alert("�Ӥѹw�����o");
					}
				};
				
				webSocket.onclose = function(event) {
					console.log("Disconnected!");
				};
			}
			//���U�n�諸�ɶ� �e�X�]�q
			$("input[name='picktime']").change(function(){
					let time =  $(this).attr("id");
					let timepick = null;
					let date = "";
					if($(this).next().attr('id')!='undefined'){
						date=$(this).next().attr('id');
					}
					if($(this).prop("checked")==true){
						timepick = "1";
					}else{
						timepick = "0";
					}
					var jsonObj = {
							"type" : "chat",
							"sender" : self,
							"identity" : houseno,
							"date" :date,
							"datepick" :"",
							"time" :time,
							"timepick" :timepick,
						};
					webSocket.send(JSON.stringify(jsonObj));
			})
			
//		 	�ڭn������v��ƪ�
			// ���U�C���I���ƥ�ç���n�ͦW�r�H���o���v�T��
			function addListener() {
					let jsonObj = {
							"type" : "history",
							"sender" : "",
							"identity" : houseno,
							"message" : "",
						};
					webSocket.send(JSON.stringify(jsonObj));
			}
			function disconnect() {
				webSocket.close();
			}
			
			$("button[name='pickdate']").click(function(){
				
				$("#showdate").html("<span>"+$(this).attr('id')+" ���ɬq </span>")
				$("#exampleModalLabel").html("�q��ݳB�z�A�йw�� \"�{�b�_ "+obj.freeTimeToSee+"�p�� \"���᪺�ɬq");
				$("input[name='picktime']").each(function(){
					$(this).prop('checked',false);
					$(this).prop('disabled',false);
				})
				spanTimetitle(prevTime,interval,$(this).attr('id'),obj.freeTimeToSee);
				
			
				addListener();
				countChecked=0;
				$("#Modal").modal('show');
			})
			
			$("input[name='picktime']").change(function(){
			let rva_order_time = $(this).val();
			let mem_no = self.substring(self.indexOf("��")+1);
			let confirmpicktime =new Date(rva_order_time).getFullYear()+"�~"+(new Date(rva_order_time).getMonth()+1)+"��"+new Date(rva_order_time).getDate()+"��";
			confirmpicktime+=new Date(rva_order_time).getHours()+"��";	
			//���u�o���I�U�h ���ηs�W �������n(�Ȯ�)
			if($(this).prop('checked')===true){
				Swal.fire({
					  title: '�T�w�w���o�ɶ�?',
					  text: confirmpicktime,
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#6495ed',
					  cancelButtonColor: '#fa8072',
					  confirmButtonText: '�T�w�w��',
					  cancelButtonText:'����',
					  confirmButtonClass:'btn-sm',
					  cancelButtonClass:'btn btn-info btn-sm',
					}).then((result) => {
					  if (result.isConfirmed) {
						$.ajax({
							url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
							type:'post',
							data:{
								action:'addPickTime',
								mem_no:mem_no,
								hos_no:houseno,
								rva_order_time:rva_order_time,
							},
							success:function(){
								console.log("�w�����\");
								//�e�X�q��
// 								let sendobj = {
// 									"houseno":houseno, 
// 									"picktime":confirmpicktime,
// 									"checked":"true",
// 								}
								let mess="�|��"+mem_no+"�b��覨�\�w��"+confirmpicktime+"�ɬq";
								picktimeSuccess(JSON.stringify(mess));
							}
						})
					    Swal.fire({
					    	icon:'success',
					    	title:'�w�����\'
					    })
					  }else{
						 $(this).prop('checked',false);
						 $(this).next().text("");
						 Swal.fire({
						    	icon:'error',
						    	title:'�w�����w��'
						  })
					  }
				})

			}else{
				$.ajax({
					url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
					type:'post',
					data:{
						action:'cancelPickTime',
						mem_no:mem_no,
						hos_no:houseno,
						rva_order_time:rva_order_time,
					},
					success:function(){
						//�e�X�q��
						let sendobj = {
							"houseno":houseno, 
							"picktime":confirmpicktime,
							"checked":"false",
						}
						picktimeSuccess(JSON.stringify(sendobj));
						
						console.log("�����w��");
						Swal.fire({
					    	icon:'error',
					    	confirmButtonColor:'red',
					    	title:'�w�����w��'
					  })
					}
				})
			}
		})
		
	$("button[class='swal2-confirm btn-sm swal2-styled']").click(function(){
		console.log("I GET");
	})

	</script>
</body>

</html>
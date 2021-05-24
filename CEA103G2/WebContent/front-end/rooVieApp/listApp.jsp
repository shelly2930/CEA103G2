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
<body>
<!-- ======�Ϥ� -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2> �d�ݹw�����p</h2>
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
	                                        	<a href='' style="font-weight:bold;color:#9999FF" id='case0'>�B�z��</a>
	                                        	<a href='' style="font-weight:bold;color:#C9C9C9" id='case1'>������</a>
	                                        	<a href='' style="font-weight:bold;color:#C9C9C9" id='case2'>�w������</a>
                            <div id='app'>
                            	<table  class="table table-striped ">
	                                <thead>
	                                	
	                                    <tr class="table-info">
	                                        <th class="text-center">����s��</th>
	                                        <th class="text-center">����W��</th>
	                                        <th class="text-center">�w���a�I</th>
	                                        <th class="text-center">�w���ɶ�</th>
	                                        <th class="text-center">�ץ�i��</th>
	                                        <th class="text-center" id='hide0'>�����H</th>
	                                        <th class="text-center"	id='hide1'>�s���q��</th>
	                                        <th class="text-center"	id='hide2'>�ڭn����</th>
	                                    </tr>
	                                </thead>
	                                <tbody id='showapp'>
	                                </tbody>
	                                <tfoot>
	                                    <tr>
	                                        <th scope="col" colspan="7" class="text-center">Appointment </th>
	                                    </tr>
	                                </tfoot>
                            </table>
                            </div>
                        </div>
					</div>
				</div>
            </div>
    	</section>
<!-- /****** CONTAINER *****/     -->	
		

<!-- /****** CONTAINER *****/     -->


				
<!-- /****** CONTAINER *****/     -->	                       
		<script>
		let mem_no = ${MemTenVO.mem_no};
		let status = 0;
		$("#case0").click(function(e){
			$(this).css("color",'#9999FF');
			$("#case1").css("color",'#C9C9C9');
			$("#case2").css("color",'#C9C9C9');
			e.preventDefault();
			status=0;
			listTheMemApp(mem_no,status);
		})
		$("#case1").click(function(e){
			$(this).css("color",'#9999FF');
			$("#case2").css("color",'#C9C9C9');
			$("#case0").css("color",'#C9C9C9');
			e.preventDefault();
			status=1;
			listTheMemApp(mem_no,status);
		})
		$("#case2").click(function(e){
			$(this).css("color",'#9999FF');
			$("#case1").css("color",'#C9C9C9');
			$("#case0").css("color",'#C9C9C9');
			e.preventDefault();
			status=2;
			listTheMemApp(mem_no,status);
		})
		
		
		$("#app").hide();
		listTheMemApp(mem_no,status);
		function listTheMemApp(mem_no,rva_status){
			$("#app").hide();
			$("#showapp").empty();
			$.ajax({
	        	  url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
	        	  type:'post',
	        	  data:{
	        		  action:'showTheMemApp',
	        		  mem_no:mem_no,
	        		  rva_status:rva_status,
	        	  },
	        	  success:function(list){
	        		if(list.length==0){
	        			let str = "<tr>";
		        		str+="<td class='text-center' colspan='8'>�S���s�ץ�</td>";
		        		str+="</tr>";
		        		$("#showapp").append(str);
	        		}else{
	        			for(let ap of list){
			        		let str = "<tr>";
			        		str+="<td>"+getHos(ap.hos_no).hos_no+"</td>";
			        		str+="<td>"+getHos(ap.hos_no).hos_name+"</td>";
			        		str+="<td>"+getHos(ap.hos_no).hos_address+"</td>";
			        		str+="<td>"+dateformat(ap.rva_order_time)+"</td>";
			        		if(ap.rva_status==0){
			        			str+="<td>"+"�B�z��"+"</td>";
			        			$("#hide0").hide();
			        			$("#hide1").hide();
			        			$("#hide2").hide();
			        		}else if(ap.rva_status==1){
			        			str+="<td>"+"������"+"</td>";
			        			str+="<td>"+getEmp(ap.emp_no).emp_name+"</td>";
				        		str+="<td>"+getEmp(ap.emp_no).emp_phone+"</td>";
				        		$("#hide0").show();
			        			$("#hide1").show();
			        			$("#hide2").hide();
			        		}else{
			        			str+="<td>"+"�w����"+"</td>";
			        			str+="<td>"+getEmp(ap.emp_no).emp_name+"</td>";
				        		str+="<td>"+getEmp(ap.emp_no).emp_phone+"</td>";
				        		if(checkthehousecon(ap.hos_no)==true){
				        			str+="<td>"+"<a  style='color:#FF8282;font-weight:bold'>�w�g�X��</a>"+"</td>";
				        		}else{
				        			str+="<td>"+"<a href='' style='color:#8282FF;font-weight:bold' class='checkhouse' id='"+ap.hos_no+"'>�ڭn����</a>"+"</td>";
				        		}
				        		
				        		$("#hide0").show();
			        			$("#hide1").show();
			        			$("#hide2").show();
			        		}
			        		
							str+="</tr>";
			        		$("#showapp").append(str);
	        			}
	        			$(".checkhouse").click(function(e){
	        				e.preventDefault();
	        				let hos = $(this).attr('id');
	        				$(location).attr('href',"${pageContext.request.contextPath}/memTen/memTen.do?action=getOne_For_Rental&hos_no="+hos);
	        			})
	        			$(".cancel").click(function(){
	        				let rva_no = $(this).parent().attr('id');
	        				let status = 2;
	        				updateStatus(empno,rva_no,status);
	        				listTheEmpApp(empno,nowStatus);
	        			})
	        		}
	        		$("#app").slideDown(1000);
	        	  }
	        })
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
		function getHos(hos_no){
			let hos ={};
			$.ajax({
				url:'<%=request.getContextPath()%>/RenConCRUDServlet',
				type: 'post',
				data:{
					action:'getOneHouse',
					houseno:hos_no,
				},
				async:false,
				success:function(hosvo){
					for(let key in hosvo){
						hos[key]=hosvo[key];
					}
				}
			})
			return hos;
		}
		function getEmp(emp_no){
			let emp ={};
			$.ajax({
  		    	url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
  		    	type:'post',
  		    	data:{
  		    		'action':'getOneEmp',
					'emp_no':emp_no,
  		    	},
  		    	async:false,
  		    	success:function(result){
  		    		
  		    		for(let key in result){
  		    			emp[key]=result[key];
					}
  		    	}
  		    });
			return emp;
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
		function checkthehousecon(hos){
			let con = false;
			$.ajax({
  		    	url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
  		    	type:'post',
  		    	data:{
  		    		'action':'checkthehousecon',
					'houseno':hos,
  		    	},
  		    	async:false,
  		    	success:function(result){
  		    		if(result.length!==0){
  		    			con=true;
  		    		}else{
  		    			con=false;
  		    		}
  		    	}
  		    });
			
			return con;
		}
		
		</script>
</body>
<%@include file="/front-end/footer.file"%>
</html>
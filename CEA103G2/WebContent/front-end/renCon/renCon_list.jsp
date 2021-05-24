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
    background-image: url(<%=request.getContextPath()%>/front-end/renCon/image/contract_03.jpg);
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
                            <h2 class='text-left'>��e�X��</h2>
                            <h3 class='text-left'>${MemTenVO.mem_name}</h3>
                            <h5 class='text-left'>
							View historical contracts</h5>
                            <h5 class='text-left'>�d�ݦX��</h5>
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
                        	<div id='hou'>
	                            <table class="table table-hover">
									<thead >
										<tr><th colspan='3' style='font-weight:bold'>�H�U�Oñ��������</th></tr>
										<tr style="background-color:#ccb78f">
											<th scope="col" class='text-center'>����W��</th>
											<th scope="col" class='text-center'>�a�}</th>
											<th scope="col" class='text-center'>����</th>
										</tr>
									</thead>
									<tbody id='showhou'>
										<tr>
											<th scope="col">����W��</th>
											<th scope="col">�X���פ��</th>
											
											<th scope="col">�X�����A</th>
										</tr>
									</tbody>
	                           </table>
                           </div>
                           <div id='con'>
	                            <table class="table table-hover">
									<thead >
										<tr><th colspan='7' style='font-weight:bold'> 
										<a href='' ><i style='color:#00BDBD' class="fas fa-long-arrow-alt-left">Back</i></a>  
										�d�ݷ�e�X��</th></tr>
										<tr style="background-color:#ccb78f">
											<th scope="col" class='text-center'>�X���s��</th>
											<th scope="col" class='text-center'>�X���_�l��</th>
											<th scope="col" class='text-center'>�X���פ��</th>
											<th scope="col" class='text-center'>�������A</th>
											<th scope="col" class='text-center'>ñ�W</th>
											<th scope="col" class='text-center'>���X�Ѭ�</th>
											<th scope="col" class='text-center'>�X��</th>
										</tr>
									</thead>
									<tbody id='showcon'>
										<tr>
											<th scope="col">����W��</th>
											<th scope="col">�X���פ��</th>
											<th scope="col">�X�����A</th>
										</tr>
									</tbody>
									<tfooter>
										<tr>
											<th colspan='7' class='text-center'><span>History</span></th>
										</tr>
									</tfooter>
	                           </table>
                           </div>
                        </div>
					</div>
				</div>
            </div>
    	</section>
    	
    	
    	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-xl" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">�X�����e</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <embed id="q" src= "" width= "100%" height= "800px" type="application/pdf">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		
		<div class="modal" id='showSignature' tabindex="-1" role="dialog">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">Signature</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <img id='showPic' src=''>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
<!-- /****** CONTAINER *****/     -->	


<!-- /****** CONTAINER *****/     -->
<script type="text/javascript">
	let mem_no = ${MemTenVO.mem_no};
	$('#con').hide();
	$('#hou').hide();
	showmemhou(mem_no);
	function showmemhou(mem_no){
		$('#hou').slideDown();
		$.ajax({
			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
			type: 'post',
			data:{
				action:'getMemHou_coustom',
				mem_no:mem_no,
				status:'2',
			},
			success:function(memhou){
				$('#showhou').empty();
				if(memhou=="none"){
					let str="<tr>";
					str+="<th colspan='3' class='text-center'>";
					str+="�S�����v�X��</th>";
					str+="</tr>"; 
					$('#showhou').append(str);
				}else{
					let count = 1;
					for(let i of memhou){
						let str="<tr id='memhou"+i+"'>";
						str+="<th scope='row' class='text-center'>";
						str+="<a style='color:#A1A1A1;' href='' class='listhoucon'>"+getHouse(i).hos_name+"</a>";
						str+="</th>";
						str+="<td class='text-center'>"+getHouse(i).hos_address+"</td>";
						str+="<td class='text-center'>"+getHouse(i).hos_rent+"</td>";
						str+="</tr>";  
						$('#showhou').append(str);
					}
					$(".listhoucon").click(function(e){
						e.preventDefault();
						$('#hou').slideUp();
						let hou = $(this).parents('tr').attr('id').substring(6);
						showhoucon(mem_no,hou);
						
					})
				}
			}
		})
	}
	function showhoucon(mem_no,hou){
		$('#con').slideDown();
		$.ajax({
			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
			type: 'post',
			data:{
				action:'getMemHouCon_coustom',
				mem_no:mem_no,
				hos_no:hou,
				status:'2',
			},
			success:function(memhoucon){
				if(memhoucon=="none"){
					alert('�d�L�X��');
				}
				$('#showcon').empty();
				for(let i of memhoucon){
					
					$.ajax({
						url:'<%=request.getContextPath()%>/RenConCRUDServlet',
						type:'post',
						data:{
							action:'list',
							mem_no:mem_no,
							hos_no:hou,
							con_no:i
						},
						success:function(cons){
							if(cons==="none"){
								let str="<tr id='"+i+"' name='"+mem_no+"' class='"+hou+"'>";
								str+="<td class='text-center' colspan='7'>";
								str+="<span>�B�z���A�еy��</span>";
								str+="</td>";
								str+="</tr>";
								$('#showcon').append(str);
								$("#send").hide();
								$("#sendtext").hide();

								
							}else{
								let samenum = 0;
								let count = 1;
								for(let con of cons){
									
									let str="<tr id='"+i+"' name='"+mem_no+"' class='"+hou+"'>";
									if(samenum==0){
										str+="<td class='text-center'><i class='fas fa-book-open' style='font-size:19px;color:#C2C2FF'></i> Contract number"+i+"<input style='display:none;' type='checkbox' class='check' id='check"+(count++)+"'></td>";
										str+="<td class='text-center'>"+getCon(i).rtct_eff_date+"</td>";
										str+="<td class='text-center'>"+getCon(i).rtct_end_date+"</td>";
										let status = "";
										if(getCon(i).rtct_status == 2){
											status = "�ͮ�"
										}else{
											status = "���ͮ�"
										}
										str+="<td class='text-center'>"+status+"</td>";
										str+="<td class='text-center'><a href=''class='signature' style='color:#00A8A8;'>ñ�W</a></td>";
										str+="<td class='text-center'>";
										str+="<a href='' class='dismiss' style='color:#00A8A8'>���e�Ѭ�</a></td>";
									}else{
										str+="<td class='text-center'></td>";
										str+="<td class='text-center'></td>";
										str+="<td class='text-center'></td>";
										str+="<td class='text-center'></td>";
										str+="<td class='text-center'></td>";
										str+="<td class='text-center'></td>";
									}
									str+="<td class='text-center'>";
									str+="<a style='color:#A1A1A1;' href='' id='"+con+"' class='listonecon'>"+con+"</a>";
									str+="</td>";
									
									str+="</tr>";
									samenum++;
									$('#showcon').append(str);
								}
								$(".dismiss").click(function(e){
									e.preventDefault();
									let contract = $(this).parents('tr').attr('id');
									let mem_no =$(this).parents('tr').attr('name');
									let hos_no =$(this).parents('tr').attr('class');
									
									console.log(getCon(contract).rtct_end_date)
									if(judge(getDate(contract))){
										Swal.fire({
											  title: 'Recheck',
											  text: "�T�w���X�Ѭ��ӽ�?",
											  icon: 'warning',
											  showCancelButton: true,
											  confirmButtonColor: '#6495ed',
											  cancelButtonColor: '#fa8072',
											  confirmButtonText: '�T�w',
											  cancelButtonText:'��^',
											  confirmButtonClass:'btn-sm',
											  cancelButtonClass:'btn btn-info btn-sm',
											}).then((result) => {
											  if (result.isConfirmed) {
												  $.ajax({
										    			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
										    			type:'post',
										    			data:{
										    				action:'updateStatus',
										    				con_no:contract,
										    				status:'4',
										    			},
										    			success:function(){
										    				console.log("���e�Ѭ�");
										    				$('#con').slideUp();
										    				showmemhou(mem_no);
										    			}
										    		})
										    		Swal.fire({
												    	icon:'success',
												    	title:'�w�e�X�ӽСA�е��Գq��'
												 	 })
											  }else{
													
											  }
										})
									}else{
										Swal.fire({
									    	icon:'error',
									    	text:'�ݩ�פ���Ӥ�H�W�~�i�H���X�ӽ�'
									  })
									}
								})
								$(".signature").click(function(e){
									e.preventDefault();
									$("#showSignature").modal('show');
									let c_no = $(this).parents('tr').attr('id');
									$("#showPic").attr('src',"data:image/gif;base64,"+getPic(c_no));
// 									
								})
								$(".listonecon").click(function(e){
									e.preventDefault();
									let mem_no =$(this).parents('tr').attr('name') ;
									let hos_no =$(this).parents('tr').attr('class') ;
									let con_no = $(this).parents('tr').attr('id') ;
									let filename = $(this).attr('id');
									var xhr = new XMLHttpRequest(); 
									let goURL = "<%=request.getContextPath()%>/RenConPdfServlet?mem_no="+mem_no+"&hos_no="+hos_no+"&con_no="+con_no+"&name="+filename;
									xhr.open('GET', goURL , true); 
									xhr.responseType = 'blob'; 
									xhr.onload = function(e) {
									    if (this.status == 200) { 
									    var blob = new Blob([this.response], {type: 'application/pdf'}), 
									    fileURL = URL.createObjectURL(blob);
									    $("#q").attr('src',fileURL);
	//									    window.open(fileURL,'_blank');�u��������
										$("#exampleModal").modal('show');
									    } 
									}; 
									xhr.send(); 
								})
							}
						}
					})
				}
				
			}
		})
	}
	
	function getHouse(hos_no){
		let hosvo={};
		$.ajax({
			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
			type: 'post',
			data:{
				action:'getOneHouse',
				houseno:hos_no,
			},
			async:false,
			success:function(hos){
				hosvo= hos;
			}
		})
		return hosvo;
	}
	function getCon(conno){
		let convo={};
		$.ajax({
			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
			type: 'post',
			data:{
				action:'getOneCon',
				con_no:conno,
			},
			async:false,
			success:function(con){
				convo= con;
			}
		})
		return convo;
	}
	function getPic(con){
    	let str='';
		$.ajax({
    		url:"<%=request.getContextPath()%>/RenConCRUDServlet",
     		type:'post',
     		data:{
     			action:'getPic',
     			con_no:con,
     		},
     		async:false,
     		success:function(b){
     			str=b;
     		}
     	})
     	return str;
	}
	function getDate(con){
    	let str='';
		$.ajax({
    		url:"<%=request.getContextPath()%>/RenConCRUDServlet",
     		type:'post',
     		data:{
     			action:'getDate',
     			con_no:con,
     		},
     		async:false,
     		success:function(b){
     			str=b;
     		}
     	})
     	return str;
	}
	function judge(judgeDay){
		let diff = parseInt(Math.abs(new Date() - new Date(judgeDay)) / 1000 / 60 / 60 / 24); // ��ۮt���@����ഫ���Ѽ�
		if(diff > 60)
			return true;
		else
			return false;
	}
</script>				
</body>
<%@include file="/front-end/footer.file"%>
</html>
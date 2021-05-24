<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>選取預約時間</title>

</head>

<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- =================================下面是導覽列==================================================== --> 
<%@include file="/front-end/header.file"%>
<!-- =================================上面是導覽列==================================================== --> 
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
<!-- ======圖片 -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2 class='text-left'>當前合約</h2>
                            <h3 class='text-left'>${MemTenVO.mem_name}</h3>
                            <h5 class='text-left'>
							View historical contracts</h5>
                            <h5 class='text-left'>查看合約</h5>
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
										<tr><th colspan='3' style='font-weight:bold'>以下是簽約的物件</th></tr>
										<tr style="background-color:#ccb78f">
											<th scope="col" class='text-center'>物件名稱</th>
											<th scope="col" class='text-center'>地址</th>
											<th scope="col" class='text-center'>租金</th>
										</tr>
									</thead>
									<tbody id='showhou'>
										<tr>
											<th scope="col">物件名稱</th>
											<th scope="col">合約終止日</th>
											
											<th scope="col">合約狀態</th>
										</tr>
									</tbody>
	                           </table>
                           </div>
                           <div id='con'>
	                            <table class="table table-hover">
									<thead >
										<tr><th colspan='7' style='font-weight:bold'> 
										<a href='' ><i style='color:#00BDBD' class="fas fa-long-arrow-alt-left">Back</i></a>  
										查看當前合約</th></tr>
										<tr style="background-color:#ccb78f">
											<th scope="col" class='text-center'>合約編號</th>
											<th scope="col" class='text-center'>合約起始日</th>
											<th scope="col" class='text-center'>合約終止日</th>
											<th scope="col" class='text-center'>租約狀態</th>
											<th scope="col" class='text-center'>簽名</th>
											<th scope="col" class='text-center'>提出解約</th>
											<th scope="col" class='text-center'>合約</th>
										</tr>
									</thead>
									<tbody id='showcon'>
										<tr>
											<th scope="col">物件名稱</th>
											<th scope="col">合約終止日</th>
											<th scope="col">合約狀態</th>
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
		        <h5 class="modal-title" id="exampleModalLabel">合約內容</h5>
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
					str+="沒有歷史合約</th>";
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
					alert('查無合約');
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
								str+="<span>處理中，請稍後</span>";
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
											status = "生效"
										}else{
											status = "未生效"
										}
										str+="<td class='text-center'>"+status+"</td>";
										str+="<td class='text-center'><a href=''class='signature' style='color:#00A8A8;'>簽名</a></td>";
										str+="<td class='text-center'>";
										str+="<a href='' class='dismiss' style='color:#00A8A8'>提前解約</a></td>";
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
											  text: "確定提出解約申請?",
											  icon: 'warning',
											  showCancelButton: true,
											  confirmButtonColor: '#6495ed',
											  cancelButtonColor: '#fa8072',
											  confirmButtonText: '確定',
											  cancelButtonText:'返回',
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
										    				console.log("提前解約");
										    				$('#con').slideUp();
										    				showmemhou(mem_no);
										    			}
										    		})
										    		Swal.fire({
												    	icon:'success',
												    	title:'已送出申請，請等候通知'
												 	 })
											  }else{
													
											  }
										})
									}else{
										Swal.fire({
									    	icon:'error',
									    	text:'需於終止日兩個月以上才可以提出申請'
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
	//									    window.open(fileURL,'_blank');彈跳視窗用
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
		let diff = parseInt(Math.abs(new Date() - new Date(judgeDay)) / 1000 / 60 / 60 / 24); // 把相差的毫秒數轉換為天數
		if(diff > 60)
			return true;
		else
			return false;
	}
</script>				
</body>
<%@include file="/front-end/footer.file"%>
</html>
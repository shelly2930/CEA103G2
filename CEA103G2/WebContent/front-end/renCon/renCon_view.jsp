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
    background-image: url(<%=request.getContextPath()%>/front-end/renCon/image/contract01.jpg);
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
                            <h2 class='text-right'>租屋合約</h2>
                            <h3 class='text-right'> &nbsp;&nbsp;&nbsp; ${MemTenVO.mem_name} 你好 !</h3>
                            <h5 class='text-right'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;View <span>-</span> Contract</h5>
                            <h5 class='text-right'>會員: ${MemTenVO.mem_no} <span>-</span> 請確定合約內容</h5>
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
										<tr><th colspan='3' style='font-weight:bold'>點選你要進行簽約的物件</th></tr>
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
										<tr>
											<th colspan='3'>
											<span id='name'>正在處理中</span>
											<br><span id='address'>將儘快為您處理</span>
											<br><span id='contract'>請稍後</span>
											<br><span id='date'>謝謝!</span>
											<br><span id='hidetext' style='font-weight:bold'>請詳細閱讀以下所有合約</span> 
											</th>
											
										</tr>
										<tr style="background-color:#ccb78f">
											<th scope="col" class='text-center'>已讀</th>
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
											<th colspan='2' class='text-center'><span id='sendtext'>已詳細閱讀&nbsp; &nbsp; </span><button id='send' class='btn btn-outline-info btn-sm'>下一步</button></th>
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
				status:"1",
			},
			success:function(memhou){
				$('#showhou').empty();
				if(memhou=='none'){
					let str="<tr>";
					str+="<th colspan='3' class='text-center'>";
					str+="目前沒有租屋申請</th>";
					str+="</tr>";  
					$('#showhou').append(str);
				}else{
					let count = 1;
					for(let i of memhou){
						let str="<tr id='memhou"+i+"'>";
						str+="<th scope='row' class='text-center'>";
						str+="<a href='' style='color:#9999FF' class='listhoucon'>"+getHouse(i).hos_name+"</a>";
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
				status:"1",
			},
			success:function(memhoucon){
				if(memhoucon==null){
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
								let str="<tr>";
								str+="<td class='text-center' colspan='2'>";
								str+="<span>處理中，請稍後</span>";
								str+="</td>";
								str+="</tr>";
								$('#showcon').append(str);
								$("#send").hide();
								$("#sendtext").hide();
								$("#hidetext").hide();
							}else{
								let count = 1;
								for(let con of cons){
									console.log(con);
									let str="<tr id='"+i+"' name='"+mem_no+"' class='"+hou+"'>";
									str+="<td class='text-center'><i class='far fa-bookmark' style='font-size:19px;color:#C2C2FF'></i><input style='display:none;' type='checkbox' class='check' id='check"+(count++)+"'></td>";
									str+="<td class='text-center'>";
									str+="<a href='' id='"+con+"' class='listonecon'>"+con+"</a>";
									str+="</td>";
									str+="</tr>";
									$('#showcon').append(str);
									
								}
								$("#name").text("會員:  "+getMem(mem_no).mem_name);
								$("#address").text("物件地址:  "+getHouse(hou).hos_address);
								$("#contract").text("合約編號:  第 "+i+" 號");
								$("#date").text("簽約時間:  "+dateformat(new Date()));
								
								
								$("#send").click(function(){
									let this_con_no = $(this).parents('table').children("tbody").children('tr').attr('id');
									let judge = true;
									$(".check").each(function(){
										if($(this).prop('checked')==false){
											judge = false;
										}
									})
									if(judge==true){
										document.location.href="<%=request.getContextPath()%>/front-end/renCon/renCon_mem.jsp?con_no="+this_con_no;
										//send to write contract
									}else{
										Swal.fire({
											  title: '請先詳細閱讀完所有合約內容!',
											  icon: 'warning',
											  confirmButtonColor: '#6495ed',
											  confirmButtonText: '確定預約',
											  confirmButtonClass:'btn-sm ',
										})
									}
								})
								$(".listonecon").click(function(e){
									e.preventDefault();
									$(this).parent().prev().children().prop('checked',true);
									$(this).parent().prev().find('i').removeClass('far');
									$(this).parent().prev().find('i').addClass('fas');
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
	function dateformat(str){
		 let year = new Date(str).getFullYear();
		 let month = new Date(str).getMonth()+1;
		 let date = new Date(str).getDate();
		 let hour = new Date(str).getHours();
		 let isAm = "上午";
		 if((Math.floor(hour/12)==1)){
			 isAm = "下午";
		 }
		 let minutes = new Date(str).getMinutes();
		 let second = new Date(str).getSeconds();
		 return year+"年"+month+"月"+date+"日" +" "+isAm+hour+"時"
	}
</script>				
</body>
<%@include file="/front-end/footer.file"%>
</html>
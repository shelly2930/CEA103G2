<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>預約時間管理</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
       <%@ include file="/back-end/includeFile/sidebarBack.file" %>

         <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

				<!-- Topbar -->
                <%@ include file="/back-end/includeFile/topbarBack.file" %>
				
                <!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
                <div class="container-fluid">
                	<div class="card shadow mb-4">
                        <div id='con'>
                        	<div class="card-header py-3">
                        		<div>
                        		<button class='btn btn-outline-info btn-sm' id='total'>合約-總攬</button>
                        		<button class='btn btn-outline-info btn-sm' id='success'>合約-生效</button>
                        		<button class='btn btn-outline-info btn-sm' id='early'>合約-解約申請</button>
                        		<button class='btn btn-outline-info btn-sm' id='history'>合約-歷史合約</button>
                        		</div><hr>
	                            <h6 class="m-0 font-weight-bold text-primary"><span>查看已繳費合約</span></h6>
		                    </div>
	                        <div class="card-body">
	                            <div class="table-responsive">
	                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	                                    <thead style='background-color:#E8E8E8'>
	                                        <tr>
	                                            <th>會員</th>
	                                            <th>物件</th>
	                                            <th>合約資料</th>
	                                            <th>簽名</th>
	                                            <th>合約起始</th>
	                                            <th>合約終止</th>
	                                            <th id='cancelheader'>解約處理</th>
	                                        </tr>
	                                    </thead>
	                                    <tfoot>
	                                        <tr>
	                                            <th colspan='6' id="cancelfooter" class="text-center"	>Contract</th>
	                                        </tr>
	                                    </tfoot>
	                                    <tbody id="showcon">
	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
                        </div>
                    </div>
                
                </div>
                <!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

            </div>
            <!-- End of Main Content -->
			<div class="modal fade" id="conpdf" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">物件詳請</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        	<table class="table table-bordered">
			        		<thead >
			        		<tr>
			        			<th>合約編號</th>
			        			<th>合約資料</th>
			        		</tr>
			        		</thead>
			        		<tbody id = "showconpdf">
			        		
			        		</tbody>
			        	</table>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">CLOSE</button>
			      </div>
			    </div>
			  </div>
			</div>
            <!-- Footer -->
            <div class="modal fade" id="pdf" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
			  <div class="modal-dialog modal-xl" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">合約</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        			<embed id="q" src= "" width= "100%" height= "800px" type="application/pdf">
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">CLOSE</button>
			      </div>
			    </div>
			  </div>
			</div>
<!--             簽名 -->
            
            
            
            
            <div class="modal fade" id="signature" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">signature</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
	        			<img src='' id ="showsignture">
	        			<p id='none'>尚無簽名</p>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">CLOSE</button>
			      </div>
			    </div>
			  </div>
			</div>
            <%@ include file="/back-end/includeFile/footerBack.file" %>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <%@ include file="/back-end/includeFile/otherBack.file" %>
    
    <!-- Bootstrap core JavaScript-->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->

    <!-- Page level custom scripts -->
    <!-- Page level custom scripts -->
	<script>
	let judgeStatus = 999;
	$("#total").click(function(){
		$(this).siblings().each(function(){
			$(this).removeClass('btn-info');
			$(this).addClass('btn-outline-info');
		})
		$(this).removeClass('btn-outline-info');
		$(this).addClass('btn-info');

		judgeStatus=999;
		getcontract(judgeStatus);
	})
	$("#success").click(function(){
		$(this).siblings().each(function(){
			$(this).removeClass('btn-info');
			$(this).addClass('btn-outline-info');
		})
		$(this).removeClass('btn-outline-info');
		$(this).addClass('btn-info');
		judgeStatus=2;
		getcontract(judgeStatus);
	})
	$("#early").click(function(){
		$(this).siblings().each(function(){
			$(this).removeClass('btn-info');
			$(this).addClass('btn-outline-info');
		})
		$(this).removeClass('btn-outline-info');
		$(this).addClass('btn-info');
		judgeStatus=4;
		getcontract(judgeStatus);
	})
	$("#history").click(function(){
		$(this).siblings().each(function(){
			$(this).removeClass('btn-info');
			$(this).addClass('btn-outline-info');
		})
		$(this).removeClass('btn-outline-info');
		$(this).addClass('btn-info');
		judgeStatus=5;
		getcontract(judgeStatus);
	})	
	getcontract(judgeStatus);
	function getcontract(status){
		let showtotal = true;
		if(status==999) showtotal=false;
		$.ajax({
			url:"<%=request.getContextPath()%>/RenConCRUDServlet",
			type:'post',
			data:{
				action:'getall',
			},
			success:function(list){
				$("#showcon").empty();
				for(let con of list){
					if(status!==con.rtct_status && showtotal) continue;
					let str = "<tr id='"+con.mem_no+"' class='"+con.hos_no+"'>";
					str+="<td>";
					str+=""+getMem(con.mem_no);
					str+="</td>";
					str+="<td>";
					str+=""+getHouse(con.hos_no).hos_address;
					str+="</td>";
					str+="<td id='"+con.rtct_no+"'>";
					str+="<a href='' style='color:#8C8CFF;font-weight:bold;' class='contract'>"+con.rtct_no+"合約</a>";
					str+="</td>";
					str+="<td>";
					str+="<a href='' style='color:#A1A1A1;font-weight:bold;' class='signature'>Click</a>";
					str+="</td>";
					str+="<td>";
					str+=""+con.rtct_eff_date;
					str+="</td>";
					str+="<td>";
					str+=""+con.rtct_end_date;
					str+="</td>";
					if(con.rtct_status==4 && status!=999){
						str+="<td>";
						str+="<a href='' class='cancelcon' style='color:#FF8C8C;font-weight:bold;'>結案</a>";
						str+="</td>";
						$("#cancelheader").show();
						$("#cancelfooter").attr('colspan','7');
					}else{
						$("#cancelheader").hide();
						$("#cancelfooter").attr('colspan','6');
					}
					str+="</tr>";
					$("#showcon").append(str);
				}
				$(".cancelcon").click(function(e){
					e.preventDefault();
					let c_no = $(this).parents('tr').children().eq(2).attr('id');
					let hos = $(this).parents('tr').attr('class');
					$.ajax({
						url:'<%=request.getContextPath()%>/RenConCRUDServlet',
						type: 'post',
						data:{
							action:'updateTmtDate',
							con_no:c_no,
							status:'5',
							tmtdate:formate(new Date())
						},
						success:function(c){
							pullorpush(hos,'2');
							$("#history").click();
						}
					})
				})
				
				
				
				$(".signature").click(function(e){
					e.preventDefault();
					let c_no = $(this).parent().prev().attr('id');
					let Str = getPic(c_no);
					if(Str=="none"){
						$("#none").fadeIn();
						$("#showsignture").hide();
					}else{
						$("#none").hide();
						$("#showsignture").fadeIn(3000);
						$("#showsignture").attr('src',"data:image/gif;base64,"+getPic(c_no));
					}
					$("#signature").modal('show');
				})
				
				
				
				$(".contract").click(function(e){
					e.preventDefault();
					$("#conpdf").modal('show');
					let mem = $(this).parents('tr').attr('id');
					let hos = $(this).parents('tr').attr('class');
					let con = $(this).parent().attr('id');
					$.ajax({
						url:'<%=request.getContextPath()%>/RenConCRUDServlet',
						type:'post',
						data:{
							action:'list',
							mem_no:mem,
							hos_no:hos,
							con_no:con
						},
						success:function(cons){
							
							$('#showconpdf').empty();
							if(cons=='none'){
								let str="<tr>";										
								str+="<td colspan='2' class='text-center'>";
								str+="查無合約";
								str+="</td>";
								str+="</tr>";  
								$('#showconpdf').append(str);
							}else{
								let count = 1;
								for(let i of cons){
									let str="<tr name='"+mem+"' class='"+hos+"'>";										
									str+="<th scope='row' class='text-center'>"+(count++)+"</th>";
									str+="<td class='text-center'>";
									str+="<a href='' name='"+con+"' id='"+i+"' class='con'>"+i+"</a>";
									str+="</td>";
									str+="</tr>";  
									$('#showconpdf').append(str);
								}
								$(".con").click(function(e){
									e.preventDefault();
									let mem_no =$(this).parents('tr').attr('name') ;
									let hos_no =$(this).parents('tr').attr('class') ;
									let con_no = $(this).attr('name');
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
										$("#pdf").modal('show');
									    } 
									}; 
									xhr.send(); 
								})
								
							}
							
						}
					})
				})
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
	function getMem(mem_no){
		let name = "";
		$.ajax({
			url:'<%=request.getContextPath()%>/RenConCRUDServlet',
			type: 'post',
			data:{
				action:'getOneMemten',
				mem_no:mem_no,
			},
			async:false,
			success:function(mem){
				name = mem.mem_name;
			}
		})
		return name;
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
     			if(b=='none'){
     				str="none";
     			}else{
     			str=b;
     			}
     		}
     	})
     	return str;
	}
	function pullorpush(hos_no,hos_state){
		$.ajax({
    		url:"<%=request.getContextPath()%>/HouseJsonServlet",
     		type:'post',
     		data:{
     			action:'pullorpush',
     			houseno:hos_no,
     			state:hos_state
     		},
     		success:function(b){
     			console.log(b);
     		}
     	})
	}
	function formate(d){
		let date = new Date(d);
		return dateFormat = date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
	}
	</script>
</body>

</html>
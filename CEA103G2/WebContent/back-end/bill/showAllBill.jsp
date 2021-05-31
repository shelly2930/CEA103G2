<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@ page import="com.bill.model.*"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="com.renFurDet.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furLis.model.*"%>
<%@ page import="com.house.model.*"%>
<%@ page import="com.renCon.model.*"%>
<%@ page import="com.memTen.model.*"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>房客帳單</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

	<!-- Custom styles for this page -->
	<link href="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<style>
	img.lld_acc_pic {
	  	height: 100px;
	  	width: auto;
	}
  	table:hover{
		cursor: pointer;
	}
	tr:hover{
		background-color: #eeeeee;
	}
	th:hover{
		background-color: #aaaaaa;
	}
	.pageTitle{
		color: #d4dedd;
		letter-spacing: 1rem;
		text-shadow: 1px 1px 2px #233559;
	}
</style>
	
</head>

<body id="page-top">
	
	<!-- Bootstrap core JavaScript-->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/datatables-demo.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    
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
					
					<div class="mx-auto pageTitle">
				        <h1 class="mx-auto mb-4 text-uppercase">房客帳單</h1>
				    </div>
				    
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
  							<button type="button" class="btn btn-danger auto-insert mr-1">新增帳單</button>
  							<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/back-end/bill/showAllBill.jsp?status=0'">未發送</button>
  							<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/back-end/bill/showAllBill.jsp?status=1'">未繳費</button>
							<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/back-end/bill/showAllBill.jsp?status=2'">已繳費</button>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>帳單期別</th>
											<th>會員姓名</th>
											<th>繳費期限</th>
											<th>房客繳費狀態</th>
<!-- 											<th>房東撥款狀態</th> -->
											<th>發送帳單</th>
											<th style="display:none;">查看</th>
										</tr>
									</thead>
									<tbody>
										<%
										BillService billSvc = new BillService();
										List<BillVO> list = billSvc.getAll();
										Set<String> set = new LinkedHashSet<String>();
										int status = 0;
										if(request.getParameter("status") != null)
											status = Integer.parseInt(request.getParameter("status"));
										for(BillVO billVO : list){
											if(status == 0){
												if(billVO.getBill_p_status() == 0 && billVO.getBill_due() == null)
													set.add(billVO.getMem_no() + "," + billVO.getBill_date().toString());
											}else if(status == 1){
												if(billVO.getBill_p_status() == 0 && billVO.getBill_due() != null)
													set.add(billVO.getMem_no() + "," + billVO.getBill_date().toString());
											}else if(status == 2){
												if(billVO.getBill_p_status() == 1)
													set.add(billVO.getMem_no() + "," + billVO.getBill_date().toString());
											}else{
												set.add(billVO.getMem_no() + "," + billVO.getBill_date().toString());
											}
												
										}
										int i = 0;
										for(String str : set){ i++;
											Integer mem_no = new Integer(str.substring(0,str.indexOf(",")));
											Date bill_date = Date.valueOf(str.substring(str.indexOf(",") + 1));
											List<BillVO> billVOs = new BillService().getMemMonthlyBill(mem_no, bill_date);
										%>
											<tr>
												<td class="view"><fmt:formatDate value="<%=bill_date%>" pattern="yyyyMM"/></td>
												<td class="view"><%=new MemTenService().getOneMemTen(mem_no).getMem_name()%></td>
												<td class="view" id="<%=mem_no+"-"+bill_date%>"><%=billVOs.get(0).getBill_due() == null ? "" : billVOs.get(0).getBill_due()%></td>
												<td class="view"><%=billVOs.get(0).getBill_p_status() == 0 ? "未繳費" : "已繳費"%></td>
<%-- 												<td class="view"><%=billVOs.get(0).getBill_r_status() == 0 ? "未撥款" : "已撥款"%></td> --%>
												<td class="text-center">
													<button type="button" class="btn btn-outline-secondary fill-in <%=mem_no+"-"+bill_date%>" data-toggle="modal" 
														data-target="#exampleModalCenter" <%=billVOs.get(0).getBill_due()==null?"":"disabled"%>>
														<%=billVOs.get(0).getBill_due()==null?"填寫帳單":"已發送"%>
													</button>
												</td>
												<td style="display:none;">
													<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/bill/bill.do">
														<button type="submit" class="btn btn-outline-danger">查看</button>
														<input type="hidden" name="mem_no" value="<%=mem_no%>">
														<input type="hidden" name="bill_date" value="<%=bill_date%>">
														<input type="hidden" name="bill_due" value="<%=billVOs.get(0).getBill_due()%>">
														<input type="hidden" name="action" value="get_A_Bill">
													</FORM>
												</td>
											</tr>
										<%}%>
									</tbody>
								</table>
							</div>
						</div>
					</div>

                </div>
                
                <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				    
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalCenterTitle">帳單資料</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span id="span_x" aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      
				      <div class="modal-body">
				      </div>

				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary send-bill">送出帳單</button>
				        <button type="button" class="btn btn-secondary" id="close" data-dismiss="modal">關閉</button>
				      </div>
				      
				    </div>
				  </div>
				</div>
                <!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@ include file="/back-end/includeFile/footerBack.file" %>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <%@ include file="/back-end/includeFile/otherBack.file" %>
    
    <script>
    	$(".auto-insert").click(function(){
    		$.ajax({
    			url:"<%=request.getContextPath()%>/bill/bill.do",
    			type:'post',
    			data:{
    				action:'autoInsert'
    			},
    			success:function(amountOfInsert){
    				if(amountOfInsert == 0){
    					Swal.fire({
	    					icon:'info',
	    					title:'尚無新帳單',
// 	    					showConfirmButton: false,
// 	    					timer: 1000
	    				});
    				}else{
	    				Swal.fire({
	    					icon:'success',
	    					title:'成功新增'+ amountOfInsert + '筆帳單',
// 	    					showConfirmButton: false,
// 	    					timer: 1000
	    				});
// 	    				setTimeout(function(){
<%-- 	    					$(location).prop('href', '<%=request.getContextPath()%>/back-end/bill/showAllBill.jsp?status=0'); --%>
// 	    			  	},1000);
    				}
    			}
    		});
    	});
    	
    	$(".view").click(function(){
			$(this).parent().find("form").submit();
		});
    	
    	let mem_no;
    	let bill_date;
    	$(".fill-in").click(function(e){
    		$(".modal-body").empty();
    		mem_no = $(this).parent().next().find("input[name='mem_no']").val();
    		bill_date = $(this).parent().next().find("input[name='bill_date']").val();

			$.ajax({
    			url:"<%=request.getContextPath()%>/bill/bill.do",
    			type:'post',
    			data:{
    				action:'getMemMonthlyBill',
    				mem_no: mem_no,
					bill_date: bill_date
    			},
    			success:function(data){
    				$(".modal-body").append(
	    				"<div class='form-group row justify-content-center'>" +
				      	 	"<label for='newPasswordCheck' class='col-3 col-form-label'>繳費期限</label>" +
				      	 	"<div class='col-7'>" +
				      	 	 	"<div class='input-group'>" +
								  	"<input type='number' value='15' min='10' max='30' class='form-control deadline' required>" +
								  	"<div class='input-group-append'>" +
								  		"<span class='input-group-text'>天</span>" +
								  	"</div>" +
								"</div>" +
							"</div>" +
						"</div>"
    				);
					for(let billVO of data){
						$(".modal-body").append(
							"<hr>" +
							"<div class='row justify-content-center mt-4 mb-4'>" +
					      	 	"<div class='col-3'>物件編號</div>" +
							  	"<div class='col-7 text-center'>" + billVO.hos_no + "</div>" +
							"</div>" +
// 					       	"<div class='row justify-content-center mt-4 mb-4'>" +
// 					      	 	"<div class='col-3'>物件名稱</div>" +
// 							  	"<div class='col-7 text-center'>很難查ㄚㄚㄚㄚ</div>" +
// 							"</div>" +
					       	"<div class='form-group row justify-content-center'>" +
					      	 	"<label for='oldPassword' class='col-3 col-form-label'>用電量</label>" +
							  	"<div class='col-7'>" +
									"<div class='input-group'>" +
									  	"<input type='number' min='0' class='form-control power' id='power" + billVO.hos_no + "' required>" +
									  	"<div class='input-group-append'>" +
									  		"<span class='input-group-text'>度</span>" +
									  	"</div>" +
									"</div>" +
								"</div>" +
							"</div>" +
							"<div class='form-group row justify-content-center'>" +
					      	 	"<label for='newPassword' class='col-3 col-form-label'>用水量</label>" +
							  	"<div class='col-7'>" +
									"<div class='input-group'>" +
									  	"<input type='number' min='0' class='form-control water' id='water" + billVO.hos_no + "' required>" +
									  	"<div class='input-group-append'>" +
									  		"<span class='input-group-text'>度</span>" +
									  	"</div>" +
									"</div>" +
								"</div>" +
							"</div>"
						);
					}
    			}
    		});
		});

    	
    	$(".send-bill").click(function(){
    		if($(".deadline").val() != '' && $(".power").val() != '' && $(".water").val() != ''){
	    		$.ajax({
	    			url:"<%=request.getContextPath()%>/bill/bill.do",
	    			type:'post',
	    			data:{
	    				action:'getMemMonthlyBill',
	    				mem_no: mem_no,
						bill_date: bill_date
	    			},
	    			success:function(data){
	    				for(let billVO of data){
		    				$.ajax({
		    					url: "${pageContext.request.contextPath}/bill/bill.do",
		    					type: "post",
		    					data: {
		    						action: "send_bill",
		    						bill_no: billVO.bill_no,
		    						deadline: $(".deadline").val(),
		    						bill_power: $("#power"+billVO.hos_no).val(),
		    						bill_water: $("#water"+billVO.hos_no).val()
		    					},
		    					success: function(data){
		    						console.log(data);
		    						$("#"+mem_no+"-"+bill_date).text(data);
		    						$("."+mem_no+"-"+bill_date).prop("disabled",true);
		    						$("."+mem_no+"-"+bill_date).text("已發送");
		    					}
		    				});
	    				}
	    				
						Swal.fire({
					    	icon:'success',
					    	title:'帳單已發送'
					    });
						$("#close").click();
// 						'<fmt:formatDate value="${list.get(0).bill_date}" pattern="yyyyMM"/>'
						
						picktimeSuccess(bill_date + '期帳單待繳費', mem_no);
	    			}
	    		});
    		}else{
    			Swal.fire({
					icon:'warning',
			    	title:'請完成填寫'
			    });
    		}
		});
    	
    </script>
     
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.bill.model.*"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="com.renFurDet.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furLis.model.*"%>
<%@ page import="com.house.model.*"%>
<%@ page import="com.renCon.model.*"%>
<%@ page import="com.memTen.model.*"%>

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
</style>
	
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
					
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">所有房客帳單</h6>
							<ul>
  								<li><a href='addBill.jsp'>Add</a> a new Bill.</li>
  								<button type="button" class="btn btn-outline-danger auto-insert">自動新增帳單</button>
							</ul>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>帳單編號</th>
											<th>會員編號</th>
											<th>帳單日期</th>
											<th>繳費期限</th>
											<th>租金</th>
											<th>用電量</th>
											<th>用水量</th>
											<th>租家具總費用</th>
											<th>房客繳費狀態</th>
											<th>房東撥款狀態</th>
										</tr>
									</thead>
									<tbody>
										<%
										BillService billSvc = new BillService();
										List<BillVO> list = billSvc.getAll();
										int i = 0;
										for(BillVO billVO : list){ i++;
											Calendar cal = Calendar.getInstance();
											cal.setTime(billVO.getBill_date()); //將帳單日期轉為Calendar
										    int year_bill = cal.get(Calendar.YEAR); //帳單日期年份
											int month_bill = cal.get(Calendar.MONTH); //帳單日期月份
										%>
											<tr>
												<td><%=billVO.getBill_no()%></td>
												<td><%=new MemTenService().getOneMemTen(billVO.getMem_no()).getMem_name()%></td>
												<td><fmt:formatDate value="<%=billVO.getBill_date()%>" pattern="yyyy-MM"/></td>
												<td><fmt:formatDate value="<%=billVO.getBill_due()%>" pattern="yyyy-MM-dd"/></td>
												<%
												RenConService renConSvc = new RenConService();
												HouseService houseSvc = new HouseService();
												List<RenConVO> list_RenConVO = renConSvc.getAll();
												int hr_total = 0; //租屋合約租金合計
												for(RenConVO renConVO : list_RenConVO){
													//合約會員編號等於帳單會員編號 且 帳單日期在合約起始日之後
													if(renConVO.getMem_no() == billVO.getMem_no() && billVO.getBill_date().getTime() > renConVO.getRtct_eff_date().getTime()){
														int hos_rent = houseSvc.getOneHouse(renConVO.getHos_no()).getHos_rent();
														//合約解約日為空值 或 合約解約日在帳單日期之後
														if(renConVO.getRtct_tmt_date() == null || renConVO.getRtct_tmt_date().getTime() > billVO.getBill_date().getTime()){
															cal.setTime(renConVO.getRtct_eff_date()); //將合約起始日轉為Calendar
															int year_eff = cal.get(Calendar.YEAR); //合約起始日年份
															int month_eff = cal.get(Calendar.MONTH); //合約起始日月份
															int dayOfMonth = cal.get(Calendar.DATE); //合約起始日為當月第幾天
															cal.set(Calendar.DATE, 1); //把日期設定為當月第一天
															cal.roll(Calendar.DATE, -1); //日期回滾一天，也就是最後一天
														    int totalDaysOfMonth = cal.get(Calendar.DATE); //合約起始日當月總天數
														    
															int betweenMonth = (year_bill - year_eff)*12 + (month_bill - month_eff); //帳單日期與合約起始日相差月份
															
														    if(betweenMonth == 1) {
														    	//按天數計算租金,int轉為double相除才會有小數
														    	int partOf_hos_rent = (int)Math.floor((double)(totalDaysOfMonth - dayOfMonth + 1) / (double)totalDaysOfMonth * hos_rent);
															    hr_total += partOf_hos_rent;
// 															    System.out.println("第"+i+"筆-1:加金額"+partOf_hos_rent);
															} else {
																hr_total += hos_rent;
// 																System.out.println("第"+i+"筆-2:加金額"+hos_rent);
															}
														//合約解約日在帳單日期之前
														} else {
															cal.setTime(renConVO.getRtct_tmt_date()); //將合約解約日轉為Calendar
															int year_tmt = cal.get(Calendar.YEAR); //合約解約日年份
															int month_tmt = cal.get(Calendar.MONTH); //合約解約日月份
															int dayOfMonth_tmt = cal.get(Calendar.DATE); //合約解約日為當月第幾天
															cal.set(Calendar.DATE, 1); //把日期設定為當月第一天
															cal.roll(Calendar.DATE, -1); //日期回滾一天，也就是最後一天
														    int totalDaysOfMonth = cal.get(Calendar.DATE); //合約解約日當月總天數
														    
														    cal.setTime(renConVO.getRtct_eff_date()); //將合約起始日轉為Calendar
														    int year_eff = cal.get(Calendar.YEAR); //合約起始日年份
															int month_eff = cal.get(Calendar.MONTH); //合約起始日月份
															int dayOfMonth_eff = cal.get(Calendar.DATE); //合約起始日為當月第幾天
														    
														    int betweenMonth = (year_bill - year_tmt)*12 + (month_bill - month_tmt); //帳單日期與合約解約日相差月份
														    
															if(betweenMonth == 1) {
																//當月租當月退的情況
																if(year_tmt == year_eff && month_tmt == month_eff){
																	int betweenDay = dayOfMonth_tmt - dayOfMonth_eff;
																	int partOf_hos_rent = (int)Math.floor((double)betweenDay / (double)totalDaysOfMonth * hos_rent);
																    hr_total += partOf_hos_rent;
// 																    System.out.println("第"+i+"筆-3:加金額"+partOf_hos_rent);
																}else {
															    	int partOf_hos_rent = (int)Math.floor((double)dayOfMonth_tmt / (double)totalDaysOfMonth * hos_rent);
																    hr_total += partOf_hos_rent;
// 																    System.out.println("第"+i+"筆-4:加金額"+partOf_hos_rent);
																}
															}
														}
													}
												}
												%>
												<td><%=hr_total%></td>
												<td><%=billVO.getBill_power()%></td>
												<td><%=billVO.getBill_water()%></td>
												<%
												RenFurAppService renFurAppSvc = new RenFurAppService();
												RenFurDetService renFurDetSvc = new RenFurDetService();
												FurIteService furIteSvc = new FurIteService();
												FurLisService furLisSvc = new FurLisService();
												int raf_total = 0; //每月家具租金合計
												for(RenFurAppVO renFurAppVO : renFurAppSvc.getAll()) {
													if(renFurAppVO.getMem_no() == billVO.getMem_no()) {
														for(RenFurDetVO renFurDetVO : renFurDetSvc.getOneList(renFurAppVO.getRfa_no())) {
															//出租日期不為空值 且 帳單日期在出租日期之後
															if(renFurDetVO.getRent_date() != null && renFurDetVO.getRent_date().getTime() < billVO.getBill_date().getTime()) {
																//家具品項租金
																int fnt_price = furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.getFnt_id()).getFnt_it_no()).getFnt_price();
																cal.setTime(renFurDetVO.getRent_date()); //將出租日期轉為Calendar
																int year_rent = cal.get(Calendar.YEAR); //出租日期年份
																int month_rent = cal.get(Calendar.MONTH); //出租日期月份
																int dayOfMonth_rent = cal.get(Calendar.DATE); //出租日期為當月第幾天
																cal.set(Calendar.DATE, 1); //把日期設定為當月第一天
																cal.roll(Calendar.DATE, -1); //日期回滾一天，也就是最後一天
															    int totalDaysOfMonth_rent = cal.get(Calendar.DATE); //出租日期當月總天數
																//如解約日期為空值 或 解租日期在帳單日期之後
																if(renFurDetVO.getRent_tmt_date() == null || renFurDetVO.getRent_tmt_date().getTime() > billVO.getBill_date().getTime()) {
																    int betweenMonth = (year_bill - year_rent)*12 + (month_bill - month_rent); //帳單日期與出租日期相差月份
																    if(betweenMonth == 1) {
																    	//按天數計算租金,int轉為double相除才會有小數
																    	int partOf_fnt_price = (int)Math.floor((double)(totalDaysOfMonth_rent - dayOfMonth_rent + 1) / (double)totalDaysOfMonth_rent * fnt_price);
																	    raf_total += partOf_fnt_price;
																	} else {
																		raf_total += fnt_price;
																	}
																//解租日期在帳單日期之前
																}else {
																	cal.setTime(renFurDetVO.getRent_tmt_date()); //將解租日期轉為Calendar
																	int year_tmt = cal.get(Calendar.YEAR); //解租日期年份
																	int month_tmt = cal.get(Calendar.MONTH); //解租日期月份
																	int dayOfMonth_tmt = cal.get(Calendar.DATE); //解租日期為當月第幾天
																	cal.set(Calendar.DATE, 1); //把日期設定為當月第一天
																	cal.roll(Calendar.DATE, -1); //日期回滾一天，也就是最後一天
																    int totalDaysOfMonth = cal.get(Calendar.DATE); //解租日期當月總天數
																  	
																	int betweenMonth = (year_bill - year_tmt)*12 + (month_bill - month_tmt); //帳單日期與解租日期相差月份
																	
																    if(betweenMonth == 1) {
																    	//當月租當月退的情況
																    	if(year_rent == year_tmt && month_rent == month_tmt){
																    		int betweenDay = dayOfMonth_tmt - dayOfMonth_rent;
																    		//按天數計算租金,int轉為double相除才會有小數
																    		int partOf_fnt_price = (int)Math.floor((double)betweenDay / (double)totalDaysOfMonth * fnt_price);
																		    raf_total += partOf_fnt_price;
																    	}else {
																			//按天數計算租金,int轉為double相除才會有小數
																		    int partOf_fnt_price = (int)Math.floor((double)dayOfMonth_tmt / (double)totalDaysOfMonth * fnt_price);
																		    raf_total += partOf_fnt_price;
																    	}
																	}
																}
															}
														}
													}
												}
												%>
												<td><%=raf_total%> 元</td>
												<td><%=billVO.getBill_p_status() == 0 ? "未繳費" : "已繳費"%></td>
												<td><%=billVO.getBill_p_status() == 0 ? "未繳費" : "已繳費"%></td>
											</tr>
										<%}%>
									</tbody>
								</table>
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
    
    <script>
    	$(".auto-insert").click(function(){
    		$.ajax({
    			url:"<%=request.getContextPath()%>/bill/bill.do",
    			type:'post',
    			data:{
    				action:'autoInsert'
    			},
    			success:function(amountOfInsert){
    				alert("成功新增" + amountOfInsert + "筆帳單");
    			}
    		});
    	});
    </script>
     
</body>

</html>
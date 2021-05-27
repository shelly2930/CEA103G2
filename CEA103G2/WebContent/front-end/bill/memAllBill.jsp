<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
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

<html>
<head>

<%-- <jsp:useBean id="renFurAppSvc" scope="page" class="com.renFurApp.model.RenFurAppService" /> --%>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<title>查看租家具申請單</title>

<style>
/* body {  */
/* background-color: #dddddd !important; */
/* } */

.genric-btn.info {
    color: #fff;
    background: #61d2b4 !important;
    border: 1px solid transparent;
    font-size: 16px;
    width: 80px;
    height: 40px;
    margin: 5px;

}

.genric-btn.radius {
    border-radius: 20px !important;
}

.genric-btn {
	line-height:2 !important;
}

.genric-btn.info:hover {
    color: #38a4ff;
    border: 1px solid #38a4ff;
    background: #fff !important;
}

table:hover{
	cursor: pointer;
}
tr:hover{
	background-color: #eeeeee;
}
</style>

</head>
<body>
<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>

<!--================ Content Area start =================-->
<section class="cat_product_area section_padding">
	<div class="container">
		<div class="row">
            <!--================ Sidebar =================-->    
			<%@include file="/front-end/sidebarFront.file"%>
                
            <div class="col-lg-10 content">
                
                <!--================ 不要的話自己刪掉 =================-->
                <div class="pagetitle">每月帳單</div>
				
				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
				<div class="table-responsive-lg">
					<a href="<%=request.getContextPath()%>/front-end/bill/memAllBill.jsp?bill_p_status=0" class="genric-btn info radius">未繳費</a>
					<a href="<%=request.getContextPath()%>/front-end/bill/memAllBill.jsp?bill_p_status=1" class="genric-btn info radius">已繳費</a>
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>帳單期別</th>
								<th>會員姓名</th>
								<th>繳費期限</th>
<!-- 								<th>租屋費用</th> -->
<!-- 								<th>租家具費用</th> -->
								<th>總金額</th>
								<th>繳費狀態</th>
								<th style="display:none;">查看</th>
							</tr>
						</thead>
						<tbody>
							<%
							BillService billSvc = new BillService();
							HouseService houseSvc = new HouseService();
							List<BillVO> list = billSvc.getAll();
							Set<String> set = new LinkedHashSet<String>();
							MemTenVO memTenVO = (MemTenVO)session.getAttribute("MemTenVO");
							Byte bill_p_status = new Byte(request.getParameter("bill_p_status"));
							for(BillVO billVO : list){
								if(billVO.getMem_no().equals(memTenVO.getMem_no()) && billVO.getBill_due() != null){
									if(billVO.getBill_p_status().equals(bill_p_status)){
										set.add(billVO.getMem_no() + "," + billVO.getBill_date().toString());
									}
								}
							}
// 							System.out.println("list.size() = "+list.size());
// 							System.out.println("set.size() = "+set.size());
							for(String str : set){
								Integer mem_no = new Integer(str.substring(0,str.indexOf(",")));
								Date bill_date = Date.valueOf(str.substring(str.indexOf(",") + 1));
								int hos_total = 0;
								int fur_total = 0;
								List<BillVO> billVOs = billSvc.getMemMonthlyBill(mem_no, bill_date);
								for(BillVO aBill : billVOs){
									hos_total += Integer.parseInt(billSvc.getHousePeriodAndMoney(aBill).get("money"));
									hos_total += aBill.getBill_power() * houseSvc.getOneHouse(aBill.getHos_no()).getHos_power();
									hos_total += aBill.getBill_water() * houseSvc.getOneHouse(aBill.getHos_no()).getHos_water();
								}
								for(RenFurAppVO renFurAppVO : billSvc.getCurrentRenFurApp(billVOs.get(0))){
									for(RenFurDetVO renFurDetVO : new RenFurDetService().getOneList(renFurAppVO.getRfa_no())){
										fur_total += Integer.parseInt(billSvc.getRenFurDetPeriodAndMoney(renFurDetVO, billVOs.get(0)).get("money"));
									}
								}
								int total = hos_total + fur_total;
							%>
								<tr>
									<td class="view"><fmt:formatDate value="<%=bill_date%>" pattern="yyyyMM"/></td>
									<td class="view"><%=new MemTenService().getOneMemTen(mem_no).getMem_name()%></td>
									<td class="view" id="<%=mem_no+"-"+bill_date%>"><%=billVOs.get(0).getBill_due() == null ? "" : billVOs.get(0).getBill_due()%></td>
<%-- 									<td class="view"><%=hos_total%></td> --%>
<%-- 									<td class="view"><%=fur_total%></td> --%>
									<td class="view">$ <%=total%></td>
									<td class="view"><%=billVOs.get(0).getBill_p_status() == 0 ? "未繳費" : "已繳費"%></td>
									<td style="display:none;">
										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/bill/bill.do">
											<button type="submit" class="btn btn-outline-danger">查看</button>
											<input type="hidden" name="mem_no" value="<%=mem_no%>">
											<input type="hidden" name="bill_date" value="<%=bill_date%>">
											<input type="hidden" name="action" value="get_Mem_Bill">
										</FORM>
									</td>
								</tr>
							<%}%>
						</tbody>
					</table>
				</div>
				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
							
            </div>
        </div>
    </div>
</section>

<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<script>
$(".view").click(function(){
	$(this).parent().find("form").submit();
});
</script>

</body>

<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

</html>
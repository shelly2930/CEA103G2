<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.bill.model.*"%>
<%@ page import="com.renFurApp.model.*"%>
<%@ page import="com.renFurDet.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furLis.model.*"%>





<%-- <jsp:useBean id="renFurDetSvc" class="com.renFurDet.model.RenFurDetService"/> --%>
<jsp:useBean id="houseSvc" class="com.house.model.HouseService"/>
<%-- <jsp:useBean id="furLisSvc" class="com.furlis.model.FurlisService"/> --%>
<%-- <jsp:useBean id="furIteSvc" class="com.furIte.model.FurIteService"/> --%>
<jsp:useBean id="renConSvc" class="com.renCon.model.RenConService"/>


<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>�Ыȱb��</title>

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

                <!--�@�@�@�����������������������e���������������������@�@�@-->
                <div class="container-fluid">
					
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">�Ҧ��Ыȱb��</h6>
							<ul>
  								<li><a href='addBill.jsp'>Add</a> a new Bill.</li>
							</ul>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>�b��s��</th>
											<th>�|���s��</th>
											<th>����s��</th>
											<th>�b����</th>
											<th>ú�O����</th>
											<th>����</th>
											<th>�ιq�q</th>
											<th>�Τ��q</th>
											<th>���a���`�O��</th>
											<th>�Ы�ú�O���A</th>
											<th>�ЪF���ڪ��A</th>
										</tr>
									</thead>
									<tbody>
										<%
										BillService billSvc = new BillService();
										List<BillVO> list = billSvc.getAll();
										for(BillVO billVO : list){ %>
											<tr>
												<td><%=billVO.getBill_no()%></td>
												<td><%=billVO.getMem_no()%></td>
												<td><%=billVO.getHos_no()%></td>
												<td><fmt:formatDate value="<%=billVO.getBill_date()%>" pattern="yyyy-MM"/></td>
												<td><fmt:formatDate value="<%=billVO.getBill_due()%>" pattern="yyyy-MM-dd"/></td>
												<td>
<%-- 													<c:forEach var="houseVO" items="${houseSvc.all}"> --%>
<%--                     									<c:if test="${billVO.hos_no == houseVO.hos_no}"> --%>
<%-- 	                    									${houseVO.hos_rent} --%>
<%--                     									</c:if> --%>
<%--                     								</c:forEach> --%>
												</td>
												<td><%=billVO.getBill_power()%></td>
												<td><%=billVO.getBill_water()%></td>
												<%
												RenFurAppService renFurAppSvc = new RenFurAppService();
												RenFurDetService renFurDetSvc = new RenFurDetService();
												FurIteService furIteSvc = new FurIteService();
												FurLisService furLisSvc = new FurLisService();
												for(RenFurAppVO renFurAppVO = renFurAppSvc.getAll()) {
													int raf_total = 0; //�C�믲���X�p
													for(RenFurDetVO renFurDetVO = renFurDetSvc.getOneList(renFurAppVO.getRfa_no())){
														int fnt_price = furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.getFnt_id()).getFnt_it_no()).getFnt_price(); //�a��~������
														if(renFurDetVO.getRent_tmt_date() == null){ //�p�Ѭ�������ŭ�
															raf_total += fnt_price;
														}else {
															Calendar cal = Calendar.getInstance();
															cal.setTime(renFurDetVO.getRent_tmt_date()); //�N�Ѭ�����ରCalendar
															int dayOfMonth = cal.get(Calendar.DATE); //�Ѭ���������ĴX��
															cal.set(Calendar.DATE, 1); //�����]�w�����Ĥ@��
															cal.roll(Calendar.DATE, -1); //����^�u�@�ѡA�]�N�O�̫�@��
														    int totalDaysOfMonth = cal.get(Calendar.DATE); //�Ѭ��������`�Ѽ�
															if((new Date().getTime() - renFurDetVO.getRent_tmt_date().getTime()) / (24*60*60*1000) < totalDaysOfMonth) { //�p��U�ɶ��P�Ѭ�����ۮt�ѼƤp���`�Ѽ�
															    int partOf_fnt_price = (int)Math.floor((double)dayOfMonth / (double)totalDaysOfMonth * fnt_price); //���Ѽƭp�⯲��,int�ରdouble�۰��~�|���p��
															    raf_total += partOf_fnt_price;
															}
														}
													}
												%>
												<td> <%=raf_total %> ��<td>
												<%}%>
												<td><%=billVO.getBill_p_status() == 0 ? "��ú�O" : "�wú�O"%></td>
												<td><%=billVO.getBill_p_status() == 0 ? "��ú�O" : "�wú�O"%></td>
											</tr>
										<%}%>
									</tbody>
								</table>
							</div>
						</div>
					</div>
                	

                </div>
                <!--�@�@�@�����������������������e���������������������@�@�@-->

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
     
</body>

</html>
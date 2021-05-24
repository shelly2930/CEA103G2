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
										for(BillVO billVO : list){ 
										%>
											<tr>
												<td><%=billVO.getBill_no()%></td>
												<td><%=new MemTenService().getOneMemTen(billVO.getMem_no()).getMem_name()%></td>
												<td><fmt:formatDate value="<%=billVO.getBill_date()%>" pattern="yyyy-MM"/></td>
												<td><fmt:formatDate value="<%=billVO.getBill_due()%>" pattern="yyyy-MM-dd"/></td>
												<%
												RenConService renConSvc = new RenConService();
												HouseService houseSvc = new HouseService();
// 												List<RenConVO> list_RenConVO = renConSvc.getAllCon(new Byte("2"), billVO.getMem_no());
												List<RenConVO> list_RenConVO = renConSvc.getAll();
												int hr_total = 0; //���ΦX�������X�p
												for(RenConVO renConVO : list_RenConVO){
													//�X���|���s�� ���� �b��|���s��
													if(renConVO.getMem_no() == billVO.getMem_no()){
														int hos_rent = houseSvc.getOneHouse(renConVO.getHos_no()).getHos_rent();
														//�X�����A��2��4��5
														if(renConVO.getRtct_status() == 2 || renConVO.getRtct_status() == 4 || renConVO.getRtct_status() == 5) {
															//�X���Ѭ��鬰�ŭ� �� �X���Ѭ���b�b��������
															if(renConVO.getRtct_tmt_date() == null || renConVO.getRtct_tmt_date().getTime() > billVO.getBill_date().getTime()){
																Calendar cal = Calendar.getInstance();
																cal.setTime(renConVO.getRtct_eff_date()); //�N�X���_�l���ରCalendar
																int dayOfMonth = cal.get(Calendar.DATE); //�X���_�l�鬰���ĴX��
																cal.set(Calendar.DATE, 1); //�����]�w�����Ĥ@��
																cal.roll(Calendar.DATE, -1); //����^�u�@�ѡA�]�N�O�̫�@��
															    int totalDaysOfMonth = cal.get(Calendar.DATE); //�X���_�l�����`�Ѽ�
															  	//�p�b��ɶ��P�X���_�l��ۮt�ѼƤp���`�Ѽ�
															    if((billVO.getBill_date().getTime() - renConVO.getRtct_eff_date().getTime()) / (24*60*60*1000) < totalDaysOfMonth) {
															    	//���Ѽƭp�⯲��,int�ରdouble�۰��~�|���p��
															    	int partOf_hos_rent = (int)Math.floor((double)dayOfMonth / (double)totalDaysOfMonth * hos_rent);
																    hr_total += partOf_hos_rent;
																} else {
																	hr_total += hos_rent;
																}
															} else {
																Calendar cal = Calendar.getInstance();
																cal.setTime(renConVO.getRtct_tmt_date()); //�N�X���Ѭ����ରCalendar
																int dayOfMonth = cal.get(Calendar.DATE); //�X���Ѭ��鬰���ĴX��
																cal.set(Calendar.DATE, 1); //�����]�w�����Ĥ@��
																cal.roll(Calendar.DATE, -1); //����^�u�@�ѡA�]�N�O�̫�@��
															    int totalDaysOfMonth = cal.get(Calendar.DATE); //�X���Ѭ������`�Ѽ�
																//�p�b��ɶ��P�X���Ѭ���ۮt�ѼƤp���`�Ѽ�
															    if((billVO.getBill_date().getTime() - renConVO.getRtct_tmt_date().getTime()) / (24*60*60*1000) < totalDaysOfMonth) {
															    	//���Ѽƭp�⯲��,int�ରdouble�۰��~�|���p��
															    	int partOf_hos_rent = (int)Math.floor((double)dayOfMonth / (double)totalDaysOfMonth * hos_rent);
																    hr_total += partOf_hos_rent;
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
												int raf_total = 0; //�C��a�㯲���X�p
												for(RenFurAppVO renFurAppVO : renFurAppSvc.getAll()) {
													if(renFurAppVO.getMem_no() == billVO.getMem_no()) {
														for(RenFurDetVO renFurDetVO : renFurDetSvc.getOneList(renFurAppVO.getRfa_no())) {
															//�X����������ŭ� �B �b�����b�X���������
															if(renFurDetVO.getRent_date() != null && renFurDetVO.getRent_date().getTime() < billVO.getBill_date().getTime()) {
																//�a��~������
																int fnt_price = furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.getFnt_id()).getFnt_it_no()).getFnt_price();
																//�p�Ѭ�������ŭ� �� �ѯ�����b�b��������
																if(renFurDetVO.getRent_tmt_date() == null || renFurDetVO.getRent_tmt_date().getTime() > billVO.getBill_date().getTime()) {
 																	Calendar cal = Calendar.getInstance();
																	cal.setTime(renFurDetVO.getRent_date()); //�N�X������ରCalendar
																	int dayOfMonth = cal.get(Calendar.DATE); //�X����������ĴX��
																	cal.set(Calendar.DATE, 1); //�����]�w�����Ĥ@��
																	cal.roll(Calendar.DATE, -1); //����^�u�@�ѡA�]�N�O�̫�@��
																    int totalDaysOfMonth = cal.get(Calendar.DATE); //�X���������`�Ѽ�
																  	//�p�b��ɶ��P�X������ۮt�ѼƤp���`�Ѽ�
																    if((billVO.getBill_date().getTime() - renFurDetVO.getRent_date().getTime()) / (24*60*60*1000) < totalDaysOfMonth) {
																    	//���Ѽƭp�⯲��,int�ରdouble�۰��~�|���p��
																    	int partOf_fnt_price = (int)Math.floor((double)dayOfMonth / (double)totalDaysOfMonth * fnt_price);
																	    raf_total += partOf_fnt_price;
																	} else {
																		raf_total += fnt_price;
																	}
																// �b�����b�ѯ�������� �B �X������P�ѯ�������P���
																} else if(renFurDetVO.getRent_tmt_date().getTime() < billVO.getBill_date().getTime() 
																		&& renFurDetVO.getRent_date().getMonth() != renFurDetVO.getRent_tmt_date().getMonth()) {
																	Calendar cal = Calendar.getInstance();
																	cal.setTime(renFurDetVO.getRent_tmt_date()); //�N�ѯ�����ରCalendar
																	int dayOfMonth = cal.get(Calendar.DATE); //�ѯ���������ĴX��
																	cal.set(Calendar.DATE, 1); //�����]�w�����Ĥ@��
																	cal.roll(Calendar.DATE, -1); //����^�u�@�ѡA�]�N�O�̫�@��
																    int totalDaysOfMonth = cal.get(Calendar.DATE); //�ѯ��������`�Ѽ�
																  	//�p�b�����P�ѯ�����ۮt�ѼƤp���`�Ѽ�
																	if((billVO.getBill_date().getTime() - renFurDetVO.getRent_tmt_date().getTime()) / (24*60*60*1000) < totalDaysOfMonth) {
																		//���Ѽƭp�⯲��,int�ରdouble�۰��~�|���p��
																	    int partOf_fnt_price = (int)Math.floor((double)dayOfMonth / (double)totalDaysOfMonth * fnt_price);
																	    raf_total += partOf_fnt_price;
																	}
																// �b�����b�ѯ�������� �B �X������P�ѯ�����P���
																} else {
																	Calendar cal = Calendar.getInstance();
																	cal.setTime(renFurDetVO.getRent_date()); //�N�X������ରCalendar
																	int dayOfMonth = cal.get(Calendar.DATE); //�X����������ĴX��
																	cal.setTime(renFurDetVO.getRent_tmt_date()); //�N�ѯ�����ରCalendar
																	int dayOfMonth_tmt = cal.get(Calendar.DATE); //�ѯ���������ĴX��
																	cal.set(Calendar.DATE, 1); //�����]�w�����Ĥ@��
																	cal.roll(Calendar.DATE, -1); //����^�u�@�ѡA�]�N�O�̫�@��
																    int totalDaysOfMonth = cal.get(Calendar.DATE); //����`�Ѽ�
																 	//�p�b��ɶ��P�ѯ�����ۮt�ѼƤp���`�Ѽ�
																	if((billVO.getBill_date().getTime() - renFurDetVO.getRent_tmt_date().getTime()) / (24*60*60*1000) < totalDaysOfMonth) {
																		//�ѯ�����P�X������۴��X�X���Ѽ�,���Ѽƭp�⯲��,int�ରdouble�۰��~�|���p��
																		int partOf_fnt_price = (int)Math.floor((double)(dayOfMonth_tmt - dayOfMonth) / (double)totalDaysOfMonth * fnt_price);
																	    raf_total += partOf_fnt_price;
																	}
																}
															}
														}
													}
												}
												%>
												<td><%=raf_total%> ��</td>
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
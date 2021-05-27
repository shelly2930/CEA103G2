<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>���Υӽмf��</title>

   <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
	 <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>

<style>
input.btn.btn-primary {
	margin:0px 10px 10px 10px;
}

img.mem_pic {
	width:200px;
	height:auto;
}
</style>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <%@include file="/back-end/includeFile/sidebarBack.file"%>

         <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

				<!-- Topbar -->
                <%@include file="/back-end/includeFile/topbarBack.file"%>

                <!--�@�@�@�����������������������e���������������������@�@�@-->
                <div class="container-fluid">
					<h1 class="h3 mb-2 text-gray-800">���μf��</h1>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <a href="${pageContext.request.contextPath}/RenConServlet?action=findByStatus&rtct_status=0">
<!--                        �q���޿�P�_��(A�BB)��C -->
                            <button class="btn-sm btn btn${not empty list &&list.get(0).rtct_status==0?'':'-outline'}-info">	
                            	���f��
                            </button>
                            </a>
                            <a href="${pageContext.request.contextPath}/RenConServlet?action=findByStatus&rtct_status=1">
                           	<button class="btn-sm btn btn${not empty list && list.get(0).rtct_status==1?'':'-outline'}-info">
                           		�q�L��ú�O
                            </button>
                            </a>
                            
<%--                             <a href="${pageContext.request.contextPath}/RenConServlet?action=findByStatus&rtct_status=2"> --%>
<%--                             <button class="btn-sm btn btn${not empty list && list.get(0).rtct_status==2?'':'-outline'}-info"> --%>
<!--                             	�q�L�wú�O -->
<!--                             </button> -->
<!--                             </a> -->
                            <a href="${pageContext.request.contextPath}/RenConServlet?action=findByStatus&rtct_status=3">
                            <button class="btn-sm btn btn${not empty list && list.get(0).rtct_status==3?'':'-outline'}-info">
                            	���q�L
                            </button>
                            </a>
<%--                             <a href="${pageContext.request.contextPath}/RenConServlet?action=findByStatus&rtct_status=4"> --%>
<%--                             <button class="btn-sm btn btn${not empty list && list.get(0).rtct_status==4?'':'-outline'}-info"> --%>
<!--                             	�w�Ѭ� -->
<!--                             </button> -->
<!--                             </a> -->
                            
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <form method="post" action="<%=request.getContextPath()%>/RenConServlet">
                            		<input type="hidden" name="action" value="updateStatus">
									<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
									<input type="submit" class="btn btn-primary" value="�q�L" name="pass">
									<input type="submit" class="btn btn-primary" value="���q�L" name="fail">
                                    <thead>
                                        <tr>
                                            <th id="check">
                                            	�Ŀ�
                                            </th>
                                            <th>����</th>
                                            <th>�|��</th>
                                            <th>�X��</th>
                                            <th>�_�l��</th>
                                            <th>�פ��</th>
                                            <th>�Ѭ��� </th>
                                            <th>�ӽЮɶ�</th>
                                            <th>���A</th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="renConVO" items="${list}" varStatus="counter">
                                        <tr id="${renConVO.hos_no}">
											<td style="${renConVO.rtct_status == 1 || renConVO.rtct_status == 2 || renConVO.rtct_status == 3 || renConVO.rtct_status == 4 ?'display:none':''}">
												<input type="checkbox" id="${renConVO.rtct_no}input" name="no" value="${renConVO.rtct_no}">
											</td>
											
                                            <td>
                                            	<button id="house" class="btn btn-success btn-sm"  data-toggle="modal" data-target="#a">����${renConVO.hos_no}</button>
                                            </td>
                                            <td id="${renConVO.mem_no}">
                                             	<button id="member" class="btn btn-warning btn-sm"  data-toggle="modal" data-target="#mem">�|��${renConVO.mem_no}</button>
                                            </td>

                                            <td>${renConVO.rtct_no}</td>
                                            <td>${renConVO.rtct_eff_date}</td>
                                            <td>${renConVO.rtct_tmt_date}</td>
                                            <td>${renConVO.rtct_end_date}</td>
                                            <td>${renConVO.rtct_apptime}</td>
                                            <td>
                                            	<c:choose>
													<c:when test="${renConVO.rtct_status == 0}">���f��</c:when>
													<c:when test="${renConVO.rtct_status == 1}">��ú�O</c:when>
													<c:when test="${renConVO.rtct_status == 2}">�wú�O</c:when>
													<c:when test="${renConVO.rtct_status == 3}">���q�L</c:when>
													<c:when test="${renConVO.rtct_status == 4}">�w�Ѭ�</c:when>
												</c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                     </form>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>	
					
                </div>
                <!--�@�@�@�����������������������e���������������������@�@�@-->
               
				
				<!-- Modal -->
				
				<!--�@�@�@���������������������u�X���������������������@�@�@-->
				
				<!--�@�@�@���������������������u�X�����������������������@�@�@-->
					<!-- Button trigger modal -->
					<div class="modal fade" id="mem" tabindex="-1" role="dialog" aria-labelledby="#c" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="c">Modal title</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					      <table class="table table-bordered">
					      	<thead>
                            <tr>
                               <th>����s��</th>
                               <td>�Z�n���A</td>
                            </tr>
                            </thead>
					        <tbody id="showOneMember">
                            <tr>
                            </tr>
                            </tbody>
                           </table>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					      </div>
					    </div>
					  </div>
					</div>
					<!-- Modal -->
					<div class="modal fade" id="a" tabindex="-1" role="dialog" aria-labelledby="#b" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="b">Modal title</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					      <table class="table table-bordered">
					      	<thead>
                            <tr>
                               <th>����s��</th>
                               <th>�Z�n���A</th>
                            </tr>
                            </thead>
					        <tbody id="showOneHouse">
                            <tr>
                            </tr>
                            </tbody>
                           </table>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					      </div>
					    </div>
					  </div>
					</div>
				 <!--�@�@�@���������������������u�X�����������������������@�@�@-->
				
				
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@include file="/back-end/includeFile/footerBack.file"%>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <%@include file="/back-end/includeFile/otherBack.file" %>
    
<!--     Bootstrap core JavaScript -->
   
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!--     Core plugin JavaScript -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

<!--     Custom scripts for all pages -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

<!--     Page level plugins -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>
    
	
	<script>
		let house_value = ['hos_no','lld_no','hos_name','hos_rent','hos_expense','hos_date','hos_city',
							'hos_dist','hos_address','hos_type','hos_info','hos_age','hos_floor','hos_ele',
							'hos_parking','hos_pet','hos_cook','hos_squares','hos_gender','hos_water','hos_power',
							'hos_internet','emp_no',
							'hos_state'];
		
		let house_key = ['����s��','�ЪF�s��','����W��','���󯲪�','�޲z�O','�Z�n���','����',
							'�m��[��]��','�a�}','�Ы�','����','����','�Ӽh','�q��P�_',
							'������P�_','�d���P�_','�N���P�_','�W��','�ʧO����','���O/�@��','�q�O/�@��',
							'�����O','���u�s��',
							'�Z�n���A'];
		
		$("button[id='house']").click(function(e1){
			e1.preventDefault();
			$("#b").text('�s��'+$(this).parent().parent().attr('id')+'����Ա�');
			$.ajax({
				url:"<%=request.getContextPath()%>/HouseJsonServlet",
				type:"post",
				data:{
					action:'getOneHouse',
					houseno:$(this).parent().parent().attr('id'),
				},
				success:function(jsonStr){
					for(let i =0;i<house_key.length;i++){
						$("#showOneHouse tr:last-child").after("<tr scope='col'><th >"+house_key[i]+"</th><th id='"+house_value[i]+"'>"+jsonStr[house_value[i]]+"</th></tr>");
					}
					$("#hos_internet").text("������");
					$("#hos_power").append("��");
					$("#hos_water").append("��");
					if($("#hos_gender").text()==0){
						$("#hos_gender").text("����");
					}else if($("#hos_gender").text()==1){
						$("#hos_gender").text("����: �k");
					}else{
						$("#hos_gender").text("����: �k");
					}
					
					if($("#hos_type").text()==0){
						$("#hos_type").text("����");
					}else if($("#hos_type").text()==1){
						$("#hos_type").text("�W�߮M��");
					}else if($("#hos_type").text()==2){
						$("#hos_type").text("�����M��");
					}else if($("#hos_type").text()==3){
						$("#hos_type").text("����");
					}else if($("#hos_type").text()==4){
						$("#hos_type").text("��h��a");
					}else if($("#hos_type").text()==5){
						$("#hos_type").text("����");
					}else{
						$("#hos_type").text("��L");
					}
					
					$("#hos_squares").append("�W");
					$("#hos_cook").text("�i����");
					$("#hos_pet").text("�i����");
					$("#hos_parking").text("������");
					$("#hos_ele").text("������");
					$("#hos_age").append("�~");
					$("#hos_floor").append("��");
					$("#hos_date").text(dateformat($("#hos_date").text()));
					$("#hos_rent").append("��");
					$("#lld_no").text(getMem(getlld($("#lld_no").text()).mem_no).mem_name);
					}
				});
		})
		
		
		let member_value = ['mem_no','mem_username','mem_name','mem_gender','mem_id','mem_birthday','mem_phone','mem_mobile','mem_email',
							'mem_city','mem_dist','mem_addr','mem_idcard_f','mem_idcard_r','mem_id_status'];
		
		let member_key = ['�|���s��','�b��','�m�W','�ʧO','�����Ҧr��','�X�ͦ~���','�s���q��','��ʹq��',
							'�q�l�H�c','����','�m����','�a�}','�����ҥ���','�����ҭI��','�����f�֪��A'];
	
		$("button[id='member']").click(function(e){
			e.preventDefault();
			$("#c").text('�s��'+$(this).parent().attr('id')+'�|�����');
			$.ajax({
				url:"<%=request.getContextPath()%>/MemTenJsonServlet",
				type:"post",
				data:{
					action:'getOneMember',
					mem_no:$(this).parent().attr('id'),
				},
				success:function(jsonStr){
					for(let i =0;i<member_key.length;i++){
						 if(i==12){
						  $("#showOneMember tr:last-child").after('<tr><th>'+member_key[i]+
								  '</th><td><img class="mem_pic" src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?mem_no='+jsonStr[member_value[0]]+'&action=getidcardf"></td></tr>');
						 }else if(i==13){
						  $("#showOneMember tr:last-child").after('<tr><th>'+member_key[i]+
								  '</th><td><img class="mem_pic" src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?mem_no='+jsonStr[member_value[0]]+'&action=getidcardr"></td></tr>');
						 }else{
						  $("#showOneMember tr:last-child").after('<tr><th>'+member_key[i]+'</th><td>'+jsonStr[member_value[i]]+'</td></tr>');
						 }
					}
				
				}
			});
			
		})
		
// 		$("button[id='member']").click(function(e){
// 			e.preventDefault();
// 			$("#c").text('�s��'+$(this).parent().attr('id')+'�|�����');
			
// 			$.ajax({
<%-- 				url:"<%=request.getContextPath()%>/MemTenJsonServlet", --%>
// 				type:"post",
// 				data:{
// 					action:'getOneMember',
// 					mem_no:$(this).parent().attr('id'),
// 				},
// 				success:function(jsonStr){
// // 					$("#showOneMember").empty();

// // 					for(let mem of jsonStr){
// // 						let str = "<tr id='"+con.mem_no+"' class='"+con.hos_no+"'>";
// // 						str+="<th>";
// // 						str+=""+getMem(con.mem_no);
// // 						str+="</th>";
// // 						str+="<td>";
// // 						str+=""+getHouse(con.hos_no).hos_address;
// // 						str+="</td>";
// // 						str+="<td id='"+con.rtct_no+"'>";
// // 						str+="<a href='' style='color:#8C8CFF;font-weight:bold;' class='contract'>"+con.rtct_no+"�X��</a>";
// // 						str+="</td>";
// // 						str+="<td>";
// // 						str+="<a href='' style='color:#A1A1A1;font-weight:bold;' class='signature'>Click</a>";
// // 						str+="</td>";
// // 						str+="<td>";
// // 						str+=""+con.rtct_eff_date;
// // 						str+="</td>";
// // 						str+="<td>";
// // 						str+=""+con.rtct_end_date;
// // 						str+="</td>";
// // 						if(con.rtct_status==4 && status!=999){
// // 							str+="<td>";
// // 							str+="<a href='' class='cancelcon' style='color:#FF8C8C;font-weight:bold;'>����</a>";
// // 							str+="</td>";
// // 							$("#cancelheader").show();
// // 							$("#cancelfooter").attr('colspan','7');
// // 						}else{
// // 							$("#cancelheader").hide();
// // 							$("#cancelfooter").attr('colspan','6');
// // 						}
// // 						str+="</tr>";
// // 						$("#showcon").append(str);
// // 					}
						
// 						$("#showOneMember tr:last-child").empty();
// 						str="";
// 						for(let i =0;i<member_key.length;i++){
// 							 if(i==12){
// 							  str+='<th>'+member_key[i]+
<%-- 									  '</th><td><img class="mem_pic" src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?mem_no='+jsonStr[member_value[0]]+'&action=getidcardf"></td>'; --%>
// 							 }else if(i==13){
// 							  str+='<th>'+member_key[i]+
<%-- 									  '</th><td><img class="mem_pic" src="<%=request.getContextPath()%>/memTen/memPicReadServlet.do?mem_no='+jsonStr[member_value[0]]+'&action=getidcardr"></td>'; --%>
// 							 }else{
// 							  str+='<th>'+member_key[i]+'</th><td>'+jsonStr[member_value[i]]+'</td>';
// 							 }
// 						}
					
// 						 $("#showOneMember tr:last-child").append(str);
// 				}
// 			});
			
// 		})
		
		// ��checkbox��td����
		if(${(empty list)||(list[0].rtct_status!= 0)}){
			$("#check").attr("style",'display:none');
			$("input[value='�q�L']").attr("style",'display:none');
			$("input[value='���q�L']").attr("style",'display:none');
		}
 </script>
	

</body>

</html>
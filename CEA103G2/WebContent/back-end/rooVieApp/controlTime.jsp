<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>��x�ŭ�</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top" onload="connect();" onunload="disconnect();">

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
                
                <div class="card shadow mb-4">
                      <div class="card-header py-3">
                          <h6 id='total_roovieapp_title' class="m-0 font-weight-bold text-primary">�Ҧ�����w���ɶ��]�w</h6>
                      </div>
                      <div id='total_roovieapp_content' class="card-body">
                     </div>
               	</div>
                
                <div class="card shadow mb-4">
                      <div class="card-header py-3">
                          <h6 id='roovieapp_title' class="m-0 font-weight-bold text-primary">�Ӫ���w�����p</h6>
                      </div>
                      <div id='roovieapp_content' class="card-body">
                     </div>
               	</div>
                
                
                <div class="card shadow mb-4">
                      <div class="card-header py-3">
                          <h6 id='roovieapp_title' class="m-0 font-weight-bold text-primary">�]�w �w���ɶ�</h6>
                      </div>
                      <div id='roovieapp_content' class="card-body">
                          
		                <div class="col-lg-12">
		                	<label><sapn>�{�b�_�X�p�ɤ����i�w��(�w�磌��)</sapn>	
		                    <input type="number" name="freeTimeToSee" min='0' max='23'  style="display:inline-block;width:30%;">
		                    </label>
		                </div>
		                <div class="col-lg-8">
		                	<label><span>���u�W�Z�ɬq</span>:
		                    <input type="number" name="gotowork" min='0' max='23' value="0" style="display:inline-block;width:20%;"><span>��</span>
		                    <input type="number" name="gooffwork" min='0' max='23' value="23" style="display:inline-block;width:20%;">
		                    </label>
		                </div>
		                <div class="col-lg-12">
		                	<label>���i�w�������
		                    <input type="date" name="freedate" value=""  style="display:inline-block;">
		                    <input type="date" name="freedate" value=""  style="display:inline-block;">
		                    <input type="date" name="freedate" value=""  style="display:inline-block;">
		                    <input type="date" name="freedate" value=""  style="display:inline-block;">
		                    <input type="date" name="freedate" value=""  style="display:inline-block;">
		                    <input type="date" name="freedate" value=""  style="display:inline-block;">
		                    </label>
		                </div>

                     </div>
               	</div>
                
                
                
		<div class="container">
	            <div class="row">
					<div class="col-lg-12">
                        <div class="order_details_iner">
                            <h3>�w�������</h3>
                            <table  class="table table-borderless">
                                <thead>
                               		 <tr class="table-primary">
                               		 	<th id="prev" class="text-center">&lt;&lt;</th>
                                        <th id="month" scope="col" colspan="5" class="text-center">���</th>
                                        <th id="next" class="text-center">&gt;&gt;</th>
                                    </tr>
                                    <tr class="table-primary">
                                        <th class="text-center">�P����</th>
                                        <th class="text-center">�P���@</th>
                                        <th class="text-center">�P���G</th>
                                        <th class="text-center">�P���T</th>
                                        <th class="text-center">�P���|</th>
                                        <th class="text-center">�P����</th>
                                        <th class="text-center">�P����</th>
                                    </tr>
                                </thead>
                                <tbody>
                               		 <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate"  style="display:none;" class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                        <th class="text-center">
                                        	<label>
                                        		<button name="pickdate" style="display:none;"  class="btn btn-outline-info  btn-sm " aria-pressed="true"></button>
                                        	</label>
                                        </th>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th scope="col" colspan="7" class="text-center">Pick Date</th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
					</div>
				</div>
            </div>
                
                
                
                
                
                
                
                
                
    <div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			 <div class="modal-header">
				 <div style="margin"><h5 class="modal-title " id="exampleModalLabel">����n�w�����ɬq</h5></div>
				   <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				      <span aria-hidden="true">&times;</span>
				   </button>
					</div>
					<div class="modal-body">
					 	<section class="confirmation_part padding_top" style="padding-top:0px">
							<div class="container">
					                        <div class="order_details_iner" style="margin-top:0px">
					                            <table  class="table table-borderless">
					                                <thead>
					                                    <tr class="table-primary">
					                                        <th class="text-center" id="showdate"><span>�ɬq</span></th>
					                                        <th class="text-center"><span>�w��</span></th>
					                                    </tr>
					                                </thead>
					                                <tbody id="picktime">
					                               		 <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                     <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                     <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                    <tr>
					                                        <th class="text-center">
					                                        	<span name="timeTitle"></span>
					                                        </th>
					                                        <th class="text-center">
					                                        	<label>
					                                        		<input type="checkbox" name="picktime">
					                                        	</label>
					                                        </th>
					                                    </tr>
					                                </tbody>
					                                <tfoot>
					                                    <tr>
					                                        <th scope="col" colspan="2" class="text-center">Pick Date</th>
					                                    </tr>
					                                </tfoot>
					                            </table>
					                        </div>
					            </div>
					    	</section>
		    	
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
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>
	<script>
	
// 	//���W�@�Ӻ����Ǫ�querystring �ثe�u�ahouseno �Y�n�W�[�гB�z
	let queryString=location.search;
	let firstequalindex = queryString.indexOf("=");
	let houseno = queryString.substring(queryString.indexOf("=")+1);
// =======���ШD������ queryString	
	$("input[name='identity']").val(houseno);
//�d�߳o����ثe�]�w�ɶ� //**
	let obj = getlistcontroltime(houseno);
	function getlistcontroltime(houseno){
		let obj = {};
		$.ajax({
	    	url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
	    	type:"post",
	    	data:{
	    		action:"listControlTime",
	    		identity:""+houseno,
	    	},
	    	async: false,//�o��?
	    	success:function(jsonobj){
	    		let empno = jsonobj.sneder;
	    		if(empno==undefined){
	    			empno='���]�w'
	    		}
	    		obj.empno = empno;
	    		let freeTimeToSee = jsonobj.freeTimeToSee;
	    		obj.freeTimeToSee=freeTimeToSee;
	    		let gotowork = jsonobj.gotowork;
	    		obj.gotowork = gotowork;
	    		let gooffwork = jsonobj.gooffwork;
	    		obj.gooffwork= gooffwork;
	    		//set
	    		let freedate = jsonobj.freedate;
	    		$("#roovieapp_title").text("�ثe ����s��: "+houseno+" �w�����p");
	    		let text = "<p> �t�d���u : "+empno+"</p>"+
	    		"<p> �ثe�]�w�{�b�ɶ� : "+freeTimeToSee+" �p�ɥH�ᤣ�i�H�w��</p>"+
	    		"<p> ���u�W�Z�ɶ� : "+gotowork+" �� - "+gooffwork+" ��</p>";
	    		for(let x in freedate){
	    			if(freedate[x]!==""){
	    				text+="<p>�w�g�w���ɶ� :"+freedate[x]+"</p>";
	    			}
	    		}
	    		$("#roovieapp_content").html(text);
	    		$("input[name='freeTimeToSee']").attr('value',freeTimeToSee);
	    		$("input[name='gotowork']").attr('value',gotowork);
	    		$("input[name='gooffwork']").attr('value',gooffwork);
	    	}
	    });
		return obj;
	}
	
//�d�ߩҦ������l�]�w�ɶ�
	$.ajax({
    	url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
    	type:"post",
    	data:{
    		action:"listInitControlTime",
    	},
    	success:function(jsonobj){
    		let empno = jsonobj.sneder;
    		if(empno==undefined){
    			empno='���]�w'
    		}
    		let freeTimeToSee = jsonobj.freeTimeToSee;
    		let gotowork = jsonobj.gotowork;
    		let gooffwork = jsonobj.gooffwork;
    		//set
    		let freedate = jsonobj.freedate;
    		$("#total_roovieapp_title").text("�Ҧ������l�]�w");
    		$("<p> �t�d���u : "+empno+"</p>").appendTo("#total_roovieapp_content");
    		$("<p> �ثe�]�w�{�b�ɶ� : "+freeTimeToSee+" �p�ɥH�ᤣ�i�H�w��</p>").appendTo("#total_roovieapp_content");
    		$("<p> ���u�W�Z�ɶ� : "+gotowork+" �� - "+gooffwork+" ��</p>").appendTo("#total_roovieapp_content");
    		
    	}
    });
//���Ҧ������l��
// 	$.ajax({
<%--     	url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do", --%>
//     	type:"post",
//     	data:{
//     		action:"saveInitControlTime",
//     		freeTimeToSee :'5',
// 			gotowork : '6',
// 			gooffwork : '23',
//     	},
//     	success:function(jsonobj){
//     		alert("SUCCESS");
//     	}
//     });
	
	
	
	//���B�z
	$("input[name='freedate']").each(function(index){
		$(this).attr('min',new Date().toJSON().substring(0,10));
	})
    $("input[name='freedate']").change(function(){
    	$(this).attr('value',$(this).val());
    })
    
    
    $("input[name='gotowork']").mouseup(function(e){
    	$("input[name='gotowork']").attr('value',$(this).val());
    	let temp = $(this).val();
    	$.ajax({
    		url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
    		type:"post",
    		data:{
    			action:"saveControlTime",
    			freeTimeToSee:obj.freeTimeToSee,
    			gotowork:temp,
    			gooffwork:obj.gooffwork,
    			identity:houseno,
    		},
    		success:function(){
     			let tempobj = getlistcontroltime(houseno).freeTimeToSee;
     			obj.freeTimeToSee = obj.freeTimeToSee;
     			obj.gotowork = temp;
     			obj.gooffwork = obj.gooffwork;
     			addListener2(houseno,obj.freeTimeToSee,obj.gotowork,obj.gooffwork);
    			freshPickDateTB();
     			spancalender();
     			addListener();
     			
    		}
    	})
    })
     $("input[name='gooffwork']").mouseup(function(e){
    	 let temp = $(this).val();
     	$.ajax({
     		url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
     		type:"post",
     		data:{
     			action:"saveControlTime",
     			freeTimeToSee:obj.freeTimeToSee,
     			gooffwork:temp,
     			gotowork:obj.gotowork,
     			identity:houseno,
     		},
     		success:function(){
     			let tempobj = getlistcontroltime(houseno).freeTimeToSee;
     			obj.freeTimeToSee = obj.freeTimeToSee;
     			obj.gotowork = obj.gotowork;
     			obj.gooffwork = temp;
     			addListener2(houseno,obj.freeTimeToSee,obj.gotowork,obj.gooffwork);
     			freshPickDateTB();
     			spancalender();
     			addListener();
     		}
     	})
    })
    $("input[name='gooffwork']").click(function(){
         $(this).attr('min',$("input[name='gotowork']").attr("value"));
    })
    
    $("input[name='freeTimeToSee']").mouseup(function(e){
    	let temp = $(this).val();
    	$.ajax({
     		url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
     		type:"post",
     		data:{
     			action:"saveControlTime",
     			freeTimeToSee:temp,
     			identity:houseno,
     			gotowork:obj.gotowork,
 				gooffwork : obj.gooffwork,
     		},
     		success:function(){
     			let tempobj = getlistcontroltime(houseno).freeTimeToSee;
     			obj.freeTimeToSee = temp;
     			obj.gotowork = obj.gotowork;
     			obj.gooffwork = obj.gooffwork;
     			addListener2(houseno,obj.freeTimeToSee,obj.gotowork,obj.gooffwork);
     			freshPickDateTB();
	     		spancalender();
     			addListener();
     		}
     	})
    })
    
    
    spancalender();
	//���ͦ�
	function spancalender(){
		let choose = new Date();
//			���~
		let currentYear = choose.getFullYear();
//			�o�Ӥ�
		let currentMonth = choose.getMonth()+1;
//			����
		let currentDate = choose.getDate();
//			�o�Ӥ�Ĥ@��
		let currentMonthFirstDay = new Date(""+currentYear+"-"+currentMonth+"-1").getDay();//0������P���� ��l1��§���@
//			���~�o�Ӥ릳�X��
		let currentTotalDay = judgeDay(currentYear,currentMonth);
//			count�γ~
		let week = 0;
		$("#prev").click(function(){
			freshPickDateTB();
			if(currentMonth==1){
				currentYear--;
				currentMonth=13;
			}
			currentMonth--;
			let d = ""+currentYear+"-"+currentMonth+"-1";
			currentMonthFirstDay = new Date(d).getDay();
			currentTotalDay = judgeDay(currentYear,currentMonth);
			
			$("#month").html("<span>"+currentYear+"�~"+currentMonth+"��</span>")
			for(let i = 1;i<=currentTotalDay;i++){
				let pickdate = currentYear+"-"+currentMonth+"-"+i;
				let compare = currentYear+"-"+currentMonth+"-"+(i+1);
				if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
					$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
				}
				$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
				$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
				currentMonthFirstDay = currentMonthFirstDay+1;
			}
		})
		$("#next").click(function(){
			freshPickDateTB();
			
			if(currentMonth==12){
				currentYear++;
				currentMonth=0;
			}
			
			currentMonth++;
			currentMonthFirstDay = new Date(""+currentYear+"-"+currentMonth+"-1").getDay();
			currentTotalDay = judgeDay(currentYear,currentMonth);
			
			$("#month").html("<span>"+currentYear+"�~"+currentMonth+"��</span>")
			for(let i = 1;i<=currentTotalDay;i++){
				let pickdate = currentYear+"-"+currentMonth+"-"+i;
				let compare = currentYear+"-"+currentMonth+"-"+(i+1);
				if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
					$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
				}
				$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
				$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
				currentMonthFirstDay = currentMonthFirstDay+1;
			}
		})
		
		//��l
		$("#month").html("<span>"+currentYear+"�~"+currentMonth+"��</span>")
		for(let i = 1;i<=currentTotalDay;i++){
			let pickdate = currentYear+"-"+currentMonth+"-"+i;
			let compare = currentYear+"-"+currentMonth+"-"+(i+1);
			$("button[name='pickdate']").eq(currentMonthFirstDay).css('display','block');
			if(Date.parse(compare).valueOf() < Date.parse(new Date()).valueOf()){
				$("button[name='pickdate']").eq(currentMonthFirstDay).prop('disabled',true);
			}
			$("button[name='pickdate']").eq(currentMonthFirstDay).attr('id',pickdate).prepend("<span>"+currentMonth+" / "+i+"</span>");
			currentMonthFirstDay = currentMonthFirstDay+1;
		}
	}
//		��s���
	function freshPickDateTB(){
		$("button[name='pickdate']").each(function(){
				$(this).css('display','none');
				$(this).prop('disabled',false);
				$(this).attr("id","").children().remove();
		})
	}
	//�P�_�X�� �]�t�|�~�Ѽ�
	function judgeDay(year,month){
		let maybe =["28","29","30","31","32"];
		let recordMonth = month;
		for(let i=0;i<maybe.length;i++){
			let judgemonth = new Date(year+"-"+month+"-"+maybe[i]);
			if((judgemonth.getMonth()+1)!=month || "Invalid Date"==judgemonth){
				return maybe[i-1];
			}
		}
	} 
//�ɬq��ܥͦ�
	let prevTime = 0;
	
	let interval = 1;
//�]�w�Z�� �{�b�h�֤p�ɤ~�i�H�w��
// 	let freeTimeToSee =  obj.freeTimeToSee;
// 	let gotowork = obj.gotowork;
// 	let gooffwork  =obj.gooffwork;
	
	let currentHours = new Date().getHours();
	//�Ω�]�q�A�P�_����諸�ɬq
	let unchoosetime = 0;
	let isUpdate = false;
	function spanTimetitle(prevTime,interval,pickdate,freeTimeToSee){
		$("span[name='timeTitle']").each(function(index){
			let nextTime = prevTime+interval;
			$(this).text(prevTime+":00-"+nextTime+":00");
			let rva_order_time =pickdate+" "+prevTime+":00:00";
			//�H�U�]�w�{�b(freeTimeToSee)�������ɬq ���i�w��
			let comparePickTime =pickdate+" "+index+":00:00";
			let nowHour = new Date().getHours()+parseInt(freeTimeToSee)+1;
			let nowDate = new Date().getDate();
			let nowMonth = (new Date().getMonth()+1); 
			let nowYear = new Date().getFullYear();
			let nowTotalDay = judgeDay(nowYear,nowMonth);
			if(nowHour>=24){
				nowDate++;
				nowHour%=24;
			}
			if(nowDate>nowTotalDay){
				nowMonth++;
				nowDate%=nowTotalDay;
			}
			if(nowMonth>=12){
				nowDate++;
				nowMonth-=12;
			}
			
			let compareNowTime = nowYear+"-"+nowMonth+"-"+nowDate+" "+nowHour+":00:00";
			if(index==1){
				isUpdate = false;
			}
			if(index<=obj.gotowork){
				$("input[name='picktime']").eq(index).prop("disabled",true);
			}
			if(obj.gooffwork<=index){
				$("input[name='picktime']").eq(index).prop("disabled",true);
			}
			if(Date.parse(comparePickTime).valueOf() < Date.parse(compareNowTime).valueOf()){
				$("input[name='picktime']").eq(index).prop("disabled",true);
				unchoosetime = index;
				isUpdate =true;
			}
			$("input[name='picktime']").eq(index).next().remove();
			$("input[name='picktime']").eq(index).attr('value',rva_order_time);
			$("input[name='picktime']").eq(index).attr('id',prevTime).after("<span id='"+pickdate+"'>"+prevTime+"</span>");
			prevTime+=interval;
		})
	}
// //�H�Uwebsocket

	let empno = "���u�s��"+${employeeVO.emp_no}
	let MyPoint = "/pickTime/"+empno+"/"+houseno;//��WS.java������
	let host = window.location.host;
	let path = window.location.pathname;
	let webCtx = path.substring(0, path.indexOf('/', 1));
	let endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	alert(endPointURL);
	let self = empno;
	let webSocket;
	let countChecked = 0 ; //�p��w�w���ɬq
	let fullCheck = 24; //�]�w 24���ɬq ���ɬq�A���X�q��
	function connect() {
		// create a websocket
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			console.log("Connect Success!");
			$("#member").after("<p>"+self+"</p>");//�s�u���\ �n�J�W��
			addListener();
		};
		
		webSocket.onmessage = function(event) {
// 			�|�ت��Atype �n�J�B���v��T�B��ѮɡB�����ɭ�
// 			�n�J�n��s�n�ͦC��
// 			���v��T���X�¸��
// 			Object �s��message
			var jsonObj = JSON.parse(event.data);
			let currentClick = null;
			
			if ("open" === jsonObj.type) {//����إ]�q
// 				�@���s�s�u�A�N��s���v���
				addListener();
			} else if ("history" === jsonObj.type && (self !== jsonObj.sender)) {
				// �o�檺jsonObj.message�O�qredis���X��n�ͪ����v�T���A�Aparse��JSON�榡�B�z
				var messages = JSON.parse(jsonObj.message);
				
				for (var i = 0; i < messages.length; i++) {
					let jsonObject = JSON.parse(messages[i]);
					let time = jsonObject.time;//���X�Q�諸�ɶ��F
					let timepick = jsonObject.timepick;
					let date = jsonObject.date;//���X�Q�諸�F
					let datepick = jsonObject.datepick;
					if(isUpdate==true && time<=unchoosetime){
						continue;
					}
					
					//���z����  //���O�ۤv���
					if(self !== jsonObject.sender && timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
						$("input[name='picktime']").each(function(){
							if($(this).attr("id")===time){
								$(this).prop("checked",true);
								if(jsonObj.sender.indexOf("���u")==0){
									$(this).next().text(jsonObject.sender+" �w�]�w����w��");
								}else{
									$(this).next().text(jsonObject.sender+" �w�w��");
								}
								countChecked++;
								$(this).prop("disabled",true);
							}
						})//���O�ۤv����
					}else if(self !== jsonObject.sender && timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
						$("input[name='picktime']").each(function(){
							if($(this).attr("id")===time){
								$(this).prop("checked",false);
								countChecked--;
								$(this).next().text("");
								$(this).prop("disabled",false);
							}
						})
					}else if(self === jsonObject.sender && timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
						$("input[name='picktime']").each(function(){
							if($(this).attr("id")===time){
								$(this).prop("checked",true);
								$(this).next().text(jsonObject.sender+" �w�]�w����w��");
								countChecked++;
							}
						})
					}else if(self === jsonObject.sender && timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
						$("input[name='picktime']").each(function(){
							if($(this).attr("id")===time){
								$(this).prop("checked",false);
								countChecked--;
								$(this).next().text("");
							}
						})
					}
				}
			}else if("chat" === jsonObj.type && self === jsonObj.sender && houseno==jsonObj.identity) {//�ۤv
				let time = jsonObj.time;//���X�Q�諸�ɶ��F
				let timepick = jsonObj.timepick;
				let date = jsonObj.date;//���X�Q�諸�ɶ��F
				let datepick = jsonObj.datepick;
				//���z����  
				if(timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
					$("input[name='picktime']").each(function(){
						if($(this).attr("id")===time){
							$(this).prop("checked",true);
							$(this).next().text(jsonObj.sender+" �w�]�w����w��");
							countChecked++;
						}
					})
				}else if(timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
					$("input[name='picktime']").each(function(){
						if($(this).attr("id")===time){
							$(this).prop("checked",false);
							$(this).next().text("");
							countChecked--;
						}
					})
				}
			}else if ("chat" === jsonObj.type && self !== jsonObj.sender && houseno==jsonObj.identity) {//�O�H
				// �o�檺jsonObj.message�O�qredis���X��n�ͪ����v�T���A�Aparse��JSON�榡�B�z
				let time = jsonObj.time;//���X�Q�諸�ɶ��F
				let timepick = jsonObj.timepick;
				let date = jsonObj.date;//���X�Q�諸�ɶ��F
				let datepick = jsonObj.datepick;
				//���z����  
				if(timepick==="1" && $("input[name='picktime']").next().attr('id')===date){
					$("input[name='picktime']").each(function(){
						if($(this).attr("id")===time){
							$(this).prop("checked",true);
							if(jsonObj.sender.indexOf("���u")==0){
								$(this).next().text(jsonObj.sender+" �w�]�w����w��");
							}else{
								$(this).next().text(jsonObj.sender+" �w�w��");
							}
							$(this).prop("disabled",true);
						}
					})
				}else if(timepick==="0" && $("input[name='picktime']").next().attr('id')===date){
					$("input[name='picktime']").each(function(){
						if($(this).attr("id")===time){
							$(this).prop("checked",false);
							$(this).prop("disabled",false);
							$(this).next().text("");
						}
					})
				}
			}else if ("close" === jsonObj.type) {
				alert("BYE");
			}else if ("control" === jsonObj.type){
				 obj = getlistcontroltime(houseno);
					console.log("ASADSADASD"+obj.freeTimeToSee+"! "+obj.gotowork+"!! "+obj.gooffwork);
				 $("input[name='picktime']").each(function(index){
					 	if(index<obj.gotowork){
							$("input[name='picktime']").eq(index).prop("disabled",true);
						}
						if(obj.gooffwork<index){
							$("input[name='picktime']").eq(index).prop("disabled",true);
						}
						if(obj.gotowork<=index && obj.gooffwork>=index){
							$("input[name='picktime']").eq(index).prop("disabled",false);
						}
				})
			}
			
			console.log("countChecked"+countChecked);
			if(countChecked==fullCheck){
				alert("�Ӥѹw�����o");
			}
		};
		
		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	//���U�n�諸�ɶ� �e�X�]�q
	$("input[name='picktime']").change(function(){
			let time =  $(this).attr("id");
			let timepick = null;
			let date = "";
			if($(this).next().attr('id')!='undefined'){
				date=$(this).next().attr('id');
			}
			if($(this).prop("checked")==true){
				timepick = "1";
			}else{
				timepick = "0";
			}
			var jsonObj = {
					"type" : "chat",
					"sender" : self,
					"identity" : houseno,
					"date" :date,
					"datepick" :"",
					"time" :time,
					"timepick" :timepick,
				};
			webSocket.send(JSON.stringify(jsonObj));
	})
	
// 	�ڭn������v��ƪ�
	// ���U�C���I���ƥ�ç���n�ͦW�r�H���o���v�T��
	function addListener() {
			let jsonObj = {
					"type" : "history",
					"sender" : "",
					"identity" : houseno,
					"message" : "",
				};
			webSocket.send(JSON.stringify(jsonObj));
	}
	//�ڭn���챱��ɶ�
	function addListener2(houseno,freeTimeToSee,gotowork,gooffwork) {
		let jsonObj = {
				"type" : "control",
				"sender" : "",
				"identity" : houseno,
				"freeTimeToSee" : freeTimeToSee,
				"gotowork" : gotowork,
				"gooffwork" : gooffwork,
			};
		webSocket.send(JSON.stringify(jsonObj));
	}
	function disconnect() {
		webSocket.close();
	}
	
	$("button[name='pickdate']").click(function(){
// 		console.log("AAAAAA"+freeTimeToSee);
// 		console.log("AAAAAA"+gotowork);
// 		console.log("AAAAAA"+gooffwork);
		$("#showdate").html("<span>"+$(this).attr('id')+" ���ɬq </span>")
		$("#exampleModalLabel").html("�q��ݳB�z�A�йw�� \"�{�b�_ "+obj.freeTimeToSee+"�p�� \"���᪺�ɬq");
		$("input[name='picktime']").each(function(){
			$(this).prop('checked',false);
			$(this).prop('disabled',false);
		})
		spanTimetitle(prevTime,interval,$(this).attr('id'),obj.freeTimeToSee);
		
		alert(isUpdate);
		addListener();
		countChecked=0;
		$("#Modal").modal('show');
	})
	
		//�w�� �ɬq ���\
		$("input[name='picktime']").change(function(){
			let rva_order_time = $(this).val();
			let mem_no = self.substring(self.indexOf("��")+1);
			alert("A"+$(this).val());
			alert("SSV"+($(this).prop('checked')===true));
			alert("SSSS"+houseno);
			alert("dd"+self.substring(self.indexOf("��")+1));
//				$("input[type='submit']").click();
			//���u�o���I�U�h ���ηs�W �������n
			if($(this).prop('checked')===true){
				$.ajax({
					url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
					type:'post',
					data:{
						action:'addPickTime',
						mem_no:mem_no,
						hos_no:houseno,
						rva_order_time:rva_order_time,
					},
					success:function(){
						console.log("�w�����\")
					}
				})
			}else{
				$.ajax({
					url:"<%=request.getContextPath()%>/rooVieApp/rooVieApp.do",
					type:'post',
					data:{
						action:'cancelPickTime',
						mem_no:mem_no,
						hos_no:houseno,
						rva_order_time:rva_order_time,
					},
					success:function(){
						console.log("�����w��")
					}
				})
			}
		})

	
</script>
</body>

</html>
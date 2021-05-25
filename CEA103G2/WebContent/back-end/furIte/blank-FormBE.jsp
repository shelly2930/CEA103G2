<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furIte.model.*"%>

<% 	  
		List<FurIteVO> list =new ArrayList<FurIteVO>();
		if(request.getAttribute("QueryResultList")!=null && request.getParameter("fnt_ctgr_no")==null){
			list=(ArrayList<FurIteVO>) request.getAttribute("QueryResultList");	
				 pageContext.setAttribute("list",list);				
		}else if(request.getParameter("fnt_ctgr_no")==null){
			FurIteService furIteSvc = new FurIteService();
		    list= furIteSvc.getAll();
		    pageContext.setAttribute("list",list);	
		} 
		else{
			FurIteService furIteSvc = new FurIteService(); 
			Integer fnt_ctgr_no = new Integer(request.getParameter("fnt_ctgr_no"));
			 list = furIteSvc.getOneFurCat_Item(fnt_ctgr_no); 
			pageContext.setAttribute("list",list);
		}
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>�a��~�����</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

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


                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">�a��~���޲z</h1>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
<!--                  ������       ���s�� �j�M�C�\���m�������� -->

             <a href="<%=request.getContextPath()%>/back-end/furCat/addFurCat.jsp" class="btn btn-warning btn-icon-split">
                                        <span class="text">�s�W���</span>
                                    </a>
                                
<!--                  ������       ���s�� �j�M�C�\���m�������� -->                                    
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                   <!--                  ������       ����\���m�������� -->
                             
										                                    
										                                  
                                      <!--                  ������       ����\���m�������� -->      
                                </table>
                            </div>
                        </div>
                    </div>

      
                <!-- /.container-fluid -->

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

</body>

</html>
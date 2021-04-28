<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="../template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="../template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

<!--     <style>
        .bg-gradient-prima{
            background-color:   #009393;
        }
    </style> -->
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">HowTrue <sup>�n��</sup></div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-house-user"></i>
                    <span>�N�޺޲z</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Escrow Management:</h6>
                        <a class="collapse-item" href="buttons.html">�N�ޥӽ�</a>
                        <a class="collapse-item" href="cards.html">������</a>
                        <a class="collapse-item" href="cards.html">�N�ަX��</a>
                    </div>
                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fas fa-fw fa-home"></i>
                    <span>���κ޲z</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Rental Management:</h6>
                        <a class="collapse-item" href="utilities-color.html">�w���ݩХӽ�</a>
                        <a class="collapse-item" href="utilities-border.html">���Ϋe�f��</a>
                        <a class="collapse-item" href="utilities-border.html">���ΦX��</a>
                    </div>
                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-couch"></i>
                    <span>�a��޲z</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Furniture Management:</h6>
                        <a class="collapse-item" href="login.html">���a��ӽ�</a>
                        <a class="collapse-item" href="register.html">�a�����O</a>
                        <a class="collapse-item" href="register.html">�a��~��</a>
                        <a class="collapse-item" href="register.html">�a��M��</a>
                    </div>
                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="fas fa-fw fa-faucet"></i>
                    <span>��µ�޲z</span></a>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseRepair"
                    aria-expanded="true" aria-controls="collapseRepair">
                    <i class="fas fa-fw fa-hand-holding-usd"></i>
                    <span>�X�Ǻ޲z</span>
                </a>
                <div id="collapseRepair" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Cashier Management:</h6>
                        <a class="collapse-item" href="login.html">�Ыȱb��</a>
                        <a class="collapse-item" href="register.html">�ЪF�b��</a>
                        <a class="collapse-item" href="register.html">�ЪF��������</a>
                    </div>
                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="fas fa-fw fa-comments"></i>
                    <span>�ȪA�޲z</span></a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="fas fa-fw fa-bullhorn"></i>
                    <span>���i�޲z</span></a>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseMember"
                    aria-expanded="true" aria-controls="collapseMember">
                    <i class="fas fa-fw fa-users"></i>
                    <span>�|���޲z</span>
                </a>
                <div id="collapseMember" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Member Management:</h6>
                        <a class="collapse-item" href="register.html">�ЪF�ӽ�</a>
                        <a class="collapse-item" href="login.html">�|��/�Ыȸ��</a>
                        <a class="collapse-item" href="register.html">�ЪF���</a>
                    </div>
                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="employee/select_page.jsp">
                    <i class="fas fa-fw fa-user-tie"></i>
                    <span>���u�޲z</span></a>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseAssign"
                    aria-expanded="true" aria-controls="collapseAssign">
                    <i class="fas fa-fw fa-briefcase"></i>
                    <span>���u����</span>
                </a>
                <div id="collapseAssign" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Assign Employee:</h6>
                        <a class="collapse-item" href="register.html">�N�ޥӽЫ���</a>
                        <a class="collapse-item" href="login.html">�w���ݩХӽЫ���</a>
                        <a class="collapse-item" href="register.html">���a��ӽЫ���</a>
                        <a class="collapse-item" href="register.html">��µ�ӽЫ���</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->


    <!-- Bootstrap core JavaScript-->
    <script src="../template_back-end/vendor/jquery/jquery.min.js"></script>
    <script src="../template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="../template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="../template_back-end/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="../template_back-end/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="../template_back-end/js/demo/chart-area-demo.js"></script>
    <script src="../template_back-end/js/demo/chart-pie-demo.js"></script>

</body>

</html>
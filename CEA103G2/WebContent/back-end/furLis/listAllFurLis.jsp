<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furLis.model.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furCat.model.*"%>
<!DOCTYPE html>

<%
	List<FurLisVO> list = null;
	if (request.getParameter("fnt_it_no") == null) {
		FurLisService furLisSvc = new FurLisService();
		list = furLisSvc.getAll();
		pageContext.setAttribute("list", list);
	} else {
		FurLisService furLisSvc = new FurLisService();
		Integer fnt_it_no = new Integer(request.getParameter("fnt_it_no"));
		list = furLisSvc.getOneFur_Item_Lis(fnt_it_no);
		pageContext.setAttribute("list", list);
	}
%>
<jsp:useBean id="furCatDAO" scope="page" 	class="com.furCat.model.FurCatDAO" />
<jsp:useBean id="furIteDAO" scope="page" 	class="com.furIte.model.FurIteDAO" />

<html>
<head>

	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

<title>家具品項清單</title>

<!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">

	<!-- Custom styles for this page -->
	<link href="<%=request.getContextPath()%>/template_back-end/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<style>
img.mem_pic {
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

                <!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
                <div class="container-fluid">
					
					<h1 class="h3 mb-2 text-gray-800">家具清單管理</h1>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							    <a href="<%=request.getContextPath()%>/back-end/furLis/addFurLis.jsp"  class="btn btn-warning btn-icon-split">
                                        <span class="text">新增資料</span>
                                </a>
							    <a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp"  class="btn btn-warning btn-icon-split">
                                        <span class="text">全部</span>
                                 </a>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>家具<br>編號</th>
											<th>類別名稱</th>
											<th>品項名稱</th>
											<th>規格</th>
											<th>家具狀態</th>
											<th>租借狀態</th>
											<th>編輯</th>
<!-- 											<th>刪除</th> -->
										</tr>
									</thead>
									<tbody>
										<c:forEach var="furLisVO" items="${list}">
											<tr>
													<!-- 		家具序號 -->
													<td>${furLisVO.fnt_id}</td>
													<!-- 			家具類別名稱 -->
													<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
															<c:if test="${furLisVO.fnt_it_no==furIteVO.fnt_it_no}">
																<c:forEach var="furCatVO" items="${furCatDAO.all}">
																	<c:if test="${furIteVO.fnt_ctgr_no==furCatVO.fnt_ctgr_no}">
									                    ${furCatVO.fnt_ctgr_name}
									                    </c:if>
																</c:forEach>
															</c:if>
														</c:forEach></td>
													<!-- 			家具品項名稱 -->
													<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
															<c:if test="${furLisVO.fnt_it_no==furIteVO.fnt_it_no}">
										                    ${furIteVO.fnt_name}
									                    </c:if>
														</c:forEach></td>
													<!-- 		規格		  -->
													<td><c:forEach var="furIteVO" items="${furIteDAO.all}">
															<c:if test="${furLisVO.fnt_it_no==furIteVO.fnt_it_no}">
										                    ${furIteVO.fnt_standard}
									                    </c:if>
														</c:forEach></td>
													<!-- 			家具狀態 -->
													<td><c:choose>
															<c:when test="${furLisVO.fnt_status==0}"> 正常 </c:when>
															<c:when test="${furLisVO.fnt_status==1}"> 維修 </c:when>
															<c:otherwise> 報廢</c:otherwise>
														</c:choose></td>
													<!-- 		租借狀態 -->
													<td><c:choose>
															<c:when test="${furLisVO.fnt_rent_status==0}"> 未出租</c:when>
															<c:otherwise> 出租中</c:otherwise>
														</c:choose></td>
													<td>
														<FORM METHOD="post"
															ACTION="<%=request.getContextPath()%>/furLis/furLis.do"
															style="margin-bottom: 0px;">
<%-- 															<input type="submit" value=${furLisVO.fnt_status!=2? "編輯":"查看"}>  --%>
															 <button type="submit" class="btn btn-outline-success">${furLisVO.fnt_status!=2? "編輯":"查看"}</button>
															<input type="hidden" name="fnt_id" value="${furLisVO.fnt_id}">
															 <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
									<%-- 			             <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
															 <input type="hidden" name="action" value="getOne_For_Update">
														</FORM>
													</td>
<!-- 													<td> -->
<%-- 														<FORM METHOD="post" 	ACTION="<%=request.getContextPath()%>/furLis/furLis.do" --%>
<!-- 															style="margin-bottom: 0px;"> -->
<!-- 															<input type="submit" value="刪除">  -->
<%-- 															<input type="hidden" name="fnt_id" value="${furLisVO.fnt_id}"> --%>
<%-- 														 <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<%-- 												     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
<!-- 																 <input type="hidden" name="action" value="delete"> -->
<!-- 														</FORM> -->
<!-- 													</td> -->
												</tr>
											</c:forEach>
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

</body>
</html>
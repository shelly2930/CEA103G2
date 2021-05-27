<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furIte.model.*"%>
<!DOCTYPE html>

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
<jsp:useBean id="furCatSvc" scope="page" class="com.furCat.model.FurCatService" />
<jsp:useBean id="furPhoSvc" scope="page" class="com.furPho.model.FurPhoService" />
<html>
<head>

	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

<title>家具品項資料</title>

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
					
					<h1 class="h3 mb-2 text-gray-800">家具品項管理</h1>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							    <a href="<%=request.getContextPath()%>/back-end/furIte/addFurIte.jsp"  id="addButton" class="btn btn-warning btn-icon-split">
                                        <span class="text">新增資料</span>
                                    </a>
							    <a href="<%=request.getContextPath()%>/back-end/furIte/listAllFurIte.jsp"  id="getAllButton" class="btn btn-warning btn-icon-split">
                                        <span class="text">全部</span>
                                    </a>
							    <a href="<%=request.getContextPath()%>/furIte/furIte.do?action=getOnItem&requestURL=<%=request.getServletPath()%>"  id="getOnItemButton" class="btn btn-warning btn-icon-split">
                                        <span class="text">上架品項</span>
                                    </a>
							    <a href="<%=request.getContextPath()%>/furIte/furIte.do?action=getOffItem&requestURL=<%=request.getServletPath()%>"  id="getOffItemButton" class="btn btn-warning btn-icon-split">
                                        <span class="text">下架品項</span>
                                    </a>
							
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
												<th>品項<br>編號</th>
												<th>品項名稱</th>
												<th>家具圖片</th>
												<th>可租<br>數量</th>
												<th>租用<br>數量</th>
												<th>維修<br>數量</th>
												<th>總<br>數量</th>
												<th>出租<br>價格</th>
												<th>規格</th>
												<th style="display:none;">瀏覽<br>次數</th>
												<th>刊登<br>狀態</th>
												<th>編輯</th>
<!-- 												<th>刪除</th> -->
										</tr>
									</thead>
									<tbody>
										<c:forEach var="furIteVO" items="${list}">
											<tr>
													<td>${furIteVO.fnt_it_no}</td>
													<td><a href="<%=request.getContextPath()%>/back-end/furLis/listAllFurLis.jsp?fnt_it_no=${furIteVO.fnt_it_no}">${furIteVO.fnt_name}</a></td> 
													<td>
														<img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoSvc.getThisIteFurPho(furIteVO.fnt_it_no).fnt_pic_no}"
															height="100">
														<a href="<%=request.getContextPath()%>/back-end/furPho/listAllFurPho.jsp?fnt_it_no=${furIteVO.fnt_it_no}"  onClick="window.open('<%=request.getContextPath()%>/back-end/furPho/listAllFurPho.jsp?fnt_it_no=${furIteVO.fnt_it_no}','update_fnt_pic','width=780,height=500,directories=no,location=no,menubar=no,scrollbars=yes,status=no,toolbar=no,resizable=no,left=5,top=0,screenX=250,screenY=50');return false">
												<img src="<%=request.getContextPath()%>/back-end/furIte/images/pic.png" style="width:20px; height:20px;"></a>
													
													</td>
													<td>${furIteVO.fnt_unrent}</td>
													<td>${furIteVO.fnt_total-furIteVO.fnt_unrent-furIteVO.fnt_repair}</td>
													<td>${furIteVO.fnt_repair}</td>
													<td>${furIteVO.fnt_total}</td>
													<td>${furIteVO.fnt_price}</td>
													<td>${furIteVO.fnt_standard}</td>
													<td style="display:none;">${furIteVO.fnt_views}</td>	
													<td><c:choose>
																<c:when test="${furIteVO.fnt_post_status==0}"> 下架</c:when>
																<c:otherwise> 上架</c:otherwise>
															</c:choose></td>	
										 		<td> 
													  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furIte/furIte.do" style="margin-bottom: 0px;">
<!-- 												     <input type="submit" value="編輯"> -->
													    <button type="submit" class="btn btn-outline-success">編輯</button>
													     <input type="hidden" name="fnt_it_no"  value="${furIteVO.fnt_it_no}">
													      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
										<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
										 			     <input type="hidden" name="action" value="getOne_For_Update"></FORM> 
												</td> 
<!-- 												<td>  -->
<%-- 													  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/furIte/furIte.do" style="margin-bottom: 0px;"> --%>
<!-- 												     <input type="submit" value="刪除"> -->
<%-- 													     <input type="hidden" name="fnt_it_no"  value="${furIteVO.fnt_it_no}"> --%>
<%-- 													      <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<%-- 													     <input type="hidden" name="whichPage"	value="<%=whichPage%>">        --%>
<!-- 										 			     <input type="hidden" name="action" value="delete"></FORM>  -->
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
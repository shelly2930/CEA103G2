<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html >

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>後台空頁</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
	<script src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
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

                    	<table  class="table table-striped ">
                              <thead>
                              	<tr>
                              		 <nav aria-label="Page navigation example">
								  <ul class="pagination">
								    <li class="page-item"><a id='prev' style='color:#BFBFBF' class="page-link" href="#">Previous</a></li>
								    <li id='start' class="page-item"><a style='color:#6363FF' class=" thispage page-link" name='1' href="#">1</a></li>
								    <li class="page-item"><a id='next' style='color:#BFBFBF' class="page-link" href="#">Next</a></li>
								  </ul>
								</nav>
                              	</tr>
                                  <tr class="table-info">
                                      <th class="text-center">編號</th>
                                      <th class="text-center">通知內容</th>
                                      <th class="text-center">發送時間</th>
                                  </tr>
                              </thead>
                              <tbody id='shownotice'>
                              </tbody>
                              <tfoot>
                                  <tr>
                                      <th scope="col" colspan="3" class="text-center">Notification </th>
                                  </tr>
                              </tfoot>
                        	</table>

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
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
    <script src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>

</body>
<script>
	let mem_no = ${MemTenVO.mem_no};
	let data = mydata();
	let page = {};
	let showpen = 5;
	let totalpen = data.length;
	let totalpage = Math.ceil(totalpen/showpen);
	for(let i=1;i<=totalpage;i++){
		page[i]=showpen*(i-1);
	}
	let whichpage = 1; 
	
	for(let i=totalpage;i>=2;i--){
		let dom = $("#start").clone(true);
		$(dom).children().text(i);
		$(dom).children().attr('name',i);
		$(dom).children().css('color','#BFBFBF');
		$("#start").after($(dom))
	}
	$(".page-item").children().click(function(e){
		e.preventDefault();
		$(".page-item").each(function(index){
			$(this).children().css('color','#BFBFBF');
		})
		$(this).css('color','#6363FF');
	})
	
	
	$("#next").click(function(e){
		e.preventDefault();
		if(whichpage<totalpage){
			whichpage++;
			show(page,whichpage,showpen);
		}
	})
	$("#prev").click(function(e){
		e.preventDefault();
		if(whichpage>1){
			whichpage--;
			show(page,whichpage,showpen);
		}
	})
	$(".thispage").click(function(e){
		e.preventDefault();
		show(page,$(this).attr('name'),showpen);
	})
	
	
	
	
	show(page,1,showpen);
	function show(page,whichpage,showpen){
		$("#shownotice").empty();
		for(let i= page[whichpage] ; i<(page[whichpage]+showpen);i++){
			let str = "<tr >";
			str += "<th class='text-center'>"+ (i+1) +"</th>";
			str += "<th class='text-center'>"+JSON.parse(data[i].message)+"</th>";
			str += "<th class='text-center'>"+dateformat1(data[i].currentTime)+"</th>";
			str +="</tr>";
			$("#shownotice").append(str);
		}
	}
	function dateformat1(str){
		 let year = new Date(str).getFullYear();
		 let month = new Date(str).getMonth()+1;
		 let date = new Date(str).getDate();
		 let hour = new Date(str).getHours();
		 let isAm = "上午";
		 if((Math.floor(hour/12)==1)){
			 isAm = "下午";
		 }
		 let minutes = new Date(str).getMinutes();
		 let second = new Date(str).getSeconds();
		 return year+"年"+month+"月"+date+"日" +" "+isAm+hour+"時  "+minutes+"分"+second+"秒";
}
	
	
	
	function mydata(){
		let list = [];
		$.ajax({
			url:"<%=request.getContextPath()%>/noticeServlet",
			type:'post',
			data:{
				action:'listnotice',
				identity:'0'
			},
			async:false,
			success:function(data){
				for(let i of data){
						let obj = {};
						obj.currentTime = i.currentTime;
						obj.message = i.message;
						if(!judge(i.currentTime,15)){
							list.push(obj);
					}
				}
			}
		})
		return list;
	}
	//v天以前
	function judge(judgeDay,view){
		let diff = parseInt(Math.abs(new Date() - new Date(judgeDay)) / 1000 / 60 / 60 / 24); // 把相差的毫秒數轉換為天數
		if(diff >= view)
			return true;
		else
			return false;
	}
</script>
</html>
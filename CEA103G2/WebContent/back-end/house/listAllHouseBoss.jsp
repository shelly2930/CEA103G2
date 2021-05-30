<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ page import="java.util.*"%>
<%@ page import="com.houPho.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>代管申請</title>
	<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
	
    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
	
    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
		
		<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js" integrity="sha256-0YPKAwZP7Mp3ALMRVB2i8GXeEndvCq3eSl/WsAl1Ryk=" crossorigin="anonymous"></script>
	
		<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
	
	
	
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

                <!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">代管申請-員工指派</h1>
                    <p class="mb-4"><p>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">員工指派</h6>
                            <h6 class="m-0 font-weight-bold text-info">可重新指派(請員工再確認，物件資料正確性)</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                            
                            	
                            	<%@ include file="pages/page1.file"%>	
                            	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            				<div id="freeEmp">
										<!-- 	之後可以用js老師作業的隨機顏色耶XD -->
												
											</div>
                            	</table>
                            	<FORM id='submit' METHOD="post" ACTION="<%=request.getContextPath()%>/house/house.do" style="margin-bottom: 0px;">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th scope="col">(修改)指派員工</th>
											<th scope="col">物件編號</th>
											<th scope="col">負責員工</th>
											<th scope="col">房東姓名</th>
							<!-- 費用				================================================= -->				
											<th scope="col">物件租金</th>
											<th scope="col">管理費</th>
							<!-- 管理				================================================= -->				
											<th scope="col">申請時間</th>
											<th scope="col">預約時間</th>
							<!-- 基本				================================================= -->
                                        </tr>
                                    </thead>
                                    
                                    <tbody id='catch'>
                                    	<c:forEach var="houseVO" items="${listAllHouse_Backend_list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="counter">
                                        <tr id ="${houseVO.hos_no}">
                                            <td class="target">
                                            <div>
				    						</div>
				    						</td>
                                            <td>${houseVO.hos_no}</td>
											<td><div class='empno'>${houseVO.emp_no==0?'未指派':houseVO.emp_no}</div></td>
											<td class='lld'>${houseVO.lld_no}</td>
                                            <td>${houseVO.hos_rent} 元</td>
											<td>${houseVO.hos_expense} 元</td>
                                            <td class='time'>${houseVO.hos_apptime}</td>
											<td class='time'>${houseVO.hos_order_date}</td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <hr>
                                <input type="submit" class="btn btn-primary btn-sm" style="background-color:#9999FF" value="指派員工">
								<input type="hidden" name="whichPage"	value="<%=whichPage%>">
								<input type="hidden" name="listSize"	value="${listSize}">
								<input type="hidden" name="comeBack"	    value="listAllHouse_Backend">
								<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
								<input type="hidden" name="action"	    value="change_Emp">
                                </FORM>
                                 <hr>	
                                <%@ include file="pages/page2.file"%>
                            </div>
                        </div>
                    </div>
                </div>

                <!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@include file="/back-end/includeFile/footerBack.file"%>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <%@include file="/back-end/includeFile/otherBack.file"%>
    
    


<!--     Custom scripts for all pages -->
    <script src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

<!--     Page level plugins -->
    <script src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

<!--     Page level custom scripts -->
	
		<script>
		
			$.ajax({
				url:"<%=request.getContextPath()%>/HouseJsonServlet",
				type:'post',
				data:{
					action:'getAllEmp',
				},
				async: false,
				success:function(str){
					for(let obj of str){
						let empString = "<button class='emp btn btn-info btn-sm'>"+obj.emp_no+" "+obj.emp_name+"";
						empString+="<input type='hidden' name='emp_no' value='"+obj.emp_no+"'></button>&nbsp; ";
						$("#freeEmp").append(empString);
					}
				}
				
			})
			
			$(".empno").each(function(index){
				let i = index;
				let empno = $(this).html();
				$.ajax({
					url:"<%=request.getContextPath()%>/HouseJsonServlet",
					type:'post',
					data:{
						action:'getEmpName',
						empno:$(this).html(),
					},
					success:function(str){
						$(".empno").eq(i).html(str.emp_name);
					}
						
				})
			})
			$(".time").each(function(){
				$(this).text(dateformat($(this).text()));
			})
			$(".lld").each(function(){
				$(this).text(getMem(getlld($(this).text()).mem_no).mem_name);
			})
			function dateformat(str){
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
			 return year+"年"+month+"月"+date+"日" +" "+isAm+hour+"時"
 			}
			function getlld(lld_no){
				let lldvo={}
				$.ajax({
					url:"<%=request.getContextPath()%>/HouseJsonServlet",
					type:'post',
					data:{
						action:'getLanlord',
						'lld_no':lld_no,
					},
					async:false,
					success:function(data){
						for(let key in data){
							lldvo[key]=data[key];
						}
					}
				})
				return lldvo;
			}
			function getMem(mem_no){
				let mem = {};
				$.ajax({
					url:'<%=request.getContextPath()%>/RenConCRUDServlet',
					type: 'post',
					data:{
						action:'getOneMemten',
						mem_no:mem_no,
					},
					async:false,
					success:function(memvo){
						for(let key in memvo){
							mem[key]=memvo[key];
						}
					}
				})
				return mem;
			}
			$(document).ready(function(){
				let hoseno =  ${empty houseno_list ? '[]' : houseno_list};
				for(let i of hoseno){
					$("#"+i).css({
						"backgroundColor":"#E8C9FF",
						"color":"#0000B2"
						});
				}
				$(".emp").draggable({
					cancel:false,//取消button預設的click事件 才不會事件傳遞 導致不能draggable
			        helper: 'clone'
			    });
			  
			    $(".target").droppable({
			        accept: ".emp",
			        drop: function(ev, vi) {
//  			        	console.log($(vi.draggable).html());//這是抓到 員工
//  						console.log($(this).parents("tr").attr("id"));//抓到元素編號
 						$(this).empty();
			            var item = $(vi.draggable).clone();
			            $(this).append(item);
			            $(document.createElement('input')).attr({
			            	'type':'hidden',
			            	'name':'houseno',
			            	'value':$(this).parents("tr").attr("id")
			            }) .appendTo(this);
			           
			        }
			    })
			})
			$("input[type='submit']").click(function(e){
				e.preventDefault();
				$("#catch").children().each(function(){
					if(!(!$(this).children("td").children("button").text())){
						pick($(this).children("td").children("button").text()+"已被指派")
					}
				})
				setTimeout(function(){
					$("#submit").submit();
				},2000);
			})
			
			
		</script>		
	
</body>

</html>
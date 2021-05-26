<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>選取預約時間</title>

</head>

<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<!-- =================================下面是導覽列==================================================== --> 
<%@include file="/front-end/header.file"%>
<!-- =================================上面是導覽列==================================================== --> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<style>

.breadcrumb_bg {
    background-image: url(<%=request.getContextPath()%>/front-end/notice/image/notice.jpg);
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}
</style>
<body>
<!-- ======圖片 -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2 style='color:#FAF2FF'> 通知</h2>
                            <h3 style='color:#FAF2FF'> &nbsp;&nbsp;&nbsp; ${MemTenVO.mem_name} 你好 !</h3>
                            <h5 style='color:#FAF2FF'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Notification</h5>
                            <h5 style='color:#FAF2FF'>會員: ${MemTenVO.mem_no} </h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
  
	    
<!-- /****** CONTAINER *****/     -->
 	<section class="confirmation_part padding_top" style="padding-top:0px">
		<div class="container">
	            <div class="row">
					<div class="col-lg-12">
                        <div class="order_details_iner">
                            <div id='notice'>
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
                        </div>
					</div>
				</div>
            </div>
    	</section>
<!-- /****** CONTAINER *****/     -->	
		

<!-- /****** CONTAINER *****/     -->



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
			str += "<th class='text-center'>"+data[i].message+"</th>";
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
				identity:'1'
			},
			async:false,
			success:function(data){
				
				for(let i of data){
						console.log(parseInt(mem_no));
						console.log(JSON.parse(i.username))
						if(parseInt(JSON.parse(i.username))==parseInt(mem_no)){
						let obj = {};
						obj.currentTime = i.currentTime;
						obj.message = i.message;
						if(!judge(i.currentTime,15)){
							list.push(obj);
						}
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
<!-- /****** CONTAINER *****/     -->	                       
	
</body>
<%@include file="/front-end/footer.file"%>

</html>
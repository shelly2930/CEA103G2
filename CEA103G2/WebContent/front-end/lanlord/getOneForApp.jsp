<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lanlord.model.*"%>

<%
	LanlordVO lanlordVO = (LanlordVO) request.getAttribute("lanlordVO");
%>

<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/css/nice-select.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<title></title>

<style>
body { 
	background-color: #dddddd !important;
}

img.lld_acc_pic {
  	height: 200px;
  	width: auto;
  }
</style>

</head>
<body>

<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>


<!--================ Content Area start =================-->
<section class="cat_product_area section_padding">
	<div class="container">
		<div class="row">
            <!--================ Sidebar =================-->    
			<%@include file="/front-end/sidebarFront.file"%>
                
            <div class="col-lg-9 content">
                
                <!--================ 不要的話自己刪掉 =================-->
                <div class="pagetitle">再次提出申請</div>
				
				<!--　　　↓↓↓↓↓↓↓↓↓↓內容↓↓↓↓↓↓↓↓↓↓　　　-->
					<%-- 錯誤表列 --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color:red">請修正以下錯誤:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color:red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>
					
					<FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/lanlord/lanlord.do" id="form1">
					<table class="table">
					  <tbody>
					  	<tr>
					    	<th>房東編號</th>
					    	<td><%=lanlordVO.getLld_no()%></td>
					    </tr>
					  	<tr>
					    	<th>會員編號</th>
					    	<td><%=lanlordVO.getMem_no()%></td>
					    </tr>
					    <tr>
					    	<th>銀行代碼</th>
					    	<td><input type="TEXT" name="lld_bank" size="45" required class="single-input" value="<%=lanlordVO.getLld_bank()%>" /></td>
					    </tr>
					    <tr>
					    	<th>匯款帳號</th>
					    	<td>
					    		<input type="TEXT" name="lld_account" size="45" required class="single-input" value="<%=lanlordVO.getLld_account()%>" />
							</td>
					    </tr>
					    <tr>
					    	<th>帳戶證明</th>
					    	<td>
					    		<div id="previewp"></div>
					    		<img id="imgp"  src="<%=request.getContextPath()%>/LanlordPicReadServlet?lld_no=${lanlordVO.lld_no}" class="lld_acc_pic">
					    		<input type="file" name="lld_acc_pic" id="lld_acc_pic" size="45">
					    	</td>
					    </tr>
					    <tr>
							<th>送出申請</th>
							<td>
								<input type="hidden" name="action" value="authagain">
								<input type="hidden" name="lld_no" value="<%=lanlordVO.getLld_no()%>">
								<input type="hidden" name="mem_no" value="<%=lanlordVO.getMem_no()%>">
								<input type="hidden" name="lld_status" value="0">
								<input type="submit" value="送出申請">
							</td>
						</tr>
					  </tbody>
					</table>
					</FORM>

				<!--　　　↑↑↑↑↑↑↑↑↑↑內容↑↑↑↑↑↑↑↑↑↑　　　-->
							
            </div>
        </div>
    </div>
</section>
<!--================ Content Area end =================-->

<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

<!-- 上傳圖片可預覽 -->
<script>
window.onload=function(){

	let myFile = document.getElementById("lld_acc_pic");
    let preview = document.getElementById("previewp");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgp');
                    img.src = result;
                    preview.append(img);
                    $("imgp:first").remove(); // 預覽只會保留最新上傳的
                });
                reader.readAsDataURL(file);
            } else {
                alert('請上傳圖片！');
            }
        }
    });
}


let mem_no = ${MemTenVO.mem_no};
$("input[type='submit']").click(function(e1){
	e1.preventDefault();
		picktimeSuccess("剛剛會員:"+mem_no+"再次提出房東申請");
		Swal.fire({
		 icon: 'success',
		 title: '您已成功申請，我們將盡快為您審核',
		 text:'即將回至首頁',
		 showConfirmButton: true,
		 confirmButtonText: "我知道了"
	})
		setTimeout(function(){
 		$("#form1").submit();
		},1000);
	})








// let mem_no = ${MemTenVO.mem_no};
// $("input[type='submit']").click(function(e1){
// 	e1.preventDefault();
// 		picktimeSuccess("剛剛會員:"+mem_no+"再次提出房東申請");
// 		Swal.fire({
// 		 icon: 'success',
// 		 title: '您已成功申請，我們將盡快為您審核',
// 		 text:'回至首頁',
// 		 showConfirmButton: true,
// 		 confirmButtonText: "我知道了"
// 	}).then((result) => {
// 		  if (result.isConfirmed) {
// 			  $("#form1").submit();
// 		  }
// 	});
// })
	

</script>

</body>




</html>
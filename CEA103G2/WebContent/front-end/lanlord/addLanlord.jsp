<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lanlord.model.*"%>

<%
	LanlordVO lanlordVO = (LanlordVO) request.getAttribute("lanlordVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<title>�����ЪF</title>

<style>

.single-input {
    display: block;
    width: 100%;
    line-height: 40px;
    border: none;
    outline: none;
    background: #ecfdff !important;
    padding: 0 20px;
}

.breadcrumb.breadcrumb_bg.rentalbaclground {
	margin-top:84px;
}

.breadcrumb_bg {
    background-image: url(/CEA103G2/front-end/lanlord/images/lanlord.jpg) !important;
}

.breadcrumb .breadcrumb_iner .breadcrumb_iner_item h2 {
    color: white !important;
    text-align: right !important;
}

.aaa {
    color: white !important;
    font-size:15px !important;
    text-align: right !important;
}

div.rentalstep {
	margin-top:20px;
}

.row {
	justify-content: center;
}

.lld_acc_pic {
	width:200px;
	height:auto;
}

h3 {
	text-align:center;
}
</style>

</head>
<body>

<!--================ navbar =================-->
<%@include file="/front-end/header.file"%>



<section class="breadcrumb breadcrumb_bg rentalbaclground">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>HowTrue</h2>
                            <h3 class="aaa">�����ЪF</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</section>

<div class="container">
	<div class="row rentalstep">
        <FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/lanlord/lanlord.do" id="form1">
<!--         <div class="step1"> -->
<!--         	<h3>��ܦX������</h3> -->
<!--         	<table class="table"> -->
<!-- 				<tbody> -->
<!-- 					<tr> -->
<!-- 						<th>�X���_�l��</th> -->
<!-- 							<td> -->
<!-- 								<div class="datealert"><i class="fas fa-exclamation-circle"></i> �u���ܷ��_��14�ѫ�</div> -->
<!-- 								<input class="single-input" name="rtct_eff_date" id="rtct_eff_date" type="text" required> -->
<!-- 							</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th>�X���פ��</th> -->
<!-- 							<td> -->
<!-- 								<div class="datealert"><i class="fas fa-exclamation-circle"></i> �����̵u�@�Ӥ�</div> -->
<!-- 								<input class="single-input" name="rtct_end_date" id="rtct_end_date" type="text" required> -->
<!-- 							</td> -->
<!-- 					</tr> -->
<!-- 				</tbody> -->
<!-- 			</table>	 -->
<!--         </div> -->
        
<!--         <br> -->
<!--         <h3>�ӽз|�����</h3> -->
<!--         <h5 class="rentalalert"><i class="fas fa-exclamation-circle"></i> �ж�u����</h5> -->
        <div class="step2">
        	<table class="table">
				<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
				<h3>�ж�g�H�U���</h3>
				<tbody>
					<tr>
						<th>�|���s��</th>
							<td>
								${MemTenVO.mem_no}
							</td>
					    </tr>
					    <tr>
					    	<th>�m�W</th>
							<td>
								${MemTenVO.mem_name}
							</td>
					    </tr>
					    <tr>
					    	<th>�Ȧ�N�X</th>
							<td>
								<input type="text" name="lld_bank" placeholder="�ж�g�Ȧ�N�X" required class="single-input" value="${lanlordVO.lld_bank}">
							</td>
					    </tr>
					    <tr>
					    	<th>�״ڱb��</th>
							<td>
								<input type="TEXT" name="lld_account" placeholder="�ж�g�״ڱb��" required class="single-input" value="${lanlordVO.lld_account}"/>
							</td>
					    </tr>
					    <tr>
					    	<th>�b���ҩ�</th>
					    	<td>
					    		<div id="preview"></div>
					    		<img id="imgf" class="lld_acc_pic">
					    		<input type="file" name="lld_acc_pic" id="lld_acc_pic" size="45" required>
					    	</td>
					    </tr>
					    <tr>
					    	<th></th>
					    	<td>
					    		<input type="hidden" name="action" value="insert">
								<input type="submit" value="�e�X�ӽ�">
					    	</td>
					    </tr>
					</tbody>
				</table>
          	</div>
        </form>
    </div>
</div>
<!--================ footer =================-->
<%@include file="/front-end/footer.file"%>

<!-- �W�ǹϤ��i�w�� -->
<script>
window.onload=function(){

    let myFile = document.getElementById("lld_acc_pic");
    let preview = document.getElementById("preview");

    myFile.addEventListener('change', function(e) {
        let files = e.target.files;
        if (files !== null) {
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
            	let reader = new FileReader();
                reader.addEventListener('load', function(e) {
                    let result = e.target.result;
                    let img = document.getElementById('imgf');
                    img.src = result;
                    preview.append(img);
                    $("imgf:first").remove(); // �w���u�|�O�d�̷s�W�Ǫ�
                });
                reader.readAsDataURL(file);
            } else {
                alert('�ФW�ǹϤ��I');
            }
        }
    });    
}

let mem_no = ${MemTenVO.mem_no};
$("input[type='submit']").click(function(e){
	e.preventDefault();
		picktimeSuccess("���|��:"+mem_no+"�w�ӽЦ����ЪF");
		Swal.fire({
		 icon: 'success',
		 title: '�z�w���\�ӽЦ����ЪF�A�ڭ̱N�ɧ֬��z�f��',
		 text:'�Y�N�^�ܭ���',
		 showConfirmButton: true,
		 confirmButtonText: "�ڪ��D�F"
	})
		setTimeout(function(){
 		$("#form1").submit();
		},1000);
	})

</script>



</body> 	
</html>
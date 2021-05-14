<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.furIte.model.*"%>
<%@ page import="com.furPho.model.*"%>
<%
FurIteVO furIteVO = (FurIteVO) request.getAttribute("furIteVO"); 
%>    

<!DOCTYPE html>
<html>
<head>
<title>�a�㤶��</title>
<!-- =================�M��bootstrap�n�ϥΥH�U=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<style>


</style>

</head>
<body>
<!-- include�����C -->
<%@include file="/front-end/header.file"%>	

 <!--================End Home Banner Area =================-->

  <!--================Single Product Area =================-->
  <div class="product_image_area section_padding">
    <div class="container">
      <div class="row s_product_inner justify-content-between">
        <div class="col-lg-7 col-xl-7">
          <div class="product_slider_img">
            <div id="vertical">
<!--              �Ӥ��`���϶� ������-->
		<c:forEach var="furPhoVO" items="${furPhoList}">
              <div data-thumb="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}">
                <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}" />
              </div>
        </c:forEach>      
<!--              �Ӥ��`���϶� ������-->
<!--              ��ӥΫݧR ������-->
<!--               <div data-thumb="img/product/single-product/product_1.png"> -->
<!--                 <img src="img/product/single-product/product_1.png" /> -->
<!--               </div> -->

            </div>
          </div>
        </div>
        <div class="col-lg-5 col-xl-4">
          <div class="s_product_text">
<!-- 			�e�@�� �U�@���s�� �Ψ�L���� -->
<!--             <h5>previous <span>|</span> next</h5> -->
<!--             �a��W -->
            <h3>${furIteVO.fnt_name}</h3>
<!--             ���� -->
            <h2>$${furIteVO.fnt_price} /��</h2>
            <ul class="list">
              <li>
                
<!--                   �����γW�� -->
                  <span>�W��</span> : ${furIteVO.fnt_standard}</a>
              </li>
              <li>
<!--               �w�s -->
                   <span>�w�s</span> : <c:choose>
					<c:when test="${furIteVO.fnt_unrent>0}">��</c:when>	
					<c:when test="${furIteVO.fnt_unrent<=0}">�L</c:when>			
					</c:choose>
              </li>
                          <li>
<!--               �s������ -->
                 <span>�s������</span> : ${furIteVO.fnt_views} ��
              </li>
            </ul>

<!--             ²�� -->            
<!-- 			<p> -->
<!--               First replenish living. Creepeth image image. Creeping can't, won't called. -->
<!--               Two fruitful let days signs sea together all land fly subdue -->
<!--             </p> -->
            <div class="card_area d-flex justify-content-between align-items-center">
<!--              �ƶq+-�s -->
              <div class="product_count">
                <span class="inumber-decrement"> <i class="ti-minus"></i></span>
                <input class="input-number" type="text" value="1" min="0" max="${furIteVO.fnt_unrent}">
                <span class="number-increment"> <i class="ti-plus"></i></span>
              </div>
<!--               �[�J�ʪ��� -->
              <a href="#" class="btn_3">+ �[�J����</a>
<!--               ���� -->
              <a href="#" class="like_us"> <i class="ti-heart"></i> </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--================End Single Product Area =================-->

  <!--================�a�㤶��=================-->
  <section class="product_description_area">
    <div class="container">
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <!--         <���� ���� �ݴ�> -->
        <li class="nav-item">
                    <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">�a��S��</a>
                </li>
        <li class="nav-item">
          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
            aria-selected="false">�a��W��</a>
        </li>

      </ul>
<!-- �H�U�����ФγW�满�� -->
      <div class="tab-content" id="myTabContent">
                       <!-- ������}�l -->
                    <div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">
                    <p>
                    ${furIteVO.fnt_info}
                    </p>
                </div>
                      <!-- �����浲�� -->
                <!-- �W����}�l -->
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                    <div class="table-responsive">
                        <table class="table">
                            <tbody>
  								<tr>
                                    <td>
                                        <h5>�W��</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_standard}</h5>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td>
                                        <h5>����</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_length} ����</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>�e��</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_width} ����</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>����</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_height} ����</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>���q</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_weight} ����</h5>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- �W���浲�� -->
             
                <!-- �H�U�d -->
            </div>
        </div>
    </section>
  <!--================End Product Description Area =================-->



<!-- JS ajax -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script type="text/javascript">


</script>
<%@ include file="/front-end/footer.file"%>
</body>
</html>
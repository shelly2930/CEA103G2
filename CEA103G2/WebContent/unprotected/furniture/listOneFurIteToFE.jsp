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
<title>家具介紹</title>
<!-- =================套用bootstrap要使用以下=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<style>


</style>

</head>
<body>
<!-- include導覽列 -->
<%@include file="/front-end/header.file"%>	

 <!--================End Home Banner Area =================-->

  <!--================Single Product Area =================-->
  <div class="product_image_area section_padding">
    <div class="container">
      <div class="row s_product_inner justify-content-between">
        <div class="col-lg-7 col-xl-7">
          <div class="product_slider_img">
            <div id="vertical">
<!--              照片循環區塊 ↓↓↓-->
		<c:forEach var="furPhoVO" items="${furPhoList}">
              <div data-thumb="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}">
                <img src="<%=request.getContextPath()%>/furPho/furPhoShow.do?fnt_pic_no=${furPhoVO.fnt_pic_no}" />
              </div>
        </c:forEach>      
<!--              照片循環區塊 ↑↑↑-->
<!--              對照用待刪 ↓↓↓-->
<!--               <div data-thumb="img/product/single-product/product_1.png"> -->
<!--                 <img src="img/product/single-product/product_1.png" /> -->
<!--               </div> -->

            </div>
          </div>
        </div>
        <div class="col-lg-5 col-xl-4">
          <div class="s_product_text">
<!-- 			前一筆 下一筆連結 或其他介紹 -->
<!--             <h5>previous <span>|</span> next</h5> -->
<!--             家具名 -->
            <h3>${furIteVO.fnt_name}</h3>
<!--             租金 -->
            <h2>$${furIteVO.fnt_price} /月</h2>
            <ul class="list">
              <li>
                
<!--                   分類或規格 -->
                  <span>規格</span> : ${furIteVO.fnt_standard}</a>
              </li>
              <li>
<!--               庫存 -->
                   <span>庫存</span> : <c:choose>
					<c:when test="${furIteVO.fnt_unrent>0}">有</c:when>	
					<c:when test="${furIteVO.fnt_unrent<=0}">無</c:when>			
					</c:choose>
              </li>
                          <li>
<!--               瀏覽次數 -->
                 <span>瀏覽次數</span> : ${furIteVO.fnt_views} 次
              </li>
            </ul>

<!--             簡介 -->            
<!-- 			<p> -->
<!--               First replenish living. Creepeth image image. Creeping can't, won't called. -->
<!--               Two fruitful let days signs sea together all land fly subdue -->
<!--             </p> -->
            <div class="card_area d-flex justify-content-between align-items-center">
<!--              數量+-鈕 -->
              <div class="product_count">
                <span class="inumber-decrement"> <i class="ti-minus"></i></span>
                <input class="input-number" type="text" value="1" min="0" max="${furIteVO.fnt_unrent}">
                <span class="number-increment"> <i class="ti-plus"></i></span>
              </div>
<!--               加入購物車 -->
              <a href="#" class="btn_3">+ 加入租借</a>
<!--               收藏 -->
              <a href="#" class="like_us"> <i class="ti-heart"></i> </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--================End Single Product Area =================-->

  <!--================家具介紹=================-->
  <section class="product_description_area">
    <div class="container">
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <!--         <測試 評論 待換> -->
        <li class="nav-item">
                    <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">家具特色</a>
                </li>
        <li class="nav-item">
          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
            aria-selected="false">家具規格</a>
        </li>

      </ul>
<!-- 以下接介紹及規格說明 -->
      <div class="tab-content" id="myTabContent">
                       <!-- 介紹欄開始 -->
                    <div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">
                    <p>
                    ${furIteVO.fnt_info}
                    </p>
                </div>
                      <!-- 介紹欄結束 -->
                <!-- 規格欄開始 -->
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                    <div class="table-responsive">
                        <table class="table">
                            <tbody>
  								<tr>
                                    <td>
                                        <h5>規格</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_standard}</h5>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td>
                                        <h5>長度</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_length} 公分</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>寬度</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_width} 公分</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>高度</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_height} 公分</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h5>重量</h5>
                                    </td>
                                    <td>
                                        <h5>${furIteVO.fnt_weight} 公斤</h5>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- 規格欄結束 -->
             
                <!-- 以下留 -->
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
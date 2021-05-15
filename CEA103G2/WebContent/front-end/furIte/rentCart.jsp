<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

    
<!DOCTYPE html>
<html>
<head>
<title>租借明細</title>
<!-- =================套用bootstrap要使用以下=========================== -->
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>

<style>


</style>

</head>
<body>
<!-- include導覽列 -->
<%@include file="/front-end/header.file"%>	
<link href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<style>

.breadcrumb_bg {
    background-image: url(<%=request.getContextPath()%>/unprotected/furniture/images/Morandi2.jpg);
    background-position: bottom -300px right 0px;
    background-repeat: no-repeat;
    background-size: cover;
}
</style>
<body onload="connect();connectNotice();" onunload="disconnect();disconnectNotice();">
<!-- 導覽列下圖片 -->
   <section class="breadcrumb breadcrumb_bg" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Welcome  好厝家具專區</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
 <!--================End Home Banner Area =================-->
    <!--================Cart Area =================-->
    <!-- 租借明細 -->
    <section class="cart_area padding_top">
        <div class="container">
            <div class="cart_inner">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Product</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Total</th>
                                <th scope="col">Delete</th>
                            </tr>
                        </thead>
                        <!-- 租借明細開始  由此開始循環 -->
                        <tr>
                            <td>
                                <div class="media">
                                    <div class="d-flex">
                                        <img src="img/product/single-product/cart-1.jpg" alt="" />
                                    </div>
                                    <div class="media-body">
                                        <p>Minimalistic shop for multipurpose use</p>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <h5>$360.00</h5>
                            </td>
                            <td>
                                <div class="product_count">
                                    <span class="input-number-decrement"> <i class="ti-angle-down"></i></span>
                                    <input class="input-number" type="text" value="1" min="0" max="10">
                                    <span class="input-number-increment"> <i class="ti-angle-up"></i></span>
                                </div>
                            </td>
                            <td>
                                <h5>$720.00</h5>
                            </td>
                            <!-- ↓↓↓↓ 加入垃圾桶元件 ↓↓↓↓ -->
                            <td>
                                <div class="">
                                    <ul class="list-inline justify-content-center">
                                        <span>&nbsp&nbsp&nbsp&nbsp<span>
                                                <li class="list-inline-item">
                                                    <a data-toggle="tooltip" data-placement="top" title="" class="delete" href="" data-original-title="Delete">
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </li>
                                    </ul>
                                </div>
                            </td>
                            <!-- ↑↑↑↑↑ 加入垃圾桶元件 ↑↑↑↑ -->
                        </tr>
                        <!-- 租借明細結束  由此開始循環 -->
                        <tr>
                            <td>
                                <div class="media">
                                    <div class="d-flex">
                                        <img src="img/product/single-product/cart-1.jpg" alt="" />
                                    </div>
                                    <div class="media-body">
                                        <p>Minimalistic shop for multipurpose use</p>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <h5>$360.00</h5>
                            </td>
                            <td>
                                <div class="product_count">
                                    <!-- <input type="text" value="1" min="0" max="10" title="Quantity:"
                      class="input-text qty input-number" />
                    <button
                      class="increase input-number-increment items-count" type="button">
                      <i class="ti-angle-up"></i>
                    </button>
                    <button
                      class="reduced input-number-decrement items-count" type="button">
                      <i class="ti-angle-down"></i>
                    </button> -->
                                    <span class="input-number-decrement"> <i class="ti-angle-down"></i></span>
                                    <input class="input-number" type="text" value="1" min="0" max="10">
                                    <span class="input-number-increment"> <i class="ti-angle-up"></i></span>
                                </div>
                            </td>
                            <td>
                                <h5>$720.00</h5>
                            </td>
                            <!-- ↓↓↓↓ 加入垃圾桶元件 ↓↓↓↓ -->
                            <td>
                                <div class="">
                                    <ul class="list-inline justify-content-center">
                                        <span>&nbsp&nbsp&nbsp&nbsp<span>
                                                <li class="list-inline-item">
                                                    <a data-toggle="tooltip" data-placement="top" title="" class="delete" href="" data-original-title="Delete">
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </li>
                                    </ul>
                                </div>
                            </td>
                            <!-- ↑↑↑↑↑ 加入垃圾桶元件 ↑↑↑↑ -->
                        </tr>
                    
                        <!-- 此部分開始顯示明細合計 -->
                        <tr>
                            <td></td>
                            <td></td>
                            <td>
                                <h5>Subtotal</h5>
                            </td>
                            <td>
                                <h5>$2160.00</h5>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <!-- 顯示明細合計結束 -->
                        </tbody>
                    </table>
                    <!-- 繼續購物或結帳區塊 開始 -->
                    <div class="checkout_btn_inner float-right">
                        <a class="btn_1" href="#">Continue Shopping</a>
                        <a class="btn_1 checkout_btn_1" href="#">Proceed to checkout</a>
                    </div>
                    <!-- 繼續購物或結帳區塊 結束 -->
                </div>
            </div>
    </section>


<!-- JS ajax -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script> 
<script type="text/javascript">


</script>
<%@ include file="/front-end/footer.file"%>
</body>
</html>
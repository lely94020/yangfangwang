<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>购物车 - 药房网商城</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        a{text-decoration:none;color:#666;}
        .container{width:1200px;margin:0 auto;}
        .top-bar{background:#f5f5f5;border-bottom:1px solid #eee;padding:8px 0;font-size:12px;}
        .top-bar .container{display:flex;justify-content:space-between;}
        .header{display:flex;align-items:center;padding:20px 0;}
        .logo{display:flex;align-items:center;margin-right:30px;}
        .logo-icon{width:48px;height:48px;background:#4CAF50;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;font-size:24px;margin-right:10px;}
        .logo-text h1{font-size:24px;color:#333;}
        .page-title{font-size:22px;color:#666;}
        .cart-section{background:white;border:1px solid #eee;border-radius:4px;margin-bottom:20px;}
        .cart-header{background:#4CAF50;color:white;padding:12px 20px;font-weight:bold;}
        .cart-table-header{display:grid;grid-template-columns:60px 3fr 1fr 1fr 1fr;padding:12px 20px;border-bottom:1px solid #eee;font-size:14px;color:#666;}
        .cart-item{display:grid;grid-template-columns:60px 3fr 1fr 1fr 1fr;padding:15px 20px;align-items:center;border-bottom:1px solid #f4f4f4;}
        .item-info{display:flex;align-items:center;}
        .item-img{width:60px;height:60px;margin-right:15px;display:flex;align-items:center;justify-content:center;background:#f9f9f9;border-radius:4px;}
        .item-img img{max-height:50px;max-width:100%;}
        .item-details .item-name{font-size:14px;font-weight:500;margin-bottom:3px;}
        .item-details .item-spec{font-size:12px;color:#999;}
        .item-price{text-align:center;font-size:14px;color:#333;}
        .quantity-control{display:flex;align-items:center;justify-content:center;}
        .quantity-btn{width:24px;height:24px;border:1px solid #ccc;background:white;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:14px;}
        .quantity-input{width:40px;height:24px;border:1px solid #ccc;border-left:none;border-right:none;text-align:center;font-size:14px;}
        .item-subtotal{text-align:center;font-size:14px;color:#e74c3c;font-weight:bold;}
        .cart-footer{background:white;border:1px solid #eee;border-radius:4px;padding:15px 20px;display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;}
        .footer-left{display:flex;align-items:center;gap:20px;}
        .footer-left .continue-btn{color:#4CAF50;font-size:14px;cursor:pointer;}
        .footer-right{display:flex;align-items:center;}
        .total-text{font-size:14px;color:#333;margin-right:20px;}
        .total-price{font-size:20px;color:#e74c3c;font-weight:bold;margin-right:20px;}
        .checkout-btn{background:#d32f2f;color:white;border:none;padding:12px 40px;font-size:16px;cursor:pointer;border-radius:3px;}
        .empty-cart{text-align:center;padding:60px 0;color:#999;}
        .empty-cart i{font-size:64px;display:block;margin-bottom:15px;color:#ddd;}
        .empty-cart a{color:#409EFF;font-size:14px;}
        .footer{background:#f5f5f5;padding:30px 0;margin-top:30px;text-align:center;font-size:12px;color:#666;}
        .top-bar-right a{margin:0 10px;color:#666;}
        .item-actions{text-align:center;}
        .item-actions a{font-size:12px;color:#f56c6c;cursor:pointer;}
    </style>
</head>
<body>
<div class="top-bar">
    <div class="container">
        <div class="top-bar-left"><a href="#"><i class="fas fa-star"></i> 收藏药房网商城</a></div>
        <div class="top-bar-right">
            <a href="#">您好，${sessionScope.member.username}</a>
            <a href="${pageContext.request.contextPath}/logout">[退出]</a>
            <a href="${pageContext.request.contextPath}/order?action=list">我的订单</a>
        </div>
    </div>
</div>
<div class="container header">
    <a href="${pageContext.request.contextPath}/" style="display:flex;align-items:center;text-decoration:none;">
        <div class="logo-icon"><i class="fas fa-plus"></i></div>
        <div class="logo-text"><h1>药房网商城</h1><p>www.yaofangwang.com</p></div>
    </a>
    <div class="page-title">购物车</div>
</div>
<div class="container">
    <div class="cart-section">
        <div class="cart-header">商品列表</div>
        <div class="cart-table-header">
            <div>商品信息</div>
            <div>单价（元）</div>
            <div>数量</div>
            <div>小计（元）</div>
            <div>操作</div>
        </div>
        <c:choose>
            <c:when test="${not empty cartItems}">
                <c:forEach items="${cartItems}" var="item">
                <div class="cart-item" data-id="${item.id}" data-price="${item.price}">
                    <div class="item-info">
                        <div class="item-img">
                            <c:choose>
                                <c:when test="${not empty item.imageUrl}"><img src="${item.imageUrl}" alt="${item.productName}"></c:when>
                                <c:otherwise><i class="fas fa-pills" style="font-size:30px;color:#ccc;"></i></c:otherwise>
                            </c:choose>
                        </div>
                        <div class="item-details">
                            <div class="item-name">${item.productName}</div>
                            <div class="item-spec">${item.specification}</div>
                        </div>
                    </div>
                    <div class="item-price" data-unit-price="${item.price}">¥${item.price}</div>
                    <div>
                        <div class="quantity-control">
                            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;" class="update-form">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${item.id}">
                                <input type="hidden" name="quantity" class="qty-hidden" value="${item.quantity}">
                                <button type="button" class="quantity-btn minus" onclick="changeQty(this,-1)">-</button>
                                <input type="text" class="quantity-input" value="${item.quantity}" readonly>
                                <button type="button" class="quantity-btn plus" onclick="changeQty(this,1)">+</button>
                            </form>
                        </div>
                    </div>
                    <div class="item-subtotal">¥<fmt:formatNumber value="${item.price * item.quantity}" pattern="#0.00"/></div>
                    <div class="item-actions">
                        <a href="${pageContext.request.contextPath}/cart?action=delete&id=${item.id}" onclick="return confirm('确定要删除吗？')">删除</a>
                    </div>
                </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <p>购物车是空的</p>
                    <a href="${pageContext.request.contextPath}/product?action=list">去逛逛 &gt;</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <c:if test="${not empty cartItems}">
    <div class="cart-footer">
        <div class="footer-left">
            <div class="continue-btn"><a href="${pageContext.request.contextPath}/product?action=list" style="color:#4CAF50;">我再逛逛 &gt;</a></div>
        </div>
        <div class="footer-right">
            <div class="total-text">合计：</div>
            <div class="total-price" id="finalTotal">¥<fmt:formatNumber value="${cartItems.stream().map(i -> i.price * i.quantity).sum()}" pattern="#0.00"/></div>
            <button class="checkout-btn" onclick="checkout()">去结算</button>
        </div>
    </div>
    </c:if>
</div>
<div class="footer"><p>©2026 药房网商城 版权所有</p></div>
<script>
function changeQty(btn, delta) {
    var form = btn.closest('.quantity-control').querySelector('.update-form');
    var input = form.querySelector('.quantity-input');
    var hidden = form.querySelector('.qty-hidden');
    var val = parseInt(input.value) + delta;
    if (val < 1) val = 1;
    input.value = val;
    hidden.value = val;
    // Submit to update
    var xhr = new XMLHttpRequest();
    xhr.open('POST', form.action, true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function() { location.reload(); };
    xhr.send('action=update&id=' + form.querySelector('[name=id]').value + '&quantity=' + val);
}
function checkout() {
    window.location.href = '${pageContext.request.contextPath}/cart?action=list';
}
</script>
</body>
</html>

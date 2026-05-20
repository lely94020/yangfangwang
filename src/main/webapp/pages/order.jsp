<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>我的订单 - 药房网商城</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        a{text-decoration:none;color:#666;}
        .container{width:1200px;margin:0 auto;}
        .top-bar{background:#f5f5f5;border-bottom:1px solid #eee;padding:8px 0;font-size:12px;}
        .top-bar .container{display:flex;justify-content:space-between;}
        .top-bar-left a,.top-bar-right a{margin:0 10px;color:#666;}
        .header{display:flex;justify-content:space-between;align-items:center;padding:20px 0;}
        .logo{display:flex;align-items:center;}
        .logo-icon{width:48px;height:48px;background:#4CAF50;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;font-size:24px;margin-right:10px;}
        .logo-text h1{font-size:24px;color:#333;}
        .main-nav{background:#4CAF50;color:white;}
        .main-nav .container{display:flex;}
        .nav-item{padding:12px 30px;cursor:pointer;}
        .main-container{display:flex;gap:20px;margin:20px 0;}
        .sidebar{width:200px;background:white;border:1px solid #eee;border-radius:4px;}
        .sidebar-menu{list-style:none;}
        .sidebar-item{display:flex;align-items:center;padding:15px 20px;cursor:pointer;border-left:3px solid transparent;}
        .sidebar-item.active{background:#f5f5f5;border-left-color:#4CAF50;color:#4CAF50;}
        .sidebar-item i{font-size:18px;margin-right:10px;width:24px;text-align:center;}
        .order-main{flex:1;background:white;border:1px solid #eee;border-radius:4px;padding:20px;}
        .order-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;}
        .order-title{font-size:16px;font-weight:bold;color:#333;}
        .order-card{border:1px solid #eee;border-radius:4px;padding:15px;margin-bottom:15px;}
        .order-card-header{display:flex;justify-content:space-between;align-items:center;padding-bottom:10px;border-bottom:1px solid #f0f0f0;margin-bottom:10px;font-size:13px;color:#666;}
        .order-card-header .status{color:#4CAF50;font-weight:bold;}
        .order-item{display:flex;justify-content:space-between;align-items:center;padding:8px 0;font-size:14px;}
        .order-item .name{flex:2;}
        .order-item .price{width:100px;text-align:right;}
        .order-item .qty{width:60px;text-align:center;}
        .order-card-footer{display:flex;justify-content:space-between;align-items:center;padding-top:10px;border-top:1px solid #f0f0f0;margin-top:10px;}
        .order-total{font-size:14px;}
        .order-total .amount{color:#e74c3c;font-weight:bold;font-size:16px;}
        .btn{display:inline-block;padding:6px 16px;border-radius:4px;border:none;cursor:pointer;font-size:12px;text-decoration:none;}
        .btn-primary{background:#409EFF;color:#fff;}
        .btn-default{background:#909399;color:#fff;}
        .btn-danger{background:#f56c6c;color:#fff;}
        .empty-order{text-align:center;padding:50px 0;color:#999;font-size:14px;}
        .footer{background:#f5f5f5;padding:30px 0;margin-top:30px;text-align:center;font-size:12px;color:#666;}
        .status-badge{padding:2px 8px;border-radius:10px;font-size:12px;}
        .status-badge-0{background:#fde2e2;color:#f56c6c;}
        .status-badge-1{background:#e1f3d8;color:#67c23a;}
        .status-badge-2{background:#e1f3d8;color:#67c23a;}
        .status-badge-3{background:#e1f3d8;color:#67c23a;}
        .status-badge-4{background:#fde2e2;color:#909399;}
    </style>
</head>
<body>
<div class="top-bar">
    <div class="container">
        <div class="top-bar-left">
            <a href="#"><i class="fas fa-star"></i> 收藏药房网商城</a>
            <a href="#"><i class="fas fa-qrcode"></i> 微信查价</a>
            <a href="#"><i class="fas fa-mobile-alt"></i> 手机APP</a>
        </div>
        <div class="top-bar-right">
            <a href="#">您好，${sessionScope.member.username}</a>
            <a href="${pageContext.request.contextPath}/logout">[退出]</a>
            <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> 购物车</a>
            <a href="#">客服中心</a>
        </div>
    </div>
</div>
<div class="container header">
    <a href="${pageContext.request.contextPath}/" style="display:flex;align-items:center;text-decoration:none;">
        <div class="logo-icon"><i class="fas fa-plus"></i></div>
        <div class="logo-text"><h1>药房网商城</h1><p>www.yaofangwang.com</p></div>
    </a>
</div>
<div class="main-nav">
    <div class="container">
        <div class="nav-item"><a href="${pageContext.request.contextPath}/" style="color:white;">首页</a></div>
        <div class="nav-item"><a href="${pageContext.request.contextPath}/product?action=list" style="color:white;">全部商品</a></div>
    </div>
</div>
<div class="container main-container">
    <div class="sidebar">
        <ul class="sidebar-menu">
            <li class="sidebar-item active"><i class="fas fa-file-alt text-green-500"></i> 我的订单</li>
            <li class="sidebar-item"><i class="fas fa-star text-green-500"></i> 收藏中心</li>
        </ul>
    </div>
    <div class="order-main">
        <div class="order-header">
            <div class="order-title">我的订单</div>
        </div>
        <c:choose>
            <c:when test="${not empty orders}">
                <c:forEach items="${orders}" var="o">
                <div class="order-card">
                    <div class="order-card-header">
                        <span>订单号：${o.orderNo}</span>
                        <span>下单时间：<fmt:formatDate value="${o.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                        <span class="status-badge status-badge-${o.status}">${o.statusText}</span>
                    </div>
                    <c:forEach items="${o.items}" var="item">
                    <div class="order-item">
                        <span class="name">${item.productName}</span>
                        <span class="price">¥${item.price}</span>
                        <span class="qty">×${item.quantity}</span>
                        <span class="price">¥${item.subtotal}</span>
                    </div>
                    </c:forEach>
                    <div class="order-card-footer">
                        <div class="order-total">
                            合计：<span class="amount">¥${o.totalAmount}</span>
                        </div>
                        <div>
                            <a href="${pageContext.request.contextPath}/order?action=view&id=${o.id}" class="btn btn-primary">查看详情</a>
                            <c:if test="${o.status == 0}">
                                <a href="${pageContext.request.contextPath}/order?action=cancel&id=${o.id}" class="btn btn-danger" onclick="return confirm('确认取消该订单？')">取消订单</a>
                            </c:if>
                        </div>
                    </div>
                </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-order">
                    <i class="fas fa-file-invoice" style="font-size:48px;display:block;margin-bottom:15px;color:#ddd;"></i>
                    您目前没有任何订单
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div class="footer"><p>©2026 药房网商城 版权所有</p></div>
</body>
</html>

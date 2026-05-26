<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.name} - 药房网商城</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        body{background:#f5f5f5;}
        a{text-decoration:none;color:#666;}
        .container{width:1200px;margin:0 auto;}
        .top-bar{background:#f5f5f5;border-bottom:1px solid #eee;padding:8px 0;font-size:12px;}
        .top-bar .container{display:flex;justify-content:space-between;}
        .top-bar-right a{margin:0 10px;color:#666;}
        .header{display:flex;justify-content:space-between;align-items:center;padding:20px 0;}
        .logo{display:flex;align-items:center;}
        .logo-icon{width:48px;height:48px;background:#4CAF50;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;font-size:24px;margin-right:10px;}
        .logo-text h1{font-size:24px;color:#333;}
        .main-nav{background:#4CAF50;color:white;}
        .main-nav .container{display:flex;}
        .nav-item{padding:12px 30px;cursor:pointer;}
        .breadcrumb{padding:15px 0;font-size:12px;color:#666;}
        .product-main{display:flex;gap:30px;margin-bottom:30px;background:#fff;padding:30px;border-radius:8px;}
        .product-left{width:400px;}
        .main-img{width:100%;height:350px;border:1px solid #eee;border-radius:4px;display:flex;align-items:center;justify-content:center;margin-bottom:15px;}
        .main-img img{max-width:80%;max-height:80%;}
        .product-right{flex:1;}
        .product-name{font-size:22px;font-weight:bold;color:#333;margin-bottom:15px;}
        .info-list{margin-bottom:20px;}
        .info-item{display:flex;margin-bottom:8px;font-size:13px;}
        .info-label{width:100px;color:#666;}
        .info-value{flex:1;color:#333;}
        .price-section{background:#f5f5f5;padding:20px;border-radius:4px;margin-bottom:20px;display:flex;align-items:center;}
        .price-label{font-size:14px;color:#666;margin-right:20px;}
        .price-value{font-size:28px;color:#e74c3c;font-weight:bold;margin-right:20px;}
        .stock-text{font-size:14px;color:#666;}
        .actions{display:flex;gap:15px;}
        .btn{display:inline-flex;align-items:center;padding:12px 30px;border-radius:4px;border:none;cursor:pointer;font-size:16px;text-decoration:none;}
        .btn-cart{background:#ff9800;color:#fff;}
        .btn-buy{background:#e74c3c;color:#fff;}
        .btn-back{background:#909399;color:#fff;}
        .footer{background:#f5f5f5;padding:30px 0;margin-top:30px;text-align:center;font-size:12px;color:#666;}
        .product-desc{background:#fff;border-radius:8px;padding:30px;margin-bottom:30px;}
        .product-desc h3{margin-bottom:15px;padding-bottom:10px;border-bottom:1px solid #eee;}
        .product-desc p{line-height:1.8;color:#666;font-size:14px;}
        .login-tip{background:#fff9e6;padding:12px 20px;border-radius:4px;margin-bottom:20px;font-size:13px;color:#e6a23c;}
        .login-tip a{color:#409EFF;}
    </style>
</head>
<body>
<div class="top-bar">
    <div class="container">
        <div class="top-bar-right" style="margin-left:auto;">
            <c:choose>
                <c:when test="${not empty sessionScope.member}">
                    <a href="#">您好，${sessionScope.member.username}</a>
                    <a href="${pageContext.request.contextPath}/logout">[退出]</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">登录/免费注册</a>
                </c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> 购物车</a>
            <a href="${pageContext.request.contextPath}/order?action=list">我的订单</a>
        </div>
    </div>
</div>
<div class="container header">
    <a href="${pageContext.request.contextPath}/" style="display:flex;align-items:center;text-decoration:none;">
        <div class="logo-icon"><i class="fas fa-plus"></i></div>
        <div class="logo-text"><h1>药房网商城</h1></div>
    </a>
</div>
<div class="main-nav"><div class="container"><div class="nav-item"><a href="${pageContext.request.contextPath}/" style="color:white;">首页</a></div></div></div>
<div class="container breadcrumb"><a href="${pageContext.request.contextPath}/">首页</a> &gt; <a href="${pageContext.request.contextPath}/product?action=list">全部商品</a> &gt; ${product.name}</div>
<div class="container product-main">
    <div class="product-left">
        <div class="main-img">
            <c:choose>
                <c:when test="${not empty product.imageUrl}"><img src="${product.imageUrl.startsWith('http') ? product.imageUrl : pageContext.request.contextPath.concat('/').concat(product.imageUrl)}" alt="${product.name}"></c:when>
                <c:otherwise><i class="fas fa-pills" style="font-size:80px;color:#ccc;"></i></c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="product-right">
        <h1 class="product-name">${product.name}</h1>
        <div class="info-list">
            <div class="info-item"><div class="info-label">批准文号</div><div class="info-value">${product.approvalNumber}</div></div>
            <div class="info-item"><div class="info-label">通用名</div><div class="info-value">${product.genericName}</div></div>
            <div class="info-item"><div class="info-label">规格</div><div class="info-value">${product.specification}</div></div>
            <div class="info-item"><div class="info-label">剂型</div><div class="info-value">${product.dosageForm}</div></div>
            <div class="info-item"><div class="info-label">生产厂家</div><div class="info-value">${product.manufacturer}</div></div>
            <div class="info-item"><div class="info-label">分类</div><div class="info-value">${product.categoryName}</div></div>
        </div>
        <div class="price-section">
            <div class="price-label">价格</div>
            <div class="price-value">¥${product.price}</div>
            <div class="stock-text">库存：${product.stock}</div>
        </div>
        <c:choose>
            <c:when test="${not empty sessionScope.member}">
                <c:if test="${product.stock > 0}">
                <div class="actions">
                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${product.id}">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn btn-cart"><i class="fas fa-cart-plus" style="margin-right:5px;"></i> 加入购物车</button>
                    </form>
                    <a href="${pageContext.request.contextPath}/product?action=list" class="btn btn-back">继续购物</a>
                </div>
                </c:if>
                <c:if test="${product.stock == 0}">
                    <div style="color:#f56c6c;font-size:16px;margin-top:10px;">该商品暂时缺货</div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="login-tip"><i class="fas fa-info-circle"></i> 请<a href="${pageContext.request.contextPath}/login">登录</a>后购买商品</div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div class="container product-desc">
    <h3>商品详情</h3>
    <p>${product.description}</p>
</div>
<div class="footer"><p>©2026 药房网商城 版权所有</p></div>
</body>
</html>

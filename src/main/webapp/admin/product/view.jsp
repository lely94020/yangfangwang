<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品详情 - 后台管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        body{background:#f0f2f5;display:flex;}
        .sidebar{width:220px;background:#304156;min-height:100vh;color:#fff;}
        .sidebar .logo{padding:20px;text-align:center;}
        .sidebar .logo h3{font-size:18px;}
        .sidebar-menu{list-style:none;}
        .sidebar-menu li a{display:flex;align-items:center;padding:14px 20px;color:rgba(255,255,255,.7);text-decoration:none;font-size:14px;border-left:3px solid transparent;}
        .sidebar-menu li a i{width:20px;margin-right:10px;}
        .sidebar-menu li a:hover,.sidebar-menu li a.active{background:rgba(255,255,255,.05);color:#fff;border-left-color:#409EFF;}
        .main{flex:1;display:flex;flex-direction:column;}
        .header{background:#fff;padding:0 20px;height:60px;display:flex;align-items:center;justify-content:space-between;box-shadow:0 1px 4px rgba(0,0,0,.08);}
        .content{padding:20px;flex:1;}
        .detail-card{background:#fff;border-radius:8px;padding:30px;box-shadow:0 2px 8px rgba(0,0,0,.06);max-width:800px;}
        .detail-card h3{margin-bottom:20px;}
        .info-table{width:100%;}
        .info-table td{padding:10px 15px;font-size:14px;border-bottom:1px solid #f0f0f0;}
        .info-table td.label{color:#666;width:120px;background:#fafafa;}
        .btn{padding:6px 16px;border-radius:4px;border:none;cursor:pointer;font-size:13px;text-decoration:none;display:inline-block;}
        .btn-primary{background:#409EFF;color:#fff;}
        .btn-default{background:#909399;color:#fff;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h3><i class="fas fa-plus" style="color:#4CAF50;"></i> 药房网</h3></div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/product?action=list" class="active"><i class="fas fa-box"></i> 商品管理</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><div class="breadcrumb">商品详情</div></div>
    <div class="content">
        <div class="detail-card">
            <h3>${product.name}</h3>
            <table class="info-table">
                <tr><td class="label">ID</td><td>${product.id}</td></tr>
                <tr><td class="label">通用名</td><td>${product.genericName}</td></tr>
                <tr><td class="label">批准文号</td><td>${product.approvalNumber}</td></tr>
                <tr><td class="label">生产厂家</td><td>${product.manufacturer}</td></tr>
                <tr><td class="label">规格</td><td>${product.specification}</td></tr>
                <tr><td class="label">剂型</td><td>${product.dosageForm}</td></tr>
                <tr><td class="label">分类</td><td>${product.categoryName}</td></tr>
                <tr><td class="label">价格</td><td>¥${product.price}</td></tr>
                <tr><td class="label">库存</td><td>${product.stock}</td></tr>
                <tr><td class="label">状态</td><td>${product.status == 1 ? '已上架' : '已下架'}</td></tr>
                <tr><td class="label">创建时间</td><td><fmt:formatDate value="${product.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
                <tr><td class="label">更新时间</td><td><fmt:formatDate value="${product.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
                <tr><td class="label">上架时间</td><td><fmt:formatDate value="${product.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
                <tr><td class="label">描述</td><td>${product.description}</td></tr>
            </table>
            <div style="margin-top:20px;">
                <a href="${pageContext.request.contextPath}/admin/product?action=edit&id=${product.id}" class="btn btn-primary">编辑</a>
                <a href="${pageContext.request.contextPath}/admin/product?action=list" class="btn btn-default" style="margin-left:10px;">返回列表</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>

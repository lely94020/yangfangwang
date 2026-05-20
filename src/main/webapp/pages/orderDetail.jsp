<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单详情 - 药房网商城</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        body{background:#f5f5f5;}
        a{text-decoration:none;color:#409EFF;}
        .container{width:1000px;margin:0 auto;}
        .header{background:#fff;padding:20px 0;border-bottom:1px solid #eee;}
        .header .container{display:flex;align-items:center;}
        .logo-icon{width:40px;height:40px;background:#4CAF50;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;font-size:20px;margin-right:10px;}
        .logo-text h1{font-size:20px;color:#333;}
        .content{background:#fff;border-radius:8px;margin:30px auto;padding:30px;box-shadow:0 2px 8px rgba(0,0,0,.06);}
        .order-header{border-bottom:1px solid #eee;padding-bottom:20px;margin-bottom:20px;}
        .order-header h2{margin-bottom:10px;}
        .status-badge{padding:4px 12px;border-radius:10px;font-size:13px;}
        .status-0{background:#fde2e2;color:#f56c6c;}
        .status-1{background:#e1f3d8;color:#67c23a;}
        .status-2{background:#e1f3d8;color:#67c23a;}
        .status-3{background:#e1f3d8;color:#67c23a;}
        .status-4{background:#fde2e2;color:#909399;}
        .info-table{width:100%;margin-bottom:20px;}
        .info-table td{padding:8px 15px;font-size:14px;border-bottom:1px solid #f0f0f0;}
        .info-table td.label{color:#666;width:120px;background:#fafafa;}
        .items-table{width:100%;border-collapse:collapse;margin-bottom:20px;}
        .items-table th,.items-table td{padding:10px;text-align:left;font-size:13px;border-bottom:1px solid #ebeef5;}
        .items-table th{background:#f5f7fa;}
        .total-row{text-align:right;font-weight:bold;font-size:18px;color:#f56c6c;padding:15px 10px;}
        .btn{padding:8px 20px;border-radius:4px;border:none;cursor:pointer;font-size:14px;text-decoration:none;display:inline-block;}
        .btn-primary{background:#409EFF;color:#fff;}
        .btn-default{background:#909399;color:#fff;}
    </style>
</head>
<body>
<div class="header">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" style="display:flex;align-items:center;">
            <div class="logo-icon"><i class="fas fa-plus"></i></div>
            <div class="logo-text"><h1>药房网商城</h1></div>
        </a>
    </div>
</div>
<div class="container content">
    <div class="order-header">
        <h2>订单详情 <span class="status-badge status-${order.status}">${order.statusText}</span></h2>
        <p style="color:#999;font-size:13px;">订单号：${order.orderNo}</p>
    </div>
    <table class="info-table">
        <tr><td class="label">下单时间</td><td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
        <tr><td class="label">收货人</td><td>${order.consignee}</td></tr>
        <tr><td class="label">联系电话</td><td>${order.phone}</td></tr>
        <tr><td class="label">收货地址</td><td>${order.address}</td></tr>
    </table>
    <h3 style="margin-bottom:15px;">商品清单</h3>
    <table class="items-table">
        <thead><tr><th>商品名称</th><th>单价</th><th>数量</th><th>小计</th></tr></thead>
        <tbody>
            <c:forEach items="${order.items}" var="item">
            <tr>
                <td>${item.productName}</td>
                <td>¥${item.price}</td>
                <td>${item.quantity}</td>
                <td>¥${item.subtotal}</td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="total-row">合计：¥${order.totalAmount}</div>
    <div style="margin-top:20px;">
        <a href="${pageContext.request.contextPath}/order?action=list" class="btn btn-default">返回订单列表</a>
    </div>
</div>
</body>
</html>

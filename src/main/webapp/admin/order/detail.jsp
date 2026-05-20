<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单详情 - 后台管理</title>
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
        .header{background:#fff;padding:0 20px;height:60px;display:flex;align-items:center;justify-content:space-between;}
        .content{padding:20px;flex:1;}
        .card{background:#fff;border-radius:8px;padding:25px;box-shadow:0 2px 8px rgba(0,0,0,.06);margin-bottom:20px;}
        .card h3{margin-bottom:15px;font-size:16px;color:#333;border-bottom:1px solid #eee;padding-bottom:10px;}
        .info-table{width:100%;}
        .info-table td{padding:8px 15px;font-size:14px;border-bottom:1px solid #f0f0f0;}
        .info-table td.label{color:#666;width:120px;background:#fafafa;}
        .btn{padding:6px 16px;border-radius:4px;border:none;cursor:pointer;font-size:13px;text-decoration:none;display:inline-block;}
        .btn-primary{background:#409EFF;color:#fff;}
        .btn-default{background:#909399;color:#fff;}
        .order-items-table{width:100%;border-collapse:collapse;}
        .order-items-table th,.order-items-table td{padding:10px;text-align:left;font-size:13px;border-bottom:1px solid #ebeef5;}
        .order-items-table th{background:#f5f7fa;}
        .status-badge{padding:2px 8px;border-radius:10px;font-size:12px;}
        .status-0{background:#fde2e2;color:#f56c6c;}
        .status-1{background:#e1f3d8;color:#67c23a;}
        .status-2{background:#e1f3d8;color:#67c23a;}
        .status-3{background:#e1f3d8;color:#67c23a;}
        .status-4{background:#fde2e2;color:#909399;}
        .total-row{text-align:right;font-weight:bold;font-size:16px;color:#f56c6c;padding:15px;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h3><i class="fas fa-plus" style="color:#4CAF50;"></i> 药房网</h3></div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/product?action=list"><i class="fas fa-box"></i> 商品管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/order?action=list" class="active"><i class="fas fa-file-invoice"></i> 订单管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/member?action=list"><i class="fas fa-user-friends"></i> 会员管理</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><div class="breadcrumb">订单详情</div></div>
    <div class="content">
        <div class="card">
            <h3>订单信息</h3>
            <table class="info-table">
                <tr><td class="label">订单号</td><td>${order.orderNo}</td></tr>
                <tr><td class="label">会员</td><td>${order.memberName}</td></tr>
                <tr><td class="label">订单状态</td><td><span class="status-badge status-${order.status}">${order.statusText}</span></td></tr>
                <tr><td class="label">收货人</td><td>${order.consignee}</td></tr>
                <tr><td class="label">联系电话</td><td>${order.phone}</td></tr>
                <tr><td class="label">收货地址</td><td>${order.address}</td></tr>
                <tr><td class="label">下单时间</td><td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
            </table>
        </div>
        <div class="card">
            <h3>商品明细</h3>
            <table class="order-items-table">
                <thead>
                    <tr><th>商品名称</th><th>单价</th><th>数量</th><th>小计</th></tr>
                </thead>
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
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/order?action=list" class="btn btn-default">返回列表</a>
        </div>
    </div>
</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>结算 - 药房网商城</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        a{text-decoration:none;color:#409EFF;}
        body{background:#f5f5f5;}
        .top-bar{background:#f5f5f5;border-bottom:1px solid #eee;padding:8px 0;font-size:12px;}
        .top-bar .container{width:1000px;margin:0 auto;display:flex;justify-content:space-between;}
        .top-bar-right a{margin:0 10px;color:#666;}
        .header{background:#fff;padding:20px 0;border-bottom:1px solid #eee;}
        .header .container{width:1000px;margin:0 auto;display:flex;align-items:center;}
        .logo-icon{width:40px;height:40px;background:#4CAF50;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;font-size:20px;margin-right:10px;}
        .logo-text h1{font-size:20px;color:#333;}
        .container{width:800px;margin:30px auto;}
        .checkout-card{background:#fff;border-radius:8px;padding:30px;box-shadow:0 2px 8px rgba(0,0,0,.06);}
        .checkout-card h2{text-align:center;margin-bottom:30px;color:#333;border-bottom:2px solid #4CAF50;padding-bottom:15px;}
        .step-bar{display:flex;justify-content:center;margin-bottom:30px;}
        .step{display:flex;align-items:center;font-size:13px;color:#999;}
        .step.active{color:#4CAF50;font-weight:bold;}
        .step .num{width:24px;height:24px;border-radius:50%;background:#ddd;color:#fff;display:flex;align-items:center;justify-content:center;font-size:12px;margin-right:6px;}
        .step.active .num{background:#4CAF50;}
        .step-line{width:60px;height:1px;background:#ddd;margin:0 15px;}
        .form-group{margin-bottom:18px;}
        .form-group label{display:block;font-size:14px;color:#666;margin-bottom:5px;}
        .form-group input,.form-group textarea{width:100%;height:40px;border:1px solid #dcdfe6;border-radius:4px;padding:0 12px;font-size:14px;outline:none;}
        .form-group textarea{height:80px;padding:12px;resize:none;}
        .form-group input:focus,.form-group textarea:focus{border-color:#409EFF;}
        .form-row{display:flex;gap:20px;}
        .form-row .form-group{flex:1;}
        .order-summary{background:#f9f9f9;border-radius:4px;padding:20px;margin-bottom:20px;}
        .order-summary h3{margin-bottom:15px;font-size:16px;}
        .summary-table{width:100%;border-collapse:collapse;font-size:13px;}
        .summary-table th{background:#f0f0f0;padding:8px 10px;text-align:left;}
        .summary-table td{padding:8px 10px;border-bottom:1px solid #eee;}
        .summary-item{display:flex;justify-content:space-between;padding:5px 0;font-size:14px;color:#666;}
        .summary-item .amount{color:#f56c6c;font-weight:bold;font-size:18px;}
        .btn{width:100%;height:44px;background:#d32f2f;color:#fff;border:none;border-radius:4px;font-size:18px;cursor:pointer;}
        .btn:hover{background:#b71c1c;}
        .back-link{display:block;text-align:center;margin-top:15px;}
        .back-link a{color:#409EFF;text-decoration:none;font-size:14px;}
        .footer{background:#f5f5f5;padding:30px 0;margin-top:30px;text-align:center;font-size:12px;color:#666;}
    </style>
</head>
<body>
<div class="top-bar">
    <div class="container">
        <div></div>
        <div class="top-bar-right">
            <a href="#">您好，${sessionScope.member.username}</a>
            <a href="${pageContext.request.contextPath}/logout">[退出]</a>
        </div>
    </div>
</div>
<div class="header">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" style="display:flex;align-items:center;">
            <div class="logo-icon"><i class="fas fa-plus"></i></div>
            <div class="logo-text"><h1>药房网商城</h1></div>
        </a>
    </div>
</div>
<div class="container">
    <div class="step-bar">
        <div class="step active"><span class="num">1</span> 我的购物车</div>
        <div class="step-line"></div>
        <div class="step active"><span class="num">2</span> 填写核对信息</div>
        <div class="step-line"></div>
        <div class="step"><span class="num">3</span> 确认提交订单</div>
    </div>
    <div class="checkout-card">
        <h2>填写核对购买信息</h2>
        <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="action" value="checkout">
            <div class="form-row">
                <div class="form-group">
                    <label>收货人 <span style="color:#f56c6c;">*</span></label>
                    <input type="text" name="consignee" value="${sessionScope.member.realName}" required>
                </div>
                <div class="form-group">
                    <label>联系电话 <span style="color:#f56c6c;">*</span></label>
                    <input type="text" name="phone" value="${sessionScope.member.phone}" required>
                </div>
            </div>
            <div class="form-group">
                <label>收货地址 <span style="color:#f56c6c;">*</span></label>
                <input type="text" name="address" value="${sessionScope.member.address}" required>
            </div>
            <div class="form-group">
                <label>备注信息</label>
                <textarea name="remark" placeholder="选填，如有特殊要求请注明"></textarea>
            </div>
            <div class="order-summary">
                <h3>商品清单</h3>
                <table class="summary-table">
                    <thead><tr><th>商品名称</th><th>规格</th><th>单价</th><th>数量</th><th>小计</th></tr></thead>
                    <tbody>
                        <c:forEach items="${checkoutItems}" var="item">
                        <tr>
                            <td>${item.productName}</td>
                            <td style="color:#999;">${item.specification}</td>
                            <td>¥<fmt:formatNumber value="${item.price}" pattern="#0.00"/></td>
                            <td>${item.quantity}</td>
                            <td style="color:#f56c6c;">¥<fmt:formatNumber value="${item.subtotal}" pattern="#0.00"/></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div style="text-align:right;padding-top:15px;font-size:14px;">
                    合计：<span style="color:#f56c6c;font-weight:bold;font-size:20px;">¥<fmt:formatNumber value="${totalAmount}" pattern="#0.00"/></span>
                </div>
            </div>
            <button class="btn">确认提交订单</button>
        </form>
        <div class="back-link"><a href="${pageContext.request.contextPath}/cart"><i class="fas fa-arrow-left"></i> 返回购物车</a></div>
    </div>
</div>
<div class="footer"><p>©2026 药房网商城 版权所有</p></div>
</body>
</html>

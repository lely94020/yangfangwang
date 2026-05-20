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
        body{background:#f5f5f5;}
        .container{width:800px;margin:30px auto;}
        .checkout-card{background:#fff;border-radius:8px;padding:30px;box-shadow:0 2px 8px rgba(0,0,0,.06);}
        .checkout-card h2{text-align:center;margin-bottom:30px;color:#333;border-bottom:2px solid #4CAF50;padding-bottom:15px;}
        .form-group{margin-bottom:18px;}
        .form-group label{display:block;font-size:14px;color:#666;margin-bottom:5px;}
        .form-group input{width:100%;height:40px;border:1px solid #dcdfe6;border-radius:4px;padding:0 12px;font-size:14px;outline:none;}
        .form-group input:focus{border-color:#409EFF;}
        .order-summary{background:#f9f9f9;border-radius:4px;padding:20px;margin-bottom:20px;}
        .order-summary h3{margin-bottom:15px;font-size:16px;}
        .summary-item{display:flex;justify-content:space-between;padding:5px 0;font-size:14px;color:#666;}
        .summary-item .amount{color:#f56c6c;font-weight:bold;font-size:18px;}
        .btn{width:100%;height:44px;background:#d32f2f;color:#fff;border:none;border-radius:4px;font-size:18px;cursor:pointer;}
        .btn:hover{background:#b71c1c;}
        .back-link{display:block;text-align:center;margin-top:15px;}
        .back-link a{color:#409EFF;text-decoration:none;font-size:14px;}
    </style>
</head>
<body>
<div class="container">
    <div class="checkout-card">
        <h2>填写核对购买信息</h2>
        <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="action" value="checkout">
            <div class="form-group">
                <label>收货人 <span style="color:#f56c6c;">*</span></label>
                <input type="text" name="consignee" value="${sessionScope.member.realName}" required>
            </div>
            <div class="form-group">
                <label>联系电话 <span style="color:#f56c6c;">*</span></label>
                <input type="text" name="phone" value="${sessionScope.member.phone}" required>
            </div>
            <div class="form-group">
                <label>收货地址 <span style="color:#f56c6c;">*</span></label>
                <input type="text" name="address" value="${sessionScope.member.address}" required>
            </div>
            <div class="order-summary">
                <h3>订单摘要</h3>
                <c:forEach items="${cartItems}" var="item">
                <div class="summary-item">
                    <span>${item.productName} × ${item.quantity}</span>
                    <span>¥<fmt:formatNumber value="${item.subtotal}" pattern="#0.00"/></span>
                </div>
                </c:forEach>
                <div class="summary-item" style="border-top:1px solid #eee;padding-top:10px;margin-top:10px;">
                    <span>合计</span>
                    <span class="amount">¥<fmt:formatNumber value="${cartItems.stream().map(i -> i.subtotal).sum()}" pattern="#0.00"/></span>
                </div>
            </div>
            <button class="btn">确认提交订单</button>
        </form>
        <div class="back-link"><a href="${pageContext.request.contextPath}/cart">返回购物车</a></div>
    </div>
</div>
</body>
</html>

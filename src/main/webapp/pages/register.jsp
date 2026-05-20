<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>会员注册 - 药房网商城</title>
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        body{background:#f5f5f5;}
        .register-wrap{width:600px;margin:50px auto;background:#fff;border-radius:8px;padding:40px;box-shadow:0 2px 12px rgba(0,0,0,.1);}
        .register-wrap h2{text-align:center;color:#333;margin-bottom:30px;}
        .form-group{margin-bottom:18px;}
        .form-group label{display:block;font-size:14px;color:#666;margin-bottom:5px;}
        .form-group label .required{color:#f56c6c;}
        .form-group input{width:100%;height:40px;border:1px solid #dcdfe6;border-radius:4px;padding:0 12px;font-size:14px;outline:none;}
        .form-group input:focus{border-color:#409EFF;}
        .register-btn{width:100%;height:42px;background:#409EFF;color:#fff;border:none;border-radius:4px;font-size:16px;cursor:pointer;}
        .error{color:#f56c6c;font-size:13px;text-align:center;margin-bottom:10px;}
        .login-link{text-align:center;margin-top:15px;font-size:13px;}
        .login-link a{color:#409EFF;text-decoration:none;}
    </style>
</head>
<body>
<div class="register-wrap">
    <h2>会员注册</h2>
    <c:if test="${not empty error}"><div class="error">${error}</div></c:if>
    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label>用户名 <span class="required">*</span></label>
            <input type="text" name="username" placeholder="请输入用户名" required>
        </div>
        <div class="form-group">
            <label>密码 <span class="required">*</span></label>
            <input type="password" name="password" placeholder="请输入密码" required>
        </div>
        <div class="form-group">
            <label>确认密码 <span class="required">*</span></label>
            <input type="password" name="confirmPassword" placeholder="请再次输入密码" required>
        </div>
        <div class="form-group">
            <label>姓名</label>
            <input type="text" name="realName" placeholder="请输入真实姓名">
        </div>
        <div class="form-group">
            <label>手机号</label>
            <input type="text" name="phone" placeholder="请输入手机号">
        </div>
        <div class="form-group">
            <label>邮箱</label>
            <input type="email" name="email" placeholder="请输入邮箱">
        </div>
        <div class="form-group">
            <label>收货地址</label>
            <input type="text" name="address" placeholder="请输入收货地址">
        </div>
        <button class="register-btn">立即注册</button>
    </form>
    <div class="login-link">
        已有账号？<a href="${pageContext.request.contextPath}/login">立即登录</a>
    </div>
</div>
</body>
</html>

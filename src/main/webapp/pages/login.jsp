<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户登录 - 药房网商城</title>
    <style>
        *{margin:0;padding:0;box-sizing:border-box;}
        body{font-family:"Microsoft YaHei",sans-serif;background:#f5f5f5;}
        .login-wrap{width:1200px;margin:50px auto;display:flex;background:#fff;border-radius:8px;overflow:hidden;box-shadow:0 2px 12px rgba(0,0,0,.1);}
        .login-left{width:600px;background:linear-gradient(135deg,#409EFF,#2d7bcb);color:#fff;display:flex;flex-direction:column;justify-content:center;align-items:center;padding:40px;}
        .login-left h2{font-size:32px;margin-bottom:10px;}
        .login-left p{font-size:16px;opacity:.9;}
        .login-right{flex:1;padding:60px 80px;}
        .login-title{font-size:24px;margin-bottom:30px;border-bottom:2px solid #409EFF;padding-bottom:10px;display:inline-block;}
        .item{margin:20px 0;}
        .item input{width:100%;height:40px;padding:0 10px;border:1px solid #ccc;border-radius:4px;outline:none;font-size:14px;}
        .item input:focus{border-color:#409EFF;}
        .login-btn{width:100%;height:42px;background:#409EFF;color:#fff;border:none;border-radius:4px;cursor:pointer;font-size:16px;}
        .login-btn:hover{background:#2d7bcb;}
        .error{color:#f56c6c;font-size:13px;text-align:center;margin-bottom:10px;padding:8px;background:#fef0f0;border-radius:4px;}
        .success{color:#67c23a;font-size:13px;text-align:center;margin-bottom:10px;padding:8px;background:#f0f9eb;border-radius:4px;}
        .links{display:flex;justify-content:space-between;margin-top:15px;font-size:13px;}
        .links a{color:#409EFF;text-decoration:none;}
        .links a:hover{text-decoration:underline;}
        .back-link{display:block;text-align:center;margin-top:15px;font-size:13px;}
        .back-link a{color:#409EFF;text-decoration:none;}
    </style>
</head>
<body>
<div class="login-wrap">
    <div class="login-left">
        <h2>药房网商城</h2>
        <p>正规购药平台 安全放心</p>
    </div>
    <div class="login-right">
        <div class="login-title">用户登录</div>
        <c:if test="${not empty error}"><div class="error">${error}</div></c:if>
        <c:if test="${not empty message}"><div class="success">${message}</div></c:if>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="item">
                <input type="text" name="username" placeholder="请输入用户名" required>
            </div>
            <div class="item">
                <input type="password" name="password" placeholder="请输入密码" required>
            </div>
            <button class="login-btn">立即登录</button>
        </form>
        <div class="links">
            <a href="${pageContext.request.contextPath}/register">没有账号？立即注册</a>
            <a href="${pageContext.request.contextPath}/">返回首页</a>
        </div>
    </div>
</div>
</body>
</html>

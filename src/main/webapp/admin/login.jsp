<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>药房网商城 - 后台管理登录</title>
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        body{background:#f0f2f5;display:flex;justify-content:center;align-items:center;height:100vh;}
        .login-box{width:400px;background:#fff;border-radius:8px;padding:40px;box-shadow:0 2px 12px rgba(0,0,0,.1);}
        .login-box h2{text-align:center;color:#333;margin-bottom:10px;}
        .login-box .sub{text-align:center;color:#999;font-size:13px;margin-bottom:30px;}
        .item{margin-bottom:18px;}
        .item label{display:block;font-size:14px;color:#666;margin-bottom:5px;}
        .item input{width:100%;height:42px;border:1px solid #dcdfe6;border-radius:4px;padding:0 12px;outline:none;font-size:14px;}
        .item input:focus{border-color:#409EFF;}
        .login-btn{width:100%;height:42px;background:#409EFF;color:#fff;border:none;border-radius:4px;font-size:16px;cursor:pointer;}
        .error{color:#f56c6c;font-size:13px;text-align:center;margin-bottom:10px;}
        .back-link{display:block;text-align:center;margin-top:15px;font-size:13px;}
        .back-link a{color:#409EFF;text-decoration:none;}
    </style>
</head>
<body>
<div class="login-box">
    <h2>药房网商城</h2>
    <div class="sub">后台管理系统</div>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>
    <form action="${pageContext.request.contextPath}/admin/login" method="post">
        <div class="item">
            <label>用户名</label>
            <input type="text" name="username" placeholder="请输入管理员账号" required>
        </div>
        <div class="item">
            <label>密码</label>
            <input type="password" name="password" placeholder="请输入密码" required>
        </div>
        <button class="login-btn">登 录</button>
    </form>
    <div class="back-link"><a href="${pageContext.request.contextPath}/">返回前台首页</a></div>
</div>
</body>
</html>

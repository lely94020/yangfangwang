<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>系统设置 - 后台管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        body{background:#f0f2f5;display:flex;}
        .sidebar{width:220px;background:#304156;min-height:100vh;color:#fff;}
        .sidebar .logo{padding:20px;text-align:center;}
        .sidebar-menu{list-style:none;}
        .sidebar-menu li a{display:flex;align-items:center;padding:14px 20px;color:rgba(255,255,255,.7);text-decoration:none;font-size:14px;border-left:3px solid transparent;}
        .sidebar-menu li a i{width:20px;margin-right:10px;}
        .sidebar-menu li a:hover,.sidebar-menu li a.active{background:rgba(255,255,255,.05);color:#fff;border-left-color:#409EFF;}
        .main{flex:1;}
        .header{background:#fff;padding:0 20px;height:60px;display:flex;align-items:center;justify-content:space-between;}
        .content{padding:20px;}
        .form-card{background:#fff;border-radius:8px;padding:30px;box-shadow:0 2px 8px rgba(0,0,0,.06);max-width:600px;}
        .form-group{margin-bottom:18px;}
        .form-group label{display:block;font-size:14px;color:#666;margin-bottom:5px;}
        .form-group input{width:100%;height:36px;border:1px solid #dcdfe6;border-radius:4px;padding:0 10px;font-size:14px;outline:none;}
        .btn{padding:8px 20px;border-radius:4px;border:none;cursor:pointer;font-size:14px;}
        .btn-primary{background:#409EFF;color:#fff;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h3><i class="fas fa-plus" style="color:#4CAF50;"></i> 药房网</h3></div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/setting" class="active"><i class="fas fa-cog"></i> 系统设置</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/role?action=list"><i class="fas fa-user-tag"></i> 角色管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/user?action=list"><i class="fas fa-users-cog"></i> 用户管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/product?action=list"><i class="fas fa-box"></i> 商品管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/order?action=list"><i class="fas fa-file-invoice"></i> 订单管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/member?action=list"><i class="fas fa-user-friends"></i> 会员管理</a></li>
    </ul>
</div>
<div class="main">
    <div class="header">
        <div class="breadcrumb">系统设置</div>
        <div>${sessionScope.adminUser.realName} <a href="${pageContext.request.contextPath}/admin/logout" style="color:#409EFF;text-decoration:none;margin-left:10px;">退出</a></div>
    </div>
    <div class="content">
        <div class="form-card">
            <h3 style="margin-bottom:20px;">系统设置</h3>
            <form action="${pageContext.request.contextPath}/admin/setting" method="post">
                <c:forEach items="${settings}" var="s">
                <div class="form-group">
                    <label>${s.description}</label>
                    <input type="hidden" name="key" value="${s.settingKey}">
                    <input type="text" name="value" value="${s.settingValue}">
                </div>
                </c:forEach>
                <c:if test="${empty settings}">
                <div style="color:#999;padding:20px 0;text-align:center;">暂无系统设置项</div>
                </c:if>
                <button type="submit" class="btn btn-primary">保存设置</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>

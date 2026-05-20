<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>药房网商城 - 后台管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        body{background:#f0f2f5;display:flex;}
        .sidebar{width:220px;background:#304156;min-height:100vh;color:#fff;}
        .sidebar .logo{padding:20px;text-align:center;border-bottom:1px solid rgba(255,255,255,.1);}
        .sidebar .logo h3{font-size:18px;}
        .sidebar .logo p{font-size:12px;opacity:.7;margin-top:5px;}
        .sidebar-menu{list-style:none;}
        .sidebar-menu li a{display:flex;align-items:center;padding:14px 20px;color:rgba(255,255,255,.7);text-decoration:none;font-size:14px;border-left:3px solid transparent;}
        .sidebar-menu li a i{width:20px;margin-right:10px;}
        .sidebar-menu li a:hover,.sidebar-menu li a.active{background:rgba(255,255,255,.05);color:#fff;border-left-color:#409EFF;}
        .main{flex:1;display:flex;flex-direction:column;}
        .header{background:#fff;padding:0 20px;height:60px;display:flex;align-items:center;justify-content:space-between;box-shadow:0 1px 4px rgba(0,0,0,.08);}
        .header .breadcrumb{font-size:14px;color:#666;}
        .header .user-info{font-size:14px;color:#333;}
        .header .user-info a{color:#409EFF;text-decoration:none;margin-left:10px;}
        .content{padding:20px;flex:1;}
        .stats{display:grid;grid-template-columns:repeat(4,1fr);gap:20px;margin-bottom:30px;}
        .stat-card{background:#fff;border-radius:8px;padding:20px;box-shadow:0 2px 8px rgba(0,0,0,.06);}
        .stat-card .num{font-size:28px;font-weight:bold;color:#333;}
        .stat-card .label{font-size:14px;color:#999;margin-top:5px;}
        .stat-card .icon{float:right;width:48px;height:48px;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;}
        .welcome-card{background:#fff;border-radius:8px;padding:30px;box-shadow:0 2px 8px rgba(0,0,0,.06);}
        .welcome-card h3{font-size:20px;color:#333;margin-bottom:10px;}
        .welcome-card p{font-size:14px;color:#666;line-height:1.8;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo">
        <h3><i class="fas fa-plus" style="color:#4CAF50;"></i> 药房网</h3>
        <p>后台管理系统</p>
    </div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/admin/index.jsp" class="active"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/setting"><i class="fas fa-cog"></i> 系统设置</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/role?action=list"><i class="fas fa-user-tag"></i> 角色管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/user?action=list"><i class="fas fa-users-cog"></i> 用户管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/product?action=list"><i class="fas fa-box"></i> 商品管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/order?action=list"><i class="fas fa-file-invoice"></i> 订单管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/member?action=list"><i class="fas fa-user-friends"></i> 会员管理</a></li>
    </ul>
</div>
<div class="main">
    <div class="header">
        <div class="breadcrumb">首页</div>
        <div class="user-info">
            <i class="fas fa-user-circle"></i> ${sessionScope.adminUser.realName} (${sessionScope.adminUser.username})
            <a href="${pageContext.request.contextPath}/admin/logout">退出</a>
        </div>
    </div>
    <div class="content">
        <div class="welcome-card">
            <h3>欢迎回来，${sessionScope.adminUser.realName}！</h3>
            <p>您可以通过左侧菜单管理系统的各项功能：<br>
            - <strong>系统设置</strong>：配置网站基本信息<br>
            - <strong>角色管理</strong>：管理管理员角色和权限<br>
            - <strong>用户管理</strong>：管理后台管理员账户<br>
            - <strong>商品管理</strong>：发布、编辑、上下架商品<br>
            - <strong>订单管理</strong>：查看和管理会员订单<br>
            - <strong>会员管理</strong>：审核注册会员、修改会员状态</p>
        </div>
    </div>
</div>
</body>
</html>

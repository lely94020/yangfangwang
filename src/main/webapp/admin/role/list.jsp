<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>角色管理 - 后台管理</title>
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
        .toolbar{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;}
        .toolbar .title{font-size:18px;font-weight:bold;color:#333;}
        table{width:100%;background:#fff;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,.06);border-collapse:collapse;}
        th,td{padding:12px 15px;text-align:left;font-size:13px;border-bottom:1px solid #ebeef5;}
        th{background:#f5f7fa;color:#606266;}
        tr:hover{background:#f5f7fa;}
        .btn{display:inline-block;padding:4px 12px;border-radius:4px;text-decoration:none;font-size:12px;border:none;cursor:pointer;}
        .btn-primary{background:#409EFF;color:#fff;}
        .btn-warning{background:#e6a23c;color:#fff;}
        .btn-success{background:#67c23a;color:#fff;}
        .btn-sm{padding:4px 12px;font-size:12px;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h3><i class="fas fa-plus" style="color:#4CAF50;"></i> 药房网</h3></div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/role?action=list" class="active"><i class="fas fa-user-tag"></i> 角色管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/user?action=list"><i class="fas fa-users-cog"></i> 用户管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/product?action=list"><i class="fas fa-box"></i> 商品管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/order?action=list"><i class="fas fa-file-invoice"></i> 订单管理</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><div class="breadcrumb">角色管理</div></div>
    <div class="content">
        <div class="toolbar">
            <div class="title">角色列表</div>
            <a href="${pageContext.request.contextPath}/admin/role?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> 添加角色</a>
        </div>
        <table>
            <thead><tr><th>ID</th><th>角色名称</th><th>描述</th><th>创建时间</th><th>操作</th></tr></thead>
            <tbody>
                <c:forEach items="${roles}" var="r">
                <tr>
                    <td>${r.id}</td>
                    <td>${r.name}</td>
                    <td>${r.description}</td>
                    <td>${r.createTime}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/role?action=edit&id=${r.id}" class="btn btn-primary btn-sm">编辑</a>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty roles}">
                <tr><td colspan="5" style="text-align:center;padding:30px;color:#999;">暂无角色数据</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

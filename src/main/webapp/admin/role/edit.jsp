<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑角色 - 后台管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        body{background:#f0f2f5;display:flex;}
        .sidebar{width:220px;background:#304156;min-height:100vh;}
        .sidebar .logo{padding:20px;color:#fff;}
        .sidebar-menu{list-style:none;}
        .sidebar-menu li a{display:flex;align-items:center;padding:14px 20px;color:rgba(255,255,255,.7);text-decoration:none;}
        .sidebar-menu li a i{width:20px;margin-right:10px;}
        .sidebar-menu li a:hover,.sidebar-menu li a.active{background:rgba(255,255,255,.05);color:#fff;border-left-color:#409EFF;}
        .main{flex:1;}
        .header{background:#fff;padding:0 20px;height:60px;display:flex;align-items:center;}
        .content{padding:20px;}
        .form-card{background:#fff;border-radius:8px;padding:30px;box-shadow:0 2px 8px rgba(0,0,0,.06);max-width:500px;}
        .form-group{margin-bottom:15px;}
        .form-group label{display:block;font-size:14px;color:#666;margin-bottom:5px;}
        .form-group input,.form-group textarea{width:100%;height:36px;border:1px solid #dcdfe6;border-radius:4px;padding:0 10px;font-size:14px;outline:none;}
        .form-group textarea{height:80px;padding:10px;resize:vertical;}
        .btn{padding:8px 20px;border-radius:4px;border:none;cursor:pointer;font-size:14px;text-decoration:none;display:inline-block;}
        .btn-primary{background:#409EFF;color:#fff;}
        .btn-default{background:#909399;color:#fff;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h3><i class="fas fa-plus" style="color:#4CAF50;"></i> 药房网</h3></div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/admin/role?action=list" class="active"><i class="fas fa-user-tag"></i> 角色管理</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><div class="breadcrumb">编辑角色</div></div>
    <div class="content">
        <div class="form-card">
            <h3 style="margin-bottom:20px;">编辑角色</h3>
            <form action="${pageContext.request.contextPath}/admin/role" method="post">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" value="${role.id}">
                <div class="form-group">
                    <label>角色名称 <span style="color:#f56c6c;">*</span></label>
                    <input type="text" name="name" value="${role.name}" required>
                </div>
                <div class="form-group">
                    <label>描述</label>
                    <textarea name="description">${role.description}</textarea>
                </div>
                <div>
                    <button type="submit" class="btn btn-primary">保存修改</button>
                    <a href="${pageContext.request.contextPath}/admin/role?action=list" class="btn btn-default" style="margin-left:10px;">返回</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>

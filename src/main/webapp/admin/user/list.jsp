<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理 - 后台管理</title>
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
        .header{background:#fff;padding:0 20px;height:60px;display:flex;align-items:center;justify-content:space-between;box-shadow:0 1px 4px rgba(0,0,0,.08);}
        .content{padding:20px;flex:1;}
        .toolbar{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;}
        .toolbar .title{font-size:18px;font-weight:bold;color:#333;}
        table{width:100%;background:#fff;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,.06);border-collapse:collapse;}
        th,td{padding:12px 15px;text-align:left;font-size:13px;border-bottom:1px solid #ebeef5;}
        th{background:#f5f7fa;color:#606266;}
        tr:hover{background:#f5f7fa;}
        .btn{display:inline-block;padding:4px 12px;border-radius:4px;text-decoration:none;font-size:12px;cursor:pointer;border:none;}
        .btn-primary{background:#409EFF;color:#fff;}
        .btn-success{background:#67c23a;color:#fff;}
        .btn-danger{background:#f56c6c;color:#fff;}
        .btn-warning{background:#e6a23c;color:#fff;}
        .status-badge{padding:2px 8px;border-radius:10px;font-size:12px;}
        .status-active{background:#e1f3d8;color:#67c23a;}
        .status-disabled{background:#fde2e2;color:#f56c6c;}
        .pagination{display:flex;justify-content:center;align-items:center;margin-top:20px;gap:5px;}
        .pagination a,.pagination span{display:inline-block;padding:6px 12px;border:1px solid #dcdfe6;border-radius:4px;text-decoration:none;color:#606266;font-size:13px;}
        .pagination a:hover{border-color:#409EFF;color:#409EFF;}
        .pagination .current{background:#409EFF;color:#fff;border-color:#409EFF;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h3><i class="fas fa-plus" style="color:#4CAF50;"></i> 药房网</h3></div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/setting"><i class="fas fa-cog"></i> 系统设置</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/role?action=list"><i class="fas fa-user-tag"></i> 角色管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/user?action=list" class="active"><i class="fas fa-users-cog"></i> 用户管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/product?action=list"><i class="fas fa-box"></i> 商品管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/order?action=list"><i class="fas fa-file-invoice"></i> 订单管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/member?action=list"><i class="fas fa-user-friends"></i> 会员管理</a></li>
    </ul>
</div>
<div class="main">
    <div class="header">
        <div class="breadcrumb">用户管理</div>
        <div class="user-info">${sessionScope.adminUser.realName} <a href="${pageContext.request.contextPath}/admin/logout" style="color:#409EFF;text-decoration:none;margin-left:10px;">退出</a></div>
    </div>
    <div class="content">
        <div class="toolbar">
            <div class="title">后台用户列表</div>
            <a href="${pageContext.request.contextPath}/admin/user?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> 添加用户</a>
        </div>
        <table>
            <thead>
                <tr><th>ID</th><th>用户名</th><th>姓名</th><th>角色</th><th>邮箱</th><th>电话</th><th>状态</th><th>创建时间</th><th>操作</th></tr>
            </thead>
            <tbody>
                <c:forEach items="${users}" var="u">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.username}</td>
                    <td>${u.realName}</td>
                    <td>${u.roleName}</td>
                    <td>${u.email}</td>
                    <td>${u.phone}</td>
                    <td><span class="status-badge ${u.status == 1 ? 'status-active' : 'status-disabled'}">${u.status == 1 ? '启用' : '禁用'}</span></td>
                    <td><fmt:formatDate value="${u.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td><a href="${pageContext.request.contextPath}/admin/user?action=edit&id=${u.id}" class="btn btn-primary">编辑</a></td>
                </tr>
                </c:forEach>
                <c:if test="${empty users}">
                <tr><td colspan="9" style="text-align:center;padding:30px;color:#999;">暂无用户数据</td></tr>
                </c:if>
            </tbody>
        </table>
        <div class="pagination">
            <c:if test="${page.currentPage > 1}">
                <a href="${pageContext.request.contextPath}/admin/user?action=list&page=${page.currentPage-1}">上一页</a>
            </c:if>
            <c:forEach begin="1" end="${page.totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == page.currentPage}"><span class="current">${i}</span></c:when>
                    <c:otherwise><a href="${pageContext.request.contextPath}/admin/user?action=list&page=${i}">${i}</a></c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${page.currentPage < page.totalPages}">
                <a href="${pageContext.request.contextPath}/admin/user?action=list&page=${page.currentPage+1}">下一页</a>
            </c:if>
            <span style="color:#999;">共${page.totalRecords}条</span>
        </div>
    </div>
</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品管理 - 后台管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        body{background:#f0f2f5;display:flex;}
        .sidebar{width:220px;background:#304156;min-height:100vh;color:#fff;}
        .sidebar .logo{padding:20px;text-align:center;border-bottom:1px solid rgba(255,255,255,.1);}
        .sidebar .logo h3{font-size:18px;}
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
        .toolbar{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;}
        .toolbar .title{font-size:18px;font-weight:bold;color:#333;}
        .btn{display:inline-block;padding:8px 20px;border-radius:4px;text-decoration:none;font-size:14px;cursor:pointer;border:none;}
        .btn-primary{background:#409EFF;color:#fff;}
        .btn-success{background:#67c23a;color:#fff;}
        .btn-danger{background:#f56c6c;color:#fff;}
        .btn-warning{background:#e6a23c;color:#fff;}
        .btn-sm{padding:4px 12px;font-size:12px;}
        table{width:100%;background:#fff;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,.06);border-collapse:collapse;}
        th,td{padding:12px 15px;text-align:left;font-size:13px;border-bottom:1px solid #ebeef5;}
        th{background:#f5f7fa;color:#606266;font-weight:bold;}
        tr:hover{background:#f5f7fa;}
        .status-badge{padding:2px 8px;border-radius:10px;font-size:12px;}
        .status-online{background:#e1f3d8;color:#67c23a;}
        .status-offline{background:#fde2e2;color:#f56c6c;}
        .pagination{display:flex;justify-content:center;align-items:center;margin-top:20px;gap:5px;}
        .pagination a,.pagination span{display:inline-block;padding:6px 12px;border:1px solid #dcdfe6;border-radius:4px;text-decoration:none;color:#606266;font-size:13px;}
        .pagination a:hover{border-color:#409EFF;color:#409EFF;}
        .pagination .current{background:#409EFF;color:#fff;border-color:#409EFF;}
        .action-group{display:flex;gap:5px;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h3><i class="fas fa-plus" style="color:#4CAF50;"></i> 药房网</h3></div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/setting"><i class="fas fa-cog"></i> 系统设置</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/role?action=list"><i class="fas fa-user-tag"></i> 角色管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/user?action=list"><i class="fas fa-users-cog"></i> 用户管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/product?action=list" class="active"><i class="fas fa-box"></i> 商品管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/order?action=list"><i class="fas fa-file-invoice"></i> 订单管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/member?action=list"><i class="fas fa-user-friends"></i> 会员管理</a></li>
    </ul>
</div>
<div class="main">
    <div class="header">
        <div class="breadcrumb">商品管理</div>
        <div class="user-info">${sessionScope.adminUser.realName} <a href="${pageContext.request.contextPath}/admin/logout">退出</a></div>
    </div>
    <div class="content">
        <div class="toolbar">
            <div class="title">商品列表</div>
            <a href="${pageContext.request.contextPath}/admin/product?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> 添加商品</a>
        </div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>商品名称</th>
                    <th>分类</th>
                    <th>价格</th>
                    <th>库存</th>
                    <th>状态</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${products}" var="p">
                <tr>
                    <td>${p.id}</td>
                    <td><a href="${pageContext.request.contextPath}/admin/product?action=view&id=${p.id}" style="color:#409EFF;">${p.name}</a></td>
                    <td>${p.categoryName}</td>
                    <td>¥${p.price}</td>
                    <td>${p.stock}</td>
                    <td>
                        <span class="status-badge ${p.status == 1 ? 'status-online' : 'status-offline'}">
                            ${p.status == 1 ? '已上架' : '已下架'}
                        </span>
                    </td>
                    <td><fmt:formatDate value="${p.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <div class="action-group">
                            <a href="${pageContext.request.contextPath}/admin/product?action=edit&id=${p.id}" class="btn btn-primary btn-sm">编辑</a>
                            <c:if test="${p.status == 1}">
                                <a href="${pageContext.request.contextPath}/admin/product?action=status&id=${p.id}&status=0" class="btn btn-warning btn-sm">下架</a>
                            </c:if>
                            <c:if test="${p.status == 0}">
                                <a href="${pageContext.request.contextPath}/admin/product?action=status&id=${p.id}&status=1" class="btn btn-success btn-sm">上架</a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/admin/product?action=view&id=${p.id}" class="btn btn-sm" style="background:#909399;color:#fff;">查看</a>
                        </div>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty products}">
                <tr><td colspan="8" style="text-align:center;padding:30px;color:#999;">暂无商品数据</td></tr>
                </c:if>
            </tbody>
        </table>
        <div class="pagination">
            <c:if test="${page.currentPage > 1}">
                <a href="${pageContext.request.contextPath}/admin/product?action=list&page=${page.currentPage-1}">上一页</a>
            </c:if>
            <c:forEach begin="1" end="${page.totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == page.currentPage}"><span class="current">${i}</span></c:when>
                    <c:otherwise><a href="${pageContext.request.contextPath}/admin/product?action=list&page=${i}">${i}</a></c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${page.currentPage < page.totalPages}">
                <a href="${pageContext.request.contextPath}/admin/product?action=list&page=${page.currentPage+1}">下一页</a>
            </c:if>
            <span style="color:#999;">共${page.totalRecords}条</span>
        </div>
    </div>
</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>会员管理 - 后台管理</title>
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
        .toolbar .title{font-size:18px;font-weight:bold;color:#333;margin-bottom:20px;}
        table{width:100%;background:#fff;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,.06);border-collapse:collapse;}
        th,td{padding:12px 15px;text-align:left;font-size:13px;border-bottom:1px solid #ebeef5;}
        th{background:#f5f7fa;color:#606266;}
        tr:hover{background:#f5f7fa;}
        .btn{display:inline-block;padding:4px 12px;border-radius:4px;text-decoration:none;font-size:12px;border:none;cursor:pointer;}
        .btn-success{background:#67c23a;color:#fff;}
        .btn-warning{background:#e6a23c;color:#fff;}
        .btn-danger{background:#f56c6c;color:#fff;}
        .btn-primary{background:#409EFF;color:#fff;}
        .status-badge{padding:2px 8px;border-radius:10px;font-size:12px;}
        .status-0{background:#fde2e2;color:#f56c6c;}
        .status-1{background:#e1f3d8;color:#67c23a;}
        .status-2{background:#fde2e2;color:#909399;}
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
        <li><a href="${pageContext.request.contextPath}/admin/product?action=list"><i class="fas fa-box"></i> 商品管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/order?action=list"><i class="fas fa-file-invoice"></i> 订单管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/member?action=list" class="active"><i class="fas fa-user-friends"></i> 会员管理</a></li>
    </ul>
</div>
<div class="main">
    <div class="header">
        <div class="breadcrumb">会员管理</div>
        <div class="user-info">${sessionScope.adminUser.realName} <a href="${pageContext.request.contextPath}/admin/logout" style="color:#409EFF;text-decoration:none;margin-left:10px;">退出</a></div>
    </div>
    <div class="content">
        <div class="toolbar"><div class="title">注册会员列表</div></div>
        <table>
            <thead>
                <tr><th>ID</th><th>用户名</th><th>姓名</th><th>电话</th><th>邮箱</th><th>状态</th><th>注册时间</th><th>操作</th></tr>
            </thead>
            <tbody>
                <c:forEach items="${members}" var="m">
                <tr>
                    <td>${m.id}</td>
                    <td>${m.username}</td>
                    <td>${m.realName}</td>
                    <td>${m.phone}</td>
                    <td>${m.email}</td>
                    <td>
                        <span class="status-badge status-${m.status}">
                            ${m.status == 0 ? '待审核' : (m.status == 1 ? '已通过' : '已禁用')}
                        </span>
                    </td>
                    <td><fmt:formatDate value="${m.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:if test="${m.status == 0}">
                            <a href="${pageContext.request.contextPath}/admin/member?action=status&id=${m.id}&status=1" class="btn btn-success">审核通过</a>
                        </c:if>
                        <c:if test="${m.status == 1}">
                            <a href="${pageContext.request.contextPath}/admin/member?action=status&id=${m.id}&status=2" class="btn btn-warning">禁用</a>
                        </c:if>
                        <c:if test="${m.status == 2}">
                            <a href="${pageContext.request.contextPath}/admin/member?action=status&id=${m.id}&status=1" class="btn btn-success">启用</a>
                        </c:if>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty members}">
                <tr><td colspan="8" style="text-align:center;padding:30px;color:#999;">暂无会员数据</td></tr>
                </c:if>
            </tbody>
        </table>
        <div class="pagination">
            <c:if test="${page.currentPage > 1}">
                <a href="${pageContext.request.contextPath}/admin/member?action=list&page=${page.currentPage-1}">上一页</a>
            </c:if>
            <c:forEach begin="1" end="${page.totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == page.currentPage}"><span class="current">${i}</span></c:when>
                    <c:otherwise><a href="${pageContext.request.contextPath}/admin/member?action=list&page=${i}">${i}</a></c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${page.currentPage < page.totalPages}">
                <a href="${pageContext.request.contextPath}/admin/member?action=list&page=${page.currentPage+1}">下一页</a>
            </c:if>
            <span style="color:#999;">共${page.totalRecords}条</span>
        </div>
    </div>
</div>
</body>
</html>

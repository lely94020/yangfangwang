<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加商品 - 后台管理</title>
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
        .form-card{background:#fff;border-radius:8px;padding:30px;box-shadow:0 2px 8px rgba(0,0,0,.06);max-width:800px;}
        .form-group{margin-bottom:18px;}
        .form-group label{display:block;font-size:14px;color:#666;margin-bottom:5px;}
        .form-group label .required{color:#f56c6c;}
        .form-group input,.form-group select,.form-group textarea{width:100%;height:36px;border:1px solid #dcdfe6;border-radius:4px;padding:0 10px;font-size:14px;outline:none;}
        .form-group textarea{height:100px;padding:10px;resize:vertical;}
        .form-group input:focus,.form-group select:focus,.form-group textarea:focus{border-color:#409EFF;}
        .form-row{display:grid;grid-template-columns:1fr 1fr;gap:20px;}
        .btn{padding:8px 20px;border-radius:4px;border:none;cursor:pointer;font-size:14px;text-decoration:none;display:inline-block;}
        .btn-primary{background:#409EFF;color:#fff;}
        .btn-default{background:#909399;color:#fff;}
        .error{color:#f56c6c;font-size:13px;margin-bottom:10px;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h3><i class="fas fa-plus" style="color:#4CAF50;"></i> 药房网</h3></div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/product?action=list" class="active"><i class="fas fa-box"></i> 商品管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/order?action=list"><i class="fas fa-file-invoice"></i> 订单管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/member?action=list"><i class="fas fa-user-friends"></i> 会员管理</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><div class="breadcrumb">添加商品</div></div>
    <div class="content">
        <div class="form-card">
            <h3 style="margin-bottom:20px;">添加商品</h3>
            <c:if test="${not empty error}"><div class="error">${error}</div></c:if>
            <form action="${pageContext.request.contextPath}/admin/product" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                <div class="form-row">
                    <div class="form-group">
                        <label>商品名称 <span class="required">*</span></label>
                        <input type="text" name="name" required>
                    </div>
                    <div class="form-group">
                        <label>通用名</label>
                        <input type="text" name="genericName">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>批准文号</label>
                        <input type="text" name="approvalNumber">
                    </div>
                    <div class="form-group">
                        <label>生产厂家</label>
                        <input type="text" name="manufacturer">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>规格</label>
                        <input type="text" name="specification">
                    </div>
                    <div class="form-group">
                        <label>剂型</label>
                        <input type="text" name="dosageForm">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>分类 <span class="required">*</span></label>
                        <select name="categoryId" required>
                            <option value="">请选择</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}">${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>价格 <span class="required">*</span></label>
                        <input type="number" step="0.01" name="price" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>库存 <span class="required">*</span></label>
                        <input type="number" name="stock" value="0" required>
                    </div>
                    <div class="form-group">
                        <label>状态</label>
                        <select name="status">
                            <option value="0">下架</option>
                            <option value="1">上架</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label>商品图片</label>
                    <input type="file" name="imageFile" accept="image/*">
                    <div style="font-size:12px;color:#999;margin-top:3px;">支持 JPG/PNG/GIF，不超过 5MB</div>
                </div>
                <div class="form-group">
                    <label>商品描述</label>
                    <textarea name="description" placeholder="请输入商品描述"></textarea>
                </div>
                <div style="margin-top:20px;">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <a href="${pageContext.request.contextPath}/admin/product?action=list" class="btn btn-default" style="margin-left:10px;">返回</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>

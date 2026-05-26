<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品列表 - 药房网商城</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
        body{background:#f5f5f5;}
        a{text-decoration:none;color:#666;}
        .container{width:1200px;margin:0 auto;}
        .top-bar{background:#f5f5f5;border-bottom:1px solid #eee;padding:8px 0;font-size:12px;}
        .top-bar .container{display:flex;justify-content:space-between;}
        .top-bar-left a,.top-bar-right a{margin:0 10px;color:#666;}
        .top-bar-right .enter-btn{background:#4CAF50;color:white;padding:4px 12px;border-radius:3px;}
        .header{display:flex;justify-content:space-between;align-items:center;padding:20px 0;}
        .logo{display:flex;align-items:center;}
        .logo-icon{width:48px;height:48px;background:#4CAF50;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;font-size:24px;margin-right:10px;}
        .logo-text h1{font-size:24px;color:#333;}
        .logo-text p{font-size:12px;color:#999;}
        .search-box{display:flex;border:1px solid #ccc;border-radius:4px;overflow:hidden;}
        .search-box input{border:none;padding:0 15px;width:350px;height:38px;outline:none;}
        .search-box button{background:#4CAF50;color:white;border:none;padding:0 25px;cursor:pointer;height:38px;}
        .main-nav{background:#4CAF50;color:white;}
        .main-nav .container{display:flex;}
        .nav-item{padding:12px 30px;cursor:pointer;}
        .nav-item.active{background:#388E3C;}
        .breadcrumb{padding:15px 0;font-size:12px;color:#666;}
        .products-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:20px;margin-bottom:30px;}
        .product-card{background:#fff;border:1px solid #eee;border-radius:8px;overflow:hidden;transition:box-shadow .3s;}
        .product-card:hover{box-shadow:0 2px 12px rgba(0,0,0,.1);}
        .product-img{height:180px;display:flex;align-items:center;justify-content:center;padding:20px;}
        .product-img img{max-height:160px;max-width:100%;}
        .product-info{padding:15px;}
        .product-name{font-size:14px;font-weight:500;color:#333;margin-bottom:5px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}
        .product-spec{font-size:12px;color:#999;margin-bottom:8px;}
        .product-price{color:#f44336;font-weight:bold;font-size:18px;}
        .product-stock{font-size:12px;color:#999;}
        .pagination{display:flex;justify-content:center;align-items:center;margin:30px 0;gap:5px;}
        .pagination a,.pagination span{display:inline-block;padding:8px 16px;border:1px solid #dcdfe6;border-radius:4px;text-decoration:none;color:#606266;font-size:14px;}
        .pagination a:hover{border-color:#409EFF;color:#409EFF;}
        .pagination .current{background:#409EFF;color:#fff;border-color:#409EFF;}
        .pagination .disabled{color:#ccc;cursor:not-allowed;}
        .page-info{text-align:center;color:#999;font-size:13px;margin-bottom:30px;}
        .empty-text{text-align:center;padding:60px 0;color:#999;font-size:16px;}
        .footer{background:#f5f5f5;padding:30px 0;margin-top:30px;font-size:12px;color:#666;text-align:center;}
        .view-mode{display:flex;gap:10px;margin-bottom:15px;}
        .view-mode button{padding:6px 16px;border:1px solid #dcdfe6;background:#fff;border-radius:4px;cursor:pointer;font-size:13px;}
        .view-mode button.active{background:#409EFF;color:#fff;border-color:#409EFF;}
        /* 列表视图 */
        .products-list{display:none;flex-direction:column;gap:10px;margin-bottom:30px;}
        .products-list .product-card{display:flex;align-items:center;padding:15px;border:1px solid #eee;border-radius:6px;background:#fff;}
        .products-list .product-card:hover{box-shadow:0 2px 12px rgba(0,0,0,.1);}
        .products-list .product-img{height:100px;min-width:100px;padding:10px;margin:0;}
        .products-list .product-img img{max-height:80px;max-width:80px;}
        .products-list .product-info{flex:1;padding:0 20px;border:none;}
        .products-list .product-name{font-size:16px;white-space:normal;}
        .products-list .product-spec{margin-bottom:0;}
        .products-list .product-price{font-size:20px;}
        .products-list .product-stock{text-align:right;min-width:80px;}
        .products-list .product-card a{display:flex;align-items:center;width:100%;text-decoration:none;}
    </style>
</head>
<body>
<div class="top-bar">
    <div class="container">
        <div class="top-bar-left">
            <a href="#"><i class="fas fa-star"></i> 收藏药房网商城</a>
            <a href="#"><i class="fas fa-qrcode"></i> 微信查价</a>
            <a href="#"><i class="fas fa-mobile-alt"></i> 手机APP</a>
        </div>
        <div class="top-bar-right">
            <c:choose>
                <c:when test="${not empty sessionScope.member}">
                    <a href="#">您好，${sessionScope.member.username}</a>
                    <a href="${pageContext.request.contextPath}/logout">[退出]</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">登录/免费注册</a>
                </c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> 购物车</a>
            <a href="${pageContext.request.contextPath}/order?action=list">我的订单</a>
        </div>
    </div>
</div>
<div class="container header">
    <a href="${pageContext.request.contextPath}/" style="display:flex;align-items:center;text-decoration:none;">
        <div class="logo-icon"><i class="fas fa-plus"></i></div>
        <div class="logo-text"><h1>药房网商城</h1><p>www.yaofangwang.com</p></div>
    </a>
    <div>
        <form action="${pageContext.request.contextPath}/product" method="get" style="display:flex;">
            <input type="hidden" name="action" value="search">
            <div class="search-box">
                <input type="text" name="keyword" placeholder="搜索商品" value="${keyword}">
                <button><i class="fas fa-search"></i></button>
            </div>
        </form>
    </div>
</div>
<div class="main-nav">
    <div class="container">
        <div class="nav-item active">全部商品</div>
        <div class="nav-item"><a href="${pageContext.request.contextPath}/" style="color:white;text-decoration:none;">首页</a></div>
    </div>
</div>
<div class="container">
    <div class="breadcrumb"><a href="${pageContext.request.contextPath}/">首页</a> &gt; 全部商品</div>
    <div class="view-mode">
        <button class="active" onclick="setView('grid')"><i class="fas fa-th-large"></i> 网格视图</button>
        <button onclick="setView('list')"><i class="fas fa-list"></i> 列表视图</button>
    </div>
    <c:choose>
        <c:when test="${not empty products}">
            <div class="products-grid" id="productGrid">
                <c:forEach items="${products}" var="p">
                <a href="${pageContext.request.contextPath}/product?action=view&id=${p.id}" style="text-decoration:none;">
                    <div class="product-card">
                        <div class="product-img">
                            <c:choose>
                                <c:when test="${not empty p.imageUrl}">
                                    <img src="${p.imageUrl.startsWith('http') ? p.imageUrl : pageContext.request.contextPath.concat('/').concat(p.imageUrl)}" alt="${p.name}">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-pills" style="font-size:60px;color:#ccc;"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="product-info">
                            <div class="product-name">${p.name}</div>
                            <div class="product-spec">${p.specification}</div>
                            <div class="product-price">¥${p.price}</div>
                            <div class="product-stock">库存：${p.stock}</div>
                        </div>
                    </div>
                </a>
                </c:forEach>
            </div>
            <div class="products-list" id="productList" style="display:none;">
                <c:forEach items="${products}" var="p">
                <a href="${pageContext.request.contextPath}/product?action=view&id=${p.id}" style="text-decoration:none;">
                    <div class="product-card">
                        <div class="product-img">
                            <c:choose>
                                <c:when test="${not empty p.imageUrl}">
                                    <img src="${p.imageUrl.startsWith('http') ? p.imageUrl : pageContext.request.contextPath.concat('/').concat(p.imageUrl)}" alt="${p.name}">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-pills" style="font-size:40px;color:#ccc;"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="product-info">
                            <div class="product-name">${p.name}</div>
                            <div class="product-spec">${p.specification}</div>
                            <div class="product-price">¥${p.price}</div>
                        </div>
                        <div class="product-stock">库存：${p.stock}</div>
                    </div>
                </a>
                </c:forEach>
            </div>
            <div class="page-info">共 ${page.totalRecords} 件商品</div>
            <div class="pagination">
                <c:if test="${page.currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/product?action=${not empty keyword ? 'search' : 'list'}&page=${page.currentPage-1}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}">上一页</a>
                </c:if>
                <c:forEach begin="1" end="${page.totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == page.currentPage}"><span class="current">${i}</span></c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/product?action=${not empty keyword ? 'search' : 'list'}&page=${i}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${page.currentPage < page.totalPages}">
                    <a href="${pageContext.request.contextPath}/product?action=${not empty keyword ? 'search' : 'list'}&page=${page.currentPage+1}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}">下一页</a>
                </c:if>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-text"><i class="fas fa-box-open" style="font-size:48px;display:block;margin-bottom:15px;"></i>暂无商品</div>
        </c:otherwise>
    </c:choose>
</div>
<div class="footer"><p>©2026 药房网商城 版权所有</p></div>
<script>
function setView(mode) {
    var grid = document.getElementById('productGrid');
    var list = document.getElementById('productList');
    var btns = document.querySelectorAll('.view-mode button');
    if (mode === 'list') {
        grid.style.display = 'none';
        list.style.display = 'flex';
        btns[0].classList.remove('active');
        btns[1].classList.add('active');
        localStorage.setItem('productView', 'list');
    } else {
        grid.style.display = 'grid';
        list.style.display = 'none';
        btns[0].classList.add('active');
        btns[1].classList.remove('active');
        localStorage.setItem('productView', 'grid');
    }
}
(function() {
    var saved = localStorage.getItem('productView');
    if (saved === 'list') setView('list');
})();
</script>
</body>
</html>

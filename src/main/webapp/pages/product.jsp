<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>药房网商城 - 复方感冒灵颗粒</title>
    <!-- 引入图标库（和之前页面统一） -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft YaHei", sans-serif;
        }
        a {
            text-decoration: none;
            color: #666;
        }
        .container {
            width: 1200px;
            margin: 0 auto;
        }

        /* 顶部导航（和首页/购物车页统一） */
        .top-bar {
            background: #f5f5f5;
            border-bottom: 1px solid #eee;
            padding: 8px 0;
            font-size: 12px;
        }
        .top-bar .container {
            display: flex;
            justify-content: space-between;
        }
        .top-bar-left a,
        .top-bar-right a {
            margin: 0 10px;
            color: #666;
        }
        .top-bar-right .enter-btn {
            background: #4CAF50;
            color: white;
            padding: 4px 12px;
            border-radius: 3px;
        }

        /* 头部：Logo + 搜索框 + 资质信息 */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
        }
        .logo {
            display: flex;
            align-items: center;
        }
        .logo-icon {
            width: 48px;
            height: 48px;
            background: #4CAF50;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            margin-right: 10px;
        }
        .logo-text h1 {
            font-size: 24px;
            color: #333;
        }
        .logo-text p {
            font-size: 12px;
            color: #999;
        }
        .search-box {
            display: flex;
            border: 1px solid #ccc;
            border-radius: 4px;
            overflow: hidden;
        }
        .search-box select {
            border: none;
            padding: 0 10px;
            background: #f9f9f9;
            height: 38px;
        }
        .search-box input {
            border: none;
            padding: 0 15px;
            width: 350px;
            height: 38px;
            outline: none;
        }
        .search-box button {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 0 25px;
            cursor: pointer;
            height: 38px;
        }
        .hot-keywords {
            margin-top: 8px;
            font-size: 12px;
            color: #666;
        }
        .hot-keywords a {
            margin-right: 15px;
        }
        .cert-info {
            display: flex;
            align-items: center;
        }
        .cert-icon {
            width: 40px;
            height: 40px;
            border: 2px solid #ffc107;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffc107;
            margin-right: 10px;
        }
        .cert-text p {
            font-size: 14px;
            color: #333;
        }
        .cert-text small {
            font-size: 12px;
            color: #999;
        }

        /* 主导航 */
        .main-nav {
            background: #4CAF50;
            color: white;
        }
        .main-nav .container {
            display: flex;
        }
        .nav-item {
            padding: 12px 30px;
            cursor: pointer;
        }
        .nav-item.active {
            background: #388E3C;
        }

        /* 面包屑导航 */
        .breadcrumb {
            padding: 15px 0;
            font-size: 12px;
            color: #666;
        }
        .breadcrumb a {
            color: #666;
        }
        .breadcrumb span {
            margin: 0 5px;
        }

        /* 商品详情主体 */
        .product-main {
            display: flex;
            gap: 30px;
            margin-bottom: 30px;
        }
        /* 左侧商品图片区 */
        .product-left {
            width: 400px;
        }
        .main-img {
            width: 100%;
            height: 350px;
            border: 1px solid #eee;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
        }
        .main-img img {
            max-width: 80%;
            max-height: 80%;
        }
        .thumbnails {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
        .thumb-item {
            width: 70px;
            height: 70px;
            border: 1px solid #eee;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .thumb-item.active {
            border-color: #4CAF50;
        }
        .thumb-item img {
            max-width: 100%;
            max-height: 100%;
        }
        .tip-text {
            font-size: 12px;
            color: #999;
            margin-bottom: 15px;
        }
        .product-meta {
            font-size: 12px;
            color: #666;
        }
        .product-meta span {
            margin-right: 20px;
        }

        /* 右侧商品信息区 */
        .product-right {
            flex: 1;
        }
        .product-title {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .otc-tag {
            background: #e74c3c;
            color: white;
            font-size: 12px;
            padding: 2px 6px;
            border-radius: 3px;
            margin-right: 10px;
        }
        .product-name {
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }
        .info-list {
            margin-bottom: 20px;
        }
        .info-item {
            display: flex;
            margin-bottom: 10px;
            font-size: 13px;
        }
        .info-label {
            width: 100px;
            color: #666;
        }
        .info-value {
            flex: 1;
            color: #333;
        }
        .info-value a {
            color: #2196F3;
            font-size: 12px;
        }
        .spec-select {
            width: 120px;
            border: 1px solid #ccc;
            padding: 4px;
            border-radius: 3px;
        }
        /* 价格区 */
        .price-section {
            background: #f5f5f5;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        .price-label {
            font-size: 14px;
            color: #666;
            margin-right: 20px;
        }
        .price-value {
            font-size: 24px;
            color: #e74c3c;
            font-weight: bold;
            margin-right: 20px;
        }
        .price-btn {
            border: 1px solid #4CAF50;
            background: white;
            color: #4CAF50;
            padding: 6px 15px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 13px;
        }
        /* 下载APP提示 */
        .app-promo {
            background: #fff2e6;
            padding: 8px 12px;
            border-radius: 3px;
            font-size: 12px;
            color: #e74c3c;
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .app-promo button {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 4px 8px;
            margin-left: 10px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
        }
        /* 右侧二维码 */
        .qr-code {
            position: absolute;
            right: 50px;
            top: 250px;
            text-align: center;
        }
        .qr-code img {
            width: 120px;
            height: 120px;
            border: 1px solid #eee;
            margin-bottom: 5px;
        }
        .qr-code p {
            font-size: 12px;
            color: #666;
        }

        /* 标签栏 */
        .tabs-section {
            background: white;
            border: 1px solid #eee;
            border-radius: 4px;
            margin-bottom: 30px;
        }
        .tabs-header {
            display: flex;
            border-bottom: 1px solid #eee;
        }
        .tab-item {
            padding: 12px 30px;
            cursor: pointer;
            font-size: 14px;
            border-bottom: 2px solid transparent;
        }
        .tab-item.active {
            color: #4CAF50;
            border-bottom-color: #4CAF50;
            font-weight: bold;
        }
        /* 筛选栏 */
        .filter-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 15px;
            border-bottom: 1px solid #eee;
            font-size: 13px;
        }
        .filter-left {
            display: flex;
            gap: 20px;
        }
        .filter-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .filter-item input {
            margin-right: 3px;
        }
        .filter-right {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .page-btn {
            border: 1px solid #ccc;
            background: white;
            padding: 4px 8px;
            cursor: pointer;
            border-radius: 3px;
        }

        /* 右侧固定工具栏（和之前页面统一） */
        .fixed-toolbar {
            position: fixed;
            right: 10px;
            top: 30%;
            display: flex;
            flex-direction: column;
        }
        .tool-btn {
            width: 40px;
            height: 40px;
            background: white;
            border: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 5px;
            color: #666;
        }
        .tool-btn.qr {
            background: #4CAF50;
            color: white;
        }

        /* 页脚（和之前页面统一） */
        .footer {
            background: #f5f5f5;
            padding: 30px 0;
            margin-top: 30px;
            font-size: 12px;
            color: #666;
        }
    </style>
</head>
<body>
<!-- 顶部导航（和之前页面统一） -->
<div class="top-bar">
    <div class="container">
        <div class="top-bar-left">
            <a href="#"><i class="fas fa-star text-yellow-500"></i> 收藏药房网商城</a>
            <a href="#"><i class="fas fa-qrcode"></i> 微信查价</a>
            <a href="#"><i class="fas fa-mobile-alt"></i> 手机APP</a>
            <a href="#"><i class="fas fa-th-large"></i> 小程序查价</a>
        </div>
        <div class="top-bar-right">
            <a href="#">您好，Mobile_19... [退出]</a>
            <a href="#"><i class="fas fa-shopping-cart text-red-500"></i> 购物车 (1)</a>
            <a href="#">个人中心 <i class="fas fa-chevron-down text-xs"></i></a>
            <a href="#">客服中心</a>
            <a href="#">商家中心 <i class="fas fa-chevron-down text-xs"></i></a>
            <a href="#">网站导航 <i class="fas fa-chevron-down text-xs"></i></a>
            <a href="#" class="enter-btn">商家入驻</a>
        </div>
    </div>
</div>

<!-- 头部：Logo + 搜索框 + 资质信息 -->
<div class="container header">
    <div class="logo">
        <div class="logo-icon"><i class="fas fa-plus"></i></div>
        <div class="logo-text">
            <h1>药房网商城</h1>
            <p>www.yaofangwang.com</p>
            <p>健 康 守 护 者</p>
        </div>
    </div>

    <div>
        <div class="search-box">
            <select>
                <option>商品</option>
                <option>店铺</option>
            </select>
            <input type="text" placeholder="请输入批准文号、通用名、商品名、症状">
            <button>搜索</button>
        </div>
        <div class="hot-keywords">
            <a href="#">拜新同</a>
            <a href="#">阿斯美</a>
            <a href="#">安宫牛黄丸</a>
            <a href="#">阿奇霉素</a>
            <a href="#">立普妥</a>
            <a href="#">奥司他韦</a>
        </div>
    </div>

    <div class="cert-info">
        <div class="cert-icon"><i class="fas fa-shield-alt"></i></div>
        <div class="cert-text">
            <p>资质齐全 品质保障</p>
            <small>药房配送 放心买药</small>
        </div>
    </div>
</div>

<!-- 主导航 -->
<div class="main-nav">
    <div class="container">
        <div class="nav-item">全部商品分类</div>
        <div class="nav-item">首页</div>
        <div class="nav-item">药品超市</div>
        <div class="nav-item">药企查</div>
        <div class="nav-item">医院大全</div>
        <div class="nav-item">医药资讯</div>
        <div class="nav-item">商家入驻</div>
    </div>
</div>

<!-- 面包屑导航 -->
<div class="container breadcrumb">
    <a href="#">药房网商城</a>
    <span>></span>
    <a href="#">中西药品</a>
    <span>></span>
    <a href="#">感冒用药</a>
    <span>></span>
    <a href="#">风热感冒</a>
    <span>></span>
    <span>复方感冒灵颗粒价格</span>
</div>

<!-- 主体：商品详情 -->
<div class="container product-main">
    <!-- 左侧商品图片区 -->
    <div class="product-left">
        <div class="main-img">
            <img src="../images/ganmaoling-big.png" alt="复方感冒灵颗粒">
        </div>
        <div class="thumbnails">
            <div class="thumb-item active">
                <img src="../images/ganmaoling-thumb1.png" alt="缩略图1">
            </div>
            <div class="thumb-item">
                <img src="../images/ganmaoling-thumb2.png" alt="缩略图2">
            </div>
            <div class="thumb-item">
                <img src="../images/ganmaoling-thumb3.png" alt="缩略图3">
            </div>
            <div class="thumb-item">
                <img src="../images/ganmaoling-thumb4.png" alt="缩略图4">
            </div>
            <div class="thumb-item">
                <img src="../images/ganmaoling-thumb5.png" alt="缩略图5">
            </div>
        </div>
        <div class="tip-text">温馨提醒：商品包装因厂家更换频繁，如有不符请以实物为准！</div>
        <div class="product-meta">
            <span>商品编号：294636</span>
            <span>最近浏览：31825</span>
        </div>
    </div>

    <!-- 右侧商品信息区 -->
    <div class="product-right">
        <div class="product-title">
            <span class="otc-tag">OTC</span>
            <h1 class="product-name">复方感冒灵颗粒</h1>
        </div>

        <div class="info-list">
            <div class="info-item">
                <div class="info-label">批准文号</div>
                <div class="info-value">国药准字Z43020334 <a href="#">进入药监局查询></a></div>
            </div>
            <div class="info-item">
                <div class="info-label">通用名</div>
                <div class="info-value">复方感冒灵颗粒</div>
            </div>
            <div class="info-item">
                <div class="info-label">商品名/商标</div>
                <div class="info-value"></div>
            </div>
            <div class="info-item">
                <div class="info-label">包装规格</div>
                <div class="info-value">
                    <select class="spec-select">
                        <option>14gx9袋/盒</option>
                    </select>
                </div>
                <div class="info-label" style="margin-left: 20px;">剂型</div>
                <div class="info-value">颗粒剂</div>
            </div>
            <div class="info-item">
                <div class="info-label">生产企业</div>
                <div class="info-value">华润三九(郴州)制药有限公司</div>
                <div class="info-label" style="margin-left: 20px;">上市许可人</div>
                <div class="info-value">华润三九(郴州)制药有限公司</div>
            </div>
            <div class="info-item">
                <div class="info-label">适应症</div>
                <div class="info-value">辛凉解表，清热解毒。用于风热感冒之发热，微恶风寒，头身痛，口干而渴，鼻塞涕浊，咽喉红肿疼痛，咳嗽，痰黄粘稠。 <a href="#">[详情]</a></div>
            </div>
        </div>

        <div class="price-section">
            <div class="price-label">商家报价</div>
            <div class="price-value">¥14.99 <span style="font-size:14px; color:#666;">起</span></div>
            <button class="price-btn">查看全部17个商家报价</button>
        </div>

        <div class="app-promo">
            下载APP享5元无门槛券，手机下单更优惠
            <button>立即下载</button>
        </div>
    </div>

    <!-- 右侧二维码 -->
    <div class="qr-code">
        <img src="../images/wechat-qr.png" alt="微信扫码比价">
        <p>微信扫一扫<br>比价更方便</p>
    </div>
</div>

<!-- 标签栏 -->
<div class="container tabs-section">
    <div class="tabs-header">
        <div class="tab-item active">17个零售商家报价</div>
        <div class="tab-item">商品说明书</div>
        <div class="tab-item">郑重承诺</div>
    </div>

    <div class="filter-bar">
        <div class="filter-left">
            <div class="filter-item">
                <input type="checkbox"> 距离
            </div>
            <div class="filter-item">
                <input type="checkbox"> 价格
            </div>
            <div class="filter-item">
                <input type="checkbox"> 效期
            </div>
            <div class="filter-item">
                <input type="checkbox"> 所在地
            </div>
            <div class="filter-item">
                <input type="checkbox"> 包邮
            </div>
        </div>
        <div class="filter-right">
            <span>浙江省嘉兴市</span>
            <button class="page-btn">&lt;</button>
            <span>1 / 2</span>
            <button class="page-btn">&gt;</button>
        </div>
    </div>
</div>

<!-- 右侧固定工具栏（和之前页面统一） -->
<div class="fixed-toolbar">
    <div class="tool-btn"><i class="fas fa-headset"></i></div>
    <div class="tool-btn"><i class="fas fa-heart"></i></div>
    <div class="tool-btn qr"><i class="fas fa-qrcode"></i></div>
    <div class="tool-btn"><i class="fas fa-pencil-alt"></i></div>
    <div class="tool-btn"><i class="fas fa-clipboard-list"></i></div>
    <div class="tool-btn"><i class="fas fa-plus"></i></div>
</div>

<!-- 页脚（和之前页面统一） -->
<div class="footer">
    <div class="container">
        <p style="text-align: center;">©2026 药房网商城 版权所有</p>
    </div>
</div>

<!-- 商品详情交互JS -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 1. 缩略图切换功能
        const thumbItems = document.querySelectorAll('.thumb-item');
        const mainImg = document.querySelector('.main-img img');

        thumbItems.forEach((thumb, index) => {
            thumb.addEventListener('click', function() {
                // 移除所有active状态
                thumbItems.forEach(t => t.classList.remove('active'));
                // 给当前缩略图添加active
                this.classList.add('active');
                // 切换主图（实际项目中可替换为真实图片路径）
                mainImg.src = this.querySelector('img').src.replace('thumb', 'big');
            });
        });

        // 2. 标签切换功能
        const tabItems = document.querySelectorAll('.tab-item');
        tabItems.forEach(tab => {
            tab.addEventListener('click', function() {
                tabItems.forEach(t => t.classList.remove('active'));
                this.classList.add('active');
                // 实际项目中可根据标签切换不同内容区域
            });
        });

        // 3. 规格选择（模拟功能）
        const specSelect = document.querySelector('.spec-select');
        specSelect.addEventListener('change', function() {
            alert(`已选择规格：${this.value}`);
        });

        // 4. 查看报价按钮（模拟跳转）
        document.querySelector('.price-btn').addEventListener('click', function() {
            alert('即将查看全部商家报价（模拟）');
        });

        // 5. 下载APP按钮（模拟功能）
        document.querySelector('.app-promo button').addEventListener('click', function() {
            alert('APP下载提示（模拟）');
        });
    });
</script>
</body>
</html>
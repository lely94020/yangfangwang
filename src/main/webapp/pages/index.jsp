<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>药房网商城</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    *{margin:0;padding:0;box-sizing:border-box;font-family:"Microsoft YaHei",sans-serif;}
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
    .hot-keywords{margin-top:8px;font-size:12px;color:#666;}
    .hot-keywords a{margin-right:15px;}
    .cert-info{display:flex;align-items:center;}
    .cert-icon{width:40px;height:40px;border:2px solid #ffc107;border-radius:50%;display:flex;align-items:center;justify-content:center;color:#ffc107;margin-right:10px;}
    .cert-text p{font-size:14px;color:#333;}
    .cert-text small{font-size:12px;color:#999;}
    .main-nav{border-bottom:1px solid #eee;}
    .main-nav .container{display:flex;}
    .nav-cate{width:200px;background:#4CAF50;color:white;padding:12px 0;text-align:center;font-weight:bold;}
    .nav-menu a{display:inline-block;padding:12px 20px;font-weight:500;}
    .nav-menu a.active{color:#4CAF50;border-bottom:2px solid #4CAF50;}
    .main-content{display:flex;margin-top:10px;}
    .left-cate{width:200px;background:white;border:1px solid #eee;overflow:visible;position:relative;z-index:10;}
    .cate-item{padding:12px 15px;border-bottom:1px solid #f4f4f4;position:relative;cursor:pointer;}
    .cate-item:hover{background:#f0faf0;}
    .cate-item i{color:#4CAF50;margin-right:8px;}
    .sub-cate{margin-top:5px;font-size:12px;color:#666;}
    .sub-cate a{margin-right:8px;}
    .cate-popup{display:none;position:absolute;left:100%;top:0;width:580px;background:#fff;border:1px solid #e0e0e0;border-radius:6px;padding:20px;box-shadow:0 4px 20px rgba(0,0,0,.12);z-index:200;min-height:280px;}
    .cate-item:hover .cate-popup{display:block;}
    .popup-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px;}
    .popup-group{margin-bottom:4px;}
    .popup-group-title{font-size:14px;font-weight:bold;color:#333;padding-bottom:6px;margin-bottom:6px;border-bottom:2px solid #4CAF50;}
    .popup-group a{display:inline-block;font-size:13px;color:#666;margin-right:12px;margin-bottom:6px;text-decoration:none;}
    .popup-group a:hover{color:#4CAF50;}
    .popup-footer{padding:10px 0 0;margin-top:10px;border-top:1px solid #eee;text-align:center;}
    .popup-footer a{color:#409EFF;font-size:13px;text-decoration:none;}
    .popup-footer a:hover{text-decoration:underline;}
    .cate-hint{float:right;color:#ccc;font-size:10px;margin-top:2px;}
    .banner{flex:1;margin:0 10px;min-height:200px;position:relative;overflow:hidden;border-radius:6px;}
    .banner .promo{color:#ffeb3b;}
    .slide{position:absolute;inset:0;display:flex;align-items:center;justify-content:center;color:white;font-size:60px;font-weight:bold;text-align:center;opacity:0;transition:opacity .6s ease;cursor:pointer;text-decoration:none;}
    .slide.active{opacity:1;}
    .slide-1{background:linear-gradient(135deg,#81C784,#4CAF50);}
    .slide-2{background:linear-gradient(135deg,#FFB74D,#FF9800);}
    .slide-3{background:linear-gradient(135deg,#64B5F6,#1E88E5);}
    .slide-4{background:linear-gradient(135deg,#CE93D8,#8E24AA);}
    .slide .sub{display:block;font-size:16px;font-weight:normal;margin-top:8px;opacity:.9;}
    .slide .badge{display:inline-block;background:rgba(255,255,255,.25);padding:4px 16px;border-radius:20px;font-size:16px;font-weight:normal;margin-top:12px;}
    .slide .big-num{font-size:80px;margin:0 8px;}
    .dots{position:absolute;bottom:12px;left:50%;transform:translateX(-50%);display:flex;gap:8px;z-index:2;}
    .dots span{width:10px;height:10px;border-radius:50%;background:rgba(255,255,255,.5);cursor:pointer;transition:background .3s;}
    .dots span.active{background:#fff;width:24px;border-radius:5px;}
    .arrow{position:absolute;top:50%;transform:translateY(-50%);z-index:2;width:36px;height:36px;background:rgba(255,255,255,.2);border-radius:50%;display:flex;align-items:center;justify-content:center;color:white;font-size:18px;cursor:pointer;transition:background .3s;border:none;}
    .arrow:hover{background:rgba(255,255,255,.4);}
    .arrow-left{left:10px;}
    .arrow-right{right:10px;}
    .right-sidebar{width:240px;}
    .section-title{margin:30px 0 15px;font-size:18px;font-weight:bold;display:flex;align-items:center;}
    .section-title i{color:#4CAF50;margin-right:8px;}
    .goods-list{display:grid;grid-template-columns:repeat(5,1fr);gap:15px;}
    .goods-item{background:white;border:1px solid #eee;border-radius:4px;padding:15px;text-align:center;transition:box-shadow .3s;}
    .goods-item:hover{box-shadow:0 2px 12px rgba(0,0,0,.1);}
    .goods-img{height:100px;display:flex;align-items:center;justify-content:center;margin-bottom:10px;}
    .goods-img img{max-height:100px;max-width:100%;}
    .goods-name{font-size:14px;color:#333;margin-bottom:5px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}
    .goods-spec{font-size:12px;color:#999;margin-bottom:8px;}
    .goods-price{color:#f44336;font-weight:bold;}
    .fixed-toolbar{position:fixed;right:10px;top:30%;display:flex;flex-direction:column;}
    .tool-btn{width:40px;height:40px;background:white;border:1px solid #eee;display:flex;align-items:center;justify-content:center;margin-bottom:5px;color:#666;}
    .tool-btn.qr{background:#4CAF50;color:white;}
    .view-all{text-align:right;margin:10px 0;}
    .view-all a{color:#409EFF;font-size:14px;}
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
          <a href="${pageContext.request.contextPath}/login">登录</a>
          <a href="${pageContext.request.contextPath}/register">免费注册</a>
        </c:otherwise>
      </c:choose>
      <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> 购物车</a>
      <a href="${pageContext.request.contextPath}/order?action=list">我的订单</a>
      <a href="${pageContext.request.contextPath}/admin/login.jsp" class="enter-btn">后台管理</a>
    </div>
  </div>
</div>
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
    <form action="${pageContext.request.contextPath}/product" method="get">
      <input type="hidden" name="action" value="search">
      <div class="search-box">
        <input type="text" name="keyword" placeholder="请输入批准文号、通用名、商品名、症状">
        <button><i class="fas fa-search"></i></button>
      </div>
    </form>
    <div class="hot-keywords">
      <a href="${pageContext.request.contextPath}/product?action=search&keyword=拜新同">拜新同</a>
      <a href="${pageContext.request.contextPath}/product?action=search&keyword=阿斯美">阿斯美</a>
      <a href="${pageContext.request.contextPath}/product?action=search&keyword=安宫牛黄丸">安宫牛黄丸</a>
      <a href="${pageContext.request.contextPath}/product?action=search&keyword=阿奇霉素">阿奇霉素</a>
      <a href="${pageContext.request.contextPath}/product?action=search&keyword=立普妥">立普妥</a>
      <a href="${pageContext.request.contextPath}/product?action=search&keyword=奥司他韦">奥司他韦</a>
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
<div class="main-nav">
  <div class="container">
    <div class="nav-cate">全部商品分类</div>
    <div class="nav-menu">
      <a href="#" class="active">首页</a>
      <a href="${pageContext.request.contextPath}/product?action=list">药品超市</a>
      <a href="${pageContext.request.contextPath}/admin/login.jsp">商家入驻</a>
    </div>
  </div>
</div>
<div class="container main-content">
  <div class="left-cate">
    <div class="cate-item">
      <i class="fas fa-pills"></i> 中西药品 <span class="cate-hint">▸</span>
      <div class="cate-popup">
        <div class="popup-grid">
          <div class="popup-group">
            <div class="popup-group-title">肠胃用药</div>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=胃痛">胃痛</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=胃炎">胃炎</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=胃溃疡">胃溃疡</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=十二指肠溃疡">十二指肠溃疡</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=便秘">便秘</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=消化不良">消化不良</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=痔疮">痔疮</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=腹痛腹泻">腹痛腹泻</a>
          </div>
          <div class="popup-group">
            <div class="popup-group-title">呼吸系统</div>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=支气管炎">支气管炎</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=咳嗽">咳嗽</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=哮喘">哮喘</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=气管炎">气管炎</a>
          </div>
          <div class="popup-group">
            <div class="popup-group-title">心脑血管</div>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=高血压">高血压</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=冠心病">冠心病</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=高血脂">高血脂</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=脑血栓">脑血栓</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=外周血管疾病">外周血管疾病</a>
          </div>
          <div class="popup-group">
            <div class="popup-group-title">风湿骨科</div>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=风湿病">风湿病</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=跌打损伤">跌打损伤</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=关节炎">关节炎</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=颈椎病">颈椎病</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=骨质疏松">骨质疏松</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=腰肌劳损">腰肌劳损</a>
          </div>
          <div class="popup-group">
            <div class="popup-group-title">抗肿瘤药</div>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=肿瘤辅助药">肿瘤辅助药</a>
          </div>
          <div class="popup-group">
            <div class="popup-group-title">皮肤科药</div>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=皮炎">皮炎</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=湿疹">湿疹</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=痤疮">痤疮</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=疱疹">疱疹</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=皮肤过敏">皮肤过敏</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=手足癣病">手足癣病</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=头皮糠疹">头皮糠疹</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=银屑病">银屑病</a>
            <a href="${pageContext.request.contextPath}/product?action=search&keyword=烧烫伤">烧烫伤</a>
          </div>
        </div>
        <div class="popup-footer">
          <a href="${pageContext.request.contextPath}/product?action=list"><i class="fas fa-arrow-right"></i> 查看更多</a>
        </div>
      </div>
    </div>
    <div class="cate-item">
      <i class="fas fa-heartbeat"></i> 医疗器械
      <div class="sub-cate">
        <a href="#">血压计</a>
        <a href="#">血糖仪</a>
        <a href="#">创可贴</a>
      </div>
    </div>
    <div class="cate-item">
      <i class="fas fa-leaf"></i> 养生保健
      <div class="sub-cate">
        <a href="#">滋补药酒</a>
        <a href="#">补钙</a>
        <a href="#">补气养血</a>
      </div>
    </div>
    <div class="cate-item">
      <i class="fas fa-mortar-pestle"></i> 中药饮片
      <div class="sub-cate">
        <a href="#">西洋参</a>
        <a href="#">三七</a>
        <a href="#">灵芝孢子粉</a>
      </div>
    </div>
    <div class="cate-item">
      <i class="fas fa-spa"></i> 美容护肤
      <div class="sub-cate">
        <a href="#">祛痘</a>
        <a href="#">祛斑</a>
        <a href="#">疤痕修复</a>
      </div>
    </div>
  </div>
  <div class="banner" id="banner">
    <a class="slide slide-1 active" href="${pageContext.request.contextPath}/product?action=list">
      健康守护<br>专业购药
      <span class="sub">药房网商城 您的健康守护者</span>
    </a>
    <a class="slide slide-2" href="${pageContext.request.contextPath}/product?action=list">
      限时满减<br><span class="big-num">99</span>减<span class="big-num">20</span>
      <span class="badge">全场通用</span>
      <span class="sub">活动时间：即日起至月底</span>
    </a>
    <a class="slide slide-3" href="${pageContext.request.contextPath}/product?action=list">
      正品保障<br>药房直送
      <span class="sub">资质齐全 品质保障 放心买药</span>
    </a>
    <a class="slide slide-4" href="${pageContext.request.contextPath}/product?action=list">
      新用户专享<br>首单包邮
      <span class="badge">立即注册</span>
      <span class="sub">首次下单享包邮服务</span>
    </a>
    <button class="arrow arrow-left" onclick="prevSlide()">‹</button>
    <button class="arrow arrow-right" onclick="nextSlide()">›</button>
    <div class="dots" id="dots">
      <span class="active"></span><span></span><span></span><span></span>
    </div>
  </div>
  <div class="right-sidebar">
    <div class="business-card" style="background:white;border:1px solid #eee;border-radius:8px;overflow:hidden;">
      <div class="card-header" style="background:#3498db;color:white;text-align:center;padding:8px 0;">商家入驻</div>
      <div class="step-item" style="padding:12px 15px;border-bottom:1px solid #eee;display:flex;align-items:center;">
        <div class="step-icon" style="width:24px;height:24px;background:#fce4ec;border-radius:50%;display:flex;align-items:center;justify-content:center;color:#e91e63;font-size:12px;margin-right:10px;">01</div>
        <span>快速注册</span>
      </div>
      <div class="step-item" style="padding:12px 15px;border-bottom:1px solid #eee;display:flex;align-items:center;">
        <div class="step-icon" style="width:24px;height:24px;background:#fce4ec;border-radius:50%;display:flex;align-items:center;justify-content:center;color:#e91e63;font-size:12px;margin-right:10px;">02</div>
        <span>交易设置</span>
      </div>
      <div class="step-item" style="padding:12px 15px;display:flex;align-items:center;">
        <div class="step-icon" style="width:24px;height:24px;background:#fce4ec;border-radius:50%;display:flex;align-items:center;justify-content:center;color:#e91e63;font-size:12px;margin-right:10px;">03</div>
        <span>发布商品</span>
      </div>
      <a href="${pageContext.request.contextPath}/admin/login.jsp" style="display:block;background:linear-gradient(to right,#ff9800,#f44336);color:white;text-align:center;padding:10px 0;text-decoration:none;">立即入驻</a>
    </div>
  </div>
</div>
<div class="container">
  <div class="section-title">
    <i class="fas fa-bars"></i> 健康专享
  </div>
  <div class="goods-list">
    <c:forEach items="${featuredProducts}" var="p">
    <a href="${pageContext.request.contextPath}/product?action=view&id=${p.id}" style="text-decoration:none;">
      <div class="goods-item">
        <div class="goods-img">
          <c:choose>
            <c:when test="${not empty p.imageUrl}">
              <img src="${p.imageUrl.startsWith('http') ? p.imageUrl : pageContext.request.contextPath.concat('/').concat(p.imageUrl)}" alt="${p.name}">
            </c:when>
            <c:otherwise>
              <i class="fas fa-pills" style="font-size:50px;color:#ccc;"></i>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="goods-name">${p.name}</div>
        <div class="goods-spec">${p.specification}</div>
        <div class="goods-price">¥${p.price}起</div>
      </div>
    </a>
    </c:forEach>
    <c:if test="${empty featuredProducts}">
      <div style="grid-column:1/6;text-align:center;padding:30px;color:#999;">暂无商品推荐</div>
    </c:if>
  </div>
  <div class="view-all"><a href="${pageContext.request.contextPath}/product?action=list">查看全部商品 &gt;</a></div>

  <div class="section-title">
    <i class="fas fa-home"></i> 家中常备
  </div>
  <div class="goods-list">
    <c:forEach items="${homeEssentials}" var="p">
    <a href="${pageContext.request.contextPath}/product?action=view&id=${p.id}" style="text-decoration:none;">
      <div class="goods-item">
        <div class="goods-img">
          <c:choose>
            <c:when test="${not empty p.imageUrl}">
              <img src="${p.imageUrl.startsWith('http') ? p.imageUrl : pageContext.request.contextPath.concat('/').concat(p.imageUrl)}" alt="${p.name}">
            </c:when>
            <c:otherwise>
              <i class="fas fa-pills" style="font-size:50px;color:#ccc;"></i>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="goods-name">${p.name}</div>
        <div class="goods-spec">${p.specification}</div>
        <div class="goods-price">¥${p.price}起</div>
      </div>
    </a>
    </c:forEach>
    <c:if test="${empty homeEssentials}">
      <div style="grid-column:1/6;text-align:center;padding:30px;color:#999;">暂无商品</div>
    </c:if>
  </div>

  <div class="section-title">
    <i class="fas fa-leaf"></i> 养生保健
  </div>
  <div class="goods-list">
    <c:forEach items="${healthCare}" var="p">
    <a href="${pageContext.request.contextPath}/product?action=view&id=${p.id}" style="text-decoration:none;">
      <div class="goods-item">
        <div class="goods-img">
          <c:choose>
            <c:when test="${not empty p.imageUrl}">
              <img src="${p.imageUrl.startsWith('http') ? p.imageUrl : pageContext.request.contextPath.concat('/').concat(p.imageUrl)}" alt="${p.name}">
            </c:when>
            <c:otherwise>
              <i class="fas fa-pills" style="font-size:50px;color:#ccc;"></i>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="goods-name">${p.name}</div>
        <div class="goods-spec">${p.specification}</div>
        <div class="goods-price">¥${p.price}起</div>
      </div>
    </a>
    </c:forEach>
    <c:if test="${empty healthCare}">
      <div style="grid-column:1/6;text-align:center;padding:30px;color:#999;">暂无商品</div>
    </c:if>
  </div>
</div>
<div class="fixed-toolbar">
  <div class="tool-btn"><i class="fas fa-headset"></i></div>
  <div class="tool-btn"><i class="fas fa-heart"></i></div>
  <div class="tool-btn qr"><i class="fas fa-qrcode"></i></div>
  <div class="tool-btn"><i class="fas fa-pencil-alt"></i></div>
  <div class="tool-btn"><i class="fas fa-clipboard-list"></i></div>
  <div class="tool-btn"><i class="fas fa-chevron-up"></i></div>
</div>
<script src="${pageContext.request.contextPath}/js/index.js"></script>
</body>
</html>

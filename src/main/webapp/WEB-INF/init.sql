-- 药房网商城 数据库初始化脚本
-- 使用方法：先创建数据库，然后执行本脚本
-- mysql -u root -p < init.sql

CREATE DATABASE IF NOT EXISTS yangfangwang DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE yangfangwang;

-- =====================================================
-- 1. 角色表
-- =====================================================
DROP TABLE IF EXISTS role;
CREATE TABLE role (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL COMMENT '角色名称',
  description VARCHAR(200) DEFAULT '' COMMENT '角色描述',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台角色表';

-- =====================================================
-- 2. 用户表（后台管理员）
-- =====================================================
DROP TABLE IF EXISTS user;
CREATE TABLE user (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  real_name VARCHAR(50) DEFAULT '' COMMENT '真实姓名',
  email VARCHAR(100) DEFAULT '',
  phone VARCHAR(20) DEFAULT '',
  role_id INT DEFAULT 0 COMMENT '角色ID',
  status INT DEFAULT 1 COMMENT '状态：1=启用 0=禁用',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台用户表';

-- =====================================================
-- 3. 分类表
-- =====================================================
DROP TABLE IF EXISTS category;
CREATE TABLE category (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  parent_id INT DEFAULT 0 COMMENT '父分类ID，0为顶级',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- =====================================================
-- 4. 商品表
-- =====================================================
DROP TABLE IF EXISTS product;
CREATE TABLE product (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(200) NOT NULL COMMENT '商品名称',
  generic_name VARCHAR(200) DEFAULT '' COMMENT '通用名',
  approval_number VARCHAR(100) DEFAULT '' COMMENT '批准文号',
  manufacturer VARCHAR(200) DEFAULT '' COMMENT '生产厂家',
  specification VARCHAR(100) DEFAULT '' COMMENT '规格',
  dosage_form VARCHAR(50) DEFAULT '' COMMENT '剂型',
  description TEXT COMMENT '商品描述',
  category_id INT DEFAULT 0 COMMENT '分类ID',
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '价格',
  stock INT DEFAULT 0 COMMENT '库存',
  status INT DEFAULT 0 COMMENT '状态：1=上架 0=下架',
  image_url VARCHAR(500) DEFAULT '' COMMENT '图片URL',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  publish_time DATETIME DEFAULT NULL COMMENT '上架时间',
  FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- =====================================================
-- 5. 会员表（前台注册用户）
-- =====================================================
DROP TABLE IF EXISTS member;
CREATE TABLE member (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  real_name VARCHAR(50) DEFAULT '',
  phone VARCHAR(20) DEFAULT '',
  email VARCHAR(100) DEFAULT '',
  address VARCHAR(500) DEFAULT '',
  status INT DEFAULT 0 COMMENT '状态：0=待审核 1=已通过 2=已禁用',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员表';

-- =====================================================
-- 6. 购物车表
-- =====================================================
DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
  id INT PRIMARY KEY AUTO_INCREMENT,
  member_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT DEFAULT 1,
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (member_id) REFERENCES member(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- =====================================================
-- 7. 订单表
-- =====================================================
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_no VARCHAR(50) NOT NULL UNIQUE COMMENT '订单号',
  member_id INT NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  status INT DEFAULT 0 COMMENT '状态：0=待付款 1=已付款 2=已发货 3=已完成 4=已取消',
  consignee VARCHAR(50) DEFAULT '' COMMENT '收货人',
  phone VARCHAR(20) DEFAULT '' COMMENT '联系电话',
  address VARCHAR(500) DEFAULT '' COMMENT '收货地址',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (member_id) REFERENCES member(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- =====================================================
-- 8. 订单明细表
-- =====================================================
DROP TABLE IF EXISTS order_item;
CREATE TABLE order_item (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  product_name VARCHAR(200) DEFAULT '',
  price DECIMAL(10,2) DEFAULT 0.00,
  quantity INT DEFAULT 0,
  subtotal DECIMAL(10,2) DEFAULT 0.00,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单明细表';

-- =====================================================
-- 9. 系统设置表
-- =====================================================
DROP TABLE IF EXISTS system_setting;
CREATE TABLE system_setting (
  id INT PRIMARY KEY AUTO_INCREMENT,
  setting_key VARCHAR(100) NOT NULL UNIQUE,
  setting_value TEXT,
  description VARCHAR(200) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统设置表';

-- =====================================================
-- 初始数据
-- =====================================================

-- 角色
INSERT INTO role (id, name, description) VALUES (1, '管理员', '系统管理员，拥有所有管理权限');
INSERT INTO role (id, name, description) VALUES (2, '销售员', '销售人员，可管理商品和订单');

-- 后台用户（默认密码）
INSERT INTO user (username, password, real_name, role_id, status) VALUES ('admin', 'admin123', '系统管理员', 1, 1);
INSERT INTO user (username, password, real_name, role_id, status) VALUES ('sales', 'sales123', '销售员小张', 2, 1);

-- 分类
INSERT INTO category (id, name, parent_id) VALUES (1, '肠胃用药', 0);
INSERT INTO category (id, name, parent_id) VALUES (2, '感冒用药', 0);
INSERT INTO category (id, name, parent_id) VALUES (3, '心脑血管', 0);
INSERT INTO category (id, name, parent_id) VALUES (4, '医疗器械', 0);
INSERT INTO category (id, name, parent_id) VALUES (5, '养生保健', 0);
INSERT INTO category (id, name, parent_id) VALUES (6, '中药饮片', 0);
INSERT INTO category (id, name, parent_id) VALUES (7, '美容护肤', 0);

-- 商品（25条测试数据）
INSERT INTO product (name, generic_name, approval_number, manufacturer, specification, dosage_form, description, category_id, price, stock, status, publish_time) VALUES
('维生素D滴剂', '维生素D滴剂', '国药准字H20193001', '青岛双鲸药业有限公司', '400IUx10粒x3板/盒', '滴剂', '用于预防和治疗维生素D缺乏症。', 5, 15.30, 200, 1, NOW()),
('葡萄糖酸钙锌口服溶液', '葡萄糖酸钙锌口服溶液', '国药准字H20003101', '澳诺(中国)制药有限公司', '10mlx24支/盒', '口服溶液', '用于治疗缺钙、缺锌引起的疾病。', 5, 22.30, 180, 1, NOW()),
('多潘立酮片', '多潘立酮片', '国药准字H20093301', '西安杨森制药有限公司', '10mgx30片/盒', '片剂', '用于消化不良、腹胀、嗳气等症状。', 1, 20.90, 300, 1, NOW()),
('复方感冒灵颗粒', '复方感冒灵颗粒', '国药准字Z43020334', '华润三九(郴州)制药有限公司', '14gx9袋/盒', '颗粒剂', '辛凉解表，清热解毒。用于风热感冒。', 2, 14.99, 500, 1, NOW()),
('阿莫西林胶囊', '阿莫西林胶囊', '国药准字H20020301', '珠海联邦制药股份有限公司', '0.25gx24粒/盒', '胶囊剂', '用于敏感菌引起的感染。', 2, 8.50, 400, 1, NOW()),
('布洛芬缓释胶囊', '布洛芬缓释胶囊', '国药准字H20010301', '中美天津史克制药有限公司', '0.3gx24粒/盒', '胶囊剂', '用于缓解轻至中度疼痛。', 2, 15.00, 350, 1, NOW()),
('硝苯地平控释片', '硝苯地平控释片', '国药准字H20030301', '拜耳医药保健有限公司', '30mgx12片/盒', '片剂', '治疗高血压、冠心病。', 3, 28.50, 250, 1, NOW()),
('阿托伐他汀钙片', '阿托伐他汀钙片', '国药准字H20040301', '辉瑞制药有限公司', '20mgx7片/盒', '片剂', '用于高胆固醇血症。', 3, 42.00, 200, 1, NOW()),
('硫酸氢氯吡格雷片', '硫酸氢氯吡格雷片', '国药准字H20120301', '赛诺菲(杭州)制药有限公司', '75mgx7片/盒', '片剂', '用于预防动脉粥样硬化血栓形成。', 3, 68.00, 150, 1, NOW()),
('云南白药气雾剂', '云南白药气雾剂', '国药准字Z53020301', '云南白药集团股份有限公司', '85g+60g/盒', '气雾剂', '活血化瘀，消肿止痛。', 4, 63.78, 180, 1, NOW()),
('创可贴', '苯扎氯铵贴', '国药准字H20010302', '上海强生有限公司', '100片/盒', '贴剂', '用于小创伤、擦伤等。', 4, 12.00, 600, 1, NOW()),
('电子血压计', NULL, '粤械注准20152200123', '欧姆龙(大连)有限公司', 'HEM-7121', '医疗器械', '上臂式电子血压计，智能加压。', 4, 299.00, 80, 1, NOW()),
('阿奇霉素分散片', '阿奇霉素分散片', '国药准字H20050301', '石药集团欧意药业有限公司', '0.25gx6片/盒', '片剂', '用于敏感菌引起的感染。', 2, 9.80, 300, 1, NOW()),
('头孢克肟胶囊', '头孢克肟胶囊', '国药准字H20060301', '广州白云山制药股份有限公司', '50mgx6粒/盒', '胶囊剂', '用于敏感菌引起的感染。', 2, 12.50, 280, 1, NOW()),
('氨茶碱片', '氨茶碱片', '国药准字H11020301', '北京双鹤药业股份有限公司', '0.1gx100片/瓶', '片剂', '用于支气管哮喘。', 2, 5.00, 400, 1, NOW()),
('复方丹参滴丸', '复方丹参滴丸', '国药准字Z20010301', '天津天士力医药集团股份有限公司', '27mgx180丸/瓶', '滴丸', '活血化瘀，理气止痛。', 3, 26.80, 220, 1, NOW()),
('速效救心丸', '速效救心丸', '国药准字Z12020301', '天津中新药业集团股份有限公司', '40mgx60粒/盒', '滴丸', '行气活血，祛瘀止痛。', 3, 35.00, 200, 1, NOW()),
('六味地黄丸', '六味地黄丸', '国药准字Z20050301', '北京同仁堂科技发展股份有限公司', '360丸/瓶', '丸剂', '滋阴补肾。', 6, 28.00, 300, 1, NOW()),
('安宫牛黄丸', '安宫牛黄丸', '国药准字Z12020302', '北京同仁堂股份有限公司', '3gx1丸/盒', '丸剂', '清热解毒，镇惊开窍。', 6, 560.00, 50, 1, NOW()),
('西洋参含片', '西洋参含片', '国药准字Z20060301', '吉林敖东药业集团股份有限公司', '0.5gx24片/盒', '片剂', '补气养阴，清热生津。', 6, 68.00, 120, 1, NOW()),
('板蓝根颗粒', '板蓝根颗粒', '国药准字Z44020301', '广州白云山和记黄埔中药有限公司', '10gx20袋/袋', '颗粒剂', '清热解毒，凉血利咽。', 2, 12.00, 500, 1, NOW()),
('藿香正气水', '藿香正气水', '国药准字Z11020301', '北京同仁堂科技发展股份有限公司', '10mlx10支/盒', '酊剂', '解表化湿，理气和中。', 1, 9.50, 350, 1, NOW()),
('健胃消食片', '健胃消食片', '国药准字Z36020301', '江中药业股份有限公司', '0.8gx64片/盒', '片剂', '健胃消食。用于脾胃虚弱所致的食积不化。', 1, 12.80, 400, 1, NOW()),
('马应龙麝香痔疮膏', '马应龙麝香痔疮膏', '国药准字Z42020301', '马应龙药业集团股份有限公司', '10g/支', '软膏剂', '清热燥湿，活血消肿。', 7, 18.90, 200, 1, NOW()),
('红霉素软膏', '红霉素软膏', '国药准字H12020301', '天津药业集团有限公司', '10g/支', '软膏剂', '用于脓疱疮等化脓性皮肤病。', 7, 4.50, 500, 1, NOW());

-- 系统设置
INSERT INTO system_setting (setting_key, setting_value, description) VALUES ('site_name', '药房网商城', '网站名称');
INSERT INTO system_setting (setting_key, setting_value, description) VALUES ('site_description', '正规购药平台 安全放心', '网站描述');
INSERT INTO system_setting (setting_key, setting_value, description) VALUES ('site_keywords', '药品,网上药店,药房网', '网站关键词');
INSERT INTO system_setting (setting_key, setting_value, description) VALUES ('contact_phone', '400-123-4567', '客服电话');
INSERT INTO system_setting (setting_key, setting_value, description) VALUES ('contact_email', 'service@yaofangwang.com', '客服邮箱');

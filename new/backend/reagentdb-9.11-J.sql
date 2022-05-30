/*
 Navicat Premium Data Transfer

 Source Server         : 121.4.95.202
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : 121.4.95.202:3306
 Source Schema         : supplies

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 11/09/2021 14:32:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for reagent_admin
-- ----------------------------
DROP TABLE IF EXISTS `reagent_admin`;
CREATE TABLE `reagent_admin`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `branch` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科室',
  `supplier` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商',
  `group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组别',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `true_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `nick_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `status` int(11) NULL DEFAULT 1 COMMENT '帐号启用状态：0->禁用；1->启用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_admin
-- ----------------------------
INSERT INTO `reagent_admin` VALUES (1, 'admin', '$2a$10$oPur9/vFF0u/SzpVQ1KUNeKf5vfUHee44xvYziwoM1VPh6l7FX4MC', '', NULL, NULL, '15505550555', 'admin', '', 'admin@163.com', '山东省济南市', '系统管理员', '超级管理员', '2018-10-08 13:32:47', '2019-04-20 12:45:16', 1);
INSERT INTO `reagent_admin` VALUES (74, '李寻欢', '$2a$10$zWR2680x6sOJxRfzM1l2s.cNCg9yNBy39QkbcNZOuByRYcWz5A1rO', '中心库', '', '', NULL, 'LEE', NULL, '', NULL, '', '', '2021-08-23 12:15:03', NULL, 1);
INSERT INTO `reagent_admin` VALUES (75, '150', '$2a$10$2ERfS5nTVzjDYeqIG4vHQ.j0tJfXM0t5P2vk4JBpA7ctdl15TFdai', '中心库', '', '', NULL, '闫婷玉', NULL, '', NULL, '', '', '2021-08-23 13:42:35', NULL, 1);
INSERT INTO `reagent_admin` VALUES (76, '李继鹏', '$2a$10$Dc9ISCQHeX23rwQaU7iotOhPwQ8ZI4lSd58x2wcrqSH27II3FEPAa', '', '广图医疗', '', NULL, '李继鹏', NULL, '', NULL, '', '', '2021-08-23 13:45:20', NULL, 1);
INSERT INTO `reagent_admin` VALUES (77, '083', '$2a$10$Xu8RaCVQh6ii0gpw0IDCZOm8N2Rme37ixitZGPuN65tkYm9fCFDfO', '检验科', '', '', NULL, '张国云', NULL, '', NULL, '', '', '2021-08-23 13:47:25', NULL, 1);
INSERT INTO `reagent_admin` VALUES (78, '085', '$2a$10$sNtWBZIkL5qAOxDoyIg.eO3F70.Opyel.Y8Ll3.6fhJVLyoqGdzhC', '检验科', '', '', NULL, '崔国营', NULL, '', NULL, '', '', '2021-08-23 13:48:14', NULL, 1);
INSERT INTO `reagent_admin` VALUES (79, '朱礼龙', '$2a$10$6/dR.ZV/bSkkL.hFxVlYDO0bvGOuWSI.UAAe0UTkls9521e2dQVk2', '', '康华医疗', '', NULL, '朱礼龙', NULL, '', NULL, '', '', '2021-08-23 20:26:29', NULL, 1);
INSERT INTO `reagent_admin` VALUES (80, '王宁', '$2a$10$QM0XFokzWjpw76sl6.Jqz.HyGOgx13ZOekZlAq8GObw72GaH.IpXK', '', '康盛医疗', '', NULL, '王宁', NULL, '', NULL, '', '', '2021-08-23 20:29:50', NULL, 1);
INSERT INTO `reagent_admin` VALUES (83, '张敏', '$2a$10$xjbL.UbQi0uAadq.cElwBO1UH509Ru6YkLGvDnpXOMvgAouJnrOOa', '', '康平医疗', '', NULL, '张敏', NULL, '', NULL, '', '', '2021-08-24 10:08:05', NULL, 1);
INSERT INTO `reagent_admin` VALUES (87, '王媛媛', '$2a$10$INd9bBl9IUI6Qu3a4Nn2cueXOTDdRMY4Y4TYmWKfT/rudKqE.7ayS', '', '忠联科技', '', NULL, '王媛媛', NULL, '', NULL, '', '', '2021-08-25 17:24:57', NULL, 1);
INSERT INTO `reagent_admin` VALUES (88, '谢云波', '$2a$10$qBmMdDsEfi/4ukYIfWWUV.Vhrpygc1B2O4w474a.O6bEwAdERKTM2', '', '康泰医疗', '', NULL, '谢云波', NULL, '', NULL, '', '', '2021-08-28 12:52:11', NULL, 1);
INSERT INTO `reagent_admin` VALUES (89, '刘荣卫', '$2a$10$ezorWYHd47Jd1sFPEu0YyujR0eirNT6viuAf5diKpWFqLw5hassZC', '', '科启医疗', '', NULL, '刘荣卫', NULL, '', NULL, '', '', '2021-08-30 18:59:45', NULL, 1);
INSERT INTO `reagent_admin` VALUES (90, '许文婷', '$2a$10$cuAlRysd2QITyFVdMsFum.Ppc1yLZN1RPZBLgeF903vNXZ6z5foBO', '', '迈尔医疗', '', NULL, '许文婷', NULL, '', NULL, '', '', '2021-08-30 19:00:04', NULL, 1);
INSERT INTO `reagent_admin` VALUES (91, '徐大福', '$2a$10$lhPh1j1xUjHZ31kgzO1/GulTytkFLK9L3jKXjfHb9J3u9aLjfCpXG', '', '迈瑞医疗', '', NULL, '徐大福', NULL, '', NULL, '', '', '2021-08-30 19:00:24', NULL, 1);
INSERT INTO `reagent_admin` VALUES (92, '曹胜铉', '$2a$10$TFPwtracSQei3T6GzxxyguQRekV2EOKZDBnHnOL.IXXdgZSZAdPli', '', '丽可医疗', '', NULL, '曹胜铉', NULL, '', NULL, '', '', '2021-08-30 19:00:42', NULL, 1);
INSERT INTO `reagent_admin` VALUES (93, 'userT', '$2a$10$HdeQWOILW0QuptwZoPgBZu/gYECPrRgFpUGiS3rPgIvROcxnRy7JC', '检验科', '', '', NULL, 'JEE', NULL, '', NULL, '', '科室库管理员', '2021-09-02 11:32:52', NULL, 1);
INSERT INTO `reagent_admin` VALUES (94, 'u21', '$2a$10$bNCTAWrakFFTCaoz/msC3.F2rqHY/pE9c3R0pJn1gVkcNsXUJJYBq', '中心库', '', '', NULL, '用户21', NULL, '', NULL, '', '', '2021-09-02 22:26:47', NULL, 1);
INSERT INTO `reagent_admin` VALUES (95, 'u22', '$2a$10$VukMT/DhM1La3/J3lI9HFOMNFZnqsPLfeZjBimrfvVoREJWd5/dD.', '检验科', '', '', NULL, '用户22', NULL, '', NULL, '', '', '2021-09-02 22:27:02', NULL, 1);
INSERT INTO `reagent_admin` VALUES (96, 'u23', '$2a$10$cTcZhwY/Wube7DII4Ju5te7z8VaV3OfETZ19Yght.cX4.ufW.FWrW', '检验科', '', '', NULL, '用户23', NULL, '', NULL, '', '', '2021-09-02 22:27:22', NULL, 1);
INSERT INTO `reagent_admin` VALUES (97, 'gh1', '$2a$10$1etfQJdrS/s4E/wy.M5nS.j//BIQ55VBH/YllrCzMZ91pCJJa7nQe', '', '广图医疗', '', NULL, '广图医疗', NULL, '', NULL, '', '', '2021-09-02 22:28:15', NULL, 1);
INSERT INTO `reagent_admin` VALUES (98, '孟宪娟', '$2a$10$lVYTAaod74vvM8xrg0BtxOIKl.p8/hUquj1b9Zs6V4NNzhXZb2O0y', '', '汇康医疗', '', NULL, '孟宪娟', NULL, '', NULL, '', '', '2021-09-03 18:27:41', NULL, 1);
INSERT INTO `reagent_admin` VALUES (99, '086', '$2a$10$AMik3zFZVnVFNEID.2q7qO895XSzcDk/N6pTb1FpLmcACtLIPEhsa', '检验科', '', '', NULL, '张春红', NULL, '', NULL, '', '', '2021-09-07 09:08:00', NULL, 1);
INSERT INTO `reagent_admin` VALUES (100, '087', '$2a$10$4ZnQcmvmLNUCpeHakva/HuuB7Rn0ewG46ghdMrTwtpRIRmj7gdZ62', '检验科', '', '', NULL, '孙菲菲', NULL, '', NULL, '', '', '2021-09-07 09:08:17', NULL, 1);

-- ----------------------------
-- Table structure for reagent_admin_login_log
-- ----------------------------
DROP TABLE IF EXISTS `reagent_admin_login_log`;
CREATE TABLE `reagent_admin_login_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_agent` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器登录类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4209 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户登录日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_admin_login_log
-- ----------------------------
INSERT INTO `reagent_admin_login_log` VALUES (4206, 95, '2021-09-11 14:27:32', '10.160.170.212', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (4207, 94, '2021-09-11 14:27:43', '10.160.170.212', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (4208, 95, '2021-09-11 14:27:56', '10.160.170.212', NULL, NULL);

-- ----------------------------
-- Table structure for reagent_admin_permission_relation
-- ----------------------------
DROP TABLE IF EXISTS `reagent_admin_permission_relation`;
CREATE TABLE `reagent_admin_permission_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) NULL DEFAULT NULL,
  `permission_id` bigint(20) NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户和权限关系表(除角色中定义的权限以外的加减权限)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_admin_permission_relation
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_admin_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `reagent_admin_role_relation`;
CREATE TABLE `reagent_admin_role_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) NULL DEFAULT NULL,
  `role_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 229 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户和角色关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_admin_role_relation
-- ----------------------------
INSERT INTO `reagent_admin_role_relation` VALUES (184, 1, 1);
INSERT INTO `reagent_admin_role_relation` VALUES (186, 74, 8);
INSERT INTO `reagent_admin_role_relation` VALUES (188, 75, 6);
INSERT INTO `reagent_admin_role_relation` VALUES (189, 76, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (191, 77, 3);
INSERT INTO `reagent_admin_role_relation` VALUES (193, 78, 9);
INSERT INTO `reagent_admin_role_relation` VALUES (194, 79, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (195, 80, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (197, 81, 6);
INSERT INTO `reagent_admin_role_relation` VALUES (199, 82, 3);
INSERT INTO `reagent_admin_role_relation` VALUES (200, 83, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (204, 85, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (205, 84, 6);
INSERT INTO `reagent_admin_role_relation` VALUES (207, 86, 3);
INSERT INTO `reagent_admin_role_relation` VALUES (208, 87, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (209, 88, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (210, 89, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (211, 90, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (212, 91, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (213, 92, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (215, 93, 8);
INSERT INTO `reagent_admin_role_relation` VALUES (219, 94, 6);
INSERT INTO `reagent_admin_role_relation` VALUES (220, 95, 3);
INSERT INTO `reagent_admin_role_relation` VALUES (221, 96, 9);
INSERT INTO `reagent_admin_role_relation` VALUES (223, 97, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (224, 98, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (227, 100, 9);
INSERT INTO `reagent_admin_role_relation` VALUES (228, 99, 9);

-- ----------------------------
-- Table structure for reagent_base_info
-- ----------------------------
DROP TABLE IF EXISTS `reagent_base_info`;
CREATE TABLE `reagent_base_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂耗材编号',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '试剂名称',
  `unit` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `specification` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `manufacturer_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `registration_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册证号',
  `supplier_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商 ID',
  `supplier_short_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `price` double(16, 2) NULL DEFAULT NULL COMMENT '单价',
  `stock_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '储存温度: 常温，冷藏，冷冻',
  `expiration_limit` int(11) NULL DEFAULT NULL COMMENT '过期预警时间阈值',
  `stock_limit` int(11) NULL DEFAULT NULL COMMENT '低库存预警阈值',
  `use_day_limit` int(11) NULL DEFAULT NULL COMMENT '开启有效期限',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 175 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '试剂基础情报' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_base_info
-- ----------------------------
INSERT INTO `reagent_base_info` VALUES (160, '1', '妊娠诊断检测试剂盒（胶体金法）', '盒', '早早孕检测试纸卡:1人份/盒', '南昌华康医疗科技有限公司', '赣食药监械(准)字2014第2400059', '1', '广图医疗', 30.00, '常温', 30, 20, 30, '2021-08-23 13:53:04', NULL, '2021-09-08 10:58:18', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (161, '161', '吗啡唾液检测试剂盒(胶体金法)', '盒', '20人份/盒', '南通市伊士生物技术有限责任公司', '国械注准20163400749', '1', '广图医疗', 100.00, '冷藏', 30, 20, 10, '2021-08-23 20:20:04', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (162, '162', '风疹病毒IgM抗体检测试剂盒（酶联免疫法', '盒', '96人份/盒', '潍坊三维生物工程集团有限公司', '国械注准20163400955', '1', '广图医疗', 260.00, '常温', 10, 20, 30, '2021-08-23 20:21:48', NULL, '2021-08-26 10:29:43', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (163, '163', '尿素（Urea）测定试剂盒', '瓶', '200mL', '郑州兰森生物技术有限公司', '豫械注准20182400054', '1', '广图医疗', 580.00, '冷藏', 15, 30, 10, '2021-08-23 20:24:41', NULL, '2021-08-26 10:30:57', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (164, '164', '肌酐测定试剂盒（酶法）', '瓶', '80ml', '合肥天一生物技术研究所', '皖械注准20182210053', '41', '康华医疗', 300.00, '冷藏', 30, 20, 10, '2021-08-23 20:28:09', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (165, '165', 'EB病毒核酸定量检测试剂盒(PCR-荧光探针法)', '盒', '48人份/盒', '湖南圣湘生物科技有限公司', '国械注准20173400077', '42', '康盛医疗', 260.00, '常温', 30, 30, 30, '2021-08-23 20:31:22', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (166, '166', '镁测定试剂盒(XB法-LST型)', '盒', '100 测试盒', '四川迈克生物科技股份有限公司', '川械注准20172400214', '43', '康平医疗', 150.00, '常温', 30, 8, 30, '2021-08-24 10:10:09', NULL, '2021-08-26 10:32:42', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (167, '167', '胆碱酯酶测定试剂盒(连续监测法)', '瓶', '50mL×3', '辽宁泰科医学科学有限公司', '辽械注准20162400193', '44', '忠联科技', 650.00, '冷藏', 5, 5, 10, '2021-08-25 17:34:59', NULL, '2021-08-26 10:31:23', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (168, '168', '丙型肝炎病毒抗体检测试剂盒(时间分辨免疫荧光法)', '盒', '96人份/盒', '苏州新波生物技术有限公司', '国械注准20173403213', '45', '康泰医疗', 180.00, '常温', 30, 10, 30, '2021-08-28 12:51:29', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (169, '169', '胆固醇测定试剂盒(终点法)', '瓶', '40ml×10', '辽宁泰科医学科学有限公司', '辽械注准20162400192', '46', '科启医疗', 50.00, '冷藏', 10, 10, 10, '2021-08-30 19:08:40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (170, '170', '真菌葡聚糖检测试剂盒（动态浊度法）', '盒', '20人份/盒', '厦门鲎试剂生物科技股份有限公司', '闽械注准20152400160', '47', '迈尔医疗', 100.00, '冷藏', 10, 10, 10, '2021-08-30 19:08:40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (171, '171', '革兰氏阳性球菌药敏试剂盒(扩散法)', '瓶', '30片/瓶×16种', '杭州滨和微生物试剂有限公司', '浙械注准20172400206', '48', '迈瑞医疗', 120.00, '常温', 10, 10, 10, '2021-08-30 19:08:40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (172, '172', '尿微量白蛋白测定试剂盒（免疫比浊法）', '瓶', '100ml', '保定长城临床试剂有限公司', '冀械注准20162400233', '49', '丽可医疗', 125.00, '常温', 10, 10, 10, '2021-08-30 19:08:40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (173, '173', '淀粉酶测定试剂盒（PNP动力学法）', '盒', '200ml', '保定长城临床试剂有限公司', '冀械注准20182400146', '50', '汇康医疗', 360.00, '常温', 30, 5, 30, '2021-09-03 18:27:00', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_base_info` VALUES (174, '174', '妊娠诊断检测试剂盒（胶体金法）', '盒', '早早孕检测试纸卡:1人份/盒', '南昌华康医疗科技有限公司', '赣食药监械(准)字2014第2400059', '44', '忠联科技', 30.00, '常温', 30, 20, 30, '2021-09-08 11:07:06', NULL, '2021-09-08 11:07:17', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for reagent_branch
-- ----------------------------
DROP TABLE IF EXISTS `reagent_branch`;
CREATE TABLE `reagent_branch`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `branch_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科室号',
  `branch_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科室名',
  `tel` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `head` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '从这五个非空',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '科室' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_branch
-- ----------------------------
INSERT INTO `reagent_branch` VALUES (13, '1', '中心库', NULL, NULL, '2021-08-23 12:12:23', NULL, '2021-08-23 12:12:23', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_branch` VALUES (15, '14', '检验科', '05397117708', '张国云', '2021-08-23 13:43:52', NULL, '2021-08-23 13:43:52', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for reagent_collect
-- ----------------------------
DROP TABLE IF EXISTS `reagent_collect`;
CREATE TABLE `reagent_collect`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `collect_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请编号',
  `apply_type` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请单种类：1 二级领用申请单， 2 移库申请单，3一级领用申请单',
  `collect_day` date NULL DEFAULT NULL COMMENT '申请日',
  `collect_status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请状态 0 ：草稿，1：已提交，2：中心已出库，3：科室已入库',
  `branch` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '移库科室名',
  `collect_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请人',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 382 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_collect
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_collect_detail
-- ----------------------------
DROP TABLE IF EXISTS `reagent_collect_detail`;
CREATE TABLE `reagent_collect_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `collect_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请单号',
  `reagent_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '基础信息编号',
  `reagent_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂名',
  `supplier_short_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `factory` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂单位',
  `reagent_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号规格',
  `price` double(16, 3) NULL DEFAULT NULL COMMENT '单价',
  `reagent_number` bigint(20) NULL DEFAULT NULL COMMENT '申请数量',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_no`(`collect_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 687 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_collect_detail
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_device
-- ----------------------------
DROP TABLE IF EXISTS `reagent_device`;
CREATE TABLE `reagent_device`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备ID',
  `device_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名',
  `device_status` tinyint(2) NULL DEFAULT NULL COMMENT '状态: 0：停用，1：启用',
  `device_qr_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备二维码',
  `device_code_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备二维码数值',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '从这五个非空',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '科室' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_device
-- ----------------------------
INSERT INTO `reagent_device` VALUES (30, '30', '罗氏生化分析仪', 1, '2021090310564130', '设备名称: <br/>罗氏生化分析仪<br/><br/>设备编号: 30', '2021-09-03 10:56:42', NULL, '2021-09-07 20:59:24', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_device` VALUES (31, '31', '希森美康血球仪', 1, '2021090318384331', '设备名称: <br/>希森美康血球仪<br/><br/>设备编号: 31', '2021-09-03 18:38:44', NULL, '2021-09-07 20:59:26', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_device` VALUES (32, '32', '迈瑞生化分析仪', 1, '2021090318385832', '设备名称: <br/>迈瑞生化分析仪<br/><br/>设备编号: 32', '2021-09-03 18:38:59', NULL, '2021-09-07 20:59:29', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for reagent_growth_change_history
-- ----------------------------
DROP TABLE IF EXISTS `reagent_growth_change_history`;
CREATE TABLE `reagent_growth_change_history`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `change_type` int(11) NULL DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
  `change_count` int(11) NULL DEFAULT NULL COMMENT '积分改变数量',
  `operate_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人员',
  `operate_note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作备注',
  `source_type` int(11) NULL DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '成长值变化历史记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_growth_change_history
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_in_bill
-- ----------------------------
DROP TABLE IF EXISTS `reagent_in_bill`;
CREATE TABLE `reagent_in_bill`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库单编号',
  `pre_inbill_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预入库单号-非必填',
  `bill_type` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库单种类：1 一级中心入库单， 2 二级中心入库单，3 科室入库单',
  `create_type` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '添加种类：1 一级建码入库，2 二级建码入库 3 一级扫码入库，4 二级扫码入库，5 移库 ，6 一级领用，7 二级领用',
  `supplier_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供货商ID',
  `supplier_short_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `bill_date` date NULL DEFAULT NULL COMMENT '单据日期（业务发生的日期，不一定等于单据创建时间，根据单据不同，在此单为入库日期）',
  `bill_status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '单据状态：0-草稿，1-已入库 ',
  `branch` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '科室库名',
  `bill_creator` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '制单人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 603 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单（接收单）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_in_bill
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_in_detail
-- ----------------------------
DROP TABLE IF EXISTS `reagent_in_detail`;
CREATE TABLE `reagent_in_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库单编号',
  `in_detail_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库单详细ID',
  `reagent_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂编号',
  `reagent_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂名称',
  `reagent_unit` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `reagent_specification` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `factory` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `price` double(20, 3) NULL DEFAULT NULL COMMENT '价格',
  `quantity` bigint(20) NULL DEFAULT NULL COMMENT '数量',
  `total` double(20, 3) NULL DEFAULT NULL COMMENT '金额',
  `batch_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '批号',
  `expire_date` date NULL DEFAULT NULL COMMENT '保质期',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 857 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单详细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_in_detail
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_in_detail_item
-- ----------------------------
DROP TABLE IF EXISTS `reagent_in_detail_item`;
CREATE TABLE `reagent_in_detail_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库单编号',
  `in_detail_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库单详细ID',
  `reagent_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂编号',
  `qr_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '二维码',
  `code_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二维码数据',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8455 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单个体' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_in_detail_item
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_integration_change_history
-- ----------------------------
DROP TABLE IF EXISTS `reagent_integration_change_history`;
CREATE TABLE `reagent_integration_change_history`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `change_type` int(11) NULL DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
  `change_count` int(11) NULL DEFAULT NULL COMMENT '积分改变数量',
  `operate_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人员',
  `operate_note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作备注',
  `source_type` int(11) NULL DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '积分变化历史记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_integration_change_history
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_integration_consume_setting
-- ----------------------------
DROP TABLE IF EXISTS `reagent_integration_consume_setting`;
CREATE TABLE `reagent_integration_consume_setting`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deduction_per_amount` int(11) NULL DEFAULT NULL COMMENT '每一元需要抵扣的积分数量',
  `max_percent_per_order` int(11) NULL DEFAULT NULL COMMENT '每笔订单最高抵用百分比',
  `use_unit` int(11) NULL DEFAULT NULL COMMENT '每次使用积分最小单位100',
  `coupon_status` int(11) NULL DEFAULT NULL COMMENT '是否可以和优惠券同用；0->不可以；1->可以',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '积分消费设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_integration_consume_setting
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_member
-- ----------------------------
DROP TABLE IF EXISTS `reagent_member`;
CREATE TABLE `reagent_member`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_level_id` bigint(20) NULL DEFAULT NULL,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `phone` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `status` int(11) NULL DEFAULT NULL COMMENT '帐号启用状态:0->禁用；1->启用',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '注册时间',
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` int(11) NULL DEFAULT NULL COMMENT '性别：0->未知；1->男；2->女',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所做城市',
  `job` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职业',
  `personalized_signature` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个性签名',
  `source_type` int(11) NULL DEFAULT NULL COMMENT '用户来源',
  `integration` int(11) NULL DEFAULT NULL COMMENT '积分',
  `growth` int(11) NULL DEFAULT NULL COMMENT '成长值',
  `luckey_count` int(11) NULL DEFAULT NULL COMMENT '剩余抽奖次数',
  `history_integration` int(11) NULL DEFAULT NULL COMMENT '历史积分数量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username`) USING BTREE,
  UNIQUE INDEX `idx_phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_member
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_member_level
-- ----------------------------
DROP TABLE IF EXISTS `reagent_member_level`;
CREATE TABLE `reagent_member_level`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `growth_point` int(11) NULL DEFAULT NULL,
  `default_status` int(11) NULL DEFAULT NULL COMMENT '是否为默认等级：0->不是；1->是',
  `free_freight_point` decimal(10, 2) NULL DEFAULT NULL COMMENT '免运费标准',
  `comment_growth_point` int(11) NULL DEFAULT NULL COMMENT '每次评价获取的成长值',
  `priviledge_free_freight` int(11) NULL DEFAULT NULL COMMENT '是否有免邮特权',
  `priviledge_sign_in` int(11) NULL DEFAULT NULL COMMENT '是否有签到特权',
  `priviledge_comment` int(11) NULL DEFAULT NULL COMMENT '是否有评论获奖励特权',
  `priviledge_promotion` int(11) NULL DEFAULT NULL COMMENT '是否有专享活动特权',
  `priviledge_member_price` int(11) NULL DEFAULT NULL COMMENT '是否有会员价格特权',
  `priviledge_birthday` int(11) NULL DEFAULT NULL COMMENT '是否有生日特权',
  `note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员等级表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_member_level
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_member_login_log
-- ----------------------------
DROP TABLE IF EXISTS `reagent_member_login_log`;
CREATE TABLE `reagent_member_login_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_type` int(11) NULL DEFAULT NULL COMMENT '登录类型：0->PC；1->android;2->ios;3->小程序',
  `province` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员登录记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_member_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_member_member_tag_relation
-- ----------------------------
DROP TABLE IF EXISTS `reagent_member_member_tag_relation`;
CREATE TABLE `reagent_member_member_tag_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `tag_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和标签关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_member_member_tag_relation
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_member_product_category_relation
-- ----------------------------
DROP TABLE IF EXISTS `reagent_member_product_category_relation`;
CREATE TABLE `reagent_member_product_category_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `product_category_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员与产品分类关系表（用户喜欢的分类）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_member_product_category_relation
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_member_receive_address
-- ----------------------------
DROP TABLE IF EXISTS `reagent_member_receive_address`;
CREATE TABLE `reagent_member_receive_address`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人名称',
  `phone_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `default_status` int(11) NULL DEFAULT NULL COMMENT '是否为默认',
  `post_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮政编码',
  `province` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省份/直辖市',
  `city` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市',
  `region` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区',
  `detail_address` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址(街道)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员收货地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_member_receive_address
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_member_rule_setting
-- ----------------------------
DROP TABLE IF EXISTS `reagent_member_rule_setting`;
CREATE TABLE `reagent_member_rule_setting`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `continue_sign_day` int(11) NULL DEFAULT NULL COMMENT '连续签到天数',
  `continue_sign_point` int(11) NULL DEFAULT NULL COMMENT '连续签到赠送数量',
  `consume_per_point` decimal(10, 2) NULL DEFAULT NULL COMMENT '每消费多少元获取1个点',
  `low_order_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '最低获取点数的订单金额',
  `max_point_per_order` int(11) NULL DEFAULT NULL COMMENT '每笔订单最高获取点数',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型：0->积分规则；1->成长值规则',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员积分成长规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_member_rule_setting
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_member_statistics_info
-- ----------------------------
DROP TABLE IF EXISTS `reagent_member_statistics_info`;
CREATE TABLE `reagent_member_statistics_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `consume_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '累计消费金额',
  `order_count` int(11) NULL DEFAULT NULL COMMENT '订单数量',
  `coupon_count` int(11) NULL DEFAULT NULL COMMENT '优惠券数量',
  `comment_count` int(11) NULL DEFAULT NULL COMMENT '评价数',
  `return_order_count` int(11) NULL DEFAULT NULL COMMENT '退货数量',
  `login_count` int(11) NULL DEFAULT NULL COMMENT '登录次数',
  `attend_count` int(11) NULL DEFAULT NULL COMMENT '关注数量',
  `fans_count` int(11) NULL DEFAULT NULL COMMENT '粉丝数量',
  `collect_product_count` int(11) NULL DEFAULT NULL,
  `collect_subject_count` int(11) NULL DEFAULT NULL,
  `collect_topic_count` int(11) NULL DEFAULT NULL,
  `collect_comment_count` int(11) NULL DEFAULT NULL,
  `invite_friend_count` int(11) NULL DEFAULT NULL,
  `recent_order_time` datetime(0) NULL DEFAULT NULL COMMENT '最后一次下订单时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员统计信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_member_statistics_info
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_member_tag
-- ----------------------------
DROP TABLE IF EXISTS `reagent_member_tag`;
CREATE TABLE `reagent_member_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `finish_order_count` int(11) NULL DEFAULT NULL COMMENT '自动打标签完成订单数量',
  `finish_order_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '自动打标签完成订单金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_member_tag
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_member_task
-- ----------------------------
DROP TABLE IF EXISTS `reagent_member_task`;
CREATE TABLE `reagent_member_task`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `growth` int(11) NULL DEFAULT NULL COMMENT '赠送成长值',
  `intergration` int(11) NULL DEFAULT NULL COMMENT '赠送积分',
  `type` int(11) NULL DEFAULT NULL COMMENT '任务类型：0->新手任务；1->日常任务',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_member_task
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_menu
-- ----------------------------
DROP TABLE IF EXISTS `reagent_menu`;
CREATE TABLE `reagent_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父级ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `level` int(11) NULL DEFAULT NULL COMMENT '菜单级数',
  `sort` int(11) NULL DEFAULT NULL COMMENT '菜单排序',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端名称',
  `icon` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端图标',
  `hidden` int(11) NULL DEFAULT NULL COMMENT '前端隐藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_menu
-- ----------------------------
INSERT INTO `reagent_menu` VALUES (3, 1, '2020-02-07 16:29:13', '系统管理', 0, 0, 'ums', 'ums', 0);
INSERT INTO `reagent_menu` VALUES (4, 3, '2020-02-07 16:29:51', '用户管理', 1, 0, 'admin', 'ums-admin', 0);
INSERT INTO `reagent_menu` VALUES (5, 3, '2020-02-07 16:30:13', '角色管理', 1, 0, 'role', 'ums-role', 0);
INSERT INTO `reagent_menu` VALUES (6, 3, '2020-02-07 16:30:53', '菜单列表', 1, 0, 'menu', 'ums-menu', 0);
INSERT INTO `reagent_menu` VALUES (7, 3, '2020-02-07 16:31:13', '资源列表', 1, 0, 'resource', 'ums-resource', 0);
INSERT INTO `reagent_menu` VALUES (8, 3, '2021-02-25 17:37:05', '科室管理', 1, 0, 'branch', 'ums-branch', 0);
INSERT INTO `reagent_menu` VALUES (9, 3, '2021-02-28 19:40:42', '供货商管理', 1, 0, 'supplier', 'ums-supplier', 0);
INSERT INTO `reagent_menu` VALUES (10, 3, '2021-03-03 17:15:51', '试剂基础数据管理', 1, 0, 'baseInfo', 'ums-baseInfo', 0);
INSERT INTO `reagent_menu` VALUES (11, 1, '2021-03-05 09:28:23', '订单管理', 0, 0, 'oms', 'order', 0);
INSERT INTO `reagent_menu` VALUES (12, 11, '2021-03-05 09:43:57', '订单列表', 1, 0, 'order', 'product-list', 0);
INSERT INTO `reagent_menu` VALUES (14, 1, '2021-03-05 20:55:27', '库存管理', 0, 0, 'tms', 'tms', 0);
INSERT INTO `reagent_menu` VALUES (15, 14, '2021-03-05 20:53:19', '科室库存列表', 1, 0, 'stockCentre', 'tms-stockCentre', 0);
INSERT INTO `reagent_menu` VALUES (16, 14, '2021-03-05 21:19:20', '库损列表', 1, 0, 'stockLoss', 'tms-stockLoss', 0);
INSERT INTO `reagent_menu` VALUES (17, 14, '2021-03-09 20:49:34', '科室库存列表', 1, 0, 'stockBranch', 'tms-stockBranch', 0);
INSERT INTO `reagent_menu` VALUES (18, 11, '2021-03-09 20:57:59', '试剂下单', 1, 0, 'placeOrder', 'place-order', 0);
INSERT INTO `reagent_menu` VALUES (19, 11, '2021-03-11 22:02:43', '随货同行单列表', 1, 0, 'preInBill', 'oms-preInBill', 0);
INSERT INTO `reagent_menu` VALUES (20, 1, '2021-03-22 19:00:09', '出库管理', 0, 0, 'dms', 'dms', 0);
INSERT INTO `reagent_menu` VALUES (21, 20, '2021-03-22 19:00:39', '科室库出库', 1, 0, 'centreOut', 'dms-centreOut', 0);
INSERT INTO `reagent_menu` VALUES (22, 20, '2021-03-22 19:01:15', '科室库出库', 1, 0, 'branchOut', 'dms-branchOut', 0);
INSERT INTO `reagent_menu` VALUES (23, 11, '2021-03-23 20:36:27', '随货同行单新增', 1, 0, 'preInBillAdd', 'oms-preInBillAdd', 0);
INSERT INTO `reagent_menu` VALUES (30, 1, '2021-03-27 17:07:03', '检索', 1, 1, 'search', 'tms-search', 0);
INSERT INTO `reagent_menu` VALUES (31, 1, '2021-03-30 17:07:03', '移库管理', 0, 0, 'cms', 'cms', 0);
INSERT INTO `reagent_menu` VALUES (32, 31, '2021-03-30 17:07:03', '领用列表', 1, 0, 'collectLT', 'collectLT-list', 0);
INSERT INTO `reagent_menu` VALUES (33, 31, '2021-03-30 15:13:36', '领用申请', 1, 0, 'collectLTAdd', 'collectLT-add', 0);
INSERT INTO `reagent_menu` VALUES (34, 1, '2021-04-01 16:00:09', '入库管理', 0, 0, 'wms', 'wms', 0);
INSERT INTO `reagent_menu` VALUES (35, 34, '2021-04-01 19:00:39', '科室库入库', 1, 0, 'inBillOC', 'wms-inBillOC', 0);
INSERT INTO `reagent_menu` VALUES (36, 34, '2021-04-01 19:01:15', '科室库入库', 1, 0, 'branchIn', 'wms-branchIn', 0);
INSERT INTO `reagent_menu` VALUES (37, 34, '2021-04-01 20:36:27', '扫码入库', 1, 0, 'scanInBillOC', 'wms-scanInBillOC', 0);
INSERT INTO `reagent_menu` VALUES (38, 1, '2021-04-01 21:58:37', '退货管理', 0, 0, 'rms', 'rms', 0);
INSERT INTO `reagent_menu` VALUES (39, 38, '2021-04-01 21:59:17', '科室库退货', 1, 0, 'refundOC', 'rms-refundOC', 0);
INSERT INTO `reagent_menu` VALUES (40, 38, '2021-04-01 21:59:20', '科室库退货', 1, 0, 'refundTB', 'rms-refundTB', 0);
INSERT INTO `reagent_menu` VALUES (41, 31, '2021-04-07 17:07:03', '移库列表', 1, 0, 'relocation', 'relocation-list', 0);
INSERT INTO `reagent_menu` VALUES (42, 31, '2021-04-07 17:07:03', '移库申请', 1, 0, 'relocationAdd', 'relocation-add', 0);
INSERT INTO `reagent_menu` VALUES (43, 31, '2021-04-09 15:13:36', '领用申请', 1, 0, 'collectLOAdd', 'collectLO-add', 0);
INSERT INTO `reagent_menu` VALUES (44, 31, '2021-04-09 17:07:03', '领用列表', 1, 0, 'collectLO', 'collectLO-list', 0);
INSERT INTO `reagent_menu` VALUES (45, 38, '2021-04-01 21:59:17', '科室库退货申请', 1, 0, 'refundOCAdd', 'rms-refundOCAdd', 0);
INSERT INTO `reagent_menu` VALUES (46, 38, '2021-04-01 21:59:17', '科室库退货申请', 1, 0, 'refundTBAdd', 'rms-refundTBAdd', 0);
INSERT INTO `reagent_menu` VALUES (47, 38, '2021-04-01 21:59:17', '中心库退货', 1, 0, 'refundTC', 'rms-refundTC', 0);
INSERT INTO `reagent_menu` VALUES (48, 38, '2021-04-01 21:59:17', '中心库退货申请', 1, 0, 'refundTCAdd', 'rms-refundTCAdd', 0);
INSERT INTO `reagent_menu` VALUES (49, 34, '2021-04-15 19:00:39', '中心库入库', 1, 0, 'inBillTC', 'wms-inBillTC', 0);
INSERT INTO `reagent_menu` VALUES (50, 34, '2021-04-15 20:36:27', '扫码入库', 1, 0, 'scanInBillTC', 'wms-scanInBillTC', 0);
INSERT INTO `reagent_menu` VALUES (51, 34, '2021-04-15 20:36:27', '建码入库', 1, 0, 'createInBillOC', 'wms-createInBillOC', 0);
INSERT INTO `reagent_menu` VALUES (52, 34, '2021-04-15 20:36:27', '建码入库', 1, 0, 'createInBillTC', 'wms-createInBillTC', 0);
INSERT INTO `reagent_menu` VALUES (53, 14, '2021-05-12 20:59:36', '中心库库存', 1, 0, 'stockCT', 'tms-stockCT', 0);
INSERT INTO `reagent_menu` VALUES (54, 20, '2021-03-22 19:00:39', '中心库出库', 1, 0, 'centreOutT', 'dms-centreOutT', 0);
INSERT INTO `reagent_menu` VALUES (55, 11, '2021-03-11 22:02:43', '二维码', 1, 0, 'qrcode', 'oms-qrcode', 0);
INSERT INTO `reagent_menu` VALUES (56, 1, '2021-06-01 21:58:37', '报表管理', 0, 0, 'bms', 'bms', 0);
INSERT INTO `reagent_menu` VALUES (57, 56, '2021-06-01 21:59:17', '科室库退货报表', 1, 0, 'refundOCR', 'bms-refundOCR', 0);
INSERT INTO `reagent_menu` VALUES (58, 56, '2021-06-01 21:59:17', '中心库退货报表', 1, 0, 'refundTCR', 'bms-refundTCR', 0);
INSERT INTO `reagent_menu` VALUES (59, 56, '2021-06-01 21:59:17', '科室库退货报表', 1, 0, 'refundTBR', 'bms-refundTBR', 0);
INSERT INTO `reagent_menu` VALUES (60, 56, '2021-06-01 21:59:17', '库损报表', 1, 0, 'countLoss', 'bms-countLoss', 0);
INSERT INTO `reagent_menu` VALUES (61, 56, '2021-06-01 21:59:17', '出入库报表', 1, 0, 'countOutIn', 'bms-countOutIn', 0);
INSERT INTO `reagent_menu` VALUES (62, 56, '2021-06-01 21:59:17', '组别领用报表', 1, 0, 'countCollect', 'bms-countCollect', 0);
INSERT INTO `reagent_menu` VALUES (63, 56, '2021-06-01 21:59:17', '时段试剂出入库报表', 1, 0, 'reagentOutIn', 'bms-reagentOutIn', 0);
INSERT INTO `reagent_menu` VALUES (64, 3, '2021-08-18 16:29:51', '日志管理', 1, 0, 'log', 'ums-log', 0);
INSERT INTO `reagent_menu` VALUES (65, 64, '2021-08-18 16:29:51', '操作日志', 1, 0, 'operationLog', 'log-operationLog', 0);
INSERT INTO `reagent_menu` VALUES (66, 64, '2021-08-18 16:29:51', '登录日志', 1, 0, 'loginLog', 'log-loginLog', 0);
INSERT INTO `reagent_menu` VALUES (67, 3, '2021-09-02 11:21:46', '设备管理', 1, 0, 'device', 'ums-device', 0);
INSERT INTO `reagent_menu` VALUES (68, 56, '2021-09-03 21:59:17', '试剂使用记录报表', 1, 0, 'reagentUseLog', 'bms-reagentUseLog', 0);

-- ----------------------------
-- Table structure for reagent_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `reagent_operation_log`;
CREATE TABLE `reagent_operation_log`  (
  `id` bigint(50) NOT NULL AUTO_INCREMENT,
  `module` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '功能区分',
  `opera_log` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '操作用户ID',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  `result` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作结果',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作路径',
  `method` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作方法',
  `ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作IP',
  `opera_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改对象id',
  `opera_params` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 675 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_operation_log
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_order
-- ----------------------------
DROP TABLE IF EXISTS `reagent_order`;
CREATE TABLE `reagent_order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `order_day` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下单日',
  `supplier_id` bigint(20) NULL DEFAULT NULL COMMENT '供货商ID',
  `supplier_short_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `order_price` double(20, 3) NULL DEFAULT NULL COMMENT '总价',
  `order_status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单状态 0 ：草稿，1：已提交，2：已配货，3：撤销，4：已完成',
  `order_describe` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 453 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_order
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `reagent_order_detail`;
CREATE TABLE `reagent_order_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `reagent_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂编号',
  `reagent_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂名',
  `specification` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `unit` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订货单位',
  `reagent_number` bigint(20) NULL DEFAULT NULL COMMENT '订货数量',
  `manufacturer_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `price` double(16, 3) NULL DEFAULT NULL COMMENT '单价',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_no`(`order_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 556 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_out_bill
-- ----------------------------
DROP TABLE IF EXISTS `reagent_out_bill`;
CREATE TABLE `reagent_out_bill`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库单编号',
  `bill_type` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT ' 出库单种类：1.科室库-单级领用/移库/退货出库单, 2.科室库-两级领用/退货出库,3.中心库移库/退货出库',
  `bill_date` date NULL DEFAULT NULL COMMENT '单据日期（业务发生的日期，不一定等于单据创建时间，根据单据不同，在此单为做成日期）',
  `bill_status` tinyint(1) NULL DEFAULT 0 COMMENT '单据状态：0-草稿，1-已完结 ',
  `bill_creator` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '制单人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `branch_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请科室名',
  `application_date` date NULL DEFAULT NULL COMMENT '申请日',
  `application_user` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请人',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 269 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_out_bill
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_out_detail
-- ----------------------------
DROP TABLE IF EXISTS `reagent_out_detail`;
CREATE TABLE `reagent_out_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库单详情编号',
  `out_detail_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库单详细ID',
  `reagent_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂ID',
  `reagent_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂名称',
  `reagent_specification` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `batch_no` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '批号',
  `factory` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `registration_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册证号',
  `supplier_short_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `reagent_unit` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位',
  `expire_date` datetime(0) NULL DEFAULT NULL COMMENT '有效期',
  `quantity` bigint(20) NULL DEFAULT NULL COMMENT '数量',
  `price` double(20, 3) NULL DEFAULT NULL COMMENT '价格',
  `total` double(20, 3) NULL DEFAULT NULL COMMENT '金额',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '出库时间',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库人',
  `application_user` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请人',
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1058 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单详细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_out_detail
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_out_detail_item
-- ----------------------------
DROP TABLE IF EXISTS `reagent_out_detail_item`;
CREATE TABLE `reagent_out_detail_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '出库单编号',
  `out_detail_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '出库单详细ID',
  `reagent_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '试剂编号',
  `qr_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '二维码',
  `code_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二维码数据',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3735 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材出库单个体' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_out_detail_item
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_permission
-- ----------------------------
DROP TABLE IF EXISTS `reagent_permission`;
CREATE TABLE `reagent_permission`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NULL DEFAULT NULL COMMENT '父级权限id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限值',
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `type` int(11) NULL DEFAULT NULL COMMENT '权限类型：0->目录；1->菜单；2->按钮（接口绑定权限）',
  `uri` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端资源路径',
  `status` int(11) NULL DEFAULT NULL COMMENT '启用状态；0->禁用；1->启用',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_permission
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_pre_in_bill
-- ----------------------------
DROP TABLE IF EXISTS `reagent_pre_in_bill`;
CREATE TABLE `reagent_pre_in_bill`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库单编号',
  `bill_type` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库单种类：1 预入库单， 2 入库单',
  `supplier_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供货商ID',
  `supplier_short_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `bill_date` date NULL DEFAULT NULL COMMENT '单据日期（业务发生的日期，不一定等于单据创建时间，根据单据不同，在此单为入库日期）',
  `bill_status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '单据状态：0-已撤销、1-已入库、2-未入库-与订单完全相符、3-未入库-与订单部分相符、4-未入库-与订单不符',
  `bill_creator` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '制单人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 232 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单（接收单）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_pre_in_bill
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_pre_in_detail
-- ----------------------------
DROP TABLE IF EXISTS `reagent_pre_in_detail`;
CREATE TABLE `reagent_pre_in_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库单编号',
  `in_detail_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '详情ID',
  `reagent_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂编号',
  `reagent_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '试剂名称',
  `reagent_unit` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位',
  `reagent_specification` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `factory` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `price` double(20, 3) NULL DEFAULT NULL COMMENT '价格',
  `quantity` bigint(20) NULL DEFAULT NULL COMMENT '数量',
  `total` double(20, 3) NULL DEFAULT NULL COMMENT '金额',
  `batch_no` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '批号',
  `expire_date` date NULL DEFAULT NULL COMMENT '保质期',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 307 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单详细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_pre_in_detail
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_pre_in_detail_item
-- ----------------------------
DROP TABLE IF EXISTS `reagent_pre_in_detail_item`;
CREATE TABLE `reagent_pre_in_detail_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库单编号',
  `in_detail_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细ID',
  `reagent_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '试剂编号',
  `qr_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二维码',
  `code_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二维码数据',
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 79839 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单个体' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_pre_in_detail_item
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_refund
-- ----------------------------
DROP TABLE IF EXISTS `reagent_refund`;
CREATE TABLE `reagent_refund`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `refund_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货单号',
  `refund_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货类型：1，一级中心退货；2，二级中心退货；3，二级科室退货',
  `quantity` bigint(20) NULL DEFAULT NULL COMMENT '数量',
  `total` double(20, 3) NULL DEFAULT NULL COMMENT '金额',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `supplier_short_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `branch` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科室名',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '制单人',
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 127 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '退货单详细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_refund
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_refund_detail
-- ----------------------------
DROP TABLE IF EXISTS `reagent_refund_detail`;
CREATE TABLE `reagent_refund_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `refund_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货单详情编号',
  `refund_detail_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货单详细ID',
  `reagent_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂ID',
  `reagent_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂名称',
  `reagent_specification` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `batch_no` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '批号',
  `factory` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `registration_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册证号',
  `supplier_short_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `reagent_unit` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位',
  `reagent_price` double(10, 3) NULL DEFAULT NULL COMMENT '单价',
  `quantity` bigint(20) NULL DEFAULT NULL COMMENT '数量',
  `total` double(20, 3) UNSIGNED NULL DEFAULT NULL COMMENT '金额',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '退货时间',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货人',
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 209 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单详细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_refund_detail
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_refund_detail_item
-- ----------------------------
DROP TABLE IF EXISTS `reagent_refund_detail_item`;
CREATE TABLE `reagent_refund_detail_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `refund_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货单详情编号',
  `refund_detail_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货单详情ID',
  `reagent_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂编号',
  `qr_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '二维码',
  `code_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二维码数据',
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 450 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '退货单个体' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_refund_detail_item
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_resource
-- ----------------------------
DROP TABLE IF EXISTS `reagent_resource`;
CREATE TABLE `reagent_resource`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源URL',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `category_id` bigint(20) NULL DEFAULT NULL COMMENT '资源分类ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台资源表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_resource
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_resource_category
-- ----------------------------
DROP TABLE IF EXISTS `reagent_resource_category`;
CREATE TABLE `reagent_resource_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资源分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_resource_category
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_role
-- ----------------------------
DROP TABLE IF EXISTS `reagent_role`;
CREATE TABLE `reagent_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `admin_count` int(11) NULL DEFAULT NULL COMMENT '后台用户数量',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `status` int(11) NULL DEFAULT 1 COMMENT '启用状态：0->禁用；1->启用',
  `sort` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_role
-- ----------------------------
INSERT INTO `reagent_role` VALUES (1, '超级管理员', '系统维护', 1, '2021-06-24 16:10:11', 1, 0);
INSERT INTO `reagent_role` VALUES (2, '科室库库管员-单级库', '科室库库管员-单级库模式', 0, '2021-06-24 16:10:09', 1, 0);
INSERT INTO `reagent_role` VALUES (3, '科室库库管员-两级库', '科室库库管员-两级库模式', 4, '2021-06-24 16:10:02', 1, 0);
INSERT INTO `reagent_role` VALUES (4, '试剂操作员-单级库', '一级科室库试剂操作员使用', 0, '2021-06-24 16:10:06', 1, 0);
INSERT INTO `reagent_role` VALUES (5, '供货商', '进货', 13, '2021-06-24 16:10:00', 1, 0);
INSERT INTO `reagent_role` VALUES (6, '中心库库管员', '两级库模式下中心库管理员', 4, '2021-05-14 15:41:33', 1, 0);
INSERT INTO `reagent_role` VALUES (7, '系统管理员-单级库', '一级医院系统管理员', 1, '2021-05-15 15:14:36', 1, 0);
INSERT INTO `reagent_role` VALUES (8, '系统管理员-两级库', '二级医院系统管理员', 2, '2021-05-17 14:47:14', 1, 0);
INSERT INTO `reagent_role` VALUES (9, '试剂操作员-两级库', '二级科室库试剂操作员使用', 4, '2021-05-17 21:00:31', 1, 0);
INSERT INTO `reagent_role` VALUES (10, '默认', '默认角色', 2, '2021-06-09 15:02:12', 1, 0);

-- ----------------------------
-- Table structure for reagent_role_menu_relation
-- ----------------------------
DROP TABLE IF EXISTS `reagent_role_menu_relation`;
CREATE TABLE `reagent_role_menu_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2173 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色菜单关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_role_menu_relation
-- ----------------------------
INSERT INTO `reagent_role_menu_relation` VALUES (1605, 5, 11);
INSERT INTO `reagent_role_menu_relation` VALUES (1606, 5, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (1607, 5, 12);
INSERT INTO `reagent_role_menu_relation` VALUES (1608, 5, 19);
INSERT INTO `reagent_role_menu_relation` VALUES (1609, 5, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (1610, 5, 39);
INSERT INTO `reagent_role_menu_relation` VALUES (1611, 5, 47);
INSERT INTO `reagent_role_menu_relation` VALUES (1751, 6, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (1752, 6, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (1753, 6, 4);
INSERT INTO `reagent_role_menu_relation` VALUES (1754, 6, 8);
INSERT INTO `reagent_role_menu_relation` VALUES (1755, 6, 9);
INSERT INTO `reagent_role_menu_relation` VALUES (1756, 6, 10);
INSERT INTO `reagent_role_menu_relation` VALUES (1757, 6, 11);
INSERT INTO `reagent_role_menu_relation` VALUES (1758, 6, 12);
INSERT INTO `reagent_role_menu_relation` VALUES (1759, 6, 14);
INSERT INTO `reagent_role_menu_relation` VALUES (1760, 6, 16);
INSERT INTO `reagent_role_menu_relation` VALUES (1761, 6, 18);
INSERT INTO `reagent_role_menu_relation` VALUES (1762, 6, 19);
INSERT INTO `reagent_role_menu_relation` VALUES (1763, 6, 20);
INSERT INTO `reagent_role_menu_relation` VALUES (1764, 6, 30);
INSERT INTO `reagent_role_menu_relation` VALUES (1765, 6, 31);
INSERT INTO `reagent_role_menu_relation` VALUES (1766, 6, 34);
INSERT INTO `reagent_role_menu_relation` VALUES (1767, 6, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (1768, 6, 40);
INSERT INTO `reagent_role_menu_relation` VALUES (1769, 6, 41);
INSERT INTO `reagent_role_menu_relation` VALUES (1770, 6, 47);
INSERT INTO `reagent_role_menu_relation` VALUES (1771, 6, 49);
INSERT INTO `reagent_role_menu_relation` VALUES (1772, 6, 52);
INSERT INTO `reagent_role_menu_relation` VALUES (1773, 6, 53);
INSERT INTO `reagent_role_menu_relation` VALUES (1774, 6, 54);
INSERT INTO `reagent_role_menu_relation` VALUES (1775, 6, 56);
INSERT INTO `reagent_role_menu_relation` VALUES (1776, 6, 58);
INSERT INTO `reagent_role_menu_relation` VALUES (1777, 6, 60);
INSERT INTO `reagent_role_menu_relation` VALUES (1778, 6, 61);
INSERT INTO `reagent_role_menu_relation` VALUES (1779, 6, 62);
INSERT INTO `reagent_role_menu_relation` VALUES (1780, 6, 63);
INSERT INTO `reagent_role_menu_relation` VALUES (1781, 13, 4);
INSERT INTO `reagent_role_menu_relation` VALUES (1782, 13, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (1783, 13, 5);
INSERT INTO `reagent_role_menu_relation` VALUES (1784, 13, 9);
INSERT INTO `reagent_role_menu_relation` VALUES (1785, 13, 10);
INSERT INTO `reagent_role_menu_relation` VALUES (2043, 1, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2044, 1, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2045, 1, 4);
INSERT INTO `reagent_role_menu_relation` VALUES (2046, 1, 5);
INSERT INTO `reagent_role_menu_relation` VALUES (2047, 1, 6);
INSERT INTO `reagent_role_menu_relation` VALUES (2048, 1, 8);
INSERT INTO `reagent_role_menu_relation` VALUES (2049, 1, 9);
INSERT INTO `reagent_role_menu_relation` VALUES (2050, 1, 10);
INSERT INTO `reagent_role_menu_relation` VALUES (2051, 1, 11);
INSERT INTO `reagent_role_menu_relation` VALUES (2052, 1, 12);
INSERT INTO `reagent_role_menu_relation` VALUES (2053, 1, 14);
INSERT INTO `reagent_role_menu_relation` VALUES (2054, 1, 15);
INSERT INTO `reagent_role_menu_relation` VALUES (2055, 1, 16);
INSERT INTO `reagent_role_menu_relation` VALUES (2056, 1, 17);
INSERT INTO `reagent_role_menu_relation` VALUES (2057, 1, 18);
INSERT INTO `reagent_role_menu_relation` VALUES (2058, 1, 19);
INSERT INTO `reagent_role_menu_relation` VALUES (2059, 1, 20);
INSERT INTO `reagent_role_menu_relation` VALUES (2060, 1, 21);
INSERT INTO `reagent_role_menu_relation` VALUES (2061, 1, 22);
INSERT INTO `reagent_role_menu_relation` VALUES (2062, 1, 23);
INSERT INTO `reagent_role_menu_relation` VALUES (2063, 1, 30);
INSERT INTO `reagent_role_menu_relation` VALUES (2064, 1, 31);
INSERT INTO `reagent_role_menu_relation` VALUES (2065, 1, 32);
INSERT INTO `reagent_role_menu_relation` VALUES (2066, 1, 33);
INSERT INTO `reagent_role_menu_relation` VALUES (2067, 1, 34);
INSERT INTO `reagent_role_menu_relation` VALUES (2068, 1, 35);
INSERT INTO `reagent_role_menu_relation` VALUES (2069, 1, 36);
INSERT INTO `reagent_role_menu_relation` VALUES (2070, 1, 37);
INSERT INTO `reagent_role_menu_relation` VALUES (2071, 1, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (2072, 1, 39);
INSERT INTO `reagent_role_menu_relation` VALUES (2073, 1, 40);
INSERT INTO `reagent_role_menu_relation` VALUES (2074, 1, 41);
INSERT INTO `reagent_role_menu_relation` VALUES (2075, 1, 42);
INSERT INTO `reagent_role_menu_relation` VALUES (2076, 1, 43);
INSERT INTO `reagent_role_menu_relation` VALUES (2077, 1, 44);
INSERT INTO `reagent_role_menu_relation` VALUES (2078, 1, 45);
INSERT INTO `reagent_role_menu_relation` VALUES (2079, 1, 46);
INSERT INTO `reagent_role_menu_relation` VALUES (2080, 1, 47);
INSERT INTO `reagent_role_menu_relation` VALUES (2081, 1, 48);
INSERT INTO `reagent_role_menu_relation` VALUES (2082, 1, 49);
INSERT INTO `reagent_role_menu_relation` VALUES (2083, 1, 50);
INSERT INTO `reagent_role_menu_relation` VALUES (2084, 1, 51);
INSERT INTO `reagent_role_menu_relation` VALUES (2085, 1, 52);
INSERT INTO `reagent_role_menu_relation` VALUES (2086, 1, 53);
INSERT INTO `reagent_role_menu_relation` VALUES (2087, 1, 54);
INSERT INTO `reagent_role_menu_relation` VALUES (2088, 1, 55);
INSERT INTO `reagent_role_menu_relation` VALUES (2089, 1, 56);
INSERT INTO `reagent_role_menu_relation` VALUES (2090, 1, 57);
INSERT INTO `reagent_role_menu_relation` VALUES (2091, 1, 58);
INSERT INTO `reagent_role_menu_relation` VALUES (2092, 1, 59);
INSERT INTO `reagent_role_menu_relation` VALUES (2093, 1, 60);
INSERT INTO `reagent_role_menu_relation` VALUES (2094, 1, 61);
INSERT INTO `reagent_role_menu_relation` VALUES (2095, 1, 62);
INSERT INTO `reagent_role_menu_relation` VALUES (2096, 1, 63);
INSERT INTO `reagent_role_menu_relation` VALUES (2097, 1, 64);
INSERT INTO `reagent_role_menu_relation` VALUES (2098, 1, 65);
INSERT INTO `reagent_role_menu_relation` VALUES (2099, 1, 66);
INSERT INTO `reagent_role_menu_relation` VALUES (2100, 1, 67);
INSERT INTO `reagent_role_menu_relation` VALUES (2101, 1, 68);
INSERT INTO `reagent_role_menu_relation` VALUES (2102, 3, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2103, 3, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2104, 3, 10);
INSERT INTO `reagent_role_menu_relation` VALUES (2105, 3, 14);
INSERT INTO `reagent_role_menu_relation` VALUES (2106, 3, 16);
INSERT INTO `reagent_role_menu_relation` VALUES (2107, 3, 17);
INSERT INTO `reagent_role_menu_relation` VALUES (2108, 3, 20);
INSERT INTO `reagent_role_menu_relation` VALUES (2109, 3, 22);
INSERT INTO `reagent_role_menu_relation` VALUES (2110, 3, 30);
INSERT INTO `reagent_role_menu_relation` VALUES (2111, 3, 31);
INSERT INTO `reagent_role_menu_relation` VALUES (2112, 3, 34);
INSERT INTO `reagent_role_menu_relation` VALUES (2113, 3, 36);
INSERT INTO `reagent_role_menu_relation` VALUES (2114, 3, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (2115, 3, 40);
INSERT INTO `reagent_role_menu_relation` VALUES (2116, 3, 41);
INSERT INTO `reagent_role_menu_relation` VALUES (2117, 3, 42);
INSERT INTO `reagent_role_menu_relation` VALUES (2118, 3, 56);
INSERT INTO `reagent_role_menu_relation` VALUES (2119, 3, 59);
INSERT INTO `reagent_role_menu_relation` VALUES (2120, 3, 60);
INSERT INTO `reagent_role_menu_relation` VALUES (2121, 3, 61);
INSERT INTO `reagent_role_menu_relation` VALUES (2122, 3, 62);
INSERT INTO `reagent_role_menu_relation` VALUES (2123, 3, 63);
INSERT INTO `reagent_role_menu_relation` VALUES (2124, 3, 67);
INSERT INTO `reagent_role_menu_relation` VALUES (2125, 3, 68);
INSERT INTO `reagent_role_menu_relation` VALUES (2126, 2, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2127, 2, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2128, 2, 9);
INSERT INTO `reagent_role_menu_relation` VALUES (2129, 2, 10);
INSERT INTO `reagent_role_menu_relation` VALUES (2130, 2, 11);
INSERT INTO `reagent_role_menu_relation` VALUES (2131, 2, 12);
INSERT INTO `reagent_role_menu_relation` VALUES (2132, 2, 14);
INSERT INTO `reagent_role_menu_relation` VALUES (2133, 2, 15);
INSERT INTO `reagent_role_menu_relation` VALUES (2134, 2, 16);
INSERT INTO `reagent_role_menu_relation` VALUES (2135, 2, 18);
INSERT INTO `reagent_role_menu_relation` VALUES (2136, 2, 19);
INSERT INTO `reagent_role_menu_relation` VALUES (2137, 2, 20);
INSERT INTO `reagent_role_menu_relation` VALUES (2138, 2, 21);
INSERT INTO `reagent_role_menu_relation` VALUES (2139, 2, 30);
INSERT INTO `reagent_role_menu_relation` VALUES (2140, 2, 34);
INSERT INTO `reagent_role_menu_relation` VALUES (2141, 2, 35);
INSERT INTO `reagent_role_menu_relation` VALUES (2142, 2, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (2143, 2, 39);
INSERT INTO `reagent_role_menu_relation` VALUES (2144, 2, 51);
INSERT INTO `reagent_role_menu_relation` VALUES (2145, 2, 56);
INSERT INTO `reagent_role_menu_relation` VALUES (2146, 2, 57);
INSERT INTO `reagent_role_menu_relation` VALUES (2147, 2, 60);
INSERT INTO `reagent_role_menu_relation` VALUES (2148, 2, 61);
INSERT INTO `reagent_role_menu_relation` VALUES (2149, 2, 63);
INSERT INTO `reagent_role_menu_relation` VALUES (2150, 2, 67);
INSERT INTO `reagent_role_menu_relation` VALUES (2151, 2, 68);
INSERT INTO `reagent_role_menu_relation` VALUES (2152, 7, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2153, 7, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2154, 7, 4);
INSERT INTO `reagent_role_menu_relation` VALUES (2155, 7, 5);
INSERT INTO `reagent_role_menu_relation` VALUES (2156, 7, 64);
INSERT INTO `reagent_role_menu_relation` VALUES (2157, 7, 65);
INSERT INTO `reagent_role_menu_relation` VALUES (2158, 7, 66);
INSERT INTO `reagent_role_menu_relation` VALUES (2159, 7, 67);
INSERT INTO `reagent_role_menu_relation` VALUES (2160, 7, 68);
INSERT INTO `reagent_role_menu_relation` VALUES (2161, 7, 56);
INSERT INTO `reagent_role_menu_relation` VALUES (2162, 8, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2163, 8, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2164, 8, 4);
INSERT INTO `reagent_role_menu_relation` VALUES (2165, 8, 5);
INSERT INTO `reagent_role_menu_relation` VALUES (2166, 8, 8);
INSERT INTO `reagent_role_menu_relation` VALUES (2167, 8, 64);
INSERT INTO `reagent_role_menu_relation` VALUES (2168, 8, 65);
INSERT INTO `reagent_role_menu_relation` VALUES (2169, 8, 66);
INSERT INTO `reagent_role_menu_relation` VALUES (2170, 8, 67);
INSERT INTO `reagent_role_menu_relation` VALUES (2171, 8, 68);
INSERT INTO `reagent_role_menu_relation` VALUES (2172, 8, 56);

-- ----------------------------
-- Table structure for reagent_role_permission_relation
-- ----------------------------
DROP TABLE IF EXISTS `reagent_role_permission_relation`;
CREATE TABLE `reagent_role_permission_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL,
  `permission_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户角色和权限关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_role_permission_relation
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_role_resource_relation
-- ----------------------------
DROP TABLE IF EXISTS `reagent_role_resource_relation`;
CREATE TABLE `reagent_role_resource_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `resource_id` bigint(20) NULL DEFAULT NULL COMMENT '资源ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 219 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色资源关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_role_resource_relation
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_search
-- ----------------------------
DROP TABLE IF EXISTS `reagent_search`;
CREATE TABLE `reagent_search`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色ID',
  `kind` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单ID',
  `placename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色菜单关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_search
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_stock
-- ----------------------------
DROP TABLE IF EXISTS `reagent_stock`;
CREATE TABLE `reagent_stock`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '库存编号',
  `stock_type` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '库存种类：1 一级中心库汇总单， 3 二级库科室汇总单，3二级库中心库库存',
  `reagent_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂耗材ID',
  `reagent_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂名称',
  `reagent_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号规格',
  `reagent_unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `branch_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科室库名称',
  `factory` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `supplier_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商',
  `quantity` bigint(20) NULL DEFAULT NULL COMMENT '库存数量',
  `reagent_price` double(10, 3) NULL DEFAULT NULL COMMENT '单价',
  `reagent_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态：1.中心已入库（在库），1997: 中心已出库，1999：科室已出库',
  `reagent_temp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '存储温度',
  `low_stock` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '低库存预警',
  `overdue_stock` int(20) NULL DEFAULT NULL COMMENT '过期预警',
  `overdue` int(20) NULL DEFAULT NULL COMMENT '过期预警阈值',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 495 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_stock
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_stock_detail
-- ----------------------------
DROP TABLE IF EXISTS `reagent_stock_detail`;
CREATE TABLE `reagent_stock_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '库存编号',
  `stock_type` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '库存种类：1 中心库汇总单， 2 二级库汇总单',
  `reagent_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂耗材ID',
  `reagent_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂名称',
  `specification` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `manufacturer_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `registration_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册证号',
  `supplier_short_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `branch` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '科室库名',
  `reagent_unit` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `reagent_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态: 0：丢失，1：破损，2：过期，3：用尽，4.其他 5: 已退货, 1997: 中心已出库,1998: 在库，1999：科室已出库',
  `reagent_temp` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '储存温度: 常温，冷藏，冷冻',
  `reagent_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '试剂编号',
  `qr_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '二维码',
  `code_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二维码数据',
  `batch_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品批号',
  `expire_date` date NULL DEFAULT NULL COMMENT '库存有效期',
  `open_period` int(32) NULL DEFAULT NULL COMMENT '开启有效期',
  `reagent_price` double(10, 3) NULL DEFAULT NULL COMMENT '单价',
  `overdue` int(20) NULL DEFAULT NULL COMMENT '过期预警',
  `collect_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '移库单号',
  `enter_time` datetime(0) NULL DEFAULT NULL COMMENT '入库时间',
  `enter_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库单号',
  `enter_man` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库人',
  `out_time` datetime(0) NULL DEFAULT NULL COMMENT '出库时间',
  `out_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库单号',
  `out_man` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库人',
  `apply_man` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申领人',
  `use_time` datetime(0) NULL DEFAULT NULL COMMENT '使用时间',
  `device_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备id',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 253466 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_stock_detail
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_stock_loss
-- ----------------------------
DROP TABLE IF EXISTS `reagent_stock_loss`;
CREATE TABLE `reagent_stock_loss`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂耗材编号',
  `stock_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '库存ID',
  `qr_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '二维码',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '库损状态： \'0\': \'丢失\' ，\'1\', \'破损\'， \'2\' \'过期\'， \'3\',\'其他原因\'',
  `use_date` date NULL DEFAULT NULL COMMENT '开瓶日',
  `use_expire` date NULL DEFAULT NULL COMMENT '开瓶有效期',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材库存个体' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_stock_loss
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_supplier
-- ----------------------------
DROP TABLE IF EXISTS `reagent_supplier`;
CREATE TABLE `reagent_supplier`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `supplier_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '供货商ID',
  `supplier_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '供货商正式名',
  `supplier_short_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商简名',
  `contacts` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contacts_tel` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人电话',
  `contacts_phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人手机',
  `contacts_wechat` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人微信',
  `supplier_address` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司地址',
  `status` int(11) NULL DEFAULT NULL COMMENT '公司状态',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '供应商' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_supplier
-- ----------------------------
INSERT INTO `reagent_supplier` VALUES (40, '1', '山东广图医疗科技有限公司', '广图医疗', '李继鹏', '4000539079', '13325081081', '13325081081', '山东省临沂市综合保税区临工路100号', 1, '2021-08-23 13:44:50', NULL, '2021-08-23 13:44:50', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_supplier` VALUES (41, '41', '临沂康华医疗器械有限公司', '康华医疗', '朱礼龙', '', '15315497939', '', '临沂市莒南县十字路镇', 1, '2021-08-23 20:26:09', NULL, '2021-08-23 20:26:09', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_supplier` VALUES (42, '42', '山东康盛医疗器械有限公司', '康盛医疗', '王宁', '', '18653555090', '', '临沂市开元尚城B栋2703', 1, '2021-08-23 20:29:29', NULL, '2021-08-23 20:29:29', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_supplier` VALUES (43, '43', ' 临沂市康平医疗器械有限公司', '康平医疗', '张敏', '', '18053975480', '', '临沂市兰山区商城路145号', 1, '2021-08-24 10:07:47', NULL, '2021-08-24 10:07:47', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_supplier` VALUES (44, '44', '临沂忠联信息科技有限公司', '忠联科技', '王媛媛', '', '13562997867', '', '临沂市综合保税区临工路100号', 1, '2021-08-25 17:24:36', NULL, '2021-08-25 17:24:36', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_supplier` VALUES (45, '45', '临沂康泰医疗器械有限公司', '康泰医疗', '谢云波', '', '18853988666', '', '临沂市兰山区开阳路20号', 1, '2021-08-28 12:47:46', NULL, '2021-08-28 12:47:46', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_supplier` VALUES (46, '46', '山东科启医疗科技有限公司', '科启医疗', ' 刘荣卫 ', '', '13353110988', '', ' 山东省济南市高新区舜华路2000号舜泰广场2号楼2202', 1, '2021-08-30 18:55:35', NULL, '2021-08-30 18:55:35', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_supplier` VALUES (47, '47', '山东迈尔医疗科技有限公司', '迈尔医疗', ' 许文婷 ', '', '15315306890', '', ' 山东省日照市富阳路西、北园一路南', 1, '2021-08-30 18:56:55', NULL, '2021-08-30 18:56:55', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_supplier` VALUES (48, '48', '山东迈瑞医疗器械有限公司', '迈瑞医疗', ' 徐大福 ', '', '15953306062', '', '淄博高新区政通路135号(高科技创业园E座306室)', 1, '2021-08-30 18:58:09', NULL, '2021-08-30 18:58:09', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_supplier` VALUES (49, '49', '青岛丽可医疗器械有限公司', '丽可医疗', '曹胜铉', '', '13353268567', '', ' 山东省青岛市城阳区棘洪滩街道荣海一路18号', 1, '2021-08-30 18:59:01', NULL, '2021-08-30 18:59:01', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_supplier` VALUES (50, '50', '临沂汇康医疗器械有限公司', '汇康医疗', ' 孟宪娟', '', '13562997867', '', '山东省临沂市兰山区商城路151号(临沂市医药技工学校)对过 ', 1, '2021-09-03 18:25:40', NULL, '2021-09-03 18:25:40', NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;

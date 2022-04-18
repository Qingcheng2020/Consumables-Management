/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50713
 Source Host           : localhost:3306
 Source Schema         : reagentdb

 Target Server Type    : MySQL
 Target Server Version : 50713
 File Encoding         : 65001

 Date: 18/04/2022 17:00:35
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
) ENGINE = InnoDB AUTO_INCREMENT = 138 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_admin
-- ----------------------------
INSERT INTO `reagent_admin` VALUES (1, 'admin', '$2a$10$26qpRmIYUrXQKgfmuN8riOnwY.C/j8hPDEN1NMz2Hj/qdUzvB0ReK', '', NULL, NULL, '15505550555', 'admin', '', 'admin@163.com', '山东省济南市', '系统管理员', '超级管理员', '2018-10-08 13:32:47', '2022-04-15 13:43:20', 1);
INSERT INTO `reagent_admin` VALUES (134, '管理员', '$2a$10$rmUYNkslj/UhNvJibxy7Lux.euiayRkqTeZdVCClYUdC.f2C/GNWK', '中心库', '', '', NULL, '王佳豪', NULL, '', NULL, '', '系统管理员', '2022-02-26 14:41:55', '2022-02-26 14:41:55', 1);
INSERT INTO `reagent_admin` VALUES (135, '陈龙', '$2a$10$wDQ/78jw8OyCDZbkjXSezueDbKaW2RoBJglZMiV/Vl6.X888KyxI2', '化验科', '', '', NULL, '陈龙', NULL, 'huayan@qq.com', NULL, '', '', '2022-04-13 21:14:18', '2022-04-18 15:50:58', 1);
INSERT INTO `reagent_admin` VALUES (136, '刘嘉诚', '$2a$10$dGZMjeawOkgOdoy8sipitezVwz1tvJvJF8DRPrfMS2lcwpyAxT2V.', '', '保护伞', '', NULL, '刘嘉诚', NULL, 'supplier@qq.com', NULL, '', '', '2022-04-13 21:17:23', '2022-04-14 14:29:33', 1);
INSERT INTO `reagent_admin` VALUES (137, '王家城', '$2a$10$AOGsMowIp4P9vBlRycJPE.3/b7Z8nkKi3AASy0d0995lWssBQI2Ra', '中心库', '', '', NULL, '王家城', NULL, '', NULL, '', '', '2022-04-14 14:39:53', '2022-04-18 09:51:35', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 5936 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户登录日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_admin_login_log
-- ----------------------------
INSERT INTO `reagent_admin_login_log` VALUES (5862, 1, '2022-02-26 14:40:26', '192.168.0.105', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5863, 134, '2022-02-26 14:42:55', '192.168.0.105', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5864, 1, '2022-04-13 08:23:24', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5865, 1, '2022-04-13 11:18:13', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5866, 1, '2022-04-13 11:27:17', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5867, 1, '2022-04-13 11:28:33', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5868, 1, '2022-04-13 11:35:31', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5869, 1, '2022-04-13 11:41:14', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5870, 1, '2022-04-13 11:44:02', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5871, 1, '2022-04-13 11:51:20', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5872, 1, '2022-04-13 12:06:34', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5873, 1, '2022-04-13 12:27:08', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5874, 1, '2022-04-13 13:37:49', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5875, 1, '2022-04-13 14:00:17', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5876, 1, '2022-04-13 15:00:42', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5877, 1, '2022-04-13 21:02:44', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5878, 136, '2022-04-13 21:22:37', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5879, 136, '2022-04-13 21:24:57', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5880, 136, '2022-04-13 21:28:48', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5881, 1, '2022-04-13 21:29:06', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5882, 1, '2022-04-13 21:35:15', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5883, 1, '2022-04-13 21:35:19', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5884, 1, '2022-04-13 21:35:56', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5885, 1, '2022-04-13 21:36:31', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5886, 135, '2022-04-13 21:38:12', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5887, 1, '2022-04-13 21:38:27', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5888, 135, '2022-04-13 21:39:26', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5889, 1, '2022-04-13 21:39:41', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5890, 1, '2022-04-14 14:28:44', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5891, 135, '2022-04-14 14:29:16', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5892, 136, '2022-04-14 14:29:33', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5893, 135, '2022-04-14 14:30:01', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5894, 1, '2022-04-14 14:30:06', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5895, 135, '2022-04-14 14:33:05', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5896, 135, '2022-04-14 14:36:29', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5897, 1, '2022-04-14 14:37:16', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5898, 135, '2022-04-14 14:40:24', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5899, 137, '2022-04-14 14:41:33', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5900, 1, '2022-04-15 13:43:20', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5901, 135, '2022-04-15 13:44:12', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5902, 1, '2022-04-15 13:44:26', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5903, 137, '2022-04-15 13:44:52', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5904, 1, '2022-04-15 13:46:26', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5905, 135, '2022-04-15 13:48:06', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5906, 1, '2022-04-15 13:48:22', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5907, 137, '2022-04-15 13:48:59', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5908, 135, '2022-04-15 13:49:24', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5909, 137, '2022-04-15 13:50:46', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5910, 135, '2022-04-15 13:51:08', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5911, 1, '2022-04-15 13:52:14', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5912, 135, '2022-04-15 13:52:44', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5913, 137, '2022-04-15 13:54:43', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5914, 137, '2022-04-15 16:43:58', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5915, 137, '2022-04-16 17:29:04', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5916, 137, '2022-04-16 19:50:14', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5917, 137, '2022-04-17 11:11:09', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5918, 135, '2022-04-17 11:40:05', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5919, 135, '2022-04-17 12:46:33', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5920, 137, '2022-04-17 13:09:59', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5921, 135, '2022-04-17 13:10:17', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5922, 137, '2022-04-17 13:12:46', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5923, 135, '2022-04-17 13:13:50', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5924, 135, '2022-04-17 13:57:37', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5925, 135, '2022-04-17 16:18:14', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5926, 137, '2022-04-18 09:51:34', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5927, 137, '2022-04-18 14:47:19', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5928, 137, '2022-04-18 15:50:49', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5929, 135, '2022-04-18 15:50:57', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5930, 137, '2022-04-18 15:51:07', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5931, 135, '2022-04-18 15:51:30', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5932, 137, '2022-04-18 15:53:31', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5933, 135, '2022-04-18 15:55:33', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5934, 137, '2022-04-18 15:56:17', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5935, 135, '2022-04-18 16:41:38', '10.27.204.2', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 302 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户和角色关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_admin_role_relation
-- ----------------------------
INSERT INTO `reagent_admin_role_relation` VALUES (184, 1, 1);
INSERT INTO `reagent_admin_role_relation` VALUES (282, 134, 8);
INSERT INTO `reagent_admin_role_relation` VALUES (294, 136, 5);
INSERT INTO `reagent_admin_role_relation` VALUES (299, 137, 6);
INSERT INTO `reagent_admin_role_relation` VALUES (301, 135, 3);

-- ----------------------------
-- Table structure for reagent_base_info
-- ----------------------------
DROP TABLE IF EXISTS `reagent_base_info`;
CREATE TABLE `reagent_base_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂耗材编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '试剂名称',
  `unit` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `specification` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格型号',
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
  `classify` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '耗材 药品 办公用品',
  `consumClassify` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医用 卫生',
  `isQR` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'int and boolean both accepted',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 392 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '试剂基础情报' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_base_info
-- ----------------------------
INSERT INTO `reagent_base_info` VALUES (388, '388', '针头', '盒', '10支', '保护伞', '12345', '1', '保护伞', 10.00, '常温', 10, 10, 10, '2022-04-15 13:45:43', NULL, '2022-04-15 13:48:30', NULL, NULL, NULL, NULL, '耗材', '医用耗材', '是');
INSERT INTO `reagent_base_info` VALUES (389, '389', '纸', '盒', '200张', '保护伞', '123', '1', '保护伞', 10.00, '', 100000, 10, 100000, '2022-04-15 19:07:43', NULL, NULL, NULL, NULL, NULL, NULL, '办公用品', '', '否');
INSERT INTO `reagent_base_info` VALUES (390, '390', 'wda', 'awd', 'dwa', 'adw', 'awd', '1', '保护伞', 1.00, '常温', 1, 1, 1, '2022-04-15 19:54:18', NULL, NULL, NULL, NULL, NULL, NULL, '药品', '', '否');
INSERT INTO `reagent_base_info` VALUES (391, '391', '5', '2', '89', '2', '5', '1', '保护伞', 2.00, '常温', 52, 2, 1, '2022-04-17 11:26:15', NULL, NULL, NULL, NULL, NULL, NULL, '药品', '', '否');

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
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '科室' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_branch
-- ----------------------------
INSERT INTO `reagent_branch` VALUES (19, '1', '中心库', NULL, NULL, '2022-02-26 14:41:29', NULL, '2022-02-26 14:41:29', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_branch` VALUES (20, '20', '化验科', '15762960990', '陈龙', '2022-04-13 21:08:17', NULL, '2022-04-13 21:08:17', NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_collect
-- ----------------------------
INSERT INTO `reagent_collect` VALUES (1, '1650001809771697', '2', '2022-04-15', '1', '化验科', NULL, '陈龙', '2022-04-15 13:50:10', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_collect` VALUES (2, '1650001912795660', '2', '2022-04-15', '1', '化验科', NULL, '陈龙', '2022-04-15 13:51:53', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for reagent_collect_detail
-- ----------------------------
DROP TABLE IF EXISTS `reagent_collect_detail`;
CREATE TABLE `reagent_collect_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `collect_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请单号',
  `reagent_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '基础信息编号',
  `reagent_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂名',
  `supplier_short_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `factory` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂单位',
  `reagent_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号规格',
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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_collect_detail
-- ----------------------------
INSERT INTO `reagent_collect_detail` VALUES (1, '1650001809771697', '1', '针头', '保护伞', '保护伞', '盒', '10支', 10.000, 5, '2022-04-15 13:50:10', '陈龙', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_collect_detail` VALUES (2, '1650001912795660', '1', '针头', '保护伞', '保护伞', '盒', '10支', 10.000, 5, '2022-04-15 13:51:53', '陈龙', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for reagent_cop_qualification
-- ----------------------------
DROP TABLE IF EXISTS `reagent_cop_qualification`;
CREATE TABLE `reagent_cop_qualification`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `supplier_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商ID',
  `supplier_short_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商正式名',
  `business_license` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司营业执照',
  `medical_equipment_business_license` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二三类医疗器械备案、经营许可证',
  `legal_person_power_of_attorney` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法人委托书',
  `client_id_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被委托人身份证复印件',
  `quality_assurance_greement` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '质量保证协议书',
  `other` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其他',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_cop_qualification
-- ----------------------------
INSERT INTO `reagent_cop_qualification` VALUES (56, '1', 'wda', NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 11:36:24', NULL, '2022-04-13 11:36:24', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_cop_qualification` VALUES (57, '1', '保护伞', NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 21:16:54', NULL, '2022-04-13 21:16:54', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for reagent_device
-- ----------------------------
DROP TABLE IF EXISTS `reagent_device`;
CREATE TABLE `reagent_device`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备ID',
  `device_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名',
  `branch_id` bigint(20) NULL DEFAULT NULL COMMENT '科室id',
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '科室' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_device
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '成长值变化历史记录表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单（接收单）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_in_bill
-- ----------------------------
INSERT INTO `reagent_in_bill` VALUES (1, '1650001755954660', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 13:49:16', NULL, '2022-04-15 13:49:16', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (2, '1650017415024405', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 18:10:15', NULL, '2022-04-15 18:10:15', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (3, '1650018467831700', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 18:27:48', NULL, '2022-04-15 18:27:48', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (4, '1650019009881974', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 18:36:50', NULL, '2022-04-15 18:36:50', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (8, '1650023826621447', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 19:57:07', NULL, '2022-04-15 19:57:07', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (9, '1650024145368812', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 20:02:25', NULL, '2022-04-15 20:02:25', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (10, '1650024404971600', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 20:06:45', NULL, '2022-04-15 20:06:45', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (11, '1650024547395365', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 20:09:07', NULL, '2022-04-15 20:09:07', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (12, '1650024679336523', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 20:11:19', NULL, '2022-04-15 20:11:19', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (13, '1650024965365558', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 20:16:05', NULL, '2022-04-15 20:16:05', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (14, '1650025433453210', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 20:23:53', NULL, '2022-04-15 20:23:53', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (15, '1650025533625816', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 20:25:34', NULL, '2022-04-15 20:25:34', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (16, '1650025621886717', NULL, '2', '2', '1', '保护伞', '2022-04-15', '1', '中心库', '王家城', NULL, '2022-04-15 20:27:02', NULL, '2022-04-15 20:27:02', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (20, '1650165254813856', NULL, '2', '2', '1', '保护伞', '2022-04-17', '1', '中心库', '王家城', NULL, '2022-04-17 11:14:15', NULL, '2022-04-17 11:14:15', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (21, '1650165640067909', NULL, '2', '2', '1', '保护伞', '2022-04-17', '1', '中心库', '王家城', NULL, '2022-04-17 11:20:40', NULL, '2022-04-17 11:20:40', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_bill` VALUES (22, '1650165881620656', NULL, '2', '2', '1', '保护伞', '2022-04-17', '1', '中心库', '王家城', NULL, '2022-04-17 11:24:42', NULL, '2022-04-17 11:24:42', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for reagent_in_detail
-- ----------------------------
DROP TABLE IF EXISTS `reagent_in_detail`;
CREATE TABLE `reagent_in_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库单编号',
  `in_detail_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库单详细ID',
  `reagent_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂编号',
  `reagent_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂名称',
  `reagent_unit` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `reagent_specification` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `factory` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
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
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单详细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_in_detail
-- ----------------------------
INSERT INTO `reagent_in_detail` VALUES (1, '1650001755954660', '1650001755960897', '1', '针头', '盒', '10支', '保护伞', 10.000, 10, 100.000, '10', '2022-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (2, '1650017415024405', '1650017415034261', '1', '针头', '盒', '10支', '保护伞', 10.000, 10, 100.000, '10000', '2022-04-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (3, '1650018467831700', '1650018467841353', '1', '针头', '盒', '10支', '保护伞', 10.000, 5, 50.000, '123', '2022-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (4, '1650019009881974', '1650019009890115', '1', '针头', '盒', '10支', '保护伞', 10.000, 5, 50.000, '4444', '2022-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (5, '1650024145368812', '1650024145377258', '389', '纸', '盒', '200张', '保护伞', 10.000, 1, 10.000, '2', '2022-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (6, '1650024404971600', '1650024404988378', '389', '纸', '盒', '200张', '保护伞', 10.000, 1, 10.000, '1', '2022-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (7, '1650024547395365', '1650024547406294', '389', '纸', '盒', '200张', '保护伞', 10.000, 2, 20.000, '1', '2022-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (8, '1650024679336523', '1650024679353638', '389', '纸', '盒', '200张', '保护伞', 10.000, 1, 10.000, '3', '2022-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (9, '1650025621886717', '1650025621895284', '388', '针头', '盒', '10支', '保护伞', 10.000, 1, 10.000, '1', '2022-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (11, '1650165254813856', '1650165254827463', '390', 'wda', 'awd', 'dwa', 'adw', 1.000, 1, 1.000, '1', '2022-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (12, '1650165640067909', '1650165640072505', '388', '针头', '盒', '10支', '保护伞', 10.000, 1, 10.000, '1', '2022-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail` VALUES (13, '1650165881620656', '1650165881625484', '388', '针头', '盒', '10支', '保护伞', 10.000, 10, 100.000, '2', '2022-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单个体' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_in_detail_item
-- ----------------------------
INSERT INTO `reagent_in_detail_item` VALUES (1, '1650001755954660', '1650001755960897', '10001', '165000175596089710001', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10<br/>有效期: 2022-04-30<br/>编号: 10001', '1', '2022-04-15 13:49:16', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (2, '1650001755954660', '1650001755960897', '10002', '165000175596089710002', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10<br/>有效期: 2022-04-30<br/>编号: 10002', '1', '2022-04-15 13:49:16', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (3, '1650001755954660', '1650001755960897', '10003', '165000175596089710003', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10<br/>有效期: 2022-04-30<br/>编号: 10003', '1', '2022-04-15 13:49:16', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (4, '1650001755954660', '1650001755960897', '10004', '165000175596089710004', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10<br/>有效期: 2022-04-30<br/>编号: 10004', '1', '2022-04-15 13:49:16', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (5, '1650001755954660', '1650001755960897', '10005', '165000175596089710005', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10<br/>有效期: 2022-04-30<br/>编号: 10005', '1', '2022-04-15 13:49:16', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (6, '1650001755954660', '1650001755960897', '10006', '165000175596089710006', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10<br/>有效期: 2022-04-30<br/>编号: 10006', '1', '2022-04-15 13:49:16', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (7, '1650001755954660', '1650001755960897', '10007', '165000175596089710007', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10<br/>有效期: 2022-04-30<br/>编号: 10007', '1', '2022-04-15 13:49:16', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (8, '1650001755954660', '1650001755960897', '10008', '165000175596089710008', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10<br/>有效期: 2022-04-30<br/>编号: 10008', '1', '2022-04-15 13:49:16', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (9, '1650001755954660', '1650001755960897', '10009', '165000175596089710009', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10<br/>有效期: 2022-04-30<br/>编号: 10009', '1', '2022-04-15 13:49:16', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (10, '1650001755954660', '1650001755960897', '10010', '165000175596089710010', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10<br/>有效期: 2022-04-30<br/>编号: 10010', '1', '2022-04-15 13:49:16', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (11, '1650017415024405', '1650017415034261', '10000001', '165001741503426110000001', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10000<br/>有效期: 2022-04-16<br/>编号: 10000001', '1', '2022-04-15 18:10:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (12, '1650017415024405', '1650017415034261', '10000002', '165001741503426110000002', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10000<br/>有效期: 2022-04-16<br/>编号: 10000002', '1', '2022-04-15 18:10:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (13, '1650017415024405', '1650017415034261', '10000003', '165001741503426110000003', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10000<br/>有效期: 2022-04-16<br/>编号: 10000003', '1', '2022-04-15 18:10:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (14, '1650017415024405', '1650017415034261', '10000004', '165001741503426110000004', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10000<br/>有效期: 2022-04-16<br/>编号: 10000004', '1', '2022-04-15 18:10:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (15, '1650017415024405', '1650017415034261', '10000005', '165001741503426110000005', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10000<br/>有效期: 2022-04-16<br/>编号: 10000005', '1', '2022-04-15 18:10:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (16, '1650017415024405', '1650017415034261', '10000006', '165001741503426110000006', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10000<br/>有效期: 2022-04-16<br/>编号: 10000006', '1', '2022-04-15 18:10:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (17, '1650017415024405', '1650017415034261', '10000007', '165001741503426110000007', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10000<br/>有效期: 2022-04-16<br/>编号: 10000007', '1', '2022-04-15 18:10:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (18, '1650017415024405', '1650017415034261', '10000008', '165001741503426110000008', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10000<br/>有效期: 2022-04-16<br/>编号: 10000008', '1', '2022-04-15 18:10:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (19, '1650017415024405', '1650017415034261', '10000009', '165001741503426110000009', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10000<br/>有效期: 2022-04-16<br/>编号: 10000009', '1', '2022-04-15 18:10:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (20, '1650017415024405', '1650017415034261', '10000010', '165001741503426110000010', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 10000<br/>有效期: 2022-04-16<br/>编号: 10000010', '1', '2022-04-15 18:10:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (21, '1650018467831700', '1650018467841353', '123001', '1650018467841353123001', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 123<br/>有效期: 2022-04-29<br/>编号: 123001', '1', '2022-04-15 18:27:48', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (22, '1650018467831700', '1650018467841353', '123002', '1650018467841353123002', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 123<br/>有效期: 2022-04-29<br/>编号: 123002', '1', '2022-04-15 18:27:48', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (23, '1650018467831700', '1650018467841353', '123003', '1650018467841353123003', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 123<br/>有效期: 2022-04-29<br/>编号: 123003', '1', '2022-04-15 18:27:48', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (24, '1650018467831700', '1650018467841353', '123004', '1650018467841353123004', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 123<br/>有效期: 2022-04-29<br/>编号: 123004', '1', '2022-04-15 18:27:48', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (25, '1650018467831700', '1650018467841353', '123005', '1650018467841353123005', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 123<br/>有效期: 2022-04-29<br/>编号: 123005', '1', '2022-04-15 18:27:48', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (26, '1650019009881974', '1650019009890115', '4444001', '16500190098901154444001', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 4444<br/>有效期: 2022-04-29<br/>编号: 4444001', '1', '2022-04-15 18:36:50', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (27, '1650019009881974', '1650019009890115', '4444002', '16500190098901154444002', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 4444<br/>有效期: 2022-04-29<br/>编号: 4444002', '1', '2022-04-15 18:36:50', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (28, '1650019009881974', '1650019009890115', '4444003', '16500190098901154444003', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 4444<br/>有效期: 2022-04-29<br/>编号: 4444003', '1', '2022-04-15 18:36:50', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (29, '1650019009881974', '1650019009890115', '4444004', '16500190098901154444004', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 4444<br/>有效期: 2022-04-29<br/>编号: 4444004', '1', '2022-04-15 18:36:50', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (30, '1650019009881974', '1650019009890115', '4444005', '16500190098901154444005', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 4444<br/>有效期: 2022-04-29<br/>编号: 4444005', '1', '2022-04-15 18:36:50', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (31, '1650024145368812', '1650024145377258', '2001', '16500241453772582001', '名称: 纸<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-04-29<br/>编号: 2001', '1', '2022-04-15 20:02:25', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (32, '1650024404971600', '1650024404988378', '1001', '16500244049883781001', '名称: 纸<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 1<br/>有效期: 2022-04-30<br/>编号: 1001', '1', '2022-04-15 20:06:45', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (33, '1650024547395365', '1650024547406294', '1002', '16500245474062941002', '名称: 纸<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 1<br/>有效期: 2022-04-30<br/>编号: 1002', '1', '2022-04-15 20:09:07', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (34, '1650024547395365', '1650024547406294', '1003', '16500245474062941003', '名称: 纸<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 1<br/>有效期: 2022-04-30<br/>编号: 1003', '1', '2022-04-15 20:09:07', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (35, '1650024679336523', '1650024679353638', '3001', '16500246793536383001', '名称: 纸<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 3<br/>有效期: 2022-05-07<br/>编号: 3001', '1', '2022-04-15 20:11:19', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (36, '1650025621886717', '1650025621895284', '1001', '16500256218952841001', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 1<br/>有效期: 2022-05-07<br/>编号: 1001', '1', '2022-04-15 20:27:02', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (38, '1650165254813856', '1650165254827463', '1001', '16501652548274631001', '名称: wda<br/>厂家: adw<br/>供货商: 保护伞<br/>批号: 1<br/>有效期: 2022-05-07<br/>编号: 1001', '1', '2022-04-17 11:14:15', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (39, '1650165640067909', '1650165640072505', '1001', '16501656400725051001', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 1<br/>有效期: 2022-05-07<br/>编号: 1001', '1', '2022-04-17 11:20:40', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (40, '1650165881620656', '1650165881625484', '2001', '16501658816254842001', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2001', '1', '2022-04-17 11:24:42', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (41, '1650165881620656', '1650165881625484', '2002', '16501658816254842002', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2002', '1', '2022-04-17 11:24:42', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (42, '1650165881620656', '1650165881625484', '2003', '16501658816254842003', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2003', '1', '2022-04-17 11:24:42', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (43, '1650165881620656', '1650165881625484', '2004', '16501658816254842004', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2004', '1', '2022-04-17 11:24:42', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (44, '1650165881620656', '1650165881625484', '2005', '16501658816254842005', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2005', '1', '2022-04-17 11:24:42', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (45, '1650165881620656', '1650165881625484', '2006', '16501658816254842006', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2006', '1', '2022-04-17 11:24:42', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (46, '1650165881620656', '1650165881625484', '2007', '16501658816254842007', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2007', '1', '2022-04-17 11:24:42', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (47, '1650165881620656', '1650165881625484', '2008', '16501658816254842008', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2008', '1', '2022-04-17 11:24:42', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (48, '1650165881620656', '1650165881625484', '2009', '16501658816254842009', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2009', '1', '2022-04-17 11:24:42', '王家城', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `reagent_in_detail_item` VALUES (49, '1650165881620656', '1650165881625484', '2010', '16501658816254842010', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2010', '1', '2022-04-17 11:24:42', '王家城', NULL, NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '积分消费设置' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员等级表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员收货地址表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台菜单表' ROW_FORMAT = Dynamic;

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
INSERT INTO `reagent_menu` VALUES (10, 3, '2021-03-03 17:15:51', '耗材基础数据管理', 1, 0, 'baseInfo', 'ums-baseInfo', 0);
INSERT INTO `reagent_menu` VALUES (11, 1, '2021-03-05 09:28:23', '订单管理', 0, 0, 'oms', 'order', 0);
INSERT INTO `reagent_menu` VALUES (12, 11, '2021-03-05 09:43:57', '订单列表', 1, 0, 'order', 'product-list', 0);
INSERT INTO `reagent_menu` VALUES (14, 1, '2021-03-05 20:55:27', '库存管理', 0, 0, 'tms', 'tms', 0);
INSERT INTO `reagent_menu` VALUES (15, 14, '2021-03-05 20:53:19', '科室库存列表', 1, 0, 'stockCentre', 'tms-stockCentre', 0);
INSERT INTO `reagent_menu` VALUES (17, 14, '2021-03-09 20:49:34', '科室库存列表', 1, 0, 'stockBranch', 'tms-stockBranch', 0);
INSERT INTO `reagent_menu` VALUES (18, 11, '2021-03-09 20:57:59', '耗材下单', 1, 0, 'placeOrder', 'place-order', 0);
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
INSERT INTO `reagent_menu` VALUES (51, 34, '2021-04-15 20:36:27', '入库', 1, 0, 'createInBillOC', 'wms-createInBillOC', 0);
INSERT INTO `reagent_menu` VALUES (52, 34, '2021-04-15 20:36:27', '入库', 1, 0, 'createInBillTC', 'wms-createInBillTC', 0);
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
INSERT INTO `reagent_menu` VALUES (63, 56, '2021-06-01 21:59:17', '时段耗材出入库报表', 1, 0, 'reagentOutIn', 'bms-reagentOutIn', 0);
INSERT INTO `reagent_menu` VALUES (64, 3, '2021-08-18 16:29:51', '日志管理', 1, 0, 'log', 'ums-log', 0);
INSERT INTO `reagent_menu` VALUES (65, 64, '2021-08-18 16:29:51', '操作日志', 1, 0, 'operationLog', 'log-operationLog', 0);
INSERT INTO `reagent_menu` VALUES (66, 64, '2021-08-18 16:29:51', '登录日志', 1, 0, 'loginLog', 'log-loginLog', 0);
INSERT INTO `reagent_menu` VALUES (67, 3, '2021-09-02 11:21:46', '设备管理', 1, 0, 'device', 'ums-device', 0);
INSERT INTO `reagent_menu` VALUES (68, 56, '2021-09-03 21:59:17', '耗材使用记录报表', 1, 0, 'reagentUseLog', 'bms-reagentUseLog', 0);
INSERT INTO `reagent_menu` VALUES (69, 14, '2021-09-13 21:19:20', '库损汇总', 1, 0, 'lossSummary', 'tms-lossSummary', 0);
INSERT INTO `reagent_menu` VALUES (70, 1, '2021-10-12 16:29:51', '资质管理', 0, 0, 'qms', 'qms', 0);
INSERT INTO `reagent_menu` VALUES (71, 70, '2021-10-12 20:43:51', '公司资质', 1, 0, 'copQualification', 'qms-copQualification', 0);
INSERT INTO `reagent_menu` VALUES (72, 70, '2021-10-12 20:43:51', '产品资质', 1, 0, 'prodQualification', 'qms-prodQualification', 0);
INSERT INTO `reagent_menu` VALUES (73, 20, '2021-11-18 11:43:01', '时段耗材出库汇总', 1, 0, 'outSummary', 'outSummary', 0);
INSERT INTO `reagent_menu` VALUES (74, 34, '2021-11-18 13:34:37', '时段耗材入库汇总', 1, 0, 'inSummary', 'wms-inSummary', 0);
INSERT INTO `reagent_menu` VALUES (75, 56, '2021-12-30 21:59:17', '耗材总库存', 1, 0, 'reagentOverall', 'bms-reagentOverall', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2565 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_operation_log
-- ----------------------------
INSERT INTO `reagent_operation_log` VALUES (2445, '科室管理', '新增科室', 1, 'admin', '2022-02-26 14:41:29', '操作成功', 'http://localhost:8080/branch/create', 'POST', '192.168.0.105', '19', '[ReagentBranch [Hash = 2120075653, id=19, branchCode=1, branchName=中心库, tel=null, head=null, createTime=Sat Feb 26 14:41:29 CST 2022, createBy=null, updateTime=Sat Feb 26 14:41:29 CST 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2446, '用户管理', '分配角色', 1, 'admin', '2022-02-26 14:42:21', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '192.168.0.105', '134', '[134, [8]]');
INSERT INTO `reagent_operation_log` VALUES (2447, '用户管理', '修改用户', 1, 'admin', '2022-02-26 14:42:30', '操作成功', 'http://localhost:8080/admin/update/134', 'POST', '192.168.0.105', '134', '[134, ReagentAdmin [Hash = 1249756402, id=134, username=管理员, password=null, branch=中心库, supplier=, groupName=, phone=null, trueName=管理员, icon=null, email=, address=null, nickName=, note=系统管理员, createTime=Sat Feb 26 14:41:55 CST 2022, loginTime=Sat Feb 26 14:41:55 CST 2022, status=1, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2448, '供货商管理', '新增供货商', 1, 'admin', '2022-04-13 11:36:24', '操作成功', 'http://localhost:8080/supplier/create', 'POST', '10.27.204.2', '71', '[ReagentSupplier [Hash = 76712870, id=71, supplierCode=1, supplierName=daw, supplierShortName=wda, contacts=wad, contactsTel=15762960990, contactsPhone=15762960990, contactsWechat=1959, supplierAddress=wad, status=1, createTime=Wed Apr 13 11:36:23 GMT+08:00 2022, createBy=null, updateTime=Wed Apr 13 11:36:23 GMT+08:00 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2449, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 11:38:25', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '372', '[ReagentBaseInfo [Hash = 1122481645, id=372, code=1, name=dwa, unit=务农, specification=dwa, manufacturerName=dwa, registrationNo=awd, supplierId=1, supplierShortName=wda, price=3.0, stockType=常温, expirationLimit=20221111, stockLimit=15, useDayLimit=15, createTime=Wed Apr 13 11:38:25 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2450, '试剂管理', '修改信息', 1, 'admin', '2022-04-13 11:39:03', '操作成功', 'http://localhost:8080/baseInfo/update/372', 'POST', '10.27.204.2', '372', '[372, ReagentBaseInfo [Hash = 1438166924, id=372, code=1, name=dwa, unit=务农, specification=dwa, manufacturerName=dwa, registrationNo=awd, supplierId=1, supplierShortName=wda, price=3.0, stockType=常温, expirationLimit=20221111, stockLimit=15, useDayLimit=15, createTime=Wed Apr 13 11:38:25 GMT+08:00 2022, createBy=null, updateTime=Wed Apr 13 11:39:03 GMT+08:00 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2451, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 11:41:44', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '373', '[ReagentBaseInfo [Hash = 1824124433, id=373, code=373, name=daw, unit=wad, specification=wad, manufacturerName=awd, registrationNo=adw, supplierId=1, supplierShortName=wda, price=2.0, stockType=常温, expirationLimit=123, stockLimit=2, useDayLimit=0, createTime=Wed Apr 13 11:41:44 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2452, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 11:44:25', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '374', '[ReagentBaseInfo [Hash = 40842478, id=374, code=374, name=adw, unit=adw, specification=adw, manufacturerName=adw, registrationNo=adw, supplierId=1, supplierShortName=wda, price=2.0, stockType=常温, expirationLimit=2, stockLimit=2, useDayLimit=2, createTime=Wed Apr 13 11:44:25 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2453, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 11:49:28', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '375', '[ReagentBaseInfo [Hash = 1804013433, id=375, code=375, name=dwa, unit=dwa, specification=dwa, manufacturerName=dwa, registrationNo=adw, supplierId=1, supplierShortName=wda, price=2.0, stockType=常温, expirationLimit=2, stockLimit=2, useDayLimit=2, createTime=Wed Apr 13 11:49:28 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2454, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 11:51:37', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '376', '[ReagentBaseInfo [Hash = 422480870, id=376, code=376, name=awd, unit=awd, specification=awd, manufacturerName=adw, registrationNo=adw, supplierId=1, supplierShortName=wda, price=2.0, stockType=常温, expirationLimit=2, stockLimit=2, useDayLimit=2, createTime=Wed Apr 13 11:51:37 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1, classify=药品, consumClassify=, isQR=是]]');
INSERT INTO `reagent_operation_log` VALUES (2455, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 12:07:00', '操作成功', 'http://localhost:8080/baseInfo/delete/372', 'POST', '10.27.204.2', '372', '[372]');
INSERT INTO `reagent_operation_log` VALUES (2456, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 12:07:02', '操作成功', 'http://localhost:8080/baseInfo/delete/372', 'POST', '10.27.204.2', '372', '[372]');
INSERT INTO `reagent_operation_log` VALUES (2457, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 12:07:03', '操作成功', 'http://localhost:8080/baseInfo/delete/372', 'POST', '10.27.204.2', '372', '[372]');
INSERT INTO `reagent_operation_log` VALUES (2458, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 12:07:04', '操作成功', 'http://localhost:8080/baseInfo/delete/372', 'POST', '10.27.204.2', '372', '[372]');
INSERT INTO `reagent_operation_log` VALUES (2459, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 12:07:06', '操作成功', 'http://localhost:8080/baseInfo/delete/372', 'POST', '10.27.204.2', '372', '[372]');
INSERT INTO `reagent_operation_log` VALUES (2460, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 12:07:23', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '377', '[ReagentBaseInfo [Hash = 1079998161, id=377, code=1, name=daw, unit=awd, specification=wad, manufacturerName=adw, registrationNo=adw, supplierId=1, supplierShortName=wda, price=2.0, stockType=常温, expirationLimit=2, stockLimit=2, useDayLimit=2, createTime=Wed Apr 13 12:07:23 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2461, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 12:27:37', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '378', '[ReagentBaseInfo [Hash = 596688130, id=378, code=378, name=dawdw, unit=wad, specification=wad, manufacturerName=adw, registrationNo=daw, supplierId=1, supplierShortName=wda, price=2.0, stockType=常温, expirationLimit=2, stockLimit=2, useDayLimit=2, createTime=Wed Apr 13 12:27:37 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2462, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 12:41:30', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '379', '[ReagentBaseInfo [Hash = 1878790160, id=379, code=379, name=daw, unit=adw, specification=adw, manufacturerName=daw, registrationNo=adw, supplierId=1, supplierShortName=wda, price=2.0, stockType=常温, expirationLimit=2, stockLimit=2, useDayLimit=2, createTime=Wed Apr 13 12:41:30 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2463, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 13:42:34', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '380', '[ReagentBaseInfo [Hash = 1021151628, id=380, code=380, name=aaaa, unit=aaaa, specification=aaaa, manufacturerName=aaaa, registrationNo=1234, supplierId=1, supplierShortName=wda, price=1234.0, stockType=常温, expirationLimit=20, stockLimit=20, useDayLimit=20, createTime=Wed Apr 13 13:42:34 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1, classify=药品, consumClassify=, isQR=是]]');
INSERT INTO `reagent_operation_log` VALUES (2464, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 13:47:22', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '381', '[ReagentBaseInfo [Hash = 1021094248, id=381, code=381, name=aaaaa, unit=aaaa, specification=aaa, manufacturerName=aaa, registrationNo=123, supplierId=1, supplierShortName=wda, price=111.0, stockType=常温, expirationLimit=111, stockLimit=111, useDayLimit=11, createTime=Wed Apr 13 13:47:21 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1, classify=药品, consumClassify=, isQR=是]]');
INSERT INTO `reagent_operation_log` VALUES (2465, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 14:05:05', '操作成功', 'http://localhost:8080/baseInfo/delete/377', 'POST', '10.27.204.2', '377', '[377]');
INSERT INTO `reagent_operation_log` VALUES (2466, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 14:05:08', '操作成功', 'http://localhost:8080/baseInfo/delete/377', 'POST', '10.27.204.2', '377', '[377]');
INSERT INTO `reagent_operation_log` VALUES (2467, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 14:05:10', '操作成功', 'http://localhost:8080/baseInfo/delete/377', 'POST', '10.27.204.2', '377', '[377]');
INSERT INTO `reagent_operation_log` VALUES (2468, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 14:05:12', '操作成功', 'http://localhost:8080/baseInfo/delete/378', 'POST', '10.27.204.2', '378', '[378]');
INSERT INTO `reagent_operation_log` VALUES (2469, '试剂管理', '修改信息', 1, 'admin', '2022-04-13 14:05:17', '操作成功', 'http://localhost:8080/baseInfo/update/377', 'POST', '10.27.204.2', '377', '[377, ReagentBaseInfo [Hash = 1816472521, id=377, code=380, name=aaaa, unit=aaaa, specification=aaaa, manufacturerName=aaaa, registrationNo=1234, supplierId=1, supplierShortName=wda, price=1234.0, stockType=常温, expirationLimit=20, stockLimit=20, useDayLimit=20, createTime=Wed Apr 13 13:42:35 GMT+08:00 2022, createBy=null, updateTime=Wed Apr 13 14:05:17 GMT+08:00 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1, classify=药品, consumClassify=null, isQR=是]]');
INSERT INTO `reagent_operation_log` VALUES (2470, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 14:21:03', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '382', '[ReagentBaseInfo [Hash = 901356131, id=382, code=378, name=vvvv, unit=vvvv, specification=vvvv, manufacturerName=vvvv, registrationNo=vvvv, supplierId=1, supplierShortName=wda, price=22.0, stockType=常温, expirationLimit=22, stockLimit=2, useDayLimit=2, createTime=Wed Apr 13 14:21:03 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2471, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 14:29:36', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '383', '[ReagentBaseInfo [Hash = 586008440, id=383, code=383, name=nnnn, unit=nnn, specification=nn, manufacturerName=nnn, registrationNo=nn, supplierId=1, supplierShortName=wda, price=22.0, stockType=常温, expirationLimit=22, stockLimit=22, useDayLimit=22, createTime=Wed Apr 13 14:29:36 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1, classify=耗材, consumClassify=医用耗材, isQR=是]]');
INSERT INTO `reagent_operation_log` VALUES (2472, '试剂管理', '修改信息', 1, 'admin', '2022-04-13 14:29:51', '操作成功', 'http://localhost:8080/baseInfo/update/383', 'POST', '10.27.204.2', '383', '[383, ReagentBaseInfo [Hash = 2021950336, id=383, code=383, name=nnnn, unit=nnn, specification=nn, manufacturerName=nnn, registrationNo=nn, supplierId=1, supplierShortName=wda, price=22.0, stockType=常温, expirationLimit=22, stockLimit=22, useDayLimit=22, createTime=Wed Apr 13 14:29:37 GMT+08:00 2022, createBy=null, updateTime=Wed Apr 13 14:29:51 GMT+08:00 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1, classify=耗材, consumClassify=医用耗材, isQR=是]]');
INSERT INTO `reagent_operation_log` VALUES (2473, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 14:30:39', '操作成功', 'http://localhost:8080/baseInfo/delete/377', 'POST', '10.27.204.2', '377', '[377]');
INSERT INTO `reagent_operation_log` VALUES (2474, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 14:30:41', '操作成功', 'http://localhost:8080/baseInfo/delete/381', 'POST', '10.27.204.2', '381', '[381]');
INSERT INTO `reagent_operation_log` VALUES (2475, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 15:01:11', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '384', '[ReagentBaseInfo [Hash = 1081551199, id=384, code=382, name=dwad, unit=dwa, specification=adw, manufacturerName=dwa, registrationNo=awd, supplierId=1, supplierShortName=wda, price=2.0, stockType=常温, expirationLimit=2, stockLimit=2, useDayLimit=2, createTime=Wed Apr 13 15:01:11 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2476, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 15:06:42', '操作成功', 'http://localhost:8080/baseInfo/delete/381', 'POST', '10.27.204.2', '381', '[381]');
INSERT INTO `reagent_operation_log` VALUES (2477, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 15:06:43', '操作成功', 'http://localhost:8080/baseInfo/delete/383', 'POST', '10.27.204.2', '383', '[383]');
INSERT INTO `reagent_operation_log` VALUES (2478, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 15:06:58', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '385', '[ReagentBaseInfo [Hash = 33743390, id=385, code=1, name=dwa, unit=awd, specification=wad, manufacturerName=wad, registrationNo=wad, supplierId=1, supplierShortName=wda, price=1.0, stockType=常温, expirationLimit=12, stockLimit=1, useDayLimit=1, createTime=Wed Apr 13 15:06:58 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2479, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 15:11:40', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '386', '[ReagentBaseInfo [Hash = 1213988974, id=386, code=386, name=awd, unit=awd, specification=awd, manufacturerName=adw, registrationNo=daw, supplierId=1, supplierShortName=wda, price=2.0, stockType=常温, expirationLimit=2, stockLimit=2, useDayLimit=2, createTime=Wed Apr 13 15:11:40 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2480, '试剂管理', '删除试剂', 1, 'admin', '2022-04-13 15:11:45', '操作成功', 'http://localhost:8080/baseInfo/delete/385', 'POST', '10.27.204.2', '385', '[385]');
INSERT INTO `reagent_operation_log` VALUES (2481, '试剂管理', '新增试剂', 1, 'admin', '2022-04-13 15:14:56', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '387', '[ReagentBaseInfo [Hash = 1988717351, id=387, code=386, name=dwad, unit=wad, specification=wad, manufacturerName=wad, registrationNo=adw, supplierId=1, supplierShortName=wda, price=3.0, stockType=常温, expirationLimit=3, stockLimit=3, useDayLimit=3, createTime=Wed Apr 13 15:14:56 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2482, '试剂管理', '修改信息', 1, 'admin', '2022-04-13 15:15:05', '操作成功', 'http://localhost:8080/baseInfo/update/387', 'POST', '10.27.204.2', '387', '[387, ReagentBaseInfo [Hash = 844592664, id=387, code=386, name=dwad, unit=wad, specification=wad, manufacturerName=wad, registrationNo=adw, supplierId=1, supplierShortName=wda, price=3.0, stockType=常温, expirationLimit=3, stockLimit=3, useDayLimit=3, createTime=Wed Apr 13 15:14:57 GMT+08:00 2022, createBy=null, updateTime=Wed Apr 13 15:15:05 GMT+08:00 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2483, '试剂管理', '修改信息', 1, 'admin', '2022-04-13 15:15:15', '操作成功', 'http://localhost:8080/baseInfo/update/387', 'POST', '10.27.204.2', '387', '[387, ReagentBaseInfo [Hash = 1079831154, id=387, code=386, name=dwad, unit=wad, specification=wad, manufacturerName=wad, registrationNo=adw, supplierId=1, supplierShortName=wda, price=3.0, stockType=常温, expirationLimit=3, stockLimit=3, useDayLimit=3, createTime=Wed Apr 13 15:14:57 GMT+08:00 2022, createBy=null, updateTime=Wed Apr 13 15:15:15 GMT+08:00 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2484, '试剂管理', '修改信息', 1, 'admin', '2022-04-13 15:23:50', '操作成功', 'http://localhost:8080/baseInfo/update/387', 'POST', '10.27.204.2', '387', '[387, ReagentBaseInfo [Hash = 869876722, id=387, code=386, name=dwad, unit=wad, specification=wad, manufacturerName=wad, registrationNo=adw, supplierId=1, supplierShortName=wda, price=3.0, stockType=常温, expirationLimit=3, stockLimit=3, useDayLimit=3, createTime=Wed Apr 13 15:14:57 GMT+08:00 2022, createBy=null, updateTime=Wed Apr 13 15:23:50 GMT+08:00 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2485, '科室管理', '新增科室', 1, 'admin', '2022-04-13 21:08:17', '操作成功', 'http://localhost:8080/branch/create', 'POST', '10.27.131.151', '20', '[ReagentBranch [Hash = 1849981381, id=20, branchCode=20, branchName=化验科, tel=15762960990, head=陈龙, createTime=Wed Apr 13 21:08:17 GMT+08:00 2022, createBy=null, updateTime=Wed Apr 13 21:08:17 GMT+08:00 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2486, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:15:33', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '135', '[135, [5]]');
INSERT INTO `reagent_operation_log` VALUES (2487, '供货商管理', '删除', 1, 'admin', '2022-04-13 21:16:12', '操作成功', 'http://localhost:8080/supplier/delete/71', 'POST', '10.27.131.151', '71', '[71]');
INSERT INTO `reagent_operation_log` VALUES (2488, '供货商管理', '新增供货商', 1, 'admin', '2022-04-13 21:16:53', '操作成功', 'http://localhost:8080/supplier/create', 'POST', '10.27.131.151', '72', '[ReagentSupplier [Hash = 1412860452, id=72, supplierCode=1, supplierName=保护伞生物制药有限公司, supplierShortName=保护伞, contacts=刘嘉诚, contactsTel=, contactsPhone=15762960990, contactsWechat=, supplierAddress=山东省临沂市河东区, status=1, createTime=Wed Apr 13 21:16:53 GMT+08:00 2022, createBy=null, updateTime=Wed Apr 13 21:16:53 GMT+08:00 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2489, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:17:31', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '136', '[136, [5]]');
INSERT INTO `reagent_operation_log` VALUES (2490, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:20:57', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '136', '[136, [1]]');
INSERT INTO `reagent_operation_log` VALUES (2491, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:21:07', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '136', '[136, [5]]');
INSERT INTO `reagent_operation_log` VALUES (2492, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:22:12', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '136', '[136, [4]]');
INSERT INTO `reagent_operation_log` VALUES (2493, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:22:17', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '136', '[136, [5]]');
INSERT INTO `reagent_operation_log` VALUES (2494, '角色管理', '新增', 1, 'admin', '2022-04-13 21:31:39', '操作成功', 'http://localhost:8080/role/create', 'POST', '10.27.131.151', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2495, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:37:57', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '135', '[135, [11]]');
INSERT INTO `reagent_operation_log` VALUES (2496, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:38:43', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '136', '[136, [11]]');
INSERT INTO `reagent_operation_log` VALUES (2497, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:39:49', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '136', '[136, [11]]');
INSERT INTO `reagent_operation_log` VALUES (2498, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:40:00', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '136', '[136, [5]]');
INSERT INTO `reagent_operation_log` VALUES (2499, '用户管理', '分配角色', 1, 'admin', '2022-04-13 21:40:05', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '135', '[135, [11]]');
INSERT INTO `reagent_operation_log` VALUES (2500, '用户管理', '分配角色', 1, 'admin', '2022-04-14 14:30:59', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '135', '[135, [1]]');
INSERT INTO `reagent_operation_log` VALUES (2501, '用户管理', '分配角色', 1, 'admin', '2022-04-14 14:31:05', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '135', '[135, [11]]');
INSERT INTO `reagent_operation_log` VALUES (2502, '角色管理', '分配菜单', 1, 'admin', '2022-04-14 14:32:53', '操作成功', 'http://localhost:8080/role/allocMenu', 'POST', '10.27.131.151', '11', '[11, [6, 3, 15, 14, 17, 21, 20, 22, 35, 34, 36, 39, 38, 40]]');
INSERT INTO `reagent_operation_log` VALUES (2503, '用户管理', '修改用户', 1, 'admin', '2022-04-14 14:39:18', '操作成功', 'http://localhost:8080/admin/update/134', 'POST', '10.27.131.151', '134', '[134, ReagentAdmin [Hash = 1367819949, id=134, username=管理员, password=$2a$10$rmUYNkslj/UhNvJibxy7Lux.euiayRkqTeZdVCClYUdC.f2C/GNWK, branch=中心库, supplier=, groupName=, phone=null, trueName=王佳豪, icon=null, email=, address=null, nickName=, note=系统管理员, createTime=Sat Feb 26 14:41:55 GMT+08:00 2022, loginTime=Sat Feb 26 14:41:55 GMT+08:00 2022, status=1, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2504, '用户管理', '分配角色', 1, 'admin', '2022-04-14 14:40:02', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '137', '[137, [6]]');
INSERT INTO `reagent_operation_log` VALUES (2505, '用户管理', '分配角色', 1, 'admin', '2022-04-14 14:40:10', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.131.151', '135', '[135, [3]]');
INSERT INTO `reagent_operation_log` VALUES (2506, '角色管理', '分配菜单', 1, 'admin', '2022-04-15 13:43:52', '操作成功', 'http://localhost:8080/role/allocMenu', 'POST', '10.27.204.2', '3', '[3, [3, 1, 10, 14, 17, 20, 22, 30, 31, 32, 33, 34, 36, 38, 40, 41, 42, 56, 59, 60, 61, 62, 63, 67, 68, 69, 73, 74, 75]]');
INSERT INTO `reagent_operation_log` VALUES (2507, '用户管理', '分配角色', 1, 'admin', '2022-04-15 13:44:04', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '10.27.204.2', '135', '[135, [3]]');
INSERT INTO `reagent_operation_log` VALUES (2508, '试剂管理', '删除试剂', 1, 'admin', '2022-04-15 13:44:43', '操作成功', 'http://localhost:8080/baseInfo/delete/385', 'POST', '10.27.204.2', '385', '[385]');
INSERT INTO `reagent_operation_log` VALUES (2509, '试剂管理', '删除试剂', 1, 'admin', '2022-04-15 13:44:45', '操作成功', 'http://localhost:8080/baseInfo/delete/386', 'POST', '10.27.204.2', '386', '[386]');
INSERT INTO `reagent_operation_log` VALUES (2510, '试剂管理', '新增试剂', 6, '王家城', '2022-04-15 13:45:43', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '388', '[ReagentBaseInfo [Hash = 1712302984, id=388, code=1, name=针头, unit=盒, specification=10支, manufacturerName=保护伞, registrationNo=12345, supplierId=1, supplierShortName=保护伞, price=10.0, stockType=常温, expirationLimit=10, stockLimit=10, useDayLimit=10, createTime=Fri Apr 15 13:45:43 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2511, '试剂管理', '修改信息', 1, 'admin', '2022-04-15 13:48:30', '操作成功', 'http://localhost:8080/baseInfo/update/388', 'POST', '10.27.204.2', '388', '[388, ReagentBaseInfo [Hash = 158611729, id=388, code=1, name=针头, unit=盒, specification=10支, manufacturerName=保护伞, registrationNo=12345, supplierId=1, supplierShortName=保护伞, price=10.0, stockType=常温, expirationLimit=10, stockLimit=10, useDayLimit=10, createTime=Fri Apr 15 13:45:43 GMT+08:00 2022, createBy=null, updateTime=Fri Apr 15 13:48:29 GMT+08:00 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2512, '入库管理-web', '新增', 6, '王家城', '2022-04-15 13:49:15', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2513, '领用管理', '新增', 3, '陈龙', '2022-04-15 13:50:09', '操作成功', 'http://localhost:8080/collect/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2514, '领用管理', '新增', 3, '陈龙', '2022-04-15 13:51:52', '操作成功', 'http://localhost:8080/collect/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2515, '角色管理', '分配菜单', 1, 'admin', '2022-04-15 13:52:36', '操作成功', 'http://localhost:8080/role/allocMenu', 'POST', '10.27.204.2', '3', '[3, [3, 1, 10, 14, 17, 20, 22, 30, 31, 34, 36, 38, 40, 41, 42, 56, 59, 60, 61, 62, 63, 67, 68, 69, 73, 74, 75]]');
INSERT INTO `reagent_operation_log` VALUES (2516, '在库管理', '库损', 6, '王家城', '2022-04-15 16:46:34', '操作成功', 'http://localhost:8080/stockDetail/updateStatus', 'POST', '10.27.204.2', '165000175596089710001', '[165000175596089710001, 1]');
INSERT INTO `reagent_operation_log` VALUES (2517, '入库管理-web', '新增', 6, '王家城', '2022-04-15 18:10:15', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2518, '入库管理-web', '新增', 6, '王家城', '2022-04-15 18:27:47', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2519, '入库管理-web', '新增', 6, '王家城', '2022-04-15 18:36:50', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2520, '试剂管理', '新增试剂', 6, '王家城', '2022-04-15 19:07:42', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '389', '[ReagentBaseInfo [Hash = 961962125, id=389, code=389, name=纸, unit=盒, specification=200张, manufacturerName=保护伞, registrationNo=123, supplierId=1, supplierShortName=保护伞, price=10.0, stockType=, expirationLimit=100000, stockLimit=10, useDayLimit=100000, createTime=Fri Apr 15 19:07:42 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2521, '入库管理', '删除', 6, '王家城', '2022-04-15 19:42:28', '操作成功', 'http://localhost:8080/inBill/delete', 'POST', '10.27.204.2', '[7]', '[[7]]');
INSERT INTO `reagent_operation_log` VALUES (2522, '入库管理', '删除', 6, '王家城', '2022-04-15 19:42:30', '操作成功', 'http://localhost:8080/inBill/delete', 'POST', '10.27.204.2', '[5]', '[[5]]');
INSERT INTO `reagent_operation_log` VALUES (2523, '入库管理', '删除', 6, '王家城', '2022-04-15 19:42:31', '操作成功', 'http://localhost:8080/inBill/delete', 'POST', '10.27.204.2', '[6]', '[[6]]');
INSERT INTO `reagent_operation_log` VALUES (2524, '入库管理', '打印', 6, '王家城', '2022-04-15 19:42:32', '操作成功', 'http://localhost:8080/inBill/searchCodeList', 'GET', '10.27.204.2', '1650019009881974', '[1650019009881974, 2]');
INSERT INTO `reagent_operation_log` VALUES (2525, '试剂管理', '新增试剂', 6, '王家城', '2022-04-15 19:54:18', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '390', '[ReagentBaseInfo [Hash = 759829967, id=390, code=390, name=wda, unit=awd, specification=dwa, manufacturerName=adw, registrationNo=awd, supplierId=1, supplierShortName=保护伞, price=1.0, stockType=常温, expirationLimit=1, stockLimit=1, useDayLimit=1, createTime=Fri Apr 15 19:54:18 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2526, '入库管理-web', '新增', 6, '王家城', '2022-04-15 20:02:25', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2527, '入库管理-web', '新增', 6, '王家城', '2022-04-15 20:06:45', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2528, '入库管理-web', '新增', 6, '王家城', '2022-04-15 20:09:07', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2529, '入库管理-web', '新增', 6, '王家城', '2022-04-15 20:11:19', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2530, '入库管理-web', '新增', 6, '王家城', '2022-04-15 20:27:02', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2531, '入库管理-web', '新增', 6, '王家城', '2022-04-15 20:40:05', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2532, '入库管理', '删除', 6, '王家城', '2022-04-17 11:13:20', '操作成功', 'http://localhost:8080/inBill/delete', 'POST', '10.27.204.2', '[19]', '[[19]]');
INSERT INTO `reagent_operation_log` VALUES (2533, '入库管理', '删除', 6, '王家城', '2022-04-17 11:13:23', '操作成功', 'http://localhost:8080/inBill/delete', 'POST', '10.27.204.2', '[18]', '[[18]]');
INSERT INTO `reagent_operation_log` VALUES (2534, '入库管理', '删除', 6, '王家城', '2022-04-17 11:13:25', '操作成功', 'http://localhost:8080/inBill/delete', 'POST', '10.27.204.2', '[17]', '[[17]]');
INSERT INTO `reagent_operation_log` VALUES (2535, '入库管理-web', '新增', 6, '王家城', '2022-04-17 11:14:14', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2536, '入库管理-web', '新增', 6, '王家城', '2022-04-17 11:20:40', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2537, '在库管理', '库损', 6, '王家城', '2022-04-17 11:23:14', '操作成功', 'http://localhost:8080/stockDetail/updateStatus', 'POST', '10.27.204.2', '16501656400725051001', '[16501656400725051001, 0]');
INSERT INTO `reagent_operation_log` VALUES (2538, '入库管理-web', '新增', 6, '王家城', '2022-04-17 11:24:41', '操作成功', 'http://localhost:8080/inBill/create', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2539, '试剂管理', '新增试剂', 6, '王家城', '2022-04-17 11:26:14', '操作成功', 'http://localhost:8080/baseInfo/create', 'POST', '10.27.204.2', '391', '[ReagentBaseInfo [Hash = 205549936, id=391, code=391, name=5, unit=2, specification=89, manufacturerName=2, registrationNo=5, supplierId=1, supplierShortName=保护伞, price=2.0, stockType=常温, expirationLimit=52, stockLimit=2, useDayLimit=1, createTime=Sun Apr 17 11:26:14 GMT+08:00 2022, createBy=null, updateTime=null, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2540, '在库管理', '修改', 3, '陈龙', '2022-04-17 11:52:25', '操作成功', 'http://localhost:8080/stock/update/1', 'POST', '10.27.204.2', '1', '[1, ReagentStock [Hash = 975755977, id=1, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=化验科, factory=保护伞, supplierName=保护伞, quantity=0, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=20, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2541, '在库管理', '修改', 3, '陈龙', '2022-04-17 11:52:32', '操作成功', 'http://localhost:8080/stock/update/1', 'POST', '10.27.204.2', '1', '[1, ReagentStock [Hash = 1493532141, id=1, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=化验科, factory=保护伞, supplierName=保护伞, quantity=0, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=20, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2542, '在库管理', '修改', 3, '陈龙', '2022-04-17 11:52:39', '操作成功', 'http://localhost:8080/stock/update/1', 'POST', '10.27.204.2', '1', '[1, ReagentStock [Hash = 868781866, id=1, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=化验科, factory=保护伞, supplierName=保护伞, quantity=0, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=20, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2543, '在库管理', '库损', 3, '陈龙', '2022-04-17 12:15:46', '操作成功', 'http://localhost:8080/stockDetail/updateStatus', 'POST', '10.27.204.2', '16501658816254842010', '[16501658816254842010, 1]');
INSERT INTO `reagent_operation_log` VALUES (2544, '在库管理', '库损', 3, '陈龙', '2022-04-17 12:19:52', '操作成功', 'http://localhost:8080/stockDetail/updateStatus', 'POST', '10.27.204.2', '16501658816254842008', '[16501658816254842008, 0]');
INSERT INTO `reagent_operation_log` VALUES (2545, '在库管理', '修改', 3, '陈龙', '2022-04-17 12:46:42', '操作成功', 'http://localhost:8080/stock/update/1', 'POST', '10.27.204.2', '1', '[1, ReagentStock [Hash = 110166027, id=1, stockNo=123, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=化验科, factory=保护伞, supplierName=保护伞, quantity=0, reagentPrice=10.0, reagentStatus=1997, reagentTemp=常温, lowStock=10, overdueStock=20, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2546, '在库管理', '修改', 3, '陈龙', '2022-04-17 12:50:41', '操作成功', 'http://localhost:8080/stock/update/1', 'POST', '10.27.204.2', '1', '[1, ReagentStock [Hash = 1499504190, id=1, stockNo=123, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=化验科, factory=保护伞, supplierName=保护伞, quantity=0, reagentPrice=10.0, reagentStatus=1997, reagentTemp=常温, lowStock=10, overdueStock=20, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2547, '在库管理', '移库', 3, '陈龙', '2022-04-17 12:57:52', '操作失败', 'http://localhost:8080/stock/outFromBranch/', 'POST', '10.27.204.2', NULL, NULL);
INSERT INTO `reagent_operation_log` VALUES (2548, '在库管理', '移库', 3, '陈龙', '2022-04-17 13:57:47', '操作成功', 'http://localhost:8080/stock/outFromBranch/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 217388088', '[ReagentStock [Hash = 217388088, id=1, stockNo=123, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=化验科, factory=保护伞, supplierName=保护伞, quantity=1, reagentPrice=10.0, reagentStatus=1997, reagentTemp=常温, lowStock=10, overdueStock=20, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2549, '在库管理', '移库', 3, '陈龙', '2022-04-17 14:43:01', '操作成功', 'http://localhost:8080/stock/outFromBranch/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 1682110815', '[ReagentStock [Hash = 1682110815, id=1, stockNo=123, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=化验科, factory=保护伞, supplierName=保护伞, quantity=4, reagentPrice=10.0, reagentStatus=1997, reagentTemp=常温, lowStock=10, overdueStock=20, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2550, '在库管理', '移库', 3, '陈龙', '2022-04-17 14:43:27', '操作成功', 'http://localhost:8080/stock/outFromBranch/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 2066986366', '[ReagentStock [Hash = 2066986366, id=1, stockNo=123, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=化验科, factory=保护伞, supplierName=保护伞, quantity=3, reagentPrice=10.0, reagentStatus=1997, reagentTemp=常温, lowStock=10, overdueStock=20, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2551, '在库管理', '移库', 3, '陈龙', '2022-04-17 16:18:22', '操作成功', 'http://localhost:8080/stock/outFromBranch/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 1852245142', '[ReagentStock [Hash = 1852245142, id=1, stockNo=123, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=化验科, factory=保护伞, supplierName=保护伞, quantity=2, reagentPrice=10.0, reagentStatus=1997, reagentTemp=常温, lowStock=10, overdueStock=20, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2552, '在库管理', '移库', 3, '陈龙', '2022-04-17 16:44:11', '操作成功', 'http://localhost:8080/stock/outFromBranch/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 1562960708', '[ReagentStock [Hash = 1562960708, id=1, stockNo=123, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=化验科, factory=保护伞, supplierName=保护伞, quantity=1, reagentPrice=10.0, reagentStatus=1997, reagentTemp=常温, lowStock=10, overdueStock=20, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2553, '出库管理', '删除', 3, '陈龙', '2022-04-17 16:59:21', '操作成功', 'http://localhost:8080/outBill/delete', 'POST', '10.27.204.2', '[1]', '[[1]]');
INSERT INTO `reagent_operation_log` VALUES (2554, '在库管理', '移库', 6, '王家城', '2022-04-18 09:51:45', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 1929883469', '[ReagentStock [Hash = 1929883469, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=4, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, destination=化验科, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2555, '在库管理', '移库', 6, '王家城', '2022-04-18 10:06:04', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 1374788659', '[ReagentStock [Hash = 1374788659, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=4, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, destination=化验科, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2556, '在库管理', '移库', 6, '王家城', '2022-04-18 15:26:15', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 394227689', '[ReagentStock [Hash = 394227689, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=3, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, destination=化验科, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2557, '在库管理', '移库', 6, '王家城', '2022-04-18 15:51:14', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 1156109222', '[ReagentStock [Hash = 1156109222, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=3, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, destination=化验科, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2558, '在库管理', '移库', 6, '王家城', '2022-04-18 15:53:37', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 1967215422', '[ReagentStock [Hash = 1967215422, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=3, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, destination=化验科, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2559, '在库管理', '移库', 6, '王家城', '2022-04-18 15:56:26', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 327413109', '[ReagentStock [Hash = 327413109, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=3, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, destination=化验科, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2560, '在库管理', '移库', 6, '王家城', '2022-04-18 16:01:53', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 2032920452', '[ReagentStock [Hash = 2032920452, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=3, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, destination=化验科, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2561, '在库管理', '移库', 6, '王家城', '2022-04-18 16:07:19', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 869766423', '[ReagentStock [Hash = 869766423, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=3, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, destination=化验科, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2562, '在库管理', '移库', 6, '王家城', '2022-04-18 16:10:14', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 90978916', '[ReagentStock [Hash = 90978916, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=2, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=2, destination=化验科, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2563, '在库管理', '移库', 6, '王家城', '2022-04-18 16:14:12', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 875936330', '[ReagentStock [Hash = 875936330, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=3, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, destination=化验科, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2564, '在库管理', '移库', 6, '王家城', '2022-04-18 16:41:26', '操作成功', 'http://localhost:8080/stock/outFromCentre/', 'POST', '10.27.204.2', 'ReagentStock [Hash = 2099973399', '[ReagentStock [Hash = 2099973399, id=6, stockNo=1650165881635361, stockType=3, reagentId=388, reagentName=针头, reagentType=10支, reagentUnit=盒, branchName=中心库, factory=保护伞, supplierName=保护伞, quantity=3, reagentPrice=10.0, reagentStatus=1, reagentTemp=常温, lowStock=10, overdueStock=19, overdue=10, createTime=Sun Apr 17 11:24:42 GMT+08:00 2022, createBy=137, updateTime=Sun Apr 17 11:24:42 GMT+08:00 2022, updateBy=137, deleteFlag=null, deleteTime=null, deleteBy=null, outNumber=1, destination=化验科, serialVersionUID=1]]');

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
  `order_status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单状态 0 ：草稿，1：已提交，2：已配货，3：撤销，4：已完成，5：已全部配货',
  `order_describe` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

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
  `reagent_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂名',
  `specification` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `unit` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订货单位',
  `reagent_number` bigint(20) NULL DEFAULT NULL COMMENT '订货数量',
  `manufacturer_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `price` double(16, 3) NULL DEFAULT NULL COMMENT '单价',
  `send_num` bigint(20) NULL DEFAULT NULL COMMENT '已发货数量',
  `unsend_num` bigint(20) NULL DEFAULT NULL COMMENT '待发货数量',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_no`(`order_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单' ROW_FORMAT = Dynamic;

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
  `reagent_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂名称',
  `reagent_specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `batch_no` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '批号',
  `factory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `registration_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册证号',
  `supplier_short_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单详细' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材出库单个体' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户权限表' ROW_FORMAT = Dynamic;

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
  `bill_status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '单据状态：0-已撤销、1-已入库、2-未入库-与订单完全相符、3-未入库-与订单部分相符、4-已入库-与订单部分相符、5：已关闭',
  `bill_creator` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '制单人',
  `electronic_invoice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电子发票',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单（接收单）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_pre_in_bill
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_pre_in_detail
-- ----------------------------
DROP TABLE IF EXISTS `reagent_pre_in_detail`;
CREATE TABLE `reagent_pre_in_detail`  (
  `id` bigint(20) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bill_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库单编号',
  `in_detail_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详情ID',
  `reagent_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂编号',
  `reagent_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂名称',
  `reagent_unit` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位',
  `reagent_specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `factory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `price` double(20, 3) NULL DEFAULT NULL COMMENT '价格',
  `quantity` bigint(20) NULL DEFAULT NULL COMMENT '数量',
  `total` double(20, 3) NULL DEFAULT NULL COMMENT '金额',
  `batch_no` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '批号',
  `expire_date` date NULL DEFAULT NULL COMMENT '保质期',
  `report_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报告单地址',
  `bill_status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '随货单状态：0：未入库、1：已入库',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单详细' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单个体' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_pre_in_detail_item
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_prod_qualification
-- ----------------------------
DROP TABLE IF EXISTS `reagent_prod_qualification`;
CREATE TABLE `reagent_prod_qualification`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `supplier_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商ID',
  `supplier_short_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商正式名',
  `reagent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂耗材编号',
  `reagent_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂名称',
  `manufacturer_business_license` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家营业执照',
  `device_prod_license` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医疗器械生产许可证',
  `equipment_business_license` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医疗器械经营许可证',
  `product_registration_form` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医疗器械生产产品登记表',
  `production_record_certificate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医疗器械生产备案凭证',
  `device_registration_certificate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医疗器械注册证',
  `other` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其他',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 277 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_prod_qualification
-- ----------------------------
INSERT INTO `reagent_prod_qualification` VALUES (251, '1', 'wda', '1', 'dwa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 11:36:57', NULL, '2022-04-13 11:36:57', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (252, '1', 'wda', '1', 'dwa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 11:37:06', NULL, '2022-04-13 11:37:06', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (253, '1', 'wda', '1', 'dwa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 11:38:25', NULL, '2022-04-13 11:38:25', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (254, '1', 'wda', '373', 'daw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 11:41:45', NULL, '2022-04-13 11:41:45', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (255, '1', 'wda', '374', 'adw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 11:44:25', NULL, '2022-04-13 11:44:25', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (256, '1', 'wda', '375', 'dwa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 11:49:28', NULL, '2022-04-13 11:49:28', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (257, '1', 'wda', '376', 'awd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 11:51:38', NULL, '2022-04-13 11:51:38', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (258, '1', 'wda', '1', 'daw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 12:07:24', NULL, '2022-04-13 12:07:24', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (259, '1', 'wda', '378', 'dawdw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 12:27:38', NULL, '2022-04-13 12:27:38', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (260, '1', 'wda', '379', 'daw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 12:41:31', NULL, '2022-04-13 12:41:31', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (261, '1', 'wda', '380', 'aaaa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 13:42:35', NULL, '2022-04-13 13:42:35', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (262, '1', 'wda', '381', 'aaaaa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 13:47:22', NULL, '2022-04-13 13:47:22', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (263, '1', 'wda', '382', 'vvv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 14:00:03', NULL, '2022-04-13 14:00:03', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (264, '1', 'wda', '382', 'vvv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 14:00:07', NULL, '2022-04-13 14:00:07', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (265, '1', 'wda', '382', 'll', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 14:01:50', NULL, '2022-04-13 14:01:50', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (266, '1', 'wda', '378', 'vvvv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 14:17:30', NULL, '2022-04-13 14:17:30', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (267, '1', 'wda', '378', 'vvvv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 14:21:04', NULL, '2022-04-13 14:21:04', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (268, '1', 'wda', '383', 'nnnn', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 14:29:37', NULL, '2022-04-13 14:29:37', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (269, '1', 'wda', '382', 'dwad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 15:01:11', NULL, '2022-04-13 15:01:11', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (270, '1', 'wda', '1', 'dwa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 15:06:58', NULL, '2022-04-13 15:06:58', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (271, '1', 'wda', '386', 'awd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 15:11:40', NULL, '2022-04-13 15:11:40', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (272, '1', 'wda', '386', 'dwad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-13 15:14:57', NULL, '2022-04-13 15:14:57', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (273, '1', '保护伞', '1', '针头', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-15 13:45:43', NULL, '2022-04-15 13:45:43', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (274, '1', '保护伞', '389', '纸', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-15 19:07:43', NULL, '2022-04-15 19:07:43', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (275, '1', '保护伞', '390', 'wda', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-15 19:54:18', NULL, '2022-04-15 19:54:18', NULL, NULL, NULL, NULL);
INSERT INTO `reagent_prod_qualification` VALUES (276, '1', '保护伞', '391', '5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-17 11:26:15', NULL, '2022-04-17 11:26:15', NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '退货单详细' ROW_FORMAT = Dynamic;

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
  `reagent_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试剂名称',
  `reagent_specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `batch_no` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '批号',
  `factory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单详细' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '退货单个体' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台资源表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资源分类表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_role
-- ----------------------------
INSERT INTO `reagent_role` VALUES (1, '超级管理员', '系统维护', 1, '2021-06-24 16:10:11', 1, 0);
INSERT INTO `reagent_role` VALUES (2, '科室库库管员-单级库', '科室库库管员-单级库模式', 0, '2021-06-24 16:10:09', 1, 0);
INSERT INTO `reagent_role` VALUES (3, '科室库库管员-两级库', '科室库库管员-两级库模式', 1, '2021-06-24 16:10:02', 1, 0);
INSERT INTO `reagent_role` VALUES (4, '试剂操作员-单级库', '一级科室库试剂操作员使用', 0, '2021-06-24 16:10:06', 1, 0);
INSERT INTO `reagent_role` VALUES (5, '供货商', '进货', 1, '2021-06-24 16:10:00', 1, 0);
INSERT INTO `reagent_role` VALUES (6, '中心库库管员', '两级库模式下中心库管理员', 1, '2021-05-14 15:41:33', 1, 0);
INSERT INTO `reagent_role` VALUES (7, '系统管理员-单级库', '一级医院系统管理员', 1, '2021-05-15 15:14:36', 1, 0);
INSERT INTO `reagent_role` VALUES (8, '系统管理员-两级库', '二级医院系统管理员', 1, '2021-05-17 14:47:14', 1, 0);
INSERT INTO `reagent_role` VALUES (9, '试剂操作员-两级库', '二级科室库试剂操作员使用', 7, '2021-05-17 21:00:31', 1, 0);
INSERT INTO `reagent_role` VALUES (10, '默认', '默认角色', 1, '2021-06-09 15:02:12', 1, 0);
INSERT INTO `reagent_role` VALUES (11, '科室库库管', '科室库管理', 1, '2022-04-13 21:31:40', 1, 0);

-- ----------------------------
-- Table structure for reagent_role_menu_relation
-- ----------------------------
DROP TABLE IF EXISTS `reagent_role_menu_relation`;
CREATE TABLE `reagent_role_menu_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2834 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色菜单关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_role_menu_relation
-- ----------------------------
INSERT INTO `reagent_role_menu_relation` VALUES (1781, 13, 4);
INSERT INTO `reagent_role_menu_relation` VALUES (1782, 13, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (1783, 13, 5);
INSERT INTO `reagent_role_menu_relation` VALUES (1784, 13, 9);
INSERT INTO `reagent_role_menu_relation` VALUES (1785, 13, 10);
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
INSERT INTO `reagent_role_menu_relation` VALUES (2343, 5, 11);
INSERT INTO `reagent_role_menu_relation` VALUES (2344, 5, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2345, 5, 12);
INSERT INTO `reagent_role_menu_relation` VALUES (2346, 5, 19);
INSERT INTO `reagent_role_menu_relation` VALUES (2347, 5, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (2348, 5, 39);
INSERT INTO `reagent_role_menu_relation` VALUES (2349, 5, 47);
INSERT INTO `reagent_role_menu_relation` VALUES (2350, 5, 70);
INSERT INTO `reagent_role_menu_relation` VALUES (2351, 5, 71);
INSERT INTO `reagent_role_menu_relation` VALUES (2352, 5, 72);
INSERT INTO `reagent_role_menu_relation` VALUES (2604, 1, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2605, 1, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2606, 1, 4);
INSERT INTO `reagent_role_menu_relation` VALUES (2607, 1, 5);
INSERT INTO `reagent_role_menu_relation` VALUES (2608, 1, 6);
INSERT INTO `reagent_role_menu_relation` VALUES (2609, 1, 8);
INSERT INTO `reagent_role_menu_relation` VALUES (2610, 1, 9);
INSERT INTO `reagent_role_menu_relation` VALUES (2611, 1, 10);
INSERT INTO `reagent_role_menu_relation` VALUES (2612, 1, 11);
INSERT INTO `reagent_role_menu_relation` VALUES (2613, 1, 12);
INSERT INTO `reagent_role_menu_relation` VALUES (2614, 1, 14);
INSERT INTO `reagent_role_menu_relation` VALUES (2615, 1, 15);
INSERT INTO `reagent_role_menu_relation` VALUES (2616, 1, 17);
INSERT INTO `reagent_role_menu_relation` VALUES (2617, 1, 18);
INSERT INTO `reagent_role_menu_relation` VALUES (2618, 1, 19);
INSERT INTO `reagent_role_menu_relation` VALUES (2619, 1, 20);
INSERT INTO `reagent_role_menu_relation` VALUES (2620, 1, 21);
INSERT INTO `reagent_role_menu_relation` VALUES (2621, 1, 22);
INSERT INTO `reagent_role_menu_relation` VALUES (2622, 1, 23);
INSERT INTO `reagent_role_menu_relation` VALUES (2623, 1, 30);
INSERT INTO `reagent_role_menu_relation` VALUES (2624, 1, 31);
INSERT INTO `reagent_role_menu_relation` VALUES (2625, 1, 32);
INSERT INTO `reagent_role_menu_relation` VALUES (2626, 1, 33);
INSERT INTO `reagent_role_menu_relation` VALUES (2627, 1, 34);
INSERT INTO `reagent_role_menu_relation` VALUES (2628, 1, 35);
INSERT INTO `reagent_role_menu_relation` VALUES (2629, 1, 36);
INSERT INTO `reagent_role_menu_relation` VALUES (2630, 1, 37);
INSERT INTO `reagent_role_menu_relation` VALUES (2631, 1, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (2632, 1, 39);
INSERT INTO `reagent_role_menu_relation` VALUES (2633, 1, 40);
INSERT INTO `reagent_role_menu_relation` VALUES (2634, 1, 41);
INSERT INTO `reagent_role_menu_relation` VALUES (2635, 1, 42);
INSERT INTO `reagent_role_menu_relation` VALUES (2636, 1, 43);
INSERT INTO `reagent_role_menu_relation` VALUES (2637, 1, 44);
INSERT INTO `reagent_role_menu_relation` VALUES (2638, 1, 45);
INSERT INTO `reagent_role_menu_relation` VALUES (2639, 1, 46);
INSERT INTO `reagent_role_menu_relation` VALUES (2640, 1, 47);
INSERT INTO `reagent_role_menu_relation` VALUES (2641, 1, 48);
INSERT INTO `reagent_role_menu_relation` VALUES (2642, 1, 49);
INSERT INTO `reagent_role_menu_relation` VALUES (2643, 1, 50);
INSERT INTO `reagent_role_menu_relation` VALUES (2644, 1, 51);
INSERT INTO `reagent_role_menu_relation` VALUES (2645, 1, 52);
INSERT INTO `reagent_role_menu_relation` VALUES (2646, 1, 53);
INSERT INTO `reagent_role_menu_relation` VALUES (2647, 1, 54);
INSERT INTO `reagent_role_menu_relation` VALUES (2648, 1, 55);
INSERT INTO `reagent_role_menu_relation` VALUES (2649, 1, 56);
INSERT INTO `reagent_role_menu_relation` VALUES (2650, 1, 57);
INSERT INTO `reagent_role_menu_relation` VALUES (2651, 1, 58);
INSERT INTO `reagent_role_menu_relation` VALUES (2652, 1, 59);
INSERT INTO `reagent_role_menu_relation` VALUES (2653, 1, 60);
INSERT INTO `reagent_role_menu_relation` VALUES (2654, 1, 61);
INSERT INTO `reagent_role_menu_relation` VALUES (2655, 1, 62);
INSERT INTO `reagent_role_menu_relation` VALUES (2656, 1, 63);
INSERT INTO `reagent_role_menu_relation` VALUES (2657, 1, 64);
INSERT INTO `reagent_role_menu_relation` VALUES (2658, 1, 65);
INSERT INTO `reagent_role_menu_relation` VALUES (2659, 1, 66);
INSERT INTO `reagent_role_menu_relation` VALUES (2660, 1, 67);
INSERT INTO `reagent_role_menu_relation` VALUES (2661, 1, 68);
INSERT INTO `reagent_role_menu_relation` VALUES (2662, 1, 69);
INSERT INTO `reagent_role_menu_relation` VALUES (2663, 1, 70);
INSERT INTO `reagent_role_menu_relation` VALUES (2664, 1, 71);
INSERT INTO `reagent_role_menu_relation` VALUES (2665, 1, 72);
INSERT INTO `reagent_role_menu_relation` VALUES (2666, 1, 73);
INSERT INTO `reagent_role_menu_relation` VALUES (2667, 1, 74);
INSERT INTO `reagent_role_menu_relation` VALUES (2668, 1, 75);
INSERT INTO `reagent_role_menu_relation` VALUES (2669, 2, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2670, 2, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2671, 2, 9);
INSERT INTO `reagent_role_menu_relation` VALUES (2672, 2, 10);
INSERT INTO `reagent_role_menu_relation` VALUES (2673, 2, 11);
INSERT INTO `reagent_role_menu_relation` VALUES (2674, 2, 12);
INSERT INTO `reagent_role_menu_relation` VALUES (2675, 2, 14);
INSERT INTO `reagent_role_menu_relation` VALUES (2676, 2, 15);
INSERT INTO `reagent_role_menu_relation` VALUES (2677, 2, 18);
INSERT INTO `reagent_role_menu_relation` VALUES (2678, 2, 19);
INSERT INTO `reagent_role_menu_relation` VALUES (2679, 2, 20);
INSERT INTO `reagent_role_menu_relation` VALUES (2680, 2, 21);
INSERT INTO `reagent_role_menu_relation` VALUES (2681, 2, 30);
INSERT INTO `reagent_role_menu_relation` VALUES (2682, 2, 34);
INSERT INTO `reagent_role_menu_relation` VALUES (2683, 2, 35);
INSERT INTO `reagent_role_menu_relation` VALUES (2684, 2, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (2685, 2, 39);
INSERT INTO `reagent_role_menu_relation` VALUES (2686, 2, 51);
INSERT INTO `reagent_role_menu_relation` VALUES (2687, 2, 56);
INSERT INTO `reagent_role_menu_relation` VALUES (2688, 2, 57);
INSERT INTO `reagent_role_menu_relation` VALUES (2689, 2, 60);
INSERT INTO `reagent_role_menu_relation` VALUES (2690, 2, 61);
INSERT INTO `reagent_role_menu_relation` VALUES (2691, 2, 63);
INSERT INTO `reagent_role_menu_relation` VALUES (2692, 2, 67);
INSERT INTO `reagent_role_menu_relation` VALUES (2693, 2, 68);
INSERT INTO `reagent_role_menu_relation` VALUES (2694, 2, 69);
INSERT INTO `reagent_role_menu_relation` VALUES (2695, 2, 70);
INSERT INTO `reagent_role_menu_relation` VALUES (2696, 2, 71);
INSERT INTO `reagent_role_menu_relation` VALUES (2697, 2, 72);
INSERT INTO `reagent_role_menu_relation` VALUES (2698, 2, 73);
INSERT INTO `reagent_role_menu_relation` VALUES (2699, 2, 74);
INSERT INTO `reagent_role_menu_relation` VALUES (2700, 2, 75);
INSERT INTO `reagent_role_menu_relation` VALUES (2728, 6, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2729, 6, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2730, 6, 4);
INSERT INTO `reagent_role_menu_relation` VALUES (2731, 6, 8);
INSERT INTO `reagent_role_menu_relation` VALUES (2732, 6, 9);
INSERT INTO `reagent_role_menu_relation` VALUES (2733, 6, 10);
INSERT INTO `reagent_role_menu_relation` VALUES (2734, 6, 11);
INSERT INTO `reagent_role_menu_relation` VALUES (2735, 6, 12);
INSERT INTO `reagent_role_menu_relation` VALUES (2736, 6, 14);
INSERT INTO `reagent_role_menu_relation` VALUES (2737, 6, 18);
INSERT INTO `reagent_role_menu_relation` VALUES (2738, 6, 19);
INSERT INTO `reagent_role_menu_relation` VALUES (2739, 6, 20);
INSERT INTO `reagent_role_menu_relation` VALUES (2740, 6, 30);
INSERT INTO `reagent_role_menu_relation` VALUES (2741, 6, 31);
INSERT INTO `reagent_role_menu_relation` VALUES (2742, 6, 34);
INSERT INTO `reagent_role_menu_relation` VALUES (2743, 6, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (2744, 6, 40);
INSERT INTO `reagent_role_menu_relation` VALUES (2745, 6, 41);
INSERT INTO `reagent_role_menu_relation` VALUES (2746, 6, 47);
INSERT INTO `reagent_role_menu_relation` VALUES (2747, 6, 49);
INSERT INTO `reagent_role_menu_relation` VALUES (2748, 6, 52);
INSERT INTO `reagent_role_menu_relation` VALUES (2749, 6, 53);
INSERT INTO `reagent_role_menu_relation` VALUES (2750, 6, 54);
INSERT INTO `reagent_role_menu_relation` VALUES (2751, 6, 56);
INSERT INTO `reagent_role_menu_relation` VALUES (2752, 6, 58);
INSERT INTO `reagent_role_menu_relation` VALUES (2753, 6, 60);
INSERT INTO `reagent_role_menu_relation` VALUES (2754, 6, 61);
INSERT INTO `reagent_role_menu_relation` VALUES (2755, 6, 62);
INSERT INTO `reagent_role_menu_relation` VALUES (2756, 6, 63);
INSERT INTO `reagent_role_menu_relation` VALUES (2757, 6, 69);
INSERT INTO `reagent_role_menu_relation` VALUES (2758, 6, 70);
INSERT INTO `reagent_role_menu_relation` VALUES (2759, 6, 71);
INSERT INTO `reagent_role_menu_relation` VALUES (2760, 6, 72);
INSERT INTO `reagent_role_menu_relation` VALUES (2761, 6, 73);
INSERT INTO `reagent_role_menu_relation` VALUES (2762, 6, 74);
INSERT INTO `reagent_role_menu_relation` VALUES (2763, 6, 75);
INSERT INTO `reagent_role_menu_relation` VALUES (2764, 11, 6);
INSERT INTO `reagent_role_menu_relation` VALUES (2765, 11, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2766, 11, 15);
INSERT INTO `reagent_role_menu_relation` VALUES (2767, 11, 14);
INSERT INTO `reagent_role_menu_relation` VALUES (2768, 11, 17);
INSERT INTO `reagent_role_menu_relation` VALUES (2769, 11, 21);
INSERT INTO `reagent_role_menu_relation` VALUES (2770, 11, 20);
INSERT INTO `reagent_role_menu_relation` VALUES (2771, 11, 22);
INSERT INTO `reagent_role_menu_relation` VALUES (2772, 11, 35);
INSERT INTO `reagent_role_menu_relation` VALUES (2773, 11, 34);
INSERT INTO `reagent_role_menu_relation` VALUES (2774, 11, 36);
INSERT INTO `reagent_role_menu_relation` VALUES (2775, 11, 39);
INSERT INTO `reagent_role_menu_relation` VALUES (2776, 11, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (2777, 11, 40);
INSERT INTO `reagent_role_menu_relation` VALUES (2807, 3, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2808, 3, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2809, 3, 10);
INSERT INTO `reagent_role_menu_relation` VALUES (2810, 3, 14);
INSERT INTO `reagent_role_menu_relation` VALUES (2811, 3, 17);
INSERT INTO `reagent_role_menu_relation` VALUES (2812, 3, 20);
INSERT INTO `reagent_role_menu_relation` VALUES (2813, 3, 22);
INSERT INTO `reagent_role_menu_relation` VALUES (2814, 3, 30);
INSERT INTO `reagent_role_menu_relation` VALUES (2815, 3, 31);
INSERT INTO `reagent_role_menu_relation` VALUES (2816, 3, 34);
INSERT INTO `reagent_role_menu_relation` VALUES (2817, 3, 36);
INSERT INTO `reagent_role_menu_relation` VALUES (2818, 3, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (2819, 3, 40);
INSERT INTO `reagent_role_menu_relation` VALUES (2820, 3, 41);
INSERT INTO `reagent_role_menu_relation` VALUES (2821, 3, 42);
INSERT INTO `reagent_role_menu_relation` VALUES (2822, 3, 56);
INSERT INTO `reagent_role_menu_relation` VALUES (2823, 3, 59);
INSERT INTO `reagent_role_menu_relation` VALUES (2824, 3, 60);
INSERT INTO `reagent_role_menu_relation` VALUES (2825, 3, 61);
INSERT INTO `reagent_role_menu_relation` VALUES (2826, 3, 62);
INSERT INTO `reagent_role_menu_relation` VALUES (2827, 3, 63);
INSERT INTO `reagent_role_menu_relation` VALUES (2828, 3, 67);
INSERT INTO `reagent_role_menu_relation` VALUES (2829, 3, 68);
INSERT INTO `reagent_role_menu_relation` VALUES (2830, 3, 69);
INSERT INTO `reagent_role_menu_relation` VALUES (2831, 3, 73);
INSERT INTO `reagent_role_menu_relation` VALUES (2832, 3, 74);
INSERT INTO `reagent_role_menu_relation` VALUES (2833, 3, 75);

-- ----------------------------
-- Table structure for reagent_role_permission_relation
-- ----------------------------
DROP TABLE IF EXISTS `reagent_role_permission_relation`;
CREATE TABLE `reagent_role_permission_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL,
  `permission_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户角色和权限关系表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色资源关系表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色菜单关系表' ROW_FORMAT = Dynamic;

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
  `reagent_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号规格',
  `reagent_unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_stock
-- ----------------------------
INSERT INTO `reagent_stock` VALUES (1, '123', '3', '388', '针头', '10支', '盒', '化验科', '保护伞', '保护伞', 4, 10.000, '1997', '常温', '10', 20, 10, '2022-04-17 11:24:42', '137', '2022-04-17 11:24:42', '137', NULL, NULL, NULL);
INSERT INTO `reagent_stock` VALUES (6, '1650165881635361', '3', '388', '针头', '10支', '盒', '中心库', '保护伞', '保护伞', 3, 10.000, '1', '常温', '10', 19, 10, '2022-04-17 11:24:42', '137', '2022-04-17 11:24:42', '137', NULL, NULL, NULL);

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
  `specification` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `manufacturer_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `registration_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册证号',
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
  `remain_day` int(20) NULL DEFAULT NULL COMMENT '过期剩余天数',
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
  `device_reg_man` bigint(20) NULL DEFAULT NULL COMMENT '上机人员',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime(0) NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_stock_detail
-- ----------------------------
INSERT INTO `reagent_stock_detail` VALUES (40, '123', '3', '388', '针头', '10支', '保护伞', '12345', '保护伞', '化验科', '盒', '1998', '常温', '2001', '16501658816254842001', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2001', '2', '2022-05-07', 10, 10.000, 10, 19, NULL, '2022-04-17 11:24:42', '1650165881620656', '王家城', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '137', '2022-04-17 11:24:42', '137', '2022-04-17 11:24:42', NULL, NULL, NULL);
INSERT INTO `reagent_stock_detail` VALUES (41, '1650165881635361', '3', '388', '针头', '10支', '保护伞', '12345', '保护伞', '中心库', '盒', '1998', '常温', '2002', '16501658816254842002', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2002', '2', '2022-05-07', 10, 10.000, 10, 19, NULL, '2022-04-17 11:24:42', '1650165881620656', '王家城', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '137', '2022-04-17 11:24:42', '137', '2022-04-17 11:24:42', NULL, NULL, NULL);
INSERT INTO `reagent_stock_detail` VALUES (42, '1650165881635361', '3', '388', '针头', '10支', '保护伞', '12345', '保护伞', '中心库', '盒', '1998', '常温', '2003', '16501658816254842003', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2003', '2', '2022-05-07', 10, 10.000, 10, 19, NULL, '2022-04-17 11:24:42', '1650165881620656', '王家城', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '137', '2022-04-17 11:24:42', '137', '2022-04-17 11:24:42', NULL, NULL, NULL);
INSERT INTO `reagent_stock_detail` VALUES (43, '1650165881635361', '3', '388', '针头', '10支', '保护伞', '12345', '保护伞', '中心库', '盒', '1998', '常温', '2004', '16501658816254842004', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2004', '2', '2022-05-07', 10, 10.000, 10, 19, NULL, '2022-04-17 11:24:42', '1650165881620656', '王家城', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '137', '2022-04-17 11:24:42', '137', '2022-04-17 11:24:42', NULL, NULL, NULL);
INSERT INTO `reagent_stock_detail` VALUES (46, '123', '3', '388', '针头', '10支', '保护伞', '12345', '保护伞', '化验科', '盒', '1998', '常温', '2007', '16501658816254842007', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2007', '2', '2022-05-07', 10, 10.000, 10, 19, NULL, '2022-04-17 11:24:42', '1650165881620656', '王家城', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '137', '2022-04-17 11:24:42', '137', '2022-04-17 11:24:42', NULL, NULL, NULL);
INSERT INTO `reagent_stock_detail` VALUES (47, '123', '3', '388', '针头', '10支', '保护伞', '12345', '保护伞', '化验科', '盒', '1998', '常温', '2008', '16501658816254842008', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2008', '2', '2022-05-07', 10, 10.000, 10, 19, NULL, '2022-04-17 11:24:42', '1650165881620656', '王家城', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '137', '2022-04-17 11:24:42', '137', '2022-04-17 12:19:52', NULL, NULL, NULL);
INSERT INTO `reagent_stock_detail` VALUES (49, '123', '3', '388', '针头', '10支', '保护伞', '12345', '保护伞', '化验科', '盒', '1998', '常温', '2010', '16501658816254842010', '名称: 针头<br/>厂家: 保护伞<br/>供货商: 保护伞<br/>批号: 2<br/>有效期: 2022-05-07<br/>编号: 2010', '2', '2022-05-07', 10, 10.000, 10, 19, NULL, '2022-04-17 11:24:42', '1650165881620656', '王家城', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '137', '2022-04-17 11:24:42', '137', '2022-04-17 12:15:46', NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材库存个体' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '供应商' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reagent_supplier
-- ----------------------------
INSERT INTO `reagent_supplier` VALUES (72, '1', '保护伞生物制药有限公司', '保护伞', '刘嘉诚', '', '15762960990', '', '山东省临沂市河东区', 1, '2022-04-13 21:16:54', NULL, '2022-04-13 21:16:54', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for wx_user
-- ----------------------------
DROP TABLE IF EXISTS `wx_user`;
CREATE TABLE `wx_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) NULL DEFAULT NULL COMMENT 'admin 表中的 id',
  `supplier_id` bigint(20) NULL DEFAULT NULL COMMENT 'supplier 表，供货商联系人的 id',
  `openid` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户的标识，对当前公众号唯一',
  `unionid` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段',
  `nickname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信昵称',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所在城市',
  `language` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户的语言，简体中文为zh_CN',
  `province` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户所在省份',
  `country` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户所在国家',
  `subscribe` tinyint(4) NULL DEFAULT 1 COMMENT '用户是否订阅该公众号标识\n0-未订阅；1-已订阅',
  `subscribe_time` datetime(0) NULL DEFAULT NULL COMMENT '订阅公众号时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '供货商联系人关注公众号后，根据联系人的手机号与微信绑定' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wx_user
-- ----------------------------

-- ----------------------------
-- View structure for in_zx
-- ----------------------------
DROP VIEW IF EXISTS `in_zx`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `in_zx` AS select `rib`.`bill_date` AS `bill_date`,`rib`.`branch` AS `branch`,`rid`.`reagent_name` AS `reagent_name`,`rid`.`total` AS `total` from (`reagent_in_detail` `rid` join `reagent_in_bill` `rib` on((`rib`.`bill_code` = `rid`.`bill_code`))) where ((`rib`.`branch` = '中心库') and (`rib`.`create_type` = '4')) order by `rib`.`bill_date` desc ;

-- ----------------------------
-- View structure for max_code
-- ----------------------------
DROP VIEW IF EXISTS `max_code`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `max_code` AS select max(`reagent_base_info`.`code`) AS `CODE` from `reagent_base_info` ;

-- ----------------------------
-- View structure for out_jy
-- ----------------------------
DROP VIEW IF EXISTS `out_jy`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `out_jy` AS select `jy_in`.`bill_date` AS `bill_date`,`jy_in`.`branch` AS `branch`,`jy_in`.`reagent_name` AS `reagent_name`,`jy_in`.`total` AS `total` from (select `rob`.`bill_date` AS `bill_date`,`ra`.`branch` AS `branch`,`rod`.`reagent_name` AS `reagent_name`,`rod`.`total` AS `total` from ((`reagentdb`.`reagent_out_detail` `rod` join `reagentdb`.`reagent_out_bill` `rob` on((`rob`.`bill_code` = `rod`.`bill_code`))) join `reagentdb`.`reagent_admin` `ra` on((convert(`ra`.`username` using utf8mb4) = `rob`.`application_user`))) where (`rob`.`branch_name` = '中心库') order by `rob`.`bill_date` desc) `jy_in` where (`jy_in`.`branch` = '检验科') ;

-- ----------------------------
-- View structure for out_pcr
-- ----------------------------
DROP VIEW IF EXISTS `out_pcr`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `out_pcr` AS select `pcr_in`.`bill_date` AS `bill_date`,`pcr_in`.`branch` AS `branch`,`pcr_in`.`reagent_name` AS `reagent_name`,`pcr_in`.`total` AS `total` from (select `rob`.`bill_date` AS `bill_date`,`ra`.`branch` AS `branch`,`rod`.`reagent_name` AS `reagent_name`,`rod`.`total` AS `total` from ((`reagentdb`.`reagent_out_detail` `rod` join `reagentdb`.`reagent_out_bill` `rob` on((`rob`.`bill_code` = `rod`.`bill_code`))) join `reagentdb`.`reagent_admin` `ra` on((convert(`ra`.`username` using utf8mb4) = `rob`.`application_user`))) where (`rob`.`branch_name` = '中心库') order by `rob`.`bill_date` desc) `pcr_in` where (`pcr_in`.`branch` = 'PCR实验室') ;

SET FOREIGN_KEY_CHECKS = 1;

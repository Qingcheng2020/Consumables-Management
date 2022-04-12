/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : localhost:3306
 Source Schema         : reagentdb

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 26/02/2022 14:43:38
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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `status` int(11) NULL DEFAULT 1 COMMENT '帐号启用状态：0->禁用；1->启用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 135 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_admin
-- ----------------------------
INSERT INTO `reagent_admin` VALUES (1, 'admin', '$2a$10$26qpRmIYUrXQKgfmuN8riOnwY.C/j8hPDEN1NMz2Hj/qdUzvB0ReK', '', NULL, NULL, '15505550555', 'admin', '', 'admin@163.com', '山东省济南市', '系统管理员', '超级管理员', '2018-10-08 13:32:47', '2022-02-26 14:40:27', 1);
INSERT INTO `reagent_admin` VALUES (134, '管理员', '$2a$10$HceJ6qF/bcHpwSJMrNvh9uByodVPlaK6EWcbKY.nsEaDojeMN1ZgO', '中心库', '', '', NULL, '管理员', NULL, '', NULL, '', '系统管理员', '2022-02-26 14:41:55', '2022-02-26 14:41:55', 1);

-- ----------------------------
-- Table structure for reagent_admin_login_log
-- ----------------------------
DROP TABLE IF EXISTS `reagent_admin_login_log`;
CREATE TABLE `reagent_admin_login_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_agent` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器登录类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5864 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户登录日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_admin_login_log
-- ----------------------------
INSERT INTO `reagent_admin_login_log` VALUES (5862, 1, '2022-02-26 14:40:26', '192.168.0.105', NULL, NULL);
INSERT INTO `reagent_admin_login_log` VALUES (5863, 134, '2022-02-26 14:42:55', '192.168.0.105', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户和权限关系表(除角色中定义的权限以外的加减权限)' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 283 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户和角色关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_admin_role_relation
-- ----------------------------
INSERT INTO `reagent_admin_role_relation` VALUES (184, 1, 1);
INSERT INTO `reagent_admin_role_relation` VALUES (282, 134, 8);

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 372 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '试剂基础情报' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_base_info
-- ----------------------------

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '从这五个非空',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '科室' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_branch
-- ----------------------------
INSERT INTO `reagent_branch` VALUES (19, '1', '中心库', NULL, NULL, '2022-02-26 14:41:29', NULL, '2022-02-26 14:41:29', NULL, NULL, NULL, NULL);

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
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 515 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = DYNAMIC;

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
  `reagent_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂名',
  `supplier_short_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `factory` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试剂单位',
  `reagent_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号规格',
  `price` double(16, 3) NULL DEFAULT NULL COMMENT '单价',
  `reagent_number` bigint(20) NULL DEFAULT NULL COMMENT '申请数量',
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_no`(`collect_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 936 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_collect_detail
-- ----------------------------

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_cop_qualification
-- ----------------------------

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '从这五个非空',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '科室' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `change_type` int(11) NULL DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
  `change_count` int(11) NULL DEFAULT NULL COMMENT '积分改变数量',
  `operate_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人员',
  `operate_note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作备注',
  `source_type` int(11) NULL DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '成长值变化历史记录表' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 979 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单（接收单）' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1466 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单详细' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11483 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单个体' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `change_type` int(11) NULL DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
  `change_count` int(11) NULL DEFAULT NULL COMMENT '积分改变数量',
  `operate_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人员',
  `operate_note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作备注',
  `source_type` int(11) NULL DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '积分变化历史记录表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '积分消费设置' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '注册时间',
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员等级表' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_type` int(11) NULL DEFAULT NULL COMMENT '登录类型：0->PC；1->android;2->ios;3->小程序',
  `province` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员登录记录' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和标签关系表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员与产品分类关系表（用户喜欢的分类）' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员收货地址表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员积分成长规则表' ROW_FORMAT = DYNAMIC;

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
  `recent_order_time` datetime NULL DEFAULT NULL COMMENT '最后一次下订单时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员统计信息' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户标签表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员任务表' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `level` int(11) NULL DEFAULT NULL COMMENT '菜单级数',
  `sort` int(11) NULL DEFAULT NULL COMMENT '菜单排序',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端名称',
  `icon` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端图标',
  `hidden` int(11) NULL DEFAULT NULL COMMENT '前端隐藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台菜单表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `reagent_menu` VALUES (69, 14, '2021-09-13 21:19:20', '库损汇总', 1, 0, 'lossSummary', 'tms-lossSummary', 0);
INSERT INTO `reagent_menu` VALUES (70, 1, '2021-10-12 16:29:51', '资质管理', 0, 0, 'qms', 'qms', 0);
INSERT INTO `reagent_menu` VALUES (71, 70, '2021-10-12 20:43:51', '公司资质', 1, 0, 'copQualification', 'qms-copQualification', 0);
INSERT INTO `reagent_menu` VALUES (72, 70, '2021-10-12 20:43:51', '产品资质', 1, 0, 'prodQualification', 'qms-prodQualification', 0);
INSERT INTO `reagent_menu` VALUES (73, 20, '2021-11-18 11:43:01', '时段试剂出库汇总', 1, 0, 'outSummary', 'outSummary', 0);
INSERT INTO `reagent_menu` VALUES (74, 34, '2021-11-18 13:34:37', '时段试剂入库汇总', 1, 0, 'inSummary', 'wms-inSummary', 0);
INSERT INTO `reagent_menu` VALUES (75, 56, '2021-12-30 21:59:17', '试剂总库存', 1, 0, 'reagentOverall', 'bms-reagentOverall', 0);

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `result` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作结果',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作路径',
  `method` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作方法',
  `ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作IP',
  `opera_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改对象id',
  `opera_params` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2448 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_operation_log
-- ----------------------------
INSERT INTO `reagent_operation_log` VALUES (2445, '科室管理', '新增科室', 1, 'admin', '2022-02-26 14:41:29', '操作成功', 'http://localhost:8080/branch/create', 'POST', '192.168.0.105', '19', '[ReagentBranch [Hash = 2120075653, id=19, branchCode=1, branchName=中心库, tel=null, head=null, createTime=Sat Feb 26 14:41:29 CST 2022, createBy=null, updateTime=Sat Feb 26 14:41:29 CST 2022, updateBy=null, deleteFlag=null, deleteTime=null, deleteBy=null, serialVersionUID=1]]');
INSERT INTO `reagent_operation_log` VALUES (2446, '用户管理', '分配角色', 1, 'admin', '2022-02-26 14:42:21', '操作成功', 'http://localhost:8080/admin/role/update', 'POST', '192.168.0.105', '134', '[134, [8]]');
INSERT INTO `reagent_operation_log` VALUES (2447, '用户管理', '修改用户', 1, 'admin', '2022-02-26 14:42:30', '操作成功', 'http://localhost:8080/admin/update/134', 'POST', '192.168.0.105', '134', '[134, ReagentAdmin [Hash = 1249756402, id=134, username=管理员, password=null, branch=中心库, supplier=, groupName=, phone=null, trueName=管理员, icon=null, email=, address=null, nickName=, note=系统管理员, createTime=Sat Feb 26 14:41:55 CST 2022, loginTime=Sat Feb 26 14:41:55 CST 2022, status=1, serialVersionUID=1]]');

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
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 598 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_no`(`order_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 877 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 776 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单' ROW_FORMAT = DYNAMIC;

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
  `expire_date` datetime NULL DEFAULT NULL COMMENT '有效期',
  `quantity` bigint(20) NULL DEFAULT NULL COMMENT '数量',
  `price` double(20, 3) NULL DEFAULT NULL COMMENT '价格',
  `total` double(20, 3) NULL DEFAULT NULL COMMENT '金额',
  `create_time` datetime NULL DEFAULT NULL COMMENT '出库时间',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库人',
  `application_user` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请人',
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1672 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单详细' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4846 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材出库单个体' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户权限表' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 347 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单（接收单）' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 544 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单详细' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 81844 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材入库申请单个体' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 251 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_prod_qualification
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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `supplier_short_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商名',
  `branch` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科室名',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '制单人',
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '退货单详细' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '退货时间',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货人',
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单详细' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '退货单个体' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_refund_detail_item
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_resource
-- ----------------------------
DROP TABLE IF EXISTS `reagent_resource`;
CREATE TABLE `reagent_resource`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源URL',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `category_id` bigint(20) NULL DEFAULT NULL COMMENT '资源分类ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台资源表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_resource
-- ----------------------------

-- ----------------------------
-- Table structure for reagent_resource_category
-- ----------------------------
DROP TABLE IF EXISTS `reagent_resource_category`;
CREATE TABLE `reagent_resource_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资源分类表' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `status` int(11) NULL DEFAULT 1 COMMENT '启用状态：0->禁用；1->启用',
  `sort` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_role
-- ----------------------------
INSERT INTO `reagent_role` VALUES (1, '超级管理员', '系统维护', 1, '2021-06-24 16:10:11', 1, 0);
INSERT INTO `reagent_role` VALUES (2, '科室库库管员-单级库', '科室库库管员-单级库模式', 0, '2021-06-24 16:10:09', 1, 0);
INSERT INTO `reagent_role` VALUES (3, '科室库库管员-两级库', '科室库库管员-两级库模式', 2, '2021-06-24 16:10:02', 1, 0);
INSERT INTO `reagent_role` VALUES (4, '试剂操作员-单级库', '一级科室库试剂操作员使用', 0, '2021-06-24 16:10:06', 1, 0);
INSERT INTO `reagent_role` VALUES (5, '供货商', '进货', 10, '2021-06-24 16:10:00', 1, 0);
INSERT INTO `reagent_role` VALUES (6, '中心库库管员', '两级库模式下中心库管理员', 1, '2021-05-14 15:41:33', 1, 0);
INSERT INTO `reagent_role` VALUES (7, '系统管理员-单级库', '一级医院系统管理员', 1, '2021-05-15 15:14:36', 1, 0);
INSERT INTO `reagent_role` VALUES (8, '系统管理员-两级库', '二级医院系统管理员', 1, '2021-05-17 14:47:14', 1, 0);
INSERT INTO `reagent_role` VALUES (9, '试剂操作员-两级库', '二级科室库试剂操作员使用', 7, '2021-05-17 21:00:31', 1, 0);
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
) ENGINE = InnoDB AUTO_INCREMENT = 2764 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色菜单关系表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `reagent_role_menu_relation` VALUES (2701, 3, 3);
INSERT INTO `reagent_role_menu_relation` VALUES (2702, 3, 1);
INSERT INTO `reagent_role_menu_relation` VALUES (2703, 3, 10);
INSERT INTO `reagent_role_menu_relation` VALUES (2704, 3, 14);
INSERT INTO `reagent_role_menu_relation` VALUES (2705, 3, 17);
INSERT INTO `reagent_role_menu_relation` VALUES (2706, 3, 20);
INSERT INTO `reagent_role_menu_relation` VALUES (2707, 3, 22);
INSERT INTO `reagent_role_menu_relation` VALUES (2708, 3, 30);
INSERT INTO `reagent_role_menu_relation` VALUES (2709, 3, 31);
INSERT INTO `reagent_role_menu_relation` VALUES (2710, 3, 34);
INSERT INTO `reagent_role_menu_relation` VALUES (2711, 3, 36);
INSERT INTO `reagent_role_menu_relation` VALUES (2712, 3, 38);
INSERT INTO `reagent_role_menu_relation` VALUES (2713, 3, 40);
INSERT INTO `reagent_role_menu_relation` VALUES (2714, 3, 41);
INSERT INTO `reagent_role_menu_relation` VALUES (2715, 3, 42);
INSERT INTO `reagent_role_menu_relation` VALUES (2716, 3, 56);
INSERT INTO `reagent_role_menu_relation` VALUES (2717, 3, 59);
INSERT INTO `reagent_role_menu_relation` VALUES (2718, 3, 60);
INSERT INTO `reagent_role_menu_relation` VALUES (2719, 3, 61);
INSERT INTO `reagent_role_menu_relation` VALUES (2720, 3, 62);
INSERT INTO `reagent_role_menu_relation` VALUES (2721, 3, 63);
INSERT INTO `reagent_role_menu_relation` VALUES (2722, 3, 67);
INSERT INTO `reagent_role_menu_relation` VALUES (2723, 3, 68);
INSERT INTO `reagent_role_menu_relation` VALUES (2724, 3, 69);
INSERT INTO `reagent_role_menu_relation` VALUES (2725, 3, 73);
INSERT INTO `reagent_role_menu_relation` VALUES (2726, 3, 74);
INSERT INTO `reagent_role_menu_relation` VALUES (2727, 3, 75);
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

-- ----------------------------
-- Table structure for reagent_role_permission_relation
-- ----------------------------
DROP TABLE IF EXISTS `reagent_role_permission_relation`;
CREATE TABLE `reagent_role_permission_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL,
  `permission_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户角色和权限关系表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色资源关系表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色菜单关系表' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 661 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材库存表' ROW_FORMAT = DYNAMIC;

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
  `enter_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `enter_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库单号',
  `enter_man` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库人',
  `out_time` datetime NULL DEFAULT NULL COMMENT '出库时间',
  `out_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库单号',
  `out_man` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库人',
  `apply_man` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申领人',
  `use_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
  `device_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备id',
  `device_reg_man` bigint(20) NULL DEFAULT NULL COMMENT '上机人员',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 255756 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材库存表' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试剂耗材库存个体' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint(4) NULL DEFAULT 0 COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime NULL DEFAULT NULL,
  `delete_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '供应商' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reagent_supplier
-- ----------------------------

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
  `subscribe_time` datetime NULL DEFAULT NULL COMMENT '订阅公众号时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '供货商联系人关注公众号后，根据联系人的手机号与微信绑定' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wx_user
-- ----------------------------

-- ----------------------------
-- View structure for in_zx
-- ----------------------------
DROP VIEW IF EXISTS `in_zx`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `in_zx` AS select `rib`.`bill_date` AS `bill_date`,`rib`.`branch` AS `branch`,`rid`.`reagent_name` AS `reagent_name`,`rid`.`total` AS `total` from (`reagent_in_detail` `rid` join `reagent_in_bill` `rib` on((`rib`.`bill_code` = `rid`.`bill_code`))) where ((`rib`.`branch` = '中心库') and (`rib`.`create_type` = '4')) order by `rib`.`bill_date` desc;

-- ----------------------------
-- View structure for max_code
-- ----------------------------
DROP VIEW IF EXISTS `max_code`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `max_code` AS select max(`reagent_base_info`.`code`) AS `CODE` from `reagent_base_info`;

-- ----------------------------
-- View structure for out_jy
-- ----------------------------
DROP VIEW IF EXISTS `out_jy`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `out_jy` AS select `jy_in`.`bill_date` AS `bill_date`,`jy_in`.`branch` AS `branch`,`jy_in`.`reagent_name` AS `reagent_name`,`jy_in`.`total` AS `total` from (select `rob`.`bill_date` AS `bill_date`,`ra`.`branch` AS `branch`,`rod`.`reagent_name` AS `reagent_name`,`rod`.`total` AS `total` from ((`reagentdb`.`reagent_out_detail` `rod` join `reagentdb`.`reagent_out_bill` `rob` on((`rob`.`bill_code` = `rod`.`bill_code`))) join `reagentdb`.`reagent_admin` `ra` on((convert(`ra`.`username` using utf8mb4) = `rob`.`application_user`))) where (`rob`.`branch_name` = '中心库') order by `rob`.`bill_date` desc) `jy_in` where (`jy_in`.`branch` = '检验科');

-- ----------------------------
-- View structure for out_pcr
-- ----------------------------
DROP VIEW IF EXISTS `out_pcr`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `out_pcr` AS select `pcr_in`.`bill_date` AS `bill_date`,`pcr_in`.`branch` AS `branch`,`pcr_in`.`reagent_name` AS `reagent_name`,`pcr_in`.`total` AS `total` from (select `rob`.`bill_date` AS `bill_date`,`ra`.`branch` AS `branch`,`rod`.`reagent_name` AS `reagent_name`,`rod`.`total` AS `total` from ((`reagentdb`.`reagent_out_detail` `rod` join `reagentdb`.`reagent_out_bill` `rob` on((`rob`.`bill_code` = `rod`.`bill_code`))) join `reagentdb`.`reagent_admin` `ra` on((convert(`ra`.`username` using utf8mb4) = `rob`.`application_user`))) where (`rob`.`branch_name` = '中心库') order by `rob`.`bill_date` desc) `pcr_in` where (`pcr_in`.`branch` = 'PCR实验室');

SET FOREIGN_KEY_CHECKS = 1;

-- reagentdb.reagent_admin definition

CREATE TABLE `reagent_admin` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                 `username` varchar(64) DEFAULT NULL,
                                 `password` varchar(64) DEFAULT NULL,
                                 `icon` varchar(500) DEFAULT NULL COMMENT '头像',
                                 `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
                                 `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
                                 `note` varchar(500) DEFAULT NULL COMMENT '备注信息',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
                                 `status` int(1) DEFAULT '1' COMMENT '帐号启用状态：0->禁用；1->启用',
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='后台用户表';


-- reagentdb.reagent_admin_login_log definition

CREATE TABLE `reagent_admin_login_log` (
                                           `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                           `admin_id` bigint(20) DEFAULT NULL,
                                           `create_time` datetime DEFAULT NULL,
                                           `ip` varchar(64) DEFAULT NULL,
                                           `address` varchar(100) DEFAULT NULL,
                                           `user_agent` varchar(100) DEFAULT NULL COMMENT '浏览器登录类型',
                                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=477 DEFAULT CHARSET=utf8 COMMENT='后台用户登录日志表';


-- reagentdb.reagent_admin_permission_relation definition

CREATE TABLE `reagent_admin_permission_relation` (
                                                     `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                     `admin_id` bigint(20) DEFAULT NULL,
                                                     `permission_id` bigint(20) DEFAULT NULL,
                                                     `type` int(1) DEFAULT NULL,
                                                     PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台用户和权限关系表(除角色中定义的权限以外的加减权限)';


-- reagentdb.reagent_admin_role_relation definition

CREATE TABLE `reagent_admin_role_relation` (
                                               `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                               `admin_id` bigint(20) DEFAULT NULL,
                                               `role_id` bigint(20) DEFAULT NULL,
                                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='后台用户和角色关系表';


-- reagentdb.reagent_base_info definition

CREATE TABLE `reagent_base_info` (
                                     `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                     `code` varchar(32) NOT NULL COMMENT '试剂耗材编号',
                                     `name` varchar(50) NOT NULL COMMENT '试剂名称',
                                     `unit` varchar(16) DEFAULT NULL COMMENT '单位',
                                     `specification` varchar(32) DEFAULT NULL COMMENT '规格型号',
                                     `manufacturer_name` varchar(255) DEFAULT NULL COMMENT '生产厂家',
                                     `registration_no` varchar(30) DEFAULT NULL COMMENT '注册证号',
                                     `supplier_id` bigint(20) DEFAULT NULL COMMENT '供货商 ID',
                                     `supplier_short_name` bigint(20) DEFAULT NULL COMMENT '供货商名',
                                     `stock_type` bigint(20) DEFAULT NULL COMMENT '储存温度: 常温，冷藏，冷冻',
                                     `experation_limit` int(11) DEFAULT NULL COMMENT '过期预警时间阈值',
                                     `stock_limit` int(11) DEFAULT NULL COMMENT '低库存预警阈值',
                                     `use_day_limit` int(11) DEFAULT NULL COMMENT '开启有效期限',
                                     `create_time` datetime NOT NULL,
                                     `create_by` varchar(20) NOT NULL,
                                     `update_time` datetime NOT NULL,
                                     `update_by` varchar(20) NOT NULL,
                                     `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                     `delete_time` datetime DEFAULT NULL,
                                     `delete_by` varchar(20) DEFAULT NULL,
                                     PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试剂基础情报';


-- reagentdb.reagent_branch definition

CREATE TABLE `reagent_branch` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                  `branch_code` varchar(20) DEFAULT NULL COMMENT '科室号',
                                  `branch_name` varchar(32) DEFAULT NULL COMMENT '科室名',
                                  `tel` varchar(15) DEFAULT NULL COMMENT '电话',
                                  `head` varchar(16) DEFAULT NULL COMMENT '负责人',
                                  `create_time` datetime NOT NULL,
                                  `create_by` varchar(20) NOT NULL,
                                  `update_time` datetime NOT NULL,
                                  `update_by` varchar(20) NOT NULL,
                                  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                  `delete_time` datetime DEFAULT NULL,
                                  `delete_by` varchar(20) DEFAULT NULL,
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='科室';


-- reagentdb.reagent_growth_change_history definition

CREATE TABLE `reagent_growth_change_history` (
                                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                 `member_id` bigint(20) DEFAULT NULL,
                                                 `create_time` datetime DEFAULT NULL,
                                                 `change_type` int(1) DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
                                                 `change_count` int(11) DEFAULT NULL COMMENT '积分改变数量',
                                                 `operate_man` varchar(100) DEFAULT NULL COMMENT '操作人员',
                                                 `operate_note` varchar(200) DEFAULT NULL COMMENT '操作备注',
                                                 `source_type` int(1) DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
                                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='成长值变化历史记录表';


-- reagentdb.reagent_in_bill definition

CREATE TABLE `reagent_in_bill` (
                                   `id` bigint(20) NOT NULL COMMENT 'id',
                                   `code` varchar(32) NOT NULL COMMENT '入库单编号',
                                   `bill_type` varchar(1) NOT NULL COMMENT '入库单种类：1 预入库单， 2 入库单',
                                   `suppiler_id` bigint(20) NOT NULL COMMENT '供货商ID',
                                   `suppiler_short_name` varchar(20) NOT NULL COMMENT '供货商名',
                                   `bill_date` date NOT NULL COMMENT '单据日期（业务发生的日期，不一定等于单据创建时间，根据单据不同，在此单为入库日期）',
                                   `bill_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '单据状态：0-草稿，1-已入库 ',
                                   `bill_creator` varchar(20) NOT NULL COMMENT '制单人',
                                   `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
                                   `create_time` datetime NOT NULL,
                                   `create_by` varchar(20) NOT NULL,
                                   `update_time` datetime NOT NULL,
                                   `update_by` varchar(20) NOT NULL,
                                   `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                   `delete_time` datetime DEFAULT NULL,
                                   `delete_by` varchar(20) DEFAULT NULL,
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试剂耗材入库申请单（接收单）';


-- reagentdb.reagent_in_detail definition

CREATE TABLE `reagent_in_detail` (
                                     `id` bigint(20) NOT NULL COMMENT 'id',
                                     `in_bill_id` bigint(20) NOT NULL COMMENT '入库单ID',
                                     `reagent_id` bigint(20) NOT NULL COMMENT '试剂ID',
                                     `reagent_name` varchar(50) NOT NULL COMMENT '试剂名称',
                                     `reagent_unit` varchar(16) DEFAULT NULL COMMENT '单位',
                                     `reagent_specification` varchar(32) DEFAULT NULL COMMENT '规格型号',
                                     `price` bigint(20) DEFAULT NULL COMMENT '价格',
                                     `quantity` bigint(20) DEFAULT NULL COMMENT '数量',
                                     `total` bigint(20) DEFAULT NULL COMMENT '金额',
                                     `batch_no` varchar(16) DEFAULT NULL COMMENT '批号',
                                     `expire_date` date NOT NULL COMMENT '保质期',
                                     `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
                                     `create_time` datetime NOT NULL,
                                     `create_by` varchar(20) NOT NULL,
                                     `update_time` datetime NOT NULL,
                                     `update_by` varchar(20) NOT NULL,
                                     `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                     `delete_time` datetime DEFAULT NULL,
                                     `delete_by` varchar(20) DEFAULT NULL,
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试剂耗材入库申请单详细';


-- reagentdb.reagent_in_detail_item definition

CREATE TABLE `reagent_in_detail_item` (
                                          `id` bigint(20) NOT NULL COMMENT 'id',
                                          `in_detail_id` bigint(20) NOT NULL COMMENT '入库单详细ID',
                                          `qr_code` varchar(50) NOT NULL COMMENT '二维码',
                                          `status` varchar(1) NOT NULL COMMENT '状态',
                                          `create_time` datetime NOT NULL,
                                          `create_by` varchar(20) NOT NULL,
                                          `update_time` datetime NOT NULL,
                                          `update_by` varchar(20) NOT NULL,
                                          `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                          `delete_time` datetime DEFAULT NULL,
                                          `delete_by` varchar(20) DEFAULT NULL,
                                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试剂耗材入库申请单个体';


-- reagentdb.reagent_integration_change_history definition

CREATE TABLE `reagent_integration_change_history` (
                                                      `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                      `member_id` bigint(20) DEFAULT NULL,
                                                      `create_time` datetime DEFAULT NULL,
                                                      `change_type` int(1) DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
                                                      `change_count` int(11) DEFAULT NULL COMMENT '积分改变数量',
                                                      `operate_man` varchar(100) DEFAULT NULL COMMENT '操作人员',
                                                      `operate_note` varchar(200) DEFAULT NULL COMMENT '操作备注',
                                                      `source_type` int(1) DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
                                                      PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分变化历史记录表';


-- reagentdb.reagent_integration_consume_setting definition

CREATE TABLE `reagent_integration_consume_setting` (
                                                       `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                       `deduction_per_amount` int(11) DEFAULT NULL COMMENT '每一元需要抵扣的积分数量',
                                                       `max_percent_per_order` int(11) DEFAULT NULL COMMENT '每笔订单最高抵用百分比',
                                                       `use_unit` int(11) DEFAULT NULL COMMENT '每次使用积分最小单位100',
                                                       `coupon_status` int(1) DEFAULT NULL COMMENT '是否可以和优惠券同用；0->不可以；1->可以',
                                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='积分消费设置';


-- reagentdb.reagent_member definition

CREATE TABLE `reagent_member` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                  `member_level_id` bigint(20) DEFAULT NULL,
                                  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
                                  `password` varchar(64) DEFAULT NULL COMMENT '密码',
                                  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
                                  `phone` varchar(64) DEFAULT NULL COMMENT '手机号码',
                                  `status` int(1) DEFAULT NULL COMMENT '帐号启用状态:0->禁用；1->启用',
                                  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
                                  `icon` varchar(500) DEFAULT NULL COMMENT '头像',
                                  `gender` int(1) DEFAULT NULL COMMENT '性别：0->未知；1->男；2->女',
                                  `birthday` date DEFAULT NULL COMMENT '生日',
                                  `city` varchar(64) DEFAULT NULL COMMENT '所做城市',
                                  `job` varchar(100) DEFAULT NULL COMMENT '职业',
                                  `personalized_signature` varchar(200) DEFAULT NULL COMMENT '个性签名',
                                  `source_type` int(1) DEFAULT NULL COMMENT '用户来源',
                                  `integration` int(11) DEFAULT NULL COMMENT '积分',
                                  `growth` int(11) DEFAULT NULL COMMENT '成长值',
                                  `luckey_count` int(11) DEFAULT NULL COMMENT '剩余抽奖次数',
                                  `history_integration` int(11) DEFAULT NULL COMMENT '历史积分数量',
                                  PRIMARY KEY (`id`),
                                  UNIQUE KEY `idx_username` (`username`),
                                  UNIQUE KEY `idx_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='会员表';


-- reagentdb.reagent_member_level definition

CREATE TABLE `reagent_member_level` (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                        `name` varchar(100) DEFAULT NULL,
                                        `growth_point` int(11) DEFAULT NULL,
                                        `default_status` int(1) DEFAULT NULL COMMENT '是否为默认等级：0->不是；1->是',
                                        `free_freight_point` decimal(10,2) DEFAULT NULL COMMENT '免运费标准',
                                        `comment_growth_point` int(11) DEFAULT NULL COMMENT '每次评价获取的成长值',
                                        `priviledge_free_freight` int(1) DEFAULT NULL COMMENT '是否有免邮特权',
                                        `priviledge_sign_in` int(1) DEFAULT NULL COMMENT '是否有签到特权',
                                        `priviledge_comment` int(1) DEFAULT NULL COMMENT '是否有评论获奖励特权',
                                        `priviledge_promotion` int(1) DEFAULT NULL COMMENT '是否有专享活动特权',
                                        `priviledge_member_price` int(1) DEFAULT NULL COMMENT '是否有会员价格特权',
                                        `priviledge_birthday` int(1) DEFAULT NULL COMMENT '是否有生日特权',
                                        `note` varchar(200) DEFAULT NULL,
                                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='会员等级表';


-- reagentdb.reagent_member_login_log definition

CREATE TABLE `reagent_member_login_log` (
                                            `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                            `member_id` bigint(20) DEFAULT NULL,
                                            `create_time` datetime DEFAULT NULL,
                                            `ip` varchar(64) DEFAULT NULL,
                                            `city` varchar(64) DEFAULT NULL,
                                            `login_type` int(1) DEFAULT NULL COMMENT '登录类型：0->PC；1->android;2->ios;3->小程序',
                                            `province` varchar(64) DEFAULT NULL,
                                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员登录记录';


-- reagentdb.reagent_member_member_tag_relation definition

CREATE TABLE `reagent_member_member_tag_relation` (
                                                      `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                      `member_id` bigint(20) DEFAULT NULL,
                                                      `tag_id` bigint(20) DEFAULT NULL,
                                                      PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和标签关系表';


-- reagentdb.reagent_member_product_category_relation definition

CREATE TABLE `reagent_member_product_category_relation` (
                                                            `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                            `member_id` bigint(20) DEFAULT NULL,
                                                            `product_category_id` bigint(20) DEFAULT NULL,
                                                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员与产品分类关系表（用户喜欢的分类）';


-- reagentdb.reagent_member_receive_address definition

CREATE TABLE `reagent_member_receive_address` (
                                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                  `member_id` bigint(20) DEFAULT NULL,
                                                  `name` varchar(100) DEFAULT NULL COMMENT '收货人名称',
                                                  `phone_number` varchar(64) DEFAULT NULL,
                                                  `default_status` int(1) DEFAULT NULL COMMENT '是否为默认',
                                                  `post_code` varchar(100) DEFAULT NULL COMMENT '邮政编码',
                                                  `province` varchar(100) DEFAULT NULL COMMENT '省份/直辖市',
                                                  `city` varchar(100) DEFAULT NULL COMMENT '城市',
                                                  `region` varchar(100) DEFAULT NULL COMMENT '区',
                                                  `detail_address` varchar(128) DEFAULT NULL COMMENT '详细地址(街道)',
                                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='会员收货地址表';


-- reagentdb.reagent_member_rule_setting definition

CREATE TABLE `reagent_member_rule_setting` (
                                               `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                               `continue_sign_day` int(11) DEFAULT NULL COMMENT '连续签到天数',
                                               `continue_sign_point` int(11) DEFAULT NULL COMMENT '连续签到赠送数量',
                                               `consume_per_point` decimal(10,2) DEFAULT NULL COMMENT '每消费多少元获取1个点',
                                               `low_order_amount` decimal(10,2) DEFAULT NULL COMMENT '最低获取点数的订单金额',
                                               `max_point_per_order` int(11) DEFAULT NULL COMMENT '每笔订单最高获取点数',
                                               `type` int(1) DEFAULT NULL COMMENT '类型：0->积分规则；1->成长值规则',
                                               PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员积分成长规则表';


-- reagentdb.reagent_member_statistics_info definition

CREATE TABLE `reagent_member_statistics_info` (
                                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                  `member_id` bigint(20) DEFAULT NULL,
                                                  `consume_amount` decimal(10,2) DEFAULT NULL COMMENT '累计消费金额',
                                                  `order_count` int(11) DEFAULT NULL COMMENT '订单数量',
                                                  `coupon_count` int(11) DEFAULT NULL COMMENT '优惠券数量',
                                                  `comment_count` int(11) DEFAULT NULL COMMENT '评价数',
                                                  `return_order_count` int(11) DEFAULT NULL COMMENT '退货数量',
                                                  `login_count` int(11) DEFAULT NULL COMMENT '登录次数',
                                                  `attend_count` int(11) DEFAULT NULL COMMENT '关注数量',
                                                  `fans_count` int(11) DEFAULT NULL COMMENT '粉丝数量',
                                                  `collect_product_count` int(11) DEFAULT NULL,
                                                  `collect_subject_count` int(11) DEFAULT NULL,
                                                  `collect_topic_count` int(11) DEFAULT NULL,
                                                  `collect_comment_count` int(11) DEFAULT NULL,
                                                  `invite_friend_count` int(11) DEFAULT NULL,
                                                  `recent_order_time` datetime DEFAULT NULL COMMENT '最后一次下订单时间',
                                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员统计信息';


-- reagentdb.reagent_member_tag definition

CREATE TABLE `reagent_member_tag` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                      `name` varchar(100) DEFAULT NULL,
                                      `finish_order_count` int(11) DEFAULT NULL COMMENT '自动打标签完成订单数量',
                                      `finish_order_amount` decimal(10,2) DEFAULT NULL COMMENT '自动打标签完成订单金额',
                                      PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户标签表';


-- reagentdb.reagent_member_task definition

CREATE TABLE `reagent_member_task` (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                       `name` varchar(100) DEFAULT NULL,
                                       `growth` int(11) DEFAULT NULL COMMENT '赠送成长值',
                                       `intergration` int(11) DEFAULT NULL COMMENT '赠送积分',
                                       `type` int(1) DEFAULT NULL COMMENT '任务类型：0->新手任务；1->日常任务',
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员任务表';


-- reagentdb.reagent_menu definition

CREATE TABLE `reagent_menu` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                `parent_id` bigint(20) DEFAULT NULL COMMENT '父级ID',
                                `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                `title` varchar(100) DEFAULT NULL COMMENT '菜单名称',
                                `level` int(4) DEFAULT NULL COMMENT '菜单级数',
                                `sort` int(4) DEFAULT NULL COMMENT '菜单排序',
                                `name` varchar(100) DEFAULT NULL COMMENT '前端名称',
                                `icon` varchar(200) DEFAULT NULL COMMENT '前端图标',
                                `hidden` int(1) DEFAULT NULL COMMENT '前端隐藏',
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='后台菜单表';


-- reagentdb.reagent_operation_log definition

CREATE TABLE `reagent_operation_log` (
                                         `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                         `module` varchar(20) DEFAULT NULL COMMENT '功能区分',
                                         `opera_log` varchar(100) DEFAULT NULL COMMENT '操作内容',
                                         `user_id` bigint(20) DEFAULT NULL COMMENT '操作用户ID',
                                         `user_name` varchar(20) DEFAULT NULL COMMENT '操作用户名',
                                         `create_time` datetime DEFAULT NULL,
                                         PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作日志';


-- reagentdb.reagent_order definition

CREATE TABLE `reagent_order` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                 `order_no` varchar(32) NOT NULL COMMENT '订单号',
                                 `order_day` varchar(50) NOT NULL COMMENT '下单日',
                                 `supplier_id` bigint(16) DEFAULT NULL COMMENT '供货商ID',
                                 `supplier_short_name` varchar(20) DEFAULT NULL COMMENT '供货商名',
                                 `reagent_code` varchar(255) DEFAULT NULL COMMENT '试剂编号',
                                 `reagent_name` varchar(30) DEFAULT NULL COMMENT '试剂名',
                                 `reagent_number` bigint(20) DEFAULT NULL COMMENT '订货数量',
                                 `unit` varchar(16) DEFAULT NULL COMMENT '订货单位',
                                 `price` bigint(20) DEFAULT NULL COMMENT '价格',
                                 `order_describe` varchar(1000) DEFAULT NULL COMMENT '描述',
                                 `create_time` datetime NOT NULL,
                                 `create_by` varchar(20) NOT NULL,
                                 `update_time` datetime NOT NULL,
                                 `update_by` varchar(20) NOT NULL,
                                 `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                 `delete_time` datetime DEFAULT NULL,
                                 `delete_by` varchar(20) DEFAULT NULL,
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单';


-- reagentdb.reagent_out_application definition

CREATE TABLE `reagent_out_application` (
                                           `id` bigint(20) NOT NULL COMMENT 'id',
                                           `reagent_id` bigint(20) NOT NULL COMMENT '试剂ID',
                                           `quantity` bigint(20) NOT NULL COMMENT '申请数量',
                                           `branch_id` bigint(20) NOT NULL COMMENT '申请科室',
                                           `stock_day` date NOT NULL COMMENT '出库预定日',
                                           `application_date` date NOT NULL COMMENT '申请日',
                                           `application_user` bigint(20) NOT NULL COMMENT '申请人',
                                           `create_time` datetime NOT NULL,
                                           `create_by` varchar(20) NOT NULL,
                                           `update_time` datetime NOT NULL,
                                           `update_by` varchar(20) NOT NULL,
                                           `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                           `delete_time` datetime DEFAULT NULL,
                                           `delete_by` varchar(20) DEFAULT NULL,
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='移库申请';


-- reagentdb.reagent_permission definition

CREATE TABLE `reagent_permission` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                      `pid` bigint(20) DEFAULT NULL COMMENT '父级权限id',
                                      `name` varchar(100) DEFAULT NULL COMMENT '名称',
                                      `value` varchar(200) DEFAULT NULL COMMENT '权限值',
                                      `icon` varchar(500) DEFAULT NULL COMMENT '图标',
                                      `type` int(1) DEFAULT NULL COMMENT '权限类型：0->目录；1->菜单；2->按钮（接口绑定权限）',
                                      `uri` varchar(200) DEFAULT NULL COMMENT '前端资源路径',
                                      `status` int(1) DEFAULT NULL COMMENT '启用状态；0->禁用；1->启用',
                                      `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                      `sort` int(11) DEFAULT NULL COMMENT '排序',
                                      PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='后台用户权限表';


-- reagentdb.reagent_resource definition

CREATE TABLE `reagent_resource` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                    `name` varchar(200) DEFAULT NULL COMMENT '资源名称',
                                    `url` varchar(200) DEFAULT NULL COMMENT '资源URL',
                                    `description` varchar(500) DEFAULT NULL COMMENT '描述',
                                    `category_id` bigint(20) DEFAULT NULL COMMENT '资源分类ID',
                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='后台资源表';


-- reagentdb.reagent_resource_category definition

CREATE TABLE `reagent_resource_category` (
                                             `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                             `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                             `name` varchar(200) DEFAULT NULL COMMENT '分类名称',
                                             `sort` int(4) DEFAULT NULL COMMENT '排序',
                                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='资源分类表';


-- reagentdb.reagent_role definition

CREATE TABLE `reagent_role` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                `name` varchar(100) DEFAULT NULL COMMENT '名称',
                                `description` varchar(500) DEFAULT NULL COMMENT '描述',
                                `admin_count` int(11) DEFAULT NULL COMMENT '后台用户数量',
                                `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                `status` int(1) DEFAULT '1' COMMENT '启用状态：0->禁用；1->启用',
                                `sort` int(11) DEFAULT '0',
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='后台用户角色表';


-- reagentdb.reagent_role_menu_relation definition

CREATE TABLE `reagent_role_menu_relation` (
                                              `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                              `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
                                              `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
                                              PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COMMENT='后台角色菜单关系表';


-- reagentdb.reagent_role_permission_relation definition

CREATE TABLE `reagent_role_permission_relation` (
                                                    `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                    `role_id` bigint(20) DEFAULT NULL,
                                                    `permission_id` bigint(20) DEFAULT NULL,
                                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='后台用户角色和权限关系表';


-- reagentdb.reagent_role_resource_relation definition

CREATE TABLE `reagent_role_resource_relation` (
                                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
                                                  `resource_id` bigint(20) DEFAULT NULL COMMENT '资源ID',
                                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8 COMMENT='后台角色资源关系表';


-- reagentdb.reagent_stock definition

CREATE TABLE `reagent_stock` (
                                 `id` bigint(20) NOT NULL COMMENT 'id',
                                 `branch_id` bigint(20) DEFAULT NULL COMMENT '科室ID ',
                                 `reagent_id` bigint(20) NOT NULL COMMENT '试剂耗材ID',
                                 `batch_no` varchar(32) NOT NULL COMMENT '系统批号',
                                 `expire_date` date NOT NULL COMMENT '到期日期',
                                 `quantity` decimal(20,4) NOT NULL COMMENT '库存数量',
                                 `create_time` datetime NOT NULL,
                                 `create_by` varchar(20) NOT NULL,
                                 `update_time` datetime NOT NULL,
                                 `update_by` varchar(20) NOT NULL,
                                 `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                 `delete_time` datetime DEFAULT NULL,
                                 `delete_by` varchar(20) DEFAULT NULL,
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试剂耗材库存表';


-- reagentdb.reagent_stock_item definition

CREATE TABLE `reagent_stock_item` (
                                      `id` bigint(20) NOT NULL COMMENT 'id',
                                      `stock_id` bigint(20) NOT NULL COMMENT '库存ID',
                                      `qr_code` varchar(50) NOT NULL COMMENT '二维码',
                                      `status` varchar(1) NOT NULL COMMENT '状态 1:在库，2:出库，9:损失',
                                      `create_time` datetime NOT NULL,
                                      `create_by` varchar(20) NOT NULL,
                                      `update_time` datetime NOT NULL,
                                      `update_by` varchar(20) NOT NULL,
                                      `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                      `delete_time` datetime DEFAULT NULL,
                                      `delete_by` varchar(20) DEFAULT NULL,
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试剂耗材库存个体';


-- reagentdb.reagent_supplier definition

CREATE TABLE `reagent_supplier` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                    `supplier_code` varchar(20) DEFAULT NULL COMMENT '供货商ID',
                                    `supplier_name` varchar(100) DEFAULT NULL COMMENT '供货商正式名',
                                    `supplier_short_name` varchar(20) DEFAULT NULL COMMENT '供货商简名',
                                    `contacts` varchar(20) DEFAULT NULL COMMENT '联系人',
                                    `contacts_tel` varchar(15) DEFAULT NULL COMMENT '联系人电话',
                                    `contacts_phone` varchar(15) DEFAULT NULL COMMENT '联系人手机',
                                    `contacts_wechat` varchar(30) DEFAULT NULL COMMENT '联系人微信',
                                    `supplier_address` varchar(150) DEFAULT NULL COMMENT '公司地址',
                                    `status` int(1) DEFAULT NULL COMMENT '公司状态',
                                    `create_time` datetime NOT NULL,
                                    `create_by` varchar(20) NOT NULL,
                                    `update_time` datetime NOT NULL,
                                    `update_by` varchar(20) NOT NULL,
                                    `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                    `delete_time` datetime DEFAULT NULL,
                                    `delete_by` varchar(20) DEFAULT NULL,
                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商';
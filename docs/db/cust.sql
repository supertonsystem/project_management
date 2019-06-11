-- ---
-- Table 'cust_person'
-- 客户基本信息
-- ---

DROP TABLE IF EXISTS `cust_person`;

CREATE TABLE `cust_person` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `register` BIGINT(20)  DEFAULT NULL COMMENT '创建人',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `name` VARCHAR(50) DEFAULT 'NULL' COMMENT '客户名称',
  `sex` TINYINT(2)  DEFAULT 0 COMMENT '客户性别',
  `post` VARCHAR(30)  DEFAULT NULL COMMENT '客户职位',
  `company_name` VARCHAR(100)  DEFAULT NULL COMMENT '公司名称',
  `company_nature` VARCHAR(100)  DEFAULT NULL COMMENT '公司性质',
  `industry` VARCHAR(100)  DEFAULT NULL COMMENT '公司行业',
  `company_scale` VARCHAR(100)  DEFAULT NULL COMMENT '公司规模',
  `company_address` VARCHAR(100)  DEFAULT NULL COMMENT '公司地址',
  `phone` VARCHAR(20)  DEFAULT NULL COMMENT '联系电话',
  `home_address` VARCHAR(100)  DEFAULT NULL COMMENT '家庭地址',
  `mobile` VARCHAR(30)  DEFAULT NULL COMMENT '手机号码',
  `email` VARCHAR(30)  DEFAULT NULL COMMENT '电子邮箱',
  `fax` VARCHAR(30)  DEFAULT NULL COMMENT '传真',
  `company_website` VARCHAR(100)  DEFAULT NULL COMMENT '公司网站',
  `source` VARCHAR(30)  DEFAULT NULL COMMENT '客户来源',
  `credit` VARCHAR(30)  DEFAULT NULL COMMENT '客户信用',
  `remark` VARCHAR(255)  DEFAULT NULL COMMENT '备注',
  `visit_time` Date DEFAULT null COMMENT '拜访时间',
  `icon` VARCHAR(50)  DEFAULT NULL COMMENT '客户头像',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'cust_project'
-- 项目信息
-- ---

DROP TABLE IF EXISTS `cust_project`;

CREATE TABLE `cust_project` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `register` BIGINT(20) NOT NULL COMMENT '创建人',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `number` VARCHAR(30)  DEFAULT NULL COMMENT '项目编号',
  `name` VARCHAR(30)  DEFAULT NULL COMMENT '项目名称',
  `company_name` VARCHAR(50)  DEFAULT NULL COMMENT '公司名称',
  `area` VARCHAR(10)  DEFAULT NULL COMMENT '区域',
  `province` VARCHAR(10)  DEFAULT NULL COMMENT '省份',
  `address` VARCHAR(100)  DEFAULT NULL COMMENT '地址',
  `start_time` DATE  DEFAULT NULL COMMENT '开工时间',
  `end_time` DATE  DEFAULT NULL COMMENT '完工时间',
  `period` VARCHAR(20)  DEFAULT NULL COMMENT '周期',
  `owner_department` VARCHAR(10)  DEFAULT NULL COMMENT '甲方部门',
  `owner` VARCHAR(10)  DEFAULT NULL COMMENT '甲方负责人',
  `department` BIGINT(20)  DEFAULT NULL COMMENT '己方部门',
  `pm` BIGINT(20)  DEFAULT NULL COMMENT '己方项目经理',
  PRIMARY KEY (`id`)  USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'cust_project_relation'
-- 项目与客户关联
-- ---
DROP TABLE IF EXISTS `cust_project_relation`;

CREATE TABLE `cust_project_relation` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `person_id` BIGINT(20) NOT NULL COMMENT '客户id',
  `project_id` BIGINT(20) NOT NULL COMMENT '项目id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'cust_contact'
-- 联系信息
-- ---

DROP TABLE IF EXISTS `cust_contact`;

CREATE TABLE `cust_contact` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `register` BIGINT(20) NOT NULL COMMENT '创建人',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `meet_time` DATE  DEFAULT NULL COMMENT '见面时间',
  `meet_address` VARCHAR(100)  DEFAULT NULL COMMENT '见面地址',
  `activity_mode` VARCHAR(100)  DEFAULT NULL COMMENT '方式',
  `expenses` DECIMAL(19,2)  DEFAULT NULL COMMENT '开销费用',
  `participant` VARCHAR(100)  DEFAULT NULL COMMENT '参与人员',
  `people_num` int(4) DEFAULT NULL COMMENT '人数',
  `chat` VARCHAR(252) DEFAULT NULL COMMENT '聊天记录',
  `remark` VARCHAR(255) DEFAULT NULL COMMENT '备注',
  `person_id` BIGINT(20)  DEFAULT NULL COMMENT '关联客户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'cust_person_relation'
-- 客户之间关联
-- ---

DROP TABLE IF EXISTS `cust_person_relation`;

CREATE TABLE `cust_person_relation` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `source_id` BIGINT(20) NOT NULL COMMENT '来源客户id',
  `dest_id` BIGINT(20) NOT NULL COMMENT '目标客户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'gift_repertory'
-- 礼品库存
-- ---

DROP TABLE IF EXISTS `gift_repertory`;

CREATE TABLE `gift_repertory` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `register` BIGINT(20) NOT NULL COMMENT '创建人',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `name` VARCHAR(30) DEFAULT NULL COMMENT '礼品名称',
  `type_id` INT(10) DEFAULT NULL COMMENT '礼品类别id',
  `sum` BIGINT(20)  DEFAULT NULL COMMENT '礼品数量',
  `repertory` INT  DEFAULT NULL COMMENT '礼品库存',
  `amount` DECIMAL(10,2)  DEFAULT NULL COMMENT '礼品金额',
  `unit` DECIMAL(10,2)  DEFAULT NULL COMMENT '礼品单价',
  `description` VARCHAR(100)  DEFAULT NULL COMMENT '礼品说明',
  `remark` VARCHAR(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'gift_type'
-- 礼品类别
-- ---

DROP TABLE IF EXISTS `gift_type`;

CREATE TABLE `gift_type` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL COMMENT '类别',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'gift_consume'
-- 礼品领用
-- ---

DROP TABLE IF EXISTS `gift_consume`;

CREATE TABLE `gift_consume` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `register` BIGINT(20) NOT NULL COMMENT '创建人',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `title` VARCHAR(100)  DEFAULT NULL COMMENT '标题',
  `num` INT  DEFAULT NULL COMMENT '数量',
  `amount` DECIMAL(10,2)  DEFAULT NULL COMMENT '金额',
  `back_num` INT  DEFAULT NULL COMMENT '退回数量',
  `back_money` DECIMAL(10,2)  DEFAULT NULL COMMENT '退回金额',
  `description` VARCHAR(100)  DEFAULT NULL COMMENT '描述',
  `status` TINYINT  DEFAULT 0 COMMENT '状态,登记，待确认，已完成',
  PRIMARY KEY (`id`) USING BTREE
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'gift_consume_detail'
-- 礼品送礼记录
-- ---

DROP TABLE IF EXISTS `gift_consume_detail`;

CREATE TABLE `gift_consume_detail` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `register` BIGINT(20) NOT NULL COMMENT '创建人',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `consume_id` BIGINT(20)  DEFAULT NULL COMMENT '礼品领用主Id',
  `person_id` BIGINT(20)  DEFAULT NULL COMMENT '客户id',
  `project_id` BIGINT(20)  DEFAULT NULL COMMENT '项目Id',
  `repertory_id` BIGINT(20)  DEFAULT NULL COMMENT '礼品Id',
  `description` VARCHAR(255)  DEFAULT NULL COMMENT '描述',
  `num` INT  DEFAULT NULL COMMENT '数量',
  `amount` DECIMAL(10,2) DEFAULT NULL COMMENT '金额',
  `send_time` DATE  DEFAULT NULL COMMENT '送礼时间',
  `send_site` VARCHAR(100)  DEFAULT NULL COMMENT '送礼地点',
  `status` TINYINT  DEFAULT 0 COMMENT '状态，已送，退回，待送',
  `draw_status` TINYINT  DEFAULT 0 COMMENT '领用状态，待领用，已领用',
  `remark` VARCHAR(100)  DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
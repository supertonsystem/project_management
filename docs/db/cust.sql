-- ---
-- Table 'cust_info'
-- 客户基本信息
-- ---

DROP TABLE IF EXISTS `cust_person`;

CREATE TABLE `cust_person` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `register` BIGINT(20)  DEFAULT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `name` VARCHAR(50) DEFAULT 'NULL',
  `sex` TINYINT(2)  DEFAULT 0,
  `post` VARCHAR(30)  DEFAULT NULL,
  `company_name` VARCHAR(100)  DEFAULT NULL,
  `company_nature` VARCHAR(100)  DEFAULT NULL,
  `industry` VARCHAR(100)  DEFAULT NULL,
  `company_scale` VARCHAR(100)  DEFAULT NULL,
  `company_address` VARCHAR(100)  DEFAULT NULL,
  `phone` VARCHAR(20)  DEFAULT NULL,
  `home_address` VARCHAR(100)  DEFAULT NULL,
  `mobile` VARCHAR(30)  DEFAULT NULL,
  `email` VARCHAR(30)  DEFAULT NULL,
  `fax` VARCHAR(30)  DEFAULT NULL,
  `company_website` VARCHAR(100)  DEFAULT NULL,
  `source` VARCHAR(30)  DEFAULT NULL,
  `credit` VARCHAR(30)  DEFAULT NULL,
  `remark` VARCHAR(255)  DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'proj_info'
-- 项目信息
-- ---

DROP TABLE IF EXISTS `cust_project`;

CREATE TABLE `cust_project` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `register` BIGINT(20) NOT NULL ,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
   `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `number` VARCHAR(30)  DEFAULT NULL,
  `name` VARCHAR(30)  DEFAULT NULL,
  `company_name` VARCHAR(50)  DEFAULT NULL,
  `area` VARCHAR(10)  DEFAULT NULL,
  `province` VARCHAR(10)  DEFAULT NULL,
  `address` VARCHAR(100)  DEFAULT NULL,
  `start_time` DATE  DEFAULT NULL,
  `end_time` DATE  DEFAULT NULL,
  `period` VARCHAR(20)  DEFAULT NULL,
  `owner_department` VARCHAR(10)  DEFAULT NULL,
  `owner` VARCHAR(10)  DEFAULT NULL,
  `department` BIGINT(20)  DEFAULT NULL,
  `pm` BIGINT(20)  DEFAULT NULL,
  `person_id` BIGINT(20)  DEFAULT NULL,
  PRIMARY KEY (`id`)  USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'cust_contact'
-- 客户联系
-- ---

DROP TABLE IF EXISTS `cust_contact`;

CREATE TABLE `cust_contact` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `register` BIGINT(20) NOT NULL ,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
   `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `meet_time` DATETIME  DEFAULT NULL,
  `meet_address` VARCHAR(30)  DEFAULT NULL,
  `expenses` DECIMAL(19,2)  DEFAULT NULL,
  `participant` VARCHAR(100)  DEFAULT NULL,
  `num_people` int(4) DEFAULT NULL,
  `Chat` VARCHAR(252) DEFAULT NULL,
  `remark` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'cust_contact_relation'
-- 联系与客户关系表
-- ---

DROP TABLE IF EXISTS `cust_contact_relation`;

CREATE TABLE `cust_contact_relation` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `contact_id` BIGINT(20) NOT NULL,
  `person_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'cust_info_relation'
-- 客户之间关联
-- ---

DROP TABLE IF EXISTS `cust_person_relation`;

CREATE TABLE `cust_person_relation` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `source_id` BIGINT(20) NOT NULL,
  `dest_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'gift_repertory'
-- 礼品库存
-- ---

DROP TABLE IF EXISTS `gift_repertory`;

CREATE TABLE `gift_repertory` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `register` BIGINT(20) NOT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
   `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `name` VARCHAR(30) DEFAULT NULL,
  `type` SMALLINT DEFAULT NULL,
  `total` INT  DEFAULT NULL,
  `repertory` INT  DEFAULT NULL,
  `total_money` DECIMAL(10,2)  DEFAULT NULL,
  `unit_money` DECIMAL(10,2)  DEFAULT NULL,
  `explain` VARCHAR(100)  DEFAULT NULL,
  `remark` VARCHAR(100)  DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'gift_type'
-- 礼品类别
-- ---

DROP TABLE IF EXISTS `gift_type`;

CREATE TABLE `gift_type` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `type` INT(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'gift_consume'
-- 礼品领用
-- ---

DROP TABLE IF EXISTS `gift_consume`;

CREATE TABLE `gift_consume` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `apply_time` DATETIME  DEFAULT NULL,
  `apply_userId` BIGINT(20)  DEFAULT NULL,
  `gift_id` BIGINT  DEFAULT NULL,
  `num` INT  DEFAULT NULL,
  `gift_money` DECIMAL(10,2)  DEFAULT NULL,
  `back_num` INT  DEFAULT NULL,
  `back_money` DECIMAL(10,2)  DEFAULT NULL,
  `explain` VARCHAR(100)  DEFAULT NULL,
  `remark` VARCHAR(100)  DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Table 'gift_consume_detail'
-- 礼品送礼记录
-- ---

DROP TABLE IF EXISTS `gift_consume_detail`;

CREATE TABLE `gift_consume_detail` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `consume_id` BIGINT(20)  DEFAULT NULL,
  `cust_id` BIGINT(20)  DEFAULT NULL,
  `proj_id` BIGINT(20)  DEFAULT NULL,
  `explain` VARCHAR(255)  DEFAULT NULL,
  `num` INT  DEFAULT NULL,
  `money` INTEGER  DEFAULT NULL,
  `send_time` DATETIME  DEFAULT NULL,
  `send_site` VARCHAR(100)  DEFAULT NULL,
  `status` TINYINT  DEFAULT NULL,
  `remark` VARCHAR(100)  DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
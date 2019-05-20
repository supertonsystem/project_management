/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50624
Source Host           : 127.0.0.1:3306
Source Database       : shiro

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2018-05-17 13:56:52
*/

-- ----------------------------
-- Records of work_projectmgt
-- ----------------------------
DROP TABLE IF EXISTS `work_projectmgt`;
CREATE TABLE `work_projectmgt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `number` varchar(100) DEFAULT NULL COMMENT '编号',
  `register_userId` bigint(20) unsigned NOT NULL COMMENT '登记人Id',
  `owner_depId` bigint(20) unsigned NOT NULL COMMENT '责任部门Id',
  `owner_userId` bigint(20)  COMMENT '责任人Id',
  `check_depId` bigint(20) unsigned NOT NULL COMMENT '核实部门Id',
  `content` varchar(255) DEFAULT NULL COMMENT '任务内容',
  `planned_time` date DEFAULT NULL COMMENT '计划时间',
  `progress` tinyint DEFAULT '0' COMMENT '实际进度',
  `finish_time` date DEFAULT NULL COMMENT '完成时间',
  `price` DECIMAL(19,2)  DEFAULT NULL COMMENT '奖金',
  `delay_reason` varchar(255) DEFAULT NULL COMMENT '延期原因',
  `office_opinion` varchar(255) DEFAULT NULL COMMENT '办公室意见',
  `gm_opinion` varchar(255) DEFAULT NULL COMMENT '总经理意见',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint DEFAULT '0' COMMENT '状态',
  `process_instance_id` varchar(255) DEFAULT NULL  COMMENT '流程实例Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
-- ----------------------------
-- Records of work_business_relation
-- 流程关联表
-- ----------------------------
-- DROP TABLE IF EXISTS `work_business_relation`;
-- CREATE TABLE `work_business_relation` (
--   `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
--   `business_id` bigint(20) unsigned NOT NULL COMMENT '业务id',
--   `process_instance_id` bigint(20) unsigned NOT NULL COMMENT '流程实例Id',
--   PRIMARY KEY (`id`) USING BTREE
-- ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
-- ----------------------------
-- Records of work_projectmgt_processlog
-- 流程运转log
-- ----------------------------
-- DROP TABLE IF EXISTS `work_projectmgt_processlog`;
-- CREATE TABLE `work_projectmgt_processlog` (
--   `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
--   `work_program_id` bigint(20) unsigned NOT NULL COMMENT '本地项目id',
--   `process_instance_id` bigint(20) unsigned NOT NULL COMMENT '流程实例Id',
--   `process_operatorId` bigint(20) unsigned NOT NULL COMMENT '执行用户Id',
--   `process_operator` varchar(100) DEFAULT NULL COMMENT '执行操作',
--   `process_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '执行时间',
--   PRIMARY KEY (`id`) USING BTREE
-- ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_notify
-- 消息通知表
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_notify`;
-- CREATE TABLE `sys_notify` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
--   `sender_id` bigint(20) NOT NULL COMMENT '发送者用户ID',
--   `reciver_id` bigint(20) NOT NULL COMMENT '接受者用户ID',
--   `type` varchar(50) NOT NULL COMMENT '消息类型:announcement公告/remind提醒/message私信',
--   `is_read` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已读,0未读,1已读',
--   `content` varchar(1000) NOT NULL COMMENT '消息内容,最长长度不允许超过1000',
--   `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间:按当前时间自动创建',
--   PRIMARY KEY (`id`) USING BTREE
-- ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;






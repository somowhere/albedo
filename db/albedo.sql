/*
 Navicat Premium Data Transfer

 Source Server         : albedo-mysql
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : albedo

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 01/10/2019 18:00:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_scheme
-- ----------------------------
DROP TABLE IF EXISTS `gen_scheme`;
CREATE TABLE `gen_scheme`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类',
  `view_type` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视图类型 0  普通表格 1  表格采用ajax刷新',
  `package_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成表编号',
  `version` int(11) NULL DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '生成方案' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联父表外键',
  `version` int(11) NULL DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `gen_table_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `comments` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述备注',
  `jdbc_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` bit(1) NULL DEFAULT NULL COMMENT '是否主键',
  `is_unique` bit(1) NULL DEFAULT NULL COMMENT '是否唯一（1：是；0：否）',
  `is_null` bit(1) NULL DEFAULT NULL COMMENT '是否可为空',
  `is_insert` bit(1) NULL DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` bit(1) NULL DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` bit(1) NULL DEFAULT NULL COMMENT '是否列表字段',
  `is_query` bit(1) NULL DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10, 0) NULL DEFAULT NULL COMMENT '排序（升序）',
  `version` int(11) NULL DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `gen_table_column_table_id`(`gen_table_id`) USING BTREE,
  INDEX `gen_table_column_name`(`name`) USING BTREE,
  INDEX `gen_table_column_sort`(`sort`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gen_table_fk
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_fk`;
CREATE TABLE `gen_table_fk`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键',
  `is_unique` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否唯一（1：是；0：否）',
  `is_null` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10, 0) NULL DEFAULT NULL COMMENT '排序（升序）',
  `version` int(11) NULL DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `gen_table_column_table_id`(`gen_table_id`) USING BTREE,
  INDEX `gen_table_column_name`(`name`) USING BTREE,
  INDEX `gen_table_column_sort`(`sort`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `blob_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `int_prop_1` int(11) NULL DEFAULT NULL,
  `int_prop_2` int(11) NULL DEFAULT NULL,
  `long_prop_1` bigint(20) NULL DEFAULT NULL,
  `long_prop_2` bigint(20) NULL DEFAULT NULL,
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL,
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL,
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `next_fire_time` bigint(13) NULL DEFAULT NULL,
  `prev_fire_time` bigint(13) NULL DEFAULT NULL,
  `priority` int(11) NULL DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) NULL DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `misfire_instr` smallint(2) NULL DEFAULT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_audit_event
-- ----------------------------
DROP TABLE IF EXISTS `sys_audit_event`;
CREATE TABLE `sys_audit_event`  (
  `event_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `principal` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `event_date` timestamp(0) NULL DEFAULT NULL,
  `event_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`event_id`) USING BTREE,
  INDEX `idx_persistent_audit_event`(`principal`, `event_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 660 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_audit_event
-- ----------------------------
INSERT INTO `sys_audit_event` VALUES (648, 'admin', '2019-08-05 09:28:50', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (649, 'admin', '2019-08-05 09:55:26', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (650, 'admin', '2019-08-05 10:31:01', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (651, 'admin', '2019-08-05 10:35:06', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (652, 'admin', '2019-08-05 10:37:22', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (653, 'admin', '2019-08-05 10:42:48', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (654, 'admin', '2019-08-05 11:32:23', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (655, 'admin', '2019-08-05 11:34:41', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (656, 'admin', '2019-08-05 11:34:41', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (657, 'admin', '2019-08-05 11:38:32', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (658, 'admin', '2019-08-05 11:40:23', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (659, 'admin', '2019-08-05 12:43:34', 'AUTHENTICATION_SUCCESS');
INSERT INTO `sys_audit_event` VALUES (660, 'admin', '2019-08-05 13:22:21', 'AUTHENTICATION_SUCCESS');

-- ----------------------------
-- Table structure for sys_audit_event_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_audit_event_data`;
CREATE TABLE `sys_audit_event_data`  (
  `event_id` bigint(20) NOT NULL,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`event_id`, `name`) USING BTREE,
  INDEX `idx_persistent_audit_evt_data`(`event_id`) USING BTREE,
  CONSTRAINT `sys_audit_event_data_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `sys_audit_event` (`event_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_audit_event_data
-- ----------------------------
INSERT INTO `sys_audit_event_data` VALUES (648, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (648, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (649, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (649, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (650, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (650, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (651, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (651, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (652, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (652, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (653, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (653, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (654, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (654, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (655, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (655, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (656, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (656, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (657, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (657, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (658, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (658, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (659, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (659, 'sessionId', NULL);
INSERT INTO `sys_audit_event_data` VALUES (660, 'remoteAddress', '127.0.0.1');
INSERT INTO `sys_audit_event_data` VALUES (660, 'sessionId', NULL);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `leaf` bit(1) NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `version` int(11) NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '-1', NULL, '山东农信', NULL, b'0', '', '2018-01-22 19:00:23.000', NULL, '2019-07-04 16:57:18.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('10', '8', NULL, '院校沙县', NULL, b'0', '', '2018-12-10 21:19:26.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('2', '-1', NULL, '沙县国际', NULL, b'0', '', '2018-01-22 19:00:38.000', NULL, '2019-07-04 16:57:22.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('3', '1', NULL, '潍坊农信', NULL, b'0', '', '2018-01-22 19:00:44.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('4', '3', NULL, '高新农信', 30, b'0', '', '2018-01-22 19:00:52.000', '1', '2019-07-14 09:02:57.000', 6, '', '0');
INSERT INTO `sys_dept` VALUES ('5', '4', NULL, '院校农信', 30, b'0', '', '2018-01-22 19:00:57.000', '1', '2019-07-14 09:10:44.000', 1, '', '0');
INSERT INTO `sys_dept` VALUES ('5f86e2a82b040b1f618aefc62f403024', '5', '5,', '11', 1, b'1', '1', '2019-07-14 09:10:45.000', '1', '2019-07-14 09:10:57.000', 0, NULL, '1');
INSERT INTO `sys_dept` VALUES ('6', '5', NULL, '潍院农信', NULL, b'0', '', '2018-01-22 19:01:06.000', NULL, '2019-01-09 10:58:18.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('7', '2', NULL, '山东沙县', NULL, b'0', '', '2018-01-22 19:01:57.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('8', '7', NULL, '潍坊沙县', NULL, b'0', '', '2018-01-22 19:02:03.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('9', '8', NULL, '高新沙县', NULL, b'0', '', '2018-01-22 19:02:14.000', NULL, '2018-09-13 01:46:44.000', 0, '', '0');

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation`  (
  `ancestor` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '祖先节点',
  `descendant` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '后代节点',
  PRIMARY KEY (`ancestor`, `descendant`) USING BTREE,
  INDEX `idx1`(`ancestor`) USING BTREE,
  INDEX `idx2`(`descendant`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = '部门关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
INSERT INTO `sys_dept_relation` VALUES ('1', '1');
INSERT INTO `sys_dept_relation` VALUES ('1', '3');
INSERT INTO `sys_dept_relation` VALUES ('1', '4');
INSERT INTO `sys_dept_relation` VALUES ('1', '5');
INSERT INTO `sys_dept_relation` VALUES ('10', '10');
INSERT INTO `sys_dept_relation` VALUES ('11', '11');
INSERT INTO `sys_dept_relation` VALUES ('2', '11');
INSERT INTO `sys_dept_relation` VALUES ('2', '2');
INSERT INTO `sys_dept_relation` VALUES ('2', '7');
INSERT INTO `sys_dept_relation` VALUES ('2', '8');
INSERT INTO `sys_dept_relation` VALUES ('3', '3');
INSERT INTO `sys_dept_relation` VALUES ('3', '4');
INSERT INTO `sys_dept_relation` VALUES ('3', '5');
INSERT INTO `sys_dept_relation` VALUES ('4', '4');
INSERT INTO `sys_dept_relation` VALUES ('4', '5');
INSERT INTO `sys_dept_relation` VALUES ('5', '5');
INSERT INTO `sys_dept_relation` VALUES ('7', '11');
INSERT INTO `sys_dept_relation` VALUES ('7', '7');
INSERT INTO `sys_dept_relation` VALUES ('7', '8');
INSERT INTO `sys_dept_relation` VALUES ('8', '11');
INSERT INTO `sys_dept_relation` VALUES ('8', '8');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名',
  `val` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据值',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
  `sort` int(10) NOT NULL COMMENT '排序（升序）',
  `show` bit(1) NULL DEFAULT NULL COMMENT '是否显示1 是0否',
  `leaf` bit(1) NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  `version` int(11) NOT NULL DEFAULT 0,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_dict_value`(`val`) USING BTREE,
  INDEX `sys_dict_label`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('05d01334ecdbe94b856038a32a42512b', '任务分组', NULL, 'sys_job_group', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-08-15 16:33:54.745', '1', '2019-08-15 16:34:47.136', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0b2420638683f1eec41242beb9912069', '在线', 'on_line', 'sys_online_status_on_line', 'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30, b'1', b'1', NULL, '1', '2019-08-11 11:17:28.210', '1', '2019-08-11 11:17:28.210', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0da02abef85f0c0b4350eaeefb4ca78d', '仅本人数据', '4', 'sys_data_scope_4', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 40, b'1', b'1', NULL, '1', '2019-07-14 06:00:03.000', '1', '2019-08-09 11:26:04.724', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0ef7242f2bb88fdbdcbc56e7a879efb0', '其他', '0', 'sys_business_type_0', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 10, b'1', b'1', NULL, '1', '2019-08-07 16:49:39.000', '1', '2019-08-09 11:26:04.726', 3, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0fdd548394368b4969136f32c435fd98', '按钮', '1', 'sys_menu_type_1', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 20, b'1', b'1', NULL, '1', '2019-07-14 06:04:44.000', '1', '2019-08-09 11:26:04.726', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('1', '数据字典', '', 'base', '-1', NULL, 1, b'1', b'0', '', '1', '2018-07-09 06:16:14.000', '1', '2019-08-09 11:26:04.707', 11, '', '0');
INSERT INTO `sys_dict` VALUES ('13276f100593667c3bd40ab8fea734b4', '立即执行', '1', 'sys_misfire_policy_1', 'cb3d07975904460c94e9e2b30755c04b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 30, b'1', b'1', NULL, '1', '2019-08-15 10:24:19.706', '1', '2019-08-15 10:24:19.706', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('181dd29afa852bd47a5ae8dd2e02a623', '正常', '1', 'sys_status_1', '952c07b027bf0be298a9243af701b8c5', '1,cfd5f62f601817a3b0f38f5ccb1f5128,952c07b027bf0be298a9243af701b8c5,', 30, b'1', b'1', NULL, '1', '2019-08-14 11:28:01.693', '1', '2019-08-15 09:08:45.451', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('2', '是否标识', '', 'sys_flag', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 10, b'1', b'0', NULL, '1', '2019-06-02 17:17:44.000', '1', '2019-08-09 11:26:04.727', 17, NULL, '0');
INSERT INTO `sys_dict` VALUES ('269ebbfff898cf1db0d243e3f7774d2c', '业务数据', 'biz', 'biz', '1', '1,', 30, b'1', b'1', NULL, '1', '2019-07-14 04:01:51.000', '1', '2019-08-09 11:24:15.473', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('2ec9dffe7cb0dea12c8e4e2a90279711', '强退', '6', 'sys_business_type_6', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 70, b'1', b'1', NULL, '1', '2019-08-07 16:52:15.681', '1', '2019-08-09 11:26:04.727', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('3', '是', '1', 'sys_flag_yes', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 10, b'1', b'1', '', '1', '2018-07-09 06:15:40.000', '1', '2019-08-09 11:26:04.728', 5, '', '0');
INSERT INTO `sys_dict` VALUES ('31d677b181cebb9bde79b78f32e1e8a3', '其他', '0', 'sys_operate_type_0', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 10, b'1', b'1', NULL, '1', '2019-08-07 16:48:21.644', '1', '2019-08-09 11:26:04.730', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('3e949b67e0c5be3357bdcce9705f7433', '放弃执行', '3', 'sys_misfire_policy_3', 'cb3d07975904460c94e9e2b30755c04b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 30, b'1', b'1', NULL, '1', '2019-08-15 10:24:54.175', '1', '2019-08-15 10:24:54.175', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4', '否', '0', 'sys_flag_no', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 30, b'1', b'1', NULL, '1', '2019-06-02 17:26:40.000', '1', '2019-08-09 11:26:04.732', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4198b5e10fe052546ebb689b4103590e', '所在机构数据', '3', 'sys_data_scope_3', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 30, b'1', b'1', NULL, '1', '2019-07-14 05:59:13.000', '1', '2019-08-09 11:26:04.733', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4ebd555fb352328cb2db93e15d3243ad', '系统', 'SYSTEM', 'sys_job_group_system', '05d01334ecdbe94b856038a32a42512b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,05d01334ecdbe94b856038a32a42512b,', 30, b'1', b'1', NULL, '1', '2019-08-15 16:34:47.139', '1', '2019-08-15 16:34:47.139', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('51828811168cd9f0ee1d118068a7d0b9', '编辑', '1', 'sys_business_type_1', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 20, b'1', b'1', NULL, '1', '2019-08-07 16:50:20.634', '1', '2019-08-09 11:26:04.733', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('5933a853cd0199b00424d66f4b92dda3', '所在机构及以下数据', '2', 'sys_data_scope_2', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 20, b'1', b'1', NULL, '1', '2019-07-14 05:53:55.000', '1', '2019-08-09 11:26:04.734', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('5f2414b2670c9a66c1d5364613caa654', '后台用户', '1', 'sys_operate_type_1', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 20, b'1', b'1', NULL, '1', '2019-08-07 16:48:40.344', '1', '2019-08-09 11:26:04.734', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('6b8211aef2fec451b0398b19857443a7', '操作人类别', NULL, 'sys_operator_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-08-07 15:37:09.613', '1', '2019-08-09 11:26:04.734', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('6e4bba74f32df9149d69f8e9bb19cd9d', '菜单', '0', 'sys_menu_type_0', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 10, b'1', b'1', NULL, '1', '2019-07-14 06:04:10.000', '1', '2019-08-09 11:26:04.736', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('764d1eaf8a39698fc85a7204c96e7089', '生成代码', '7', 'sys_business_type_7', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 80, b'1', b'1', NULL, '1', '2019-08-07 16:52:36.997', '1', '2019-08-09 11:26:04.739', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('80b084e162b0a30b348a45ff29e5b326', '导出', '4', 'sys_business_type_4', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 50, b'1', b'1', NULL, '1', '2019-08-07 16:51:33.286', '1', '2019-08-09 11:26:04.739', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8153bd2af73b6d59eed9f34d2bc05bb9', '删除', '3', 'sys_business_type_3', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 40, b'1', b'1', NULL, '1', '2019-08-07 16:50:45.270', '1', '2019-08-09 11:26:04.740', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8883abe4dcf9390df69a5740050abf74', '离线', 'off_line', 'sys_online_status_off_line', 'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30, b'1', b'1', NULL, '1', '2019-08-11 11:17:50.132', '1', '2019-08-11 11:17:50.132', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8c4589d0a32c9b84b6254507354a195b', 'test', 'test', 'test', '-1', NULL, 30, b'1', b'1', NULL, '1', '2019-07-14 03:59:38.000', '1', '2019-07-14 04:00:28.000', 0, NULL, '1');
INSERT INTO `sys_dict` VALUES ('94e00baf14b640d793c133fb7bfa4c9a', '默认', 'DEFAULT', 'sys_job_group_default', '05d01334ecdbe94b856038a32a42512b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,05d01334ecdbe94b856038a32a42512b,', 30, b'1', b'1', NULL, '1', '2019-08-15 16:34:28.547', '1', '2019-08-15 16:34:28.547', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('952c07b027bf0be298a9243af701b8c5', '状态', NULL, 'sys_status', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-08-14 11:26:50.424', '1', '2019-08-15 09:09:12.239', 3, NULL, '0');
INSERT INTO `sys_dict` VALUES ('a5dfce34bdb7aa99560e8c0d393a632f', '全部', '1', 'sys_data_scope_1', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 10, b'1', b'1', NULL, '1', '2019-07-14 05:52:44.000', '1', '2019-08-09 11:26:04.740', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('aa294a48211a2deb5c7d76c5e90dc28e', '数据范围', '', 'sys_data_scope', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-07-14 05:50:08.000', '1', '2019-08-09 11:26:04.741', 16, NULL, '0');
INSERT INTO `sys_dict` VALUES ('b672448a74c1d1a47eb1378e3d8c6dc9', '导入', '5', 'sys_business_type_5', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 60, b'1', b'1', NULL, '1', '2019-08-07 16:51:45.855', '1', '2019-08-09 11:26:04.741', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('c46ec99af2c1f967bf10cf2c0d96a6c5', '按明细设置', '5', 'sys_data_scope_5', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 50, b'1', b'1', NULL, '1', '2019-07-14 06:01:11.000', '1', '2019-08-09 11:26:04.741', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('cb3d07975904460c94e9e2b30755c04b', '计划执行错误策略', NULL, 'sys_misfire_policy', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-08-15 10:23:54.460', '1', '2019-08-15 10:24:54.169', 3, NULL, '0');
INSERT INTO `sys_dict` VALUES ('cfd5f62f601817a3b0f38f5ccb1f5128', '系统数据', 'sys', 'sys', '1', '1,', 30, b'1', b'0', NULL, '1', '2019-07-14 01:13:12.000', '1', '2019-08-15 16:33:54.741', 22, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e0696db908c87ad57a85c6b326348dbd', '业务操作类型', NULL, 'sys_business_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-08-07 15:33:35.000', '1', '2019-08-09 11:26:04.742', 17, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e26ee931e276a099fb876541ca18756f', '菜单类型', '', 'sys_menu_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-07-14 06:01:48.000', '1', '2019-08-09 11:26:04.744', 8, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e7891a6351a2e143899849b2955851b2', '锁定', '2', 'sys_business_type_2', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 30, b'1', b'1', NULL, '1', '2019-08-07 16:50:32.457', '1', '2019-08-09 11:26:04.746', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('ef0368c6fd52ee8f1f4270869da00f18', 'tab按钮', '2', 'sys_menu_type_2', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 30, b'1', b'1', NULL, '1', '2019-08-07 13:55:24.531', '1', '2019-08-09 11:26:04.746', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f3592a047c466e348279983336ebaf28', '在线状态', NULL, 'sys_online_status', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-08-11 11:16:52.095', '1', '2019-08-11 11:17:50.128', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f35adf75d9ab0ca5cec43815b7db5274', '执行一次', '2', 'sys_misfire_policy_2', 'cb3d07975904460c94e9e2b30755c04b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 30, b'1', b'1', NULL, '1', '2019-08-15 10:24:39.273', '1', '2019-08-15 10:24:39.273', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f83a718756762758707c67db3d271c9d', '手机端用户', '2', 'sys_operate_type_2', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 30, b'1', b'1', NULL, '1', '2019-08-07 16:49:00.766', '1', '2019-08-09 11:26:04.746', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('fafe8843b2f4091f8096dc0df09c300c', '失败', '0', 'sys_status_0', '952c07b027bf0be298a9243af701b8c5', '1,cfd5f62f601817a3b0f38f5ccb1f5128,952c07b027bf0be298a9243af701b8c5,', 30, b'1', b'1', NULL, '1', '2019-08-14 11:28:11.000', '1', '2019-08-15 09:08:49.884', 1, NULL, '0');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（1允许 0禁止）',
  `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态(1-正常，0-锁定)',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` datetime(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'simpleTask.doNoParams', '0/10 * * * * ?', '3', '1', '0', '', '2019-08-14 10:21:36.000', '1', '2019-08-15 16:43:24.833', NULL, 5, '0');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '0/15 * * * * ?', '3', '1', '1', '', '2019-08-14 10:21:36.950', '1', '2019-08-15 17:10:56.781', NULL, 11, '0');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'simpleTask.doMultipleParams(\'albedo\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '0', '', '2019-08-14 10:21:36.000', '1', '2019-08-15 16:43:22.501', NULL, 3, '0');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `start_time` datetime(3) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(3) NULL DEFAULT NULL COMMENT '结束时间',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2847 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES (1571, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：28毫秒', '1', '2019-08-20 13:07:49.880', '2019-08-20 13:07:49.908', '2019-08-20 13:07:49.908', '', NULL);
INSERT INTO `sys_job_log` VALUES (1572, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:08:00.042', '2019-08-20 13:08:00.043', '2019-08-20 13:08:00.043', '', NULL);
INSERT INTO `sys_job_log` VALUES (1573, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:08:15.040', '2019-08-20 13:08:15.040', '2019-08-20 13:08:15.040', '', NULL);
INSERT INTO `sys_job_log` VALUES (1574, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:08:30.081', '2019-08-20 13:08:30.082', '2019-08-20 13:08:30.082', '', NULL);
INSERT INTO `sys_job_log` VALUES (1575, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:08:45.019', '2019-08-20 13:08:45.019', '2019-08-20 13:08:45.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1576, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:09:00.022', '2019-08-20 13:09:00.022', '2019-08-20 13:09:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (1577, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:09:15.017', '2019-08-20 13:09:15.017', '2019-08-20 13:09:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1578, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:09:30.044', '2019-08-20 13:09:30.044', '2019-08-20 13:09:30.044', '', NULL);
INSERT INTO `sys_job_log` VALUES (1579, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:09:45.016', '2019-08-20 13:09:45.016', '2019-08-20 13:09:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1580, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:10:00.026', '2019-08-20 13:10:00.026', '2019-08-20 13:10:00.026', '', NULL);
INSERT INTO `sys_job_log` VALUES (1581, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:10:15.066', '2019-08-20 13:10:15.066', '2019-08-20 13:10:15.066', '', NULL);
INSERT INTO `sys_job_log` VALUES (1582, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：4毫秒', '1', '2019-08-20 13:10:30.036', '2019-08-20 13:10:30.040', '2019-08-20 13:10:30.040', '', NULL);
INSERT INTO `sys_job_log` VALUES (1583, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:10:45.028', '2019-08-20 13:10:45.028', '2019-08-20 13:10:45.028', '', NULL);
INSERT INTO `sys_job_log` VALUES (1584, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:11:00.030', '2019-08-20 13:11:00.031', '2019-08-20 13:11:00.031', '', NULL);
INSERT INTO `sys_job_log` VALUES (1585, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:11:15.017', '2019-08-20 13:11:15.017', '2019-08-20 13:11:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1586, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:11:30.030', '2019-08-20 13:11:30.030', '2019-08-20 13:11:30.030', '', NULL);
INSERT INTO `sys_job_log` VALUES (1587, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:11:45.016', '2019-08-20 13:11:45.017', '2019-08-20 13:11:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1588, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:12:00.025', '2019-08-20 13:12:00.025', '2019-08-20 13:12:00.025', '', NULL);
INSERT INTO `sys_job_log` VALUES (1589, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:12:15.014', '2019-08-20 13:12:15.014', '2019-08-20 13:12:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1590, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:12:30.019', '2019-08-20 13:12:30.020', '2019-08-20 13:12:30.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1591, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:12:45.014', '2019-08-20 13:12:45.015', '2019-08-20 13:12:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1592, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:13:00.032', '2019-08-20 13:13:00.032', '2019-08-20 13:13:00.032', '', NULL);
INSERT INTO `sys_job_log` VALUES (1593, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:13:15.019', '2019-08-20 13:13:15.019', '2019-08-20 13:13:15.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1594, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:13:30.018', '2019-08-20 13:13:30.018', '2019-08-20 13:13:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1595, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:13:45.015', '2019-08-20 13:13:45.015', '2019-08-20 13:13:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1596, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:14:00.020', '2019-08-20 13:14:00.020', '2019-08-20 13:14:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1597, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:14:15.016', '2019-08-20 13:14:15.016', '2019-08-20 13:14:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1598, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:14:30.012', '2019-08-20 13:14:30.013', '2019-08-20 13:14:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1599, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:14:45.014', '2019-08-20 13:14:45.014', '2019-08-20 13:14:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1600, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:15:00.016', '2019-08-20 13:15:00.016', '2019-08-20 13:15:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1601, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:15:15.015', '2019-08-20 13:15:15.016', '2019-08-20 13:15:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1602, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:15:30.018', '2019-08-20 13:15:30.018', '2019-08-20 13:15:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1603, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:15:45.019', '2019-08-20 13:15:45.019', '2019-08-20 13:15:45.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1604, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:16:00.018', '2019-08-20 13:16:00.018', '2019-08-20 13:16:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1605, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:16:15.013', '2019-08-20 13:16:15.013', '2019-08-20 13:16:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1606, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:16:30.014', '2019-08-20 13:16:30.014', '2019-08-20 13:16:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1607, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:16:45.013', '2019-08-20 13:16:45.013', '2019-08-20 13:16:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1608, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:17:00.018', '2019-08-20 13:17:00.019', '2019-08-20 13:17:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1609, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:17:15.014', '2019-08-20 13:17:15.014', '2019-08-20 13:17:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1610, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:17:30.018', '2019-08-20 13:17:30.018', '2019-08-20 13:17:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1611, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:17:45.015', '2019-08-20 13:17:45.015', '2019-08-20 13:17:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1612, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:18:00.019', '2019-08-20 13:18:00.019', '2019-08-20 13:18:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1613, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:18:15.016', '2019-08-20 13:18:15.017', '2019-08-20 13:18:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1614, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:18:30.016', '2019-08-20 13:18:30.016', '2019-08-20 13:18:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1615, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:18:45.017', '2019-08-20 13:18:45.017', '2019-08-20 13:18:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1616, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:19:00.018', '2019-08-20 13:19:00.018', '2019-08-20 13:19:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1617, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:19:15.014', '2019-08-20 13:19:15.014', '2019-08-20 13:19:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1618, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:19:30.018', '2019-08-20 13:19:30.018', '2019-08-20 13:19:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1619, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:19:45.015', '2019-08-20 13:19:45.015', '2019-08-20 13:19:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1620, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:20:00.020', '2019-08-20 13:20:00.021', '2019-08-20 13:20:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (1621, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:20:15.019', '2019-08-20 13:20:15.020', '2019-08-20 13:20:15.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1622, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:20:30.016', '2019-08-20 13:20:30.016', '2019-08-20 13:20:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1623, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:20:45.015', '2019-08-20 13:20:45.015', '2019-08-20 13:20:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1624, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:21:00.016', '2019-08-20 13:21:00.017', '2019-08-20 13:21:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1625, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:21:15.013', '2019-08-20 13:21:15.013', '2019-08-20 13:21:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1626, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:21:30.017', '2019-08-20 13:21:30.017', '2019-08-20 13:21:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1627, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:21:45.015', '2019-08-20 13:21:45.015', '2019-08-20 13:21:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1628, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:22:00.016', '2019-08-20 13:22:00.016', '2019-08-20 13:22:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1629, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:22:15.016', '2019-08-20 13:22:15.017', '2019-08-20 13:22:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1630, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:22:30.021', '2019-08-20 13:22:30.021', '2019-08-20 13:22:30.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (1631, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:22:45.015', '2019-08-20 13:22:45.015', '2019-08-20 13:22:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1632, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:23:00.020', '2019-08-20 13:23:00.020', '2019-08-20 13:23:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1633, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:23:15.015', '2019-08-20 13:23:15.015', '2019-08-20 13:23:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1634, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:23:30.018', '2019-08-20 13:23:30.018', '2019-08-20 13:23:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1635, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:23:45.014', '2019-08-20 13:23:45.015', '2019-08-20 13:23:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1636, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:24:00.018', '2019-08-20 13:24:00.018', '2019-08-20 13:24:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1637, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:24:15.015', '2019-08-20 13:24:15.015', '2019-08-20 13:24:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1638, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:24:30.014', '2019-08-20 13:24:30.014', '2019-08-20 13:24:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1639, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:24:45.016', '2019-08-20 13:24:45.016', '2019-08-20 13:24:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1640, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:25:00.016', '2019-08-20 13:25:00.017', '2019-08-20 13:25:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1641, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:25:15.015', '2019-08-20 13:25:15.015', '2019-08-20 13:25:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1642, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:25:30.018', '2019-08-20 13:25:30.018', '2019-08-20 13:25:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1643, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:25:45.016', '2019-08-20 13:25:45.016', '2019-08-20 13:25:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1644, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:26:00.017', '2019-08-20 13:26:00.017', '2019-08-20 13:26:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1645, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:26:15.013', '2019-08-20 13:26:15.013', '2019-08-20 13:26:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1646, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:26:30.015', '2019-08-20 13:26:30.015', '2019-08-20 13:26:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1647, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:26:45.015', '2019-08-20 13:26:45.016', '2019-08-20 13:26:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1648, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:27:00.015', '2019-08-20 13:27:00.016', '2019-08-20 13:27:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1649, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:27:15.017', '2019-08-20 13:27:15.018', '2019-08-20 13:27:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1650, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:27:30.017', '2019-08-20 13:27:30.017', '2019-08-20 13:27:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1651, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:27:45.014', '2019-08-20 13:27:45.014', '2019-08-20 13:27:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1652, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:28:00.019', '2019-08-20 13:28:00.019', '2019-08-20 13:28:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1653, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:28:15.016', '2019-08-20 13:28:15.016', '2019-08-20 13:28:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1654, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:28:30.013', '2019-08-20 13:28:30.013', '2019-08-20 13:28:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1655, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:28:45.014', '2019-08-20 13:28:45.014', '2019-08-20 13:28:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1656, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:29:00.016', '2019-08-20 13:29:00.016', '2019-08-20 13:29:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1657, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:29:15.014', '2019-08-20 13:29:15.014', '2019-08-20 13:29:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1658, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:29:30.019', '2019-08-20 13:29:30.019', '2019-08-20 13:29:30.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1659, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:29:45.014', '2019-08-20 13:29:45.014', '2019-08-20 13:29:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1660, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:30:00.019', '2019-08-20 13:30:00.019', '2019-08-20 13:30:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1661, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:30:15.014', '2019-08-20 13:30:15.014', '2019-08-20 13:30:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1662, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:30:30.013', '2019-08-20 13:30:30.013', '2019-08-20 13:30:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1663, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:30:45.014', '2019-08-20 13:30:45.015', '2019-08-20 13:30:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1664, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:31:00.019', '2019-08-20 13:31:00.019', '2019-08-20 13:31:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1665, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:31:15.016', '2019-08-20 13:31:15.016', '2019-08-20 13:31:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1666, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:31:30.018', '2019-08-20 13:31:30.018', '2019-08-20 13:31:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1667, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:31:45.013', '2019-08-20 13:31:45.013', '2019-08-20 13:31:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1668, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:32:00.017', '2019-08-20 13:32:00.017', '2019-08-20 13:32:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1669, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:32:15.021', '2019-08-20 13:32:15.022', '2019-08-20 13:32:15.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (1670, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:32:30.013', '2019-08-20 13:32:30.013', '2019-08-20 13:32:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1671, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:32:45.016', '2019-08-20 13:32:45.016', '2019-08-20 13:32:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1672, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:33:00.018', '2019-08-20 13:33:00.018', '2019-08-20 13:33:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1673, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:33:15.018', '2019-08-20 13:33:15.018', '2019-08-20 13:33:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1674, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:33:30.017', '2019-08-20 13:33:30.017', '2019-08-20 13:33:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1675, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:33:45.014', '2019-08-20 13:33:45.014', '2019-08-20 13:33:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1676, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:34:00.018', '2019-08-20 13:34:00.018', '2019-08-20 13:34:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1677, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:34:15.014', '2019-08-20 13:34:15.015', '2019-08-20 13:34:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1678, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:34:30.022', '2019-08-20 13:34:30.022', '2019-08-20 13:34:30.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (1679, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:34:45.014', '2019-08-20 13:34:45.014', '2019-08-20 13:34:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1680, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:35:00.017', '2019-08-20 13:35:00.018', '2019-08-20 13:35:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1681, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:35:15.016', '2019-08-20 13:35:15.016', '2019-08-20 13:35:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1682, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:35:30.022', '2019-08-20 13:35:30.023', '2019-08-20 13:35:30.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (1683, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:35:45.015', '2019-08-20 13:35:45.015', '2019-08-20 13:35:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1684, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:36:00.015', '2019-08-20 13:36:00.015', '2019-08-20 13:36:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1685, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:36:15.013', '2019-08-20 13:36:15.014', '2019-08-20 13:36:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1686, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:36:30.016', '2019-08-20 13:36:30.016', '2019-08-20 13:36:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1687, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:36:45.015', '2019-08-20 13:36:45.015', '2019-08-20 13:36:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1688, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:37:00.017', '2019-08-20 13:37:00.017', '2019-08-20 13:37:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1689, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:37:15.014', '2019-08-20 13:37:15.014', '2019-08-20 13:37:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1690, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:37:30.018', '2019-08-20 13:37:30.018', '2019-08-20 13:37:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1691, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:37:45.018', '2019-08-20 13:37:45.018', '2019-08-20 13:37:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1692, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:38:00.017', '2019-08-20 13:38:00.017', '2019-08-20 13:38:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1693, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:38:15.016', '2019-08-20 13:38:15.016', '2019-08-20 13:38:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1694, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:38:30.015', '2019-08-20 13:38:30.015', '2019-08-20 13:38:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1695, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:38:45.017', '2019-08-20 13:38:45.017', '2019-08-20 13:38:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1696, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:39:00.017', '2019-08-20 13:39:00.017', '2019-08-20 13:39:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1697, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:39:15.014', '2019-08-20 13:39:15.014', '2019-08-20 13:39:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1698, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:39:30.022', '2019-08-20 13:39:30.022', '2019-08-20 13:39:30.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (1699, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:39:45.016', '2019-08-20 13:39:45.016', '2019-08-20 13:39:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1700, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:40:00.016', '2019-08-20 13:40:00.017', '2019-08-20 13:40:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1701, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:40:15.014', '2019-08-20 13:40:15.014', '2019-08-20 13:40:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1702, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:40:30.015', '2019-08-20 13:40:30.015', '2019-08-20 13:40:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1703, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:40:45.013', '2019-08-20 13:40:45.014', '2019-08-20 13:40:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1704, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:41:00.018', '2019-08-20 13:41:00.019', '2019-08-20 13:41:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1705, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:41:15.018', '2019-08-20 13:41:15.018', '2019-08-20 13:41:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1706, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:41:30.015', '2019-08-20 13:41:30.015', '2019-08-20 13:41:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1707, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:41:45.018', '2019-08-20 13:41:45.018', '2019-08-20 13:41:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1708, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:42:00.017', '2019-08-20 13:42:00.017', '2019-08-20 13:42:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1709, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:42:15.015', '2019-08-20 13:42:15.015', '2019-08-20 13:42:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1710, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:42:30.014', '2019-08-20 13:42:30.014', '2019-08-20 13:42:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1711, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:42:45.015', '2019-08-20 13:42:45.015', '2019-08-20 13:42:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1712, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:43:00.017', '2019-08-20 13:43:00.017', '2019-08-20 13:43:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1713, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:43:15.016', '2019-08-20 13:43:15.016', '2019-08-20 13:43:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1714, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:43:30.020', '2019-08-20 13:43:30.020', '2019-08-20 13:43:30.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1715, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:43:45.014', '2019-08-20 13:43:45.015', '2019-08-20 13:43:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1716, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:44:00.018', '2019-08-20 13:44:00.018', '2019-08-20 13:44:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1717, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:44:15.014', '2019-08-20 13:44:15.014', '2019-08-20 13:44:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1718, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:44:30.014', '2019-08-20 13:44:30.014', '2019-08-20 13:44:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1719, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:44:45.014', '2019-08-20 13:44:45.014', '2019-08-20 13:44:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1720, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:45:00.016', '2019-08-20 13:45:00.016', '2019-08-20 13:45:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1721, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:45:15.013', '2019-08-20 13:45:15.013', '2019-08-20 13:45:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1722, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:45:30.016', '2019-08-20 13:45:30.017', '2019-08-20 13:45:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1723, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:45:45.019', '2019-08-20 13:45:45.019', '2019-08-20 13:45:45.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1724, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:46:00.016', '2019-08-20 13:46:00.016', '2019-08-20 13:46:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1725, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:46:15.015', '2019-08-20 13:46:15.015', '2019-08-20 13:46:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1726, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:46:30.017', '2019-08-20 13:46:30.017', '2019-08-20 13:46:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1727, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:46:45.014', '2019-08-20 13:46:45.014', '2019-08-20 13:46:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1728, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:47:00.017', '2019-08-20 13:47:00.017', '2019-08-20 13:47:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1729, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:47:15.014', '2019-08-20 13:47:15.014', '2019-08-20 13:47:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1730, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:47:30.018', '2019-08-20 13:47:30.018', '2019-08-20 13:47:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1731, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:47:45.013', '2019-08-20 13:47:45.013', '2019-08-20 13:47:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1732, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:48:00.017', '2019-08-20 13:48:00.017', '2019-08-20 13:48:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1733, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:48:15.013', '2019-08-20 13:48:15.013', '2019-08-20 13:48:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1734, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:48:30.014', '2019-08-20 13:48:30.014', '2019-08-20 13:48:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1735, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:48:45.014', '2019-08-20 13:48:45.015', '2019-08-20 13:48:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1736, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:49:00.017', '2019-08-20 13:49:00.017', '2019-08-20 13:49:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1737, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:49:15.016', '2019-08-20 13:49:15.016', '2019-08-20 13:49:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1738, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:49:30.016', '2019-08-20 13:49:30.017', '2019-08-20 13:49:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1739, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:49:45.017', '2019-08-20 13:49:45.017', '2019-08-20 13:49:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1740, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:50:00.021', '2019-08-20 13:50:00.022', '2019-08-20 13:50:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (1741, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:50:15.016', '2019-08-20 13:50:15.016', '2019-08-20 13:50:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1742, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:50:30.013', '2019-08-20 13:50:30.014', '2019-08-20 13:50:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1743, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:50:45.025', '2019-08-20 13:50:45.025', '2019-08-20 13:50:45.025', '', NULL);
INSERT INTO `sys_job_log` VALUES (1744, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:51:00.021', '2019-08-20 13:51:00.021', '2019-08-20 13:51:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (1745, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:51:15.014', '2019-08-20 13:51:15.014', '2019-08-20 13:51:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1746, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:51:30.015', '2019-08-20 13:51:30.015', '2019-08-20 13:51:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1747, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:51:45.016', '2019-08-20 13:51:45.016', '2019-08-20 13:51:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1748, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:52:00.017', '2019-08-20 13:52:00.018', '2019-08-20 13:52:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1749, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:52:15.014', '2019-08-20 13:52:15.014', '2019-08-20 13:52:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1750, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:52:30.015', '2019-08-20 13:52:30.015', '2019-08-20 13:52:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1751, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:52:45.015', '2019-08-20 13:52:45.015', '2019-08-20 13:52:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1752, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:53:00.015', '2019-08-20 13:53:00.015', '2019-08-20 13:53:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1753, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:53:15.014', '2019-08-20 13:53:15.014', '2019-08-20 13:53:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1754, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:53:30.014', '2019-08-20 13:53:30.014', '2019-08-20 13:53:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1755, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:53:45.018', '2019-08-20 13:53:45.018', '2019-08-20 13:53:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1756, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:54:00.017', '2019-08-20 13:54:00.017', '2019-08-20 13:54:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1757, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:54:15.015', '2019-08-20 13:54:15.016', '2019-08-20 13:54:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1758, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:54:30.014', '2019-08-20 13:54:30.014', '2019-08-20 13:54:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1759, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:54:45.014', '2019-08-20 13:54:45.014', '2019-08-20 13:54:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1760, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:55:00.016', '2019-08-20 13:55:00.017', '2019-08-20 13:55:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1761, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:55:15.014', '2019-08-20 13:55:15.014', '2019-08-20 13:55:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1762, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:55:30.013', '2019-08-20 13:55:30.013', '2019-08-20 13:55:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1763, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:55:45.016', '2019-08-20 13:55:45.016', '2019-08-20 13:55:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1764, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:56:00.020', '2019-08-20 13:56:00.020', '2019-08-20 13:56:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1765, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:56:15.014', '2019-08-20 13:56:15.015', '2019-08-20 13:56:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1766, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:56:30.015', '2019-08-20 13:56:30.015', '2019-08-20 13:56:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1767, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:56:45.014', '2019-08-20 13:56:45.014', '2019-08-20 13:56:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1768, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:57:00.017', '2019-08-20 13:57:00.018', '2019-08-20 13:57:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1769, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:57:15.013', '2019-08-20 13:57:15.014', '2019-08-20 13:57:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1770, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:57:30.016', '2019-08-20 13:57:30.016', '2019-08-20 13:57:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1771, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:57:45.019', '2019-08-20 13:57:45.019', '2019-08-20 13:57:45.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1772, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:58:00.016', '2019-08-20 13:58:00.016', '2019-08-20 13:58:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1773, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 13:58:15.014', '2019-08-20 13:58:15.015', '2019-08-20 13:58:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1774, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:58:30.014', '2019-08-20 13:58:30.014', '2019-08-20 13:58:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1775, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:58:45.014', '2019-08-20 13:58:45.014', '2019-08-20 13:58:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1776, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:59:00.016', '2019-08-20 13:59:00.016', '2019-08-20 13:59:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1777, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:59:15.014', '2019-08-20 13:59:15.014', '2019-08-20 13:59:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1778, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:59:30.014', '2019-08-20 13:59:30.014', '2019-08-20 13:59:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1779, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 13:59:45.018', '2019-08-20 13:59:45.018', '2019-08-20 13:59:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1780, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:00:00.025', '2019-08-20 14:00:00.025', '2019-08-20 14:00:00.025', '', NULL);
INSERT INTO `sys_job_log` VALUES (1781, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:00:15.013', '2019-08-20 14:00:15.013', '2019-08-20 14:00:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1782, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:00:30.014', '2019-08-20 14:00:30.014', '2019-08-20 14:00:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1783, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:00:45.013', '2019-08-20 14:00:45.013', '2019-08-20 14:00:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1784, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:01:00.018', '2019-08-20 14:01:00.018', '2019-08-20 14:01:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1785, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:01:15.015', '2019-08-20 14:01:15.015', '2019-08-20 14:01:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1786, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:01:30.016', '2019-08-20 14:01:30.016', '2019-08-20 14:01:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1787, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:01:45.019', '2019-08-20 14:01:45.019', '2019-08-20 14:01:45.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1788, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:02:00.018', '2019-08-20 14:02:00.018', '2019-08-20 14:02:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1789, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:02:15.015', '2019-08-20 14:02:15.015', '2019-08-20 14:02:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1790, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:02:30.015', '2019-08-20 14:02:30.015', '2019-08-20 14:02:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1791, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:02:45.014', '2019-08-20 14:02:45.014', '2019-08-20 14:02:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1792, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:03:00.017', '2019-08-20 14:03:00.017', '2019-08-20 14:03:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1793, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:03:15.017', '2019-08-20 14:03:15.017', '2019-08-20 14:03:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1794, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:03:30.015', '2019-08-20 14:03:30.015', '2019-08-20 14:03:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1795, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:03:45.017', '2019-08-20 14:03:45.017', '2019-08-20 14:03:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1796, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:04:00.017', '2019-08-20 14:04:00.017', '2019-08-20 14:04:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1797, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:04:15.014', '2019-08-20 14:04:15.014', '2019-08-20 14:04:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1798, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:04:30.014', '2019-08-20 14:04:30.014', '2019-08-20 14:04:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1799, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:04:45.014', '2019-08-20 14:04:45.015', '2019-08-20 14:04:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1800, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:05:00.017', '2019-08-20 14:05:00.017', '2019-08-20 14:05:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1801, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:05:15.014', '2019-08-20 14:05:15.014', '2019-08-20 14:05:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1802, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:05:30.014', '2019-08-20 14:05:30.014', '2019-08-20 14:05:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1803, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:05:45.017', '2019-08-20 14:05:45.017', '2019-08-20 14:05:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1804, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:06:00.016', '2019-08-20 14:06:00.017', '2019-08-20 14:06:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1805, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:06:15.017', '2019-08-20 14:06:15.017', '2019-08-20 14:06:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1806, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:06:30.015', '2019-08-20 14:06:30.015', '2019-08-20 14:06:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1807, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:06:45.015', '2019-08-20 14:06:45.015', '2019-08-20 14:06:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1808, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:07:00.016', '2019-08-20 14:07:00.017', '2019-08-20 14:07:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1809, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:07:15.015', '2019-08-20 14:07:15.015', '2019-08-20 14:07:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1810, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:07:30.014', '2019-08-20 14:07:30.014', '2019-08-20 14:07:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1811, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:07:45.017', '2019-08-20 14:07:45.018', '2019-08-20 14:07:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1812, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:08:00.016', '2019-08-20 14:08:00.017', '2019-08-20 14:08:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1813, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:08:15.015', '2019-08-20 14:08:15.015', '2019-08-20 14:08:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1814, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:08:30.015', '2019-08-20 14:08:30.015', '2019-08-20 14:08:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1815, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:08:45.013', '2019-08-20 14:08:45.013', '2019-08-20 14:08:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1816, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:09:00.015', '2019-08-20 14:09:00.015', '2019-08-20 14:09:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1817, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:09:15.016', '2019-08-20 14:09:15.016', '2019-08-20 14:09:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1818, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:09:30.014', '2019-08-20 14:09:30.015', '2019-08-20 14:09:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1819, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:09:45.018', '2019-08-20 14:09:45.018', '2019-08-20 14:09:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1820, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:10:00.020', '2019-08-20 14:10:00.020', '2019-08-20 14:10:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1821, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:10:15.015', '2019-08-20 14:10:15.015', '2019-08-20 14:10:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1822, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:10:30.019', '2019-08-20 14:10:30.019', '2019-08-20 14:10:30.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1823, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:10:45.015', '2019-08-20 14:10:45.015', '2019-08-20 14:10:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1824, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:11:00.018', '2019-08-20 14:11:00.019', '2019-08-20 14:11:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1825, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:11:15.015', '2019-08-20 14:11:15.015', '2019-08-20 14:11:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1826, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:11:30.016', '2019-08-20 14:11:30.017', '2019-08-20 14:11:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1827, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:11:45.021', '2019-08-20 14:11:45.021', '2019-08-20 14:11:45.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (1828, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:12:00.016', '2019-08-20 14:12:00.017', '2019-08-20 14:12:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1829, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:12:15.017', '2019-08-20 14:12:15.017', '2019-08-20 14:12:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1830, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:12:30.014', '2019-08-20 14:12:30.014', '2019-08-20 14:12:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1831, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:12:45.022', '2019-08-20 14:12:45.022', '2019-08-20 14:12:45.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (1832, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:13:00.017', '2019-08-20 14:13:00.017', '2019-08-20 14:13:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1833, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:13:15.015', '2019-08-20 14:13:15.015', '2019-08-20 14:13:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1834, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:13:30.014', '2019-08-20 14:13:30.014', '2019-08-20 14:13:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1835, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:13:45.021', '2019-08-20 14:13:45.021', '2019-08-20 14:13:45.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (1836, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:14:00.019', '2019-08-20 14:14:00.019', '2019-08-20 14:14:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1837, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:14:15.013', '2019-08-20 14:14:15.013', '2019-08-20 14:14:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1838, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:14:30.014', '2019-08-20 14:14:30.014', '2019-08-20 14:14:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1839, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:14:45.012', '2019-08-20 14:14:45.012', '2019-08-20 14:14:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (1840, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:15:00.016', '2019-08-20 14:15:00.016', '2019-08-20 14:15:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1841, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:15:15.015', '2019-08-20 14:15:15.015', '2019-08-20 14:15:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1842, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:15:30.014', '2019-08-20 14:15:30.014', '2019-08-20 14:15:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1843, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:15:45.013', '2019-08-20 14:15:45.014', '2019-08-20 14:15:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1844, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:16:00.018', '2019-08-20 14:16:00.018', '2019-08-20 14:16:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1845, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:16:15.013', '2019-08-20 14:16:15.013', '2019-08-20 14:16:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1846, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:16:30.013', '2019-08-20 14:16:30.013', '2019-08-20 14:16:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1847, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:16:45.015', '2019-08-20 14:16:45.015', '2019-08-20 14:16:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1848, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:17:00.015', '2019-08-20 14:17:00.015', '2019-08-20 14:17:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1849, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:17:15.015', '2019-08-20 14:17:15.015', '2019-08-20 14:17:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1850, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:17:30.014', '2019-08-20 14:17:30.014', '2019-08-20 14:17:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1851, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:17:45.013', '2019-08-20 14:17:45.014', '2019-08-20 14:17:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1852, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:18:00.020', '2019-08-20 14:18:00.020', '2019-08-20 14:18:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1853, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:18:15.015', '2019-08-20 14:18:15.015', '2019-08-20 14:18:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1854, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:18:30.015', '2019-08-20 14:18:30.015', '2019-08-20 14:18:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1855, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:18:45.014', '2019-08-20 14:18:45.014', '2019-08-20 14:18:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1856, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:19:00.016', '2019-08-20 14:19:00.016', '2019-08-20 14:19:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1857, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:19:15.014', '2019-08-20 14:19:15.014', '2019-08-20 14:19:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1858, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:19:30.016', '2019-08-20 14:19:30.016', '2019-08-20 14:19:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1859, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:19:45.013', '2019-08-20 14:19:45.013', '2019-08-20 14:19:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1860, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:20:00.016', '2019-08-20 14:20:00.016', '2019-08-20 14:20:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1861, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:20:15.017', '2019-08-20 14:20:15.017', '2019-08-20 14:20:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1862, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:20:30.014', '2019-08-20 14:20:30.015', '2019-08-20 14:20:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1863, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:20:45.015', '2019-08-20 14:20:45.015', '2019-08-20 14:20:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1864, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:21:00.018', '2019-08-20 14:21:00.018', '2019-08-20 14:21:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1865, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:21:15.015', '2019-08-20 14:21:15.015', '2019-08-20 14:21:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1866, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:21:30.015', '2019-08-20 14:21:30.015', '2019-08-20 14:21:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1867, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:21:45.014', '2019-08-20 14:21:45.014', '2019-08-20 14:21:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1868, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:22:00.016', '2019-08-20 14:22:00.016', '2019-08-20 14:22:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1869, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:22:15.017', '2019-08-20 14:22:15.017', '2019-08-20 14:22:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1870, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:22:30.014', '2019-08-20 14:22:30.014', '2019-08-20 14:22:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1871, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:22:45.015', '2019-08-20 14:22:45.015', '2019-08-20 14:22:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1872, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:23:00.019', '2019-08-20 14:23:00.019', '2019-08-20 14:23:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1873, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:23:15.017', '2019-08-20 14:23:15.017', '2019-08-20 14:23:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1874, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:23:30.017', '2019-08-20 14:23:30.017', '2019-08-20 14:23:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1875, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:23:45.016', '2019-08-20 14:23:45.016', '2019-08-20 14:23:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1876, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:24:00.018', '2019-08-20 14:24:00.018', '2019-08-20 14:24:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1877, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:24:15.018', '2019-08-20 14:24:15.018', '2019-08-20 14:24:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1878, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:24:30.014', '2019-08-20 14:24:30.014', '2019-08-20 14:24:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1879, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:24:45.014', '2019-08-20 14:24:45.014', '2019-08-20 14:24:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1880, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:25:00.017', '2019-08-20 14:25:00.017', '2019-08-20 14:25:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1881, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:25:15.016', '2019-08-20 14:25:15.016', '2019-08-20 14:25:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1882, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:25:30.014', '2019-08-20 14:25:30.014', '2019-08-20 14:25:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1883, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:25:45.014', '2019-08-20 14:25:45.014', '2019-08-20 14:25:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1884, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:26:00.017', '2019-08-20 14:26:00.017', '2019-08-20 14:26:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1885, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:26:15.018', '2019-08-20 14:26:15.018', '2019-08-20 14:26:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1886, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:26:30.014', '2019-08-20 14:26:30.014', '2019-08-20 14:26:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1887, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:26:45.014', '2019-08-20 14:26:45.014', '2019-08-20 14:26:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1888, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:27:00.016', '2019-08-20 14:27:00.017', '2019-08-20 14:27:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1889, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:27:15.015', '2019-08-20 14:27:15.015', '2019-08-20 14:27:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1890, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:27:30.014', '2019-08-20 14:27:30.014', '2019-08-20 14:27:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1891, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:27:45.014', '2019-08-20 14:27:45.014', '2019-08-20 14:27:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1892, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:28:00.017', '2019-08-20 14:28:00.017', '2019-08-20 14:28:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1893, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:28:15.015', '2019-08-20 14:28:15.015', '2019-08-20 14:28:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1894, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:28:30.018', '2019-08-20 14:28:30.018', '2019-08-20 14:28:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1895, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:28:45.014', '2019-08-20 14:28:45.014', '2019-08-20 14:28:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1896, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:29:00.017', '2019-08-20 14:29:00.017', '2019-08-20 14:29:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1897, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:29:15.013', '2019-08-20 14:29:15.013', '2019-08-20 14:29:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1898, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:29:30.015', '2019-08-20 14:29:30.015', '2019-08-20 14:29:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1899, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:29:45.015', '2019-08-20 14:29:45.015', '2019-08-20 14:29:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1900, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:30:00.018', '2019-08-20 14:30:00.018', '2019-08-20 14:30:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1901, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:30:15.014', '2019-08-20 14:30:15.014', '2019-08-20 14:30:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1902, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:30:30.018', '2019-08-20 14:30:30.018', '2019-08-20 14:30:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1903, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:30:45.012', '2019-08-20 14:30:45.012', '2019-08-20 14:30:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (1904, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:31:00.017', '2019-08-20 14:31:00.017', '2019-08-20 14:31:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1905, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:31:15.014', '2019-08-20 14:31:15.015', '2019-08-20 14:31:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1906, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:31:30.014', '2019-08-20 14:31:30.014', '2019-08-20 14:31:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1907, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:31:45.014', '2019-08-20 14:31:45.014', '2019-08-20 14:31:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1908, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:32:00.016', '2019-08-20 14:32:00.016', '2019-08-20 14:32:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1909, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:32:15.017', '2019-08-20 14:32:15.017', '2019-08-20 14:32:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1910, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:32:30.015', '2019-08-20 14:32:30.015', '2019-08-20 14:32:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1911, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:32:45.016', '2019-08-20 14:32:45.016', '2019-08-20 14:32:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1912, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:33:00.016', '2019-08-20 14:33:00.016', '2019-08-20 14:33:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1913, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:33:15.017', '2019-08-20 14:33:15.017', '2019-08-20 14:33:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1914, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:33:30.015', '2019-08-20 14:33:30.015', '2019-08-20 14:33:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1915, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:33:45.015', '2019-08-20 14:33:45.015', '2019-08-20 14:33:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1916, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:34:00.023', '2019-08-20 14:34:00.023', '2019-08-20 14:34:00.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (1917, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:34:15.013', '2019-08-20 14:34:15.014', '2019-08-20 14:34:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1918, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:34:30.016', '2019-08-20 14:34:30.016', '2019-08-20 14:34:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1919, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:34:45.018', '2019-08-20 14:34:45.018', '2019-08-20 14:34:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1920, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:35:00.017', '2019-08-20 14:35:00.018', '2019-08-20 14:35:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1921, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:35:15.017', '2019-08-20 14:35:15.017', '2019-08-20 14:35:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1922, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:35:30.017', '2019-08-20 14:35:30.017', '2019-08-20 14:35:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1923, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:35:45.016', '2019-08-20 14:35:45.017', '2019-08-20 14:35:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1924, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:36:00.016', '2019-08-20 14:36:00.016', '2019-08-20 14:36:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1925, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:36:15.014', '2019-08-20 14:36:15.014', '2019-08-20 14:36:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1926, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:36:30.016', '2019-08-20 14:36:30.016', '2019-08-20 14:36:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1927, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:36:45.015', '2019-08-20 14:36:45.015', '2019-08-20 14:36:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1928, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:37:00.020', '2019-08-20 14:37:00.020', '2019-08-20 14:37:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1929, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:37:15.015', '2019-08-20 14:37:15.016', '2019-08-20 14:37:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1930, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:37:30.016', '2019-08-20 14:37:30.016', '2019-08-20 14:37:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1931, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:37:45.014', '2019-08-20 14:37:45.014', '2019-08-20 14:37:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1932, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:38:00.017', '2019-08-20 14:38:00.017', '2019-08-20 14:38:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1933, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:38:15.014', '2019-08-20 14:38:15.014', '2019-08-20 14:38:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1934, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:38:30.013', '2019-08-20 14:38:30.013', '2019-08-20 14:38:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1935, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:38:45.014', '2019-08-20 14:38:45.014', '2019-08-20 14:38:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1936, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:39:00.020', '2019-08-20 14:39:00.020', '2019-08-20 14:39:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1937, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:39:15.014', '2019-08-20 14:39:15.014', '2019-08-20 14:39:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1938, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:39:30.016', '2019-08-20 14:39:30.016', '2019-08-20 14:39:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1939, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:39:45.014', '2019-08-20 14:39:45.014', '2019-08-20 14:39:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1940, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:40:00.018', '2019-08-20 14:40:00.018', '2019-08-20 14:40:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1941, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:40:15.014', '2019-08-20 14:40:15.014', '2019-08-20 14:40:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1942, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:40:30.015', '2019-08-20 14:40:30.015', '2019-08-20 14:40:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1943, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:40:45.016', '2019-08-20 14:40:45.016', '2019-08-20 14:40:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1944, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:41:00.021', '2019-08-20 14:41:00.021', '2019-08-20 14:41:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (1945, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:41:15.014', '2019-08-20 14:41:15.014', '2019-08-20 14:41:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1946, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:41:30.015', '2019-08-20 14:41:30.016', '2019-08-20 14:41:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1947, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:41:45.013', '2019-08-20 14:41:45.013', '2019-08-20 14:41:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1948, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:42:00.018', '2019-08-20 14:42:00.018', '2019-08-20 14:42:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1949, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:42:15.013', '2019-08-20 14:42:15.014', '2019-08-20 14:42:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1950, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:42:30.016', '2019-08-20 14:42:30.016', '2019-08-20 14:42:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1951, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:42:45.018', '2019-08-20 14:42:45.018', '2019-08-20 14:42:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1952, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:43:00.019', '2019-08-20 14:43:00.019', '2019-08-20 14:43:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1953, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:43:15.017', '2019-08-20 14:43:15.017', '2019-08-20 14:43:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1954, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:43:30.014', '2019-08-20 14:43:30.014', '2019-08-20 14:43:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1955, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:43:45.016', '2019-08-20 14:43:45.017', '2019-08-20 14:43:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1956, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:44:00.017', '2019-08-20 14:44:00.017', '2019-08-20 14:44:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1957, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:44:15.015', '2019-08-20 14:44:15.016', '2019-08-20 14:44:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1958, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:44:30.013', '2019-08-20 14:44:30.013', '2019-08-20 14:44:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1959, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:44:45.014', '2019-08-20 14:44:45.014', '2019-08-20 14:44:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1960, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:45:00.022', '2019-08-20 14:45:00.022', '2019-08-20 14:45:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (1961, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:45:15.015', '2019-08-20 14:45:15.015', '2019-08-20 14:45:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1962, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:45:30.016', '2019-08-20 14:45:30.016', '2019-08-20 14:45:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1963, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:45:45.014', '2019-08-20 14:45:45.014', '2019-08-20 14:45:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1964, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:46:00.016', '2019-08-20 14:46:00.017', '2019-08-20 14:46:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1965, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:46:15.014', '2019-08-20 14:46:15.014', '2019-08-20 14:46:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1966, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:46:30.012', '2019-08-20 14:46:30.012', '2019-08-20 14:46:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (1967, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:46:45.014', '2019-08-20 14:46:45.014', '2019-08-20 14:46:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1968, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:47:00.021', '2019-08-20 14:47:00.021', '2019-08-20 14:47:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (1969, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:47:15.015', '2019-08-20 14:47:15.015', '2019-08-20 14:47:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1970, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:47:30.017', '2019-08-20 14:47:30.017', '2019-08-20 14:47:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1971, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:47:45.017', '2019-08-20 14:47:45.017', '2019-08-20 14:47:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1972, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:48:00.017', '2019-08-20 14:48:00.018', '2019-08-20 14:48:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1973, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:48:15.020', '2019-08-20 14:48:15.020', '2019-08-20 14:48:15.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (1974, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:48:30.017', '2019-08-20 14:48:30.017', '2019-08-20 14:48:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1975, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:48:45.014', '2019-08-20 14:48:45.014', '2019-08-20 14:48:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1976, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:49:00.017', '2019-08-20 14:49:00.017', '2019-08-20 14:49:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1977, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:49:15.017', '2019-08-20 14:49:15.017', '2019-08-20 14:49:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1978, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:49:30.015', '2019-08-20 14:49:30.015', '2019-08-20 14:49:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1979, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:49:45.014', '2019-08-20 14:49:45.014', '2019-08-20 14:49:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1980, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:50:00.016', '2019-08-20 14:50:00.017', '2019-08-20 14:50:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1981, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:50:15.015', '2019-08-20 14:50:15.015', '2019-08-20 14:50:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1982, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:50:30.013', '2019-08-20 14:50:30.013', '2019-08-20 14:50:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1983, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:50:45.015', '2019-08-20 14:50:45.015', '2019-08-20 14:50:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1984, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:51:00.016', '2019-08-20 14:51:00.017', '2019-08-20 14:51:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1985, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:51:15.015', '2019-08-20 14:51:15.016', '2019-08-20 14:51:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (1986, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:51:30.015', '2019-08-20 14:51:30.015', '2019-08-20 14:51:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1987, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:51:45.015', '2019-08-20 14:51:45.015', '2019-08-20 14:51:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1988, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:52:00.017', '2019-08-20 14:52:00.017', '2019-08-20 14:52:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1989, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:52:15.013', '2019-08-20 14:52:15.013', '2019-08-20 14:52:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (1990, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:52:30.014', '2019-08-20 14:52:30.014', '2019-08-20 14:52:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1991, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:52:45.014', '2019-08-20 14:52:45.014', '2019-08-20 14:52:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1992, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:53:00.017', '2019-08-20 14:53:00.017', '2019-08-20 14:53:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (1993, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:53:15.018', '2019-08-20 14:53:15.018', '2019-08-20 14:53:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1994, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:53:30.015', '2019-08-20 14:53:30.015', '2019-08-20 14:53:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (1995, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:53:45.014', '2019-08-20 14:53:45.014', '2019-08-20 14:53:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1996, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:54:00.019', '2019-08-20 14:54:00.019', '2019-08-20 14:54:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (1997, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:54:15.014', '2019-08-20 14:54:15.014', '2019-08-20 14:54:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (1998, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:54:30.018', '2019-08-20 14:54:30.018', '2019-08-20 14:54:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (1999, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:54:45.014', '2019-08-20 14:54:45.014', '2019-08-20 14:54:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2000, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:55:00.016', '2019-08-20 14:55:00.016', '2019-08-20 14:55:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2001, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:55:15.017', '2019-08-20 14:55:15.017', '2019-08-20 14:55:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2002, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:55:30.015', '2019-08-20 14:55:30.015', '2019-08-20 14:55:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2003, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:55:45.014', '2019-08-20 14:55:45.014', '2019-08-20 14:55:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2004, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:56:00.017', '2019-08-20 14:56:00.017', '2019-08-20 14:56:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2005, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:56:15.015', '2019-08-20 14:56:15.015', '2019-08-20 14:56:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2006, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:56:30.014', '2019-08-20 14:56:30.014', '2019-08-20 14:56:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2007, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:56:45.015', '2019-08-20 14:56:45.015', '2019-08-20 14:56:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2008, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:57:00.016', '2019-08-20 14:57:00.016', '2019-08-20 14:57:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2009, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:57:15.015', '2019-08-20 14:57:15.015', '2019-08-20 14:57:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2010, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:57:30.017', '2019-08-20 14:57:30.017', '2019-08-20 14:57:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2011, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:57:45.013', '2019-08-20 14:57:45.013', '2019-08-20 14:57:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2012, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:58:00.018', '2019-08-20 14:58:00.019', '2019-08-20 14:58:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2013, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:58:15.015', '2019-08-20 14:58:15.015', '2019-08-20 14:58:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2014, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:58:30.015', '2019-08-20 14:58:30.015', '2019-08-20 14:58:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2015, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:58:45.015', '2019-08-20 14:58:45.015', '2019-08-20 14:58:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2016, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:59:00.018', '2019-08-20 14:59:00.018', '2019-08-20 14:59:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2017, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:59:15.015', '2019-08-20 14:59:15.015', '2019-08-20 14:59:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2018, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 14:59:30.017', '2019-08-20 14:59:30.018', '2019-08-20 14:59:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2019, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 14:59:45.014', '2019-08-20 14:59:45.014', '2019-08-20 14:59:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2020, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:00:00.018', '2019-08-20 15:00:00.018', '2019-08-20 15:00:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2021, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:00:15.015', '2019-08-20 15:00:15.015', '2019-08-20 15:00:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2022, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:00:30.014', '2019-08-20 15:00:30.014', '2019-08-20 15:00:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2023, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:00:45.015', '2019-08-20 15:00:45.015', '2019-08-20 15:00:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2024, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:01:00.017', '2019-08-20 15:01:00.017', '2019-08-20 15:01:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2025, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:01:15.015', '2019-08-20 15:01:15.015', '2019-08-20 15:01:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2026, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:01:30.014', '2019-08-20 15:01:30.014', '2019-08-20 15:01:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2027, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:01:45.016', '2019-08-20 15:01:45.016', '2019-08-20 15:01:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2028, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:02:00.018', '2019-08-20 15:02:00.018', '2019-08-20 15:02:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2029, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:02:15.016', '2019-08-20 15:02:15.016', '2019-08-20 15:02:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2030, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:02:30.013', '2019-08-20 15:02:30.013', '2019-08-20 15:02:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2031, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:02:45.014', '2019-08-20 15:02:45.014', '2019-08-20 15:02:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2032, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:03:00.017', '2019-08-20 15:03:00.017', '2019-08-20 15:03:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2033, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:03:15.014', '2019-08-20 15:03:15.014', '2019-08-20 15:03:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2034, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:03:30.015', '2019-08-20 15:03:30.015', '2019-08-20 15:03:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2035, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:03:45.018', '2019-08-20 15:03:45.018', '2019-08-20 15:03:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2036, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:04:00.018', '2019-08-20 15:04:00.018', '2019-08-20 15:04:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2037, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:04:15.013', '2019-08-20 15:04:15.013', '2019-08-20 15:04:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2038, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:04:30.014', '2019-08-20 15:04:30.014', '2019-08-20 15:04:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2039, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:04:45.014', '2019-08-20 15:04:45.015', '2019-08-20 15:04:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2040, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:05:00.016', '2019-08-20 15:05:00.016', '2019-08-20 15:05:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2041, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:05:15.015', '2019-08-20 15:05:15.015', '2019-08-20 15:05:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2042, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:05:30.013', '2019-08-20 15:05:30.013', '2019-08-20 15:05:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2043, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:05:45.020', '2019-08-20 15:05:45.020', '2019-08-20 15:05:45.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2044, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:06:00.017', '2019-08-20 15:06:00.017', '2019-08-20 15:06:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2045, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:06:15.014', '2019-08-20 15:06:15.014', '2019-08-20 15:06:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2046, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:06:30.016', '2019-08-20 15:06:30.016', '2019-08-20 15:06:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2047, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:06:45.016', '2019-08-20 15:06:45.016', '2019-08-20 15:06:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2048, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:07:00.017', '2019-08-20 15:07:00.017', '2019-08-20 15:07:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2049, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:07:15.016', '2019-08-20 15:07:15.016', '2019-08-20 15:07:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2050, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:07:30.014', '2019-08-20 15:07:30.014', '2019-08-20 15:07:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2051, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:07:45.022', '2019-08-20 15:07:45.022', '2019-08-20 15:07:45.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2052, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:08:00.016', '2019-08-20 15:08:00.016', '2019-08-20 15:08:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2053, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:08:15.015', '2019-08-20 15:08:15.015', '2019-08-20 15:08:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2054, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:08:30.014', '2019-08-20 15:08:30.014', '2019-08-20 15:08:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2055, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:08:45.014', '2019-08-20 15:08:45.014', '2019-08-20 15:08:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2056, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:09:00.017', '2019-08-20 15:09:00.017', '2019-08-20 15:09:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2057, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:09:15.014', '2019-08-20 15:09:15.014', '2019-08-20 15:09:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2058, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:09:30.015', '2019-08-20 15:09:30.015', '2019-08-20 15:09:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2059, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:09:45.015', '2019-08-20 15:09:45.015', '2019-08-20 15:09:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2060, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:10:00.019', '2019-08-20 15:10:00.019', '2019-08-20 15:10:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2061, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:10:15.014', '2019-08-20 15:10:15.014', '2019-08-20 15:10:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2062, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:10:30.013', '2019-08-20 15:10:30.013', '2019-08-20 15:10:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2063, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:10:45.014', '2019-08-20 15:10:45.014', '2019-08-20 15:10:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2064, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:11:00.017', '2019-08-20 15:11:00.017', '2019-08-20 15:11:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2065, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:11:15.013', '2019-08-20 15:11:15.013', '2019-08-20 15:11:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2066, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:11:30.015', '2019-08-20 15:11:30.015', '2019-08-20 15:11:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2067, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:11:45.018', '2019-08-20 15:11:45.018', '2019-08-20 15:11:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2068, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:12:00.021', '2019-08-20 15:12:00.021', '2019-08-20 15:12:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2069, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:12:15.015', '2019-08-20 15:12:15.015', '2019-08-20 15:12:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2070, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:12:30.014', '2019-08-20 15:12:30.014', '2019-08-20 15:12:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2071, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:12:45.014', '2019-08-20 15:12:45.014', '2019-08-20 15:12:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2072, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:13:00.017', '2019-08-20 15:13:00.017', '2019-08-20 15:13:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2073, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:13:15.014', '2019-08-20 15:13:15.014', '2019-08-20 15:13:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2074, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:13:30.013', '2019-08-20 15:13:30.013', '2019-08-20 15:13:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2075, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:13:45.015', '2019-08-20 15:13:45.015', '2019-08-20 15:13:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2076, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:14:00.021', '2019-08-20 15:14:00.021', '2019-08-20 15:14:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2077, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:14:15.012', '2019-08-20 15:14:15.013', '2019-08-20 15:14:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2078, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:14:30.014', '2019-08-20 15:14:30.014', '2019-08-20 15:14:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2079, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:14:45.014', '2019-08-20 15:14:45.015', '2019-08-20 15:14:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2080, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:15:00.017', '2019-08-20 15:15:00.017', '2019-08-20 15:15:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2081, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:15:15.015', '2019-08-20 15:15:15.015', '2019-08-20 15:15:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2082, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:15:30.016', '2019-08-20 15:15:30.016', '2019-08-20 15:15:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2083, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:15:45.014', '2019-08-20 15:15:45.014', '2019-08-20 15:15:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2084, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:16:00.024', '2019-08-20 15:16:00.024', '2019-08-20 15:16:00.024', '', NULL);
INSERT INTO `sys_job_log` VALUES (2085, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:16:15.014', '2019-08-20 15:16:15.014', '2019-08-20 15:16:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2086, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:16:30.014', '2019-08-20 15:16:30.014', '2019-08-20 15:16:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2087, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:16:45.015', '2019-08-20 15:16:45.016', '2019-08-20 15:16:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2088, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:17:00.018', '2019-08-20 15:17:00.018', '2019-08-20 15:17:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2089, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:17:15.014', '2019-08-20 15:17:15.014', '2019-08-20 15:17:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2090, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:17:30.012', '2019-08-20 15:17:30.012', '2019-08-20 15:17:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2091, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:17:45.015', '2019-08-20 15:17:45.016', '2019-08-20 15:17:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2092, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:18:00.017', '2019-08-20 15:18:00.017', '2019-08-20 15:18:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2093, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:18:15.017', '2019-08-20 15:18:15.017', '2019-08-20 15:18:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2094, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:18:30.015', '2019-08-20 15:18:30.015', '2019-08-20 15:18:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2095, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:18:45.015', '2019-08-20 15:18:45.015', '2019-08-20 15:18:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2096, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:19:00.016', '2019-08-20 15:19:00.016', '2019-08-20 15:19:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2097, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:19:15.014', '2019-08-20 15:19:15.015', '2019-08-20 15:19:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2098, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:19:30.014', '2019-08-20 15:19:30.014', '2019-08-20 15:19:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2099, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:19:45.015', '2019-08-20 15:19:45.016', '2019-08-20 15:19:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2100, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:20:00.015', '2019-08-20 15:20:00.015', '2019-08-20 15:20:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2101, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:20:15.020', '2019-08-20 15:20:15.020', '2019-08-20 15:20:15.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2102, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:20:30.014', '2019-08-20 15:20:30.015', '2019-08-20 15:20:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2103, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:20:45.015', '2019-08-20 15:20:45.015', '2019-08-20 15:20:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2104, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:21:00.017', '2019-08-20 15:21:00.017', '2019-08-20 15:21:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2105, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:21:15.015', '2019-08-20 15:21:15.015', '2019-08-20 15:21:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2106, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:21:30.016', '2019-08-20 15:21:30.016', '2019-08-20 15:21:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2107, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:21:45.014', '2019-08-20 15:21:45.014', '2019-08-20 15:21:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2108, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:22:00.016', '2019-08-20 15:22:00.016', '2019-08-20 15:22:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2109, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:22:15.021', '2019-08-20 15:22:15.021', '2019-08-20 15:22:15.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2110, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:22:30.014', '2019-08-20 15:22:30.014', '2019-08-20 15:22:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2111, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:22:45.019', '2019-08-20 15:22:45.020', '2019-08-20 15:22:45.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2112, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:23:00.018', '2019-08-20 15:23:00.019', '2019-08-20 15:23:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2113, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:23:15.015', '2019-08-20 15:23:15.015', '2019-08-20 15:23:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2114, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:23:30.014', '2019-08-20 15:23:30.014', '2019-08-20 15:23:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2115, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:23:45.014', '2019-08-20 15:23:45.014', '2019-08-20 15:23:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2116, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:24:00.018', '2019-08-20 15:24:00.018', '2019-08-20 15:24:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2117, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:24:15.016', '2019-08-20 15:24:15.016', '2019-08-20 15:24:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2118, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:24:30.018', '2019-08-20 15:24:30.018', '2019-08-20 15:24:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2119, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:24:45.015', '2019-08-20 15:24:45.015', '2019-08-20 15:24:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2120, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:25:00.020', '2019-08-20 15:25:00.020', '2019-08-20 15:25:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2121, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:25:15.014', '2019-08-20 15:25:15.014', '2019-08-20 15:25:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2122, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:25:30.014', '2019-08-20 15:25:30.014', '2019-08-20 15:25:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2123, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:25:45.015', '2019-08-20 15:25:45.015', '2019-08-20 15:25:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2124, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:26:00.017', '2019-08-20 15:26:00.017', '2019-08-20 15:26:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2125, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:26:15.016', '2019-08-20 15:26:15.016', '2019-08-20 15:26:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2126, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:26:30.016', '2019-08-20 15:26:30.016', '2019-08-20 15:26:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2127, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:26:45.014', '2019-08-20 15:26:45.014', '2019-08-20 15:26:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2128, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:27:00.017', '2019-08-20 15:27:00.017', '2019-08-20 15:27:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2129, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:27:15.015', '2019-08-20 15:27:15.015', '2019-08-20 15:27:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2130, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:27:30.013', '2019-08-20 15:27:30.014', '2019-08-20 15:27:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2131, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:27:45.014', '2019-08-20 15:27:45.014', '2019-08-20 15:27:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2132, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:28:00.017', '2019-08-20 15:28:00.018', '2019-08-20 15:28:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2133, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:28:15.015', '2019-08-20 15:28:15.015', '2019-08-20 15:28:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2134, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:28:30.018', '2019-08-20 15:28:30.018', '2019-08-20 15:28:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2135, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:28:45.017', '2019-08-20 15:28:45.017', '2019-08-20 15:28:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2136, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:29:00.016', '2019-08-20 15:29:00.017', '2019-08-20 15:29:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2137, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:29:15.014', '2019-08-20 15:29:15.014', '2019-08-20 15:29:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2138, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:29:30.017', '2019-08-20 15:29:30.017', '2019-08-20 15:29:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2139, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:29:45.016', '2019-08-20 15:29:45.016', '2019-08-20 15:29:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2140, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:30:00.018', '2019-08-20 15:30:00.018', '2019-08-20 15:30:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2141, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:30:15.013', '2019-08-20 15:30:15.013', '2019-08-20 15:30:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2142, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:30:30.019', '2019-08-20 15:30:30.019', '2019-08-20 15:30:30.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2143, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:30:45.013', '2019-08-20 15:30:45.014', '2019-08-20 15:30:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2144, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:31:00.018', '2019-08-20 15:31:00.018', '2019-08-20 15:31:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2145, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:31:15.018', '2019-08-20 15:31:15.018', '2019-08-20 15:31:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2146, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:31:30.015', '2019-08-20 15:31:30.015', '2019-08-20 15:31:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2147, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:31:45.015', '2019-08-20 15:31:45.015', '2019-08-20 15:31:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2148, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:32:00.019', '2019-08-20 15:32:00.019', '2019-08-20 15:32:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2149, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:32:15.014', '2019-08-20 15:32:15.014', '2019-08-20 15:32:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2150, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:32:30.016', '2019-08-20 15:32:30.016', '2019-08-20 15:32:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2151, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:32:45.017', '2019-08-20 15:32:45.017', '2019-08-20 15:32:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2152, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:33:00.017', '2019-08-20 15:33:00.017', '2019-08-20 15:33:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2153, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:33:15.016', '2019-08-20 15:33:15.016', '2019-08-20 15:33:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2154, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:33:30.015', '2019-08-20 15:33:30.015', '2019-08-20 15:33:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2155, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:33:45.021', '2019-08-20 15:33:45.021', '2019-08-20 15:33:45.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2156, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:34:00.019', '2019-08-20 15:34:00.019', '2019-08-20 15:34:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2157, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:34:15.014', '2019-08-20 15:34:15.015', '2019-08-20 15:34:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2158, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:34:30.015', '2019-08-20 15:34:30.015', '2019-08-20 15:34:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2159, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:34:45.021', '2019-08-20 15:34:45.022', '2019-08-20 15:34:45.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2160, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:35:00.016', '2019-08-20 15:35:00.017', '2019-08-20 15:35:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2161, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:35:15.015', '2019-08-20 15:35:15.015', '2019-08-20 15:35:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2162, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:35:30.019', '2019-08-20 15:35:30.019', '2019-08-20 15:35:30.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2163, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:35:45.018', '2019-08-20 15:35:45.018', '2019-08-20 15:35:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2164, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:36:00.018', '2019-08-20 15:36:00.018', '2019-08-20 15:36:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2165, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:36:15.015', '2019-08-20 15:36:15.015', '2019-08-20 15:36:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2166, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:36:30.016', '2019-08-20 15:36:30.016', '2019-08-20 15:36:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2167, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:36:45.021', '2019-08-20 15:36:45.021', '2019-08-20 15:36:45.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2168, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:37:00.016', '2019-08-20 15:37:00.016', '2019-08-20 15:37:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2169, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:37:15.014', '2019-08-20 15:37:15.014', '2019-08-20 15:37:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2170, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:37:30.013', '2019-08-20 15:37:30.014', '2019-08-20 15:37:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2171, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:37:45.013', '2019-08-20 15:37:45.013', '2019-08-20 15:37:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2172, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:38:00.015', '2019-08-20 15:38:00.016', '2019-08-20 15:38:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2173, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:38:15.014', '2019-08-20 15:38:15.014', '2019-08-20 15:38:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2174, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:38:30.015', '2019-08-20 15:38:30.015', '2019-08-20 15:38:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2175, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:38:45.023', '2019-08-20 15:38:45.023', '2019-08-20 15:38:45.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (2176, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:39:00.016', '2019-08-20 15:39:00.016', '2019-08-20 15:39:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2177, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:39:15.012', '2019-08-20 15:39:15.012', '2019-08-20 15:39:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2178, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:39:30.013', '2019-08-20 15:39:30.013', '2019-08-20 15:39:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2179, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:39:45.013', '2019-08-20 15:39:45.013', '2019-08-20 15:39:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2180, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:40:00.021', '2019-08-20 15:40:00.021', '2019-08-20 15:40:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2181, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:40:15.013', '2019-08-20 15:40:15.013', '2019-08-20 15:40:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2182, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:40:30.014', '2019-08-20 15:40:30.014', '2019-08-20 15:40:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2183, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:40:45.017', '2019-08-20 15:40:45.018', '2019-08-20 15:40:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2184, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:41:00.026', '2019-08-20 15:41:00.026', '2019-08-20 15:41:00.026', '', NULL);
INSERT INTO `sys_job_log` VALUES (2185, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:41:15.013', '2019-08-20 15:41:15.013', '2019-08-20 15:41:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2186, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:41:30.017', '2019-08-20 15:41:30.017', '2019-08-20 15:41:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2187, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:41:45.014', '2019-08-20 15:41:45.014', '2019-08-20 15:41:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2188, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:42:00.017', '2019-08-20 15:42:00.017', '2019-08-20 15:42:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2189, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:42:15.013', '2019-08-20 15:42:15.013', '2019-08-20 15:42:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2190, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:42:30.014', '2019-08-20 15:42:30.014', '2019-08-20 15:42:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2191, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:42:45.019', '2019-08-20 15:42:45.019', '2019-08-20 15:42:45.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2192, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:43:00.016', '2019-08-20 15:43:00.016', '2019-08-20 15:43:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2193, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:43:15.015', '2019-08-20 15:43:15.015', '2019-08-20 15:43:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2194, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:43:30.014', '2019-08-20 15:43:30.014', '2019-08-20 15:43:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2195, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:43:45.013', '2019-08-20 15:43:45.013', '2019-08-20 15:43:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2196, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:44:00.016', '2019-08-20 15:44:00.016', '2019-08-20 15:44:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2197, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:44:15.016', '2019-08-20 15:44:15.016', '2019-08-20 15:44:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2198, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:44:30.013', '2019-08-20 15:44:30.013', '2019-08-20 15:44:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2199, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:44:45.023', '2019-08-20 15:44:45.023', '2019-08-20 15:44:45.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (2200, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:45:00.016', '2019-08-20 15:45:00.016', '2019-08-20 15:45:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2201, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:45:15.014', '2019-08-20 15:45:15.014', '2019-08-20 15:45:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2202, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:45:30.014', '2019-08-20 15:45:30.014', '2019-08-20 15:45:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2203, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:45:45.014', '2019-08-20 15:45:45.014', '2019-08-20 15:45:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2204, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:46:00.017', '2019-08-20 15:46:00.017', '2019-08-20 15:46:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2205, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:46:15.014', '2019-08-20 15:46:15.014', '2019-08-20 15:46:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2206, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:46:30.014', '2019-08-20 15:46:30.014', '2019-08-20 15:46:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2207, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:46:45.020', '2019-08-20 15:46:45.020', '2019-08-20 15:46:45.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2208, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:47:00.017', '2019-08-20 15:47:00.017', '2019-08-20 15:47:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2209, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:47:15.014', '2019-08-20 15:47:15.014', '2019-08-20 15:47:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2210, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:47:30.014', '2019-08-20 15:47:30.015', '2019-08-20 15:47:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2211, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:47:45.013', '2019-08-20 15:47:45.014', '2019-08-20 15:47:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2212, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:48:00.017', '2019-08-20 15:48:00.017', '2019-08-20 15:48:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2213, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:48:15.014', '2019-08-20 15:48:15.014', '2019-08-20 15:48:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2214, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:48:30.014', '2019-08-20 15:48:30.014', '2019-08-20 15:48:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2215, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:48:45.015', '2019-08-20 15:48:45.015', '2019-08-20 15:48:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2216, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:49:00.020', '2019-08-20 15:49:00.020', '2019-08-20 15:49:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2217, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:49:15.015', '2019-08-20 15:49:15.015', '2019-08-20 15:49:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2218, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:49:30.013', '2019-08-20 15:49:30.013', '2019-08-20 15:49:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2219, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:49:45.015', '2019-08-20 15:49:45.015', '2019-08-20 15:49:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2220, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:50:00.016', '2019-08-20 15:50:00.016', '2019-08-20 15:50:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2221, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:50:15.015', '2019-08-20 15:50:15.015', '2019-08-20 15:50:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2222, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:50:30.015', '2019-08-20 15:50:30.015', '2019-08-20 15:50:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2223, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:50:45.018', '2019-08-20 15:50:45.018', '2019-08-20 15:50:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2224, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:51:00.019', '2019-08-20 15:51:00.019', '2019-08-20 15:51:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2225, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:51:15.014', '2019-08-20 15:51:15.014', '2019-08-20 15:51:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2226, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:51:30.015', '2019-08-20 15:51:30.015', '2019-08-20 15:51:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2227, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:51:45.015', '2019-08-20 15:51:45.015', '2019-08-20 15:51:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2228, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:52:00.016', '2019-08-20 15:52:00.017', '2019-08-20 15:52:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2229, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:52:15.014', '2019-08-20 15:52:15.014', '2019-08-20 15:52:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2230, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:52:30.014', '2019-08-20 15:52:30.014', '2019-08-20 15:52:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2231, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:52:45.013', '2019-08-20 15:52:45.013', '2019-08-20 15:52:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2232, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:53:00.020', '2019-08-20 15:53:00.020', '2019-08-20 15:53:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2233, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:53:15.014', '2019-08-20 15:53:15.014', '2019-08-20 15:53:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2234, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:53:30.015', '2019-08-20 15:53:30.015', '2019-08-20 15:53:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2235, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:53:45.014', '2019-08-20 15:53:45.014', '2019-08-20 15:53:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2236, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:54:00.017', '2019-08-20 15:54:00.018', '2019-08-20 15:54:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2237, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:54:15.014', '2019-08-20 15:54:15.014', '2019-08-20 15:54:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2238, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:54:30.013', '2019-08-20 15:54:30.013', '2019-08-20 15:54:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2239, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:54:45.013', '2019-08-20 15:54:45.014', '2019-08-20 15:54:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2240, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:55:00.019', '2019-08-20 15:55:00.019', '2019-08-20 15:55:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2241, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:55:15.014', '2019-08-20 15:55:15.014', '2019-08-20 15:55:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2242, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:55:30.015', '2019-08-20 15:55:30.015', '2019-08-20 15:55:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2243, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:55:45.014', '2019-08-20 15:55:45.014', '2019-08-20 15:55:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2244, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:56:00.017', '2019-08-20 15:56:00.017', '2019-08-20 15:56:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2245, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:56:15.015', '2019-08-20 15:56:15.016', '2019-08-20 15:56:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2246, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:56:30.013', '2019-08-20 15:56:30.013', '2019-08-20 15:56:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2247, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:56:45.015', '2019-08-20 15:56:45.015', '2019-08-20 15:56:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2248, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:57:00.022', '2019-08-20 15:57:00.022', '2019-08-20 15:57:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2249, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:57:15.014', '2019-08-20 15:57:15.014', '2019-08-20 15:57:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2250, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:57:30.015', '2019-08-20 15:57:30.015', '2019-08-20 15:57:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2251, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:57:45.014', '2019-08-20 15:57:45.014', '2019-08-20 15:57:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2252, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:58:00.017', '2019-08-20 15:58:00.017', '2019-08-20 15:58:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2253, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:58:15.013', '2019-08-20 15:58:15.013', '2019-08-20 15:58:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2254, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:58:30.014', '2019-08-20 15:58:30.014', '2019-08-20 15:58:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2255, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:58:45.014', '2019-08-20 15:58:45.014', '2019-08-20 15:58:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2256, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:59:00.022', '2019-08-20 15:59:00.022', '2019-08-20 15:59:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2257, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 15:59:15.014', '2019-08-20 15:59:15.015', '2019-08-20 15:59:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2258, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:59:30.014', '2019-08-20 15:59:30.014', '2019-08-20 15:59:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2259, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 15:59:45.015', '2019-08-20 15:59:45.015', '2019-08-20 15:59:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2260, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:00:00.016', '2019-08-20 16:00:00.016', '2019-08-20 16:00:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2261, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:00:15.015', '2019-08-20 16:00:15.015', '2019-08-20 16:00:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2262, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:00:30.013', '2019-08-20 16:00:30.013', '2019-08-20 16:00:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2263, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:00:45.014', '2019-08-20 16:00:45.014', '2019-08-20 16:00:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2264, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:01:00.021', '2019-08-20 16:01:00.021', '2019-08-20 16:01:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2265, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:01:15.015', '2019-08-20 16:01:15.015', '2019-08-20 16:01:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2266, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:01:30.015', '2019-08-20 16:01:30.016', '2019-08-20 16:01:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2267, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:01:45.013', '2019-08-20 16:01:45.013', '2019-08-20 16:01:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2268, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:02:00.016', '2019-08-20 16:02:00.016', '2019-08-20 16:02:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2269, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:02:15.014', '2019-08-20 16:02:15.014', '2019-08-20 16:02:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2270, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:02:30.015', '2019-08-20 16:02:30.015', '2019-08-20 16:02:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2271, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:02:45.018', '2019-08-20 16:02:45.018', '2019-08-20 16:02:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2272, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:03:00.021', '2019-08-20 16:03:00.021', '2019-08-20 16:03:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2273, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:03:15.013', '2019-08-20 16:03:15.013', '2019-08-20 16:03:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2274, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:03:30.014', '2019-08-20 16:03:30.015', '2019-08-20 16:03:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2275, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:03:45.015', '2019-08-20 16:03:45.016', '2019-08-20 16:03:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2276, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:04:00.018', '2019-08-20 16:04:00.018', '2019-08-20 16:04:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2277, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:04:15.016', '2019-08-20 16:04:15.016', '2019-08-20 16:04:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2278, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:04:30.020', '2019-08-20 16:04:30.020', '2019-08-20 16:04:30.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2279, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:04:45.015', '2019-08-20 16:04:45.015', '2019-08-20 16:04:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2280, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:05:00.019', '2019-08-20 16:05:00.019', '2019-08-20 16:05:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2281, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:05:15.018', '2019-08-20 16:05:15.019', '2019-08-20 16:05:15.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2282, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:05:30.014', '2019-08-20 16:05:30.015', '2019-08-20 16:05:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2283, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:05:45.015', '2019-08-20 16:05:45.015', '2019-08-20 16:05:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2284, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:06:00.019', '2019-08-20 16:06:00.019', '2019-08-20 16:06:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2285, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:06:15.015', '2019-08-20 16:06:15.015', '2019-08-20 16:06:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2286, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:06:30.017', '2019-08-20 16:06:30.017', '2019-08-20 16:06:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2287, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:06:45.016', '2019-08-20 16:06:45.016', '2019-08-20 16:06:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2288, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:07:00.021', '2019-08-20 16:07:00.021', '2019-08-20 16:07:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2289, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:07:15.018', '2019-08-20 16:07:15.019', '2019-08-20 16:07:15.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2290, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:07:30.015', '2019-08-20 16:07:30.015', '2019-08-20 16:07:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2291, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:07:45.014', '2019-08-20 16:07:45.014', '2019-08-20 16:07:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2292, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:08:00.017', '2019-08-20 16:08:00.018', '2019-08-20 16:08:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2293, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:08:15.015', '2019-08-20 16:08:15.015', '2019-08-20 16:08:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2294, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:08:30.017', '2019-08-20 16:08:30.018', '2019-08-20 16:08:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2295, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:08:45.013', '2019-08-20 16:08:45.013', '2019-08-20 16:08:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2296, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:09:00.019', '2019-08-20 16:09:00.019', '2019-08-20 16:09:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2297, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:09:15.018', '2019-08-20 16:09:15.018', '2019-08-20 16:09:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2298, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:09:30.015', '2019-08-20 16:09:30.015', '2019-08-20 16:09:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2299, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:09:45.014', '2019-08-20 16:09:45.014', '2019-08-20 16:09:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2300, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:10:00.019', '2019-08-20 16:10:00.019', '2019-08-20 16:10:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2301, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:10:15.016', '2019-08-20 16:10:15.016', '2019-08-20 16:10:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2302, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:10:30.015', '2019-08-20 16:10:30.015', '2019-08-20 16:10:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2303, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:10:45.014', '2019-08-20 16:10:45.014', '2019-08-20 16:10:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2304, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:11:00.019', '2019-08-20 16:11:00.019', '2019-08-20 16:11:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2305, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:11:15.018', '2019-08-20 16:11:15.018', '2019-08-20 16:11:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2306, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:11:30.015', '2019-08-20 16:11:30.015', '2019-08-20 16:11:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2307, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:11:45.015', '2019-08-20 16:11:45.015', '2019-08-20 16:11:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2308, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:12:00.017', '2019-08-20 16:12:00.017', '2019-08-20 16:12:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2309, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:12:15.019', '2019-08-20 16:12:15.019', '2019-08-20 16:12:15.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2310, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:12:30.014', '2019-08-20 16:12:30.014', '2019-08-20 16:12:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2311, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:12:45.014', '2019-08-20 16:12:45.014', '2019-08-20 16:12:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2312, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:13:00.017', '2019-08-20 16:13:00.017', '2019-08-20 16:13:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2313, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:13:15.014', '2019-08-20 16:13:15.014', '2019-08-20 16:13:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2314, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:13:30.018', '2019-08-20 16:13:30.018', '2019-08-20 16:13:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2315, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:13:45.014', '2019-08-20 16:13:45.014', '2019-08-20 16:13:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2316, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:14:00.015', '2019-08-20 16:14:00.015', '2019-08-20 16:14:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2317, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:14:15.014', '2019-08-20 16:14:15.014', '2019-08-20 16:14:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2318, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:14:30.013', '2019-08-20 16:14:30.013', '2019-08-20 16:14:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2319, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:14:45.015', '2019-08-20 16:14:45.016', '2019-08-20 16:14:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2320, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:15:00.015', '2019-08-20 16:15:00.016', '2019-08-20 16:15:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2321, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:15:15.015', '2019-08-20 16:15:15.015', '2019-08-20 16:15:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2322, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:15:30.018', '2019-08-20 16:15:30.018', '2019-08-20 16:15:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2323, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:15:45.014', '2019-08-20 16:15:45.014', '2019-08-20 16:15:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2324, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:16:00.018', '2019-08-20 16:16:00.018', '2019-08-20 16:16:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2325, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:16:15.015', '2019-08-20 16:16:15.015', '2019-08-20 16:16:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2326, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:16:30.014', '2019-08-20 16:16:30.014', '2019-08-20 16:16:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2327, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:16:45.014', '2019-08-20 16:16:45.014', '2019-08-20 16:16:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2328, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:17:00.017', '2019-08-20 16:17:00.017', '2019-08-20 16:17:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2329, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:17:15.013', '2019-08-20 16:17:15.014', '2019-08-20 16:17:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2330, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:17:30.015', '2019-08-20 16:17:30.015', '2019-08-20 16:17:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2331, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:17:45.020', '2019-08-20 16:17:45.021', '2019-08-20 16:17:45.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2332, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:18:00.015', '2019-08-20 16:18:00.016', '2019-08-20 16:18:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2333, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:18:15.014', '2019-08-20 16:18:15.014', '2019-08-20 16:18:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2334, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:18:30.014', '2019-08-20 16:18:30.014', '2019-08-20 16:18:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2335, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:18:45.014', '2019-08-20 16:18:45.014', '2019-08-20 16:18:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2336, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:19:00.015', '2019-08-20 16:19:00.016', '2019-08-20 16:19:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2337, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:19:15.015', '2019-08-20 16:19:15.015', '2019-08-20 16:19:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2338, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:19:30.017', '2019-08-20 16:19:30.018', '2019-08-20 16:19:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2339, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:19:45.019', '2019-08-20 16:19:45.019', '2019-08-20 16:19:45.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2340, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:20:00.050', '2019-08-20 16:20:00.051', '2019-08-20 16:20:00.051', '', NULL);
INSERT INTO `sys_job_log` VALUES (2341, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:20:15.017', '2019-08-20 16:20:15.017', '2019-08-20 16:20:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2342, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:20:30.016', '2019-08-20 16:20:30.016', '2019-08-20 16:20:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2343, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:20:45.013', '2019-08-20 16:20:45.013', '2019-08-20 16:20:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2344, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:21:00.023', '2019-08-20 16:21:00.023', '2019-08-20 16:21:00.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (2345, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:21:15.023', '2019-08-20 16:21:15.023', '2019-08-20 16:21:15.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (2346, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:21:30.024', '2019-08-20 16:21:30.024', '2019-08-20 16:21:30.024', '', NULL);
INSERT INTO `sys_job_log` VALUES (2347, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:21:45.016', '2019-08-20 16:21:45.016', '2019-08-20 16:21:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2348, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:22:00.021', '2019-08-20 16:22:00.021', '2019-08-20 16:22:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2349, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:22:15.019', '2019-08-20 16:22:15.019', '2019-08-20 16:22:15.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2350, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:22:30.016', '2019-08-20 16:22:30.016', '2019-08-20 16:22:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2351, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:22:45.015', '2019-08-20 16:22:45.015', '2019-08-20 16:22:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2352, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:23:00.021', '2019-08-20 16:23:00.021', '2019-08-20 16:23:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2353, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:23:15.016', '2019-08-20 16:23:15.016', '2019-08-20 16:23:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2354, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:23:30.013', '2019-08-20 16:23:30.014', '2019-08-20 16:23:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2355, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:23:45.015', '2019-08-20 16:23:45.015', '2019-08-20 16:23:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2356, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:24:00.017', '2019-08-20 16:24:00.018', '2019-08-20 16:24:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2357, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:24:15.020', '2019-08-20 16:24:15.020', '2019-08-20 16:24:15.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2358, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:24:30.016', '2019-08-20 16:24:30.016', '2019-08-20 16:24:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2359, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:24:45.016', '2019-08-20 16:24:45.017', '2019-08-20 16:24:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2360, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:25:00.018', '2019-08-20 16:25:00.019', '2019-08-20 16:25:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2361, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:25:15.014', '2019-08-20 16:25:15.014', '2019-08-20 16:25:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2362, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:25:30.015', '2019-08-20 16:25:30.015', '2019-08-20 16:25:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2363, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:25:45.014', '2019-08-20 16:25:45.014', '2019-08-20 16:25:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2364, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:26:00.028', '2019-08-20 16:26:00.028', '2019-08-20 16:26:00.028', '', NULL);
INSERT INTO `sys_job_log` VALUES (2365, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:26:15.023', '2019-08-20 16:26:15.023', '2019-08-20 16:26:15.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (2366, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:26:30.014', '2019-08-20 16:26:30.014', '2019-08-20 16:26:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2367, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:26:45.015', '2019-08-20 16:26:45.015', '2019-08-20 16:26:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2368, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:27:00.018', '2019-08-20 16:27:00.018', '2019-08-20 16:27:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2369, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:27:15.016', '2019-08-20 16:27:15.016', '2019-08-20 16:27:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2370, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:27:30.014', '2019-08-20 16:27:30.014', '2019-08-20 16:27:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2371, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:27:45.016', '2019-08-20 16:27:45.017', '2019-08-20 16:27:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2372, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:28:00.017', '2019-08-20 16:28:00.017', '2019-08-20 16:28:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2373, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:28:15.015', '2019-08-20 16:28:15.015', '2019-08-20 16:28:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2374, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:28:30.017', '2019-08-20 16:28:30.017', '2019-08-20 16:28:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2375, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:28:45.015', '2019-08-20 16:28:45.015', '2019-08-20 16:28:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2376, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:29:00.017', '2019-08-20 16:29:00.017', '2019-08-20 16:29:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2377, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:29:15.015', '2019-08-20 16:29:15.015', '2019-08-20 16:29:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2378, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:29:30.015', '2019-08-20 16:29:30.015', '2019-08-20 16:29:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2379, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:29:45.014', '2019-08-20 16:29:45.014', '2019-08-20 16:29:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2380, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:30:00.018', '2019-08-20 16:30:00.018', '2019-08-20 16:30:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2381, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:30:15.015', '2019-08-20 16:30:15.015', '2019-08-20 16:30:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2382, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:30:30.031', '2019-08-20 16:30:30.031', '2019-08-20 16:30:30.031', '', NULL);
INSERT INTO `sys_job_log` VALUES (2383, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:30:45.015', '2019-08-20 16:30:45.015', '2019-08-20 16:30:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2384, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:31:00.018', '2019-08-20 16:31:00.018', '2019-08-20 16:31:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2385, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:31:15.013', '2019-08-20 16:31:15.013', '2019-08-20 16:31:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2386, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:31:30.016', '2019-08-20 16:31:30.016', '2019-08-20 16:31:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2387, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:31:45.016', '2019-08-20 16:31:45.016', '2019-08-20 16:31:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2388, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:32:00.020', '2019-08-20 16:32:00.020', '2019-08-20 16:32:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2389, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:32:15.015', '2019-08-20 16:32:15.015', '2019-08-20 16:32:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2390, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:32:30.020', '2019-08-20 16:32:30.020', '2019-08-20 16:32:30.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2391, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:32:45.014', '2019-08-20 16:32:45.014', '2019-08-20 16:32:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2392, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:33:00.019', '2019-08-20 16:33:00.020', '2019-08-20 16:33:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2393, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:33:15.027', '2019-08-20 16:33:15.027', '2019-08-20 16:33:15.027', '', NULL);
INSERT INTO `sys_job_log` VALUES (2394, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:33:30.018', '2019-08-20 16:33:30.018', '2019-08-20 16:33:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2395, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:33:45.015', '2019-08-20 16:33:45.015', '2019-08-20 16:33:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2396, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:34:00.016', '2019-08-20 16:34:00.016', '2019-08-20 16:34:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2397, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:34:15.014', '2019-08-20 16:34:15.014', '2019-08-20 16:34:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2398, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:34:30.018', '2019-08-20 16:34:30.018', '2019-08-20 16:34:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2399, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:34:45.015', '2019-08-20 16:34:45.015', '2019-08-20 16:34:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2400, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:35:00.017', '2019-08-20 16:35:00.017', '2019-08-20 16:35:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2401, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:35:15.014', '2019-08-20 16:35:15.014', '2019-08-20 16:35:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2402, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:35:30.012', '2019-08-20 16:35:30.012', '2019-08-20 16:35:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2403, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:35:45.013', '2019-08-20 16:35:45.013', '2019-08-20 16:35:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2404, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:36:00.015', '2019-08-20 16:36:00.015', '2019-08-20 16:36:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2405, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:36:15.014', '2019-08-20 16:36:15.015', '2019-08-20 16:36:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2406, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:36:30.018', '2019-08-20 16:36:30.018', '2019-08-20 16:36:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2407, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:36:45.012', '2019-08-20 16:36:45.013', '2019-08-20 16:36:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2408, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:37:00.016', '2019-08-20 16:37:00.016', '2019-08-20 16:37:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2409, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:37:15.014', '2019-08-20 16:37:15.014', '2019-08-20 16:37:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2410, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:37:30.014', '2019-08-20 16:37:30.014', '2019-08-20 16:37:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2411, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:37:45.014', '2019-08-20 16:37:45.014', '2019-08-20 16:37:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2412, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:38:00.017', '2019-08-20 16:38:00.017', '2019-08-20 16:38:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2413, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:38:15.014', '2019-08-20 16:38:15.014', '2019-08-20 16:38:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2414, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:38:30.018', '2019-08-20 16:38:30.018', '2019-08-20 16:38:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2415, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:38:45.016', '2019-08-20 16:38:45.016', '2019-08-20 16:38:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2416, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:39:00.023', '2019-08-20 16:39:00.023', '2019-08-20 16:39:00.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (2417, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:39:15.017', '2019-08-20 16:39:15.017', '2019-08-20 16:39:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2418, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:39:30.015', '2019-08-20 16:39:30.015', '2019-08-20 16:39:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2419, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:39:45.015', '2019-08-20 16:39:45.015', '2019-08-20 16:39:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2420, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:40:00.019', '2019-08-20 16:40:00.019', '2019-08-20 16:40:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2421, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:40:15.015', '2019-08-20 16:40:15.015', '2019-08-20 16:40:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2422, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:40:30.014', '2019-08-20 16:40:30.015', '2019-08-20 16:40:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2423, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:40:45.015', '2019-08-20 16:40:45.015', '2019-08-20 16:40:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2424, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:41:00.016', '2019-08-20 16:41:00.016', '2019-08-20 16:41:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2425, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:41:15.016', '2019-08-20 16:41:15.016', '2019-08-20 16:41:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2426, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:41:30.013', '2019-08-20 16:41:30.013', '2019-08-20 16:41:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2427, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:41:45.016', '2019-08-20 16:41:45.016', '2019-08-20 16:41:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2428, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:42:00.018', '2019-08-20 16:42:00.018', '2019-08-20 16:42:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2429, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:42:15.016', '2019-08-20 16:42:15.016', '2019-08-20 16:42:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2430, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:42:30.014', '2019-08-20 16:42:30.014', '2019-08-20 16:42:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2431, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:42:45.018', '2019-08-20 16:42:45.018', '2019-08-20 16:42:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2432, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:43:00.018', '2019-08-20 16:43:00.018', '2019-08-20 16:43:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2433, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:43:15.014', '2019-08-20 16:43:15.014', '2019-08-20 16:43:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2434, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:43:30.013', '2019-08-20 16:43:30.014', '2019-08-20 16:43:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2435, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:43:45.014', '2019-08-20 16:43:45.015', '2019-08-20 16:43:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2436, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:44:00.016', '2019-08-20 16:44:00.016', '2019-08-20 16:44:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2437, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:44:15.017', '2019-08-20 16:44:15.017', '2019-08-20 16:44:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2438, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:44:30.017', '2019-08-20 16:44:30.017', '2019-08-20 16:44:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2439, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:44:45.020', '2019-08-20 16:44:45.020', '2019-08-20 16:44:45.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2440, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:45:00.016', '2019-08-20 16:45:00.016', '2019-08-20 16:45:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2441, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:45:15.017', '2019-08-20 16:45:15.017', '2019-08-20 16:45:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2442, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:45:30.014', '2019-08-20 16:45:30.014', '2019-08-20 16:45:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2443, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:45:45.026', '2019-08-20 16:45:45.026', '2019-08-20 16:45:45.026', '', NULL);
INSERT INTO `sys_job_log` VALUES (2444, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:46:00.016', '2019-08-20 16:46:00.016', '2019-08-20 16:46:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2445, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:46:15.039', '2019-08-20 16:46:15.040', '2019-08-20 16:46:15.040', '', NULL);
INSERT INTO `sys_job_log` VALUES (2446, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:46:30.032', '2019-08-20 16:46:30.032', '2019-08-20 16:46:30.032', '', NULL);
INSERT INTO `sys_job_log` VALUES (2447, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:46:45.014', '2019-08-20 16:46:45.014', '2019-08-20 16:46:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2448, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:47:00.019', '2019-08-20 16:47:00.019', '2019-08-20 16:47:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2449, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:47:15.015', '2019-08-20 16:47:15.015', '2019-08-20 16:47:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2450, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:47:30.015', '2019-08-20 16:47:30.015', '2019-08-20 16:47:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2451, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:47:45.016', '2019-08-20 16:47:45.016', '2019-08-20 16:47:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2452, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:48:00.015', '2019-08-20 16:48:00.015', '2019-08-20 16:48:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2453, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:48:15.021', '2019-08-20 16:48:15.021', '2019-08-20 16:48:15.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2454, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:48:30.013', '2019-08-20 16:48:30.013', '2019-08-20 16:48:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2455, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:48:45.014', '2019-08-20 16:48:45.014', '2019-08-20 16:48:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2456, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:49:00.020', '2019-08-20 16:49:00.020', '2019-08-20 16:49:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2457, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:49:15.015', '2019-08-20 16:49:15.015', '2019-08-20 16:49:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2458, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:49:30.013', '2019-08-20 16:49:30.013', '2019-08-20 16:49:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2459, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:49:45.013', '2019-08-20 16:49:45.013', '2019-08-20 16:49:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2460, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:50:00.040', '2019-08-20 16:50:00.041', '2019-08-20 16:50:00.041', '', NULL);
INSERT INTO `sys_job_log` VALUES (2461, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:50:15.015', '2019-08-20 16:50:15.015', '2019-08-20 16:50:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2462, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:50:30.016', '2019-08-20 16:50:30.016', '2019-08-20 16:50:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2463, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:50:45.014', '2019-08-20 16:50:45.014', '2019-08-20 16:50:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2464, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:51:00.026', '2019-08-20 16:51:00.026', '2019-08-20 16:51:00.026', '', NULL);
INSERT INTO `sys_job_log` VALUES (2465, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:51:15.015', '2019-08-20 16:51:15.015', '2019-08-20 16:51:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2466, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:51:30.015', '2019-08-20 16:51:30.015', '2019-08-20 16:51:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2467, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:51:45.015', '2019-08-20 16:51:45.015', '2019-08-20 16:51:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2468, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:52:00.017', '2019-08-20 16:52:00.017', '2019-08-20 16:52:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2469, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:52:15.016', '2019-08-20 16:52:15.017', '2019-08-20 16:52:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2470, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:52:30.016', '2019-08-20 16:52:30.016', '2019-08-20 16:52:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2471, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:52:45.015', '2019-08-20 16:52:45.015', '2019-08-20 16:52:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2472, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:53:00.027', '2019-08-20 16:53:00.027', '2019-08-20 16:53:00.027', '', NULL);
INSERT INTO `sys_job_log` VALUES (2473, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:53:15.025', '2019-08-20 16:53:15.026', '2019-08-20 16:53:15.026', '', NULL);
INSERT INTO `sys_job_log` VALUES (2474, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:53:30.025', '2019-08-20 16:53:30.026', '2019-08-20 16:53:30.026', '', NULL);
INSERT INTO `sys_job_log` VALUES (2475, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:53:45.016', '2019-08-20 16:53:45.017', '2019-08-20 16:53:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2476, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:54:00.020', '2019-08-20 16:54:00.020', '2019-08-20 16:54:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2477, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:54:15.014', '2019-08-20 16:54:15.014', '2019-08-20 16:54:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2478, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:54:30.014', '2019-08-20 16:54:30.014', '2019-08-20 16:54:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2479, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:54:45.015', '2019-08-20 16:54:45.015', '2019-08-20 16:54:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2480, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:55:00.018', '2019-08-20 16:55:00.018', '2019-08-20 16:55:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2481, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:55:15.019', '2019-08-20 16:55:15.019', '2019-08-20 16:55:15.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2482, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:55:30.015', '2019-08-20 16:55:30.015', '2019-08-20 16:55:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2483, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:55:45.014', '2019-08-20 16:55:45.014', '2019-08-20 16:55:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2484, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:56:00.023', '2019-08-20 16:56:00.023', '2019-08-20 16:56:00.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (2485, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:56:15.016', '2019-08-20 16:56:15.016', '2019-08-20 16:56:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2486, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:56:30.015', '2019-08-20 16:56:30.015', '2019-08-20 16:56:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2487, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:56:45.014', '2019-08-20 16:56:45.014', '2019-08-20 16:56:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2488, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:57:00.019', '2019-08-20 16:57:00.019', '2019-08-20 16:57:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2489, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:57:15.017', '2019-08-20 16:57:15.017', '2019-08-20 16:57:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2490, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:57:30.017', '2019-08-20 16:57:30.017', '2019-08-20 16:57:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2491, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 16:57:45.013', '2019-08-20 16:57:45.014', '2019-08-20 16:57:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2492, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:58:00.015', '2019-08-20 16:58:00.015', '2019-08-20 16:58:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2493, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:58:15.015', '2019-08-20 16:58:15.015', '2019-08-20 16:58:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2494, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:58:30.014', '2019-08-20 16:58:30.014', '2019-08-20 16:58:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2495, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:58:45.015', '2019-08-20 16:58:45.015', '2019-08-20 16:58:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2496, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:59:00.020', '2019-08-20 16:59:00.020', '2019-08-20 16:59:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2497, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:59:15.017', '2019-08-20 16:59:15.017', '2019-08-20 16:59:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2498, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:59:30.015', '2019-08-20 16:59:30.015', '2019-08-20 16:59:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2499, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 16:59:45.014', '2019-08-20 16:59:45.014', '2019-08-20 16:59:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2500, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:00:00.020', '2019-08-20 17:00:00.020', '2019-08-20 17:00:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2501, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:00:15.016', '2019-08-20 17:00:15.017', '2019-08-20 17:00:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2502, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:00:30.014', '2019-08-20 17:00:30.014', '2019-08-20 17:00:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2503, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:00:45.018', '2019-08-20 17:00:45.018', '2019-08-20 17:00:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2504, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:01:00.020', '2019-08-20 17:01:00.020', '2019-08-20 17:01:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2505, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:01:15.019', '2019-08-20 17:01:15.020', '2019-08-20 17:01:15.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2506, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:01:30.015', '2019-08-20 17:01:30.015', '2019-08-20 17:01:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2507, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:01:45.018', '2019-08-20 17:01:45.018', '2019-08-20 17:01:45.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2508, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:02:00.019', '2019-08-20 17:02:00.020', '2019-08-20 17:02:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2509, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:02:15.014', '2019-08-20 17:02:15.014', '2019-08-20 17:02:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2510, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:02:30.019', '2019-08-20 17:02:30.019', '2019-08-20 17:02:30.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2511, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:02:45.015', '2019-08-20 17:02:45.015', '2019-08-20 17:02:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2512, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:03:00.018', '2019-08-20 17:03:00.018', '2019-08-20 17:03:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2513, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:03:15.015', '2019-08-20 17:03:15.015', '2019-08-20 17:03:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2514, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:03:30.017', '2019-08-20 17:03:30.017', '2019-08-20 17:03:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2515, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:03:45.017', '2019-08-20 17:03:45.017', '2019-08-20 17:03:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2516, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:04:00.019', '2019-08-20 17:04:00.019', '2019-08-20 17:04:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2517, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:04:15.012', '2019-08-20 17:04:15.012', '2019-08-20 17:04:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2518, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:04:30.015', '2019-08-20 17:04:30.015', '2019-08-20 17:04:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2519, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:04:45.013', '2019-08-20 17:04:45.013', '2019-08-20 17:04:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2520, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:05:00.018', '2019-08-20 17:05:00.018', '2019-08-20 17:05:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2521, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:05:15.016', '2019-08-20 17:05:15.016', '2019-08-20 17:05:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2522, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:05:30.016', '2019-08-20 17:05:30.016', '2019-08-20 17:05:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2523, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:05:45.014', '2019-08-20 17:05:45.014', '2019-08-20 17:05:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2524, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:06:00.017', '2019-08-20 17:06:00.017', '2019-08-20 17:06:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2525, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:06:15.015', '2019-08-20 17:06:15.015', '2019-08-20 17:06:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2526, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:06:30.013', '2019-08-20 17:06:30.013', '2019-08-20 17:06:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2527, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:06:45.012', '2019-08-20 17:06:45.012', '2019-08-20 17:06:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2528, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:07:00.014', '2019-08-20 17:07:00.014', '2019-08-20 17:07:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2529, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:07:15.014', '2019-08-20 17:07:15.014', '2019-08-20 17:07:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2530, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:07:30.012', '2019-08-20 17:07:30.013', '2019-08-20 17:07:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2531, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:07:45.017', '2019-08-20 17:07:45.017', '2019-08-20 17:07:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2532, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:08:00.018', '2019-08-20 17:08:00.018', '2019-08-20 17:08:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2533, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:08:15.015', '2019-08-20 17:08:15.015', '2019-08-20 17:08:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2534, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:08:30.013', '2019-08-20 17:08:30.013', '2019-08-20 17:08:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2535, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:08:45.014', '2019-08-20 17:08:45.014', '2019-08-20 17:08:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2536, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:09:00.019', '2019-08-20 17:09:00.019', '2019-08-20 17:09:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2537, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:09:15.014', '2019-08-20 17:09:15.014', '2019-08-20 17:09:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2538, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:09:30.016', '2019-08-20 17:09:30.016', '2019-08-20 17:09:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2539, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:09:45.020', '2019-08-20 17:09:45.020', '2019-08-20 17:09:45.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2540, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:10:00.017', '2019-08-20 17:10:00.017', '2019-08-20 17:10:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2541, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:10:15.021', '2019-08-20 17:10:15.021', '2019-08-20 17:10:15.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2542, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:10:30.015', '2019-08-20 17:10:30.015', '2019-08-20 17:10:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2543, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:10:45.013', '2019-08-20 17:10:45.013', '2019-08-20 17:10:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2544, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:11:00.019', '2019-08-20 17:11:00.019', '2019-08-20 17:11:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2545, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:11:15.019', '2019-08-20 17:11:15.019', '2019-08-20 17:11:15.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2546, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:11:30.015', '2019-08-20 17:11:30.015', '2019-08-20 17:11:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2547, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:11:45.017', '2019-08-20 17:11:45.017', '2019-08-20 17:11:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2548, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:12:00.017', '2019-08-20 17:12:00.017', '2019-08-20 17:12:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2549, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:12:15.014', '2019-08-20 17:12:15.014', '2019-08-20 17:12:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2550, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:12:30.014', '2019-08-20 17:12:30.015', '2019-08-20 17:12:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2551, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:12:45.016', '2019-08-20 17:12:45.016', '2019-08-20 17:12:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2552, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:13:00.017', '2019-08-20 17:13:00.017', '2019-08-20 17:13:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2553, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:13:15.015', '2019-08-20 17:13:15.015', '2019-08-20 17:13:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2554, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:13:30.013', '2019-08-20 17:13:30.014', '2019-08-20 17:13:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2555, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:13:45.018', '2019-08-20 17:13:45.018', '2019-08-20 17:13:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2556, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:14:00.018', '2019-08-20 17:14:00.018', '2019-08-20 17:14:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2557, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:14:15.014', '2019-08-20 17:14:15.014', '2019-08-20 17:14:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2558, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:14:30.017', '2019-08-20 17:14:30.017', '2019-08-20 17:14:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2559, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:14:45.015', '2019-08-20 17:14:45.015', '2019-08-20 17:14:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2560, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:15:00.018', '2019-08-20 17:15:00.018', '2019-08-20 17:15:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2561, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:15:15.016', '2019-08-20 17:15:15.016', '2019-08-20 17:15:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2562, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:15:30.020', '2019-08-20 17:15:30.020', '2019-08-20 17:15:30.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2563, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:15:45.018', '2019-08-20 17:15:45.018', '2019-08-20 17:15:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2564, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:16:00.017', '2019-08-20 17:16:00.017', '2019-08-20 17:16:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2565, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:16:15.014', '2019-08-20 17:16:15.014', '2019-08-20 17:16:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2566, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:16:30.015', '2019-08-20 17:16:30.015', '2019-08-20 17:16:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2567, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:16:45.014', '2019-08-20 17:16:45.014', '2019-08-20 17:16:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2568, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:17:00.018', '2019-08-20 17:17:00.018', '2019-08-20 17:17:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2569, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:17:15.015', '2019-08-20 17:17:15.015', '2019-08-20 17:17:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2570, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:17:30.015', '2019-08-20 17:17:30.015', '2019-08-20 17:17:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2571, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:17:45.020', '2019-08-20 17:17:45.020', '2019-08-20 17:17:45.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2572, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:18:00.016', '2019-08-20 17:18:00.017', '2019-08-20 17:18:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2573, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:18:15.013', '2019-08-20 17:18:15.013', '2019-08-20 17:18:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2574, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:18:30.014', '2019-08-20 17:18:30.014', '2019-08-20 17:18:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2575, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:18:45.016', '2019-08-20 17:18:45.016', '2019-08-20 17:18:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2576, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:19:00.017', '2019-08-20 17:19:00.017', '2019-08-20 17:19:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2577, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:19:15.014', '2019-08-20 17:19:15.014', '2019-08-20 17:19:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2578, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:19:30.013', '2019-08-20 17:19:30.013', '2019-08-20 17:19:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2579, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:19:45.017', '2019-08-20 17:19:45.017', '2019-08-20 17:19:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2580, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:20:00.018', '2019-08-20 17:20:00.019', '2019-08-20 17:20:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2581, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:20:15.015', '2019-08-20 17:20:15.015', '2019-08-20 17:20:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2582, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:20:30.015', '2019-08-20 17:20:30.015', '2019-08-20 17:20:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2583, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:20:45.014', '2019-08-20 17:20:45.014', '2019-08-20 17:20:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2584, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:21:00.018', '2019-08-20 17:21:00.018', '2019-08-20 17:21:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2585, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:21:15.014', '2019-08-20 17:21:15.014', '2019-08-20 17:21:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2586, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:21:30.014', '2019-08-20 17:21:30.014', '2019-08-20 17:21:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2587, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:21:45.018', '2019-08-20 17:21:45.018', '2019-08-20 17:21:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2588, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:22:00.016', '2019-08-20 17:22:00.016', '2019-08-20 17:22:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2589, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:22:15.014', '2019-08-20 17:22:15.014', '2019-08-20 17:22:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2590, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:22:30.016', '2019-08-20 17:22:30.016', '2019-08-20 17:22:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2591, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:22:45.015', '2019-08-20 17:22:45.015', '2019-08-20 17:22:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2592, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:23:00.016', '2019-08-20 17:23:00.016', '2019-08-20 17:23:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2593, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:23:15.015', '2019-08-20 17:23:15.015', '2019-08-20 17:23:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2594, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:23:30.015', '2019-08-20 17:23:30.015', '2019-08-20 17:23:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2595, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:23:45.014', '2019-08-20 17:23:45.014', '2019-08-20 17:23:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2596, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:24:00.019', '2019-08-20 17:24:00.019', '2019-08-20 17:24:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2597, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:24:15.015', '2019-08-20 17:24:15.015', '2019-08-20 17:24:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2598, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:24:30.012', '2019-08-20 17:24:30.012', '2019-08-20 17:24:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2599, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:24:45.015', '2019-08-20 17:24:45.015', '2019-08-20 17:24:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2600, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:25:00.017', '2019-08-20 17:25:00.017', '2019-08-20 17:25:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2601, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:25:15.015', '2019-08-20 17:25:15.015', '2019-08-20 17:25:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2602, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:25:30.013', '2019-08-20 17:25:30.013', '2019-08-20 17:25:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2603, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:25:45.015', '2019-08-20 17:25:45.015', '2019-08-20 17:25:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2604, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:26:00.022', '2019-08-20 17:26:00.022', '2019-08-20 17:26:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2605, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:26:15.014', '2019-08-20 17:26:15.014', '2019-08-20 17:26:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2606, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:26:30.014', '2019-08-20 17:26:30.014', '2019-08-20 17:26:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2607, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:26:45.011', '2019-08-20 17:26:45.012', '2019-08-20 17:26:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2608, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:27:00.016', '2019-08-20 17:27:00.016', '2019-08-20 17:27:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2609, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:27:15.013', '2019-08-20 17:27:15.013', '2019-08-20 17:27:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2610, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:27:30.012', '2019-08-20 17:27:30.012', '2019-08-20 17:27:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2611, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:27:45.012', '2019-08-20 17:27:45.012', '2019-08-20 17:27:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2612, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:28:00.014', '2019-08-20 17:28:00.014', '2019-08-20 17:28:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2613, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:28:15.017', '2019-08-20 17:28:15.017', '2019-08-20 17:28:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2614, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:28:30.013', '2019-08-20 17:28:30.013', '2019-08-20 17:28:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2615, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:28:45.012', '2019-08-20 17:28:45.012', '2019-08-20 17:28:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2616, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:29:00.016', '2019-08-20 17:29:00.016', '2019-08-20 17:29:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2617, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:29:15.012', '2019-08-20 17:29:15.012', '2019-08-20 17:29:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2618, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:29:30.013', '2019-08-20 17:29:30.013', '2019-08-20 17:29:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2619, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:29:45.014', '2019-08-20 17:29:45.014', '2019-08-20 17:29:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2620, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:30:00.018', '2019-08-20 17:30:00.018', '2019-08-20 17:30:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2621, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:30:15.021', '2019-08-20 17:30:15.021', '2019-08-20 17:30:15.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2622, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:30:30.015', '2019-08-20 17:30:30.015', '2019-08-20 17:30:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2623, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:30:45.015', '2019-08-20 17:30:45.015', '2019-08-20 17:30:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2624, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:31:00.016', '2019-08-20 17:31:00.017', '2019-08-20 17:31:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2625, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:31:15.014', '2019-08-20 17:31:15.014', '2019-08-20 17:31:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2626, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:31:30.016', '2019-08-20 17:31:30.016', '2019-08-20 17:31:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2627, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:31:45.013', '2019-08-20 17:31:45.013', '2019-08-20 17:31:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2628, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:32:00.016', '2019-08-20 17:32:00.016', '2019-08-20 17:32:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2629, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:32:15.013', '2019-08-20 17:32:15.013', '2019-08-20 17:32:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2630, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:32:30.016', '2019-08-20 17:32:30.016', '2019-08-20 17:32:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2631, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:32:45.014', '2019-08-20 17:32:45.014', '2019-08-20 17:32:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2632, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:33:00.019', '2019-08-20 17:33:00.019', '2019-08-20 17:33:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2633, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:33:15.014', '2019-08-20 17:33:15.014', '2019-08-20 17:33:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2634, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:33:30.014', '2019-08-20 17:33:30.014', '2019-08-20 17:33:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2635, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:33:45.018', '2019-08-20 17:33:45.018', '2019-08-20 17:33:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2636, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:34:00.017', '2019-08-20 17:34:00.017', '2019-08-20 17:34:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2637, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:34:15.016', '2019-08-20 17:34:15.016', '2019-08-20 17:34:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2638, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:34:30.017', '2019-08-20 17:34:30.017', '2019-08-20 17:34:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2639, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:34:45.013', '2019-08-20 17:34:45.013', '2019-08-20 17:34:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2640, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:35:00.018', '2019-08-20 17:35:00.018', '2019-08-20 17:35:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2641, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:35:15.014', '2019-08-20 17:35:15.014', '2019-08-20 17:35:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2642, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:35:30.016', '2019-08-20 17:35:30.016', '2019-08-20 17:35:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2643, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:35:45.014', '2019-08-20 17:35:45.014', '2019-08-20 17:35:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2644, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:36:00.016', '2019-08-20 17:36:00.016', '2019-08-20 17:36:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2645, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:36:15.014', '2019-08-20 17:36:15.014', '2019-08-20 17:36:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2646, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:36:30.020', '2019-08-20 17:36:30.020', '2019-08-20 17:36:30.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2647, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:36:45.014', '2019-08-20 17:36:45.014', '2019-08-20 17:36:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2648, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:37:00.017', '2019-08-20 17:37:00.017', '2019-08-20 17:37:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2649, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:37:15.016', '2019-08-20 17:37:15.016', '2019-08-20 17:37:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2650, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:37:30.015', '2019-08-20 17:37:30.015', '2019-08-20 17:37:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2651, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:37:45.015', '2019-08-20 17:37:45.015', '2019-08-20 17:37:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2652, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:38:00.022', '2019-08-20 17:38:00.022', '2019-08-20 17:38:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2653, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:38:15.017', '2019-08-20 17:38:15.018', '2019-08-20 17:38:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2654, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:38:30.013', '2019-08-20 17:38:30.013', '2019-08-20 17:38:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2655, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:38:45.014', '2019-08-20 17:38:45.014', '2019-08-20 17:38:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2656, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:39:00.071', '2019-08-20 17:39:00.071', '2019-08-20 17:39:00.071', '', NULL);
INSERT INTO `sys_job_log` VALUES (2657, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:39:15.015', '2019-08-20 17:39:15.015', '2019-08-20 17:39:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2658, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:39:30.011', '2019-08-20 17:39:30.011', '2019-08-20 17:39:30.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (2659, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:39:45.013', '2019-08-20 17:39:45.013', '2019-08-20 17:39:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2660, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:40:00.015', '2019-08-20 17:40:00.015', '2019-08-20 17:40:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2661, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:40:15.014', '2019-08-20 17:40:15.014', '2019-08-20 17:40:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2662, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:40:30.013', '2019-08-20 17:40:30.014', '2019-08-20 17:40:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2663, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:40:45.015', '2019-08-20 17:40:45.015', '2019-08-20 17:40:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2664, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:41:00.017', '2019-08-20 17:41:00.017', '2019-08-20 17:41:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2665, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:41:15.013', '2019-08-20 17:41:15.013', '2019-08-20 17:41:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2666, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:41:30.014', '2019-08-20 17:41:30.014', '2019-08-20 17:41:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2667, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:41:45.013', '2019-08-20 17:41:45.013', '2019-08-20 17:41:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2668, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:42:00.017', '2019-08-20 17:42:00.017', '2019-08-20 17:42:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2669, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:42:15.013', '2019-08-20 17:42:15.013', '2019-08-20 17:42:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2670, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:42:30.014', '2019-08-20 17:42:30.014', '2019-08-20 17:42:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2671, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:42:45.016', '2019-08-20 17:42:45.016', '2019-08-20 17:42:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2672, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:43:00.016', '2019-08-20 17:43:00.016', '2019-08-20 17:43:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2673, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:43:15.015', '2019-08-20 17:43:15.015', '2019-08-20 17:43:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2674, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:43:30.014', '2019-08-20 17:43:30.014', '2019-08-20 17:43:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2675, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:43:45.013', '2019-08-20 17:43:45.013', '2019-08-20 17:43:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2676, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:44:00.016', '2019-08-20 17:44:00.016', '2019-08-20 17:44:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2677, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:44:15.016', '2019-08-20 17:44:15.016', '2019-08-20 17:44:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2678, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:44:30.014', '2019-08-20 17:44:30.014', '2019-08-20 17:44:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2679, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:44:45.019', '2019-08-20 17:44:45.019', '2019-08-20 17:44:45.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2680, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:45:00.017', '2019-08-20 17:45:00.017', '2019-08-20 17:45:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2681, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:45:15.016', '2019-08-20 17:45:15.016', '2019-08-20 17:45:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2682, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:45:30.013', '2019-08-20 17:45:30.013', '2019-08-20 17:45:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2683, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:45:45.016', '2019-08-20 17:45:45.016', '2019-08-20 17:45:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2684, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:46:00.018', '2019-08-20 17:46:00.018', '2019-08-20 17:46:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2685, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:46:15.015', '2019-08-20 17:46:15.015', '2019-08-20 17:46:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2686, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:46:30.015', '2019-08-20 17:46:30.015', '2019-08-20 17:46:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2687, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:46:45.014', '2019-08-20 17:46:45.014', '2019-08-20 17:46:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2688, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:47:00.020', '2019-08-20 17:47:00.020', '2019-08-20 17:47:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2689, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:47:15.012', '2019-08-20 17:47:15.012', '2019-08-20 17:47:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2690, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:47:30.015', '2019-08-20 17:47:30.015', '2019-08-20 17:47:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2691, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:47:45.014', '2019-08-20 17:47:45.014', '2019-08-20 17:47:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2692, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:48:00.017', '2019-08-20 17:48:00.017', '2019-08-20 17:48:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2693, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:48:15.014', '2019-08-20 17:48:15.014', '2019-08-20 17:48:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2694, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:48:30.013', '2019-08-20 17:48:30.013', '2019-08-20 17:48:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2695, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:48:45.018', '2019-08-20 17:48:45.018', '2019-08-20 17:48:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2696, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:49:00.017', '2019-08-20 17:49:00.017', '2019-08-20 17:49:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2697, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:49:15.014', '2019-08-20 17:49:15.014', '2019-08-20 17:49:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2698, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:49:30.016', '2019-08-20 17:49:30.016', '2019-08-20 17:49:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2699, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:49:45.015', '2019-08-20 17:49:45.015', '2019-08-20 17:49:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2700, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:50:00.015', '2019-08-20 17:50:00.015', '2019-08-20 17:50:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2701, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:50:15.014', '2019-08-20 17:50:15.014', '2019-08-20 17:50:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2702, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:50:30.013', '2019-08-20 17:50:30.013', '2019-08-20 17:50:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2703, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:50:45.018', '2019-08-20 17:50:45.018', '2019-08-20 17:50:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2704, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:51:00.017', '2019-08-20 17:51:00.017', '2019-08-20 17:51:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2705, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:51:15.013', '2019-08-20 17:51:15.014', '2019-08-20 17:51:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2706, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:51:30.013', '2019-08-20 17:51:30.013', '2019-08-20 17:51:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2707, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:51:45.013', '2019-08-20 17:51:45.013', '2019-08-20 17:51:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2708, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:52:00.017', '2019-08-20 17:52:00.017', '2019-08-20 17:52:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2709, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:52:15.013', '2019-08-20 17:52:15.013', '2019-08-20 17:52:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2710, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:52:30.015', '2019-08-20 17:52:30.015', '2019-08-20 17:52:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2711, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:52:45.015', '2019-08-20 17:52:45.015', '2019-08-20 17:52:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2712, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:53:00.019', '2019-08-20 17:53:00.019', '2019-08-20 17:53:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2713, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:53:15.015', '2019-08-20 17:53:15.015', '2019-08-20 17:53:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2714, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:53:30.013', '2019-08-20 17:53:30.013', '2019-08-20 17:53:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2715, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:53:45.014', '2019-08-20 17:53:45.014', '2019-08-20 17:53:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2716, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:54:00.016', '2019-08-20 17:54:00.016', '2019-08-20 17:54:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2717, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:54:15.014', '2019-08-20 17:54:15.014', '2019-08-20 17:54:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2718, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:54:30.014', '2019-08-20 17:54:30.014', '2019-08-20 17:54:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2719, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:54:45.013', '2019-08-20 17:54:45.013', '2019-08-20 17:54:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2720, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:55:00.021', '2019-08-20 17:55:00.021', '2019-08-20 17:55:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2721, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:55:15.018', '2019-08-20 17:55:15.018', '2019-08-20 17:55:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2722, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:55:30.014', '2019-08-20 17:55:30.014', '2019-08-20 17:55:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2723, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:55:45.013', '2019-08-20 17:55:45.013', '2019-08-20 17:55:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2724, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:56:00.016', '2019-08-20 17:56:00.016', '2019-08-20 17:56:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2725, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:56:15.018', '2019-08-20 17:56:15.018', '2019-08-20 17:56:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2726, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:56:30.014', '2019-08-20 17:56:30.014', '2019-08-20 17:56:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2727, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:56:45.014', '2019-08-20 17:56:45.014', '2019-08-20 17:56:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2728, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:57:00.022', '2019-08-20 17:57:00.022', '2019-08-20 17:57:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2729, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:57:15.014', '2019-08-20 17:57:15.015', '2019-08-20 17:57:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2730, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:57:30.014', '2019-08-20 17:57:30.014', '2019-08-20 17:57:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2731, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:57:45.013', '2019-08-20 17:57:45.013', '2019-08-20 17:57:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2732, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 17:58:00.017', '2019-08-20 17:58:00.018', '2019-08-20 17:58:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2733, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:58:15.015', '2019-08-20 17:58:15.015', '2019-08-20 17:58:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2734, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:58:30.018', '2019-08-20 17:58:30.018', '2019-08-20 17:58:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2735, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:58:45.012', '2019-08-20 17:58:45.012', '2019-08-20 17:58:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2736, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:59:00.022', '2019-08-20 17:59:00.022', '2019-08-20 17:59:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2737, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:59:15.013', '2019-08-20 17:59:15.013', '2019-08-20 17:59:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2738, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:59:30.014', '2019-08-20 17:59:30.014', '2019-08-20 17:59:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2739, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 17:59:45.015', '2019-08-20 17:59:45.015', '2019-08-20 17:59:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2740, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:00:00.024', '2019-08-20 18:00:00.024', '2019-08-20 18:00:00.024', '', NULL);
INSERT INTO `sys_job_log` VALUES (2741, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 18:00:15.012', '2019-08-20 18:00:15.013', '2019-08-20 18:00:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2742, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:00:30.015', '2019-08-20 18:00:30.015', '2019-08-20 18:00:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2743, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:00:45.013', '2019-08-20 18:00:45.013', '2019-08-20 18:00:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2744, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:01:00.022', '2019-08-20 18:01:00.022', '2019-08-20 18:01:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2745, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:01:15.019', '2019-08-20 18:01:15.019', '2019-08-20 18:01:15.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (2746, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:01:30.013', '2019-08-20 18:01:30.013', '2019-08-20 18:01:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2747, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:01:45.017', '2019-08-20 18:01:45.017', '2019-08-20 18:01:45.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2748, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:02:00.032', '2019-08-20 18:02:00.032', '2019-08-20 18:02:00.032', '', NULL);
INSERT INTO `sys_job_log` VALUES (2749, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:02:15.013', '2019-08-20 18:02:15.013', '2019-08-20 18:02:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2750, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:02:30.012', '2019-08-20 18:02:30.012', '2019-08-20 18:02:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2751, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:02:45.013', '2019-08-20 18:02:45.013', '2019-08-20 18:02:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2752, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:03:00.016', '2019-08-20 18:03:00.016', '2019-08-20 18:03:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2753, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:03:15.018', '2019-08-20 18:03:15.018', '2019-08-20 18:03:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2754, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:03:30.016', '2019-08-20 18:03:30.016', '2019-08-20 18:03:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2755, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:03:45.016', '2019-08-20 18:03:45.016', '2019-08-20 18:03:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2756, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:04:00.017', '2019-08-20 18:04:00.017', '2019-08-20 18:04:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2757, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 18:04:15.014', '2019-08-20 18:04:15.015', '2019-08-20 18:04:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2758, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:04:30.015', '2019-08-20 18:04:30.015', '2019-08-20 18:04:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2759, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:04:45.013', '2019-08-20 18:04:45.013', '2019-08-20 18:04:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2760, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:05:00.017', '2019-08-20 18:05:00.017', '2019-08-20 18:05:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2761, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:05:15.016', '2019-08-20 18:05:15.016', '2019-08-20 18:05:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2762, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:05:30.014', '2019-08-20 18:05:30.014', '2019-08-20 18:05:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2763, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:05:45.016', '2019-08-20 18:05:45.016', '2019-08-20 18:05:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2764, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:06:00.016', '2019-08-20 18:06:00.016', '2019-08-20 18:06:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2765, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:06:15.013', '2019-08-20 18:06:15.013', '2019-08-20 18:06:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2766, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:06:30.015', '2019-08-20 18:06:30.015', '2019-08-20 18:06:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2767, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:06:45.014', '2019-08-20 18:06:45.014', '2019-08-20 18:06:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2768, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:07:00.016', '2019-08-20 18:07:00.016', '2019-08-20 18:07:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2769, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:07:15.017', '2019-08-20 18:07:15.017', '2019-08-20 18:07:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2770, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:07:30.014', '2019-08-20 18:07:30.014', '2019-08-20 18:07:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2771, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:07:45.013', '2019-08-20 18:07:45.013', '2019-08-20 18:07:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2772, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:08:00.016', '2019-08-20 18:08:00.016', '2019-08-20 18:08:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2773, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:08:15.015', '2019-08-20 18:08:15.015', '2019-08-20 18:08:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2774, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:08:30.014', '2019-08-20 18:08:30.014', '2019-08-20 18:08:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2775, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:08:45.015', '2019-08-20 18:08:45.015', '2019-08-20 18:08:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2776, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:09:00.016', '2019-08-20 18:09:00.016', '2019-08-20 18:09:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2777, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:09:15.014', '2019-08-20 18:09:15.014', '2019-08-20 18:09:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2778, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:09:30.018', '2019-08-20 18:09:30.018', '2019-08-20 18:09:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2779, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:09:45.012', '2019-08-20 18:09:45.012', '2019-08-20 18:09:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2780, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:10:00.017', '2019-08-20 18:10:00.017', '2019-08-20 18:10:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2781, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:10:15.013', '2019-08-20 18:10:15.013', '2019-08-20 18:10:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2782, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:10:30.014', '2019-08-20 18:10:30.014', '2019-08-20 18:10:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2783, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:10:45.013', '2019-08-20 18:10:45.013', '2019-08-20 18:10:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2784, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 18:11:00.016', '2019-08-20 18:11:00.017', '2019-08-20 18:11:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2785, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:11:15.015', '2019-08-20 18:11:15.015', '2019-08-20 18:11:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2786, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:11:30.017', '2019-08-20 18:11:30.017', '2019-08-20 18:11:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2787, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:11:45.016', '2019-08-20 18:11:45.016', '2019-08-20 18:11:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2788, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:12:00.017', '2019-08-20 18:12:00.017', '2019-08-20 18:12:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2789, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:12:15.014', '2019-08-20 18:12:15.014', '2019-08-20 18:12:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2790, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 18:12:30.014', '2019-08-20 18:12:30.015', '2019-08-20 18:12:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2791, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:12:45.016', '2019-08-20 18:12:45.016', '2019-08-20 18:12:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2792, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:13:00.022', '2019-08-20 18:13:00.022', '2019-08-20 18:13:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2793, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:13:15.014', '2019-08-20 18:13:15.014', '2019-08-20 18:13:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2794, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:13:30.018', '2019-08-20 18:13:30.018', '2019-08-20 18:13:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2795, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:13:45.013', '2019-08-20 18:13:45.013', '2019-08-20 18:13:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2796, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:14:00.017', '2019-08-20 18:14:00.017', '2019-08-20 18:14:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2797, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:14:15.014', '2019-08-20 18:14:15.014', '2019-08-20 18:14:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2798, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:14:30.014', '2019-08-20 18:14:30.014', '2019-08-20 18:14:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2799, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:14:45.013', '2019-08-20 18:14:45.013', '2019-08-20 18:14:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2800, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:15:00.016', '2019-08-20 18:15:00.016', '2019-08-20 18:15:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2801, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:15:15.014', '2019-08-20 18:15:15.014', '2019-08-20 18:15:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2802, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:15:30.014', '2019-08-20 18:15:30.014', '2019-08-20 18:15:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2803, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:15:45.015', '2019-08-20 18:15:45.015', '2019-08-20 18:15:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2804, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:16:00.018', '2019-08-20 18:16:00.018', '2019-08-20 18:16:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2805, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:16:15.015', '2019-08-20 18:16:15.015', '2019-08-20 18:16:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2806, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:16:30.014', '2019-08-20 18:16:30.014', '2019-08-20 18:16:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2807, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:16:45.015', '2019-08-20 18:16:45.015', '2019-08-20 18:16:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2808, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:17:00.017', '2019-08-20 18:17:00.017', '2019-08-20 18:17:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2809, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:17:15.014', '2019-08-20 18:17:15.014', '2019-08-20 18:17:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2810, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:17:30.013', '2019-08-20 18:17:30.013', '2019-08-20 18:17:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2811, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:17:45.018', '2019-08-20 18:17:45.018', '2019-08-20 18:17:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2812, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:18:00.017', '2019-08-20 18:18:00.017', '2019-08-20 18:18:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2813, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-20 18:18:15.013', '2019-08-20 18:18:15.014', '2019-08-20 18:18:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2814, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:18:30.013', '2019-08-20 18:18:30.013', '2019-08-20 18:18:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (2815, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:18:45.014', '2019-08-20 18:18:45.014', '2019-08-20 18:18:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2816, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:19:00.017', '2019-08-20 18:19:00.017', '2019-08-20 18:19:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2817, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 18:19:15.012', '2019-08-20 18:19:15.012', '2019-08-20 18:19:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (2818, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-20 21:04:07.859', '2019-08-20 21:04:07.859', '2019-08-20 21:04:07.859', '', NULL);
INSERT INTO `sys_job_log` VALUES (2819, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：19毫秒', '1', '2019-10-01 15:11:19.650', '2019-10-01 15:11:19.669', '2019-10-01 15:11:19.669', '', NULL);
INSERT INTO `sys_job_log` VALUES (2820, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:11:30.020', '2019-10-01 15:11:30.020', '2019-10-01 15:11:30.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2821, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:11:45.022', '2019-10-01 15:11:45.022', '2019-10-01 15:11:45.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (2822, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:12:00.020', '2019-10-01 15:12:00.020', '2019-10-01 15:12:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2823, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-10-01 15:12:15.151', '2019-10-01 15:12:15.152', '2019-10-01 15:12:15.152', '', NULL);
INSERT INTO `sys_job_log` VALUES (2824, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:12:30.021', '2019-10-01 15:12:30.021', '2019-10-01 15:12:30.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2825, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:12:45.044', '2019-10-01 15:12:45.044', '2019-10-01 15:12:45.044', '', NULL);
INSERT INTO `sys_job_log` VALUES (2826, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-10-01 15:13:00.030', '2019-10-01 15:13:00.031', '2019-10-01 15:13:00.031', '', NULL);
INSERT INTO `sys_job_log` VALUES (2827, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:13:15.015', '2019-10-01 15:13:15.015', '2019-10-01 15:13:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2828, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-10-01 15:13:30.014', '2019-10-01 15:13:30.015', '2019-10-01 15:13:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2829, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:13:45.018', '2019-10-01 15:13:45.018', '2019-10-01 15:13:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2830, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:14:00.015', '2019-10-01 15:14:00.015', '2019-10-01 15:14:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (2831, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:14:15.016', '2019-10-01 15:14:15.016', '2019-10-01 15:14:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2832, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:14:30.018', '2019-10-01 15:14:30.018', '2019-10-01 15:14:30.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (2833, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:14:45.014', '2019-10-01 15:14:45.014', '2019-10-01 15:14:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2834, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-10-01 15:15:00.048', '2019-10-01 15:15:00.049', '2019-10-01 15:15:00.049', '', NULL);
INSERT INTO `sys_job_log` VALUES (2835, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:15:15.020', '2019-10-01 15:15:15.020', '2019-10-01 15:15:15.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (2836, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:15:30.030', '2019-10-01 15:15:30.030', '2019-10-01 15:15:30.030', '', NULL);
INSERT INTO `sys_job_log` VALUES (2837, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:15:45.016', '2019-10-01 15:15:45.016', '2019-10-01 15:15:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (2838, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-10-01 15:16:00.016', '2019-10-01 15:16:00.017', '2019-10-01 15:16:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2839, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 15:16:15.017', '2019-10-01 15:16:15.017', '2019-10-01 15:16:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (2840, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：11毫秒', '1', '2019-10-01 17:56:30.050', '2019-10-01 17:56:30.061', '2019-10-01 17:56:30.061', '', NULL);
INSERT INTO `sys_job_log` VALUES (2841, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-10-01 17:56:45.020', '2019-10-01 17:56:45.021', '2019-10-01 17:56:45.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (2842, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 17:57:00.024', '2019-10-01 17:57:00.024', '2019-10-01 17:57:00.024', '', NULL);
INSERT INTO `sys_job_log` VALUES (2843, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 17:57:15.040', '2019-10-01 17:57:15.040', '2019-10-01 17:57:15.040', '', NULL);
INSERT INTO `sys_job_log` VALUES (2844, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：10毫秒', '1', '2019-10-01 17:58:22.264', '2019-10-01 17:58:22.274', '2019-10-01 17:58:22.274', '', NULL);
INSERT INTO `sys_job_log` VALUES (2845, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-10-01 17:58:30.047', '2019-10-01 17:58:30.048', '2019-10-01 17:58:30.048', '', NULL);
INSERT INTO `sys_job_log` VALUES (2846, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-10-01 17:58:45.018', '2019-10-01 17:58:45.018', '2019-10-01 17:58:45.018', '', NULL);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `service_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务ID',
  `remote_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求URI',
  `method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作方式',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '操作提交的数据',
  `time` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行时间',
  `exception` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常信息',
  `created_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  `version` int(11) NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_log_create_by`(`created_by`) USING BTREE,
  INDEX `sys_log_request_uri`(`request_uri`) USING BTREE,
  INDEX `sys_log_type`(`type`) USING BTREE,
  INDEX `sys_log_create_date`(`created_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (55, '0', '锁定/解锁用户', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36', '/sys/user/90da0206c39867a1b36ac36ced80c1a9', 'PUT', '', '10', NULL, '1', '2019-07-07 22:16:43.000', 'system', '2019-07-26 10:54:23.264', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (56, '0', '锁定/解锁用户', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36', '/sys/user/90da0206c39867a1b36ac36ced80c1a9', 'PUT', '', '63818', NULL, '1', '2019-07-07 22:19:27.000', 'system', '2019-07-26 10:54:23.267', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (57, '1', '删除菜单', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36', '/menu/663848c0f8206dba3fd2425812fd2fbf', 'DELETE', '', '28', NULL, 'system', '2019-07-26 11:15:45.309', 'system', '2019-07-26 11:15:45.309', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (58, '1', '删除菜单', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36', '/menu/ba842f6e126664a139c79f97a6bc01a9', 'DELETE', '', '20', NULL, 'system', '2019-07-26 11:16:02.388', 'system', '2019-07-26 11:16:02.388', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (59, '1', '删除菜单', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36', '/menu/4026ad4683346e478306cdb1559e2e7e', 'DELETE', '', '19', NULL, 'system', '2019-07-26 11:16:19.698', 'system', '2019-07-26 11:16:19.698', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (60, '1', '删除菜单', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36', '/menu/aa74553ef25bbd93d3a921f37177b66b', 'DELETE', '', '21', NULL, 'system', '2019-07-26 11:16:21.731', 'system', '2019-07-26 11:16:21.731', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (61, '1', '添加/更新菜单', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36', '/menu/', 'POST', '', '60', NULL, 'system', '2019-07-26 15:50:53.318', 'system', '2019-07-26 15:50:53.318', 0, NULL, '0');

-- ----------------------------
-- Table structure for sys_log_login
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_login`;
CREATE TABLE `sys_log_login`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `login_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录账号',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（1成功 0失败）',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '登录日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_log_operate
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_operate`;
CREATE TABLE `sys_log_operate`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `service_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务ID',
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `ip_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求URI',
  `method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作方式',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '操作提交的数据',
  `time` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行时间',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `exception` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常信息',
  `created_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_log_create_by`(`created_by`) USING BTREE,
  INDEX `sys_log_request_uri`(`request_uri`) USING BTREE,
  INDEX `sys_log_create_date`(`created_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单ID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `permission` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端URL',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'VUE页面',
  `keep_alive` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否显示1 是0否',
  `show` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否显示1 是0否',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单类型 （0菜单 1按钮）',
  `leaf` bit(1) NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `sort` int(11) NULL DEFAULT 1 COMMENT '排序值',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('06874adacf1f272be7928badd4fe8ed1', '配置日志', NULL, 'log', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-read', 'views/admin/log/index', '0', '1', '0', b'1', 30, '1', '2019-08-05 16:16:06.000', '1', '2019-08-05 16:17:17.483', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('0747d9d8f651f19e49748ba68f18c6f5', '任务调度方案编辑', 'quartz_job_edit', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, '0', '1', '1', b'0', 40, '1', '2019-08-14 10:36:03.602', '1', '2019-08-14 10:37:00.053', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('0d0be247863fcbf08b3db943e5f45992', '在线用户查看', 'sys_userOnline_view', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', 'ef2382c0cc2d99ee73444e684237a88a,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-07 09:05:28.000', '1', '2019-08-07 09:05:58.473', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1000', '权限管理', NULL, '/perm', '-1', NULL, 'icon-quanxianguanli', 'Layout', '0', '1', '0', b'0', 10, '', '2018-09-28 08:29:53.000', '1', '2019-08-18 11:45:24.037', NULL, 13, '0');
INSERT INTO `sys_menu` VALUES ('1100', '用户管理', NULL, 'user', '1000', '1000,', 'icon-yonghuguanli', 'views/sys/user/index', '0', '1', '0', b'0', 10, '', '2017-11-02 22:24:37.000', '1', '2019-08-18 11:45:24.047', NULL, 10, '0');
INSERT INTO `sys_menu` VALUES ('1101', '用户编辑', 'sys_user_edit', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 09:52:09.000', NULL, '2019-08-08 13:23:14.225', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1102', '用户锁定', 'sys_user_lock', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 09:52:48.000', NULL, '2019-08-08 13:23:14.228', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1103', '用户删除', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 09:54:01.000', NULL, '2019-08-08 13:23:14.231', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('11b9ae870fb0fc89c52236faf43f3d96', '任务调度方案查看', 'quartz_job_view', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, '0', '1', '1', b'0', 20, '1', '2019-08-14 10:35:56.085', '1', '2019-08-14 10:36:03.588', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('1200', '菜单管理', NULL, 'menu', '1000', '1000,', 'icon-caidanguanli', 'views/sys/menu/index', '0', '1', '0', b'0', 20, '', '2017-11-08 09:57:27.000', '1', '2019-08-18 11:31:00.719', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('1201', '菜单编辑', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:15:53.000', NULL, '2019-08-08 13:23:14.233', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1202', '菜单锁定', 'sys_menu_lock', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:16:23.000', NULL, '2019-08-08 13:23:14.235', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1203', '菜单删除', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:16:43.000', NULL, '2019-08-08 13:23:14.238', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1300', '角色管理', NULL, 'role', '1000', '1000,', 'icon-jiaoseguanli', 'views/sys/role/index', '0', '1', '0', b'0', 30, '', '2017-11-08 10:13:37.000', '1', '2019-08-18 11:31:00.724', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('1301', '角色编辑', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:14:18.000', NULL, '2019-08-08 13:23:14.241', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1302', '角色锁定', 'sys_role_lock', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:14:41.000', NULL, '2019-08-08 13:23:14.243', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1303', '角色删除', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:14:59.000', NULL, '2019-08-08 13:23:14.245', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1304', '角色查看', 'sys_role_view', NULL, '1300', '1300,', NULL, NULL, '0', '1', '1', b'1', 30, '', '2018-04-20 07:22:55.000', '1', '2019-08-07 17:28:17.093', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('13093fb658c1806ad5bd0600316158f2', '操作日志导出', 'sys_logOperate_export', NULL, '2100', '2000,2100,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-07 17:50:46.973', '1', '2019-08-08 15:06:52.841', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1400', '部门管理', NULL, 'dept', '1000', NULL, 'icon-web-icon-', 'views/sys/dept/index', '0', '1', '0', b'0', 40, '', '2018-01-20 13:17:19.000', '1', '2019-08-18 11:31:00.731', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('1401', '部门编辑', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2018-01-20 14:56:16.000', NULL, '2019-08-08 13:23:14.247', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1402', '部门锁定', 'sys_dept_lock', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2018-01-20 14:56:59.000', NULL, '2019-08-08 13:23:14.249', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1403', '部门删除', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2018-01-20 14:57:28.000', NULL, '2019-08-08 13:23:14.251', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('18d6b5e0f6b986cd074bf23de11ecd34', '任务调度删除', 'quartz_job_del', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', NULL, NULL, NULL, '0', '1', '1', b'0', 80, '1', '2019-08-14 10:36:47.091', '1', '2019-08-14 10:36:47.091', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1a900c3f10ef5b0987e0a8ee4445316d', '用户查看', 'sys_user_view', NULL, '1100', '1000,1100,', NULL, NULL, '0', '1', '1', b'1', 10, '1', '2019-08-07 17:27:34.000', '1', '2019-08-09 10:55:47.709', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('2000', '系统管理', NULL, '/sys', '-1', NULL, 'icon-xitongguanli', 'Layout', '0', '1', '0', b'0', 20, '', '2017-11-07 20:56:00.000', '1', '2019-08-18 10:50:33.184', NULL, 13, '0');
INSERT INTO `sys_menu` VALUES ('2100', '操作日志', NULL, 'log-operate', '2000', '2000,', 'icon-rizhiguanli', 'views/sys/log-operate/index', '0', '1', '0', b'0', 40, '', '2017-11-20 14:06:22.000', '1', '2019-08-18 11:31:36.435', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('2101', '操作日志删除', 'sys_logOperate_del', NULL, '2100', '2000,2100,', NULL, NULL, '0', '1', '1', b'1', 30, '', '2017-11-20 20:37:37.000', '1', '2019-08-08 15:06:52.843', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('2200', '字典管理', NULL, 'dict', '2000', NULL, 'icon-navicon-zdgl', 'views/sys/dict/index', '0', '1', '0', b'0', 10, '', '2017-11-29 11:30:52.000', '1', '2019-08-18 11:31:36.441', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('2201', '字典删除', 'sys_dict_del', NULL, '2200', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-29 11:30:11.000', NULL, '2019-08-08 13:23:14.253', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2202', '字典编辑', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2018-05-11 22:34:55.000', NULL, '2019-08-08 13:23:14.256', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('23430df88fb72179c2a85c39eaf4d50b', '任务调度日志清空', 'quartz_job_log_clean', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-15 16:12:26.285', '1', '2019-08-15 16:12:26.285', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('247071d42ff40267c8d8c44eac92da67', '生成方案', NULL, 'scheme', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'icon-appstore', 'views/gen/scheme/index', '0', '1', '0', b'0', 40, '1', '2019-07-21 13:27:35.000', '1', '2019-08-11 09:20:09.072', NULL, 18, '0');
INSERT INTO `sys_menu` VALUES ('2500', '服务接口', NULL, 'http://localhost:8061/swagger-ui.html', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-server', NULL, '0', '1', '0', b'1', 500, '', '2018-06-26 10:50:32.000', '1', '2019-08-08 17:06:04.472', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('2600', '令牌管理', NULL, 'persistent-token', '2000', '2000,', 'icon-denglvlingpai', 'views/sys/persistent-token/index', '0', '1', '0', b'0', 20, '', '2018-09-04 05:58:41.000', '1', '2019-08-18 11:31:36.446', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('2601', '令牌删除', 'sys_persistentToken_del', NULL, '2600', '2600,', NULL, NULL, '0', '1', '1', b'1', 1, '', '2018-09-04 05:59:50.000', '1', '2019-08-08 15:06:43.169', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('2836ced373377be75936827ecddf7fad', '测试树管理编辑', 'test_testTreeBook_edit', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, '0', '1', '1', b'0', 40, '1', '2019-08-11 14:32:06.856', '1', '2019-08-11 14:43:59.833', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('29de79df95e70d8e8fbdc7945acf214a', '任务调度查看', 'quartz_job_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', NULL, NULL, NULL, '0', '1', '1', b'0', 20, '1', '2019-08-14 10:36:47.085', '1', '2019-08-14 10:36:47.085', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2af0268f695b79abdf6e8b10d559d081', '测试树管理删除', 'test_testTreeBook_del', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, '0', '1', '1', b'0', 80, '1', '2019-08-11 14:32:06.859', '1', '2019-08-11 14:44:03.802', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2c8fdecfee63a310266b2e4b94fd3f4c', '任务调度日志删除', 'quartz_job_log_del', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-15 16:12:07.842', '1', '2019-08-15 16:12:07.842', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2c90f69bccf0845b1aca8b072b730c39', '任务调度方案删除', 'quartz_job_del', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, '0', '1', '1', b'0', 80, '1', '2019-08-14 10:35:56.092', '1', '2019-08-14 10:36:03.588', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2d9efe7ea66351a96da68e6a7cca5e00', '任务调度方案删除', 'quartz_job_del', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, '0', '1', '1', b'0', 80, '1', '2019-08-14 10:36:03.606', '1', '2019-08-14 10:37:03.383', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('322efc9833f2562f8862f882dabdf3d6', '任务调度方案', NULL, 'job', '2000', NULL, 'icon-right-square', 'views/quartz/job/index', '0', '1', '0', b'0', 30, '1', '2019-08-14 10:35:56.081', '1', '2019-08-14 10:36:03.588', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('34acb71268387bb85c80849f7377c7fd', '任务日志导出', 'quartz_jobLog_export', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, '0', '1', '1', b'1', 40, '1', '2019-08-14 10:36:42.000', '1', '2019-08-15 09:47:37.769', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('34dae0db3f9c97482d598f964bd4c9c7', '配置管理', NULL, 'configuration', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-slack', 'views/admin/configuration/index', '0', '1', '0', b'1', 50, '1', '2019-08-05 17:46:50.000', '1', '2019-08-05 17:47:28.719', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('365a9f74f847322d2b8a0eff2b426ef4', '登录日志导出', 'sys_logLogin_export', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', 'a41d4ac1a6cc179696e0dbf284e3efc4,', NULL, NULL, '0', '1', '1', b'1', 40, '1', '2019-08-15 09:26:02.000', '1', '2019-08-15 09:46:53.019', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('3c1c5a48888650b9a7ba5a1763f2e205', '任务日志查看', 'quartz_jobLog_view', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, '0', '1', '1', b'1', 20, '1', '2019-08-14 10:36:42.000', '1', '2019-08-15 09:47:41.596', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('413892fe8d52c1163d6659f51299dc96', '代码生成', NULL, '/gen', '-1', NULL, 'icon-weibiaoti46', 'Layout', '0', '1', '0', b'0', 100, '1', '2019-07-20 12:00:48.000', '1', '2019-08-18 09:31:07.559', NULL, 24, '0');
INSERT INTO `sys_menu` VALUES ('52715698214e88cb09fa4dd1ea5ad348', '生成方案菜单', 'gen_scheme_menu', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-25 13:03:03.000', '1', '2019-08-11 09:20:09.081', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('5431004fa397e0280fd75c4a3b73c4aa', '登录日志查看', 'sys_logLogin_view', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, '0', '1', '1', b'0', 20, '1', '2019-08-15 09:26:02.349', '1', '2019-08-15 09:26:02.349', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('5da31e19f05edeea6a7041e3101deefe', '任务日志删除', 'quartz_jobLog_del', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, '0', '1', '1', b'1', 80, '1', '2019-08-14 10:36:42.000', '1', '2019-08-15 09:47:45.790', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('621e50e1c7d66a1febeb699bebb2fe35', '任务调度执行', 'quartz_job_run', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-15 16:10:59.000', '1', '2019-08-15 16:11:07.125', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('6e3f89cda84ac2c6e715e7812c102ae8', '在线用户', '', 'online-user', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-team', 'views/admin/online-user/index', '0', '1', '0', b'0', 30, '1', '2019-08-07 09:03:52.000', '1', '2019-08-11 10:57:51.498', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('74f2b2a8871a298e0acc4d7129d10e9c', '任务调度', NULL, 'job', '2000', NULL, 'icon-right-square', 'views/quartz/job/index', '0', '1', '0', b'0', 30, '1', '2019-08-14 10:36:47.081', '1', '2019-08-18 11:31:36.451', NULL, 7, '0');
INSERT INTO `sys_menu` VALUES ('76d6087052dc26b32f3efa71b9cc119b', '任务调度日志', 'quartz_job_log_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-15 16:11:30.986', '1', '2019-08-15 16:11:30.986', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('7b14af9e9fbff286856338a194422b07', '令牌查看', 'sys_persistentToken_view', NULL, '2600', '2600,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-08 09:44:25.617', '1', '2019-08-08 15:06:43.172', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('7c7a876f4cceba2dd92aa539dea6b6e5', '任务日志清空', 'quartz_jobLog_clean', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-15 13:55:37.892', '1', '2019-08-15 13:55:37.892', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('8d3517427e527df11d51da528261c915', '测试树管理', NULL, 'test-tree-book', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/test-tree-book/index', '0', '1', '0', b'0', 30, '1', '2019-08-11 14:32:06.849', '1', '2019-08-11 14:44:10.280', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('92f78825551a22fa130c03066f398448', '在线用户删除', 'sys_userOnline_del', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', 'ef2382c0cc2d99ee73444e684237a88a,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-07 09:06:33.448', '1', '2019-08-07 09:06:33.448', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('94b57a562063d103423e2c6125cb30ad', '菜单查看', 'sys_menu_view', NULL, '1200', '1200,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-07 17:27:59.697', '1', '2019-08-09 10:57:24.065', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('9763343d9cce11ce9eb4f21c8e49122b', '任务调度编辑', 'quartz_job_edit', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', NULL, NULL, NULL, '0', '1', '1', b'0', 40, '1', '2019-08-14 10:36:47.088', '1', '2019-08-14 10:36:47.088', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('97722c6d56c8b9990cc3c1a6eea3d6bb', '业务表编辑', 'gen_table_edit', 'edit', 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, 'views/gen/table/edit', '0', '1', '2', b'1', 30, '1', '2019-07-21 13:24:02.000', '1', '2019-08-08 15:21:18.115', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('a18b33e15bde209a3c9115517c56d9ec', '业务表', '', 'table', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'icon-table', 'views/gen/table/index', '0', '1', '0', b'0', 30, '1', '2019-07-20 12:02:02.000', '1', '2019-08-11 08:47:39.824', NULL, 17, '0');
INSERT INTO `sys_menu` VALUES ('a41d4ac1a6cc179696e0dbf284e3efc4', '登录日志', NULL, 'log-login', '2000', NULL, 'icon-right-square', 'views/sys/log-login/index', '0', '1', '0', b'0', 50, '1', '2019-08-15 09:26:02.345', '1', '2019-08-18 11:31:36.457', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('b961670cbf3454f5927c4bd2a327e915', '生成方案删除', 'gen_scheme_del', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:30:18.000', '1', '2019-08-11 08:50:09.304', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('b963a451117f430703817b3b6c87402a', '任务调度日志导出', 'quartz_job_log_export', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-15 16:13:16.742', '1', '2019-08-15 16:13:16.742', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('bb9dd4b7a2a462193d0f01517308f812', '业务表查看', 'gen_table_view', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-11 08:47:39.828', '1', '2019-08-11 08:47:39.828', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('bd62904371247f56594741ff8e9bded9', '用户管理导入', 'sys_user_import', NULL, '1100', '1000,1100,', NULL, NULL, '0', '1', '1', b'1', 80, '1', '2019-08-07 17:50:02.000', '1', '2019-08-09 10:55:47.711', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('c0ba37c10abaecd89a738c5cf2a2fd24', '服务状态', NULL, 'health', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-boxplot', 'views/admin/health/index', '0', '1', '0', b'1', 40, '1', '2019-08-05 17:21:10.000', '1', '2019-08-05 17:23:22.745', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('c77855e4171d00ae3f97563a8391f70a', '任务调度方案', NULL, 'job', '2000', NULL, 'icon-right-square', 'views/quartz/job/index', '0', '1', '0', b'0', 30, '1', '2019-08-14 10:36:03.593', '1', '2019-08-14 10:37:07.325', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c93f8fca7ca6f8631d383b08ab67009a', '任务日志', NULL, 'job-log', '2000', '2000,', 'icon-right-square', 'views/quartz/job-log/index', '0', '0', '0', b'0', 60, '1', '2019-08-14 10:36:42.000', '1', '2019-08-18 11:31:36.462', NULL, 9, '0');
INSERT INTO `sys_menu` VALUES ('caaec41413c5713c6f290efe08c11415', '生成方案查看', 'gen_scheme_view', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-11 08:48:09.000', '1', '2019-08-11 08:50:16.065', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('d4c16faad8f883650a3a8eab829ebad9', '操作日志查看', 'sys_logOperate_view', NULL, '2100', '2000,2100,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-07 17:51:38.454', '1', '2019-08-08 15:06:52.844', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('d5897b78312e09024546530fd8b2e8fc', '任务调度方案查看', 'quartz_job_view', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, '0', '1', '1', b'0', 20, '1', '2019-08-14 10:36:03.598', '1', '2019-08-14 10:37:01.776', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e086c4aa4943a883b29cf94680608b89', '生成方案代码', 'gen_scheme_code', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-11 08:55:37.000', '1', '2019-08-11 09:19:50.418', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('e590df103d3382d3091eae818f68626b', '测试树管理查看', 'test_testTreeBook_view', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, '0', '1', '1', b'0', 20, '1', '2019-08-11 14:32:06.853', '1', '2019-08-11 14:44:05.503', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e5ea38c1f97dee0043e78f3fb27b25d6', '生成方案编辑', 'gen_scheme_edit', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:29:14.000', '1', '2019-08-05 15:54:01.914', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('e66c7efccb9e1a0519afc328339e9108', '登录日志删除', 'sys_logLogin_del', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, '0', '1', '1', b'0', 80, '1', '2019-08-15 09:26:02.357', '1', '2019-08-15 09:26:02.357', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('e6ea0a5dc986c69852010e4a24329cf1', '任务调度方案编辑', 'quartz_job_edit', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, '0', '1', '1', b'0', 40, '1', '2019-08-14 10:35:56.089', '1', '2019-08-14 10:36:03.588', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e710a66583fe0e324492462adb16014e', '业务表删除', 'gen_table_del', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:24:45.000', '1', '2019-07-25 13:32:11.051', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('ef2382c0cc2d99ee73444e684237a88a', '资源管理', NULL, '/admin', '-1', NULL, 'icon-barchart', 'Layout', '0', '1', '0', b'0', 30, '1', '2019-08-05 15:58:12.000', '1', '2019-08-08 17:06:04.464', NULL, 16, '0');
INSERT INTO `sys_menu` VALUES ('f15e2186907d22765cd149a94905842a', '在线用户强退', 'sys_userOnline_logout', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', 'ef2382c0cc2d99ee73444e684237a88a,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-11 10:57:51.502', '1', '2019-08-11 10:57:51.502', NULL, 0, '0');

-- ----------------------------
-- Table structure for sys_persistent_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_persistent_token`;
CREATE TABLE `sys_persistent_token`  (
  `series` varchar(76) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `token_value` varchar(76) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token_date` timestamp(3) NULL DEFAULT NULL,
  `ip_address` varchar(39) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  PRIMARY KEY (`series`) USING BTREE,
  INDEX `fk_user_persistent_token`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '数据权限 1全部 2所在机构及以下数据  3 所在机构数据  4仅本人数据 5 按明细设置',
  `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '1-正常，0-锁定',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_idx1_role_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '管理员', 'ROLE_ADMIN', '管理员', '1', '1', '', '2017-10-29 15:45:51.000', '1', '2019-08-18 09:46:34.637', NULL, 69, '0');
INSERT INTO `sys_role` VALUES ('2', 'ROLE_CQQ', 'ROLE_CQQ', 'ROLE_CQQ', '5', '1', '', '2018-11-11 19:42:26.000', '1', '2019-08-18 09:25:55.630', NULL, 9, '0');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色ID',
  `dept_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色与部门对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('112b02f11f1a382a6b1200cd3b06252b', '2', '5');
INSERT INTO `sys_role_dept` VALUES ('28e2bd6452d0aff99f014136336eab61', '1', '8');
INSERT INTO `sys_role_dept` VALUES ('8951a57012be2633c2c2c95dddd221ad', '2', '4');
INSERT INTO `sys_role_dept` VALUES ('d86fe58ba7cf40da5101cfb3ea052c3a', '2', '3');
INSERT INTO `sys_role_dept` VALUES ('f7daf721079b7b905f89cbe07a7e018f', '2', '1');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
  `menu_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '06874adacf1f272be7928badd4fe8ed1');
INSERT INTO `sys_role_menu` VALUES ('1', '0d0be247863fcbf08b3db943e5f45992');
INSERT INTO `sys_role_menu` VALUES ('1', '1000');
INSERT INTO `sys_role_menu` VALUES ('1', '1100');
INSERT INTO `sys_role_menu` VALUES ('1', '1101');
INSERT INTO `sys_role_menu` VALUES ('1', '1102');
INSERT INTO `sys_role_menu` VALUES ('1', '1103');
INSERT INTO `sys_role_menu` VALUES ('1', '1200');
INSERT INTO `sys_role_menu` VALUES ('1', '1201');
INSERT INTO `sys_role_menu` VALUES ('1', '1202');
INSERT INTO `sys_role_menu` VALUES ('1', '1203');
INSERT INTO `sys_role_menu` VALUES ('1', '1300');
INSERT INTO `sys_role_menu` VALUES ('1', '1301');
INSERT INTO `sys_role_menu` VALUES ('1', '1302');
INSERT INTO `sys_role_menu` VALUES ('1', '1303');
INSERT INTO `sys_role_menu` VALUES ('1', '1304');
INSERT INTO `sys_role_menu` VALUES ('1', '13093fb658c1806ad5bd0600316158f2');
INSERT INTO `sys_role_menu` VALUES ('1', '1400');
INSERT INTO `sys_role_menu` VALUES ('1', '1401');
INSERT INTO `sys_role_menu` VALUES ('1', '1402');
INSERT INTO `sys_role_menu` VALUES ('1', '1403');
INSERT INTO `sys_role_menu` VALUES ('1', '18d6b5e0f6b986cd074bf23de11ecd34');
INSERT INTO `sys_role_menu` VALUES ('1', '1a900c3f10ef5b0987e0a8ee4445316d');
INSERT INTO `sys_role_menu` VALUES ('1', '2000');
INSERT INTO `sys_role_menu` VALUES ('1', '2100');
INSERT INTO `sys_role_menu` VALUES ('1', '2101');
INSERT INTO `sys_role_menu` VALUES ('1', '2200');
INSERT INTO `sys_role_menu` VALUES ('1', '2201');
INSERT INTO `sys_role_menu` VALUES ('1', '2202');
INSERT INTO `sys_role_menu` VALUES ('1', '23430df88fb72179c2a85c39eaf4d50b');
INSERT INTO `sys_role_menu` VALUES ('1', '247071d42ff40267c8d8c44eac92da67');
INSERT INTO `sys_role_menu` VALUES ('1', '2500');
INSERT INTO `sys_role_menu` VALUES ('1', '2600');
INSERT INTO `sys_role_menu` VALUES ('1', '2601');
INSERT INTO `sys_role_menu` VALUES ('1', '29de79df95e70d8e8fbdc7945acf214a');
INSERT INTO `sys_role_menu` VALUES ('1', '2c8fdecfee63a310266b2e4b94fd3f4c');
INSERT INTO `sys_role_menu` VALUES ('1', '34acb71268387bb85c80849f7377c7fd');
INSERT INTO `sys_role_menu` VALUES ('1', '34dae0db3f9c97482d598f964bd4c9c7');
INSERT INTO `sys_role_menu` VALUES ('1', '365a9f74f847322d2b8a0eff2b426ef4');
INSERT INTO `sys_role_menu` VALUES ('1', '3c1c5a48888650b9a7ba5a1763f2e205');
INSERT INTO `sys_role_menu` VALUES ('1', '52715698214e88cb09fa4dd1ea5ad348');
INSERT INTO `sys_role_menu` VALUES ('1', '5431004fa397e0280fd75c4a3b73c4aa');
INSERT INTO `sys_role_menu` VALUES ('1', '5da31e19f05edeea6a7041e3101deefe');
INSERT INTO `sys_role_menu` VALUES ('1', '621e50e1c7d66a1febeb699bebb2fe35');
INSERT INTO `sys_role_menu` VALUES ('1', '6e3f89cda84ac2c6e715e7812c102ae8');
INSERT INTO `sys_role_menu` VALUES ('1', '74f2b2a8871a298e0acc4d7129d10e9c');
INSERT INTO `sys_role_menu` VALUES ('1', '76d6087052dc26b32f3efa71b9cc119b');
INSERT INTO `sys_role_menu` VALUES ('1', '7b14af9e9fbff286856338a194422b07');
INSERT INTO `sys_role_menu` VALUES ('1', '7c7a876f4cceba2dd92aa539dea6b6e5');
INSERT INTO `sys_role_menu` VALUES ('1', '92f78825551a22fa130c03066f398448');
INSERT INTO `sys_role_menu` VALUES ('1', '94b57a562063d103423e2c6125cb30ad');
INSERT INTO `sys_role_menu` VALUES ('1', '9763343d9cce11ce9eb4f21c8e49122b');
INSERT INTO `sys_role_menu` VALUES ('1', '97722c6d56c8b9990cc3c1a6eea3d6bb');
INSERT INTO `sys_role_menu` VALUES ('1', 'a18b33e15bde209a3c9115517c56d9ec');
INSERT INTO `sys_role_menu` VALUES ('1', 'a41d4ac1a6cc179696e0dbf284e3efc4');
INSERT INTO `sys_role_menu` VALUES ('1', 'b961670cbf3454f5927c4bd2a327e915');
INSERT INTO `sys_role_menu` VALUES ('1', 'b963a451117f430703817b3b6c87402a');
INSERT INTO `sys_role_menu` VALUES ('1', 'bb9dd4b7a2a462193d0f01517308f812');
INSERT INTO `sys_role_menu` VALUES ('1', 'bd62904371247f56594741ff8e9bded9');
INSERT INTO `sys_role_menu` VALUES ('1', 'c0ba37c10abaecd89a738c5cf2a2fd24');
INSERT INTO `sys_role_menu` VALUES ('1', 'c93f8fca7ca6f8631d383b08ab67009a');
INSERT INTO `sys_role_menu` VALUES ('1', 'caaec41413c5713c6f290efe08c11415');
INSERT INTO `sys_role_menu` VALUES ('1', 'd4c16faad8f883650a3a8eab829ebad9');
INSERT INTO `sys_role_menu` VALUES ('1', 'e086c4aa4943a883b29cf94680608b89');
INSERT INTO `sys_role_menu` VALUES ('1', 'e5ea38c1f97dee0043e78f3fb27b25d6');
INSERT INTO `sys_role_menu` VALUES ('1', 'e66c7efccb9e1a0519afc328339e9108');
INSERT INTO `sys_role_menu` VALUES ('1', 'e710a66583fe0e324492462adb16014e');
INSERT INTO `sys_role_menu` VALUES ('1', 'ef2382c0cc2d99ee73444e684237a88a');
INSERT INTO `sys_role_menu` VALUES ('1', 'f15e2186907d22765cd149a94905842a');
INSERT INTO `sys_role_menu` VALUES ('2', '1000');
INSERT INTO `sys_role_menu` VALUES ('2', '1100');
INSERT INTO `sys_role_menu` VALUES ('2', '1101');
INSERT INTO `sys_role_menu` VALUES ('2', '1102');
INSERT INTO `sys_role_menu` VALUES ('2', '1103');
INSERT INTO `sys_role_menu` VALUES ('2', '1200');
INSERT INTO `sys_role_menu` VALUES ('2', '1201');
INSERT INTO `sys_role_menu` VALUES ('2', '1202');
INSERT INTO `sys_role_menu` VALUES ('2', '1203');
INSERT INTO `sys_role_menu` VALUES ('2', '1300');
INSERT INTO `sys_role_menu` VALUES ('2', '1301');
INSERT INTO `sys_role_menu` VALUES ('2', '1302');
INSERT INTO `sys_role_menu` VALUES ('2', '1303');
INSERT INTO `sys_role_menu` VALUES ('2', '1304');
INSERT INTO `sys_role_menu` VALUES ('2', '1400');
INSERT INTO `sys_role_menu` VALUES ('2', '1401');
INSERT INTO `sys_role_menu` VALUES ('2', '1402');
INSERT INTO `sys_role_menu` VALUES ('2', '1403');
INSERT INTO `sys_role_menu` VALUES ('2', 'e5ea38c1f97dee0043e78f3fb27b25d6');

-- ----------------------------
-- Table structure for sys_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_token`;
CREATE TABLE `sys_token`  (
  `id_` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `series_` varchar(76) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `token_value` varchar(76) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token_date` date NULL DEFAULT NULL,
  `ip_address` varchar(39) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_`) USING BTREE,
  INDEX `fk_user_persistent_token`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '1' COMMENT '主键ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '随机盐',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '简介',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '头像',
  `dept_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '部门ID',
  `qq_open_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'QQ openid',
  `wx_open_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信openid',
  `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '1-正常，0-锁定',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_wx_openid`(`wx_open_id`) USING BTREE,
  INDEX `user_qq_openid`(`qq_open_id`) USING BTREE,
  INDEX `user_idx1_username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, '17034642999', NULL, '', '1', NULL, 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', '1', '', '2018-04-20 07:15:18.000', '1', '2019-08-11 17:46:36.983', NULL, 9, '0');
INSERT INTO `sys_user` VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', 'dsafdf', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, '12343543432', '837158@qq.com', NULL, '3', NULL, NULL, '1', '1', '2019-07-07 14:32:17.000', '1', '2019-07-13 01:38:33.000', NULL, 19, '1');
INSERT INTO `sys_user` VALUES ('90da0206c39867a1b36ac36ced80c1a9', 'test', '$2a$10$NmGuhLe7ODgRC0cwHPa0IuJh94uFYGrAMCyndqMwX07s.CH18RmlS', NULL, NULL, NULL, NULL, '3', NULL, NULL, '1', '1', '2019-07-07 14:35:13.000', '1', '2019-08-09 10:58:20.948', NULL, 36, '0');

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `session_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户会话id',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录账号',
  `dept_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门ID',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `ip_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP地址',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '在线状态on_line在线off_line离线',
  `start_timestamp` datetime(0) NULL DEFAULT NULL COMMENT 'session创建时间',
  `last_access_time` datetime(0) NULL DEFAULT NULL COMMENT 'session最后访问时间',
  `expire_time` int(5) NULL DEFAULT 0 COMMENT '超时时间，单位为分钟',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`, `session_id`) USING BTREE,
  UNIQUE INDEX `session_id`(`session_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '在线用户记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('90da0206c39867a1b36ac36ced80c1a9', '1');

-- ----------------------------
-- Table structure for test_book
-- ----------------------------
DROP TABLE IF EXISTS `test_book`;
CREATE TABLE `test_book`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title_` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `author_` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `name_` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `email_` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone_` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `activated_` bit(1) NOT NULL,
  `number_` int(11) NULL DEFAULT NULL COMMENT 'key',
  `money_` decimal(20, 2) NULL DEFAULT NULL,
  `amount_` double(11, 2) NULL DEFAULT NULL,
  `reset_date` timestamp(3) NULL DEFAULT NULL,
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version` int(11) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '测试书籍' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for test_tree_book
-- ----------------------------
DROP TABLE IF EXISTS `test_tree_book`;
CREATE TABLE `test_tree_book`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `leaf` bit(1) NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `author_` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `email_` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone_` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `activated_` bit(1) NOT NULL,
  `number_` int(11) NULL DEFAULT NULL COMMENT 'key',
  `money_` decimal(20, 2) NULL DEFAULT NULL,
  `amount_` double(11, 2) NULL DEFAULT NULL,
  `reset_date` timestamp(3) NULL DEFAULT NULL,
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `version` int(11) NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '  测试树书' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

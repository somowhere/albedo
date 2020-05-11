/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : albedo

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 11/05/2020 10:13:08
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
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES ('138567c7103e4753f6904920c36c18c3', 'test_book', '测试书籍', 'TestBook', NULL, NULL, 0, NULL, '1', '2020-05-07 12:22:06.760', '1', '2020-05-07 12:22:06.760', '0');

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
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES ('1969e125ae3325c3e1426a55f9e1ba50', '138567c7103e4753f6904920c36c18c3', 'email_', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2020-05-07 12:22:06.787', '1', '2020-05-07 12:22:06.787', '0');
INSERT INTO `gen_table_column` VALUES ('198a9bcafeca49476dbef881115875b2', '138567c7103e4753f6904920c36c18c3', 'activated_', 'activated_', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2020-05-07 12:22:06.790', '1', '2020-05-07 12:22:06.790', '0');
INSERT INTO `gen_table_column` VALUES ('1c0a1c2a4f24ad9e218bc0fcf2a1b6b9', '138567c7103e4753f6904920c36c18c3', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 0, NULL, '1', '2020-05-07 12:22:06.799', '1', '2020-05-07 12:22:06.799', '0');
INSERT INTO `gen_table_column` VALUES ('25d454fd9b3c6474ddd693c3441583bf', '138567c7103e4753f6904920c36c18c3', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 0, NULL, '1', '2020-05-07 12:22:06.795', '1', '2020-05-07 12:22:06.795', '0');
INSERT INTO `gen_table_column` VALUES ('2fcad3dabcb378690c2091f9001e3c7c', '138567c7103e4753f6904920c36c18c3', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2020-05-07 12:22:06.779', '1', '2020-05-07 12:22:06.779', '0');
INSERT INTO `gen_table_column` VALUES ('32e5e366dbea17d6974ac22b49248232', '138567c7103e4753f6904920c36c18c3', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 0, NULL, '1', '2020-05-07 12:22:06.795', '1', '2020-05-07 12:22:06.795', '0');
INSERT INTO `gen_table_column` VALUES ('4ad045ef58f72bb3c05c65d00848d39e', '138567c7103e4753f6904920c36c18c3', 'amount_', 'amount_', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1', '2020-05-07 12:22:06.794', '1', '2020-05-07 12:22:06.794', '0');
INSERT INTO `gen_table_column` VALUES ('69d97fb3de75fb119f3768f40b49a561', '138567c7103e4753f6904920c36c18c3', 'author_', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2020-05-07 12:22:06.784', '1', '2020-05-07 12:22:06.784', '0');
INSERT INTO `gen_table_column` VALUES ('91c34e44dc35320e62665748365b01ae', '138567c7103e4753f6904920c36c18c3', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 0, NULL, '1', '2020-05-07 12:22:06.796', '1', '2020-05-07 12:22:06.796', '0');
INSERT INTO `gen_table_column` VALUES ('92b13f6aefbc726c4f4a3ac9ffc58e53', '138567c7103e4753f6904920c36c18c3', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 0, NULL, '1', '2020-05-07 12:22:06.797', '1', '2020-05-07 12:22:06.797', '0');
INSERT INTO `gen_table_column` VALUES ('9900848b9593ab0e94bc1a0f71e67192', '138567c7103e4753f6904920c36c18c3', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 0, NULL, '1', '2020-05-07 12:22:06.800', '1', '2020-05-07 12:22:06.800', '0');
INSERT INTO `gen_table_column` VALUES ('9ae4e021891f1a583d635b0be926d3d2', '138567c7103e4753f6904920c36c18c3', 'phone_', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2020-05-07 12:22:06.789', '1', '2020-05-07 12:22:06.789', '0');
INSERT INTO `gen_table_column` VALUES ('aeba4ceb3f1bb6667ecac2b9ebcbda39', '138567c7103e4753f6904920c36c18c3', 'number_', 'key', NULL, 'int(11)', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2020-05-07 12:22:06.791', '1', '2020-05-07 12:22:06.791', '0');
INSERT INTO `gen_table_column` VALUES ('c8dcc693a574b5b8c39493c5b97447bb', '138567c7103e4753f6904920c36c18c3', 'money_', 'money_', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2020-05-07 12:22:06.793', '1', '2020-05-07 12:22:06.793', '0');
INSERT INTO `gen_table_column` VALUES ('dc03e123fb451d117014886ae3816bd9', '138567c7103e4753f6904920c36c18c3', 'name_', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0, NULL, '1', '2020-05-07 12:22:06.786', '1', '2020-05-07 12:22:06.786', '0');
INSERT INTO `gen_table_column` VALUES ('e68f6e7adf1ee4c881664d5f38b0f54e', '138567c7103e4753f6904920c36c18c3', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 160, 0, NULL, '1', '2020-05-07 12:22:06.798', '1', '2020-05-07 12:22:06.798', '0');
INSERT INTO `gen_table_column` VALUES ('f4ce8c9e6be8e44cd0fd28e199a18ae9', '138567c7103e4753f6904920c36c18c3', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 0, NULL, '1', '2020-05-07 12:22:06.782', '1', '2020-05-07 12:22:06.782', '0');
INSERT INTO `gen_table_column` VALUES ('ffad9bfc6089f3e728d0113e1fd91c57', '138567c7103e4753f6904920c36c18c3', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 0, NULL, '1', '2020-05-07 12:22:06.797', '1', '2020-05-07 12:22:06.797', '0');

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
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Singapore');
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Singapore');
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Singapore');

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
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F6200000000000000010200074C0009617661696C61626C657400124C6A6176612F6C616E672F537472696E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C000567726F757071007E00094C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E000978720032636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E4964456E7469747900000000000000010200014C0002696471007E000978720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E44617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB7870740001317371007E0014770E05000007E3080F102B1831A6924078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000574000131740001307400013174000E302F3130202A202A202A202A203F74000744454641554C5474001573696D706C655461736B2E646F4E6F506172616D7374000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC897800);
INSERT INTO `qrtz_job_details` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F6200000000000000010200074C0009617661696C61626C657400124C6A6176612F6C616E672F537472696E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C000567726F757071007E00094C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E000978720032636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E4964456E7469747900000000000000010200014C0002696471007E000978720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E44617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770E05000007E3080E0A1524389FD9807870740001317371007E0014770E05000007E3080F110A382E8D1D4078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000B74000132740001317400013174000E302F3135202A202A202A202A203F74000744454641554C5474001D73696D706C655461736B2E646F506172616D732827616C6265646F272974000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC897800);
INSERT INTO `qrtz_job_details` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F6200000000000000010200074C0009617661696C61626C657400124C6A6176612F6C616E672F537472696E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C000567726F757071007E00094C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E000978720032636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E4964456E7469747900000000000000010200014C0002696471007E000978720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E44617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB7870740001317371007E0014770E05000007E3080F102B161DDCA74078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000374000133740001307400013174000E302F3230202A202A202A202A203F74000744454641554C5474004073696D706C655461736B2E646F4D756C7469706C65506172616D732827616C6265646F272C20747275652C20323030304C2C203331362E3530442C203130302974000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC897800);

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
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('AlbedoQuartzScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('AlbedoQuartzScheduler', 'TRIGGER_ACCESS');

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
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('AlbedoQuartzScheduler', 'somewhere1587722070987', 1587722209048, 15000);

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
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1587722080000, -1, 5, 'PAUSED', 'CRON', 1587722074000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1587722220000, 1587722205000, 5, 'WAITING', 'CRON', 1587722074000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1587722080000, -1, 5, 'PAUSED', 'CRON', 1587722074000, 0, NULL, 2, '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 661 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
  `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '1-正常，0-锁定',
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
INSERT INTO `sys_dept` VALUES ('1', '-1', NULL, '山东农信', NULL, b'0', '1', '', '2018-01-22 19:00:23.000', NULL, '2019-07-04 16:57:18.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('10', '8', NULL, '院校沙县', NULL, b'0', '1', '', '2018-12-10 21:19:26.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('2', '-1', NULL, '沙县国际', NULL, b'0', '1', '', '2018-01-22 19:00:38.000', NULL, '2019-07-04 16:57:22.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('3', '1', NULL, '潍坊农信', NULL, b'0', '1', '', '2018-01-22 19:00:44.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('4', '3', NULL, '高新农信', 30, b'0', '1', '', '2018-01-22 19:00:52.000', '1', '2019-07-14 09:02:57.000', 6, '', '0');
INSERT INTO `sys_dept` VALUES ('5', '4', NULL, '院校农信', 30, b'0', '1', '', '2018-01-22 19:00:57.000', '1', '2019-07-14 09:10:44.000', 1, '', '0');
INSERT INTO `sys_dept` VALUES ('5f86e2a82b040b1f618aefc62f403024', '5', '5,', '11', 1, b'1', '1', '1', '2019-07-14 09:10:45.000', '1', '2019-07-14 09:10:57.000', 0, NULL, '1');
INSERT INTO `sys_dept` VALUES ('6', '5', NULL, '潍院农信', NULL, b'0', '1', '', '2018-01-22 19:01:06.000', NULL, '2019-01-09 10:58:18.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('7', '2', NULL, '山东沙县', NULL, b'0', '1', '', '2018-01-22 19:01:57.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('8', '7', NULL, '潍坊沙县', NULL, b'0', '1', '', '2018-01-22 19:02:03.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('9', '8', NULL, '高新沙县', NULL, b'0', '1', '', '2018-01-22 19:02:14.000', NULL, '2018-09-13 01:46:44.000', 0, '', '0');

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
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES (1, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：5毫秒', '1', '2020-04-24 12:07:00.071', '2020-04-24 12:07:00.076', '2020-04-24 12:07:00.076', '', NULL);
INSERT INTO `sys_job_log` VALUES (2, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:07:15.011', '2020-04-24 12:07:15.011', '2020-04-24 12:07:15.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (3, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 12:07:30.010', '2020-04-24 12:07:30.011', '2020-04-24 12:07:30.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (4, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:07:45.008', '2020-04-24 12:07:45.008', '2020-04-24 12:07:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (5, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:08:00.009', '2020-04-24 12:08:00.009', '2020-04-24 12:08:00.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (6, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:08:15.009', '2020-04-24 12:08:15.009', '2020-04-24 12:08:15.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (7, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:08:30.006', '2020-04-24 12:08:30.006', '2020-04-24 12:08:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (8, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:08:45.015', '2020-04-24 12:08:45.015', '2020-04-24 12:08:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (9, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 12:09:00.007', '2020-04-24 12:09:00.008', '2020-04-24 12:09:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (10, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:09:15.007', '2020-04-24 12:09:15.007', '2020-04-24 12:09:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (11, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 12:09:30.006', '2020-04-24 12:09:30.007', '2020-04-24 12:09:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (12, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：11毫秒', '1', '2020-04-24 12:12:45.090', '2020-04-24 12:12:45.101', '2020-04-24 12:12:45.101', '', NULL);
INSERT INTO `sys_job_log` VALUES (13, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：8毫秒', '1', '2020-04-24 12:13:00.020', '2020-04-24 12:13:00.028', '2020-04-24 12:13:00.028', '', NULL);
INSERT INTO `sys_job_log` VALUES (14, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:13:15.007', '2020-04-24 12:13:15.007', '2020-04-24 12:13:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (15, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:13:30.007', '2020-04-24 12:13:30.007', '2020-04-24 12:13:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (16, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:13:45.008', '2020-04-24 12:13:45.008', '2020-04-24 12:13:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (17, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:14:00.010', '2020-04-24 12:14:00.010', '2020-04-24 12:14:00.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (18, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:14:15.007', '2020-04-24 12:14:15.007', '2020-04-24 12:14:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (19, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 12:14:30.007', '2020-04-24 12:14:30.008', '2020-04-24 12:14:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (20, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:14:45.007', '2020-04-24 12:14:45.007', '2020-04-24 12:14:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (21, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 12:15:00.014', '2020-04-24 12:15:00.015', '2020-04-24 12:15:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (22, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 12:15:15.008', '2020-04-24 12:15:15.009', '2020-04-24 12:15:15.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (23, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：5毫秒', '1', '2020-04-24 12:25:30.100', '2020-04-24 12:25:30.105', '2020-04-24 12:25:30.105', '', NULL);
INSERT INTO `sys_job_log` VALUES (24, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 12:25:45.017', '2020-04-24 12:25:45.018', '2020-04-24 12:25:45.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (25, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：5毫秒', '1', '2020-04-24 12:26:45.090', '2020-04-24 12:26:45.095', '2020-04-24 12:26:45.095', '', NULL);
INSERT INTO `sys_job_log` VALUES (26, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：2毫秒', '1', '2020-04-24 12:27:00.021', '2020-04-24 12:27:00.023', '2020-04-24 12:27:00.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (27, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 12:27:15.011', '2020-04-24 12:27:15.012', '2020-04-24 12:27:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (28, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 12:27:30.015', '2020-04-24 12:27:30.016', '2020-04-24 12:27:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (29, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 12:27:45.007', '2020-04-24 12:27:45.007', '2020-04-24 12:27:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (30, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 12:28:00.010', '2020-04-24 12:28:00.011', '2020-04-24 12:28:00.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (31, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：3毫秒', '1', '2020-04-24 12:28:15.011', '2020-04-24 12:28:15.014', '2020-04-24 12:28:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (32, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：3毫秒', '1', '2020-04-24 17:54:45.076', '2020-04-24 17:54:45.079', '2020-04-24 17:54:45.079', '', NULL);
INSERT INTO `sys_job_log` VALUES (33, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 17:55:00.032', '2020-04-24 17:55:00.032', '2020-04-24 17:55:00.032', '', NULL);
INSERT INTO `sys_job_log` VALUES (34, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 17:55:15.357', '2020-04-24 17:55:15.358', '2020-04-24 17:55:15.358', '', NULL);
INSERT INTO `sys_job_log` VALUES (35, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 17:55:30.008', '2020-04-24 17:55:30.008', '2020-04-24 17:55:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (36, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 17:55:45.010', '2020-04-24 17:55:45.010', '2020-04-24 17:55:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (37, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 17:56:00.019', '2020-04-24 17:56:00.019', '2020-04-24 17:56:00.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (38, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-04-24 17:56:15.017', '2020-04-24 17:56:15.018', '2020-04-24 17:56:15.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (39, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 17:56:30.016', '2020-04-24 17:56:30.016', '2020-04-24 17:56:30.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (40, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-04-24 17:56:45.017', '2020-04-24 17:56:45.017', '2020-04-24 17:56:45.017', '', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志表' ROW_FORMAT = Dynamic;

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
  `message` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '登录日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log_login
-- ----------------------------
INSERT INTO `sys_log_login` VALUES (1, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-02-05 01:59:25', '0');
INSERT INTO `sys_log_login` VALUES (2, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-02-05 01:59:34', '0');
INSERT INTO `sys_log_login` VALUES (3, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-02-05 02:10:13', '0');
INSERT INTO `sys_log_login` VALUES (4, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-03-08 14:55:07', '0');
INSERT INTO `sys_log_login` VALUES (5, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-03-21 09:02:03', '0');
INSERT INTO `sys_log_login` VALUES (6, 'test', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-03-21 10:17:22', '0');
INSERT INTO `sys_log_login` VALUES (7, 'test', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-03-21 10:18:38', '0');
INSERT INTO `sys_log_login` VALUES (8, 'test', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-03-21 10:45:02', '0');
INSERT INTO `sys_log_login` VALUES (9, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-04-08 09:29:44', '0');
INSERT INTO `sys_log_login` VALUES (10, 'test', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-04-08 09:29:56', '0');
INSERT INTO `sys_log_login` VALUES (11, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-04-24 11:11:28', '0');
INSERT INTO `sys_log_login` VALUES (12, 'admin', '192.168.86.53', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-04-24 11:13:06', '0');
INSERT INTO `sys_log_login` VALUES (13, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-07 12:04:33', '0');
INSERT INTO `sys_log_login` VALUES (14, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-07 14:27:04', '0');
INSERT INTO `sys_log_login` VALUES (15, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-07 16:37:02', '0');
INSERT INTO `sys_log_login` VALUES (16, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:29:51', '0');
INSERT INTO `sys_log_login` VALUES (17, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-08 01:42:55', '0');
INSERT INTO `sys_log_login` VALUES (18, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:43:04', '0');
INSERT INTO `sys_log_login` VALUES (19, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:44:34', '0');
INSERT INTO `sys_log_login` VALUES (20, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:44:58', '0');
INSERT INTO `sys_log_login` VALUES (21, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:45:33', '0');
INSERT INTO `sys_log_login` VALUES (22, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:46:10', '0');
INSERT INTO `sys_log_login` VALUES (23, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:49:26', '0');
INSERT INTO `sys_log_login` VALUES (24, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:49:32', '0');
INSERT INTO `sys_log_login` VALUES (25, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:49:36', '0');
INSERT INTO `sys_log_login` VALUES (26, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:49:47', '0');
INSERT INTO `sys_log_login` VALUES (27, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:50:31', '0');
INSERT INTO `sys_log_login` VALUES (28, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:50:39', '0');
INSERT INTO `sys_log_login` VALUES (29, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:51:23', '0');
INSERT INTO `sys_log_login` VALUES (30, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:51:30', '0');
INSERT INTO `sys_log_login` VALUES (31, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:52:40', '0');
INSERT INTO `sys_log_login` VALUES (32, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:52:55', '0');
INSERT INTO `sys_log_login` VALUES (33, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:55:26', '0');
INSERT INTO `sys_log_login` VALUES (34, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:56:12', '0');
INSERT INTO `sys_log_login` VALUES (35, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:57:57', '0');
INSERT INTO `sys_log_login` VALUES (36, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 01:59:12', '0');
INSERT INTO `sys_log_login` VALUES (37, 'admin1', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '用户不存在', '2020-05-08 01:59:21', '0');
INSERT INTO `sys_log_login` VALUES (38, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 02:07:03', '0');
INSERT INTO `sys_log_login` VALUES (39, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 02:08:55', '0');
INSERT INTO `sys_log_login` VALUES (40, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 02:09:12', '0');
INSERT INTO `sys_log_login` VALUES (41, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 02:13:59', '0');
INSERT INTO `sys_log_login` VALUES (42, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 02:14:55', '0');
INSERT INTO `sys_log_login` VALUES (43, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Bad credentials', '2020-05-08 02:18:46', '0');
INSERT INTO `sys_log_login` VALUES (44, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '密码填写错误！', '2020-05-08 02:19:50', '0');
INSERT INTO `sys_log_login` VALUES (45, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '密码填写错误！', '2020-05-08 02:19:58', '0');
INSERT INTO `sys_log_login` VALUES (46, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '密码填写错误！', '2020-05-08 02:21:16', '0');
INSERT INTO `sys_log_login` VALUES (47, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '密码填写错误！', '2020-05-08 02:21:18', '0');
INSERT INTO `sys_log_login` VALUES (48, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '密码填写错误！', '2020-05-08 02:21:21', '0');
INSERT INTO `sys_log_login` VALUES (49, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-08 02:23:31', '0');
INSERT INTO `sys_log_login` VALUES (50, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-08 02:24:09', '0');
INSERT INTO `sys_log_login` VALUES (51, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-08 02:30:56', '0');
INSERT INTO `sys_log_login` VALUES (52, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-08 02:31:48', '0');
INSERT INTO `sys_log_login` VALUES (53, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '密码填写错误！', '2020-05-08 02:33:03', '0');
INSERT INTO `sys_log_login` VALUES (54, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-08 02:33:10', '0');
INSERT INTO `sys_log_login` VALUES (55, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-08 02:52:02', '0');
INSERT INTO `sys_log_login` VALUES (56, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:12:14', '0');
INSERT INTO `sys_log_login` VALUES (57, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:13:51', '0');
INSERT INTO `sys_log_login` VALUES (58, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:15:47', '0');
INSERT INTO `sys_log_login` VALUES (59, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:20:42', '0');
INSERT INTO `sys_log_login` VALUES (60, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:26:25', '0');
INSERT INTO `sys_log_login` VALUES (61, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:39:45', '0');
INSERT INTO `sys_log_login` VALUES (62, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:40:35', '0');
INSERT INTO `sys_log_login` VALUES (63, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:40:52', '0');
INSERT INTO `sys_log_login` VALUES (64, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:44:45', '0');
INSERT INTO `sys_log_login` VALUES (65, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:44:51', '0');
INSERT INTO `sys_log_login` VALUES (66, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:45:14', '0');
INSERT INTO `sys_log_login` VALUES (67, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:45:23', '0');
INSERT INTO `sys_log_login` VALUES (68, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 10:58:33', '0');
INSERT INTO `sys_log_login` VALUES (69, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 11:06:33', '0');
INSERT INTO `sys_log_login` VALUES (70, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 11:06:55', '0');
INSERT INTO `sys_log_login` VALUES (71, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 11:07:17', '0');
INSERT INTO `sys_log_login` VALUES (72, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 11:07:49', '0');
INSERT INTO `sys_log_login` VALUES (73, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 11:09:40', '0');
INSERT INTO `sys_log_login` VALUES (74, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 11:11:13', '0');
INSERT INTO `sys_log_login` VALUES (75, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 11:14:18', '0');
INSERT INTO `sys_log_login` VALUES (76, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-09 11:30:17', '0');
INSERT INTO `sys_log_login` VALUES (77, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'com.albedo.java.modules.sys.domain.vo.MenuVo cannot be cast to com.albedo.java.modules.sys.domain.dto.MenuDto', '2020-05-10 10:43:54', '0');
INSERT INTO `sys_log_login` VALUES (78, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'com.albedo.java.modules.sys.domain.vo.MenuVo cannot be cast to com.albedo.java.modules.sys.domain.dto.MenuDto', '2020-05-10 10:44:45', '0');
INSERT INTO `sys_log_login` VALUES (79, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-10 10:55:21', '0');
INSERT INTO `sys_log_login` VALUES (80, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-10 11:36:09', '0');
INSERT INTO `sys_log_login` VALUES (81, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-10 11:37:49', '0');
INSERT INTO `sys_log_login` VALUES (82, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-10 13:53:23', '0');
INSERT INTO `sys_log_login` VALUES (83, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-10 16:36:20', '0');
INSERT INTO `sys_log_login` VALUES (84, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-10 17:33:24', '0');
INSERT INTO `sys_log_login` VALUES (85, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-11 11:10:58', '0');
INSERT INTO `sys_log_login` VALUES (86, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-11 06:20:46', '0');
INSERT INTO `sys_log_login` VALUES (87, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'nested exception is org.apache.ibatis.reflection.ReflectionException: Could not set property \'version\' of \'class com.albedo.java.modules.sys.domain.vo.UserVo\' with value \'9\' Cause: org.apache.ibatis.reflection.ReflectionException: There is no setter for property named \'version\' in \'class com.albedo.java.modules.sys.domain.vo.UserVo\'', '2020-05-11 09:56:16', '0');
INSERT INTO `sys_log_login` VALUES (88, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'nested exception is org.apache.ibatis.reflection.ReflectionException: Could not set property \'createdBy\' of \'class com.albedo.java.modules.sys.domain.vo.MenuVo\' with value \'\' Cause: org.apache.ibatis.reflection.ReflectionException: There is no setter for property named \'createdBy\' in \'class com.albedo.java.modules.sys.domain.vo.MenuVo\'', '2020-05-11 09:59:03', '0');
INSERT INTO `sys_log_login` VALUES (89, 'admin', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2020-05-11 10:04:21', '0');

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log_operate
-- ----------------------------
INSERT INTO `sys_log_operate` VALUES (1, '用户管理', 'test', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', '/a/sys/user/', 'POST', '{\"id\":\"90da0206c39867a1b36ac36ced80c1a9\",\"delFlag\":\"0\",\"createdBy\":\"1\",\"createdDate\":\"2019-07-07 14:35:13\",\"lastModifiedBy\":\"1\",\"version\":36,\"lastModifiedDate\":\"2019-08-09 10:58:20\",\"description\":null,\"username\":\"test\",\"password\":\"\",\"availableText\":\"是\",\"available\":\"1\",\"email\":null,\"phone\":null,\"avatar\":null,\"parentDeptId\":\"1\",\"deptId\":\"3\",\"deptName\":\"潍坊农信\",\"wxOpenId\":null,\"qqOpenId\":null,\"roleNames\":\"管理员\",\"roleIdList\":[\"2\"]}', '56', 1, 1, NULL, '90da0206c39867a1b36ac36ced80c1a9', '2020-03-21 10:17:46.690', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (2, '角色管理', 'test', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', '/a/sys/role', 'POST', '{\"id\":\"2\",\"delFlag\":\"0\",\"createdBy\":\"\",\"createdDate\":\"2018-11-11 19:42:26\",\"lastModifiedBy\":\"1\",\"version\":9,\"lastModifiedDate\":\"2019-08-18 09:25:55\",\"description\":null,\"availableText\":\"是\",\"available\":\"1\",\"dataScopeText\":\"按明细设置\",\"dataScope\":\"5\",\"name\":\"ROLE_CQQ\",\"code\":\"ROLE_CQQ\",\"remark\":\"ROLE_CQQ\",\"menuIdList\":[\"1100\",\"1a900c3f10ef5b0987e0a8ee4445316d\",\"1101\",\"1102\",\"1103\",\"bd62904371247f56594741ff8e9bded9\",\"1201\",\"1202\",\"1300\",\"1301\",\"1302\",\"1303\",\"1304\",\"1400\",\"1401\",\"1402\",\"1403\",\"e5ea38c1f97dee0043e78f3fb27b25d6\"],\"deptIdList\":[\"3\",\"4\",\"5\"]}', '54', 1, 1, NULL, '90da0206c39867a1b36ac36ced80c1a9', '2020-03-21 10:18:22.507', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (3, '角色管理', 'test', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', '/a/sys/role', 'POST', '{\"id\":\"2\",\"delFlag\":\"0\",\"createdBy\":\"\",\"createdDate\":\"2018-11-11 19:42:26\",\"lastModifiedBy\":\"90da0206c39867a1b36ac36ced80c1a9\",\"version\":10,\"lastModifiedDate\":\"2020-03-21 10:18:22\",\"description\":null,\"availableText\":\"是\",\"available\":\"1\",\"dataScopeText\":\"按明细设置\",\"dataScope\":\"4\",\"name\":\"ROLE_CQQ\",\"code\":\"ROLE_CQQ\",\"remark\":\"ROLE_CQQ\",\"menuIdList\":[\"1100\",\"1101\",\"1102\",\"1103\",\"1201\",\"1202\",\"1300\",\"1301\",\"1302\",\"1303\",\"1304\",\"1400\",\"1401\",\"1402\",\"1403\",\"1a900c3f10ef5b0987e0a8ee4445316d\",\"bd62904371247f56594741ff8e9bded9\",\"e5ea38c1f97dee0043e78f3fb27b25d6\"],\"deptIdList\":[\"3\",\"5\",\"4\"]}', '55', 1, 1, NULL, '90da0206c39867a1b36ac36ced80c1a9', '2020-03-21 10:44:46.771', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (4, '角色管理', 'test', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/role', 'POST', '{\"id\":\"2\",\"delFlag\":\"0\",\"createdBy\":\"\",\"createdDate\":\"2018-11-11 19:42:26\",\"lastModifiedBy\":\"90da0206c39867a1b36ac36ced80c1a9\",\"version\":11,\"lastModifiedDate\":\"2020-03-21 10:44:46\",\"description\":null,\"availableText\":\"是\",\"available\":\"1\",\"dataScopeText\":\"仅本人数据\",\"dataScope\":\"2\",\"name\":\"ROLE_CQQ\",\"code\":\"ROLE_CQQ\",\"remark\":\"ROLE_CQQ\",\"menuIdList\":[\"1100\",\"1101\",\"1102\",\"1103\",\"1201\",\"1202\",\"1300\",\"1301\",\"1302\",\"1303\",\"1304\",\"1400\",\"1401\",\"1402\",\"1403\",\"1a900c3f10ef5b0987e0a8ee4445316d\",\"bd62904371247f56594741ff8e9bded9\",\"e5ea38c1f97dee0043e78f3fb27b25d6\"],\"deptIdList\":[\"4\",\"3\",\"5\"]}', '57', 1, 1, NULL, '90da0206c39867a1b36ac36ced80c1a9', '2020-04-08 09:29:32.704', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (5, '业务表', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'POST', '{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"name\":\"test_book\",\"comments\":\"测试书籍\",\"className\":\"TestBook\",\"parentTable\":null,\"parentTableFk\":null,\"parent\":null,\"childList\":[],\"nameAndTitle\":\"test_book  :  测试书籍\",\"nameLike\":null,\"pkList\":[\"id\"],\"category\":null,\"pkColumnList\":[{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"id\",\"title\":\"id\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"id\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":10,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"id  :  id\",\"size\":\"32\",\"null\":false,\"unique\":false,\"list\":false,\"pk\":true,\"constantJavaField\":\"ID\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"id\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"id\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"32\"}],\"columnList\":[{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"id\",\"title\":\"id\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"id\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":10,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"id  :  id\",\"size\":\"32\",\"null\":false,\"unique\":false,\"list\":false,\"pk\":true,\"constantJavaField\":\"ID\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"id\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"id\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"32\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"title_\",\"title\":\"标题\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"title\",\"queryType\":\"like\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":20,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"title_  :  标题\",\"size\":\"32\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"TITLE\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"title\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"标题长度必须介于 1 和 32 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"标题长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":true,\"edit\":true,\"insert\":true,\"javaFieldId\":\"title\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"32\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"author_\",\"title\":\"作者\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"author\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":30,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"nameAndTitle\":\"author_  :  作者\",\"size\":\"50\",\"null\":false,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"AUTHOR\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"author\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"作者长度必须介于 1 和 50 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"作者长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"author\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"50\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"name_\",\"title\":\"名称\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"name\",\"queryType\":\"like\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":40,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"nameAndTitle\":\"name_  :  名称\",\"size\":\"50\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"NAME\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"name\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"名称长度必须介于 1 和 50 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"名称长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaFieldAttrs\":[],\"query\":true,\"edit\":true,\"insert\":true,\"javaFieldId\":\"name\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"50\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"email_\",\"title\":\"邮箱\",\"comments\":null,\"jdbcType\":\"varchar(100)\",\"javaType\":\"String\",\"javaField\":\"email\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":50,\"hibernateValidatorExprssion\":\"@Email @Size(max=100)\",\"nameAndTitle\":\"email_  :  邮箱\",\"size\":\"100\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"EMAIL\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"email\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=100, message=\\\"邮箱长度必须介于 1 和 100 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=100, message=\\\"邮箱长度必须介于 1 和 100 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"email\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"100\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"phone_\",\"title\":\"手机\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"phone\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":60,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"phone_  :  手机\",\"size\":\"32\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"PHONE\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"phone\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"手机长度必须介于 1 和 32 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"手机长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"phone\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"32\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"activated_\",\"title\":\"activated_\",\"comments\":null,\"jdbcType\":\"bit(1)\",\"javaType\":\"Integer\",\"javaField\":\"activated\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":70,\"hibernateValidatorExprssion\":\"@NotNull \",\"nameAndTitle\":\"activated_  :  activated_\",\"size\":\"1\",\"null\":false,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"ACTIVATED\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"activated\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"activated_不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"activated_不能为空\\\")\"],\"simpleJavaType\":\"Integer\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"activated\",\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"dataLength\":\"1\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"number_\",\"title\":\"key\",\"comments\":null,\"jdbcType\":\"int(11)\",\"javaType\":\"Long\",\"javaField\":\"number\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":80,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"number_  :  key\",\"size\":\"11\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"NUMBER\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"number\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"key不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"key不能为空\\\")\"],\"simpleJavaType\":\"Long\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"number\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"11\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"money_\",\"title\":\"money_\",\"comments\":null,\"jdbcType\":\"decimal(20,2)\",\"javaType\":\"Double\",\"javaField\":\"money\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":90,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"money_  :  money_\",\"size\":\"20,2\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"MONEY\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"money\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"money_不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"money_不能为空\\\")\"],\"simpleJavaType\":\"Double\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"money\",\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"dataLength\":\"0\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"amount_\",\"title\":\"amount_\",\"comments\":null,\"jdbcType\":\"double(11,2)\",\"javaType\":\"Double\",\"javaField\":\"amount\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":100,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"amount_  :  amount_\",\"size\":\"11,2\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"AMOUNT\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"amount\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"amount_不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"amount_不能为空\\\")\"],\"simpleJavaType\":\"Double\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"amount\",\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"dataLength\":\"0\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"reset_date\",\"title\":\"reset_date\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"resetDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":110,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"reset_date  :  reset_date\",\"size\":\"3\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"RESETDATE\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"resetDate\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"reset_date不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"reset_date不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"isDateTimeColumn\":true,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"resetDate\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"3\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"created_by\",\"title\":\"created_by\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"createdBy\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":120,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"nameAndTitle\":\"created_by  :  created_by\",\"size\":\"50\",\"null\":false,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"CREATEDBY\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"createdBy\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"createdBy\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"50\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"created_date\",\"title\":\"created_date\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"createdDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":130,\"hibernateValidatorExprssion\":\"@NotNull \",\"nameAndTitle\":\"created_date  :  created_date\",\"size\":\"3\",\"null\":false,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"CREATEDDATE\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"createdDate\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"created_date不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"created_date不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"createdDate\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"3\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"last_modified_by\",\"title\":\"last_modified_by\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"lastModifiedBy\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":140,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"size\":\"50\",\"null\":true,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"LASTMODIFIEDBY\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"lastModifiedBy\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"lastModifiedBy\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"50\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"last_modified_date\",\"title\":\"last_modified_date\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"lastModifiedDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":150,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"last_modified_date  :  last_modified_date\",\"size\":\"3\",\"null\":true,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"LASTMODIFIEDDATE\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"lastModifiedDate\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"last_modified_date不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"last_modified_date不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"lastModifiedDate\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"3\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"description\",\"title\":\"备注\",\"comments\":null,\"jdbcType\":\"varchar(255)\",\"javaType\":\"String\",\"javaField\":\"description\",\"queryType\":\"eq\",\"showType\":\"textarea\",\"dictType\":\"\",\"sort\":160,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"nameAndTitle\":\"description  :  备注\",\"size\":\"255\",\"null\":true,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"DESCRIPTION\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"description\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"description\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"255\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"version\",\"title\":\"version\",\"comments\":null,\"jdbcType\":\"int(11)\",\"javaType\":\"Long\",\"javaField\":\"version\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":170,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"version  :  version\",\"size\":\"11\",\"null\":true,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"VERSION\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"version\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaType\":\"Long\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"version\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"11\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"del_flag\",\"title\":\"0-正常，1-删除\",\"comments\":null,\"jdbcType\":\"char(1)\",\"javaType\":\"String\",\"javaField\":\"delFlag\",\"queryType\":\"eq\",\"showType\":\"radio\",\"dictType\":\"sys_flag\",\"sort\":180,\"hibernateValidatorExprssion\":\"@Size(max=1)\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"size\":\"1\",\"null\":true,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"DELFLAG\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"delFlag\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"delFlag\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"1\"}],\"columnFormList\":[{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"id\",\"title\":\"id\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"id\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":10,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"id  :  id\",\"size\":\"32\",\"null\":false,\"unique\":false,\"list\":false,\"pk\":true,\"constantJavaField\":\"ID\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"id\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"id\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"32\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"title_\",\"title\":\"标题\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"title\",\"queryType\":\"like\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":20,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"title_  :  标题\",\"size\":\"32\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"TITLE\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"title\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"标题长度必须介于 1 和 32 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"标题长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":true,\"edit\":true,\"insert\":true,\"javaFieldId\":\"title\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"32\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"author_\",\"title\":\"作者\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"author\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":30,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"nameAndTitle\":\"author_  :  作者\",\"size\":\"50\",\"null\":false,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"AUTHOR\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"author\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"作者长度必须介于 1 和 50 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"作者长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"author\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"50\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"name_\",\"title\":\"名称\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"name\",\"queryType\":\"like\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":40,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"nameAndTitle\":\"name_  :  名称\",\"size\":\"50\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"NAME\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"name\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"名称长度必须介于 1 和 50 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"名称长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaFieldAttrs\":[],\"query\":true,\"edit\":true,\"insert\":true,\"javaFieldId\":\"name\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"50\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"email_\",\"title\":\"邮箱\",\"comments\":null,\"jdbcType\":\"varchar(100)\",\"javaType\":\"String\",\"javaField\":\"email\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":50,\"hibernateValidatorExprssion\":\"@Email @Size(max=100)\",\"nameAndTitle\":\"email_  :  邮箱\",\"size\":\"100\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"EMAIL\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"email\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=100, message=\\\"邮箱长度必须介于 1 和 100 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=100, message=\\\"邮箱长度必须介于 1 和 100 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"email\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"100\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"phone_\",\"title\":\"手机\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"phone\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":60,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"phone_  :  手机\",\"size\":\"32\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"PHONE\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"phone\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"手机长度必须介于 1 和 32 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"手机长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"phone\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"32\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"activated_\",\"title\":\"activated_\",\"comments\":null,\"jdbcType\":\"bit(1)\",\"javaType\":\"Integer\",\"javaField\":\"activated\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":70,\"hibernateValidatorExprssion\":\"@NotNull \",\"nameAndTitle\":\"activated_  :  activated_\",\"size\":\"1\",\"null\":false,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"ACTIVATED\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"activated\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"activated_不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"activated_不能为空\\\")\"],\"simpleJavaType\":\"Integer\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"activated\",\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"dataLength\":\"1\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"number_\",\"title\":\"key\",\"comments\":null,\"jdbcType\":\"int(11)\",\"javaType\":\"Long\",\"javaField\":\"number\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":80,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"number_  :  key\",\"size\":\"11\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"NUMBER\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"number\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"key不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"key不能为空\\\")\"],\"simpleJavaType\":\"Long\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"number\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"11\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"money_\",\"title\":\"money_\",\"comments\":null,\"jdbcType\":\"decimal(20,2)\",\"javaType\":\"Double\",\"javaField\":\"money\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":90,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"money_  :  money_\",\"size\":\"20,2\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"MONEY\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"money\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"money_不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"money_不能为空\\\")\"],\"simpleJavaType\":\"Double\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"money\",\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"dataLength\":\"0\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"amount_\",\"title\":\"amount_\",\"comments\":null,\"jdbcType\":\"double(11,2)\",\"javaType\":\"Double\",\"javaField\":\"amount\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":100,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"amount_  :  amount_\",\"size\":\"11,2\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"AMOUNT\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"amount\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"amount_不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"amount_不能为空\\\")\"],\"simpleJavaType\":\"Double\",\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"amount\",\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"dataLength\":\"0\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"reset_date\",\"title\":\"reset_date\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"resetDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":110,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"reset_date  :  reset_date\",\"size\":\"3\",\"null\":true,\"unique\":false,\"list\":true,\"pk\":false,\"constantJavaField\":\"RESETDATE\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"resetDate\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"reset_date不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"reset_date不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"isDateTimeColumn\":true,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"resetDate\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"3\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"created_by\",\"title\":\"created_by\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"createdBy\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":120,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"nameAndTitle\":\"created_by  :  created_by\",\"size\":\"50\",\"null\":false,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"CREATEDBY\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"createdBy\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"createdBy\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"50\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"created_date\",\"title\":\"created_date\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"createdDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":130,\"hibernateValidatorExprssion\":\"@NotNull \",\"nameAndTitle\":\"created_date  :  created_date\",\"size\":\"3\",\"null\":false,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"CREATEDDATE\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"createdDate\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"created_date不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"created_date不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"createdDate\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"3\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"last_modified_by\",\"title\":\"last_modified_by\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"lastModifiedBy\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":140,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"size\":\"50\",\"null\":true,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"LASTMODIFIEDBY\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"lastModifiedBy\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"lastModifiedBy\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"50\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"last_modified_date\",\"title\":\"last_modified_date\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"lastModifiedDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":150,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"last_modified_date  :  last_modified_date\",\"size\":\"3\",\"null\":true,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"LASTMODIFIEDDATE\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"lastModifiedDate\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"last_modified_date不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"last_modified_date不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"lastModifiedDate\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"3\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"description\",\"title\":\"备注\",\"comments\":null,\"jdbcType\":\"varchar(255)\",\"javaType\":\"String\",\"javaField\":\"description\",\"queryType\":\"eq\",\"showType\":\"textarea\",\"dictType\":\"\",\"sort\":160,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"nameAndTitle\":\"description  :  备注\",\"size\":\"255\",\"null\":true,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"DESCRIPTION\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"description\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":true,\"insert\":true,\"javaFieldId\":\"description\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"255\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"version\",\"title\":\"version\",\"comments\":null,\"jdbcType\":\"int(11)\",\"javaType\":\"Long\",\"javaField\":\"version\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":170,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"version  :  version\",\"size\":\"11\",\"null\":true,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"VERSION\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"version\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaType\":\"Long\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"version\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"11\"},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"del_flag\",\"title\":\"0-正常，1-删除\",\"comments\":null,\"jdbcType\":\"char(1)\",\"javaType\":\"String\",\"javaField\":\"delFlag\",\"queryType\":\"eq\",\"showType\":\"radio\",\"dictType\":\"sys_flag\",\"sort\":180,\"hibernateValidatorExprssion\":\"@Size(max=1)\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"size\":\"1\",\"null\":true,\"unique\":false,\"list\":false,\"pk\":false,\"constantJavaField\":\"DELFLAG\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"delFlag\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"delFlag\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"1\"}],\"updateTimeExists\":false,\"createTimeExists\":false,\"statusExists\":false,\"pkJavaType\":\"String\",\"compositeId\":false,\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.core.annotation.SearchField\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotBlank\",\"javax.validation.constraints.Email\",\"javax.validation.constraints.NotNull\",\"java.util.Date\",\"com.albedo.java.common.core.annotation.DictType\"],\"childeExists\":false,\"notCompositeId\":true,\"pkColumn\":{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"id\",\"title\":\"id\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"id\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":10,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"id  :  id\",\"size\":\"32\",\"null\":false,\"unique\":false,\"list\":false,\"pk\":true,\"constantJavaField\":\"ID\",\"defaultJavaFieldName\":\"name\",\"simpleJavaField\":\"id\",\"javaFieldShowName\":\"\",\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaFieldAttrs\":[],\"query\":false,\"edit\":false,\"insert\":true,\"javaFieldId\":\"id\",\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"dataLength\":\"32\"},\"pkSize\":\"32\",\"pkSqlName\":\"id\",\"parentExists\":false}', '439', 1, 1, NULL, '1', '2020-05-07 12:22:06.377', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (6, '用户管理', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/user/', 'POST', '{\"id\":\"53fb3761bdd95ed3d03f4a07f78ea0eb\",\"username\":\"dsafdf\",\"email\":\"837158@qq.com\",\"available\":\"1\",\"roleIdList\":[\"1\"],\"deptId\":\"3\",\"phone\":13258462101,\"description\":\"11\",\"delFlag\":\"0\",\"createdBy\":\"1\",\"createdDate\":\"2019-07-07 14:32:17\",\"lastModifiedBy\":\"1\",\"version\":19,\"lastModifiedDate\":\"2020-05-11 06:22:51\",\"availableText\":\"是\",\"avatar\":null,\"deptName\":\"潍坊农信\",\"wxOpenId\":null,\"qqOpenId\":null,\"roleNames\":null}', '59', 1, 1, NULL, '1', '2020-05-11 07:31:46.176', NULL, '0');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单ID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单类型 （0菜单 1按钮）',
  `permission` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端URL',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'VUE页面',
  `hidden` bit(1) NULL DEFAULT b'0' COMMENT '隐藏',
  `i_frame` bit(1) NULL DEFAULT NULL COMMENT '是否外链',
  `cache` bit(1) NULL DEFAULT b'0' COMMENT '缓存',
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
INSERT INTO `sys_menu` VALUES ('06874adacf1f272be7928badd4fe8ed1', '配置日志', '0', NULL, 'log', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/log/index', b'0', NULL, b'0', b'1', 30, '1', '2019-08-05 16:16:06.000', '1', '2020-05-09 11:29:37.482', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('0747d9d8f651f19e49748ba68f18c6f5', '任务调度方案编辑', '1', 'quartz_job_edit', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1', '2019-08-14 10:36:03.602', '1', '2019-08-14 10:37:00.053', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('0d0be247863fcbf08b3db943e5f45992', '在线用户查看', '1', 'sys_userOnline_view', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', 'ef2382c0cc2d99ee73444e684237a88a,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-07 09:05:28.000', '1', '2019-08-07 09:05:58.473', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1000', '权限管理', '0', NULL, '/perm', '-1', NULL, 'menu', 'Layout', b'0', NULL, b'0', b'0', 10, '', '2018-09-28 08:29:53.000', '1', '2020-05-09 11:26:40.259', NULL, 13, '0');
INSERT INTO `sys_menu` VALUES ('1100', '用户管理', '0', NULL, 'user', '1000', '1000,', 'peoples', 'sys/user/index', b'0', NULL, b'0', b'0', 10, '', '2017-11-02 22:24:37.000', '1', '2020-05-09 11:29:37.482', NULL, 10, '0');
INSERT INTO `sys_menu` VALUES ('1101', '用户编辑', '1', 'sys_user_edit', NULL, '1100', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2017-11-08 09:52:09.000', NULL, '2019-08-08 13:23:14.225', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1102', '用户锁定', '1', 'sys_user_lock', NULL, '1100', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2017-11-08 09:52:48.000', NULL, '2019-08-08 13:23:14.228', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1103', '用户删除', '1', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2017-11-08 09:54:01.000', NULL, '2019-08-08 13:23:14.231', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('11b9ae870fb0fc89c52236faf43f3d96', '任务调度方案查看', '1', 'quartz_job_view', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1', '2019-08-14 10:35:56.085', '1', '2019-08-14 10:36:03.588', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('1200', '菜单管理', '0', NULL, 'menu', '1000', '1000,', 'menu', 'sys/menu/index', b'0', NULL, b'0', b'0', 20, '', '2017-11-08 09:57:27.000', '1', '2020-05-09 11:29:37.482', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('1201', '菜单编辑', '1', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2017-11-08 10:15:53.000', NULL, '2019-08-08 13:23:14.233', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1202', '菜单锁定', '1', 'sys_menu_lock', NULL, '1200', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2017-11-08 10:16:23.000', NULL, '2019-08-08 13:23:14.235', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1203', '菜单删除', '1', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2017-11-08 10:16:43.000', NULL, '2019-08-08 13:23:14.238', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1300', '角色管理', '0', NULL, 'role', '1000', '1000,', 'role', 'sys/role/index', b'0', NULL, b'0', b'0', 30, '', '2017-11-08 10:13:37.000', '1', '2020-05-09 11:29:37.482', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('1301', '角色编辑', '1', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2017-11-08 10:14:18.000', NULL, '2019-08-08 13:23:14.241', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1302', '角色锁定', '1', 'sys_role_lock', NULL, '1300', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2017-11-08 10:14:41.000', NULL, '2019-08-08 13:23:14.243', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1303', '角色删除', '1', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2017-11-08 10:14:59.000', NULL, '2019-08-08 13:23:14.245', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1304', '角色查看', '1', 'sys_role_view', NULL, '1300', '1300,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '', '2018-04-20 07:22:55.000', '1', '2019-08-07 17:28:17.093', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('13093fb658c1806ad5bd0600316158f2', '操作日志导出', '1', 'sys_logOperate_export', NULL, '2100', '2000,2100,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-07 17:50:46.973', '1', '2019-08-08 15:06:52.841', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1400', '部门管理', '0', NULL, 'dept', '1000', NULL, 'dept', 'sys/dept/index', b'0', NULL, b'0', b'0', 40, '', '2018-01-20 13:17:19.000', '1', '2020-05-09 11:29:37.482', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('1401', '部门编辑', '1', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2018-01-20 14:56:16.000', NULL, '2019-08-08 13:23:14.247', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1402', '部门锁定', '1', 'sys_dept_lock', NULL, '1400', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2018-01-20 14:56:59.000', NULL, '2019-08-08 13:23:14.249', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1403', '部门删除', '1', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2018-01-20 14:57:28.000', NULL, '2019-08-08 13:23:14.251', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('18d6b5e0f6b986cd074bf23de11ecd34', '任务调度删除', '1', 'quartz_job_del', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1', '2019-08-14 10:36:47.091', '1', '2019-08-14 10:36:47.091', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1a900c3f10ef5b0987e0a8ee4445316d', '用户查看', '1', 'sys_user_view', NULL, '1100', '1000,1100,', NULL, NULL, b'0', NULL, b'0', b'1', 10, '1', '2019-08-07 17:27:34.000', '1', '2019-08-09 10:55:47.709', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('2000', '系统管理', '0', NULL, '/sys', '-1', NULL, 'system', 'Layout', b'0', NULL, b'0', b'0', 20, '', '2017-11-07 20:56:00.000', '1', '2020-05-09 11:17:27.544', NULL, 13, '0');
INSERT INTO `sys_menu` VALUES ('2100', '操作日志', '0', NULL, 'log-operate', '2000', '2000,', 'log', 'sys/log-operate/index', b'0', NULL, b'0', b'0', 40, '', '2017-11-20 14:06:22.000', '1', '2020-05-09 11:29:37.482', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('2101', '操作日志删除', '1', 'sys_logOperate_del', NULL, '2100', '2000,2100,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '', '2017-11-20 20:37:37.000', '1', '2019-08-08 15:06:52.843', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('2200', '字典管理', '0', NULL, 'dict', '2000', NULL, 'dictionary', 'sys/dict/index', b'0', NULL, b'0', b'0', 10, '', '2017-11-29 11:30:52.000', '1', '2020-05-09 11:29:37.482', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('2201', '字典删除', '1', 'sys_dict_del', NULL, '2200', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2017-11-29 11:30:11.000', NULL, '2019-08-08 13:23:14.253', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2202', '字典编辑', '1', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 30, '', '2018-05-11 22:34:55.000', NULL, '2019-08-08 13:23:14.256', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('23430df88fb72179c2a85c39eaf4d50b', '任务调度日志清空', '1', 'quartz_job_log_clean', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-15 16:12:26.285', '1', '2019-08-15 16:12:26.285', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('247071d42ff40267c8d8c44eac92da67', '生成方案', '0', NULL, 'scheme', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'dev', 'gen/scheme/index', b'0', NULL, b'0', b'0', 40, '1', '2019-07-21 13:27:35.000', '1', '2020-05-09 11:29:59.824', NULL, 18, '0');
INSERT INTO `sys_menu` VALUES ('2500', '服务接口', '0', NULL, 'swagger2', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'swagger', 'tools/swagger/index', b'0', NULL, b'0', b'1', 500, '', '2018-06-26 10:50:32.000', '1', '2020-05-09 11:20:59.932', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('2600', '令牌管理', '0', NULL, 'persistent-token', '2000', '2000,', 'dev', 'sys/persistent-token/index', b'0', NULL, b'0', b'0', 20, '', '2018-09-04 05:58:41.000', '1', '2020-05-09 11:30:04.263', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('2601', '令牌删除', '1', 'sys_persistentToken_del', NULL, '2600', '2600,', NULL, NULL, b'0', NULL, b'0', b'1', 1, '', '2018-09-04 05:59:50.000', '1', '2019-08-08 15:06:43.169', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('2836ced373377be75936827ecddf7fad', '测试树管理编辑', '1', 'test_testTreeBook_edit', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1', '2019-08-11 14:32:06.856', '1', '2019-08-11 14:43:59.833', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('29de79df95e70d8e8fbdc7945acf214a', '任务调度查看', '1', 'quartz_job_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1', '2019-08-14 10:36:47.085', '1', '2019-08-14 10:36:47.085', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2af0268f695b79abdf6e8b10d559d081', '测试树管理删除', '1', 'test_testTreeBook_del', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1', '2019-08-11 14:32:06.859', '1', '2019-08-11 14:44:03.802', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2c8fdecfee63a310266b2e4b94fd3f4c', '任务调度日志删除', '1', 'quartz_job_log_del', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-15 16:12:07.842', '1', '2019-08-15 16:12:07.842', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2c90f69bccf0845b1aca8b072b730c39', '任务调度方案删除', '1', 'quartz_job_del', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1', '2019-08-14 10:35:56.092', '1', '2019-08-14 10:36:03.588', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2d9efe7ea66351a96da68e6a7cca5e00', '任务调度方案删除', '1', 'quartz_job_del', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1', '2019-08-14 10:36:03.606', '1', '2019-08-14 10:37:03.383', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('322efc9833f2562f8862f882dabdf3d6', '任务调度方案', '0', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index', b'0', NULL, b'0', b'0', 30, '1', '2019-08-14 10:35:56.081', '1', '2020-05-09 11:29:37.482', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('34acb71268387bb85c80849f7377c7fd', '任务日志导出', '1', 'quartz_jobLog_export', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', NULL, b'0', b'1', 40, '1', '2019-08-14 10:36:42.000', '1', '2019-08-15 09:47:37.769', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('34dae0db3f9c97482d598f964bd4c9c7', '配置管理', '0', NULL, 'configuration', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/configuration/index', b'0', NULL, b'0', b'1', 50, '1', '2019-08-05 17:46:50.000', '1', '2020-05-09 11:29:37.482', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('365a9f74f847322d2b8a0eff2b426ef4', '登录日志导出', '1', 'sys_logLogin_export', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', 'a41d4ac1a6cc179696e0dbf284e3efc4,', NULL, NULL, b'0', NULL, b'0', b'1', 40, '1', '2019-08-15 09:26:02.000', '1', '2019-08-15 09:46:53.019', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('3c1c5a48888650b9a7ba5a1763f2e205', '任务日志查看', '1', 'quartz_jobLog_view', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', NULL, b'0', b'1', 20, '1', '2019-08-14 10:36:42.000', '1', '2019-08-15 09:47:41.596', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('413892fe8d52c1163d6659f51299dc96', '代码生成', '0', NULL, '/gen', '-1', NULL, 'dev', 'Layout', b'0', NULL, b'0', b'0', 100, '1', '2019-07-20 12:00:48.000', '1', '2020-05-09 11:18:15.175', NULL, 24, '0');
INSERT INTO `sys_menu` VALUES ('52715698214e88cb09fa4dd1ea5ad348', '生成方案菜单', '1', 'gen_scheme_menu', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-07-25 13:03:03.000', '1', '2019-08-11 09:20:09.081', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('5431004fa397e0280fd75c4a3b73c4aa', '登录日志查看', '1', 'sys_logLogin_view', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1', '2019-08-15 09:26:02.349', '1', '2019-08-15 09:26:02.349', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('5da31e19f05edeea6a7041e3101deefe', '任务日志删除', '1', 'quartz_jobLog_del', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', NULL, b'0', b'1', 80, '1', '2019-08-14 10:36:42.000', '1', '2019-08-15 09:47:45.790', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('621e50e1c7d66a1febeb699bebb2fe35', '任务调度执行', '1', 'quartz_job_run', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-15 16:10:59.000', '1', '2019-08-15 16:11:07.125', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('6e3f89cda84ac2c6e715e7812c102ae8', '在线用户', '0', '', 'online-user', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'Steve-jobs', 'admin/online-user/index', b'0', NULL, b'0', b'0', 30, '1', '2019-08-07 09:03:52.000', '1', '2020-05-09 11:29:37.482', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('74f2b2a8871a298e0acc4d7129d10e9c', '任务调度', '0', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index', b'0', NULL, b'0', b'0', 30, '1', '2019-08-14 10:36:47.081', '1', '2020-05-09 11:29:37.482', NULL, 7, '0');
INSERT INTO `sys_menu` VALUES ('76d6087052dc26b32f3efa71b9cc119b', '任务调度日志', '1', 'quartz_job_log_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-15 16:11:30.986', '1', '2019-08-15 16:11:30.986', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('7b14af9e9fbff286856338a194422b07', '令牌查看', '1', 'sys_persistentToken_view', NULL, '2600', '2600,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-08 09:44:25.617', '1', '2019-08-08 15:06:43.172', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('7c7a876f4cceba2dd92aa539dea6b6e5', '任务日志清空', '1', 'quartz_jobLog_clean', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-15 13:55:37.892', '1', '2019-08-15 13:55:37.892', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('8d3517427e527df11d51da528261c915', '测试树管理', '0', NULL, 'test-tree-book', '413892fe8d52c1163d6659f51299dc96', NULL, 'dev', 'test/test-tree-book/index', b'0', NULL, b'0', b'0', 30, '1', '2019-08-11 14:32:06.849', '1', '2020-05-09 11:29:37.482', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('92f78825551a22fa130c03066f398448', '在线用户删除', '1', 'sys_userOnline_del', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', 'ef2382c0cc2d99ee73444e684237a88a,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-07 09:06:33.448', '1', '2019-08-07 09:06:33.448', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('94b57a562063d103423e2c6125cb30ad', '菜单查看', '1', 'sys_menu_view', NULL, '1200', '1200,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-07 17:27:59.697', '1', '2019-08-09 10:57:24.065', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('9763343d9cce11ce9eb4f21c8e49122b', '任务调度编辑', '1', 'quartz_job_edit', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1', '2019-08-14 10:36:47.088', '1', '2019-08-14 10:36:47.088', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('97722c6d56c8b9990cc3c1a6eea3d6bb', '业务表编辑', '2', 'gen_table_edit', 'edit', 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, 'gen/table/edit', b'0', NULL, b'0', b'1', 30, '1', '2019-07-21 13:24:02.000', '1', '2020-05-09 11:29:37.482', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('a18b33e15bde209a3c9115517c56d9ec', '业务表', '0', '', 'table', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'Steve-jobs', 'gen/table/index', b'0', NULL, b'0', b'0', 30, '1', '2019-07-20 12:02:02.000', '1', '2020-05-09 11:29:37.482', NULL, 17, '0');
INSERT INTO `sys_menu` VALUES ('a41d4ac1a6cc179696e0dbf284e3efc4', '登录日志', '0', NULL, 'log-login', '2000', NULL, 'log', 'sys/log-login/index', b'0', NULL, b'0', b'0', 50, '1', '2019-08-15 09:26:02.345', '1', '2020-05-09 11:29:37.482', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('b961670cbf3454f5927c4bd2a327e915', '生成方案删除', '1', 'gen_scheme_del', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-07-21 13:30:18.000', '1', '2019-08-11 08:50:09.304', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('b963a451117f430703817b3b6c87402a', '任务调度日志导出', '1', 'quartz_job_log_export', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-15 16:13:16.742', '1', '2019-08-15 16:13:16.742', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('bb9dd4b7a2a462193d0f01517308f812', '业务表查看', '1', 'gen_table_view', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-11 08:47:39.828', '1', '2019-08-11 08:47:39.828', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('bd62904371247f56594741ff8e9bded9', '用户管理导入', '1', 'sys_user_import', NULL, '1100', '1000,1100,', NULL, NULL, b'0', NULL, b'0', b'1', 80, '1', '2019-08-07 17:50:02.000', '1', '2019-08-09 10:55:47.711', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('c0ba37c10abaecd89a738c5cf2a2fd24', '服务状态', '0', NULL, 'health', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/health/index', b'0', NULL, b'0', b'1', 40, '1', '2019-08-05 17:21:10.000', '1', '2020-05-09 11:30:02.870', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('c77855e4171d00ae3f97563a8391f70a', '任务调度方案', '0', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index', b'0', NULL, b'0', b'0', 30, '1', '2019-08-14 10:36:03.593', '1', '2020-05-09 11:29:37.482', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c93f8fca7ca6f8631d383b08ab67009a', '任务日志', '0', NULL, 'job-log', '2000', '2000,', 'log', 'quartz/job-log/index', b'0', NULL, b'0', b'0', 60, '1', '2019-08-14 10:36:42.000', '1', '2020-05-09 11:29:37.482', NULL, 9, '0');
INSERT INTO `sys_menu` VALUES ('caaec41413c5713c6f290efe08c11415', '生成方案查看', '1', 'gen_scheme_view', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-11 08:48:09.000', '1', '2019-08-11 08:50:16.065', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('d4c16faad8f883650a3a8eab829ebad9', '操作日志查看', '1', 'sys_logOperate_view', NULL, '2100', '2000,2100,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-07 17:51:38.454', '1', '2019-08-08 15:06:52.844', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('d5897b78312e09024546530fd8b2e8fc', '任务调度方案查看', '1', 'quartz_job_view', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1', '2019-08-14 10:36:03.598', '1', '2019-08-14 10:37:01.776', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e086c4aa4943a883b29cf94680608b89', '生成方案代码', '1', 'gen_scheme_code', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-11 08:55:37.000', '1', '2019-08-11 09:19:50.418', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('e590df103d3382d3091eae818f68626b', '测试树管理查看', '1', 'test_testTreeBook_view', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1', '2019-08-11 14:32:06.853', '1', '2019-08-11 14:44:05.503', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e5ea38c1f97dee0043e78f3fb27b25d6', '生成方案编辑', '1', 'gen_scheme_edit', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-07-21 13:29:14.000', '1', '2019-08-05 15:54:01.914', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('e66c7efccb9e1a0519afc328339e9108', '登录日志删除', '1', 'sys_logLogin_del', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1', '2019-08-15 09:26:02.357', '1', '2019-08-15 09:26:02.357', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('e6ea0a5dc986c69852010e4a24329cf1', '任务调度方案编辑', '1', 'quartz_job_edit', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1', '2019-08-14 10:35:56.089', '1', '2019-08-14 10:36:03.588', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e710a66583fe0e324492462adb16014e', '业务表删除', '1', 'gen_table_del', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-07-21 13:24:45.000', '1', '2019-07-25 13:32:11.051', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('ef2382c0cc2d99ee73444e684237a88a', '资源管理', '0', NULL, '/admin', '-1', NULL, 'dev', 'Layout', b'0', NULL, b'0', b'0', 30, '1', '2019-08-05 15:58:12.000', '1', '2020-05-09 11:30:01.269', NULL, 16, '0');
INSERT INTO `sys_menu` VALUES ('f15e2186907d22765cd149a94905842a', '在线用户强退', '1', 'sys_userOnline_logout', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', 'ef2382c0cc2d99ee73444e684237a88a,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', NULL, b'0', b'1', 30, '1', '2019-08-11 10:57:51.502', '1', '2019-08-11 10:57:51.502', NULL, 0, '0');

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
-- Records of sys_persistent_token
-- ----------------------------
INSERT INTO `sys_persistent_token` VALUES ('00r5k2emv9xzw1wkyu95', '1', 'admin', 'p9uyox709iwplra3h783', '2020-05-08 02:24:09.241', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('2fmvjatb6im2syb0ompf', '1', 'admin', '75412jnyzrvut4j6urq1', '2020-05-09 10:40:35.066', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('2frr0jh7mlsfpcc3f4ga', '1', 'admin', 'q8q8dg2gizjlgc6l6dwr', '2020-04-24 11:13:05.938', '192.168.86.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('44m84x08zl5ybd0j83ix', '1', 'admin', 'esmpis5ut1h6hwji3ptn', '2020-05-09 10:12:14.334', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('4ab80y8q40mnbazz5lez', '1', 'admin', 'vqija6ybsb51hiezrjwo', '2020-05-09 10:39:44.779', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('4rwdiodb2hv8s9jbtpzz', '1', 'admin', 'q72rlc2oadoilbnjn5bv', '2020-05-09 11:30:16.956', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('5okbxyfytm553lugt6u5', '1', 'admin', 'qytnyzuhce0rhckxvp43', '2020-05-08 02:31:48.064', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('5pdv1gecftyhrzmhccrb', '1', 'admin', 'w4ud7i3b1xdxrcrdl0xu', '2020-05-09 10:45:14.233', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('60x4j4m3nvf5iku2ujac', '1', 'admin', '02zrruw057s22py5f7ra', '2020-05-09 11:11:13.306', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('6fx8rmk8q9jgc86rdoiv', '1', 'admin', '8bb0ruaohawvsxp08i4o', '2020-05-09 11:14:17.891', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('7JP0Ls3eXojcnNEOigSW', '1', 'admin', 'TjzM9ptvssY9CIqSz5WN', '2020-02-05 02:10:13.021', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('94v7npvcn6wu3hmyjayx', '1', 'admin', '1lefk1v659s6idoox55b', '2020-05-08 04:58:07.344', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('f72uykfut88b9xnp5r7v', '1', 'admin', 'xqhk6w77fgdpkhbpyodg', '2020-05-09 10:15:46.902', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('ffhtz6hj8wikqxdxryt9', '1', 'admin', '05v93ri1g7pbqq68ua6m', '2020-05-10 11:36:09.204', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('g11qgy9oz6toyyvxfr22', '1', 'admin', '65rrnhmtcye2pxgzi46q', '2020-05-11 10:04:20.800', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('gmtc7sqfzpox08w2f340', '1', 'admin', '5mdc1urm6l32sp4ng3ce', '2020-05-08 02:23:30.516', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('jfvorm8wokoabfwia7s8', '1', 'admin', '7i6qh7w5k1grdwqie9bp', '2020-05-09 10:44:44.819', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('koe44wt2zwkj23jbqtgh', '1', 'admin', '6udno8z7gctolp6hl3q8', '2020-05-10 10:55:20.721', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('q1gswz2l691pp2qiqd1i', '1', 'admin', 'a4jc97vnwmu5vk1hiuhp', '2020-05-09 10:45:23.461', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('q71agw8pck0yskg27y7r', '1', 'admin', '8css4figfyz0rrf3gy6j', '2020-05-09 10:13:51.350', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('sp4mi1tz6242iez0bs9o', '1', 'admin', '6n4pqf1g2mfk3ux6t2e1', '2020-05-10 16:48:43.490', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('vidn8yotvnrl6pxswyvs', '1', 'admin', 'dufz2el7lesmtw7dl4ci', '2020-05-09 10:44:50.790', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('yd9niaq2g8e6w87pkn36', '1', 'admin', 'cjd49gpsiil1vl0o91oq', '2020-05-08 01:20:48.696', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');
INSERT INTO `sys_persistent_token` VALUES ('ym9s61lmeig7mg77xslb', '1', 'admin', 'bulnja45i54hke6ln3l8', '2020-05-08 02:30:56.223', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '编码',
  `level` int(11) NULL DEFAULT NULL COMMENT '角色级别',
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
INSERT INTO `sys_role` VALUES ('1', '管理员', 'ROLE_ADMIN', 1, '1', '1', '', '2017-10-29 15:45:51.000', '1', '2020-05-11 11:33:01.989', NULL, 69, '0');
INSERT INTO `sys_role` VALUES ('2', 'ROLE_CQQ', 'ROLE_CQQ', 1, '2', '1', '', '2018-11-11 19:42:26.000', '90da0206c39867a1b36ac36ced80c1a9', '2020-05-11 11:33:01.993', NULL, 12, '0');

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
INSERT INTO `sys_role_dept` VALUES ('28e2bd6452d0aff99f014136336eab61', '1', '8');
INSERT INTO `sys_role_dept` VALUES ('34481e9777757dd6ffe1c799749b4db5', '2', '5');
INSERT INTO `sys_role_dept` VALUES ('5c5c58ad79db6edea88100e6491e5e30', '2', '4');
INSERT INTO `sys_role_dept` VALUES ('64af22db5dbe5cf69de8fa7f2d917922', '2', '3');

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
INSERT INTO `sys_role_menu` VALUES ('2', '1100');
INSERT INTO `sys_role_menu` VALUES ('2', '1101');
INSERT INTO `sys_role_menu` VALUES ('2', '1102');
INSERT INTO `sys_role_menu` VALUES ('2', '1103');
INSERT INTO `sys_role_menu` VALUES ('2', '1201');
INSERT INTO `sys_role_menu` VALUES ('2', '1202');
INSERT INTO `sys_role_menu` VALUES ('2', '1300');
INSERT INTO `sys_role_menu` VALUES ('2', '1301');
INSERT INTO `sys_role_menu` VALUES ('2', '1302');
INSERT INTO `sys_role_menu` VALUES ('2', '1303');
INSERT INTO `sys_role_menu` VALUES ('2', '1304');
INSERT INTO `sys_role_menu` VALUES ('2', '1400');
INSERT INTO `sys_role_menu` VALUES ('2', '1401');
INSERT INTO `sys_role_menu` VALUES ('2', '1402');
INSERT INTO `sys_role_menu` VALUES ('2', '1403');
INSERT INTO `sys_role_menu` VALUES ('2', '1a900c3f10ef5b0987e0a8ee4445316d');
INSERT INTO `sys_role_menu` VALUES ('2', 'bd62904371247f56594741ff8e9bded9');
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
INSERT INTO `sys_user` VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', 'dsafdf', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, '13258462101', '837158@qq.com', NULL, '3', NULL, NULL, '1', '1', '2019-07-07 14:32:17.000', '1', '2020-05-11 07:31:46.216', '11', 20, '0');
INSERT INTO `sys_user` VALUES ('90da0206c39867a1b36ac36ced80c1a9', 'test', '$2a$10$NmGuhLe7ODgRC0cwHPa0IuJh94uFYGrAMCyndqMwX07s.CH18RmlS', NULL, NULL, NULL, NULL, '3', NULL, NULL, '1', '1', '2019-07-07 14:35:13.000', '90da0206c39867a1b36ac36ced80c1a9', '2020-03-21 10:17:46.722', NULL, 37, '0');

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
-- Records of sys_user_online
-- ----------------------------
INSERT INTO `sys_user_online` VALUES ('017b2859fddebdf1ae1a0a141ab16c5e', 'zsRe3yKlelRnoEySx4rknBdItjehmhgtfkhE-xkm', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-03-21 10:24:22', '2020-03-21 10:44:53', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('05c54a025c481063f983513b4748bc56', 'elNo9qByVyBm5LSN4-nAECZBR5DwUomN0Yu2EdSR', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 11:14:18', '2020-05-09 11:14:18', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('065368b78acf0c124dea3721104ba4fb', '9UM-ei8Sar9XW6jfvekJRNCsNo3Oh98oF012jVhq', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:58:26', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('069905a2bca6f63c602d3e0e654f3e37', 'r-TlQrfkXEGxFSutExgCwe2idWYfAXgZ77M8pfC3', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:44:48', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('07a30de36d0dfd81a65423379c1d404a', 'yaM-B3ZEZzZfK2jnAi2hoLAc44Y7b5BGjq5bGHCq', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-03-21 10:18:38', '2020-03-21 10:20:57', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('0c8185d3af14675c6e521f8c9912f137', 'EF46E3E4DEBD4D9301CB7B93258A671D', '1', 'admin', '1', '山东农信', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-24 12:07:11', '2020-04-24 12:08:15', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259316061827895297', 'ajrb5ZuGCxex_-OOZIN9EQSrw6T5eQKGJBmV4OJz', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-10 10:55:21', '2020-05-10 10:55:21', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259326331501621250', '9EpYdmhTmdSf5v1SmtzH75UUw_xDVQATHAeqkuyw', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-10 11:36:09', '2020-05-10 11:36:09', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259326748033757186', '-dUEoFpjV_pDehyFLsCaIXCITq8WJUITf3L2PRvP', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-10 11:37:49', '2020-05-10 12:33:56', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259360864846426114', 'N1BgOF4eDeIauDW2q1Sn9BdJnyNhjMEJ5o_xPolB', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-10 13:53:23', '2020-05-10 13:53:23', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('1259394779292278786', 'zvn0I1KUeMCiqC8sSPI8F34btQA8imd6R6KBOPKl', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-10 16:08:08', '2020-05-10 16:13:48', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259398834345365505', 'TISBgnFVIkeUqv7xubwJlBvlfrAWPG7AgzMgiJLw', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-10 16:24:15', '2020-05-10 16:24:15', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259401872443363330', 'sppJ-2vlAeU8tdmBCKzhKkzFLt2bKC4h5KJ7Bb0c', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-10 16:36:20', '2020-05-10 16:38:13', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259402998651744257', 'AYki8t-VEeN4FRgr88wAIhevWqflxIbId0riH9rm', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-10 16:40:48', '2020-05-10 16:48:12', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259404993185906689', 'H1qxOT9jxFzYqmlYNtO1r1iK6KKPKUQu9qKgZ4xM', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-10 16:48:44', '2020-05-10 17:33:19', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259416235837423618', 'aUCr7pUuhjFZ_sbyjKoxmYG_dpg51ydR9LM_6P3m', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-10 16:48:44', '2020-05-10 18:11:01', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('1259596558500093953', 'XryEmx76lrsVMCsnwM0_EsNTpJkrUUTJO-sa622W', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 05:29:56', '2020-05-11 05:29:56', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('1259609348740734978', 'lM5uLKVXJDRaQfJ-jBIqYWEzh-ReBvZNbNVHUKMK', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 06:20:46', '2020-05-11 06:20:46', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259612090653683713', 'xDXeEjYL-VmYSDLe70zXV23aofW6h-jhyP2bWFUD', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 06:31:39', '2020-05-11 06:34:24', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259614042963791873', 'cJCpAX88npxk9HDEJ7MvtKgchTVKmbxLGho1YNPt', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 06:39:25', '2020-05-11 06:39:25', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259614334644015105', '0OKdRg0-rxFkCnDFvhSTPB9JDkhQXnkOTm5mDus9', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 06:40:34', '2020-05-11 06:49:27', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('1259624286750134273', 'gy42_22EirtmX3Jj8xhbCEZHY73hZCuG0-OPzPJB', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 07:20:07', '2020-05-11 07:20:07', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259626101000560641', 'B0Nq4mlUb9lywEaaDvOPYI8FljM9FB6zSqFlMPm7', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 07:27:20', '2020-05-11 07:31:51', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259627549440524290', 'dl2nzfHUisqsUFi_Ud5WO-mfLAs3EZnQ7eI8cU8Q', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 07:33:05', '2020-05-11 07:35:55', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259633410535792642', 'k9weqT7cDh01K4X3djR6gd0BuRbei9mFjTtDk8Nc', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 07:56:23', '2020-05-11 07:56:23', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('1259649887397732353', 'SaroGAyRbjr-BPYzpaXXv_GsoTtRGe9uD1YV46Xu', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 09:01:51', '2020-05-11 09:01:51', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('1259649887397732354', 'Y6gg_t5mW2c7R4wmDCw-Xo4WbMeqfEIyafHJGapY', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 09:01:51', '2020-05-11 09:47:34', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259665615437824001', 'QcN59awpkpo9sMLVX0A0SEsruSU-A7KILhX1yoMq', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 10:04:21', '2020-05-11 10:04:21', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259682380637261826', 'NNnNOgXH3tbzOlh0147dkYugpssrgoDCoog5V1Tj', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 11:10:58', '2020-05-11 11:12:34', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259686571246006273', 'd8fLFVXHtRuJ2tVJHEzOJgwZLKpEfDJlTXoxMmIx', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 11:27:37', '2020-05-11 11:27:37', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259686571246006274', 'WQjC4oh3LQGajkWoXMReAdpSx5Euc2plDEgnY-oM', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 11:27:37', '2020-05-11 11:34:02', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1259688462742921218', 'tRsE9CJJKDkBNspy3EpmFks5-Ivl6q3D9vgHDYWN', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-11 11:35:08', '2020-05-11 12:27:34', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('139655b95ed23b756547bd497c00ee38', 'qlsmB7F7im-jsnANQH0l9oY75QehBHi24nhfUYOQ', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:44:31', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1a041372841528eac08f2613e801899d', 'ELoiCTeOIoCDhjEQWZe9uDDiC3_qnqv3oPpJEbQE', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 02:23:31', '2020-05-08 02:33:03', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('1a0f547252af0e2c0ff06ec39ad1b0d1', 'lxexPNR82FR0cZOZXJe-0ufkVO91Dyx08-Is8Iqs', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:29:30', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('20912e5ebdd93aba7efc9c5c39cfa516', 'A8bz96ILTxx87GjTUN1ijWbcN2oDuYDnefDPlhYb', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-03-21 10:17:00', '2020-03-21 10:17:00', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('21b2ad86e5f49b228df2e0d35b452ad8', '4B922FD7A6A87C80811A593439030118', '1', 'admin', '1', '山东农信', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-24 12:02:36', '2020-04-24 12:02:36', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('2480045a4d2562277172929fd6f8e592', 'Mjh-0puwqMw0ZVxeNlM8p1K-QerQ02XYkigRiNlB', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:29:30', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('264b0c55307696d55686a049c8703a54', 'ZvSGNtICHXuZHnUK9fvroEx7yNntuTyOURg7oYF1', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-07 17:23:24', '2020-05-07 17:26:05', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('2650bd40237e5a2f633b8611cda64301', '7Crk3a_ykSs-SCSoQQcElWjP6SevPah4-7P6kbvl', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 02:52:02', '2020-05-08 03:00:12', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('280e408e3e967fe9e2e0ffa377f92153', 'mNpm2_kPOAZxWXwt3V3yDM5XaS17Bm1bfNw_WRmt', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 04:58:07', '2020-05-08 04:58:07', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('35004c5cc9d6792145c7ba8242272f95', '3n2NjHmtLmbeXSmiO4RJTNGq_5y5jJM5kHcKprv5', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-02-05 02:10:13', '2020-02-05 02:10:13', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('363f5f2582e968846526a0d500e56fd6', 'wE97-fMKGor9FELY4NSRa88EgR1ntCJ3n1iYueN-', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 11:05:25', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('44228b3a00d5e38242ceb3cdf188b539', 'XE4H1h99SIqg-YXebyCoZbo85adoGlibF4KvbIL_', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-07 12:04:33', '2020-05-07 12:49:44', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('45d94cbb29fa4d449208f9fee7a128fc', '57VUvwVzhXzw6JitKWMm7_FiAgsmEND4ZNMHD0z2', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-03-21 10:24:22', '2020-03-21 10:24:22', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('4a18468335010383e1575569643a15f0', '6BA8E3026F94428442F01D136CD0E24C', '1', 'admin', '1', '山东农信', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-24 11:16:56', '2020-04-24 11:16:56', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('5511daa19c07eff23ce1a1f99d354610', 'rc5qAlwYUYC3M1pIRSC0mDZrJ0UVFcDQXnvOb2QL', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:26:10', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('55a284b1897467677e7449d680dbd21c', 'zuW2hP5UuxmzQ2Mi01FOpIxGTa7V_f-9PPh_8xvL', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 01:20:49', '2020-05-08 01:41:13', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('5dc9c8190d40bedb6ce02eae0873ca92', 'Gh080KQx6mb_AU5Rut-mka8PBh7vbZfp5dzfBGLO', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:20:39', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('6555555955', 'ReLfeUN_LsJRPI3RwMx_3fD2zTzk4dfaB1Cjg-eG', '1', 'admin', '1', '山东农信', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-24 11:13:21', '2020-04-24 11:13:21', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('669ec5b69f9c174fd04e6533fcbf5bb5', 'vqKnILLTs80CSIXp_-sl5vJBdSJumicGbANVCEno', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-08 09:29:56', '2020-04-08 09:34:26', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('6b84ddb5df07239fafe4971e536dde0a', 'VwRzavxaH7ISMU_nyOy8RYB8bbbHyq4QEica1afi', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-03-21 09:02:03', '2020-03-21 09:07:25', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('78168dc221b757c101818a53b17525f2', 'IGY1SE0MYSh2WDLn3kY30PrcmNAsqruxiI8xWVqk', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 02:23:31', '2020-05-08 02:23:31', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('7d4b8fffde0f90ee67142edb9beb5f65', 'JExI-Xw18mioeG7pro3tF795To70kw1cTZrjkOob', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-03-21 10:24:22', '2020-03-21 10:24:22', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('7de314bd0c495f97d8a962b0e00124cc', 'GbCp5XIGaSJietYI_I2V7uihOrjjvlaZLu8HFODZ', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:13:47', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('84150a0e2a2b9f4a3140928ac23e1e56', '0JrJt62p0Z7pcMjb1OSFJKr8O8gY5uCeft0l07IZ', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-03-21 10:24:22', '2020-03-21 10:24:22', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('845001f965022751dcb88753bea16067', 'Z_bzlzr_RK1Zz-VRpIySYPQaOiekIPYY4ZqjbDzC', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 04:58:07', '2020-05-08 04:58:07', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('8751e4aeff384b4aeb8f9f0b6874cc3d', 'YKEIgouFQXnRwzViJx8i-m4_PHQpLD_XQP2k6jUK', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:44:51', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('8973d0aa5f85715c03d61320d727a9f3', '4Icc4jHmXS_piKm1Mq3L--QsenPxcxThDmW1LLhr', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-03-21 10:17:22', '2020-03-21 10:18:30', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('98b210a0583fc443a120b3173213b909', '3L8i8pdLfh0p92kZnNgewnp0cxRaZPyNMVbePMpO', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 11:06:33', '2020-05-09 11:06:33', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('a5d39c1625cc70ccc1b5c6baa7991773', 'B8qIQXpsv0-4PTIAAjgb7JyYjfBvI4IlDNAiacM-', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:13:47', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('a7e066224c67de7fb3b524fc6c843f9c', '-rmjtju-mc06YHOOSJl4J4OpER_qAiwP1hKavlIt', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 01:20:49', '2020-05-08 01:41:13', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('aa4f8f0f1643e84084a944f600dfa050', '4rx8O_JNXBCUac8h0RAkg3US1QUnoyxnFZLIpKqQ', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 02:23:31', '2020-05-08 02:30:35', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('aafe9320c976453a27bbd9e228c24a1d', '_jQEvnrlBpzWWVUfXzIbRxWUEXa-GBWx3LiBTsoS', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-07 14:27:04', '2020-05-07 14:30:26', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ab4fdf30378cfd0de733c220d3984291', 'MEleSiO8QM4qsTAHITepY-NWX-Uv4LNIZkS4hpmZ', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 11:07:49', '2020-05-09 11:09:05', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ab7177b95af0831b516d6d9f648b723e', 'coGXSYi8AWyxi5DGNZWeJObHM_yMZQB1zsjbVOp8', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:40:25', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('adcdf23a10428e82737411b0df9abeae', '726B4F98A9ADE455792D173855A6F859', '1', 'admin', '1', '山东农信', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-24 12:07:01', '2020-04-24 12:07:01', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('ae27366981fd7aca128cc147dab321a9', 'GkcJx4VU1tmMAqQWPDlo7721wH-d_EEjrQQKHms-', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 11:11:13', '2020-05-09 11:11:13', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('af75eb8d24d63321fb3cab5e5eb04684', '79OQ5p4PT6LknIHAGrDR4sMy5rKmmO7Or7bv6w6D', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 10:12:14', '2020-05-09 10:44:31', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('be804d131565875b3cc5f242d76f8945', 'pTgENDyuzf6beBqjT2BSOlo-8fKH5jNzTOF3rwK4', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-03-21 10:24:22', '2020-03-21 10:24:22', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('c0aa8147ce799ce333b0f673f0c96fc4', 'sDBVDTQP82NoY7Sl4_AeSBOzuwxnDgmE6pLR0fzz', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 04:08:57', '2020-05-08 04:08:57', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('c4e58eb0099f865b4e6c2d39bc870366', 'QgzFmWtuNrtMNs_s8xUhs_wCj1cGuPWP-p_xR77Q', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 11:30:17', '2020-05-09 11:30:17', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('c745e31ce00919e7593c178577b6a908', 'qeDaB5iNXYHwvJzBGRT66MSFkSTAezOzA1SvLT6K', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-08 09:25:44', '2020-04-08 09:29:33', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('cbaed2ef80c09f85ad73693ca65f3b60', 'ZwN2LnxvlqUOUh6hz0nrxNnVGBJJj8Z40bB6KIf_', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-08 09:29:44', '2020-04-08 09:29:44', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('d42a49bf5dc8e42fedc1b091441c979a', '20A326E460638367FB837F632FAE12C3', '1', 'admin', '1', '山东农信', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-24 12:02:36', '2020-04-24 12:02:36', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('d5091245f74b2fdda4610d2e52cd9b0f', 'P9QJFXx2er02ijAJ_kXBdJwOwaXl9GM9VY1eDp4V', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 02:23:31', '2020-05-08 02:30:35', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('e4b9b31a77e97cee072b43297e72b255', '3ksCKOzCrLHtSIIbGZ3I8F2pXH4B8YxDhqlTdS3h', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 02:23:31', '2020-05-08 02:33:03', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('e53791163983c7fcbcd78873ab689a0b', 'pw3DYdVr4MgwcXDpJHCl5pbcl9Xzu6XRKjXLqvZz', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 11:09:40', '2020-05-09 11:10:58', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('e59482f7e8a552f79cc6c20d69580ea5', 'juCa9iuaFry5kBsFv8Rqd6YAt2yg3hoC1ta-qaA7', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-07 16:37:02', '2020-05-07 16:37:02', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('e5f4e5cacd834534ac579172aaab8f52', 'XCE2Vua_aUGNLtJOunk-BJ8kJtgN9jvqHcgN8Kl5', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-03-21 10:45:02', '2020-03-21 10:45:02', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('e9815b392ecff7e09b6e70b7e64be984', 'T48DqRiv4R69ZPLrtkt1EgqflGlmkJHeCsrWoEdW', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-08 01:20:49', '2020-05-08 01:20:49', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('ee028d5dfb58e6f3f877c23e70da9794', 'wuUOs4jCdn_winB1o4KMuV-JCva7cOWwSU4sjlgB', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 11:06:33', '2020-05-09 11:06:37', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('eed465c7227687d6d1930df7b1119323', '3B811C64D8A977EB87A675AAE1110483', '1', 'admin', '1', '山东农信', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-24 11:11:28', '2020-04-24 11:11:28', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('f58f1de4fcab15ffc530b41c487306ed', 'EwbKxX35Uk6a9pG__-3aVzvWqFh3i4wmoXyjwwtb', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-09 11:07:17', '2020-05-09 11:07:17', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('f5c9cc1674804d55cbb9a5431856276b', 'yNZpSeNuiAc9Rp_3N1mmnBKKhQn7tXuupmmFfSLo', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-07 17:19:50', '2020-05-07 17:19:50', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('f9c78fa9e3e3ca90df2638c21d3e57b3', 'CEC7EC702DFA7C579CC26AB786C5DD40', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-24 11:11:09', '2020-04-24 11:11:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('fd8a5264d498417141e88b5c6bad0a68', 'lc1OYcx9HVTB5wXm35XhuW8-3IUKsJajvGQNSQpH', '90da0206c39867a1b36ac36ced80c1a9', 'test', '3', '潍坊农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-18 12:22:09', '2020-04-18 12:22:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ff3ed337db642981532100ef989a56b8', 'qjcFw8goXzvHFJAhknuiq__YHZW5W9V8Qs1oenr5', '1', 'admin', '1', '山东农信', '192.168.86.53', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-04-24 11:13:06', '2020-04-24 11:13:06', 1800, '0');

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
INSERT INTO `sys_user_role` VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', '1');
INSERT INTO `sys_user_role` VALUES ('90da0206c39867a1b36ac36ced80c1a9', '2');

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

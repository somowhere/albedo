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

 Date: 17/05/2020 18:56:53
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
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');

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
  `fired_time` bigint(20) NOT NULL,
  `sched_time` bigint(20) NOT NULL,
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
INSERT INTO `qrtz_job_details` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F62000000000000000102000A4C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C0005656D61696C71007E00094C000567726F757071007E00094C000269647400134C6A6176612F6C616E672F496E74656765723B4C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E00094C000673746174757371007E00094C00077375625461736B71007E000978720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E44617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E71007E000A78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB7870740001317371007E0013770A05000007E405100F26E778737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000097400013174000E302F3130202A202A202A202A203F7074000744454641554C547371007E00170000000174001573696D706C655461736B2E646F4E6F506172616D7374000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000130740001327800);
INSERT INTO `qrtz_job_details` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F62000000000000000102000A4C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C0005656D61696C71007E00094C000567726F757071007E00094C000269647400134C6A6176612F6C616E672F496E74656765723B4C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E00094C000673746174757371007E00094C00077375625461736B71007E000978720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E44617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E71007E000A78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB7870740001317371007E0013770A05000007E405100F1CE778737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000127400013174000E302F3135202A202A202A202A203F7074000744454641554C547371007E00170000000274001D73696D706C655461736B2E646F506172616D732827616C6265646F272974000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000130707800);
INSERT INTO `qrtz_job_details` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F62000000000000000102000A4C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C0005656D61696C71007E00094C000567726F757071007E00094C000269647400134C6A6176612F6C616E672F496E74656765723B4C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E00094C000673746174757371007E00094C00077375625461736B71007E000978720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E44617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E71007E000A78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB7870740001317371007E0013770E05000007E405100F0C320F60C48078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000047400013174000E302F3230202A202A202A202A203F7074000744454641554C547371007E00170000000374004073696D706C655461736B2E646F4D756C7469706C65506172616D732827616C6265646F272C20747275652C20323030304C2C203331362E3530442C203130302974000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000130707800);

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
  `last_checkin_time` bigint(20) NOT NULL,
  `checkin_interval` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('AlbedoQuartzScheduler', 'somewheredembp.lan1589613526383', 1589615059393, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `repeat_count` bigint(20) NOT NULL,
  `repeat_interval` bigint(20) NOT NULL,
  `times_triggered` bigint(20) NOT NULL,
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
  `next_fire_time` bigint(20) NULL DEFAULT NULL,
  `prev_fire_time` bigint(20) NULL DEFAULT NULL,
  `priority` int(11) NULL DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `start_time` bigint(20) NOT NULL,
  `end_time` bigint(20) NULL DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `misfire_instr` smallint(6) NULL DEFAULT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1589614710000, -1, 5, 'PAUSED', 'CRON', 1589614705000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1589614110000, -1, 5, 'PAUSED', 'CRON', 1589614104000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1589613540000, -1, 5, 'PAUSED', 'CRON', 1589613528000, 0, NULL, 2, '');

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
INSERT INTO `sys_dept` VALUES ('1', '-1', NULL, '总部', 30, b'0', '1', '1', '2020-05-15 11:26:57.020', '1', '2020-05-15 14:27:17.404', 11, '', '0');
INSERT INTO `sys_dept` VALUES ('4981e65fbb6059f3a5ceddd6b3426e6d', '9e4dcac1683359bfeac1871ccdc29e9f', '9e4dcac1683359bfeac1871ccdc29e9f,', 'ddd', 1, b'1', '1', '1', '2020-05-15 12:05:18.140', '1', '2020-05-15 12:05:23.939', 0, NULL, '1');
INSERT INTO `sys_dept` VALUES ('6304292a4ecb1448c33447adc0c35f08', '1', '1,', '运营部', 30, b'1', '1', '1', '2020-05-15 12:03:46.542', '1', '2020-05-15 14:27:11.787', 2, '', '0');
INSERT INTO `sys_dept` VALUES ('701903b72179df2c79d383f621eab9c8', '1', '1,', 'AI部', 30, b'1', '1', '1', '2020-05-15 12:04:11.395', '1', '2020-05-15 12:04:11.395', 0, NULL, '0');
INSERT INTO `sys_dept` VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '-1', NULL, 'test', 1, b'0', '1', '1', '2020-05-15 12:05:05.919', '1', '2020-05-15 12:05:23.939', 1, NULL, '1');
INSERT INTO `sys_dept` VALUES ('c095173c3aebcd7ff9c6177fbf7a8b69', '-1', NULL, '平台', 30, b'1', '1', '1', '2020-05-15 11:28:08.383', '1', '2020-05-15 12:04:55.462', 2, NULL, '0');
INSERT INTO `sys_dept` VALUES ('db32c981785f619401518127c48b6247', '1', '1,', '测试部', 30, b'1', '1', '1', '2020-05-15 12:03:57.184', '1', '2020-05-15 12:03:57.184', 0, NULL, '0');
INSERT INTO `sys_dept` VALUES ('f52e1e844bf0fbadf5213214fb621e27', '1', '1,', '开发部', 30, b'1', '1', '1', '2020-05-15 12:03:23.518', '1', '2020-05-15 12:06:51.719', 2, NULL, '0');

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation`  (
  `ancestor` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '祖先节点',
  `descendant` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '后代节点',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`ancestor`, `descendant`) USING BTREE,
  INDEX `idx1`(`ancestor`) USING BTREE,
  INDEX `idx2`(`descendant`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = '部门关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
INSERT INTO `sys_dept_relation` VALUES ('1', '1', '0');
INSERT INTO `sys_dept_relation` VALUES ('1', '6304292a4ecb1448c33447adc0c35f08', '0');
INSERT INTO `sys_dept_relation` VALUES ('1', '701903b72179df2c79d383f621eab9c8', '0');
INSERT INTO `sys_dept_relation` VALUES ('1', 'db32c981785f619401518127c48b6247', '0');
INSERT INTO `sys_dept_relation` VALUES ('1', 'f52e1e844bf0fbadf5213214fb621e27', '0');
INSERT INTO `sys_dept_relation` VALUES ('4981e65fbb6059f3a5ceddd6b3426e6d', '4981e65fbb6059f3a5ceddd6b3426e6d', '1');
INSERT INTO `sys_dept_relation` VALUES ('6304292a4ecb1448c33447adc0c35f08', '6304292a4ecb1448c33447adc0c35f08', '0');
INSERT INTO `sys_dept_relation` VALUES ('701903b72179df2c79d383f621eab9c8', '701903b72179df2c79d383f621eab9c8', '0');
INSERT INTO `sys_dept_relation` VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '4981e65fbb6059f3a5ceddd6b3426e6d', '1');
INSERT INTO `sys_dept_relation` VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '9e4dcac1683359bfeac1871ccdc29e9f', '1');
INSERT INTO `sys_dept_relation` VALUES ('c095173c3aebcd7ff9c6177fbf7a8b69', 'c095173c3aebcd7ff9c6177fbf7a8b69', '0');
INSERT INTO `sys_dept_relation` VALUES ('db32c981785f619401518127c48b6247', 'db32c981785f619401518127c48b6247', '0');
INSERT INTO `sys_dept_relation` VALUES ('f52e1e844bf0fbadf5213214fb621e27', 'f52e1e844bf0fbadf5213214fb621e27', '0');

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
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `available` bit(1) NULL DEFAULT b'1' COMMENT '是否显示1 是0否',
  `leaf` bit(1) NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
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
INSERT INTO `sys_dict` VALUES ('05d01334ecdbe94b856038a32a42512b', '任务分组', NULL, 'quartz_job_group', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-15 16:33:54.745', '1', '2020-05-16 10:24:03.237', 9, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0b2420638683f1eec41242beb9912069', '在线', 'on_line', 'sys_online_status_on_line', 'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30, b'1', b'1', '1', '2019-08-11 11:17:28.210', '1', '2020-05-15 20:54:54.622', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0da02abef85f0c0b4350eaeefb4ca78d', '仅本人数据', '4', 'sys_data_scope_4', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 40, b'1', b'1', '1', '2019-07-14 06:00:03.000', '1', '2020-05-15 20:54:54.622', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0ef7242f2bb88fdbdcbc56e7a879efb0', '查看', 'VIEW', 'sys_business_type_view', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 10, b'1', b'1', '1', '2019-08-07 16:49:39.000', '1', '2020-05-17 13:48:58.580', 8, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0fdd548394368b4969136f32c435fd98', '菜单', '1', 'sys_menu_type_1', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 20, b'1', b'1', '1', '2019-07-14 06:04:44.000', '1', '2020-05-15 21:02:26.017', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('1', '数据字典', '', 'base', '-1', NULL, 1, b'1', b'0', '1', '2018-07-09 06:16:14.000', '1', '2020-05-15 20:54:54.622', 15, '', '0');
INSERT INTO `sys_dict` VALUES ('13276f100593667c3bd40ab8fea734b4', '立即执行', '1', 'quartz_misfire_policy_1', 'cb3d07975904460c94e9e2b30755c04b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 10, b'1', b'1', '1', '2019-08-15 10:24:19.706', '1', '2020-05-16 11:22:07.230', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('181dd29afa852bd47a5ae8dd2e02a623', '正常', '1', 'sys_status_1', '952c07b027bf0be298a9243af701b8c5', '1,cfd5f62f601817a3b0f38f5ccb1f5128,952c07b027bf0be298a9243af701b8c5,', 30, b'1', b'1', '1', '2019-08-14 11:28:01.693', '1', '2020-05-15 20:54:54.622', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('2', '是否标识', '', 'sys_flag', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 10, b'1', b'0', '1', '2019-06-02 17:17:44.000', '1', '2020-05-15 20:54:54.622', 19, NULL, '0');
INSERT INTO `sys_dict` VALUES ('269ebbfff898cf1db0d243e3f7774d2c', '业务数据', 'biz', 'biz', '1', '1,', 30, b'1', b'1', '1', '2019-07-14 04:01:51.000', '1', '2020-05-15 20:54:54.622', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('2ec9dffe7cb0dea12c8e4e2a90279711', '强退', 'FORCE_LOGOUT', 'sys_business_type_force_logout', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 70, b'1', b'1', '1', '2019-08-07 16:52:15.681', '1', '2020-05-17 13:50:42.409', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('3', '是', '1', 'sys_flag_yes', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 10, b'1', b'1', '1', '2018-07-09 06:15:40.000', '1', '2020-05-15 20:54:54.622', 7, '', '0');
INSERT INTO `sys_dict` VALUES ('31d677b181cebb9bde79b78f32e1e8a3', '其他', 'OTHER', 'sys_operate_type_other', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 10, b'1', b'1', '1', '2019-08-07 16:48:21.644', '1', '2020-05-17 14:14:43.112', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('356f3304462386a8827d44b9e6c9482c', '运行中', '1', 'quartz_job_status_1', 'c7243dfd9599957c281be8be786708d5', '1,cfd5f62f601817a3b0f38f5ccb1f5128,c7243dfd9599957c281be8be786708d5,', 10, b'1', b'1', '1', '2020-05-16 10:14:46.614', '1', '2020-05-16 10:31:32.619', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('3e949b67e0c5be3357bdcce9705f7433', '放弃执行', '3', 'quartz_misfire_policy_3', 'cb3d07975904460c94e9e2b30755c04b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 30, b'1', b'1', '1', '2019-08-15 10:24:54.175', '1', '2020-05-16 11:21:48.328', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4', '否', '0', 'sys_flag_no', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 30, b'1', b'1', '1', '2019-06-02 17:26:40.000', '1', '2020-05-15 20:54:54.622', 8, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4198b5e10fe052546ebb689b4103590e', '所在机构数据', '3', 'sys_data_scope_3', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 30, b'1', b'1', '1', '2019-07-14 05:59:13.000', '1', '2020-05-15 20:54:54.622', 9, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4ebd555fb352328cb2db93e15d3243ad', '系统', 'SYSTEM', 'quartz_job_group_system', '05d01334ecdbe94b856038a32a42512b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,05d01334ecdbe94b856038a32a42512b,', 20, b'1', b'1', '1', '2019-08-15 16:34:47.139', '1', '2020-05-16 10:23:56.949', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('51828811168cd9f0ee1d118068a7d0b9', '编辑', 'EDIT', 'sys_business_type_edit', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 20, b'1', b'1', '1', '2019-08-07 16:50:20.634', '1', '2020-05-17 13:49:05.059', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('5933a853cd0199b00424d66f4b92dda3', '所在机构及以下数据', '2', 'sys_data_scope_2', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 20, b'1', b'1', '1', '2019-07-14 05:53:55.000', '1', '2020-05-15 20:54:54.622', 9, NULL, '0');
INSERT INTO `sys_dict` VALUES ('5f2414b2670c9a66c1d5364613caa654', '后台用户', 'MANAGE', 'sys_operate_type_manage', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 20, b'1', b'1', '1', '2019-08-07 16:48:40.344', '1', '2020-05-17 14:14:58.792', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('6b8211aef2fec451b0398b19857443a7', '操作人类别', NULL, 'sys_operator_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-07 15:37:09.613', '1', '2020-05-17 14:15:13.873', 11, NULL, '0');
INSERT INTO `sys_dict` VALUES ('6e4bba74f32df9149d69f8e9bb19cd9d', '目录', '0', 'sys_menu_type_0', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 10, b'1', b'1', '1', '2019-07-14 06:04:10.000', '1', '2020-05-15 21:02:15.230', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('764d1eaf8a39698fc85a7204c96e7089', '生成代码', 'GEN_CODE', 'sys_business_type_gen_code', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 80, b'1', b'1', '1', '2019-08-07 16:52:36.997', '1', '2020-05-17 13:51:07.250', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('80b084e162b0a30b348a45ff29e5b326', '导出', 'EXPORT', 'sys_business_type_export', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 50, b'1', b'1', '1', '2019-08-07 16:51:33.286', '1', '2020-05-17 13:49:43.288', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8153bd2af73b6d59eed9f34d2bc05bb9', '删除', 'DELETE', 'sys_business_type_delete', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 40, b'1', b'1', '1', '2019-08-07 16:50:45.270', '1', '2020-05-17 13:48:51.169', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8883abe4dcf9390df69a5740050abf74', '离线', 'off_line', 'sys_online_status_off_line', 'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30, b'1', b'1', '1', '2019-08-11 11:17:50.132', '1', '2020-05-15 20:54:54.622', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8c4589d0a32c9b84b6254507354a195b', 'test', 'test', 'test', '-1', NULL, 30, b'1', b'1', '1', '2019-07-14 03:59:38.000', '1', '2019-07-14 04:00:28.000', 0, NULL, '1');
INSERT INTO `sys_dict` VALUES ('94e00baf14b640d793c133fb7bfa4c9a', '默认', 'DEFAULT', 'quartz_job_group_default', '05d01334ecdbe94b856038a32a42512b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,05d01334ecdbe94b856038a32a42512b,', 10, b'1', b'1', '1', '2019-08-15 16:34:28.547', '1', '2020-05-16 10:24:03.248', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('952c07b027bf0be298a9243af701b8c5', '状态', NULL, 'sys_status', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-14 11:26:50.424', '1', '2020-05-15 20:54:54.622', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('a5dfce34bdb7aa99560e8c0d393a632f', '全部', '1', 'sys_data_scope_1', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 10, b'1', b'1', '1', '2019-07-14 05:52:44.000', '1', '2020-05-15 20:54:54.622', 9, NULL, '0');
INSERT INTO `sys_dict` VALUES ('aa294a48211a2deb5c7d76c5e90dc28e', '数据范围', '', 'sys_data_scope', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-07-14 05:50:08.000', '1', '2020-05-15 20:54:54.622', 18, NULL, '0');
INSERT INTO `sys_dict` VALUES ('b672448a74c1d1a47eb1378e3d8c6dc9', '导入', 'IMPORT', 'sys_business_type_import', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 60, b'1', b'1', '1', '2019-08-07 16:51:45.855', '1', '2020-05-17 13:50:08.748', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('bec679404aedc7e75eeeef2ac68d9107', '其他', 'OTHER', 'sys_business_type_other', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 90, b'1', b'1', '1', '2020-05-17 13:45:33.764', '1', '2020-05-17 13:49:14.282', 1, NULL, '0');
INSERT INTO `sys_dict` VALUES ('c46ec99af2c1f967bf10cf2c0d96a6c5', '按明细设置', '5', 'sys_data_scope_5', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 50, b'1', b'1', '1', '2019-07-14 06:01:11.000', '1', '2020-05-15 20:54:54.622', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('c7243dfd9599957c281be8be786708d5', '任务状态', NULL, 'quartz_job_status', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2020-05-16 10:13:18.543', '1', '2020-05-16 10:31:43.851', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('cb3d07975904460c94e9e2b30755c04b', '计划执行错误策略', NULL, 'quartz_misfire_policy', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-15 10:23:54.460', '1', '2020-05-16 11:22:16.976', 11, NULL, '0');
INSERT INTO `sys_dict` VALUES ('cfd5f62f601817a3b0f38f5ccb1f5128', '系统数据', 'sys', 'sys', '1', '1,', 30, b'1', b'0', '1', '2019-07-14 01:13:12.000', '1', '2020-05-16 11:21:35.770', 27, NULL, '0');
INSERT INTO `sys_dict` VALUES ('decc4b5f8996c755ba6e5a097486e362', '已暂停', '0', 'quartz_job_status_0', 'c7243dfd9599957c281be8be786708d5', '1,cfd5f62f601817a3b0f38f5ccb1f5128,c7243dfd9599957c281be8be786708d5,', 20, b'1', b'1', '1', '2020-05-16 10:15:08.604', '1', '2020-05-16 10:31:43.863', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e0696db908c87ad57a85c6b326348dbd', '业务操作类型', NULL, 'sys_business_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-07 15:33:35.000', '1', '2020-05-17 13:51:07.237', 34, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e26ee931e276a099fb876541ca18756f', '菜单类型', '', 'sys_menu_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-07-14 06:01:48.000', '1', '2020-05-15 21:02:34.965', 14, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e7891a6351a2e143899849b2955851b2', '锁定', 'LOCK', 'sys_business_type_lock', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 30, b'1', b'1', '1', '2019-08-07 16:50:32.457', '1', '2020-05-17 13:49:23.225', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('ef0368c6fd52ee8f1f4270869da00f18', '按钮', '2', 'sys_menu_type_2', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 30, b'1', b'1', '1', '2019-08-07 13:55:24.531', '1', '2020-05-15 21:02:34.974', 8, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f3592a047c466e348279983336ebaf28', '在线状态', NULL, 'sys_online_status', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-11 11:16:52.095', '1', '2020-05-15 20:54:54.622', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f35adf75d9ab0ca5cec43815b7db5274', '执行一次', '2', 'quartz_misfire_policy_2', 'cb3d07975904460c94e9e2b30755c04b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 20, b'1', b'1', '1', '2019-08-15 10:24:39.273', '1', '2020-05-16 11:22:16.986', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f83a718756762758707c67db3d271c9d', '手机端用户', 'MOBILE', 'sys_operate_type_moblie', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 30, b'1', b'1', '1', '2019-08-07 16:49:00.766', '1', '2020-05-17 14:15:13.882', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('fafe8843b2f4091f8096dc0df09c300c', '失败', '0', 'sys_status_0', '952c07b027bf0be298a9243af701b8c5', '1,cfd5f62f601817a3b0f38f5ccb1f5128,952c07b027bf0be298a9243af701b8c5,', 30, b'1', b'1', '1', '2019-08-14 11:28:11.000', '1', '2020-05-15 20:54:54.622', 3, NULL, '0');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（1允许 0禁止）',
  `sub_task` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子任务id 多个用逗号隔开',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报警邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态(1-运行中，0-暂停)',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` datetime(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'simpleTask.doNoParams', '0/10 * * * * ?', '3', '1', '2', NULL, '0', '', '2019-08-14 10:21:36.000', '1', '2020-05-16 15:38:24.728', NULL, 9, '0');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '0/15 * * * * ?', '3', '1', NULL, NULL, '0', '', '2019-08-14 10:21:36.950', '1', '2020-05-16 15:28:24.387', NULL, 18, '0');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'simpleTask.doMultipleParams(\'albedo\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', NULL, NULL, '0', '', '2019-08-14 10:21:36.000', '1', '2020-05-16 15:12:50.258', NULL, 4, '0');
INSERT INTO `sys_job` VALUES (4, 'test', 'DEFAULT', 'test', '0/20 * * * * ?', '2', '1', '1', NULL, '0', '1', '2020-05-16 15:06:05.098', '1', '2020-05-16 15:21:10.516', NULL, 1, '1');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `start_time` datetime(3) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(3) NULL DEFAULT NULL COMMENT '结束时间',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `exception_info` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES (41, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：11毫秒', '1', '2020-05-16 14:49:14.481', '2020-05-16 14:49:14.492', '2020-05-16 14:49:14.492', '', NULL);
INSERT INTO `sys_job_log` VALUES (42, 'test', 'DEFAULT', '0/20 * * * * ?', 'test', 'test 总共耗时：7毫秒', '0', '2020-05-16 15:13:24.117', '2020-05-16 15:13:24.124', '2020-05-16 15:13:24.128', 'NoSuchBeanDefinitionException: No bean named \'test\' available', NULL);
INSERT INTO `sys_job_log` VALUES (43, '系统默认（多参）', 'DEFAULT', '0/20 * * * * ?', 'simpleTask.doMultipleParams(\'albedo\', true, 2000L, 316.50D, 100)', '系统默认（多参） 总共耗时：12毫秒', '1', '2020-05-16 15:20:09.566', '2020-05-16 15:20:09.578', '2020-05-16 15:20:09.578', '', NULL);
INSERT INTO `sys_job_log` VALUES (44, 'test', 'DEFAULT', '0/20 * * * * ?', 'test', 'test 总共耗时：4毫秒', '0', '2020-05-16 15:20:16.169', '2020-05-16 15:20:16.173', '2020-05-16 15:20:16.177', 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'test\' available\n	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeanDefinition(DefaultListableBeanFactory.java:808)\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getMergedLocalBeanDefinition(AbstractBeanFactory.java:1279)\n	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:297)\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:202)\n	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1108)\n	at com.albedo.java.common.core.util.SpringContextHolder.getBean(SpringContextHolder.java:79)\n	at com.albedo.java.modules.quartz.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:37)\n	at com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:16)\n	at com.albedo.java.modules.quartz.util.AbstractQuartzJob.execute(AbstractQuartzJob.java:39)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', NULL);
INSERT INTO `sys_job_log` VALUES (45, 'test', 'DEFAULT', '0/20 * * * * ?', 'test', 'test 总共耗时：1毫秒', '0', '2020-05-16 15:20:49.412', '2020-05-16 15:20:49.413', '2020-05-16 15:20:49.413', 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'test\' available\n	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeanDefinition(DefaultListableBeanFactory.java:808)\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getMergedLocalBeanDefinition(AbstractBeanFactory.java:1279)\n	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:297)\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:202)\n	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1108)\n	at com.albedo.java.common.core.util.SpringContextHolder.getBean(SpringContextHolder.java:79)\n	at com.albedo.java.modules.quartz.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:37)\n	at com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:16)\n	at com.albedo.java.modules.quartz.util.AbstractQuartzJob.execute(AbstractQuartzJob.java:39)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', NULL);
INSERT INTO `sys_job_log` VALUES (46, 'test', 'DEFAULT', '0/20 * * * * ?', 'test', 'test 总共耗时：0毫秒', '0', '2020-05-16 15:20:50.256', '2020-05-16 15:20:50.256', '2020-05-16 15:20:50.256', 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'test\' available\n	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeanDefinition(DefaultListableBeanFactory.java:808)\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getMergedLocalBeanDefinition(AbstractBeanFactory.java:1279)\n	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:297)\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:202)\n	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1108)\n	at com.albedo.java.common.core.util.SpringContextHolder.getBean(SpringContextHolder.java:79)\n	at com.albedo.java.modules.quartz.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:37)\n	at com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:16)\n	at com.albedo.java.modules.quartz.util.AbstractQuartzJob.execute(AbstractQuartzJob.java:39)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', NULL);
INSERT INTO `sys_job_log` VALUES (47, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-05-16 15:21:45.055', '2020-05-16 15:21:45.055', '2020-05-16 15:21:45.055', '', NULL);
INSERT INTO `sys_job_log` VALUES (48, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:21:50.058', '2020-05-16 15:21:50.058', '2020-05-16 15:21:50.058', '', NULL);
INSERT INTO `sys_job_log` VALUES (49, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:22:00.021', '2020-05-16 15:22:00.021', '2020-05-16 15:22:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (50, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-05-16 15:22:00.029', '2020-05-16 15:22:00.030', '2020-05-16 15:22:00.030', '', NULL);
INSERT INTO `sys_job_log` VALUES (51, '系统默认（多参）', 'DEFAULT', '0/20 * * * * ?', 'simpleTask.doMultipleParams(\'albedo\', true, 2000L, 316.50D, 100)', '系统默认（多参） 总共耗时：1毫秒', '1', '2020-05-16 15:22:00.695', '2020-05-16 15:22:00.696', '2020-05-16 15:22:00.696', '', NULL);
INSERT INTO `sys_job_log` VALUES (52, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:22:10.030', '2020-05-16 15:22:10.030', '2020-05-16 15:22:10.030', '', NULL);
INSERT INTO `sys_job_log` VALUES (53, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-05-16 15:22:15.011', '2020-05-16 15:22:15.012', '2020-05-16 15:22:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (54, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:22:20.010', '2020-05-16 15:22:20.010', '2020-05-16 15:22:20.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (55, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:22:30.026', '2020-05-16 15:22:30.026', '2020-05-16 15:22:30.026', '', NULL);
INSERT INTO `sys_job_log` VALUES (56, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-05-16 15:22:30.044', '2020-05-16 15:22:30.044', '2020-05-16 15:22:30.044', '', NULL);
INSERT INTO `sys_job_log` VALUES (57, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：1毫秒', '1', '2020-05-16 15:22:40.032', '2020-05-16 15:22:40.033', '2020-05-16 15:22:40.033', '', NULL);
INSERT INTO `sys_job_log` VALUES (58, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-05-16 15:22:45.040', '2020-05-16 15:22:45.040', '2020-05-16 15:22:45.040', '', NULL);
INSERT INTO `sys_job_log` VALUES (59, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:22:50.052', '2020-05-16 15:22:50.052', '2020-05-16 15:22:50.052', '', NULL);
INSERT INTO `sys_job_log` VALUES (60, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-05-16 15:23:00.054', '2020-05-16 15:23:00.054', '2020-05-16 15:23:00.054', '', NULL);
INSERT INTO `sys_job_log` VALUES (61, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:23:00.047', '2020-05-16 15:23:00.047', '2020-05-16 15:23:00.047', '', NULL);
INSERT INTO `sys_job_log` VALUES (62, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:23:10.023', '2020-05-16 15:23:10.023', '2020-05-16 15:23:10.023', '', NULL);
INSERT INTO `sys_job_log` VALUES (63, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-05-16 15:23:15.009', '2020-05-16 15:23:15.009', '2020-05-16 15:23:15.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (64, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:23:20.014', '2020-05-16 15:23:20.014', '2020-05-16 15:23:20.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (65, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:23:30.027', '2020-05-16 15:23:30.027', '2020-05-16 15:23:30.027', '', NULL);
INSERT INTO `sys_job_log` VALUES (66, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-05-16 15:23:30.063', '2020-05-16 15:23:30.064', '2020-05-16 15:23:30.064', '', NULL);
INSERT INTO `sys_job_log` VALUES (67, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:23:40.009', '2020-05-16 15:23:40.009', '2020-05-16 15:23:40.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (68, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-05-16 15:23:45.032', '2020-05-16 15:23:45.032', '2020-05-16 15:23:45.032', '', NULL);
INSERT INTO `sys_job_log` VALUES (69, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：2毫秒', '1', '2020-05-16 15:23:50.040', '2020-05-16 15:23:50.042', '2020-05-16 15:23:50.042', '', NULL);
INSERT INTO `sys_job_log` VALUES (70, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:24:00.015', '2020-05-16 15:24:00.015', '2020-05-16 15:24:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (71, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-05-16 15:24:00.022', '2020-05-16 15:24:00.022', '2020-05-16 15:24:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (72, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:24:10.200', '2020-05-16 15:24:10.200', '2020-05-16 15:24:10.200', '', NULL);
INSERT INTO `sys_job_log` VALUES (73, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-05-16 15:24:15.030', '2020-05-16 15:24:15.031', '2020-05-16 15:24:15.031', '', NULL);
INSERT INTO `sys_job_log` VALUES (74, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：3毫秒', '1', '2020-05-16 15:24:20.050', '2020-05-16 15:24:20.053', '2020-05-16 15:24:20.053', '', NULL);
INSERT INTO `sys_job_log` VALUES (75, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:24:30.010', '2020-05-16 15:24:30.010', '2020-05-16 15:24:30.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (76, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-05-16 15:24:30.019', '2020-05-16 15:24:30.020', '2020-05-16 15:24:30.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (77, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:24:40.028', '2020-05-16 15:24:40.028', '2020-05-16 15:24:40.028', '', NULL);
INSERT INTO `sys_job_log` VALUES (78, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-05-16 15:24:45.013', '2020-05-16 15:24:45.013', '2020-05-16 15:24:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (79, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:24:50.014', '2020-05-16 15:24:50.014', '2020-05-16 15:24:50.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (80, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:25:00.014', '2020-05-16 15:25:00.014', '2020-05-16 15:25:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (81, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2020-05-16 15:25:00.027', '2020-05-16 15:25:00.028', '2020-05-16 15:25:00.028', '', NULL);
INSERT INTO `sys_job_log` VALUES (82, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：1毫秒', '1', '2020-05-16 15:25:10.013', '2020-05-16 15:25:10.014', '2020-05-16 15:25:10.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (83, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-05-16 15:25:15.016', '2020-05-16 15:25:15.016', '2020-05-16 15:25:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (84, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：0毫秒', '1', '2020-05-16 15:25:20.040', '2020-05-16 15:25:20.040', '2020-05-16 15:25:20.040', '', NULL);
INSERT INTO `sys_job_log` VALUES (85, '系统默认（无参）', 'DEFAULT', '0/10 * * * * ?', 'simpleTask.doNoParams', '系统默认（无参） 总共耗时：38毫秒', '1', '2020-05-16 15:30:18.500', '2020-05-16 15:30:18.538', '2020-05-16 15:30:18.538', '', NULL);
INSERT INTO `sys_job_log` VALUES (86, '系统默认（有参）', 'DEFAULT', '0/15 * * * * ?', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2020-05-16 15:30:18.571', '2020-05-16 15:30:18.571', '2020-05-16 15:30:18.571', '', NULL);

-- ----------------------------
-- Table structure for sys_log_operate
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_operate`;
CREATE TABLE `sys_log_operate`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `service_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务ID',
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `ip_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求URI',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '操作提交的数据',
  `time` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行时间',
  `operator_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `business_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `exception` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常信息',
  `created_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_log_create_by`(`created_by`) USING BTREE,
  INDEX `sys_log_request_uri`(`request_uri`) USING BTREE,
  INDEX `sys_log_create_date`(`created_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 549 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log_operate
-- ----------------------------
INSERT INTO `sys_log_operate` VALUES (403, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '14', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:11:12.937', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (404, '用户管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/user/', 'GET', '', '35', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:11:15.932', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (405, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:11:19.278', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (406, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:11:20.263', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (407, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '24', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:11:21.823', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (408, '字典管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/dict/', 'GET', '', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:12:19.948', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (409, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '8', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:12:22.514', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (410, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:12:24.848', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (411, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:12:32.000', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (412, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '21', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:12:33.364', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (413, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:12:33.965', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (414, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:12:36.159', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (415, '字典管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/dict/', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:14:02.060', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (416, '字典管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/dict', 'POST', '{\"id\":\"31d677b181cebb9bde79b78f32e1e8a3\",\"name\":\"其他\",\"val\":\"OTHER\",\"code\":\"sys_operate_type_other\",\"available\":null,\"parentId\":\"6b8211aef2fec451b0398b19857443a7\",\"description\":null,\"sort\":10,\"remark\":null,\"enabled\":\"undefined\"}', '46', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 14:14:43.079', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (417, '字典管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/dict/', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:14:43.229', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (418, '字典管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/dict', 'POST', '{\"id\":\"5f2414b2670c9a66c1d5364613caa654\",\"name\":\"后台用户\",\"val\":\"MANAGE\",\"code\":\"sys_operate_type_manage\",\"available\":null,\"parentId\":\"6b8211aef2fec451b0398b19857443a7\",\"description\":null,\"sort\":20,\"remark\":null,\"enabled\":\"undefined\"}', '42', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 14:14:58.760', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (419, '字典管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/dict/', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:14:59.012', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (420, '字典管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/dict', 'POST', '{\"id\":\"f83a718756762758707c67db3d271c9d\",\"name\":\"手机端用户\",\"val\":\"MOBILE\",\"code\":\"sys_operate_type_moblie\",\"available\":null,\"parentId\":\"6b8211aef2fec451b0398b19857443a7\",\"description\":null,\"sort\":30,\"remark\":null,\"enabled\":\"undefined\"}', '39', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 14:15:13.853', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (421, '字典管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/dict/', 'GET', '', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:15:14.291', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (422, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '21', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:15:23.032', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (423, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:15:38.439', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (424, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:16:36.653', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (425, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:16:38.869', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (426, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:16:40.214', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (427, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:16:41.771', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (428, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:16:48.138', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (429, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:16:50.424', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (430, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:16:57.370', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (431, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:16:57.967', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (432, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:17:22.609', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (433, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:17:24.701', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (434, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:17:26.532', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (435, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:17:36.732', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (436, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '14153', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:18:08.555', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (437, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6790', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:19:26.307', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (438, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:20:12.906', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (439, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:20:19.058', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (440, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:20:21.013', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (441, '操作日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/log-operate', 'GET', '', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:20:43.535', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (442, '用户管理', 'ERROR', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/user/', 'GET', '', '55', 'MANAGE', 'VIEW', 'org.mybatis.spring.MyBatisSystemException: nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error of sql : \n SELECT COUNT(1) FROM ( SELECT\n		a.id,\n		a.username,\n		a.`password`,\n		a.salt,\n		a.phone,\n		a.email,\n		a.avatar,\n		a.wx_open_id,\n		a.qq_open_id,\n		a.dept_id,\n		a.created_by,\n		a.created_date,\n		a.last_modified_by,\n		a.last_modified_date,\n		a.description,\n		a.version,\n		a.del_flag,\n		a.available AS available,\n		a.dept_id AS deptId,,\n		b.name AS deptName\n		FROM\n		sys_user AS a\n		INNER JOIN sys_dept AS b ON b.id = a.dept_id\n		 WHERE (a.del_flag = ?) ) TOTAL \n\r\n### The error may exist in file [D:\\IdeaProjects\\albedo\\albedo-common\\albedo-common-api\\target\\classes\\mapper\\sys\\UserMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error of sql : \n SELECT COUNT(1) FROM ( SELECT\n		a.id,\n		a.username,\n		a.`password`,\n		a.salt,\n		a.phone,\n		a.email,\n		a.avatar,\n		a.wx_open_id,\n		a.qq_open_id,\n		a.dept_id,\n		a.created_by,\n		a.created_date,\n		a.last_modified_by,\n		a.last_modified_date,\n		a.description,\n		a.version,\n		a.del_flag,\n		a.available AS available,\n		a.dept_id AS deptId,,\n		b.name AS deptName\n		FROM\n		sys_user AS a\n		INNER JOIN sys_dept AS b ON b.id = a.dept_id\n		 WHERE (a.del_flag = ?) ) TOTAL \n\r\n	at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:92)\r\n	at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:440)\r\n	at com.sun.proxy.$Proxy144.selectList(Unknown Source)\r\n	at org.mybatis.spring.SqlSessionTemplate.selectList(SqlSessionTemplate.java:223)\r\n	at com.baomidou.mybatisplus.core.override.MybatisMapperMethod.executeForIPage(MybatisMapperMethod.java:134)\r\n	at com.baomidou.mybatisplus.core.override.MybatisMapperMethod.execute(MybatisMapperMethod.java:96)\r\n	at com.baomidou.mybatisplus.core.override.MybatisMapperProxy.invoke(MybatisMapperProxy.java:96)\r\n	at com.sun.proxy.$Proxy158.findUserVoPage(Unknown Source)\r\n	at com.albedo.java.modules.sys.service.impl.UserServiceImpl.getUserPage(UserServiceImpl.java:188)\r\n	at com.albedo.java.modules.sys.service.impl.UserServiceImpl$$FastClassBySpringCGLIB$$1a2e4281.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(Transact', '1', '2020-05-17 14:30:30.848', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (443, '任务调度', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/quartz/job', 'GET', '', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:54:45.725', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (444, '任务日志', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/quartz/job-log', 'GET', '', '14', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:54:47.311', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (445, '令牌管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/persistent-token', 'GET', '', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:55:01.220', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (446, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'GET', '', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:55:08.539', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (447, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:55:10.513', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (448, '菜单管理', 'ERROR', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'DELETE', '[\"a41d4ac1a6cc179696e0dbf284e3efc4\"]', '6', 'MANAGE', 'DELETE', 'com.albedo.java.common.core.exception.BadRequestException: 菜单含有下级不能删除\r\n	at com.albedo.java.modules.sys.service.impl.MenuServiceImpl.lambda$removeMenuById$0(MenuServiceImpl.java:132)\r\n	at java.lang.Iterable.forEach(Iterable.java:75)\r\n	at com.albedo.java.modules.sys.service.impl.MenuServiceImpl.removeMenuById(MenuServiceImpl.java:127)\r\n	at com.albedo.java.modules.sys.service.impl.MenuServiceImpl$$FastClassBySpringCGLIB$$6ae2146d.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:366)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:118)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.cache.interceptor.CacheInterceptor.lambda$invoke$0(CacheInterceptor.java:53)\r\n	at org.springframework.cache.interceptor.CacheAspectSupport.invokeOperation(CacheAspectSupport.java:365)\r\n	at org.springframework.cache.interceptor.CacheAspectSupport.execute(CacheAspectSupport.java:420)\r\n	at org.springframework.cache.interceptor.CacheAspectSupport.execute(CacheAspectSupport.java:345)\r\n	at org.springframework.cache.interceptor.CacheInterceptor.invoke(CacheInterceptor.java:61)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.albedo.java.modules.sys.service.impl.MenuServiceImpl$$EnhancerBySpringCGLIB$$dd68ab2f.removeMenuById(<generated>)\r\n	at com.albedo.java.modules.sys.web.MenuResource.removeByIds(MenuResource.java:187)\r\n	at com.albedo.java.modules.sys.web.MenuResource$$FastClassBySpringCGLIB$$3f5bd433.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java', '1', '2020-05-17 14:55:14.844', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (449, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:55:20.111', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (450, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'DELETE', '[\"5431004fa397e0280fd75c4a3b73c4aa\",\"365a9f74f847322d2b8a0eff2b426ef4\",\"e66c7efccb9e1a0519afc328339e9108\"]', '37', 'MANAGE', 'DELETE', NULL, '1', '2020-05-17 14:55:26.833', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (451, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'GET', '', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:55:27.082', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (452, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'GET', '', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:55:30.297', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (453, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'GET', '', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:55:33.040', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (454, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'DELETE', '[\"a41d4ac1a6cc179696e0dbf284e3efc4\"]', '10', 'MANAGE', 'DELETE', NULL, '1', '2020-05-17 14:55:36.141', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (455, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'GET', '', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:55:36.483', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (456, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'GET', '', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:55:39.626', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (457, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'GET', '', '4', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:56:35.762', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (458, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'GET', '', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:56:42.757', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (459, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'GET', '', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 14:57:23.150', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (460, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'GET', 'current=%5B1%5D&size=%5B10%5D', '10', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 15:01:14.332', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (461, '角色管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()', '{ pm: PageModel() roleQueryCriteria: RoleQueryCriteria(blurry=null, available=null, createdDate=null) }', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 15:12:49.054', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (462, '用户管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.getUserPage()', '{ pm: PageModel() userQueryCriteria: UserQueryCriteria(deptIds=null, blurry=null, available=null, deptId=null, createdDate=null) }', '41', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 15:14:37.619', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (463, '部门管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/dept/', 'com.albedo.java.modules.sys.web.DeptResource.findTreeList()', '{ deptQueryCriteria: DeptQueryCriteria(notId=null, deptIds=null, name=null, available=null, blurry=null, parentId=null, createdDate=null) }', '8', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 15:14:38.657', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (464, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 15:15:42.199', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (465, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=413892fe8d52c1163d6659f51299dc96, blurry=null, type=null, createdDate=null) }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 15:15:44.819', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (466, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: MenuDto(permission=, icon=database, component=gen/table/index, type=1, hidden=0, cache=0, iframe=0, path=table) }', '60', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 15:15:56.901', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (467, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 15:15:57.319', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (468, '用户管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.getUserPage()', '{ pm: PageModel() userQueryCriteria: UserQueryCriteria(deptIds=null, blurry=null, available=null, deptId=null, createdDate=null) }', '40', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 15:16:18.249', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (469, '用户管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.getUserPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} userQueryCriteria: {} }', '111', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 15:18:42.116', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (470, '角色管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} roleQueryCriteria: {} }', '14', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 15:19:36.223', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (471, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '8', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 16:48:28.862', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (472, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '14', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 16:48:30.384', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (473, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"2000\"} }', '15', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 16:48:42.040', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (474, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: {\"cache\":0,\"component\":\"monitor/server/index\",\"hidden\":0,\"icon\":\"codeConsole\",\"id\":\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"iframe\":0,\"name\":\"服务监控\",\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\",\"path\":\"server\",\"sort\":40,\"type\":\"1\"} }', '51', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 16:49:37.929', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (475, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 16:49:38.077', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (476, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 16:49:41.337', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (477, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: {\"cache\":0,\"component\":\"monitor/server/index\",\"hidden\":0,\"icon\":\"codeConsole\",\"id\":\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"iframe\":0,\"name\":\"服务监控\",\"parentId\":\"2000\",\"path\":\"server\",\"sort\":40,\"type\":\"1\"} }', '49', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 16:50:09.073', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (478, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 16:50:09.485', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (479, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 16:50:15.108', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (480, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 16:50:35.754', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (481, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"2000\"} }', '13', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 16:51:53.454', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (482, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: {\"cache\":0,\"component\":\"monitor/server/index\",\"hidden\":0,\"icon\":\"codeConsole\",\"id\":\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"iframe\":0,\"name\":\"服务监控\",\"parentId\":\"2000\",\"path\":\"server\",\"permission\":\"sys_monitor_view\",\"sort\":40,\"type\":\"1\"} }', '47', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 16:52:02.551', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (483, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 16:52:02.958', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (484, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '15', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:05:20.021', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (485, '', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/authenticate', NULL, 'password=admin&randomStr=36471589708175320&rememberMe=true&code=1111&username=admin', NULL, 'MANAGE', 'LOGIN', NULL, '1', '2020-05-17 17:36:19.928', '登录成功', '0');
INSERT INTO `sys_log_operate` VALUES (486, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:44:49.240', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (487, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '15', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:46:23.262', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (488, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:46:33.888', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (489, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:47:52.249', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (490, '令牌管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/persistent-token', 'com.albedo.java.modules.sys.web.PersistentTokenResource.getUserPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} persistentTokenQueryCriteria: {} }', '64', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:47:55.442', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (491, '令牌管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/persistent-token', 'com.albedo.java.modules.sys.web.PersistentTokenResource.getUserPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} persistentTokenQueryCriteria: {} }', '10', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:48:04.992', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (492, '令牌管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/persistent-token', 'com.albedo.java.modules.sys.web.PersistentTokenResource.getUserPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} persistentTokenQueryCriteria: {} }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:48:52.827', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (493, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '8', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:54:06.196', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (494, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"1000\"} }', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:54:11.277', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (495, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"2000\"} }', '4', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:54:21.185', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (496, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:54:27.980', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (497, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.removeByIds()', '{ ids: [\"06874adacf1f272be7928badd4fe8ed1\"] }', '22', 'MANAGE', 'DELETE', NULL, '1', '2020-05-17 17:54:34.737', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (498, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:54:34.962', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (499, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:54:36.972', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (500, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.removeByIds()', '{ ids: [\"34dae0db3f9c97482d598f964bd4c9c7\"] }', '13', 'MANAGE', 'DELETE', NULL, '1', '2020-05-17 17:54:41.684', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (501, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:54:41.937', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (502, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '8', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:54:43.171', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (503, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"413892fe8d52c1163d6659f51299dc96\"} }', '4', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:54:44.815', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (504, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: {\"cache\":0,\"component\":\"Layout\",\"hidden\":0,\"icon\":\"codeConsole\",\"id\":\"413892fe8d52c1163d6659f51299dc96\",\"iframe\":0,\"name\":\"代码生成\",\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\",\"path\":\"/gen\",\"sort\":50,\"type\":\"0\"} }', '49', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 17:55:10.735', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (505, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:55:11.159', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (506, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:55:13.420', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (507, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: {\"cache\":0,\"component\":\"Layout\",\"hidden\":0,\"icon\":\"list\",\"id\":\"ef2382c0cc2d99ee73444e684237a88a\",\"iframe\":0,\"name\":\"系统工具\",\"parentId\":\"-1\",\"path\":\"/admin\",\"sort\":30,\"type\":\"0\"} }', '27', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 17:55:32.838', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (508, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:55:33.092', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (509, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:55:36.250', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (510, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '4', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:56:14.324', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (511, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: {\"cache\":0,\"component\":\"tools/email/index\",\"hidden\":0,\"icon\":\"email\",\"iframe\":0,\"name\":\"邮件工具\",\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\",\"path\":\"email\",\"sort\":30,\"type\":\"1\"} }', '30', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 17:56:55.983', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (512, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:56:56.235', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (513, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '4', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:56:58.099', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (514, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: {\"cache\":0,\"component\":\"tools/alipay/index\",\"hidden\":0,\"icon\":\"alipay\",\"iframe\":0,\"name\":\"支付宝工具\",\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\",\"path\":\"alipay\",\"sort\":30,\"type\":\"1\"} }', '26', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 17:58:06.858', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (515, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:58:07.108', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (516, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '4', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:58:08.995', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (517, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/sort-update', 'com.albedo.java.modules.sys.web.MenuResource.sortUpdate()', '{ menuSortDto: {\"menuSortList\":[{\"id\":\"7754b1457826c48290bc189bb1289740\",\"sort\":40}]} }', '9', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 17:58:15.104', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (518, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:58:15.343', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (519, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:58:16.659', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (520, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: {\"cache\":0,\"component\":\"tools/swagger/index\",\"hidden\":0,\"icon\":\"swagger\",\"id\":\"2500\",\"iframe\":0,\"name\":\"接口文档\",\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\",\"path\":\"swagger2\",\"sort\":500,\"type\":\"1\"} }', '44', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 17:58:37.298', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (521, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:58:37.690', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (522, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 17:58:40.346', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (523, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:01:27.901', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (524, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:01:33.307', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (525, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:01:39.044', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (526, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/sort-update', 'com.albedo.java.modules.sys.web.MenuResource.sortUpdate()', '{ menuSortDto: {\"menuSortList\":[{\"id\":\"413892fe8d52c1163d6659f51299dc96\",\"sort\":10}]} }', '8', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 18:01:52.219', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (527, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:01:52.472', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (528, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '4', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:01:54.123', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (529, '角色管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} roleQueryCriteria: {} }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:01:57.416', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (530, '角色管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()', '{ roleMenuDto: {\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"247071d42ff40267c8d8c44eac92da67\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"76d6087052dc26b32f3efa71b9cc119b\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"d4c16faad8f883650a3a8eab829ebad9\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"caaec41413c5713c6f290efe08c11415\"],\"roleId\":\"1\"} }', '66', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 18:02:09.384', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (531, '角色管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} roleQueryCriteria: {} }', '18', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:02:44.303', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (532, '角色管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} roleQueryCriteria: {} }', '13', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:06:10.575', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (533, '角色管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} roleQueryCriteria: {} }', '13', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:06:38.628', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (534, '角色管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} roleQueryCriteria: {} }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:06:52.064', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (535, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '10', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:07:18.691', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (536, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:07:20.700', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (537, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:07:56.848', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (538, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:15:40.620', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (539, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:15:42.508', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (540, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:16:24.529', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (541, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:53:59.702', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (542, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {\"parentId\":\"ef2382c0cc2d99ee73444e684237a88a\"} }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:54:03.930', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (543, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: {\"cache\":0,\"component\":\"Layout\",\"hidden\":0,\"icon\":\"sys-tools\",\"id\":\"ef2382c0cc2d99ee73444e684237a88a\",\"iframe\":0,\"name\":\"系统工具\",\"parentId\":\"-1\",\"path\":\"/admin\",\"sort\":30,\"type\":\"0\"} }', '37', 'MANAGE', 'EDIT', NULL, '1', '2020-05-17 18:54:18.218', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (544, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:54:18.377', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (545, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: {} }', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:54:22.204', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (546, '支付宝PC网页支付', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/tool/aliPay/toPayAsPC', 'com.albedo.java.modules.tool.web.AliPayResource.toPayAsPc()', '{ trade: {\"body\":\"1\",\"subject\":\"1\",\"totalAmount\":\"1\"} }', '680', 'MANAGE', 'OTHER', NULL, '1', '2020-05-17 18:55:09.495', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (547, '令牌管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/persistent-token', 'com.albedo.java.modules.sys.web.PersistentTokenResource.getUserPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} persistentTokenQueryCriteria: {} }', '44', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:56:22.749', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (548, '在线用户', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/user-online', 'com.albedo.java.modules.sys.web.UserOnlineResource.getUserPage()', '{ pm: {\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0} userOnlineQueryCriteria: {} }', '10', 'MANAGE', 'VIEW', NULL, '1', '2020-05-17 18:56:24.034', NULL, '0');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单ID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单类型 （0目录 1菜单 2按钮）',
  `permission` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端URL',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'VUE页面',
  `hidden` bit(1) NULL DEFAULT b'0' COMMENT '隐藏',
  `iframe` bit(1) NULL DEFAULT NULL COMMENT '是否外链',
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
INSERT INTO `sys_menu` VALUES ('06874adacf1f272be7928badd4fe8ed1', '配置日志', '1', NULL, 'log', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/log/index', b'0', b'0', b'0', b'1', 30, '1', '2019-08-05 16:16:06.000', '1', '2020-05-17 17:54:34.755', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('0747d9d8f651f19e49748ba68f18c6f5', '任务调度方案编辑', '2', 'quartz_job_edit', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-14 10:36:03.602', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('0b934688321b1db735c3bf6ec3e7cdc7', 'test', '2', 'test', 'test', '-1', NULL, 'date', NULL, b'0', b'0', b'0', b'1', 999, '1', '2020-05-14 17:47:36.261', '1', '2020-05-15 21:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('0d0be247863fcbf08b3db943e5f45992', '在线用户查看', '2', 'sys_userOnline_view', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 09:05:28.000', '1', '2020-05-16 17:55:59.725', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('1000', '系统管理', '0', NULL, '/perm', '-1', NULL, 'menu', 'Layout', b'0', b'0', b'0', b'0', 10, '', '2018-09-28 08:29:53.000', '1', '2020-05-16 17:55:32.580', NULL, 36, '0');
INSERT INTO `sys_menu` VALUES ('10bd98f30a42427dd7ef75418ad3da6b', '邮件工具', '1', NULL, 'email', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'email', 'tools/email/index', b'0', b'0', b'0', b'1', 30, '1', '2020-05-17 17:56:56.008', '1', '2020-05-17 17:56:56.008', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1100', '用户管理', '1', 'sys_user_view', 'user', '1000', '1000,', 'peoples', 'sys/user/index', b'0', b'0', b'0', b'0', 10, '', '2017-11-02 22:24:37.000', '1', '2020-05-16 17:56:34.938', NULL, 15, '0');
INSERT INTO `sys_menu` VALUES ('1101', '用户编辑', '2', 'sys_user_edit', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 09:52:09.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1102', '用户锁定', '2', 'sys_user_lock', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 09:52:48.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1103', '用户删除', '2', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 09:54:01.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('11b9ae870fb0fc89c52236faf43f3d96', '任务调度方案查看', '2', 'quartz_job_view', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-14 10:35:56.085', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('1200', '菜单管理', '1', 'sys_menu_view', 'menu', '1000', '1000,', 'menu', 'sys/menu/index', b'0', b'0', b'0', b'0', 40, '', '2017-11-08 09:57:27.000', '1', '2020-05-16 17:56:34.959', NULL, 8, '0');
INSERT INTO `sys_menu` VALUES ('1201', '菜单编辑', '2', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:15:53.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1202', '菜单锁定', '2', 'sys_menu_lock', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:16:23.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1203', '菜单删除', '2', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:16:43.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1300', '角色管理', '1', 'sys_role_view', 'role', '1000', '1000,', 'role', 'sys/role/index', b'0', b'0', b'0', b'0', 20, '', '2017-11-08 10:13:37.000', '1', '2020-05-16 17:56:34.949', NULL, 7, '0');
INSERT INTO `sys_menu` VALUES ('1301', '角色编辑', '2', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:14:18.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1302', '角色锁定', '2', 'sys_role_lock', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:14:41.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1303', '角色删除', '2', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:14:59.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1304', '角色查看', '2', 'sys_role_view', NULL, '1300', '1300,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '', '2018-04-20 07:22:55.000', '1', '2020-05-15 21:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('13093fb658c1806ad5bd0600316158f2', '操作日志导出', '2', 'sys_logOperate_export', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:50:46.973', '1', '2020-05-17 10:23:57.541', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('133f1408f5e3187d3e1a00b0260b7165', '字典可用', '2', 'sys_dict_lock', NULL, '2200', '1000,2200,', NULL, NULL, b'0', NULL, b'0', b'1', 999, '1', '2020-05-15 17:24:57.559', '1', '2020-05-16 17:55:19.915', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1400', '部门管理', '1', 'sys_dept_view', 'dept', '1000', '1000,', 'dept', 'sys/dept/index', b'0', b'0', b'0', b'0', 30, '', '2018-01-20 13:17:19.000', '1', '2020-05-16 17:56:34.955', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('1401', '部门编辑', '2', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2018-01-20 14:56:16.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1402', '部门锁定', '2', 'sys_dept_lock', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2018-01-20 14:56:59.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1403', '部门删除', '2', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2018-01-20 14:57:28.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('18d6b5e0f6b986cd074bf23de11ecd34', '任务调度删除', '2', 'quartz_job_del', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-14 10:36:47.091', '1', '2020-05-16 13:24:22.873', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1a900c3f10ef5b0987e0a8ee4445316d', '用户查看', '2', 'sys_user_view', NULL, '1100', '1000,1100,', NULL, NULL, b'0', b'0', b'0', b'1', 10, '1', '2019-08-07 17:27:34.000', '1', '2020-05-15 21:06:35.180', NULL, 4, '1');
INSERT INTO `sys_menu` VALUES ('2000', '系统监控', '0', NULL, '/sys', '-1', NULL, 'system', 'Layout', b'0', b'0', b'0', b'0', 20, '', '2017-11-07 20:56:00.000', '1', '2020-05-17 16:52:02.575', NULL, 39, '0');
INSERT INTO `sys_menu` VALUES ('2100', '操作日志', '1', NULL, 'log-operate', '2000', '2000,', 'log', 'monitor/log-operate/index', b'0', b'0', b'0', b'0', 40, '', '2017-11-20 14:06:22.000', '1', '2020-05-17 10:23:57.530', NULL, 12, '0');
INSERT INTO `sys_menu` VALUES ('2101', '操作日志删除', '2', 'sys_logOperate_del', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '', '2017-11-20 20:37:37.000', '1', '2020-05-17 10:23:57.545', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('2200', '字典管理', '1', 'sys_dict_view', 'dict', '1000', '1000,', 'dictionary', 'sys/dict/index', b'0', b'0', b'0', b'0', 50, '', '2017-11-29 11:30:52.000', '1', '2020-05-16 17:56:34.943', NULL, 11, '0');
INSERT INTO `sys_menu` VALUES ('2201', '字典删除', '2', 'sys_dict_del', NULL, '2200', '1000,2200,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '', '2017-11-29 11:30:11.000', '1', '2020-05-16 17:55:19.918', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('2202', '字典编辑', '2', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2018-05-11 22:34:55.000', '1', '2020-05-16 13:24:22.800', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('23430df88fb72179c2a85c39eaf4d50b', '任务调度日志清空', '2', 'quartz_jobLog_clean', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2019-08-15 16:12:26.285', '1', '2020-05-16 15:40:21.370', NULL, 2, '1');
INSERT INTO `sys_menu` VALUES ('247071d42ff40267c8d8c44eac92da67', '生成方案', '1', NULL, 'scheme', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'dev', 'gen/scheme/index', b'0', b'0', b'0', b'0', 40, '1', '2019-07-21 13:27:35.000', '1', '2020-05-15 21:07:50.836', NULL, 18, '0');
INSERT INTO `sys_menu` VALUES ('2500', '接口文档', '1', NULL, 'swagger2', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'swagger', 'tools/swagger/index', b'0', b'0', b'0', b'1', 500, '', '2018-06-26 10:50:32.000', '1', '2020-05-17 17:58:37.328', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('2600', '令牌管理', '1', NULL, 'persistent-token', '2000', '2000,', 'dev', 'monitor/persistent-token/index', b'0', b'0', b'0', b'0', 20, '', '2018-09-04 05:58:41.000', '1', '2020-05-16 17:57:31.286', NULL, 14, '0');
INSERT INTO `sys_menu` VALUES ('2601', '令牌删除', '2', 'sys_persistentToken_del', NULL, '2600', '2600,', NULL, NULL, b'0', b'0', b'0', b'1', 1, '', '2018-09-04 05:59:50.000', '1', '2020-05-16 17:57:31.293', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('2836ced373377be75936827ecddf7fad', '测试树管理编辑', '2', 'test_testTreeBook_edit', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-11 14:32:06.856', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('29de79df95e70d8e8fbdc7945acf214a', '任务调度查看', '2', 'quartz_job_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 10, '1', '2019-08-14 10:36:47.085', '1', '2020-05-16 12:10:40.648', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('2af0268f695b79abdf6e8b10d559d081', '测试树管理删除', '2', 'test_testTreeBook_del', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-11 14:32:06.859', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2c8fdecfee63a310266b2e4b94fd3f4c', '任务调度日志删除', '2', 'quartz_jobLog_del', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 70, '1', '2019-08-15 16:12:07.842', '1', '2020-05-16 15:40:08.708', NULL, 2, '1');
INSERT INTO `sys_menu` VALUES ('2c90f69bccf0845b1aca8b072b730c39', '任务调度方案删除', '2', 'quartz_job_del', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-14 10:35:56.092', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2d9efe7ea66351a96da68e6a7cca5e00', '任务调度方案删除', '2', 'quartz_job_del', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-14 10:36:03.606', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('310c04e534c9af92935c54b4e1357447', 'tes', '1', 'te', 'te', '54cd27f34ca7e9a8848b92377468965d', '54cd27f34ca7e9a8848b92377468965d,', 'app', 'te', b'0', b'0', b'0', b'1', 999, '1', '2020-05-14 18:17:11.736', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('322efc9833f2562f8862f882dabdf3d6', '任务调度方案', '1', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-14 10:35:56.081', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('34acb71268387bb85c80849f7377c7fd', '任务日志导出', '2', 'quartz_jobLog_export', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0', b'1', 40, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:17.758', NULL, 4, '1');
INSERT INTO `sys_menu` VALUES ('34dae0db3f9c97482d598f964bd4c9c7', '配置管理', '1', NULL, 'configuration', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/configuration/index', b'0', b'0', b'0', b'1', 50, '1', '2019-08-05 17:46:50.000', '1', '2020-05-17 17:54:41.694', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('365a9f74f847322d2b8a0eff2b426ef4', '登录日志导出', '2', 'sys_logLogin_export', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', 'a41d4ac1a6cc179696e0dbf284e3efc4,', NULL, NULL, b'0', b'0', b'0', b'1', 40, '1', '2019-08-15 09:26:02.000', '1', '2020-05-17 14:55:26.858', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('3c1c5a48888650b9a7ba5a1763f2e205', '任务日志查看', '2', 'quartz_jobLog_view', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0', b'1', 20, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:17.732', NULL, 4, '1');
INSERT INTO `sys_menu` VALUES ('413892fe8d52c1163d6659f51299dc96', '代码生成', '0', NULL, '/gen', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'codeConsole', 'Layout', b'0', b'0', b'0', b'0', 10, '1', '2019-07-20 12:00:48.000', '1', '2020-05-17 18:01:52.223', NULL, 43, '0');
INSERT INTO `sys_menu` VALUES ('52715698214e88cb09fa4dd1ea5ad348', '生成方案菜单', '2', 'gen_scheme_menu', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-25 13:03:03.000', '1', '2020-05-15 21:06:35.180', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('5404c3df9f771dbc0237578814bbe44b', 'Yaml编辑器', '1', NULL, 'yaml', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'dev', 'components/YamlEdit', b'0', b'0', b'0', b'1', 50, '1', '2020-05-15 21:22:43.364', '1', '2020-05-15 21:22:43.364', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('5431004fa397e0280fd75c4a3b73c4aa', '登录日志查看', '2', 'sys_logLogin_view', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-15 09:26:02.349', '1', '2020-05-17 14:55:26.848', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('54cd27f34ca7e9a8848b92377468965d', 'test', '1', 'test', 'tes', '-1', NULL, 'Steve-Jobs', 'tes', b'1', b'0', b'1', b'0', 999, '1', '2020-05-14 18:16:52.599', '1', '2020-05-15 21:07:50.836', NULL, 2, '1');
INSERT INTO `sys_menu` VALUES ('5da31e19f05edeea6a7041e3101deefe', '任务日志删除', '2', 'quartz_jobLog_del', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:17.702', NULL, 4, '1');
INSERT INTO `sys_menu` VALUES ('618ee4b9660265a85a8b61277de2a579', '富文本', '1', NULL, 'editor', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'fwb', 'components/Editor', b'0', b'0', b'0', b'1', 30, '1', '2020-05-15 21:16:40.552', '1', '2020-05-15 21:16:50.233', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('621e50e1c7d66a1febeb699bebb2fe35', '任务调度执行', '2', 'quartz_job_run', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 20, '1', '2019-08-15 16:10:59.000', '1', '2020-05-16 12:11:01.548', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('64b61b8966e1c74d9b309069b2f622d1', '图标库', '1', NULL, 'icons', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'icon', 'components/icons/index', b'0', b'0', b'0', b'1', 10, '1', '2020-05-15 21:14:28.945', '1', '2020-05-15 21:15:00.712', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('6e3f89cda84ac2c6e715e7812c102ae8', '在线用户', '1', '', 'user-online', '2000', '2000,', 'Steve-Jobs', 'monitor/user-online/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-07 09:03:52.000', '1', '2020-05-16 17:55:59.718', NULL, 10, '0');
INSERT INTO `sys_menu` VALUES ('74f2b2a8871a298e0acc4d7129d10e9c', '任务调度', '1', NULL, 'job', '1000', '1000,', 'timing', 'quartz/job/index', b'0', b'0', b'0', b'0', 60, '1', '2019-08-14 10:36:47.081', '1', '2020-05-16 17:56:34.966', NULL, 22, '0');
INSERT INTO `sys_menu` VALUES ('76d6087052dc26b32f3efa71b9cc119b', '任务调度日志', '2', 'quartz_jobLog_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 50, '1', '2019-08-15 16:11:30.986', '1', '2020-05-16 13:43:44.992', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('7754b1457826c48290bc189bb1289740', '支付宝工具', '1', NULL, 'alipay', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'alipay', 'tools/alipay/index', b'0', b'0', b'0', b'1', 40, '1', '2020-05-17 17:58:06.876', '1', '2020-05-17 17:58:15.108', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('795b4d5cf0eb3ed80e24cbab39727b9d', 'Markdown', '1', NULL, 'markdown', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'markdown', 'components/MarkDown', b'0', b'0', b'0', b'1', 40, '1', '2020-05-15 21:21:46.675', '1', '2020-05-15 21:22:53.122', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('7b14af9e9fbff286856338a194422b07', '令牌查看', '2', 'sys_persistentToken_view', NULL, '2600', '2600,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-08 09:44:25.617', '1', '2020-05-16 17:57:31.295', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('7c7a876f4cceba2dd92aa539dea6b6e5', '任务日志清空', '2', 'quartz_jobLog_clean', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-15 13:55:37.892', '1', '2020-05-16 13:43:17.774', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('8d3517427e527df11d51da528261c915', '测试树管理', '1', NULL, 'test-tree-book', '413892fe8d52c1163d6659f51299dc96', NULL, 'dev', 'test/test-tree-book/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-11 14:32:06.849', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('92f78825551a22fa130c03066f398448', '在线用户删除', '2', 'sys_userOnline_del', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 09:06:33.448', '1', '2020-05-16 17:55:59.728', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('94b57a562063d103423e2c6125cb30ad', '菜单查看', '2', 'sys_menu_view', NULL, '1200', '1200,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:27:59.697', '1', '2020-05-15 21:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('9763343d9cce11ce9eb4f21c8e49122b', '任务调度编辑', '2', 'quartz_job_edit', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-14 10:36:47.088', '1', '2020-05-16 12:11:35.820', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('97722c6d56c8b9990cc3c1a6eea3d6bb', '业务表编辑', '2', 'gen_table_edit', 'edit', 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, 'gen/table/edit', b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:24:02.000', '1', '2020-05-17 15:15:56.947', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('9f02e346b5350366968f217daef3f1b7', '图表库', '1', NULL, 'Echarts', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'chart', 'components/Echarts', b'0', b'0', b'0', b'1', 20, '1', '2020-05-15 21:12:39.827', '1', '2020-05-15 21:15:09.128', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('a18b33e15bde209a3c9115517c56d9ec', '业务表', '1', '', 'table', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'database', 'gen/table/index', b'0', b'0', b'0', b'0', 30, '1', '2019-07-20 12:02:02.000', '1', '2020-05-17 15:15:56.936', NULL, 18, '0');
INSERT INTO `sys_menu` VALUES ('a41d4ac1a6cc179696e0dbf284e3efc4', '登录日志', '1', NULL, 'log-login', '2000', '2000,', 'log', 'monitor//log-login/index', b'0', b'0', b'0', b'0', 50, '1', '2019-08-15 09:26:02.345', '1', '2020-05-17 14:55:36.150', NULL, 8, '1');
INSERT INTO `sys_menu` VALUES ('b961670cbf3454f5927c4bd2a327e915', '生成方案删除', '2', 'gen_scheme_del', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:30:18.000', '1', '2020-05-15 21:06:35.180', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('b963a451117f430703817b3b6c87402a', '任务调度日志导出', '2', 'quartz_jobLog_export', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 60, '1', '2019-08-15 16:13:16.742', '1', '2020-05-16 13:43:54.409', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('bb9dd4b7a2a462193d0f01517308f812', '业务表查看', '2', 'gen_table_view', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:47:39.828', '1', '2020-05-17 15:15:56.951', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('bd62904371247f56594741ff8e9bded9', '用户导出', '2', 'sys_user_export', NULL, '1100', '1000,1100,', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2019-08-07 17:50:02.000', '1', '2020-05-15 21:06:35.180', NULL, 7, '0');
INSERT INTO `sys_menu` VALUES ('c0ba37c10abaecd89a738c5cf2a2fd24', '服务监控', '1', 'sys_monitor_view', 'server', '2000', '2000,', 'codeConsole', 'monitor/server/index', b'0', b'0', b'0', b'1', 40, '1', '2019-08-05 17:21:10.000', '1', '2020-05-17 16:52:02.586', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('c77855e4171d00ae3f97563a8391f70a', '任务调度方案', '1', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-14 10:36:03.593', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c93f8fca7ca6f8631d383b08ab67009a', '任务日志', '1', NULL, 'job-log', '2000', '2000,', 'log', 'quartz/job-log/index', b'0', b'0', b'0', b'0', 60, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:26.449', NULL, 14, '1');
INSERT INTO `sys_menu` VALUES ('caaec41413c5713c6f290efe08c11415', '生成方案查看', '2', 'gen_scheme_view', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:48:09.000', '1', '2020-05-15 21:06:35.180', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('d4c16faad8f883650a3a8eab829ebad9', '操作日志查看', '2', 'sys_logOperate_view', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:51:38.454', '1', '2020-05-17 10:23:57.546', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('d5897b78312e09024546530fd8b2e8fc', '任务调度方案查看', '2', 'quartz_job_view', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-14 10:36:03.598', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('d9d87cf8ed7c29ed2eda06d5dec4dcda', '组件管理', '0', NULL, '/components', '-1', NULL, 'zujian', 'Layout', b'0', b'0', b'0', b'0', 80, '1', '2020-05-15 20:57:28.521', '1', '2020-05-16 13:38:57.307', NULL, 26, '0');
INSERT INTO `sys_menu` VALUES ('e086c4aa4943a883b29cf94680608b89', '生成方案代码', '2', 'gen_scheme_code', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:55:37.000', '1', '2020-05-15 21:06:35.180', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('e590df103d3382d3091eae818f68626b', '测试树管理查看', '2', 'test_testTreeBook_view', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-11 14:32:06.853', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e5ea38c1f97dee0043e78f3fb27b25d6', '生成方案编辑', '2', 'gen_scheme_edit', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:29:14.000', '1', '2020-05-15 21:06:35.180', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('e66c7efccb9e1a0519afc328339e9108', '登录日志删除', '2', 'sys_logLogin_del', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-15 09:26:02.357', '1', '2020-05-17 14:55:26.867', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e6ea0a5dc986c69852010e4a24329cf1', '任务调度方案编辑', '2', 'quartz_job_edit', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-14 10:35:56.089', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e710a66583fe0e324492462adb16014e', '业务表删除', '2', 'gen_table_del', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:24:45.000', '1', '2020-05-17 15:15:56.954', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('ef2382c0cc2d99ee73444e684237a88a', '系统工具', '0', NULL, '/admin', '-1', NULL, 'sys-tools', 'Layout', b'0', b'0', b'0', b'0', 30, '1', '2019-08-05 15:58:12.000', '1', '2020-05-17 18:54:18.246', NULL, 40, '0');
INSERT INTO `sys_menu` VALUES ('f15e2186907d22765cd149a94905842a', '在线用户强退', '2', 'sys_userOnline_logout', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 10:57:51.502', '1', '2020-05-16 17:55:59.729', NULL, 5, '0');

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
INSERT INTO `sys_persistent_token` VALUES ('iu3uuh5p9rm9v0syt07w', '1', 'admin', '9vao3fp2z5y4emdkiwl7', '2020-05-17 18:53:59.345', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016');
INSERT INTO `sys_persistent_token` VALUES ('ypm4f7vxj6l7r12g6ogo', '1', 'admin', 'jj76g3u1zvcc1xum4i8l', '2020-05-17 12:58:17.994', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Windows 10 or Windows Server 2016', 'Chrome');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 1, '1', '1', '', '2017-10-29 15:45:51.000', '1', '2020-05-14 11:00:00.741', NULL, 75, '0');
INSERT INTO `sys_role` VALUES ('2', '机构管理员', 2, '2', '1', '', '2018-11-11 19:42:26.000', '1', '2020-05-14 11:01:14.154', NULL, 18, '0');
INSERT INTO `sys_role` VALUES ('262da20a182dd09e70422cbca05503b7', 'tets', 3, '5', '1', '1', '2020-05-14 11:21:30.869', '1', '2020-05-14 11:28:55.628', NULL, 0, '1');
INSERT INTO `sys_role` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '部门管理员', 3, '3', '1', '1', '2020-05-14 11:02:13.389', '1', '2020-05-14 11:02:29.846', NULL, 1, '0');
INSERT INTO `sys_role` VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '普通管理员', 4, '4', '1', '1', '2020-05-14 11:00:50.813', '1', '2020-05-14 11:30:26.577', '普通管理', 6, '0');

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
INSERT INTO `sys_role_dept` VALUES ('c3b5457350bb7a9be8201fa3f88d3c2c', '262da20a182dd09e70422cbca05503b7', NULL);

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
INSERT INTO `sys_role_menu` VALUES ('1', '0d0be247863fcbf08b3db943e5f45992');
INSERT INTO `sys_role_menu` VALUES ('1', '1000');
INSERT INTO `sys_role_menu` VALUES ('1', '10bd98f30a42427dd7ef75418ad3da6b');
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
INSERT INTO `sys_role_menu` VALUES ('1', '13093fb658c1806ad5bd0600316158f2');
INSERT INTO `sys_role_menu` VALUES ('1', '133f1408f5e3187d3e1a00b0260b7165');
INSERT INTO `sys_role_menu` VALUES ('1', '1400');
INSERT INTO `sys_role_menu` VALUES ('1', '1401');
INSERT INTO `sys_role_menu` VALUES ('1', '1402');
INSERT INTO `sys_role_menu` VALUES ('1', '1403');
INSERT INTO `sys_role_menu` VALUES ('1', '18d6b5e0f6b986cd074bf23de11ecd34');
INSERT INTO `sys_role_menu` VALUES ('1', '2000');
INSERT INTO `sys_role_menu` VALUES ('1', '2100');
INSERT INTO `sys_role_menu` VALUES ('1', '2101');
INSERT INTO `sys_role_menu` VALUES ('1', '2200');
INSERT INTO `sys_role_menu` VALUES ('1', '2201');
INSERT INTO `sys_role_menu` VALUES ('1', '2202');
INSERT INTO `sys_role_menu` VALUES ('1', '247071d42ff40267c8d8c44eac92da67');
INSERT INTO `sys_role_menu` VALUES ('1', '2500');
INSERT INTO `sys_role_menu` VALUES ('1', '2600');
INSERT INTO `sys_role_menu` VALUES ('1', '2601');
INSERT INTO `sys_role_menu` VALUES ('1', '29de79df95e70d8e8fbdc7945acf214a');
INSERT INTO `sys_role_menu` VALUES ('1', '413892fe8d52c1163d6659f51299dc96');
INSERT INTO `sys_role_menu` VALUES ('1', '52715698214e88cb09fa4dd1ea5ad348');
INSERT INTO `sys_role_menu` VALUES ('1', '5404c3df9f771dbc0237578814bbe44b');
INSERT INTO `sys_role_menu` VALUES ('1', '618ee4b9660265a85a8b61277de2a579');
INSERT INTO `sys_role_menu` VALUES ('1', '621e50e1c7d66a1febeb699bebb2fe35');
INSERT INTO `sys_role_menu` VALUES ('1', '64b61b8966e1c74d9b309069b2f622d1');
INSERT INTO `sys_role_menu` VALUES ('1', '6e3f89cda84ac2c6e715e7812c102ae8');
INSERT INTO `sys_role_menu` VALUES ('1', '74f2b2a8871a298e0acc4d7129d10e9c');
INSERT INTO `sys_role_menu` VALUES ('1', '76d6087052dc26b32f3efa71b9cc119b');
INSERT INTO `sys_role_menu` VALUES ('1', '7754b1457826c48290bc189bb1289740');
INSERT INTO `sys_role_menu` VALUES ('1', '795b4d5cf0eb3ed80e24cbab39727b9d');
INSERT INTO `sys_role_menu` VALUES ('1', '7b14af9e9fbff286856338a194422b07');
INSERT INTO `sys_role_menu` VALUES ('1', '92f78825551a22fa130c03066f398448');
INSERT INTO `sys_role_menu` VALUES ('1', '9763343d9cce11ce9eb4f21c8e49122b');
INSERT INTO `sys_role_menu` VALUES ('1', '97722c6d56c8b9990cc3c1a6eea3d6bb');
INSERT INTO `sys_role_menu` VALUES ('1', '9f02e346b5350366968f217daef3f1b7');
INSERT INTO `sys_role_menu` VALUES ('1', 'a18b33e15bde209a3c9115517c56d9ec');
INSERT INTO `sys_role_menu` VALUES ('1', 'b961670cbf3454f5927c4bd2a327e915');
INSERT INTO `sys_role_menu` VALUES ('1', 'b963a451117f430703817b3b6c87402a');
INSERT INTO `sys_role_menu` VALUES ('1', 'bb9dd4b7a2a462193d0f01517308f812');
INSERT INTO `sys_role_menu` VALUES ('1', 'bd62904371247f56594741ff8e9bded9');
INSERT INTO `sys_role_menu` VALUES ('1', 'c0ba37c10abaecd89a738c5cf2a2fd24');
INSERT INTO `sys_role_menu` VALUES ('1', 'caaec41413c5713c6f290efe08c11415');
INSERT INTO `sys_role_menu` VALUES ('1', 'd4c16faad8f883650a3a8eab829ebad9');
INSERT INTO `sys_role_menu` VALUES ('1', 'd9d87cf8ed7c29ed2eda06d5dec4dcda');
INSERT INTO `sys_role_menu` VALUES ('1', 'e086c4aa4943a883b29cf94680608b89');
INSERT INTO `sys_role_menu` VALUES ('1', 'e5ea38c1f97dee0043e78f3fb27b25d6');
INSERT INTO `sys_role_menu` VALUES ('1', 'e710a66583fe0e324492462adb16014e');
INSERT INTO `sys_role_menu` VALUES ('1', 'ef2382c0cc2d99ee73444e684237a88a');
INSERT INTO `sys_role_menu` VALUES ('1', 'f15e2186907d22765cd149a94905842a');
INSERT INTO `sys_role_menu` VALUES ('2', '1000');
INSERT INTO `sys_role_menu` VALUES ('2', '1100');
INSERT INTO `sys_role_menu` VALUES ('2', '1101');
INSERT INTO `sys_role_menu` VALUES ('2', '1102');
INSERT INTO `sys_role_menu` VALUES ('2', '1200');
INSERT INTO `sys_role_menu` VALUES ('2', '1201');
INSERT INTO `sys_role_menu` VALUES ('2', '1202');
INSERT INTO `sys_role_menu` VALUES ('2', '1203');
INSERT INTO `sys_role_menu` VALUES ('2', '1300');
INSERT INTO `sys_role_menu` VALUES ('2', '1301');
INSERT INTO `sys_role_menu` VALUES ('2', '1302');
INSERT INTO `sys_role_menu` VALUES ('2', '1303');
INSERT INTO `sys_role_menu` VALUES ('2', '13093fb658c1806ad5bd0600316158f2');
INSERT INTO `sys_role_menu` VALUES ('2', '1400');
INSERT INTO `sys_role_menu` VALUES ('2', '1401');
INSERT INTO `sys_role_menu` VALUES ('2', '1402');
INSERT INTO `sys_role_menu` VALUES ('2', '1403');
INSERT INTO `sys_role_menu` VALUES ('2', '18d6b5e0f6b986cd074bf23de11ecd34');
INSERT INTO `sys_role_menu` VALUES ('2', '2000');
INSERT INTO `sys_role_menu` VALUES ('2', '2100');
INSERT INTO `sys_role_menu` VALUES ('2', '2101');
INSERT INTO `sys_role_menu` VALUES ('2', '2200');
INSERT INTO `sys_role_menu` VALUES ('2', '2201');
INSERT INTO `sys_role_menu` VALUES ('2', '2202');
INSERT INTO `sys_role_menu` VALUES ('2', '2600');
INSERT INTO `sys_role_menu` VALUES ('2', '2601');
INSERT INTO `sys_role_menu` VALUES ('2', '29de79df95e70d8e8fbdc7945acf214a');
INSERT INTO `sys_role_menu` VALUES ('2', '621e50e1c7d66a1febeb699bebb2fe35');
INSERT INTO `sys_role_menu` VALUES ('2', '74f2b2a8871a298e0acc4d7129d10e9c');
INSERT INTO `sys_role_menu` VALUES ('2', '76d6087052dc26b32f3efa71b9cc119b');
INSERT INTO `sys_role_menu` VALUES ('2', '7b14af9e9fbff286856338a194422b07');
INSERT INTO `sys_role_menu` VALUES ('2', '9763343d9cce11ce9eb4f21c8e49122b');
INSERT INTO `sys_role_menu` VALUES ('2', 'b963a451117f430703817b3b6c87402a');
INSERT INTO `sys_role_menu` VALUES ('2', 'd4c16faad8f883650a3a8eab829ebad9');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1100');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1101');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1102');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1103');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1300');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1301');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1302');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1303');
INSERT INTO `sys_role_menu` VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '1000');
INSERT INTO `sys_role_menu` VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '1100');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '1' COMMENT '主键ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '昵称',
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
INSERT INTO `sys_user` VALUES ('1', 'admin', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, '17034642999', '22@ss.com', '', '1', NULL, 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', '1', '', '2018-04-20 07:15:18.000', '1', '2020-05-13 10:16:44.958', NULL, 11, '0');
INSERT INTO `sys_user` VALUES ('49f40b21c1dbdc83255d5c64119fcd4d', 'test1', '$2a$10$6ws6SdUb9cO3dLKFhZCub.rssb1Je.mZst.rbdK42.hV4a7K273KW', NULL, '13254642311', '13@qqx.om', NULL, '1', NULL, NULL, '1', '1', '2020-05-12 09:51:46.703', '1', '2020-05-15 11:27:21.180', NULL, 5, '0');
INSERT INTO `sys_user` VALUES ('5168fcfd16b8bad9fb38edfab4409023', 'www', '$2a$10$5nozeJD3VGgBGQf8iOXcPeONsn0lSEA/bLRS94j/Yu76.MK6vPYjG', NULL, '13258465211', 'qq@ee.com', NULL, '1', NULL, NULL, '1', '1', '2020-05-12 10:22:11.393', '1', '2020-05-14 18:43:14.491', NULL, 15, '0');
INSERT INTO `sys_user` VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', 'dsafdf', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, '13258462101', '837158@qq.com', NULL, '1', NULL, NULL, '1', '1', '2019-07-07 14:32:17.000', '1', '2020-05-15 11:27:18.658', '11', 23, '0');
INSERT INTO `sys_user` VALUES ('90da0206c39867a1b36ac36ced80c1a9', 'test', '$2a$10$t2HS9xbo98UCZ/0sPskts.vZrHuyC4w4hX7C/o9BVZBZOX9P9uIde', NULL, '13258462222', 'ww@qq.com', NULL, '1', NULL, NULL, '1', '1', '2019-07-07 14:35:13.000', '1', '2020-05-15 11:27:17.467', NULL, 48, '0');
INSERT INTO `sys_user` VALUES ('dcc5b57ad27014f1839a9f4bb2b568b1', 'ttt', '$2a$10$iv.88nQfvVOIQH14khKju.DX0Okx.mO9RqRF9RTh8qoloTNrpms0S', NULL, '13254732131', '2113@ed.bom', NULL, '1', NULL, NULL, '1', '1', '2020-05-12 10:06:21.381', '1', '2020-05-12 17:41:14.629', NULL, 1, '1');

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online`  (
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
  `expire_time` int(11) NULL DEFAULT 0 COMMENT '超时时间，单位为分钟',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`session_id`) USING BTREE,
  UNIQUE INDEX `session_id`(`session_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '在线用户记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_online
-- ----------------------------
INSERT INTO `sys_user_online` VALUES ('00EpsnZV2-t9IF7w-Bc7_7KP1JFaL8U9T7Ycg-TR', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 09:58:38', '2020-05-17 09:58:38', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('3PP7W7aw92OdvW032OR5P3iE-NTQpMtMEabIB6fa', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 15:01:14', '2020-05-17 15:01:14', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('44_UKg75zx5rthn7hJnGzI2oKjJTaMq528Ccipdq', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-16 18:40:49', '2020-05-16 18:49:34', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('5ADwI6YsWuTLiaSxUh1rDUxT1MIeM_CPvlZg9gUD', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 18:47:10', '2020-05-17 18:48:54', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('7mY97_wi7QOKW0TP16As2Evl3mJS1RhPPfL81nEv', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 10:22:15', '2020-05-17 11:02:02', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('8JX-hY2rauI-VmVscfPwiK4s6S07U_wtBOmIZaxa', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 16:42:00', '2020-05-17 16:42:00', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('aiweB7rd8ueNBArmTLZU166xMY8KA6yJc3gMJyMY', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:19:40', '2020-05-17 17:19:40', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('AP5GSH_LfKbRG2PZxUiIZ77IZfGlvyob_vXVSiib', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:14:50', '2020-05-17 17:17:38', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('CiDi0nBAKOG7YEig9Xk0ifmZM1-bQ-Qgx6RPim6z', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 14:23:09', '2020-05-17 14:23:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('dB-3TIPyzJg2DbebHxGN6QRb55r1amUOjbdr2kiC', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 14:23:09', '2020-05-17 14:23:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('EmZ7rpG2-mJ5Ae7LKLZTPqALdrixRbtUP7OMytG9', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 12:58:18', '2020-05-17 12:58:18', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('f0_SjQOYX8jzgVL9_7_TA6vzMDt8-BKPWw0L1bb6', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 15:18:42', '2020-05-17 15:18:42', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('giGrY94eSjyna8NlltT1iOiuASJyPsDSIgUVlkp_', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 15:15:42', '2020-05-17 15:15:42', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('GX21AOIcvFKMr97xFVxm015C6jYzMGach2HWF9SE', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 10:10:15', '2020-05-17 10:13:42', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('iqXlh9xmSl39ZNjfbsIAdYVkt4hYB5Cmhtft4aXh', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 12:58:18', '2020-05-17 13:51:08', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('JOSm-YFRT76HDXdc6wL6A7aSkysGD7BykDVpThWo', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:18:11', '2020-05-17 17:18:11', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('mYMdcAslV7rmq87vH9Zz-dYYb4aol7Z5s4DSidUH', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:36:20', '2020-05-17 18:16:38', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('N6A0N67hTSshsJ4bfhhz3Wcv7bEluBf--pbhibVI', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-16 18:35:49', '2020-05-16 18:40:30', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('PeKlyi8xm3hoJS0yyrQ3jcwRJjG4cAHkcJoDheeV', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 09:59:19', '2020-05-17 10:09:59', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('pggbOMSKqt6uDFmpZOGDEjYjzNHeKWWl_ZQz4-10', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:04:06', '2020-05-17 17:05:20', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('PN6GfgwIgfSzyNnyW6db_1MaCkixJ0wYK-80vWxX', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 14:30:31', '2020-05-17 14:59:02', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('POz6Ragil6Qi_ZeFj5yFl6Vko75hW-Vd9CcLlSlf', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 14:09:20', '2020-05-17 14:20:44', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('qpsYVTufTh872YywEq5r14q9G29uK6l4Fee6bM_R', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:10:16', '2020-05-17 17:14:29', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('s2_j-7-BcAlZV40YqWULkoVjoJPHJYeWDzj1_3Hl', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:27:07', '2020-05-17 17:27:07', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('S5tF7sBHNEWdTSpQfv1MEvP553hPEJvi8gyPKIZE', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 18:52:09', '2020-05-17 18:52:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('u29r6rUvSkCnIs0tnwJ9iZpszyb1HGhm6W05Eont', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 11:05:38', '2020-05-17 11:05:38', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ud36VSPOEaLq8A1vFWDvPpnP_wsPut_yucM3vjVh', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 15:09:58', '2020-05-17 15:14:40', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('V8tK19jgRMbrGN1iV4DMsOFlzoacrp-C8bhvcD_n', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 16:42:00', '2020-05-17 16:42:00', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('W0z28HCduqFTvYrU8DSFpMboq-D5JDZV0uV6FC_N', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 18:54:00', '2020-05-17 18:56:51', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('y-mGrXwJwv5Zn-_EhBwWoh6K62yFKLDsMzrWO8r-', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 11:03:14', '2020-05-17 11:03:14', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('y1SHMzNYQ8RUJpLFTIO0CfDXgWxg6sTak6K9eunD', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-16 18:54:03', '2020-05-16 18:55:04', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('y9XNS7eI4QQsLgsCnMal78vUpUizhpNqFAAkbIpf', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 12:14:57', '2020-05-17 12:26:00', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('yXKnlZ5Qb4TTq3Ms-eWbXVz_2O0Nkhhy_tokbI00', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 15:18:42', '2020-05-17 15:18:42', 1800, '1');

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
INSERT INTO `sys_user_role` VALUES ('1', '2');
INSERT INTO `sys_user_role` VALUES ('49f40b21c1dbdc83255d5c64119fcd4d', '2');
INSERT INTO `sys_user_role` VALUES ('5168fcfd16b8bad9fb38edfab4409023', '2');
INSERT INTO `sys_user_role` VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', '1');
INSERT INTO `sys_user_role` VALUES ('90da0206c39867a1b36ac36ced80c1a9', '2');
INSERT INTO `sys_user_role` VALUES ('dcc5b57ad27014f1839a9f4bb2b568b1', '2');

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

-- ----------------------------
-- Table structure for tool_alipay_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_alipay_config`;
CREATE TABLE `tool_alipay_config`  (
  `config_id` bigint(20) NOT NULL COMMENT 'ID',
  `app_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用ID',
  `charset` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `format` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型 固定格式json',
  `gateway_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网关地址',
  `notify_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '异步回调',
  `private_key` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '私钥',
  `public_key` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '公钥',
  `return_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回调地址',
  `sign_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '签名方式',
  `sys_service_provider_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商户号',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '支付宝配置类' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tool_alipay_config
-- ----------------------------
INSERT INTO `tool_alipay_config` VALUES (1, '2016091700532697', 'utf-8', 'JSON', 'https://openapi.alipaydev.com/gateway.do', 'http://api.auauz.net/api/aliPay/notify', 'MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC5js8sInU10AJ0cAQ8UMMyXrQ+oHZEkVt5lBwsStmTJ7YikVYgbskx1YYEXTojRsWCb+SH/kDmDU4pK/u91SJ4KFCRMF2411piYuXU/jF96zKrADznYh/zAraqT6hvAIVtQAlMHN53nx16rLzZ/8jDEkaSwT7+HvHiS+7sxSojnu/3oV7BtgISoUNstmSe8WpWHOaWv19xyS+Mce9MY4BfseFhzTICUymUQdd/8hXA28/H6osUfAgsnxAKv7Wil3aJSgaJczWuflYOve0dJ3InZkhw5Cvr0atwpk8YKBQjy5CdkoHqvkOcIB+cYHXJKzOE5tqU7inSwVbHzOLQ3XbnAgMBAAECggEAVJp5eT0Ixg1eYSqFs9568WdetUNCSUchNxDBu6wxAbhUgfRUGZuJnnAll63OCTGGck+EGkFh48JjRcBpGoeoHLL88QXlZZbC/iLrea6gcDIhuvfzzOffe1RcZtDFEj9hlotg8dQj1tS0gy9pN9g4+EBH7zeu+fyv+qb2e/v1l6FkISXUjpkD7RLQr3ykjiiEw9BpeKb7j5s7Kdx1NNIzhkcQKNqlk8JrTGDNInbDM6inZfwwIO2R1DHinwdfKWkvOTODTYa2MoAvVMFT9Bec9FbLpoWp7ogv1JMV9svgrcF9XLzANZ/OQvkbe9TV9GWYvIbxN6qwQioKCWO4GPnCAQKBgQDgW5MgfhX8yjXqoaUy/d1VjI8dHeIyw8d+OBAYwaxRSlCfyQ+tieWcR2HdTzPca0T0GkWcKZm0ei5xRURgxt4DUDLXNh26HG0qObbtLJdu/AuBUuCqgOiLqJ2f1uIbrz6OZUHns+bT/jGW2Ws8+C13zTCZkZt9CaQsrp3QOGDx5wKBgQDTul39hp3ZPwGNFeZdkGoUoViOSd5Lhowd5wYMGAEXWRLlU8z+smT5v0POz9JnIbCRchIY2FAPKRdVTICzmPk2EPJFxYTcwaNbVqL6lN7J2IlXXMiit5QbiLauo55w7plwV6LQmKm9KV7JsZs5XwqF7CEovI7GevFzyD3w+uizAQKBgC3LY1eRhOlpWOIAhpjG6qOoohmeXOphvdmMlfSHq6WYFqbWwmV4rS5d/6LNpNdL6fItXqIGd8I34jzql49taCmi+A2nlR/E559j0mvM20gjGDIYeZUz5MOE8k+K6/IcrhcgofgqZ2ZED1ksHdB/E8DNWCswZl16V1FrfvjeWSNnAoGAMrBplCrIW5xz+J0Hm9rZKrs+AkK5D4fUv8vxbK/KgxZ2KaUYbNm0xv39c+PZUYuFRCz1HDGdaSPDTE6WeWjkMQd5mS6ikl9hhpqFRkyh0d0fdGToO9yLftQKOGE/q3XUEktI1XvXF0xyPwNgUCnq0QkpHyGVZPtGFxwXiDvpvgECgYA5PoB+nY8iDiRaJNko9w0hL4AeKogwf+4TbCw+KWVEn6jhuJa4LFTdSqp89PktQaoVpwv92el/AhYjWOl/jVCm122f9b7GyoelbjMNolToDwe5pF5RnSpEuDdLy9MfE8LnE3PlbE7E5BipQ3UjSebkgNboLHH/lNZA5qvEtvbfvQ==', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAut9evKRuHJ/2QNfDlLwvN/S8l9hRAgPbb0u61bm4AtzaTGsLeMtScetxTWJnVvAVpMS9luhEJjt+Sbk5TNLArsgzzwARgaTKOLMT1TvWAK5EbHyI+eSrc3s7Awe1VYGwcubRFWDm16eQLv0k7iqiw+4mweHSz/wWyvBJVgwLoQ02btVtAQErCfSJCOmt0Q/oJQjj08YNRV4EKzB19+f5A+HQVAKy72dSybTzAK+3FPtTtNen/+b5wGeat7c32dhYHnGorPkPeXLtsqqUTp1su5fMfd4lElNdZaoCI7osZxWWUo17vBCZnyeXc9fk0qwD9mK6yRAxNbrY72Xx5VqIqwIDAQAB', 'http://api.auauz.net/api/aliPay/return', 'RSA2', '2088102176044281');

-- ----------------------------
-- Table structure for tool_email_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_email_config`;
CREATE TABLE `tool_email_config`  (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `from_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件人',
  `host` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮件服务器SMTP地址',
  `pass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `port` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '端口',
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发件者用户名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邮箱配置' ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;

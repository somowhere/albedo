/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : albedo

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 10/12/2021 13:58:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_datasource_conf
-- ----------------------------
DROP TABLE IF EXISTS `gen_datasource_conf`;
CREATE TABLE `gen_datasource_conf` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'url',
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '0-正常，1-删除',
  `version` int DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='数据源表';

-- ----------------------------
-- Records of gen_datasource_conf
-- ----------------------------
BEGIN;
INSERT INTO `gen_datasource_conf` VALUES ('893af6088511440a2998c9277886ec76', 'albedo', 'jdbc:mysql://albedo-mysql:3306/albedo', 'root', 'UTvxglk7x9Rj7Jz/xC5rfA==', '0', 4, NULL, '1', '2021-11-26 12:12:43.408', '1', '2021-10-21 11:52:50.602', '0000');
COMMIT;

-- ----------------------------
-- Table structure for gen_scheme
-- ----------------------------
DROP TABLE IF EXISTS `gen_scheme`;
CREATE TABLE `gen_scheme` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类',
  `view_type` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '视图类型 0  普通表格 1  表格采用ajax刷新',
  `package_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生成表编号',
  `version` int DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='生成方案';

-- ----------------------------
-- Records of gen_scheme
-- ----------------------------
BEGIN;
INSERT INTO `gen_scheme` VALUES ('1465206027958878208', '测试书籍', 'curd', NULL, 'com.albedo.java.modules', 'test', NULL, '测试书籍', '测试书籍', 'admin', '1465199562711891968', 0, NULL, '1', '2021-11-29 14:28:33.931', '1', '2021-11-29 14:28:33.932', '0', '0000');
INSERT INTO `gen_scheme` VALUES ('1465216133614272512', '测试树书籍', 'treeTable', NULL, 'com.albedo.java.modules', 'test', NULL, '测试树书籍', '测试树书籍', 'admin', '1465216015712387072', 0, NULL, '1', '2021-11-29 15:08:43.309', '1', '2021-11-29 15:08:43.310', '0', '0000');
INSERT INTO `gen_scheme` VALUES ('1465502545534255104', '登录日志', 'curd', NULL, 'com.albedo.java.modules', 'sys', NULL, '登录日志管理', '登录日志', 'admin', '1465502374771556352', 0, NULL, '1', '2021-11-30 10:06:49.232', '1', '2021-11-30 10:06:49.233', '0', '0000');
INSERT INTO `gen_scheme` VALUES ('1468396243003637760', '文件管理', 'curd_front', NULL, 'com.albedo.java.modules', 'sys', NULL, '附件管理', '附件管理', 'admin', '1468404145256923136', 1, NULL, '1', '2021-12-08 09:45:20.472', '1', '2021-12-08 09:45:20.472', '0', '0000');
INSERT INTO `gen_scheme` VALUES ('9c85b7481730e1619bfee1b4508cdc60', '测试书籍', 'curd', NULL, 'com.albedo.java.modules', 'testBook', NULL, '测试书籍', '测试书籍', 'admin', 'b51b39d0588eb0d02b5398b0d9cf70ff', 0, NULL, '1', '2021-10-21 13:44:45.427', '1', '2021-10-21 13:44:45.427', '0', '');
COMMIT;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `coding` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '字符编码',
  `ds_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据库引擎',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联父表外键',
  `version` int DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `gen_table_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
INSERT INTO `gen_table` VALUES ('1465199562711891968', 'test_book', '测试书籍', NULL, 'albedo', 'TestBook', NULL, NULL, 1, NULL, '1', '2021-11-29 14:28:00.742', '1', '2021-11-29 14:28:00.737', '0', '0000');
INSERT INTO `gen_table` VALUES ('1465216015712387072', 'test_tree_book', '测试树书', NULL, 'albedo', 'TestTreeBook', NULL, NULL, 1, NULL, '1', '2021-11-29 16:01:19.171', '1', '2021-11-29 16:01:19.166', '0', '0000');
INSERT INTO `gen_table` VALUES ('1465502374771556352', 'sys_log_login', '登录日志表', NULL, 'albedo', 'LogLogin', NULL, NULL, 1, NULL, '1', '2021-11-30 10:14:48.294', '1', '2021-11-30 10:14:48.289', '0', '0000');
INSERT INTO `gen_table` VALUES ('1468396101210996736', 'sys_appendix', '业务附件', NULL, 'albedo', 'Appendix', NULL, NULL, 0, NULL, '1', '2021-12-08 09:44:46.664', '1', '2021-12-08 09:44:46.666', '0', '0000');
INSERT INTO `gen_table` VALUES ('1468404145256923136', 'sys_file', '文件管理', NULL, 'albedo', 'File', NULL, NULL, 1, NULL, '1', '2021-12-08 10:17:40.857', '1', '2021-12-08 10:17:40.853', '0', '0000');
INSERT INTO `gen_table` VALUES ('23e5b6463bece83a7bb3039c79cad984', 'test_tree_book', '测试树书', NULL, 'albedo', 'TestTreeBook', NULL, NULL, 0, NULL, '1', '2021-10-21 13:51:02.707', '1', '2021-10-21 13:51:02.707', '0', '');
INSERT INTO `gen_table` VALUES ('807aa43d6dd9b6a11814ed7ef17bb9e3', 'test_book', '测试书籍', NULL, 'albedo', 'TestBook', NULL, NULL, 1, NULL, '1', '2021-10-21 13:31:37.169', '1', '2021-10-21 12:25:03.588', '1', '');
INSERT INTO `gen_table` VALUES ('914e23ded1edc89992828b45a3baeb4d', 'test_book', '测试书籍', NULL, 'albedo', 'TestBook', NULL, NULL, 1, NULL, '1', '2021-10-21 13:40:34.490', '1', '2021-10-21 13:32:50.062', '1', '');
INSERT INTO `gen_table` VALUES ('b51b39d0588eb0d02b5398b0d9cf70ff', 'test_book', '测试书籍', NULL, 'albedo', 'TestBook', NULL, NULL, 1, NULL, '1', '2021-10-21 13:41:07.708', '1', '2021-10-21 13:41:07.706', '0', '');
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `comments` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述备注',
  `jdbc_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` bit(1) DEFAULT NULL COMMENT '是否主键',
  `is_unique` bit(1) DEFAULT NULL COMMENT '是否唯一（1：是；0：否）',
  `is_null` bit(1) DEFAULT NULL COMMENT '是否可为空',
  `is_insert` bit(1) DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` bit(1) DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` bit(1) DEFAULT NULL COMMENT '是否列表字段',
  `is_query` bit(1) DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `version` int DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `gen_table_column_table_id` (`gen_table_id`) USING BTREE,
  KEY `gen_table_column_name` (`name`) USING BTREE,
  KEY `gen_table_column_sort` (`sort`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
INSERT INTO `gen_table_column` VALUES ('01ac87c5dfc0e616ba12feae0b361c9d', '914e23ded1edc89992828b45a3baeb4d', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.075', '1', '');
INSERT INTO `gen_table_column` VALUES ('03a548f07481d50d22c8450a0970a1a6', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.806', '1', '');
INSERT INTO `gen_table_column` VALUES ('06c2bbd97f6e26c0ac6879e11f6da6af', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 160, 1, NULL, '1', '2021-10-21 13:41:07.817', '1', '2021-10-21 13:41:07.815', '0', '');
INSERT INTO `gen_table_column` VALUES ('07d80ee8b233cea7e56e3c8bc4cf5d1c', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'activated', 'activated', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.745', '1', '');
INSERT INTO `gen_table_column` VALUES ('0de0dadfc96153cc1301640de4d732b6', '914e23ded1edc89992828b45a3baeb4d', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.245', '1', '');
INSERT INTO `gen_table_column` VALUES ('12b1bcbd2c9a0860c6a7d56b2214a1ee', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'version', 'version', NULL, 'int', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 1, NULL, '1', '2021-10-21 13:41:07.824', '1', '2021-10-21 13:41:07.822', '0', '');
INSERT INTO `gen_table_column` VALUES ('1465199562900635648', '1465199562711891968', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:00.812', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199562942578688', '1465199562711891968', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:00.840', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199562963550208', '1465199562711891968', 'author', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:00.877', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199562976133120', '1465199562711891968', 'name', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:00.899', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199562984521728', '1465199562711891968', 'email', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:00.924', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199562997104640', '1465199562711891968', 'phone', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:00.948', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563022270464', '1465199562711891968', 'activated', 'activated', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:00.972', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563030659072', '1465199562711891968', 'number', 'key', NULL, 'int', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:00.991', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563043241984', '1465199562711891968', 'money', 'money', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.012', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563047436288', '1465199562711891968', 'amount', 'amount', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.034', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563051630592', '1465199562711891968', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.057', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563055824896', '1465199562711891968', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.074', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563064213504', '1465199562711891968', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.090', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563072602112', '1465199562711891968', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.121', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563076796416', '1465199562711891968', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.154', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563085185024', '1465199562711891968', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 160, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.189', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563089379328', '1465199562711891968', 'version', 'version', NULL, 'int', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.244', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563097767936', '1465199562711891968', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.263', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465199563101962240', '1465199562711891968', 'tenant_code', '租户编码', NULL, 'varchar(20)', 'String', 'tenantCode', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 190, 1, NULL, '1', '2021-11-29 14:48:10.670', '1', '2021-11-29 14:28:01.283', '1', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964042317824', '1465199562711891968', 'id', 'id', NULL, 'bigint', 'Long', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 2, NULL, '1', '2021-11-29 16:01:09.774', '1', '2021-11-29 16:01:09.754', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964092649472', '1465199562711891968', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 2, NULL, '1', '2021-11-29 16:01:09.794', '1', '2021-11-29 16:01:09.779', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964101038080', '1465199562711891968', 'author', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 2, NULL, '1', '2021-11-29 16:01:09.819', '1', '2021-11-29 16:01:09.800', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964117815296', '1465199562711891968', 'name', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 2, NULL, '1', '2021-11-29 16:01:09.851', '1', '2021-11-29 16:01:09.831', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964138786816', '1465199562711891968', 'email', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 2, NULL, '1', '2021-11-29 16:01:09.877', '1', '2021-11-29 16:01:09.858', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964151369728', '1465199562711891968', 'phone', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 2, NULL, '1', '2021-11-29 16:01:09.903', '1', '2021-11-29 16:01:09.888', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964159758336', '1465199562711891968', 'activated', 'activated', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 2, NULL, '1', '2021-11-29 16:01:09.926', '1', '2021-11-29 16:01:09.908', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964163952640', '1465199562711891968', 'number', 'key', NULL, 'int', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 2, NULL, '1', '2021-11-29 16:01:09.960', '1', '2021-11-29 16:01:09.933', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964172341248', '1465199562711891968', 'money', 'money', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 2, NULL, '1', '2021-11-29 16:01:09.990', '1', '2021-11-29 16:01:09.970', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964180729856', '1465199562711891968', 'amount', 'amount', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 2, NULL, '1', '2021-11-29 16:01:10.011', '1', '2021-11-29 16:01:09.995', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964184924160', '1465199562711891968', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 2, NULL, '1', '2021-11-29 16:01:10.048', '1', '2021-11-29 16:01:10.033', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964197507072', '1465199562711891968', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 2, NULL, '1', '2021-11-29 16:01:10.064', '1', '2021-11-29 16:01:10.053', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964201701376', '1465199562711891968', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 2, NULL, '1', '2021-11-29 16:01:10.083', '1', '2021-11-29 16:01:10.070', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964205895680', '1465199562711891968', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 2, NULL, '1', '2021-11-29 16:01:10.098', '1', '2021-11-29 16:01:10.088', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964214284288', '1465199562711891968', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 2, NULL, '1', '2021-11-29 16:01:10.116', '1', '2021-11-29 16:01:10.106', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964218478592', '1465199562711891968', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 160, 2, NULL, '1', '2021-11-29 16:01:10.134', '1', '2021-11-29 16:01:10.122', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964222672896', '1465199562711891968', 'version', 'version', NULL, 'int', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 2, NULL, '1', '2021-11-29 16:01:10.149', '1', '2021-11-29 16:01:10.138', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964226867200', '1465199562711891968', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 2, NULL, '1', '2021-11-29 16:01:10.167', '1', '2021-11-29 16:01:10.155', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465210964252033024', '1465199562711891968', 'tenant_code', '租户编码', NULL, 'varchar(20)', 'String', 'tenantCode', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 190, 2, NULL, '1', '2021-11-29 16:01:10.182', '1', '2021-11-29 16:01:10.175', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015821438976', '1465216015712387072', 'id', 'id', NULL, 'bigint', 'Long', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 1, NULL, '1', '2021-11-29 16:01:19.209', '1', '2021-11-29 16:01:19.199', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015842410496', '1465216015712387072', 'parent_id', 'parent_id', NULL, 'varchar(32)', 'String', 'parentId', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 20, 1, NULL, '1', '2021-11-29 16:01:19.223', '1', '2021-11-29 16:01:19.212', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015846604800', '1465216015712387072', 'parent_ids', '父菜单IDs', NULL, 'varchar(2000)', 'String', 'parentIds', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 1, NULL, '1', '2021-11-29 16:01:19.238', '1', '2021-11-29 16:01:19.226', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015846604801', '1465216015712387072', 'name', '部门名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 1, NULL, '1', '2021-11-29 16:01:19.251', '1', '2021-11-29 16:01:19.241', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015850799104', '1465216015712387072', 'sort', '排序', NULL, 'int', 'Long', 'sort', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 1, NULL, '1', '2021-11-29 16:01:19.266', '1', '2021-11-29 16:01:19.256', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015854993408', '1465216015712387072', 'leaf', '叶子节点', NULL, 'bit(1)', 'Integer', 'leaf', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 60, 1, NULL, '1', '2021-11-29 16:01:19.280', '1', '2021-11-29 16:01:19.269', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015854993409', '1465216015712387072', 'author_', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 1, NULL, '1', '2021-11-29 16:01:19.298', '1', '2021-11-29 16:01:19.287', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015859187712', '1465216015712387072', 'email_', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 1, NULL, '1', '2021-11-29 16:01:19.315', '1', '2021-11-29 16:01:19.303', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015859187713', '1465216015712387072', 'phone_', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 1, NULL, '1', '2021-11-29 16:01:19.332', '1', '2021-11-29 16:01:19.320', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015863382016', '1465216015712387072', 'activated_', 'activated_', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 1, NULL, '1', '2021-11-29 16:01:19.347', '1', '2021-11-29 16:01:19.335', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015871770624', '1465216015712387072', 'number_', 'key', NULL, 'int', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 110, 1, NULL, '1', '2021-11-29 16:01:19.362', '1', '2021-11-29 16:01:19.350', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015871770625', '1465216015712387072', 'money_', 'money_', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 120, 1, NULL, '1', '2021-11-29 16:01:19.377', '1', '2021-11-29 16:01:19.366', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015875964928', '1465216015712387072', 'amount_', 'amount_', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 130, 1, NULL, '1', '2021-11-29 16:01:19.390', '1', '2021-11-29 16:01:19.380', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015875964929', '1465216015712387072', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 140, 1, NULL, '1', '2021-11-29 16:01:19.404', '1', '2021-11-29 16:01:19.395', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015880159232', '1465216015712387072', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 150, 1, NULL, '1', '2021-11-29 16:01:19.421', '1', '2021-11-29 16:01:19.411', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015880159233', '1465216015712387072', 'created_date', '创建时间', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 160, 1, NULL, '1', '2021-11-29 16:01:19.438', '1', '2021-11-29 16:01:19.427', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015884353536', '1465216015712387072', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 1, NULL, '1', '2021-11-29 16:01:19.450', '1', '2021-11-29 16:01:19.441', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015888547840', '1465216015712387072', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 1, NULL, '1', '2021-11-29 16:01:19.466', '1', '2021-11-29 16:01:19.453', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015892742144', '1465216015712387072', 'last_modified_date', '修改时间', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 190, 1, NULL, '1', '2021-11-29 16:01:19.484', '1', '2021-11-29 16:01:19.470', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015896936448', '1465216015712387072', 'version', 'version', NULL, 'int', 'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 200, 1, NULL, '1', '2021-11-29 16:01:19.500', '1', '2021-11-29 16:01:19.489', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015901130752', '1465216015712387072', 'description', '备注', NULL, 'varchar(100)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 210, 1, NULL, '1', '2021-11-29 16:01:19.514', '1', '2021-11-29 16:01:19.503', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465216015901130753', '1465216015712387072', 'tenant_code', '租户编码', NULL, 'varchar(20)', 'String', 'tenantCode', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 220, 1, NULL, '1', '2021-11-29 16:01:19.523', '1', '2021-11-29 16:01:19.518', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375006437376', '1465502374771556352', 'id', '编号', NULL, 'bigint', 'Long', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 1, NULL, '1', '2021-11-30 10:14:48.395', '1', '2021-11-30 10:14:48.376', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375031603200', '1465502374771556352', 'title', '日志标题', NULL, 'varchar(255)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 1, NULL, '1', '2021-11-30 10:14:48.415', '1', '2021-11-30 10:14:48.401', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375048380416', '1465502374771556352', 'user_id', '用户ID', NULL, 'bigint', 'Long', 'userId', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 30, 1, NULL, '1', '2021-11-30 10:14:48.444', '1', '2021-11-30 10:14:48.421', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375065157632', '1465502374771556352', 'username', '用户名', NULL, 'varchar(255)', 'String', 'username', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 40, 1, NULL, '1', '2021-11-30 10:14:48.477', '1', '2021-11-30 10:14:48.455', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375073546240', '1465502374771556352', 'ip_address', 'IP地址', NULL, 'varchar(255)', 'String', 'ipAddress', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 1, NULL, '1', '2021-11-30 10:14:48.494', '1', '2021-11-30 10:14:48.484', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375186792448', '1465502374771556352', 'ip_location', '登录地点', NULL, 'varchar(255)', 'String', 'ipLocation', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 1, NULL, '1', '2021-11-30 10:14:48.509', '1', '2021-11-30 10:14:48.498', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375190986752', '1465502374771556352', 'browser', '浏览器类型', NULL, 'varchar(50)', 'String', 'browser', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 1, NULL, '1', '2021-11-30 10:14:48.524', '1', '2021-11-30 10:14:48.512', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375199375360', '1465502374771556352', 'os', '操作系统', NULL, 'varchar(50)', 'String', 'os', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 1, NULL, '1', '2021-11-30 10:14:48.537', '1', '2021-11-30 10:14:48.527', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375232929792', '1465502374771556352', 'user_agent', '用户代理', NULL, 'varchar(1000)', 'String', 'userAgent', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 1, NULL, '1', '2021-11-30 10:14:48.557', '1', '2021-11-30 10:14:48.542', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375232929793', '1465502374771556352', 'request_uri', '请求URI', NULL, 'varchar(255)', 'String', 'requestUri', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 1, NULL, '1', '2021-11-30 10:14:48.572', '1', '2021-11-30 10:14:48.561', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375237124096', '1465502374771556352', 'execute_time', '执行时间', NULL, 'bigint', 'Long', 'executeTime', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 110, 1, NULL, '1', '2021-11-30 10:14:48.586', '1', '2021-11-30 10:14:48.575', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375241318400', '1465502374771556352', 'tenant_code', '租户编码', NULL, 'varchar(20)', 'String', 'tenantCode', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 1, NULL, '1', '2021-11-30 10:14:48.599', '1', '2021-11-30 10:14:48.589', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375245512704', '1465502374771556352', 'created_by', '创建者', NULL, 'bigint', 'Long', 'createdBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 130, 1, NULL, '1', '2021-11-30 10:14:48.616', '1', '2021-11-30 10:14:48.605', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375249707008', '1465502374771556352', 'created_date', '创建时间', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 140, 1, NULL, '1', '2021-11-30 10:14:48.628', '1', '2021-11-30 10:14:48.619', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375249707009', '1465502374771556352', 'description', '备注', NULL, 'varchar(500)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 150, 1, NULL, '1', '2021-11-30 10:14:48.642', '1', '2021-11-30 10:14:48.631', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1465502375253901312', '1465502374771556352', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 160, 1, NULL, '1', '2021-11-30 10:14:48.650', '1', '2021-11-30 10:14:48.647', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101466849280', '1468396101210996736', 'id', 'ID', NULL, 'bigint', 'Long', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2021-12-08 09:44:46.727', '1', '2021-12-08 09:44:46.727', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101483626496', '1468396101210996736', 'biz_id', '业务id', NULL, 'bigint', 'Long', 'bizId', b'0', b'0', b'0', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 20, 0, NULL, '1', '2021-12-08 09:44:46.731', '1', '2021-12-08 09:44:46.731', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101483626497', '1468396101210996736', 'biz_type', '业务类型', NULL, 'varchar(255)', 'String', 'bizType', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2021-12-08 09:44:46.731', '1', '2021-12-08 09:44:46.731', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101500403712', '1468396101210996736', 'file_type', '文件类型', NULL, 'varchar(255)', 'String', 'fileType', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 40, 0, NULL, '1', '2021-12-08 09:44:46.735', '1', '2021-12-08 09:44:46.735', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101504598016', '1468396101210996736', 'bucket', '桶', NULL, 'varchar(255)', 'String', 'bucket', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2021-12-08 09:44:46.736', '1', '2021-12-08 09:44:46.736', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101517180928', '1468396101210996736', 'path', '文件相对地址', NULL, 'varchar(255)', 'String', 'path', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2021-12-08 09:44:46.739', '1', '2021-12-08 09:44:46.739', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101521375232', '1468396101210996736', 'original_file_name', '原始文件名', NULL, 'varchar(255)', 'String', 'originalFileName', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2021-12-08 09:44:46.740', '1', '2021-12-08 09:44:46.740', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101529763840', '1468396101210996736', 'content_type', '文件类型', NULL, 'varchar(255)', 'String', 'contentType', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2021-12-08 09:44:46.742', '1', '2021-12-08 09:44:46.742', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101533958144', '1468396101210996736', 'size', '大小', NULL, 'bigint', 'Long', 'size', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2021-12-08 09:44:46.743', '1', '2021-12-08 09:44:46.743', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101542346752', '1468396101210996736', 'tenant_code', '租户编码', NULL, 'varchar(20)', 'String', 'tenantCode', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1', '2021-12-08 09:44:46.745', '1', '2021-12-08 09:44:46.745', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101542346753', '1468396101210996736', 'created_by', 'created_by', NULL, 'bigint', 'Long', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 110, 0, NULL, '1', '2021-12-08 09:44:46.745', '1', '2021-12-08 09:44:46.745', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101546541056', '1468396101210996736', 'created_date', '创建时间', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 120, 0, NULL, '1', '2021-12-08 09:44:46.746', '1', '2021-12-08 09:44:46.746', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101550735360', '1468396101210996736', 'last_modified_by', 'last_modified_by', NULL, 'bigint', 'Long', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 130, 0, NULL, '1', '2021-12-08 09:44:46.747', '1', '2021-12-08 09:44:46.747', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101554929664', '1468396101210996736', 'last_modified_date', '修改时间', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 140, 0, NULL, '1', '2021-12-08 09:44:46.748', '1', '2021-12-08 09:44:46.748', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101559123968', '1468396101210996736', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 150, 0, NULL, '1', '2021-12-08 09:44:46.749', '1', '2021-12-08 09:44:46.749', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101563318272', '1468396101210996736', 'version', 'version', NULL, 'int', 'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 160, 0, NULL, '1', '2021-12-08 09:44:46.750', '1', '2021-12-08 09:44:46.750', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468396101571706880', '1468396101210996736', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 170, 0, NULL, '1', '2021-12-08 09:44:46.752', '1', '2021-12-08 09:44:46.752', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145433083904', '1468404145256923136', 'id', 'ID', NULL, 'bigint', 'Long', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 2, NULL, '1', '2021-12-08 10:20:09.909', '1', '2021-12-08 10:20:09.901', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145445666816', '1468404145256923136', 'biz_type', '业务类型', NULL, 'varchar(255)', 'String', 'bizType', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 2, NULL, '1', '2021-12-08 10:20:09.921', '1', '2021-12-08 10:20:09.912', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145466638336', '1468404145256923136', 'file_type', '文件类型', NULL, 'varchar(255)', 'String', 'fileType', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', 'file_type', NULL, 30, 2, NULL, '1', '2021-12-08 10:20:09.933', '1', '2021-12-08 10:20:09.925', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145483415552', '1468404145256923136', 'storage_type', '存储类型\nLOCAL FAST_DFS MIN_IO ALI \n', NULL, 'varchar(255)', 'String', 'storageType', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', 'file_storage_type', NULL, 40, 2, NULL, '1', '2021-12-08 10:20:09.947', '1', '2021-12-08 10:20:09.937', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145487609856', '1468404145256923136', 'bucket', '桶', NULL, 'varchar(255)', 'String', 'bucket', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 2, NULL, '1', '2021-12-08 10:20:09.971', '1', '2021-12-08 10:20:09.952', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145495998464', '1468404145256923136', 'path', '文件相对地址', NULL, 'varchar(255)', 'String', 'path', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 2, NULL, '1', '2021-12-08 10:20:09.984', '1', '2021-12-08 10:20:09.975', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145500192768', '1468404145256923136', 'url', '文件访问地址', NULL, 'varchar(255)', 'String', 'url', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 2, NULL, '1', '2021-12-08 10:20:09.996', '1', '2021-12-08 10:20:09.987', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145504387072', '1468404145256923136', 'unique_file_name', '唯一文件名', NULL, 'varchar(255)', 'String', 'uniqueFileName', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 2, NULL, '1', '2021-12-08 10:20:10.010', '1', '2021-12-08 10:20:10.000', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145508581376', '1468404145256923136', 'file_md5', '文件md5', NULL, 'varchar(255)', 'String', 'fileMd5', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'like', 'input', '', NULL, 90, 2, NULL, '1', '2021-12-08 10:20:10.022', '1', '2021-12-08 10:20:10.013', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145508581377', '1468404145256923136', 'original_file_name', '原始文件名', NULL, 'varchar(255)', 'String', 'originalFileName', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 100, 2, NULL, '1', '2021-12-08 10:20:10.036', '1', '2021-12-08 10:20:10.026', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145512775680', '1468404145256923136', 'content_type', '文件类型', NULL, 'varchar(255)', 'String', 'contentType', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'like', 'input', '', NULL, 110, 2, NULL, '1', '2021-12-08 10:20:10.047', '1', '2021-12-08 10:20:10.039', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145533747200', '1468404145256923136', 'suffix', '后缀', NULL, 'varchar(255)', 'String', 'suffix', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 120, 2, NULL, '1', '2021-12-08 10:20:10.059', '1', '2021-12-08 10:20:10.051', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145537941504', '1468404145256923136', 'size', '大小', NULL, 'bigint', 'Long', 'size', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 130, 2, NULL, '1', '2021-12-08 10:20:10.073', '1', '2021-12-08 10:20:10.062', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145542135808', '1468404145256923136', 'tenant_code', '租户编码', NULL, 'varchar(20)', 'String', 'tenantCode', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 2, NULL, '1', '2021-12-08 10:20:10.087', '1', '2021-12-08 10:20:10.077', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145554718720', '1468404145256923136', 'created_by', 'created_by', NULL, 'bigint', 'Long', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 150, 2, NULL, '1', '2021-12-08 10:20:10.100', '1', '2021-12-08 10:20:10.091', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145554718721', '1468404145256923136', 'created_date', '创建时间', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 160, 2, NULL, '1', '2021-12-08 10:20:10.115', '1', '2021-12-08 10:20:10.105', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145563107328', '1468404145256923136', 'last_modified_by', 'last_modified_by', NULL, 'bigint', 'Long', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 2, NULL, '1', '2021-12-08 10:20:10.131', '1', '2021-12-08 10:20:10.119', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145588273152', '1468404145256923136', 'last_modified_date', '修改时间', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 180, 2, NULL, '1', '2021-12-08 10:20:10.146', '1', '2021-12-08 10:20:10.135', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145592467456', '1468404145256923136', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 190, 2, NULL, '1', '2021-12-08 10:20:10.165', '1', '2021-12-08 10:20:10.150', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145596661760', '1468404145256923136', 'version', 'version', NULL, 'int', 'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 200, 2, NULL, '1', '2021-12-08 10:20:10.181', '1', '2021-12-08 10:20:10.172', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('1468404145596661761', '1468404145256923136', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 210, 2, NULL, '1', '2021-12-08 10:20:10.188', '1', '2021-12-08 10:20:10.186', '0', '0000');
INSERT INTO `gen_table_column` VALUES ('14f390ce038e8d7cf43ccc459af3f6ad', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'email', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 1, NULL, '1', '2021-10-21 13:41:07.758', '1', '2021-10-21 13:41:07.756', '0', '');
INSERT INTO `gen_table_column` VALUES ('160ef5a56e43aae3116468d9fca55f0e', '914e23ded1edc89992828b45a3baeb4d', 'name', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.111', '1', '');
INSERT INTO `gen_table_column` VALUES ('16b885d529007b518e698b7ebd9c8468', '23e5b6463bece83a7bb3039c79cad984', 'author_', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2021-10-21 13:51:02.766', '1', '2021-10-21 13:51:02.766', '0', '');
INSERT INTO `gen_table_column` VALUES ('1730403fba8a72b80b51851ad1de6ff2', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.829', '1', '');
INSERT INTO `gen_table_column` VALUES ('196d5a0bde4c87801bcc4a3c880f320d', '23e5b6463bece83a7bb3039c79cad984', 'amount_', 'amount_', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 130, 0, NULL, '1', '2021-10-21 13:51:02.776', '1', '2021-10-21 13:51:02.776', '0', '');
INSERT INTO `gen_table_column` VALUES ('1a21f72b4c8f4400f93d227b1df91658', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.797', '1', '');
INSERT INTO `gen_table_column` VALUES ('1d7a161b2e3ae025fcd13ef7d5f2ebe0', '23e5b6463bece83a7bb3039c79cad984', 'email_', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2021-10-21 13:51:02.768', '1', '2021-10-21 13:51:02.768', '0', '');
INSERT INTO `gen_table_column` VALUES ('1ebde78b99da2c1c9df8a85f3f825afe', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'money', 'money', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.762', '1', '');
INSERT INTO `gen_table_column` VALUES ('2032b309505a9967ee491adab14ff7bf', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 1, NULL, '1', '2021-10-21 13:41:07.793', '1', '2021-10-21 13:41:07.791', '0', '');
INSERT INTO `gen_table_column` VALUES ('2bb5e991a2b5d7573427af0999a82a09', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'money', 'money', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 1, NULL, '1', '2021-10-21 13:41:07.782', '1', '2021-10-21 13:41:07.779', '0', '');
INSERT INTO `gen_table_column` VALUES ('350f2218fe35aa725c7621dfaec701fc', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.783', '1', '');
INSERT INTO `gen_table_column` VALUES ('376c0accb0d931cc8b236f45bc9a0b53', '914e23ded1edc89992828b45a3baeb4d', 'number', 'key', NULL, 'int', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.186', '1', '');
INSERT INTO `gen_table_column` VALUES ('3bbe3ff618ab459be8667bb36d503b0c', '914e23ded1edc89992828b45a3baeb4d', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.249', '1', '');
INSERT INTO `gen_table_column` VALUES ('3ff7cdfcee3543d103d855c6386e4f25', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 1, NULL, '1', '2021-10-21 13:41:07.808', '1', '2021-10-21 13:41:07.806', '0', '');
INSERT INTO `gen_table_column` VALUES ('4247f9282e2014c21d4e6f70c5951f8a', '914e23ded1edc89992828b45a3baeb4d', 'amount', 'amount', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.205', '1', '');
INSERT INTO `gen_table_column` VALUES ('47e3e9da932eac8a90613d07ab6d215f', '914e23ded1edc89992828b45a3baeb4d', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.086', '1', '');
INSERT INTO `gen_table_column` VALUES ('4a81bb196d49f5bf8ddc75866ed822de', '23e5b6463bece83a7bb3039c79cad984', 'version', 'version', NULL, 'int', 'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 200, 0, NULL, '1', '2021-10-21 13:51:02.789', '1', '2021-10-21 13:51:02.789', '0', '');
INSERT INTO `gen_table_column` VALUES ('4ac83e46b9d01b1a93338829ae9d08fb', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'author', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 1, NULL, '1', '2021-10-21 13:41:07.748', '1', '2021-10-21 13:41:07.746', '0', '');
INSERT INTO `gen_table_column` VALUES ('4e068d016b1ded2d55bf3b570cee6409', '914e23ded1edc89992828b45a3baeb4d', 'name', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.154', '1', '');
INSERT INTO `gen_table_column` VALUES ('58364bb2c2096f1f901a5800ade8547d', '23e5b6463bece83a7bb3039c79cad984', 'created_date', '创建时间', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 160, 0, NULL, '1', '2021-10-21 13:51:02.781', '1', '2021-10-21 13:51:02.781', '0', '');
INSERT INTO `gen_table_column` VALUES ('5e2a3ba8476f0a9bfe0a1a3395458b52', '914e23ded1edc89992828b45a3baeb4d', 'money', 'money', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.197', '1', '');
INSERT INTO `gen_table_column` VALUES ('5eb7797ebf43a137fb5627c7c45cc691', '23e5b6463bece83a7bb3039c79cad984', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 0, NULL, '1', '2021-10-21 13:51:02.784', '1', '2021-10-21 13:51:02.784', '0', '');
INSERT INTO `gen_table_column` VALUES ('6a2a23a5473c6a902989e8320d75bedd', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'author', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.718', '1', '');
INSERT INTO `gen_table_column` VALUES ('6ffd18450192a44a064990dd30d9da96', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 1, NULL, '1', '2021-10-21 13:41:07.743', '1', '2021-10-21 13:41:07.740', '0', '');
INSERT INTO `gen_table_column` VALUES ('7198e1ee4064b5109551b49d00c886e0', '914e23ded1edc89992828b45a3baeb4d', 'email', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.161', '1', '');
INSERT INTO `gen_table_column` VALUES ('7435d089d4b038bc9704ab2aad4f3b0f', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'phone', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 1, NULL, '1', '2021-10-21 13:41:07.766', '1', '2021-10-21 13:41:07.763', '0', '');
INSERT INTO `gen_table_column` VALUES ('769a9df74fa04613eab5d104543621c2', '914e23ded1edc89992828b45a3baeb4d', 'number', 'key', NULL, 'int', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.193', '1', '');
INSERT INTO `gen_table_column` VALUES ('787c73cc4828237c10a0bb799b42cef7', '23e5b6463bece83a7bb3039c79cad984', 'parent_id', 'parent_id', NULL, 'varchar(32)', 'String', 'parentId', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 20, 0, NULL, '1', '2021-10-21 13:51:02.753', '1', '2021-10-21 13:51:02.753', '0', '');
INSERT INTO `gen_table_column` VALUES ('7c4d84500f93ea15a85a128dd0365bb8', '914e23ded1edc89992828b45a3baeb4d', 'activated', 'activated', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.178', '1', '');
INSERT INTO `gen_table_column` VALUES ('817fcd924d8125642b86874835c1779a', '914e23ded1edc89992828b45a3baeb4d', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.216', '1', '');
INSERT INTO `gen_table_column` VALUES ('832a5cdd494ab749e0b68ecd08c963cd', '914e23ded1edc89992828b45a3baeb4d', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.238', '1', '');
INSERT INTO `gen_table_column` VALUES ('85eccd9ec0c14bd6fdcabb4bc84e55b7', '914e23ded1edc89992828b45a3baeb4d', 'author', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.096', '1', '');
INSERT INTO `gen_table_column` VALUES ('87e519040f06d1d98cc6c4f5044f65e7', '914e23ded1edc89992828b45a3baeb4d', 'phone', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.170', '1', '');
INSERT INTO `gen_table_column` VALUES ('8a5b163e299a579219a7c5cb4d590824', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.708', '1', '');
INSERT INTO `gen_table_column` VALUES ('8a7db81877b38481b28841df0c2fd48b', '914e23ded1edc89992828b45a3baeb4d', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.242', '1', '');
INSERT INTO `gen_table_column` VALUES ('8dfa831d21fd87bedb68b092de111b3f', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 1, NULL, '1', '2021-10-21 13:41:07.732', '1', '2021-10-21 13:41:07.729', '0', '');
INSERT INTO `gen_table_column` VALUES ('8f00f0b6ef15cbd73e61609419940ff9', '914e23ded1edc89992828b45a3baeb4d', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.090', '1', '');
INSERT INTO `gen_table_column` VALUES ('8f8ab7bf2bf5e1b62779bfcc735038dc', '914e23ded1edc89992828b45a3baeb4d', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.271', '1', '');
INSERT INTO `gen_table_column` VALUES ('92cc5c4fee3ae2bc65ca35c13ecd50ba', '914e23ded1edc89992828b45a3baeb4d', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.276', '1', '');
INSERT INTO `gen_table_column` VALUES ('94a1cd02d37413a38ebb0627e5255452', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'name', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.726', '1', '');
INSERT INTO `gen_table_column` VALUES ('95e3a489fe8fdc951eda5c30bc199759', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'activated', 'activated', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 1, NULL, '1', '2021-10-21 13:41:07.770', '1', '2021-10-21 13:41:07.769', '0', '');
INSERT INTO `gen_table_column` VALUES ('9aac329cd6ae5b6a4dedf2f649d3fb62', '914e23ded1edc89992828b45a3baeb4d', 'version', 'version', NULL, 'int', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.263', '1', '');
INSERT INTO `gen_table_column` VALUES ('9abc230a64498fa4477ff44ad16c2144', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'version', 'version', NULL, 'int', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.822', '1', '');
INSERT INTO `gen_table_column` VALUES ('9b581487322037525724f9014803621b', '914e23ded1edc89992828b45a3baeb4d', 'phone', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.174', '1', '');
INSERT INTO `gen_table_column` VALUES ('9c14719f3ec200fefdeb2514e1edaeae', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 1, NULL, '1', '2021-10-21 13:41:07.831', '1', '2021-10-21 13:41:07.828', '0', '');
INSERT INTO `gen_table_column` VALUES ('9ebd74b312314ca4b6bcb6f225e17c8c', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'amount', 'amount', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 1, NULL, '1', '2021-10-21 13:41:07.787', '1', '2021-10-21 13:41:07.785', '0', '');
INSERT INTO `gen_table_column` VALUES ('9f332cda1eb45dff57e6621a34794985', '23e5b6463bece83a7bb3039c79cad984', 'activated_', 'activated_', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1', '2021-10-21 13:51:02.772', '1', '2021-10-21 13:51:02.772', '0', '');
INSERT INTO `gen_table_column` VALUES ('a02819031e0f7a89e7bbcfd70b5ea7b0', '23e5b6463bece83a7bb3039c79cad984', 'parent_ids', '父菜单IDs', NULL, 'varchar(2000)', 'String', 'parentIds', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2021-10-21 13:51:02.755', '1', '2021-10-21 13:51:02.755', '0', '');
INSERT INTO `gen_table_column` VALUES ('a525a9f93386e0b7e1e526967a20aeb1', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'phone', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.738', '1', '');
INSERT INTO `gen_table_column` VALUES ('a54bc691b787102fea8876691743fefa', '23e5b6463bece83a7bb3039c79cad984', 'description', '备注', NULL, 'varchar(100)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 210, 0, NULL, '1', '2021-10-21 13:51:02.791', '1', '2021-10-21 13:51:02.791', '0', '');
INSERT INTO `gen_table_column` VALUES ('a89fe97d8601c280265ac8e1da82d238', '914e23ded1edc89992828b45a3baeb4d', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 160, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.254', '1', '');
INSERT INTO `gen_table_column` VALUES ('aafba242fedad14e8a1e4472ad2007f3', '23e5b6463bece83a7bb3039c79cad984', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 0, NULL, '1', '2021-10-21 13:51:02.786', '1', '2021-10-21 13:51:02.786', '0', '');
INSERT INTO `gen_table_column` VALUES ('ac33059130f9d39b0122331a3539431b', '914e23ded1edc89992828b45a3baeb4d', 'author', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.103', '1', '');
INSERT INTO `gen_table_column` VALUES ('ad54b72d51c214684e5c2288cca2b789', '23e5b6463bece83a7bb3039c79cad984', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2021-10-21 13:51:02.745', '1', '2021-10-21 13:51:02.745', '0', '');
INSERT INTO `gen_table_column` VALUES ('aeeaa73635fcfabc9b0d020c20f3622e', '23e5b6463bece83a7bb3039c79cad984', 'leaf', '叶子节点', NULL, 'bit(1)', 'Integer', 'leaf', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2021-10-21 13:51:02.763', '1', '2021-10-21 13:51:02.763', '0', '');
INSERT INTO `gen_table_column` VALUES ('af8a1a555969fcc89b4adfd40b1b8b1e', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'amount', 'amount', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.770', '1', '');
INSERT INTO `gen_table_column` VALUES ('b2a49039989a8767421c9bdf365e5dab', '23e5b6463bece83a7bb3039c79cad984', 'sort', '排序', NULL, 'int', 'Long', 'sort', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2021-10-21 13:51:02.760', '1', '2021-10-21 13:51:02.760', '0', '');
INSERT INTO `gen_table_column` VALUES ('b2d51b0c0d79e0230993765814cb0a47', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.778', '1', '');
INSERT INTO `gen_table_column` VALUES ('b4151934dafc27f59e582bffa505d220', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'name', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 1, NULL, '1', '2021-10-21 13:41:07.754', '1', '2021-10-21 13:41:07.752', '0', '');
INSERT INTO `gen_table_column` VALUES ('b53933714e07626e48b20f906b8648af', '23e5b6463bece83a7bb3039c79cad984', 'number_', 'key', NULL, 'int', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 110, 0, NULL, '1', '2021-10-21 13:51:02.774', '1', '2021-10-21 13:51:02.774', '0', '');
INSERT INTO `gen_table_column` VALUES ('b6f7adea923ca45bd4b5504e5056969c', '914e23ded1edc89992828b45a3baeb4d', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.230', '1', '');
INSERT INTO `gen_table_column` VALUES ('b7cda5c3e83554788f9d4f76a0248f04', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 1, NULL, '1', '2021-10-21 13:41:07.797', '1', '2021-10-21 13:41:07.796', '0', '');
INSERT INTO `gen_table_column` VALUES ('b7fbe74b0d8cd459e1e34a6d04c5fad5', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'number', 'key', NULL, 'int', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 1, NULL, '1', '2021-10-21 13:41:07.775', '1', '2021-10-21 13:41:07.773', '0', '');
INSERT INTO `gen_table_column` VALUES ('ba0cccf677f97bd52513d72f2a9b0d31', '23e5b6463bece83a7bb3039c79cad984', 'money_', 'money_', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 120, 0, NULL, '1', '2021-10-21 13:51:02.775', '1', '2021-10-21 13:51:02.775', '0', '');
INSERT INTO `gen_table_column` VALUES ('ba3f9d75b426fb862f1df15313678b50', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'email', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.732', '1', '');
INSERT INTO `gen_table_column` VALUES ('bb8340b538a52414de5468d84ce29e64', '23e5b6463bece83a7bb3039c79cad984', 'phone_', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2021-10-21 13:51:02.770', '1', '2021-10-21 13:51:02.770', '0', '');
INSERT INTO `gen_table_column` VALUES ('bca8234daa7f90b3bffb9302875b49e6', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 160, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.815', '1', '');
INSERT INTO `gen_table_column` VALUES ('be9e963593ea3dcd20e505f3645f4967', '23e5b6463bece83a7bb3039c79cad984', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 150, 0, NULL, '1', '2021-10-21 13:51:02.779', '1', '2021-10-21 13:51:02.779', '0', '');
INSERT INTO `gen_table_column` VALUES ('c21e4722bdbb3578ca5209819530178b', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'number', 'key', NULL, 'int', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.752', '1', '');
INSERT INTO `gen_table_column` VALUES ('c87cf848a6daec6887955bd2626933ee', '23e5b6463bece83a7bb3039c79cad984', 'name', '部门名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0, NULL, '1', '2021-10-21 13:51:02.758', '1', '2021-10-21 13:51:02.758', '0', '');
INSERT INTO `gen_table_column` VALUES ('cb5a21836a651c5f5e13dfd4cbceebd1', '914e23ded1edc89992828b45a3baeb4d', 'amount', 'amount', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.212', '1', '');
INSERT INTO `gen_table_column` VALUES ('ccaefa439dd18ea00e3fdef9061c6265', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.789', '1', '');
INSERT INTO `gen_table_column` VALUES ('cd3e618d0ce7a93d698013702883ccaa', '914e23ded1edc89992828b45a3baeb4d', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 160, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.259', '1', '');
INSERT INTO `gen_table_column` VALUES ('cd8776c254e19164efc4ce68be84cc2d', '914e23ded1edc89992828b45a3baeb4d', 'money', 'money', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.201', '1', '');
INSERT INTO `gen_table_column` VALUES ('cdae1650592435d735f3b64d018c2a9e', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 1, NULL, '1', '2021-10-21 13:41:07.803', '1', '2021-10-21 13:41:07.801', '0', '');
INSERT INTO `gen_table_column` VALUES ('d516837612bf7d075096d9f03ed08401', '23e5b6463bece83a7bb3039c79cad984', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 140, 0, NULL, '1', '2021-10-21 13:51:02.778', '1', '2021-10-21 13:51:02.778', '0', '');
INSERT INTO `gen_table_column` VALUES ('d8f665f3401df3cc864fd70bbcddcd45', '914e23ded1edc89992828b45a3baeb4d', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.223', '1', '');
INSERT INTO `gen_table_column` VALUES ('de55d094f861ec9b58f41a4d84ce80ac', 'b51b39d0588eb0d02b5398b0d9cf70ff', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 1, NULL, '1', '2021-10-21 13:41:07.812', '1', '2021-10-21 13:41:07.810', '0', '');
INSERT INTO `gen_table_column` VALUES ('df5b874e5f7c4f57254740095147b0b4', '914e23ded1edc89992828b45a3baeb4d', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.234', '1', '');
INSERT INTO `gen_table_column` VALUES ('e83767d293356b9989dd253dde2eab5f', '914e23ded1edc89992828b45a3baeb4d', 'email', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.166', '1', '');
INSERT INTO `gen_table_column` VALUES ('e8ab962ae390fbeee07bb7f1d8b98fc3', '914e23ded1edc89992828b45a3baeb4d', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.081', '1', '');
INSERT INTO `gen_table_column` VALUES ('ea9526b321f1655efa3eb95430676459', '914e23ded1edc89992828b45a3baeb4d', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.226', '1', '');
INSERT INTO `gen_table_column` VALUES ('f24a89283a3d2d16d1b8d441717744da', '914e23ded1edc89992828b45a3baeb4d', 'version', 'version', NULL, 'int', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.267', '1', '');
INSERT INTO `gen_table_column` VALUES ('f2bce4638bc835c7ae3f36eb7b251123', '807aa43d6dd9b6a11814ed7ef17bb9e3', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 3, NULL, '1', '2021-10-21 13:31:37.189', '1', '2021-10-21 13:28:06.693', '1', '');
INSERT INTO `gen_table_column` VALUES ('f2cdd848bd9333a9258938c1fe3c744e', '914e23ded1edc89992828b45a3baeb4d', 'activated', 'activated', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.181', '1', '');
INSERT INTO `gen_table_column` VALUES ('f868144da3c5c840f6c71f2c5260e7f8', '23e5b6463bece83a7bb3039c79cad984', 'last_modified_date', '修改时间', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 190, 0, NULL, '1', '2021-10-21 13:51:02.788', '1', '2021-10-21 13:51:02.788', '0', '');
INSERT INTO `gen_table_column` VALUES ('f9fcb2dbe20f0508244c6db8aa69d6e5', '914e23ded1edc89992828b45a3baeb4d', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 1, NULL, '1', '2021-10-21 13:40:34.574', '1', '2021-10-21 13:33:17.219', '1', '');
COMMIT;

-- ----------------------------
-- Table structure for gen_table_fk
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_fk`;
CREATE TABLE `gen_table_fk` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否主键',
  `is_unique` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '是否唯一（1：是；0：否）',
  `is_null` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `version` int DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `gen_table_column_table_id` (`gen_table_id`) USING BTREE,
  KEY `gen_table_column_name` (`name`) USING BTREE,
  KEY `gen_table_column_sort` (`sort`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='业务表字段';

-- ----------------------------
-- Records of gen_table_fk
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME1', 'DEFAULT0000', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME2', 'DEFAULT0000', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME3', 'DEFAULT0000', '0/20 * * * * ?', 'Asia/Shanghai');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fired_time` bigint NOT NULL,
  `sched_time` bigint NOT NULL,
  `priority` int NOT NULL,
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_job_details` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME1', 'DEFAULT0000', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F62000000000000000102000A4C000A636F6E63757272656E7474003B4C636F6D2F616C6265646F2F6A6176612F6D6F64756C65732F71756172747A2F646F6D61696E2F656E756D732F4A6F62436F6E63757272656E743B4C000E63726F6E45787072657373696F6E7400124C6A6176612F6C616E672F537472696E673B4C0005656D61696C71007E000A4C000567726F757071007E000A4C000269647400104C6A6176612F6C616E672F4C6F6E673B4C000C696E766F6B6554617267657471007E000A4C000D6D697366697265506F6C69637974003E4C636F6D2F616C6265646F2F6A6176612F6D6F64756C65732F71756172747A2F646F6D61696E2F656E756D732F4A6F624D697366697265506F6C6963793B4C00046E616D6571007E000A4C00067374617475737400374C636F6D2F616C6265646F2F6A6176612F6D6F64756C65732F71756172747A2F646F6D61696E2F656E756D732F4A6F625374617475733B4C000A74656E616E74436F646571007E000A78720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E636F72652E62617369632E646F6D61696E2E4261736544617461456E7469747900000000000000010200064C00096372656174656442797400164C6A6176612F696F2F53657269616C697A61626C653B4C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E000A4C000E6C6173744D6F646966696564427971007E000F4C00106C6173744D6F6469666965644461746571007E00104C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B78720033636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E636F72652E62617369632E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000A78720036636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E636F72652E62617369632E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB78707371007E001700000000000000017371007E001A770E05000007E50B19102A2827E0214078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00180000000C7E720039636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E656E756D732E4A6F62436F6E63757272656E7400000000000000001200007872000E6A6176612E6C616E672E456E756D0000000000000000120000787074000359455374000E302F3130202A202A202A202A203F7074000744454641554C5471007E001C74001573696D706C655461736B2E646F4E6F506172616D737E72003C636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E656E756D732E4A6F624D697366697265506F6C69637900000000000000001200007871007E002174000C464952455F50524F43454544740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC897E720035636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E656E756D732E4A6F6253746174757300000000000000001200007871007E00217400055041555345740004303030307800);
INSERT INTO `qrtz_job_details` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME2', 'DEFAULT0000', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F62000000000000000102000A4C000A636F6E63757272656E7474003B4C636F6D2F616C6265646F2F6A6176612F6D6F64756C65732F71756172747A2F646F6D61696E2F656E756D732F4A6F62436F6E63757272656E743B4C000E63726F6E45787072657373696F6E7400124C6A6176612F6C616E672F537472696E673B4C0005656D61696C71007E000A4C000567726F757071007E000A4C000269647400104C6A6176612F6C616E672F4C6F6E673B4C000C696E766F6B6554617267657471007E000A4C000D6D697366697265506F6C69637974003E4C636F6D2F616C6265646F2F6A6176612F6D6F64756C65732F71756172747A2F646F6D61696E2F656E756D732F4A6F624D697366697265506F6C6963793B4C00046E616D6571007E000A4C00067374617475737400374C636F6D2F616C6265646F2F6A6176612F6D6F64756C65732F71756172747A2F646F6D61696E2F656E756D732F4A6F625374617475733B4C000A74656E616E74436F646571007E000A78720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E636F72652E62617369632E646F6D61696E2E4261736544617461456E7469747900000000000000010200064C00096372656174656442797400164C6A6176612F696F2F53657269616C697A61626C653B4C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E000A4C000E6C6173744D6F646966696564427971007E000F4C00106C6173744D6F6469666965644461746571007E00104C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B78720033636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E636F72652E62617369632E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000A78720036636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E636F72652E62617369632E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770E05000007E3080E0A1524389FD98078707371007E001700000000000000017371007E001A770E05000007E50B19102A28285A334078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0018000000167E720039636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E656E756D732E4A6F62436F6E63757272656E7400000000000000001200007872000E6A6176612E6C616E672E456E756D0000000000000000120000787074000359455374000E302F3135202A202A202A202A203F7074000744454641554C547371007E0017000000000000000274001D73696D706C655461736B2E646F506172616D732827616C6265646F27297E72003C636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E656E756D732E4A6F624D697366697265506F6C69637900000000000000001200007871007E002174000C464952455F50524F43454544740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC897E720035636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E656E756D732E4A6F6253746174757300000000000000001200007871007E00217400055041555345740004303030307800);
INSERT INTO `qrtz_job_details` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME3', 'DEFAULT0000', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F62000000000000000102000A4C000A636F6E63757272656E7474003B4C636F6D2F616C6265646F2F6A6176612F6D6F64756C65732F71756172747A2F646F6D61696E2F656E756D732F4A6F62436F6E63757272656E743B4C000E63726F6E45787072657373696F6E7400124C6A6176612F6C616E672F537472696E673B4C0005656D61696C71007E000A4C000567726F757071007E000A4C000269647400104C6A6176612F6C616E672F4C6F6E673B4C000C696E766F6B6554617267657471007E000A4C000D6D697366697265506F6C69637974003E4C636F6D2F616C6265646F2F6A6176612F6D6F64756C65732F71756172747A2F646F6D61696E2F656E756D732F4A6F624D697366697265506F6C6963793B4C00046E616D6571007E000A4C00067374617475737400374C636F6D2F616C6265646F2F6A6176612F6D6F64756C65732F71756172747A2F646F6D61696E2F656E756D732F4A6F625374617475733B4C000A74656E616E74436F646571007E000A78720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E636F72652E62617369632E646F6D61696E2E4261736544617461456E7469747900000000000000010200064C00096372656174656442797400164C6A6176612F696F2F53657269616C697A61626C653B4C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E000A4C000E6C6173744D6F646966696564427971007E000F4C00106C6173744D6F6469666965644461746571007E00104C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B78720033636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E636F72652E62617369632E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000A78720036636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E636F72652E62617369632E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB78707371007E001700000000000000017371007E001A770E05000007E50B19102A282878B7C078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0018000000047E720039636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E656E756D732E4A6F62436F6E63757272656E7400000000000000001200007872000E6A6176612E6C616E672E456E756D0000000000000000120000787074000359455374000E302F3230202A202A202A202A203F7074000744454641554C547371007E0017000000000000000374004073696D706C655461736B2E646F4D756C7469706C65506172616D732827616C6265646F272C20747275652C20323030304C2C203331362E3530442C20313030297E72003C636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E656E756D732E4A6F624D697366697265506F6C69637900000000000000001200007871007E002174000C464952455F50524F43454544740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC897E720035636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E656E756D732E4A6F6253746174757300000000000000001200007871007E00217400055041555345740004303030307800);
COMMIT;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_locks` VALUES ('AlbedoQuartzScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('AlbedoQuartzScheduler', 'TRIGGER_ACCESS');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_checkin_time` bigint NOT NULL,
  `checkin_interval` bigint NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_scheduler_state` VALUES ('AlbedoQuartzScheduler', 'CindydeMBP.lan1639114111315', 1639115895411, 15000);
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `repeat_count` bigint NOT NULL,
  `repeat_interval` bigint NOT NULL,
  `times_triggered` bigint NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `int_prop_1` int DEFAULT NULL,
  `int_prop_2` int DEFAULT NULL,
  `long_prop_1` bigint DEFAULT NULL,
  `long_prop_2` bigint DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `next_fire_time` bigint DEFAULT NULL,
  `prev_fire_time` bigint DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `start_time` bigint NOT NULL,
  `end_time` bigint DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `misfire_instr` smallint DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME1', 'DEFAULT0000', 'TASK_CLASS_NAME1', 'DEFAULT0000', NULL, 1639114120000, -1, 5, 'PAUSED', 'CRON', 1639114113000, 0, NULL, 1, '');
INSERT INTO `qrtz_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME2', 'DEFAULT0000', 'TASK_CLASS_NAME2', 'DEFAULT0000', NULL, 1639114125000, -1, 5, 'PAUSED', 'CRON', 1639114114000, 0, NULL, 1, '');
INSERT INTO `qrtz_triggers` VALUES ('AlbedoQuartzScheduler', 'TASK_CLASS_NAME3', 'DEFAULT0000', 'TASK_CLASS_NAME3', 'DEFAULT0000', NULL, 1639114120000, -1, 5, 'PAUSED', 'CRON', 1639114114000, 0, NULL, 1, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_appendix
-- ----------------------------
DROP TABLE IF EXISTS `sys_appendix`;
CREATE TABLE `sys_appendix` (
  `id` bigint NOT NULL COMMENT 'ID',
  `biz_id` bigint NOT NULL DEFAULT '0' COMMENT '业务id',
  `biz_type` varchar(255) NOT NULL DEFAULT '' COMMENT '业务类型',
  `file_type` varchar(255) DEFAULT NULL COMMENT '文件类型',
  `bucket` varchar(255) DEFAULT '' COMMENT '桶',
  `path` varchar(255) DEFAULT '' COMMENT '文件相对地址',
  `original_file_name` varchar(255) DEFAULT '' COMMENT '原始文件名',
  `content_type` varchar(255) DEFAULT '' COMMENT '文件类型',
  `size` bigint DEFAULT '0' COMMENT '大小',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  `created_by` bigint NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` bigint DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `version` int NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务附件';

-- ----------------------------
-- Records of sys_appendix
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_application
-- ----------------------------
DROP TABLE IF EXISTS `sys_application`;
CREATE TABLE `sys_application` (
  `id` bigint NOT NULL COMMENT 'ID',
  `client_id` varchar(24) DEFAULT '' COMMENT '客户端ID',
  `client_secret` varchar(32) DEFAULT '' COMMENT '客户端密码',
  `website` varchar(100) DEFAULT '' COMMENT '官网',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '应用名称',
  `icon` varchar(255) DEFAULT '' COMMENT '应用图标',
  `app_type` varchar(10) DEFAULT '' COMMENT '类型 \n#{SERVER:服务应用;APP:手机应用;PC:PC网页应用;WAP:手机网页应用}',
  `state` bit(1) DEFAULT b'1' COMMENT '状态',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  `created_by` bigint NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` bigint DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `version` int NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_client_id` (`tenant_code`,`client_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='应用';

-- ----------------------------
-- Records of sys_application
-- ----------------------------
BEGIN;
INSERT INTO `sys_application` VALUES (1, 'albedo_web', 'albedo_web_secret', 'https://github.com/somowhere/albedo', 'albedo 快速开发平台', NULL, 'PC', b'1', '0000', 0, '2021-10-27 13:51:34.202', NULL, '2021-12-02 20:11:17.897', NULL, 0, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` bigint NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父菜单IDs',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '部门名称',
  `sort` int DEFAULT NULL COMMENT '排序',
  `leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '1-正常，0-锁定',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `version` int NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='部门管理';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` VALUES (1, -1, NULL, '总部', 30, b'0', '1', '1', '2020-05-15 11:26:57.020', '1', '2021-11-19 19:53:52.884', 14, '', '0', '0000');
INSERT INTO `sys_dept` VALUES (3, 1, '1,', 'ddd', 1, b'1', '1', '1', '2020-05-15 12:05:18.140', '1', '2021-11-19 19:53:52.887', 0, NULL, '1', '0000');
INSERT INTO `sys_dept` VALUES (4, 1, '1,', '运营部', 30, b'1', '1', '1', '2020-05-15 12:03:46.542', '1', '2021-11-19 19:53:52.888', 3, '', '0', '0000');
INSERT INTO `sys_dept` VALUES (5, 1, '1,', 'AI部', 30, b'1', '1', '1', '2020-05-15 12:04:11.395', '1', '2021-11-19 19:53:52.890', 2, NULL, '0', '0000');
INSERT INTO `sys_dept` VALUES (6, -1, NULL, 'test', 1, b'0', '1', '1', '2020-05-15 12:05:05.919', '1', '2021-11-19 19:53:52.891', 1, NULL, '1', '0000');
INSERT INTO `sys_dept` VALUES (7, -1, NULL, '平台', 30, b'1', '1', '1', '2020-05-15 11:28:08.383', '1', '2021-11-19 19:53:52.892', 7, NULL, '0', '0000');
INSERT INTO `sys_dept` VALUES (8, 1, '1,', '测试部', 30, b'1', '1', '1', '2020-05-15 12:03:57.184', '1', '2021-11-19 19:53:52.893', 1, NULL, '0', '0000');
INSERT INTO `sys_dept` VALUES (44, 1, '1,', '开发部', 30, b'1', '1', '1', '2020-05-15 12:03:23.518', '1', '2021-11-19 19:53:52.894', 5, NULL, '0', '0000');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation` (
  `ancestor` bigint NOT NULL COMMENT '祖先节点',
  `descendant` bigint NOT NULL COMMENT '后代节点',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`ancestor`,`descendant`) USING BTREE,
  KEY `idx1` (`ancestor`) USING BTREE,
  KEY `idx2` (`descendant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='部门关系表';

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept_relation` VALUES (1, 1, '0', '0000');
INSERT INTO `sys_dept_relation` VALUES (1, 4, '0', '0000');
INSERT INTO `sys_dept_relation` VALUES (1, 5, '0', '0000');
INSERT INTO `sys_dept_relation` VALUES (1, 8, '0', '0000');
INSERT INTO `sys_dept_relation` VALUES (1, 44, '0', '0000');
INSERT INTO `sys_dept_relation` VALUES (4, 4, '0', '0000');
INSERT INTO `sys_dept_relation` VALUES (5, 5, '0', '0000');
INSERT INTO `sys_dept_relation` VALUES (7, 7, '0', '0000');
INSERT INTO `sys_dept_relation` VALUES (8, 8, '0', '0000');
INSERT INTO `sys_dept_relation` VALUES (44, 44, '0', '0000');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint NOT NULL COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名',
  `val` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据值',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `parent_id` bigint DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父菜单IDs',
  `sort` int NOT NULL COMMENT '排序（升序）',
  `available` bit(1) DEFAULT b'1' COMMENT '是否显示1 是0否',
  `leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  `version` int NOT NULL DEFAULT '0',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_value` (`val`) USING BTREE,
  KEY `sys_dict_label` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` VALUES (0, '所在机构及以下数据', 'THIS_LEVEL_CHILDREN', 'sys_data_scope_2', 199, '1,', 20, b'1', b'1', '1', '2019-07-14 05:53:55.000', '1', '2021-11-22 14:52:37.391', 10, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (1, '数据字典', '', 'base', -1, NULL, 1, b'1', b'0', '1', '2018-07-09 06:16:14.000', '1', '2021-12-08 11:07:00.622', 17, '', '1', '0000');
INSERT INTO `sys_dict` VALUES (2, '是否标识', '', 'sys_flag', 455, '1,', 10, b'1', b'0', '1', '2019-06-02 17:17:44.000', '1', '2021-11-22 14:49:12.709', 20, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (3, '是', '1', 'sys_flag_yes', 2, '1,', 10, b'1', b'1', '1', '2018-07-09 06:15:40.000', '1', '2021-11-22 14:49:12.709', 12, '', '0', '0000');
INSERT INTO `sys_dict` VALUES (4, '否', '0', 'sys_flag_no', 2, '1,', 30, b'1', b'1', '1', '2019-06-02 17:26:40.000', '1', '2021-11-22 14:49:12.709', 8, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (111, '编辑', 'EDIT', 'sys_business_type_edit', 4555, '1,', 20, b'1', b'1', '1', '2019-08-07 16:50:20.634', '1', '2021-11-22 14:52:56.329', 6, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (199, '数据范围', '', 'sys_data_scope', 455, '1,', 30, b'1', b'0', '1', '2019-07-14 05:50:08.000', '1', '2021-11-22 14:49:12.709', 20, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (222, '运行中', '1', 'quartz_job_status_1', 344, '1,', 10, b'1', b'1', '1', '2020-05-16 10:14:46.614', '1', '2021-11-25 16:40:23.140', 2, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (223, '导入', 'IMPORT', 'sys_business_type_import', 4555, '1,', 60, b'1', b'1', '1', '2019-08-07 16:51:45.855', '1', '2021-11-22 14:52:56.320', 5, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (233, '其他', 'OTHER', 'sys_business_type_other', 4555, '1,', 90, b'1', b'1', '1', '2020-05-17 13:45:33.764', '1', '2021-11-22 14:52:56.317', 1, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (333, '放弃执行', '3', 'quartz_misfire_policy_3', 445, '1,', 30, b'1', b'1', '1', '2019-08-15 10:24:54.175', '1', '2021-11-25 16:40:12.635', 4, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (334, '按明细设置', 'CUSTOMIZE', 'sys_data_scope_5', 199, '1,', 50, b'1', b'1', '1', '2019-07-14 06:01:11.000', '1', '2021-11-22 14:52:43.388', 9, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (344, '任务状态', NULL, 'quartz_job_status', 1, '1,', 30, b'1', b'0', '1', '2020-05-16 10:13:18.543', '1', '2021-11-25 16:40:31.975', 6, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (345, '失败', '0', 'sys_status_0', 1177, '1,', 30, b'1', b'1', '1', '2019-08-14 11:28:11.000', '1', '2021-11-22 14:51:06.891', 3, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (444, '所在机构数据', 'THIS_LEVEL', 'sys_data_scope_3', 199, '1,', 30, b'1', b'1', '1', '2019-07-14 05:59:13.000', '1', '2021-11-22 14:52:39.790', 10, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (445, '计划执行错误策略', NULL, 'quartz_misfire_policy', 1, '1,', 30, b'1', b'0', '1', '2019-08-15 10:23:54.460', '1', '2021-11-25 16:40:17.971', 11, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (455, '系统数据', 'sys', 'sys', -1, '1,', 30, b'1', b'0', '1', '2019-07-14 01:13:12.000', '1', '2021-11-22 14:49:12.709', 30, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (555, '系统', 'SYSTEM', 'quartz_job_group_system', 55345, '1,', 20, b'1', b'1', '1', '2019-08-15 16:34:47.139', '1', '2021-11-22 14:53:49.574', 5, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (666, '生成代码', 'GEN_CODE', 'sys_business_type_gen_code', 4555, '1,', 80, b'1', b'1', '1', '2019-08-07 16:52:36.997', '1', '2021-11-22 14:52:56.322', 6, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (777, '目录', '0', 'sys_menu_type_0', 66555, '1,', 10, b'1', b'1', '1', '2019-07-14 06:04:10.000', '1', '2021-11-22 14:52:05.625', 7, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (888, '操作人类别', NULL, 'sys_operator_type', 455, '1,', 30, b'1', b'0', '1', '2019-08-07 15:37:09.613', '1', '2021-11-22 14:49:12.709', 13, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (999, '后台用户', 'MANAGE', 'sys_operate_type_manage', 888, '1,', 20, b'1', b'1', '1', '2019-08-07 16:48:40.344', '1', '2021-11-22 14:51:23.856', 6, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (1122, '导出', 'EXPORT', 'sys_business_type_export', 4555, '1,', 50, b'1', b'1', '1', '2019-08-07 16:51:33.286', '1', '2021-11-22 14:52:56.328', 5, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (1133, '离线', 'OFFLINE', 'sys_online_status_off_line', 9967, '1,', 30, b'1', b'1', '1', '2019-08-11 11:17:50.132', '1', '2021-11-25 09:35:25.921', 3, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (1144, '删除', 'DELETE', 'sys_business_type_delete', 4555, '1,', 40, b'1', b'1', '1', '2019-08-07 16:50:45.270', '1', '2021-11-22 14:52:56.329', 5, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (1155, 'test', 'test', 'test', -1, NULL, 30, b'1', b'1', '1', '2019-07-14 03:59:38.000', '1', '2021-11-22 14:49:12.709', 0, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (1166, '默认', 'DEFAULT', 'quartz_job_group_default', 55345, '1,', 10, b'1', b'1', '1', '2019-08-15 16:34:28.547', '1', '2021-11-22 14:53:49.576', 5, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (1177, '状态', NULL, 'sys_status', 455, '1,', 30, b'1', b'0', '1', '2019-08-14 11:26:50.424', '1', '2021-11-22 14:49:12.709', 6, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (4447, '按钮', '2', 'sys_menu_type_2', 66555, '1,', 30, b'1', b'1', '1', '2019-08-07 13:55:24.531', '1', '2021-11-22 14:52:12.939', 8, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (4453, '强退', 'FORCE_LOGOUT', 'sys_business_type_force_logout', 4555, '1,', 70, b'1', b'1', '1', '2019-08-07 16:52:15.681', '1', '2021-11-22 14:52:56.327', 5, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (4534, '其他', 'OTHER', 'sys_operate_type_other', 888, '1,', 10, b'1', b'1', '1', '2019-08-07 16:48:21.644', '1', '2021-11-22 14:51:17.223', 6, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (4555, '业务操作类型', NULL, 'sys_business_type', 455, '1,', 30, b'1', b'0', '1', '2019-08-07 15:33:35.000', '1', '2021-11-22 14:49:12.709', 37, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (4564, '执行一次', '2', 'quartz_misfire_policy_2', 445, '1,', 20, b'1', b'1', '1', '2019-08-15 10:24:39.273', '1', '2021-11-25 16:39:53.801', 5, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (4623, '立即执行', '1', 'quartz_misfire_policy_1', 445, '1,', 10, b'1', b'1', '1', '2019-08-15 10:24:19.706', '1', '2021-11-25 16:39:47.020', 5, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (5555, '已暂停', '0', 'quartz_job_status_0', 344, '1,', 20, b'1', b'1', '1', '2020-05-16 10:15:08.604', '1', '2021-11-25 16:40:27.853', 2, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (6663, '锁定', 'LOCK', 'sys_business_type_lock', 4555, '1,', 30, b'1', b'1', '1', '2019-08-07 16:50:32.457', '1', '2021-11-22 14:52:56.319', 6, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (7654, '手机端用户', 'MOBILE', 'sys_operate_type_moblie', 888, '1,', 30, b'1', b'1', '1', '2019-08-07 16:49:00.766', '1', '2021-11-22 14:51:21.205', 6, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (9967, '在线状态', NULL, 'sys_online_status', 455, '1,', 30, b'1', b'0', '1', '2019-08-11 11:16:52.095', '1', '2021-11-25 09:35:36.574', 5, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (11888, '全部', 'ALL', 'sys_data_scope_1', 199, '1,', 10, b'1', b'1', '1', '2019-07-14 05:52:44.000', '1', '2021-11-22 14:52:35.489', 10, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (40654, '仅本人数据', 'SELF', 'sys_data_scope_4', 199, '1,', 40, b'1', b'1', '1', '2019-07-14 06:00:03.000', '1', '2021-11-22 14:52:41.740', 8, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (44223, '菜单', '1', 'sys_menu_type_1', 66555, '1,', 20, b'1', b'1', '1', '2019-07-14 06:04:44.000', '1', '2021-11-22 14:52:09.706', 7, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (55345, '任务分组', NULL, 'quartz_job_group', 455, '1,', 30, b'1', b'0', '1', '2019-08-15 16:33:54.745', '1', '2021-11-22 14:49:12.709', 10, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (55634, '在线', 'ONLINE', 'sys_online_status_on_line', 9967, '1,', 30, b'1', b'1', '1', '2019-08-11 11:17:28.210', '1', '2021-11-25 09:35:32.195', 3, NULL, '1', '0000');
INSERT INTO `sys_dict` VALUES (55734, '查看', 'VIEW', 'sys_business_type_view', 4555, '1,', 10, b'1', b'1', '1', '2019-08-07 16:49:39.000', '1', '2021-11-22 14:52:56.315', 8, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (64456, '登录', 'LOGIN', 'sys_business_type_login', 4555, '1,', 100, b'0', b'1', '1', '2020-05-27 11:41:37.787', '1', '2021-11-22 14:52:56.318', 1, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (65765, '业务数据', 'biz', 'biz', -1, '1,', 30, b'1', b'1', '1', '2019-07-14 04:01:51.000', '1', '2021-11-22 14:49:12.709', 6, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (66555, '菜单类型', '', 'sys_menu_type', 455, '1,', 30, b'1', b'0', '1', '2019-07-14 06:01:48.000', '1', '2021-11-22 14:49:12.709', 15, NULL, '0', '0000');
INSERT INTO `sys_dict` VALUES (74563, '正常', '1', 'sys_status_1', 1177, '1,', 30, b'1', b'1', '1', '2019-08-14 11:28:01.693', '1', '2021-11-22 14:51:09.036', 2, NULL, '0', '0000');
COMMIT;

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file` (
  `id` bigint NOT NULL COMMENT 'ID',
  `biz_type` varchar(255) NOT NULL DEFAULT '' COMMENT '业务类型',
  `file_type` varchar(255) DEFAULT NULL COMMENT '文件类型',
  `storage_type` varchar(255) DEFAULT NULL COMMENT '存储类型\nLOCAL FAST_DFS MIN_IO ALI \n',
  `bucket` varchar(255) DEFAULT '' COMMENT '桶',
  `path` varchar(255) DEFAULT '' COMMENT '文件相对地址',
  `url` varchar(255) DEFAULT NULL COMMENT '文件访问地址',
  `unique_file_name` varchar(255) DEFAULT '' COMMENT '唯一文件名',
  `file_md5` varchar(255) DEFAULT NULL COMMENT '文件md5',
  `original_file_name` varchar(255) DEFAULT '' COMMENT '原始文件名',
  `content_type` varchar(255) DEFAULT '' COMMENT '文件类型',
  `suffix` varchar(255) DEFAULT '' COMMENT '后缀',
  `size` bigint DEFAULT '0' COMMENT '大小',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  `created_by` bigint NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` bigint DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `version` int NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='增量文件上传日志';

-- ----------------------------
-- Records of sys_file
-- ----------------------------
BEGIN;
INSERT INTO `sys_file` VALUES (1467023162330841088, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/a5b549c113b94f849b412742723bd1b9.jpg', 'https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/a5b549c113b94f849b412742723bd1b9.jpg', 'a5b549c113b94f849b412742723bd1b9.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 14:49:12.511', 1, '2021-12-08 10:30:22.838', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467023384859639808, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/c904f1e9ea7549c6943535ddc52695a5.jpg', 'https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/c904f1e9ea7549c6943535ddc52695a5.jpg', 'c904f1e9ea7549c6943535ddc52695a5.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 14:50:05.583', 1, '2021-12-08 10:35:03.808', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467024571344355328, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/d3ee9280828b4f29b3a4ad2ae27de921.jpg', 'https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/d3ee9280828b4f29b3a4ad2ae27de921.jpg', 'd3ee9280828b4f29b3a4ad2ae27de921.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 14:54:48.462', 1, '2021-12-08 10:35:03.808', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467024702038867968, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/2f15a9e12b654e6da0d697747997036f.jpg', 'https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/2f15a9e12b654e6da0d697747997036f.jpg', '2f15a9e12b654e6da0d697747997036f.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 14:55:19.623', 1, '2021-12-08 10:35:03.808', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467024956737978368, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/11d4d77207a6470bbdc9a838b5e92634.jpg', 'https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/11d4d77207a6470bbdc9a838b5e92634.jpg', '11d4d77207a6470bbdc9a838b5e92634.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 14:56:20.348', 1, '2021-12-08 10:35:03.808', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467027979442847744, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/1202170e9efa4a32b587a501a03f79d6.jpg', 'https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/1202170e9efa4a32b587a501a03f79d6.jpg', '1202170e9efa4a32b587a501a03f79d6.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:08:21.011', 1, '2021-12-08 10:35:03.808', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467028392086863872, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/ae4a01d7c2aa46008980cb52d9d5fb77.jpg', 'https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/ae4a01d7c2aa46008980cb52d9d5fb77.jpg', 'ae4a01d7c2aa46008980cb52d9d5fb77.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:09:59.391', 1, '2021-12-08 10:35:03.808', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467029366637592576, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/a13e42026b014bf5940548da97d21a8e.jpg', 'https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/a13e42026b014bf5940548da97d21a8e.jpg', 'a13e42026b014bf5940548da97d21a8e.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:13:51.747', 1, '2021-12-08 10:35:03.808', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467033048376672256, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/ac22b263cddf4dadb0886d579602f8fc.jpg', 'https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/ac22b263cddf4dadb0886d579602f8fc.jpg', 'ac22b263cddf4dadb0886d579602f8fc.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:28:29.541', 1, '2021-12-08 10:30:26.026', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467034144696434688, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/139e2822c6cb4635b333af4e2f3f1fff.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/139e2822c6cb4635b333af4e2f3f1fff.jpg', '139e2822c6cb4635b333af4e2f3f1fff.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:32:50.912', 1, '2021-12-08 10:35:00.362', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467034290523996160, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/d685c34ab657404aa1f562fb5e25ba4a.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/d685c34ab657404aa1f562fb5e25ba4a.jpg', 'd685c34ab657404aa1f562fb5e25ba4a.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:33:25.696', 1, '2021-12-08 10:34:58.515', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467034373625741312, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/8c1aef8043d0495ba73929239e96d3de.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/8c1aef8043d0495ba73929239e96d3de.jpg', '8c1aef8043d0495ba73929239e96d3de.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:33:45.510', 1, '2021-12-08 10:34:55.786', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467034699288281088, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/4f8c39bcacb74ff0a0a15a465b562a31.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/4f8c39bcacb74ff0a0a15a465b562a31.jpg', '4f8c39bcacb74ff0a0a15a465b562a31.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:35:03.154', 1, '2021-12-08 10:35:03.808', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467035096501452800, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/7f1b6dbcce2d4830a6ed5a09a5367a96.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/7f1b6dbcce2d4830a6ed5a09a5367a96.jpg', '7f1b6dbcce2d4830a6ed5a09a5367a96.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:36:37.856', 1, '2021-12-08 10:35:03.808', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467035309022642176, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/125725a79c9c433d9a78b68e472edb54.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/125725a79c9c433d9a78b68e472edb54.jpg', '125725a79c9c433d9a78b68e472edb54.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:37:28.526', 1, '2021-12-08 10:35:03.808', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467035384608194560, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/252822ef2f7b42ef9b2fe7856b1b4af1.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/252822ef2f7b42ef9b2fe7856b1b4af1.jpg', '252822ef2f7b42ef9b2fe7856b1b4af1.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:37:46.547', 1, '2021-12-08 11:26:55.356', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467035692767903744, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/756e5d2cce154afc85dccd953d9f71ed.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/756e5d2cce154afc85dccd953d9f71ed.jpg', '756e5d2cce154afc85dccd953d9f71ed.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:39:00.013', 1, '2021-12-08 11:26:55.356', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467035880945352704, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/8651019de0b546e8bea62d78545ab0dc.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/8651019de0b546e8bea62d78545ab0dc.jpg', '8651019de0b546e8bea62d78545ab0dc.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:39:44.882', 1, '2021-12-08 11:26:55.356', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467036516415963136, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/a83b05ddeda14db3a80eac1a017ab0e5.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/a83b05ddeda14db3a80eac1a017ab0e5.jpg', 'a83b05ddeda14db3a80eac1a017ab0e5.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:42:16.391', 1, '2021-12-08 11:26:52.882', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467036966729023488, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/370dd47b2f1942ffb26a81b30f92fdd8.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/370dd47b2f1942ffb26a81b30f92fdd8.jpg', '370dd47b2f1942ffb26a81b30f92fdd8.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:44:03.752', 1, '2021-12-08 11:26:52.882', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467037132164956160, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/9c7e6aa57824469196b2cd5fc11ed4b8.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/9c7e6aa57824469196b2cd5fc11ed4b8.jpg', '9c7e6aa57824469196b2cd5fc11ed4b8.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:44:43.197', 1, '2021-12-08 11:26:52.882', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467037699943694336, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/87d2d42bc8ed44758cfa3340efad27c2.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/87d2d42bc8ed44758cfa3340efad27c2.jpg', '87d2d42bc8ed44758cfa3340efad27c2.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:46:58.565', 1, '2021-12-08 11:26:52.882', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467039487262457856, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/97e69d2762be4a24aff43085894b3505.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/97e69d2762be4a24aff43085894b3505.jpg', '97e69d2762be4a24aff43085894b3505.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 15:54:04.695', 1, '2021-12-08 11:26:52.882', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1467044287936987136, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/04/946d98eb4c0b4b6da1eccc1b648f023d.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/946d98eb4c0b4b6da1eccc1b648f023d.jpg', '946d98eb4c0b4b6da1eccc1b648f023d.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-04 16:13:09.254', 1, '2021-12-08 11:26:52.882', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1468419790770012160, 'BASE_FILE', 'DOC', 'LOCAL', 'dev', '0000/BASE_FILE/2021/12/08/1ec3372296b24002bae2542cb02ab7dd.txt', 'http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/1ec3372296b24002bae2542cb02ab7dd.txt', '1ec3372296b24002bae2542cb02ab7dd.txt', NULL, '200个免费节点.txt', 'text/plain', 'txt', 121456, '0000', 1, '2021-12-08 11:18:54.691', 1, '2021-12-08 11:26:52.882', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1468420594188943360, 'BASE_FILE', 'DOC', 'LOCAL', 'dev', '0000/BASE_FILE/2021/12/08/dd32fe8cf00b4509a79d37ec865d89cf.txt', 'http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/dd32fe8cf00b4509a79d37ec865d89cf.txt', 'dd32fe8cf00b4509a79d37ec865d89cf.txt', NULL, '200个免费节点.txt', 'text/plain', 'txt', 121456, '0000', 1, '2021-12-08 11:22:06.246', 1, '2021-12-08 11:26:52.882', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1468421198781087744, 'BASE_FILE', 'DOC', 'LOCAL', 'dev', '0000/BASE_FILE/2021/12/08/f316089dbe3e42b7a629be446c1c7238.txt', 'http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/f316089dbe3e42b7a629be446c1c7238.txt', 'f316089dbe3e42b7a629be446c1c7238.txt', NULL, '200个免费节点.txt', 'text/plain', 'txt', 121456, '0000', 1, '2021-12-08 11:24:30.388', 1, '2021-12-08 11:26:52.882', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1468421746632687616, 'BASE_FILE', 'DOC', 'LOCAL', 'dev', '0000/BASE_FILE/2021/12/08/f02fba0a4d6f47b285606311e6a059a2.txt', 'http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/f02fba0a4d6f47b285606311e6a059a2.txt', 'f02fba0a4d6f47b285606311e6a059a2.txt', NULL, '200个免费节点.txt', 'text/plain', 'txt', 121456, '0000', 1, '2021-12-08 11:26:41.010', 1, '2021-12-08 11:26:52.882', NULL, 0, '1');
INSERT INTO `sys_file` VALUES (1468421845593096192, 'BASE_FILE', 'DOC', 'LOCAL', 'dev', '0000/BASE_FILE/2021/12/08/7d697a6b334b463db51a630ffe741573.txt', 'http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/7d697a6b334b463db51a630ffe741573.txt', '7d697a6b334b463db51a630ffe741573.txt', NULL, '200个免费节点.txt', 'text/plain', 'txt', 121456, '0000', 1, '2021-12-08 11:27:04.604', 1, '2021-12-08 11:27:04.605', NULL, 0, '0');
INSERT INTO `sys_file` VALUES (1468421845609873408, 'BASE_FILE', 'IMAGE', 'LOCAL', 'dev', '0000/BASE_FILE/2021/12/08/0a63a34fd90543a88cf43ee4b3626723.jpg', 'http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/0a63a34fd90543a88cf43ee4b3626723.jpg', '0a63a34fd90543a88cf43ee4b3626723.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-08 11:27:04.608', 1, '2021-12-08 11:27:04.609', NULL, 0, '0');
INSERT INTO `sys_file` VALUES (1469157645930725376, 'USER_AVATAR', 'IMAGE', 'LOCAL', 'dev', '0000/USER_AVATAR/2021/12/10/d1b42710b67f4e80a710a687fd4d8412.jpg', 'http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/10/d1b42710b67f4e80a710a687fd4d8412.jpg', 'd1b42710b67f4e80a710a687fd4d8412.jpg', NULL, '31921638496726_.pic.jpg', 'image/jpeg', 'jpg', 816277, '0000', 1, '2021-12-10 12:10:53.062', 1, '2021-12-10 12:10:53.075', NULL, 0, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '是否并发执行（1允许 0禁止）',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '报警邮箱',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态(1-运行中，0-暂停)',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` datetime(3) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `version` int NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'simpleTask.doNoParams', '0/10 * * * * ?', 'FIRE_PROCEED', '1', NULL, 'PAUSE', '0', '2019-08-14 10:21:36.000', '1', '2021-11-25 16:42:40.669', NULL, 12, '0', '0000');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '0/15 * * * * ?', 'FIRE_PROCEED', '1', NULL, 'PAUSE', '0', '2019-08-14 10:21:36.950', '1', '2021-11-25 16:42:40.677', NULL, 22, '0', '0000');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'simpleTask.doMultipleParams(\'albedo\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', 'FIRE_PROCEED', '1', NULL, 'PAUSE', '', '2019-08-14 10:21:36.000', '1', '2021-11-25 16:42:40.679', NULL, 4, '0', '0000');
INSERT INTO `sys_job` VALUES (4, 'test', 'DEFAULT', 'test', '0/20 * * * * ?', 'FIRE_PROCEED', '1', NULL, 'PAUSE', '1', '2020-05-16 15:06:05.098', '1', '2021-11-25 16:42:40.699', NULL, 1, '1', '0000');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'cron执行表达式',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `start_time` datetime(3) DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(3) DEFAULT NULL COMMENT '结束时间',
  `create_time` datetime(3) DEFAULT NULL COMMENT '创建时间',
  `exception_info` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '异常信息',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_log_login
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_login`;
CREATE TABLE `sys_log_login` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '日志标题',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录人昵称',
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'IP地址',
  `ip_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求URI',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '操作提交的数据',
  `login_date` char(10) DEFAULT NULL COMMENT '登录时间',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  `created_by` bigint DEFAULT NULL COMMENT '创建者',
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_log_create_by` (`created_by`) USING BTREE,
  KEY `sys_log_request_uri` (`request_uri`) USING BTREE,
  KEY `sys_log_create_date` (`created_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1558 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='登录日志表';

-- ----------------------------
-- Records of sys_log_login
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_log_operate
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_operate`;
CREATE TABLE `sys_log_operate` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '日志标题',
  `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '日志类型',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `service_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '服务ID',
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'IP地址',
  `ip_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求URI',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求方法',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '操作提交的数据',
  `time` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '执行时间',
  `operator_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  `business_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `exception` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '异常信息',
  `created_by` bigint DEFAULT NULL COMMENT '创建者',
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_log_create_by` (`created_by`) USING BTREE,
  KEY `sys_log_request_uri` (`request_uri`) USING BTREE,
  KEY `sys_log_create_date` (`created_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2105 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='操作日志表';

-- ----------------------------
-- Records of sys_log_operate
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` bigint NOT NULL COMMENT '菜单ID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单类型 （0目录 1菜单 2按钮）',
  `permission` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '前端URL',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父菜单IDs',
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标',
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'VUE页面',
  `hidden` bit(1) DEFAULT b'0' COMMENT '隐藏',
  `iframe` bit(1) DEFAULT b'0' COMMENT '是否外链',
  `cache_` bit(1) DEFAULT b'0' COMMENT '缓存',
  `leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `sort` int DEFAULT '1' COMMENT '排序值',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `version` int NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES (330, '生成方案编辑', '2', 'gen_scheme_edit', NULL, '9999', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:29:14.000', '1', '2021-11-22 15:20:28.451', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (334, '服务监控', '1', 'sys_monitor_view', 'server', '2000', '2000,', 'codeConsole', 'monitor/server/index', b'0', b'0', b'0', b'1', 40, '1', '2019-08-05 17:21:10.000', '1', '2021-11-19 18:29:35.734', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (335, '生成方案查看', '2', 'gen_scheme_view', NULL, '9999', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:48:09.000', '1', '2021-11-22 15:20:28.453', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (336, '操作日志查看', '2', 'sys_logOperate_view', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:51:38.454', '1', '2021-11-19 18:29:35.736', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (337, '数据源编辑', '2', 'gen_datasourceConf_edit', NULL, '8877', '', NULL, NULL, b'0', b'0', b'0', b'1', 40, '1', '2020-09-20 09:11:12.778', '1', '2021-11-22 15:30:14.383', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (338, '组件管理', '0', NULL, '/components', '-1', NULL, 'zujian', 'Layout', b'0', b'0', b'0', b'0', 80, '1', '2020-05-15 20:57:28.521', '1', '2021-11-19 18:29:35.739', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (339, '生成方案代码', '2', 'gen_scheme_code', NULL, '9999', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:55:37.000', '1', '2021-11-22 15:20:28.443', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (440, '三级菜单2', '1', NULL, 'menu1-2', '9000', '', 'dev', 'nested/menu1/menu1-2', b'0', b'0', b'0', b'1', 30, '1', '2020-05-18 11:13:18.819', '1', '2021-11-22 15:34:11.433', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (445, '业务表删除', '2', 'gen_table_del', NULL, '7000', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:24:45.000', '1', '2021-11-22 15:20:53.409', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (446, '多级菜单', '0', NULL, '/nested', '-1', NULL, 'dev', 'Layout', b'0', b'0', b'0', b'0', 100, '1', '2020-05-18 11:09:23.393', '1', '2021-11-19 18:29:35.745', NULL, 9, '0', '0000');
INSERT INTO `sys_menu` VALUES (447, '系统工具', '0', NULL, '/admin', '-1', NULL, 'sys-tools', 'Layout', b'0', b'0', b'0', b'0', 30, '1', '2019-08-05 15:58:12.000', '1', '2021-11-19 18:29:35.750', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (448, '在线用户强退', '2', 'sys_userOnline_logout', NULL, '7766', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 10:57:51.502', '1', '2021-11-22 15:21:25.665', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (449, '数据源查看', '2', 'gen_datasourceConf_view', NULL, '8877', '', NULL, NULL, b'0', b'0', b'0', b'1', 20, '1', '2020-09-20 09:11:12.771', '1', '2021-11-22 15:30:14.384', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1000, '系统管理', '0', NULL, '/perm', '-1', NULL, 'menu', 'Layout', b'0', b'0', b'0', b'0', 10, '1', '2018-09-28 08:29:53.000', '1', '2021-11-19 18:29:35.762', NULL, 3, '0', '0000');
INSERT INTO `sys_menu` VALUES (1100, '用户管理', '1', 'sys_user_view', 'user', '1000', '1000,', 'peoples', 'sys/user/index', b'0', b'0', b'0', b'0', 10, '1', '2017-11-02 22:24:37.000', '1', '2021-11-19 18:29:35.763', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1101, '用户编辑', '2', 'sys_user_edit', NULL, '1100', '1000,1100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2017-11-08 09:52:09.000', '1', '2021-11-19 18:29:35.763', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1102, '用户锁定', '2', 'sys_user_lock', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2017-11-08 09:52:48.000', NULL, '2021-11-19 18:29:35.764', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1103, '用户删除', '2', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2017-11-08 09:54:01.000', NULL, '2021-11-19 18:29:35.765', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1166, '富文本', '1', NULL, 'editor', '338', '', 'fwb', 'components/Editor', b'0', b'0', b'0', b'1', 30, '1', '2020-05-15 21:16:40.552', '1', '2021-11-22 15:33:24.892', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1200, '菜单管理', '1', 'sys_menu_view', 'menu', '1000', '1000,', 'menu', 'sys/menu/index', b'0', b'0', b'0', b'0', 40, '1', '2017-11-08 09:57:27.000', '1', '2021-11-19 18:29:35.767', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1201, '菜单编辑', '2', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2017-11-08 10:15:53.000', NULL, '2021-11-19 18:29:35.768', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1202, '菜单锁定', '2', 'sys_menu_lock', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2017-11-08 10:16:23.000', NULL, '2021-11-19 18:29:35.769', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1203, '菜单删除', '2', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2017-11-08 10:16:43.000', NULL, '2021-11-19 18:29:35.770', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1300, '角色管理', '1', 'sys_role_view', 'role', '1000', '1000,', 'role', 'sys/role/index', b'0', b'0', b'0', b'0', 20, '1', '2017-11-08 10:13:37.000', '1', '2021-11-19 18:29:35.771', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1301, '角色编辑', '2', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2017-11-08 10:14:18.000', NULL, '2021-11-19 18:29:35.772', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1302, '角色锁定', '2', 'sys_role_lock', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2017-11-08 10:14:41.000', NULL, '2021-11-19 18:29:35.773', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1303, '角色删除', '2', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2017-11-08 10:14:59.000', NULL, '2021-11-19 18:29:35.774', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1400, '部门管理', '1', 'sys_dept_view', 'dept', '1000', '1000,', 'dept', 'sys/dept/index', b'0', b'0', b'0', b'0', 30, '1', '2018-01-20 13:17:19.000', '1', '2021-11-19 18:29:35.775', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1401, '部门编辑', '2', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2018-01-20 14:56:16.000', NULL, '2021-11-19 18:29:35.776', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1402, '部门锁定', '2', 'sys_dept_lock', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2018-01-20 14:56:59.000', NULL, '2021-11-19 18:29:35.778', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1403, '部门删除', '2', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2018-01-20 14:57:28.000', NULL, '2021-11-19 18:29:35.779', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (2000, '系统监控', '0', NULL, '/sys', '-1', NULL, 'system', 'Layout', b'0', b'0', b'0', b'0', 20, '1', '2017-11-07 20:56:00.000', '1', '2021-11-19 18:29:35.780', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (2100, '操作日志', '1', NULL, 'log-operate', '2000', '2000,', 'log', 'monitor/log-operate/index', b'0', b'0', b'0', b'0', 60, '1', '2017-11-20 14:06:22.000', '1', '2021-11-19 18:29:35.781', NULL, 1, '0', '0000');
INSERT INTO `sys_menu` VALUES (2101, '操作日志删除', '2', 'sys_logOperate_del', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2017-11-20 20:37:37.000', '1', '2021-11-19 18:29:35.782', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (2200, '字典管理', '1', 'sys_dict_view', 'dict', '1000', '1000,', 'dictionary', 'sys/dict/index', b'0', b'0', b'0', b'0', 50, '1', '2017-11-29 11:30:52.000', '1', '2021-11-19 18:29:35.784', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (2201, '字典删除', '2', 'sys_dict_del', NULL, '2200', '1000,2200,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2017-11-29 11:30:11.000', '1', '2021-11-19 18:29:35.785', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (2202, '字典编辑', '2', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '1', '2018-05-11 22:34:55.000', '1', '2021-11-19 18:29:35.786', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (2500, '接口文档', '1', NULL, 'swagger2', '447', '', 'swagger', 'tool/swagger/index', b'0', b'0', b'0', b'1', 20, '1', '2018-06-26 10:50:32.000', '1', '2021-11-22 15:31:37.510', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (2600, '令牌管理', '1', NULL, 'persistent-token', '2000', '2000,', 'dev', 'monitor/persistent-token/index', b'0', b'0', b'0', b'0', 20, '1', '2018-09-04 05:58:41.000', '1', '2021-11-19 18:29:35.788', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (2601, '令牌删除', '2', 'sys_persistentToken_del', NULL, '2600', '', NULL, NULL, b'0', b'0', b'0', b'1', 1, '1', '2018-09-04 05:59:50.000', '1', '2021-11-19 18:29:35.789', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (3333, '在线用户查看', '2', 'sys_userOnline_view', NULL, '7766', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 09:05:28.000', '1', '2021-11-22 15:21:25.667', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (4422, '任务调度执行', '2', 'quartz_job_run', NULL, '6655', '', NULL, NULL, b'0', b'0', b'0', b'1', 20, '1', '2019-08-15 16:10:59.000', '1', '2021-11-22 15:21:18.495', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (4433, '支付宝工具', '1', NULL, 'alipay', '447', '', 'alipay', 'tool/alipay/index', b'0', b'0', b'0', b'1', 40, '1', '2020-05-17 17:58:06.876', '1', '2021-11-22 15:31:26.775', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (4444, '邮件工具', '1', NULL, 'email', '447', '', 'email', 'tool/email/index', b'0', b'0', b'0', b'1', 30, '1', '2020-05-17 17:56:56.008', '1', '2021-11-22 15:31:26.773', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (4455, '任务调度查看', '2', 'quartz_job_view', NULL, '6655', '', NULL, NULL, b'0', b'0', b'0', b'1', 10, '1', '2019-08-14 10:36:47.085', '1', '2021-11-22 15:21:18.496', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (5544, '任务调度日志', '2', 'quartz_jobLog_view', NULL, '6655', '', NULL, NULL, b'0', b'0', b'0', b'1', 50, '1', '2019-08-15 16:11:30.986', '1', '2021-11-22 15:21:18.491', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (5555, '操作日志导出', '2', 'sys_logOperate_export', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:50:46.973', '1', '2021-11-19 18:29:35.796', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (5566, '数据源删除', '2', 'gen_datasourceConf_del', NULL, '8877', '', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2020-09-20 09:11:12.784', '1', '2021-11-22 15:30:14.380', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (5588, '令牌查看', '2', 'sys_persistentToken_view', NULL, '2600', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-08 09:44:25.617', '1', '2021-11-19 18:29:35.798', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (6000, '图表库', '1', NULL, 'Echarts', '338', '', 'chart', 'components/Echarts', b'0', b'0', b'0', b'1', 20, '1', '2020-05-15 21:12:39.827', '1', '2021-11-22 15:33:36.828', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (6655, '任务调度', '1', NULL, 'job', '1000', '1000,', 'timing', 'quartz/job/index', b'0', b'0', b'0', b'0', 60, '1', '2019-08-14 10:36:47.081', '1', '2021-11-19 18:29:35.799', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (6666, '字典可用', '2', 'sys_dict_lock', NULL, '2200', '1000,2200,', NULL, NULL, b'0', NULL, b'0', b'1', 999, '1', '2020-05-15 17:24:57.559', '1', '2021-11-19 18:29:35.801', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (6677, '代码生成', '0', NULL, '/gen', '447', '', 'codeConsole', 'gen/index', b'0', b'0', b'0', b'0', 10, '1', '2019-07-20 12:00:48.000', '1', '2021-11-22 15:32:02.221', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (7000, '业务表', '1', '', 'table', '6677', '', 'list', 'gen/table/index', b'0', b'0', b'0', b'0', 10, '1', '2019-07-20 12:02:02.000', '1', '2021-11-22 15:32:49.229', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (7700, '业务表编辑', '1', 'gen_table_edit', 'edit', '6677', '', NULL, 'gen/table/edit', b'1', b'0', b'0', b'1', 20, '1', '2019-07-21 13:24:02.000', '1', '2021-11-22 15:20:53.411', NULL, 1, '0', '0000');
INSERT INTO `sys_menu` VALUES (7766, '在线用户', '1', '', 'user-online', '2000', '2000,', 'Steve-Jobs', 'monitor/user-online/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-07 09:03:52.000', '1', '2021-11-19 18:29:35.805', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (7777, '任务调度删除', '2', 'quartz_job_del', NULL, '6655', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-14 10:36:47.091', '1', '2021-11-22 15:21:18.493', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (7788, '生成方案菜单', '2', 'gen_scheme_menu', NULL, '9999', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-25 13:03:03.000', '1', '2021-11-22 15:20:28.452', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (7799, '任务调度编辑', '2', 'quartz_job_edit', NULL, '6655', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-14 10:36:47.088', '1', '2021-11-22 15:21:18.494', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (8855, 'Markdown', '1', NULL, 'markdown', '338', '', 'markdown', 'components/MarkDown', b'0', b'0', b'0', b'1', 40, '1', '2020-05-15 21:21:46.675', '1', '2021-11-22 15:33:22.311', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (8877, '数据源', '1', NULL, 'datasource-conf', '6677', '', 'database', 'gen/datasource-conf/index', b'0', b'0', b'0', b'0', 5, '1', '2020-09-20 09:11:12.765', '1', '2021-11-22 15:33:20.945', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (8888, '二级菜单1', '1', NULL, 'menu1', '446', '', 'dev', 'nested/menu1/index', b'0', b'0', b'0', b'0', 10, '1', '2020-05-18 11:10:06.354', '1', '2021-11-22 15:33:58.182', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (8899, 'Yaml编辑器', '1', NULL, 'yaml', '338', '', 'dev', 'components/YamlEdit', b'0', b'0', b'0', b'1', 50, '1', '2020-05-15 21:22:43.364', '1', '2021-11-22 15:33:14.776', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (9000, '二级菜单2', '1', NULL, 'menu2', '446', '', 'dev', 'nested/menu2/index', b'0', b'0', b'0', b'1', 30, '1', '2020-05-18 11:14:32.907', '1', '2021-11-22 15:34:07.276', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (9900, '三级菜单1', '1', NULL, 'menu1-1', '9000', '', 'dev', 'nested/menu1/menu1-1', b'0', b'0', b'0', b'1', 30, '1', '2020-05-18 11:11:16.436', '1', '2021-11-22 15:34:09.295', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (9911, '生成方案删除', '2', 'gen_scheme_del', NULL, '9999', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:30:18.000', '1', '2021-11-22 15:20:28.449', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (9922, '任务调度日志导出', '2', 'quartz_jobLog_export', NULL, '6655', '', NULL, NULL, b'0', b'0', b'0', b'1', 60, '1', '2019-08-15 16:13:16.742', '1', '2021-11-22 15:21:18.489', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (9944, '业务表查看', '2', 'gen_table_view', NULL, '7000', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:47:39.828', '1', '2021-11-22 15:20:53.413', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (9955, '用户导出', '2', 'sys_user_export', NULL, '1100', '1000,1100,', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2019-08-07 17:50:02.000', '1', '2021-11-19 18:29:35.817', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (9977, '在线用户删除', '2', 'sys_userOnline_del', NULL, '7766', '', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 09:06:33.448', '1', '2021-11-22 15:21:25.663', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (9988, '图标库', '1', NULL, 'icons', '338', '', 'icon', 'components/icons/index', b'0', b'0', b'0', b'1', 10, '1', '2020-05-15 21:14:28.945', '1', '2021-11-22 15:33:12.130', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (9999, '生成方案', '1', NULL, 'scheme', '6677', '', 'dev', 'gen/scheme/index', b'0', b'0', b'0', b'0', 30, '1', '2019-07-21 13:27:35.000', '1', '2021-11-22 15:33:01.113', NULL, 2, '0', '0000');
INSERT INTO `sys_menu` VALUES (1465206065929912320, '测试书籍', '1', NULL, 'test-book', '446', NULL, 'icon-right-square', 'test/test-book/index', b'0', b'0', b'0', b'0', 30, '1', '2021-11-29 14:28:42.987', '1', '2021-11-29 16:08:16.747', NULL, 0, '1', '0000');
INSERT INTO `sys_menu` VALUES (1465206065955078144, '测试书籍查看', '2', 'test_testBook_view', NULL, '1465206065929912320', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2021-11-29 14:28:42.993', '1', '2021-11-29 16:07:58.721', NULL, 0, '1', '0000');
INSERT INTO `sys_menu` VALUES (1465206065976049664, '测试书籍编辑', '2', 'test_testBook_edit', NULL, '1465206065929912320', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2021-11-29 14:28:42.998', '1', '2021-11-29 16:07:58.755', NULL, 0, '1', '0000');
INSERT INTO `sys_menu` VALUES (1465206065988632576, '测试书籍删除', '2', 'test_testBook_del', NULL, '1465206065929912320', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2021-11-29 14:28:43.001', '1', '2021-11-29 16:07:58.786', NULL, 0, '1', '0000');
INSERT INTO `sys_menu` VALUES (1465216162739519488, '测试树书籍', '1', NULL, 'test-tree-book', '446', NULL, 'icon-right-square', 'test/test-tree-book/index', b'0', b'0', b'0', b'0', 30, '1', '2021-11-29 15:08:50.254', '1', '2021-11-29 16:08:16.787', NULL, 0, '1', '0000');
INSERT INTO `sys_menu` VALUES (1465216162764685312, '测试树书籍查看', '2', 'test_testTreeBook_view', NULL, '1465216162739519488', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2021-11-29 15:08:50.259', '1', '2021-11-29 16:08:09.917', NULL, 0, '1', '0000');
INSERT INTO `sys_menu` VALUES (1465216162777268224, '测试树书籍编辑', '2', 'test_testTreeBook_edit', NULL, '1465216162739519488', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2021-11-29 15:08:50.263', '1', '2021-11-29 16:08:09.955', NULL, 0, '1', '0000');
INSERT INTO `sys_menu` VALUES (1465216162798239744, '测试树书籍删除', '2', 'test_testTreeBook_del', NULL, '1465216162739519488', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2021-11-29 15:08:50.268', '1', '2021-11-29 16:08:09.982', NULL, 0, '1', '0000');
INSERT INTO `sys_menu` VALUES (1465502605210812416, '登录日志', '1', NULL, 'log-login', '2000', NULL, 'log', 'monitor/log-login/index', b'0', b'0', b'0', b'0', 50, '1', '2021-11-30 10:07:03.460', '1', '2021-11-30 10:07:03.460', NULL, 3, '0', '0000');
INSERT INTO `sys_menu` VALUES (1465502605244366848, '登录日志查看', '2', 'sys_logLogin_view', NULL, '1465502605210812416', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2021-11-30 10:07:03.469', '1', '2021-11-30 10:07:03.469', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1465502605277921280, '登录日志导出', '2', 'sys_logLogin_export', NULL, '1465502605210812416', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2021-11-30 10:07:03.477', '1', '2021-11-30 10:07:03.477', NULL, 1, '0', '0000');
INSERT INTO `sys_menu` VALUES (1465502605307281408, '登录日志删除', '2', 'sys_logLogin_del', NULL, '1465502605210812416', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2021-11-30 10:07:03.484', '1', '2021-11-30 10:07:03.484', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1468397111971151872, '附件管理', '1', NULL, 'appendix', '1000', NULL, 'documentation', 'sys/appendix/index', b'0', b'0', b'0', b'0', 70, '1', '2021-12-08 09:48:47.649', '1', '2021-12-08 10:16:13.265', NULL, 2, '1', '0000');
INSERT INTO `sys_menu` VALUES (1468397112000512000, '附件管理查看', '2', 'sys_appendix_view', NULL, '1468397111971151872', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2021-12-08 09:48:47.657', '1', '2021-12-08 10:16:04.092', NULL, 0, '1', '0000');
INSERT INTO `sys_menu` VALUES (1468397112017289216, '附件管理添加', '2', 'sys_appendix_add', NULL, '1468397111971151872', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2021-12-08 09:48:47.661', '1', '2021-12-08 10:08:45.340', NULL, 1, '1', '0000');
INSERT INTO `sys_menu` VALUES (1468397112029872128, '附件管理删除', '2', 'sys_appendix_del', NULL, '1468397111971151872', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2021-12-08 09:48:47.664', '1', '2021-12-08 10:16:08.248', NULL, 0, '1', '0000');
INSERT INTO `sys_menu` VALUES (1468405431398301696, '文件管理', '1', NULL, 'file', '1000', NULL, 'app', 'sys/file/index', b'0', b'0', b'0', b'0', 70, '1', '2021-12-08 10:21:51.156', '1', '2021-12-08 10:21:51.156', NULL, 1, '0', '0000');
INSERT INTO `sys_menu` VALUES (1468405431419273216, '文件管理查看', '2', 'sys_file_view', NULL, '1468405431398301696', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2021-12-08 10:21:51.161', '1', '2021-12-08 10:21:51.161', NULL, 0, '0', '0000');
INSERT INTO `sys_menu` VALUES (1468405431440244736, '文件管理编辑', '2', 'sys_file_add', NULL, '1468405431398301696', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2021-12-08 10:21:51.166', '1', '2021-12-08 11:05:18.826', NULL, 1, '0', '0000');
INSERT INTO `sys_menu` VALUES (1468405431457021952, '文件管理删除', '2', 'sys_file_del', NULL, '1468405431398301696', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2021-12-08 10:21:51.169', '1', '2021-12-08 10:21:51.170', NULL, 0, '0', '0000');
COMMIT;

-- ----------------------------
-- Table structure for sys_parameter
-- ----------------------------
DROP TABLE IF EXISTS `sys_parameter`;
CREATE TABLE `sys_parameter` (
  `id` bigint NOT NULL COMMENT 'ID',
  `key_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '参数键',
  `value` varchar(255) NOT NULL COMMENT '参数值',
  `name` varchar(255) NOT NULL COMMENT '参数名称',
  `state` bit(1) DEFAULT b'1' COMMENT '状态',
  `readonly_` bit(1) DEFAULT b'0' COMMENT '内置',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  `created_by` bigint NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` bigint DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `version` int NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_key` (`tenant_code`,`key_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数配置';

-- ----------------------------
-- Records of sys_parameter
-- ----------------------------
BEGIN;
INSERT INTO `sys_parameter` VALUES (1, 'LoginPolicy', 'MANY', '登录策略', b'1', b'1', '0000', 0, '2021-10-27 13:51:01.785', NULL, NULL, NULL, 0, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_persistent_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_persistent_token`;
CREATE TABLE `sys_persistent_token` (
  `series` varchar(76) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `token_value` varchar(76) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token_date` timestamp(3) NULL DEFAULT NULL,
  `ip_address` varchar(39) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`series`) USING BTREE,
  KEY `fk_user_persistent_token` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_persistent_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '编码',
  `level` int DEFAULT NULL COMMENT '角色级别',
  `data_scope` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据权限 1全部 2所在机构及以下数据  3 所在机构数据  4仅本人数据 5 按明细设置',
  `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '1-正常，0-锁定',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `version` int NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES (1, '超级管理员', NULL, 1, 'ALL', '1', '', '2017-10-29 15:45:51.000', '1', '2021-11-19 18:29:00.367', NULL, 75, '0', '0000');
INSERT INTO `sys_role` VALUES (2, '机构管理员', NULL, 2, 'CUSTOMIZE', '1', '', '2018-11-11 19:42:26.000', '1', '2021-11-19 18:29:00.370', NULL, 19, '0', '0000');
INSERT INTO `sys_role` VALUES (3, 'tets', NULL, 3, 'SELF', '1', '1', '2020-05-14 11:21:30.869', '1', '2021-11-19 18:29:00.371', NULL, 0, '1', '0000');
INSERT INTO `sys_role` VALUES (4, '部门管理员', NULL, 3, 'THIS_LEVEL_CHILDREN', '1', '1', '2020-05-14 11:02:13.389', '1', '2021-11-19 18:29:00.372', NULL, 3, '1', '0000');
INSERT INTO `sys_role` VALUES (5, '普通管理员', NULL, 4, 'CUSTOMIZE', '1', '1', '2020-05-14 11:00:50.813', '1', '2021-11-19 18:29:00.374', '普通管理', 6, '0', '0000');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `id` bigint NOT NULL,
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='角色与部门对应关系';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept` VALUES (1, 1, 8, '0000');
INSERT INTO `sys_role_dept` VALUES (2, 2, 5, '0000');
INSERT INTO `sys_role_dept` VALUES (3, 2, 4, '0000');
INSERT INTO `sys_role_dept` VALUES (4, 2, 3, '0000');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='角色菜单表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` VALUES (1, 330, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 334, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 335, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 336, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 337, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 338, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 339, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 440, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 445, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 446, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 447, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 448, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 449, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1000, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1100, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1101, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1102, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1103, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1166, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1200, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1201, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1202, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1203, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1300, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1301, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1302, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1303, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1400, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1401, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1402, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1403, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 2000, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 2100, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 2101, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 2200, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 2201, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 2202, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 2500, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 2600, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 2601, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 3333, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 4422, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 4433, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 4444, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 4455, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 5544, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 5555, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 5566, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 5588, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 6000, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 6655, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 6666, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 6677, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 7000, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 7700, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 7766, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 7777, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 7788, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 7799, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 8855, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 8877, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 8888, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 8899, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 9000, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 9900, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 9911, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 9922, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 9944, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 9955, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 9977, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 9988, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 9999, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1465502605210812416, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1465502605244366848, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1465502605277921280, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1465502605307281408, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1468405431398301696, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1468405431419273216, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1468405431440244736, '0000');
INSERT INTO `sys_role_menu` VALUES (1, 1468405431457021952, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 334, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 338, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 440, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 446, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 1000, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 1100, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 1101, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 1102, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 1103, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 1166, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 1200, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 1300, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 1400, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 2000, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 2200, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 6000, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 6655, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 8855, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 8888, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 8899, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 9000, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 9900, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 9955, '0000');
INSERT INTO `sys_role_menu` VALUES (2, 9988, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 338, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 440, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 446, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 1000, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 1101, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 1102, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 1103, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 1166, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 1200, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 1400, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 2200, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 6000, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 6655, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 8855, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 8888, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 8899, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 9000, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 9900, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 9955, '0000');
INSERT INTO `sys_role_menu` VALUES (5, 9988, '0000');
COMMIT;

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `code` varchar(20) NOT NULL COMMENT '企业编码',
  `name` varchar(255) DEFAULT '' COMMENT '企业名称',
  `type` varchar(10) DEFAULT '' COMMENT '类型 \n#{CREATE:创建;REGISTER:注册}',
  `connect_type` varchar(10) DEFAULT '' COMMENT '链接类型 \n#TenantConnectTypeEnum{LOCAL:本地;REMOTE:远程}',
  `status` varchar(10) DEFAULT '' COMMENT '状态 \n#{NORMAL:正常;WAIT_INIT:待初始化;FORBIDDEN:禁用;WAITING:待审核;REFUSE:拒绝;DELETE:已删除}',
  `readonly_` bit(1) DEFAULT b'0' COMMENT '内置',
  `duty` varchar(50) DEFAULT '' COMMENT '责任人',
  `expiration_time` datetime DEFAULT NULL COMMENT '有效期 \n为空表示永久',
  `logo` varchar(255) DEFAULT '' COMMENT 'logo地址',
  `describe_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '简介',
  `created_by` bigint NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` bigint DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `version` int NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='企业';

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
BEGIN;
INSERT INTO `sys_tenant` VALUES (1, '0000', '最后内置的运营&超级租户', 'CREATE', 'LOCAL', 'NORMAL', b'1', '最后', NULL, NULL, NULL, 0, '2021-10-27 13:51:59.303', NULL, NULL, NULL, 0, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_tenant_datasource_conf
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_datasource_conf`;
CREATE TABLE `sys_tenant_datasource_conf` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `datasource_config_id` bigint NOT NULL COMMENT '数据源id',
  `application` varchar(100) NOT NULL DEFAULT '' COMMENT '服务',
  `created_by` bigint NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `version` int NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenan_application` (`tenant_id`,`datasource_config_id`,`application`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户数据源关系';

-- ----------------------------
-- Records of sys_tenant_datasource_conf
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint NOT NULL DEFAULT '1' COMMENT '主键ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '昵称',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '简介',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像',
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '性别 \n#Sex{W:女;M:男;N:未知}',
  `dept_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '部门ID',
  `qq_open_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'QQ openid',
  `wx_open_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '微信openid',
  `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '1-正常，0-锁定',
  `created_by` bigint NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` bigint DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `version` int NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_wx_openid` (`wx_open_id`) USING BTREE,
  KEY `user_qq_openid` (`qq_open_id`) USING BTREE,
  KEY `user_idx1_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$6z14VGdfVnlWY2K1pvdzJOHkvjLmOuBrJXXeZ0mGIqB60Qd6WYDoC', 'albedo', '17034642999', 'albedo@ss.com', '20180414165920.jpg', 'W', '1', NULL, 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', '1', 1, '2018-04-20 07:15:18.000', 1, '2021-12-04 16:10:43.979', '11', 87, '0', '0000');
INSERT INTO `sys_user` VALUES (2, 'manage', '$2a$10$rmMeskeLIFFqP39zH5a2duJ0pcDvePqdwrSQHFW.rBVszm3lE9E2y', NULL, '13254642311', '13@qqx.om', NULL, 'M', '1', NULL, NULL, '1', 1, '2020-05-12 09:51:46.703', 1, '2021-12-04 13:15:51.645', NULL, 15, '0', '0000');
INSERT INTO `sys_user` VALUES (3, 'ttttt', '$2a$10$KYuAjYBhucUG4GbYQTuRO.YOl6JJlGdEdD5zGLkfrSumnjEF59S7G', '1', '13245678975', '1@e.com', NULL, 'N', '1', NULL, NULL, '1', 1, '2020-05-29 16:41:21.126', 1, '2021-12-04 13:15:52.453', NULL, 12, '1', '0000');
INSERT INTO `sys_user` VALUES (4, 'normal', '$2a$10$tr91uxFhn2emY7sXqLqzz.66xrXGgLkzxyREnRhgWcNbxmlgUXJU6', NULL, '13258465211', 'qq@ee.com', NULL, 'N', '1', NULL, NULL, '1', 1, '2020-05-12 10:22:11.393', 1, '2021-12-04 13:15:53.372', NULL, 24, '0', '0000');
INSERT INTO `sys_user` VALUES (5, 'dddd', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', 'dd', '13258465214', '1@1.com', NULL, 'N', '1', NULL, NULL, '1', 1, '2020-05-28 03:08:17.639', 1, '2021-12-04 13:15:54.490', NULL, 1, '1', '0000');
INSERT INTO `sys_user` VALUES (6, 'dsafdf', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', NULL, '13258462101', '837158@qq.com', NULL, 'N', '1', NULL, NULL, '1', 1, '2019-07-07 14:32:17.000', 1, '2021-12-04 13:15:55.244', '11', 26, '1', '0000');
INSERT INTO `sys_user` VALUES (7, 'test', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', NULL, '13258462222', 'ww@qq.com', NULL, 'N', '1', NULL, NULL, '1', 1, '2019-07-07 14:35:13.000', 1, '2021-12-04 13:15:55.937', NULL, 50, '1', '0000');
INSERT INTO `sys_user` VALUES (8, 'ttt', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', NULL, '13254732131', '2113@ed.bom', NULL, 'N', '1', NULL, NULL, '1', 1, '2020-05-12 10:06:21.381', 1, '2021-12-04 13:15:56.571', NULL, 1, '1', '0000');
INSERT INTO `sys_user` VALUES (9, 'test', '$2a$10$g74ZwJNgw52R/A6t7lQBzuMbBcBFzm.cKd7SqS5uNxkkecvN/MVte', NULL, '13265843021', '33@d.com', NULL, 'N', '1', NULL, NULL, '1', 1, '2021-12-02 20:03:08.829', 1, '2021-12-04 13:34:39.680', NULL, 3, '0', '0000');
INSERT INTO `sys_user` VALUES (1467013500122431488, 'dddddd', '$2a$10$K0C0WyfF4owq6M1c.p4G6OzJkCY8vWCBRrFeSlGy.3b9YdKVEdX7.', NULL, '13258465001', '1@1x.com', NULL, 'W', '1', NULL, NULL, '1', 1, '2021-12-04 14:10:48.872', 1, '2021-12-04 14:10:48.879', NULL, 1, '0', '0000');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online` (
  `session_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户会话id',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录账号',
  `dept_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '部门ID',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'IP',
  `ip_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'IP地址',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户代理',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '在线状态on_line在线off_line离线',
  `start_timestamp` datetime DEFAULT NULL COMMENT 'session创建时间',
  `last_access_time` datetime DEFAULT NULL COMMENT 'session最后访问时间',
  `expire_time` int DEFAULT '0' COMMENT '超时时间，单位为分钟',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`session_id`) USING BTREE,
  UNIQUE KEY `session_id` (`session_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='在线用户记录';

-- ----------------------------
-- Records of sys_user_online
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_online` VALUES ('-0FmrvfgrwGYvEeIz-Ta0YT2BZotzGyhzx4_-lUQ', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:21:16', '2021-11-22 14:21:16', 1800, '1', '');
INSERT INTO `sys_user_online` VALUES ('-aOCmqU5F9VSvw7zApA00CdsoPyzxZuR_0anDcwI', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-25 10:18:56', '2021-11-25 10:18:56', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('-EfKhkGWACJI7mBfHjpAziiOKJBgTPhbT4kkeB7m', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 11:15:20', '2021-12-01 11:15:20', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('-eYVZa3SrhYpSkNR4WdVn0E6lDeOllsjazYMUm2A', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 16:14:39', '2021-12-04 16:16:45', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('-Nk2Kwqw645qfpBpC-ynZYhCTk3OUXWScoRJNu80', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 10:41:50', '2021-11-22 10:41:50', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('-USSUa_fIj7jEyrE4HX4BAoy8QqAzrFTJE3L10i4', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-08 10:51:30', '2021-12-08 10:51:30', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('-zc4ZG2pegF_MnakZjcjaztpt-Vta0JO5qC7wJ4G', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 FS', 'Chrome', 'OSX', 'on_line', '2020-12-24 13:48:40', '2020-12-24 13:48:40', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('03eyvK4nWn5r7d6jYpydx0rhTEHqj_GYw1pNNJrV', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Safari/605.1.15', 'Safari', 'OSX', 'on_line', '2021-10-21 10:44:26', '2021-10-21 10:44:26', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('0aDHyVVWqjJouSJD33EAocCZ1qHQ3Wknom65D4tj', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-10 13:30:49', '2021-12-10 13:35:00', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('0W4wfL2zpJXJm3NSsCDpKpk7STsTOWOalO57igQn', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 11:46:13', '2021-12-01 11:46:13', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('12777A9FA870942EE91373E26E51487A', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 FS', 'Chrome', 'OSX', 'on_line', '2020-12-27 10:12:19', '2020-12-27 10:18:16', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('1mqn_EAn7r5OGNST27DbnBN_I5CTTvee8ijzUiv9', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-26 11:23:05', '2021-11-26 11:28:29', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('1rJXTH3D9oywqCOpAfQQF00qXJVrvveEdwAf1UrO', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-25 16:44:08', '2021-11-25 16:44:08', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('1Yim1yR9SijtUD4iilNH1x-22-A-bVWQaXzf9gbd', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 15:50:42', '2021-11-30 15:50:42', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('28pz6zDE9-NKXrrRoPAVJMyISrl1lRiyeQpV43wQ', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 16:13:26', '2021-11-29 16:13:26', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('2E5y6aFaElK0Vt41O2Byw7ICxJsCVJSiaYEGxdzR', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 18:42:34', '2021-12-02 18:42:34', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('2JndMy4zAeeTUXYuzJAeJ-eXMWsRu3JmGHsSpshz', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-25 17:48:30', '2021-11-25 17:48:30', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('2qN8TB3irjKUmlDJSkRh5Kjc0foHn4UMxG5nG-PR', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 11:31:25', '2021-11-23 11:34:13', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('3Ah4YV9dRottu5_fr1Znf80oS4hOizXJBB6UdROw', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 11:24:29', '2021-12-01 11:33:08', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('3ewE0EyfMxVh3l8ACwIhqwQ3oBZRNUvOwslDfwhC', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 10:37:41', '2021-11-22 10:37:41', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('3ImK8SFWjoJIe4clWUPm6Ljurfo8yg869vGH6Oja', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 16:13:25', '2021-11-29 16:13:25', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('43Yh08YzPEQ3RdAUEJ0wXg_NXuPumWFKQyzNaeCf', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 16:05:56', '2021-11-22 16:05:56', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('4lNFtufO3zsSRdehiAu3c4gosRvitw1bSl5s4Pxp', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-26 12:07:24', '2021-11-26 12:12:19', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('4Neenps_0Ob70CGzvnPvuK2vV8-nMJxURMKPZH47', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 15:50:42', '2021-11-30 15:50:42', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('4PcSkkOxE3kwIpx2sUznLDzwo0TYFs1vkItkw2LW', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-08 10:11:06', '2021-12-08 10:11:06', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('4Py3m_CpTjFlSY5OVMekXXiGnCut5LTyWnNGxM7V', '1', 'admin', '1', '总部', '127.0.0.1', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 16:24:37', '2021-11-30 16:24:37', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('573CCD9C3BA78A467A6E49E9386EF637', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 FS', 'Chrome', 'OSX', 'on_line', '2020-12-27 09:29:49', '2020-12-27 09:35:45', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('5r1q9-okbWOOX9uMe8VJENJUg84dWWoHclrWS9G6', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 13:28:46', '2021-11-29 13:34:11', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('5U4BRJ1YMgaBJhiR6Gj7q2voSAqjlBof_SArK0rc', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 16:13:25', '2021-11-29 16:13:25', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('6EZV4iMjl-UHiieY6Pyz7aAHCqoNIY06hVgMv65H', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:54:26', '2021-12-04 13:54:26', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('6IVkJSQ1EICIKoNuUAP-3sg2g9o7hms1wtcvnfsM', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Safari/605.1.15', 'Safari', 'OSX', 'on_line', '2021-10-21 11:48:20', '2021-10-21 11:49:32', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('79D8FC38415E727A1D0EE29D6777ACF5', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 FS', 'Chrome', 'OSX', 'on_line', '2020-12-27 09:49:35', '2020-12-27 09:49:35', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('7AlKtuMpJcahCC1r3HzKbYWpneYC9FqPycs46_6l', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 11:14:07', '2021-11-30 11:14:07', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('834A88DF1EBBEE529E9EA88712C2B070', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 FS', 'Chrome', 'OSX', 'on_line', '2020-12-27 09:25:53', '2020-12-27 09:27:48', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('898OaI-KQw0SKYPhnIWHyF9S2Bcuc3ziNdWyQDrE', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:45:18', '2021-11-22 14:55:00', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('8RwS3J5owF7XYPtfpI4VR2OjVVgtIqcwnSQe-ZqZ', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-25 16:14:35', '2021-11-25 16:14:35', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('8Tb8ABDaqtNyMmsoknXPg4FNRKzolYMTd898fFLw', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 20:11:53', '2021-12-02 20:18:39', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('9Ehrw6D1XuKJkkzk7wK0N0UuRS2aypdoaQ_w9DNR', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 16:01:09', '2021-11-29 16:01:09', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('9zcomLHTQ3LHq0qHgmT6oEdPiurbZ-v-1WYJ8PRj', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-24 09:58:30', '2021-11-24 09:58:30', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('A8CD5CDABE9C57132A27FC09CDCBBF8D', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 FS', 'Chrome', 'OSX', 'on_line', '2020-12-27 09:28:49', '2020-12-27 09:28:49', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Am85JCLLxlkYMDqs1btga0H_J5qTSahF2mtcVmzT', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 11:28:04', '2021-11-30 11:49:15', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('bdDhAS310N_WeS5ayyoOFgyjfYiu8h-0lHMJqxrm', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-26 11:38:08', '2021-11-26 12:05:56', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('bnK7uxcM-bqh1s3nX57WwllxNwqiITnOwu0Gjmpw', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-26 12:16:31', '2021-11-26 12:19:54', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('bOYuoJLel-yrtu4enclcRIhfBWAIwc10uJCRwMkV', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 15:05:19', '2021-11-30 15:16:05', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('BqdFsnFScCbqvQDy3Z2od56w4KD73ReWBaZHJB6G', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 15:25:55', '2021-11-23 15:28:05', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('bxg3Y809kXgffEPXblgjD_cWdmBh1Hcn1WQ2Rro2', '1', 'admin', '1', '总部', '127.0.0.1', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 09:28:32', '2021-12-01 09:33:17', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('c1Z-JGp1aV73CdmBNuf4jaHWuXNj3j1cKgj8zXMH', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-24 13:21:03', '2021-11-24 13:21:03', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('CBFA89A68A8D6D0393C2910C88721C19', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 FS', 'Chrome', 'OSX', 'on_line', '2020-12-27 09:13:50', '2020-12-27 09:18:30', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('CcnIB8X8QlT0vkJTdfsLwQ9iBDc_InmSpkpX8cm_', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 15:13:45', '2021-12-04 15:28:30', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('CCykhRRaxbbabEJVS3il49IJngwIKLYD330ZTFPp', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 16:59:56', '2021-12-02 17:03:28', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('cgTzWniF3yVk33Rd6-PyNjC1BA9VSgvxQ3sFg-wt', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 09:48:05', '2021-12-01 09:48:05', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('cS9cREY9JwiG95Punh3lMLJAUaUzzmMD8otINZOd', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2021-10-21 10:45:18', '2021-10-21 10:45:18', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Cxhnh9Jqr1yNn36uoXqXPfLc_RCVEZTlVB3f91Xi', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 14:02:32', '2021-11-29 14:05:59', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('d-uBcEGFYxSPX_1S1r85v6wxswcpF2YMSNX8uLGq', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Safari/605.1.15', 'Safari', 'OSX', 'on_line', '2021-10-03 17:06:46', '2021-10-03 17:06:46', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('DcpmHIdBJu0W_uR4CCrG_UsfnKDY-7MBU1guK4CZ', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 13:51:10', '2021-11-29 13:51:10', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('dRO1xfJi2MdcG5fHLfi-tvlKOK3GePYjlMpgOKB5', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 19:48:50', '2021-12-02 20:01:38', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('DtRWCbAC0SQ_E75-YFdfoNjBWfOfc9Lg9183CuFF', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 19:41:19', '2021-12-02 19:41:19', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('E6jx6b494GsQDNGc0dErrduFmHynMc2V9zlJM3HW', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:04:19', '2021-11-22 14:04:19', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('e6ogiE8fG7CpPCx2vfz3H0AEJtx9W3rmKNCFT1iT', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 15:01:54', '2021-11-23 15:01:54', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('ee4DtFBbRPBdCw0LWOHC2aBU8FbAdcG8pCT4mpYB', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-08 10:30:09', '2021-12-08 10:49:42', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('EE_8EomRHi-d-dkHzWcmaQIJUbvt-iQTT1I4zGw5', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 16:13:25', '2021-11-29 16:13:25', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('eKnyM43OFZVdoiGJgyN6bT9LocC9osXV5-ngSWTU', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Safari/605.1.15', 'Safari', 'OSX', 'on_line', '2021-10-21 11:27:30', '2021-10-21 11:27:30', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('eQ2DlB-qhBdZZ1YCpOTdLT5_UqsAgbN_E-qRVDhA', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:20:06', '2021-12-04 13:23:37', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('euqusQws_RAsox7nEkqqXoaw75z6xbYsB68YgbVa', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2021-10-21 13:50:01', '2021-10-21 13:52:05', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('F1T3oGTWkB-O7ueV4w7BqWwfJKxKMMljEs2LujIn', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-08 09:11:29', '2021-12-08 10:08:50', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('F4nXKTROQVXl7ba34lNl-VVmQN5mvVdiI7TK-jRS', '1', 'admin', '1', '总部', '127.0.0.1', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 15:54:06', '2021-11-30 15:54:06', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('fg__8HI0libEkVq2etbv58-BEGRxjrnvOhXEMjPJ', '2', 'manage', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 20:03:48', '2021-12-02 20:06:20', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('fH4zPRyvMI3EViOYBo2ApDSxXrz64FyWtHufblXa', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-26 10:07:43', '2021-11-26 10:12:02', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('FoXMkNX1lM10wmWKO4xCwUaMUzE5wWEnBXIeh5FM', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Safari/605.1.15', 'Safari', 'OSX', 'ONLINE', '2021-12-01 11:50:48', '2021-12-01 13:07:42', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('fWErc8JODzxo6d8GWDi3_CBUHQmgMsF0qZzWnxgi', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:55:27', '2021-12-04 13:55:27', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('g0hxZGaLV6qJ5wkgWMcTd-qhN6TrlW4ZhhlVWfr2', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.2 Safari/605.1.15', 'Safari', 'OSX', 'on_line', '2021-09-16 15:52:35', '2021-09-16 15:59:08', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('G9qeq78GL1WAksj2zTIPPObM1Migs30Fh_Zh3TB0', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-25 16:15:46', '2021-11-25 16:17:34', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('gouQtnpANNOawxWCc5CkzmtfgGH9Jp3NTysy3fUw', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 FS', 'Chrome', 'OSX', 'on_line', '2020-12-20 08:37:24', '2020-12-20 08:38:50', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('GQJ4kgBetlxuN1oJ8PojFOwpuBgh6DiTY0RSiyCE', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 15:32:41', '2021-12-04 15:37:47', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('GyMkckiHxwSgqrfEvwdVRb7WzxeUO9QPwUSb8gaN', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2021-10-21 13:22:43', '2021-10-21 13:25:14', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('G_a1UeAE0mddQt6qEn7l5zWfHYtTdgzuNndpDtfL', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 18:34:57', '2021-12-02 18:34:57', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('h1Kn3U3V5Ov2Op8iD1VBDGp-Ruatzd5Q9B0tywOc', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 15:51:06', '2021-11-29 15:51:06', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('H84ZqPAT8ileK1TgbncdZyf80ymIsQU8-O-3A6uX', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-10 13:51:42', '2021-12-10 13:51:42', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Hi98MldCiV_xgudaqwSRgCi0yAxPGUSRlILRWVNB', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 13:59:52', '2021-11-29 13:59:52', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('hLRnDfQ3phaQ-tz66wJkMu_fdGy8h1TxHELeLO5Y', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-26 11:20:38', '2021-11-26 11:20:38', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('HLXyiwHtZS-D9YV0TQxdD5woGNzHCAkbhjLm3Ncf', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 16:03:40', '2021-11-29 16:10:33', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('HsFX4y9YJlZ30SCN5eUOeuTcvQIEdgnn1Rq_HCiO', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-25 09:27:38', '2021-11-25 09:36:48', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('HtftARnqjeeZxwBW2yzTRB6A2gi3hrq2w9l4fpdM', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2021-10-21 12:08:25', '2021-10-21 12:27:44', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('HWk3lNZsjT7jzV8JPqa1I-L7p1wZpjWWHwgx5bF8', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 11:37:09', '2021-11-23 11:39:43', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('hzkAz_3DMG-C24GGWYPa5o5PKRhAWSjRClv5u989', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:35:45', '2021-12-04 13:35:45', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('IH1da5K9otPG3KrtCtVzw6VGrfNKOLvhRb2Snrml', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:17:27', '2021-11-22 14:17:27', 1800, '0', 'MDAwMA==');
INSERT INTO `sys_user_online` VALUES ('ILXpsRwUZCq6qoM-oJb-AdHrrEvpYDP4lz9tpk8h', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 16:01:49', '2021-12-04 16:03:50', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('JFsfV5NFDOd7kHBv1dPGMZ6WQYJs2w-mrFaE4XIa', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:18:32', '2021-11-22 14:18:32', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Jp31Z4jldRmIIS9XmzwesgJWrabVYyTlu_ro1nX-', '4', 'normal', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 20:08:39', '2021-12-02 20:08:39', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('JpP3Ks5Y6hH7s9nMtFhS3_e4nwY789XHUtBOSz9_', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-24 10:04:35', '2021-11-24 10:04:35', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('JsHLpbw7uNw-zflJKFTqQbgNqdgPzIgGEhOW8MPD', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 18:25:23', '2021-12-02 18:25:23', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('K2pz-AL4Bd4MnhPkAh31C2rXATDdGF1vamUuNqiM', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 11:47:15', '2021-12-01 11:47:15', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('KIrJc7S2C9Nq_BQaAzmAo3em41hN7HHupqCDddpf', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2021-10-21 11:49:57', '2021-10-21 11:51:00', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('kv1IM4-bk5jNlIU6Iy6pU7ooyjOD1exa4l0Rnoq8', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 13:36:20', '2021-11-29 13:36:20', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Kz4jaSzayLm1olzZPDaPlJRsQFH0UluQMEhLAE9Z', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-03 09:45:55', '2021-12-03 10:00:22', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('kz6Hh7LZHCYH3PruuVNVtEY5huU-O4GIIMYnj8L8', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-24 13:17:31', '2021-11-24 13:17:31', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('l1IUYftFicBHDGLvyDqVGzRiq3usE8eKNmy-HRhG', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-08 10:53:07', '2021-12-08 10:53:07', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('L6QxHoHREWsbz50cKwbh-pYBWqzbIb_dHawy2iOM', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 16:09:31', '2021-12-04 16:14:32', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('l8mUwZ_ZDJ28mKJFRTfx4yK_Mu3y3eUZAL2hgvLJ', '4', 'normal', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 20:06:44', '2021-12-02 20:06:44', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('lbv3y5I4hyd3XWkBE_eipU0M1uPGcoM-O68UnsfG', '1', 'admin', '1', '总部', '127.0.0.1', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 15:53:49', '2021-11-30 15:53:49', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('LfNqrcFPk6HWxe1q0rZ_eoXCKwatq_hdl0eXkYBd', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-24 10:02:59', '2021-11-24 10:02:59', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('lFs0Cy2WA0qQiJwpaXo3Ph-dFe-6xxCAypIDHVq8', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-24 10:12:26', '2021-11-24 10:13:58', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('LI9vlmy4dawjlFntTXnyYv7KLLn7LYDITe7n6-G1', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:00:33', '2021-11-22 14:00:33', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('LiCxhclIcIZl7Qw5AXDEQCRLPbFjnzhwyaL2mgJQ', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 14:48:06', '2021-11-29 15:09:05', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('LO8PkqTpESspRXZ6LGwsMBg61L--Sl8Ic0-ZgbUO', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-26 10:16:53', '2021-11-26 10:29:06', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('lSYVwbGkuAeO2_73D4h_EIGDyOyBqh2BzhABFrYq', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 FS', 'Chrome', 'OSX', 'on_line', '2020-12-24 13:48:53', '2020-12-24 14:06:17', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('lUbVvgVPYBLt0x0lyCCAj1yaAqQi2F9Ddlz9VHWe', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 15:38:45', '2021-11-22 15:44:50', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('lvsHsp8po1DXDI53UJ5NbQ6bt7cd_u6bpX0b1mx-', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:01:32', '2021-11-22 14:01:32', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('lZgGf3GPfakyqMOL-CFaTaW7IcBXY7ggNhQLFU3p', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 18:26:33', '2021-12-02 18:26:33', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('M0WZ2KzCDZTfDL21V3OCRsVxLg255-L-ot2Rvdjg', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-10 12:10:30', '2021-12-10 12:10:30', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('M1qPgN7HITSP8RKgjG0nwD9pYmbrCBDISW0KM91E', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 11:48:16', '2021-12-01 11:50:32', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('MbcLGoMoVLBVgd4CvWiFzFN11dT1Vd7U5oGIKZDd', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 10:51:49', '2021-11-22 10:51:49', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('MXY6F6DI2QyBhrlZZovF_wr37LjiCo1I2dgKbPQU', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 15:51:49', '2021-11-29 15:55:53', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('mxYeS_kPLoIAcfcjLs-jMbNwBq4BvTeb56cqdxYE', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:23:21', '2021-11-22 14:23:21', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('mYr_Vs0tGkXyKPlO6bJ2jlrDsAb6La5ktRM8nVAa', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 10:00:13', '2021-11-30 10:17:46', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('mzKIc_fSpoEE1k0jSD4vtM8rEQ4rEQJsJdGR90az', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 10:37:24', '2021-11-22 10:37:24', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('n0oQj1vaY029C3Z4FOnYBalD5V0HzfgdPcrsLxoz', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 14:27:32', '2021-11-29 14:28:48', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Nk2JwKtkTvMie8Upsk_brb7YSXr7Nv0gDzPYL_RF', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-10 13:36:07', '2021-12-10 13:45:14', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Nk6PBrCM8-X1vgqnmG77h9alhCFp8LB_OBxA9ysK', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2021-10-11 21:07:05', '2021-10-11 21:23:26', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Nld5qz0LgxaOke_i4o1bETRiTuDNFzJR1SS68hCK', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-25 16:34:21', '2021-11-25 16:40:58', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('nPq941gKcTmPtQOAkrj7Pm5ooTQJmx1FgB_XgYN_', '1', 'admin', '1', '总部', '127.0.0.1', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 16:28:00', '2021-11-30 16:28:00', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('n_qAC6HoL7iPnQmEcdqK_oqoSbdpCDOfmMTxFp7h', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 18:41:39', '2021-12-02 18:41:39', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('O6WEOLtbxSJj-rvwcqY5r_L-uf8t73kQHF1QpVDg', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-10 13:56:52', '2021-12-10 13:56:52', 1800, '0', '0000');
INSERT INTO `sys_user_online` VALUES ('O73PIzDnu4zcS6J4M2S0gcgOwfLLEcDxFbrMAdXr', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 09:44:14', '2021-12-01 09:44:14', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('o7fMo93QUJx_DS4kIHO2KTsVZYmU0LL_bqfZtl7c', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 14:30:12', '2021-11-29 14:42:18', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('ohuOyeL293uAyeM074ONzjU_TfJ513PMaS84J37U', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 18:34:57', '2021-12-02 18:34:57', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('oTjbD94SpzEX6n-KE13VdGeVHNP4nac41ZseYzKv', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 14:43:34', '2021-12-04 14:56:23', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('P59d21Shjd7pCt2D8Ug_nlWQP8YEkc2Dgylvd9Br', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:12:29', '2021-11-22 14:12:29', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('P8nv1zRqbuAaxXU3ER1ylxEB_7ptP_zdh9SEv8Sf', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 11:27:27', '2021-11-23 11:29:13', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('PAr_X7IZogOsR0GqO6RhX52xEvwt-KcFvxGOYa6i', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2021-10-21 13:40:34', '2021-10-21 13:48:11', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('PDNU_iPk3N33iP0us6vUqqSsu74PbiSL-NsCZowl', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 14:19:31', '2021-12-04 14:31:58', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('pg3S4MTQ04BgiUMO_UqcgZcd2HYKswSS8pFpRDNK', '1', 'admin', '1', '总部', '127.0.0.1', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 09:37:09', '2021-12-01 09:37:09', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('PhEHRfPI0RXoCWQb6K2UBGfxvxkFjimWJD6jBvX7', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 13:25:33', '2021-11-29 13:25:33', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('pmT1m8fcZRd8zJp7FG-0QWRLTHXysBn2PMoF6csw', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 16:13:25', '2021-11-29 16:13:25', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('QD_LW6hT3alQkY8QPrABLMgNoot8880lVAKTA1RT', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:52:11', '2021-12-04 13:52:11', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('QG2GGVu1lVA7aC0yT7sgFWzw-FkkYW9fbI6Fuln5', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:28:55', '2021-11-22 14:28:55', 1800, '1', 'MDAwMA==');
INSERT INTO `sys_user_online` VALUES ('qitMye7ibd-SSGyCQh9MQIdPfgL2tq9fryMpvrml', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:56:55', '2021-12-04 14:10:49', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('qkoKUS_o-RkbNPwHEcE6psH6EBmD4y2jOCikIqj3', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-25 17:52:51', '2021-11-25 17:52:51', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('qKozMisPawb7OLm9OQmdMqL_qeSOjfevO1i2HPAm', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-08 10:27:16', '2021-12-08 10:29:14', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('QYCQdMTxyu4kZWvueFcMuacARrtV6uQfgXBIXIDj', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 11:42:55', '2021-11-23 11:42:55', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('RF3Cb4ZnWWYB9sNFtV5_mS5oOSEMrpl2PRbpfnCO', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 14:14:28', '2021-12-04 14:18:29', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('rN8DxvHqq2Nkbyg1TLzyCrISGTnQtuHYkjDspq0A', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 16:05:04', '2021-12-04 16:05:04', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('S0DSK7-cBOTCCF7AyZCGHIHsv6W4d95slPuDtIjL', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-03 10:05:55', '2021-12-03 10:12:23', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('SbkMW7HMKWA_VcWHvTgu1aAJY7LGtpcy7gs3n_fl', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 09:39:28', '2021-12-01 09:39:28', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('SC7yVA5i6rdrnnGixS0gyLmyf--StfqWmam4GK3n', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:05:11', '2021-12-04 13:11:22', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('sCAMyus6Bn2bqwy2YIt6WZYavt3hvAISFO4inbIx', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-25 17:24:06', '2021-11-25 17:25:46', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Seg3Y-8AAXOLI7qT65avSKbiYeYsB72IB2y9xeM3', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 11:28:04', '2021-11-30 11:49:15', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('sF-YQ_Vy8DaIbkz-U2BHI_aaywCq_NmWix-A1rbu', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2021-10-21 12:28:34', '2021-10-21 12:28:34', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('sjlMZlfSwf8K9NBuxW-YRVbXOzwTMvmAh2VjWeH_', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 10:47:28', '2021-11-22 10:47:28', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('SpjG8G4F4OP9C7_F3QAPQzui0Drs9V7xe8uYXR7G', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Safari/605.1.15', 'Safari', 'OSX', 'on_line', '2021-10-21 11:31:15', '2021-10-21 11:31:15', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('SQFevkBd4Gq6wm7Gv5iPvWb3kFLJw0L5LtZNUyxV', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-08 10:29:23', '2021-12-08 10:29:23', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('SxraNv52vvHRYbwI66URtz7b5J4fEQaoOgL20zb4', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 18:24:33', '2021-12-02 18:24:33', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('T22AJKjUik6zU6L63dQsmFzHIlUZY_uHJ8pfWq3q', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 15:03:18', '2021-11-23 15:03:18', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('T4sQaE52V67EC3rspOb7fwcW2EXZIgehPpkFFUbm', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 16:16:50', '2021-11-22 16:19:18', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('t93d9eA80Q0Vn_wSoigOLe9RC67cvqRJxyERIzu8', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Safari/605.1.15', 'Safari', 'OSX', 'on_line', '2021-10-21 10:45:10', '2021-10-21 10:45:10', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('tGPNkbeFnZLXwVUQ5mLSq2PTn1BI1iwE2H-veQnf', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-25 16:25:17', '2021-11-25 16:28:50', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('tkLTxsBjkb8WAGFmhhgzo-lJ3RFvAclDAHcElBH9', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 20:01:57', '2021-12-02 20:03:33', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('tp5iCu2jig4CN522DMlDqF7HJfcH177w4p7P_KwZ', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 09:43:35', '2021-11-23 09:43:35', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('TP6WX3sOo_VxwDqv-vJYTH1aNYJwh_l3ADhmHg5y', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-10 13:49:23', '2021-12-10 13:49:23', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('UiJYR6yheHnQ5GfBsxHOf06asJ48XaITogs4KcHN', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-26 09:40:58', '2021-11-26 09:45:22', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('uQ0Wsgg3IVZDs0j30L9lca-HENL8EBEGPCK0Y0qO', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:39:32', '2021-12-04 13:40:56', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('uVFpYbMd_D08DKtIoJ2RraMbMQWh_a9wqa2zY98m', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2021-10-21 13:26:41', '2021-10-21 13:33:18', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('uZyvMHXjKpjgq5NadONctoTO2NYjvmvzDZN4tOZP', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-08 10:12:05', '2021-12-08 10:24:47', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('VBbI4sgIOf1HbwjVwrwguySNLLta6uEt-1pNNtx_', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 14:33:04', '2021-11-22 14:40:21', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('vf-zBMSvdmwYKkWeu_CEokJfHv6-WRyGzyUJCsj8', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:25:03', '2021-12-04 13:31:03', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('VIGLlayzmoDWg8k8-6o7hrCQAmOLinVParb6N-dn', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.2 Safari/605.1.15', 'Safari', 'OSX', 'on_line', '2021-09-15 15:24:15', '2021-09-15 15:25:21', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('vjIpA9T7MMaD45wfYnCVwPoo-9i6hl-Zoxl0bJwk', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-10 13:53:01', '2021-12-10 13:54:10', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Vv8wGqqD26YCwf6tEaNfRi74fRqsS3nroh5BiEL1', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2021-10-21 11:51:37', '2021-10-21 12:01:37', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('w57pGAqtrL157osG4yXYnpiIUehkf3948tIiozqA', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-10 13:51:35', '2021-12-10 13:51:35', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('wED38s7Ns4b8lRgCtgf5OAIRKZT8QIGE_92kexi2', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 10:38:11', '2021-11-22 10:38:11', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('WgioXVZA_1D4c72BzTKnL_XYkKmiqzmVQNxnIybm', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:53:11', '2021-12-04 13:53:11', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('wo3vZfKdSF0Vno8HsLJeaJmBYvL1U6CwsXetJNvH', '4', 'normal', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 20:07:07', '2021-12-02 20:07:07', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Wog8sIeCU8J9hMHLMuf-eeFZuC692rH3hMd8vZcL', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 15:05:13', '2021-11-23 15:11:26', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('wzYTOGv71Tvrr2HGeDa9d-reo8XJB3_A4cgiwH2N', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 15:09:51', '2021-12-04 15:09:51', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Xfs84bzPskGAm91-QRJWlt2MoHPekYFdBxZwy5XX', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:16:04', '2021-12-04 13:16:04', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('XnVpRVy59vyMometwHLYFyuxWOdpzNYPATvKOHew', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:43:11', '2021-12-04 13:49:56', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('xScb5EIU55SYmzwdvwoqFOKnYz-8da9SJ-_QaKCB', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 18:30:37', '2021-12-02 18:30:37', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('Y8PdSMsWtYLBKSmbnaQt3IJGR7q-MB8uas_74Jfd', '1', 'admin', '1', '总部', '0:0:0:0:0:0:0:1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Safari/605.1.15', 'Safari', 'OSX', 'on_line', '2021-10-11 21:06:42', '2021-10-11 21:06:42', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('YbQtQUw4T2T13iAy_Lx2kz8vFzgXZBxdqA-Nse2C', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 16:43:47', '2021-12-02 16:43:47', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('yCD5Qw5b0JDi4qXNEdCnpgIdLo-jmUulv2ol-ZVr', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 15:08:21', '2021-12-04 15:08:21', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('YCIwHUo2ebF3aYzW--zXJO7d-NerkxrV-8HI5kSj', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 16:13:25', '2021-11-29 16:13:25', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('yDAwHCe4pDr1ZSKr0jV0FJsipC3iH0l1CvHmj7Pl', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 16:11:12', '2021-11-22 16:11:12', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('yn5q8JCor4RspSNW4v9mjuj1Pl-rjt4HdcPcfD02', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 18:37:46', '2021-12-02 18:38:53', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('yoCDwUcNYBIZAbNV0zgScd7BIOt3w92DgPWgOWig', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 15:13:56', '2021-11-22 15:35:32', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('yVMQpJZ_l_7-a2Pu0PRGB8KrwaPAwYg58-SsIpYi', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-08 10:58:19', '2021-12-08 11:58:24', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('YW9fM6rNghP4M1NXsGkGhaoF8G87fcjA6D722Jp9', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 20:07:26', '2021-12-02 20:07:26', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('YYelXyoYcUE_gOfJV4i39JbFly1cGrKv1R_E3mdT', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 15:44:30', '2021-11-23 15:46:07', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('YZbfXf0S-wYzfI3N9v3x5eOx2aJDdzTwevMLFyDS', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 19:42:56', '2021-12-02 19:45:13', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('yZpLtZGpCOtHzhkw-GnP8DBFOSDX5cnDGPOeSGbL', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-22 10:39:46', '2021-11-22 10:39:46', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('yZVbDqIuEOcY3OF84CiAeybyuD0ACCVQydcnQ0Kk', '1', 'admin', '1', '总部', '127.0.0.1', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 16:32:33', '2021-11-30 16:32:33', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('zbUXV_gguGC67g7yEnNnG-sKbxIoDqtgcIsctBYJ', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-01 11:33:45', '2021-12-01 11:37:03', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('ZChvwoiwDBi6qs-XVrGkw1-cgp0EDfdVyVaB2u_k', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-02 18:24:09', '2021-12-02 18:24:09', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('ZcisNpN7KcfYMm70dDyi6lGRxxkAt0SueIMJv-iM', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 16:05:58', '2021-12-04 16:05:58', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('zgb1O7aP6UAuAZyzemiAzeTZAZ3hLw9ml2_b_aVl', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 15:48:38', '2021-11-29 15:48:38', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('ZL6ILTknjWVcinJA894A3BjRmaiaCSaVwESIzP_i', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-24 13:19:38', '2021-11-24 13:19:38', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('ZM7FO47uMMp8oOB3g45uGf24yMFT3SCHBsXZHpPZ', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-30 11:51:32', '2021-11-30 12:16:50', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('zoBN35a1xuGOYpss3WjICfK0whLe3j6k6g_284VV', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 11:37:08', '2021-11-23 11:37:08', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('ZZ72dPrwplIBf9qwxvym6mubWpCrl3W4VPWU2KV7', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-24 13:14:03', '2021-11-24 13:14:03', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('zZmga2jctku-1SCnwAsS1XHqQMuoCIZ17oMrydl8', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-23 15:48:01', '2021-11-23 15:52:55', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('z_SYFu5bfI2JD4p-E-0ahJNnrSfu9xgh-lno07Pv', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 15:38:53', '2021-12-04 16:00:55', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('_6VATux7Wn9pNK2oe-r8GmzocPD0zbQ_T5pifOKq', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-11-29 13:53:01', '2021-11-29 13:53:01', 1800, '1', '0000');
INSERT INTO `sys_user_online` VALUES ('_7waYqMTztrvmnszRS9r4OSa-MeqAabOydD-mkwe', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36', 'Chrome', 'OSX', 'ONLINE', '2021-12-04 13:41:33', '2021-12-04 13:41:33', 1800, '1', '0000');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='用户角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` VALUES (1, 1, '0000');
INSERT INTO `sys_user_role` VALUES (2, 2, '0000');
INSERT INTO `sys_user_role` VALUES (3, 2, '0000');
INSERT INTO `sys_user_role` VALUES (4, 5, '0000');
INSERT INTO `sys_user_role` VALUES (9, 5, '0000');
INSERT INTO `sys_user_role` VALUES (1466377391856156672, 5, '0000');
INSERT INTO `sys_user_role` VALUES (1467013500122431488, 5, '0000');
COMMIT;

-- ----------------------------
-- Table structure for test_book
-- ----------------------------
DROP TABLE IF EXISTS `test_book`;
CREATE TABLE `test_book` (
  `id` bigint NOT NULL,
  `title_` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机',
  `activated` bit(1) NOT NULL,
  `number` int DEFAULT NULL COMMENT 'key',
  `money` decimal(20,2) DEFAULT NULL,
  `amount` double(11,2) DEFAULT NULL,
  `reset_date` timestamp(3) NULL DEFAULT NULL,
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `version` int DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='测试书籍';

-- ----------------------------
-- Records of test_book
-- ----------------------------
BEGIN;
INSERT INTO `test_book` VALUES (1, 'ddd', 'a', 'd', 'a@qq.com', '13', b'1', NULL, NULL, NULL, '2020-05-13 00:00:00.000', '1', '2021-11-29 14:42:57.787', '1', '2020-05-25 13:12:25.898', 'dd', 9, '0', '');
INSERT INTO `test_book` VALUES (2, NULL, '3', NULL, '3@e.com', '1', b'1', NULL, NULL, NULL, NULL, '1', '2021-11-29 14:43:01.749', '1', '2020-05-25 13:10:18.888', NULL, 53, '0', '');
INSERT INTO `test_book` VALUES (1465227096199528448, NULL, '1', NULL, NULL, NULL, b'1', NULL, NULL, NULL, NULL, '1', '2021-11-29 15:53:33.342', '1', '2021-11-29 15:52:16.990', NULL, 1, '1', '0000');
INSERT INTO `test_book` VALUES (1465229962263920640, '2', '1', NULL, NULL, NULL, b'1', NULL, NULL, NULL, NULL, '1', '2021-11-29 16:03:40.308', '1', '2021-11-29 16:03:40.315', NULL, 2, '0', '0000');
COMMIT;

-- ----------------------------
-- Table structure for test_tree_book
-- ----------------------------
DROP TABLE IF EXISTS `test_tree_book`;
CREATE TABLE `test_tree_book` (
  `id` bigint NOT NULL,
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父菜单IDs',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '部门名称',
  `sort` int DEFAULT NULL COMMENT '排序',
  `leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `author_` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `email_` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `phone_` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机',
  `activated_` bit(1) NOT NULL,
  `number_` int DEFAULT NULL COMMENT 'key',
  `money_` decimal(20,2) DEFAULT NULL,
  `amount_` double(11,2) DEFAULT NULL,
  `reset_date` timestamp(3) NULL DEFAULT NULL,
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `version` int NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='测试树书';

-- ----------------------------
-- Records of test_tree_book
-- ----------------------------
BEGIN;
INSERT INTO `test_tree_book` VALUES (1465230193474928640, '-1', NULL, '2', NULL, b'0', 'd', NULL, NULL, b'1', NULL, NULL, NULL, NULL, '1', '2021-11-29 16:04:35.442', '1', '1', '2021-11-29 16:07:27.194', 0, NULL, '0000');
INSERT INTO `test_tree_book` VALUES (1465230307564191744, '1465230193474928640', NULL, '3', 30, b'0', '1d', NULL, NULL, b'1', NULL, NULL, NULL, NULL, '1', '2021-11-29 16:05:02.642', '1', '1', '2021-11-29 16:05:12.134', 1, NULL, '0000');
INSERT INTO `test_tree_book` VALUES (1465230796129304576, '1465230193474928640', NULL, '4', NULL, b'0', '3', NULL, NULL, b'1', NULL, NULL, NULL, NULL, '1', '2021-11-29 16:06:59.125', '1', '1', '2021-11-29 16:07:25.828', 0, NULL, '0000');
INSERT INTO `test_tree_book` VALUES (1465230845026500608, '1465230796129304576', NULL, '33', NULL, b'0', '1', NULL, NULL, b'1', NULL, NULL, NULL, NULL, '1', '2021-11-29 16:07:10.783', '1', '1', '2021-11-29 16:07:24.528', 0, NULL, '0000');
COMMIT;

-- ----------------------------
-- Table structure for tool_alipay_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_alipay_config`;
CREATE TABLE `tool_alipay_config` (
  `id` bigint NOT NULL COMMENT 'ID',
  `app_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用ID',
  `charset` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '编码',
  `format` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '类型 固定格式json',
  `gateway_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网关地址',
  `notify_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '异步回调',
  `private_key` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '私钥',
  `public_key` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '公钥',
  `return_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '回调地址',
  `sign_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '签名方式',
  `sys_service_provider_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商户号',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT COMMENT='支付宝配置类';

-- ----------------------------
-- Records of tool_alipay_config
-- ----------------------------
BEGIN;
INSERT INTO `tool_alipay_config` VALUES (1, '2016091700532697', 'utf-8', 'JSON', 'https://openapi.alipaydev.com/gateway.do', 'http://api.auauz.net/api/aliPay/notify', 'MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC5js8sInU10AJ0cAQ8UMMyXrQ+oHZEkVt5lBwsStmTJ7YikVYgbskx1YYEXTojRsWCb+SH/kDmDU4pK/u91SJ4KFCRMF2411piYuXU/jF96zKrADznYh/zAraqT6hvAIVtQAlMHN53nx16rLzZ/8jDEkaSwT7+HvHiS+7sxSojnu/3oV7BtgISoUNstmSe8WpWHOaWv19xyS+Mce9MY4BfseFhzTICUymUQdd/8hXA28/H6osUfAgsnxAKv7Wil3aJSgaJczWuflYOve0dJ3InZkhw5Cvr0atwpk8YKBQjy5CdkoHqvkOcIB+cYHXJKzOE5tqU7inSwVbHzOLQ3XbnAgMBAAECggEAVJp5eT0Ixg1eYSqFs9568WdetUNCSUchNxDBu6wxAbhUgfRUGZuJnnAll63OCTGGck+EGkFh48JjRcBpGoeoHLL88QXlZZbC/iLrea6gcDIhuvfzzOffe1RcZtDFEj9hlotg8dQj1tS0gy9pN9g4+EBH7zeu+fyv+qb2e/v1l6FkISXUjpkD7RLQr3ykjiiEw9BpeKb7j5s7Kdx1NNIzhkcQKNqlk8JrTGDNInbDM6inZfwwIO2R1DHinwdfKWkvOTODTYa2MoAvVMFT9Bec9FbLpoWp7ogv1JMV9svgrcF9XLzANZ/OQvkbe9TV9GWYvIbxN6qwQioKCWO4GPnCAQKBgQDgW5MgfhX8yjXqoaUy/d1VjI8dHeIyw8d+OBAYwaxRSlCfyQ+tieWcR2HdTzPca0T0GkWcKZm0ei5xRURgxt4DUDLXNh26HG0qObbtLJdu/AuBUuCqgOiLqJ2f1uIbrz6OZUHns+bT/jGW2Ws8+C13zTCZkZt9CaQsrp3QOGDx5wKBgQDTul39hp3ZPwGNFeZdkGoUoViOSd5Lhowd5wYMGAEXWRLlU8z+smT5v0POz9JnIbCRchIY2FAPKRdVTICzmPk2EPJFxYTcwaNbVqL6lN7J2IlXXMiit5QbiLauo55w7plwV6LQmKm9KV7JsZs5XwqF7CEovI7GevFzyD3w+uizAQKBgC3LY1eRhOlpWOIAhpjG6qOoohmeXOphvdmMlfSHq6WYFqbWwmV4rS5d/6LNpNdL6fItXqIGd8I34jzql49taCmi+A2nlR/E559j0mvM20gjGDIYeZUz5MOE8k+K6/IcrhcgofgqZ2ZED1ksHdB/E8DNWCswZl16V1FrfvjeWSNnAoGAMrBplCrIW5xz+J0Hm9rZKrs+AkK5D4fUv8vxbK/KgxZ2KaUYbNm0xv39c+PZUYuFRCz1HDGdaSPDTE6WeWjkMQd5mS6ikl9hhpqFRkyh0d0fdGToO9yLftQKOGE/q3XUEktI1XvXF0xyPwNgUCnq0QkpHyGVZPtGFxwXiDvpvgECgYA5PoB+nY8iDiRaJNko9w0hL4AeKogwf+4TbCw+KWVEn6jhuJa4LFTdSqp89PktQaoVpwv92el/AhYjWOl/jVCm122f9b7GyoelbjMNolToDwe5pF5RnSpEuDdLy9MfE8LnE3PlbE7E5BipQ3UjSebkgNboLHH/lNZA5qvEtvbfvQ==', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAut9evKRuHJ/2QNfDlLwvN/S8l9hRAgPbb0u61bm4AtzaTGsLeMtScetxTWJnVvAVpMS9luhEJjt+Sbk5TNLArsgzzwARgaTKOLMT1TvWAK5EbHyI+eSrc3s7Awe1VYGwcubRFWDm16eQLv0k7iqiw+4mweHSz/wWyvBJVgwLoQ02btVtAQErCfSJCOmt0Q/oJQjj08YNRV4EKzB19+f5A+HQVAKy72dSybTzAK+3FPtTtNen/+b5wGeat7c32dhYHnGorPkPeXLtsqqUTp1su5fMfd4lElNdZaoCI7osZxWWUo17vBCZnyeXc9fk0qwD9mK6yRAxNbrY72Xx5VqIqwIDAQAB', 'http://api.auauz.net/api/aliPay/return', 'RSA2', '2088102176044281', '');
COMMIT;

-- ----------------------------
-- Table structure for tool_email_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_email_config`;
CREATE TABLE `tool_email_config` (
  `id` bigint NOT NULL COMMENT 'ID',
  `from_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收件人',
  `host` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮件服务器SMTP地址',
  `pass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `port` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '端口',
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发件者用户名',
  `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT COMMENT='邮箱配置';

-- ----------------------------
-- Records of tool_email_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for worker_node
-- ----------------------------
DROP TABLE IF EXISTS `worker_node`;
CREATE TABLE `worker_node` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'auto increment id',
  `host_name` varchar(64) NOT NULL COMMENT '主机名',
  `port` varchar(64) NOT NULL COMMENT '端口',
  `type` int NOT NULL COMMENT '节点类型: ACTUAL 或者 CONTAINER',
  `launch_date` date NOT NULL COMMENT '上线日期',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DB WorkerID Assigner for UID Generator';

-- ----------------------------
-- Records of worker_node
-- ----------------------------
BEGIN;
INSERT INTO `worker_node` VALUES (1, '192.168.31.229', '1637893298885-57505', 2, '2021-11-26', '2021-11-26 10:21:38', '2021-11-26 10:21:38');
INSERT INTO `worker_node` VALUES (2, '192.168.31.229', '1638168748956-24355', 2, '2021-11-29', '2021-11-29 14:52:29', '2021-11-29 14:52:29');
INSERT INTO `worker_node` VALUES (3, '192.168.31.229', '1638169396167-61474', 2, '2021-11-29', '2021-11-29 15:03:16', '2021-11-29 15:03:16');
INSERT INTO `worker_node` VALUES (4, '192.168.31.229', '1638169508724-93391', 2, '2021-11-29', '2021-11-29 15:05:08', '2021-11-29 15:05:08');
INSERT INTO `worker_node` VALUES (5, '192.168.31.229', '1638171589842-29142', 2, '2021-11-29', '2021-11-29 15:39:49', '2021-11-29 15:39:49');
INSERT INTO `worker_node` VALUES (6, '192.168.31.229', '1638172174335-98175', 2, '2021-11-29', '2021-11-29 15:49:34', '2021-11-29 15:49:34');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

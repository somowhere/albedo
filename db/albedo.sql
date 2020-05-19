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

 Date: 19/05/2020 19:17:10
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
-- Records of gen_scheme
-- ----------------------------
INSERT INTO `gen_scheme` VALUES ('e7bb88eeb56e45b6b32403b29179a048', '测试书籍', 'curd', NULL, 'com.albedo.java.modules', 'testBook', NULL, '测试书籍', '测试书籍', 'admin', '4fffc16e9dbab3de1a981b1a181027b3', 0, NULL, '1', '2020-05-19 02:23:43.425', '1', '2020-05-19 02:23:43.425', '0');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `coding` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字符编码',
  `engine` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库引擎',
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
INSERT INTO `gen_table` VALUES ('4fffc16e9dbab3de1a981b1a181027b3', 'test_book', '测试书籍', NULL, NULL, 'TestBook', NULL, NULL, 1, NULL, '1', '2020-05-19 17:40:12.990', '1', '2020-05-19 17:40:12.987', '0');

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
INSERT INTO `gen_table_column` VALUES ('06b7c03c60796b988a967bfff7a59185', '4fffc16e9dbab3de1a981b1a181027b3', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.761', '1');
INSERT INTO `gen_table_column` VALUES ('08abef31727e745744ce2cb6f35dd5a9', '4fffc16e9dbab3de1a981b1a181027b3', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 1, NULL, '1', '2020-05-19 17:40:13.080', '1', '2020-05-19 17:40:13.063', '0');
INSERT INTO `gen_table_column` VALUES ('094520c89ab29d678f1b2313eeb2dd86', '4fffc16e9dbab3de1a981b1a181027b3', 'number', 'key', NULL, 'int(11)', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.751', '1');
INSERT INTO `gen_table_column` VALUES ('0dd19984011fc2bdd5540516471a41c7', '4fffc16e9dbab3de1a981b1a181027b3', 'name_', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.523', '1');
INSERT INTO `gen_table_column` VALUES ('12cb16395c334d746dabea320c7efcfe', '4fffc16e9dbab3de1a981b1a181027b3', 'author_', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.522', '1');
INSERT INTO `gen_table_column` VALUES ('1bd37f9c282bb649c563b9b5ed5f22dd', '4fffc16e9dbab3de1a981b1a181027b3', 'activated_', 'activated_', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.526', '1');
INSERT INTO `gen_table_column` VALUES ('1cfe9d0a6d57b4672f6d197091ee655b', '4fffc16e9dbab3de1a981b1a181027b3', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.530', '1');
INSERT INTO `gen_table_column` VALUES ('1fd5e17020a37da59f0be27555334b4f', '4fffc16e9dbab3de1a981b1a181027b3', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 1, NULL, '1', '2020-05-19 17:40:13.079', '1', '2020-05-19 17:40:13.059', '0');
INSERT INTO `gen_table_column` VALUES ('225aa044d27501dc1fdc6560d5f3a7b8', '4fffc16e9dbab3de1a981b1a181027b3', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.756', '1');
INSERT INTO `gen_table_column` VALUES ('2948d7f37709b0a3ee499743aeac930d', '4fffc16e9dbab3de1a981b1a181027b3', 'number_', 'key', NULL, 'int(11)', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.527', '1');
INSERT INTO `gen_table_column` VALUES ('2af9ff9308447bd0bdb8f24785861e0c', '4fffc16e9dbab3de1a981b1a181027b3', 'author', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.744', '1');
INSERT INTO `gen_table_column` VALUES ('3305235b77c8b08708cc12628f331925', '4fffc16e9dbab3de1a981b1a181027b3', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 1, NULL, '1', '2020-05-19 17:40:13.077', '1', '2020-05-19 17:40:13.008', '0');
INSERT INTO `gen_table_column` VALUES ('38f2598fbfd292feeac543f2d680e96a', '4fffc16e9dbab3de1a981b1a181027b3', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.736', '1');
INSERT INTO `gen_table_column` VALUES ('3e69c255e1dcd5e0953e327227e317f7', '4fffc16e9dbab3de1a981b1a181027b3', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'1', 'between', 'dateselect', '', NULL, 130, 1, NULL, '1', '2020-05-19 17:40:13.079', '1', '2020-05-19 17:40:13.054', '0');
INSERT INTO `gen_table_column` VALUES ('5338f6663cc8952fd43ceca27104f9b6', '4fffc16e9dbab3de1a981b1a181027b3', 'email', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'1', b'0', b'1', b'1', b'1', b'0', 'likeRight', 'input', '', NULL, 50, 1, NULL, '1', '2020-05-19 17:40:13.078', '1', '2020-05-19 17:40:13.021', '0');
INSERT INTO `gen_table_column` VALUES ('574f0f3d0b50dffd452013545c5116dd', '4fffc16e9dbab3de1a981b1a181027b3', 'activated', 'activated', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.750', '1');
INSERT INTO `gen_table_column` VALUES ('5af74bd31b2f0c83a3084de825f1a64a', '4fffc16e9dbab3de1a981b1a181027b3', 'email_', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'1', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 50, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.524', '1');
INSERT INTO `gen_table_column` VALUES ('5e9c32295e42354f47958508dc31e221', '4fffc16e9dbab3de1a981b1a181027b3', 'author', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 1, NULL, '1', '2020-05-19 17:40:13.077', '1', '2020-05-19 17:40:13.013', '0');
INSERT INTO `gen_table_column` VALUES ('5fa2ae73f147984cba7271d00c1cb8b4', '4fffc16e9dbab3de1a981b1a181027b3', 'phone', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'1', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 1, NULL, '1', '2020-05-19 17:40:13.078', '1', '2020-05-19 17:40:13.025', '0');
INSERT INTO `gen_table_column` VALUES ('5feea0672ba8987514d1869ee1763188', '4fffc16e9dbab3de1a981b1a181027b3', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.757', '1');
INSERT INTO `gen_table_column` VALUES ('6300b231eb05ad95b67e6172acff45cd', '4fffc16e9dbab3de1a981b1a181027b3', 'name', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.745', '1');
INSERT INTO `gen_table_column` VALUES ('688277b488f44f11afba11340e1df325', '4fffc16e9dbab3de1a981b1a181027b3', 'amount', 'amount', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 1, NULL, '1', '2020-05-19 17:40:13.079', '1', '2020-05-19 17:40:13.042', '0');
INSERT INTO `gen_table_column` VALUES ('742ae900ae3298a49c7c407fa921e30f', '4fffc16e9dbab3de1a981b1a181027b3', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.522', '1');
INSERT INTO `gen_table_column` VALUES ('7550d7cea03502a44615c4d8704c25fd', '4fffc16e9dbab3de1a981b1a181027b3', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 1, NULL, '1', '2020-05-19 17:40:13.079', '1', '2020-05-19 17:40:13.046', '0');
INSERT INTO `gen_table_column` VALUES ('76ab4358af19caaab1329d535367123a', '4fffc16e9dbab3de1a981b1a181027b3', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.742', '1');
INSERT INTO `gen_table_column` VALUES ('7785585acdadf0e467e9ab680963a9d3', '4fffc16e9dbab3de1a981b1a181027b3', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 160, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.532', '1');
INSERT INTO `gen_table_column` VALUES ('79ce4b631d794ee5b820a28d3f29207e', '4fffc16e9dbab3de1a981b1a181027b3', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.533', '1');
INSERT INTO `gen_table_column` VALUES ('90927ca00879c70fa2ce4c844f73747a', '4fffc16e9dbab3de1a981b1a181027b3', 'money_', 'money_', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.528', '1');
INSERT INTO `gen_table_column` VALUES ('98e0785647e0e549ef0f600ee61b16ee', '4fffc16e9dbab3de1a981b1a181027b3', 'money', 'money', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 1, NULL, '1', '2020-05-19 17:40:13.079', '1', '2020-05-19 17:40:13.038', '0');
INSERT INTO `gen_table_column` VALUES ('9a871d625abca090d776923554ef63b7', '4fffc16e9dbab3de1a981b1a181027b3', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'1', 'between', 'dateselect', '', NULL, 130, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.530', '1');
INSERT INTO `gen_table_column` VALUES ('9d31a8545b470b798373c9f343720cee', '4fffc16e9dbab3de1a981b1a181027b3', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.755', '1');
INSERT INTO `gen_table_column` VALUES ('9dbc44946647b8c8d93cf04c915bdbc7', '4fffc16e9dbab3de1a981b1a181027b3', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 160, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.759', '1');
INSERT INTO `gen_table_column` VALUES ('a44932c1baf455365da735f5ac5dd049', '4fffc16e9dbab3de1a981b1a181027b3', 'money', 'money', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.753', '1');
INSERT INTO `gen_table_column` VALUES ('a7e9c333cef3f90595598a194ceb43f0', '4fffc16e9dbab3de1a981b1a181027b3', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 1, NULL, '1', '2020-05-19 17:40:13.080', '1', '2020-05-19 17:40:13.071', '0');
INSERT INTO `gen_table_column` VALUES ('a8eef5693fb026205fa58f95b3903191', '4fffc16e9dbab3de1a981b1a181027b3', 'phone', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.749', '1');
INSERT INTO `gen_table_column` VALUES ('aa0dd44b4c0de88b38d65a453b03e525', '4fffc16e9dbab3de1a981b1a181027b3', 'amount', 'amount', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.754', '1');
INSERT INTO `gen_table_column` VALUES ('acdcb3d783ef31c2c14c92b0226d1e2a', '4fffc16e9dbab3de1a981b1a181027b3', 'amount_', 'amount_', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.528', '1');
INSERT INTO `gen_table_column` VALUES ('ae9cacf80a8ea45bbacef72c624423d7', '4fffc16e9dbab3de1a981b1a181027b3', 'name', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 1, NULL, '1', '2020-05-19 17:40:13.078', '1', '2020-05-19 17:40:13.017', '0');
INSERT INTO `gen_table_column` VALUES ('bbeb5f3fe7ba7696dc8dc134dee6402f', '4fffc16e9dbab3de1a981b1a181027b3', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.754', '1');
INSERT INTO `gen_table_column` VALUES ('bf8de1af4c6957f76a8c14d6814c03ed', '4fffc16e9dbab3de1a981b1a181027b3', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.531', '1');
INSERT INTO `gen_table_column` VALUES ('bfe88d79653b0eb5c1abb81e3b7813f3', '4fffc16e9dbab3de1a981b1a181027b3', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.529', '1');
INSERT INTO `gen_table_column` VALUES ('c14fe14e03b2f43c1f7c1b3d17b07413', '4fffc16e9dbab3de1a981b1a181027b3', 'phone_', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'1', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 60, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.526', '1');
INSERT INTO `gen_table_column` VALUES ('cbee31a9746d28dfba52a242919c7903', '4fffc16e9dbab3de1a981b1a181027b3', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.531', '1');
INSERT INTO `gen_table_column` VALUES ('d37e0f6c1f5c72b345400b1916fa6061', '4fffc16e9dbab3de1a981b1a181027b3', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.758', '1');
INSERT INTO `gen_table_column` VALUES ('d951d1d35f89ef6dd092ba7d27f9066a', '4fffc16e9dbab3de1a981b1a181027b3', 'activated', 'activated', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 1, NULL, '1', '2020-05-19 17:40:13.078', '1', '2020-05-19 17:40:13.030', '0');
INSERT INTO `gen_table_column` VALUES ('dae61c67a450bde9e4629b054fb24fd3', '4fffc16e9dbab3de1a981b1a181027b3', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 160, 1, NULL, '1', '2020-05-19 17:40:13.080', '1', '2020-05-19 17:40:13.067', '0');
INSERT INTO `gen_table_column` VALUES ('dff068fc2248d93c69a53545d70330cc', '4fffc16e9dbab3de1a981b1a181027b3', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.533', '1');
INSERT INTO `gen_table_column` VALUES ('e080f2bba7ff3dd0f6acfe87f9ec7d0b', '4fffc16e9dbab3de1a981b1a181027b3', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.760', '1');
INSERT INTO `gen_table_column` VALUES ('e51dff43b7dcfb566314cc552bcf36ce', '4fffc16e9dbab3de1a981b1a181027b3', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2020-05-19 17:33:45.396', '1', '2020-05-19 02:22:04.518', '1');
INSERT INTO `gen_table_column` VALUES ('f0a945e58fb40cc18175a6886c3c7f0e', '4fffc16e9dbab3de1a981b1a181027b3', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 1, NULL, '1', '2020-05-19 17:40:13.079', '1', '2020-05-19 17:40:13.050', '0');
INSERT INTO `gen_table_column` VALUES ('f1032b9ed9ca33a998079d0513384bb3', '4fffc16e9dbab3de1a981b1a181027b3', 'email', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2020-05-19 17:39:09.684', '1', '2020-05-19 17:33:45.747', '1');
INSERT INTO `gen_table_column` VALUES ('f31f766f6b538c603ec155bb709b1d42', '4fffc16e9dbab3de1a981b1a181027b3', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 1, NULL, '1', '2020-05-19 17:40:13.077', '1', '2020-05-19 17:40:13.002', '0');
INSERT INTO `gen_table_column` VALUES ('fa3ead32ec6d698dbadc731df8ad5344', '4fffc16e9dbab3de1a981b1a181027b3', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 1, NULL, '1', '2020-05-19 17:40:13.080', '1', '2020-05-19 17:40:13.076', '0');
INSERT INTO `gen_table_column` VALUES ('fa6f522d0617804c29555f557111ba8d', '4fffc16e9dbab3de1a981b1a181027b3', 'number', 'key', NULL, 'int(11)', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 1, NULL, '1', '2020-05-19 17:40:13.078', '1', '2020-05-19 17:40:13.034', '0');

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
  `last_checkin_time` bigint(20) NOT NULL,
  `checkin_interval` bigint(20) NOT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 910 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log_operate
-- ----------------------------
INSERT INTO `sys_log_operate` VALUES (802, '', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/authenticate', NULL, 'password=admin&randomStr=94121589824686755&rememberMe=true&code=%E5%95%8A111&username=admin', NULL, 'MANAGE', 'LOGIN', NULL, '1', '2020-05-19 01:59:13.426', '登录成功', '0');
INSERT INTO `sys_log_operate` VALUES (803, '支付宝PC网页支付', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/tool/aliPay/toPayAsPC', 'com.albedo.java.modules.tool.web.AliPayResource.toPayAsPc()', '{ trade: TradeVo(body=1, subject=1, outTradeNo=null, tradeNo=null, totalAmount=1, state=null, createTime=null, cancelTime=null) }', '56', 'MANAGE', 'OTHER', NULL, '1', '2020-05-19 02:00:36.254', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (804, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '67', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:01:17.486', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (805, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=ef2382c0cc2d99ee73444e684237a88a, blurry=null, type=null, createdDate=null) }', '41', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:01:21.695', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (806, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/sort-update', 'com.albedo.java.modules.sys.web.MenuResource.sortUpdate()', '{ menuSortDto: MenuSortDto(menuSortList=[MenuSortItemDto(id=2500, sort=20)]) }', '26', 'MANAGE', 'EDIT', NULL, '1', '2020-05-19 02:01:28.300', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (807, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '42', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:01:28.650', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (808, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '47', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:01:33.602', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (809, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '17', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:01:36.030', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (810, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:01:37.968', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (811, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:01:42.481', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (812, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '8', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:01:43.847', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (813, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:01:45.409', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (814, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:02.307', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (815, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '44', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:06.478', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (816, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=ef2382c0cc2d99ee73444e684237a88a, blurry=null, type=null, createdDate=null) }', '29', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:08.175', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (817, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=2000, blurry=null, type=null, createdDate=null) }', '30', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:10.200', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (818, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: MenuDto(permission=null, icon=swagger, component=tool/swagger/index, type=1, hidden=0, cache=0, iframe=0, path=swagger2) }', '52', 'MANAGE', 'EDIT', NULL, '1', '2020-05-19 02:17:26.879', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (819, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '55', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:27.292', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (820, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=d9d87cf8ed7c29ed2eda06d5dec4dcda, blurry=null, type=null, createdDate=null) }', '34', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:29.209', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (821, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=ef2382c0cc2d99ee73444e684237a88a, blurry=null, type=null, createdDate=null) }', '30', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:31.455', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (822, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: MenuDto(permission=null, icon=email, component=tool/email/index, type=1, hidden=0, cache=0, iframe=0, path=email) }', '42', 'MANAGE', 'EDIT', NULL, '1', '2020-05-19 02:17:42.429', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (823, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '36', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:42.826', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (824, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=ef2382c0cc2d99ee73444e684237a88a, blurry=null, type=null, createdDate=null) }', '27', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:44.497', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (825, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()', '{ menuDto: MenuDto(permission=null, icon=alipay, component=tool/alipay/index, type=1, hidden=0, cache=0, iframe=0, path=alipay) }', '47', 'MANAGE', 'EDIT', NULL, '1', '2020-05-19 02:17:53.030', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (826, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '34', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:53.423', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (827, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '34', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:17:57.854', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (828, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:18:13.486', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (829, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:18:15.455', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (830, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()', '{ tableDto: TableDto(name=test_book, comments=测试书籍, className=TestBook, parentTable=null, parentTableFk=null, parent=null, childList=[], nameAndTitle=test_book  :  测试书籍, nameLike=null, pkList=[id], category=null, pkColumnList=[TableColumnDto(tableId=null, table=null, name=id, title=id, comments=null, jdbcType=varchar(32), javaType=String, javaField=id, isPk=true, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=10, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=id  :  id)], columnList=[TableColumnDto(tableId=null, table=null, name=id, title=id, comments=null, jdbcType=varchar(32), javaType=String, javaField=id, isPk=true, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=10, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=id  :  id), TableColumnDto(tableId=null, table=null, name=title_, title=标题, comments=null, jdbcType=varchar(32), javaType=String, javaField=title, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=true, queryType=like, showType=input, dictType=, sort=20, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=title_  :  标题), TableColumnDto(tableId=null, table=null, name=author_, title=作者, comments=null, jdbcType=varchar(50), javaType=String, javaField=author, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=30, hibernateValidatorExprssion=@NotBlank @Size(max=50), nameAndTitle=author_  :  作者), TableColumnDto(tableId=null, table=null, name=name_, title=名称, comments=null, jdbcType=varchar(50), javaType=String, javaField=name, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=true, queryType=like, showType=input, dictType=, sort=40, hibernateValidatorExprssion=@Size(max=50), nameAndTitle=name_  :  名称), TableColumnDto(tableId=null, table=null, name=email_, title=邮箱, comments=null, jdbcType=varchar(100), javaType=String, javaField=email, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=50, hibernateValidatorExprssion=@Email @Size(max=100), nameAndTitle=email_  :  邮箱), TableColumnDto(tableId=null, table=null, name=phone_, title=手机, comments=null, jdbcType=varchar(32), javaType=String, javaField=phone, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=60, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=phone_  :  手机), TableColumnDto(tableId=null, table=null, name=activated_, title=activated_, comments=null, jdbcType=bit(1), javaType=Integer, javaField=activated, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=70, hibernateValidatorExprssion=@NotNull , nameAndTitle=activated_  :  activated_), TableColumnDto(tableId=null, table=null, name=number_, title=key, comments=null, jdbcType=int(11), javaType=Long, javaField=number, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=80, hibernateValidatorExprssion=, nameAndTitle=number_  :  key), TableColumnDto(tableId=null, table=null, name=money_, title=money_, comments=null, jdbcType=decimal(20,2), javaType=Double, javaField=money, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=90, hibernateValidatorExprssion=, nameAndTitle=money_  :  money_), TableColumnDto(tableId=null, table=null, name=amount_, title=amount_, comments=null, jdbcType=double(11,2), javaType=Double, javaField=amount, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=100, hibernateValidatorExprssion=, nameAndTitle=amount_  :  amount_), TableColumnDto(tableId=null, table=null, name=reset_date, title=reset_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=resetDate, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=dateselect, dictType=, sort=110, hibernateValidatorExprssion=, nameAndTitle=reset_date  :  reset_date), TableColumnDto(tableId=null, table=null, name=created_by, title=created_by, comments=null, jdbcType=varchar(50), javaType=String, javaField=createdBy, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=120, hibernateValidatorExprssion=@NotBlank @Size(max=50), nameAndTitle=created_by  :  created_by), TableColumnDto(tableId=null, table=null, name=created_date, title=created_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=createdDate, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=dateselect, dictType=, sort=130, hibernateValidatorExprssion=@NotNull , nameAndTitle=created_date  :  created_date), TableColumnDto(tableId=null, table=null, name=last_modified_by, title=last_modified_by, comments=null, jdbcType=varchar(50), javaType=String, javaField=lastModifiedBy, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=140, hibernateValidatorExprssion=@Size(max=50), nameAndTitle=last_modified_by  :  last_modified_by), TableColumnDto(tableId=null, table=null, name=last_modified_date, title=last_modified_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=lastModifiedDate, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=dateselect, dictType=, sort=150, hibernateValidatorExprssion=, nameAndTitle=last_modified_date  :  last_modified_date), TableColumnDto(tableId=null, table=null, name=description, title=备注, comments=null, jdbcType=varchar(255), javaType=String, javaField=description, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=false, isQuery=false, queryType=eq, showType=textarea, dictType=, sort=160, hibernateValidatorExprssion=@Size(max=255), nameAndTitle=description  :  备注), TableColumnDto(tableId=null, table=null, name=version, title=version, comments=null, jdbcType=int(11), javaType=Long, javaField=version, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=170, hibernateValidatorExprssion=, nameAndTitle=version  :  version), TableColumnDto(tableId=null, table=null, name=del_flag, title=0-正常，1-删除, comments=null, jdbcType=char(1), javaType=String, javaField=delFlag, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=radio, dictType=sys_flag, sort=180, hibernateValidatorExprssion=@Size(max=1), nameAndTitle=del_flag  :  0-正常，1-删除)], columnFormList=[TableColumnDto(tableId=null, table=null, name=id, title=id, comments=null, jdbcType=varchar(32), javaType=String, javaField=id, isPk=true, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=10, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=id  :  id), TableColumnDto(tableId=null, table=null, name=title_, title=标题, comments=null, jdbcType=varchar(32), javaType=String, javaField=title, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=true, queryType=like, showType=input, dictType=, sort=20, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=title_  :  标题), TableColumnDto(tableId=null, table=null, name=author_, title=作者, comments=null, jdbcType=varchar(50), javaType=String, javaField=author, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=30, hibernateValidatorExprssion=@NotBlank @Size(max=50), nameAndTitle=author_  :  作者), TableColumnDto(tableId=null, table=null, name=name_, title=名称, comments=null, jdbcType=varchar(50), javaType=String, javaField=name, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=true, queryType=like, showType=input, dictType=, sort=40, hibernateValidatorExprssion=@Size(max=50), nameAndTitle=name_  :  名称), TableColumnDto(tableId=null, table=null, name=email_, title=邮箱, comments=null, jdbcType=varchar(100), javaType=String, javaField=email, isPk=false, isUnique=true, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=true, queryType=like, showType=input, dictType=, sort=50, hibernateValidatorExprssion=@Email @Size(max=100), nameAndTitle=email_  :  邮箱), TableColumnDto(tableId=null, table=null, name=phone_, title=手机, comments=null, jdbcType=varchar(32), javaType=String, javaField=phone, isPk=false, isUnique=true, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=true, queryType=like, showType=input, dictType=, sort=60, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=phone_  :  手机), TableColumnDto(tableId=null, table=null, name=activated_, title=activated_, comments=null, jdbcType=bit(1), javaType=Integer, javaField=activated, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=70, hibernateValidatorExprssion=@NotNull , nameAndTitle=activated_  :  activated_), TableColumnDto(tableId=null, table=null, name=number_, title=key, comments=null, jdbcType=int(11), javaType=Long, javaField=number, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=80, hibernateValidatorExprssion=, nameAndTitle=number_  :  key), TableColumnDto(tableId=null, table=null, name=money_, title=money_, comments=null, jdbcType=decimal(20,2), javaType=Double, javaField=money, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=90, hibernateValidatorExprssion=, nameAndTitle=money_  :  money_), TableColumnDto(tableId=null, table=null, name=amount_, title=amount_, comments=null, jdbcType=double(11,2), javaType=Double, javaField=amount, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=100, hibernateValidatorExprssion=, nameAndTitle=amount_  :  amount_), TableColumnDto(tableId=null, table=null, name=reset_date, title=reset_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=resetDate, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=dateselect, dictType=, sort=110, hibernateValidatorExprssion=, nameAndTitle=reset_date  :  reset_date), TableColumnDto(tableId=null, table=null, name=created_by, title=created_by, comments=null, jdbcType=varchar(50), javaType=String, javaField=createdBy, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=120, hibernateValidatorExprssion=@NotBlank @Size(max=50), nameAndTitle=created_by  :  created_by), TableColumnDto(tableId=null, table=null, name=created_date, title=created_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=createdDate, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=true, queryType=between, showType=dateselect, dictType=, sort=130, hibernateValidatorExprssion=@NotNull , nameAndTitle=created_date  :  created_date), TableColumnDto(tableId=null, table=null, name=last_modified_by, title=last_modified_by, comments=null, jdbcType=varchar(50), javaType=String, javaField=lastModifiedBy, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=140, hibernateValidatorExprssion=@Size(max=50), nameAndTitle=last_modified_by  :  last_modified_by), TableColumnDto(tableId=null, table=null, name=last_modified_date, title=last_modified_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=lastModifiedDate, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=dateselect, dictType=, sort=150, hibernateValidatorExprssion=, nameAndTitle=last_modified_date  :  last_modified_date), TableColumnDto(tableId=null, table=null, name=description, title=备注, comments=null, jdbcType=varchar(255), javaType=String, javaField=description, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=false, isQuery=false, queryType=eq, showType=textarea, dictType=, sort=160, hibernateValidatorExprssion=@Size(max=255), nameAndTitle=description  :  备注), TableColumnDto(tableId=null, table=null, name=version, title=version, comments=null, jdbcType=int(11), javaType=Long, javaField=version, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=170, hibernateValidatorExprssion=, nameAndTitle=version  :  version), TableColumnDto(tableId=null, table=null, name=del_flag, title=0-正常，1-删除, comments=null, jdbcType=char(1), javaType=String, javaField=delFlag, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=radio, dictType=sys_flag, sort=180, hibernateValidatorExprssion=@Size(max=1), nameAndTitle=del_flag  :  0-正常，1-删除)]) }', '413', 'MANAGE', 'EDIT', NULL, '1', '2020-05-19 02:22:04.128', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (831, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '18', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:22:05.352', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (832, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:22:18.936', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (833, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()', '{ schemeDto: SchemeDto(name=测试书籍, category=curd, viewType=null, packageName=com.albedo.java.modules, moduleName=testBook, subModuleName=null, functionName=测试书籍, functionNameSimple=测试书籍, functionAuthor=admin, tableId=4fffc16e9dbab3de1a981b1a181027b3, tableDto=null, genCode=false, replaceFile=false) }', '51', 'MANAGE', 'EDIT', NULL, '1', '2020-05-19 02:23:43.380', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (834, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:23:43.602', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (835, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '13', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:26:47.978', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (836, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '14', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:29:59.227', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (837, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '17', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:39:19.613', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (838, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '42', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:40:16.208', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (839, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=1000, blurry=null, type=null, createdDate=null) }', '47', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:40:18.788', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (840, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=2000, blurry=null, type=null, createdDate=null) }', '38', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:40:21.883', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (841, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=ef2382c0cc2d99ee73444e684237a88a, blurry=null, type=null, createdDate=null) }', '53', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:40:25.354', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (842, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=413892fe8d52c1163d6659f51299dc96, blurry=null, type=null, createdDate=null) }', '23', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:40:36.449', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (843, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=247071d42ff40267c8d8c44eac92da67, blurry=null, type=null, createdDate=null) }', '61', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:40:37.755', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (844, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 02:41:04.689', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (845, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '16', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 10:53:26.388', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (846, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '15', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 10:59:42.988', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (847, '任务调度', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/quartz/job', 'com.albedo.java.modules.quartz.web.JobResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  jobQueryCriteria: JobQueryCriteria(blurry=null, available=null, createdDate=null) }', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 11:21:15.077', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (848, '任务调度', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/quartz/job', 'com.albedo.java.modules.quartz.web.JobResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  jobQueryCriteria: JobQueryCriteria(blurry=null, available=null, createdDate=null) }', '8', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 11:21:27.543', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (849, '任务调度', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/quartz/job', 'com.albedo.java.modules.quartz.web.JobResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  jobQueryCriteria: JobQueryCriteria(blurry=null, available=null, createdDate=null) }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 11:29:38.251', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (850, '任务调度', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/quartz/job', 'com.albedo.java.modules.quartz.web.JobResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  jobQueryCriteria: JobQueryCriteria(blurry=null, available=null, createdDate=null) }', '8', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 11:34:50.913', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (851, '任务调度', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/quartz/job/', 'com.albedo.java.modules.quartz.web.JobResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  jobQueryCriteria: JobQueryCriteria(blurry=null, available=null, createdDate=null) }', '7', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:08:01.420', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (852, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '46', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:08:09.895', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (853, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=ef2382c0cc2d99ee73444e684237a88a, blurry=null, type=null, createdDate=null) }', '42', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:08:15.550', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (854, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=管理, type=null, createdDate=null) }', '60', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:08:26.228', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (855, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=d9d87cf8ed7c29ed2eda06d5dec4dcda, blurry=管理, type=null, createdDate=null) }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:08:28.735', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (856, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=1000, blurry=管理, type=null, createdDate=null) }', '38', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:08:39.940', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (857, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '38', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:09:18.561', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (858, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=null, type=null, createdDate=null) }', '49', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:09:27.065', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (859, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=null, blurry=管理, type=null, createdDate=null) }', '77', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:09:31.196', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (860, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=1000, blurry=管理, type=null, createdDate=null) }', '38', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:09:32.598', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (861, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=1100, blurry=管理, type=null, createdDate=null) }', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:09:34.444', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (862, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=1400, blurry=管理, type=null, createdDate=null) }', '5', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:09:36.979', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (863, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=1300, blurry=管理, type=null, createdDate=null) }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:09:38.418', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (864, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=d9d87cf8ed7c29ed2eda06d5dec4dcda, blurry=管理, type=null, createdDate=null) }', '6', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:09:39.054', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (865, '菜单管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{ menuQueryCriteria: MenuQueryCriteria(notId=null, parentId=2200, blurry=管理, type=null, createdDate=null) }', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:09:40.298', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (866, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:10:34.279', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (867, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '13', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 12:10:52.853', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (868, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '127', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 13:24:04.029', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (869, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '18', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 13:43:32.351', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (870, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '18', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 14:10:03.506', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (871, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '13', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 14:15:09.503', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (872, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '14', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 14:16:03.787', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (873, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '18', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 14:16:39.044', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (874, '用户管理', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.getUserPage()', '{ pm: PageModel(current=1,size=10,orders=[])  userQueryCriteria: UserQueryCriteria(deptIds=null, blurry=null, available=null, deptId=null, createdDate=null) }', '48', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 14:22:20.779', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (875, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '16', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 14:22:36.204', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (876, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '16', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 14:26:04.411', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (877, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=false) }', '459', 'MANAGE', 'GENCODE', NULL, '1', '2020-05-19 15:05:29.240', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (878, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '15', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 15:05:32.176', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (879, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '15', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 15:07:11.020', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (880, '生成方案', 'ERROR', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=true) }', '261', 'MANAGE', 'GENCODE', 'java.lang.RuntimeException: freemarker.core.ParseException: Syntax error in template \"name\" in line 27, column 135:\n#elseif is an existing directive, but the tag is malformed.  (See FreeMarker Manual / Directive Reference.)\r\n	at com.albedo.java.common.core.util.FreeMarkers.renderString(FreeMarkers.java:25)\r\n	at com.albedo.java.modules.gen.util.GenUtil.generateToFile(GenUtil.java:330)\r\n	at com.albedo.java.modules.gen.service.impl.SchemeServiceImpl.generateCode(SchemeServiceImpl.java:101)\r\n	at com.albedo.java.modules.gen.service.impl.SchemeServiceImpl$$FastClassBySpringCGLIB$$ab8b31c4.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:366)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:118)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.albedo.java.modules.gen.service.impl.SchemeServiceImpl$$EnhancerBySpringCGLIB$$7e54aaed.generateCode(<generated>)\r\n	at com.albedo.java.modules.gen.web.SchemeResource.genCode(SchemeResource.java:78)\r\n	at com.albedo.java.modules.gen.web.SchemeResource$$FastClassBySpringCGLIB$$443c5f96.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.albedo.java.common.log.aspect.SysLogAspect.around(SysLogAspect.java:75)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvi', '1', '2020-05-19 16:56:52.847', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (881, '生成方案', 'ERROR', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=true) }', '206', 'MANAGE', 'GENCODE', 'java.lang.RuntimeException: freemarker.core.ParseException: Syntax error in template \"name\" in line 27, column 135:\n#elseif is an existing directive, but the tag is malformed.  (See FreeMarker Manual / Directive Reference.)\r\n	at com.albedo.java.common.core.util.FreeMarkers.renderString(FreeMarkers.java:25)\r\n	at com.albedo.java.modules.gen.util.GenUtil.generateToFile(GenUtil.java:330)\r\n	at com.albedo.java.modules.gen.service.impl.SchemeServiceImpl.generateCode(SchemeServiceImpl.java:101)\r\n	at com.albedo.java.modules.gen.service.impl.SchemeServiceImpl$$FastClassBySpringCGLIB$$ab8b31c4.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:366)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:118)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.albedo.java.modules.gen.service.impl.SchemeServiceImpl$$EnhancerBySpringCGLIB$$7e54aaed.generateCode(<generated>)\r\n	at com.albedo.java.modules.gen.web.SchemeResource.genCode(SchemeResource.java:78)\r\n	at com.albedo.java.modules.gen.web.SchemeResource$$FastClassBySpringCGLIB$$443c5f96.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.albedo.java.common.log.aspect.SysLogAspect.around(SysLogAspect.java:75)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvi', '1', '2020-05-19 16:59:55.495', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (882, '生成方案', 'ERROR', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=true) }', '213', 'MANAGE', 'GENCODE', 'java.lang.RuntimeException: freemarker.core.InvalidReferenceException: The following has evaluated to null or missing:\n==> column  [in template \"name\" at line 21, column 14]\n\n----\nTip: If the failing expression is known to legally refer to something that\'s sometimes null or missing, either specify a default value like myOptionalVar!myDefault, or use <#if myOptionalVar??>when-present<#else>when-missing</#if>. (These only cover the last step of the expression; to cover the whole expression, use parenthesis: (myOptionalVar.foo)!myDefault, (myOptionalVar.foo)??\n----\n\n----\nFTL stack trace (\"~\" means nesting-related):\n	- Failed at: #if column.name != column.simpleJavaF...  [in template \"name\" at line 21, column 9]\n----\r\n	at com.albedo.java.common.core.util.FreeMarkers.renderString(FreeMarkers.java:25)\r\n	at com.albedo.java.modules.gen.util.GenUtil.generateToFile(GenUtil.java:330)\r\n	at com.albedo.java.modules.gen.service.impl.SchemeServiceImpl.generateCode(SchemeServiceImpl.java:101)\r\n	at com.albedo.java.modules.gen.service.impl.SchemeServiceImpl$$FastClassBySpringCGLIB$$ab8b31c4.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:366)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:118)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.albedo.java.modules.gen.service.impl.SchemeServiceImpl$$EnhancerBySpringCGLIB$$7e54aaed.generateCode(<generated>)\r\n	at com.albedo.java.modules.gen.web.SchemeResource.genCode(SchemeResource.java:78)\r\n	at com.albedo.java.modules.gen.web.SchemeResource$$FastClassBySpringCGLIB$$443c5f96.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.albedo.java.common.log.aspect.SysLogAspect.ar', '1', '2020-05-19 17:01:43.483', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (883, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=true) }', '261', 'MANAGE', 'GENCODE', NULL, '1', '2020-05-19 17:04:25.230', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (884, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '21', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:04:28.216', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (885, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=true) }', '244', 'MANAGE', 'GENCODE', NULL, '1', '2020-05-19 17:13:50.762', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (886, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '13', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:13:53.428', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (887, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=true) }', '222', 'MANAGE', 'GENCODE', NULL, '1', '2020-05-19 17:15:28.365', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (888, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:15:30.776', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (889, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:16:19.679', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (890, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '9', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:16:42.959', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (891, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '8', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:18:29.870', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (892, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:20:02.239', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (893, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:20:02.530', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (894, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:21:19.507', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (895, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()', '{ tableDto: TableDto(name=test_book, comments=测试书籍, className=TestBook, parentTable=null, parentTableFk=null, parent=null, childList=[], nameAndTitle=test_book  :  测试书籍, nameLike=null, pkList=[id], category=null, pkColumnList=[TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=id, title=id, comments=null, jdbcType=varchar(32), javaType=String, javaField=id, isPk=true, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=10, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=id  :  id)], columnList=[TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=id, title=id, comments=null, jdbcType=varchar(32), javaType=String, javaField=id, isPk=true, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=10, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=id  :  id), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=title_, title=标题, comments=null, jdbcType=varchar(32), javaType=String, javaField=title, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=true, queryType=like, showType=input, dictType=, sort=20, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=title_  :  标题), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=author, title=作者, comments=null, jdbcType=varchar(50), javaType=String, javaField=author, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=30, hibernateValidatorExprssion=@NotBlank @Size(max=50), nameAndTitle=author  :  作者), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=name, title=名称, comments=null, jdbcType=varchar(50), javaType=String, javaField=name, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=true, queryType=like, showType=input, dictType=, sort=40, hibernateValidatorExprssion=@Size(max=50), nameAndTitle=name  :  名称), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=email, title=邮箱, comments=null, jdbcType=varchar(100), javaType=String, javaField=email, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=50, hibernateValidatorExprssion=@Email @Size(max=100), nameAndTitle=email  :  邮箱), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=phone, title=手机, comments=null, jdbcType=varchar(32), javaType=String, javaField=phone, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=60, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=phone  :  手机), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=activated, title=activated, comments=null, jdbcType=bit(1), javaType=Integer, javaField=activated, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=70, hibernateValidatorExprssion=@NotNull , nameAndTitle=activated  :  activated), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=number, title=key, comments=null, jdbcType=int(11), javaType=Long, javaField=number, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=80, hibernateValidatorExprssion=, nameAndTitle=number  :  key), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=money, title=money, comments=null, jdbcType=decimal(20,2), javaType=Double, javaField=money, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=90, hibernateValidatorExprssion=, nameAndTitle=money  :  money), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=amount, title=amount, comments=null, jdbcType=double(11,2), javaType=Double, javaField=amount, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=100, hibernateValidatorExprssion=, nameAndTitle=amount  :  amount), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=reset_date, title=reset_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=resetDate, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=dateselect, dictType=, sort=110, hibernateValidatorExprssion=, nameAndTitle=reset_date  :  reset_date), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=created_by, title=created_by, comments=null, jdbcType=varchar(50), javaType=String, javaField=createdBy, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=120, hibernateValidatorExprssion=@NotBlank @Size(max=50), nameAndTitle=created_by  :  created_by), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=created_date, title=created_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=createdDate, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=dateselect, dictType=, sort=130, hibernateValidatorExprssion=@NotNull , nameAndTitle=created_date  :  created_date), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=last_modified_by, title=last_modified_by, comments=null, jdbcType=varchar(50), javaType=String, javaField=lastModifiedBy, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=140, hibernateValidatorExprssion=@Size(max=50), nameAndTitle=last_modified_by  :  last_modified_by), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=last_modified_date, title=last_modified_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=lastModifiedDate, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=dateselect, dictType=, sort=150, hibernateValidatorExprssion=, nameAndTitle=last_modified_date  :  last_modified_date), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=description, title=备注, comments=null, jdbcType=varchar(255), javaType=String, javaField=description, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=false, isQuery=false, queryType=eq, showType=textarea, dictType=, sort=160, hibernateValidatorExprssion=@Size(max=255), nameAndTitle=description  :  备注), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=version, title=version, comments=null, jdbcType=int(11), javaType=Long, javaField=version, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=170, hibernateValidatorExprssion=, nameAndTitle=version  :  version), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=del_flag, title=0-正常，1-删除, comments=null, jdbcType=char(1), javaType=String, javaField=delFlag, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=radio, dictType=sys_flag, sort=180, hibernateValidatorExprssion=@Size(max=1), nameAndTitle=del_flag  :  0-正常，1-删除)], columnFormList=[TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=id, title=id, comments=null, jdbcType=varchar(32), javaType=String, javaField=id, isPk=true, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=10, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=id  :  id), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=title_, title=标题, comments=null, jdbcType=varchar(32), javaType=String, javaField=title, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=true, queryType=like, showType=input, dictType=, sort=20, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=title_  :  标题), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=author, title=作者, comments=null, jdbcType=varchar(50), javaType=String, javaField=author, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=30, hibernateValidatorExprssion=@NotBlank @Size(max=50), nameAndTitle=author  :  作者), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=name, title=名称, comments=null, jdbcType=varchar(50), javaType=String, javaField=name, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=true, queryType=like, showType=input, dictType=, sort=40, hibernateValidatorExprssion=@Size(max=50), nameAndTitle=name  :  名称), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=email, title=邮箱, comments=null, jdbcType=varchar(100), javaType=String, javaField=email, isPk=false, isUnique=true, isNull=false, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=likeRight, showType=input, dictType=, sort=50, hibernateValidatorExprssion=@Email @Size(max=100), nameAndTitle=email  :  邮箱), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=phone, title=手机, comments=null, jdbcType=varchar(32), javaType=String, javaField=phone, isPk=false, isUnique=true, isNull=false, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=60, hibernateValidatorExprssion=@Size(max=32), nameAndTitle=phone  :  手机), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=activated, title=activated, comments=null, jdbcType=bit(1), javaType=Integer, javaField=activated, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=70, hibernateValidatorExprssion=@NotNull , nameAndTitle=activated  :  activated), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=number, title=key, comments=null, jdbcType=int(11), javaType=Long, javaField=number, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=80, hibernateValidatorExprssion=, nameAndTitle=number  :  key), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=money, title=money, comments=null, jdbcType=decimal(20,2), javaType=Double, javaField=money, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=90, hibernateValidatorExprssion=, nameAndTitle=money  :  money), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=amount, title=amount, comments=null, jdbcType=double(11,2), javaType=Double, javaField=amount, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=input, dictType=, sort=100, hibernateValidatorExprssion=, nameAndTitle=amount  :  amount), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=reset_date, title=reset_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=resetDate, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=true, isQuery=false, queryType=eq, showType=dateselect, dictType=, sort=110, hibernateValidatorExprssion=, nameAndTitle=reset_date  :  reset_date), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=created_by, title=created_by, comments=null, jdbcType=varchar(50), javaType=String, javaField=createdBy, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=120, hibernateValidatorExprssion=@NotBlank @Size(max=50), nameAndTitle=created_by  :  created_by), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=created_date, title=created_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=createdDate, isPk=false, isUnique=false, isNull=false, isInsert=true, isEdit=false, isList=false, isQuery=true, queryType=between, showType=dateselect, dictType=, sort=130, hibernateValidatorExprssion=@NotNull , nameAndTitle=created_date  :  created_date), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=last_modified_by, title=last_modified_by, comments=null, jdbcType=varchar(50), javaType=String, javaField=lastModifiedBy, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=140, hibernateValidatorExprssion=@Size(max=50), nameAndTitle=last_modified_by  :  last_modified_by), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=last_modified_date, title=last_modified_date, comments=null, jdbcType=timestamp(3), javaType=java.util.Date, javaField=lastModifiedDate, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=dateselect, dictType=, sort=150, hibernateValidatorExprssion=, nameAndTitle=last_modified_date  :  last_modified_date), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=description, title=备注, comments=null, jdbcType=varchar(255), javaType=String, javaField=description, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=true, isList=false, isQuery=false, queryType=eq, showType=textarea, dictType=, sort=160, hibernateValidatorExprssion=@Size(max=255), nameAndTitle=description  :  备注), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=version, title=version, comments=null, jdbcType=int(11), javaType=Long, javaField=version, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=input, dictType=, sort=170, hibernateValidatorExprssion=, nameAndTitle=version  :  version), TableColumnDto(tableId=4fffc16e9dbab3de1a981b1a181027b3, table=null, name=del_flag, title=0-正常，1-删除, comments=null, jdbcType=char(1), javaType=String, javaField=delFlag, isPk=false, isUnique=false, isNull=true, isInsert=true, isEdit=false, isList=false, isQuery=false, queryType=eq, showType=radio, dictType=sys_flag, sort=180, hibernateValidatorExprssion=@Size(max=1), nameAndTitle=del_flag  :  0-正常，1-删除)]) }', '426', 'MANAGE', 'EDIT', NULL, '1', '2020-05-19 17:40:12.656', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (896, '业务表', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  tableQueryCriteria: TableQueryCriteria(blurry=null, createdDate=null) }', '36', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:40:13.915', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (897, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '20', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:40:23.418', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (898, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=true) }', '185', 'MANAGE', 'GENCODE', NULL, '1', '2020-05-19 17:40:34.369', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (899, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '14', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 17:40:36.934', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (900, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=true) }', '170', 'MANAGE', 'GENCODE', NULL, '1', '2020-05-19 18:03:24.974', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (901, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=null) }', '10', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 18:03:27.410', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (902, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=[2020-05-18 00:00:00.0, 2020-05-20 23:59:59.0]) }', '15', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 18:07:00.776', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (903, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=[2020-05-18 00:00:00.0, 2020-05-20 23:59:59.0]) }', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 18:07:17.097', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (904, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=[2020-05-18 00:00:00.0, 2020-05-20 23:59:59.0]) }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 18:08:33.193', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (905, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=[2020-05-18 00:00:00.0, 2020-05-20 23:59:59.0]) }', '10', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 18:08:49.303', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (906, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=true) }', '225', 'MANAGE', 'GENCODE', NULL, '1', '2020-05-19 19:03:09.526', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (907, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=[2020-05-18 00:00:00.0, 2020-05-20 23:59:59.0]) }', '12', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 19:03:12.268', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (908, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/gen-code', 'com.albedo.java.modules.gen.web.SchemeResource.genCode()', '{ genCodeDto: GenCodeDto(id=e7bb88eeb56e45b6b32403b29179a048, replaceFile=true) }', '236', 'MANAGE', 'GENCODE', NULL, '1', '2020-05-19 19:16:22.212', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (909, '生成方案', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()', '{ pm: PageModel(current=1,size=10,orders=[])  schemeQueryCriteria: SchemeQueryCriteria(blurry=null, createdDate=[2020-05-18 00:00:00.0, 2020-05-20 23:59:59.0]) }', '11', 'MANAGE', 'VIEW', NULL, '1', '2020-05-19 19:16:24.815', NULL, '0');

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
INSERT INTO `sys_menu` VALUES ('10bd98f30a42427dd7ef75418ad3da6b', '邮件工具', '1', NULL, 'email', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'email', 'tool/email/index', b'0', b'0', b'0', b'1', 30, '1', '2020-05-17 17:56:56.008', '1', '2020-05-19 02:17:42.461', NULL, 1, '0');
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
INSERT INTO `sys_menu` VALUES ('1ae562534a64d4473899e52497c40b2e', '二级菜单1', '1', NULL, 'menu1', 'eb17cee437ea6b630dad59fff2a059ca', 'eb17cee437ea6b630dad59fff2a059ca,', 'dev', 'nested/menu1/index', b'0', b'0', b'0', b'0', 10, '1', '2020-05-18 11:10:06.354', '1', '2020-05-18 11:14:45.745', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('2000', '系统监控', '0', NULL, '/sys', '-1', NULL, 'system', 'Layout', b'0', b'0', b'0', b'0', 20, '', '2017-11-07 20:56:00.000', '1', '2020-05-17 16:52:02.575', NULL, 39, '0');
INSERT INTO `sys_menu` VALUES ('2100', '操作日志', '1', NULL, 'log-operate', '2000', '2000,', 'log', 'monitor/log-operate/index', b'0', b'0', b'0', b'0', 40, '', '2017-11-20 14:06:22.000', '1', '2020-05-17 10:23:57.530', NULL, 12, '0');
INSERT INTO `sys_menu` VALUES ('2101', '操作日志删除', '2', 'sys_logOperate_del', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '', '2017-11-20 20:37:37.000', '1', '2020-05-17 10:23:57.545', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('2200', '字典管理', '1', 'sys_dict_view', 'dict', '1000', '1000,', 'dictionary', 'sys/dict/index', b'0', b'0', b'0', b'0', 50, '', '2017-11-29 11:30:52.000', '1', '2020-05-16 17:56:34.943', NULL, 11, '0');
INSERT INTO `sys_menu` VALUES ('2201', '字典删除', '2', 'sys_dict_del', NULL, '2200', '1000,2200,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '', '2017-11-29 11:30:11.000', '1', '2020-05-16 17:55:19.918', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('2202', '字典编辑', '2', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2018-05-11 22:34:55.000', '1', '2020-05-16 13:24:22.800', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('23430df88fb72179c2a85c39eaf4d50b', '任务调度日志清空', '2', 'quartz_jobLog_clean', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2019-08-15 16:12:26.285', '1', '2020-05-16 15:40:21.370', NULL, 2, '1');
INSERT INTO `sys_menu` VALUES ('247071d42ff40267c8d8c44eac92da67', '生成方案', '1', NULL, 'scheme', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'dev', 'gen/scheme/index', b'0', b'0', b'0', b'0', 30, '1', '2019-07-21 13:27:35.000', '1', '2020-05-18 11:39:42.026', NULL, 21, '0');
INSERT INTO `sys_menu` VALUES ('2500', '接口文档', '1', NULL, 'swagger2', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'swagger', 'tool/swagger/index', b'0', b'0', b'0', b'1', 20, '', '2018-06-26 10:50:32.000', '1', '2020-05-19 02:17:26.914', NULL, 8, '0');
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
INSERT INTO `sys_menu` VALUES ('413892fe8d52c1163d6659f51299dc96', '代码生成', '0', NULL, '/gen', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'codeConsole', 'gen/index', b'0', b'0', b'0', b'0', 10, '1', '2019-07-20 12:00:48.000', '1', '2020-05-18 11:39:41.987', NULL, 47, '0');
INSERT INTO `sys_menu` VALUES ('52715698214e88cb09fa4dd1ea5ad348', '生成方案菜单', '2', 'gen_scheme_menu', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-25 13:03:03.000', '1', '2020-05-18 11:39:42.037', NULL, 8, '0');
INSERT INTO `sys_menu` VALUES ('5404c3df9f771dbc0237578814bbe44b', 'Yaml编辑器', '1', NULL, 'yaml', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'dev', 'components/YamlEdit', b'0', b'0', b'0', b'1', 50, '1', '2020-05-15 21:22:43.364', '1', '2020-05-15 21:22:43.364', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('5431004fa397e0280fd75c4a3b73c4aa', '登录日志查看', '2', 'sys_logLogin_view', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-15 09:26:02.349', '1', '2020-05-17 14:55:26.848', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('54cd27f34ca7e9a8848b92377468965d', 'test', '1', 'test', 'tes', '-1', NULL, 'Steve-Jobs', 'tes', b'1', b'0', b'1', b'0', 999, '1', '2020-05-14 18:16:52.599', '1', '2020-05-15 21:07:50.836', NULL, 2, '1');
INSERT INTO `sys_menu` VALUES ('5b39ca5a25c772105c71f8c51d1f19d4', '三级菜单1', '1', NULL, 'menu1-1', '1ae562534a64d4473899e52497c40b2e', 'eb17cee437ea6b630dad59fff2a059ca,1ae562534a64d4473899e52497c40b2e,', 'dev', 'nested/menu1/menu1-1', b'0', b'0', b'0', b'1', 30, '1', '2020-05-18 11:11:16.436', '1', '2020-05-18 11:13:40.823', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('5da31e19f05edeea6a7041e3101deefe', '任务日志删除', '2', 'quartz_jobLog_del', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:17.702', NULL, 4, '1');
INSERT INTO `sys_menu` VALUES ('618ee4b9660265a85a8b61277de2a579', '富文本', '1', NULL, 'editor', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'fwb', 'components/Editor', b'0', b'0', b'0', b'1', 30, '1', '2020-05-15 21:16:40.552', '1', '2020-05-15 21:16:50.233', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('621e50e1c7d66a1febeb699bebb2fe35', '任务调度执行', '2', 'quartz_job_run', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 20, '1', '2019-08-15 16:10:59.000', '1', '2020-05-16 12:11:01.548', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('64b61b8966e1c74d9b309069b2f622d1', '图标库', '1', NULL, 'icons', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'icon', 'components/icons/index', b'0', b'0', b'0', b'1', 10, '1', '2020-05-15 21:14:28.945', '1', '2020-05-15 21:15:00.712', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('6e3f89cda84ac2c6e715e7812c102ae8', '在线用户', '1', '', 'user-online', '2000', '2000,', 'Steve-Jobs', 'monitor/user-online/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-07 09:03:52.000', '1', '2020-05-16 17:55:59.718', NULL, 10, '0');
INSERT INTO `sys_menu` VALUES ('74f2b2a8871a298e0acc4d7129d10e9c', '任务调度', '1', NULL, 'job', '1000', '1000,', 'timing', 'quartz/job/index', b'0', b'0', b'0', b'0', 60, '1', '2019-08-14 10:36:47.081', '1', '2020-05-16 17:56:34.966', NULL, 22, '0');
INSERT INTO `sys_menu` VALUES ('76d6087052dc26b32f3efa71b9cc119b', '任务调度日志', '2', 'quartz_jobLog_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 50, '1', '2019-08-15 16:11:30.986', '1', '2020-05-16 13:43:44.992', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('7754b1457826c48290bc189bb1289740', '支付宝工具', '1', NULL, 'alipay', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'alipay', 'tool/alipay/index', b'0', b'0', b'0', b'1', 40, '1', '2020-05-17 17:58:06.876', '1', '2020-05-19 02:17:53.063', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('795b4d5cf0eb3ed80e24cbab39727b9d', 'Markdown', '1', NULL, 'markdown', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'markdown', 'components/MarkDown', b'0', b'0', b'0', b'1', 40, '1', '2020-05-15 21:21:46.675', '1', '2020-05-15 21:22:53.122', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('7b14af9e9fbff286856338a194422b07', '令牌查看', '2', 'sys_persistentToken_view', NULL, '2600', '2600,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-08 09:44:25.617', '1', '2020-05-16 17:57:31.295', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('7c7a876f4cceba2dd92aa539dea6b6e5', '任务日志清空', '2', 'quartz_jobLog_clean', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-15 13:55:37.892', '1', '2020-05-16 13:43:17.774', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('8d3517427e527df11d51da528261c915', '测试树管理', '1', NULL, 'test-tree-book', '413892fe8d52c1163d6659f51299dc96', NULL, 'dev', 'test/test-tree-book/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-11 14:32:06.849', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('92f78825551a22fa130c03066f398448', '在线用户删除', '2', 'sys_userOnline_del', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 09:06:33.448', '1', '2020-05-16 17:55:59.728', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('94b57a562063d103423e2c6125cb30ad', '菜单查看', '2', 'sys_menu_view', NULL, '1200', '1200,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:27:59.697', '1', '2020-05-15 21:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('9763343d9cce11ce9eb4f21c8e49122b', '任务调度编辑', '2', 'quartz_job_edit', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-14 10:36:47.088', '1', '2020-05-16 12:11:35.820', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('97722c6d56c8b9990cc3c1a6eea3d6bb', '业务表编辑', '1', 'gen_table_edit', 'edit', '413892fe8d52c1163d6659f51299dc96', 'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,', NULL, 'gen/table/edit', b'1', b'0', b'0', b'1', 20, '1', '2019-07-21 13:24:02.000', '1', '2020-05-18 11:39:42.048', NULL, 10, '0');
INSERT INTO `sys_menu` VALUES ('9f02e346b5350366968f217daef3f1b7', '图表库', '1', NULL, 'Echarts', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'chart', 'components/Echarts', b'0', b'0', b'0', b'1', 20, '1', '2020-05-15 21:12:39.827', '1', '2020-05-15 21:15:09.128', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('a18b33e15bde209a3c9115517c56d9ec', '业务表', '1', '', 'table', '413892fe8d52c1163d6659f51299dc96', 'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,', 'database', 'gen/table/index', b'0', b'0', b'0', b'0', 10, '1', '2019-07-20 12:02:02.000', '1', '2020-05-18 11:39:42.059', NULL, 23, '0');
INSERT INTO `sys_menu` VALUES ('a41d4ac1a6cc179696e0dbf284e3efc4', '登录日志', '1', NULL, 'log-login', '2000', '2000,', 'log', 'monitor//log-login/index', b'0', b'0', b'0', b'0', 50, '1', '2019-08-15 09:26:02.345', '1', '2020-05-17 14:55:36.150', NULL, 8, '1');
INSERT INTO `sys_menu` VALUES ('b8eafb6c3a8bf0919230f0bfa59d86b6', '二级菜单2', '1', NULL, 'menu2', 'eb17cee437ea6b630dad59fff2a059ca', 'eb17cee437ea6b630dad59fff2a059ca,', 'dev', 'nested/menu2/index', b'0', b'0', b'0', b'1', 30, '1', '2020-05-18 11:14:32.907', '1', '2020-05-18 11:15:14.535', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('b961670cbf3454f5927c4bd2a327e915', '生成方案删除', '2', 'gen_scheme_del', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:30:18.000', '1', '2020-05-18 11:39:42.072', NULL, 8, '0');
INSERT INTO `sys_menu` VALUES ('b963a451117f430703817b3b6c87402a', '任务调度日志导出', '2', 'quartz_jobLog_export', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 60, '1', '2019-08-15 16:13:16.742', '1', '2020-05-16 13:43:54.409', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('bb9dd4b7a2a462193d0f01517308f812', '业务表查看', '2', 'gen_table_view', NULL, 'a18b33e15bde209a3c9115517c56d9ec', 'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:47:39.828', '1', '2020-05-18 11:39:42.081', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('bd62904371247f56594741ff8e9bded9', '用户导出', '2', 'sys_user_export', NULL, '1100', '1000,1100,', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2019-08-07 17:50:02.000', '1', '2020-05-15 21:06:35.180', NULL, 7, '0');
INSERT INTO `sys_menu` VALUES ('c0ba37c10abaecd89a738c5cf2a2fd24', '服务监控', '1', 'sys_monitor_view', 'server', '2000', '2000,', 'codeConsole', 'monitor/server/index', b'0', b'0', b'0', b'1', 40, '1', '2019-08-05 17:21:10.000', '1', '2020-05-17 16:52:02.586', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('c77855e4171d00ae3f97563a8391f70a', '任务调度方案', '1', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-14 10:36:03.593', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c93f8fca7ca6f8631d383b08ab67009a', '任务日志', '1', NULL, 'job-log', '2000', '2000,', 'log', 'quartz/job-log/index', b'0', b'0', b'0', b'0', 60, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:26.449', NULL, 14, '1');
INSERT INTO `sys_menu` VALUES ('caaec41413c5713c6f290efe08c11415', '生成方案查看', '2', 'gen_scheme_view', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:48:09.000', '1', '2020-05-18 11:39:42.095', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('d4c16faad8f883650a3a8eab829ebad9', '操作日志查看', '2', 'sys_logOperate_view', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:51:38.454', '1', '2020-05-17 10:23:57.546', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('d5897b78312e09024546530fd8b2e8fc', '任务调度方案查看', '2', 'quartz_job_view', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-14 10:36:03.598', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('d9d87cf8ed7c29ed2eda06d5dec4dcda', '组件管理', '0', NULL, '/components', '-1', NULL, 'zujian', 'Layout', b'0', b'0', b'0', b'0', 80, '1', '2020-05-15 20:57:28.521', '1', '2020-05-16 13:38:57.307', NULL, 26, '0');
INSERT INTO `sys_menu` VALUES ('e086c4aa4943a883b29cf94680608b89', '生成方案代码', '2', 'gen_scheme_code', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:55:37.000', '1', '2020-05-18 11:39:42.099', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('e590df103d3382d3091eae818f68626b', '测试树管理查看', '2', 'test_testTreeBook_view', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-11 14:32:06.853', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e5ea38c1f97dee0043e78f3fb27b25d6', '生成方案编辑', '2', 'gen_scheme_edit', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:29:14.000', '1', '2020-05-18 11:39:42.102', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('e66c7efccb9e1a0519afc328339e9108', '登录日志删除', '2', 'sys_logLogin_del', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-15 09:26:02.357', '1', '2020-05-17 14:55:26.867', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e6ea0a5dc986c69852010e4a24329cf1', '任务调度方案编辑', '2', 'quartz_job_edit', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-14 10:35:56.089', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e710a66583fe0e324492462adb16014e', '业务表删除', '2', 'gen_table_del', NULL, 'a18b33e15bde209a3c9115517c56d9ec', 'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:24:45.000', '1', '2020-05-18 11:39:42.110', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('eb17cee437ea6b630dad59fff2a059ca', '多级菜单', '0', NULL, '/nested', '-1', NULL, 'dev', 'Layout', b'0', b'0', b'0', b'0', 100, '1', '2020-05-18 11:09:23.393', '1', '2020-05-18 11:26:16.370', NULL, 9, '0');
INSERT INTO `sys_menu` VALUES ('ef2382c0cc2d99ee73444e684237a88a', '系统工具', '0', NULL, '/admin', '-1', NULL, 'sys-tools', 'Layout', b'0', b'0', b'0', b'0', 30, '1', '2019-08-05 15:58:12.000', '1', '2020-05-19 02:17:53.050', NULL, 46, '0');
INSERT INTO `sys_menu` VALUES ('f15e2186907d22765cd149a94905842a', '在线用户强退', '2', 'sys_userOnline_logout', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 10:57:51.502', '1', '2020-05-16 17:55:59.729', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('fe4c7938e146ec223e99d426aaa87109', '三级菜单2', '1', NULL, 'menu1-2', '1ae562534a64d4473899e52497c40b2e', 'eb17cee437ea6b630dad59fff2a059ca,1ae562534a64d4473899e52497c40b2e,', 'dev', 'nested/menu1/menu1-2', b'0', b'0', b'0', b'1', 30, '1', '2020-05-18 11:13:18.819', '1', '2020-05-18 11:13:18.819', NULL, 0, '0');

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
INSERT INTO `sys_persistent_token` VALUES ('0jvq9hwei4c1742zlkm9', '1', 'admin', '9m6w26icsamanvxfa2yb', '2020-05-18 20:37:40.262', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', '内网IP', 'Chrome', 'OSX');
INSERT INTO `sys_persistent_token` VALUES ('5wjjo9osiwfv2jger14t', '1', 'admin', 'g60ha7z4thnrkz20as4q', '2020-05-18 09:45:52.121', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', '内网IP', 'Chrome', 'OSX');
INSERT INTO `sys_persistent_token` VALUES ('ick8hxex3al2qvizl12o', '1', 'admin', 'ux5ekl3n2n4y3mevjt51', '2020-05-19 19:01:18.459', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016');
INSERT INTO `sys_persistent_token` VALUES ('iu3uuh5p9rm9v0syt07w', '1', 'admin', '9vao3fp2z5y4emdkiwl7', '2020-05-17 18:53:59.345', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016');
INSERT INTO `sys_persistent_token` VALUES ('wtghds57btqes1ac2vw4', '1', 'admin', '58364wu2y5jmdpg1sz8b', '2020-05-17 20:42:36.546', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', '内网IP', 'Chrome', 'OSX');
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
INSERT INTO `sys_role_menu` VALUES ('1', '1ae562534a64d4473899e52497c40b2e');
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
INSERT INTO `sys_role_menu` VALUES ('1', '5b39ca5a25c772105c71f8c51d1f19d4');
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
INSERT INTO `sys_role_menu` VALUES ('1', 'b8eafb6c3a8bf0919230f0bfa59d86b6');
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
INSERT INTO `sys_role_menu` VALUES ('1', 'eb17cee437ea6b630dad59fff2a059ca');
INSERT INTO `sys_role_menu` VALUES ('1', 'ef2382c0cc2d99ee73444e684237a88a');
INSERT INTO `sys_role_menu` VALUES ('1', 'f15e2186907d22765cd149a94905842a');
INSERT INTO `sys_role_menu` VALUES ('1', 'fe4c7938e146ec223e99d426aaa87109');
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
INSERT INTO `sys_user` VALUES ('1', 'admin', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', 'albedo', '17034642999', '22@ss.com', '', '1', NULL, 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', '1', '', '2018-04-20 07:15:18.000', '1', '2020-05-17 20:44:56.513', NULL, 12, '0');
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
INSERT INTO `sys_user_online` VALUES ('-Tz9EjrWlWsrXdprIs7L1UREEUTO3BUHBAKbz2wV', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-19 01:59:13', '2020-05-19 12:10:53', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('00EpsnZV2-t9IF7w-Bc7_7KP1JFaL8U9T7Ycg-TR', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 09:58:38', '2020-05-17 09:58:38', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('0jAyrO0YESUnU1S18XwYtem3KGdbMtn94JvvVXDO', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 20:25:09', '2020-05-18 20:25:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('18fdrRafeHit-b8y-yt6WuOG8vw1wwem009EO3Ol', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 20:07:58', '2020-05-18 20:18:18', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('37mwwnbOL3_dvyjuenZj90brKm5f3EupPEo7RNGs', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 19:07:29', '2020-05-18 19:07:29', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('38PxXJoq0b250nCBvlxGiNW8i67tYPzcRMNqdWuY', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 15:52:07', '2020-05-18 16:31:39', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('3PP7W7aw92OdvW032OR5P3iE-NTQpMtMEabIB6fa', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 15:01:14', '2020-05-17 15:01:14', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('44_UKg75zx5rthn7hJnGzI2oKjJTaMq528Ccipdq', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-16 18:40:49', '2020-05-16 18:49:34', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('5ADwI6YsWuTLiaSxUh1rDUxT1MIeM_CPvlZg9gUD', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 18:47:10', '2020-05-17 18:48:54', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('5aGbv8xjcHh1lDV0X5QW_wwifLi8DFZyFqgpX8Tp', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-19 17:33:45', '2020-05-19 17:33:45', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('5rmtRDspuPGzm9m7jpTvXc0wWhIlyBHt15M8zp8s', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 09:45:52', '2020-05-18 09:45:52', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('7hzE5nynkiGzxh_fG9RotLA6QRCJqfkDiUNI_TdS', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-17 20:40:31', '2020-05-17 20:40:31', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('7mY97_wi7QOKW0TP16As2Evl3mJS1RhPPfL81nEv', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 10:22:15', '2020-05-17 11:02:02', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('7P2kSl3bhSldOc9sJn7h-kjUZrjyyRVeLKLk54rs', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 20:27:59', '2020-05-18 20:35:39', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('8JX-hY2rauI-VmVscfPwiK4s6S07U_wtBOmIZaxa', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 16:42:00', '2020-05-17 16:42:00', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('a29YvKRqRkLmoNhGnmgIukqkQ-GDaEvy5DamkdYI', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 09:45:52', '2020-05-18 09:58:50', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ABBR9vHgN3NE5wbmxmAX0x-5NBPqc2Jg8itQHmb9', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-19 12:22:59', '2020-05-19 12:22:59', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('aiweB7rd8ueNBArmTLZU166xMY8KA6yJc3gMJyMY', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:19:40', '2020-05-17 17:19:40', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('AP5GSH_LfKbRG2PZxUiIZ77IZfGlvyob_vXVSiib', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:14:50', '2020-05-17 17:17:38', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('aXx4GuRVaB_KHYVNswcw0kdpw3KNqzmaoHw29cL1', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 10:43:41', '2020-05-18 11:34:24', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('CiDi0nBAKOG7YEig9Xk0ifmZM1-bQ-Qgx6RPim6z', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 14:23:09', '2020-05-17 14:23:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('dB-3TIPyzJg2DbebHxGN6QRb55r1amUOjbdr2kiC', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 14:23:09', '2020-05-17 14:23:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('EakOVwZO1rMVfuGs5VNX3XtVDW8m-ULEXTAM6JTl', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 17:58:18', '2020-05-18 18:00:08', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ehOkJLFJMomKhwj0Jk_kTMF7dI1mVEywFaxm2mQX', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 20:18:57', '2020-05-18 20:23:06', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('EmZ7rpG2-mJ5Ae7LKLZTPqALdrixRbtUP7OMytG9', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 12:58:18', '2020-05-17 12:58:18', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('f0_SjQOYX8jzgVL9_7_TA6vzMDt8-BKPWw0L1bb6', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 15:18:42', '2020-05-17 15:18:42', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('G5_8u9lo2SOUZ2_UZQX2v7GKBtX3opkpB-xyuJCv', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 19:07:29', '2020-05-18 19:07:29', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('giGrY94eSjyna8NlltT1iOiuASJyPsDSIgUVlkp_', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 15:15:42', '2020-05-17 15:15:42', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('gwR6aOn26eLy57U51MMGegyl0E361osNTqrieg9s', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 13:41:11', '2020-05-18 14:01:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('GX21AOIcvFKMr97xFVxm015C6jYzMGach2HWF9SE', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 10:10:15', '2020-05-17 10:13:42', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('hxHQu8_eacYmGxSEkyE61AVyh0pCPEWqwsWdPT3K', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-19 16:56:53', '2020-05-19 17:21:20', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('HXMBHj08C6JN83qiFvuo0Kz2fICY4akKlfWetMQA', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 12:15:25', '2020-05-18 12:19:51', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('iqXlh9xmSl39ZNjfbsIAdYVkt4hYB5Cmhtft4aXh', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 12:58:18', '2020-05-17 13:51:08', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('JOSm-YFRT76HDXdc6wL6A7aSkysGD7BykDVpThWo', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:18:11', '2020-05-17 17:18:11', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('lIjGFEtlLy2bp7eYb-EtOxUEION3tUcyGfsSp3zJ', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-19 15:05:29', '2020-05-19 15:07:11', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('LjzcrgvJh1JoMYBI5ATRkTFNjG0CGf5j-idG6BhF', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-19 13:24:03', '2020-05-19 14:31:17', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('mo9CHOXVnm_ukI80Lg-wsu27_VA5pVEbOq_Z4m8a', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-17 20:44:41', '2020-05-17 20:44:41', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('mYMdcAslV7rmq87vH9Zz-dYYb4aol7Z5s4DSidUH', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:36:20', '2020-05-17 18:16:38', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('N6A0N67hTSshsJ4bfhhz3Wcv7bEluBf--pbhibVI', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-16 18:35:49', '2020-05-16 18:40:30', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('NlejvS91Y4-bWsYMZV9MBxD_SpY_EKeyAtGByc4h', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 20:37:40', '2020-05-18 20:39:25', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('nUwuB02N0LdwqwnGE4uooH2WpBlX9QC-TTDiVpUL', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-19 12:22:59', '2020-05-19 12:22:59', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('PeKlyi8xm3hoJS0yyrQ3jcwRJjG4cAHkcJoDheeV', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 09:59:19', '2020-05-17 10:09:59', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('pggbOMSKqt6uDFmpZOGDEjYjzNHeKWWl_ZQz4-10', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:04:06', '2020-05-17 17:05:20', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('PN6GfgwIgfSzyNnyW6db_1MaCkixJ0wYK-80vWxX', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 14:30:31', '2020-05-17 14:59:02', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('POz6Ragil6Qi_ZeFj5yFl6Vko75hW-Vd9CcLlSlf', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 14:09:20', '2020-05-17 14:20:44', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('qJXNeTN_RiilxZ-Du2wpB4hdfz64vmn0y0PtZqWx', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 20:07:57', '2020-05-18 20:07:57', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('qpsYVTufTh872YywEq5r14q9G29uK6l4Fee6bM_R', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:10:16', '2020-05-17 17:14:29', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('s2_j-7-BcAlZV40YqWULkoVjoJPHJYeWDzj1_3Hl', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 17:27:07', '2020-05-17 17:27:07', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('S5tF7sBHNEWdTSpQfv1MEvP553hPEJvi8gyPKIZE', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 18:52:09', '2020-05-17 18:52:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ShjSmasqyhdbk9Jo1U62Wi3iyWaq2_VMOdv6wBfz', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 17:29:42', '2020-05-18 17:29:42', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('SiHPyWkHYkvhgyQYJmeBSrjJ753iNX7dfmFLhJyh', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 20:04:33', '2020-05-18 20:04:33', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('spJ5pE5fMfns88s0SEuzdUBPGPbsIiovlJsP15cz', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 13:23:56', '2020-05-18 13:37:45', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('T1tvti1qzTu7d1ne3hBpSSJu2HylSYHGzzG_pmX6', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-19 19:01:19', '2020-05-19 19:16:25', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('TrlvByrGajl9jst_x6hZ2LA43_kornall3QS8v2X', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-19 17:39:10', '2020-05-19 18:08:49', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('u29r6rUvSkCnIs0tnwJ9iZpszyb1HGhm6W05Eont', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 11:05:38', '2020-05-17 11:05:38', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ud36VSPOEaLq8A1vFWDvPpnP_wsPut_yucM3vjVh', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 15:09:58', '2020-05-17 15:14:40', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('V8tK19jgRMbrGN1iV4DMsOFlzoacrp-C8bhvcD_n', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 16:42:00', '2020-05-17 16:42:00', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('vymSNu5cAJFePgCr0OgsRhWhNuBLXnczpOhJniPf', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-05-18 11:38:54', '2020-05-18 12:07:24', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('W0z28HCduqFTvYrU8DSFpMboq-D5JDZV0uV6FC_N', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2020-05-17 18:54:00', '2020-05-17 18:56:51', 1800, '1');
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
  `author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `activated` bit(1) NOT NULL,
  `number` int(11) NULL DEFAULT NULL COMMENT 'key',
  `money` decimal(20, 2) NULL DEFAULT NULL,
  `amount` double(11, 2) NULL DEFAULT NULL,
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
  `id` bigint(20) NOT NULL COMMENT 'ID',
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
  PRIMARY KEY (`id`) USING BTREE
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

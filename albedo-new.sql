/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : albedo-new

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2017-06-30 15:10:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for gen_scheme_t
-- ----------------------------
DROP TABLE IF EXISTS `gen_scheme_t`;
CREATE TABLE `gen_scheme_t` (
  `id_` varchar(64) NOT NULL COMMENT '编号',
  `name_` varchar(200) DEFAULT NULL COMMENT '名称',
  `category_` varchar(2000) DEFAULT NULL COMMENT '分类',
  `view_type` char(2) DEFAULT NULL COMMENT '视图类型 0  普通表格 1  表格采用ajax刷新',
  `package_name` varchar(500) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` varchar(200) DEFAULT NULL COMMENT '生成表编号',
  `status_` char(2) DEFAULT '0' COMMENT '状态 -2 已删除 -1停用 0 正常',
  `version_` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description_` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='生成方案';

-- ----------------------------
-- Records of gen_scheme_t
-- ----------------------------
INSERT INTO `gen_scheme_t` VALUES ('57fa576bbbbc40a9b49cc8cba1998e6d', '用户管理', 'curd', '0', 'com.albedo.java.modules', 'sys', '', '用户管理', '用户', 'admin', '95477bf45a234d49a1b09df355292ac0', '-2', '0', '', '1', '2017-03-27 15:13:50', '1', '2017-03-27 15:13:50');
INSERT INTO `gen_scheme_t` VALUES ('7100dcdc99834a54bafd27526000a86b', '油站管理', 'curd', '0', 'com.albedo.java.modules', 'gas', '', '油站管理', '油站', 'admin', '433f844704204f3190f77e5776a2a3da', '-2', '0', '', '1', '2017-03-27 15:13:56', '1', '2017-03-27 15:13:56');
INSERT INTO `gen_scheme_t` VALUES ('74f0ae746299418c956c501c53e0106d', '消息管理', 'curd', '0', 'com.albedo.java.modules', 'mpns', '', '消息管理', '消息', 'lijie', '8be3b71107534e31885edb5139d7fec0', '0', '1', '', '1', '2017-03-27 15:27:08', '1', '2017-06-30 15:02:02');
INSERT INTO `gen_scheme_t` VALUES ('7b1ac13d5dad43ca8975079d001dde9f', '操作日志', 'curd', '0', 'com.albedo.java.modules', 'sys', '', '操作日志', '操作日志', 'admin', '6487595f89e04559ade88b297d6c4da4', '-2', '0', '', '1', '2017-03-27 15:13:54', '1', '2017-03-27 15:13:54');
INSERT INTO `gen_scheme_t` VALUES ('8f075d27c7364ab6aa2034451cc7f29d', '字典管理', 'curd', '1', 'com.albedo.java.modules', 'sys', '', '字典管理', '字典', 'admin', '494f396184ba4433ba083e8bd9dc2530', '-2', '0', '', '1', '2017-03-27 15:13:52', '1', '2017-03-27 15:13:52');
INSERT INTO `gen_scheme_t` VALUES ('9590fc0222c848299446031b3be3f2c7', '区域管理', 'treeTable', '1', 'com.albedo.java.modules', 'sys', '', '区域管理', '区域管理', 'admin', '839d689f93dd4933af6fbe77c690b5de', '-2', '0', '', '1', '2017-03-27 15:14:00', '1', '2017-03-27 15:14:00');
INSERT INTO `gen_scheme_t` VALUES ('989376a334c247cab4e8754b3ae3620a', '油站管理', 'curd', '0', 'com.albedo.java.modules', 'gas', '', '油站管理', '油站', 'admin', '433f844704204f3190f77e5776a2a3da', '-2', '0', '', '1', '2016-12-29 17:14:36', '1', '2016-12-29 17:14:36');

-- ----------------------------
-- Table structure for gen_table_column_t
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column_t`;
CREATE TABLE `gen_table_column_t` (
  `id_` varchar(64) NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `name_` varchar(200) DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键',
  `is_unique` char(1) DEFAULT '0' COMMENT '是否唯一（1：是；0：否）',
  `is_null` char(1) DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort_` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `status_` char(2) DEFAULT '0' COMMENT '状态 -2 已删除 -1停用 0 正常',
  `version_` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description_` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `gen_table_column_table_id` (`gen_table_id`),
  KEY `gen_table_column_name` (`name_`),
  KEY `gen_table_column_sort` (`sort_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务表字段';

-- ----------------------------
-- Records of gen_table_column_t
-- ----------------------------
INSERT INTO `gen_table_column_t` VALUES ('03a7f29af5874b309707eadbe749b658', '433f844704204f3190f77e5776a2a3da', 'is_groupbuy', '是否有团购', 'tinyint(4)', 'String', 'isGroupbuy', '0', '0', '1', '1', '1', '1', '0', '=', 'radiobox', 'sys_yes_no', null, '310', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('03b6e9834f4b431997f45f6e5c41f9de', '95477bf45a234d49a1b09df355292ac0', 'email_', 'email_', 'varchar(100)', 'String', 'email', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '60', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('05bff3bf6b6c4b52872ec042335ee513', '433f844704204f3190f77e5776a2a3da', 'type_', '加油站类型  1 航油加油站', 'int(11)', 'Long', 'type', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '250', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('088d5827c3ae4960ae6cca13aec0bad7', 'b865f6196888498b8200209721da240c', 'content_', '内容', 'varchar(1024)', 'String', 'content', '0', '0', '1', '1', '1', '1', '0', 'eq', 'textarea', '', null, '60', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('09d0868faa044435b6eada3eb678aa24', '494f396184ba4433ba083e8bd9dc2530', 'description_', '描述', 'varchar(255)', 'String', 'description', '0', '0', '1', '1', '1', '0', '0', '=', 'textarea', '', null, '90', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('0a27d220b503417aa3c9d4473c06ca6c', '6487595f89e04559ade88b297d6c4da4', 'caller_method', '操作方法', 'varchar(254)', 'String', 'callerMethod', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '140', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('0b7577b41f5d4b428d533941339b4d75', '494f396184ba4433ba083e8bd9dc2530', 'show_name', '资源key', 'varchar(255)', 'String', 'showName', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '110', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('0ea96f523a354bcfa38fafba87180f10', '6487595f89e04559ade88b297d6c4da4', 'reference_flag', '引用标识', 'smallint(6)', 'String', 'referenceFlag', '0', '0', '1', '1', '1', '1', '1', '=', 'checkbox', 'sys_yes_no', null, '70', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('10850076f368415ca0708031ceacbaee', '433f844704204f3190f77e5776a2a3da', 'status_', '状态 -2 已删除 -1停用 0 正常', 'char(2)', 'String', 'status', '0', '0', '1', '1', '0', '0', '0', '=', 'radiobox', 'sys_status', null, '260', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('10b46fea848f4d2fbb28c5e6c315f99a', '8be3b71107534e31885edb5139d7fec0', 'os_name', '系统名称', 'varchar(64)', 'String', 'osName', '0', '0', '1', '1', '1', '1', '1', 'eq', 'input', '', null, '40', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('13238782329b42418b0aac742db66ff8', '839d689f93dd4933af6fbe77c690b5de', 'description_', '描述', 'varchar(225)', 'String', 'description', '0', '0', '1', '1', '1', '0', '0', '=', 'textarea', '', null, '90', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('13415d2efd904eee928adfc1727f415f', 'b865f6196888498b8200209721da240c', 'client_id', '客户端编号', 'varchar(32)', 'String', 'clientId', '0', '0', '0', '1', '1', '1', '0', 'eq', 'input', '', null, '40', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('144c41a3e26844f5b7eae60c68ec9c3c', '433f844704204f3190f77e5776a2a3da', 'description_', '描述', 'varchar(255)', 'String', 'description', '0', '0', '1', '1', '1', '0', '0', '=', 'textarea', '', null, '280', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('152b8220a2c34314b4886d9d25eddb06', '433f844704204f3190f77e5776a2a3da', 'has_shopping', '是否有购物', 'int(1)', 'Integer', 'hasShopping', '0', '0', '1', '1', '1', '1', '0', '=', 'radiobox', 'sys_yes_no', null, '120', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('19952e23453145ad98629a495a8a0ed4', '95477bf45a234d49a1b09df355292ac0', 'reset_key', 'reset_key', 'varchar(20)', 'String', 'resetKey', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '100', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('199867497a6e4bb9ac79a2ea9b96ab76', '494f396184ba4433ba083e8bd9dc2530', 'last_modified_by', 'last_modified_by', 'varchar(50)', 'String', 'lastModifiedBy', '0', '0', '1', '1', '0', '0', '0', '=', 'input', '', null, '160', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('1be974816ed84ec1b616e90596b7aa96', '433f844704204f3190f77e5776a2a3da', 'location_', '地址', 'varchar(255)', 'String', 'location', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '50', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('1e6220f75e8d478aad0cbb893377432c', '8be3b71107534e31885edb5139d7fec0', 'status_', '状态 0 正常 1审核  -1 停用 -2 删除', 'varchar(2)', 'String', 'status', '0', '0', '1', '1', '0', '0', '0', 'eq', 'radio', 'sys_status', null, '140', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('1f80a5092cf74c629fc5b4a86b2977d9', 'b865f6196888498b8200209721da240c', 'send_status', '发送状态', 'tinyint(4)', 'String', 'sendStatus', '0', '0', '0', '1', '1', '1', '0', 'eq', 'select', 'send_staus', null, '70', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('203efcb4402a4973a19f08105c5384eb', '839d689f93dd4933af6fbe77c690b5de', 'short_name', '区域简称', 'varchar(32)', 'String', 'shortName', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '50', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('208023d174184d0fadddb739d49f0139', '8be3b71107534e31885edb5139d7fec0', 'iv_', 'AESIV', 'varchar(64)', 'String', 'iv', '0', '0', '1', '1', '1', '1', '0', 'eq', 'input', '', null, '80', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('21f8bc66e3ca4d61b8b2c5517c5aaed3', '95477bf45a234d49a1b09df355292ac0', 'last_modified_by', 'last_modified_by', 'varchar(50)', 'String', 'lastModifiedBy', '0', '0', '1', '1', '0', '0', '0', '=', 'input', '', null, '140', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('225f30f1ed3e42dcada9be8bf24a9a66', '95477bf45a234d49a1b09df355292ac0', 'last_modified_date', 'last_modified_date', 'timestamp', 'java.util.Date', 'lastModifiedDate', '0', '0', '1', '1', '0', '0', '0', '=', 'dateselect', '', null, '150', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('22766cf080d64568b4e47e3896c9091b', '839d689f93dd4933af6fbe77c690b5de', 'status_', '状态', 'varchar(32)', 'String', 'status', '0', '0', '1', '1', '0', '1', '0', '=', 'radiobox', 'sys_status', null, '100', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('22e5529cc6ef44898d2822064a6d54e6', '8be3b71107534e31885edb5139d7fec0', 'user_id', '用户', 'varchar(32)', 'String', 'userId', '0', '0', '0', '1', '1', '1', '1', 'eq', 'input', '', null, '20', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('23ad75ef3a61462bbbebbf2b3608c6d4', '433f844704204f3190f77e5776a2a3da', 'area_id', '区域', 'varchar(32)', 'com.albedo.java.modules.sys.domain.Area', 'area.id|name', '0', '0', '1', '1', '1', '1', '0', '=', 'areaselect', '', null, '100', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('2c5fb8404df54b34ab1149b5bff3f32a', '839d689f93dd4933af6fbe77c690b5de', 'parent_id', '上级区域', 'int(11)', 'String', 'parentId', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '30', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('2ee48dd28568462f868d73380b199b4b', '433f844704204f3190f77e5776a2a3da', 'is_useinvoice', '是否使用加油站', 'int(1)', 'Integer', 'isUseinvoice', '0', '0', '0', '1', '1', '1', '0', '=', 'radiobox', 'sys_yes_no', null, '140', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('2fd9bbdb399d494ebbace429c1ea6c91', '6487595f89e04559ade88b297d6c4da4', 'caller_class', '操作类名', 'varchar(254)', 'String', 'callerClass', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '130', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('300800d5920b40a3a11ce2dfe498f935', '8be3b71107534e31885edb5139d7fec0', 'created_by', '创建人', 'varchar(50)', 'String', 'createdBy', '0', '0', '0', '1', '0', '0', '0', 'eq', 'input', '', null, '100', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('306724e56bc44e96af227a3162b7923c', '6487595f89e04559ade88b297d6c4da4', 'arg3', '参数3', 'varchar(254)', 'String', 'arg3', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '110', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('3790a3870b1d4494a2f4b8efc78dfa77', '839d689f93dd4933af6fbe77c690b5de', 'last_modified_by', 'last_modified_by', 'varchar(50)', 'String', 'lastModifiedBy', '0', '0', '1', '1', '0', '0', '0', '=', 'input', '', null, '140', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('3873cfbb2c184689b38bb0f2c82d515e', '433f844704204f3190f77e5776a2a3da', 'id_', '编号', 'varchar(32)', 'String', 'id', '1', '0', '0', '1', '0', '0', '0', '=', 'input', '', null, '10', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('3918d924f8b14a248ebcd92d19afbc8e', 'b865f6196888498b8200209721da240c', 'version_', '版本', 'int(11)', 'Long', 'version', '0', '0', '1', '1', '0', '0', '0', 'eq', 'input', '', null, '150', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('3941688e1b3c4679b8eaf40d6b0e15db', 'b865f6196888498b8200209721da240c', 'description_', '描述', 'varchar(1024)', 'String', 'description', '0', '0', '1', '1', '1', '0', '0', 'eq', 'textarea', '', null, '160', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('3a2507536c704b4bbedab3f67f2b4fa2', '839d689f93dd4933af6fbe77c690b5de', 'level_', '区域等级', 'int(11)', 'Integer', 'level', '0', '0', '1', '1', '1', '1', '0', '=', 'radiobox', 'sys_area_type', null, '70', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('3ba78b6e567642398c39ce109f5f4abd', '494f396184ba4433ba083e8bd9dc2530', 'created_by', 'created_by', 'varchar(50)', 'String', 'createdBy', '0', '0', '0', '1', '0', '0', '0', '=', 'input', '', null, '140', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('4100f71d115c4e92a5a7977bc79d5d3f', '8be3b71107534e31885edb5139d7fec0', 'id_', '编号', 'varchar(32)', 'String', 'id', '1', '0', '0', '1', '0', '0', '0', 'eq', 'input', '', null, '10', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('432fdcddcca04de7a6bc21a4d104342f', '433f844704204f3190f77e5776a2a3da', 'created_date', 'created_date', 'datetime', 'java.util.Date', 'createdDate', '0', '0', '0', '1', '0', '0', '0', '=', 'dateselect', '', null, '330', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('437c7a918d82452dbe9bcef0c3c4b3b8', '95477bf45a234d49a1b09df355292ac0', 'status_', 'status_', 'int(11)', 'Long', 'status', '0', '0', '1', '1', '0', '0', '0', '=', 'radiobox', 'sys_status', null, '160', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('4446892a37774f24ba7ec230089266a7', 'b865f6196888498b8200209721da240c', 'id_', '编号', 'varchar(32)', 'String', 'id', '1', '0', '0', '1', '0', '0', '0', 'eq', 'input', '', null, '10', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('45f29829ccf24cd297a2dbbec287b950', '95477bf45a234d49a1b09df355292ac0', 'activation_key', 'activation_key', 'varchar(20)', 'String', 'activationKey', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '90', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('474e3ad5e4e842299313fd11e6de6806', '433f844704204f3190f77e5776a2a3da', 'last_modified_by', 'last_modified_by', 'varchar(50)', 'String', 'lastModifiedBy', '0', '0', '1', '1', '0', '0', '0', '=', 'input', '', null, '340', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('480dc23422ca441f995dc7451d012962', '494f396184ba4433ba083e8bd9dc2530', 'version_', 'version_', 'int(11)', 'Long', 'version', '0', '0', '1', '1', '0', '0', '0', '=', 'input', '', null, '130', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('4b34baedffd14854b02b7ece9a2c2919', 'b865f6196888498b8200209721da240c', 'created_by', '创建人', 'varchar(50)', 'String', 'createdBy', '0', '0', '0', '1', '0', '0', '0', 'eq', 'input', '', null, '100', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('4bd66fdf9400461883d29b0a3cca4775', '433f844704204f3190f77e5776a2a3da', 'is_cooperate', '是否合作站', 'int(1)', 'Integer', 'isCooperate', '0', '0', '0', '1', '1', '1', '0', '=', 'radiobox', 'sys_yes_no', null, '130', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('559e56c2c20e41e582605f9801f945c1', '6487595f89e04559ade88b297d6c4da4', 'caller_filename', '操作文件', 'varchar(254)', 'String', 'callerFilename', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '120', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('56572ffffa8e4dca919de6369c2ad342', '433f844704204f3190f77e5776a2a3da', 'created_by', 'created_by', 'varchar(50)', 'String', 'createdBy', '0', '0', '0', '1', '0', '0', '0', '=', 'input', '', null, '320', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('57917b12a49e49b8ad34fef6939b50d5', '839d689f93dd4933af6fbe77c690b5de', 'sort_', '序号', 'int(11)', 'Long', 'sort', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '60', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('5c349a08bc2649af832fa6bb6b040b56', '8be3b71107534e31885edb5139d7fec0', 'created_date', '创建时间', 'datetime', 'java.util.Date', 'createdDate', '0', '0', '0', '1', '0', '0', '0', 'eq', 'dateselect', '', null, '110', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('5eca9cc871d4431e90542db9c5e75698', '839d689f93dd4933af6fbe77c690b5de', 'version_', '版本', 'int(11)', 'Long', 'version', '0', '0', '0', '1', '0', '0', '0', '=', 'input', '', null, '110', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('61bbdd5f8a1e46c5be18664f425fcb2e', '494f396184ba4433ba083e8bd9dc2530', 'id_', '编号', 'varchar(32)', 'String', 'id', '1', '0', '0', '1', '0', '0', '0', '=', 'input', '', null, '10', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('61debb1d07d04ce6ba0380096fa59c4d', '8be3b71107534e31885edb5139d7fec0', 'last_modified_date', '最后更新时间', 'datetime', 'java.util.Date', 'lastModifiedDate', '0', '0', '1', '1', '0', '0', '0', 'eq', 'dateselect', '', null, '130', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('638f2d40508c40d0b410b6c23116b91a', '839d689f93dd4933af6fbe77c690b5de', 'code_', '区域编码', 'varchar(32)', 'String', 'code', '0', '1', '1', '1', '1', '1', '1', 'like', 'input', '', null, '80', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('6444181c4b5a46e5ab48307caad7571b', '6487595f89e04559ade88b297d6c4da4', 'level_string', '级别', 'varchar(254)', 'String', 'levelString', '0', '0', '0', '1', '1', '1', '1', '=', 'checkbox', 'sys_log_level', null, '50', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('649b41c81e824ff2967a0dadb84d1a36', '433f844704204f3190f77e5776a2a3da', 'user_id', '用户', 'varchar(32)', 'com.albedo.java.modules.sys.domain.User', 'user.id|name', '0', '0', '1', '1', '1', '1', '0', '=', 'userselect', '', null, '30', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('64ddd9f48ff64b2583e283ff26860d87', '433f844704204f3190f77e5776a2a3da', 'company_id', '所属公司', 'varchar(32)', 'String', 'companyId', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '290', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('64fa40d8dd754792926dc59d06d9aa51', '839d689f93dd4933af6fbe77c690b5de', 'last_modified_date', 'last_modified_date', 'datetime', 'java.util.Date', 'lastModifiedDate', '0', '0', '1', '1', '0', '0', '0', '=', 'dateselect', '', null, '150', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('6521c483980a4f3683c33a3ec8bb6ad8', '433f844704204f3190f77e5776a2a3da', 'last_modified_date', 'last_modified_date', 'datetime', 'java.util.Date', 'lastModifiedDate', '0', '0', '1', '1', '0', '0', '0', '=', 'dateselect', '', null, '350', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('664a8d7ad5f940eabff9e07861b5d529', '95477bf45a234d49a1b09df355292ac0', 'login_id', 'login_id', 'varchar(50)', 'String', 'loginId', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '30', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('664d004cf4a849fe94631cf2b207fe73', '6487595f89e04559ade88b297d6c4da4', 'arg1', '参数1', 'varchar(254)', 'String', 'arg1', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '90', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('6884bbe4f93e4044ab9a9e686acc9a23', '433f844704204f3190f77e5776a2a3da', 'business_hour_start', '营业开始时间', 'varchar(64)', 'String', 'businessHourStart', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '220', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('68f8c9efb8b740dfa30cdb4d73eeeb63', '494f396184ba4433ba083e8bd9dc2530', 'is_leaf', '叶子节点', 'bit(1)', 'String', 'isLeaf', '0', '0', '1', '1', '1', '1', '0', '=', 'radiobox', 'sys_yes_no', null, '70', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('69ac6c86b8c24db5b86410b3dddb4f9e', '494f396184ba4433ba083e8bd9dc2530', 'is_show', '是否显示', 'bit(1)', 'String', 'isShow', '0', '0', '1', '1', '1', '1', '0', '=', 'radiobox', 'sys_yes_no', null, '65', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('6d0267263b5245c5b6b957825177d6db', '95477bf45a234d49a1b09df355292ac0', 'password_hash', 'password_hash', 'varchar(60)', 'String', 'passwordHash', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '40', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('6fcee64e7c1e4374b4de22e6e842d6c8', '494f396184ba4433ba083e8bd9dc2530', 'parent_id', 'parent_id', 'varchar(32)', 'String', 'parentId', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '30', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('73298847174a45f486bde3092227363b', '494f396184ba4433ba083e8bd9dc2530', 'parent_ids', 'parent_ids', 'varchar(2000)', 'String', 'parentIds', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '40', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('7331a39df8e34f658b93ed0f6b5a2e45', '8be3b71107534e31885edb5139d7fec0', 'last_modified_by', '更新人', 'varchar(50)', 'String', 'lastModifiedBy', '0', '0', '1', '1', '0', '0', '0', 'eq', 'input', '', null, '120', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('7380a9a3832d4e5aa9a510b29ca4abf2', '839d689f93dd4933af6fbe77c690b5de', 'created_by', 'created_by', 'varchar(50)', 'com.albedo.java.modules.sys.domain.User', 'createdBy', '0', '0', '0', '1', '0', '0', '0', '=', 'input', '', null, '120', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('791aa2c5aa2849a7b30757c54c0bad09', '494f396184ba4433ba083e8bd9dc2530', 'val_', '值', 'varchar(255)', 'String', 'val', '0', '0', '1', '1', '1', '1', '1', '=', 'input', '', null, '50', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('79459212a7044050a1ee8dbf1bbcb55c', '494f396184ba4433ba083e8bd9dc2530', 'status_', 'status_', 'varchar(2)', 'String', 'status', '0', '0', '1', '1', '0', '0', '0', '=', 'radiobox', 'sys_status', null, '100', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('7bf9987cdcab4927b76d13b3613ce84c', 'b865f6196888498b8200209721da240c', 'last_modified_date', '最后更新时间', 'datetime', 'java.util.Date', 'lastModifiedDate', '0', '0', '1', '1', '0', '0', '0', 'eq', 'dateselect', '', null, '130', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('7c8009105b884fb28b4dff8246cdacaa', '433f844704204f3190f77e5776a2a3da', 'longitude_', '经度', 'varchar(255)', 'String', 'longitude', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '60', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('80ad0e59b24c424a82b5259e54138b57', '6487595f89e04559ade88b297d6c4da4', 'thread_name', '线程', 'varchar(254)', 'String', 'threadName', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '60', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('824adc18e2af45f2bebead0eb9f226dc', '433f844704204f3190f77e5776a2a3da', 'mark_envir', '环境评分', 'decimal(11,2)', 'Double', 'markEnvir', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '180', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('88330dc3ed4344f7adb677873135c7fc', '839d689f93dd4933af6fbe77c690b5de', 'id_', '区域id', 'int(11)', 'String', 'id', '1', '0', '0', '1', '1', '0', '0', '=', 'input', '', null, '10', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('896b1e54cb6c4a5696e4f4a549b57e05', '433f844704204f3190f77e5776a2a3da', 'phone_', '联系方式', 'varchar(255)', 'String', 'phone', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '90', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('8cc6da6960424f6fbe26e6d4d4f49a64', '433f844704204f3190f77e5776a2a3da', 'name_', '名称', 'varchar(255)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'like', 'input', '', null, '20', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('8e3048243014437398331b8686176a50', '433f844704204f3190f77e5776a2a3da', 'open_time', '开通时间', 'datetime', 'java.util.Date', 'openTime', '0', '0', '1', '1', '1', '1', '0', '=', 'dateselect', '', null, '300', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('8face8acc7e64a3cb38c05f4432cf74c', '433f844704204f3190f77e5776a2a3da', 'latitude_', '纬度', 'varchar(255)', 'String', 'latitude', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '40', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('8fc533077ddf4aaa8e332bae2945b618', '6487595f89e04559ade88b297d6c4da4', 'timestmp', '创建时间', 'bigint(20)', 'Long', 'timestmp', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '20', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('917e3aeda044408291f6e4dcdc986706', '494f396184ba4433ba083e8bd9dc2530', 'last_modified_date', 'last_modified_date', 'datetime', 'java.util.Date', 'lastModifiedDate', '0', '0', '1', '1', '0', '0', '0', '=', 'dateselect', '', null, '170', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('93a38da5c74248629f4439be8f46d669', '494f396184ba4433ba083e8bd9dc2530', 'created_date', 'created_date', 'datetime', 'java.util.Date', 'createdDate', '0', '0', '0', '1', '0', '0', '0', '=', 'dateselect', '', null, '150', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('93cb2c5097404136881b2e6e1412fed9', '433f844704204f3190f77e5776a2a3da', 'mark_service', '服务评分', 'decimal(11,2)', 'Double', 'markService', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '190', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('956f345f8e3f430f89e22400510a2f13', '433f844704204f3190f77e5776a2a3da', 'gaode_table_id', '高德地图表格Id', 'varchar(32)', 'String', 'gaodeTableId', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '240', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('975dd9c14c8f4299be495dbf3605c2a0', '6487595f89e04559ade88b297d6c4da4', 'event_id', 'event_id', 'bigint(20)', 'Long', 'eventId', '1', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '10', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('9840e7b5ad7c45e78ec16a78b0765564', '433f844704204f3190f77e5776a2a3da', 'map_id', '地图Id', 'varchar(32)', 'String', 'mapId', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '70', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('99327558fc9e4edf8c10fc47b2e61ef6', '8be3b71107534e31885edb5139d7fec0', 'client_key', 'AESKey', 'tinyint(128)', 'String', 'clientKey', '0', '0', '1', '1', '1', '1', '0', 'eq', 'input', '', null, '70', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('9af13a2d7af14771b523f5b4994e870d', 'b865f6196888498b8200209721da240c', 'title_', '标题', 'varchar(64)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'like', 'input', '', null, '50', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('9b1bd919eed449a88437bf6535963898', '8be3b71107534e31885edb5139d7fec0', 'online_status', '在线状态', 'tinyint(4)', 'String', 'onlineStatus', '0', '0', '0', '1', '1', '1', '1', 'eq', 'radio', 'online_status', null, '90', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('9c0a54b10a6349eba6f83218ba716de8', 'b865f6196888498b8200209721da240c', 'msg_id', '消息编号', 'varchar(32)', 'String', 'msgId', '0', '0', '0', '1', '1', '1', '0', 'eq', 'input', '', null, '20', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('9f6f755940454d56845b1398c194263c', '8be3b71107534e31885edb5139d7fec0', 'version_', '版本', 'int(11)', 'Long', 'version', '0', '0', '1', '1', '0', '0', '0', 'eq', 'input', '', null, '150', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('9fc6904b843040d4bdd207a4a9606223', '433f844704204f3190f77e5776a2a3da', 'business_hour_end', '营业结束时间', 'varchar(64)', 'String', 'businessHourEnd', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '230', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('a38d7c25cb0f4060804b05cb25888671', '494f396184ba4433ba083e8bd9dc2530', 'name_', '名称', 'varchar(255)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'like', 'input', '', null, '20', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('a4884029d2b941f5be32b29eb9432584', 'b865f6196888498b8200209721da240c', 'form_', '来源', 'varchar(32)', 'String', 'form', '0', '0', '1', '1', '1', '1', '0', 'eq', 'input', '', null, '90', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('a76d8b8b4dc145958c68ad6f042e0c7c', 'b865f6196888498b8200209721da240c', 'user_id', '用户', 'varchar(32)', 'String', 'userId', '0', '0', '0', '1', '1', '1', '0', 'eq', 'input', '', null, '30', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('ac4f736b357844b7800bcd29ae8886c4', '95477bf45a234d49a1b09df355292ac0', 'description_', 'description_', 'varchar(255)', 'String', 'description', '0', '0', '1', '1', '1', '0', '0', '=', 'textarea', '', null, '170', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('b1fa49ecab0d4f7abb80e56cbb7aec46', '8be3b71107534e31885edb5139d7fec0', 'cipher_', '密码', 'varchar(128)', 'String', 'cipher', '0', '0', '0', '1', '1', '1', '0', 'eq', 'input', '', null, '60', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('b8f691ee828641fcbfc23e406a0fc5d8', '95477bf45a234d49a1b09df355292ac0', 'lang_key', 'lang_key', 'varchar(5)', 'String', 'langKey', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '80', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('bd2952c551c34564b0b3cf48b53e14aa', '95477bf45a234d49a1b09df355292ac0', 'reset_date', 'reset_date', 'timestamp', 'java.util.Date', 'resetDate', '0', '0', '1', '1', '1', '1', '0', '=', 'dateselect', '', null, '110', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('c589f4945847425e8be781cfd52ce446', '494f396184ba4433ba083e8bd9dc2530', 'code_', '唯一编码', 'varchar(255)', 'String', 'code', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '60', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('c635991a51754cd88e5cb2ac672d2365', '8be3b71107534e31885edb5139d7fec0', 'description_', '描述', 'varchar(1024)', 'String', 'description', '0', '0', '1', '1', '1', '0', '0', 'eq', 'textarea', '', null, '160', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('c8cf7be9b8d64968a6b09f08406b3462', '839d689f93dd4933af6fbe77c690b5de', 'is_leaf', '是否叶子节点', 'bit(1)', 'String', 'isLeaf', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '90', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('c9e6b04818174b768e441b45457d3c28', '95477bf45a234d49a1b09df355292ac0', 'created_by', 'created_by', 'varchar(50)', 'String', 'createdBy', '0', '0', '0', '1', '0', '0', '0', '=', 'input', '', null, '120', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('cb8f55b59d2441a4a3847dc5e7b8e68e', '8be3b71107534e31885edb5139d7fec0', 'device_id', '设备编号', 'varchar(64)', 'String', 'deviceId', '0', '0', '0', '1', '1', '1', '1', 'eq', 'input', '', null, '30', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('ccd6e3a314e04bc9ba9cb6dfbc929b79', '6487595f89e04559ade88b297d6c4da4', 'formatted_message', '内容', 'text', 'String', 'formattedMessage', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '30', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('cfc5b391af644cf08a93ddc1e2baf00c', '6487595f89e04559ade88b297d6c4da4', 'logger_name', '名称', 'varchar(254)', 'String', 'loggerName', '0', '0', '0', '1', '1', '1', '1', '=', 'input', '', null, '40', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('d0be56d2b7bd435680cdf1f3c56b36c9', '8be3b71107534e31885edb5139d7fec0', 'os_version', '系统版本', 'varchar(64)', 'String', 'osVersion', '0', '0', '1', '1', '1', '1', '1', 'eq', 'input', '', null, '50', '0', '0', null, '1', '2017-03-27 16:00:14', '1', '2017-03-27 16:00:14');
INSERT INTO `gen_table_column_t` VALUES ('d0e530b012f3474cb5487fe28f187551', '433f844704204f3190f77e5776a2a3da', 'cooperate_type', '合作类型', 'varchar(12)', 'String', 'cooperateType', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '150', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('d45c3e776a6c4f4faae3dee3fe6c5cbe', '839d689f93dd4933af6fbe77c690b5de', 'name_', '区域名称', 'varchar(32)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'like', 'input', '', null, '40', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('d4f77623576941fd8525e8bc47248c33', 'b865f6196888498b8200209721da240c', 'created_date', '创建时间', 'datetime', 'java.util.Date', 'createdDate', '0', '0', '0', '1', '0', '0', '0', 'eq', 'dateselect', '', null, '110', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('d763c1888f5443c88fc5b52fbf5a1ed0', '433f844704204f3190f77e5776a2a3da', 'consume_order', '消费单数', 'int(11)', 'Long', 'consumeOrder', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '210', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('da61e633d55c4d5fa64cd2aea3221602', '6487595f89e04559ade88b297d6c4da4', 'arg2', '参数2', 'varchar(254)', 'String', 'arg2', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '100', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('db9cd4e4d1584351988036219b77a694', '433f844704204f3190f77e5776a2a3da', 'score_', '平均分', 'decimal(11,2)', 'Double', 'score', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '200', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('ddef328eda5b4a7a9b4ff38e09169955', '494f396184ba4433ba083e8bd9dc2530', 'sort_', '排序', 'int(11)', 'Long', 'sort', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '80', '-2', '0', null, '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_column_t` VALUES ('e05c0b98659a4c2e8c1cb0acb91849b4', '95477bf45a234d49a1b09df355292ac0', 'created_date', 'created_date', 'timestamp', 'java.util.Date', 'createdDate', '0', '0', '0', '1', '0', '0', '0', '=', 'dateselect', '', null, '130', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('e2a962d6e313497b91b6cb7a9eb3942f', 'b865f6196888498b8200209721da240c', 'send_time', '发送时间', 'datetime', 'java.util.Date', 'sendTime', '0', '0', '0', '1', '1', '1', '0', 'eq', 'dateselect', '', null, '80', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('e37f9b24a4fb42d88ecb06faad0f013e', '433f844704204f3190f77e5776a2a3da', 'mark_oil', '油评分', 'decimal(11,2)', 'Double', 'markOil', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '170', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('e4bd7a6fde404972a894b1d956a64060', '433f844704204f3190f77e5776a2a3da', 'oil_card_amount', '购买油卡金额', 'decimal(11,2)', 'Double', 'oilCardAmount', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '160', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('ea483bdfb2724656b508dd91b9ed4026', '95477bf45a234d49a1b09df355292ac0', 'name_', 'name_', 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'like', 'input', '', null, '50', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('ed23d26dc4944401af468f7a70aa23dd', '95477bf45a234d49a1b09df355292ac0', 'id_', 'id_', 'varchar(32)', 'String', 'id', '1', '0', '0', '1', '0', '0', '0', '=', 'input', '', null, '10', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('ed77cb26fe514f98a28dc9bd916f9818', 'b865f6196888498b8200209721da240c', 'status_', '状态 0 正常 1审核  -1 停用 -2 删除', 'varchar(2)', 'String', 'status', '0', '0', '1', '1', '0', '0', '0', 'eq', 'radio', 'sys_status', null, '140', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('ee22f73f84854ec3ab4fa1b8c6d1d48d', '6487595f89e04559ade88b297d6c4da4', 'arg0', '参数0', 'varchar(254)', 'String', 'arg0', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '80', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('f0e4732fd296401ebc78d3f9f7696205', '6487595f89e04559ade88b297d6c4da4', 'caller_line', '操作行', 'char(4)', 'String', 'callerLine', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '150', '-2', '0', null, '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_column_t` VALUES ('f1c208496e9d4139afff761f62f8b79a', '95477bf45a234d49a1b09df355292ac0', 'activated_', 'activated_', 'bit(1)', 'Integer', 'activated', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '70', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('f2a082b6e6ad49f2b07334d0eab66f9f', '433f844704204f3190f77e5776a2a3da', 'has_car_wash', '是否有洗车服务', 'int(1)', 'Integer', 'hasCarWash', '0', '0', '0', '1', '1', '1', '0', '=', 'radiobox', 'sys_yes_no', null, '110', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('f5130d9ec7604cd09131544b2c0ef12b', '839d689f93dd4933af6fbe77c690b5de', 'created_date', 'created_date', 'datetime', 'java.util.Date', 'createdDate', '0', '0', '0', '1', '0', '0', '0', '=', 'dateselect', '', null, '130', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_column_t` VALUES ('f73dc9cf94b44a6fb1626b1b9648449a', '95477bf45a234d49a1b09df355292ac0', 'version_', 'version_', 'int(11)', 'Long', 'version', '0', '0', '1', '1', '0', '0', '0', '=', 'input', '', null, '180', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('f7873fa00a0b42998c10d9621f3d54b7', 'b865f6196888498b8200209721da240c', 'last_modified_by', '更新人', 'varchar(50)', 'String', 'lastModifiedBy', '0', '0', '1', '1', '0', '0', '0', 'eq', 'input', '', null, '120', '0', '1', null, '1', '2017-06-30 15:01:56', '1', '2017-06-30 15:01:56');
INSERT INTO `gen_table_column_t` VALUES ('f8211381d246417e9e39e28e426261e6', '433f844704204f3190f77e5776a2a3da', 'version_', '默认0，必填，离线乐观锁', 'int(11)', 'Long', 'version', '0', '0', '1', '1', '0', '0', '0', '=', 'input', '', null, '270', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('f8c924636cea470aac314c76e04af90e', '95477bf45a234d49a1b09df355292ac0', 'org_id', 'org_id', 'varchar(32)', 'com.albedo.java.modules.sys.domain.Org', 'org.id|name', '0', '0', '1', '1', '1', '1', '0', '=', 'orgselect', '', null, '20', '-2', '0', null, '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:31');
INSERT INTO `gen_table_column_t` VALUES ('f95d955c665345449942890d9574bd37', '433f844704204f3190f77e5776a2a3da', 'logo_url', 'LOGO', 'varchar(255)', 'String', 'logoUrl', '0', '0', '1', '1', '1', '1', '0', '=', 'input', '', null, '80', '-2', '0', null, '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_column_t` VALUES ('fbb5e8f90bf547a0b80ea1920bc39bfa', '839d689f93dd4933af6fbe77c690b5de', 'parent_ids', '所有上级区域节点', 'text', 'String', 'parentIds', '0', '0', '0', '1', '1', '1', '0', '=', 'input', '', null, '20', '-2', '0', null, '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');

-- ----------------------------
-- Table structure for gen_table_fk_t
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_fk_t`;
CREATE TABLE `gen_table_fk_t` (
  `id_` varchar(64) NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `name_` varchar(200) DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键',
  `is_unique` char(1) DEFAULT '0' COMMENT '是否唯一（1：是；0：否）',
  `is_null` char(1) DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort_` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `status_` char(2) DEFAULT '0' COMMENT '状态 -2 已删除 -1停用 0 正常',
  `version_` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description_` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `gen_table_column_table_id` (`gen_table_id`),
  KEY `gen_table_column_name` (`name_`),
  KEY `gen_table_column_sort` (`sort_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务表字段';

-- ----------------------------
-- Records of gen_table_fk_t
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_t
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_t`;
CREATE TABLE `gen_table_t` (
  `id_` varchar(64) NOT NULL COMMENT '编号',
  `name_` varchar(200) DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) DEFAULT NULL COMMENT '描述',
  `class_name` varchar(100) DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) DEFAULT NULL COMMENT '关联父表外键',
  `status_` char(2) DEFAULT '0' COMMENT '状态 -2 已删除 -1停用 0 正常',
  `version_` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description_` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `gen_table_name` (`name_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务表';

-- ----------------------------
-- Records of gen_table_t
-- ----------------------------
INSERT INTO `gen_table_t` VALUES ('433f844704204f3190f77e5776a2a3da', 'gas_station', '加油站表', 'Station', '', '', '-2', '0', '', '1', '2017-03-27 15:13:43', '1', '2017-03-27 15:13:43');
INSERT INTO `gen_table_t` VALUES ('494f396184ba4433ba083e8bd9dc2530', 'sys_dict_t', '字典表', 'Dict', '', '', '-2', '0', '', '1', '2017-03-27 15:13:41', '1', '2017-03-27 15:13:41');
INSERT INTO `gen_table_t` VALUES ('6487595f89e04559ade88b297d6c4da4', 'logging_event', '日志表', 'LoggingEvent', '', '', '-2', '0', '', '1', '2017-03-27 15:13:37', '1', '2017-03-27 15:13:37');
INSERT INTO `gen_table_t` VALUES ('839d689f93dd4933af6fbe77c690b5de', 'sys_area_t', '区域表', 'Area', '', '', '-2', '0', '', '1', '2017-03-27 15:13:39', '1', '2017-03-27 15:13:39');
INSERT INTO `gen_table_t` VALUES ('8be3b71107534e31885edb5139d7fec0', 'mpns_client', '设备表', 'Client', '', '', '0', '0', '', '1', '2017-03-27 15:21:59', '1', '2017-03-27 15:21:59');
INSERT INTO `gen_table_t` VALUES ('95477bf45a234d49a1b09df355292ac0', 'sys_user_t', '用户表', 'User', '', '', '-2', '0', '', '1', '2017-03-27 15:13:31', '1', '2017-03-27 15:13:30');
INSERT INTO `gen_table_t` VALUES ('b865f6196888498b8200209721da240c', 'mpns_message', '消息表', 'Message', '', '', '0', '1', '', '1', '2017-03-27 15:21:31', '1', '2017-06-30 15:01:56');

-- ----------------------------
-- Table structure for gen_template_t
-- ----------------------------
DROP TABLE IF EXISTS `gen_template_t`;
CREATE TABLE `gen_template_t` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) DEFAULT NULL COMMENT '分类',
  `file_path` varchar(500) DEFAULT NULL COMMENT '生成文件路径',
  `file_name` varchar(200) DEFAULT NULL COMMENT '生成文件名',
  `content` text COMMENT '内容',
  `status_` char(2) DEFAULT '0' COMMENT '状态 -2 已删除 -1停用 0 正常',
  `version_` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description_` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代码模板表';

-- ----------------------------
-- Records of gen_template_t
-- ----------------------------

-- ----------------------------
-- Table structure for jhi_authority
-- ----------------------------
DROP TABLE IF EXISTS `jhi_authority`;
CREATE TABLE `jhi_authority` (
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jhi_authority
-- ----------------------------

-- ----------------------------
-- Table structure for jhi_persistent_audit_event
-- ----------------------------
DROP TABLE IF EXISTS `jhi_persistent_audit_event`;
CREATE TABLE `jhi_persistent_audit_event` (
  `event_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `principal` varchar(50) NOT NULL,
  `event_date` timestamp NULL DEFAULT NULL,
  `event_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_persistent_audit_event` (`principal`,`event_date`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jhi_persistent_audit_event
-- ----------------------------
INSERT INTO `jhi_persistent_audit_event` VALUES ('206', 'admin', '2017-02-28 20:44:31', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('207', 'admin', '2017-02-28 21:25:39', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('208', 'admin', '2017-02-28 21:29:50', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('209', 'admin', '2017-03-01 09:26:19', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('210', 'admin', '2017-03-01 13:42:39', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('211', 'admin', '2017-03-01 13:52:40', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('212', 'admin', '2017-03-01 13:55:17', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('213', 'admin', '2017-03-01 19:29:48', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('214', 'admin', '2017-03-01 19:36:50', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('215', 'admin', '2017-03-01 20:37:46', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('216', 'admin', '2017-03-01 21:02:05', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('217', 'admin', '2017-03-01 21:23:11', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('218', 'admin', '2017-03-01 21:27:54', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('219', 'admin', '2017-03-02 09:52:54', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('220', 'admin', '2017-03-02 10:41:15', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('221', 'admin', '2017-03-02 11:38:25', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('222', 'admin', '2017-03-02 12:35:11', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('223', 'admin', '2017-03-02 13:33:20', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('224', 'admin', '2017-03-02 13:35:08', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('225', 'admin', '2017-03-02 13:54:35', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('226', 'admin', '2017-03-02 13:59:21', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('227', 'admin', '2017-03-02 14:02:51', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('228', 'admin', '2017-03-02 15:34:31', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('229', 'admin', '2017-03-02 16:20:44', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('230', 'admin', '2017-03-02 16:48:10', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('231', 'admin', '2017-03-02 17:28:43', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('232', 'admin', '2017-03-02 21:27:13', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('233', 'admin', '2017-03-02 22:05:20', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('234', 'admin', '2017-03-02 22:23:05', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('235', 'admin', '2017-03-02 22:24:32', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('236', 'admin', '2017-03-02 22:26:53', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('237', 'admin', '2017-03-02 22:37:05', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('238', 'admin', '2017-03-02 22:48:28', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('239', 'admin', '2017-03-02 22:58:52', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('240', 'admin', '2017-03-02 23:01:16', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('241', 'admin', '2017-03-02 23:06:03', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('242', 'admin', '2017-03-02 23:20:31', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('243', 'admin', '2017-03-02 23:24:04', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('244', 'admin', '2017-03-27 15:13:23', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('245', 'admin', '2017-03-27 15:42:36', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('246', 'admin', '2017-03-27 15:46:28', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('247', 'admin', '2017-03-27 15:50:03', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('248', 'admin', '2017-03-27 15:57:54', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('249', 'admin', '2017-06-30 14:31:20', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('250', 'admin', '2017-06-30 14:52:06', 'AUTHENTICATION_FAILURE');
INSERT INTO `jhi_persistent_audit_event` VALUES ('251', 'admin', '2017-06-30 14:52:09', 'AUTHENTICATION_FAILURE');
INSERT INTO `jhi_persistent_audit_event` VALUES ('252', 'admin', '2017-06-30 14:52:13', 'AUTHENTICATION_FAILURE');
INSERT INTO `jhi_persistent_audit_event` VALUES ('253', 'admin', '2017-06-30 14:52:47', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('254', 'admin', '2017-06-30 14:53:14', 'AUTHENTICATION_SUCCESS');
INSERT INTO `jhi_persistent_audit_event` VALUES ('255', 'admin', '2017-06-30 14:58:58', 'AUTHENTICATION_SUCCESS');

-- ----------------------------
-- Table structure for jhi_persistent_audit_evt_data
-- ----------------------------
DROP TABLE IF EXISTS `jhi_persistent_audit_evt_data`;
CREATE TABLE `jhi_persistent_audit_evt_data` (
  `event_id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`event_id`,`name`),
  KEY `idx_persistent_audit_evt_data` (`event_id`),
  CONSTRAINT `jhi_persistent_audit_evt_data_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `jhi_persistent_audit_event` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jhi_persistent_audit_evt_data
-- ----------------------------
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('206', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('206', 'sessionId', 'U49Uy-XelbJAJZa8nRQTWhh1_FZm_Mrloo7ziDZq');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('207', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('207', 'sessionId', 'OSUCX4YlZ16NWWwgPg4G8QEYPsLJjhzEp0d9tvVf');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('208', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('208', 'sessionId', '5rePOkXMfMwBpCauOFtD_yeByroTcpRW634OK5_v');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('209', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('209', 'sessionId', 'yGkQLAYfVMcMojDhSfkHoQ5qgttoCfVrOfG_f32s');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('210', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('210', 'sessionId', 'IFcF-hxRULUPRpjcxa-gB2Ad2KCLCI52hhgp2juG');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('211', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('211', 'sessionId', '-nTwB88TMVOutNx48GxOiWRXbXsOlh4Auqfh4mM-');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('212', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('212', 'sessionId', 'zrCJBRsV-gFf-D8OqZUl3dooVhI6ofHKDEDzslD8');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('213', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('213', 'sessionId', 'aThmN21jKZAGmna44nWA7voNW4lLh_9SOSRrI8Tg');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('214', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('214', 'sessionId', 'KkpbFRZmOqHZsJw5RhS5nFxL6HJKOiXvi7r-bD0a');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('215', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('215', 'sessionId', '5cmhYhrRtuwlTrcAXobJejFHTRtEolwHbd6fTp0E');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('216', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('216', 'sessionId', 'q4GFsbABq9216CKDXMEd2FClCF2p2zUYKPSXfFVn');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('217', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('217', 'sessionId', 'rIOLfXK9tKyikBvA_pTOrkqbgZGJBRk6xkrEOEUD');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('218', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('218', 'sessionId', 'g13nWF3Q-zPEKj-HWeUcDpYqFb0cfGQZhBGCJP2p');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('219', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('219', 'sessionId', 'M1H6KiXDG0nrmDfHNMb2ORrp_Fr1M3VmlPFx65KD');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('220', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('220', 'sessionId', 'wnqf4H8wSZjC5KBRChc-UBluN4oXZsoNVEhj675k');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('221', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('221', 'sessionId', 'X0PuXMkL_qz5OBX4BoBljL7tVanNQumv9C0x2C39');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('222', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('222', 'sessionId', 'rqSlnwxyUiL2Q6ksi5_PG_FphmNldeHJKHJ6jw3M');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('223', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('223', 'sessionId', 'MPpZu6i79DieRGPzXRYQJuDsAgqnQtC79Ke10_mG');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('224', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('224', 'sessionId', 'zvuqlEmd8n5b3q0kkHZBIfeHreLOQw5iihYiP1LJ');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('225', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('225', 'sessionId', 'N_JlufDQxpE9djZAOODIGYfbR905pM03MpQc17Pn');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('226', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('226', 'sessionId', 'nUYMuhYyiyclNyvqR7gSEnPBSdXDrAj8-If1WBOh');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('227', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('227', 'sessionId', 'KlNpF99X1IXSpbzNWKWlGjQirFu68-Wasn6brxim');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('228', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('228', 'sessionId', 'Ot15jUUAmsFwDAXt4hJ_VfzGVpAk2MgZV-4CH8hy');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('229', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('229', 'sessionId', '5DPEVGOFG8gLrN8CsOUZqo1_YVn_7vScyKGLdVaH');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('230', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('230', 'sessionId', 'PlHNGO4p04U-oYVnx8MvOY4MWL0x--M7X7w1upua');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('231', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('231', 'sessionId', '8D_bXX2RuYfr4rbsrRY4IyqSRqjq7cvCx7eBuUiU');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('232', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('232', 'sessionId', 'CobezgkL6ucY195GFtV9fY9rPD0N-VAbtxb_LviA');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('233', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('233', 'sessionId', 'foFkjnp0k1ERe_wVZG8sRX-BQwjxP9F4AN8x1QkR');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('234', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('234', 'sessionId', 'SwGLQmZfRjZFyJtT3mjy26xwJFi-0WKYWsrNAz5E');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('235', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('235', 'sessionId', 'dRgFjb5mlawIS_JyhDsMEXJJy3jp4tcqLtPiH8PP');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('236', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('236', 'sessionId', 'sUi6NPkeOTw5ZlweRg0P51ZGwjYaDK_6slQ6N433');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('237', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('237', 'sessionId', '5KapWrPvNNNX7rYXYylm4QkEc6JUcnOnNVVnSE3O');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('238', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('238', 'sessionId', 'wfALwvn7IbASsxz4EiLUx0SZ43_auE1kajnyszdc');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('239', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('239', 'sessionId', 'gKqH7d9s_T6THBTij5MxnmIJqlPYM7vr__KL_C0P');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('240', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('240', 'sessionId', 'Qc_dgwK47jnLHPrp1FnONFX32Hc1yaw1G6e8gARL');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('241', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('241', 'sessionId', 'l1qVS-jfk9qwbCZszNJWBG6hHPDNc9H1-19hbrT7');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('242', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('242', 'sessionId', 'jpSqmVL85ojJyOAdfGwtesA_hqztNVa6Ir0kQu4B');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('243', 'remoteAddress', '0:0:0:0:0:0:0:1');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('243', 'sessionId', 'yM5YhHIjDG9RM2cjvSxZ96GIwWW1PxHkT7U-tSaD');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('244', 'remoteAddress', '192.168.249.106');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('244', 'sessionId', 'jn__Syqjx-Rnt_DJwy4GwEugohn7NamHqbbCzo-r');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('245', 'remoteAddress', '192.168.249.106');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('245', 'sessionId', 'r0YJGk29rAJl6X5AU1c7vERUljyhRcM9gnp0q2RN');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('246', 'remoteAddress', '192.168.249.106');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('246', 'sessionId', '2b54BUxTiocw0nF0_G_MQsds9TjCBTalKp7hz45x');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('247', 'remoteAddress', '192.168.249.106');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('247', 'sessionId', 'K75Ari5MtX0Dk7qO1cbNKQFvf_N94TXZPgFQ3igv');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('248', 'remoteAddress', '192.168.249.106');
INSERT INTO `jhi_persistent_audit_evt_data` VALUES ('248', 'sessionId', 'RlaAY-i_DlGqX4YSuNgJcyJKn9fhr3_D-UYfszzK');

-- ----------------------------
-- Table structure for jhi_persistent_token
-- ----------------------------
DROP TABLE IF EXISTS `jhi_persistent_token`;
CREATE TABLE `jhi_persistent_token` (
  `id_` varchar(32) NOT NULL,
  `series_` varchar(76) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `token_value` varchar(76) NOT NULL,
  `token_date` date DEFAULT NULL,
  `ip_address` varchar(39) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `fk_user_persistent_token` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jhi_persistent_token
-- ----------------------------

-- ----------------------------
-- Table structure for logging_event
-- ----------------------------
DROP TABLE IF EXISTS `logging_event`;
CREATE TABLE `logging_event` (
  `event_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestmp` bigint(20) NOT NULL COMMENT '创建时间',
  `formatted_message` text NOT NULL COMMENT '内容',
  `logger_name` varchar(254) NOT NULL COMMENT '名称',
  `level_string` varchar(254) NOT NULL COMMENT '级别',
  `thread_name` varchar(254) DEFAULT NULL COMMENT '线程',
  `reference_flag` smallint(6) DEFAULT NULL COMMENT '引用标识',
  `arg0` varchar(254) DEFAULT NULL COMMENT '参数0',
  `arg1` varchar(254) DEFAULT NULL COMMENT '参数1',
  `arg2` varchar(254) DEFAULT NULL COMMENT '参数2',
  `arg3` varchar(254) DEFAULT NULL COMMENT '参数3',
  `caller_filename` varchar(254) NOT NULL COMMENT '操作文件',
  `caller_class` varchar(254) NOT NULL COMMENT '操作类名',
  `caller_method` varchar(254) NOT NULL COMMENT '操作方法',
  `caller_line` char(4) NOT NULL COMMENT '操作行',
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7219 DEFAULT CHARSET=utf8 COMMENT='日志表';

-- ----------------------------
-- Records of logging_event
-- ----------------------------

-- ----------------------------
-- Table structure for logging_event_exception
-- ----------------------------
DROP TABLE IF EXISTS `logging_event_exception`;
CREATE TABLE `logging_event_exception` (
  `event_id` bigint(20) NOT NULL,
  `i` smallint(6) NOT NULL,
  `trace_line` varchar(254) NOT NULL,
  PRIMARY KEY (`event_id`,`i`),
  CONSTRAINT `logging_event_exception_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `logging_event` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logging_event_exception
-- ----------------------------

-- ----------------------------
-- Table structure for logging_event_property
-- ----------------------------
DROP TABLE IF EXISTS `logging_event_property`;
CREATE TABLE `logging_event_property` (
  `event_id` bigint(20) NOT NULL,
  `mapped_key` varchar(254) NOT NULL,
  `mapped_value` text,
  PRIMARY KEY (`event_id`,`mapped_key`),
  CONSTRAINT `logging_event_property_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `logging_event` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logging_event_property
-- ----------------------------

-- ----------------------------
-- Table structure for sys_area_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_area_t`;
CREATE TABLE `sys_area_t` (
  `id_` int(11) NOT NULL COMMENT '区域id',
  `parent_ids` text NOT NULL COMMENT '所有上级区域节点',
  `parent_id` int(11) DEFAULT NULL COMMENT '上级区域',
  `name_` varchar(32) DEFAULT NULL COMMENT '区域名称',
  `short_name` varchar(32) DEFAULT NULL COMMENT '区域简称',
  `sort_` int(11) NOT NULL COMMENT '序号',
  `level_` int(11) DEFAULT NULL COMMENT '区域等级(1省/2市/3区县)',
  `code_` varchar(32) DEFAULT NULL COMMENT '区域编码',
  `is_leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_modified_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `last_modified_date` datetime DEFAULT NULL COMMENT '修改时间',
  `description_` varchar(225) DEFAULT NULL COMMENT '描述',
  `status_` varchar(32) DEFAULT '0' COMMENT '状态',
  `version_` int(11) NOT NULL DEFAULT '0' COMMENT '版本',
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域表';

-- ----------------------------
-- Records of sys_area_t
-- ----------------------------
INSERT INTO `sys_area_t` VALUES ('1', '', '0', '全国', null, '0', '0', null, '\0', null, null, null, null, null, '0', '0');
INSERT INTO `sys_area_t` VALUES ('110000', '1,', '1', '北京市', null, '1', '1', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '4');
INSERT INTO `sys_area_t` VALUES ('110100', '1,110000,', '110000', '市辖区', '', '0', '2', '', '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', '', '0', '3');
INSERT INTO `sys_area_t` VALUES ('110101', '1,110000,110100,', '110100', '东城区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110102', '1,110000,110100,', '110100', '西城区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110103', '1,110000,110100,', '110100', '崇文区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110104', '1,110000,110100,', '110100', '宣武区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110105', '1,110000,110100,', '110100', '朝阳区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110106', '1,110000,110100,', '110100', '丰台区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110107', '1,110000,110100,', '110100', '石景山区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110108', '1,110000,110100,', '110100', '海淀区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110109', '1,110000,110100,', '110100', '门头沟区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110111', '1,110000,110100,', '110100', '房山区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110112', '1,110000,110100,', '110100', '通州区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110113', '1,110000,110100,', '110100', '顺义区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110114', '1,110000,110100,', '110100', '昌平区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110115', '1,110000,110100,', '110100', '大兴区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110116', '1,110000,110100,', '110100', '怀柔区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110117', '1,110000,110100,', '110100', '平谷区', null, '0', '3', null, '\0', null, '2017-06-30 15:01:29', '1', '2017-06-30 15:01:29', null, '0', '3');
INSERT INTO `sys_area_t` VALUES ('110200', '1,110000,', '110000', '县', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:01:33', null, '0', '2');
INSERT INTO `sys_area_t` VALUES ('110228', '1,110000,110200,', '110200', '密云县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:01:33', null, '0', '2');
INSERT INTO `sys_area_t` VALUES ('110229', '1,110000,110200,', '110200', '延庆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:01:33', null, '0', '2');
INSERT INTO `sys_area_t` VALUES ('120000', '1,', '1', '天津市', null, '2', '1', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '2');
INSERT INTO `sys_area_t` VALUES ('120100', '1,120000,', '120000', '市辖区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120101', '1,120000,120100,', '120100', '和平区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120102', '1,120000,120100,', '120100', '河东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120103', '1,120000,120100,', '120100', '河西区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120104', '1,120000,120100,', '120100', '南开区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120105', '1,120000,120100,', '120100', '河北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120106', '1,120000,120100,', '120100', '红桥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120107', '1,120000,120100,', '120100', '塘沽区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120108', '1,120000,120100,', '120100', '汉沽区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120109', '1,120000,120100,', '120100', '大港区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120110', '1,120000,120100,', '120100', '东丽区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120111', '1,120000,120100,', '120100', '西青区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120112', '1,120000,120100,', '120100', '津南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120113', '1,120000,120100,', '120100', '北辰区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120114', '1,120000,120100,', '120100', '武清区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120115', '1,120000,120100,', '120100', '宝坻区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120200', '1,120000,', '120000', '县', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120221', '1,120000,120200,', '120200', '宁河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120223', '1,120000,120200,', '120200', '静海县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('120225', '1,120000,120200,', '120200', '蓟县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130000', '1,', '1', '河北省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130100', '1,130000,', '130000', '石家庄市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130101', '1,130000,130100,', '130100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130102', '1,130000,130100,', '130100', '长安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130103', '1,130000,130100,', '130100', '桥东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130104', '1,130000,130100,', '130100', '桥西区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130105', '1,130000,130100,', '130100', '新华区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130107', '1,130000,130100,', '130100', '井陉矿区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130108', '1,130000,130100,', '130100', '裕华区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130121', '1,130000,130100,', '130100', '井陉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130123', '1,130000,130100,', '130100', '正定县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130124', '1,130000,130100,', '130100', '栾城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130125', '1,130000,130100,', '130100', '行唐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130126', '1,130000,130100,', '130100', '灵寿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130127', '1,130000,130100,', '130100', '高邑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130128', '1,130000,130100,', '130100', '深泽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130129', '1,130000,130100,', '130100', '赞皇县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130130', '1,130000,130100,', '130100', '无极县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130131', '1,130000,130100,', '130100', '平山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130132', '1,130000,130100,', '130100', '元氏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130133', '1,130000,130100,', '130100', '赵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130181', '1,130000,130100,', '130100', '辛集市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130182', '1,130000,130100,', '130100', '藁城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130183', '1,130000,130100,', '130100', '晋州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130184', '1,130000,130100,', '130100', '新乐市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130185', '1,130000,130100,', '130100', '鹿泉市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130200', '1,130000,', '130000', '唐山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130201', '1,130000,130200,', '130200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130202', '1,130000,130200,', '130200', '路南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130203', '1,130000,130200,', '130200', '路北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130204', '1,130000,130200,', '130200', '古冶区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130205', '1,130000,130200,', '130200', '开平区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130207', '1,130000,130200,', '130200', '丰南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130208', '1,130000,130200,', '130200', '丰润区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130223', '1,130000,130200,', '130200', '滦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130224', '1,130000,130200,', '130200', '滦南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130225', '1,130000,130200,', '130200', '乐亭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130227', '1,130000,130200,', '130200', '迁西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130229', '1,130000,130200,', '130200', '玉田县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130230', '1,130000,130200,', '130200', '唐海县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130281', '1,130000,130200,', '130200', '遵化市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130283', '1,130000,130200,', '130200', '迁安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130300', '1,130000,', '130000', '秦皇岛市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130301', '1,130000,130300,', '130300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130302', '1,130000,130300,', '130300', '海港区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130303', '1,130000,130300,', '130300', '山海关区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130304', '1,130000,130300,', '130300', '北戴河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130321', '1,130000,130300,', '130300', '青龙满族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130322', '1,130000,130300,', '130300', '昌黎县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130323', '1,130000,130300,', '130300', '抚宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130324', '1,130000,130300,', '130300', '卢龙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130400', '1,130000,', '130000', '邯郸市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130401', '1,130000,130400,', '130400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130402', '1,130000,130400,', '130400', '邯山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130403', '1,130000,130400,', '130400', '丛台区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130404', '1,130000,130400,', '130400', '复兴区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130406', '1,130000,130400,', '130400', '峰峰矿区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130421', '1,130000,130400,', '130400', '邯郸县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130423', '1,130000,130400,', '130400', '临漳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130424', '1,130000,130400,', '130400', '成安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130425', '1,130000,130400,', '130400', '大名县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130426', '1,130000,130400,', '130400', '涉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130427', '1,130000,130400,', '130400', '磁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130428', '1,130000,130400,', '130400', '肥乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130429', '1,130000,130400,', '130400', '永年县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130430', '1,130000,130400,', '130400', '邱县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130431', '1,130000,130400,', '130400', '鸡泽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130432', '1,130000,130400,', '130400', '广平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130433', '1,130000,130400,', '130400', '馆陶县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130434', '1,130000,130400,', '130400', '魏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130435', '1,130000,130400,', '130400', '曲周县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130481', '1,130000,130400,', '130400', '武安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130500', '1,130000,', '130000', '邢台市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130501', '1,130000,130500,', '130500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130502', '1,130000,130500,', '130500', '桥东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130503', '1,130000,130500,', '130500', '桥西区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130521', '1,130000,130500,', '130500', '邢台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130522', '1,130000,130500,', '130500', '临城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130523', '1,130000,130500,', '130500', '内丘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130524', '1,130000,130500,', '130500', '柏乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130525', '1,130000,130500,', '130500', '隆尧县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130526', '1,130000,130500,', '130500', '任县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130527', '1,130000,130500,', '130500', '南和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130528', '1,130000,130500,', '130500', '宁晋县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130529', '1,130000,130500,', '130500', '巨鹿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130530', '1,130000,130500,', '130500', '新河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130531', '1,130000,130500,', '130500', '广宗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130532', '1,130000,130500,', '130500', '平乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130533', '1,130000,130500,', '130500', '威县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130534', '1,130000,130500,', '130500', '清河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130535', '1,130000,130500,', '130500', '临西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130581', '1,130000,130500,', '130500', '南宫市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130582', '1,130000,130500,', '130500', '沙河市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130600', '1,130000,', '130000', '保定市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130601', '1,130000,130600,', '130600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130602', '1,130000,130600,', '130600', '新市区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130603', '1,130000,130600,', '130600', '北市区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130604', '1,130000,130600,', '130600', '南市区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130621', '1,130000,130600,', '130600', '满城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130622', '1,130000,130600,', '130600', '清苑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130623', '1,130000,130600,', '130600', '涞水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130624', '1,130000,130600,', '130600', '阜平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130625', '1,130000,130600,', '130600', '徐水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130626', '1,130000,130600,', '130600', '定兴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130627', '1,130000,130600,', '130600', '唐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130628', '1,130000,130600,', '130600', '高阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130629', '1,130000,130600,', '130600', '容城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130630', '1,130000,130600,', '130600', '涞源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130631', '1,130000,130600,', '130600', '望都县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130632', '1,130000,130600,', '130600', '安新县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130633', '1,130000,130600,', '130600', '易县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130634', '1,130000,130600,', '130600', '曲阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130635', '1,130000,130600,', '130600', '蠡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130636', '1,130000,130600,', '130600', '顺平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130637', '1,130000,130600,', '130600', '博野县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130638', '1,130000,130600,', '130600', '雄县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130681', '1,130000,130600,', '130600', '涿州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130682', '1,130000,130600,', '130600', '定州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130683', '1,130000,130600,', '130600', '安国市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130684', '1,130000,130600,', '130600', '高碑店市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130700', '1,130000,', '130000', '张家口市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130701', '1,130000,130700,', '130700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130702', '1,130000,130700,', '130700', '桥东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130703', '1,130000,130700,', '130700', '桥西区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130705', '1,130000,130700,', '130700', '宣化区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130706', '1,130000,130700,', '130700', '下花园区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130721', '1,130000,130700,', '130700', '宣化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130722', '1,130000,130700,', '130700', '张北县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130723', '1,130000,130700,', '130700', '康保县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130724', '1,130000,130700,', '130700', '沽源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130725', '1,130000,130700,', '130700', '尚义县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130726', '1,130000,130700,', '130700', '蔚县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130727', '1,130000,130700,', '130700', '阳原县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130728', '1,130000,130700,', '130700', '怀安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130729', '1,130000,130700,', '130700', '万全县', '', '0', '3', '', '', null, null, '1', '2016-12-28 16:37:55', '', '0', '1');
INSERT INTO `sys_area_t` VALUES ('130730', '1,130000,130700,', '130700', '怀来县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130731', '1,130000,130700,', '130700', '涿鹿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130732', '1,130000,130700,', '130700', '赤城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130733', '1,130000,130700,', '130700', '崇礼县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130800', '1,130000,', '130000', '承德市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130801', '1,130000,130800,', '130800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130802', '1,130000,130800,', '130800', '双桥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130803', '1,130000,130800,', '130800', '双滦区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130804', '1,130000,130800,', '130800', '鹰手营子矿区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130821', '1,130000,130800,', '130800', '承德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130822', '1,130000,130800,', '130800', '兴隆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130823', '1,130000,130800,', '130800', '平泉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130824', '1,130000,130800,', '130800', '滦平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130825', '1,130000,130800,', '130800', '隆化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130826', '1,130000,130800,', '130800', '丰宁满族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130827', '1,130000,130800,', '130800', '宽城满族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130828', '1,130000,130800,', '130800', '围场满族蒙古族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130900', '1,130000,', '130000', '沧州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130901', '1,130000,130900,', '130900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130902', '1,130000,130900,', '130900', '新华区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130903', '1,130000,130900,', '130900', '运河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130921', '1,130000,130900,', '130900', '沧县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130922', '1,130000,130900,', '130900', '青县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130923', '1,130000,130900,', '130900', '东光县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130924', '1,130000,130900,', '130900', '海兴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130925', '1,130000,130900,', '130900', '盐山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130926', '1,130000,130900,', '130900', '肃宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130927', '1,130000,130900,', '130900', '南皮县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130928', '1,130000,130900,', '130900', '吴桥县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130929', '1,130000,130900,', '130900', '献县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130930', '1,130000,130900,', '130900', '孟村回族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130981', '1,130000,130900,', '130900', '泊头市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130982', '1,130000,130900,', '130900', '任丘市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130983', '1,130000,130900,', '130900', '黄骅市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('130984', '1,130000,130900,', '130900', '河间市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131000', '1,130000,', '130000', '廊坊市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131001', '1,130000,131000,', '131000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131002', '1,130000,131000,', '131000', '安次区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131003', '1,130000,131000,', '131000', '广阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131022', '1,130000,131000,', '131000', '固安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131023', '1,130000,131000,', '131000', '永清县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131024', '1,130000,131000,', '131000', '香河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131025', '1,130000,131000,', '131000', '大城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131026', '1,130000,131000,', '131000', '文安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131028', '1,130000,131000,', '131000', '大厂回族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131081', '1,130000,131000,', '131000', '霸州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131082', '1,130000,131000,', '131000', '三河市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131100', '1,130000,', '130000', '衡水市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131101', '1,130000,131100,', '131100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131102', '1,130000,131100,', '131100', '桃城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131121', '1,130000,131100,', '131100', '枣强县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131122', '1,130000,131100,', '131100', '武邑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131123', '1,130000,131100,', '131100', '武强县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131124', '1,130000,131100,', '131100', '饶阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131125', '1,130000,131100,', '131100', '安平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131126', '1,130000,131100,', '131100', '故城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131127', '1,130000,131100,', '131100', '景县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131128', '1,130000,131100,', '131100', '阜城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131181', '1,130000,131100,', '131100', '冀州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('131182', '1,130000,131100,', '131100', '深州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140000', '1,', '1', '山西省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140100', '1,140000,', '140000', '太原市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140101', '1,140000,140100,', '140100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140105', '1,140000,140100,', '140100', '小店区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140106', '1,140000,140100,', '140100', '迎泽区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140107', '1,140000,140100,', '140100', '杏花岭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140108', '1,140000,140100,', '140100', '尖草坪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140109', '1,140000,140100,', '140100', '万柏林区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140110', '1,140000,140100,', '140100', '晋源区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140121', '1,140000,140100,', '140100', '清徐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140122', '1,140000,140100,', '140100', '阳曲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140123', '1,140000,140100,', '140100', '娄烦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140181', '1,140000,140100,', '140100', '古交市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140200', '1,140000,', '140000', '大同市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140201', '1,140000,140200,', '140200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140202', '1,140000,140200,', '140200', '城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140203', '1,140000,140200,', '140200', '矿区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140211', '1,140000,140200,', '140200', '南郊区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140212', '1,140000,140200,', '140200', '新荣区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140221', '1,140000,140200,', '140200', '阳高县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140222', '1,140000,140200,', '140200', '天镇县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140223', '1,140000,140200,', '140200', '广灵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140224', '1,140000,140200,', '140200', '灵丘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140225', '1,140000,140200,', '140200', '浑源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140226', '1,140000,140200,', '140200', '左云县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140227', '1,140000,140200,', '140200', '大同县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140300', '1,140000,', '140000', '阳泉市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140301', '1,140000,140300,', '140300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140302', '1,140000,140300,', '140300', '城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140303', '1,140000,140300,', '140300', '矿区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140311', '1,140000,140300,', '140300', '郊区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140321', '1,140000,140300,', '140300', '平定县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140322', '1,140000,140300,', '140300', '盂县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140400', '1,140000,', '140000', '长治市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140401', '1,140000,140400,', '140400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140402', '1,140000,140400,', '140400', '城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140411', '1,140000,140400,', '140400', '郊区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140421', '1,140000,140400,', '140400', '长治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140423', '1,140000,140400,', '140400', '襄垣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140424', '1,140000,140400,', '140400', '屯留县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140425', '1,140000,140400,', '140400', '平顺县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140426', '1,140000,140400,', '140400', '黎城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140427', '1,140000,140400,', '140400', '壶关县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140428', '1,140000,140400,', '140400', '长子县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140429', '1,140000,140400,', '140400', '武乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140430', '1,140000,140400,', '140400', '沁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140431', '1,140000,140400,', '140400', '沁源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140481', '1,140000,140400,', '140400', '潞城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140500', '1,140000,', '140000', '晋城市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140501', '1,140000,140500,', '140500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140502', '1,140000,140500,', '140500', '城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140521', '1,140000,140500,', '140500', '沁水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140522', '1,140000,140500,', '140500', '阳城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140524', '1,140000,140500,', '140500', '陵川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140525', '1,140000,140500,', '140500', '泽州县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140581', '1,140000,140500,', '140500', '高平市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140600', '1,140000,', '140000', '朔州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140601', '1,140000,140600,', '140600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140602', '1,140000,140600,', '140600', '朔城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140603', '1,140000,140600,', '140600', '平鲁区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140621', '1,140000,140600,', '140600', '山阴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140622', '1,140000,140600,', '140600', '应县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140623', '1,140000,140600,', '140600', '右玉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140624', '1,140000,140600,', '140600', '怀仁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140700', '1,140000,', '140000', '晋中市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140701', '1,140000,140700,', '140700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140702', '1,140000,140700,', '140700', '榆次区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140721', '1,140000,140700,', '140700', '榆社县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140722', '1,140000,140700,', '140700', '左权县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140723', '1,140000,140700,', '140700', '和顺县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140724', '1,140000,140700,', '140700', '昔阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140725', '1,140000,140700,', '140700', '寿阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140726', '1,140000,140700,', '140700', '太谷县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140727', '1,140000,140700,', '140700', '祁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140728', '1,140000,140700,', '140700', '平遥县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140729', '1,140000,140700,', '140700', '灵石县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140781', '1,140000,140700,', '140700', '介休市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140800', '1,140000,', '140000', '运城市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140801', '1,140000,140800,', '140800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140802', '1,140000,140800,', '140800', '盐湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140821', '1,140000,140800,', '140800', '临猗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140822', '1,140000,140800,', '140800', '万荣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140823', '1,140000,140800,', '140800', '闻喜县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140824', '1,140000,140800,', '140800', '稷山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140825', '1,140000,140800,', '140800', '新绛县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140826', '1,140000,140800,', '140800', '绛县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140827', '1,140000,140800,', '140800', '垣曲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140828', '1,140000,140800,', '140800', '夏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140829', '1,140000,140800,', '140800', '平陆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140830', '1,140000,140800,', '140800', '芮城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140881', '1,140000,140800,', '140800', '永济市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140882', '1,140000,140800,', '140800', '河津市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140900', '1,140000,', '140000', '忻州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140901', '1,140000,140900,', '140900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140902', '1,140000,140900,', '140900', '忻府区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140921', '1,140000,140900,', '140900', '定襄县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140922', '1,140000,140900,', '140900', '五台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140923', '1,140000,140900,', '140900', '代县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140924', '1,140000,140900,', '140900', '繁峙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140925', '1,140000,140900,', '140900', '宁武县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140926', '1,140000,140900,', '140900', '静乐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140927', '1,140000,140900,', '140900', '神池县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140928', '1,140000,140900,', '140900', '五寨县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140929', '1,140000,140900,', '140900', '岢岚县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140930', '1,140000,140900,', '140900', '河曲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140931', '1,140000,140900,', '140900', '保德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140932', '1,140000,140900,', '140900', '偏关县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('140981', '1,140000,140900,', '140900', '原平市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141000', '1,140000,', '140000', '临汾市', '', '0', '2', '', '\0', null, null, '1', '2016-12-28 17:02:00', '', '0', '1');
INSERT INTO `sys_area_t` VALUES ('141001', '1,140000,141000,', '141000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141002', '1,140000,141000,', '141000', '尧都区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141021', '1,140000,141000,', '141000', '曲沃县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141022', '1,140000,141000,', '141000', '翼城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141023', '1,140000,141000,', '141000', '襄汾县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141024', '1,140000,141000,', '141000', '洪洞县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141025', '1,140000,141000,', '141000', '古县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141026', '1,140000,141000,', '141000', '安泽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141027', '1,140000,141000,', '141000', '浮山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141028', '1,140000,141000,', '141000', '吉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141029', '1,140000,141000,', '141000', '乡宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141030', '1,140000,141000,', '141000', '大宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141031', '1,140000,141000,', '141000', '隰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141032', '1,140000,141000,', '141000', '永和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141033', '1,140000,141000,', '141000', '蒲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141034', '1,140000,141000,', '141000', '汾西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141081', '1,140000,141000,', '141000', '侯马市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141082', '1,140000,141000,', '141000', '霍州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141100', '1,140000,', '140000', '吕梁市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141101', '1,140000,141100,', '141100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141102', '1,140000,141100,', '141100', '离石区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141121', '1,140000,141100,', '141100', '文水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141122', '1,140000,141100,', '141100', '交城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141123', '1,140000,141100,', '141100', '兴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141124', '1,140000,141100,', '141100', '临县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141125', '1,140000,141100,', '141100', '柳林县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141126', '1,140000,141100,', '141100', '石楼县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141127', '1,140000,141100,', '141100', '岚县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141128', '1,140000,141100,', '141100', '方山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141129', '1,140000,141100,', '141100', '中阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141130', '1,140000,141100,', '141100', '交口县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141181', '1,140000,141100,', '141100', '孝义市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('141182', '1,140000,141100,', '141100', '汾阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150000', '1,', '1', '内蒙古自治区', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150100', '1,150000,', '150000', '呼和浩特市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150101', '1,150000,150100,', '150100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150102', '1,150000,150100,', '150100', '新城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150103', '1,150000,150100,', '150100', '回民区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150104', '1,150000,150100,', '150100', '玉泉区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150105', '1,150000,150100,', '150100', '赛罕区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150121', '1,150000,150100,', '150100', '土默特左旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150122', '1,150000,150100,', '150100', '托克托县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150123', '1,150000,150100,', '150100', '和林格尔县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150124', '1,150000,150100,', '150100', '清水河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150125', '1,150000,150100,', '150100', '武川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150200', '1,150000,', '150000', '包头市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150201', '1,150000,150200,', '150200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150202', '1,150000,150200,', '150200', '东河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150203', '1,150000,150200,', '150200', '昆都仑区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150204', '1,150000,150200,', '150200', '青山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150205', '1,150000,150200,', '150200', '石拐区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150206', '1,150000,150200,', '150200', '白云矿区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150207', '1,150000,150200,', '150200', '九原区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150221', '1,150000,150200,', '150200', '土默特右旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150222', '1,150000,150200,', '150200', '固阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150223', '1,150000,150200,', '150200', '达尔罕茂明安联合旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150300', '1,150000,', '150000', '乌海市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150301', '1,150000,150300,', '150300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150302', '1,150000,150300,', '150300', '海勃湾区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150303', '1,150000,150300,', '150300', '海南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150304', '1,150000,150300,', '150300', '乌达区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150400', '1,150000,', '150000', '赤峰市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150401', '1,150000,150400,', '150400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150402', '1,150000,150400,', '150400', '红山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150403', '1,150000,150400,', '150400', '元宝山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150404', '1,150000,150400,', '150400', '松山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150421', '1,150000,150400,', '150400', '阿鲁科尔沁旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150422', '1,150000,150400,', '150400', '巴林左旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150423', '1,150000,150400,', '150400', '巴林右旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150424', '1,150000,150400,', '150400', '林西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150425', '1,150000,150400,', '150400', '克什克腾旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150426', '1,150000,150400,', '150400', '翁牛特旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150428', '1,150000,150400,', '150400', '喀喇沁旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150429', '1,150000,150400,', '150400', '宁城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150430', '1,150000,150400,', '150400', '敖汉旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150500', '1,150000,', '150000', '通辽市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150501', '1,150000,150500,', '150500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150502', '1,150000,150500,', '150500', '科尔沁区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150521', '1,150000,150500,', '150500', '科尔沁左翼中旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150522', '1,150000,150500,', '150500', '科尔沁左翼后旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150523', '1,150000,150500,', '150500', '开鲁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150524', '1,150000,150500,', '150500', '库伦旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150525', '1,150000,150500,', '150500', '奈曼旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150526', '1,150000,150500,', '150500', '扎鲁特旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150581', '1,150000,150500,', '150500', '霍林郭勒市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150600', '1,150000,', '150000', '鄂尔多斯市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150602', '1,150000,150600,', '150600', '东胜区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150621', '1,150000,150600,', '150600', '达拉特旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150622', '1,150000,150600,', '150600', '准格尔旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150623', '1,150000,150600,', '150600', '鄂托克前旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150624', '1,150000,150600,', '150600', '鄂托克旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150625', '1,150000,150600,', '150600', '杭锦旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150626', '1,150000,150600,', '150600', '乌审旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150627', '1,150000,150600,', '150600', '伊金霍洛旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150700', '1,150000,', '150000', '呼伦贝尔市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150701', '1,150000,150700,', '150700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150702', '1,150000,150700,', '150700', '海拉尔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150721', '1,150000,150700,', '150700', '阿荣旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150722', '1,150000,150700,', '150700', '莫力达瓦达斡尔族自治旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150723', '1,150000,150700,', '150700', '鄂伦春自治旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150724', '1,150000,150700,', '150700', '鄂温克族自治旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150725', '1,150000,150700,', '150700', '陈巴尔虎旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150726', '1,150000,150700,', '150700', '新巴尔虎左旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150727', '1,150000,150700,', '150700', '新巴尔虎右旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150781', '1,150000,150700,', '150700', '满洲里市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150782', '1,150000,150700,', '150700', '牙克石市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150783', '1,150000,150700,', '150700', '扎兰屯市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150784', '1,150000,150700,', '150700', '额尔古纳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150785', '1,150000,150700,', '150700', '根河市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150800', '1,150000,', '150000', '巴彦淖尔市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150801', '1,150000,150800,', '150800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150802', '1,150000,150800,', '150800', '临河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150821', '1,150000,150800,', '150800', '五原县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150822', '1,150000,150800,', '150800', '磴口县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150823', '1,150000,150800,', '150800', '乌拉特前旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150824', '1,150000,150800,', '150800', '乌拉特中旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150825', '1,150000,150800,', '150800', '乌拉特后旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150826', '1,150000,150800,', '150800', '杭锦后旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150900', '1,150000,', '150000', '乌兰察布市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150901', '1,150000,150900,', '150900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150902', '1,150000,150900,', '150900', '集宁区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150921', '1,150000,150900,', '150900', '卓资县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150922', '1,150000,150900,', '150900', '化德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150923', '1,150000,150900,', '150900', '商都县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150924', '1,150000,150900,', '150900', '兴和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150925', '1,150000,150900,', '150900', '凉城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150926', '1,150000,150900,', '150900', '察哈尔右翼前旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150927', '1,150000,150900,', '150900', '察哈尔右翼中旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150928', '1,150000,150900,', '150900', '察哈尔右翼后旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150929', '1,150000,150900,', '150900', '四子王旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('150981', '1,150000,150900,', '150900', '丰镇市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152200', '1,150000,', '150000', '兴安盟', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152201', '1,150000,152200,', '152200', '乌兰浩特市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152202', '1,150000,152200,', '152200', '阿尔山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152221', '1,150000,152200,', '152200', '科尔沁右翼前旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152222', '1,150000,152200,', '152200', '科尔沁右翼中旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152223', '1,150000,152200,', '152200', '扎赉特旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152224', '1,150000,152200,', '152200', '突泉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152500', '1,150000,', '150000', '锡林郭勒盟', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152501', '1,150000,152500,', '152500', '二连浩特市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152502', '1,150000,152500,', '152500', '锡林浩特市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152522', '1,150000,152500,', '152500', '阿巴嘎旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152523', '1,150000,152500,', '152500', '苏尼特左旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152524', '1,150000,152500,', '152500', '苏尼特右旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152525', '1,150000,152500,', '152500', '东乌珠穆沁旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152526', '1,150000,152500,', '152500', '西乌珠穆沁旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152527', '1,150000,152500,', '152500', '太仆寺旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152528', '1,150000,152500,', '152500', '镶黄旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152529', '1,150000,152500,', '152500', '正镶白旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152530', '1,150000,152500,', '152500', '正蓝旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152531', '1,150000,152500,', '152500', '多伦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152900', '1,150000,', '150000', '阿拉善盟', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152921', '1,150000,152900,', '152900', '阿拉善左旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152922', '1,150000,152900,', '152900', '阿拉善右旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('152923', '1,150000,152900,', '152900', '额济纳旗', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210000', '1,', '1', '辽宁省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210100', '1,210000,', '210000', '沈阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210101', '1,210000,210100,', '210100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210102', '1,210000,210100,', '210100', '和平区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210103', '1,210000,210100,', '210100', '沈河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210104', '1,210000,210100,', '210100', '大东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210105', '1,210000,210100,', '210100', '皇姑区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210106', '1,210000,210100,', '210100', '铁西区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210111', '1,210000,210100,', '210100', '苏家屯区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210112', '1,210000,210100,', '210100', '东陵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210113', '1,210000,210100,', '210100', '沈北新区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210114', '1,210000,210100,', '210100', '于洪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210122', '1,210000,210100,', '210100', '辽中县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210123', '1,210000,210100,', '210100', '康平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210124', '1,210000,210100,', '210100', '法库县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210181', '1,210000,210100,', '210100', '新民市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210200', '1,210000,', '210000', '大连市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210201', '1,210000,210200,', '210200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210202', '1,210000,210200,', '210200', '中山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210203', '1,210000,210200,', '210200', '西岗区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210204', '1,210000,210200,', '210200', '沙河口区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210211', '1,210000,210200,', '210200', '甘井子区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210212', '1,210000,210200,', '210200', '旅顺口区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210213', '1,210000,210200,', '210200', '金州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210224', '1,210000,210200,', '210200', '长海县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210281', '1,210000,210200,', '210200', '瓦房店市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210282', '1,210000,210200,', '210200', '普兰店市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210283', '1,210000,210200,', '210200', '庄河市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210300', '1,210000,', '210000', '鞍山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210301', '1,210000,210300,', '210300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210302', '1,210000,210300,', '210300', '铁东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210303', '1,210000,210300,', '210300', '铁西区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210304', '1,210000,210300,', '210300', '立山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210311', '1,210000,210300,', '210300', '千山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210321', '1,210000,210300,', '210300', '台安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210323', '1,210000,210300,', '210300', '岫岩满族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210381', '1,210000,210300,', '210300', '海城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210400', '1,210000,', '210000', '抚顺市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210401', '1,210000,210400,', '210400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210402', '1,210000,210400,', '210400', '新抚区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210403', '1,210000,210400,', '210400', '东洲区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210404', '1,210000,210400,', '210400', '望花区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210411', '1,210000,210400,', '210400', '顺城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210421', '1,210000,210400,', '210400', '抚顺县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210422', '1,210000,210400,', '210400', '新宾满族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210423', '1,210000,210400,', '210400', '清原满族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210500', '1,210000,', '210000', '本溪市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210501', '1,210000,210500,', '210500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210502', '1,210000,210500,', '210500', '平山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210503', '1,210000,210500,', '210500', '溪湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210504', '1,210000,210500,', '210500', '明山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210505', '1,210000,210500,', '210500', '南芬区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210521', '1,210000,210500,', '210500', '本溪满族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210522', '1,210000,210500,', '210500', '桓仁满族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210600', '1,210000,', '210000', '丹东市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210601', '1,210000,210600,', '210600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210602', '1,210000,210600,', '210600', '元宝区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210603', '1,210000,210600,', '210600', '振兴区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210604', '1,210000,210600,', '210600', '振安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210624', '1,210000,210600,', '210600', '宽甸满族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210681', '1,210000,210600,', '210600', '东港市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210682', '1,210000,210600,', '210600', '凤城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210700', '1,210000,', '210000', '锦州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210701', '1,210000,210700,', '210700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210702', '1,210000,210700,', '210700', '古塔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210703', '1,210000,210700,', '210700', '凌河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210711', '1,210000,210700,', '210700', '太和区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210726', '1,210000,210700,', '210700', '黑山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210727', '1,210000,210700,', '210700', '义县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210781', '1,210000,210700,', '210700', '凌海市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210782', '1,210000,210700,', '210700', '北镇市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210800', '1,210000,', '210000', '营口市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210801', '1,210000,210800,', '210800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210802', '1,210000,210800,', '210800', '站前区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210803', '1,210000,210800,', '210800', '西市区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210804', '1,210000,210800,', '210800', '鲅鱼圈区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210811', '1,210000,210800,', '210800', '老边区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210881', '1,210000,210800,', '210800', '盖州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210882', '1,210000,210800,', '210800', '大石桥市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210900', '1,210000,', '210000', '阜新市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210901', '1,210000,210900,', '210900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210902', '1,210000,210900,', '210900', '海州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210903', '1,210000,210900,', '210900', '新邱区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210904', '1,210000,210900,', '210900', '太平区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210905', '1,210000,210900,', '210900', '清河门区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210911', '1,210000,210900,', '210900', '细河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210921', '1,210000,210900,', '210900', '阜新蒙古族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('210922', '1,210000,210900,', '210900', '彰武县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211000', '1,210000,', '210000', '辽阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211001', '1,210000,211000,', '211000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211002', '1,210000,211000,', '211000', '白塔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211003', '1,210000,211000,', '211000', '文圣区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211004', '1,210000,211000,', '211000', '宏伟区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211005', '1,210000,211000,', '211000', '弓长岭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211011', '1,210000,211000,', '211000', '太子河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211021', '1,210000,211000,', '211000', '辽阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211081', '1,210000,211000,', '211000', '灯塔市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211100', '1,210000,', '210000', '盘锦市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211101', '1,210000,211100,', '211100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211102', '1,210000,211100,', '211100', '双台子区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211103', '1,210000,211100,', '211100', '兴隆台区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211121', '1,210000,211100,', '211100', '大洼县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211122', '1,210000,211100,', '211100', '盘山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211200', '1,210000,', '210000', '铁岭市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211201', '1,210000,211200,', '211200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211202', '1,210000,211200,', '211200', '银州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211204', '1,210000,211200,', '211200', '清河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211221', '1,210000,211200,', '211200', '铁岭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211223', '1,210000,211200,', '211200', '西丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211224', '1,210000,211200,', '211200', '昌图县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211281', '1,210000,211200,', '211200', '调兵山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211282', '1,210000,211200,', '211200', '开原市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211300', '1,210000,', '210000', '朝阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211301', '1,210000,211300,', '211300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211302', '1,210000,211300,', '211300', '双塔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211303', '1,210000,211300,', '211300', '龙城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211321', '1,210000,211300,', '211300', '朝阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211322', '1,210000,211300,', '211300', '建平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211324', '1,210000,211300,', '211300', '喀喇沁左翼蒙古族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211381', '1,210000,211300,', '211300', '北票市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211382', '1,210000,211300,', '211300', '凌源市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211400', '1,210000,', '210000', '葫芦岛市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211401', '1,210000,211400,', '211400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211402', '1,210000,211400,', '211400', '连山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211403', '1,210000,211400,', '211400', '龙港区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211404', '1,210000,211400,', '211400', '南票区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211421', '1,210000,211400,', '211400', '绥中县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211422', '1,210000,211400,', '211400', '建昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('211481', '1,210000,211400,', '211400', '兴城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('213342', '1,110000,', '110000', '11', null, '30', '1', null, '\0', '1', '2015-08-27 11:30:17', null, '2016-12-14 15:01:33', null, '-2', '2');
INSERT INTO `sys_area_t` VALUES ('220000', '1,', '1', '吉林省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220100', '1,220000,', '220000', '长春市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220101', '1,220000,220100,', '220100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220102', '1,220000,220100,', '220100', '南关区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220103', '1,220000,220100,', '220100', '宽城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220104', '1,220000,220100,', '220100', '朝阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220105', '1,220000,220100,', '220100', '二道区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220106', '1,220000,220100,', '220100', '绿园区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220112', '1,220000,220100,', '220100', '双阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220122', '1,220000,220100,', '220100', '农安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220181', '1,220000,220100,', '220100', '九台市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220182', '1,220000,220100,', '220100', '榆树市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220183', '1,220000,220100,', '220100', '德惠市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220200', '1,220000,', '220000', '吉林市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220201', '1,220000,220200,', '220200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220202', '1,220000,220200,', '220200', '昌邑区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220203', '1,220000,220200,', '220200', '龙潭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220204', '1,220000,220200,', '220200', '船营区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220211', '1,220000,220200,', '220200', '丰满区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220221', '1,220000,220200,', '220200', '永吉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220281', '1,220000,220200,', '220200', '蛟河市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220282', '1,220000,220200,', '220200', '桦甸市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220283', '1,220000,220200,', '220200', '舒兰市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220284', '1,220000,220200,', '220200', '磐石市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220300', '1,220000,', '220000', '四平市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220301', '1,220000,220300,', '220300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220302', '1,220000,220300,', '220300', '铁西区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220303', '1,220000,220300,', '220300', '铁东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220322', '1,220000,220300,', '220300', '梨树县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220323', '1,220000,220300,', '220300', '伊通满族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220381', '1,220000,220300,', '220300', '公主岭市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220382', '1,220000,220300,', '220300', '双辽市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220400', '1,220000,', '220000', '辽源市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220401', '1,220000,220400,', '220400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220402', '1,220000,220400,', '220400', '龙山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220403', '1,220000,220400,', '220400', '西安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220421', '1,220000,220400,', '220400', '东丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220422', '1,220000,220400,', '220400', '东辽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220500', '1,220000,', '220000', '通化市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220501', '1,220000,220500,', '220500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220502', '1,220000,220500,', '220500', '东昌区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220503', '1,220000,220500,', '220500', '二道江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220521', '1,220000,220500,', '220500', '通化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220523', '1,220000,220500,', '220500', '辉南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220524', '1,220000,220500,', '220500', '柳河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220581', '1,220000,220500,', '220500', '梅河口市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220582', '1,220000,220500,', '220500', '集安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220600', '1,220000,', '220000', '白山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220601', '1,220000,220600,', '220600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220602', '1,220000,220600,', '220600', '八道江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220604', '1,220000,220600,', '220600', '江源区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220621', '1,220000,220600,', '220600', '抚松县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220622', '1,220000,220600,', '220600', '靖宇县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220623', '1,220000,220600,', '220600', '长白朝鲜族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220681', '1,220000,220600,', '220600', '临江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220700', '1,220000,', '220000', '松原市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220701', '1,220000,220700,', '220700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220702', '1,220000,220700,', '220700', '宁江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220721', '1,220000,220700,', '220700', '前郭尔罗斯蒙古族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220722', '1,220000,220700,', '220700', '长岭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220723', '1,220000,220700,', '220700', '乾安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220724', '1,220000,220700,', '220700', '扶余县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220800', '1,220000,', '220000', '白城市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220801', '1,220000,220800,', '220800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220802', '1,220000,220800,', '220800', '洮北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220821', '1,220000,220800,', '220800', '镇赉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220822', '1,220000,220800,', '220800', '通榆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220881', '1,220000,220800,', '220800', '洮南市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('220882', '1,220000,220800,', '220800', '大安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('222400', '1,220000,', '220000', '延边朝鲜族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('222401', '1,220000,222400,', '222400', '延吉市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('222402', '1,220000,222400,', '222400', '图们市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('222403', '1,220000,222400,', '222400', '敦化市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('222404', '1,220000,222400,', '222400', '珲春市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('222405', '1,220000,222400,', '222400', '龙井市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('222406', '1,220000,222400,', '222400', '和龙市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('222424', '1,220000,222400,', '222400', '汪清县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('222426', '1,220000,222400,', '222400', '安图县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230000', '1,', '1', '黑龙江省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230100', '1,230000,', '230000', '哈尔滨市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230101', '1,230000,230100,', '230100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230102', '1,230000,230100,', '230100', '道里区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230103', '1,230000,230100,', '230100', '南岗区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230104', '1,230000,230100,', '230100', '道外区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230108', '1,230000,230100,', '230100', '平房区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230109', '1,230000,230100,', '230100', '松北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230110', '1,230000,230100,', '230100', '香坊区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230111', '1,230000,230100,', '230100', '呼兰区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230112', '1,230000,230100,', '230100', '阿城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230123', '1,230000,230100,', '230100', '依兰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230124', '1,230000,230100,', '230100', '方正县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230125', '1,230000,230100,', '230100', '宾县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230126', '1,230000,230100,', '230100', '巴彦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230127', '1,230000,230100,', '230100', '木兰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230128', '1,230000,230100,', '230100', '通河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230129', '1,230000,230100,', '230100', '延寿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230182', '1,230000,230100,', '230100', '双城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230183', '1,230000,230100,', '230100', '尚志市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230184', '1,230000,230100,', '230100', '五常市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230200', '1,230000,', '230000', '齐齐哈尔市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230201', '1,230000,230200,', '230200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230202', '1,230000,230200,', '230200', '龙沙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230203', '1,230000,230200,', '230200', '建华区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230204', '1,230000,230200,', '230200', '铁锋区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230205', '1,230000,230200,', '230200', '昂昂溪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230206', '1,230000,230200,', '230200', '富拉尔基区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230207', '1,230000,230200,', '230200', '碾子山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230208', '1,230000,230200,', '230200', '梅里斯达斡尔族区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230221', '1,230000,230200,', '230200', '龙江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230223', '1,230000,230200,', '230200', '依安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230224', '1,230000,230200,', '230200', '泰来县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230225', '1,230000,230200,', '230200', '甘南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230227', '1,230000,230200,', '230200', '富裕县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230229', '1,230000,230200,', '230200', '克山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230230', '1,230000,230200,', '230200', '克东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230231', '1,230000,230200,', '230200', '拜泉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230281', '1,230000,230200,', '230200', '讷河市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230300', '1,230000,', '230000', '鸡西市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230301', '1,230000,230300,', '230300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230302', '1,230000,230300,', '230300', '鸡冠区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230303', '1,230000,230300,', '230300', '恒山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230304', '1,230000,230300,', '230300', '滴道区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230305', '1,230000,230300,', '230300', '梨树区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230306', '1,230000,230300,', '230300', '城子河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230307', '1,230000,230300,', '230300', '麻山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230321', '1,230000,230300,', '230300', '鸡东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230381', '1,230000,230300,', '230300', '虎林市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230382', '1,230000,230300,', '230300', '密山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230400', '1,230000,', '230000', '鹤岗市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230401', '1,230000,230400,', '230400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230402', '1,230000,230400,', '230400', '向阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230403', '1,230000,230400,', '230400', '工农区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230404', '1,230000,230400,', '230400', '南山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230405', '1,230000,230400,', '230400', '兴安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230406', '1,230000,230400,', '230400', '东山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230407', '1,230000,230400,', '230400', '兴山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230421', '1,230000,230400,', '230400', '萝北县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230422', '1,230000,230400,', '230400', '绥滨县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230500', '1,230000,', '230000', '双鸭山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230501', '1,230000,230500,', '230500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230502', '1,230000,230500,', '230500', '尖山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230503', '1,230000,230500,', '230500', '岭东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230505', '1,230000,230500,', '230500', '四方台区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230506', '1,230000,230500,', '230500', '宝山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230521', '1,230000,230500,', '230500', '集贤县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230522', '1,230000,230500,', '230500', '友谊县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230523', '1,230000,230500,', '230500', '宝清县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230524', '1,230000,230500,', '230500', '饶河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230600', '1,230000,', '230000', '大庆市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230601', '1,230000,230600,', '230600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230602', '1,230000,230600,', '230600', '萨尔图区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230603', '1,230000,230600,', '230600', '龙凤区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230604', '1,230000,230600,', '230600', '让胡路区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230605', '1,230000,230600,', '230600', '红岗区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230606', '1,230000,230600,', '230600', '大同区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230621', '1,230000,230600,', '230600', '肇州县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230622', '1,230000,230600,', '230600', '肇源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230623', '1,230000,230600,', '230600', '林甸县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230624', '1,230000,230600,', '230600', '杜尔伯特蒙古族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230700', '1,230000,', '230000', '伊春市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230701', '1,230000,230700,', '230700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230702', '1,230000,230700,', '230700', '伊春区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230703', '1,230000,230700,', '230700', '南岔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230704', '1,230000,230700,', '230700', '友好区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230705', '1,230000,230700,', '230700', '西林区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230706', '1,230000,230700,', '230700', '翠峦区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230707', '1,230000,230700,', '230700', '新青区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230708', '1,230000,230700,', '230700', '美溪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230709', '1,230000,230700,', '230700', '金山屯区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230710', '1,230000,230700,', '230700', '五营区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230711', '1,230000,230700,', '230700', '乌马河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230712', '1,230000,230700,', '230700', '汤旺河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230713', '1,230000,230700,', '230700', '带岭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230714', '1,230000,230700,', '230700', '乌伊岭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230715', '1,230000,230700,', '230700', '红星区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230716', '1,230000,230700,', '230700', '上甘岭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230722', '1,230000,230700,', '230700', '嘉荫县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230781', '1,230000,230700,', '230700', '铁力市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230800', '1,230000,', '230000', '佳木斯市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230801', '1,230000,230800,', '230800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230803', '1,230000,230800,', '230800', '向阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230804', '1,230000,230800,', '230800', '前进区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230805', '1,230000,230800,', '230800', '东风区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230811', '1,230000,230800,', '230800', '郊区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230822', '1,230000,230800,', '230800', '桦南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230826', '1,230000,230800,', '230800', '桦川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:58:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230828', '1,230000,230800,', '230800', '汤原县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230833', '1,230000,230800,', '230800', '抚远县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230881', '1,230000,230800,', '230800', '同江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230882', '1,230000,230800,', '230800', '富锦市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230900', '1,230000,', '230000', '七台河市', '', '30', '2', '', '\0', null, null, '1', '2016-12-28 17:24:52', '', '0', '1');
INSERT INTO `sys_area_t` VALUES ('230901', '1,230000,230900,', '230900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230902', '1,230000,230900,', '230900', '新兴区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230903', '1,230000,230900,', '230900', '桃山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230904', '1,230000,230900,', '230900', '茄子河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('230921', '1,230000,230900,', '230900', '勃利县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231000', '1,230000,', '230000', '牡丹江市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231001', '1,230000,231000,', '231000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231002', '1,230000,231000,', '231000', '东安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231003', '1,230000,231000,', '231000', '阳明区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231004', '1,230000,231000,', '231000', '爱民区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231005', '1,230000,231000,', '231000', '西安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231024', '1,230000,231000,', '231000', '东宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231025', '1,230000,231000,', '231000', '林口县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231081', '1,230000,231000,', '231000', '绥芬河市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231083', '1,230000,231000,', '231000', '海林市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231084', '1,230000,231000,', '231000', '宁安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231085', '1,230000,231000,', '231000', '穆棱市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231100', '1,230000,', '230000', '黑河市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231101', '1,230000,231100,', '231100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231102', '1,230000,231100,', '231100', '爱辉区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231121', '1,230000,231100,', '231100', '嫩江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231123', '1,230000,231100,', '231100', '逊克县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231124', '1,230000,231100,', '231100', '孙吴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231181', '1,230000,231100,', '231100', '北安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231182', '1,230000,231100,', '231100', '五大连池市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231200', '1,230000,', '230000', '绥化市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231201', '1,230000,231200,', '231200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231202', '1,230000,231200,', '231200', '北林区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231221', '1,230000,231200,', '231200', '望奎县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231222', '1,230000,231200,', '231200', '兰西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231223', '1,230000,231200,', '231200', '青冈县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231224', '1,230000,231200,', '231200', '庆安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231225', '1,230000,231200,', '231200', '明水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231226', '1,230000,231200,', '231200', '绥棱县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231281', '1,230000,231200,', '231200', '安达市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231282', '1,230000,231200,', '231200', '肇东市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('231283', '1,230000,231200,', '231200', '海伦市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('232700', '1,230000,', '230000', '大兴安岭地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('232701', '1,230000,232700,', '232700', '加格达奇区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('232702', '1,230000,232700,', '232700', '松岭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('232703', '1,230000,232700,', '232700', '新林区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('232704', '1,230000,232700,', '232700', '呼中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('232721', '1,230000,232700,', '232700', '呼玛县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('232722', '1,230000,232700,', '232700', '塔河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('232723', '1,230000,232700,', '232700', '漠河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310000', '1,', '1', '上海市', '', '0', '1', '', '\0', null, null, '1', '2016-12-28 15:20:49', '', '0', '1');
INSERT INTO `sys_area_t` VALUES ('310100', '1,310000,', '310000', '市辖区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310101', '1,310000,310100,', '310100', '黄浦区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310103', '1,310000,310100,', '310100', '卢湾区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310104', '1,310000,310100,', '310100', '徐汇区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310105', '1,310000,310100,', '310100', '长宁区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310106', '1,310000,310100,', '310100', '静安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310107', '1,310000,310100,', '310100', '普陀区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310108', '1,310000,310100,', '310100', '闸北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310109', '1,310000,310100,', '310100', '虹口区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310110', '1,310000,310100,', '310100', '杨浦区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310112', '1,310000,310100,', '310100', '闵行区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310113', '1,310000,310100,', '310100', '宝山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310114', '1,310000,310100,', '310100', '嘉定区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310115', '1,310000,310100,', '310100', '浦东新区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310116', '1,310000,310100,', '310100', '金山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310117', '1,310000,310100,', '310100', '松江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310118', '1,310000,310100,', '310100', '青浦区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310119', '1,310000,310100,', '310100', '南汇区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310120', '1,310000,310100,', '310100', '奉贤区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310200', '1,310000,', '310000', '县', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('310230', '1,310000,310200,', '310200', '崇明县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320000', '1,', '1', '江苏省', null, '0', '1', null, '\0', null, null, '1', '2016-12-28 12:30:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320100', '1,320000,', '320000', '南京市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320101', '1,320000,320100,', '320100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320102', '1,320000,320100,', '320100', '玄武区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320103', '1,320000,320100,', '320100', '白下区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320104', '1,320000,320100,', '320100', '秦淮区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320105', '1,320000,320100,', '320100', '建邺区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320106', '1,320000,320100,', '320100', '鼓楼区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320107', '1,320000,320100,', '320100', '下关区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320111', '1,320000,320100,', '320100', '浦口区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320113', '1,320000,320100,', '320100', '栖霞区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320114', '1,320000,320100,', '320100', '雨花台区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320115', '1,320000,320100,', '320100', '江宁区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320116', '1,320000,320100,', '320100', '六合区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320124', '1,320000,320100,', '320100', '溧水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320125', '1,320000,320100,', '320100', '高淳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320200', '1,320000,', '320000', '无锡市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320201', '1,320000,320200,', '320200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320202', '1,320000,320200,', '320200', '崇安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320203', '1,320000,320200,', '320200', '南长区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320204', '1,320000,320200,', '320200', '北塘区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320205', '1,320000,320200,', '320200', '锡山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320206', '1,320000,320200,', '320200', '惠山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320211', '1,320000,320200,', '320200', '滨湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320281', '1,320000,320200,', '320200', '江阴市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320282', '1,320000,320200,', '320200', '宜兴市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320300', '1,320000,', '320000', '徐州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320301', '1,320000,320300,', '320300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320302', '1,320000,320300,', '320300', '鼓楼区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320303', '1,320000,320300,', '320300', '云龙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320304', '1,320000,320300,', '320300', '九里区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320305', '1,320000,320300,', '320300', '贾汪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320311', '1,320000,320300,', '320300', '泉山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320321', '1,320000,320300,', '320300', '丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320322', '1,320000,320300,', '320300', '沛县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320323', '1,320000,320300,', '320300', '铜山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320324', '1,320000,320300,', '320300', '睢宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320381', '1,320000,320300,', '320300', '新沂市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320382', '1,320000,320300,', '320300', '邳州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320400', '1,320000,', '320000', '常州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320401', '1,320000,320400,', '320400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320402', '1,320000,320400,', '320400', '天宁区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320404', '1,320000,320400,', '320400', '钟楼区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320405', '1,320000,320400,', '320400', '戚墅堰区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320411', '1,320000,320400,', '320400', '新北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320412', '1,320000,320400,', '320400', '武进区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320481', '1,320000,320400,', '320400', '溧阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320482', '1,320000,320400,', '320400', '金坛市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320500', '1,320000,', '320000', '苏州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320501', '1,320000,320500,', '320500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320502', '1,320000,320500,', '320500', '沧浪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320503', '1,320000,320500,', '320500', '平江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320504', '1,320000,320500,', '320500', '金阊区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320505', '1,320000,320500,', '320500', '虎丘区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320506', '1,320000,320500,', '320500', '吴中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320507', '1,320000,320500,', '320500', '相城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320581', '1,320000,320500,', '320500', '常熟市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320582', '1,320000,320500,', '320500', '张家港市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320583', '1,320000,320500,', '320500', '昆山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320584', '1,320000,320500,', '320500', '吴江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320585', '1,320000,320500,', '320500', '太仓市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320600', '1,320000,', '320000', '南通市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320601', '1,320000,320600,', '320600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320602', '1,320000,320600,', '320600', '崇川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320611', '1,320000,320600,', '320600', '港闸区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320621', '1,320000,320600,', '320600', '海安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320623', '1,320000,320600,', '320600', '如东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320681', '1,320000,320600,', '320600', '启东市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320682', '1,320000,320600,', '320600', '如皋市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320683', '1,320000,320600,', '320600', '通州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320684', '1,320000,320600,', '320600', '海门市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320700', '1,320000,', '320000', '连云港市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320701', '1,320000,320700,', '320700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320703', '1,320000,320700,', '320700', '连云区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320705', '1,320000,320700,', '320700', '新浦区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320706', '1,320000,320700,', '320700', '海州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320721', '1,320000,320700,', '320700', '赣榆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320722', '1,320000,320700,', '320700', '东海县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320723', '1,320000,320700,', '320700', '灌云县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320724', '1,320000,320700,', '320700', '灌南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320800', '1,320000,', '320000', '淮安市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320801', '1,320000,320800,', '320800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320802', '1,320000,320800,', '320800', '清河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320803', '1,320000,320800,', '320800', '楚州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320804', '1,320000,320800,', '320800', '淮阴区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320811', '1,320000,320800,', '320800', '清浦区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320826', '1,320000,320800,', '320800', '涟水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320829', '1,320000,320800,', '320800', '洪泽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320830', '1,320000,320800,', '320800', '盱眙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320831', '1,320000,320800,', '320800', '金湖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320900', '1,320000,', '320000', '盐城市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320901', '1,320000,320900,', '320900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320902', '1,320000,320900,', '320900', '亭湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320903', '1,320000,320900,', '320900', '盐都区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320921', '1,320000,320900,', '320900', '响水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320922', '1,320000,320900,', '320900', '滨海县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320923', '1,320000,320900,', '320900', '阜宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320924', '1,320000,320900,', '320900', '射阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320925', '1,320000,320900,', '320900', '建湖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320981', '1,320000,320900,', '320900', '东台市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('320982', '1,320000,320900,', '320900', '大丰市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321000', '1,320000,', '320000', '扬州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321001', '1,320000,321000,', '321000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321002', '1,320000,321000,', '321000', '广陵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321003', '1,320000,321000,', '321000', '邗江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321011', '1,320000,321000,', '321000', '维扬区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321023', '1,320000,321000,', '321000', '宝应县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321081', '1,320000,321000,', '321000', '仪征市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321084', '1,320000,321000,', '321000', '高邮市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321088', '1,320000,321000,', '321000', '江都市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321100', '1,320000,', '320000', '镇江市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321101', '1,320000,321100,', '321100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321102', '1,320000,321100,', '321100', '京口区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321111', '1,320000,321100,', '321100', '润州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321112', '1,320000,321100,', '321100', '丹徒区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321181', '1,320000,321100,', '321100', '丹阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321182', '1,320000,321100,', '321100', '扬中市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321183', '1,320000,321100,', '321100', '句容市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321200', '1,320000,', '320000', '泰州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321201', '1,320000,321200,', '321200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321202', '1,320000,321200,', '321200', '海陵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321203', '1,320000,321200,', '321200', '高港区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321281', '1,320000,321200,', '321200', '兴化市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321282', '1,320000,321200,', '321200', '靖江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321283', '1,320000,321200,', '321200', '泰兴市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321284', '1,320000,321200,', '321200', '姜堰市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321300', '1,320000,', '320000', '宿迁市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321301', '1,320000,321300,', '321300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321302', '1,320000,321300,', '321300', '宿城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321311', '1,320000,321300,', '321300', '宿豫区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321322', '1,320000,321300,', '321300', '沭阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321323', '1,320000,321300,', '321300', '泗阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('321324', '1,320000,321300,', '321300', '泗洪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330000', '1,', '1', '浙江省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330100', '1,330000,', '330000', '杭州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330101', '1,330000,330100,', '330100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330102', '1,330000,330100,', '330100', '上城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330103', '1,330000,330100,', '330100', '下城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330104', '1,330000,330100,', '330100', '江干区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330105', '1,330000,330100,', '330100', '拱墅区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330106', '1,330000,330100,', '330100', '西湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330108', '1,330000,330100,', '330100', '滨江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330109', '1,330000,330100,', '330100', '萧山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330110', '1,330000,330100,', '330100', '余杭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330122', '1,330000,330100,', '330100', '桐庐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330127', '1,330000,330100,', '330100', '淳安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330182', '1,330000,330100,', '330100', '建德市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330183', '1,330000,330100,', '330100', '富阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330185', '1,330000,330100,', '330100', '临安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330200', '1,330000,', '330000', '宁波市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330201', '1,330000,330200,', '330200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330203', '1,330000,330200,', '330200', '海曙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330204', '1,330000,330200,', '330200', '江东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330205', '1,330000,330200,', '330200', '江北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330206', '1,330000,330200,', '330200', '北仑区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330211', '1,330000,330200,', '330200', '镇海区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330212', '1,330000,330200,', '330200', '鄞州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330225', '1,330000,330200,', '330200', '象山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330226', '1,330000,330200,', '330200', '宁海县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330281', '1,330000,330200,', '330200', '余姚市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330282', '1,330000,330200,', '330200', '慈溪市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330283', '1,330000,330200,', '330200', '奉化市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330300', '1,330000,', '330000', '温州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330301', '1,330000,330300,', '330300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330302', '1,330000,330300,', '330300', '鹿城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330303', '1,330000,330300,', '330300', '龙湾区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330304', '1,330000,330300,', '330300', '瓯海区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330322', '1,330000,330300,', '330300', '洞头县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330324', '1,330000,330300,', '330300', '永嘉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330326', '1,330000,330300,', '330300', '平阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330327', '1,330000,330300,', '330300', '苍南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330328', '1,330000,330300,', '330300', '文成县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330329', '1,330000,330300,', '330300', '泰顺县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330381', '1,330000,330300,', '330300', '瑞安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330382', '1,330000,330300,', '330300', '乐清市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330400', '1,330000,', '330000', '嘉兴市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330401', '1,330000,330400,', '330400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330402', '1,330000,330400,', '330400', '秀城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330411', '1,330000,330400,', '330400', '秀洲区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330421', '1,330000,330400,', '330400', '嘉善县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330424', '1,330000,330400,', '330400', '海盐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330481', '1,330000,330400,', '330400', '海宁市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330482', '1,330000,330400,', '330400', '平湖市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330483', '1,330000,330400,', '330400', '桐乡市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330500', '1,330000,', '330000', '湖州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330501', '1,330000,330500,', '330500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330502', '1,330000,330500,', '330500', '吴兴区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330503', '1,330000,330500,', '330500', '南浔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330521', '1,330000,330500,', '330500', '德清县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330522', '1,330000,330500,', '330500', '长兴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330523', '1,330000,330500,', '330500', '安吉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330600', '1,330000,', '330000', '绍兴市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330601', '1,330000,330600,', '330600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330602', '1,330000,330600,', '330600', '越城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330621', '1,330000,330600,', '330600', '绍兴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330624', '1,330000,330600,', '330600', '新昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330681', '1,330000,330600,', '330600', '诸暨市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330682', '1,330000,330600,', '330600', '上虞市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330683', '1,330000,330600,', '330600', '嵊州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330700', '1,330000,', '330000', '金华市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330701', '1,330000,330700,', '330700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330702', '1,330000,330700,', '330700', '婺城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330703', '1,330000,330700,', '330700', '金东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330723', '1,330000,330700,', '330700', '武义县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330726', '1,330000,330700,', '330700', '浦江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330727', '1,330000,330700,', '330700', '磐安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330781', '1,330000,330700,', '330700', '兰溪市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330782', '1,330000,330700,', '330700', '义乌市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330783', '1,330000,330700,', '330700', '东阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330784', '1,330000,330700,', '330700', '永康市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330800', '1,330000,', '330000', '衢州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330801', '1,330000,330800,', '330800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330802', '1,330000,330800,', '330800', '柯城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330803', '1,330000,330800,', '330800', '衢江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330822', '1,330000,330800,', '330800', '常山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330824', '1,330000,330800,', '330800', '开化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330825', '1,330000,330800,', '330800', '龙游县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330881', '1,330000,330800,', '330800', '江山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330900', '1,330000,', '330000', '舟山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330901', '1,330000,330900,', '330900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330902', '1,330000,330900,', '330900', '定海区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330903', '1,330000,330900,', '330900', '普陀区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330921', '1,330000,330900,', '330900', '岱山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('330922', '1,330000,330900,', '330900', '嵊泗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331000', '1,330000,', '330000', '台州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331001', '1,330000,331000,', '331000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331002', '1,330000,331000,', '331000', '椒江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331003', '1,330000,331000,', '331000', '黄岩区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331004', '1,330000,331000,', '331000', '路桥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331021', '1,330000,331000,', '331000', '玉环县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331022', '1,330000,331000,', '331000', '三门县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331023', '1,330000,331000,', '331000', '天台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331024', '1,330000,331000,', '331000', '仙居县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331081', '1,330000,331000,', '331000', '温岭市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331082', '1,330000,331000,', '331000', '临海市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331100', '1,330000,', '330000', '丽水市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331101', '1,330000,331100,', '331100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331102', '1,330000,331100,', '331100', '莲都区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331121', '1,330000,331100,', '331100', '青田县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331122', '1,330000,331100,', '331100', '缙云县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331123', '1,330000,331100,', '331100', '遂昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331124', '1,330000,331100,', '331100', '松阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331125', '1,330000,331100,', '331100', '云和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331126', '1,330000,331100,', '331100', '庆元县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331127', '1,330000,331100,', '331100', '景宁畲族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('331181', '1,330000,331100,', '331100', '龙泉市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340000', '1,', '1', '安徽省', null, '0', '1', null, '\0', null, null, '1', '2016-12-28 12:24:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340100', '1,340000,', '340000', '合肥市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340101', '1,340000,340100,', '340100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340102', '1,340000,340100,', '340100', '瑶海区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340103', '1,340000,340100,', '340100', '庐阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340104', '1,340000,340100,', '340100', '蜀山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340111', '1,340000,340100,', '340100', '包河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340121', '1,340000,340100,', '340100', '长丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340122', '1,340000,340100,', '340100', '肥东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340123', '1,340000,340100,', '340100', '肥西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340200', '1,340000,', '340000', '芜湖市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340201', '1,340000,340200,', '340200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340202', '1,340000,340200,', '340200', '镜湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340203', '1,340000,340200,', '340200', '弋江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340207', '1,340000,340200,', '340200', '鸠江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340208', '1,340000,340200,', '340200', '三山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340221', '1,340000,340200,', '340200', '芜湖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340222', '1,340000,340200,', '340200', '繁昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340223', '1,340000,340200,', '340200', '南陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340300', '1,340000,', '340000', '蚌埠市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340301', '1,340000,340300,', '340300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340302', '1,340000,340300,', '340300', '龙子湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340303', '1,340000,340300,', '340300', '蚌山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340304', '1,340000,340300,', '340300', '禹会区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340311', '1,340000,340300,', '340300', '淮上区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340321', '1,340000,340300,', '340300', '怀远县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340322', '1,340000,340300,', '340300', '五河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340323', '1,340000,340300,', '340300', '固镇县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340400', '1,340000,', '340000', '淮南市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340401', '1,340000,340400,', '340400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340402', '1,340000,340400,', '340400', '大通区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340403', '1,340000,340400,', '340400', '田家庵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340404', '1,340000,340400,', '340400', '谢家集区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340405', '1,340000,340400,', '340400', '八公山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340406', '1,340000,340400,', '340400', '潘集区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340421', '1,340000,340400,', '340400', '凤台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340500', '1,340000,', '340000', '马鞍山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340501', '1,340000,340500,', '340500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340502', '1,340000,340500,', '340500', '金家庄区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340503', '1,340000,340500,', '340500', '花山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340504', '1,340000,340500,', '340500', '雨山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340521', '1,340000,340500,', '340500', '当涂县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340600', '1,340000,', '340000', '淮北市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340601', '1,340000,340600,', '340600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340602', '1,340000,340600,', '340600', '杜集区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340603', '1,340000,340600,', '340600', '相山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340604', '1,340000,340600,', '340600', '烈山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340621', '1,340000,340600,', '340600', '濉溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340700', '1,340000,', '340000', '铜陵市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340701', '1,340000,340700,', '340700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340702', '1,340000,340700,', '340700', '铜官山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340703', '1,340000,340700,', '340700', '狮子山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340711', '1,340000,340700,', '340700', '郊区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340721', '1,340000,340700,', '340700', '铜陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340800', '1,340000,', '340000', '安庆市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340801', '1,340000,340800,', '340800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340802', '1,340000,340800,', '340800', '迎江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340803', '1,340000,340800,', '340800', '大观区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340811', '1,340000,340800,', '340800', '宜秀区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340822', '1,340000,340800,', '340800', '怀宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340823', '1,340000,340800,', '340800', '枞阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340824', '1,340000,340800,', '340800', '潜山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340825', '1,340000,340800,', '340800', '太湖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340826', '1,340000,340800,', '340800', '宿松县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340827', '1,340000,340800,', '340800', '望江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340828', '1,340000,340800,', '340800', '岳西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('340881', '1,340000,340800,', '340800', '桐城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341000', '1,340000,', '340000', '黄山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341001', '1,340000,341000,', '341000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341002', '1,340000,341000,', '341000', '屯溪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341003', '1,340000,341000,', '341000', '黄山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341004', '1,340000,341000,', '341000', '徽州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341021', '1,340000,341000,', '341000', '歙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341022', '1,340000,341000,', '341000', '休宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341023', '1,340000,341000,', '341000', '黟县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341024', '1,340000,341000,', '341000', '祁门县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341100', '1,340000,', '340000', '滁州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341101', '1,340000,341100,', '341100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341102', '1,340000,341100,', '341100', '琅琊区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341103', '1,340000,341100,', '341100', '南谯区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341122', '1,340000,341100,', '341100', '来安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341124', '1,340000,341100,', '341100', '全椒县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341125', '1,340000,341100,', '341100', '定远县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341126', '1,340000,341100,', '341100', '凤阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341181', '1,340000,341100,', '341100', '天长市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341182', '1,340000,341100,', '341100', '明光市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341200', '1,340000,', '340000', '阜阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341201', '1,340000,341200,', '341200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341202', '1,340000,341200,', '341200', '颍州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341203', '1,340000,341200,', '341200', '颍东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341204', '1,340000,341200,', '341200', '颍泉区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341221', '1,340000,341200,', '341200', '临泉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341222', '1,340000,341200,', '341200', '太和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341225', '1,340000,341200,', '341200', '阜南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341226', '1,340000,341200,', '341200', '颍上县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341282', '1,340000,341200,', '341200', '界首市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341300', '1,340000,', '340000', '宿州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341301', '1,340000,341300,', '341300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341302', '1,340000,341300,', '341300', '埇桥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341321', '1,340000,341300,', '341300', '砀山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341322', '1,340000,341300,', '341300', '萧县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341323', '1,340000,341300,', '341300', '灵璧县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341324', '1,340000,341300,', '341300', '泗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341400', '1,340000,', '340000', '巢湖市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341401', '1,340000,341400,', '341400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341402', '1,340000,341400,', '341400', '居巢区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341421', '1,340000,341400,', '341400', '庐江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341422', '1,340000,341400,', '341400', '无为县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341423', '1,340000,341400,', '341400', '含山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341424', '1,340000,341400,', '341400', '和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341500', '1,340000,', '340000', '六安市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341501', '1,340000,341500,', '341500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341502', '1,340000,341500,', '341500', '金安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341503', '1,340000,341500,', '341500', '裕安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341521', '1,340000,341500,', '341500', '寿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341522', '1,340000,341500,', '341500', '霍邱县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341523', '1,340000,341500,', '341500', '舒城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341524', '1,340000,341500,', '341500', '金寨县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341525', '1,340000,341500,', '341500', '霍山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341600', '1,340000,', '340000', '亳州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341601', '1,340000,341600,', '341600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341602', '1,340000,341600,', '341600', '谯城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341621', '1,340000,341600,', '341600', '涡阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341622', '1,340000,341600,', '341600', '蒙城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341623', '1,340000,341600,', '341600', '利辛县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341700', '1,340000,', '340000', '池州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341701', '1,340000,341700,', '341700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341702', '1,340000,341700,', '341700', '贵池区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341721', '1,340000,341700,', '341700', '东至县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341722', '1,340000,341700,', '341700', '石台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341723', '1,340000,341700,', '341700', '青阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341800', '1,340000,', '340000', '宣城市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341801', '1,340000,341800,', '341800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341802', '1,340000,341800,', '341800', '宣州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341821', '1,340000,341800,', '341800', '郎溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341822', '1,340000,341800,', '341800', '广德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341823', '1,340000,341800,', '341800', '泾县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341824', '1,340000,341800,', '341800', '绩溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341825', '1,340000,341800,', '341800', '旌德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('341881', '1,340000,341800,', '341800', '宁国市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350000', '1,', '1', '福建省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350100', '1,350000,', '350000', '福州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350101', '1,350000,350100,', '350100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350102', '1,350000,350100,', '350100', '鼓楼区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350103', '1,350000,350100,', '350100', '台江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350104', '1,350000,350100,', '350100', '仓山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350105', '1,350000,350100,', '350100', '马尾区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350111', '1,350000,350100,', '350100', '晋安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350121', '1,350000,350100,', '350100', '闽侯县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350122', '1,350000,350100,', '350100', '连江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350123', '1,350000,350100,', '350100', '罗源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350124', '1,350000,350100,', '350100', '闽清县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350125', '1,350000,350100,', '350100', '永泰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350128', '1,350000,350100,', '350100', '平潭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350181', '1,350000,350100,', '350100', '福清市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350182', '1,350000,350100,', '350100', '长乐市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350200', '1,350000,', '350000', '厦门市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350201', '1,350000,350200,', '350200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350203', '1,350000,350200,', '350200', '思明区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350205', '1,350000,350200,', '350200', '海沧区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350206', '1,350000,350200,', '350200', '湖里区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350211', '1,350000,350200,', '350200', '集美区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350212', '1,350000,350200,', '350200', '同安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350213', '1,350000,350200,', '350200', '翔安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350300', '1,350000,', '350000', '莆田市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350301', '1,350000,350300,', '350300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350302', '1,350000,350300,', '350300', '城厢区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350303', '1,350000,350300,', '350300', '涵江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350304', '1,350000,350300,', '350300', '荔城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350305', '1,350000,350300,', '350300', '秀屿区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350322', '1,350000,350300,', '350300', '仙游县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350400', '1,350000,', '350000', '三明市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350401', '1,350000,350400,', '350400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350402', '1,350000,350400,', '350400', '梅列区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350403', '1,350000,350400,', '350400', '三元区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350421', '1,350000,350400,', '350400', '明溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350423', '1,350000,350400,', '350400', '清流县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350424', '1,350000,350400,', '350400', '宁化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350425', '1,350000,350400,', '350400', '大田县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350426', '1,350000,350400,', '350400', '尤溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350427', '1,350000,350400,', '350400', '沙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350428', '1,350000,350400,', '350400', '将乐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350429', '1,350000,350400,', '350400', '泰宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350430', '1,350000,350400,', '350400', '建宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350481', '1,350000,350400,', '350400', '永安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350500', '1,350000,', '350000', '泉州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350501', '1,350000,350500,', '350500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350502', '1,350000,350500,', '350500', '鲤城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350503', '1,350000,350500,', '350500', '丰泽区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350504', '1,350000,350500,', '350500', '洛江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350505', '1,350000,350500,', '350500', '泉港区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350521', '1,350000,350500,', '350500', '惠安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350524', '1,350000,350500,', '350500', '安溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350525', '1,350000,350500,', '350500', '永春县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350526', '1,350000,350500,', '350500', '德化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350527', '1,350000,350500,', '350500', '金门县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350581', '1,350000,350500,', '350500', '石狮市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350582', '1,350000,350500,', '350500', '晋江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350583', '1,350000,350500,', '350500', '南安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350600', '1,350000,', '350000', '漳州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350601', '1,350000,350600,', '350600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350602', '1,350000,350600,', '350600', '芗城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350603', '1,350000,350600,', '350600', '龙文区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350622', '1,350000,350600,', '350600', '云霄县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350623', '1,350000,350600,', '350600', '漳浦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350624', '1,350000,350600,', '350600', '诏安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350625', '1,350000,350600,', '350600', '长泰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350626', '1,350000,350600,', '350600', '东山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350627', '1,350000,350600,', '350600', '南靖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350628', '1,350000,350600,', '350600', '平和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350629', '1,350000,350600,', '350600', '华安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350681', '1,350000,350600,', '350600', '龙海市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350700', '1,350000,', '350000', '南平市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350701', '1,350000,350700,', '350700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350702', '1,350000,350700,', '350700', '延平区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350721', '1,350000,350700,', '350700', '顺昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350722', '1,350000,350700,', '350700', '浦城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350723', '1,350000,350700,', '350700', '光泽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350724', '1,350000,350700,', '350700', '松溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350725', '1,350000,350700,', '350700', '政和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350781', '1,350000,350700,', '350700', '邵武市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350782', '1,350000,350700,', '350700', '武夷山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350783', '1,350000,350700,', '350700', '建瓯市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350784', '1,350000,350700,', '350700', '建阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350800', '1,350000,', '350000', '龙岩市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350801', '1,350000,350800,', '350800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350802', '1,350000,350800,', '350800', '新罗区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350821', '1,350000,350800,', '350800', '长汀县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350822', '1,350000,350800,', '350800', '永定县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350823', '1,350000,350800,', '350800', '上杭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350824', '1,350000,350800,', '350800', '武平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350825', '1,350000,350800,', '350800', '连城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350881', '1,350000,350800,', '350800', '漳平市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350900', '1,350000,', '350000', '宁德市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350901', '1,350000,350900,', '350900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350902', '1,350000,350900,', '350900', '蕉城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350921', '1,350000,350900,', '350900', '霞浦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350922', '1,350000,350900,', '350900', '古田县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350923', '1,350000,350900,', '350900', '屏南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350924', '1,350000,350900,', '350900', '寿宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350925', '1,350000,350900,', '350900', '周宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350926', '1,350000,350900,', '350900', '柘荣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350981', '1,350000,350900,', '350900', '福安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('350982', '1,350000,350900,', '350900', '福鼎市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360000', '1,', '1', '江西省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360100', '1,360000,', '360000', '南昌市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360101', '1,360000,360100,', '360100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360102', '1,360000,360100,', '360100', '东湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360103', '1,360000,360100,', '360100', '西湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360104', '1,360000,360100,', '360100', '青云谱区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360105', '1,360000,360100,', '360100', '湾里区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360111', '1,360000,360100,', '360100', '青山湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360121', '1,360000,360100,', '360100', '南昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360122', '1,360000,360100,', '360100', '新建县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360123', '1,360000,360100,', '360100', '安义县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360124', '1,360000,360100,', '360100', '进贤县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360200', '1,360000,', '360000', '景德镇市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360201', '1,360000,360200,', '360200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360202', '1,360000,360200,', '360200', '昌江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360203', '1,360000,360200,', '360200', '珠山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360222', '1,360000,360200,', '360200', '浮梁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360281', '1,360000,360200,', '360200', '乐平市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360300', '1,360000,', '360000', '萍乡市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360301', '1,360000,360300,', '360300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360302', '1,360000,360300,', '360300', '安源区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360313', '1,360000,360300,', '360300', '湘东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:15', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360321', '1,360000,360300,', '360300', '莲花县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360322', '1,360000,360300,', '360300', '上栗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360323', '1,360000,360300,', '360300', '芦溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360400', '1,360000,', '360000', '九江市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360401', '1,360000,360400,', '360400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360402', '1,360000,360400,', '360400', '庐山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360403', '1,360000,360400,', '360400', '浔阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360421', '1,360000,360400,', '360400', '九江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360423', '1,360000,360400,', '360400', '武宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360424', '1,360000,360400,', '360400', '修水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360425', '1,360000,360400,', '360400', '永修县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360426', '1,360000,360400,', '360400', '德安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360427', '1,360000,360400,', '360400', '星子县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360428', '1,360000,360400,', '360400', '都昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360429', '1,360000,360400,', '360400', '湖口县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360430', '1,360000,360400,', '360400', '彭泽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360481', '1,360000,360400,', '360400', '瑞昌市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360500', '1,360000,', '360000', '新余市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360501', '1,360000,360500,', '360500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360502', '1,360000,360500,', '360500', '渝水区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360521', '1,360000,360500,', '360500', '分宜县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360600', '1,360000,', '360000', '鹰潭市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360601', '1,360000,360600,', '360600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360602', '1,360000,360600,', '360600', '月湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360622', '1,360000,360600,', '360600', '余江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360681', '1,360000,360600,', '360600', '贵溪市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360700', '1,360000,', '360000', '赣州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360701', '1,360000,360700,', '360700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360702', '1,360000,360700,', '360700', '章贡区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360721', '1,360000,360700,', '360700', '赣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360722', '1,360000,360700,', '360700', '信丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360723', '1,360000,360700,', '360700', '大余县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360724', '1,360000,360700,', '360700', '上犹县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360725', '1,360000,360700,', '360700', '崇义县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360726', '1,360000,360700,', '360700', '安远县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360727', '1,360000,360700,', '360700', '龙南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:16', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360728', '1,360000,360700,', '360700', '定南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360729', '1,360000,360700,', '360700', '全南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360730', '1,360000,360700,', '360700', '宁都县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360731', '1,360000,360700,', '360700', '于都县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360732', '1,360000,360700,', '360700', '兴国县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360733', '1,360000,360700,', '360700', '会昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360734', '1,360000,360700,', '360700', '寻乌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360735', '1,360000,360700,', '360700', '石城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360781', '1,360000,360700,', '360700', '瑞金市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360782', '1,360000,360700,', '360700', '南康市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360800', '1,360000,', '360000', '吉安市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360801', '1,360000,360800,', '360800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360802', '1,360000,360800,', '360800', '吉州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360803', '1,360000,360800,', '360800', '青原区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360821', '1,360000,360800,', '360800', '吉安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360822', '1,360000,360800,', '360800', '吉水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360823', '1,360000,360800,', '360800', '峡江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360824', '1,360000,360800,', '360800', '新干县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360825', '1,360000,360800,', '360800', '永丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360826', '1,360000,360800,', '360800', '泰和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360827', '1,360000,360800,', '360800', '遂川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360828', '1,360000,360800,', '360800', '万安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360829', '1,360000,360800,', '360800', '安福县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360830', '1,360000,360800,', '360800', '永新县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360881', '1,360000,360800,', '360800', '井冈山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360900', '1,360000,', '360000', '宜春市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360901', '1,360000,360900,', '360900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360902', '1,360000,360900,', '360900', '袁州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360921', '1,360000,360900,', '360900', '奉新县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360922', '1,360000,360900,', '360900', '万载县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360923', '1,360000,360900,', '360900', '上高县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360924', '1,360000,360900,', '360900', '宜丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360925', '1,360000,360900,', '360900', '靖安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360926', '1,360000,360900,', '360900', '铜鼓县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360981', '1,360000,360900,', '360900', '丰城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360982', '1,360000,360900,', '360900', '樟树市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('360983', '1,360000,360900,', '360900', '高安市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361000', '1,360000,', '360000', '抚州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361001', '1,360000,361000,', '361000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361002', '1,360000,361000,', '361000', '临川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:17', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361021', '1,360000,361000,', '361000', '南城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361022', '1,360000,361000,', '361000', '黎川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361023', '1,360000,361000,', '361000', '南丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361024', '1,360000,361000,', '361000', '崇仁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361025', '1,360000,361000,', '361000', '乐安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361026', '1,360000,361000,', '361000', '宜黄县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361027', '1,360000,361000,', '361000', '金溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361028', '1,360000,361000,', '361000', '资溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361029', '1,360000,361000,', '361000', '东乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361030', '1,360000,361000,', '361000', '广昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361100', '1,360000,', '360000', '上饶市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361101', '1,360000,361100,', '361100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361102', '1,360000,361100,', '361100', '信州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361121', '1,360000,361100,', '361100', '上饶县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361122', '1,360000,361100,', '361100', '广丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361123', '1,360000,361100,', '361100', '玉山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361124', '1,360000,361100,', '361100', '铅山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361125', '1,360000,361100,', '361100', '横峰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361126', '1,360000,361100,', '361100', '弋阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361127', '1,360000,361100,', '361100', '余干县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361128', '1,360000,361100,', '361100', '鄱阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361129', '1,360000,361100,', '361100', '万年县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361130', '1,360000,361100,', '361100', '婺源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('361181', '1,360000,361100,', '361100', '德兴市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370000', '1,', '1', '山东省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370100', '1,370000,', '370000', '济南市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370101', '1,370000,370100,', '370100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370102', '1,370000,370100,', '370100', '历下区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370103', '1,370000,370100,', '370100', '市中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370104', '1,370000,370100,', '370100', '槐荫区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370105', '1,370000,370100,', '370100', '天桥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370112', '1,370000,370100,', '370100', '历城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370113', '1,370000,370100,', '370100', '长清区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370124', '1,370000,370100,', '370100', '平阴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370125', '1,370000,370100,', '370100', '济阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370126', '1,370000,370100,', '370100', '商河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370181', '1,370000,370100,', '370100', '章丘市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370200', '1,370000,', '370000', '青岛市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370201', '1,370000,370200,', '370200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370202', '1,370000,370200,', '370200', '市南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:18', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370203', '1,370000,370200,', '370200', '市北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370205', '1,370000,370200,', '370200', '四方区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370211', '1,370000,370200,', '370200', '黄岛区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370212', '1,370000,370200,', '370200', '崂山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370213', '1,370000,370200,', '370200', '李沧区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370214', '1,370000,370200,', '370200', '城阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370281', '1,370000,370200,', '370200', '胶州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370282', '1,370000,370200,', '370200', '即墨市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370283', '1,370000,370200,', '370200', '平度市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370284', '1,370000,370200,', '370200', '胶南市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370285', '1,370000,370200,', '370200', '莱西市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370300', '1,370000,', '370000', '淄博市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370301', '1,370000,370300,', '370300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370302', '1,370000,370300,', '370300', '淄川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370303', '1,370000,370300,', '370300', '张店区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370304', '1,370000,370300,', '370300', '博山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370305', '1,370000,370300,', '370300', '临淄区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370306', '1,370000,370300,', '370300', '周村区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370321', '1,370000,370300,', '370300', '桓台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370322', '1,370000,370300,', '370300', '高青县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370323', '1,370000,370300,', '370300', '沂源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370400', '1,370000,', '370000', '枣庄市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370401', '1,370000,370400,', '370400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370402', '1,370000,370400,', '370400', '市中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370403', '1,370000,370400,', '370400', '薛城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370404', '1,370000,370400,', '370400', '峄城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370405', '1,370000,370400,', '370400', '台儿庄区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370406', '1,370000,370400,', '370400', '山亭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370481', '1,370000,370400,', '370400', '滕州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370500', '1,370000,', '370000', '东营市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:19', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370501', '1,370000,370500,', '370500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370502', '1,370000,370500,', '370500', '东营区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370503', '1,370000,370500,', '370500', '河口区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370521', '1,370000,370500,', '370500', '垦利县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370522', '1,370000,370500,', '370500', '利津县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370523', '1,370000,370500,', '370500', '广饶县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370600', '1,370000,', '370000', '烟台市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370601', '1,370000,370600,', '370600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370602', '1,370000,370600,', '370600', '芝罘区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370611', '1,370000,370600,', '370600', '福山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370612', '1,370000,370600,', '370600', '牟平区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370613', '1,370000,370600,', '370600', '莱山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370634', '1,370000,370600,', '370600', '长岛县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370681', '1,370000,370600,', '370600', '龙口市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370682', '1,370000,370600,', '370600', '莱阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370683', '1,370000,370600,', '370600', '莱州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370684', '1,370000,370600,', '370600', '蓬莱市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370685', '1,370000,370600,', '370600', '招远市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370686', '1,370000,370600,', '370600', '栖霞市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370687', '1,370000,370600,', '370600', '海阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370700', '1,370000,', '370000', '潍坊市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370701', '1,370000,370700,', '370700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370702', '1,370000,370700,', '370700', '潍城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370703', '1,370000,370700,', '370700', '寒亭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370704', '1,370000,370700,', '370700', '坊子区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370705', '1,370000,370700,', '370700', '奎文区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370724', '1,370000,370700,', '370700', '临朐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370725', '1,370000,370700,', '370700', '昌乐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370781', '1,370000,370700,', '370700', '青州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370782', '1,370000,370700,', '370700', '诸城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370783', '1,370000,370700,', '370700', '寿光市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370784', '1,370000,370700,', '370700', '安丘市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370785', '1,370000,370700,', '370700', '高密市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370786', '1,370000,370700,', '370700', '昌邑市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370800', '1,370000,', '370000', '济宁市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370801', '1,370000,370800,', '370800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370802', '1,370000,370800,', '370800', '市中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370811', '1,370000,370800,', '370800', '任城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370826', '1,370000,370800,', '370800', '微山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370827', '1,370000,370800,', '370800', '鱼台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:20', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370828', '1,370000,370800,', '370800', '金乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370829', '1,370000,370800,', '370800', '嘉祥县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370830', '1,370000,370800,', '370800', '汶上县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370831', '1,370000,370800,', '370800', '泗水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370832', '1,370000,370800,', '370800', '梁山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370881', '1,370000,370800,', '370800', '曲阜市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370882', '1,370000,370800,', '370800', '兖州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370883', '1,370000,370800,', '370800', '邹城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370900', '1,370000,', '370000', '泰安市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370901', '1,370000,370900,', '370900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370902', '1,370000,370900,', '370900', '泰山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370903', '1,370000,370900,', '370900', '岱岳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370921', '1,370000,370900,', '370900', '宁阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370923', '1,370000,370900,', '370900', '东平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370982', '1,370000,370900,', '370900', '新泰市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('370983', '1,370000,370900,', '370900', '肥城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371000', '1,370000,', '370000', '威海市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371001', '1,370000,371000,', '371000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371002', '1,370000,371000,', '371000', '环翠区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371081', '1,370000,371000,', '371000', '文登市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371082', '1,370000,371000,', '371000', '荣成市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371083', '1,370000,371000,', '371000', '乳山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371100', '1,370000,', '370000', '日照市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371101', '1,370000,371100,', '371100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371102', '1,370000,371100,', '371100', '东港区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371103', '1,370000,371100,', '371100', '岚山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371121', '1,370000,371100,', '371100', '五莲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371122', '1,370000,371100,', '371100', '莒县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371200', '1,370000,', '370000', '莱芜市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371201', '1,370000,371200,', '371200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371202', '1,370000,371200,', '371200', '莱城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371203', '1,370000,371200,', '371200', '钢城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371300', '1,370000,', '370000', '临沂市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371301', '1,370000,371300,', '371300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371302', '1,370000,371300,', '371300', '兰山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371311', '1,370000,371300,', '371300', '罗庄区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371312', '1,370000,371300,', '371300', '河东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371321', '1,370000,371300,', '371300', '沂南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371322', '1,370000,371300,', '371300', '郯城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371323', '1,370000,371300,', '371300', '沂水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371324', '1,370000,371300,', '371300', '苍山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371325', '1,370000,371300,', '371300', '费县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:21', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371326', '1,370000,371300,', '371300', '平邑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371327', '1,370000,371300,', '371300', '莒南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371328', '1,370000,371300,', '371300', '蒙阴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371329', '1,370000,371300,', '371300', '临沭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371400', '1,370000,', '370000', '德州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371401', '1,370000,371400,', '371400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371402', '1,370000,371400,', '371400', '德城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371421', '1,370000,371400,', '371400', '陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371422', '1,370000,371400,', '371400', '宁津县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371423', '1,370000,371400,', '371400', '庆云县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371424', '1,370000,371400,', '371400', '临邑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371425', '1,370000,371400,', '371400', '齐河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371426', '1,370000,371400,', '371400', '平原县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371427', '1,370000,371400,', '371400', '夏津县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371428', '1,370000,371400,', '371400', '武城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371481', '1,370000,371400,', '371400', '乐陵市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371482', '1,370000,371400,', '371400', '禹城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371500', '1,370000,', '370000', '聊城市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371501', '1,370000,371500,', '371500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371502', '1,370000,371500,', '371500', '东昌府区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371521', '1,370000,371500,', '371500', '阳谷县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371522', '1,370000,371500,', '371500', '莘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371523', '1,370000,371500,', '371500', '茌平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371524', '1,370000,371500,', '371500', '东阿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371525', '1,370000,371500,', '371500', '冠县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371526', '1,370000,371500,', '371500', '高唐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371581', '1,370000,371500,', '371500', '临清市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371600', '1,370000,', '370000', '滨州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371601', '1,370000,371600,', '371600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371602', '1,370000,371600,', '371600', '滨城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371621', '1,370000,371600,', '371600', '惠民县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371622', '1,370000,371600,', '371600', '阳信县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371623', '1,370000,371600,', '371600', '无棣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371624', '1,370000,371600,', '371600', '沾化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371625', '1,370000,371600,', '371600', '博兴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371626', '1,370000,371600,', '371600', '邹平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371700', '1,370000,', '370000', '菏泽市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:22', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371701', '1,370000,371700,', '371700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371702', '1,370000,371700,', '371700', '牡丹区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371721', '1,370000,371700,', '371700', '曹县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371722', '1,370000,371700,', '371700', '单县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371723', '1,370000,371700,', '371700', '成武县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371724', '1,370000,371700,', '371700', '巨野县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371725', '1,370000,371700,', '371700', '郓城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371726', '1,370000,371700,', '371700', '鄄城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371727', '1,370000,371700,', '371700', '定陶县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('371728', '1,370000,371700,', '371700', '东明县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410000', '1,', '1', '河南省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410100', '1,410000,', '410000', '郑州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410101', '1,410000,410100,', '410100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410102', '1,410000,410100,', '410100', '中原区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410103', '1,410000,410100,', '410100', '二七区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410104', '1,410000,410100,', '410100', '管城回族区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410105', '1,410000,410100,', '410100', '金水区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410106', '1,410000,410100,', '410100', '上街区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410108', '1,410000,410100,', '410100', '惠济区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410122', '1,410000,410100,', '410100', '中牟县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410181', '1,410000,410100,', '410100', '巩义市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410182', '1,410000,410100,', '410100', '荥阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410183', '1,410000,410100,', '410100', '新密市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410184', '1,410000,410100,', '410100', '新郑市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410185', '1,410000,410100,', '410100', '登封市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410200', '1,410000,', '410000', '开封市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410201', '1,410000,410200,', '410200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410202', '1,410000,410200,', '410200', '龙亭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410203', '1,410000,410200,', '410200', '顺河回族区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410204', '1,410000,410200,', '410200', '鼓楼区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410205', '1,410000,410200,', '410200', '禹王台区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410211', '1,410000,410200,', '410200', '金明区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410221', '1,410000,410200,', '410200', '杞县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410222', '1,410000,410200,', '410200', '通许县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410223', '1,410000,410200,', '410200', '尉氏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410224', '1,410000,410200,', '410200', '开封县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410225', '1,410000,410200,', '410200', '兰考县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410300', '1,410000,', '410000', '洛阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410301', '1,410000,410300,', '410300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:23', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410302', '1,410000,410300,', '410300', '老城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410303', '1,410000,410300,', '410300', '西工区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410304', '1,410000,410300,', '410300', '廛河回族区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410305', '1,410000,410300,', '410300', '涧西区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410306', '1,410000,410300,', '410300', '吉利区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410307', '1,410000,410300,', '410300', '洛龙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410322', '1,410000,410300,', '410300', '孟津县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410323', '1,410000,410300,', '410300', '新安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410324', '1,410000,410300,', '410300', '栾川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410325', '1,410000,410300,', '410300', '嵩县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410326', '1,410000,410300,', '410300', '汝阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410327', '1,410000,410300,', '410300', '宜阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410328', '1,410000,410300,', '410300', '洛宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410329', '1,410000,410300,', '410300', '伊川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410381', '1,410000,410300,', '410300', '偃师市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410400', '1,410000,', '410000', '平顶山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410401', '1,410000,410400,', '410400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410402', '1,410000,410400,', '410400', '新华区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410403', '1,410000,410400,', '410400', '卫东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410404', '1,410000,410400,', '410400', '石龙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410411', '1,410000,410400,', '410400', '湛河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410421', '1,410000,410400,', '410400', '宝丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410422', '1,410000,410400,', '410400', '叶县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410423', '1,410000,410400,', '410400', '鲁山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410425', '1,410000,410400,', '410400', '郏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410481', '1,410000,410400,', '410400', '舞钢市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410482', '1,410000,410400,', '410400', '汝州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410500', '1,410000,', '410000', '安阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410501', '1,410000,410500,', '410500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410502', '1,410000,410500,', '410500', '文峰区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410503', '1,410000,410500,', '410500', '北关区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410505', '1,410000,410500,', '410500', '殷都区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410506', '1,410000,410500,', '410500', '龙安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410522', '1,410000,410500,', '410500', '安阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410523', '1,410000,410500,', '410500', '汤阴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410526', '1,410000,410500,', '410500', '滑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:24', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410527', '1,410000,410500,', '410500', '内黄县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410581', '1,410000,410500,', '410500', '林州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410600', '1,410000,', '410000', '鹤壁市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410601', '1,410000,410600,', '410600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410602', '1,410000,410600,', '410600', '鹤山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410603', '1,410000,410600,', '410600', '山城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410611', '1,410000,410600,', '410600', '淇滨区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410621', '1,410000,410600,', '410600', '浚县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410622', '1,410000,410600,', '410600', '淇县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410700', '1,410000,', '410000', '新乡市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410701', '1,410000,410700,', '410700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410702', '1,410000,410700,', '410700', '红旗区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410703', '1,410000,410700,', '410700', '卫滨区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410704', '1,410000,410700,', '410700', '凤泉区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410711', '1,410000,410700,', '410700', '牧野区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410721', '1,410000,410700,', '410700', '新乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410724', '1,410000,410700,', '410700', '获嘉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410725', '1,410000,410700,', '410700', '原阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410726', '1,410000,410700,', '410700', '延津县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410727', '1,410000,410700,', '410700', '封丘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410728', '1,410000,410700,', '410700', '长垣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410781', '1,410000,410700,', '410700', '卫辉市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410782', '1,410000,410700,', '410700', '辉县市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410800', '1,410000,', '410000', '焦作市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410801', '1,410000,410800,', '410800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410802', '1,410000,410800,', '410800', '解放区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410803', '1,410000,410800,', '410800', '中站区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410804', '1,410000,410800,', '410800', '马村区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410811', '1,410000,410800,', '410800', '山阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410821', '1,410000,410800,', '410800', '修武县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410822', '1,410000,410800,', '410800', '博爱县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410823', '1,410000,410800,', '410800', '武陟县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:25', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410825', '1,410000,410800,', '410800', '温县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410881', '1,410000,410800,', '410800', '济源市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410882', '1,410000,410800,', '410800', '沁阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410883', '1,410000,410800,', '410800', '孟州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410900', '1,410000,', '410000', '濮阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410901', '1,410000,410900,', '410900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410902', '1,410000,410900,', '410900', '华龙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410922', '1,410000,410900,', '410900', '清丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410923', '1,410000,410900,', '410900', '南乐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410926', '1,410000,410900,', '410900', '范县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410927', '1,410000,410900,', '410900', '台前县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('410928', '1,410000,410900,', '410900', '濮阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411000', '1,410000,', '410000', '许昌市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411001', '1,410000,411000,', '411000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411002', '1,410000,411000,', '411000', '魏都区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411023', '1,410000,411000,', '411000', '许昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411024', '1,410000,411000,', '411000', '鄢陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411025', '1,410000,411000,', '411000', '襄城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411081', '1,410000,411000,', '411000', '禹州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411082', '1,410000,411000,', '411000', '长葛市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411100', '1,410000,', '410000', '漯河市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411101', '1,410000,411100,', '411100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411102', '1,410000,411100,', '411100', '源汇区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411103', '1,410000,411100,', '411100', '郾城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411104', '1,410000,411100,', '411100', '召陵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411121', '1,410000,411100,', '411100', '舞阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411122', '1,410000,411100,', '411100', '临颍县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411200', '1,410000,', '410000', '三门峡市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411201', '1,410000,411200,', '411200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411202', '1,410000,411200,', '411200', '湖滨区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411221', '1,410000,411200,', '411200', '渑池县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411222', '1,410000,411200,', '411200', '陕县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411224', '1,410000,411200,', '411200', '卢氏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411281', '1,410000,411200,', '411200', '义马市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411282', '1,410000,411200,', '411200', '灵宝市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411300', '1,410000,', '410000', '南阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411301', '1,410000,411300,', '411300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411302', '1,410000,411300,', '411300', '宛城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411303', '1,410000,411300,', '411300', '卧龙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411321', '1,410000,411300,', '411300', '南召县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:26', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411322', '1,410000,411300,', '411300', '方城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411323', '1,410000,411300,', '411300', '西峡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411324', '1,410000,411300,', '411300', '镇平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411325', '1,410000,411300,', '411300', '内乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411326', '1,410000,411300,', '411300', '淅川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411327', '1,410000,411300,', '411300', '社旗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411328', '1,410000,411300,', '411300', '唐河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411329', '1,410000,411300,', '411300', '新野县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411330', '1,410000,411300,', '411300', '桐柏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411381', '1,410000,411300,', '411300', '邓州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411400', '1,410000,', '410000', '商丘市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411401', '1,410000,411400,', '411400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411402', '1,410000,411400,', '411400', '梁园区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411403', '1,410000,411400,', '411400', '睢阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411421', '1,410000,411400,', '411400', '民权县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411422', '1,410000,411400,', '411400', '睢县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411423', '1,410000,411400,', '411400', '宁陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411424', '1,410000,411400,', '411400', '柘城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411425', '1,410000,411400,', '411400', '虞城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411426', '1,410000,411400,', '411400', '夏邑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411481', '1,410000,411400,', '411400', '永城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411500', '1,410000,', '410000', '信阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411501', '1,410000,411500,', '411500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411502', '1,410000,411500,', '411500', '浉河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411503', '1,410000,411500,', '411500', '平桥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411521', '1,410000,411500,', '411500', '罗山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411522', '1,410000,411500,', '411500', '光山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411523', '1,410000,411500,', '411500', '新县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411524', '1,410000,411500,', '411500', '商城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411525', '1,410000,411500,', '411500', '固始县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411526', '1,410000,411500,', '411500', '潢川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411527', '1,410000,411500,', '411500', '淮滨县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411528', '1,410000,411500,', '411500', '息县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411600', '1,410000,', '410000', '周口市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411601', '1,410000,411600,', '411600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411602', '1,410000,411600,', '411600', '川汇区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411621', '1,410000,411600,', '411600', '扶沟县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411622', '1,410000,411600,', '411600', '西华县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411623', '1,410000,411600,', '411600', '商水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411624', '1,410000,411600,', '411600', '沈丘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411625', '1,410000,411600,', '411600', '郸城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411626', '1,410000,411600,', '411600', '淮阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411627', '1,410000,411600,', '411600', '太康县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:27', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411628', '1,410000,411600,', '411600', '鹿邑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411681', '1,410000,411600,', '411600', '项城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411700', '1,410000,', '410000', '驻马店市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411701', '1,410000,411700,', '411700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411702', '1,410000,411700,', '411700', '驿城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411721', '1,410000,411700,', '411700', '西平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411722', '1,410000,411700,', '411700', '上蔡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411723', '1,410000,411700,', '411700', '平舆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411724', '1,410000,411700,', '411700', '正阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411725', '1,410000,411700,', '411700', '确山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411726', '1,410000,411700,', '411700', '泌阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411727', '1,410000,411700,', '411700', '汝南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411728', '1,410000,411700,', '411700', '遂平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('411729', '1,410000,411700,', '411700', '新蔡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420000', '1,', '1', '湖北省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420100', '1,420000,', '420000', '武汉市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420101', '1,420000,420100,', '420100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420102', '1,420000,420100,', '420100', '江岸区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420103', '1,420000,420100,', '420100', '江汉区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420104', '1,420000,420100,', '420100', '硚口区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420105', '1,420000,420100,', '420100', '汉阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420106', '1,420000,420100,', '420100', '武昌区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420107', '1,420000,420100,', '420100', '青山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420111', '1,420000,420100,', '420100', '洪山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420112', '1,420000,420100,', '420100', '东西湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420113', '1,420000,420100,', '420100', '汉南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420114', '1,420000,420100,', '420100', '蔡甸区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420115', '1,420000,420100,', '420100', '江夏区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420116', '1,420000,420100,', '420100', '黄陂区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420117', '1,420000,420100,', '420100', '新洲区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420200', '1,420000,', '420000', '黄石市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420201', '1,420000,420200,', '420200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420202', '1,420000,420200,', '420200', '黄石港区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420203', '1,420000,420200,', '420200', '西塞山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420204', '1,420000,420200,', '420200', '下陆区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:28', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420205', '1,420000,420200,', '420200', '铁山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420222', '1,420000,420200,', '420200', '阳新县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420281', '1,420000,420200,', '420200', '大冶市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420300', '1,420000,', '420000', '十堰市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420301', '1,420000,420300,', '420300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420302', '1,420000,420300,', '420300', '茅箭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420303', '1,420000,420300,', '420300', '张湾区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420321', '1,420000,420300,', '420300', '郧县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420322', '1,420000,420300,', '420300', '郧西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420323', '1,420000,420300,', '420300', '竹山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420324', '1,420000,420300,', '420300', '竹溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420325', '1,420000,420300,', '420300', '房县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420381', '1,420000,420300,', '420300', '丹江口市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420500', '1,420000,', '420000', '宜昌市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420501', '1,420000,420500,', '420500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420502', '1,420000,420500,', '420500', '西陵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420503', '1,420000,420500,', '420500', '伍家岗区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420504', '1,420000,420500,', '420500', '点军区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420505', '1,420000,420500,', '420500', '猇亭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420506', '1,420000,420500,', '420500', '夷陵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420525', '1,420000,420500,', '420500', '远安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420526', '1,420000,420500,', '420500', '兴山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420527', '1,420000,420500,', '420500', '秭归县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420528', '1,420000,420500,', '420500', '长阳土家族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420529', '1,420000,420500,', '420500', '五峰土家族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420581', '1,420000,420500,', '420500', '宜都市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420582', '1,420000,420500,', '420500', '当阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420583', '1,420000,420500,', '420500', '枝江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420600', '1,420000,', '420000', '襄樊市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420601', '1,420000,420600,', '420600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420602', '1,420000,420600,', '420600', '襄城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420606', '1,420000,420600,', '420600', '樊城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420607', '1,420000,420600,', '420600', '襄阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420624', '1,420000,420600,', '420600', '南漳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420625', '1,420000,420600,', '420600', '谷城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420626', '1,420000,420600,', '420600', '保康县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420682', '1,420000,420600,', '420600', '老河口市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420683', '1,420000,420600,', '420600', '枣阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420684', '1,420000,420600,', '420600', '宜城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420700', '1,420000,', '420000', '鄂州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:29', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420701', '1,420000,420700,', '420700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420702', '1,420000,420700,', '420700', '梁子湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420703', '1,420000,420700,', '420700', '华容区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420704', '1,420000,420700,', '420700', '鄂城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420800', '1,420000,', '420000', '荆门市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420801', '1,420000,420800,', '420800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420802', '1,420000,420800,', '420800', '东宝区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420804', '1,420000,420800,', '420800', '掇刀区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420821', '1,420000,420800,', '420800', '京山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420822', '1,420000,420800,', '420800', '沙洋县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420881', '1,420000,420800,', '420800', '钟祥市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420900', '1,420000,', '420000', '孝感市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420901', '1,420000,420900,', '420900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420902', '1,420000,420900,', '420900', '孝南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420921', '1,420000,420900,', '420900', '孝昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420922', '1,420000,420900,', '420900', '大悟县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420923', '1,420000,420900,', '420900', '云梦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420981', '1,420000,420900,', '420900', '应城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420982', '1,420000,420900,', '420900', '安陆市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('420984', '1,420000,420900,', '420900', '汉川市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421000', '1,420000,', '420000', '荆州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421001', '1,420000,421000,', '421000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421002', '1,420000,421000,', '421000', '沙市区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421003', '1,420000,421000,', '421000', '荆州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421022', '1,420000,421000,', '421000', '公安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421023', '1,420000,421000,', '421000', '监利县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421024', '1,420000,421000,', '421000', '江陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421081', '1,420000,421000,', '421000', '石首市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421083', '1,420000,421000,', '421000', '洪湖市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421087', '1,420000,421000,', '421000', '松滋市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421100', '1,420000,', '420000', '黄冈市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421101', '1,420000,421100,', '421100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421102', '1,420000,421100,', '421100', '黄州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421121', '1,420000,421100,', '421100', '团风县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421122', '1,420000,421100,', '421100', '红安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421123', '1,420000,421100,', '421100', '罗田县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421124', '1,420000,421100,', '421100', '英山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421125', '1,420000,421100,', '421100', '浠水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:30', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421126', '1,420000,421100,', '421100', '蕲春县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421127', '1,420000,421100,', '421100', '黄梅县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421181', '1,420000,421100,', '421100', '麻城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421182', '1,420000,421100,', '421100', '武穴市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421200', '1,420000,', '420000', '咸宁市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421201', '1,420000,421200,', '421200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421202', '1,420000,421200,', '421200', '咸安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421221', '1,420000,421200,', '421200', '嘉鱼县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421222', '1,420000,421200,', '421200', '通城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421223', '1,420000,421200,', '421200', '崇阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421224', '1,420000,421200,', '421200', '通山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421281', '1,420000,421200,', '421200', '赤壁市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421300', '1,420000,', '420000', '随州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421301', '1,420000,421300,', '421300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421302', '1,420000,421300,', '421300', '曾都区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('421381', '1,420000,421300,', '421300', '广水市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('422800', '1,420000,', '420000', '恩施土家族苗族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('422801', '1,420000,422800,', '422800', '恩施市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('422802', '1,420000,422800,', '422800', '利川市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('422822', '1,420000,422800,', '422800', '建始县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('422823', '1,420000,422800,', '422800', '巴东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('422825', '1,420000,422800,', '422800', '宣恩县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('422826', '1,420000,422800,', '422800', '咸丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('422827', '1,420000,422800,', '422800', '来凤县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('422828', '1,420000,422800,', '422800', '鹤峰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('429000', '1,420000,', '420000', '省直辖行政单位', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('429004', '1,420000,429000,', '429000', '仙桃市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('429005', '1,420000,429000,', '429000', '潜江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('429006', '1,420000,429000,', '429000', '天门市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('429021', '1,420000,429000,', '429000', '神农架林区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430000', '1,', '1', '湖南省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430100', '1,430000,', '430000', '长沙市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430101', '1,430000,430100,', '430100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430102', '1,430000,430100,', '430100', '芙蓉区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430103', '1,430000,430100,', '430100', '天心区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430104', '1,430000,430100,', '430100', '岳麓区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430105', '1,430000,430100,', '430100', '开福区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430111', '1,430000,430100,', '430100', '雨花区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430121', '1,430000,430100,', '430100', '长沙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430122', '1,430000,430100,', '430100', '望城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430124', '1,430000,430100,', '430100', '宁乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430181', '1,430000,430100,', '430100', '浏阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:31', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430200', '1,430000,', '430000', '株洲市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430201', '1,430000,430200,', '430200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430202', '1,430000,430200,', '430200', '荷塘区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430203', '1,430000,430200,', '430200', '芦淞区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430204', '1,430000,430200,', '430200', '石峰区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430211', '1,430000,430200,', '430200', '天元区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430221', '1,430000,430200,', '430200', '株洲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430223', '1,430000,430200,', '430200', '攸县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430224', '1,430000,430200,', '430200', '茶陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430225', '1,430000,430200,', '430200', '炎陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430281', '1,430000,430200,', '430200', '醴陵市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430300', '1,430000,', '430000', '湘潭市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430301', '1,430000,430300,', '430300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430302', '1,430000,430300,', '430300', '雨湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430304', '1,430000,430300,', '430300', '岳塘区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430321', '1,430000,430300,', '430300', '湘潭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430381', '1,430000,430300,', '430300', '湘乡市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430382', '1,430000,430300,', '430300', '韶山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430400', '1,430000,', '430000', '衡阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430401', '1,430000,430400,', '430400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430405', '1,430000,430400,', '430400', '珠晖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430406', '1,430000,430400,', '430400', '雁峰区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430407', '1,430000,430400,', '430400', '石鼓区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430408', '1,430000,430400,', '430400', '蒸湘区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430412', '1,430000,430400,', '430400', '南岳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430421', '1,430000,430400,', '430400', '衡阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430422', '1,430000,430400,', '430400', '衡南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430423', '1,430000,430400,', '430400', '衡山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430424', '1,430000,430400,', '430400', '衡东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430426', '1,430000,430400,', '430400', '祁东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430481', '1,430000,430400,', '430400', '耒阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430482', '1,430000,430400,', '430400', '常宁市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430500', '1,430000,', '430000', '邵阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430501', '1,430000,430500,', '430500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430502', '1,430000,430500,', '430500', '双清区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430503', '1,430000,430500,', '430500', '大祥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430511', '1,430000,430500,', '430500', '北塔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430521', '1,430000,430500,', '430500', '邵东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430522', '1,430000,430500,', '430500', '新邵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430523', '1,430000,430500,', '430500', '邵阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:32', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430524', '1,430000,430500,', '430500', '隆回县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430525', '1,430000,430500,', '430500', '洞口县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430527', '1,430000,430500,', '430500', '绥宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430528', '1,430000,430500,', '430500', '新宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430529', '1,430000,430500,', '430500', '城步苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430581', '1,430000,430500,', '430500', '武冈市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430600', '1,430000,', '430000', '岳阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430601', '1,430000,430600,', '430600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430602', '1,430000,430600,', '430600', '岳阳楼区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430603', '1,430000,430600,', '430600', '云溪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430611', '1,430000,430600,', '430600', '君山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430621', '1,430000,430600,', '430600', '岳阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430623', '1,430000,430600,', '430600', '华容县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430624', '1,430000,430600,', '430600', '湘阴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430626', '1,430000,430600,', '430600', '平江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430681', '1,430000,430600,', '430600', '汨罗市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430682', '1,430000,430600,', '430600', '临湘市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430700', '1,430000,', '430000', '常德市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430701', '1,430000,430700,', '430700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430702', '1,430000,430700,', '430700', '武陵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430703', '1,430000,430700,', '430700', '鼎城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430721', '1,430000,430700,', '430700', '安乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430722', '1,430000,430700,', '430700', '汉寿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430723', '1,430000,430700,', '430700', '澧县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430724', '1,430000,430700,', '430700', '临澧县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430725', '1,430000,430700,', '430700', '桃源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430726', '1,430000,430700,', '430700', '石门县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430781', '1,430000,430700,', '430700', '津市市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430800', '1,430000,', '430000', '张家界市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430801', '1,430000,430800,', '430800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430802', '1,430000,430800,', '430800', '永定区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430811', '1,430000,430800,', '430800', '武陵源区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430821', '1,430000,430800,', '430800', '慈利县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430822', '1,430000,430800,', '430800', '桑植县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430900', '1,430000,', '430000', '益阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430901', '1,430000,430900,', '430900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430902', '1,430000,430900,', '430900', '资阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430903', '1,430000,430900,', '430900', '赫山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430921', '1,430000,430900,', '430900', '南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430922', '1,430000,430900,', '430900', '桃江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430923', '1,430000,430900,', '430900', '安化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:33', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('430981', '1,430000,430900,', '430900', '沅江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431000', '1,430000,', '430000', '郴州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431001', '1,430000,431000,', '431000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431002', '1,430000,431000,', '431000', '北湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431003', '1,430000,431000,', '431000', '苏仙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431021', '1,430000,431000,', '431000', '桂阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431022', '1,430000,431000,', '431000', '宜章县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431023', '1,430000,431000,', '431000', '永兴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431024', '1,430000,431000,', '431000', '嘉禾县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431025', '1,430000,431000,', '431000', '临武县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431026', '1,430000,431000,', '431000', '汝城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431027', '1,430000,431000,', '431000', '桂东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431028', '1,430000,431000,', '431000', '安仁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431081', '1,430000,431000,', '431000', '资兴市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431100', '1,430000,', '430000', '永州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431101', '1,430000,431100,', '431100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431102', '1,430000,431100,', '431100', '零陵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431103', '1,430000,431100,', '431100', '冷水滩区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431121', '1,430000,431100,', '431100', '祁阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431122', '1,430000,431100,', '431100', '东安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431123', '1,430000,431100,', '431100', '双牌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431124', '1,430000,431100,', '431100', '道县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431125', '1,430000,431100,', '431100', '江永县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431126', '1,430000,431100,', '431100', '宁远县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431127', '1,430000,431100,', '431100', '蓝山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431128', '1,430000,431100,', '431100', '新田县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431129', '1,430000,431100,', '431100', '江华瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431200', '1,430000,', '430000', '怀化市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431201', '1,430000,431200,', '431200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431202', '1,430000,431200,', '431200', '鹤城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431221', '1,430000,431200,', '431200', '中方县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431222', '1,430000,431200,', '431200', '沅陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431223', '1,430000,431200,', '431200', '辰溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431224', '1,430000,431200,', '431200', '溆浦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:34', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431225', '1,430000,431200,', '431200', '会同县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431226', '1,430000,431200,', '431200', '麻阳苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431227', '1,430000,431200,', '431200', '新晃侗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431228', '1,430000,431200,', '431200', '芷江侗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431229', '1,430000,431200,', '431200', '靖州苗族侗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431230', '1,430000,431200,', '431200', '通道侗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431281', '1,430000,431200,', '431200', '洪江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431300', '1,430000,', '430000', '娄底市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431301', '1,430000,431300,', '431300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431302', '1,430000,431300,', '431300', '娄星区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431321', '1,430000,431300,', '431300', '双峰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431322', '1,430000,431300,', '431300', '新化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431381', '1,430000,431300,', '431300', '冷水江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('431382', '1,430000,431300,', '431300', '涟源市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('433100', '1,430000,', '430000', '湘西土家族苗族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('433101', '1,430000,433100,', '433100', '吉首市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('433122', '1,430000,433100,', '433100', '泸溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('433123', '1,430000,433100,', '433100', '凤凰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('433124', '1,430000,433100,', '433100', '花垣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('433125', '1,430000,433100,', '433100', '保靖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('433126', '1,430000,433100,', '433100', '古丈县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('433127', '1,430000,433100,', '433100', '永顺县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('433130', '1,430000,433100,', '433100', '龙山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440000', '1,', '1', '广东省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440100', '1,440000,', '440000', '广州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440101', '1,440000,440100,', '440100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440103', '1,440000,440100,', '440100', '荔湾区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440104', '1,440000,440100,', '440100', '越秀区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440105', '1,440000,440100,', '440100', '海珠区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440106', '1,440000,440100,', '440100', '天河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440111', '1,440000,440100,', '440100', '白云区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440112', '1,440000,440100,', '440100', '黄埔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440113', '1,440000,440100,', '440100', '番禺区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440114', '1,440000,440100,', '440100', '花都区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440115', '1,440000,440100,', '440100', '南沙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440116', '1,440000,440100,', '440100', '萝岗区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440183', '1,440000,440100,', '440100', '增城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440184', '1,440000,440100,', '440100', '从化市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:35', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440200', '1,440000,', '440000', '韶关市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440201', '1,440000,440200,', '440200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440203', '1,440000,440200,', '440200', '武江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440204', '1,440000,440200,', '440200', '浈江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440205', '1,440000,440200,', '440200', '曲江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440222', '1,440000,440200,', '440200', '始兴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440224', '1,440000,440200,', '440200', '仁化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440229', '1,440000,440200,', '440200', '翁源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440232', '1,440000,440200,', '440200', '乳源瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440233', '1,440000,440200,', '440200', '新丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440281', '1,440000,440200,', '440200', '乐昌市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440282', '1,440000,440200,', '440200', '南雄市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440300', '1,440000,', '440000', '深圳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440301', '1,440000,440300,', '440300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440303', '1,440000,440300,', '440300', '罗湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440304', '1,440000,440300,', '440300', '福田区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440305', '1,440000,440300,', '440300', '南山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440306', '1,440000,440300,', '440300', '宝安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440307', '1,440000,440300,', '440300', '龙岗区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440308', '1,440000,440300,', '440300', '盐田区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440400', '1,440000,', '440000', '珠海市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440401', '1,440000,440400,', '440400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440402', '1,440000,440400,', '440400', '香洲区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440403', '1,440000,440400,', '440400', '斗门区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440404', '1,440000,440400,', '440400', '金湾区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440500', '1,440000,', '440000', '汕头市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440501', '1,440000,440500,', '440500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440507', '1,440000,440500,', '440500', '龙湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440511', '1,440000,440500,', '440500', '金平区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440512', '1,440000,440500,', '440500', '濠江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440513', '1,440000,440500,', '440500', '潮阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440514', '1,440000,440500,', '440500', '潮南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440515', '1,440000,440500,', '440500', '澄海区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440523', '1,440000,440500,', '440500', '南澳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440600', '1,440000,', '440000', '佛山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440601', '1,440000,440600,', '440600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440604', '1,440000,440600,', '440600', '禅城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:36', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440605', '1,440000,440600,', '440600', '南海区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440606', '1,440000,440600,', '440600', '顺德区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440607', '1,440000,440600,', '440600', '三水区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440608', '1,440000,440600,', '440600', '高明区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440700', '1,440000,', '440000', '江门市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440701', '1,440000,440700,', '440700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440703', '1,440000,440700,', '440700', '蓬江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440704', '1,440000,440700,', '440700', '江海区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440705', '1,440000,440700,', '440700', '新会区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440781', '1,440000,440700,', '440700', '台山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440783', '1,440000,440700,', '440700', '开平市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440784', '1,440000,440700,', '440700', '鹤山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440785', '1,440000,440700,', '440700', '恩平市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440800', '1,440000,', '440000', '湛江市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440801', '1,440000,440800,', '440800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440802', '1,440000,440800,', '440800', '赤坎区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440803', '1,440000,440800,', '440800', '霞山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440804', '1,440000,440800,', '440800', '坡头区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440811', '1,440000,440800,', '440800', '麻章区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440823', '1,440000,440800,', '440800', '遂溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440825', '1,440000,440800,', '440800', '徐闻县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440881', '1,440000,440800,', '440800', '廉江市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440882', '1,440000,440800,', '440800', '雷州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440883', '1,440000,440800,', '440800', '吴川市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440900', '1,440000,', '440000', '茂名市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440901', '1,440000,440900,', '440900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440902', '1,440000,440900,', '440900', '茂南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440903', '1,440000,440900,', '440900', '茂港区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440923', '1,440000,440900,', '440900', '电白县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440981', '1,440000,440900,', '440900', '高州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440982', '1,440000,440900,', '440900', '化州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('440983', '1,440000,440900,', '440900', '信宜市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441200', '1,440000,', '440000', '肇庆市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441201', '1,440000,441200,', '441200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441202', '1,440000,441200,', '441200', '端州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441203', '1,440000,441200,', '441200', '鼎湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:37', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441223', '1,440000,441200,', '441200', '广宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441224', '1,440000,441200,', '441200', '怀集县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441225', '1,440000,441200,', '441200', '封开县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441226', '1,440000,441200,', '441200', '德庆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441283', '1,440000,441200,', '441200', '高要市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441284', '1,440000,441200,', '441200', '四会市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441300', '1,440000,', '440000', '惠州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441301', '1,440000,441300,', '441300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441302', '1,440000,441300,', '441300', '惠城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441303', '1,440000,441300,', '441300', '惠阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441322', '1,440000,441300,', '441300', '博罗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441323', '1,440000,441300,', '441300', '惠东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441324', '1,440000,441300,', '441300', '龙门县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441400', '1,440000,', '440000', '梅州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441401', '1,440000,441400,', '441400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441402', '1,440000,441400,', '441400', '梅江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441421', '1,440000,441400,', '441400', '梅县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441422', '1,440000,441400,', '441400', '大埔县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441423', '1,440000,441400,', '441400', '丰顺县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441424', '1,440000,441400,', '441400', '五华县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441426', '1,440000,441400,', '441400', '平远县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441427', '1,440000,441400,', '441400', '蕉岭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441481', '1,440000,441400,', '441400', '兴宁市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441500', '1,440000,', '440000', '汕尾市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441501', '1,440000,441500,', '441500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441502', '1,440000,441500,', '441500', '城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441521', '1,440000,441500,', '441500', '海丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441523', '1,440000,441500,', '441500', '陆河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441581', '1,440000,441500,', '441500', '陆丰市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441600', '1,440000,', '440000', '河源市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441601', '1,440000,441600,', '441600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441602', '1,440000,441600,', '441600', '源城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441621', '1,440000,441600,', '441600', '紫金县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441622', '1,440000,441600,', '441600', '龙川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441623', '1,440000,441600,', '441600', '连平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:38', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441624', '1,440000,441600,', '441600', '和平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441625', '1,440000,441600,', '441600', '东源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441700', '1,440000,', '440000', '阳江市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441701', '1,440000,441700,', '441700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441702', '1,440000,441700,', '441700', '江城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441721', '1,440000,441700,', '441700', '阳西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441723', '1,440000,441700,', '441700', '阳东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441781', '1,440000,441700,', '441700', '阳春市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441800', '1,440000,', '440000', '清远市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441801', '1,440000,441800,', '441800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441802', '1,440000,441800,', '441800', '清城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441821', '1,440000,441800,', '441800', '佛冈县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441823', '1,440000,441800,', '441800', '阳山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441825', '1,440000,441800,', '441800', '连山壮族瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441826', '1,440000,441800,', '441800', '连南瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441827', '1,440000,441800,', '441800', '清新县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441881', '1,440000,441800,', '441800', '英德市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441882', '1,440000,441800,', '441800', '连州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441900', '1,440000,', '440000', '东莞市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('441901', '1,440000,441900,', '441900', '东莞市市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('442000', '1,440000,', '440000', '中山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('442001', '1,440000,442000,', '442000', '中山市市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445100', '1,440000,', '440000', '潮州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445101', '1,440000,445100,', '445100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445102', '1,440000,445100,', '445100', '湘桥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445121', '1,440000,445100,', '445100', '潮安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445122', '1,440000,445100,', '445100', '饶平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445200', '1,440000,', '440000', '揭阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445201', '1,440000,445200,', '445200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445202', '1,440000,445200,', '445200', '榕城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445221', '1,440000,445200,', '445200', '揭东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445222', '1,440000,445200,', '445200', '揭西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445224', '1,440000,445200,', '445200', '惠来县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445281', '1,440000,445200,', '445200', '普宁市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445300', '1,440000,', '440000', '云浮市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:39', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445301', '1,440000,445300,', '445300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445302', '1,440000,445300,', '445300', '云城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445321', '1,440000,445300,', '445300', '新兴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445322', '1,440000,445300,', '445300', '郁南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445323', '1,440000,445300,', '445300', '云安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('445381', '1,440000,445300,', '445300', '罗定市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450000', '1,', '1', '广西壮族自治区', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450100', '1,450000,', '450000', '南宁市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450101', '1,450000,450100,', '450100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450102', '1,450000,450100,', '450100', '兴宁区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450103', '1,450000,450100,', '450100', '青秀区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450105', '1,450000,450100,', '450100', '江南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450107', '1,450000,450100,', '450100', '西乡塘区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450108', '1,450000,450100,', '450100', '良庆区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450109', '1,450000,450100,', '450100', '邕宁区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450122', '1,450000,450100,', '450100', '武鸣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450123', '1,450000,450100,', '450100', '隆安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450124', '1,450000,450100,', '450100', '马山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450125', '1,450000,450100,', '450100', '上林县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450126', '1,450000,450100,', '450100', '宾阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450127', '1,450000,450100,', '450100', '横县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450200', '1,450000,', '450000', '柳州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450201', '1,450000,450200,', '450200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450202', '1,450000,450200,', '450200', '城中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450203', '1,450000,450200,', '450200', '鱼峰区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450204', '1,450000,450200,', '450200', '柳南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450205', '1,450000,450200,', '450200', '柳北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450221', '1,450000,450200,', '450200', '柳江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450222', '1,450000,450200,', '450200', '柳城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450223', '1,450000,450200,', '450200', '鹿寨县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450224', '1,450000,450200,', '450200', '融安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450225', '1,450000,450200,', '450200', '融水苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450226', '1,450000,450200,', '450200', '三江侗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450300', '1,450000,', '450000', '桂林市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450301', '1,450000,450300,', '450300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450302', '1,450000,450300,', '450300', '秀峰区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450303', '1,450000,450300,', '450300', '叠彩区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450304', '1,450000,450300,', '450300', '象山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:40', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450305', '1,450000,450300,', '450300', '七星区', '', '0', '3', '', '', null, null, '1', '2016-12-28 16:37:58', '', '0', '1');
INSERT INTO `sys_area_t` VALUES ('450311', '1,450000,450300,', '450300', '雁山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450321', '1,450000,450300,', '450300', '阳朔县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450322', '1,450000,450300,', '450300', '临桂县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450323', '1,450000,450300,', '450300', '灵川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450324', '1,450000,450300,', '450300', '全州县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450325', '1,450000,450300,', '450300', '兴安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450326', '1,450000,450300,', '450300', '永福县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450327', '1,450000,450300,', '450300', '灌阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450328', '1,450000,450300,', '450300', '龙胜各族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450329', '1,450000,450300,', '450300', '资源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450330', '1,450000,450300,', '450300', '平乐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450331', '1,450000,450300,', '450300', '荔蒲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450332', '1,450000,450300,', '450300', '恭城瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450400', '1,450000,', '450000', '梧州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450401', '1,450000,450400,', '450400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450403', '1,450000,450400,', '450400', '万秀区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450404', '1,450000,450400,', '450400', '蝶山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450405', '1,450000,450400,', '450400', '长洲区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450421', '1,450000,450400,', '450400', '苍梧县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450422', '1,450000,450400,', '450400', '藤县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450423', '1,450000,450400,', '450400', '蒙山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450481', '1,450000,450400,', '450400', '岑溪市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450500', '1,450000,', '450000', '北海市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450501', '1,450000,450500,', '450500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450502', '1,450000,450500,', '450500', '海城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450503', '1,450000,450500,', '450500', '银海区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450512', '1,450000,450500,', '450500', '铁山港区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450521', '1,450000,450500,', '450500', '合浦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450600', '1,450000,', '450000', '防城港市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450601', '1,450000,450600,', '450600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450602', '1,450000,450600,', '450600', '港口区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450603', '1,450000,450600,', '450600', '防城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450621', '1,450000,450600,', '450600', '上思县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450681', '1,450000,450600,', '450600', '东兴市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450700', '1,450000,', '450000', '钦州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450701', '1,450000,450700,', '450700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:41', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450702', '1,450000,450700,', '450700', '钦南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450703', '1,450000,450700,', '450700', '钦北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450721', '1,450000,450700,', '450700', '灵山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450722', '1,450000,450700,', '450700', '浦北县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450800', '1,450000,', '450000', '贵港市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450801', '1,450000,450800,', '450800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450802', '1,450000,450800,', '450800', '港北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450803', '1,450000,450800,', '450800', '港南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450804', '1,450000,450800,', '450800', '覃塘区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450821', '1,450000,450800,', '450800', '平南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450881', '1,450000,450800,', '450800', '桂平市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450900', '1,450000,', '450000', '玉林市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450901', '1,450000,450900,', '450900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450902', '1,450000,450900,', '450900', '玉州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450921', '1,450000,450900,', '450900', '容县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450922', '1,450000,450900,', '450900', '陆川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450923', '1,450000,450900,', '450900', '博白县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450924', '1,450000,450900,', '450900', '兴业县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('450981', '1,450000,450900,', '450900', '北流市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451000', '1,450000,', '450000', '百色市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451001', '1,450000,451000,', '451000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451002', '1,450000,451000,', '451000', '右江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451021', '1,450000,451000,', '451000', '田阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451022', '1,450000,451000,', '451000', '田东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451023', '1,450000,451000,', '451000', '平果县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451024', '1,450000,451000,', '451000', '德保县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451025', '1,450000,451000,', '451000', '靖西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451026', '1,450000,451000,', '451000', '那坡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451027', '1,450000,451000,', '451000', '凌云县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451028', '1,450000,451000,', '451000', '乐业县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451029', '1,450000,451000,', '451000', '田林县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451030', '1,450000,451000,', '451000', '西林县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451031', '1,450000,451000,', '451000', '隆林各族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451100', '1,450000,', '450000', '贺州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451101', '1,450000,451100,', '451100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451102', '1,450000,451100,', '451100', '八步区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:42', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451121', '1,450000,451100,', '451100', '昭平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451122', '1,450000,451100,', '451100', '钟山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451123', '1,450000,451100,', '451100', '富川瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451200', '1,450000,', '450000', '河池市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451201', '1,450000,451200,', '451200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451202', '1,450000,451200,', '451200', '金城江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451221', '1,450000,451200,', '451200', '南丹县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451222', '1,450000,451200,', '451200', '天峨县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451223', '1,450000,451200,', '451200', '凤山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451224', '1,450000,451200,', '451200', '东兰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451225', '1,450000,451200,', '451200', '罗城仫佬族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451226', '1,450000,451200,', '451200', '环江毛南族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451227', '1,450000,451200,', '451200', '巴马瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451228', '1,450000,451200,', '451200', '都安瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451229', '1,450000,451200,', '451200', '大化瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451281', '1,450000,451200,', '451200', '宜州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451300', '1,450000,', '450000', '来宾市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451301', '1,450000,451300,', '451300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451302', '1,450000,451300,', '451300', '兴宾区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451321', '1,450000,451300,', '451300', '忻城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451322', '1,450000,451300,', '451300', '象州县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451323', '1,450000,451300,', '451300', '武宣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451324', '1,450000,451300,', '451300', '金秀瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451381', '1,450000,451300,', '451300', '合山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451400', '1,450000,', '450000', '崇左市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451401', '1,450000,451400,', '451400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451402', '1,450000,451400,', '451400', '江洲区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451421', '1,450000,451400,', '451400', '扶绥县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451422', '1,450000,451400,', '451400', '宁明县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451423', '1,450000,451400,', '451400', '龙州县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451424', '1,450000,451400,', '451400', '大新县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451425', '1,450000,451400,', '451400', '天等县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('451481', '1,450000,451400,', '451400', '凭祥市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('460000', '1,', '1', '海南省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('460100', '1,460000,', '460000', '海口市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('460101', '1,460000,460100,', '460100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('460105', '1,460000,460100,', '460100', '秀英区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('460106', '1,460000,460100,', '460100', '龙华区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:43', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('460107', '1,460000,460100,', '460100', '琼山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('460108', '1,460000,460100,', '460100', '美兰区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('460200', '1,460000,', '460000', '三亚市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('460201', '1,460000,460200,', '460200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469000', '1,460000,', '460000', '省直辖县级行政单位', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469001', '1,460000,469000,', '469000', '五指山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469002', '1,460000,469000,', '469000', '琼海市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469003', '1,460000,469000,', '469000', '儋州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469005', '1,460000,469000,', '469000', '文昌市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469006', '1,460000,469000,', '469000', '万宁市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469007', '1,460000,469000,', '469000', '东方市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469025', '1,460000,469000,', '469000', '定安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469026', '1,460000,469000,', '469000', '屯昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469027', '1,460000,469000,', '469000', '澄迈县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469028', '1,460000,469000,', '469000', '临高县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469030', '1,460000,469000,', '469000', '白沙黎族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469031', '1,460000,469000,', '469000', '昌江黎族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469033', '1,460000,469000,', '469000', '乐东黎族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469034', '1,460000,469000,', '469000', '陵水黎族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469035', '1,460000,469000,', '469000', '保亭黎族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469036', '1,460000,469000,', '469000', '琼中黎族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469037', '1,460000,469000,', '469000', '西沙群岛', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469038', '1,460000,469000,', '469000', '南沙群岛', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('469039', '1,460000,469000,', '469000', '中沙群岛的岛礁及其海域', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500000', '1,', '1', '重庆市', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500100', '1,500000,', '500000', '市辖区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500101', '1,500000,500100,', '500100', '万州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500102', '1,500000,500100,', '500100', '涪陵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500103', '1,500000,500100,', '500100', '渝中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500104', '1,500000,500100,', '500100', '大渡口区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500105', '1,500000,500100,', '500100', '江北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500106', '1,500000,500100,', '500100', '沙坪坝区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500107', '1,500000,500100,', '500100', '九龙坡区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500108', '1,500000,500100,', '500100', '南岸区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500109', '1,500000,500100,', '500100', '北碚区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500110', '1,500000,500100,', '500100', '万盛区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500111', '1,500000,500100,', '500100', '双桥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500112', '1,500000,500100,', '500100', '渝北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500113', '1,500000,500100,', '500100', '巴南区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500114', '1,500000,500100,', '500100', '黔江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:44', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500115', '1,500000,500100,', '500100', '长寿区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500116', '1,500000,500100,', '500100', '江津区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500117', '1,500000,500100,', '500100', '合川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500118', '1,500000,500100,', '500100', '永川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500119', '1,500000,500100,', '500100', '南川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500200', '1,500000,', '500000', '县', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500222', '1,500000,500200,', '500200', '綦江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500223', '1,500000,500200,', '500200', '潼南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500224', '1,500000,500200,', '500200', '铜梁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500225', '1,500000,500200,', '500200', '大足县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500226', '1,500000,500200,', '500200', '荣昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500227', '1,500000,500200,', '500200', '璧山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500228', '1,500000,500200,', '500200', '梁平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500229', '1,500000,500200,', '500200', '城口县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500230', '1,500000,500200,', '500200', '丰都县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500231', '1,500000,500200,', '500200', '垫江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500232', '1,500000,500200,', '500200', '武隆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500233', '1,500000,500200,', '500200', '忠县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500234', '1,500000,500200,', '500200', '开县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500235', '1,500000,500200,', '500200', '云阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500236', '1,500000,500200,', '500200', '奉节县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500237', '1,500000,500200,', '500200', '巫山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500238', '1,500000,500200,', '500200', '巫溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500240', '1,500000,500200,', '500200', '石柱土家族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500241', '1,500000,500200,', '500200', '秀山土家族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500242', '1,500000,500200,', '500200', '酉阳土家族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('500243', '1,500000,500200,', '500200', '彭水苗族土家族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510000', '1,', '1', '四川省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510100', '1,510000,', '510000', '成都市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:45', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510101', '1,510000,510100,', '510100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510104', '1,510000,510100,', '510100', '锦江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510105', '1,510000,510100,', '510100', '青羊区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510106', '1,510000,510100,', '510100', '金牛区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510107', '1,510000,510100,', '510100', '武侯区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510108', '1,510000,510100,', '510100', '成华区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510112', '1,510000,510100,', '510100', '龙泉驿区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510113', '1,510000,510100,', '510100', '青白江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510114', '1,510000,510100,', '510100', '新都区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510115', '1,510000,510100,', '510100', '温江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510121', '1,510000,510100,', '510100', '金堂县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510122', '1,510000,510100,', '510100', '双流县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510124', '1,510000,510100,', '510100', '郫县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510129', '1,510000,510100,', '510100', '大邑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510131', '1,510000,510100,', '510100', '蒲江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510132', '1,510000,510100,', '510100', '新津县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510181', '1,510000,510100,', '510100', '都江堰市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510182', '1,510000,510100,', '510100', '彭州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510183', '1,510000,510100,', '510100', '邛崃市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510184', '1,510000,510100,', '510100', '崇州市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510300', '1,510000,', '510000', '自贡市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510301', '1,510000,510300,', '510300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510302', '1,510000,510300,', '510300', '自流井区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510303', '1,510000,510300,', '510300', '贡井区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510304', '1,510000,510300,', '510300', '大安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510311', '1,510000,510300,', '510300', '沿滩区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510321', '1,510000,510300,', '510300', '荣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510322', '1,510000,510300,', '510300', '富顺县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510400', '1,510000,', '510000', '攀枝花市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510401', '1,510000,510400,', '510400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510402', '1,510000,510400,', '510400', '东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510403', '1,510000,510400,', '510400', '西区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510411', '1,510000,510400,', '510400', '仁和区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510421', '1,510000,510400,', '510400', '米易县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510422', '1,510000,510400,', '510400', '盐边县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510500', '1,510000,', '510000', '泸州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510501', '1,510000,510500,', '510500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510502', '1,510000,510500,', '510500', '江阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510503', '1,510000,510500,', '510500', '纳溪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510504', '1,510000,510500,', '510500', '龙马潭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:46', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510521', '1,510000,510500,', '510500', '泸县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510522', '1,510000,510500,', '510500', '合江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510524', '1,510000,510500,', '510500', '叙永县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510525', '1,510000,510500,', '510500', '古蔺县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510600', '1,510000,', '510000', '德阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510601', '1,510000,510600,', '510600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510603', '1,510000,510600,', '510600', '旌阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510623', '1,510000,510600,', '510600', '中江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510626', '1,510000,510600,', '510600', '罗江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510681', '1,510000,510600,', '510600', '广汉市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510682', '1,510000,510600,', '510600', '什邡市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510683', '1,510000,510600,', '510600', '绵竹市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510700', '1,510000,', '510000', '绵阳市', '', '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '2');
INSERT INTO `sys_area_t` VALUES ('510701', '1,510000,510700,', '510700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510703', '1,510000,510700,', '510700', '涪城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510704', '1,510000,510700,', '510700', '游仙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510722', '1,510000,510700,', '510700', '三台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510723', '1,510000,510700,', '510700', '盐亭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510724', '1,510000,510700,', '510700', '安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510725', '1,510000,510700,', '510700', '梓潼县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510726', '1,510000,510700,', '510700', '北川羌族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510727', '1,510000,510700,', '510700', '平武县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510781', '1,510000,510700,', '510700', '江油市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510800', '1,510000,', '510000', '广元市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510801', '1,510000,510800,', '510800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510802', '1,510000,510800,', '510800', '市中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510811', '1,510000,510800,', '510800', '元坝区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510812', '1,510000,510800,', '510800', '朝天区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510821', '1,510000,510800,', '510800', '旺苍县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510822', '1,510000,510800,', '510800', '青川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510823', '1,510000,510800,', '510800', '剑阁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510824', '1,510000,510800,', '510800', '苍溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510900', '1,510000,', '510000', '遂宁市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510901', '1,510000,510900,', '510900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510903', '1,510000,510900,', '510900', '船山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510904', '1,510000,510900,', '510900', '安居区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:47', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510921', '1,510000,510900,', '510900', '蓬溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510922', '1,510000,510900,', '510900', '射洪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('510923', '1,510000,510900,', '510900', '大英县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511000', '1,510000,', '510000', '内江市', '', '0', '2', '', '\0', null, null, '1', '2017-03-02 23:21:42', '', '0', '1');
INSERT INTO `sys_area_t` VALUES ('511001', '1,510000,511000,', '511000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511002', '1,510000,511000,', '511000', '市中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511011', '1,510000,511000,', '511000', '东兴区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511024', '1,510000,511000,', '511000', '威远县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511025', '1,510000,511000,', '511000', '资中县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511028', '1,510000,511000,', '511000', '隆昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511100', '1,510000,', '510000', '乐山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511101', '1,510000,511100,', '511100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511102', '1,510000,511100,', '511100', '市中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511111', '1,510000,511100,', '511100', '沙湾区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511112', '1,510000,511100,', '511100', '五通桥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511113', '1,510000,511100,', '511100', '金口河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511123', '1,510000,511100,', '511100', '犍为县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511124', '1,510000,511100,', '511100', '井研县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511126', '1,510000,511100,', '511100', '夹江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511129', '1,510000,511100,', '511100', '沐川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511132', '1,510000,511100,', '511100', '峨边彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511133', '1,510000,511100,', '511100', '马边彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511181', '1,510000,511100,', '511100', '峨眉山市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511300', '1,510000,', '510000', '南充市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511301', '1,510000,511300,', '511300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511302', '1,510000,511300,', '511300', '顺庆区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511303', '1,510000,511300,', '511300', '高坪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511304', '1,510000,511300,', '511300', '嘉陵区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511321', '1,510000,511300,', '511300', '南部县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511322', '1,510000,511300,', '511300', '营山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511323', '1,510000,511300,', '511300', '蓬安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511324', '1,510000,511300,', '511300', '仪陇县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511325', '1,510000,511300,', '511300', '西充县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511381', '1,510000,511300,', '511300', '阆中市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511400', '1,510000,', '510000', '眉山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511401', '1,510000,511400,', '511400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511402', '1,510000,511400,', '511400', '东坡区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511421', '1,510000,511400,', '511400', '仁寿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511422', '1,510000,511400,', '511400', '彭山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511423', '1,510000,511400,', '511400', '洪雅县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511424', '1,510000,511400,', '511400', '丹棱县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511425', '1,510000,511400,', '511400', '青神县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:48', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511500', '1,510000,', '510000', '宜宾市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511501', '1,510000,511500,', '511500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511502', '1,510000,511500,', '511500', '翠屏区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511521', '1,510000,511500,', '511500', '宜宾县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511522', '1,510000,511500,', '511500', '南溪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511523', '1,510000,511500,', '511500', '江安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511524', '1,510000,511500,', '511500', '长宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511525', '1,510000,511500,', '511500', '高县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511526', '1,510000,511500,', '511500', '珙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511527', '1,510000,511500,', '511500', '筠连县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511528', '1,510000,511500,', '511500', '兴文县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511529', '1,510000,511500,', '511500', '屏山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511600', '1,510000,', '510000', '广安市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511601', '1,510000,511600,', '511600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511602', '1,510000,511600,', '511600', '广安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511621', '1,510000,511600,', '511600', '岳池县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511622', '1,510000,511600,', '511600', '武胜县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511623', '1,510000,511600,', '511600', '邻水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511681', '1,510000,511600,', '511600', '华蓥市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511700', '1,510000,', '510000', '达州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511701', '1,510000,511700,', '511700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511702', '1,510000,511700,', '511700', '通川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511721', '1,510000,511700,', '511700', '达县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511722', '1,510000,511700,', '511700', '宣汉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511723', '1,510000,511700,', '511700', '开江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511724', '1,510000,511700,', '511700', '大竹县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511725', '1,510000,511700,', '511700', '渠县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511781', '1,510000,511700,', '511700', '万源市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511800', '1,510000,', '510000', '雅安市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511801', '1,510000,511800,', '511800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511802', '1,510000,511800,', '511800', '雨城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511821', '1,510000,511800,', '511800', '名山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511822', '1,510000,511800,', '511800', '荥经县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511823', '1,510000,511800,', '511800', '汉源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511824', '1,510000,511800,', '511800', '石棉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511825', '1,510000,511800,', '511800', '天全县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511826', '1,510000,511800,', '511800', '芦山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511827', '1,510000,511800,', '511800', '宝兴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511900', '1,510000,', '510000', '巴中市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:49', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511901', '1,510000,511900,', '511900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511902', '1,510000,511900,', '511900', '巴州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511921', '1,510000,511900,', '511900', '通江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511922', '1,510000,511900,', '511900', '南江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('511923', '1,510000,511900,', '511900', '平昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('512000', '1,510000,', '510000', '资阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('512001', '1,510000,512000,', '512000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('512002', '1,510000,512000,', '512000', '雁江区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('512021', '1,510000,512000,', '512000', '安岳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('512022', '1,510000,512000,', '512000', '乐至县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('512081', '1,510000,512000,', '512000', '简阳市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513200', '1,510000,', '510000', '阿坝藏族羌族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513221', '1,510000,513200,', '513200', '汶川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513222', '1,510000,513200,', '513200', '理县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513223', '1,510000,513200,', '513200', '茂县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513224', '1,510000,513200,', '513200', '松潘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513225', '1,510000,513200,', '513200', '九寨沟县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513226', '1,510000,513200,', '513200', '金川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513227', '1,510000,513200,', '513200', '小金县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513228', '1,510000,513200,', '513200', '黑水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513229', '1,510000,513200,', '513200', '马尔康县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513230', '1,510000,513200,', '513200', '壤塘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513231', '1,510000,513200,', '513200', '阿坝县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513232', '1,510000,513200,', '513200', '若尔盖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513233', '1,510000,513200,', '513200', '红原县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513300', '1,510000,', '510000', '甘孜藏族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513321', '1,510000,513300,', '513300', '康定县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513322', '1,510000,513300,', '513300', '泸定县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513323', '1,510000,513300,', '513300', '丹巴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513324', '1,510000,513300,', '513300', '九龙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513325', '1,510000,513300,', '513300', '雅江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513326', '1,510000,513300,', '513300', '道孚县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513327', '1,510000,513300,', '513300', '炉霍县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513328', '1,510000,513300,', '513300', '甘孜县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513329', '1,510000,513300,', '513300', '新龙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513330', '1,510000,513300,', '513300', '德格县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513331', '1,510000,513300,', '513300', '白玉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513332', '1,510000,513300,', '513300', '石渠县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513333', '1,510000,513300,', '513300', '色达县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513334', '1,510000,513300,', '513300', '理塘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513335', '1,510000,513300,', '513300', '巴塘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:50', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513336', '1,510000,513300,', '513300', '乡城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513337', '1,510000,513300,', '513300', '稻城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513338', '1,510000,513300,', '513300', '得荣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513400', '1,510000,', '510000', '凉山彝族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513401', '1,510000,513400,', '513400', '西昌市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513422', '1,510000,513400,', '513400', '木里藏族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513423', '1,510000,513400,', '513400', '盐源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513424', '1,510000,513400,', '513400', '德昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513425', '1,510000,513400,', '513400', '会理县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513426', '1,510000,513400,', '513400', '会东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513427', '1,510000,513400,', '513400', '宁南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513428', '1,510000,513400,', '513400', '普格县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513429', '1,510000,513400,', '513400', '布拖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513430', '1,510000,513400,', '513400', '金阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513431', '1,510000,513400,', '513400', '昭觉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513432', '1,510000,513400,', '513400', '喜德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513433', '1,510000,513400,', '513400', '冕宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513434', '1,510000,513400,', '513400', '越西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513435', '1,510000,513400,', '513400', '甘洛县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513436', '1,510000,513400,', '513400', '美姑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('513437', '1,510000,513400,', '513400', '雷波县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520000', '1,', '1', '贵州省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520100', '1,520000,', '520000', '贵阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520101', '1,520000,520100,', '520100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520102', '1,520000,520100,', '520100', '南明区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520103', '1,520000,520100,', '520100', '云岩区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520111', '1,520000,520100,', '520100', '花溪区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520112', '1,520000,520100,', '520100', '乌当区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520113', '1,520000,520100,', '520100', '白云区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520114', '1,520000,520100,', '520100', '小河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520121', '1,520000,520100,', '520100', '开阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520122', '1,520000,520100,', '520100', '息烽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520123', '1,520000,520100,', '520100', '修文县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520181', '1,520000,520100,', '520100', '清镇市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520200', '1,520000,', '520000', '六盘水市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520201', '1,520000,520200,', '520200', '钟山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520203', '1,520000,520200,', '520200', '六枝特区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520221', '1,520000,520200,', '520200', '水城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520222', '1,520000,520200,', '520200', '盘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520300', '1,520000,', '520000', '遵义市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:51', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520301', '1,520000,520300,', '520300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520302', '1,520000,520300,', '520300', '红花岗区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520303', '1,520000,520300,', '520300', '汇川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520321', '1,520000,520300,', '520300', '遵义县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520322', '1,520000,520300,', '520300', '桐梓县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520323', '1,520000,520300,', '520300', '绥阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520324', '1,520000,520300,', '520300', '正安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520325', '1,520000,520300,', '520300', '道真仡佬族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520326', '1,520000,520300,', '520300', '务川仡佬族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520327', '1,520000,520300,', '520300', '凤冈县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520328', '1,520000,520300,', '520300', '湄潭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520329', '1,520000,520300,', '520300', '余庆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520330', '1,520000,520300,', '520300', '习水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520381', '1,520000,520300,', '520300', '赤水市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520382', '1,520000,520300,', '520300', '仁怀市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520400', '1,520000,', '520000', '安顺市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520401', '1,520000,520400,', '520400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520402', '1,520000,520400,', '520400', '西秀区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520421', '1,520000,520400,', '520400', '平坝县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520422', '1,520000,520400,', '520400', '普定县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520423', '1,520000,520400,', '520400', '镇宁布依族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520424', '1,520000,520400,', '520400', '关岭布依族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('520425', '1,520000,520400,', '520400', '紫云苗族布依族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522200', '1,520000,', '520000', '铜仁地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522201', '1,520000,522200,', '522200', '铜仁市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522222', '1,520000,522200,', '522200', '江口县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522223', '1,520000,522200,', '522200', '玉屏侗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522224', '1,520000,522200,', '522200', '石阡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522225', '1,520000,522200,', '522200', '思南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522226', '1,520000,522200,', '522200', '印江土家族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522227', '1,520000,522200,', '522200', '德江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522228', '1,520000,522200,', '522200', '沿河土家族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522229', '1,520000,522200,', '522200', '松桃苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522230', '1,520000,522200,', '522200', '万山特区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522300', '1,520000,', '520000', '黔西南布依族苗族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522301', '1,520000,522300,', '522300', '兴义市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522322', '1,520000,522300,', '522300', '兴仁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522323', '1,520000,522300,', '522300', '普安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522324', '1,520000,522300,', '522300', '晴隆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522325', '1,520000,522300,', '522300', '贞丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:52', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522326', '1,520000,522300,', '522300', '望谟县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522327', '1,520000,522300,', '522300', '册亨县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522328', '1,520000,522300,', '522300', '安龙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522400', '1,520000,', '520000', '毕节地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522401', '1,520000,522400,', '522400', '毕节市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522422', '1,520000,522400,', '522400', '大方县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522423', '1,520000,522400,', '522400', '黔西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522424', '1,520000,522400,', '522400', '金沙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522425', '1,520000,522400,', '522400', '织金县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522426', '1,520000,522400,', '522400', '纳雍县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522427', '1,520000,522400,', '522400', '威宁彝族回族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522428', '1,520000,522400,', '522400', '赫章县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522600', '1,520000,', '520000', '黔东南苗族侗族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522601', '1,520000,522600,', '522600', '凯里市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522622', '1,520000,522600,', '522600', '黄平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522623', '1,520000,522600,', '522600', '施秉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522624', '1,520000,522600,', '522600', '三穗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522625', '1,520000,522600,', '522600', '镇远县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522626', '1,520000,522600,', '522600', '岑巩县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522627', '1,520000,522600,', '522600', '天柱县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522628', '1,520000,522600,', '522600', '锦屏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522629', '1,520000,522600,', '522600', '剑河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522630', '1,520000,522600,', '522600', '台江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522631', '1,520000,522600,', '522600', '黎平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522632', '1,520000,522600,', '522600', '榕江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522633', '1,520000,522600,', '522600', '从江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522634', '1,520000,522600,', '522600', '雷山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522635', '1,520000,522600,', '522600', '麻江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522636', '1,520000,522600,', '522600', '丹寨县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522700', '1,520000,', '520000', '黔南布依族苗族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522701', '1,520000,522700,', '522700', '都匀市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522702', '1,520000,522700,', '522700', '福泉市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522722', '1,520000,522700,', '522700', '荔波县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522723', '1,520000,522700,', '522700', '贵定县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522725', '1,520000,522700,', '522700', '瓮安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522726', '1,520000,522700,', '522700', '独山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522727', '1,520000,522700,', '522700', '平塘县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522728', '1,520000,522700,', '522700', '罗甸县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522729', '1,520000,522700,', '522700', '长顺县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522730', '1,520000,522700,', '522700', '龙里县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522731', '1,520000,522700,', '522700', '惠水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('522732', '1,520000,522700,', '522700', '三都水族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530000', '1,', '1', '云南省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:53', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530100', '1,530000,', '530000', '昆明市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530101', '1,530000,530100,', '530100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530102', '1,530000,530100,', '530100', '五华区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530103', '1,530000,530100,', '530100', '盘龙区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530111', '1,530000,530100,', '530100', '官渡区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530112', '1,530000,530100,', '530100', '西山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530113', '1,530000,530100,', '530100', '东川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530121', '1,530000,530100,', '530100', '呈贡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530122', '1,530000,530100,', '530100', '晋宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530124', '1,530000,530100,', '530100', '富民县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530125', '1,530000,530100,', '530100', '宜良县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530126', '1,530000,530100,', '530100', '石林彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530127', '1,530000,530100,', '530100', '嵩明县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530128', '1,530000,530100,', '530100', '禄劝彝族苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530129', '1,530000,530100,', '530100', '寻甸回族彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530181', '1,530000,530100,', '530100', '安宁市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530300', '1,530000,', '530000', '曲靖市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530301', '1,530000,530300,', '530300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530302', '1,530000,530300,', '530300', '麒麟区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530321', '1,530000,530300,', '530300', '马龙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530322', '1,530000,530300,', '530300', '陆良县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530323', '1,530000,530300,', '530300', '师宗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530324', '1,530000,530300,', '530300', '罗平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530325', '1,530000,530300,', '530300', '富源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530326', '1,530000,530300,', '530300', '会泽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530328', '1,530000,530300,', '530300', '沾益县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530381', '1,530000,530300,', '530300', '宣威市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530400', '1,530000,', '530000', '玉溪市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530401', '1,530000,530400,', '530400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530402', '1,530000,530400,', '530400', '红塔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530421', '1,530000,530400,', '530400', '江川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530422', '1,530000,530400,', '530400', '澄江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530423', '1,530000,530400,', '530400', '通海县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530424', '1,530000,530400,', '530400', '华宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530425', '1,530000,530400,', '530400', '易门县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530426', '1,530000,530400,', '530400', '峨山彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530427', '1,530000,530400,', '530400', '新平彝族傣族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530428', '1,530000,530400,', '530400', '元江哈尼族彝族傣族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530500', '1,530000,', '530000', '保山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530501', '1,530000,530500,', '530500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530502', '1,530000,530500,', '530500', '隆阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530521', '1,530000,530500,', '530500', '施甸县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:54', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530522', '1,530000,530500,', '530500', '腾冲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530523', '1,530000,530500,', '530500', '龙陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530524', '1,530000,530500,', '530500', '昌宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530600', '1,530000,', '530000', '昭通市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530601', '1,530000,530600,', '530600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530602', '1,530000,530600,', '530600', '昭阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530621', '1,530000,530600,', '530600', '鲁甸县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530622', '1,530000,530600,', '530600', '巧家县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530623', '1,530000,530600,', '530600', '盐津县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530624', '1,530000,530600,', '530600', '大关县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530625', '1,530000,530600,', '530600', '永善县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530626', '1,530000,530600,', '530600', '绥江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530627', '1,530000,530600,', '530600', '镇雄县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530628', '1,530000,530600,', '530600', '彝良县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530629', '1,530000,530600,', '530600', '威信县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530630', '1,530000,530600,', '530600', '水富县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530700', '1,530000,', '530000', '丽江市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530701', '1,530000,530700,', '530700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530702', '1,530000,530700,', '530700', '古城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530721', '1,530000,530700,', '530700', '玉龙纳西族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530722', '1,530000,530700,', '530700', '永胜县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530723', '1,530000,530700,', '530700', '华坪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530724', '1,530000,530700,', '530700', '宁蒗彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530800', '1,530000,', '530000', '思茅市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530801', '1,530000,530800,', '530800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530802', '1,530000,530800,', '530800', '翠云区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530821', '1,530000,530800,', '530800', '普洱哈尼族彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530822', '1,530000,530800,', '530800', '墨江哈尼族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530823', '1,530000,530800,', '530800', '景东彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530824', '1,530000,530800,', '530800', '景谷傣族彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530825', '1,530000,530800,', '530800', '镇沅彝族哈尼族拉祜族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530826', '1,530000,530800,', '530800', '江城哈尼族彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530827', '1,530000,530800,', '530800', '孟连傣族拉祜族佤族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530828', '1,530000,530800,', '530800', '澜沧拉祜族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530829', '1,530000,530800,', '530800', '西盟佤族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530900', '1,530000,', '530000', '临沧市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530901', '1,530000,530900,', '530900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530902', '1,530000,530900,', '530900', '临翔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530921', '1,530000,530900,', '530900', '凤庆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530922', '1,530000,530900,', '530900', '云县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:55', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530923', '1,530000,530900,', '530900', '永德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530924', '1,530000,530900,', '530900', '镇康县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530925', '1,530000,530900,', '530900', '双江拉祜族佤族布朗族傣族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530926', '1,530000,530900,', '530900', '耿马傣族佤族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('530927', '1,530000,530900,', '530900', '沧源佤族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532300', '1,530000,', '530000', '楚雄彝族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532301', '1,530000,532300,', '532300', '楚雄市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532322', '1,530000,532300,', '532300', '双柏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532323', '1,530000,532300,', '532300', '牟定县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532324', '1,530000,532300,', '532300', '南华县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532325', '1,530000,532300,', '532300', '姚安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532326', '1,530000,532300,', '532300', '大姚县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532327', '1,530000,532300,', '532300', '永仁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532328', '1,530000,532300,', '532300', '元谋县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532329', '1,530000,532300,', '532300', '武定县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532331', '1,530000,532300,', '532300', '禄丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532500', '1,530000,', '530000', '红河哈尼族彝族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532501', '1,530000,532500,', '532500', '个旧市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532502', '1,530000,532500,', '532500', '开远市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532522', '1,530000,532500,', '532500', '蒙自县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532523', '1,530000,532500,', '532500', '屏边苗族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532524', '1,530000,532500,', '532500', '建水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532525', '1,530000,532500,', '532500', '石屏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532526', '1,530000,532500,', '532500', '弥勒县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532527', '1,530000,532500,', '532500', '泸西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532528', '1,530000,532500,', '532500', '元阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532529', '1,530000,532500,', '532500', '红河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532530', '1,530000,532500,', '532500', '金平苗族瑶族傣族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532531', '1,530000,532500,', '532500', '绿春县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532532', '1,530000,532500,', '532500', '河口瑶族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532600', '1,530000,', '530000', '文山壮族苗族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532621', '1,530000,532600,', '532600', '文山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532622', '1,530000,532600,', '532600', '砚山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532623', '1,530000,532600,', '532600', '西畴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532624', '1,530000,532600,', '532600', '麻栗坡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532625', '1,530000,532600,', '532600', '马关县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532626', '1,530000,532600,', '532600', '丘北县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532627', '1,530000,532600,', '532600', '广南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532628', '1,530000,532600,', '532600', '富宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532800', '1,530000,', '530000', '西双版纳傣族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532801', '1,530000,532800,', '532800', '景洪市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532822', '1,530000,532800,', '532800', '勐海县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:56', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532823', '1,530000,532800,', '532800', '勐腊县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532900', '1,530000,', '530000', '大理白族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532901', '1,530000,532900,', '532900', '大理市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532922', '1,530000,532900,', '532900', '漾濞彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532923', '1,530000,532900,', '532900', '祥云县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532924', '1,530000,532900,', '532900', '宾川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532925', '1,530000,532900,', '532900', '弥渡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532926', '1,530000,532900,', '532900', '南涧彝族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532927', '1,530000,532900,', '532900', '巍山彝族回族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532928', '1,530000,532900,', '532900', '永平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532929', '1,530000,532900,', '532900', '云龙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532930', '1,530000,532900,', '532900', '洱源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532931', '1,530000,532900,', '532900', '剑川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('532932', '1,530000,532900,', '532900', '鹤庆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533100', '1,530000,', '530000', '德宏傣族景颇族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533102', '1,530000,533100,', '533100', '瑞丽市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533103', '1,530000,533100,', '533100', '潞西市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533122', '1,530000,533100,', '533100', '梁河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533123', '1,530000,533100,', '533100', '盈江县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533124', '1,530000,533100,', '533100', '陇川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533300', '1,530000,', '530000', '怒江傈僳族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533321', '1,530000,533300,', '533300', '泸水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533323', '1,530000,533300,', '533300', '福贡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533324', '1,530000,533300,', '533300', '贡山独龙族怒族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533325', '1,530000,533300,', '533300', '兰坪白族普米族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533400', '1,530000,', '530000', '迪庆藏族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533421', '1,530000,533400,', '533400', '香格里拉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533422', '1,530000,533400,', '533400', '德钦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('533423', '1,530000,533400,', '533400', '维西傈僳族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540000', '1,', '1', '西藏自治区', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540100', '1,540000,', '540000', '拉萨市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540101', '1,540000,540100,', '540100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540102', '1,540000,540100,', '540100', '城关区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540121', '1,540000,540100,', '540100', '林周县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540122', '1,540000,540100,', '540100', '当雄县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540123', '1,540000,540100,', '540100', '尼木县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540124', '1,540000,540100,', '540100', '曲水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540125', '1,540000,540100,', '540100', '堆龙德庆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540126', '1,540000,540100,', '540100', '达孜县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('540127', '1,540000,540100,', '540100', '墨竹工卡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542100', '1,540000,', '540000', '昌都地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542121', '1,540000,542100,', '542100', '昌都县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542122', '1,540000,542100,', '542100', '江达县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:57', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542123', '1,540000,542100,', '542100', '贡觉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542124', '1,540000,542100,', '542100', '类乌齐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542125', '1,540000,542100,', '542100', '丁青县', '', '0', '3', '', '', null, null, '1', '2016-12-29 13:33:18', '', '0', '1');
INSERT INTO `sys_area_t` VALUES ('542126', '1,540000,542100,', '542100', '察雅县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542127', '1,540000,542100,', '542100', '八宿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542128', '1,540000,542100,', '542100', '左贡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542129', '1,540000,542100,', '542100', '芒康县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542132', '1,540000,542100,', '542100', '洛隆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542133', '1,540000,542100,', '542100', '边坝县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542200', '1,540000,', '540000', '山南地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542221', '1,540000,542200,', '542200', '乃东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542222', '1,540000,542200,', '542200', '扎囊县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542223', '1,540000,542200,', '542200', '贡嘎县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542224', '1,540000,542200,', '542200', '桑日县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542225', '1,540000,542200,', '542200', '琼结县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542226', '1,540000,542200,', '542200', '曲松县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542227', '1,540000,542200,', '542200', '措美县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542228', '1,540000,542200,', '542200', '洛扎县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542229', '1,540000,542200,', '542200', '加查县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542231', '1,540000,542200,', '542200', '隆子县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542232', '1,540000,542200,', '542200', '错那县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542233', '1,540000,542200,', '542200', '浪卡子县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542300', '1,540000,', '540000', '日喀则地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542301', '1,540000,542300,', '542300', '日喀则市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542322', '1,540000,542300,', '542300', '南木林县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542323', '1,540000,542300,', '542300', '江孜县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542324', '1,540000,542300,', '542300', '定日县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542325', '1,540000,542300,', '542300', '萨迦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542326', '1,540000,542300,', '542300', '拉孜县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542327', '1,540000,542300,', '542300', '昂仁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542328', '1,540000,542300,', '542300', '谢通门县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542329', '1,540000,542300,', '542300', '白朗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542330', '1,540000,542300,', '542300', '仁布县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542331', '1,540000,542300,', '542300', '康马县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542332', '1,540000,542300,', '542300', '定结县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542333', '1,540000,542300,', '542300', '仲巴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542334', '1,540000,542300,', '542300', '亚东县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542335', '1,540000,542300,', '542300', '吉隆县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542336', '1,540000,542300,', '542300', '聂拉木县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542337', '1,540000,542300,', '542300', '萨嘎县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542338', '1,540000,542300,', '542300', '岗巴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542400', '1,540000,', '540000', '那曲地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542421', '1,540000,542400,', '542400', '那曲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:58', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542422', '1,540000,542400,', '542400', '嘉黎县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542423', '1,540000,542400,', '542400', '比如县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542424', '1,540000,542400,', '542400', '聂荣县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542425', '1,540000,542400,', '542400', '安多县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542426', '1,540000,542400,', '542400', '申扎县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542427', '1,540000,542400,', '542400', '索县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542428', '1,540000,542400,', '542400', '班戈县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542429', '1,540000,542400,', '542400', '巴青县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542430', '1,540000,542400,', '542400', '尼玛县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542500', '1,540000,', '540000', '阿里地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542521', '1,540000,542500,', '542500', '普兰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542522', '1,540000,542500,', '542500', '札达县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542523', '1,540000,542500,', '542500', '噶尔县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542524', '1,540000,542500,', '542500', '日土县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542525', '1,540000,542500,', '542500', '革吉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542526', '1,540000,542500,', '542500', '改则县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542527', '1,540000,542500,', '542500', '措勤县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542600', '1,540000,', '540000', '林芝地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542621', '1,540000,542600,', '542600', '林芝县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542622', '1,540000,542600,', '542600', '工布江达县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542623', '1,540000,542600,', '542600', '米林县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542624', '1,540000,542600,', '542600', '墨脱县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542625', '1,540000,542600,', '542600', '波密县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542626', '1,540000,542600,', '542600', '察隅县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('542627', '1,540000,542600,', '542600', '朗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610000', '1,', '1', '陕西省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610100', '1,610000,', '610000', '西安市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610101', '1,610000,610100,', '610100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610102', '1,610000,610100,', '610100', '新城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610103', '1,610000,610100,', '610100', '碑林区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610104', '1,610000,610100,', '610100', '莲湖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610111', '1,610000,610100,', '610100', '灞桥区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610112', '1,610000,610100,', '610100', '未央区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610113', '1,610000,610100,', '610100', '雁塔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610114', '1,610000,610100,', '610100', '阎良区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610115', '1,610000,610100,', '610100', '临潼区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610116', '1,610000,610100,', '610100', '长安区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610122', '1,610000,610100,', '610100', '蓝田县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 14:59:59', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610124', '1,610000,610100,', '610100', '周至县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610125', '1,610000,610100,', '610100', '户县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610126', '1,610000,610100,', '610100', '高陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610200', '1,610000,', '610000', '铜川市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610201', '1,610000,610200,', '610200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610202', '1,610000,610200,', '610200', '王益区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610203', '1,610000,610200,', '610200', '印台区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610204', '1,610000,610200,', '610200', '耀州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610222', '1,610000,610200,', '610200', '宜君县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610300', '1,610000,', '610000', '宝鸡市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610301', '1,610000,610300,', '610300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610302', '1,610000,610300,', '610300', '渭滨区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610303', '1,610000,610300,', '610300', '金台区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610304', '1,610000,610300,', '610300', '陈仓区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610322', '1,610000,610300,', '610300', '凤翔县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610323', '1,610000,610300,', '610300', '岐山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610324', '1,610000,610300,', '610300', '扶风县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610326', '1,610000,610300,', '610300', '眉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610327', '1,610000,610300,', '610300', '陇县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610328', '1,610000,610300,', '610300', '千阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610329', '1,610000,610300,', '610300', '麟游县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610330', '1,610000,610300,', '610300', '凤县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610331', '1,610000,610300,', '610300', '太白县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610400', '1,610000,', '610000', '咸阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610401', '1,610000,610400,', '610400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610402', '1,610000,610400,', '610400', '秦都区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610403', '1,610000,610400,', '610400', '杨凌区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610404', '1,610000,610400,', '610400', '渭城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610422', '1,610000,610400,', '610400', '三原县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610423', '1,610000,610400,', '610400', '泾阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610424', '1,610000,610400,', '610400', '乾县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610425', '1,610000,610400,', '610400', '礼泉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610426', '1,610000,610400,', '610400', '永寿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:00', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610427', '1,610000,610400,', '610400', '彬县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610428', '1,610000,610400,', '610400', '长武县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610429', '1,610000,610400,', '610400', '旬邑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610430', '1,610000,610400,', '610400', '淳化县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610431', '1,610000,610400,', '610400', '武功县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610481', '1,610000,610400,', '610400', '兴平市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610500', '1,610000,', '610000', '渭南市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610501', '1,610000,610500,', '610500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610502', '1,610000,610500,', '610500', '临渭区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610521', '1,610000,610500,', '610500', '华县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610522', '1,610000,610500,', '610500', '潼关县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610523', '1,610000,610500,', '610500', '大荔县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610524', '1,610000,610500,', '610500', '合阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610525', '1,610000,610500,', '610500', '澄城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610526', '1,610000,610500,', '610500', '蒲城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610527', '1,610000,610500,', '610500', '白水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610528', '1,610000,610500,', '610500', '富平县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610581', '1,610000,610500,', '610500', '韩城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610582', '1,610000,610500,', '610500', '华阴市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610600', '1,610000,', '610000', '延安市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610601', '1,610000,610600,', '610600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610602', '1,610000,610600,', '610600', '宝塔区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610621', '1,610000,610600,', '610600', '延长县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610622', '1,610000,610600,', '610600', '延川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610623', '1,610000,610600,', '610600', '子长县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610624', '1,610000,610600,', '610600', '安塞县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610625', '1,610000,610600,', '610600', '志丹县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610626', '1,610000,610600,', '610600', '吴起县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610627', '1,610000,610600,', '610600', '甘泉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610628', '1,610000,610600,', '610600', '富县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610629', '1,610000,610600,', '610600', '洛川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610630', '1,610000,610600,', '610600', '宜川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610631', '1,610000,610600,', '610600', '黄龙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610632', '1,610000,610600,', '610600', '黄陵县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610700', '1,610000,', '610000', '汉中市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610701', '1,610000,610700,', '610700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610702', '1,610000,610700,', '610700', '汉台区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610721', '1,610000,610700,', '610700', '南郑县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:01', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610722', '1,610000,610700,', '610700', '城固县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610723', '1,610000,610700,', '610700', '洋县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610724', '1,610000,610700,', '610700', '西乡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610725', '1,610000,610700,', '610700', '勉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610726', '1,610000,610700,', '610700', '宁强县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610727', '1,610000,610700,', '610700', '略阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610728', '1,610000,610700,', '610700', '镇巴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610729', '1,610000,610700,', '610700', '留坝县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610730', '1,610000,610700,', '610700', '佛坪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610800', '1,610000,', '610000', '榆林市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610801', '1,610000,610800,', '610800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610802', '1,610000,610800,', '610800', '榆阳区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610821', '1,610000,610800,', '610800', '神木县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610822', '1,610000,610800,', '610800', '府谷县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610823', '1,610000,610800,', '610800', '横山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610824', '1,610000,610800,', '610800', '靖边县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610825', '1,610000,610800,', '610800', '定边县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610826', '1,610000,610800,', '610800', '绥德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610827', '1,610000,610800,', '610800', '米脂县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610828', '1,610000,610800,', '610800', '佳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610829', '1,610000,610800,', '610800', '吴堡县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610830', '1,610000,610800,', '610800', '清涧县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610831', '1,610000,610800,', '610800', '子洲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610900', '1,610000,', '610000', '安康市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610901', '1,610000,610900,', '610900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610902', '1,610000,610900,', '610900', '汉滨区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610921', '1,610000,610900,', '610900', '汉阴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610922', '1,610000,610900,', '610900', '石泉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610923', '1,610000,610900,', '610900', '宁陕县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610924', '1,610000,610900,', '610900', '紫阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610925', '1,610000,610900,', '610900', '岚皋县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610926', '1,610000,610900,', '610900', '平利县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610927', '1,610000,610900,', '610900', '镇坪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610928', '1,610000,610900,', '610900', '旬阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('610929', '1,610000,610900,', '610900', '白河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('611000', '1,610000,', '610000', '商洛市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('611001', '1,610000,611000,', '611000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('611002', '1,610000,611000,', '611000', '商州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('611021', '1,610000,611000,', '611000', '洛南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('611022', '1,610000,611000,', '611000', '丹凤县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('611023', '1,610000,611000,', '611000', '商南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:02', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('611024', '1,610000,611000,', '611000', '山阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('611025', '1,610000,611000,', '611000', '镇安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('611026', '1,610000,611000,', '611000', '柞水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620000', '1,', '1', '甘肃省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620100', '1,620000,', '620000', '兰州市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620101', '1,620000,620100,', '620100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620102', '1,620000,620100,', '620100', '城关区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620103', '1,620000,620100,', '620100', '七里河区', '', '0', '3', '', '', null, null, '1', '2016-12-28 16:06:09', '', '0', '1');
INSERT INTO `sys_area_t` VALUES ('620104', '1,620000,620100,', '620100', '西固区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620105', '1,620000,620100,', '620100', '安宁区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620111', '1,620000,620100,', '620100', '红古区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620121', '1,620000,620100,', '620100', '永登县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620122', '1,620000,620100,', '620100', '皋兰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620123', '1,620000,620100,', '620100', '榆中县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620200', '1,620000,', '620000', '嘉峪关市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620201', '1,620000,620200,', '620200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620300', '1,620000,', '620000', '金昌市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620301', '1,620000,620300,', '620300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620302', '1,620000,620300,', '620300', '金川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620321', '1,620000,620300,', '620300', '永昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620400', '1,620000,', '620000', '白银市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620401', '1,620000,620400,', '620400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620402', '1,620000,620400,', '620400', '白银区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620403', '1,620000,620400,', '620400', '平川区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620421', '1,620000,620400,', '620400', '靖远县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620422', '1,620000,620400,', '620400', '会宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620423', '1,620000,620400,', '620400', '景泰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620500', '1,620000,', '620000', '天水市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620501', '1,620000,620500,', '620500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620502', '1,620000,620500,', '620500', '秦城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620503', '1,620000,620500,', '620500', '北道区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620521', '1,620000,620500,', '620500', '清水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620522', '1,620000,620500,', '620500', '秦安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620523', '1,620000,620500,', '620500', '甘谷县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620524', '1,620000,620500,', '620500', '武山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620525', '1,620000,620500,', '620500', '张家川回族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620600', '1,620000,', '620000', '武威市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620601', '1,620000,620600,', '620600', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:03', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620602', '1,620000,620600,', '620600', '凉州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620621', '1,620000,620600,', '620600', '民勤县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620622', '1,620000,620600,', '620600', '古浪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620623', '1,620000,620600,', '620600', '天祝藏族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620700', '1,620000,', '620000', '张掖市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620701', '1,620000,620700,', '620700', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620702', '1,620000,620700,', '620700', '甘州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620721', '1,620000,620700,', '620700', '肃南裕固族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620722', '1,620000,620700,', '620700', '民乐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620723', '1,620000,620700,', '620700', '临泽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620724', '1,620000,620700,', '620700', '高台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620725', '1,620000,620700,', '620700', '山丹县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620800', '1,620000,', '620000', '平凉市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620801', '1,620000,620800,', '620800', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620802', '1,620000,620800,', '620800', '崆峒区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620821', '1,620000,620800,', '620800', '泾川县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620822', '1,620000,620800,', '620800', '灵台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620823', '1,620000,620800,', '620800', '崇信县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620824', '1,620000,620800,', '620800', '华亭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620825', '1,620000,620800,', '620800', '庄浪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620826', '1,620000,620800,', '620800', '静宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620900', '1,620000,', '620000', '酒泉市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620901', '1,620000,620900,', '620900', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620902', '1,620000,620900,', '620900', '肃州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620921', '1,620000,620900,', '620900', '金塔县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620922', '1,620000,620900,', '620900', '瓜州县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620923', '1,620000,620900,', '620900', '肃北蒙古族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620924', '1,620000,620900,', '620900', '阿克塞哈萨克族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620981', '1,620000,620900,', '620900', '玉门市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('620982', '1,620000,620900,', '620900', '敦煌市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621000', '1,620000,', '620000', '庆阳市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621001', '1,620000,621000,', '621000', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621002', '1,620000,621000,', '621000', '西峰区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621021', '1,620000,621000,', '621000', '庆城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621022', '1,620000,621000,', '621000', '环县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621023', '1,620000,621000,', '621000', '华池县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621024', '1,620000,621000,', '621000', '合水县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621025', '1,620000,621000,', '621000', '正宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:04', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621026', '1,620000,621000,', '621000', '宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621027', '1,620000,621000,', '621000', '镇原县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621100', '1,620000,', '620000', '定西市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621101', '1,620000,621100,', '621100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621102', '1,620000,621100,', '621100', '安定区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621121', '1,620000,621100,', '621100', '通渭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621122', '1,620000,621100,', '621100', '陇西县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621123', '1,620000,621100,', '621100', '渭源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621124', '1,620000,621100,', '621100', '临洮县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621125', '1,620000,621100,', '621100', '漳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621126', '1,620000,621100,', '621100', '岷县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621200', '1,620000,', '620000', '陇南市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621201', '1,620000,621200,', '621200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621202', '1,620000,621200,', '621200', '武都区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621221', '1,620000,621200,', '621200', '成县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621222', '1,620000,621200,', '621200', '文县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621223', '1,620000,621200,', '621200', '宕昌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621224', '1,620000,621200,', '621200', '康县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621225', '1,620000,621200,', '621200', '西和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621226', '1,620000,621200,', '621200', '礼县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621227', '1,620000,621200,', '621200', '徽县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('621228', '1,620000,621200,', '621200', '两当县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:05', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('622900', '1,620000,', '620000', '临夏回族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('622901', '1,620000,622900,', '622900', '临夏市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('622921', '1,620000,622900,', '622900', '临夏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('622922', '1,620000,622900,', '622900', '康乐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('622923', '1,620000,622900,', '622900', '永靖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('622924', '1,620000,622900,', '622900', '广河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('622925', '1,620000,622900,', '622900', '和政县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('622926', '1,620000,622900,', '622900', '东乡族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('622927', '1,620000,622900,', '622900', '积石山保安族东乡族撒拉族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('623000', '1,620000,', '620000', '甘南藏族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('623001', '1,620000,623000,', '623000', '合作市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('623021', '1,620000,623000,', '623000', '临潭县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('623022', '1,620000,623000,', '623000', '卓尼县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('623023', '1,620000,623000,', '623000', '舟曲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('623024', '1,620000,623000,', '623000', '迭部县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('623025', '1,620000,623000,', '623000', '玛曲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('623026', '1,620000,623000,', '623000', '碌曲县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('623027', '1,620000,623000,', '623000', '夏河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('630000', '1,', '1', '青海省', null, '0', '1', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('630100', '1,630000,', '630000', '西宁市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('630101', '1,630000,630100,', '630100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('630102', '1,630000,630100,', '630100', '城东区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('630103', '1,630000,630100,', '630100', '城中区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('630104', '1,630000,630100,', '630100', '城西区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:06', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('630105', '1,630000,630100,', '630100', '城北区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('630121', '1,630000,630100,', '630100', '大通回族土族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('630122', '1,630000,630100,', '630100', '湟中县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('630123', '1,630000,630100,', '630100', '湟源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632100', '1,630000,', '630000', '海东地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632121', '1,630000,632100,', '632100', '平安县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632122', '1,630000,632100,', '632100', '民和回族土族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632123', '1,630000,632100,', '632100', '乐都县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632126', '1,630000,632100,', '632100', '互助土族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632127', '1,630000,632100,', '632100', '化隆回族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632128', '1,630000,632100,', '632100', '循化撒拉族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632200', '1,630000,', '630000', '海北藏族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632221', '1,630000,632200,', '632200', '门源回族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632222', '1,630000,632200,', '632200', '祁连县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632223', '1,630000,632200,', '632200', '海晏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632224', '1,630000,632200,', '632200', '刚察县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632300', '1,630000,', '630000', '黄南藏族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632321', '1,630000,632300,', '632300', '同仁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632322', '1,630000,632300,', '632300', '尖扎县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632323', '1,630000,632300,', '632300', '泽库县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632324', '1,630000,632300,', '632300', '河南蒙古族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632500', '1,630000,', '630000', '海南藏族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632521', '1,630000,632500,', '632500', '共和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632522', '1,630000,632500,', '632500', '同德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632523', '1,630000,632500,', '632500', '贵德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632524', '1,630000,632500,', '632500', '兴海县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:07', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632525', '1,630000,632500,', '632500', '贵南县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632600', '1,630000,', '630000', '果洛藏族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632621', '1,630000,632600,', '632600', '玛沁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632622', '1,630000,632600,', '632600', '班玛县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632623', '1,630000,632600,', '632600', '甘德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632624', '1,630000,632600,', '632600', '达日县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632625', '1,630000,632600,', '632600', '久治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632626', '1,630000,632600,', '632600', '玛多县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632700', '1,630000,', '630000', '玉树藏族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632721', '1,630000,632700,', '632700', '玉树县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632722', '1,630000,632700,', '632700', '杂多县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632723', '1,630000,632700,', '632700', '称多县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632724', '1,630000,632700,', '632700', '治多县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632725', '1,630000,632700,', '632700', '囊谦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632726', '1,630000,632700,', '632700', '曲麻莱县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632800', '1,630000,', '630000', '海西蒙古族藏族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632801', '1,630000,632800,', '632800', '格尔木市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632802', '1,630000,632800,', '632800', '德令哈市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632821', '1,630000,632800,', '632800', '乌兰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632822', '1,630000,632800,', '632800', '都兰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632823', '1,630000,632800,', '632800', '天峻县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632824', '1,630000,632800,', '632800', '芒崖', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632825', '1,630000,632800,', '632800', '冷湖', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('632826', '1,630000,632800,', '632800', '大柴旦', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640000', '1,', '1', '宁夏回族自治区', '', '0', '1', '', '\0', null, null, '1', '2016-12-28 12:20:18', '', '0', '1');
INSERT INTO `sys_area_t` VALUES ('640100', '1,640000,', '640000', '银川市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640101', '1,640000,640100,', '640100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640104', '1,640000,640100,', '640100', '兴庆区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640105', '1,640000,640100,', '640100', '西夏区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640106', '1,640000,640100,', '640100', '金凤区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:08', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640121', '1,640000,640100,', '640100', '永宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640122', '1,640000,640100,', '640100', '贺兰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640181', '1,640000,640100,', '640100', '灵武市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640200', '1,640000,', '640000', '石嘴山市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640201', '1,640000,640200,', '640200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640202', '1,640000,640200,', '640200', '大武口区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640205', '1,640000,640200,', '640200', '惠农区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640221', '1,640000,640200,', '640200', '平罗县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640300', '1,640000,', '640000', '吴忠市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640301', '1,640000,640300,', '640300', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640302', '1,640000,640300,', '640300', '利通区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640323', '1,640000,640300,', '640300', '盐池县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640324', '1,640000,640300,', '640300', '同心县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640381', '1,640000,640300,', '640300', '青铜峡市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640400', '1,640000,', '640000', '固原市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640401', '1,640000,640400,', '640400', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640402', '1,640000,640400,', '640400', '原州区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640422', '1,640000,640400,', '640400', '西吉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640423', '1,640000,640400,', '640400', '隆德县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640424', '1,640000,640400,', '640400', '泾源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640425', '1,640000,640400,', '640400', '彭阳县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640500', '1,640000,', '640000', '中卫市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640501', '1,640000,640500,', '640500', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640502', '1,640000,640500,', '640500', '沙坡头区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640521', '1,640000,640500,', '640500', '中宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('640522', '1,640000,640500,', '640500', '海原县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:09', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650000', '1,', '1', '新疆维吾尔自治区', '', '0', '1', '', '\0', null, null, '1', '2016-12-28 14:11:40', '', '0', '1');
INSERT INTO `sys_area_t` VALUES ('650100', '1,650000,', '650000', '乌鲁木齐市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650101', '1,650000,650100,', '650100', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650102', '1,650000,650100,', '650100', '天山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650103', '1,650000,650100,', '650100', '沙依巴克区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650104', '1,650000,650100,', '650100', '新市区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650105', '1,650000,650100,', '650100', '水磨沟区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650106', '1,650000,650100,', '650100', '头屯河区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650107', '1,650000,650100,', '650100', '达坂城区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650108', '1,650000,650100,', '650100', '东山区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650121', '1,650000,650100,', '650100', '乌鲁木齐县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650200', '1,650000,', '650000', '克拉玛依市', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650201', '1,650000,650200,', '650200', '市辖区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650202', '1,650000,650200,', '650200', '独山子区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650203', '1,650000,650200,', '650200', '克拉玛依区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650204', '1,650000,650200,', '650200', '白碱滩区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('650205', '1,650000,650200,', '650200', '乌尔禾区', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652100', '1,650000,', '650000', '吐鲁番地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652101', '1,650000,652100,', '652100', '吐鲁番市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652122', '1,650000,652100,', '652100', '鄯善县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:10', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652123', '1,650000,652100,', '652100', '托克逊县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652200', '1,650000,', '650000', '哈密地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652201', '1,650000,652200,', '652200', '哈密市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652222', '1,650000,652200,', '652200', '巴里坤哈萨克自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652223', '1,650000,652200,', '652200', '伊吾县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652300', '1,650000,', '650000', '昌吉回族自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652301', '1,650000,652300,', '652300', '昌吉市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652302', '1,650000,652300,', '652300', '阜康市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652303', '1,650000,652300,', '652300', '米泉市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652323', '1,650000,652300,', '652300', '呼图壁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652324', '1,650000,652300,', '652300', '玛纳斯县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652325', '1,650000,652300,', '652300', '奇台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652327', '1,650000,652300,', '652300', '吉木萨尔县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652328', '1,650000,652300,', '652300', '木垒哈萨克自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652700', '1,650000,', '650000', '博尔塔拉蒙古自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652701', '1,650000,652700,', '652700', '博乐市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652722', '1,650000,652700,', '652700', '精河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652723', '1,650000,652700,', '652700', '温泉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652800', '1,650000,', '650000', '巴音郭楞蒙古自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652801', '1,650000,652800,', '652800', '库尔勒市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652822', '1,650000,652800,', '652800', '轮台县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652823', '1,650000,652800,', '652800', '尉犁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652824', '1,650000,652800,', '652800', '若羌县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652825', '1,650000,652800,', '652800', '且末县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652826', '1,650000,652800,', '652800', '焉耆回族自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652827', '1,650000,652800,', '652800', '和静县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652828', '1,650000,652800,', '652800', '和硕县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652829', '1,650000,652800,', '652800', '博湖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652900', '1,650000,', '650000', '阿克苏地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:11', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652901', '1,650000,652900,', '652900', '阿克苏市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652922', '1,650000,652900,', '652900', '温宿县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652923', '1,650000,652900,', '652900', '库车县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652924', '1,650000,652900,', '652900', '沙雅县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652925', '1,650000,652900,', '652900', '新和县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652926', '1,650000,652900,', '652900', '拜城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652927', '1,650000,652900,', '652900', '乌什县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652928', '1,650000,652900,', '652900', '阿瓦提县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('652929', '1,650000,652900,', '652900', '柯坪县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653000', '1,650000,', '650000', '克孜勒苏柯尔克孜自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653001', '1,650000,653000,', '653000', '阿图什市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653022', '1,650000,653000,', '653000', '阿克陶县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653023', '1,650000,653000,', '653000', '阿合奇县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653024', '1,650000,653000,', '653000', '乌恰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653100', '1,650000,', '650000', '喀什地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653101', '1,650000,653100,', '653100', '喀什市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653121', '1,650000,653100,', '653100', '疏附县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653122', '1,650000,653100,', '653100', '疏勒县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653123', '1,650000,653100,', '653100', '英吉沙县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653124', '1,650000,653100,', '653100', '泽普县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653125', '1,650000,653100,', '653100', '莎车县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653126', '1,650000,653100,', '653100', '叶城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653127', '1,650000,653100,', '653100', '麦盖提县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653128', '1,650000,653100,', '653100', '岳普湖县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653129', '1,650000,653100,', '653100', '伽师县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653130', '1,650000,653100,', '653100', '巴楚县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653131', '1,650000,653100,', '653100', '塔什库尔干塔吉克自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653200', '1,650000,', '650000', '和田地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653201', '1,650000,653200,', '653200', '和田市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653221', '1,650000,653200,', '653200', '和田县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653222', '1,650000,653200,', '653200', '墨玉县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653223', '1,650000,653200,', '653200', '皮山县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653224', '1,650000,653200,', '653200', '洛浦县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653225', '1,650000,653200,', '653200', '策勒县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653226', '1,650000,653200,', '653200', '于田县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('653227', '1,650000,653200,', '653200', '民丰县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654000', '1,650000,', '650000', '伊犁哈萨克自治州', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:12', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654002', '1,650000,654000,', '654000', '伊宁市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654003', '1,650000,654000,', '654000', '奎屯市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654021', '1,650000,654000,', '654000', '伊宁县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654022', '1,650000,654000,', '654000', '察布查尔锡伯自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654023', '1,650000,654000,', '654000', '霍城县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654024', '1,650000,654000,', '654000', '巩留县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654025', '1,650000,654000,', '654000', '新源县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654026', '1,650000,654000,', '654000', '昭苏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654027', '1,650000,654000,', '654000', '特克斯县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654028', '1,650000,654000,', '654000', '尼勒克县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654200', '1,650000,', '650000', '塔城地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654201', '1,650000,654200,', '654200', '塔城市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654202', '1,650000,654200,', '654200', '乌苏市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654221', '1,650000,654200,', '654200', '额敏县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654223', '1,650000,654200,', '654200', '沙湾县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654224', '1,650000,654200,', '654200', '托里县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654225', '1,650000,654200,', '654200', '裕民县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654226', '1,650000,654200,', '654200', '和布克赛尔蒙古自治县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654300', '1,650000,', '650000', '阿勒泰地区', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654301', '1,650000,654300,', '654300', '阿勒泰市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654321', '1,650000,654300,', '654300', '布尔津县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654322', '1,650000,654300,', '654300', '富蕴县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654323', '1,650000,654300,', '654300', '福海县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654324', '1,650000,654300,', '654300', '哈巴河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654325', '1,650000,654300,', '654300', '青河县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('654326', '1,650000,654300,', '654300', '吉木乃县', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('659000', '1,650000,', '650000', '省直辖行政单位', null, '0', '2', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('659001', '1,650000,659000,', '659000', '石河子市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('659002', '1,650000,659000,', '659000', '阿拉尔市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:13', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('659003', '1,650000,659000,', '659000', '图木舒克市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:14', null, '0', '1');
INSERT INTO `sys_area_t` VALUES ('659004', '1,650000,659000,', '659000', '五家渠市', null, '0', '3', null, '\0', null, null, null, '2016-12-14 15:00:14', null, '0', '1');

-- ----------------------------
-- Table structure for sys_dict_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_t`;
CREATE TABLE `sys_dict_t` (
  `id_` varchar(32) NOT NULL COMMENT '编号',
  `name_` varchar(255) DEFAULT NULL COMMENT '字典名称',
  `parent_id` varchar(32) DEFAULT NULL,
  `parent_ids` varchar(2000) DEFAULT NULL,
  `val_` varchar(255) DEFAULT NULL COMMENT '字典值',
  `key_` varchar(225) DEFAULT NULL,
  `code_` varchar(255) DEFAULT NULL COMMENT '字典唯一编码',
  `is_leaf` bit(1) DEFAULT b'0' COMMENT '0 叶子节点 1 非叶子节点',
  `sort_` int(11) DEFAULT '0' COMMENT '排序',
  `description_` varchar(255) DEFAULT NULL COMMENT '描述',
  `status_` varchar(2) DEFAULT '0',
  `show_name` varchar(255) DEFAULT NULL COMMENT '资源文件key',
  `is_show` bit(1) DEFAULT b'1' COMMENT '0 叶子节点 1 非叶子节点',
  `version_` int(11) DEFAULT '0',
  `created_by` varchar(50) NOT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `val_` (`val_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_dict_t
-- ----------------------------
INSERT INTO `sys_dict_t` VALUES ('002ad16e23b84cb3bb73ed35661c2771', '默认展现方式', '4ff390ef18c74373a90cd511f563de91', '0,1,faab4823cc8c4ddf89165fec5cac93af,4ff390ef18c74373a90cd511f563de91,', '0', null, 'cms_show_modes_0', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('00ddb6f23b1945acb48206120e5af733', '不能操作', 'fa4c71c5e56a49a8a9bba90f11d0a9fa', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,fa4c71c5e56a49a8a9bba90f11d0a9fa,', '0', null, 'refund_operate_status_0', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('00f4e8b69b314a2ebb814e96cd3fd019', '橙色主题', '192b728ede9b4c33ae963a52175e4a93', '0,1,5ea249bb780348eb8ea6a0efade684a6,192b728ede9b4c33ae963a52175e4a93,', 'readable', null, 'readable', '\0', '80', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:47:08');
INSERT INTO `sys_dict_t` VALUES ('01738aa7fd884849b2631402b8159ebd', '业务消息', 'a73c99c35bd84d5baea21549c05e9493', '0,1,5ea249bb780348eb8ea6a0efade684a6,a73c99c35bd84d5baea21549c05e9493,', '1', null, 'sys_message_type_1', '', '0', '', '0', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:42:37');
INSERT INTO `sys_dict_t` VALUES ('02d64d53bd6148ef8edf29fa8f39d0ef', '房地产-建筑', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '3', null, 'job_type_3', '\0', '30', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('02f740118dfe462fbdb4cd598b3f8724', '普通商品', '30906ca1f1324629a2960a8892020e2e', '0,1,28a368fdbbd44a7a99af28d01b12c089,30906ca1f1324629a2960a8892020e2e,', '2', null, 'commodity_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('03313c7672934531b468551ae916a7a9', '团购详情页面', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '6', null, 'notice_page_type_6', '\0', '60', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('03ff9e9d56ae40da84731677aa177f20', '常来客户', '99fd51a62c8e4a799f56128826fc1922', '0,1,28a368fdbbd44a7a99af28d01b12c089,99fd51a62c8e4a799f56128826fc1922,', '3', null, 'client_msg_type_3', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('04df64d859bc4073ac91a54d6b238501', '一级', '8040c72a95f541a49734bbe1c47547ca', '0,1,5ea249bb780348eb8ea6a0efade684a6,8040c72a95f541a49734bbe1c47547ca,', '1', null, 'sys_org_grade_1', '\0', '4', null, '0', null, '', '4', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('05655dc0210a4dc9840c3a22ab96cee3', '已删除', '36adfd803e3f4b48b6fa829c96b26959', '0,1,5ea249bb780348eb8ea6a0efade684a6,36adfd803e3f4b48b6fa829c96b26959,', '-2', null, 'sys_status_delete', '', '0', '', '0', null, '\0', '7', '', '2016-12-05 11:31:22', '1', '2016-12-29 13:15:08');
INSERT INTO `sys_dict_t` VALUES ('06e19590ff9f41d28381ec14565fb1fd', '加油', '676ca81bfa9440018af3f15c17d7a1b6', '0,1,28a368fdbbd44a7a99af28d01b12c089,676ca81bfa9440018af3f15c17d7a1b6,', '1', null, 'score_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('0857ed8ed2e44bac8434c524ab8f467a', '是', 'ed6bc6b03a2a4afbbdc9e35957aa0440', '0,1,5ea249bb780348eb8ea6a0efade684a6,ed6bc6b03a2a4afbbdc9e35957aa0440,', '1', null, 'sys_no', '\0', '0', '', '0', null, '', '10', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('087cf2856c334d95937e641a7a6d798d', '油站推送内容', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'content_type', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('09ce53d380d0410eb4ef94fc3e380e95', '商品期数状态', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'period_type', '\0', '85', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('09cf4592658c4fb787ed5e0601d5e10f', '兑换商品', '676ca81bfa9440018af3f15c17d7a1b6', '0,1,28a368fdbbd44a7a99af28d01b12c089,676ca81bfa9440018af3f15c17d7a1b6,', '4', null, 'score_type_4', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('09d92c95ae5a456b97af362b8920bead', '投诉', '857efc4a11844315aec9ace0d2a75206', '0,1,faab4823cc8c4ddf89165fec5cac93af,857efc4a11844315aec9ace0d2a75206,', '3', null, 'cms_guestbook_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('0a18ac9cea074db9bafaa6ac71c479a0', '首栏目内容列表', '4ff390ef18c74373a90cd511f563de91', '0,1,faab4823cc8c4ddf89165fec5cac93af,4ff390ef18c74373a90cd511f563de91,', '1', null, 'cms_show_modes_1', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('0a319398781d45e88dea8db45eb42bfd', '分享邀请获得优惠券两张总额', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '10', null, 'USER_INVITE_DISCOUNT_TWO', '\0', '0', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('0c06f2924ba443719dc34cc0fb3d332c', 'ic卡充值面额', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '100-110:300-340:500-560:1000-1120', null, 'ic_recharge_money', '', '123', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('0c6ee942880f47a4b67580cb43e771f5', '新模式', '2bf3cf6cc6bf46f8a077ed59d710ae86', '0,1,b95893620a4a462490349148b9bfe1e7,2bf3cf6cc6bf46f8a077ed59d710ae86,', '2', null, 'mode_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('0cab64470c044e49a23becc3e1d2a2f6', '支付页面', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '4', null, 'notice_page_type_4', '\0', '40', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('0d4d5f3b9ca54a50ad06071daa7cd4a5', '自动新增', '52e80591e4434de9b8bc8e3d5bf2c394', '0,1,b95893620a4a462490349148b9bfe1e7,52e80591e4434de9b8bc8e3d5bf2c394,', '1', null, 'sale_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('0e38f24789f7459cb7726b9a62ce2a23', '流失客户', '99fd51a62c8e4a799f56128826fc1922', '0,1,28a368fdbbd44a7a99af28d01b12c089,99fd51a62c8e4a799f56128826fc1922,', '4', null, 'client_msg_type_4', '\0', '50', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('0f53705c795644448cc331a02788fc67', '中奖晒单', '676ca81bfa9440018af3f15c17d7a1b6', '0,1,28a368fdbbd44a7a99af28d01b12c089,676ca81bfa9440018af3f15c17d7a1b6,', '8', null, 'score_type_8', '\0', '80', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('0f77deaad18c48d4a1394093cd72f7f3', '请求方法类型', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '', null, 'sys_request_method', '\0', '30', '', '0', null, '', '0', '1', '2016-12-28 17:48:05', '1', '2016-12-28 17:48:58');
INSERT INTO `sys_dict_t` VALUES ('0fa997a5e4c94b4ab7c69b1d7ebc6f78', '汽车-机械', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '70', null, 'job_type_7', '\0', '70', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('1', '数据字典', '0', '0,', null, null, 'base', '\0', '0', null, '0', null, '', '6', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('10025736a46145819300a0f6a4cf3c26', 'LNG', '6a6391af2d82453c8e13bbebdf448249', '0,1,28a368fdbbd44a7a99af28d01b12c089,6a6391af2d82453c8e13bbebdf448249,', '6', null, 'oil_type_6', '', '60', '元/公斤', '-2', null, '', '7', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('108eabb7ee8f4dcd8e9d7d37526e479e', '超级管理员', 'f144d350f02f457c8ce90588c7d67c77', '0,1,bede16c99d85416a834a6b3c664bbb9b,f144d350f02f457c8ce90588c7d67c77,', '2', null, 'ep_role_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('109d1234024b4ca2abc8645cf7e186e2', '首页焦点图', 'ac531aa386174308935cfea881685fe4', '0,1,faab4823cc8c4ddf89165fec5cac93af,ac531aa386174308935cfea881685fe4,', '1', null, 'cms_posid_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('11c9f767492c43ae9e46dfe3666f5bf5', '优品加油维护电话', '39f49944671841f090195db52eb6e03f', '0,1,28a368fdbbd44a7a99af28d01b12c089,39f49944671841f090195db52eb6e03f,', '400-005-8905', null, 'merchant_technical_contact', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('13370a47ef44472fad7c7c8fab5a2ae3', '每单优惠', 'c8b6eed70aac438dbaa90896fcdcbd4d', '0,1,b95893620a4a462490349148b9bfe1e7,c8b6eed70aac438dbaa90896fcdcbd4d,', '2', null, 'wx_refuel_type_2', '', '30', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('14bff8207bcf4fbc9d726a19f6065dc2', '病假', '41a1ef8605464dcbaf51296230ffb25d', '0,1,28a368fdbbd44a7a99af28d01b12c089,41a1ef8605464dcbaf51296230ffb25d,', '2', null, 'oa_leave_type_2', '\0', '700', '', '-2', null, '', '6', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('14c8d7b3fc56455db298a0cff97d0601', '系统管理', '1c7261a0576b4844be71a1a6f4238d49', '0,1,5ea249bb780348eb8ea6a0efade684a6,1c7261a0576b4844be71a1a6f4238d49,', '1', null, 'sys_staff_type_1', '\0', '10', '', '0', null, '', '4', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('163c3219546d4336a4249856677690d4', '微信', '302d390aae3142e79bf0155aeb4768bb', '0,1,28a368fdbbd44a7a99af28d01b12c089,302d390aae3142e79bf0155aeb4768bb,', '1', null, 'pay_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('1643f491a1d34d67b4e2663c5171698b', '红包优惠券', '86f3598178fb4f659480dfdab40f0613', '0,1,28a368fdbbd44a7a99af28d01b12c089,86f3598178fb4f659480dfdab40f0613,', '6', null, 'voucher_discount_type_6', '\0', '60', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('17e3e7f594934f129ce1d16a62bc6b26', '已过期', 'e154ebf279844277b36190cd40561cb7', '0,1,28a368fdbbd44a7a99af28d01b12c089,e154ebf279844277b36190cd40561cb7,', '2', null, 'voucher_discount_status_2', '\0', '33', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('192b728ede9b4c33ae963a52175e4a93', '主题', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', 'theme', null, 'theme', '\0', '30', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:47:08');
INSERT INTO `sys_dict_t` VALUES ('1b8d322425c140c6b8cc3165a0ac5458', '92#test', '6a6391af2d82453c8e13bbebdf448249', '0,1,28a368fdbbd44a7a99af28d01b12c089,6a6391af2d82453c8e13bbebdf448249,', '10', null, 'oil_type_10', '', '90', 'RMB/Ltest', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('1be4fa1a638847d8b7f56add647dbf57', '美元汇率', 'c9a70cf00c8e42b2b6d8eb475d133d57', '0,1,28a368fdbbd44a7a99af28d01b12c089,c9a70cf00c8e42b2b6d8eb475d133d57,', '1', null, 'exchange_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('1c25bd83fb9b4de18f5e53bc1eaa0272', '优品夺宝主页', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '7', null, 'notice_page_type_7', '\0', '70', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('1c70df559b1346e8aaa41a604d7f9bae', '文化传媒', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '4', null, 'job_type_4', '\0', '40', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('1c7261a0576b4844be71a1a6f4238d49', '用户类型', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '1', null, 'sys_staff_type', '\0', '10', '', '0', null, '', '4', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('1ca59e473f0e48a9ab0591fa098e89f9', '团购卷状态', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'vucher_status', '\0', '20', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('1d1fef2730aa4eb19fd9a9804cff8ee3', '圆通', 'e5ad79055bfd41ddaf9cd9e2be127ae0', '0,1,28a368fdbbd44a7a99af28d01b12c089,e5ad79055bfd41ddaf9cd9e2be127ae0,', '4', null, 'express_type_4', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('1e5429816dbc48fe99d247a0de7523a7', 'app模块类型', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'app_type', '\0', '885', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('1ef7c3f1ec58470f9187dc607f61399e', '省份、直辖市', '43c66dd855b84a4489e40a05141472db', '0,1,5ea249bb780348eb8ea6a0efade684a6,43c66dd855b84a4489e40a05141472db,', '1', null, 'sys_area_type_2', '\0', '20', '', '0', null, '', '5', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('1fbeb15cd52849ffba2b7a77ce9dda78', '分享邀请限制金额', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '100', null, 'USER_INVITE_DISCOUNT_LIMIT_MONEY', '\0', '60', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('21150b4cebd349a1992e6bb3428ab4e5', '性别', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'gender', '\0', '80', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('214d7affc6f046c4a769a37f62274d49', '申请已提交', '8f914a54eef54792b900032864f43dad', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,8f914a54eef54792b900032864f43dad,', '1', null, 'refund_status_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('21c6ab14d8c547e0a4f6f63941e68800', '3个月', '8ba80468747d4fb18d5715354e8a813e', '0,1,28a368fdbbd44a7a99af28d01b12c089,8ba80468747d4fb18d5715354e8a813e,', '3', null, 'validity_date_3', '', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('225037004a2d4d2bbf926020deb59dcd', '红色主题', '192b728ede9b4c33ae963a52175e4a93', '0,1,5ea249bb780348eb8ea6a0efade684a6,192b728ede9b4c33ae963a52175e4a93,', 'united', null, 'united', '\0', '70', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:47:08');
INSERT INTO `sys_dict_t` VALUES ('22ee9ab66e6549e1b7073fcaf6bba982', '充值', 'de329dd14fd44edeb5f32c54fe02b1e2', '0,1,bede16c99d85416a834a6b3c664bbb9b,de329dd14fd44edeb5f32c54fe02b1e2,', '1', null, 'wallet_consume_flowing_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('23254e4c15c545e2b470d71609882706', '内容3', '47a5e3b107294f318017dd336c9a8ad7', '0,1,a0d3943b46154244bfeb0bee9b59ab38,47a5e3b107294f318017dd336c9a8ad7,', '第一次来加油，比想象中好得多，下次还会再来！', null, 'comment_content_type_3', '', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('236f98b874394681b179c55612c43dd7', '优惠签约', '28d335463d1f426aa80700d817ae427b', '0,1,bede16c99d85416a834a6b3c664bbb9b,28d335463d1f426aa80700d817ae427b,', '2', null, 'contract_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('2384c05145b54ed693cfd7f20e7d8b65', 'CNG', '6a6391af2d82453c8e13bbebdf448249', '0,1,28a368fdbbd44a7a99af28d01b12c089,6a6391af2d82453c8e13bbebdf448249,', '7', null, 'oil_type_7', '', '70', '元/立方米', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('23aa6229b36a45aa9113d003fb37ff63', '新增用户', '99fd51a62c8e4a799f56128826fc1922', '0,1,28a368fdbbd44a7a99af28d01b12c089,99fd51a62c8e4a799f56128826fc1922,', '5', null, 'client_msg_type_5', '\0', '60', '1个月内的新增用户', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('240d3f05b88842d7a36bd3757b026c75', '城市商业银行', 'ed8014b466d1419d9b26171248460894', '0,1,28a368fdbbd44a7a99af28d01b12c089,ed8014b466d1419d9b26171248460894,', '21', null, 'bank_type_chengshishangye', '\0', '80', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('2468f642eb014e918f5901d7274760c4', '车牌类型', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'car_num_type', '\0', '87', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('24890a15cef44a8b86afbed32e1e3a2d', '快钱', '302d390aae3142e79bf0155aeb4768bb', '0,1,28a368fdbbd44a7a99af28d01b12c089,302d390aae3142e79bf0155aeb4768bb,', '7', null, 'pay_type_7', '\0', '70', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('24dc1071aefb47a1be1c0544062e99f9', '否', 'ed6bc6b03a2a4afbbdc9e35957aa0440', '0,1,5ea249bb780348eb8ea6a0efade684a6,ed6bc6b03a2a4afbbdc9e35957aa0440,', '0', null, 'sys_yes', '\0', '10', '', '0', null, '', '10', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('25958fb362674775b84050e8e2bbda56', '仅本人数据', 'aec4a6b7cfd6475ea0d97714c13003fe', '0,1,5ea249bb780348eb8ea6a0efade684a6,aec4a6b7cfd6475ea0d97714c13003fe,', '4', null, 'sys_role_scope_4', '\0', '10', '', '0', null, '', '6', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('26e8db8c98964edfb6a35e437b32cee5', '企业优惠比例类型', 'bede16c99d85416a834a6b3c664bbb9b', '0,1,bede16c99d85416a834a6b3c664bbb9b,', '', null, 'ratio_type', '\0', '44', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('2797025c78fd473b9e91e4f9d91b1167', '航油加油站', 'f836643eb0754b1d84711435111e8234', '0,1,b95893620a4a462490349148b9bfe1e7,f836643eb0754b1d84711435111e8234,', '1', null, 'station_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('2810baaf4ec44f58aa6ba802704dd88c', '内容2', '47a5e3b107294f318017dd336c9a8ad7', '0,1,a0d3943b46154244bfeb0bee9b59ab38,47a5e3b107294f318017dd336c9a8ad7,', '油好，服务好，软件更好，尽在不言中！', null, 'comment_content_type_2', '', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('28a368fdbbd44a7a99af28d01b12c089', '基础数据', '1', '0,1,', '', null, 'ser', '\0', '10', '', '-2', null, '', '29', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('28d335463d1f426aa80700d817ae427b', '企业签约类型', 'bede16c99d85416a834a6b3c664bbb9b', '0,1,bede16c99d85416a834a6b3c664bbb9b,', '', null, 'contract_type', '\0', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('29cd496627ca4d15a29872165d58e412', '优品夺宝支付页面', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '11', null, 'notice_page_type_11', '\0', '110', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('29dd5ba26b8c4758bcd8c3a3d1ccc5d6', '内容1', '47a5e3b107294f318017dd336c9a8ad7', '0,1,a0d3943b46154244bfeb0bee9b59ab38,47a5e3b107294f318017dd336c9a8ad7,', '油站服务很贴心，不错的体验！', null, 'comment_content_type_1', '', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('2a049947ec9d457b8720dca1652cd4ea', '微信首次加油节约金额', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '0', null, 'WX_USER_CONSUME_FRIST_SAVEMONEY', '\0', '50', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('2a325c1dcb95412faebd7118ed0e6110', 'WARN', 'cf92bd9bc2a64ac9a37776f3ec8cce24', '0,1,5ea249bb780348eb8ea6a0efade684a6,cf92bd9bc2a64ac9a37776f3ec8cce24,', 'WARN', null, 'sys_log_level_warn', '', '90', '', '0', null, '', '0', '1', '2017-01-03 15:04:12', '1', '2017-01-03 15:04:12');
INSERT INTO `sys_dict_t` VALUES ('2a3efc44ead7458394cbd8dce284e8a7', '已使用', 'de37ceeedc6643ad9e5a38745deb4b3f', '0,1,28a368fdbbd44a7a99af28d01b12c089,de37ceeedc6643ad9e5a38745deb4b3f,', '1', null, 'gun_use_status_1', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('2a41ef6aa47b40a5b15c899be205e0f1', '可见', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', 'show_hide', null, 'show_hide', '\0', '10', '', '0', null, '', '2', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('2bf3cf6cc6bf46f8a077ed59d710ae86', '券类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'mode_type', '\0', '500', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('2c6b8b7ba127449d8588ba2ea8d7c856', '加油站管理', '1c7261a0576b4844be71a1a6f4238d49', '0,1,5ea249bb780348eb8ea6a0efade684a6,1c7261a0576b4844be71a1a6f4238d49,', '2', null, 'sys_staff_type_2', '\0', '0', '', '0', null, '', '7', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('2d778a9832084c4ba246d1b042e9b4ea', '模块类型', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '', null, 'sys_module_type', '\0', '0', null, '0', null, '', '2', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('2d9c98ffa9074d399c33662891f82938', '未使用', 'de37ceeedc6643ad9e5a38745deb4b3f', '0,1,28a368fdbbd44a7a99af28d01b12c089,de37ceeedc6643ad9e5a38745deb4b3f,', '0', null, 'gun_use_status_0', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('2dba0acea9664a89b186ef2ffbb7ca48', '中国银行', 'ed8014b466d1419d9b26171248460894', '0,1,28a368fdbbd44a7a99af28d01b12c089,ed8014b466d1419d9b26171248460894,', '04', null, 'bank_type_zhongguo', '\0', '40', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('2e18fe323e2e4ad0897f456a8b68dbc8', '退款处理中', 'fa4c71c5e56a49a8a9bba90f11d0a9fa', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,fa4c71c5e56a49a8a9bba90f11d0a9fa,', '2', null, 'refund_operate_status_2', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('2ec0f3e762c443168694014ec6749bf5', 'vip预约', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '3', null, 'notice_page_type_3', '\0', '30', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('2ec179d675984d94b7c13091954c641c', '60后', '56b066d2c4fb49358d7dc044d5370e6f', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,56b066d2c4fb49358d7dc044d5370e6f,', '4', null, 'age_type_4', '\0', '40', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('2f10104fd5844cb6b898f26a8bd9c930', '否', 'b69b14b96942405ea4eaf2030b08c531', '0,1,28a368fdbbd44a7a99af28d01b12c089,b69b14b96942405ea4eaf2030b08c531,', '1', null, 'is_wash_car_1', '\0', '10', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('2f1c5e64be254ed9b88dd26dc66c22b5', '安卓手表版本信息', '82bcde93ebec45caa80f43ff5dfec9a5', '0,1,82bcde93ebec45caa80f43ff5dfec9a5,', '6', null, 'android.watch.version', '', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:04');
INSERT INTO `sys_dict_t` VALUES ('2f8b5dc852474887b5787631b9baa574', '93#test', '6a6391af2d82453c8e13bbebdf448249', '0,1,28a368fdbbd44a7a99af28d01b12c089,6a6391af2d82453c8e13bbebdf448249,', '11', null, 'oil_type_11', '', '100', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('2fc37c3bcf3945408f94d201e5ba7740', '事假', '41a1ef8605464dcbaf51296230ffb25d', '0,1,28a368fdbbd44a7a99af28d01b12c089,41a1ef8605464dcbaf51296230ffb25d,', '1', null, 'oa_leave_type_1', '\0', '900', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('2ffb17cd29824387b0a14a30dc6ce3ec', '首单(加油立减)', 'c8b6eed70aac438dbaa90896fcdcbd4d', '0,1,b95893620a4a462490349148b9bfe1e7,c8b6eed70aac438dbaa90896fcdcbd4d,', '1', null, 'wx_refuel_type_1', '', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('302641f9125644c7a1c43a7c84433c27', '安卓注册', 'de535c516c4941f0805aff89af46fdff', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,de535c516c4941f0805aff89af46fdff,', '10', null, 'regist_type_2', '\0', '20', '', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('302d390aae3142e79bf0155aeb4768bb', '支付类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'pay_type', '\0', '80', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('305fa6067d5845b2a3bbdad47643f321', '加油站', 'af9fa7257bde4f1b8a117723d28d94ee', '0,1,b95893620a4a462490349148b9bfe1e7,af9fa7257bde4f1b8a117723d28d94ee,', '1', null, 'station_genre_1', '\0', '10', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('30906ca1f1324629a2960a8892020e2e', '商品类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'commodity_type', '\0', '999', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('31170f31cc9b4f579f0baa168a6c2982', '普通员工', 'f144d350f02f457c8ce90588c7d67c77', '0,1,bede16c99d85416a834a6b3c664bbb9b,f144d350f02f457c8ce90588c7d67c77,', '0', null, 'ep_role_type_0', '\0', '0', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('31417fc7b5684a83aea01d17301dba82', '退款中', '1ca59e473f0e48a9ab0591fa098e89f9', '0,1,28a368fdbbd44a7a99af28d01b12c089,1ca59e473f0e48a9ab0591fa098e89f9,', '300', null, 'vucher_status_5', '\0', '50', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('31f259d669c742308f9a8042ddc032b2', '优品油耗', 'b084821826c3485fbbb9a590ae470809', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,b084821826c3485fbbb9a590ae470809,', '5', null, 'app_operate_type_5', '\0', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('32918f5f441f4e5d9e3f6eb8c9caa8de', '通知页面类型', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'notice_page_type', '\0', '111', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('33d6b4ca03e9472786be9d4368fde2ac', '农村商业银行', 'ed8014b466d1419d9b26171248460894', '0,1,28a368fdbbd44a7a99af28d01b12c089,ed8014b466d1419d9b26171248460894,', '26', null, 'bank_type_nongshang', '\0', '80', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('355f898402bf45f39934b60c8ab5818f', '加油站合作方式', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'cooperate_type', '\0', '50', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('3574e2f27d9f4b0ebbd651eb7c4e33df', '中国航油', '8473ea94776e45fdbb758257e4054fae', '0,1,bede16c99d85416a834a6b3c664bbb9b,8473ea94776e45fdbb758257e4054fae,', '4', null, 'ep_role_station_company_4', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('35dc39f8a2494f3eb11c302eb336160c', '亲爱的顾客，我们是{0}，您已经有一段时间没来消费，我们很想您哦！', '087cf2856c334d95937e641a7a6d798d', '0,1,b95893620a4a462490349148b9bfe1e7,087cf2856c334d95937e641a7a6d798d,', '亲爱的顾客，我们是{0}，您已经有一段时间没来消费，我们很想您哦！', null, 'content_type_1', '\0', '10', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('3642c877eeb145d0a39cc39b61a1208a', '一键支付', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '1', null, 'app_type_1', '\0', '10', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('36adfd803e3f4b48b6fa829c96b26959', '数据状态', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '', null, 'sys_status', '\0', '0', '', '0', null, '', '8', '', '2016-12-05 11:31:22', '1', '2016-12-29 13:15:08');
INSERT INTO `sys_dict_t` VALUES ('370b6d33bde04d7a857fd548a889c732', '团购主页', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '5', null, 'notice_page_type_5', '\0', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('37d4968b75534f8abf7358fb9d21358b', '审核', '36adfd803e3f4b48b6fa829c96b26959', '0,1,5ea249bb780348eb8ea6a0efade684a6,36adfd803e3f4b48b6fa829c96b26959,', '1', null, 'sys_status_audit', '\0', '99', '', '0', null, '', '4', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('37f467eb59cf49f0b0c130ad6f064482', '中国工商银行', 'ed8014b466d1419d9b26171248460894', '0,1,28a368fdbbd44a7a99af28d01b12c089,ed8014b466d1419d9b26171248460894,', '02', null, 'bank_type_gongshang', '\0', '20', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('381273cbfa814474a83b48da49b46c17', '油站消息接收类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'station_reveive_type', '\0', '111', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('38b75cb2aea64954abf149707728f967', '服务业', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '130', null, 'job_type_13', '\0', '130', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('3956165e4d9e4e9fbf60d610175f3d29', '12个月', '8ba80468747d4fb18d5715354e8a813e', '0,1,28a368fdbbd44a7a99af28d01b12c089,8ba80468747d4fb18d5715354e8a813e,', '12', null, 'validity_date_12', '', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('39f49944671841f090195db52eb6e03f', '优品加油联系方式', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'merchant_contact', '\0', '200', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('3a30ce234f8e4be58c7da9b12ea52d7f', '顺丰', 'e5ad79055bfd41ddaf9cd9e2be127ae0', '0,1,28a368fdbbd44a7a99af28d01b12c089,e5ad79055bfd41ddaf9cd9e2be127ae0,', '1', null, 'express_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('3af9f34ba3f3404f9cbacce996f3b927', '柴油', '26e8db8c98964edfb6a35e437b32cee5', '0,1,bede16c99d85416a834a6b3c664bbb9b,26e8db8c98964edfb6a35e437b32cee5,', '2', null, 'ratio_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('3beb9c8ddcc24873894029ecade40a10', '分类2', '4d602044fd6d4b85acfcb1d0160673be', '0,1,5ea249bb780348eb8ea6a0efade684a6,4d602044fd6d4b85acfcb1d0160673be,', '2', null, 'act_category_2', '\0', '20', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:29');
INSERT INTO `sys_dict_t` VALUES ('3c122256add3471eb517ab2849d1f5eb', '活动注册', 'de535c516c4941f0805aff89af46fdff', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,de535c516c4941f0805aff89af46fdff,', '500', null, 'regist_type_6', '\0', '60', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('3c14ad77483347f0b4b271c11125ba35', '待付款', '1ca59e473f0e48a9ab0591fa098e89f9', '0,1,28a368fdbbd44a7a99af28d01b12c089,1ca59e473f0e48a9ab0591fa098e89f9,', '1', null, 'vucher_status_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('3c1d4ebc8fd8472191acf9875c065d9e', '黄牌', '2468f642eb014e918f5901d7274760c4', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,2468f642eb014e918f5901d7274760c4,', '2', null, 'car_num_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('3cff813418b942f7a343208a45d78bac', '6个月', '8ba80468747d4fb18d5715354e8a813e', '0,1,28a368fdbbd44a7a99af28d01b12c089,8ba80468747d4fb18d5715354e8a813e,', '6', null, 'validity_date_6', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('3d80a544521148f188303a1a129b624d', '管理加油', 'd731fd771daf48d0a75e6593f4123e32', '0,1,b95893620a4a462490349148b9bfe1e7,d731fd771daf48d0a75e6593f4123e32,', '1', null, 'refuel_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('3ee0fd1a6ddd4fc68947378b9bbca2bd', '点击菜单', 'fe104789ebbd41c5983984beb634705f', '0,1,5ea249bb780348eb8ea6a0efade684a6,fe104789ebbd41c5983984beb634705f,', '2', null, 'sys_module_flag_2', '\0', '30', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:42');
INSERT INTO `sys_dict_t` VALUES ('3f3e6381391f44828d3d161163831b2e', '登录失败', '9274dd2c76b94e51972e8b439e036eb2', '0,1,5ea249bb780348eb8ea6a0efade684a6,9274dd2c76b94e51972e8b439e036eb2,', '1', null, 'sys_login_status_1', '\0', '0', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:36');
INSERT INTO `sys_dict_t` VALUES ('412946b86b5946f08aa6c6e6316ddb44', 'ic卡支付', '302d390aae3142e79bf0155aeb4768bb', '0,1,28a368fdbbd44a7a99af28d01b12c089,302d390aae3142e79bf0155aeb4768bb,', '9', null, 'pay_type_9', '\0', '90', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('41a1ef8605464dcbaf51296230ffb25d', '请假类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '0', null, 'oa_leave_type', '\0', '20', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('41bd2f5e4a83400fa00bf797d7972fff', '合作油站', 'edfa4d6478d9429d8474c4bc9f687dbe', '0,1,b95893620a4a462490349148b9bfe1e7,edfa4d6478d9429d8474c4bc9f687dbe,', '1', null, 'station_cooperate_1', '\0', '20', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('42076c1f158442b5b6ebd997b95cc871', '可以退款', 'fa4c71c5e56a49a8a9bba90f11d0a9fa', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,fa4c71c5e56a49a8a9bba90f11d0a9fa,', '1', null, 'refund_operate_status_1', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('42e66048a6ff42a088997313bbbc711b', '团购卷使用状态', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'vucher_use_status', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('4345fe102a554cf0af155f6645fa9642', '教育-翻译', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '80', null, 'job_type_8', '\0', '80', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('43c66dd855b84a4489e40a05141472db', '区域类型', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '', null, 'sys_area_type', '\0', '0', '', '0', null, '', '3', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('447ab520a847456494b93a0a9f801ef2', '能源-化工', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '110', null, 'job_type_11', '\0', '110', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('4543f2ea56fb4ab8a234f59d68f8d54c', '是', '51a416cf4fc244478135680613221998', '0,1,28a368fdbbd44a7a99af28d01b12c089,51a416cf4fc244478135680613221998,', '0', null, 'is_toilet_0', '\0', '0', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('45633501bc274ed49ee35aef154c62c5', '200元', 'cf595f8ea0ff43d3a7c7c4ab25ea77d2', '0,1,b95893620a4a462490349148b9bfe1e7,cf595f8ea0ff43d3a7c7c4ab25ea77d2,', '200', null, 'station_voucher_money_200', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('4586c9de27fc4911809c472d66dea8e4', '企业认证状态', 'bede16c99d85416a834a6b3c664bbb9b', '0,1,bede16c99d85416a834a6b3c664bbb9b,', '', null, 'ep_company_verify_state', '\0', '0', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('45d64ceb5666460fa9c76b38c482335c', '优品夺宝短标题', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '11', null, 'app_type_11', '\0', '110', '个人中心优品夺宝短标题', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('46258708a2504dc0ad32deba28a9799e', '签约', '355f898402bf45f39934b60c8ab5818f', '0,1,28a368fdbbd44a7a99af28d01b12c089,355f898402bf45f39934b60c8ab5818f,', '1', null, 'cooperate_type_1', '\0', '10', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('46ebe32b9e7141ddbe3dac1de2d31d79', '团购券支付成功', '5271a93acd624e598ad658a577d37ebf', '0,1,28a368fdbbd44a7a99af28d01b12c089,5271a93acd624e598ad658a577d37ebf,', '100', null, 'consume_status_2', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('473a7a75518a41a48fe415e6cf67cf87', '新模式油站', 'f836643eb0754b1d84711435111e8234', '0,1,b95893620a4a462490349148b9bfe1e7,f836643eb0754b1d84711435111e8234,', '2', null, 'station_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('47a5e3b107294f318017dd336c9a8ad7', '分享评论内容', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '', null, 'comment_content_type', '\0', '88', '', '-2', null, '', '6', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('47ca009b782c4fffa467f1eeadf23906', '站内消息', 'a73c99c35bd84d5baea21549c05e9493', '0,1,5ea249bb780348eb8ea6a0efade684a6,a73c99c35bd84d5baea21549c05e9493,', '0', null, 'sys_message_type_0', '\0', '0', '', '0', null, '', '4', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('47e7e809935f45ff8363e6b3be79eded', '1000元', 'cf595f8ea0ff43d3a7c7c4ab25ea77d2', '0,1,b95893620a4a462490349148b9bfe1e7,cf595f8ea0ff43d3a7c7c4ab25ea77d2,', '1000', null, 'station_voucher_money_1000', '', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('48152c0e74b24290b771a16840d90b82', '银联支付费率', 'b655abdc4016444caa5bd758cbed81e6', '0,1,28a368fdbbd44a7a99af28d01b12c089,b655abdc4016444caa5bd758cbed81e6,', '0.008', null, 'union_pay_discount', '\0', '50', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('48b2d57436da46d685612ece2232e318', '其它行业', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '1000', null, 'job_type_100', '\0', '1000', '', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('48fc9f15c40c4484bb1011935a4c527e', '改变限额', '89b638c11f3f4a409a47ca932dcc4a21', '0,1,bede16c99d85416a834a6b3c664bbb9b,89b638c11f3f4a409a47ca932dcc4a21,', '2', null, 'quota_flowing_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('49986afae4964fc1a3f26dc21f8464c0', '活动赠送', '676ca81bfa9440018af3f15c17d7a1b6', '0,1,28a368fdbbd44a7a99af28d01b12c089,676ca81bfa9440018af3f15c17d7a1b6,', '7', null, 'score_type_7', '\0', '70', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('4a96222bc12746c9ae64c12ad5b6d162', '订单关闭', 'cd3935b5dd2a4ea89df6e60203367aa9', '0,1,28a368fdbbd44a7a99af28d01b12c089,cd3935b5dd2a4ea89df6e60203367aa9,', '3', null, 'commodity_order_status_3', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('4b83e314763746b3857335ee9ec26836', '业务参数', '1', '0,1,', '', null, '', '\0', '68', '', '0', null, '', '1', '1', '2017-03-27 15:17:05', '1', '2017-06-30 15:01:19');
INSERT INTO `sys_dict_t` VALUES ('4b8630e836de42fa9ff8d4b4156ec39a', '加气站', 'af9fa7257bde4f1b8a117723d28d94ee', '0,1,b95893620a4a462490349148b9bfe1e7,af9fa7257bde4f1b8a117723d28d94ee,', '2', null, 'station_genre_2', '\0', '20', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('4c1a841de04745c6b26cd5dfa132a933', '优惠券', '5de6bd42e9a248bd95a54254d651ea19', '0,1,28a368fdbbd44a7a99af28d01b12c089,5de6bd42e9a248bd95a54254d651ea19,', '1', null, 'discount_code_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('4c48895ca2754715ab127f387d556048', 'PUT', '0f77deaad18c48d4a1394093cd72f7f3', '0,1,5ea249bb780348eb8ea6a0efade684a6,0f77deaad18c48d4a1394093cd72f7f3,', 'PUT', null, 'sys_request_method_3', '', '90', '', '0', null, '', '0', '1', '2016-12-28 17:49:46', '1', '2016-12-28 17:55:18');
INSERT INTO `sys_dict_t` VALUES ('4ceb667fc75448b694ecce1a504a9694', '下班', '5779a04931394aafa6f69a1b11917cff', '0,1,28a368fdbbd44a7a99af28d01b12c089,5779a04931394aafa6f69a1b11917cff,', '1', null, 'guard_status_1', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('4d602044fd6d4b85acfcb1d0160673be', '类型', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', 'act_category', null, 'act_category', '\0', '0', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:29');
INSERT INTO `sys_dict_t` VALUES ('4e43ecdc9c30497e8b51d0d0fd2f25f8', '加油加气站', 'af9fa7257bde4f1b8a117723d28d94ee', '0,1,b95893620a4a462490349148b9bfe1e7,af9fa7257bde4f1b8a117723d28d94ee,', '3', null, 'station_genre_3', '\0', '30', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('4e7bef6fb878448abe91fe50afcf7c05', '生物-医疗', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '100', null, 'job_type_10', '\0', '100', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('4f120b96cb764d348a36c564328490b7', '油站最低消费', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '100', null, 'STATION_MIN_CONSUME', '\0', '22', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('4f7efb46030c4058814ef9ed1d01b5b8', '已关闭', '1ca59e473f0e48a9ab0591fa098e89f9', '0,1,28a368fdbbd44a7a99af28d01b12c089,1ca59e473f0e48a9ab0591fa098e89f9,', '-1', null, 'vucher_status_7', '', '70', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('4ff390ef18c74373a90cd511f563de91', '展现方式', 'faab4823cc8c4ddf89165fec5cac93af', '0,1,faab4823cc8c4ddf89165fec5cac93af,', '', null, 'cms_show_modes', '\0', '55', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('50664a812d6849d18ae438e884b3670d', '二级', '8040c72a95f541a49734bbe1c47547ca', '0,1,5ea249bb780348eb8ea6a0efade684a6,8040c72a95f541a49734bbe1c47547ca,', '2', null, 'sys_org_grade_2', '\0', '3', null, '0', null, '', '15', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('51594fc1aa1d4b14a8b00ad06e235f39', '失效', '36adfd803e3f4b48b6fa829c96b26959', '0,1,5ea249bb780348eb8ea6a0efade684a6,36adfd803e3f4b48b6fa829c96b26959,', '-1', null, 'sys_status_unable', '\0', '-2', '', '0', null, '', '13', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('5184fab7455a480c8cdfe39e33f88a89', '9个月', '8ba80468747d4fb18d5715354e8a813e', '0,1,28a368fdbbd44a7a99af28d01b12c089,8ba80468747d4fb18d5715354e8a813e,', '9', null, 'validity_date_9', '\0', '20', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('51a416cf4fc244478135680613221998', '是否有厕所', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'is_toilet', '\0', '0', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('5234af235c6045bf922531ced2097e42', '苹果注册', 'de535c516c4941f0805aff89af46fdff', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,de535c516c4941f0805aff89af46fdff,', '100', null, 'regist_type_3', '\0', '30', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('5271a93acd624e598ad658a577d37ebf', '消费记录状态', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'consume_status', '\0', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('52e80591e4434de9b8bc8e3d5bf2c394', '团购券销售类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'sale_type', '\0', '88', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('53b5d46e56144fee8897dd29e08193e2', '购油', '355f898402bf45f39934b60c8ab5818f', '0,1,28a368fdbbd44a7a99af28d01b12c089,355f898402bf45f39934b60c8ab5818f,', '2', null, 'cooperate_type_2', '\0', '20', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('546c60b125654f64b4635ace149c733d', '支付成功', '5271a93acd624e598ad658a577d37ebf', '0,1,28a368fdbbd44a7a99af28d01b12c089,5271a93acd624e598ad658a577d37ebf,', '200', null, 'consume_status_4', '\0', '99', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('556ed00c74d54e2da55d87da0217d9c9', '积分', '302d390aae3142e79bf0155aeb4768bb', '0,1,28a368fdbbd44a7a99af28d01b12c089,302d390aae3142e79bf0155aeb4768bb,', '6', null, 'pay_type_6', '\0', '60', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('56543e923cd14cd5a4f028e2d03cf43c', '微信支付费率', 'b655abdc4016444caa5bd758cbed81e6', '0,1,28a368fdbbd44a7a99af28d01b12c089,b655abdc4016444caa5bd758cbed81e6,', '0.006', null, 'wx_pay_discount', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('56a8a7bbe2d147f181fb144ecc48088c', '邀请优惠券', '86f3598178fb4f659480dfdab40f0613', '0,1,28a368fdbbd44a7a99af28d01b12c089,86f3598178fb4f659480dfdab40f0613,', '2', null, 'voucher_discount_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('56b066d2c4fb49358d7dc044d5370e6f', '年龄类型', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'age_type', '\0', '456', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('56d101a2ee3c437da39e8414ce115049', '团购券', '5de6bd42e9a248bd95a54254d651ea19', '0,1,28a368fdbbd44a7a99af28d01b12c089,5de6bd42e9a248bd95a54254d651ea19,', '2', null, 'discount_code_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('5779a04931394aafa6f69a1b11917cff', '在岗状态', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'guard_status', '\0', '60', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('580f51d4b05c4077a3f1d7753a5fab66', '创建订单', 'cd3935b5dd2a4ea89df6e60203367aa9', '0,1,28a368fdbbd44a7a99af28d01b12c089,cd3935b5dd2a4ea89df6e60203367aa9,', '0', null, 'commodity_order_status_0', '\0', '10', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('581cffc74c554a5fa012a39a2771d331', '积分兑换', 'b084821826c3485fbbb9a590ae470809', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,b084821826c3485fbbb9a590ae470809,', '3', null, 'app_operate_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('594e00eb4366445cb5c27a414ff28cba', '菜单模块', '2d778a9832084c4ba246d1b042e9b4ea', '0,1,5ea249bb780348eb8ea6a0efade684a6,2d778a9832084c4ba246d1b042e9b4ea,', '1', null, 'sys_module_type_1', '', '0', '', '0', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 16:49:41');
INSERT INTO `sys_dict_t` VALUES ('59812c29295047a090d7b754f9f8403f', '期数奖号基数', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '1000000', null, 'COMMODITY_PRAISE_BASE_NUMBER', '\0', '80', '', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('59aa45da26054a51a972d5c66c3cd70c', '中国石化', '8473ea94776e45fdbb758257e4054fae', '0,1,bede16c99d85416a834a6b3c664bbb9b,8473ea94776e45fdbb758257e4054fae,', '2', null, 'ep_role_station_company_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('5a5bbb83ffd441008c001083e7d487ac', '分类1', '4d602044fd6d4b85acfcb1d0160673be', '0,1,5ea249bb780348eb8ea6a0efade684a6,4d602044fd6d4b85acfcb1d0160673be,', '1', null, 'act_category_1', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:29');
INSERT INTO `sys_dict_t` VALUES ('5ac182c87c054258aa18c4c8fd6bce84', '订单生成', '6735318ecfc84075a475a464297963b4', '0,1,28a368fdbbd44a7a99af28d01b12c089,6735318ecfc84075a475a464297963b4,', '1', null, 'bank_status_new', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('5ae1fcfe7843406983cfb3bbddaa3497', '普通管理员', 'f144d350f02f457c8ce90588c7d67c77', '0,1,bede16c99d85416a834a6b3c664bbb9b,f144d350f02f457c8ce90588c7d67c77,', '1', null, 'ep_role_type_1', '\0', '10', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('5b00f1461e704ddd9d6c0443922ff60c', '金融类', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '5', null, 'job_type_5', '\0', '50', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('5b4d3b14664144c7977e10d725979a2b', '默认主题', '192b728ede9b4c33ae963a52175e4a93', '0,1,5ea249bb780348eb8ea6a0efade684a6,192b728ede9b4c33ae963a52175e4a93,', 'default', null, 'default', '\0', '100', '', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:47:08');
INSERT INTO `sys_dict_t` VALUES ('5b63d78a434e405bba7b19d882d5d802', '分享优惠注册', 'de535c516c4941f0805aff89af46fdff', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,de535c516c4941f0805aff89af46fdff,', '400', null, 'regist_type_5', '\0', '50', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('5b9742fc0acd4a108b2ab661dc85269c', '所有数据', 'aec4a6b7cfd6475ea0d97714c13003fe', '0,1,5ea249bb780348eb8ea6a0efade684a6,aec4a6b7cfd6475ea0d97714c13003fe,', '1', null, 'sys_role_scope_1', '\0', '50', '', '0', null, '', '5', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('5bf7ed84fb6c4fbb882559f2a17124b1', '黄金期货', 'c9a70cf00c8e42b2b6d8eb475d133d57', '0,1,28a368fdbbd44a7a99af28d01b12c089,c9a70cf00c8e42b2b6d8eb475d133d57,', '4', null, 'exchange_type_4', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('5c2fbf9516124d90bf6c87b670348231', '活动赠送', '86f3598178fb4f659480dfdab40f0613', '0,1,28a368fdbbd44a7a99af28d01b12c089,86f3598178fb4f659480dfdab40f0613,', '8', null, 'voucher_discount_type_8', '\0', '80', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('5c64f8161d6549f8bcbfccc5c8c9ec45', '分享有礼', 'b084821826c3485fbbb9a590ae470809', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,b084821826c3485fbbb9a590ae470809,', '6', null, 'app_operate_type_6', '\0', '60', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('5cef76222e4541c79c5c82cf2b52d1f1', '90号', '6a6391af2d82453c8e13bbebdf448249', '0,1,28a368fdbbd44a7a99af28d01b12c089,6a6391af2d82453c8e13bbebdf448249,', '1', null, 'oil_type_1', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('5cf1ea18ddb1476186708894de24078b', '一键支付', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '1', null, 'notice_page_type_1', '\0', '10', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('5de6bd42e9a248bd95a54254d651ea19', '红包类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'discount_code_type', '\0', '46', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('5e55f699515244929448392bd5798af4', '航油加油站', 'b1210659ed0f459eae1dfebad40f8001', '0,1,28a368fdbbd44a7a99af28d01b12c089,b1210659ed0f459eae1dfebad40f8001,', '1', null, 'bank_station_type_aviation', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('5ea249bb780348eb8ea6a0efade684a6', '系统参数', '1', '0,1,', '', null, 'sys', '\0', '8', '', '0', null, '', '13', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('5ef02d3fba1b468d8897e16732e6ec0e', '首页弹窗广告', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '12', null, 'app_type_12', '', '120', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('5ef8ac538c39499892e1af9bfe06bbfe', '70后', '56b066d2c4fb49358d7dc044d5370e6f', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,56b066d2c4fb49358d7dc044d5370e6f,', '3', null, 'age_type_3', '\0', '30', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('5fb1e881d64e48aba0d80b784f797a49', '全部油站', 'b30f3c0b94b1418c8ba11a8fbb77a918', '0,1,b95893620a4a462490349148b9bfe1e7,b30f3c0b94b1418c8ba11a8fbb77a918,', '2', null, 'station_send_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('5fca082c172b4231902e3ddb4fd34e01', '支付成功', 'cd3935b5dd2a4ea89df6e60203367aa9', '0,1,28a368fdbbd44a7a99af28d01b12c089,cd3935b5dd2a4ea89df6e60203367aa9,', '1', null, 'commodity_order_status_1', '\0', '20', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('61eb6ddfa0824ac495db5f1f7281ca39', '客户端类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'client_type', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('62556154ffd64dceb9e0b8f93313bd6a', '社会加油站', 'b1210659ed0f459eae1dfebad40f8001', '0,1,28a368fdbbd44a7a99af28d01b12c089,b1210659ed0f459eae1dfebad40f8001,', '2', null, 'bank_station_type_social', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('627cfe8ea0ce40e79bbd65e0529f143b', '团购评论', 'e1dafc74ec424ca7bbe2f1d8913c7cfb', '0,1,28a368fdbbd44a7a99af28d01b12c089,e1dafc74ec424ca7bbe2f1d8913c7cfb,', '0', null, 'comment_type_0', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('640537def76740f5872298c0e1935c70', 'DELETE', '0f77deaad18c48d4a1394093cd72f7f3', '0,1,5ea249bb780348eb8ea6a0efade684a6,0f77deaad18c48d4a1394093cd72f7f3,', 'DELETE', null, 'sys_request_method_4', '', '120', '', '0', null, '', '0', '1', '2016-12-29 09:39:55', '1', '2016-12-29 09:39:55');
INSERT INTO `sys_dict_t` VALUES ('662789515c2f4c3bac817622f1a7949f', '国家', '43c66dd855b84a4489e40a05141472db', '0,1,5ea249bb780348eb8ea6a0efade684a6,43c66dd855b84a4489e40a05141472db,', '0', null, 'sys_area_type_1', '\0', '1', '', '0', null, '', '5', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('665147d58e504675af027627ef2e4a0b', '创建订单', '5271a93acd624e598ad658a577d37ebf', '0,1,28a368fdbbd44a7a99af28d01b12c089,5271a93acd624e598ad658a577d37ebf,', '0', null, 'consume_status_0', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('66cd941b60154c46ae0311f889cfcc8d', '0#', '6a6391af2d82453c8e13bbebdf448249', '0,1,28a368fdbbd44a7a99af28d01b12c089,6a6391af2d82453c8e13bbebdf448249,', '5', null, 'oil_type_5', '', '50', '元/升', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('6735318ecfc84075a475a464297963b4', '银行订单状态', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'bank_status', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('676ca81bfa9440018af3f15c17d7a1b6', '积分类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'score_type', '\0', '99', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('679e0dcae9914e629d42733525aac8fd', '消费分享优惠券', '86f3598178fb4f659480dfdab40f0613', '0,1,28a368fdbbd44a7a99af28d01b12c089,86f3598178fb4f659480dfdab40f0613,', '5', null, 'voucher_discount_type_5', '\0', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('68b39ac1cc624549a3d8ebd8d4cc6274', '栏目页文章推荐', 'ac531aa386174308935cfea881685fe4', '0,1,faab4823cc8c4ddf89165fec5cac93af,ac531aa386174308935cfea881685fe4,', '2', null, 'cms_posid_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('68dd094a80a4442ea08d0ab65de13156', '初始超级管理员', 'f144d350f02f457c8ce90588c7d67c77', '0,1,bede16c99d85416a834a6b3c664bbb9b,f144d350f02f457c8ce90588c7d67c77,', '3', null, 'ep_role_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('691f3aaeb1c74f0a94bd24c216bf4a3a', '95#(97#)', '6a6391af2d82453c8e13bbebdf448249', '0,1,28a368fdbbd44a7a99af28d01b12c089,6a6391af2d82453c8e13bbebdf448249,', '3', null, 'oil_type_3', '', '30', '元/升', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('6a6391af2d82453c8e13bbebdf448249', '汽油类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'oil_type', '\0', '10', '', '-2', null, '', '17', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('6ad48b59da874704a95d0d412a10053e', '微信订单生成', '5271a93acd624e598ad658a577d37ebf', '0,1,28a368fdbbd44a7a99af28d01b12c089,5271a93acd624e598ad658a577d37ebf,', '10', null, 'consume_status_1', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('6b6cd8ba1a3c40d4aeb1fc50abe6ac18', '绑卡优惠券', '86f3598178fb4f659480dfdab40f0613', '0,1,28a368fdbbd44a7a99af28d01b12c089,86f3598178fb4f659480dfdab40f0613,', '7', null, 'voucher_discount_type_7', '\0', '70', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('6b7d319001fe41f485556d4230153aa7', '暂停营业', 'edfa4d6478d9429d8474c4bc9f687dbe', '0,1,b95893620a4a462490349148b9bfe1e7,edfa4d6478d9429d8474c4bc9f687dbe,', '2', null, 'station_cooperate_2', '\0', '30', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('6c1f5d4774d84ae3a89045e9f12ec5eb', '离线', '8b5fc2a625d242e5a30576f1e0fc0364', '0,1,4b83e314763746b3857335ee9ec26836,8b5fc2a625d242e5a30576f1e0fc0364,', '1', null, 'online_status_1', '', '90', '', '0', null, '', '1', '1', '2017-03-27 15:20:26', '1', '2017-06-30 15:01:19');
INSERT INTO `sys_dict_t` VALUES ('6df80357797e48f184de7038a05e0252', '是', 'b69b14b96942405ea4eaf2030b08c531', '0,1,28a368fdbbd44a7a99af28d01b12c089,b69b14b96942405ea4eaf2030b08c531,', '0', null, 'is_wash_car_0', '\0', '0', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('6e503d93c7614badb36865cf2d8fd8ab', '兑换众筹商品失败', '676ca81bfa9440018af3f15c17d7a1b6', '0,1,28a368fdbbd44a7a99af28d01b12c089,676ca81bfa9440018af3f15c17d7a1b6,', '6', null, 'score_type_6', '\0', '60', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('6f0a1e3d1ab445c5b2a5244d1c1f3638', '已失效', '09ce53d380d0410eb4ef94fc3e380e95', '0,1,28a368fdbbd44a7a99af28d01b12c089,09ce53d380d0410eb4ef94fc3e380e95,', '4', null, 'period_type_4', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('702ba1c2cb0a401f878ba4dfc98c3865', '余额支付', 'ff7144c53f2d4839b1e22048b53cdc69', '0,1,bede16c99d85416a834a6b3c664bbb9b,ff7144c53f2d4839b1e22048b53cdc69,', '1', null, 'user_consume_company_type_1', '\0', '10', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('719820cdf0db4d0f8219163216d8f288', '申通', 'e5ad79055bfd41ddaf9cd9e2be127ae0', '0,1,28a368fdbbd44a7a99af28d01b12c089,e5ad79055bfd41ddaf9cd9e2be127ae0,', '2', null, 'express_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('71aff74ac1704005b6bbc33cd63fe640', '饮料', '951c185957794748a6a880ad28e0e8f9', '0,1,b95893620a4a462490349148b9bfe1e7,951c185957794748a6a880ad28e0e8f9,', '1', null, 'gas_commodity_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('7426775094ff466c85ae945f715f8367', '职业类型', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'job_type', '\0', '44', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('7444978d2ed64c6fada89b8fb8c77555', '团购支付页面', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '9', null, 'notice_page_type_9', '\0', '90', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('74f6376829c54419b89ea3d37260f29e', '区县', '43c66dd855b84a4489e40a05141472db', '0,1,5ea249bb780348eb8ea6a0efade684a6,43c66dd855b84a4489e40a05141472db,', '3', null, 'sys_area_type_4', '\0', '40', '', '0', null, '', '5', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('75647fa224384d768a3adaaa8c94d394', '中国邮政储汇局', 'ed8014b466d1419d9b26171248460894', '0,1,28a368fdbbd44a7a99af28d01b12c089,ed8014b466d1419d9b26171248460894,', '07', null, 'bank_type_youzheng', '\0', '70', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('78a0b6ca574c48b4a82dbdfe1a458511', '限量发行', '52e80591e4434de9b8bc8e3d5bf2c394', '0,1,b95893620a4a462490349148b9bfe1e7,52e80591e4434de9b8bc8e3d5bf2c394,', '2', null, 'sale_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('78a4d0ffe52b4f578a537e4caad02efc', '微信注册', 'de535c516c4941f0805aff89af46fdff', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,de535c516c4941f0805aff89af46fdff,', '1', null, 'regist_type_1', '\0', '10', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('7932fdf044ca44b795cf3dafeca0a218', '团购券详情', 'b084821826c3485fbbb9a590ae470809', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,b084821826c3485fbbb9a590ae470809,', '7', null, 'app_operate_type_7', '\0', '70', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('7a265834873548e797578f2f79bebe1d', '隐藏', '2a41ef6aa47b40a5b15c899be205e0f1', '0,1,5ea249bb780348eb8ea6a0efade684a6,2a41ef6aa47b40a5b15c899be205e0f1,', '1', null, 'show_hide_1', '\0', '20', '', '0', null, '', '2', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('7a4c9a3ee0a74f0d932212defdd9b27d', '部门', '8725bc528472472cae9cd79d8a3526f7', '0,1,5ea249bb780348eb8ea6a0efade684a6,8725bc528472472cae9cd79d8a3526f7,', '2', null, 'sys_org_type_2', '\0', '20', '', '0', null, '', '2', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('7ad6ecea872a42cc8ebb4d71488902d6', 'IC卡流水类型', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'ic_card_type', '\0', '88', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('7bf1552139fc42b69864d701d915ea13', '系统操作', '676ca81bfa9440018af3f15c17d7a1b6', '0,1,28a368fdbbd44a7a99af28d01b12c089,676ca81bfa9440018af3f15c17d7a1b6,', '9', null, 'score_type_9', '\0', '90', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('7d0e732438ee48a0b2d95c961e672d0f', '2000元', 'cf595f8ea0ff43d3a7c7c4ab25ea77d2', '0,1,b95893620a4a462490349148b9bfe1e7,cf595f8ea0ff43d3a7c7c4ab25ea77d2,', '2000', null, 'station_voucher_money_2000', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('7ebeb9ed12104d3f8828455002ecd466', '90后', '56b066d2c4fb49358d7dc044d5370e6f', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,56b066d2c4fb49358d7dc044d5370e6f,', '1', null, 'age_type_1', '\0', '10', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('7f51aaef298a4d24b4d3d993caa9a09f', 'ERROR', 'cf92bd9bc2a64ac9a37776f3ec8cce24', '0,1,5ea249bb780348eb8ea6a0efade684a6,cf92bd9bc2a64ac9a37776f3ec8cce24,', 'ERROR', null, 'sys_log_level_error', '', '150', '', '0', null, '', '0', '1', '2017-01-03 15:04:22', '1', '2017-01-03 15:04:22');
INSERT INTO `sys_dict_t` VALUES ('8039ff42992840e191657f79c4446c5c', '等待揭晓', '09ce53d380d0410eb4ef94fc3e380e95', '0,1,28a368fdbbd44a7a99af28d01b12c089,09ce53d380d0410eb4ef94fc3e380e95,', '2', null, 'period_type_2', '\0', '20', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('8040c72a95f541a49734bbe1c47547ca', '机构等级', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '', null, 'sys_org_grade', '\0', '10', null, '0', null, '', '12', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('80dcac9baced499580380a249e4c2e6c', 'POST', '0f77deaad18c48d4a1394093cd72f7f3', '0,1,5ea249bb780348eb8ea6a0efade684a6,0f77deaad18c48d4a1394093cd72f7f3,', 'POST', null, 'sys_request_method_2', '', '60', '', '0', null, '', '0', '1', '2016-12-28 17:49:25', '1', '2016-12-28 17:49:25');
INSERT INTO `sys_dict_t` VALUES ('810661c884cf4060aa09206fb169c287', '栏目第一条内容', '4ff390ef18c74373a90cd511f563de91', '0,1,faab4823cc8c4ddf89165fec5cac93af,4ff390ef18c74373a90cd511f563de91,', '2', null, 'cms_show_modes_2', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('81a6dc7a6ea94c89a3a42a42870ac52d', '自主加油', 'd731fd771daf48d0a75e6593f4123e32', '0,1,b95893620a4a462490349148b9bfe1e7,d731fd771daf48d0a75e6593f4123e32,', '2', null, 'refuel_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('81dce14413194f61a57b276c587bf784', '菜单模块', 'fe104789ebbd41c5983984beb634705f', '0,1,5ea249bb780348eb8ea6a0efade684a6,fe104789ebbd41c5983984beb634705f,', '0', null, 'sys_module_flag_0', '\0', '0', null, '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:42');
INSERT INTO `sys_dict_t` VALUES ('824cc22434e0446d9070f66da0e52f1c', '人工消息', '381273cbfa814474a83b48da49b46c17', '0,1,b95893620a4a462490349148b9bfe1e7,381273cbfa814474a83b48da49b46c17,', '2', null, 'station_reveive_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('82bcde93ebec45caa80f43ff5dfec9a5', '系统运行常量', '1', '0,1,', '', null, 'sys_run_constants', '\0', '88', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:04');
INSERT INTO `sys_dict_t` VALUES ('8305cfa2b53e4bb0ba73b4591122e868', '天蓝主题', '192b728ede9b4c33ae963a52175e4a93', '0,1,5ea249bb780348eb8ea6a0efade684a6,192b728ede9b4c33ae963a52175e4a93,', 'cerulean', null, 'cerulean', '\0', '90', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:47:08');
INSERT INTO `sys_dict_t` VALUES ('8346319e10b24ac89d9919d6dd2f7224', '正常', '42e66048a6ff42a088997313bbbc711b', '0,1,28a368fdbbd44a7a99af28d01b12c089,42e66048a6ff42a088997313bbbc711b,', '1', null, 'vucher_use_status_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('845be46e64984d68aa2e953de48f7194', '已过期', '1ca59e473f0e48a9ab0591fa098e89f9', '0,1,28a368fdbbd44a7a99af28d01b12c089,1ca59e473f0e48a9ab0591fa098e89f9,', '200', null, 'vucher_status_4', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('8473ea94776e45fdbb758257e4054fae', '限制油站公司', 'bede16c99d85416a834a6b3c664bbb9b', '0,1,bede16c99d85416a834a6b3c664bbb9b,', '', null, 'ep_role_station_company', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('857efc4a11844315aec9ace0d2a75206', '留言板分类', 'faab4823cc8c4ddf89165fec5cac93af', '0,1,faab4823cc8c4ddf89165fec5cac93af,', '', null, 'cms_guestbook', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('86f3598178fb4f659480dfdab40f0613', '优惠券来源类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'voucher_discount_type', '\0', '44', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('871970c6c0e84d938feecb1347b0b04b', '建议', '857efc4a11844315aec9ace0d2a75206', '0,1,faab4823cc8c4ddf89165fec5cac93af,857efc4a11844315aec9ace0d2a75206,', '2', null, 'cms_guestbook_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('8725bc528472472cae9cd79d8a3526f7', '机构类型', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '', null, 'sys_org_type', '\0', '0', null, '0', null, '', '7', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('872efd6913ea4d0c9c388b8414c2d1d0', '优惠比例支付', 'ff7144c53f2d4839b1e22048b53cdc69', '0,1,bede16c99d85416a834a6b3c664bbb9b,ff7144c53f2d4839b1e22048b53cdc69,', '2', null, 'user_consume_company_type_2', '\0', '20', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('8897e46e05e9458a85d437fcc08321be', 'Brent', 'c9a70cf00c8e42b2b6d8eb475d133d57', '0,1,28a368fdbbd44a7a99af28d01b12c089,c9a70cf00c8e42b2b6d8eb475d133d57,', '2', null, 'exchange_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('895cf84643544f82bd7db1894910c2c8', '正在审核中', '4586c9de27fc4911809c472d66dea8e4', '0,1,bede16c99d85416a834a6b3c664bbb9b,4586c9de27fc4911809c472d66dea8e4,', '2', null, 'ep_company_verify_state_2', '\0', '2', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('89b638c11f3f4a409a47ca932dcc4a21', '限额流水改变类型', 'bede16c99d85416a834a6b3c664bbb9b', '0,1,bede16c99d85416a834a6b3c664bbb9b,', '', null, 'quota_flowing_type', '\0', '88', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('8ac435fd40a945e797dd44026c96a8f8', '系统消息', '381273cbfa814474a83b48da49b46c17', '0,1,b95893620a4a462490349148b9bfe1e7,381273cbfa814474a83b48da49b46c17,', '1', null, 'station_reveive_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('8b5fc2a625d242e5a30576f1e0fc0364', '在线状态', '4b83e314763746b3857335ee9ec26836', '0,1,4b83e314763746b3857335ee9ec26836,', '', '', 'online_status', '\0', '30', '', '0', null, '', '1', '1', '2017-03-27 15:17:44', '1', '2017-06-30 15:01:19');
INSERT INTO `sys_dict_t` VALUES ('8b8e2843dfc74be18a461cf1ac9e0b6b', 'IC卡优惠', 'a4cf48c7f1ba469ca347c5bd19e87d6f', '0,1,b95893620a4a462490349148b9bfe1e7,a4cf48c7f1ba469ca347c5bd19e87d6f,', '1', null, 'oil_save_type_1', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('8ba80468747d4fb18d5715354e8a813e', '有效期', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'validity_date', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('8bdd953f56864f4aa660e465b93329a9', '待使用', '1ca59e473f0e48a9ab0591fa098e89f9', '0,1,28a368fdbbd44a7a99af28d01b12c089,1ca59e473f0e48a9ab0591fa098e89f9,', '10', null, 'vucher_status_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('8c5e16650dc947cea2fb591336cb8ecf', '已过期', '42e66048a6ff42a088997313bbbc711b', '0,1,28a368fdbbd44a7a99af28d01b12c089,42e66048a6ff42a088997313bbbc711b,', '2', null, 'vucher_use_status_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('8ddb0c7628314275b52f4af5054a8118', '中国石油', '8473ea94776e45fdbb758257e4054fae', '0,1,bede16c99d85416a834a6b3c664bbb9b,8473ea94776e45fdbb758257e4054fae,', '1', null, 'ep_role_station_company_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('8de4dd7c03e647bb86f71ffc97930e2d', '客户群组优惠', 'a4cf48c7f1ba469ca347c5bd19e87d6f', '0,1,b95893620a4a462490349148b9bfe1e7,a4cf48c7f1ba469ca347c5bd19e87d6f,', '2', null, 'oil_save_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('8f08f83157a34161868f83c33ce92a8c', '充值签约', '28d335463d1f426aa80700d817ae427b', '0,1,bede16c99d85416a834a6b3c664bbb9b,28d335463d1f426aa80700d817ae427b,', '1', null, 'contract_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('8f914a54eef54792b900032864f43dad', '退款状态', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'refund_status', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('907f99d77043435aa107fbc97d61d9b8', '充值', 'c28d29b56b2a415e949ecd27431f6f63', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,c28d29b56b2a415e949ecd27431f6f63,', '1', null, 'account_change_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('91eac669f4f04cccb0b95a2a2435d708', '订单生成且团购券支付成功', '5271a93acd624e598ad658a577d37ebf', '0,1,28a368fdbbd44a7a99af28d01b12c089,5271a93acd624e598ad658a577d37ebf,', '110', null, 'consume_status_3', '\0', '50', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('9274dd2c76b94e51972e8b439e036eb2', '登录状态', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '', null, 'sys_login_status', '\0', '0', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:36');
INSERT INTO `sys_dict_t` VALUES ('92e1d75ce777433c80820c6c17cbdc77', '优惠券', '302d390aae3142e79bf0155aeb4768bb', '0,1,28a368fdbbd44a7a99af28d01b12c089,302d390aae3142e79bf0155aeb4768bb,', '5', null, 'pay_type_5', '\0', '50', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('933ef87b6ef3414ab9806a186bf9f7d4', '指定用户', '99fd51a62c8e4a799f56128826fc1922', '0,1,28a368fdbbd44a7a99af28d01b12c089,99fd51a62c8e4a799f56128826fc1922,', '1', null, 'client_msg_type_1', '\0', '20', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('934c0c8fdf264b048b9b62479d1bb4f4', '女', '9b1ff3c6b65943a8bfa4d91cb1b55933', '0,1,28a368fdbbd44a7a99af28d01b12c089,9b1ff3c6b65943a8bfa4d91cb1b55933,', '2', null, 'sex_type_2', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('934fa4e90eaf46b0ae2cfd32529c5fe1', '夺宝商品详情', 'b084821826c3485fbbb9a590ae470809', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,b084821826c3485fbbb9a590ae470809,', '2', null, 'app_operate_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('935bde10c5474c9db2ec30a82bf631af', '加油消费', 'c28d29b56b2a415e949ecd27431f6f63', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,c28d29b56b2a415e949ecd27431f6f63,', '2', null, 'account_change_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('9374ddf0e82f4decaef27d0b9a67ef67', '农村合作银行24', 'ed8014b466d1419d9b26171248460894', '0,1,28a368fdbbd44a7a99af28d01b12c089,ed8014b466d1419d9b26171248460894,', '24', null, 'bank_type_hezuo', '\0', '90', '农村合作银行24,', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('93c59da907ce47409d1b4be838431588', '文章模型', 'b490c72630aa4c25af8d7b9ae063a483', '0,1,faab4823cc8c4ddf89165fec5cac93af,b490c72630aa4c25af8d7b9ae063a483,', 'article', null, 'cms_module_article', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('93c9c524d3d84a6ca0ee7dcc6ee9c227', '男', '9b1ff3c6b65943a8bfa4d91cb1b55933', '0,1,28a368fdbbd44a7a99af28d01b12c089,9b1ff3c6b65943a8bfa4d91cb1b55933,', '1', null, 'sex_type_1', '\0', '0', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('943a3aa818614527a077f7f1fb53f8fd', '地市', '43c66dd855b84a4489e40a05141472db', '0,1,5ea249bb780348eb8ea6a0efade684a6,43c66dd855b84a4489e40a05141472db,', '2', null, 'sys_area_type_3', '\0', '30', '', '0', null, '', '5', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('951c185957794748a6a880ad28e0e8f9', '非油品商品类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'gas_commodity_type', '\0', '10', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('96b29d600de54919ac56ec43a6e9500f', '银联', '302d390aae3142e79bf0155aeb4768bb', '0,1,28a368fdbbd44a7a99af28d01b12c089,302d390aae3142e79bf0155aeb4768bb,', '3', null, 'pay_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('971ded6966774a87b82b39148bc38d9d', '亲爱的顾客，感谢您对{0}的支持，我们会将服务做到最好。', '087cf2856c334d95937e641a7a6d798d', '0,1,b95893620a4a462490349148b9bfe1e7,087cf2856c334d95937e641a7a6d798d,', '亲爱的顾客，感谢您对{0}的支持，我们会将服务做到最好。', null, 'content_type_2', '\0', '20', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('97f1b5ad8a5a4d10a72693247c9187d9', '显示', '2a41ef6aa47b40a5b15c899be205e0f1', '0,1,5ea249bb780348eb8ea6a0efade684a6,2a41ef6aa47b40a5b15c899be205e0f1,', '0', null, 'show_hide_0', '\0', '10', '', '0', null, '', '2', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('97fc835ca66e4330901dc0440d0cc4a4', '指定油站', 'b30f3c0b94b1418c8ba11a8fbb77a918', '0,1,b95893620a4a462490349148b9bfe1e7,b30f3c0b94b1418c8ba11a8fbb77a918,', '1', null, 'station_send_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('987185b92f944d4284727a67eadbe171', '中国人民银行', 'ed8014b466d1419d9b26171248460894', '0,1,28a368fdbbd44a7a99af28d01b12c089,ed8014b466d1419d9b26171248460894,', '01', null, 'bank_type_renmin', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('9886aba3bed1431aa43f0ef03aec845c', '未提交过审核', '4586c9de27fc4911809c472d66dea8e4', '0,1,bede16c99d85416a834a6b3c664bbb9b,4586c9de27fc4911809c472d66dea8e4,', '0', null, 'ep_company_verify_state_0', '\0', '0', '', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('99b822196bd44ec1b8b40daa03e19ded', '0.01元团购券', 'cf595f8ea0ff43d3a7c7c4ab25ea77d2', '0,1,b95893620a4a462490349148b9bfe1e7,cf595f8ea0ff43d3a7c7c4ab25ea77d2,', '0.01', null, 'station_voucher_money_0.01', '', '80', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('99fd51a62c8e4a799f56128826fc1922', '推送消息类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'client_msg_type', '\0', '20', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('9a68b88d9d1542528761684536932fc8', '已处理', 'c2b4aadd1c184dcbbab22fa9785e09c2', '0,1,5ea249bb780348eb8ea6a0efade684a6,c2b4aadd1c184dcbbab22fa9785e09c2,', '1', null, 'sys_message_status_1', '\0', '0', '', '0', null, '', '4', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('9b1ff3c6b65943a8bfa4d91cb1b55933', '性别', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'sex_type', '\0', '99', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('9b893f22d03e4830b0ddee3ea6085194', '油价类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'price_type', '\0', '44', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('9bda873df80d410abc92a841bb94e256', '全部用户', '99fd51a62c8e4a799f56128826fc1922', '0,1,28a368fdbbd44a7a99af28d01b12c089,99fd51a62c8e4a799f56128826fc1922,', '0', null, 'client_msg_type_0', '\0', '10', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('9c61eacf3e0e4eb594ea334e827c2bd2', '咨询', '857efc4a11844315aec9ace0d2a75206', '0,1,faab4823cc8c4ddf89165fec5cac93af,857efc4a11844315aec9ace0d2a75206,', '1', null, 'cms_guestbook_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('9dda518fc93542fe9fdb1e5fa6fa99f0', '消费券支付成功', '5271a93acd624e598ad658a577d37ebf', '0,1,28a368fdbbd44a7a99af28d01b12c089,5271a93acd624e598ad658a577d37ebf,', '300', null, 'consume_status_5', '\0', '111', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('9e27558d0f484bdca6c5f3acf01678e5', '团购券', '302d390aae3142e79bf0155aeb4768bb', '0,1,28a368fdbbd44a7a99af28d01b12c089,302d390aae3142e79bf0155aeb4768bb,', '4', null, 'pay_type_4', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('9f1abb87a5794dbbad9cae9c4dd8bc87', '订单关闭', '5271a93acd624e598ad658a577d37ebf', '0,1,28a368fdbbd44a7a99af28d01b12c089,5271a93acd624e598ad658a577d37ebf,', '-1', null, 'consume_status_-1', '\0', '5', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('9f97ee5c7c634bc5801aade48de17787', '角色类型', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '0', null, 'sys_role_type', '\0', '0', '', '-2', null, '', '6', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('a0d3943b46154244bfeb0bee9b59ab38', '系统常量', '1', '0,1,', '', null, 'constant', '\0', '12', '', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('a1a29b87c3534df2832c63b3b54402ca', '油站优惠最低消费', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '150', null, 'STATION_MIN_DISCOUNT_CONSUME', '\0', '33', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('a2342691fab9459aa1ba866d7d354b1e', '优品加油财务电话', '39f49944671841f090195db52eb6e03f', '0,1,28a368fdbbd44a7a99af28d01b12c089,39f49944671841f090195db52eb6e03f,', '400-005-8905', null, 'merchant_financial_contact', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('a284c1180d7144c886a488d9e7884f64', '老模式', '2bf3cf6cc6bf46f8a077ed59d710ae86', '0,1,b95893620a4a462490349148b9bfe1e7,2bf3cf6cc6bf46f8a077ed59d710ae86,', '1', null, 'mode_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('a2c144b349d644a5b4866c3856120924', '进行中', '09ce53d380d0410eb4ef94fc3e380e95', '0,1,28a368fdbbd44a7a99af28d01b12c089,09ce53d380d0410eb4ef94fc3e380e95,', '1', null, 'period_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('a35b86dadd8744c4b8db1873725fe886', 'DEBUG', 'cf92bd9bc2a64ac9a37776f3ec8cce24', '0,1,5ea249bb780348eb8ea6a0efade684a6,cf92bd9bc2a64ac9a37776f3ec8cce24,', 'DEBUG', null, 'sys_log_level_debug', '', '0', '', '0', null, '', '5', '', '2016-12-05 11:31:22', '1', '2017-01-03 15:03:28');
INSERT INTO `sys_dict_t` VALUES ('a4cf48c7f1ba469ca347c5bd19e87d6f', '优惠来源类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'oil_save_type', '\0', '99', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('a73c99c35bd84d5baea21549c05e9493', '消息类型', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '0', null, 'sys_message_type', '\0', '0', '', '0', null, '', '3', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('a76e92df76434174bd4b51e3ff1e49c9', '团购退款原因', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'user_voucher_refund_type', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('a83bbdd9168f4864a527dfe1fe95d1a3', '公司', '8725bc528472472cae9cd79d8a3526f7', '0,1,5ea249bb780348eb8ea6a0efade684a6,8725bc528472472cae9cd79d8a3526f7,', '1', null, 'sys_org_type_1', '\0', '0', '', '0', null, '', '4', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('a848f8a1f9b44d3589d7a33c2157f3f7', '已认证', '4586c9de27fc4911809c472d66dea8e4', '0,1,bede16c99d85416a834a6b3c664bbb9b,4586c9de27fc4911809c472d66dea8e4,', '1', null, 'ep_company_verify_state_1', '\0', '1', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('a8763eace40749d998192d74059745c8', '已使用', '1ca59e473f0e48a9ab0591fa098e89f9', '0,1,28a368fdbbd44a7a99af28d01b12c089,1ca59e473f0e48a9ab0591fa098e89f9,', '100', null, 'vucher_status_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('a89fdc0d14cd4593b2262bf47bd23b2a', '百世汇通', 'e5ad79055bfd41ddaf9cd9e2be127ae0', '0,1,28a368fdbbd44a7a99af28d01b12c089,e5ad79055bfd41ddaf9cd9e2be127ae0,', '5', null, 'express_type_5', '\0', '5', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('a9504057b6634939affeeccf440e575d', '中国海油', '8473ea94776e45fdbb758257e4054fae', '0,1,bede16c99d85416a834a6b3c664bbb9b,8473ea94776e45fdbb758257e4054fae,', '3', null, 'ep_role_station_company_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('aa398949a4e24f15a9da928b1824ddc6', '积分众筹兑换基数', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '100', null, 'COMMODITY_PERIOD_EXCHANGE_SCORE', '\0', '15', '', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('aac24fd3928f4daa8ff865b2a1804a7e', '链接模型', 'b490c72630aa4c25af8d7b9ae063a483', '0,1,faab4823cc8c4ddf89165fec5cac93af,b490c72630aa4c25af8d7b9ae063a483,', 'link', null, 'cms_module_link', '\0', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('aada851c2b0040069eaacfc64efdc309', '安卓', '61eb6ddfa0824ac495db5f1f7281ca39', '0,1,28a368fdbbd44a7a99af28d01b12c089,61eb6ddfa0824ac495db5f1f7281ca39,', '0', null, 'client_type_0', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('aae9fa0332584b4cb8de985eae887dcb', '互联网-软件', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '1', null, 'job_type_1', '\0', '10', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('ac531aa386174308935cfea881685fe4', '推荐位', 'faab4823cc8c4ddf89165fec5cac93af', '0,1,faab4823cc8c4ddf89165fec5cac93af,', '', null, 'cms_posid', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('adc97926a7a046d4883bdd2fb2f29bbc', '打印设备版本信息', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '{versionCode:7,downloadUrl:\'http://qiniu-app-cdn.pgyer.com/5d335df06199bd720a453ecf6895a835.apk?e=1480485273&amp;attname=UPIM_PDA3505_5.apk&amp;token=6fYeQ7_TVB5L0QSzosNFfw2HU8eJhAirMF5VxV9G:5kPLtuGCSHp0ePLP1wILnAeMwdw=\'}', null, 'PRINT_CLIENT_VERSION', '', '50', '', '-2', null, '', '8', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('ae79ca61722b44d7b30442d2f4b497e1', '消费', 'de329dd14fd44edeb5f32c54fe02b1e2', '0,1,bede16c99d85416a834a6b3c664bbb9b,de329dd14fd44edeb5f32c54fe02b1e2,', '2', null, 'wallet_consume_flowing_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('aeadd0bed0f345d4b718f1a65c742923', '女', '21150b4cebd349a1992e6bb3428ab4e5', '0,1,28a368fdbbd44a7a99af28d01b12c089,21150b4cebd349a1992e6bb3428ab4e5,', '1', null, 'gender_1', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('aec4a6b7cfd6475ea0d97714c13003fe', '数据范围', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '0', null, 'sys_role_scope', '\0', '0', '', '0', null, '', '3', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('af4bd1c0c57e423c878711383b59eb04', '按明细设置', 'aec4a6b7cfd6475ea0d97714c13003fe', '0,1,5ea249bb780348eb8ea6a0efade684a6,aec4a6b7cfd6475ea0d97714c13003fe,', '5', null, 'sys_role_scope_5', '\0', '0', '', '0', null, '', '5', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('af9fa7257bde4f1b8a117723d28d94ee', '加油站类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'station_genre', '\0', '45', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('b02540522dd14dbaab51a67dd33e626c', 'WTI', 'c9a70cf00c8e42b2b6d8eb475d133d57', '0,1,28a368fdbbd44a7a99af28d01b12c089,c9a70cf00c8e42b2b6d8eb475d133d57,', '3', null, 'exchange_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('b0735a6028a841b28f1715551f4d9b0a', '优品夺宝支付页面', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '8', null, 'notice_page_type_8', '\0', '80', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('b084821826c3485fbbb9a590ae470809', 'app模块操作类型', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'app_operate_type', '\0', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('b1210659ed0f459eae1dfebad40f8001', '油站类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'bank_station_type', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('b1dd0ea58f334a1e84f5f37aa1f0d4e8', '车险链接', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', 'http://clec_uup.h5-legend.com/h5/bebf8a10-2a19-fb67-cce2-14271d8e74c4.html?from=singlemessage&amp;isappinstalled=0', null, 'car_insurance_url', '\0', '99', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('b2b11346325a48dda61ecc020d86d189', '91#test', '6a6391af2d82453c8e13bbebdf448249', '0,1,28a368fdbbd44a7a99af28d01b12c089,6a6391af2d82453c8e13bbebdf448249,', '9', null, 'oil_type_9', '', '90', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('b30f3c0b94b1418c8ba11a8fbb77a918', '油站消息发送类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'station_send_type', '\0', '99', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('b343b0635acf452ebd829885680c2a14', '优品指南说明', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '5', null, 'app_type_5', '\0', '50', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('b3dcc8ff71d940baa75a38db176abc9a', '未使用', 'e154ebf279844277b36190cd40561cb7', '0,1,28a368fdbbd44a7a99af28d01b12c089,e154ebf279844277b36190cd40561cb7,', '0', null, 'voucher_discount_status_0', '\0', '10', '', '-2', null, '', '6', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('b3f2727136e6441387a221d536912006', '即将开放', 'edfa4d6478d9429d8474c4bc9f687dbe', '0,1,b95893620a4a462490349148b9bfe1e7,edfa4d6478d9429d8474c4bc9f687dbe,', '3', null, 'station_cooperate_3', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('b482119799ca4c2cbe8b816ffcae82f3', '红包来源', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'discount_code_payway', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('b490c72630aa4c25af8d7b9ae063a483', '栏目模型', 'faab4823cc8c4ddf89165fec5cac93af', '0,1,faab4823cc8c4ddf89165fec5cac93af,', '', null, 'cms_module', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('b49610202b674d488b938c9b507ea08f', '期号初始值', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '20000000', null, 'COMMODITY_PERIOD_NUMBER', '\0', '20', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('b51b0bc55b8842d78b44fd61a20b03c9', '新版优惠券说明', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '10', null, 'app_type_10', '\0', '100', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('b5ebc25002714a81bb7aa2f7935dcfbe', '普通油站', 'edfa4d6478d9429d8474c4bc9f687dbe', '0,1,b95893620a4a462490349148b9bfe1e7,edfa4d6478d9429d8474c4bc9f687dbe,', '0', null, 'station_cooperate_0', '\0', '10', '', '-2', null, '', '7', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('b60698988c63496d83fa07338bc7694a', '优品夺宝', 'b084821826c3485fbbb9a590ae470809', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,b084821826c3485fbbb9a590ae470809,', '1', null, 'app_operate_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('b655abdc4016444caa5bd758cbed81e6', '支付费率', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'pay_discount', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('b69b14b96942405ea4eaf2030b08c531', '洗车服务', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '0', null, 'is_wash_car', '\0', '10', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('b88bd3914cb4446f950481f6c768b6b3', '支付失败', 'cd3935b5dd2a4ea89df6e60203367aa9', '0,1,28a368fdbbd44a7a99af28d01b12c089,cd3935b5dd2a4ea89df6e60203367aa9,', '2', null, 'commodity_order_status_2', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('b8eb5ac34a824c76944801f157c7d79c', '苹果', '61eb6ddfa0824ac495db5f1f7281ca39', '0,1,28a368fdbbd44a7a99af28d01b12c089,61eb6ddfa0824ac495db5f1f7281ca39,', '1', null, 'client_type_1', '\0', '20', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('b95893620a4a462490349148b9bfe1e7', '油站数据', '1', '0,1,', '', null, 'station_data', '\0', '44', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('b9742ff772994611ac88315170edcf43', '扫码支付', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '2', null, 'notice_page_type_2', '\0', '20', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('ba983d6d3ec74347856dad1581f4c45e', '邀请注册', 'de535c516c4941f0805aff89af46fdff', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,de535c516c4941f0805aff89af46fdff,', '300', null, 'regist_type_4', '\0', '40', '', '-2', null, '', '7', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('baa2c325b84e4aaf86c033ab7217c9df', '支付宝支付费率', 'b655abdc4016444caa5bd758cbed81e6', '0,1,28a368fdbbd44a7a99af28d01b12c089,b655abdc4016444caa5bd758cbed81e6,', '0.006', null, 'alipay_pay_discount', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('bb443fa5befe48d1813a716985bdd5c8', '积分', '5de6bd42e9a248bd95a54254d651ea19', '0,1,28a368fdbbd44a7a99af28d01b12c089,5de6bd42e9a248bd95a54254d651ea19,', '3', null, 'discount_code_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('bb50647c19ba48b395de6e4ad38d2ac4', '指定油站', '99fd51a62c8e4a799f56128826fc1922', '0,1,28a368fdbbd44a7a99af28d01b12c089,99fd51a62c8e4a799f56128826fc1922,', '5', null, 'client_msg_type_5', '\0', '50', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('bbc304fc1f884a258c9feccea57301b8', '扫码支付', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '3', null, 'app_type_3', '\0', '30', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('bca52f7429fb4814b144d96e1f4e79df', 'GET', '0f77deaad18c48d4a1394093cd72f7f3', '0,1,5ea249bb780348eb8ea6a0efade684a6,0f77deaad18c48d4a1394093cd72f7f3,', 'GET', null, 'sys_request_method_1', '', '30', '', '0', null, '', '0', '1', '2016-12-28 17:48:58', '1', '2016-12-28 17:48:58');
INSERT INTO `sys_dict_t` VALUES ('bd23725d60d34578ac9fa11efe52e6ed', '50后', '56b066d2c4fb49358d7dc044d5370e6f', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,56b066d2c4fb49358d7dc044d5370e6f,', '5', null, 'age_type_5', '\0', '50', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('bd327d4485a94daeaba9923b88344313', '男', '21150b4cebd349a1992e6bb3428ab4e5', '0,1,28a368fdbbd44a7a99af28d01b12c089,21150b4cebd349a1992e6bb3428ab4e5,', '0', null, 'gender_0', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('bde92fc6fdc44a2491658a9903634155', '权限模块', '2d778a9832084c4ba246d1b042e9b4ea', '0,1,5ea249bb780348eb8ea6a0efade684a6,2d778a9832084c4ba246d1b042e9b4ea,', '2', null, 'sys_module_type_2', '', '0', '', '0', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 16:49:33');
INSERT INTO `sys_dict_t` VALUES ('be61ce3a8b08479ab5aac57066d26275', '已揭晓', '09ce53d380d0410eb4ef94fc3e380e95', '0,1,28a368fdbbd44a7a99af28d01b12c089,09ce53d380d0410eb4ef94fc3e380e95,', '3', null, 'period_type_3', '\0', '30', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('be625dcc020b45a081ae250acd04a7c7', '消费', '7ad6ecea872a42cc8ebb4d71488902d6', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7ad6ecea872a42cc8ebb4d71488902d6,', '3', null, 'ic_card_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('bede16c99d85416a834a6b3c664bbb9b', '企业版数据', '1', '0,1,', '', null, 'enterprise', '\0', '14', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('bf0fa21eade44a8a9eaf309c090cac02', '不想用了', 'a76e92df76434174bd4b51e3ff1e49c9', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,a76e92df76434174bd4b51e3ff1e49c9,', '3', null, 'user_voucher_refund_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('bfb9185adf814ca7bf07f41449ec5429', '首页广告', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '9', null, 'app_type_9', '\0', '90', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('bfdd58ca129e4999be51aa92e69a22b8', '积分商城广告', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '8', null, 'app_type_8', '\0', '80', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('c122446e28d7457a943b18fe1aec4537', '站点主题', 'faab4823cc8c4ddf89165fec5cac93af', '0,1,faab4823cc8c4ddf89165fec5cac93af,', '', null, 'cms_theme', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('c15870fe42924847801439bb52c1eb58', '没有优惠', 'c8b6eed70aac438dbaa90896fcdcbd4d', '0,1,b95893620a4a462490349148b9bfe1e7,c8b6eed70aac438dbaa90896fcdcbd4d,', '0', null, 'wx_refuel_type_0', '', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('c1aafb746df24705b2542a2d8c948fee', '充值', '7ad6ecea872a42cc8ebb4d71488902d6', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7ad6ecea872a42cc8ebb4d71488902d6,', '2', null, 'ic_card_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('c24dc57b84f642d8adff169f8183862e', '安卓手表版本名称', '82bcde93ebec45caa80f43ff5dfec9a5', '0,1,82bcde93ebec45caa80f43ff5dfec9a5,', 'http://qiniu-app-cdn.pgyer.com/5d335df06199bd720a453ecf6895a835.apk?e=1480485273&amp;attname=UPIM_PDA3505_5.apk&amp;token=6fYeQ7_TVB5L0QSzosNFfw2HU8eJhAirMF5VxV9G:5kPLtuGCSHp0ePLP1wILnAeMwdw=', null, 'android.watch.downloadUrl', '', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:04');
INSERT INTO `sys_dict_t` VALUES ('c28d29b56b2a415e949ecd27431f6f63', '账户余额流水变化类型', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'account_change_type', '\0', '33', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('c2b4aadd1c184dcbbab22fa9785e09c2', '消息状态', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '0', null, 'sys_message_status', '\0', '0', '', '0', null, '', '2', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('c32e4e4b35c54977b7655737476ff07e', '登录成功', '9274dd2c76b94e51972e8b439e036eb2', '0,1,5ea249bb780348eb8ea6a0efade684a6,9274dd2c76b94e51972e8b439e036eb2,', '0', null, 'sys_login_status_0', '\0', '0', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:36');
INSERT INTO `sys_dict_t` VALUES ('c4651a1f36dc401a97e2ac11ac78827e', '丧假', '41a1ef8605464dcbaf51296230ffb25d', '0,1,28a368fdbbd44a7a99af28d01b12c089,41a1ef8605464dcbaf51296230ffb25d,', '3', null, 'oa_leave_type_3', '\0', '800', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('c4bdde70aaf643f082ade032a3651734', '审核未通过', '4586c9de27fc4911809c472d66dea8e4', '0,1,bede16c99d85416a834a6b3c664bbb9b,4586c9de27fc4911809c472d66dea8e4,', '3', null, 'ep_company_verify_state_3', '\0', '3', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('c5cd2e8b2e1e49fcbe0133ac3221607f', '93#(92#)', '6a6391af2d82453c8e13bbebdf448249', '0,1,28a368fdbbd44a7a99af28d01b12c089,6a6391af2d82453c8e13bbebdf448249,', '2', null, 'oil_type_2', '', '20', '元/升', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('c6d100fb9c6d4467bf39c3d69f9838d0', '挂牌价', '9b893f22d03e4830b0ddee3ea6085194', '0,1,b95893620a4a462490349148b9bfe1e7,9b893f22d03e4830b0ddee3ea6085194,', '1', null, 'price_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('c8b6eed70aac438dbaa90896fcdcbd4d', '微信加油优惠类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'wx_refuel_type', '\0', '123', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('c96d55956f8f4977b34d06d3ed10e331', '全部客户', '99fd51a62c8e4a799f56128826fc1922', '0,1,28a368fdbbd44a7a99af28d01b12c089,99fd51a62c8e4a799f56128826fc1922,', '2', null, 'client_msg_type_2', '\0', '25', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('c9a70cf00c8e42b2b6d8eb475d133d57', '外汇类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'exchange_type', '\0', '111', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('ca979f2e20fe45f2bfd359dcba1b1654', '微信', '61eb6ddfa0824ac495db5f1f7281ca39', '0,1,28a368fdbbd44a7a99af28d01b12c089,61eb6ddfa0824ac495db5f1f7281ca39,', '2', null, 'client_type_2', '\0', '30', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('caa1c4c4e3f040348011675219e6efb2', '基础主题', 'c122446e28d7457a943b18fe1aec4537', '0,1,faab4823cc8c4ddf89165fec5cac93af,c122446e28d7457a943b18fe1aec4537,', 'basic', null, 'cms_theme', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('cd3935b5dd2a4ea89df6e60203367aa9', '商品订单状态', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'commodity_order_status', '\0', '98', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('cd8f723e95d74f649a4c751469f04096', '优惠券使用规则', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '6', null, 'app_type_6', '\0', '60', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('cdf67d4574464d00a6453098d8f3ea97', 'Flat主题', '192b728ede9b4c33ae963a52175e4a93', '0,1,5ea249bb780348eb8ea6a0efade684a6,192b728ede9b4c33ae963a52175e4a93,', 'flat', null, 'flat', '\0', '60', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:47:08');
INSERT INTO `sys_dict_t` VALUES ('ce2801afa1a44d4b9b1610a1e1066ae7', '98#', '6a6391af2d82453c8e13bbebdf448249', '0,1,28a368fdbbd44a7a99af28d01b12c089,6a6391af2d82453c8e13bbebdf448249,', '4', null, 'oil_type_4', '', '40', '元/升', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('ceb0bb0c5039487f9bfcfd3fdeeed8da', '消费评论', 'e1dafc74ec424ca7bbe2f1d8913c7cfb', '0,1,28a368fdbbd44a7a99af28d01b12c089,e1dafc74ec424ca7bbe2f1d8913c7cfb,', '1', null, 'comment_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('cebc6c3c990d4322bc703be667a27cba', '系统油站管理', '1c7261a0576b4844be71a1a6f4238d49', '0,1,5ea249bb780348eb8ea6a0efade684a6,1c7261a0576b4844be71a1a6f4238d49,', '4', null, 'sys_staff_type_4', '', '40', '', '0', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('cf595f8ea0ff43d3a7c7c4ab25ea77d2', '团购券面额', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'station_voucher_money', '\0', '100', '油站发布团购券时所供选择的金额列表', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('cf87fe1d27e04a32b72aa572990107da', '圣诞活动中奖最大额', '1', '0,1,', '10', null, 'APP_ACTIVITY_MAX_MONEY', '\0', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('cf92bd9bc2a64ac9a37776f3ec8cce24', '日志级别', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '', null, 'sys_log_level', '\0', '0', '', '0', null, '', '6', '', '2016-12-05 11:31:22', '1', '2017-01-03 15:02:38');
INSERT INTO `sys_dict_t` VALUES ('d07bf464b1044f15aa93220e2b448921', '上班', '5779a04931394aafa6f69a1b11917cff', '0,1,28a368fdbbd44a7a99af28d01b12c089,5779a04931394aafa6f69a1b11917cff,', '0', null, 'guard_status_0', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('d1fabde44a524705ad3a2238dc942f3e', '民营公司', '8473ea94776e45fdbb758257e4054fae', '0,1,bede16c99d85416a834a6b3c664bbb9b,8473ea94776e45fdbb758257e4054fae,', '5', null, 'ep_role_station_company_5', '\0', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('d23c674c29c2489eb6121a1c29fd827f', '转账成功', '6735318ecfc84075a475a464297963b4', '0,1,28a368fdbbd44a7a99af28d01b12c089,6735318ecfc84075a475a464297963b4,', '2', null, 'bank_status_success', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('d3b987c4018d4babbd0aae28ec698f86', '中国农业银行', 'ed8014b466d1419d9b26171248460894', '0,1,28a368fdbbd44a7a99af28d01b12c089,ed8014b466d1419d9b26171248460894,', '03', null, 'bank_type_nongye', '\0', '30', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('d4565f3198574d0b8c9be555e7bd1914', 'test_data', '1', '0,1,', 'test_data111', null, 'test_data', '', '0', '', '-2', null, '', '4', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('d554d5a57b1c46c3a54951afe21e81bb', '支付汇率', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '0.006', null, 'PAY_EXCHANGE_RATE', '\0', '8', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('d5697906556a4ec8b4164534836a3d9a', 'INFO', 'cf92bd9bc2a64ac9a37776f3ec8cce24', '0,1,5ea249bb780348eb8ea6a0efade684a6,cf92bd9bc2a64ac9a37776f3ec8cce24,', 'INFO', null, 'sys_log_level_info', '', '30', '', '0', null, '', '5', '', '2016-12-05 11:31:22', '1', '2017-01-03 15:03:51');
INSERT INTO `sys_dict_t` VALUES ('d6389c07af3840488635ad435e1c7361', '兑换优惠券', '86f3598178fb4f659480dfdab40f0613', '0,1,28a368fdbbd44a7a99af28d01b12c089,86f3598178fb4f659480dfdab40f0613,', '4', null, 'voucher_discount_type_4', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('d6b5382dd25942be9b5f099697c43048', '消费', '89b638c11f3f4a409a47ca932dcc4a21', '0,1,bede16c99d85416a834a6b3c664bbb9b,89b638c11f3f4a409a47ca932dcc4a21,', '1', null, 'quota_flowing_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('d731fd771daf48d0a75e6593f4123e32', '加油类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'refuel_type', '\0', '55', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('d7447e8116644b579cd0bba7f1c74dd7', '汽油', '26e8db8c98964edfb6a35e437b32cee5', '0,1,bede16c99d85416a834a6b3c664bbb9b,26e8db8c98964edfb6a35e437b32cee5,', '1', null, 'ratio_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('d99f1efd57bc4a5bafbe3c5f79aee103', '四级', '8040c72a95f541a49734bbe1c47547ca', '0,1,5ea249bb780348eb8ea6a0efade684a6,8040c72a95f541a49734bbe1c47547ca,', '4', null, 'sys_org_grade_4', '', '10', '', '0', null, '', '4', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:42:17');
INSERT INTO `sys_dict_t` VALUES ('da22436573c4424fbf13a1987faeb529', '三级', '8040c72a95f541a49734bbe1c47547ca', '0,1,5ea249bb780348eb8ea6a0efade684a6,8040c72a95f541a49734bbe1c47547ca,', '3', null, 'sys_org_grade_3', '\0', '-1', null, '-1', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:43:22');
INSERT INTO `sys_dict_t` VALUES ('da581b145cb143a59ded9e9c7cc65d26', '企业支付', '302d390aae3142e79bf0155aeb4768bb', '0,1,28a368fdbbd44a7a99af28d01b12c089,302d390aae3142e79bf0155aeb4768bb,', '8', null, 'pay_type_8', '\0', '80', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('da8c04da8108425a833fecbb47e22833', '优惠券使用类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'use_type', '\0', '122', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('da8c5f2c4c404764851c1c40ce06ffa6', '注册优惠券', '86f3598178fb4f659480dfdab40f0613', '0,1,28a368fdbbd44a7a99af28d01b12c089,86f3598178fb4f659480dfdab40f0613,', '1', null, 'voucher_discount_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('db1f56668eea44b9b2726e334c7df1f8', '兑换众筹商品', '676ca81bfa9440018af3f15c17d7a1b6', '0,1,28a368fdbbd44a7a99af28d01b12c089,676ca81bfa9440018af3f15c17d7a1b6,', '5', null, 'score_type_5', '\0', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('dc0998ca63d640d592efa988d26518e0', '优品夺宝主页', '32918f5f441f4e5d9e3f6eb8c9caa8de', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,32918f5f441f4e5d9e3f6eb8c9caa8de,', '10', null, 'notice_page_type_10', '\0', '100', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('dc8e714a391d4f93b8fa008f3cee351c', '中通', 'e5ad79055bfd41ddaf9cd9e2be127ae0', '0,1,28a368fdbbd44a7a99af28d01b12c089,e5ad79055bfd41ddaf9cd9e2be127ae0,', '3', null, 'express_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('de1aeeb8fb4c430bae22a475cda24739', '80后', '56b066d2c4fb49358d7dc044d5370e6f', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,56b066d2c4fb49358d7dc044d5370e6f,', '2', null, 'age_type_2', '\0', '20', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('de1cb2b9612b487ebaa7e418f66ddecb', '500元', 'cf595f8ea0ff43d3a7c7c4ab25ea77d2', '0,1,b95893620a4a462490349148b9bfe1e7,cf595f8ea0ff43d3a7c7c4ab25ea77d2,', '500', null, 'station_voucher_money_500', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('de329dd14fd44edeb5f32c54fe02b1e2', '钱包流水类型', 'bede16c99d85416a834a6b3c664bbb9b', '0,1,bede16c99d85416a834a6b3c664bbb9b,', '', null, 'wallet_consume_flowing', '\0', '77', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('de37ceeedc6643ad9e5a38745deb4b3f', '加油枪使用状态', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'gun_use_status', '\0', '70', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('de535c516c4941f0805aff89af46fdff', 'app用户注册方式', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'regist_type', '\0', '88', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('df396c579e7445aa8ec6225217a47c98', '内容4', '47a5e3b107294f318017dd336c9a8ad7', '0,1,a0d3943b46154244bfeb0bee9b59ab38,47a5e3b107294f318017dd336c9a8ad7,', '老顾客了，用了软件加油，更划算了！', null, 'comment_content_type_4', '', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('e154ebf279844277b36190cd40561cb7', '优惠卷使用状态', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'voucher_discount_status', '\0', '50', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('e17946525207436ea938a8fee6fa96ce', '亲爱的顾客，我们是{0}，为了更好地服务客户，我们将于4月30日至5月30日对加油站进行装修，装修期', '087cf2856c334d95937e641a7a6d798d', '0,1,b95893620a4a462490349148b9bfe1e7,087cf2856c334d95937e641a7a6d798d,', '亲爱的顾客，我们是{0}，为了更好地服务客户，我们将于4月30日至5月30日对加油站进行装修，装修期', null, 'content_type_3', '\0', '30', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('e1dafc74ec424ca7bbe2f1d8913c7cfb', '评论类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'comment_type', '\0', '90', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('e44cd1c06b1c44008822198334a3dd2f', '评论', '676ca81bfa9440018af3f15c17d7a1b6', '0,1,28a368fdbbd44a7a99af28d01b12c089,676ca81bfa9440018af3f15c17d7a1b6,', '2', null, 'score_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('e4561c62ad4a44c384bf29dc1db63fa3', '膨化食品', '951c185957794748a6a880ad28e0e8f9', '0,1,b95893620a4a462490349148b9bfe1e7,951c185957794748a6a880ad28e0e8f9,', '2', null, 'gas_commodity_type_2', '', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('e54d4e54ceec4b8f9b8bf034d97cdf56', 'app数据', '1', '0,1,', '', null, 'app_data', '\0', '55', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('e574221f8d3e475e8078b6698ebc7958', '金钱众筹兑换基数', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '1', null, 'COMMODITY_PERIOD_EXCHANGE_MONEY', '\0', '10', '', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('e5a870535d76449e93d0380fcb6ca552', '绑卡', '7ad6ecea872a42cc8ebb4d71488902d6', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7ad6ecea872a42cc8ebb4d71488902d6,', '1', null, 'ic_card_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('e5ad79055bfd41ddaf9cd9e2be127ae0', '快递类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '0', null, 'express_type', '\0', '56', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('e5c4ef6ea6db4b669758330696161c49', '优惠券', '30906ca1f1324629a2960a8892020e2e', '0,1,28a368fdbbd44a7a99af28d01b12c089,30906ca1f1324629a2960a8892020e2e,', '1', null, 'commodity_type_1', '\0', '30', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('e658a7f48b0e428a81581d22817a9288', '我是航油用户，但是误购买了民营的团购券了', 'a76e92df76434174bd4b51e3ff1e49c9', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,a76e92df76434174bd4b51e3ff1e49c9,', '1', null, 'user_voucher_refund_type_1', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('e667e5c2f48e4903ae8eec9a807f1282', '其它', '857efc4a11844315aec9ace0d2a75206', '0,1,faab4823cc8c4ddf89165fec5cac93af,857efc4a11844315aec9ace0d2a75206,', '4', null, 'cms_guestbook_4', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('e6e1a2538358478696dc9fa35c18a905', '支付宝', '302d390aae3142e79bf0155aeb4768bb', '0,1,28a368fdbbd44a7a99af28d01b12c089,302d390aae3142e79bf0155aeb4768bb,', '2', null, 'pay_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('e7f3c85d28dc4b0b8147b83df401439f', '通信-软件', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '2', null, 'job_type_2', '\0', '20', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('e7f773681d574e7bb90c85386eaa489a', '未处理', 'c2b4aadd1c184dcbbab22fa9785e09c2', '0,1,5ea249bb780348eb8ea6a0efade684a6,c2b4aadd1c184dcbbab22fa9785e09c2,', '0', null, 'sys_message_status_0', '\0', '0', '', '0', null, '', '4', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('e81024b1d2a24442bbdc551d10250a0b', '正常', '36adfd803e3f4b48b6fa829c96b26959', '0,1,5ea249bb780348eb8ea6a0efade684a6,36adfd803e3f4b48b6fa829c96b26959,', '0', null, 'sys_status_normal', '\0', '10', '', '0', null, '', '13', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('e82ac00cc3964ebe89c59de9c047bccb', '被邀请优惠券', '86f3598178fb4f659480dfdab40f0613', '0,1,28a368fdbbd44a7a99af28d01b12c089,86f3598178fb4f659480dfdab40f0613,', '3', null, 'voucher_discount_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('e8358c7f56414976b493c107f12940a2', '航油新模式站', 'f836643eb0754b1d84711435111e8234', '0,1,b95893620a4a462490349148b9bfe1e7,f836643eb0754b1d84711435111e8234,', '3', null, 'station_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('e874667d258c48209541f00d7926b558', '已退款', '1ca59e473f0e48a9ab0591fa098e89f9', '0,1,28a368fdbbd44a7a99af28d01b12c089,1ca59e473f0e48a9ab0591fa098e89f9,', '400', null, 'vucher_status_6', '\0', '60', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('eabba2d8864d48ea9f393ffdbaee65f9', 'vip预约', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '2', null, 'app_type_2', '\0', '20', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('eaef9f9a924048f29c8478d55c6033d6', '贸易-物流', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '90', null, 'job_type_9', '\0', '90', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('eb446d32b849403db7ac73aa5991fb62', '查违章', 'b084821826c3485fbbb9a590ae470809', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,b084821826c3485fbbb9a590ae470809,', '4', null, 'app_operate_type_4', '\0', '40', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('eb5f0523d0154fafbfe57a928ccd4b2b', '在线', '8b5fc2a625d242e5a30576f1e0fc0364', '0,1,4b83e314763746b3857335ee9ec26836,8b5fc2a625d242e5a30576f1e0fc0364,', '0', null, 'online_status_0', '', '30', '', '0', null, '', '1', '1', '2017-03-27 15:20:15', '1', '2017-06-30 15:01:19');
INSERT INTO `sys_dict_t` VALUES ('ec38850666a94af8b11f7eb1a3d40482', '发现功能说明', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '4', null, 'app_type_4', '\0', '40', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('ecb25d8f6f6e43a4a935b4372181e25b', '油站优惠券', 'da8c04da8108425a833fecbb47e22833', '0,1,b95893620a4a462490349148b9bfe1e7,da8c04da8108425a833fecbb47e22833,', '1', null, 'use_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('ed6bc6b03a2a4afbbdc9e35957aa0440', '状态', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '0', null, 'sys_yes_no', '\0', '0', '', '0', null, '', '2', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('ed8014b466d1419d9b26171248460894', '银行类型', '28a368fdbbd44a7a99af28d01b12c089', '0,1,28a368fdbbd44a7a99af28d01b12c089,', '', null, 'bank_type', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('edfa4d6478d9429d8474c4bc9f687dbe', '加油站状态类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'station_cooperate', '\0', '33', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('ef1901121346440d8f1b60a8fd366d0a', '权限模块', 'fe104789ebbd41c5983984beb634705f', '0,1,5ea249bb780348eb8ea6a0efade684a6,fe104789ebbd41c5983984beb634705f,', '1', null, 'sys_module_flag_1', '\0', '0', '', '-2', null, '', '5', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:42');
INSERT INTO `sys_dict_t` VALUES ('efd8571900754f3c9ef89ff7f2a084a2', '新用户注册5元面额最低消费限制', 'a0d3943b46154244bfeb0bee9b59ab38', '0,1,a0d3943b46154244bfeb0bee9b59ab38,', '100', null, 'USER_REGIST_FIVE_LIMIT_MONEY', '\0', '55', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('f02a7e3164d644358aea3381d8284d7e', '我是民营油站客户，但是误购买航油油站的团购券了', 'a76e92df76434174bd4b51e3ff1e49c9', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,a76e92df76434174bd4b51e3ff1e49c9,', '2', null, 'user_voucher_refund_type_2', '\0', '20', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('f144d350f02f457c8ce90588c7d67c77', '用户角色', 'bede16c99d85416a834a6b3c664bbb9b', '0,1,bede16c99d85416a834a6b3c664bbb9b,', '', null, 'ep_role_type', '\0', '10', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('f177e0beb8224d318719670425291cd0', '中国建设银行', 'ed8014b466d1419d9b26171248460894', '0,1,28a368fdbbd44a7a99af28d01b12c089,ed8014b466d1419d9b26171248460894,', '05', null, 'bank_type_jianshe', '\0', '50', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('f21c2ec664a94180852b91da94c0835e', '财务审核通过', '6735318ecfc84075a475a464297963b4', '0,1,28a368fdbbd44a7a99af28d01b12c089,6735318ecfc84075a475a464297963b4,', '4', null, 'bank_status_check', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('f41408e4f06b4240bef826057b200192', '已使用', 'e154ebf279844277b36190cd40561cb7', '0,1,28a368fdbbd44a7a99af28d01b12c089,e154ebf279844277b36190cd40561cb7,', '1', null, 'voucher_discount_status_1', '\0', '22', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('f46d039e4b3843f591b8161ba74c50b4', '政府机构', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '120', null, 'job_type_12', '\0', '120', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('f4af11e55d3945079ace9613bd8ae40d', '否', '51a416cf4fc244478135680613221998', '0,1,28a368fdbbd44a7a99af28d01b12c089,51a416cf4fc244478135680613221998,', '1', null, 'is_toilet_1', '\0', '10', '', '-2', null, '', '3', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('f4bde82ec2df47d290f5ddd5c512d254', '转账失败', '6735318ecfc84075a475a464297963b4', '0,1,28a368fdbbd44a7a99af28d01b12c089,6735318ecfc84075a475a464297963b4,', '3', null, 'bank_status_failed', '\0', '0', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('f64edd136e80465e8d78f66c008aaaf1', '所在机构及以下数据', 'aec4a6b7cfd6475ea0d97714c13003fe', '0,1,5ea249bb780348eb8ea6a0efade684a6,aec4a6b7cfd6475ea0d97714c13003fe,', '2', null, 'sys_role_scope_2', '\0', '30', '', '0', null, '', '5', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('f7a3ccf7852c499e916e354267460c61', '蓝牌', '2468f642eb014e918f5901d7274760c4', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,2468f642eb014e918f5901d7274760c4,', '1', null, 'car_num_type_1', '\0', '10', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('f7b3dc948cfa4be3b5dd71e0a64ec31d', '原支付方审核中', '8f914a54eef54792b900032864f43dad', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,8f914a54eef54792b900032864f43dad,', '2', null, 'refund_status_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('f7bb158b237048b7a1751ab810ae70f6', '个人中心广告', '1e5429816dbc48fe99d247a0de7523a7', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,1e5429816dbc48fe99d247a0de7523a7,', '7', null, 'app_type_7', '\0', '70', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('f836643eb0754b1d84711435111e8234', '加油站类型', 'b95893620a4a462490349148b9bfe1e7', '0,1,b95893620a4a462490349148b9bfe1e7,', '', null, 'station_type', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('f9cfd88093bd4f538773742c21e1159a', '消费品', '7426775094ff466c85ae945f715f8367', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,7426775094ff466c85ae945f715f8367,', '6', null, 'job_type_6', '\0', '60', '', '-2', null, '', '1', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('fa4c71c5e56a49a8a9bba90f11d0a9fa', '退款操作状态', 'e54d4e54ceec4b8f9b8bf034d97cdf56', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,', '', null, 'refund_operate_status', '\0', '0', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');
INSERT INTO `sys_dict_t` VALUES ('faab4823cc8c4ddf89165fec5cac93af', '内容管理', '1', '0,1,', '', null, 'cms', '\0', '50', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('fab53a9a171c44c1a8fa3613933a3528', '查违章', '676ca81bfa9440018af3f15c17d7a1b6', '0,1,28a368fdbbd44a7a99af28d01b12c089,676ca81bfa9440018af3f15c17d7a1b6,', '3', null, 'score_type_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('fb8d349af89c4be091cf38b8e65a5d07', '农村信用社', 'ed8014b466d1419d9b26171248460894', '0,1,28a368fdbbd44a7a99af28d01b12c089,ed8014b466d1419d9b26171248460894,', '12', null, 'bank_type_nongxin', '\0', '60', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:15');
INSERT INTO `sys_dict_t` VALUES ('fcf6a12e6f0e4db98be49a1eefbd5a85', '所在机构数据', 'aec4a6b7cfd6475ea0d97714c13003fe', '0,1,5ea249bb780348eb8ea6a0efade684a6,aec4a6b7cfd6475ea0d97714c13003fe,', '3', null, 'sys_role_scope_3', '\0', '20', '', '0', null, '', '5', '', '2016-12-05 11:31:22', null, null);
INSERT INTO `sys_dict_t` VALUES ('fe104789ebbd41c5983984beb634705f', '模块标识', '5ea249bb780348eb8ea6a0efade684a6', '0,1,5ea249bb780348eb8ea6a0efade684a6,', '', null, 'sys_module_flag', '\0', '0', '', '-2', null, '', '6', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:46:42');
INSERT INTO `sys_dict_t` VALUES ('feb26d3ccd3045b5b2360b64142cd38c', '优品价', '9b893f22d03e4830b0ddee3ea6085194', '0,1,b95893620a4a462490349148b9bfe1e7,9b893f22d03e4830b0ddee3ea6085194,', '2', null, 'price_type_2', '\0', '20', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:22');
INSERT INTO `sys_dict_t` VALUES ('ff7144c53f2d4839b1e22048b53cdc69', '企业消费订单类型', 'bede16c99d85416a834a6b3c664bbb9b', '0,1,bede16c99d85416a834a6b3c664bbb9b,', '', null, 'user_consume_company_type', '\0', '56', '', '-2', null, '', '2', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:11');
INSERT INTO `sys_dict_t` VALUES ('ff9a964f70e24970b41ba60323547cf6', '内容5', '47a5e3b107294f318017dd336c9a8ad7', '0,1,a0d3943b46154244bfeb0bee9b59ab38,47a5e3b107294f318017dd336c9a8ad7,', '朋友推荐过来加油的，挺好！', null, 'comment_content_type_5', '', '50', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-24 09:26:16');
INSERT INTO `sys_dict_t` VALUES ('ffa8202d04bd42e7aa9898f4ea62e554', '到账成功，退回原支付账户', '8f914a54eef54792b900032864f43dad', '0,1,e54d4e54ceec4b8f9b8bf034d97cdf56,8f914a54eef54792b900032864f43dad,', '3', null, 'refund_status_3', '\0', '30', '', '-2', null, '', '0', '', '2016-12-05 11:31:22', '1', '2016-12-28 17:38:08');

-- ----------------------------
-- Table structure for sys_log_login_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_login_t`;
CREATE TABLE `sys_log_login_t` (
  `id_` varchar(32) NOT NULL DEFAULT '0',
  `staff_id` varchar(32) DEFAULT NULL,
  `login_id` varchar(50) DEFAULT NULL,
  `remote_addr` varchar(255) DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `enter_time` datetime DEFAULT NULL,
  `leave_time` datetime DEFAULT NULL,
  `total_time` int(11) DEFAULT NULL,
  `login_flag` int(11) DEFAULT NULL,
  `description_` varchar(255) DEFAULT NULL,
  `status_` varchar(2) DEFAULT '0',
  PRIMARY KEY (`id_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_log_login_t
-- ----------------------------

-- ----------------------------
-- Table structure for sys_log_operate_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_operate_t`;
CREATE TABLE `sys_log_operate_t` (
  `id_` varchar(32) NOT NULL,
  `title_` varchar(500) DEFAULT NULL,
  `type_` char(1) DEFAULT '0' COMMENT '日志类型 0：接入日志；1：错误日志',
  `staff_id` varchar(50) DEFAULT NULL,
  `login_id` varchar(50) DEFAULT NULL,
  `exception_` text,
  `request_method` varchar(50) DEFAULT NULL COMMENT '请求方式',
  `access_method` varchar(255) DEFAULT NULL COMMENT '请求方法',
  `params_` varchar(2000) DEFAULT NULL,
  `remote_addr` varchar(255) DEFAULT NULL,
  `permissions` varchar(255) DEFAULT NULL COMMENT '权限标识',
  `time_consuming` int(11) DEFAULT NULL,
  `request_uri` varchar(2000) DEFAULT NULL COMMENT '耗时(毫秒)',
  `user_agent` varchar(255) DEFAULT NULL,
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  `operate_des` varchar(255) DEFAULT NULL,
  `status_` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_log_operate_t
-- ----------------------------
INSERT INTO `sys_log_operate_t` VALUES ('5dffb37b158a4fabb93e35099ca2167d', '数据模块-系统设置-系统管理-操作日志', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.LogOperateController.list(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model)', '', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_logOperate_view])', '11', '/a/sys/logOperate/', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', '2015-12-15 21:12:27', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('763dc27054084291945d83999d006650', '数据模块-我的面板-个人信息-个人信息', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.info(com.albedo.modules.sys.entity.Staff,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[user])', '62', '/a/sys/staff/info', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', '2015-12-15 21:12:31', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('20b4dbdbddbf4b0fb02915c2ee9051c1', '数据模块-系统设置-代码生成-生成方案配置', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.gen.controller.GenSchemeController.list(com.albedo.modules.gen.entity.GenScheme,javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_1', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[gen_genScheme_view])', '14', '/a/gen/genScheme', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', '2015-12-15 21:12:33', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('bae10b32c38f4d60a974bed4225381a8', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', 'tabPageId=jerichotabiframe_2', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '13', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', '2015-12-15 21:12:35', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('9e4ffbcba7d44693bc9c4214006df4cf', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'nd=1450185154794&pageNo=1&sortOrder=asc&pageSize=20&sortName=', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '30', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', '2015-12-15 21:12:35', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('4e473711b63c4af0ac0f3d33333cc520', '数据模块-系统设置-机构用户-角色管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.RoleController.list(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model,com.albedo.modules.sys.entity.Role)', 'tabPageId=jerichotabiframe_3', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_role_view])', '16', '/a/sys/role/', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', '2015-12-15 21:12:36', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('eba9eb9b714140f4847b03c33680304e', '数据模块-系统设置-系统管理-模块管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.list()', 'tabPageId=jerichotabiframe_4', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '7', '/a/sys/module/', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', '2015-12-15 21:12:37', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('45ea612481f84489aea2dc05d5921c2e', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'GET', 'public java.util.List com.albedo.modules.sys.controller.ModuleController.findTreeData(java.lang.String,java.lang.String,javax.servlet.http.HttpServletResponse)', 'all=', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '5', '/a/sys/module/findTreeData', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', '2015-12-15 21:12:37', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('8059ac3ee88c46dfb00e7de4d9a20704', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Module)', 'parentId=1&nd=1450185157256&pageNo=1&sortOrder=asc&pageSize=20&sortName=', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '14', '/a/sys/module/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', '2015-12-15 21:12:37', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('663dd71633904d039e8ac01432973bab', '数据模块-系统设置-系统管理-操作日志', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.LogOperateController.list(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_5', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_logOperate_view])', '11', '/a/sys/logOperate/', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', '2015-12-15 21:12:39', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('6e79cf85e2044c3cb255730868b02410', '数据模块-我的面板-个人信息-个人信息', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.info(com.albedo.modules.sys.entity.Staff,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[user])', '2582', '/a/sys/staff/info', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:11:53', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('6a8808dba2e4425bb98cdbb89cb9dcd4', '数据模块-我的面板-个人信息-修改密码', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.modifyPwd(java.lang.String,java.lang.String,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_3', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[user])', '583', '/a/sys/staff/modifyPwd', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:00', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('b7e72c06ab8a4c24a02e7b85ac59cc00', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', 'tabPageId=jerichotabiframe_4', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '1584', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:03', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('3cc3c5bb125448d3b409bee6a5d18580', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756324062&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '589', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:05', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('575b65090fc14a0fb3c79173f3ba362e', '数据模块-系统设置-机构用户-角色管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.RoleController.list(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model,com.albedo.modules.sys.entity.Role)', 'tabPageId=jerichotabiframe_5', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_role_view])', '1944', '/a/sys/role/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:05', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('8ca3b2cfd9c54946ac55b9f5f1291ca7', '数据模块-系统设置-机构用户-机构管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.OrgController.list(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_6', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_org_view])', '677', '/a/sys/org/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:07', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('de6ea9b0db9444d388df1f47d0c9a0eb', '数据模块-系统设置-系统管理-模块管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.list()', 'tabPageId=jerichotabiframe_7', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '557', '/a/sys/module/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:10', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('4e9011f54d7e45808704dfa44989cd46', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'GET', 'public void com.albedo.modules.sys.controller.ModuleController.findTreeData(java.lang.String,java.lang.String,javax.servlet.http.HttpServletResponse)', 'all=', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '14', '/a/sys/module/findTreeData', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:10', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('3efee7b344c44c708214fee1d5745375', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Module)', 'sortName=&nd=1480756330053&pageNo=1&sortOrder=asc&pageSize=20&parentId=1', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '24', '/a/sys/module/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:10', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('5dc0762505b3474dae68abce51933681', '数据模块-系统设置-系统管理-消息管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.MessageController.box(org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_8', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_message_view])', '605', '/a/sys/message/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:12', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('3e4eecc1940a49b1909b55057c86b583', '数据模块-系统设置-系统管理-消息管理-查看消息列表', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.MessageController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Message)', 'sortName=&receiver=1&nd=1480756331894&pageNo=1&sortOrder=asc&pageSize=20&messageFlag=0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_message_view])', '76', '/a/sys/message/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:12', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('81e56430523f4c7dbd27bd35d5ef4e0c', '数据模块-系统设置-系统管理-字典管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.DictController.list()', 'tabPageId=jerichotabiframe_9', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_dict_view])', '442', '/a/sys/dict/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:15', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('0a3d075cf01e41b9834c3ad6137261f6', '数据模块-系统设置-系统管理-字典管理-查看字典', '0', '1', 'admin', '', 'GET', 'public void com.albedo.modules.sys.controller.DictController.findTreeData(java.lang.String,java.lang.String,javax.servlet.http.HttpServletResponse)', 'all=', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_dict_view])', '9', '/a/sys/dict/findTreeData', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:15', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('3e96cba292c44333a23640682730e951', '数据模块-系统设置-系统管理-字典管理-查看字典', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.DictController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Dict)', 'sortName=&nd=1480756334945&pageNo=1&sortOrder=asc&pageSize=20&parentId=1', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_dict_view])', '33', '/a/sys/dict/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:15', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('c3607ed0bb484bcf86e92f418d097524', '数据模块-系统设置-机构用户-区域管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.AreaController.list()', 'tabPageId=jerichotabiframe_10', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_area_view])', '531', '/a/sys/area/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:17', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('ffa8b51b448a4a858f2cfcf46bf66075', '数据模块-系统设置-机构用户-区域管理-查看区域', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.AreaController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756336945&pageNo=1&sortOrder=asc&pageSize=100&queryConditionJson=[{\'fieldName\':\'parentId\',\'operation\':\'=\',\'value\':\'1\'}]', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_area_view])', '808', '/a/sys/area/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:18', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('fc1a5c2c34ab44d0a2adfb6e6faecaa6', '数据模块-系统设置-系统管理-操作日志', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.LogOperateController.list(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_14', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_logOperate_view])', '460', '/a/sys/logOperate/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:36', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('fa4fa191a7a243fd808ee1a0fc5631d0', '数据模块-系统设置-代码生成-生成方案配置', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.gen.controller.GenSchemeController.list(com.albedo.modules.gen.entity.GenScheme,javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_16', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[gen_genScheme_view])', '555', '/a/gen/genScheme', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:42', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('c91b939daf7943a5b38ddcd2dc1bbeab', '数据模块-系统设置-代码生成-业务表配置', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.gen.controller.GenTableController.list(com.albedo.modules.gen.entity.GenTable,javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_17', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[gen_genTable_view])', '691', '/a/gen/genTable', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:45', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('348c986f93564b6fabdfd61b4ffadf0b', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756374771&pageNo=1&sortOrder=asc&pageSize=20&queryConditionJson=[{\"fieldName\":\"orgId\",\"attrType\":\"String\",\"fieldNode\":\"\",\"operation\":\"=\",\"weight\":0,\"value\":\"1\"}]', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '40', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:12:55', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('963aa1e3cf1047bb8f7092d3d9813f9f', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', 'tabPageId=jerichotabiframe_4', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '15', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:13:05', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('9122106641bb4626ba0073bd3d5cb01f', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756384902&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '25', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:13:05', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('4773c36a2f3e4b6f9aef5a99bc024432', '数据模块-我的面板-个人信息-个人信息', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.info(com.albedo.modules.sys.entity.Staff,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[user])', '37', '/a/sys/staff/info', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:13:40', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('4dd70a88e49140ac9756965900ba9f1f', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', 'tabPageId=jerichotabiframe_1', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '11', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:13:41', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('4cd1f43fae78447488b28f847cec254b', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756421359&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '39', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:13:41', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('969ff06d8b20443584aeda6c175d569b', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.showSave(com.albedo.modules.sys.entity.Staff,org.springframework.ui.Model,org.springframework.web.servlet.mvc.support.RedirectAttributes)', '', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '416', '/a/sys/staff/showSave', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:13:43', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('d23f2ccd9c1f4fc096390e59e08d56d3', '数据模块-系统设置-机构用户-用户管理-添加/修改用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.save(com.albedo.modules.sys.entity.Staff,java.lang.String,org.springframework.ui.Model,org.springframework.web.servlet.mvc.support.RedirectAttributes)', 'confirmNewPassword=&orgName=平台 &loginId=test&roleIdList=bf5eeff57a1e4b1fac97bb37b5b73da7&_roleIdList=on&mobile=&photo=&newPassword=&description=&telephone=&type=1&orgId=1&name=&id=&email=&status=0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_save])', '481', '/a/sys/staff/save', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:14:01', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('b15ed6e737d843be9c39a04e4cb62ccb', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', 'repage=', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '10', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:14:01', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('f45d2c95abe343d7aa8abde9c640bf68', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756441514&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '55', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:14:02', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('585b28b9cb784f7f887b6457ab706fa6', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&pageSize=20&nd=1480756444708&pageNo=1&sortOrder=asc&queryConditionJson=[{\"fieldName\":\"orgId\",\"attrType\":\"String\",\"fieldNode\":\"\",\"operation\":\"=\",\"weight\":0,\"value\":\"1\"}]', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '39', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:14:05', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('b969442f5ef44d759fe24590ccdb9ec0', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756445812&pageNo=1&sortOrder=asc&pageSize=20&queryConditionJson=[]', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '44', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:14:06', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('e7d31e1942e14406a263495ff0dd55c4', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', '', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '15', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:14:12', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('854276bbdb86404e8b5808c7da3fffee', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756452494&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '36', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:14:13', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('933ae1f06a7e4b56a3be051ab9d6a112', '数据模块-我的面板-个人信息-个人信息', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.info(com.albedo.modules.sys.entity.Staff,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[user])', '18', '/a/sys/staff/info', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:14:37', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('5c80b6e7ae4040eebbcbe3230022c74b', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', 'tabPageId=jerichotabiframe_1', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '12', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:15:01', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('fd438e2d8a6e4514a2ce1375711f4720', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756501783&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '66', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:15:02', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('b5457f28fc694fb99adb5412c60638dd', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', '', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '747', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:17:03', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('dbdd5eac2cda4b1f9cb676c045ab69a4', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', '', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '22', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:17:20', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('b4dfcca701a94aa086e6210984a39955', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756641354&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '1205', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:17:23', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('dcd6885a21ac4e22bff8bd146d299cdd', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', '', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '25', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:17:46', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('880eda9751354104bce89672890f9a1e', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480756667030&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '53', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:17:47', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('07bcd6a77e6a47b2aeceab0c7403f685', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', '', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '24', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:19:53', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('0351bed41e0141488d63da97641403c0', '数据模块-我的面板-个人信息-个人信息', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.info(com.albedo.modules.sys.entity.Staff,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[user])', '910', '/a/sys/staff/info', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:23:35', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('6fd9dac77d674616b1c19f15c326a018', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', 'tabPageId=jerichotabiframe_1', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '561', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:23:38', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('c37ba06f413441db8b5bee2657712930', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480757018570&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '42725', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:24:21', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('c7e432a6a96e4f0895efeaa1d675df26', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', '', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '19', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:24:32', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('83150f16a7484185bbaad534c7ec7b6e', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480757072573&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '55', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:24:33', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('49f197ce20fb4cf4b9c29dba2e995615', '数据模块-我的面板-个人信息-个人信息', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.info(com.albedo.modules.sys.entity.Staff,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[user])', '33', '/a/sys/staff/info', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:24:43', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('92e5e61a02c642378e938f0b9299db8f', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', 'tabPageId=jerichotabiframe_1', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '15', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:24:44', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('ec8f241fd2fe40f3a6f9199150336866', '数据模块-我的面板-个人信息-个人信息', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.info(com.albedo.modules.sys.entity.Staff,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[user])', '181', '/a/sys/staff/info', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:27:41', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('ad8161add75547c3bbf3a78c91120e34', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', 'tabPageId=jerichotabiframe_1', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '110', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:27:46', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('8f35d7e0d4254121bc1073d9273daa50', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480757266347&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '201', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:27:47', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('18fa5ebb955d429fb5cea7f3b7fe7d44', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480757277139&pageNo=1&sortOrder=asc&pageSize=20&queryConditionJson=[]', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '69', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:27:57', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('f817467450da4dd3bfc5d7268babf180', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', '', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '15', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:29:17', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('51c6dbf546574d0bbc7b0785c67a0163', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480757357091&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '24', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:29:17', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('fdbae5d81a744251a24bcdf27f1eaca8', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', '', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '9', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:29:18', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('3e3d568adb514011b043557629d7e7e8', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480757358393&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '23', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:29:18', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('4a26483b69704c5092cfbe51f3e0ded4', '数据模块-系统设置-机构用户-角色管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.RoleController.list(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model,com.albedo.modules.sys.entity.Role)', 'tabPageId=jerichotabiframe_2', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_role_view])', '200', '/a/sys/role/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:29:20', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('1df83b5935c94cbabd17e8e6cc8181fd', '数据模块-系统设置-机构用户-机构管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.OrgController.list(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_3', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_org_view])', '120', '/a/sys/org/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:29:21', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('73528bed5b8f4a8a9a994a2c649bdbde', '数据模块-我的面板-个人信息-个人信息', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.info(com.albedo.modules.sys.entity.Staff,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[user])', '22', '/a/sys/staff/info', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:30:52', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('2eb96d57df964083827b1b4360e47ca7', '数据模块-系统设置-机构用户-用户管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.list()', 'tabPageId=jerichotabiframe_1', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '11', '/a/sys/staff/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:30:53', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('8d71a3fd391048c389e3b680b06ced63', '数据模块-系统设置-机构用户-用户管理-查看列表用户', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.StaffController.findList(com.albedo.common.domain.PageModel)', 'sortName=&nd=1480757453600&pageNo=1&sortOrder=asc&pageSize=20', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_staff_view])', '42', '/a/sys/staff/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:30:54', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('e4ae343528984a13a2dffbf463baa8af', '数据模块-系统设置-机构用户-角色管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.RoleController.list(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model,com.albedo.modules.sys.entity.Role)', 'tabPageId=jerichotabiframe_2', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_role_view])', '15', '/a/sys/role/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:30:55', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('71c7d3555c724ec39339cceb99df0e3d', '数据模块-系统设置-机构用户-机构管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.OrgController.list(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse,org.springframework.ui.Model)', 'tabPageId=jerichotabiframe_3', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_org_view])', '11', '/a/sys/org/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:30:56', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('da107c368e1a48ed98293e80e10887d2', '数据模块-系统设置-系统管理-模块管理', '0', '1', 'admin', '', 'GET', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.list()', 'tabPageId=jerichotabiframe_4', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '130', '/a/sys/module/', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:30:58', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('c6e36a2afcb34c91bdac3b7c803782f5', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'GET', 'public void com.albedo.modules.sys.controller.ModuleController.findTreeData(java.lang.String,java.lang.String,javax.servlet.http.HttpServletResponse)', 'all=', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '9', '/a/sys/module/findTreeData', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:30:59', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('3304c32e90254fdb89ec8d0bc5a2299e', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Module)', 'sortName=&nd=1480757458612&pageNo=1&sortOrder=asc&pageSize=20&parentId=1', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '18', '/a/sys/module/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:30:59', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('71b3fd4560ef453798127b59cbb7f7bd', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Module)', 'sortName=&nd=1480757460144&pageNo=0&sortOrder=asc&pageSize=20&parentId=8bfcaa0836a145c3b9cd68c58e1f5aef', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '70', '/a/sys/module/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:31:00', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('6de0600a349f4124a66aaa5dca19000e', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Module)', 'sortName=&nd=1480757462419&pageNo=1&sortOrder=asc&pageSize=20&parentId=fd8be39d8db44c60917633defe9996c0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '26', '/a/sys/module/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:31:02', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('9308b10af8d54df5a0d0825476517ee4', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Module)', 'sortName=&nd=1480757463499&pageNo=1&sortOrder=asc&pageSize=20&parentId=fd8be39d8db44c60917633defe9996c0', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '25', '/a/sys/module/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:31:04', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('53ad4b49892c4224bd3d0f8b45511472', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Module)', 'sortName=&nd=1480757466884&pageNo=1&sortOrder=asc&pageSize=20&parentId=ee5224dc13404267acfb8fc443dee4c3', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '22', '/a/sys/module/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:31:07', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('ac8b1c39761049fdaa844edd90fa5f3f', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Module)', 'sortName=&nd=1480757468114&pageNo=1&sortOrder=asc&pageSize=20&parentId=4715e01a290c447eac93ee47db6b9c81', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '29', '/a/sys/module/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:31:08', null, '0');
INSERT INTO `sys_log_operate_t` VALUES ('164adebacc8e483c9aa000f409cd39d0', '数据模块-系统设置-系统管理-模块管理-查看列表模块', '0', '1', 'admin', '', 'POST', 'public java.lang.String com.albedo.modules.sys.controller.ModuleController.findList(com.albedo.common.domain.PageModel,com.albedo.modules.sys.entity.Module)', 'sortName=&nd=1480757469012&pageNo=1&sortOrder=asc&pageSize=20&parentId=3566c3b5c4114f77a5434c175b9f64c5', '0:0:0:0:0:0:0:1', '@org.apache.shiro.authz.annotation.RequiresPermissions(logical=AND, value=[sys_module_view])', '22', '/a/sys/module/findList', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '2016-12-03 17:31:09', null, '0');

-- ----------------------------
-- Table structure for sys_message_deal_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_deal_t`;
CREATE TABLE `sys_message_deal_t` (
  `id_` varchar(32) NOT NULL,
  `message_id` varchar(32) NOT NULL DEFAULT '0',
  `staff_id` varchar(32) NOT NULL,
  `deal_time` datetime DEFAULT NULL,
  `version_` int(11) DEFAULT NULL,
  `status_` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_message_deal_t
-- ----------------------------
INSERT INTO `sys_message_deal_t` VALUES ('07d4ff2bf38444f1827b28ab3929c2f9', 'e7f47c0b61464282af7fd6dd51398130', '28ef444985d145879e89ee8a757c9dc8', null, null, '0');
INSERT INTO `sys_message_deal_t` VALUES ('08f100a0ce40443a8217e3f5ea306a71', 'e7f47c0b61464282af7fd6dd51398130', '26efce8f247e451b830322269bface41', null, null, '0');
INSERT INTO `sys_message_deal_t` VALUES ('0de1187ee2db4b2b8d24bcac577d141f', 'e7f47c0b61464282af7fd6dd51398130', '383d07235e3a4bcb9cf1eb0d15844d57', null, null, '0');
INSERT INTO `sys_message_deal_t` VALUES ('0e6bda00c98842f9a3d2036c6546d411', 'e7f47c0b61464282af7fd6dd51398130', '04f8a454bc0447e09791b5acf6466799', null, null, '0');
INSERT INTO `sys_message_deal_t` VALUES ('0f2e1302e43d41f9aa77c84e0a3931dc', 'e7f47c0b61464282af7fd6dd51398130', '2d1d5a605d364fccbd0f053416d8ba8e', null, null, '0');
INSERT INTO `sys_message_deal_t` VALUES ('327824ae247d41b99652a3032d5b18c2', 'e7f47c0b61464282af7fd6dd51398130', '216ecd201faa429ca8eed65b219a9463', null, null, '0');
INSERT INTO `sys_message_deal_t` VALUES ('4cb62813a06c406d8451b79271a08c1a', 'a6327bef6fd64b1087561a0d8d392c33', '0d7008a0bf1947dcaddde036d275ea34', null, null, '-2');
INSERT INTO `sys_message_deal_t` VALUES ('71a2c9f54480404f8459a98e6de7c131', 'e7f47c0b61464282af7fd6dd51398130', '21dda8f61196466f8e6e03ef57518091', null, null, '0');
INSERT INTO `sys_message_deal_t` VALUES ('90c3456693894f73b63699b8d5c43649', 'e7f47c0b61464282af7fd6dd51398130', '2dfb5306b52b46af9544212364c27c13', null, null, '0');
INSERT INTO `sys_message_deal_t` VALUES ('949c6ca4e51d4ab6975235cc01fccedb', 'a6327bef6fd64b1087561a0d8d392c33', '04f8a454bc0447e09791b5acf6466799', null, null, '-2');
INSERT INTO `sys_message_deal_t` VALUES ('bb7ba1926f7a4be9a397e4516f160865', 'a6327bef6fd64b1087561a0d8d392c33', '2d1d5a605d364fccbd0f053416d8ba8e', null, null, '-2');
INSERT INTO `sys_message_deal_t` VALUES ('c5ca3a9b128a421e9a53cc943a62f284', 'a6327bef6fd64b1087561a0d8d392c33', '216ecd201faa429ca8eed65b219a9463', null, null, '-2');
INSERT INTO `sys_message_deal_t` VALUES ('c83a2e0a381643ac99ec1529fbbc92a3', 'a6327bef6fd64b1087561a0d8d392c33', 'fe59fb534cb947fba464a55d53c2403e', null, null, '-2');
INSERT INTO `sys_message_deal_t` VALUES ('e7d42e1236754a1eb4644c57947202b1', 'e7f47c0b61464282af7fd6dd51398130', '09471af5826b472790d440e04ab5df5d', null, null, '0');
INSERT INTO `sys_message_deal_t` VALUES ('ee09d960d333468bb2b1aef2bec0ca56', 'a6327bef6fd64b1087561a0d8d392c33', '26efce8f247e451b830322269bface41', null, null, '-2');
INSERT INTO `sys_message_deal_t` VALUES ('ee6d04983642479ba369648841611844', 'a6327bef6fd64b1087561a0d8d392c33', '2dfb5306b52b46af9544212364c27c13', null, null, '-2');
INSERT INTO `sys_message_deal_t` VALUES ('f4e241fc7bb14a82b5a62883224c6d9f', 'd56e63ac4b15463caa8d2f17eba25022', '216ecd201faa429ca8eed65b219a9463', null, null, '-2');
INSERT INTO `sys_message_deal_t` VALUES ('fa465da26da147bba4612e75a5e71636', 'a6327bef6fd64b1087561a0d8d392c33', '09471af5826b472790d440e04ab5df5d', null, null, '-2');

-- ----------------------------
-- Table structure for sys_message_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_t`;
CREATE TABLE `sys_message_t` (
  `id_` varchar(32) NOT NULL DEFAULT '0',
  `type_` varchar(255) DEFAULT NULL,
  `title_` varchar(255) DEFAULT NULL COMMENT '消息主题',
  `content_` varchar(4000) DEFAULT NULL,
  `attachment_` varchar(255) DEFAULT NULL,
  `attach_path` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `message_flag` varchar(255) DEFAULT NULL,
  `sender` varchar(64) DEFAULT NULL COMMENT '发件端',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `reciver` varchar(64) DEFAULT NULL,
  `deal_time` datetime DEFAULT NULL,
  `description_` varchar(255) DEFAULT NULL,
  `version_` int(11) DEFAULT NULL,
  `status_` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FKFBFB834A7A37E1A2` (`sender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_message_t
-- ----------------------------
INSERT INTO `sys_message_t` VALUES ('a6327bef6fd64b1087561a0d8d392c33', '0', 'test', '&lt;p&gt;\r\n	testsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsevvtestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsevvtestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsevvtestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsevvtestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsevvtestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsetestsevv&lt;/p&gt;', null, '', '0', '1', '2015-04-20 15:04:54', '2015-04-20 15:04:54', null, null, null, null, '-2');
INSERT INTO `sys_message_t` VALUES ('d56e63ac4b15463caa8d2f17eba25022', '0', '地对地导弹', '&lt;p&gt;\r\n	顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶v&lt;/p&gt;', null, '', '0', '1', '2015-04-20 15:04:11', '2015-04-20 15:04:11', null, null, null, null, '-2');
INSERT INTO `sys_message_t` VALUES ('e7f47c0b61464282af7fd6dd51398130', '0', 'testest', '&lt;p&gt;\r\n	&lt;span style=&quot;background-color:lime;&quot;&gt;tsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetse&lt;/span&gt;&lt;/p&gt;\r\n&lt;h1&gt;\r\n	&lt;span style=&quot;background-color:lime;&quot;&gt;dfsdfasdfsadfasdfasdf&lt;/span&gt;&lt;/h1&gt;\r\n&lt;p&gt;\r\n	&lt;span style=&quot;background-color:lime;&quot;&gt;dfasdfasdfasdfasd&lt;span style=&quot;background-color:yellow;&quot;&gt;&lt;span style=&quot;font-size:9px;&quot;&gt;sdfasdfasdfasdfsdfad&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;font-size:9px;&quot;&gt;sdfsadfsadfasdfsdfdfda&lt;/span&gt;&lt;/p&gt;', null, '', '0', '1', '2015-04-20 16:42:48', '2015-04-20 16:42:48', null, null, null, null, '0');

-- ----------------------------
-- Table structure for sys_module_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_module_t`;
CREATE TABLE `sys_module_t` (
  `id_` varchar(50) NOT NULL COMMENT '模块编码',
  `name_` varchar(255) DEFAULT '' COMMENT '名称',
  `parent_id` varchar(50) DEFAULT NULL COMMENT '父module的id',
  `parent_ids` varchar(2000) DEFAULT NULL,
  `type_` varchar(50) DEFAULT NULL COMMENT '模块类型  0 菜单模块 1权限模块',
  `permission_` varchar(500) DEFAULT NULL COMMENT '权限标识',
  `sort_` int(11) DEFAULT '0' COMMENT '排序',
  `target_` varchar(255) DEFAULT NULL,
  `url_` varchar(2000) DEFAULT NULL,
  `request_method` varchar(64) DEFAULT NULL COMMENT '请求方法',
  `status_` varchar(2) DEFAULT NULL COMMENT '是否删除  0正常 1不可用',
  `icon_cls` varchar(50) DEFAULT NULL,
  `show_type` varchar(10) DEFAULT '0' COMMENT '针对顶层菜单，0 普通展示下级菜单， 1已树形结构展示',
  `description_` varchar(255) DEFAULT NULL COMMENT '描述',
  `version_` int(11) NOT NULL,
  `is_leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `created_by` varchar(50) NOT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='module表';

-- ----------------------------
-- Records of sys_module_t
-- ----------------------------
INSERT INTO `sys_module_t` VALUES ('00aafae086fe4d6eafc401336ed8620f', '删除', 'ad35950b2e2b42b2824a4ea403e07eb2', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,ad35950b2e2b42b2824a4ea403e07eb2,', '2', 'data_userConsume_delete', '80', null, '/data/userConsume/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 17:34:21', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('024d876a23424ff397c224de2e2939a8', '生成方案配置', 'ee5224dc13404267acfb8fc443dee4c3', '4d32c49cc7f448dcbfb92ce9c4dde058,2d5f2af5e36349b5bb8dfbd5904900c8,ee5224dc13404267acfb8fc443dee4c3,', '1', 'gen_genScheme', '10', '', '/gen/genScheme/', null, '0', 'fa-reddit-square', '0', '', '9', '', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t` VALUES ('03e0ab9426c743428afc48e4b2540334', '锁定', '1a704d407ae54dc697f51cd3993cd683', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,1a704d407ae54dc697f51cd3993cd683,', '2', 'client_cardMoneyFlow_lock', '60', null, '/client/cardMoneyFlow/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 15:46:53', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('03fe0b2bd3d04c98997767c038dd2c30', '油站管理', '7860179350414b4985ea1c73a80206dd', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,', '1', 'gas_station', '30', '', '/gas/station/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 10:27:03', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('0646bf1909c74a4285269ad522dc8ba0', '删除', '696cdba768c645afa6d2dac2c6d40c67', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,696cdba768c645afa6d2dac2c6d40c67,', '2', 'data_clientCompanyAccount_delete', '80', null, '/data/clientCompanyAccount/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 16:03:15', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('07396bbb5bb540c9b8d28f82ba9fbf71', '锁定', 'f121dbf5cd584eddb200c63968065365', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,f121dbf5cd584eddb200c63968065365,', '2', 'client_cardStyle_lock', '60', null, '/client/cardStyle/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-13 14:53:47', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('0771998f75b444f8b2ec0631c69c644f', '字典管理', '3566c3b5c4114f77a5434c175b9f64c5', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,', '1', 'sys_dict', '30', '', '/sys/dict/', 'GET', '0', 'fa-navicon', '0', '', '0', '\0', '1', '2016-12-29 14:27:37', '1', '2016-12-29 14:50:38');
INSERT INTO `sys_module_t` VALUES ('08839f9002b245e4b228b5b816c94b47', '充值明细查询', '9d76a92eb9744a399f8ac8470ff31a9f', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,9d76a92eb9744a399f8ac8470ff31a9f,', '1', 'merchant_select_recharge', '50', '', '/merchant/select/recharge', 'GET', '-2', '', '0', '', '0', '', '1', '2017-02-14 16:37:02', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('08bb2278416a4aaa86a1db7898252791', '编辑', '0771998f75b444f8b2ec0631c69c644f', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,0771998f75b444f8b2ec0631c69c644f,', '2', 'sys_dict_edit', '40', null, '/sys/dict/edit', 'GET,POST', '0', 'fa-pencil', '0', null, '0', '', '1', '2016-12-29 14:27:37', '1', '2016-12-29 14:27:37');
INSERT INTO `sys_module_t` VALUES ('090dcfce0a5f483b99a5b21b55db2539', 'IC卡管理', 'bed876ed10524f9a9e05c1f0e98a2339', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,', '1', '', '30', '', '', null, '-2', 'fa-users', '0', '', '0', '\0', '1', '2017-01-09 15:47:34', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('0b9733254e7a4280a1fd039cc384f98b', '删除', '73f2d7162a46478d8f596b84251fbfa6', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,73f2d7162a46478d8f596b84251fbfa6,', '2', 'gas_stationCompany_delete', '80', null, '/gas/stationCompany/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 14:46:55', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('0ce85de4f54e4ea982f324812002db35', '查看', '03fe0b2bd3d04c98997767c038dd2c30', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,03fe0b2bd3d04c98997767c038dd2c30,', '2', 'gas_station_view', '20', null, '/gas/station/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 10:27:04', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('0dde5b6e17de43e6bbfb7f9d59427cc6', '删除', '9ed591fdbfb7462090e84a22c94cc055', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,9ed591fdbfb7462090e84a22c94cc055,', '2', 'gas_stationHandheldTerminal_delete', '80', null, '/gas/stationHandheldTerminal/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 15:49:55', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('103442bf4bfc4232b46fcb9b2574a005', '订单详情', 'a3ae36b8566e4e8d93ee077ead73d6a1', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,a3ae36b8566e4e8d93ee077ead73d6a1,', '1', 'merchant_profit_order', '20', '', '/merchant/profit/order', 'GET', '-2', 'fa-tags', '0', '', '0', '', '1', '2017-02-06 10:40:43', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('10c64457f77e4b9193c457559562b02d', '锁定', 'ccabf325f5ad495f821c4b848249a32d', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,ccabf325f5ad495f821c4b848249a32d,', '2', 'gas_stationGun_lock', '60', null, '/gas/stationGun/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 15:27:53', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('11999ef9768e423581b59fee4b4d1fef', '编辑', 'f121dbf5cd584eddb200c63968065365', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,f121dbf5cd584eddb200c63968065365,', '2', 'client_cardStyle_edit', '40', null, '/client/cardStyle/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-13 14:53:47', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('11f8167fe2064197985c927c4d25c498', '删除', 'cda7b42d710c44b2b7319a0f42760bcb', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,cda7b42d710c44b2b7319a0f42760bcb,', '2', 'client_card_delete', '80', null, '/client/card/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 17:32:58', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('120268c6884a43db939ad0a5cfa81844', '商户发卡', 'cda7b42d710c44b2b7319a0f42760bcb', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,cda7b42d710c44b2b7319a0f42760bcb,', '1', 'client_card_distribute', '54', '', '/client/card/distribute,/client/card/distributeInfo', 'GET,POST', '-2', '', '0', '', '0', '\0', '1', '2017-02-06 15:20:52', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('124ed1006eb24a97b36e3b9cb742ddac', '充值记录审核', 'b6fb1622a42541f6b19d5bae080300b2', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,', '1', 'data_clientCompanyAccountFlow', '110', '', '/data/clientCompanyAccountFlow/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 17:35:13', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('12e0d76b698c4821b33c46ca7038a52e', '消费流水', '7ae80cfcc9aa441f985f37f13e196493', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,', '1', 'data_userConsumeMoneyFlow', '30', '', '/data/userConsumeMoneyFlow/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-19 16:10:56', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('18537cb41b0d4c2cabe5eba04add75b3', '查看', 'a84f5c9233e14669a7337f2a73efc1cc', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,a84f5c9233e14669a7337f2a73efc1cc,', '2', 'gas_stationMoneyTransferFlow_view', '20', null, '/gas/stationMoneyTransferFlow/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-19 16:07:41', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('1a704d407ae54dc697f51cd3993cd683', 'IC卡流水管理', '7ae80cfcc9aa441f985f37f13e196493', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,', '1', 'client_cardMoneyFlow', '60', '', '/client/cardMoneyFlow/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 15:46:52', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('1c3aab2952af4e73a3eba1db6f85aa74', '锁定', '7b53ee2194894ba687f6f57975bb6529', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,7b53ee2194894ba687f6f57975bb6529,', '2', 'client_cardLimit_lock', '60', null, '/client/cardLimit/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-12 16:07:46', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('1e3626ff2d364719962a82c0d2e1af5a', '锁定', '359d9d9ad76b43889a4e325586751bea', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,359d9d9ad76b43889a4e325586751bea,', '2', 'client_cardOperateFlow_lock', '60', null, '/client/cardOperateFlow/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-13 14:54:25', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('201305b309b0462ab8eb294ab1d42410', '用户管理', '714afd9e5d9f4c0697e502a43a4a2491', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,', '1', 'sys_user', '30', '', '/sys/user/', 'GET', '0', 'fa-users', '0', '', '1', '\0', '1', '2016-12-29 14:54:14', '1', '2017-06-30 15:01:11');
INSERT INTO `sys_module_t` VALUES ('223b8f1345114589ae09681be4744bbc', '操作日志', '4715e01a290c447eac93ee47db6b9c81', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,', '1', 'sys_loggingEvent', '30', '', '/sys/loggingEvent/,/sys/loggingEvent/page', 'GET', '0', 'fa-list-ul', '0', '', '0', '\0', '1', '2017-01-03 14:57:47', '1', '2017-01-04 14:00:42');
INSERT INTO `sys_module_t` VALUES ('23102efeb01f4b80b8687dbd34f7f924', '锁定', 'cda7b42d710c44b2b7319a0f42760bcb', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,cda7b42d710c44b2b7319a0f42760bcb,', '2', 'client_card_lock', '60', null, '/client/card/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 17:32:57', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('2541273f3e05455396904eb6ae843d66', '补卡查询', '9d76a92eb9744a399f8ac8470ff31a9f', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,9d76a92eb9744a399f8ac8470ff31a9f,', '1', 'merchant_select_replenish', '20', '', '/merchant/select/replenish', 'GET', '-2', '', '0', '', '0', '', '1', '2017-02-14 16:33:35', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('25a868347e8f4a6bb68b53925db95692', '编辑机构', 'ce4517a441dc4115a14921419b4d131a', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,ce4517a441dc4115a14921419b4d131a,', '2', 'sys_org_edit', '40', '', '/sys/org/edit', 'GET,POST', '0', '', '0', '', '21', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:11');
INSERT INTO `sys_module_t` VALUES ('28c788e69d2a42d1a7f89679185ab49a', '编辑', '73f2d7162a46478d8f596b84251fbfa6', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,73f2d7162a46478d8f596b84251fbfa6,', '2', 'gas_stationCompany_edit', '40', null, '/gas/stationCompany/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 14:46:54', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('2d5f2af5e36349b5bb8dfbd5904900c8', '代码生成', '4d32c49cc7f448dcbfb92ce9c4dde058', '4d32c49cc7f448dcbfb92ce9c4dde058,', '1', '', '60', '', '', null, '0', 'fa-sliders', '0', '', '6', '\0', '', '2016-12-05 11:29:48', '1', '2017-03-27 15:26:05');
INSERT INTO `sys_module_t` VALUES ('2f1f5d1fae78447798dd0e880ff18836', '删除', '992c331be29c4386a7e86e93ff291ecc', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,992c331be29c4386a7e86e93ff291ecc,', '2', 'client_cardProfitInterval_delete', '80', null, '/client/cardProfitInterval/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-02-04 10:07:30', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('2f7af4d3d2534d03bb413f0073b3347c', '利润统计', 'a3ae36b8566e4e8d93ee077ead73d6a1', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,a3ae36b8566e4e8d93ee077ead73d6a1,', '1', 'merchant_profit_stat', '10', '', '/merchant/profit/stat', 'GET', '-2', 'fa-cny', '0', '', '0', '', '1', '2017-02-06 10:39:07', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('3011372107594043a65f66bca2407f4b', '锁定', 'a16e66a896cb4c2b8b47fe17503750c8', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,a16e66a896cb4c2b8b47fe17503750c8,', '2', 'client_clientCompanyMoneyFlow_lock', '60', null, '/client/clientCompanyMoneyFlow/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-10 11:24:45', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('3566c3b5c4114f77a5434c175b9f64c5', '系统管理', 'fc987e00a31246aea6d2e2a6afe8db36', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,', '1', 'sys', '5', '', '', null, '0', 'fa-gear', '1', '_showTree', '24', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t` VALUES ('359d9d9ad76b43889a4e325586751bea', 'IC卡操作流水', '090dcfce0a5f483b99a5b21b55db2539', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,', '1', 'client_cardOperateFlow', '4', '', '/client/cardOperateFlow/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-13 14:54:24', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('37ceac18a00b4a7ea45c8681035fe402', '模块管理', '3566c3b5c4114f77a5434c175b9f64c5', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,', '1', 'sys_module', '10', '', '/sys/module/', 'GET,POST,PUT', '0', 'fa-sitemap', '0', '', '24', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-29 15:15:58');
INSERT INTO `sys_module_t` VALUES ('3aa0fdaca30e41f6b722983de1c2a399', '平台对账', 'b6fb1622a42541f6b19d5bae080300b2', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,', '1', 'data_finance', '10', '', '/data/finance/', 'GET', '-2', '', '0', '', '0', '\0', '1', '2017-02-10 13:15:18', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('3bb67d9715bd40888e5cbce7ced3b58d', '利润管理', '8be2c19fab0d4b098407f614051798c3', '4d32c49cc7f448dcbfb92ce9c4dde058,8be2c19fab0d4b098407f614051798c3,', '1', 'station_module_profit', '50', '', '/station/profit/index', 'GET', '-2', 'fa-fire', '0', '', '0', '', '1', '2017-01-23 15:26:28', '1', '2017-03-01 13:56:11');
INSERT INTO `sys_module_t` VALUES ('3ce4aa89b1c5483dbc538d3f3ae0a63f', '删除机构', 'ce4517a441dc4115a14921419b4d131a', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,ce4517a441dc4115a14921419b4d131a,', '2', 'sys_org_delete', '80', '', '/sys/org/delete', 'DELETE', '0', '', '0', '', '18', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:11');
INSERT INTO `sys_module_t` VALUES ('3ce73e592a8f46d38618a996c29ef863', '编辑', 'e1f8b38201064edaaf72398851c752b7', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,e1f8b38201064edaaf72398851c752b7,', '2', 'sys_taskScheduleJob_edit', '40', null, '/sys/taskScheduleJob/edit', 'GET,POST', '0', 'fa-pencil', '0', null, '0', '', '1', '2017-01-23 09:55:09', '1', '2017-01-23 09:55:09');
INSERT INTO `sys_module_t` VALUES ('3db270bdb78945fe987b190c3d9b4ba4', '删除', 'd43aeeff1f6d4572b19d0ecd62a3ba51', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,d43aeeff1f6d4572b19d0ecd62a3ba51,', '2', 'gas_stationOilPrice_delete', '80', null, '/gas/stationOilPrice/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-24 17:19:09', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('3dc743ff54734668b45a95dd02276de5', '锁定', '0771998f75b444f8b2ec0631c69c644f', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,0771998f75b444f8b2ec0631c69c644f,', '2', 'sys_dict_lock', '60', null, '/sys/dict/lock', 'POST', '0', 'fa-lock', '0', null, '0', '', '1', '2016-12-29 14:27:37', '1', '2016-12-29 14:27:37');
INSERT INTO `sys_module_t` VALUES ('3deec42f2b1b4febbd34e10fe536c929', '锁定', 'a265b0fef27d4df4a3a0f1be86b885e6', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,4ac7e4c8c2d54d368f31194a8b578fb7,a265b0fef27d4df4a3a0f1be86b885e6,', '2', 'data_oilWholesalePrice_lock', '60', null, '/data/oilWholesalePrice/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-19 16:11:43', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('42baef661e504fa998a35d27b0daa3c4', '账户预览', 'fd8be39d8db44c60917633defe9996c0', '4d32c49cc7f448dcbfb92ce9c4dde058,fd8be39d8db44c60917633defe9996c0,', '1', 'user', '30', '_top', '/index', 'GET', '0', 'fa-leaf', '0', '', '5', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:00:51');
INSERT INTO `sys_module_t` VALUES ('42fcc1668813458bbdc58b9d7933bb93', '卡业务操作', '99be1a381a1f415288354a76219023fc', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,', '1', 'merchant_module_card', '20', '', '/merchant/card', 'GET', '-2', 'fa-credit-card', '0', '', '0', '\0', '1', '2017-01-09 10:02:48', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('44bd189179e6403084a9c89db663d987', '用户管理', '99be1a381a1f415288354a76219023fc', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,', '1', 'merchant_module_user', '30', '', '/merchant/user', 'GET', '-2', 'fa-users', '0', '', '0', '\0', '1', '2017-01-09 10:13:21', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('4715e01a290c447eac93ee47db6b9c81', '资源管理', 'fc987e00a31246aea6d2e2a6afe8db36', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,', '1', '', '30', '', '', null, '0', 'fa-book', '0', '', '15', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 14:46:48');
INSERT INTO `sys_module_t` VALUES ('477d4525ba89481fb8458104e600330c', '查看', '9ed591fdbfb7462090e84a22c94cc055', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,9ed591fdbfb7462090e84a22c94cc055,', '2', 'gas_stationHandheldTerminal_view', '20', null, '/gas/stationHandheldTerminal/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 15:49:54', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('47ace366578f4ad5b334752aca14c0d5', '公众号密码验证', '44bd189179e6403084a9c89db663d987', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,44bd189179e6403084a9c89db663d987,', '2', 'merchant_wechat_password', '40', '', '/wechat/confirmPassword', 'POST', '-2', '', '0', '', '0', '', '1', '2017-02-09 11:29:52', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('4807651e3eaf4140985ddb4a06bec8af', '删除', '8b2884ed8c4145f7b8fc472bdf2db640', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7837f39345fb4dd195a591fe4f722302,8b2884ed8c4145f7b8fc472bdf2db640,', '2', 'client_clientCompany_delete', '80', null, '/client/clientCompany/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 15:56:29', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('4ac7e4c8c2d54d368f31194a8b578fb7', '业务中心', 'bed876ed10524f9a9e05c1f0e98a2339', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,', '1', '', '40', '', '', null, '-2', 'fa-calendar-check-o', '0', '', '0', '\0', '1', '2017-02-16 14:22:05', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('4af7ec96d448483cb6fdc0eff1f2afde', '删除', 'a265b0fef27d4df4a3a0f1be86b885e6', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,a265b0fef27d4df4a3a0f1be86b885e6,', '2', 'data_oilWholesalePrice_delete', '80', null, '/data/oilWholesalePrice/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-19 16:11:44', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('4d32c49cc7f448dcbfb92ce9c4dde058', '数据模块', '', '', '1', 'root', '30', null, null, null, '0', ' fa-reorder', '0', null, '10', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:00:51');
INSERT INTO `sys_module_t` VALUES ('5080f7eb98a64ea7ac1b7be00eb9fa38', '加油员管理', '7860179350414b4985ea1c73a80206dd', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,', '1', 'gas_stationMember', '40', '', '/gas/stationMember/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 14:45:22', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('5293bd1a28924276a236a4363af5dde8', '启用/停用机构', 'ce4517a441dc4115a14921419b4d131a', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,ce4517a441dc4115a14921419b4d131a,', '2', 'sys_org_lock', '60', '', '/sys/org/lock', 'POST', '0', '', '0', '', '19', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('5331d35482604a66bf1e1d98675bd0e5', '结算管理', '8be2c19fab0d4b098407f614051798c3', '4d32c49cc7f448dcbfb92ce9c4dde058,8be2c19fab0d4b098407f614051798c3,', '1', 'station_module_settlement', '40', '', '/station/settlement', 'GET', '-2', 'fa-dot-circle-o', '0', '', '0', '', '1', '2017-01-19 15:36:29', '1', '2017-03-01 13:56:11');
INSERT INTO `sys_module_t` VALUES ('53bddae5c62b492794924ae63af16b38', '查看', '90b88c0d1e6144aebb1846e287a4f2ef', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,90b88c0d1e6144aebb1846e287a4f2ef,', '2', 'client_cardPlan_view', '20', null, '/client/cardPlan/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-12 16:11:28', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('543025a27e6d4d96b00c1eb7638a236c', '锁定', '8a2ac39b8a4a410e97dfe0e3803516d7', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,8a2ac39b8a4a410e97dfe0e3803516d7,', '2', 'client_cardLimit_lock', '60', null, '/client/cardLimit/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-12 16:10:32', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('546898c4ff5543cfbb2cc9d21456990f', '编辑', 'ad35950b2e2b42b2824a4ea403e07eb2', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,ad35950b2e2b42b2824a4ea403e07eb2,', '2', 'data_userConsume_edit', '40', null, '/data/userConsume/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 17:34:20', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('575bbd9ca6ab4b37b83e900efad920f9', '删除', '12e0d76b698c4821b33c46ca7038a52e', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,12e0d76b698c4821b33c46ca7038a52e,', '2', 'data_userConsumeMoneyFlow_delete', '80', null, '/data/userConsumeMoneyFlow/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-19 16:10:57', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('584be5bc35c6478c9ea5e07c57829283', '删除', '03fe0b2bd3d04c98997767c038dd2c30', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,03fe0b2bd3d04c98997767c038dd2c30,', '2', 'gas_station_delete', '80', null, '/gas/station/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 10:27:05', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('590e0f70d9e9408499cbfed1c02cdd84', '锁定', 'e1f8b38201064edaaf72398851c752b7', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,e1f8b38201064edaaf72398851c752b7,', '2', 'sys_taskScheduleJob_lock', '60', null, '/sys/taskScheduleJob/lock', 'POST', '0', 'fa-lock', '0', null, '0', '', '1', '2017-01-23 09:55:09', '1', '2017-01-23 09:55:09');
INSERT INTO `sys_module_t` VALUES ('5baf1423d93d4c5985c5c4d9ecfe71b4', '查看', 'ad35950b2e2b42b2824a4ea403e07eb2', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,ad35950b2e2b42b2824a4ea403e07eb2,', '2', 'data_userConsume_view', '20', null, '/data/userConsume/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 17:34:20', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('5dbb072371bb427aa6c310a55d574f81', '查看', 'a16e66a896cb4c2b8b47fe17503750c8', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,a16e66a896cb4c2b8b47fe17503750c8,', '2', 'client_clientCompanyMoneyFlow_view', '20', '', '/client/clientCompanyMoneyFlow/page,/client/clientCompanyMoneyFlow/export', 'GET', '-2', 'fa-info-circle', '0', '', '0', '\0', '1', '2017-01-10 11:24:44', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('5e3375759e5a481a8618cc1d3cb2f46c', '编辑', 'a84f5c9233e14669a7337f2a73efc1cc', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,a84f5c9233e14669a7337f2a73efc1cc,', '2', 'gas_stationMoneyTransferFlow_edit', '40', null, '/gas/stationMoneyTransferFlow/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-19 16:07:41', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('615bf17335b5462d9bd018fae8ba33b3', '锁定', '696cdba768c645afa6d2dac2c6d40c67', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,696cdba768c645afa6d2dac2c6d40c67,', '2', 'data_clientCompanyAccount_lock', '60', null, '/data/clientCompanyAccount/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 16:03:15', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('6193b5947b0f4b27b593954dff3ea72b', '查看', '7aeb0f1984c2419fbe84dc5879d1a0b7', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,7aeb0f1984c2419fbe84dc5879d1a0b7,', '2', 'gas_stationMemberWorkFlow_view', '20', null, '/gas/stationMemberWorkFlow/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 15:28:58', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('61d035aa9f0547638d8de070ded214f3', '编辑', '7b53ee2194894ba687f6f57975bb6529', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,7b53ee2194894ba687f6f57975bb6529,', '2', 'client_cardLimit_edit', '40', null, '/client/cardLimit/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-12 16:07:45', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('646217274820400785b204d174be1f61', '对账单', '72600215ad154e9eb36bc922ef636008', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,72600215ad154e9eb36bc922ef636008,', '1', 'merchant_reconciliation_bill', '10', '', '/merchant/reconciliation/bill', 'GET', '-2', '', '0', '', '0', '', '1', '2017-01-20 15:45:47', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('64c63d29eb0f4b0ba12f0c5c72b4d5c6', '编辑', '9ed591fdbfb7462090e84a22c94cc055', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,9ed591fdbfb7462090e84a22c94cc055,', '2', 'gas_stationHandheldTerminal_edit', '40', null, '/gas/stationHandheldTerminal/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 15:49:54', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('64ff7211516a4025ab29698a7cf07762', '查看', 'ca5993a9e1ba4574a2ebd61cad0e3b39', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7837f39345fb4dd195a591fe4f722302,ca5993a9e1ba4574a2ebd61cad0e3b39,', '2', 'client_userInfo_view', '20', null, '/client/userInfo/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 15:55:33', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('66da443901984e879fb9cd4c4da1060c', '删除', '7b53ee2194894ba687f6f57975bb6529', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,7b53ee2194894ba687f6f57975bb6529,', '2', 'client_cardLimit_delete', '80', null, '/client/cardLimit/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-12 16:07:46', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('6730c8490f254e86ae11393f60e46fe9', '锁定', '8b2884ed8c4145f7b8fc472bdf2db640', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,8b2884ed8c4145f7b8fc472bdf2db640,', '2', 'client_clientCompany_lock', '60', null, '/client/clientCompany/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 15:56:29', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('696cdba768c645afa6d2dac2c6d40c67', '财务转账管理', 'b6fb1622a42541f6b19d5bae080300b2', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,', '1', 'data_clientCompanyAccount', '120', '', '/data/clientCompanyAccount/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 16:03:13', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('6c223f9f00414e649959b670421348e8', '锁定', '73f2d7162a46478d8f596b84251fbfa6', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,73f2d7162a46478d8f596b84251fbfa6,', '2', 'gas_stationCompany_lock', '60', null, '/gas/stationCompany/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 14:46:54', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('6c9bef0251174471ac56924e7d2d3513', '查看', '5080f7eb98a64ea7ac1b7be00eb9fa38', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,5080f7eb98a64ea7ac1b7be00eb9fa38,', '2', 'gas_stationMember_view', '20', null, '/gas/stationMember/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 14:45:23', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('6fb8b24481c446a5a64441636dc31ef6', '编辑', '7ff7263cb0e24fb48cda7c07e70c4f52', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,7ff7263cb0e24fb48cda7c07e70c4f52,', '2', 'client_clientCompanyMoney_edit', '40', null, '/client/clientCompanyMoney/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 16:11:14', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('6fee63e283b7489085ce05f333701301', '审核', '829077714e8644be85edb6a173f91c59', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,829077714e8644be85edb6a173f91c59,', '1', 'data_clientCompanyAccount_audit', '60', '', '/data/clientCompanyAccount/audit', 'GET,POST', '-2', 'fa-check', '0', '', '0', '', '1', '2017-01-12 17:52:32', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('714afd9e5d9f4c0697e502a43a4a2491', '机构用户', 'fc987e00a31246aea6d2e2a6afe8db36', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,', '1', '', '0', '', '', null, '0', 'fa-dot-circle-o', '0', '', '11', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:11');
INSERT INTO `sys_module_t` VALUES ('72600215ad154e9eb36bc922ef636008', '预分配对账系统', '99be1a381a1f415288354a76219023fc', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,', '1', 'merchant_module_reconciliation', '40', '', '/merchant/reconciliation', 'GET', '-2', 'fa-cog', '0', '', '0', '\0', '1', '2017-01-20 15:42:48', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('7328ecb8c4af40d0b39b8396d184a56b', '锁定', '5080f7eb98a64ea7ac1b7be00eb9fa38', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,5080f7eb98a64ea7ac1b7be00eb9fa38,', '2', 'gas_stationMember_lock', '60', null, '/gas/stationMember/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 14:45:24', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('73f2d7162a46478d8f596b84251fbfa6', '油站公司管理', '7860179350414b4985ea1c73a80206dd', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,', '1', 'gas_stationCompany', '80', '', '/gas/stationCompany/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 14:46:53', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('7445d22ec178408c9a3db960facc0fda', '编辑', '03fe0b2bd3d04c98997767c038dd2c30', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,03fe0b2bd3d04c98997767c038dd2c30,', '2', 'gas_station_edit', '40', null, '/gas/station/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 10:27:04', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('749160f6086f475da6f350543994608e', '查看', 'fa1cf28bbd424fb0b900cf11f10b1817', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,fa1cf28bbd424fb0b900cf11f10b1817,', '2', 'sys_area_view', '20', null, '/sys/area/page', 'GET', '0', 'fa-info-circle', '0', null, '0', '', '1', '2016-12-29 14:31:16', '1', '2016-12-29 14:31:16');
INSERT INTO `sys_module_t` VALUES ('750c6f4a2df041ad82f572b235372630', '查看', '73f2d7162a46478d8f596b84251fbfa6', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,73f2d7162a46478d8f596b84251fbfa6,', '2', 'gas_stationCompany_view', '20', null, '/gas/stationCompany/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 14:46:53', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('75f58401461c486b875f851e18a8ee9d', '锁定', '37ceac18a00b4a7ea45c8681035fe402', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,37ceac18a00b4a7ea45c8681035fe402,', '2', 'sys_module_lock', '60', '', '/sys/module/lock', 'POST', '0', '', null, '', '22', '\0', '', '2016-12-05 11:29:48', '1', '2017-01-04 11:37:58');
INSERT INTO `sys_module_t` VALUES ('761ab47cb4fe4f54b3d8500b0451a093', '编辑', 'ef80fa47eaa84bb88b5d6bd1e197330e', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,ef80fa47eaa84bb88b5d6bd1e197330e,', '1', 'data_clientCompanyAccount_add', '60', '', '/data/clientCompanyAccount/add', 'GET,POST', '-2', 'fa-pencil', '0', '', '0', '', '1', '2017-01-12 17:49:12', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('767ac3317dfb4566b92c1bf820f6402a', '删除', 'e1f8b38201064edaaf72398851c752b7', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,e1f8b38201064edaaf72398851c752b7,', '2', 'sys_taskScheduleJob_delete', '80', null, '/sys/taskScheduleJob/delete', 'DELETE', '0', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-23 09:55:10', '1', '2017-01-23 09:55:10');
INSERT INTO `sys_module_t` VALUES ('7837f39345fb4dd195a591fe4f722302', '商户管理', 'bed876ed10524f9a9e05c1f0e98a2339', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,', '1', '', '40', '', '', null, '-2', 'fa-hand-paper-o', '0', '', '0', '\0', '1', '2017-02-16 14:05:09', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('7860179350414b4985ea1c73a80206dd', '油站中心', 'bed876ed10524f9a9e05c1f0e98a2339', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,', '1', '', '60', '', '', null, '-2', 'fa-cube', '0', '', '0', '\0', '1', '2017-01-09 14:42:28', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('797925f43d9340b9a5260474697c6e2e', '删除', '5080f7eb98a64ea7ac1b7be00eb9fa38', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,5080f7eb98a64ea7ac1b7be00eb9fa38,', '2', 'gas_stationMember_delete', '80', null, '/gas/stationMember/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 14:45:24', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('79b7c6c6f4cd45b08e624118fe0c6215', '查询', '42fcc1668813458bbdc58b9d7933bb93', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,42fcc1668813458bbdc58b9d7933bb93,', '1', 'merchant_card_select', '50', '', '/merchant/card/select', 'GET', '-2', '', '0', '', '0', '\0', '1', '2017-01-09 10:11:24', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('7ae80cfcc9aa441f985f37f13e196493', '数据中心', 'bed876ed10524f9a9e05c1f0e98a2339', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,', '1', '', '90', '', '', null, '-2', 'fa-reorder', '0', '', '0', '\0', '1', '2017-01-09 15:58:37', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('7aeb0f1984c2419fbe84dc5879d1a0b7', '加油员上下班流水', '7860179350414b4985ea1c73a80206dd', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,', '1', 'gas_stationMemberWorkFlow', '45', '', '/gas/stationMemberWorkFlow/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 15:28:57', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('7b53ee2194894ba687f6f57975bb6529', '限制方案管理', '090dcfce0a5f483b99a5b21b55db2539', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,', '1', 'client_cardLimit', '30', null, '/client/cardLimit/', 'GET', '-2', 'fa-file', '0', null, '0', '\0', '1', '2017-01-12 16:07:44', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('7e24021c250a4b7bab12d9f605cd19b9', '批量入库', 'cda7b42d710c44b2b7319a0f42760bcb', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,cda7b42d710c44b2b7319a0f42760bcb,', '1', 'client_card_storage', '52', '', '/client/card/storage,/client/card/findStorageTemplate', 'GET,POST', '-2', '', '0', '', '0', '', '1', '2017-02-06 15:22:18', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('7e8bb6f4551b4f55a9dea35e97bafec2', '锁定', '7ff7263cb0e24fb48cda7c07e70c4f52', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,7ff7263cb0e24fb48cda7c07e70c4f52,', '2', 'client_clientCompanyMoney_lock', '60', null, '/client/clientCompanyMoney/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 16:11:15', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('7f1a3558ebdc451c83223b702d6aa48c', '查看', '7ff7263cb0e24fb48cda7c07e70c4f52', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,7ff7263cb0e24fb48cda7c07e70c4f52,', '2', 'client_clientCompanyMoney_view', '20', null, '/client/clientCompanyMoney/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 16:11:14', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('7ff1ee3bd23845b8a1d7ef8df661bb0d', '编辑', '37ceac18a00b4a7ea45c8681035fe402', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,37ceac18a00b4a7ea45c8681035fe402,', '2', 'sys_module_edit', '40', '', '/sys/module/edit', 'GET,POST', '0', 'fa-pencil', '0', '', '27', '\0', '', '2016-12-05 11:29:48', '1', '2017-01-04 11:37:46');
INSERT INTO `sys_module_t` VALUES ('7ff7263cb0e24fb48cda7c07e70c4f52', '企业账户管理', '090dcfce0a5f483b99a5b21b55db2539', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,', '1', 'client_clientCompanyMoney', '30', null, '/client/clientCompanyMoney/', 'GET', '-2', 'fa-file', '0', null, '0', '\0', '1', '2017-01-09 16:11:13', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('801c146f0db9483f8355be6fa48890c2', '单卡预分配', '42fcc1668813458bbdc58b9d7933bb93', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,42fcc1668813458bbdc58b9d7933bb93,', '1', 'merchant_card_recharge', '20', '', '/merchant/card/recharge', 'GET', '-2', '', '0', '', '0', '\0', '1', '2017-01-09 10:07:21', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('823cd29aec9c4cc09897be22dd9eb5f5', '个人用户', '44bd189179e6403084a9c89db663d987', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,44bd189179e6403084a9c89db663d987,', '1', 'merchant_user_individual', '10', '', '/merchant/user/individual', 'GET', '-2', '', '0', '', '0', '\0', '1', '2017-01-09 10:16:55', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('826137d6389f4730abb0422d7d252b32', '回话管理', '4715e01a290c447eac93ee47db6b9c81', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,', '1', 'sys_persistentToken_view', '30', '', '/sys/persistentToken/,/sys/persistentToken/page', 'GET', '0', 'fa-stack-exchange', '0', '', '0', '', '1', '2017-01-04 14:05:52', '1', '2017-01-04 14:05:52');
INSERT INTO `sys_module_t` VALUES ('829077714e8644be85edb6a173f91c59', '财务审核', 'b6fb1622a42541f6b19d5bae080300b2', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,', '1', 'data_clientCompanyAccount_listAudit', '100', '', '/data/clientCompanyAccount/listAudit', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-12 17:50:31', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('83d7229e1d5a49898de7c044b83db9b2', '删除', '8a2ac39b8a4a410e97dfe0e3803516d7', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,8a2ac39b8a4a410e97dfe0e3803516d7,', '2', 'client_cardLimit_delete', '80', null, '/client/cardLimit/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-12 16:10:32', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('87825137dec44ea5b04b9e43df1a1d5e', '修改密码', 'fd8be39d8db44c60917633defe9996c0', '4d32c49cc7f448dcbfb92ce9c4dde058,fd8be39d8db44c60917633defe9996c0,', '1', '', '60', '', '/api/account/changePassword', 'GET', '0', 'fa-lock', '0', '', '20', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:00:51');
INSERT INTO `sys_module_t` VALUES ('8926dc0c69304cfb8aa88bcfdd45cd5f', '多卡预分配', '42fcc1668813458bbdc58b9d7933bb93', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,42fcc1668813458bbdc58b9d7933bb93,', '1', 'merchant_card_activation', '10', '', '/merchant/card/activation', 'GET', '-2', '', '0', '', '0', '\0', '1', '2017-01-09 10:06:27', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('8995c4f6538d44d59e00a7991ce06a8d', '删除', '1a704d407ae54dc697f51cd3993cd683', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,1a704d407ae54dc697f51cd3993cd683,', '2', 'client_cardMoneyFlow_delete', '80', null, '/client/cardMoneyFlow/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 15:46:53', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('89e53e7369dc4893ae3ab31da73e3687', '账户概览', '8be2c19fab0d4b098407f614051798c3', '4d32c49cc7f448dcbfb92ce9c4dde058,8be2c19fab0d4b098407f614051798c3,', '1', 'station_module_index', '10', '', '/station/index', 'GET', '-2', 'fa-home', '0', '', '0', '', '1', '2017-01-19 15:31:19', '1', '2017-03-01 13:56:11');
INSERT INTO `sys_module_t` VALUES ('8a2ac39b8a4a410e97dfe0e3803516d7', 'IC卡限制管理', '090dcfce0a5f483b99a5b21b55db2539', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,', '1', 'client_cardLimit', '5', '', '/client/cardLimit/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-12 16:10:31', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('8b2884ed8c4145f7b8fc472bdf2db640', '商户管理', '7837f39345fb4dd195a591fe4f722302', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7837f39345fb4dd195a591fe4f722302,', '1', 'client_clientCompany', '10', '', '/client/clientCompany/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 15:56:27', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('8be2c19fab0d4b098407f614051798c3', '加油站后台', '4d32c49cc7f448dcbfb92ce9c4dde058', '4d32c49cc7f448dcbfb92ce9c4dde058,', '1', '', '90', '', '', null, '-2', 'fa-institution', '0', '', '0', '\0', '1', '2017-01-19 15:21:30', '1', '2017-03-01 13:56:11');
INSERT INTO `sys_module_t` VALUES ('8c049f8b4e2744bda39b74dd2614e863', '锁定', '90b88c0d1e6144aebb1846e287a4f2ef', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,90b88c0d1e6144aebb1846e287a4f2ef,', '2', 'client_cardPlan_lock', '60', null, '/client/cardPlan/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-12 16:11:29', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('8d607e3d86ad436b89e3067323021168', '系统监控', '4715e01a290c447eac93ee47db6b9c81', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,', '1', 'sys_metrics', '0', '', '/sys/metrics,/management/metrics/', 'GET', '0', 'fa-drupal', null, '', '1', '', '', '2017-03-02 23:03:19', '1', '2017-06-30 14:46:48');
INSERT INTO `sys_module_t` VALUES ('8e21d10003694354822fe0ad44106ce0', '业务表配置', 'ee5224dc13404267acfb8fc443dee4c3', '4d32c49cc7f448dcbfb92ce9c4dde058,2d5f2af5e36349b5bb8dfbd5904900c8,ee5224dc13404267acfb8fc443dee4c3,', '1', 'gen_genTable', '100', '', '/gen/genTable/', null, '0', 'fa-delicious', '0', '', '10', '', '', '2016-12-05 11:29:48', '1', '2016-12-25 17:13:13');
INSERT INTO `sys_module_t` VALUES ('8eae4c0c642a43eba9de678d36ca9186', '删除', '201305b309b0462ab8eb294ab1d42410', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,201305b309b0462ab8eb294ab1d42410,', '2', 'sys_user_delete', '80', null, '/sys/user/delete', 'DELETE', '0', 'fa-trash-o', '0', null, '1', '', '1', '2016-12-29 14:54:15', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('8f6e8fcc5b5141e298a1ab9eefe55eb9', '锁定', '223b8f1345114589ae09681be4744bbc', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,223b8f1345114589ae09681be4744bbc,', '2', 'sys_loggingEvent_lock', '60', null, '/sys/loggingEvent/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-03 14:57:50', '1', '2017-01-04 11:36:33');
INSERT INTO `sys_module_t` VALUES ('9008b275f589473fb6398a6e05e6bbe0', '查看', '829077714e8644be85edb6a173f91c59', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,829077714e8644be85edb6a173f91c59,', '1', 'data_clientCompanyAccount_pageAdudit', '30', '', '/data/clientCompanyAccount/pageAudit', 'GET', '-2', 'fa-info-circle', '0', '', '0', '', '1', '2017-01-12 17:51:27', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('909fe4ec38f548b0839ea2279e1be69b', '编辑', '12e0d76b698c4821b33c46ca7038a52e', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,12e0d76b698c4821b33c46ca7038a52e,', '2', 'data_userConsumeMoneyFlow_edit', '40', null, '/data/userConsumeMoneyFlow/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-19 16:10:57', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('90b88c0d1e6144aebb1846e287a4f2ef', 'IC卡限制方案管理', '090dcfce0a5f483b99a5b21b55db2539', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,', '1', 'client_cardPlan', '3', '', '/client/cardPlan/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-12 16:11:28', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('919cce8e6f0c426c831f9c478f79fd13', '分配角色', 'bd7872df2fe748fb97bb1dcc629cdecb', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,bd7872df2fe748fb97bb1dcc629cdecb,', '2', 'sys_role_assign', '0', '', '', null, '-2', '', '0', '', '10', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('93eb238f76874dc78fcf10afb067e9d2', '查看', 'e1f8b38201064edaaf72398851c752b7', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,e1f8b38201064edaaf72398851c752b7,', '2', 'sys_taskScheduleJob_view', '20', null, '/sys/taskScheduleJob/page', 'GET', '0', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-23 09:55:09', '1', '2017-01-23 09:55:09');
INSERT INTO `sys_module_t` VALUES ('95179bf3e741428f9b101ce5fbdea0d5', '查看', '359d9d9ad76b43889a4e325586751bea', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,359d9d9ad76b43889a4e325586751bea,', '2', 'client_cardOperateFlow_view', '20', null, '/client/cardOperateFlow/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-13 14:54:24', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('952e4f8ac58b428585274e3850d47e31', '锁定', '124ed1006eb24a97b36e3b9cb742ddac', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,124ed1006eb24a97b36e3b9cb742ddac,', '2', 'data_clientCompanyAccountFlow_lock', '60', null, '/data/clientCompanyAccountFlow/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 17:35:14', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('95a093b48f1947818d50fe09eab72753', '编辑', 'bd7872df2fe748fb97bb1dcc629cdecb', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,bd7872df2fe748fb97bb1dcc629cdecb,', '2', 'sys_role_edit', '20', '', '/sys/role/edit', 'GET,POST', '0', '', '0', '', '29', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('95f08d8e746d4427a5b322ef4736a644', '删除', '7ff7263cb0e24fb48cda7c07e70c4f52', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,7ff7263cb0e24fb48cda7c07e70c4f52,', '2', 'client_clientCompanyMoney_delete', '80', null, '/client/clientCompanyMoney/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 16:11:15', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('96f6994b088449249b6ac23ae962ed50', '查看', 'd5f7cf80752247c9ab29b8532d970ad9', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,d5f7cf80752247c9ab29b8532d970ad9,', '2', 'client_cardProfit_view', '20', null, '/client/cardProfit/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-02-04 10:06:11', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('97e68ff89d69402a9fff0825278e9b20', '锁定', '7aeb0f1984c2419fbe84dc5879d1a0b7', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,7aeb0f1984c2419fbe84dc5879d1a0b7,', '2', 'gas_stationMemberWorkFlow_lock', '60', null, '/gas/stationMemberWorkFlow/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 15:28:59', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('992c331be29c4386a7e86e93ff291ecc', '分利区间管理', '090dcfce0a5f483b99a5b21b55db2539', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,', '1', 'client_cardProfitInterval', '30', null, '/client/cardProfitInterval/', 'GET', '-2', 'fa-file', '0', null, '0', '\0', '1', '2017-02-04 10:07:28', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('99be1a381a1f415288354a76219023fc', '商户后台', '4d32c49cc7f448dcbfb92ce9c4dde058', '4d32c49cc7f448dcbfb92ce9c4dde058,', '1', '', '90', '', '', null, '-2', '', '0', '', '0', '\0', '1', '2017-01-09 10:20:19', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('9a7690b08a544237949cbe016a3e41cd', '编辑', '8b2884ed8c4145f7b8fc472bdf2db640', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,8b2884ed8c4145f7b8fc472bdf2db640,', '2', 'client_clientCompany_edit', '40', null, '/client/clientCompany/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 15:56:28', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('9bb46dcd560c48a98f7c227e364147aa', '购油管理', '8be2c19fab0d4b098407f614051798c3', '4d32c49cc7f448dcbfb92ce9c4dde058,8be2c19fab0d4b098407f614051798c3,', '1', 'station_module_purchase', '30', '', '/station/purchase', 'GET', '-2', 'fa-database', '0', '', '0', '\0', '1', '2017-01-19 15:34:43', '1', '2017-03-01 13:56:11');
INSERT INTO `sys_module_t` VALUES ('9cdd4ff979ca4633b0942f2a320df303', '锁定', 'd43aeeff1f6d4572b19d0ecd62a3ba51', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,d43aeeff1f6d4572b19d0ecd62a3ba51,', '2', 'gas_stationOilPrice_lock', '60', null, '/gas/stationOilPrice/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-24 17:19:08', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('9d76a92eb9744a399f8ac8470ff31a9f', '卡业务查询', '99be1a381a1f415288354a76219023fc', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,', '1', 'merchant_module_select', '25', '', '/merchant/select', 'GET', '-2', 'fa-search', '0', '', '0', '\0', '1', '2017-02-14 16:23:24', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('9ed591fdbfb7462090e84a22c94cc055', '手表管理', '7860179350414b4985ea1c73a80206dd', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,', '1', 'gas_stationHandheldTerminal', '60', '', '/gas/stationHandheldTerminal/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 15:49:53', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('9fec2607b166460cb99d9ed2436be506', '接口管理', '4715e01a290c447eac93ee47db6b9c81', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,', '1', '', '30', '_blank', '/../swagger-ui/index.html', 'GET', '0', 'fa-hand-pointer-o', '0', '', '2', '', '1', '2017-01-05 17:48:44', '1', '2017-06-30 14:34:09');
INSERT INTO `sys_module_t` VALUES ('a0a92a1a64f64e17a022d2cba358cedd', '查看', '1a704d407ae54dc697f51cd3993cd683', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,1a704d407ae54dc697f51cd3993cd683,', '2', 'client_cardMoneyFlow_view', '20', '', '/client/cardMoneyFlow/page,/client/cardMoneyFlow/export', 'GET', '-2', 'fa-info-circle', '0', '', '0', '\0', '1', '2017-01-09 15:46:52', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('a16e66a896cb4c2b8b47fe17503750c8', '企业预付款流水', '7ae80cfcc9aa441f985f37f13e196493', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,', '1', 'client_clientCompanyMoneyFlow', '50', '', '/client/clientCompanyMoneyFlow/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-10 11:24:43', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('a1a208ed4552454a9a11a9c622ff3b15', '油价设置', '8be2c19fab0d4b098407f614051798c3', '4d32c49cc7f448dcbfb92ce9c4dde058,8be2c19fab0d4b098407f614051798c3,', '1', 'station_module_price', '15', '', '/station/price', 'GET', '-2', 'fa-flask', '0', '', '0', '\0', '1', '2017-01-23 11:18:14', '1', '2017-03-01 13:56:11');
INSERT INTO `sys_module_t` VALUES ('a265b0fef27d4df4a3a0f1be86b885e6', '油品价格管理', '4ac7e4c8c2d54d368f31194a8b578fb7', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,4ac7e4c8c2d54d368f31194a8b578fb7,', '1', 'data_oilWholesalePrice', '30', '', '/data/oilWholesalePrice/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-19 16:11:42', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('a3642765916b4733be1c8e6257848de6', '批量添加', 'cda7b42d710c44b2b7319a0f42760bcb', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,cda7b42d710c44b2b7319a0f42760bcb,', '2', 'client_card_editMultiple', '50', '', '/client/card/editMultiple,/client/card/editMultipleInfo', 'GET,POST', '-2', '', '0', '', '0', '\0', '1', '2017-02-06 15:17:57', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('a39c3e8b63234b7689acc86d009334c9', '锁定', 'd5f7cf80752247c9ab29b8532d970ad9', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,d5f7cf80752247c9ab29b8532d970ad9,', '2', 'client_cardProfit_lock', '60', null, '/client/cardProfit/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-02-04 10:06:12', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('a3ae36b8566e4e8d93ee077ead73d6a1', '利润系统', '99be1a381a1f415288354a76219023fc', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,', '1', 'merchant_module_profit', '50', '', '/merchant/profit', 'GET', '-2', 'fa-fire', '0', '', '0', '\0', '1', '2017-02-04 18:03:31', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('a74c306c7ec4488caad5ec5acb7212b3', '删除', 'd5f7cf80752247c9ab29b8532d970ad9', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,d5f7cf80752247c9ab29b8532d970ad9,', '2', 'client_cardProfit_delete', '80', null, '/client/cardProfit/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-02-04 10:06:12', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('a755575dbbb04733ae90a17556bd0fe8', '编辑', 'a16e66a896cb4c2b8b47fe17503750c8', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,a16e66a896cb4c2b8b47fe17503750c8,', '2', 'client_clientCompanyMoneyFlow_edit', '40', null, '/client/clientCompanyMoneyFlow/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-10 11:24:44', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('a7e552c43fb54ffe96725ce6d81532e9', '查看', '12e0d76b698c4821b33c46ca7038a52e', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,12e0d76b698c4821b33c46ca7038a52e,', '2', 'data_userConsumeMoneyFlow_view', '20', '', '/data/userConsumeMoneyFlow/page,/data/userConsumeMoneyFlow/export', 'GET', '-2', 'fa-info-circle', '0', '', '0', '\0', '1', '2017-01-19 16:10:56', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('a7f4acbf1e3648a8b22cb034c6b4cf31', '查看', '992c331be29c4386a7e86e93ff291ecc', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,992c331be29c4386a7e86e93ff291ecc,', '2', 'client_cardProfitInterval_view', '20', null, '/client/cardProfitInterval/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-02-04 10:07:29', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('a84f5c9233e14669a7337f2a73efc1cc', '油站打款管理', 'b6fb1622a42541f6b19d5bae080300b2', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,', '1', 'gas_stationMoneyTransferFlow', '101', '', '/gas/stationMoneyTransferFlow/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-19 16:07:40', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('aa0e54f897854086b0a52498a3ec9918', '挂失查询', '9d76a92eb9744a399f8ac8470ff31a9f', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,9d76a92eb9744a399f8ac8470ff31a9f,', '1', 'merchant_select_deactivation', '30', '', '/merchant/select/deactivation', 'GET', '-2', '', '0', '', '0', '', '1', '2017-02-14 16:34:54', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('ab3d9c1763e74b16ae71f84fc6f55294', '查看', 'f121dbf5cd584eddb200c63968065365', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,f121dbf5cd584eddb200c63968065365,', '2', 'client_cardStyle_view', '20', null, '/client/cardStyle/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-13 14:53:46', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('ab64f406899d4e0089dc6a3d64ced615', '锁定', 'a84f5c9233e14669a7337f2a73efc1cc', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,a84f5c9233e14669a7337f2a73efc1cc,', '2', 'gas_stationMoneyTransferFlow_lock', '60', null, '/gas/stationMoneyTransferFlow/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-19 16:07:41', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('abd42541d2614a7d9f117ce857645382', '删除', '37ceac18a00b4a7ea45c8681035fe402', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,37ceac18a00b4a7ea45c8681035fe402,', '2', 'sys_module_delete', '80', '', '/sys/module/delete', 'DELETE', '0', '', null, '', '20', '\0', '', '2016-12-05 11:29:48', '1', '2017-01-04 11:38:04');
INSERT INTO `sys_module_t` VALUES ('ac2d70f3a3a149e58d260d8da845c32e', '编辑', 'ccabf325f5ad495f821c4b848249a32d', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,ccabf325f5ad495f821c4b848249a32d,', '2', 'gas_stationGun_edit', '40', null, '/gas/stationGun/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 15:27:52', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('ac6f313a57c94fb79480d6a9ece88ab5', '删除', 'a16e66a896cb4c2b8b47fe17503750c8', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,a16e66a896cb4c2b8b47fe17503750c8,', '2', 'client_clientCompanyMoneyFlow_delete', '80', null, '/client/clientCompanyMoneyFlow/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-10 11:24:45', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('acdc3fb3183c4c8faf5fc167e72de8de', '编辑', 'cda7b42d710c44b2b7319a0f42760bcb', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,cda7b42d710c44b2b7319a0f42760bcb,', '2', 'client_card_edit', '40', null, '/client/card/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 17:32:57', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('ad35950b2e2b42b2824a4ea403e07eb2', '消费管理', '7ae80cfcc9aa441f985f37f13e196493', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,', '1', 'data_userConsume', '30', null, '/data/userConsume/', 'GET', '-2', 'fa-file', '0', null, '0', '\0', '1', '2017-01-09 17:34:19', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('af6294af4db4487c930125b40212f6ac', '查看', '37ceac18a00b4a7ea45c8681035fe402', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,37ceac18a00b4a7ea45c8681035fe402,', '2', 'sys_module_view', '20', '', '/sys/module/page', 'GET', '0', 'fa-info-circle', '0', '', '29', '\0', '', '2016-12-05 11:29:48', '1', '2017-01-04 11:37:32');
INSERT INTO `sys_module_t` VALUES ('afb54abea1164a76a790064f4bf2263c', '删除', '223b8f1345114589ae09681be4744bbc', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,223b8f1345114589ae09681be4744bbc,', '2', 'sys_loggingEvent_delete', '80', null, '/sys/loggingEvent/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-03 14:57:50', '1', '2017-01-04 11:36:37');
INSERT INTO `sys_module_t` VALUES ('b126bea42de7411283c79f6c1fca3533', '查看', '7b53ee2194894ba687f6f57975bb6529', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,7b53ee2194894ba687f6f57975bb6529,', '2', 'client_cardLimit_view', '20', null, '/client/cardLimit/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-12 16:07:45', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('b394c822b2b34ff6b9f2409be1466401', '编辑', '359d9d9ad76b43889a4e325586751bea', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,359d9d9ad76b43889a4e325586751bea,', '2', 'client_cardOperateFlow_edit', '40', null, '/client/cardOperateFlow/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-13 14:54:25', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('b3b338d90444429aa841b94ab8dc6768', '编辑', '1a704d407ae54dc697f51cd3993cd683', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,1a704d407ae54dc697f51cd3993cd683,', '2', 'client_cardMoneyFlow_edit', '40', null, '/client/cardMoneyFlow/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 15:46:53', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('b4dc5bb4a11149d78c765dbef12e13c7', '删除', 'fa1cf28bbd424fb0b900cf11f10b1817', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,fa1cf28bbd424fb0b900cf11f10b1817,', '2', 'sys_area_delete', '80', null, '/sys/area/delete', 'DELETE', '0', 'fa-trash-o', '0', null, '0', '', '1', '2016-12-29 14:31:16', '1', '2016-12-29 14:31:16');
INSERT INTO `sys_module_t` VALUES ('b57911172bf74bceae6e22e706d83fb8', '锁定', '201305b309b0462ab8eb294ab1d42410', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,201305b309b0462ab8eb294ab1d42410,', '2', 'sys_user_lock', '60', '', '/sys/user/lock', 'POST', '0', 'fa-lock', null, '', '1', '\0', '1', '2017-03-02 22:25:04', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('b5d3e3b0bdcc49bcb5b8f17a7905660c', '锁定', 'ca5993a9e1ba4574a2ebd61cad0e3b39', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,ca5993a9e1ba4574a2ebd61cad0e3b39,', '2', 'client_userInfo_lock', '60', null, '/client/userInfo/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 15:55:34', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('b6fb1622a42541f6b19d5bae080300b2', '财务管理', 'bed876ed10524f9a9e05c1f0e98a2339', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,', '1', '', '10', '', '', null, '-2', 'fa-calculator', '0', '', '0', '\0', '1', '2017-02-10 13:14:02', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('b7614091d6884c74a0908bb64e5cbd9e', '编辑', 'a265b0fef27d4df4a3a0f1be86b885e6', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,a265b0fef27d4df4a3a0f1be86b885e6,', '2', 'data_oilWholesalePrice_edit', '40', null, '/data/oilWholesalePrice/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-19 16:11:43', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('b7cf4af71dd44b1082f35a60d53232d6', '查看', 'd43aeeff1f6d4572b19d0ecd62a3ba51', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,d43aeeff1f6d4572b19d0ecd62a3ba51,', '2', 'gas_stationOilPrice_view', '20', null, '/gas/stationOilPrice/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-24 17:19:08', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('b86c7839963f47a9a3ead088b9a50b64', '查看', '696cdba768c645afa6d2dac2c6d40c67', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,696cdba768c645afa6d2dac2c6d40c67,', '2', 'data_clientCompanyAccount_view', '20', null, '/data/clientCompanyAccount/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 16:03:14', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('badfe0b992fd4f79b1dfcc2494a47e76', '删除', 'bd7872df2fe748fb97bb1dcc629cdecb', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,bd7872df2fe748fb97bb1dcc629cdecb,', '2', 'sys_role_delete', '40', '', '/sys/role/delete', 'DELETE', '0', '', '0', '', '26', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('bc779f2d65da44ad8397a8ff5976ac65', '查看', 'bd7872df2fe748fb97bb1dcc629cdecb', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,bd7872df2fe748fb97bb1dcc629cdecb,', '2', 'sys_role_view', '10', '', '/sys/role/page', 'GET', '0', '', '0', '', '28', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('bcdfeacfc0d043849743e4e7b256e40e', '挂失', '42fcc1668813458bbdc58b9d7933bb93', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,42fcc1668813458bbdc58b9d7933bb93,', '1', 'merchant_card_deactivate', '40', '', '/merchant/card/deactivate', 'GET', '-2', '', '0', '', '0', '\0', '1', '2017-01-09 10:10:34', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('bd7872df2fe748fb97bb1dcc629cdecb', '角色管理', '714afd9e5d9f4c0697e502a43a4a2491', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,', '1', 'sys_role', '90', '', '/sys/role/', 'GET', '0', 'fa-reorder', '0', '', '26', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('bde070578f80403a879d9fcfd6c4dc62', '删除', 'f121dbf5cd584eddb200c63968065365', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,f121dbf5cd584eddb200c63968065365,', '2', 'client_cardStyle_delete', '80', null, '/client/cardStyle/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-13 14:53:47', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('be56fac59d6f4cb3a58817b6f8cf46b4', '锁定', '992c331be29c4386a7e86e93ff291ecc', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,992c331be29c4386a7e86e93ff291ecc,', '2', 'client_cardProfitInterval_lock', '60', null, '/client/cardProfitInterval/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-02-04 10:07:30', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('bed876ed10524f9a9e05c1f0e98a2339', '后台管理', '4d32c49cc7f448dcbfb92ce9c4dde058', '4d32c49cc7f448dcbfb92ce9c4dde058,', '1', '', '80', '', '', null, '-2', 'fa-cubes', '0', '', '0', '\0', '1', '2017-01-04 10:08:12', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('c361a985cf2d449ba88d901a46217a67', '查看', '8a2ac39b8a4a410e97dfe0e3803516d7', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,8a2ac39b8a4a410e97dfe0e3803516d7,', '2', 'client_cardLimit_view', '20', null, '/client/cardLimit/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-12 16:10:31', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('ca5993a9e1ba4574a2ebd61cad0e3b39', '商户员工管理', '7837f39345fb4dd195a591fe4f722302', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7837f39345fb4dd195a591fe4f722302,', '1', 'client_userInfo', '100', '', '/client/userInfo/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 15:55:32', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('cb598b67d0df446f989d7f084db89ea6', '编辑', '7aeb0f1984c2419fbe84dc5879d1a0b7', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,7aeb0f1984c2419fbe84dc5879d1a0b7,', '2', 'gas_stationMemberWorkFlow_edit', '40', null, '/gas/stationMemberWorkFlow/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 15:28:58', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('cbe75c6f3aa3443a85321bdec9a5c4b1', '编辑', 'ca5993a9e1ba4574a2ebd61cad0e3b39', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,ca5993a9e1ba4574a2ebd61cad0e3b39,', '2', 'client_userInfo_edit', '40', null, '/client/userInfo/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 15:55:34', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('ccab7469d8df473c8ff769437f6bd393', '锁定', 'bd7872df2fe748fb97bb1dcc629cdecb', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,bd7872df2fe748fb97bb1dcc629cdecb,', '2', 'sys_role_lock', '30', '', '/sys/role/lock', 'POST', '0', '', '0', '', '1', '\0', '1', '2016-12-28 16:53:19', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('ccabf325f5ad495f821c4b848249a32d', '加油枪管理', '7860179350414b4985ea1c73a80206dd', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,', '1', 'gas_stationGun', '50', '', '/gas/stationGun/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 15:27:51', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('cda7b42d710c44b2b7319a0f42760bcb', 'IC卡管理', '090dcfce0a5f483b99a5b21b55db2539', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,', '1', 'client_card', '1', '', '/client/card/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-09 17:32:56', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('ce4517a441dc4115a14921419b4d131a', '机构管理', '714afd9e5d9f4c0697e502a43a4a2491', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,', '1', 'sys_org', '60', '', '/sys/org/', 'GET', '0', 'fa-th-large', '0', '', '24', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('cf69bae7a5014ea4885d645ab128b02c', '编辑', '992c331be29c4386a7e86e93ff291ecc', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,992c331be29c4386a7e86e93ff291ecc,', '2', 'client_cardProfitInterval_edit', '40', null, '/client/cardProfitInterval/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-02-04 10:07:29', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('cfd37cfb27fc42daa6366cba9f257e6f', '账户信息', 'fd8be39d8db44c60917633defe9996c0', '4d32c49cc7f448dcbfb92ce9c4dde058,fd8be39d8db44c60917633defe9996c0,', '1', '', '40', '', '/sys/user/info', null, '-2', 'fa-credit-card', '0', '', '21', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:00:51');
INSERT INTO `sys_module_t` VALUES ('d25ce671dc50495c97d936172033cf04', '删除', '90b88c0d1e6144aebb1846e287a4f2ef', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,90b88c0d1e6144aebb1846e287a4f2ef,', '2', 'client_cardPlan_delete', '80', null, '/client/cardPlan/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-12 16:11:30', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('d3fbb00ddb894022ad8d386022f07727', '补卡', '42fcc1668813458bbdc58b9d7933bb93', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,42fcc1668813458bbdc58b9d7933bb93,', '1', 'merchant_card_replenish', '30', '', '/merchant/card/replenish', 'GET', '-2', '', '0', '', '0', '\0', '1', '2017-01-09 10:08:24', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('d40fcdec366f4038971f3d9bb68451eb', '编辑', 'fa1cf28bbd424fb0b900cf11f10b1817', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,fa1cf28bbd424fb0b900cf11f10b1817,', '2', 'sys_area_edit', '40', null, '/sys/area/edit', 'GET,POST', '0', 'fa-pencil', '0', null, '0', '', '1', '2016-12-29 14:31:16', '1', '2016-12-29 14:31:16');
INSERT INTO `sys_module_t` VALUES ('d43aeeff1f6d4572b19d0ecd62a3ba51', '油枪价格管理', '7860179350414b4985ea1c73a80206dd', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,', '1', 'gas_stationOilPrice', '30', null, '/gas/stationOilPrice/', 'GET', '-2', 'fa-file', '0', null, '0', '\0', '1', '2017-01-24 17:19:07', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('d547049ca8d14696886fe116712543cf', '删除', 'ccabf325f5ad495f821c4b848249a32d', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,ccabf325f5ad495f821c4b848249a32d,', '2', 'gas_stationGun_delete', '80', null, '/gas/stationGun/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 15:27:53', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('d5f7cf80752247c9ab29b8532d970ad9', '分利管理', '090dcfce0a5f483b99a5b21b55db2539', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,', '1', 'client_cardProfit', '30', null, '/client/cardProfit/', 'GET', '-2', 'fa-file', '0', null, '0', '\0', '1', '2017-02-04 10:06:10', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('d6524c1158cf4e72b486a7027ac88cc9', '编辑', 'd5f7cf80752247c9ab29b8532d970ad9', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,d5f7cf80752247c9ab29b8532d970ad9,', '2', 'client_cardProfit_edit', '40', null, '/client/cardProfit/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-02-04 10:06:11', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('d6814dcbdb624077afeb95d856ad76d0', '删除', '0771998f75b444f8b2ec0631c69c644f', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,0771998f75b444f8b2ec0631c69c644f,', '2', 'sys_dict_delete', '80', null, '/sys/dict/delete', 'DELETE', '0', 'fa-trash-o', '0', null, '0', '', '1', '2016-12-29 14:27:37', '1', '2016-12-29 14:27:37');
INSERT INTO `sys_module_t` VALUES ('d7069653320643e89b3c93dcdfa5b2c6', '编辑', '201305b309b0462ab8eb294ab1d42410', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,201305b309b0462ab8eb294ab1d42410,', '2', 'sys_user_edit', '40', null, '/sys/user/edit', 'GET,POST', '0', 'fa-pencil', '0', null, '1', '', '1', '2016-12-29 14:54:15', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('d8a7f59bcfab43cf85e29e33a560bd62', '首页', '99be1a381a1f415288354a76219023fc', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,', '1', 'merchant_module_index', '10', '', '/merchant/index', 'GET', '-2', 'fa-home', '0', '', '0', '\0', '1', '2017-01-11 10:15:39', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('d8f097ac6d9644569924e79c9feb55d3', '编辑', '696cdba768c645afa6d2dac2c6d40c67', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,696cdba768c645afa6d2dac2c6d40c67,', '2', 'data_clientCompanyAccount_edit', '40', null, '/data/clientCompanyAccount/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 16:03:14', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('d919015e6e7f4730a9b1f91c6c351f89', '查看', 'ccabf325f5ad495f821c4b848249a32d', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,ccabf325f5ad495f821c4b848249a32d,', '2', 'gas_stationGun_view', '20', null, '/gas/stationGun/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 15:27:52', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('da0a2f2cf94f490bab860694dd438b62', '查看', '8b2884ed8c4145f7b8fc472bdf2db640', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,8b2884ed8c4145f7b8fc472bdf2db640,', '2', 'client_clientCompany_view', '20', null, '/client/clientCompany/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 15:56:28', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('dd72713496474a6296114744a5798b7c', '编辑', '90b88c0d1e6144aebb1846e287a4f2ef', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,90b88c0d1e6144aebb1846e287a4f2ef,', '2', 'client_cardPlan_edit', '40', null, '/client/cardPlan/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-12 16:11:29', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('ddd038826ea64717813e3b078344a276', '预分配查询', '9d76a92eb9744a399f8ac8470ff31a9f', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,9d76a92eb9744a399f8ac8470ff31a9f,', '1', 'merchant_select_activation', '40', '', '/merchant/select/activation', null, '-2', '', '0', '', '0', '', '1', '2017-02-14 16:36:12', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('dfbcd6fddcc14b12abb3c2d015177433', '查看', 'cda7b42d710c44b2b7319a0f42760bcb', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,cda7b42d710c44b2b7319a0f42760bcb,', '2', 'client_card_view', '20', null, '/client/card/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 17:32:56', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('e085ea75a1df4973833a938f50cbcce0', '编辑', 'd43aeeff1f6d4572b19d0ecd62a3ba51', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,d43aeeff1f6d4572b19d0ecd62a3ba51,', '2', 'gas_stationOilPrice_edit', '40', null, '/gas/stationOilPrice/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-24 17:19:08', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('e1f8b38201064edaaf72398851c752b7', '任务调度管理', '3566c3b5c4114f77a5434c175b9f64c5', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,', '1', 'sys_taskScheduleJob', '30', null, '/sys/taskScheduleJob/', 'GET', '0', 'fa-file', '0', null, '0', '\0', '1', '2017-01-23 09:55:08', '1', '2017-01-23 09:55:09');
INSERT INTO `sys_module_t` VALUES ('e2747436ad11407b8017bb31910f1608', '删除', '7aeb0f1984c2419fbe84dc5879d1a0b7', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,7aeb0f1984c2419fbe84dc5879d1a0b7,', '2', 'gas_stationMemberWorkFlow_delete', '80', null, '/gas/stationMemberWorkFlow/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 15:28:59', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('e2db4b2004e24f9e91dc12dabb571c7f', '查看', 'a265b0fef27d4df4a3a0f1be86b885e6', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,a265b0fef27d4df4a3a0f1be86b885e6,', '2', 'data_oilWholesalePrice_view', '20', null, '/data/oilWholesalePrice/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-19 16:11:42', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('e2f35f3f74d84e92ab57dce826a83a66', '删除', '359d9d9ad76b43889a4e325586751bea', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,359d9d9ad76b43889a4e325586751bea,', '2', 'client_cardOperateFlow_delete', '80', null, '/client/cardOperateFlow/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-13 14:54:26', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('e3e12c8b9b8c41d88fb31bf26e987923', '交易明细查询', '9d76a92eb9744a399f8ac8470ff31a9f', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,9d76a92eb9744a399f8ac8470ff31a9f,', '1', 'merchant_select_trade', '10', '', '/merchant/select/trade', 'GET', '-2', '', '0', '', '0', '', '1', '2017-02-14 16:28:30', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('e5223c949502447fa1a1f2b579203608', '锁定', 'fa1cf28bbd424fb0b900cf11f10b1817', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,fa1cf28bbd424fb0b900cf11f10b1817,', '2', 'sys_area_lock', '60', null, '/sys/area/lock', 'POST', '0', 'fa-lock', '0', null, '0', '', '1', '2016-12-29 14:31:16', '1', '2016-12-29 14:31:16');
INSERT INTO `sys_module_t` VALUES ('e68abcb6a75b45688e9678db551206e7', '消息管理', 'fcf49184c1854cc8958e4bb6de7b15b5', '4d32c49cc7f448dcbfb92ce9c4dde058,fcf49184c1854cc8958e4bb6de7b15b5,', '1', 'mpns_client', '30', '', '/mpns/client/', 'GET', '-2', 'fa-info-circle', '0', '', '1', '\0', '1', '2017-03-27 15:27:09', '1', '2017-06-30 14:31:53');
INSERT INTO `sys_module_t` VALUES ('e8122b9782f04beeb872064780163a27', '删除', 'ca5993a9e1ba4574a2ebd61cad0e3b39', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,ca5993a9e1ba4574a2ebd61cad0e3b39,', '2', 'client_userInfo_delete', '80', null, '/client/userInfo/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 15:55:35', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('e8ae688873d44d60a5c98bceae61e7db', '编辑', '124ed1006eb24a97b36e3b9cb742ddac', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,124ed1006eb24a97b36e3b9cb742ddac,', '2', 'data_clientCompanyAccountFlow_edit', '40', null, '/data/clientCompanyAccountFlow/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 17:35:14', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('eaaff69aa81d448eb465d729bdad0508', '查看列表机构', 'ce4517a441dc4115a14921419b4d131a', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,ce4517a441dc4115a14921419b4d131a,', '2', 'sys_org_view', '20', '', '/sys/org/page', 'GET', '0', 'frame/images/icons/32X32/consulting.gif', '0', '', '21', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('ebb02e173e2f49bfa43b6616c6eda0b2', '删除', '124ed1006eb24a97b36e3b9cb742ddac', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,124ed1006eb24a97b36e3b9cb742ddac,', '2', 'data_clientCompanyAccountFlow_delete', '80', null, '/data/clientCompanyAccountFlow/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-09 17:35:15', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('ee5224dc13404267acfb8fc443dee4c3', '代码生成', '2d5f2af5e36349b5bb8dfbd5904900c8', '4d32c49cc7f448dcbfb92ce9c4dde058,2d5f2af5e36349b5bb8dfbd5904900c8,', '1', '', '0', '', '', null, '0', 'fa-ils', '0', '', '10', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t` VALUES ('ef80fa47eaa84bb88b5d6bd1e197330e', '会计转账', 'b6fb1622a42541f6b19d5bae080300b2', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,b6fb1622a42541f6b19d5bae080300b2,', '1', 'data_clientCompanyAccount_listAdd', '60', '', '/data/clientCompanyAccount/listAdd', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-12 17:47:18', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('f121dbf5cd584eddb200c63968065365', 'IC卡样式管理', '090dcfce0a5f483b99a5b21b55db2539', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,', '1', 'client_cardStyle', '2', '', '/client/cardStyle/', 'GET', '-2', 'fa-file', '0', '', '0', '\0', '1', '2017-01-13 14:53:46', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('f27af0f332f04c75b1a9b2387c8bb1de', '锁定', '12e0d76b698c4821b33c46ca7038a52e', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,12e0d76b698c4821b33c46ca7038a52e,', '2', 'data_userConsumeMoneyFlow_lock', '60', null, '/data/userConsumeMoneyFlow/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-19 16:10:57', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('f2cf7f8d45684a65bc6ab327289fc755', '锁定', 'ad35950b2e2b42b2824a4ea403e07eb2', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,ad35950b2e2b42b2824a4ea403e07eb2,', '2', 'data_userConsume_lock', '60', null, '/data/userConsume/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 17:34:21', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('f31034a888594011b03e80a44d411d4b', '锁定', '9ed591fdbfb7462090e84a22c94cc055', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,9ed591fdbfb7462090e84a22c94cc055,', '2', 'gas_stationHandheldTerminal_lock', '60', null, '/gas/stationHandheldTerminal/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 15:49:55', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('f36649682064453298765f09fc8ddfe4', '查看', 'ef80fa47eaa84bb88b5d6bd1e197330e', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,ef80fa47eaa84bb88b5d6bd1e197330e,', '1', 'data_clientCompanyAccount_pageAdd', '30', '', '/data/clientCompanyAccount/pageAdd', 'GET', '-2', 'fa-info-circle', '0', '', '0', '', '1', '2017-01-12 17:48:18', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('f3ddc140cf32451ea95c72e572452111', '订单管理', '8be2c19fab0d4b098407f614051798c3', '4d32c49cc7f448dcbfb92ce9c4dde058,8be2c19fab0d4b098407f614051798c3,', '1', 'station_module_order', '20', '', '/station/order/index', 'GET', '-2', 'fa-bell', '0', '', '0', '\0', '1', '2017-01-19 15:33:05', '1', '2017-03-01 13:56:11');
INSERT INTO `sys_module_t` VALUES ('f50cbea46eb5489cbae85cc509223a0b', '锁定', '03fe0b2bd3d04c98997767c038dd2c30', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,03fe0b2bd3d04c98997767c038dd2c30,', '2', 'gas_station_lock', '60', null, '/gas/station/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2017-01-09 10:27:05', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('f5dc958155df4deaba4947bd9989202d', '查看', '0771998f75b444f8b2ec0631c69c644f', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,0771998f75b444f8b2ec0631c69c644f,', '2', 'sys_dict_view', '20', '', '/sys/dict/page', 'GET', '0', 'fa-info-circle', '0', '', '0', '\0', '1', '2016-12-29 14:27:37', '1', '2016-12-29 16:48:30');
INSERT INTO `sys_module_t` VALUES ('f6264571f16e4245b3273acc916b0617', '查看', '223b8f1345114589ae09681be4744bbc', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,223b8f1345114589ae09681be4744bbc,', '2', 'sys_loggingEvent_view', '20', null, '/sys/loggingEvent/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-03 14:57:48', '1', '2017-01-04 14:01:36');
INSERT INTO `sys_module_t` VALUES ('f6680215e42f44719e0a2d839aea95c9', '查看', '124ed1006eb24a97b36e3b9cb742ddac', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7ae80cfcc9aa441f985f37f13e196493,124ed1006eb24a97b36e3b9cb742ddac,', '2', 'data_clientCompanyAccountFlow_view', '20', null, '/data/clientCompanyAccountFlow/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-09 17:35:13', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('f83fd0de69ee47939494b6643343ff77', '转账记录', '72600215ad154e9eb36bc922ef636008', '4d32c49cc7f448dcbfb92ce9c4dde058,99be1a381a1f415288354a76219023fc,72600215ad154e9eb36bc922ef636008,', '1', 'merchant_reconciliation_transfer', '20', '', '/merchant/reconciliation/transfer', 'GET', '-2', '', '0', '', '0', '\0', '1', '2017-01-20 15:47:12', '1', '2017-03-01 13:56:17');
INSERT INTO `sys_module_t` VALUES ('f95a5729dc1942c0926b6acb0f39f8b2', '编辑', '8a2ac39b8a4a410e97dfe0e3803516d7', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,090dcfce0a5f483b99a5b21b55db2539,8a2ac39b8a4a410e97dfe0e3803516d7,', '2', 'client_cardLimit_edit', '40', null, '/client/cardLimit/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-12 16:10:31', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('fa1cf28bbd424fb0b900cf11f10b1817', '区域管理', '3566c3b5c4114f77a5434c175b9f64c5', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,', '1', 'sys_area', '60', '', '/sys/area/', 'GET', '0', 'fa-map', '0', '', '0', '\0', '1', '2016-12-29 14:31:16', '1', '2016-12-29 14:49:29');
INSERT INTO `sys_module_t` VALUES ('fc5260105d3a4589bc777069a0481381', '编辑', '5080f7eb98a64ea7ac1b7be00eb9fa38', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,5080f7eb98a64ea7ac1b7be00eb9fa38,', '2', 'gas_stationMember_edit', '40', null, '/gas/stationMember/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-09 14:45:23', '1', '2017-03-01 13:56:04');
INSERT INTO `sys_module_t` VALUES ('fc987e00a31246aea6d2e2a6afe8db36', '系统设置', '4d32c49cc7f448dcbfb92ce9c4dde058', '4d32c49cc7f448dcbfb92ce9c4dde058,', '1', 'sm', '30', '', '', null, '0', 'fa-asterisk', '1', '', '27', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:01:11');
INSERT INTO `sys_module_t` VALUES ('fcf49184c1854cc8958e4bb6de7b15b5', '业务中心', '4d32c49cc7f448dcbfb92ce9c4dde058', '4d32c49cc7f448dcbfb92ce9c4dde058,', '1', '', '20', '', '', null, '0', 'fa-lemon-o', '0', '', '0', '\0', '1', '2017-03-27 15:26:46', '1', '2017-03-27 15:27:09');
INSERT INTO `sys_module_t` VALUES ('fd8be39d8db44c60917633defe9996c0', '账户中心', '4d32c49cc7f448dcbfb92ce9c4dde058', '4d32c49cc7f448dcbfb92ce9c4dde058,', '1', '', '10', '', '', null, '0', 'fa-gear', '0', '', '15', '\0', '', '2016-12-05 11:29:48', '1', '2017-06-30 15:00:51');
INSERT INTO `sys_module_t` VALUES ('fe5a44e473cb486cb5f80558dc9c283c', '编辑', '223b8f1345114589ae09681be4744bbc', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,223b8f1345114589ae09681be4744bbc,', '2', 'sys_loggingEvent_edit', '40', null, '/sys/loggingEvent/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2017-01-03 14:57:49', '1', '2017-01-04 11:36:30');
INSERT INTO `sys_module_t` VALUES ('fe5dcdbcc132480da84701173a3fb5f2', '查看', '201305b309b0462ab8eb294ab1d42410', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,201305b309b0462ab8eb294ab1d42410,', '2', 'sys_user_view', '20', null, '/sys/user/page', 'GET', '0', 'fa-info-circle', '0', null, '1', '', '1', '2016-12-29 14:54:14', '1', '2017-06-30 15:01:12');
INSERT INTO `sys_module_t` VALUES ('ff37aeb817ff445d8dd312b3dee4becc', '删除', 'a84f5c9233e14669a7337f2a73efc1cc', '4d32c49cc7f448dcbfb92ce9c4dde058,bed876ed10524f9a9e05c1f0e98a2339,7860179350414b4985ea1c73a80206dd,a84f5c9233e14669a7337f2a73efc1cc,', '2', 'gas_stationMoneyTransferFlow_delete', '80', null, '/gas/stationMoneyTransferFlow/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-19 16:07:42', '1', '2017-03-01 13:56:04');

-- ----------------------------
-- Table structure for sys_module_t_old
-- ----------------------------
DROP TABLE IF EXISTS `sys_module_t_old`;
CREATE TABLE `sys_module_t_old` (
  `id_` varchar(50) NOT NULL COMMENT '模块编码',
  `name_` varchar(255) DEFAULT '' COMMENT '名称',
  `parent_id` varchar(50) DEFAULT NULL COMMENT '父module的id',
  `parent_ids` varchar(2000) DEFAULT NULL,
  `type_` varchar(50) DEFAULT NULL COMMENT '模块类型  0 菜单模块 1权限模块',
  `permission_` varchar(500) DEFAULT NULL COMMENT '权限标识',
  `sort_` int(11) DEFAULT '0' COMMENT '排序',
  `target_` varchar(255) DEFAULT NULL,
  `url_` varchar(2000) DEFAULT NULL,
  `request_method` varchar(64) DEFAULT NULL COMMENT '请求方法',
  `status_` varchar(2) DEFAULT NULL COMMENT '是否删除  0正常 1不可用',
  `icon_cls` varchar(50) DEFAULT NULL,
  `show_type` varchar(10) DEFAULT '0' COMMENT '针对顶层菜单，0 普通展示下级菜单， 1已树形结构展示',
  `description_` varchar(255) DEFAULT NULL COMMENT '描述',
  `version_` int(11) NOT NULL,
  `is_leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `created_by` varchar(50) NOT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='module表';

-- ----------------------------
-- Records of sys_module_t_old
-- ----------------------------
INSERT INTO `sys_module_t_old` VALUES ('024d876a23424ff397c224de2e2939a8', '生成方案配置', 'ee5224dc13404267acfb8fc443dee4c3', '4d32c49cc7f448dcbfb92ce9c4dde058,2d5f2af5e36349b5bb8dfbd5904900c8,ee5224dc13404267acfb8fc443dee4c3,', '1', 'gen_genScheme', '10', '', '/gen/genScheme/', null, '0', 'fa-reddit-square', '0', '', '9', '', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('0771998f75b444f8b2ec0631c69c644f', '字典管理', '3566c3b5c4114f77a5434c175b9f64c5', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,', '1', 'sys_dict', '30', '', '/sys/dict/', 'GET', '0', 'fa-navicon', '0', '', '0', '\0', '1', '2016-12-29 14:27:37', '1', '2016-12-29 14:50:38');
INSERT INTO `sys_module_t_old` VALUES ('08bb2278416a4aaa86a1db7898252791', '编辑', '0771998f75b444f8b2ec0631c69c644f', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,0771998f75b444f8b2ec0631c69c644f,', '2', 'sys_dict_edit', '40', null, '/sys/dict/edit', 'GET,POST', '0', 'fa-pencil', '0', null, '0', '', '1', '2016-12-29 14:27:37', '1', '2016-12-29 14:27:37');
INSERT INTO `sys_module_t_old` VALUES ('1f9baf66928d4c0bad47b6280a56a2c3', '删除', '87bdd1a11a5748fe8294cfb278dff9a4', '4d32c49cc7f448dcbfb92ce9c4dde058,42baef661e504fa998a35d27b0daa3c4,87bdd1a11a5748fe8294cfb278dff9a4,', '2', 'gas_station_delete', '80', null, '/gas/station/delete', 'DELETE', '-2', 'fa-trash-o', '0', null, '0', '', '1', '2016-12-29 16:59:55', '1', '2017-02-28 15:44:02');
INSERT INTO `sys_module_t_old` VALUES ('201305b309b0462ab8eb294ab1d42410', '用户管理', '714afd9e5d9f4c0697e502a43a4a2491', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,', '1', 'sys_user', '30', '', '/sys/user/', 'GET', '0', 'fa-users', '0', '', '0', '\0', '1', '2016-12-29 14:54:14', '1', '2016-12-29 14:55:03');
INSERT INTO `sys_module_t_old` VALUES ('223b8f1345114589ae09681be4744bbc', '操作日志', '4715e01a290c447eac93ee47db6b9c81', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,', '1', 'sys_loggingEvent', '30', '', '/sys/loggingEvent/', 'GET', '0', 'fa-list-ul', '0', '', '0', '\0', '1', '2017-01-03 14:57:47', '1', '2017-01-03 16:03:05');
INSERT INTO `sys_module_t_old` VALUES ('25a868347e8f4a6bb68b53925db95692', '编辑机构', 'ce4517a441dc4115a14921419b4d131a', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,ce4517a441dc4115a14921419b4d131a,', '2', 'sys_org_edit', '40', '', '/sys/org/edit', 'GET,POST', '0', '', '0', '', '20', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-29 13:14:11');
INSERT INTO `sys_module_t_old` VALUES ('2d5f2af5e36349b5bb8dfbd5904900c8', '代码生成', '4d32c49cc7f448dcbfb92ce9c4dde058', '4d32c49cc7f448dcbfb92ce9c4dde058,', '1', '', '900', '', '', null, '0', 'fa-sliders', '0', '', '6', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('3566c3b5c4114f77a5434c175b9f64c5', '系统管理', 'fc987e00a31246aea6d2e2a6afe8db36', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,', '1', 'sys', '5', '', '', null, '0', 'fa-gear', '1', '_showTree', '24', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('37ceac18a00b4a7ea45c8681035fe402', '模块管理', '3566c3b5c4114f77a5434c175b9f64c5', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,', '1', 'sys_module', '10', '', '/sys/module/', 'GET,POST,PUT', '0', 'fa-sitemap', '0', '', '24', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-29 15:15:58');
INSERT INTO `sys_module_t_old` VALUES ('3ce4aa89b1c5483dbc538d3f3ae0a63f', '删除机构', 'ce4517a441dc4115a14921419b4d131a', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,ce4517a441dc4115a14921419b4d131a,', '2', 'sys_org_delete', '80', '', '/sys/org/delete', 'DELETE', '0', '', '0', '', '17', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-29 13:14:15');
INSERT INTO `sys_module_t_old` VALUES ('3dc743ff54734668b45a95dd02276de5', '锁定', '0771998f75b444f8b2ec0631c69c644f', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,0771998f75b444f8b2ec0631c69c644f,', '2', 'sys_dict_lock', '60', null, '/sys/dict/lock', 'POST', '0', 'fa-lock', '0', null, '0', '', '1', '2016-12-29 14:27:37', '1', '2016-12-29 14:27:37');
INSERT INTO `sys_module_t_old` VALUES ('42baef661e504fa998a35d27b0daa3c4', '账户中心', '4d32c49cc7f448dcbfb92ce9c4dde058', '4d32c49cc7f448dcbfb92ce9c4dde058,', '1', '', '200', '', '', null, '0', 'fa-building-o', '0', '', '4', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('4715e01a290c447eac93ee47db6b9c81', '日志查询', 'fc987e00a31246aea6d2e2a6afe8db36', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,', '1', '', '30', '', '', null, '0', 'fa-book', '0', '', '12', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('4d32c49cc7f448dcbfb92ce9c4dde058', '数据模块', '', '', '1', 'root', null, null, null, null, '0', ' fa-reorder', '0', null, '9', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-27 17:15:11');
INSERT INTO `sys_module_t_old` VALUES ('5293bd1a28924276a236a4363af5dde8', '启用/停用机构', 'ce4517a441dc4115a14921419b4d131a', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,ce4517a441dc4115a14921419b4d131a,', '2', 'sys_org_lock', '60', '', '/sys/org/lock', 'POST', '0', '', '0', '', '18', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-29 16:01:46');
INSERT INTO `sys_module_t_old` VALUES ('591f53d17e0c46e5a6ab7969e767084d', '编辑', '87bdd1a11a5748fe8294cfb278dff9a4', '4d32c49cc7f448dcbfb92ce9c4dde058,42baef661e504fa998a35d27b0daa3c4,87bdd1a11a5748fe8294cfb278dff9a4,', '2', 'gas_station_edit', '40', null, '/gas/station/edit', 'GET,POST', '-2', 'fa-pencil', '0', null, '0', '', '1', '2016-12-29 16:59:55', '1', '2017-02-28 15:44:02');
INSERT INTO `sys_module_t_old` VALUES ('714afd9e5d9f4c0697e502a43a4a2491', '机构用户', 'fc987e00a31246aea6d2e2a6afe8db36', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,', '1', '', '0', '', '', null, '0', 'fa-dot-circle-o', '0', '', '10', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('749160f6086f475da6f350543994608e', '查看', 'fa1cf28bbd424fb0b900cf11f10b1817', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,fa1cf28bbd424fb0b900cf11f10b1817,', '2', 'sys_area_view', '20', null, '/sys/area/page', 'GET', '0', 'fa-info-circle', '0', null, '0', '', '1', '2016-12-29 14:31:16', '1', '2016-12-29 14:31:16');
INSERT INTO `sys_module_t_old` VALUES ('75f58401461c486b875f851e18a8ee9d', '启用/停用模块', '37ceac18a00b4a7ea45c8681035fe402', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,37ceac18a00b4a7ea45c8681035fe402,', '2', 'sys_module_lock', '60', '', '/sys/module/lock', 'POST', '0', '', null, '', '22', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('7f640c48e80d4171ae4d9d663408baa1', '查看', '87bdd1a11a5748fe8294cfb278dff9a4', '4d32c49cc7f448dcbfb92ce9c4dde058,42baef661e504fa998a35d27b0daa3c4,87bdd1a11a5748fe8294cfb278dff9a4,', '2', 'gas_station_view', '20', null, '/gas/station/page', 'GET', '-2', 'fa-info-circle', '0', null, '0', '', '1', '2016-12-29 16:59:55', '1', '2017-02-28 15:44:02');
INSERT INTO `sys_module_t_old` VALUES ('7ff1ee3bd23845b8a1d7ef8df661bb0d', '添加/修改模块', '37ceac18a00b4a7ea45c8681035fe402', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,37ceac18a00b4a7ea45c8681035fe402,', '2', 'sys_module_edit', '40', '', '/sys/module/edit', 'GET,POST', '0', 'fa-pencil', '0', '', '27', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('87825137dec44ea5b04b9e43df1a1d5e', '修改密码', 'fd8be39d8db44c60917633defe9996c0', '4d32c49cc7f448dcbfb92ce9c4dde058,42baef661e504fa998a35d27b0daa3c4,fd8be39d8db44c60917633defe9996c0,', '1', '', '20', '', '/sys/user/modifyPwd', null, '0', 'fa-lock', '0', '', '19', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-28 15:29:26');
INSERT INTO `sys_module_t_old` VALUES ('87bdd1a11a5748fe8294cfb278dff9a4', '油站管理', '42baef661e504fa998a35d27b0daa3c4', '4d32c49cc7f448dcbfb92ce9c4dde058,42baef661e504fa998a35d27b0daa3c4,', '1', 'gas_station', '30', null, '/gas/station/', 'GET', '-2', 'fa-file', '0', null, '0', '\0', '1', '2016-12-29 16:59:55', '1', '2017-02-28 15:44:02');
INSERT INTO `sys_module_t_old` VALUES ('8d607e3d86ad436b89e3067323021168', '资源监控', '4715e01a290c447eac93ee47db6b9c81', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,', '1', 'sys_metrics', '0', '_blank', '/sys/metrics', 'GET', '0', 'fa-drupal', '0', '', '8', '\0', '', '2016-12-05 11:29:48', '1', '2017-01-03 15:06:48');
INSERT INTO `sys_module_t_old` VALUES ('8e21d10003694354822fe0ad44106ce0', '业务表配置', 'ee5224dc13404267acfb8fc443dee4c3', '4d32c49cc7f448dcbfb92ce9c4dde058,2d5f2af5e36349b5bb8dfbd5904900c8,ee5224dc13404267acfb8fc443dee4c3,', '1', 'gen_genTable', '100', '', '/gen/genTable/', null, '0', 'fa-delicious', '0', '', '10', '', '', '2016-12-05 11:29:48', '1', '2016-12-25 17:13:13');
INSERT INTO `sys_module_t_old` VALUES ('8eae4c0c642a43eba9de678d36ca9186', '删除', '201305b309b0462ab8eb294ab1d42410', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,201305b309b0462ab8eb294ab1d42410,', '2', 'sys_user_delete', '80', null, '/sys/user/delete', 'DELETE', '0', 'fa-trash-o', '0', null, '0', '', '1', '2016-12-29 14:54:15', '1', '2016-12-29 14:54:15');
INSERT INTO `sys_module_t_old` VALUES ('8f6e8fcc5b5141e298a1ab9eefe55eb9', '锁定', '223b8f1345114589ae09681be4744bbc', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,223b8f1345114589ae09681be4744bbc,', '2', 'sys_loggingEvent_lock', '60', null, '/sys/loggingEvent/lock', 'POST', '0', 'fa-lock', '0', null, '0', '', '1', '2017-01-03 14:57:50', '1', '2017-01-03 14:57:50');
INSERT INTO `sys_module_t_old` VALUES ('919cce8e6f0c426c831f9c478f79fd13', '分配角色', 'bd7872df2fe748fb97bb1dcc629cdecb', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,bd7872df2fe748fb97bb1dcc629cdecb,', '2', 'sys_role_assign', '0', '', '', null, '-2', '', '0', '', '9', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-28 15:54:41');
INSERT INTO `sys_module_t_old` VALUES ('95a093b48f1947818d50fe09eab72753', '编辑', 'bd7872df2fe748fb97bb1dcc629cdecb', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,bd7872df2fe748fb97bb1dcc629cdecb,', '2', 'sys_role_edit', '20', '', '/sys/role/edit', 'GET,POST', '0', '', '0', '', '28', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-28 17:27:07');
INSERT INTO `sys_module_t_old` VALUES ('abd42541d2614a7d9f117ce857645382', '删除模块', '37ceac18a00b4a7ea45c8681035fe402', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,37ceac18a00b4a7ea45c8681035fe402,', '2', 'sys_module_delete', '80', null, '/sys/module/delete', 'DELETE', '0', '', null, '', '20', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('abef72628d6a4c1e84f142c79c40d84c', '锁定', '87bdd1a11a5748fe8294cfb278dff9a4', '4d32c49cc7f448dcbfb92ce9c4dde058,42baef661e504fa998a35d27b0daa3c4,87bdd1a11a5748fe8294cfb278dff9a4,', '2', 'gas_station_lock', '60', null, '/gas/station/lock', 'POST', '-2', 'fa-lock', '0', null, '0', '', '1', '2016-12-29 16:59:55', '1', '2017-02-28 15:44:02');
INSERT INTO `sys_module_t_old` VALUES ('af6294af4db4487c930125b40212f6ac', '查看列表模块', '37ceac18a00b4a7ea45c8681035fe402', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,37ceac18a00b4a7ea45c8681035fe402,', '2', 'sys_module_view', '20', '', '/sys/module/page', 'GET', '0', 'fa-info-circle', '0', '', '29', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('afb54abea1164a76a790064f4bf2263c', '删除', '223b8f1345114589ae09681be4744bbc', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,223b8f1345114589ae09681be4744bbc,', '2', 'sys_loggingEvent_delete', '80', null, '/sys/loggingEvent/delete', 'DELETE', '0', 'fa-trash-o', '0', null, '0', '', '1', '2017-01-03 14:57:50', '1', '2017-01-03 14:57:50');
INSERT INTO `sys_module_t_old` VALUES ('b4dc5bb4a11149d78c765dbef12e13c7', '删除', 'fa1cf28bbd424fb0b900cf11f10b1817', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,fa1cf28bbd424fb0b900cf11f10b1817,', '2', 'sys_area_delete', '80', null, '/sys/area/delete', 'DELETE', '0', 'fa-trash-o', '0', null, '0', '', '1', '2016-12-29 14:31:16', '1', '2016-12-29 14:31:16');
INSERT INTO `sys_module_t_old` VALUES ('b57911172bf74bceae6e22e706d83fb8', '锁定', '201305b309b0462ab8eb294ab1d42410', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,201305b309b0462ab8eb294ab1d42410,', '2', 'sys_user_lock', '60', null, '/sys/user/lock', 'POST', '0', 'fa-lock', '0', null, '0', '', '1', '2016-12-29 14:54:15', '1', '2016-12-29 14:54:15');
INSERT INTO `sys_module_t_old` VALUES ('badfe0b992fd4f79b1dfcc2494a47e76', '删除', 'bd7872df2fe748fb97bb1dcc629cdecb', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,bd7872df2fe748fb97bb1dcc629cdecb,', '2', 'sys_role_delete', '40', '', '/sys/role/delete', 'DELETE', '0', '', '0', '', '25', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-28 17:27:01');
INSERT INTO `sys_module_t_old` VALUES ('bc779f2d65da44ad8397a8ff5976ac65', '查看', 'bd7872df2fe748fb97bb1dcc629cdecb', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,bd7872df2fe748fb97bb1dcc629cdecb,', '2', 'sys_role_view', '10', '', '/sys/role/page', 'GET', '0', '', '0', '', '27', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-28 17:26:54');
INSERT INTO `sys_module_t_old` VALUES ('bd7872df2fe748fb97bb1dcc629cdecb', '角色管理', '714afd9e5d9f4c0697e502a43a4a2491', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,', '1', 'sys_role', '90', '', '/sys/role/', 'GET', '0', 'fa-reorder', '0', '', '25', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-29 14:54:43');
INSERT INTO `sys_module_t_old` VALUES ('ccab7469d8df473c8ff769437f6bd393', '锁定', 'bd7872df2fe748fb97bb1dcc629cdecb', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,bd7872df2fe748fb97bb1dcc629cdecb,', '2', 'sys_role_lock', '30', '', '/sys/role/lock', 'POST', '0', '', '0', '', '0', '\0', '1', '2016-12-28 16:53:19', '1', '2016-12-28 17:27:29');
INSERT INTO `sys_module_t_old` VALUES ('ce4517a441dc4115a14921419b4d131a', '机构管理', '714afd9e5d9f4c0697e502a43a4a2491', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,', '1', 'sys_org', '60', '', '/sys/org/', 'GET', '0', 'fa-th-large', '0', '', '23', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-29 14:54:35');
INSERT INTO `sys_module_t_old` VALUES ('cfd37cfb27fc42daa6366cba9f257e6f', '账户信息', 'fd8be39d8db44c60917633defe9996c0', '4d32c49cc7f448dcbfb92ce9c4dde058,42baef661e504fa998a35d27b0daa3c4,fd8be39d8db44c60917633defe9996c0,', '1', '', '10', '', '/sys/user/info', null, '0', 'fa-credit-card', '0', '', '20', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-28 15:29:19');
INSERT INTO `sys_module_t_old` VALUES ('d40fcdec366f4038971f3d9bb68451eb', '编辑', 'fa1cf28bbd424fb0b900cf11f10b1817', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,fa1cf28bbd424fb0b900cf11f10b1817,', '2', 'sys_area_edit', '40', null, '/sys/area/edit', 'GET,POST', '0', 'fa-pencil', '0', null, '0', '', '1', '2016-12-29 14:31:16', '1', '2016-12-29 14:31:16');
INSERT INTO `sys_module_t_old` VALUES ('d6814dcbdb624077afeb95d856ad76d0', '删除', '0771998f75b444f8b2ec0631c69c644f', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,0771998f75b444f8b2ec0631c69c644f,', '2', 'sys_dict_delete', '80', null, '/sys/dict/delete', 'DELETE', '0', 'fa-trash-o', '0', null, '0', '', '1', '2016-12-29 14:27:37', '1', '2016-12-29 14:27:37');
INSERT INTO `sys_module_t_old` VALUES ('d7069653320643e89b3c93dcdfa5b2c6', '编辑', '201305b309b0462ab8eb294ab1d42410', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,201305b309b0462ab8eb294ab1d42410,', '2', 'sys_user_edit', '40', null, '/sys/user/edit', 'GET,POST', '0', 'fa-pencil', '0', null, '0', '', '1', '2016-12-29 14:54:15', '1', '2016-12-29 14:54:15');
INSERT INTO `sys_module_t_old` VALUES ('e5223c949502447fa1a1f2b579203608', '锁定', 'fa1cf28bbd424fb0b900cf11f10b1817', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,fa1cf28bbd424fb0b900cf11f10b1817,', '2', 'sys_area_lock', '60', null, '/sys/area/lock', 'POST', '0', 'fa-lock', '0', null, '0', '', '1', '2016-12-29 14:31:16', '1', '2016-12-29 14:31:16');
INSERT INTO `sys_module_t_old` VALUES ('eaaff69aa81d448eb465d729bdad0508', '查看列表机构', 'ce4517a441dc4115a14921419b4d131a', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,ce4517a441dc4115a14921419b4d131a,', '2', 'sys_org_view', '20', '', '/sys/org/page', 'GET', '0', 'frame/images/icons/32X32/consulting.gif', '0', '', '20', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('ee5224dc13404267acfb8fc443dee4c3', '代码生成', '2d5f2af5e36349b5bb8dfbd5904900c8', '4d32c49cc7f448dcbfb92ce9c4dde058,2d5f2af5e36349b5bb8dfbd5904900c8,', '1', '', '0', '', '', null, '0', 'fa-ils', '0', '', '10', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('f5dc958155df4deaba4947bd9989202d', '查看', '0771998f75b444f8b2ec0631c69c644f', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,0771998f75b444f8b2ec0631c69c644f,', '2', 'sys_dict_view', '20', '', '/sys/dict/page', 'GET', '0', 'fa-info-circle', '0', '', '0', '\0', '1', '2016-12-29 14:27:37', '1', '2016-12-29 16:48:30');
INSERT INTO `sys_module_t_old` VALUES ('f6264571f16e4245b3273acc916b0617', '查看', '223b8f1345114589ae09681be4744bbc', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,223b8f1345114589ae09681be4744bbc,', '2', 'sys_loggingEvent_view', '20', null, '/sys/loggingEvent/page', 'GET', '0', 'fa-info-circle', '0', null, '0', '', '1', '2017-01-03 14:57:48', '1', '2017-01-03 14:57:48');
INSERT INTO `sys_module_t_old` VALUES ('fa1cf28bbd424fb0b900cf11f10b1817', '区域管理', '3566c3b5c4114f77a5434c175b9f64c5', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,3566c3b5c4114f77a5434c175b9f64c5,', '1', 'sys_area', '60', '', '/sys/area/', 'GET', '0', 'fa-map', '0', '', '0', '\0', '1', '2016-12-29 14:31:16', '1', '2016-12-29 14:49:29');
INSERT INTO `sys_module_t_old` VALUES ('fc987e00a31246aea6d2e2a6afe8db36', '系统设置', '4d32c49cc7f448dcbfb92ce9c4dde058', '4d32c49cc7f448dcbfb92ce9c4dde058,', '1', 'sm', '800', '', '', null, '0', 'fa-asterisk', '1', '', '26', '\0', '', '2016-12-05 11:29:48', null, null);
INSERT INTO `sys_module_t_old` VALUES ('fd8be39d8db44c60917633defe9996c0', '账户设置', '42baef661e504fa998a35d27b0daa3c4', '4d32c49cc7f448dcbfb92ce9c4dde058,42baef661e504fa998a35d27b0daa3c4,', '1', '', '60', '', '', null, '0', 'fa-gear', '0', '', '14', '\0', '', '2016-12-05 11:29:48', '1', '2016-12-29 17:07:30');
INSERT INTO `sys_module_t_old` VALUES ('fe5a44e473cb486cb5f80558dc9c283c', '编辑', '223b8f1345114589ae09681be4744bbc', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,4715e01a290c447eac93ee47db6b9c81,223b8f1345114589ae09681be4744bbc,', '2', 'sys_loggingEvent_edit', '40', null, '/sys/loggingEvent/edit', 'GET,POST', '0', 'fa-pencil', '0', null, '0', '', '1', '2017-01-03 14:57:49', '1', '2017-01-03 14:57:49');
INSERT INTO `sys_module_t_old` VALUES ('fe5dcdbcc132480da84701173a3fb5f2', '查看', '201305b309b0462ab8eb294ab1d42410', '4d32c49cc7f448dcbfb92ce9c4dde058,fc987e00a31246aea6d2e2a6afe8db36,714afd9e5d9f4c0697e502a43a4a2491,201305b309b0462ab8eb294ab1d42410,', '2', 'sys_user_view', '20', null, '/sys/user/page', 'GET', '0', 'fa-info-circle', '0', null, '0', '', '1', '2016-12-29 14:54:14', '1', '2016-12-29 14:54:14');

-- ----------------------------
-- Table structure for sys_org_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_org_t`;
CREATE TABLE `sys_org_t` (
  `id_` varchar(32) NOT NULL DEFAULT '0',
  `name_` varchar(255) DEFAULT NULL,
  `parent_id` varchar(32) DEFAULT NULL,
  `parent_ids` varchar(2000) DEFAULT NULL,
  `code_` varchar(64) DEFAULT NULL COMMENT '机构编码',
  `grade_` varchar(255) DEFAULT NULL COMMENT '机构等级',
  `is_leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `en_` varchar(255) DEFAULT NULL,
  `sort_` int(11) DEFAULT '0' COMMENT '序号',
  `type_` varchar(64) DEFAULT NULL COMMENT '组织类型',
  `status_` int(11) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `version_` int(11) DEFAULT NULL,
  `description_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FK2006A5E73CA88251` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_org_t
-- ----------------------------
INSERT INTO `sys_org_t` VALUES ('1', '平台', '0', '0,', '100000', '1', '\0', 'root', '30', '1', '0', '', '2016-12-12 16:32:48', '1', '2017-06-30 14:59:27', '1', null);
INSERT INTO `sys_org_t` VALUES ('186eaa340c934cb49434765f807fdeff', '公司领导', '1', '0,1,', '100001', '1', '', null, '30', '1', '0', '', '2016-12-12 16:32:48', '1', '2017-06-30 14:59:27', '1', '');
INSERT INTO `sys_org_t` VALUES ('27db8e3b19364a279b1e9721b5a784c7', '人事部', '38c65b8630ff473aa9f618906401efa0', '0,1,38c65b8630ff473aa9f618906401efa0,', '100005', '1', '', null, '20', '1', '0', '', '2016-12-12 16:32:48', '1', '2016-12-28 16:58:12', '0', '');
INSERT INTO `sys_org_t` VALUES ('38c65b8630ff473aa9f618906401efa0', '综合部', '1', '0,1,', '100004', '1', '\0', null, '0', '1', '0', '', '2016-12-12 16:32:48', '1', '2016-12-28 16:58:39', '0', '');
INSERT INTO `sys_org_t` VALUES ('588e010702d343fe9082416102e49def', 'fdsa', 'c5fe48b99ad24e83a2271405a43fb8b7', '0,1,c5fe48b99ad24e83a2271405a43fb8b7,', 'dsfas', '1', '', null, '0', '1', '1', '', '2016-12-12 16:32:48', '1', '2016-12-28 16:59:11', '0', '');
INSERT INTO `sys_org_t` VALUES ('c4f84e7695d94b469d93405fb73060d0', 'dd', '38c65b8630ff473aa9f618906401efa0', '0,1,38c65b8630ff473aa9f618906401efa0,', '', '1', '', null, '30', '1', '0', '', '2017-03-02 22:23:11', '1', '2017-03-02 22:23:11', '0', '');
INSERT INTO `sys_org_t` VALUES ('c5fe48b99ad24e83a2271405a43fb8b7', '技术部', '1', '0,1,', '100003', '1', '\0', null, '20', '1', '0', '', '2016-12-12 16:32:48', null, null, '0', null);
INSERT INTO `sys_org_t` VALUES ('f93883513a034577a166b424beb93794', '研发部', '1', '0,1,', '100002', '1', '\0', null, '30', '1', '-1', '', '2016-12-12 16:32:48', '1', '2016-12-22 20:43:04', '0', null);

-- ----------------------------
-- Table structure for sys_role_module_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_module_t`;
CREATE TABLE `sys_role_module_t` (
  `role_id` varchar(255) NOT NULL,
  `module_id` varchar(255) NOT NULL,
  PRIMARY KEY (`role_id`,`module_id`),
  KEY `FK_6eloh5l1ylo4pteqj5n1viu3c` (`module_id`),
  CONSTRAINT `sys_role_module_t_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `sys_module_t_old` (`id_`),
  CONSTRAINT `sys_role_module_t_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `sys_role_t` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_module_t
-- ----------------------------
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '25a868347e8f4a6bb68b53925db95692');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '3566c3b5c4114f77a5434c175b9f64c5');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '37ceac18a00b4a7ea45c8681035fe402');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '3ce4aa89b1c5483dbc538d3f3ae0a63f');
INSERT INTO `sys_role_module_t` VALUES ('931ea939caaa4451833a9e5f2426a951', '42baef661e504fa998a35d27b0daa3c4');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '4715e01a290c447eac93ee47db6b9c81');
INSERT INTO `sys_role_module_t` VALUES ('14330c13c78243658d824fc5b8def161', '4d32c49cc7f448dcbfb92ce9c4dde058');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '4d32c49cc7f448dcbfb92ce9c4dde058');
INSERT INTO `sys_role_module_t` VALUES ('931ea939caaa4451833a9e5f2426a951', '4d32c49cc7f448dcbfb92ce9c4dde058');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '5293bd1a28924276a236a4363af5dde8');
INSERT INTO `sys_role_module_t` VALUES ('14330c13c78243658d824fc5b8def161', '714afd9e5d9f4c0697e502a43a4a2491');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '714afd9e5d9f4c0697e502a43a4a2491');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '75f58401461c486b875f851e18a8ee9d');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '7ff1ee3bd23845b8a1d7ef8df661bb0d');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '8d607e3d86ad436b89e3067323021168');
INSERT INTO `sys_role_module_t` VALUES ('14330c13c78243658d824fc5b8def161', '95a093b48f1947818d50fe09eab72753');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '95a093b48f1947818d50fe09eab72753');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', 'abd42541d2614a7d9f117ce857645382');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', 'af6294af4db4487c930125b40212f6ac');
INSERT INTO `sys_role_module_t` VALUES ('14330c13c78243658d824fc5b8def161', 'badfe0b992fd4f79b1dfcc2494a47e76');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', 'badfe0b992fd4f79b1dfcc2494a47e76');
INSERT INTO `sys_role_module_t` VALUES ('14330c13c78243658d824fc5b8def161', 'bc779f2d65da44ad8397a8ff5976ac65');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', 'bc779f2d65da44ad8397a8ff5976ac65');
INSERT INTO `sys_role_module_t` VALUES ('14330c13c78243658d824fc5b8def161', 'bd7872df2fe748fb97bb1dcc629cdecb');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', 'bd7872df2fe748fb97bb1dcc629cdecb');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', 'ce4517a441dc4115a14921419b4d131a');
INSERT INTO `sys_role_module_t` VALUES ('931ea939caaa4451833a9e5f2426a951', 'cfd37cfb27fc42daa6366cba9f257e6f');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', 'eaaff69aa81d448eb465d729bdad0508');
INSERT INTO `sys_role_module_t` VALUES ('14330c13c78243658d824fc5b8def161', 'fc987e00a31246aea6d2e2a6afe8db36');
INSERT INTO `sys_role_module_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', 'fc987e00a31246aea6d2e2a6afe8db36');
INSERT INTO `sys_role_module_t` VALUES ('931ea939caaa4451833a9e5f2426a951', 'fd8be39d8db44c60917633defe9996c0');

-- ----------------------------
-- Table structure for sys_role_org_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_org_t`;
CREATE TABLE `sys_role_org_t` (
  `role_id` varchar(32) NOT NULL DEFAULT '0',
  `org_id` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`role_id`,`org_id`),
  KEY `FK4C18BAB12A44C67D` (`org_id`),
  KEY `FK4C18BAB1B90B46FD` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_org_t
-- ----------------------------
INSERT INTO `sys_role_org_t` VALUES ('1', '1');

-- ----------------------------
-- Table structure for sys_role_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_t`;
CREATE TABLE `sys_role_t` (
  `id_` varchar(32) NOT NULL DEFAULT '0',
  `name_` varchar(100) DEFAULT NULL,
  `org_id` varchar(32) DEFAULT NULL,
  `sys_data` char(1) DEFAULT NULL COMMENT '是否系统数据',
  `data_scope` int(11) DEFAULT NULL COMMENT '数据范围',
  `status_` varchar(64) DEFAULT NULL COMMENT '是否删除  0正常 1不可用',
  `sort_` int(11) DEFAULT '0' COMMENT '序号',
  `type_` varchar(225) DEFAULT NULL COMMENT '对应activiti中的group表',
  `en_` varchar(225) DEFAULT NULL,
  `description_` varchar(225) DEFAULT NULL,
  `version_` int(11) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FKE5C4B49D852279D7` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_t
-- ----------------------------
INSERT INTO `sys_role_t` VALUES ('14330c13c78243658d824fc5b8def161', '普通角色', '1', '1', '1', '0', null, null, null, '', '0', '', '2017-03-02 22:21:40', '1', '2017-03-02 22:21:40');
INSERT INTO `sys_role_t` VALUES ('37b1a8177e5d40f4abd8a3b9fd7521f9', '财务经理', '1', '1', '1', '-2', '2', null, null, '', '10', '', '2016-12-28 15:30:17', '1', '2016-12-28 15:30:18');
INSERT INTO `sys_role_t` VALUES ('43186a6c08d247c098ea357e28cc75f4', '管理员', '1', '1', '1', '0', '0', null, null, '', '5', '', '2016-12-28 15:31:11', '1', '2017-06-30 15:01:07');
INSERT INTO `sys_role_t` VALUES ('489c114e0c3b454fb3fd4c6141e31025', '市场部', '1', '1', '1', '-2', '11', null, null, '', '3', '', '2016-12-28 15:30:35', '1', '2016-12-28 15:30:36');
INSERT INTO `sys_role_t` VALUES ('4a07cfe83c22424ca4020612afb6f48e', '加油站管理员', '1', '0', '4', '-2', '20', null, null, '', '31', '', '2016-12-28 15:29:59', '1', '2016-12-28 15:30:00');
INSERT INTO `sys_role_t` VALUES ('72edbc1fd12a469e990505b9ce3ee187', '会计', '1', '1', '1', '-2', '0', null, null, '', '10', '', '2016-12-28 15:30:33', '1', '2016-12-28 15:30:33');
INSERT INTO `sys_role_t` VALUES ('8ae82d83573f47c098e2b5a9eaaf6b0e', '企业版普通员工', '1', '1', '5', '-2', '100', null, null, '', '1', '', '2016-12-28 15:30:02', '1', '2016-12-28 15:30:02');
INSERT INTO `sys_role_t` VALUES ('931ea939caaa4451833a9e5f2426a951', '企业版普通管理员', '1', '1', '5', '-2', '110', null, null, '', '1', '', '2016-12-28 15:30:26', '1', '2016-12-28 15:30:26');
INSERT INTO `sys_role_t` VALUES ('964a5a77da5249aab3dad3795e0d9e33', '新版油站经理', '1', '1', '4', '-2', '220', null, null, '', '0', '', '2016-12-28 15:30:04', '1', '2016-12-28 15:30:04');
INSERT INTO `sys_role_t` VALUES ('abb373b2264a4f79ba61d54ad43d5a35', '业务部', '1', '1', '1', '-2', '7', null, null, '地推', '11', '', '2016-12-28 15:30:07', '1', '2016-12-28 15:30:08');
INSERT INTO `sys_role_t` VALUES ('ae4fd60b2d0f4b7f874daf294dbd1f7f', '新版油站管理员', '1', '1', '4', '-2', '210', null, null, '', '2', '', '2016-12-28 15:30:10', '1', '2016-12-28 15:30:10');
INSERT INTO `sys_role_t` VALUES ('b3c962f8bc24457f9577017715410df4', '客服', '1', '1', '1', '-2', '3', null, null, '', '21', '', '2016-12-28 15:30:12', '1', '2016-12-28 15:30:12');
INSERT INTO `sys_role_t` VALUES ('bc98757e06e1474d9b100aa19a2030c7', '企划部经理', '1', '0', '1', '-2', '5', null, null, '', '35', '', '2016-12-28 15:30:20', '1', '2016-12-28 15:30:20');
INSERT INTO `sys_role_t` VALUES ('c25fca621db9420ba2215d6357b0439f', '油站图片维护', '1', '1', '1', '-2', '6', null, null, '', '6', '', '2016-12-28 15:30:31', '1', '2016-12-28 15:30:31');
INSERT INTO `sys_role_t` VALUES ('c6ce051040df41528ccaa14f2dae1d51', '总经理', '1', '1', '1', '-2', '11', null, null, '', '0', '', '2016-12-28 15:30:14', '1', '2016-12-28 15:30:15');
INSERT INTO `sys_role_t` VALUES ('d8f563b501d34334a1378330e91dc66c', '新版油站员工', '1', '0', '4', '-2', '230', null, null, '', '0', '', '2016-12-28 15:30:22', '1', '2016-12-28 15:30:23');
INSERT INTO `sys_role_t` VALUES ('de2bc55c890a4b58b53fc9abf6eae20d', '技术客服', '1', '1', '1', '-2', '4', 'assignment', 'guan', '开发人员', '13', '', '2016-12-28 15:30:29', '1', '2016-12-28 15:30:29');

-- ----------------------------
-- Table structure for sys_task_schedule_job_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_task_schedule_job_t`;
CREATE TABLE `sys_task_schedule_job_t` (
  `id_` varchar(32) NOT NULL,
  `name_` varchar(255) DEFAULT NULL COMMENT '名称',
  `group_` varchar(255) DEFAULT NULL COMMENT '分组',
  `job_status` varchar(255) DEFAULT NULL COMMENT '任务状态',
  `cron_expression` varchar(255) NOT NULL COMMENT 'cron表达式',
  `bean_class` varchar(255) DEFAULT NULL COMMENT '任务执行时调用哪个类的方法 包名+类名',
  `is_concurrent` varchar(255) DEFAULT NULL COMMENT '任务是否有状态',
  `spring_id` varchar(255) DEFAULT NULL COMMENT 'spring bean',
  `source_id` varchar(32) DEFAULT NULL,
  `method_name` varchar(255) NOT NULL COMMENT '任务调用的方法名',
  `method_params` varchar(512) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  `description_` varchar(255) DEFAULT NULL,
  `version_` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  UNIQUE KEY `name_group` (`name_`,`group_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='计划任务表';

-- ----------------------------
-- Records of sys_task_schedule_job_t
-- ----------------------------
INSERT INTO `sys_task_schedule_job_t` VALUES ('e864d607c3374f059903eb037c46c49c', 'sample', 'test', '0', '*/5 * * * * ?', '', '1', 'sampleService', '', 'hello', '', '1', '2017-02-15 14:30:11', '1', '2017-06-30 15:01:25', '0', '', '1');

-- ----------------------------
-- Table structure for sys_user_role_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role_t`;
CREATE TABLE `sys_user_role_t` (
  `user_id` varchar(255) NOT NULL,
  `role_id` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FK_k7q8xbl92flmkhwupf64o6ii5` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_role_t
-- ----------------------------
INSERT INTO `sys_user_role_t` VALUES ('2', '14330c13c78243658d824fc5b8def161');
INSERT INTO `sys_user_role_t` VALUES ('285398b3ad4f417787842cde87774515', '14330c13c78243658d824fc5b8def161');
INSERT INTO `sys_user_role_t` VALUES ('4', '14330c13c78243658d824fc5b8def161');
INSERT INTO `sys_user_role_t` VALUES ('5', '43186a6c08d247c098ea357e28cc75f4');

-- ----------------------------
-- Table structure for sys_user_t
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_t`;
CREATE TABLE `sys_user_t` (
  `id_` varchar(32) NOT NULL,
  `org_id` varchar(32) DEFAULT NULL,
  `login_id` varchar(50) NOT NULL,
  `password_hash` varchar(60) DEFAULT NULL,
  `name_` varchar(50) DEFAULT NULL,
  `email_` varchar(100) DEFAULT NULL,
  `phone_` varchar(32) DEFAULT NULL,
  `activated_` bit(1) NOT NULL,
  `lang_key` varchar(5) DEFAULT NULL,
  `activation_key` varchar(20) DEFAULT NULL,
  `reset_key` varchar(20) DEFAULT NULL,
  `reset_date` timestamp NULL DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  `description_` varchar(255) DEFAULT NULL,
  `version_` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  UNIQUE KEY `login` (`login_id`),
  UNIQUE KEY `idx_user_login` (`login_id`),
  UNIQUE KEY `email` (`email_`),
  UNIQUE KEY `idx_user_email` (`email_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_t
-- ----------------------------
INSERT INTO `sys_user_t` VALUES ('1', null, 'admin', '$2a$10$gSAhZrxMllrbgj/kkK9UceBPpChGWJA7SYIb1Mqo.n5aNLq1/oRrC', 'Administrator', 'admin@localhost', null, '', 'zh-cn', null, null, null, 'system', '2017-06-30 14:49:34', 'system', null, '0', null, '0');
INSERT INTO `sys_user_t` VALUES ('2', '1', 'anonymoususer', '$2a$10$j8S5d7Sr7.8VTOYNviDPOeWX8KcYILUVJBsYV83Y5NtECayypx9lO', null, 'anonymous@localhost1', '', '', 'zh-cn', null, '62504648923202974259', '2017-03-02 23:14:34', 'system', '2017-03-02 23:14:35', '1', '2017-03-02 23:14:35', '0', '', '0');
INSERT INTO `sys_user_t` VALUES ('285398b3ad4f417787842cde87774515', '38c65b8630ff473aa9f618906401efa0', 'admin3', '$2a$10$Pvyd3WhtnZc1mNanBv6Lbem2/kSdAx3rHiI/bQZkxajmFNPRaFeuq', null, '', '', '', 'zh-cn', null, '07324724558601162589', '2017-06-30 14:54:23', 'admin', '2017-06-30 14:54:23', '1', '2017-06-30 14:54:23', '1', 'ddd', '3');
INSERT INTO `sys_user_t` VALUES ('4', '27db8e3b19364a279b1e9721b5a784c7', 'user', '$2a$10$VEjxo0jq2YG9Rbk2HmX9S.k1uZBGYUHdUcid3g/vfiEl7lwWgOH/K', null, 'user@localhost', '', '', 'zh-cn', null, '80201723640854367683', '2017-06-30 14:49:39', 'system', '2017-06-30 14:49:39', '1', '2017-06-30 14:49:44', '0', '', '3');
INSERT INTO `sys_user_t` VALUES ('5', '27db8e3b19364a279b1e9721b5a784c7', 'system', '$2a$10$5CgTzmdgk9dolbvfhUfTSeEZz5hc4p/YtEMxZoGOeFmq/RhAIIyJC', 'System', 'system@localhost', '', '', 'zh-cn', null, '06542895295499066154', '2017-03-02 23:14:42', 'system', '2017-06-30 14:49:34', '1', '2017-03-02 23:14:43', '0', '', '0');

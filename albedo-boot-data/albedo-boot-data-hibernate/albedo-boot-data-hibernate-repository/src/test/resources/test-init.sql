-- ----------------------------
-- Table structure for gen_scheme_t
-- ----------------------------
DROP TABLE IF EXISTS gen_scheme_t;
CREATE TABLE gen_scheme_t (
  id_ varchar(64) NOT NULL ,
  name_ varchar(200) DEFAULT NULL ,
  category_ varchar(2000) DEFAULT NULL ,
  view_type char(2) DEFAULT NULL ,
  package_name varchar(500) DEFAULT NULL ,
  module_name varchar(30) DEFAULT NULL ,
  sub_module_name varchar(30) DEFAULT NULL ,
  function_name varchar(500) DEFAULT NULL ,
  function_name_simple varchar(100) DEFAULT NULL ,
  function_author varchar(100) DEFAULT NULL ,
  gen_table_id varchar(200) DEFAULT NULL ,
  status_ char(2) DEFAULT '0' ,
  version_ int(11) DEFAULT '0' ,
  description_ varchar(255) DEFAULT NULL ,
  created_by varchar(50) NOT NULL,
  created_date timestamp NOT NULL  AS CURRENT_TIMESTAMP,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for gen_table_column_t
-- ----------------------------
DROP TABLE IF EXISTS gen_table_column_t;
CREATE TABLE gen_table_column_t (
  id_ varchar(64) NOT NULL ,
  gen_table_id varchar(64) DEFAULT NULL ,
  name_ varchar(200) DEFAULT NULL ,
  comments varchar(500) DEFAULT NULL ,
  jdbc_type varchar(100) DEFAULT NULL ,
  java_type varchar(500) DEFAULT NULL ,
  java_field varchar(200) DEFAULT NULL ,
  is_pk char(1) DEFAULT NULL ,
  is_unique char(1) DEFAULT '0' ,
  is_null char(1) DEFAULT NULL ,
  is_insert char(1) DEFAULT NULL ,
  is_edit char(1) DEFAULT NULL ,
  is_list char(1) DEFAULT NULL ,
  is_query char(1) DEFAULT NULL ,
  query_type varchar(200) DEFAULT NULL ,
  show_type varchar(200) DEFAULT NULL ,
  dict_type varchar(200) DEFAULT NULL ,
  settings varchar(2000) DEFAULT NULL ,
  sort_ decimal(10,0) DEFAULT NULL ,
  status_ char(2) DEFAULT '0' ,
  version_ int(11) DEFAULT '0' ,
  description_ varchar(255) DEFAULT NULL ,
  created_by varchar(50) NOT NULL,
  created_date timestamp NOT NULL  AS CURRENT_TIMESTAMP,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id_)
);


DROP TABLE IF EXISTS gen_table_fk_t;
CREATE TABLE gen_table_fk_t (
  id_ varchar(64) NOT NULL ,
  gen_table_id varchar(64) DEFAULT NULL ,
  name_ varchar(200) DEFAULT NULL ,
  comments varchar(500) DEFAULT NULL ,
  jdbc_type varchar(100) DEFAULT NULL ,
  java_type varchar(500) DEFAULT NULL ,
  java_field varchar(200) DEFAULT NULL ,
  is_pk char(1) DEFAULT NULL ,
  is_unique char(1) DEFAULT '0' ,
  is_null char(1) DEFAULT NULL ,
  is_insert char(1) DEFAULT NULL ,
  is_edit char(1) DEFAULT NULL ,
  is_list char(1) DEFAULT NULL ,
  is_query char(1) DEFAULT NULL ,
  query_type varchar(200) DEFAULT NULL ,
  show_type varchar(200) DEFAULT NULL ,
  dict_type varchar(200) DEFAULT NULL ,
  settings varchar(2000) DEFAULT NULL ,
  sort_ decimal(10,0) DEFAULT NULL ,
  status_ char(2) DEFAULT '0' ,
  version_ int(11) DEFAULT '0' ,
  description_ varchar(255) DEFAULT NULL ,
  created_by varchar(50) NOT NULL,
  created_date timestamp NOT NULL  AS CURRENT_TIMESTAMP,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for gen_table_t
-- ----------------------------
DROP TABLE IF EXISTS gen_table_t;
CREATE TABLE gen_table_t (
  id_ varchar(64) NOT NULL ,
  name_ varchar(200) DEFAULT NULL ,
  comments varchar(500) DEFAULT NULL ,
  class_name varchar(100) DEFAULT NULL ,
  parent_table varchar(200) DEFAULT NULL ,
  parent_table_fk varchar(100) DEFAULT NULL ,
  status_ char(2) DEFAULT '0' ,
  version_ int(11) DEFAULT '0' ,
  description_ varchar(255) DEFAULT NULL ,
  created_by varchar(50) NOT NULL,
  created_date timestamp NOT NULL  AS CURRENT_TIMESTAMP,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for gen_template_t
-- ----------------------------
DROP TABLE IF EXISTS gen_template_t;
CREATE TABLE gen_template_t (
  id varchar(64) NOT NULL ,
  name varchar(200) DEFAULT NULL ,
  category varchar(2000) DEFAULT NULL ,
  file_path varchar(500) DEFAULT NULL ,
  file_name varchar(200) DEFAULT NULL ,
  content text ,
  status_ char(2) DEFAULT '0' ,
  version_ int(11) DEFAULT '0' ,
  description_ varchar(255) DEFAULT NULL ,
  created_by varchar(50) NOT NULL,
  created_date timestamp NOT NULL  AS CURRENT_TIMESTAMP,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for jhi_authority
-- ----------------------------
DROP TABLE IF EXISTS jhi_authority;
CREATE TABLE jhi_authority (
  name varchar(50) NOT NULL,
  PRIMARY KEY (name)
);

-- ----------------------------
-- Table structure for jhi_persistent_audit_event
-- ----------------------------
DROP TABLE IF EXISTS jhi_persistent_audit_event;
CREATE TABLE jhi_persistent_audit_event (
  event_id bigint(20) NOT NULL AUTO_INCREMENT,
  principal varchar(50) NOT NULL,
  event_date timestamp NULL DEFAULT NULL,
  event_type varchar(255) DEFAULT NULL,
  PRIMARY KEY (event_id)
);

-- ----------------------------
-- Table structure for jhi_persistent_audit_evt_data
-- ----------------------------
DROP TABLE IF EXISTS jhi_persistent_audit_evt_data;
CREATE TABLE jhi_persistent_audit_evt_data (
  event_id bigint(20) NOT NULL,
  name varchar(150) NOT NULL,
  value varchar(255) DEFAULT NULL,
  PRIMARY KEY (event_id,name)
);

-- ----------------------------
-- Table structure for jhi_persistent_token
-- ----------------------------
DROP TABLE IF EXISTS jhi_persistent_token;
CREATE TABLE jhi_persistent_token (
  id_ varchar(32) NOT NULL,
  series_ varchar(76) NOT NULL,
  user_id bigint(20) DEFAULT NULL,
  token_value varchar(76) NOT NULL,
  token_date date DEFAULT NULL,
  ip_address varchar(39) DEFAULT NULL,
  user_agent varchar(255) DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for logging_event
-- ----------------------------
DROP TABLE IF EXISTS logging_event;
CREATE TABLE logging_event (
  event_id bigint(20) NOT NULL AUTO_INCREMENT,
  timestmp bigint(20) NOT NULL ,
  formatted_message text NOT NULL ,
  logger_name varchar(254) NOT NULL ,
  level_string varchar(254) NOT NULL ,
  thread_name varchar(254) DEFAULT NULL ,
  reference_flag smallint(6) DEFAULT NULL ,
  arg0 varchar(254) DEFAULT NULL ,
  arg1 varchar(254) DEFAULT NULL ,
  arg2 varchar(254) DEFAULT NULL ,
  arg3 varchar(254) DEFAULT NULL ,
  caller_filename varchar(254) NOT NULL ,
  caller_class varchar(254) NOT NULL ,
  caller_method varchar(254) NOT NULL ,
  caller_line char(4) NOT NULL ,
  PRIMARY KEY (event_id)
);

-- ----------------------------
-- Table structure for logging_event_exception
-- ----------------------------
DROP TABLE IF EXISTS logging_event_exception;
CREATE TABLE logging_event_exception (
  event_id bigint(20) NOT NULL,
  i smallint(6) NOT NULL,
  trace_line varchar(254) NOT NULL,
  PRIMARY KEY (event_id,i)
);

-- ----------------------------
-- Table structure for logging_event_property
-- ----------------------------
DROP TABLE IF EXISTS logging_event_property;
CREATE TABLE logging_event_property (
  event_id bigint(20) NOT NULL,
  mapped_key varchar(254) NOT NULL,
  mapped_value text,
  PRIMARY KEY (event_id,mapped_key)
);
DROP TABLE IF EXISTS system_area;
CREATE TABLE system_area (
  id_ int(11) NOT NULL AUTO_INCREMENT,
  parent_ids text,
  parent_id int(11) DEFAULT NULL ,
  name_ varchar(32) DEFAULT NULL ,
  short_name varchar(32) DEFAULT NULL ,
  sort_ int(11) NOT NULL ,
  level_ int(11) DEFAULT NULL ,
  code_ varchar(32) DEFAULT NULL ,
  is_leaf bit(1) DEFAULT '0' ,
  created_by varchar(32) DEFAULT NULL ,
  created_date datetime DEFAULT NULL ,
  last_modified_by varchar(32) DEFAULT NULL ,
  last_modified_date datetime DEFAULT NULL ,
  description_ varchar(225) DEFAULT NULL ,
  status_ varchar(32) DEFAULT '0' ,
  version_ int(11) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (id_)
);
-- ----------------------------
-- Table structure for sys_area_t
-- ----------------------------
DROP TABLE IF EXISTS sys_area_t;
CREATE TABLE sys_area_t (
  id_ int(11) NOT NULL ,
  parent_ids text NOT NULL ,
  parent_id int(11) DEFAULT NULL ,
  name_ varchar(32) DEFAULT NULL ,
  short_name varchar(32) DEFAULT NULL ,
  sort_ int(11) NOT NULL ,
  level_ int(11) DEFAULT NULL ,
  code_ varchar(32) DEFAULT NULL ,
  is_leaf bit(1) DEFAULT '0' ,
  created_by varchar(32) DEFAULT NULL ,
  created_date datetime DEFAULT NULL ,
  last_modified_by varchar(32) DEFAULT NULL ,
  last_modified_date datetime DEFAULT NULL ,
  description_ varchar(225) DEFAULT NULL ,
  status_ varchar(32) DEFAULT '0' ,
  version_ int(11) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for sys_dict_t
-- ----------------------------
DROP TABLE IF EXISTS sys_dict_t;
CREATE TABLE sys_dict_t (
  id_ varchar(32) NOT NULL ,
  name_ varchar(255) DEFAULT NULL ,
  parent_id varchar(32) DEFAULT NULL,
  parent_ids varchar(2000) DEFAULT NULL,
  val_ varchar(255) DEFAULT NULL ,
  code_ varchar(255) DEFAULT NULL ,
  is_leaf bit(1) DEFAULT '0' ,
  sort_ int(11) DEFAULT '0' ,
  description_ varchar(255) DEFAULT NULL ,
  status_ varchar(2) DEFAULT '0',
  show_name varchar(255) DEFAULT NULL ,
  is_show bit(1) DEFAULT '1' ,
  version_ int(11) DEFAULT '0',
  created_by varchar(50) NOT NULL,
  created_date datetime NOT NULL,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date datetime DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for sys_log_login_t
-- ----------------------------
DROP TABLE IF EXISTS sys_log_login_t;
CREATE TABLE sys_log_login_t (
  id_ varchar(32) NOT NULL DEFAULT '0',
  staff_id varchar(32) DEFAULT NULL,
  login_id varchar(50) DEFAULT NULL,
  remote_addr varchar(255) DEFAULT NULL,
  session_id varchar(255) DEFAULT NULL,
  enter_time datetime DEFAULT NULL,
  leave_time datetime DEFAULT NULL,
  total_time int(11) DEFAULT NULL,
  login_flag int(11) DEFAULT NULL,
  description_ varchar(255) DEFAULT NULL,
  status_ varchar(2) DEFAULT '0',
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for sys_log_operate_t
-- ----------------------------
DROP TABLE IF EXISTS sys_log_operate_t;
CREATE TABLE sys_log_operate_t (
  id_ varchar(32) NOT NULL,
  title_ varchar(500) DEFAULT NULL,
  type_ char(1) DEFAULT '0' ,
  staff_id varchar(50) DEFAULT NULL,
  login_id varchar(50) DEFAULT NULL,
  exception_ text,
  request_method varchar(50) DEFAULT NULL ,
  access_method varchar(255) DEFAULT NULL ,
  params_ varchar(2000) DEFAULT NULL,
  remote_addr varchar(255) DEFAULT NULL,
  permissions varchar(255) DEFAULT NULL ,
  time_consuming int(11) DEFAULT NULL,
  request_uri varchar(2000) DEFAULT NULL ,
  user_agent varchar(255) DEFAULT NULL,
  operate_time datetime DEFAULT NULL ,
  operate_des varchar(255) DEFAULT NULL,
  status_ varchar(2) DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for sys_message_deal_t
-- ----------------------------
DROP TABLE IF EXISTS sys_message_deal_t;
CREATE TABLE sys_message_deal_t (
  id_ varchar(32) NOT NULL,
  message_id varchar(32) NOT NULL DEFAULT '0',
  staff_id varchar(32) NOT NULL,
  deal_time datetime DEFAULT NULL,
  version_ int(11) DEFAULT NULL,
  status_ varchar(2) DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for sys_message_t
-- ----------------------------
DROP TABLE IF EXISTS sys_message_t;
CREATE TABLE sys_message_t (
  id_ varchar(32) NOT NULL DEFAULT '0',
  type_ varchar(255) DEFAULT NULL,
  title_ varchar(255) DEFAULT NULL ,
  content_ varchar(4000) DEFAULT NULL,
  attachment_ varchar(255) DEFAULT NULL,
  attach_path varchar(255) DEFAULT NULL ,
  message_flag varchar(255) DEFAULT NULL,
  sender varchar(64) DEFAULT NULL ,
  send_time datetime DEFAULT NULL ,
  create_time datetime DEFAULT NULL ,
  reciver varchar(64) DEFAULT NULL,
  deal_time datetime DEFAULT NULL,
  description_ varchar(255) DEFAULT NULL,
  version_ int(11) DEFAULT NULL,
  status_ varchar(2) DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for sys_module_t
-- ----------------------------
DROP TABLE IF EXISTS sys_module_t;
CREATE TABLE sys_module_t (
  id_ varchar(50) NOT NULL ,
  name_ varchar(255) DEFAULT '' ,
  parent_id varchar(50) DEFAULT NULL ,
  parent_ids varchar(2000) DEFAULT NULL,
  type_ varchar(50) DEFAULT NULL ,
  permission_ varchar(500) DEFAULT NULL ,
  sort_ int(11) DEFAULT '0' ,
  target_ varchar(255) DEFAULT NULL,
  url_ varchar(2000) DEFAULT NULL,
  request_method varchar(64) DEFAULT NULL ,
  status_ varchar(2) DEFAULT NULL ,
  icon_cls varchar(50) DEFAULT NULL,
  show_type varchar(10) DEFAULT '0' ,
  description_ varchar(255) DEFAULT NULL ,
  version_ int(11) NOT NULL,
  is_leaf bit(1) DEFAULT '0' ,
  created_by varchar(50) NOT NULL,
  created_date datetime NOT NULL,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date datetime DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for sys_org_t
-- ----------------------------
DROP TABLE IF EXISTS sys_org_t;
CREATE TABLE sys_org_t (
  id_ varchar(32) NOT NULL DEFAULT '0',
  name_ varchar(255) DEFAULT NULL,
  parent_id varchar(32) DEFAULT NULL,
  parent_ids varchar(2000) DEFAULT NULL,
  code_ varchar(64) DEFAULT NULL ,
  grade_ varchar(255) DEFAULT NULL ,
  is_leaf bit(1) DEFAULT '0' ,
  en_ varchar(255) DEFAULT NULL,
  sort_ int(11) DEFAULT '0' ,
  type_ varchar(64) DEFAULT NULL ,
  status_ int(11) DEFAULT NULL,
  created_by varchar(50) NOT NULL,
  created_date datetime NOT NULL,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date datetime DEFAULT NULL,
  version_ int(11) DEFAULT NULL,
  description_ varchar(255) DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for sys_role_module_t
-- ----------------------------
DROP TABLE IF EXISTS sys_role_module_t;
CREATE TABLE sys_role_module_t (
  role_id varchar(255) NOT NULL,
  module_id varchar(255) NOT NULL,
  PRIMARY KEY (role_id,module_id)
);

-- ----------------------------
-- Table structure for sys_role_org_t
-- ----------------------------
DROP TABLE IF EXISTS sys_role_org_t;
CREATE TABLE sys_role_org_t (
  role_id varchar(32) NOT NULL DEFAULT '0',
  org_id varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (role_id,org_id)
);

-- ----------------------------
-- Table structure for sys_role_t
-- ----------------------------
DROP TABLE IF EXISTS sys_role_t;
CREATE TABLE sys_role_t (
  id_ varchar(32) NOT NULL DEFAULT '0',
  name_ varchar(100) DEFAULT NULL,
  org_id varchar(32) DEFAULT NULL,
  sys_data char(1) DEFAULT NULL ,
  data_scope int(11) DEFAULT NULL ,
  status_ varchar(64) DEFAULT NULL ,
  sort_ int(11) DEFAULT '0' ,
  type_ varchar(225) DEFAULT NULL ,
  en_ varchar(225) DEFAULT NULL,
  description_ varchar(225) DEFAULT NULL,
  version_ int(11) DEFAULT NULL,
  created_by varchar(50) NOT NULL,
  created_date timestamp NOT NULL  AS CURRENT_TIMESTAMP,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for sys_task_schedule_job_t
-- ----------------------------
DROP TABLE IF EXISTS sys_task_schedule_job_t;
CREATE TABLE sys_task_schedule_job_t (
  id_ varchar(32) NOT NULL,
  name_ varchar(255) DEFAULT NULL ,
  group_ varchar(255) DEFAULT NULL ,
  job_status varchar(255) DEFAULT NULL ,
  cron_expression varchar(255) NOT NULL ,
  bean_class varchar(255) DEFAULT NULL ,
  is_concurrent varchar(255) DEFAULT NULL ,
  spring_id varchar(255) DEFAULT NULL ,
  source_id varchar(32) DEFAULT NULL,
  method_name varchar(255) NOT NULL ,
  method_params varchar(512) DEFAULT NULL,
  created_by varchar(50) NOT NULL,
  created_date timestamp NOT NULL  AS CURRENT_TIMESTAMP,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date timestamp NULL DEFAULT NULL,
  status_ int(11) DEFAULT NULL,
  description_ varchar(255) DEFAULT NULL,
  version_ int(11) DEFAULT NULL,
  PRIMARY KEY (id_)
);

-- ----------------------------
-- Table structure for sys_user_role_t
-- ----------------------------
DROP TABLE IF EXISTS sys_user_role_t;
CREATE TABLE sys_user_role_t (
  user_id varchar(255) NOT NULL,
  role_id varchar(255) NOT NULL,
  PRIMARY KEY (user_id,role_id)
);

-- ----------------------------
-- Table structure for sys_user_t
-- ----------------------------
DROP TABLE IF EXISTS sys_user_t;
CREATE TABLE sys_user_t (
  id_ varchar(32) NOT NULL,
  org_id varchar(32) DEFAULT NULL,
  login_id varchar(50) NOT NULL,
  password_hash varchar(60) DEFAULT NULL,
  name_ varchar(50) DEFAULT NULL,
  email_ varchar(100) DEFAULT NULL,
  phone_ varchar(32) DEFAULT NULL,
  activated_ bit(1) NOT NULL,
  lang_key varchar(5) DEFAULT NULL,
  activation_key varchar(20) DEFAULT NULL,
  reset_key varchar(20) DEFAULT NULL,
  reset_date timestamp NULL DEFAULT NULL,
  created_by varchar(50) NOT NULL,
  created_date timestamp NOT NULL  AS CURRENT_TIMESTAMP,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date timestamp NULL DEFAULT NULL,
  status_ int(11) DEFAULT NULL,
  description_ varchar(255) DEFAULT NULL,
  version_ int(11) DEFAULT NULL,
  PRIMARY KEY (id_)
);


DROP TABLE IF EXISTS DS_ROLE;
DROP TABLE IF EXISTS DS_USER;
DROP TABLE IF EXISTS DS_GROUP;
DROP TABLE IF EXISTS DEPARTMENT;

CREATE TABLE DS_USER (
  ID            INT IDENTITY,
  FIRSTNAME     VARCHAR(32)  NULL,
  LASTNAME      VARCHAR(32)  NULL,
  AGE           INT          NULL,
  ACTIVE        INT          NULL,
  CREATED_AT    TIMESTAMP    NULL,
  EMAIL_ADDRESS VARCHAR(128) NULL,
  MANAGER_ID    INT          NULL,
  BINARY_DATA   BLOB         NULL,
  DATE_OF_BIRTH DATE         NULL,
  country       VARCHAR(64)  NULL,
  city          VARCHAR(64)  NULL,
  street_name   VARCHAR(64)  NULL,
  street_no     VARCHAR(64)  NULL,
  PRIMARY KEY (ID)
);
CREATE TABLE DS_ROLE (
  ID       INT IDENTITY,
  NAME     VARCHAR(32) NULL,
  GROUP_ID INT         NULL,
  PRIMARY KEY (ID)
);
CREATE TABLE DS_GROUP (
  ID   INT IDENTITY,
  NAME VARCHAR(32) NULL,
  CODE VARCHAR(32) NULL,
  PRIMARY KEY (ID)
);
CREATE TABLE DEPARTMENT (
  ID                 INT IDENTITY,
  NAME               VARCHAR(32) NULL,
  version            INT         NULL,
  created_date       TIMESTAMP   NULL,
  last_modified_date TIMESTAMP   NULL,
  creator            INT         NULL,
  modifier           INT         NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE ds_booking (
  ID            INT IDENTITY,
  serial_number VARCHAR(32) NULL,
  amount        INT(11)     NULL,
  user_id       INT(11)     NULL,
  PRIMARY KEY (ID)
);
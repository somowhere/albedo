DROP TABLE IF EXISTS "DS_ROLE";
DROP TABLE IF EXISTS "DS_USER";
DROP TABLE IF EXISTS "DS_GROUP";
DROP TABLE IF EXISTS "DEPARTMENT";

CREATE TABLE "DS_USER" (
  ID              BIGSERIAL   NOT NULL,
  "FIRSTNAME"     VARCHAR(32) NULL,
  "LASTNAME"      VARCHAR(32) NULL,
  AGE             INT         NULL,
  ACTIVE          BOOLEAN     NULL,
  CREATED_AT      TIMESTAMP   NULL,
  "EMAIL_ADDRESS" VARCHAR     NULL,
  MANAGER_ID      INT         NULL,
  BINARY_DATA     SMALLINT    NULL,
  DATE_OF_BIRTH   DATE        NULL,
  country         VARCHAR(64) NULL,
  city            VARCHAR(64) NULL,
  street_name     VARCHAR(64) NULL,
  street_no       VARCHAR(64) NULL,
  PRIMARY KEY (ID)
);
CREATE TABLE "DS_ROLE" (
  ID       BIGSERIAL   NOT NULL,
  NAME     VARCHAR(32) NULL,
  GROUP_ID INT         NULL,
  PRIMARY KEY (ID)
);
CREATE TABLE "DS_GROUP" (
  ID   BIGSERIAL   NOT NULL,
  NAME VARCHAR(32) NULL,
  CODE VARCHAR(32) NULL,
  PRIMARY KEY (ID)
);
CREATE TABLE "DEPARTMENT" (
  ID                 BIGSERIAL   NOT NULL,
  NAME               VARCHAR(32) NULL,
  version            INT         NULL,
  created_date       TIMESTAMP   NULL,
  last_modified_date TIMESTAMP   NULL,
  creator            INT         NULL,
  "MODIFIER"         INT         NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE "ds_booking" (
  ID            BIGSERIAL   NOT NULL,
  serial_number VARCHAR(32) NULL,
  amount        INT     NULL,
  user_id       INT     NULL,
  PRIMARY KEY (ID)
);


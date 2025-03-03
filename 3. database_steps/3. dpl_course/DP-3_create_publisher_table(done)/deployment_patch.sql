DEFINE schema_name = "FERB_DBA";

DROP TABLE "&schema_name"."PUBLISHER";

CREATE TABLE "&schema_name"."PUBLISHER" (
publisher_id NUMBER,
name VARCHAR2(200) CONSTRAINT publisher_name_nn NOT NULL,
email  VARCHAR2(70),
phone VARCHAR2(20),
website VARCHAR2(100),
founded_year VARCHAR2(4) CONSTRAINT publisher_founded_year_nn NOT NULL,
status VARCHAR2(20) DEFAULT 'activ',
notes VARCHAR2(200),
description VARCHAR2(250),
rating NUMBER(3,1),
creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON COLUMN "&schema_name"."PUBLISHER".publisher_id IS 'The primary key of publisher table';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".name IS 'The name of the publisher';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".email IS 'The email of the publisher';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".phone IS 'The phone of the publisher';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".website IS 'The website of the publisher';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".founded_year IS 'The founded year of the publisher';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".status IS 'The status of the publisher';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".notes IS 'The notes about the publisher';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".description IS 'The description of the publisher';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".rating IS 'The rating of the publisher';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".creation_date IS 'Tehnical Column - date when the row was inserted';
COMMENT ON COLUMN "&schema_name"."PUBLISHER".update_date IS 'Tehnical Column - date when the row was updated';

ALTER TABLE "&schema_name"."PUBLISHER" ADD CONSTRAINT publisher_id_pk PRIMARY KEY (publisher_id);

CREATE OR REPLACE TRIGGER trigger_upt_dt_publisher
BEFORE UPDATE ON "&schema_name"."PUBLISHER"
FOR EACH ROW 
BEGIN
        :NEW.update_date := CURRENT_TIMESTAMP;
END;
/

ALTER TRIGGER trigger_upt_dt_publisher DISABLE;

ALTER TRIGGER trigger_upt_dt_publisher ENABLE;

DROP SEQUENCE "&schema_name".sequence_publisher_id;
CREATE SEQUENCE "&schema_name".sequence_publisher_id 
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER trigger_seq_publisher_id_pk
BEFORE INSERT ON "&schema_name"."PUBLISHER"
FOR EACH ROW
BEGIN
    :NEW.publisher_id := sequence_publisher_id.NEXTVAL;
END;
/
ALTER TRIGGER trigger_seq_publisher_id_pk DISABLE;
ALTER TRIGGER trigger_seq_publisher_id_pk ENABLE;

COMMIT;
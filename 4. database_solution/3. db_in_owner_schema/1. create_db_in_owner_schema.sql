-- vom defini variabila schema_name pe care o vom folosi pentru a seta schema tuturor obiectelor pe care le vom crea
-- vom folosi variabila prin intermediul &schema_name(referinta)
DEFINE schema_name = "DB_IN_OWNER";

-- CREATE REGION TABLE
-- verificam daca tabela exista
DROP TABLE "&schema_name"."REGION";
-- cream tabela REGION
CREATE TABLE "&schema_name"."REGION" (
region_id NUMBER,
region_name VARCHAR2(50) CONSTRAINT region_name_nn NOT NULL,
creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON COLUMN "&schema_name"."REGION".region_id IS 'The primary key of region table';
COMMENT ON COLUMN "&schema_name"."REGION".region_name IS 'The name of the region';
COMMENT ON COLUMN "&schema_name"."REGION".creation_date IS 'Tehnical Column - date when the row was inserted';
COMMENT ON COLUMN "&schema_name"."REGION".update_date IS 'Tehnical Column - date when the row was updated';
--adaugare constrangeri
ALTER TABLE "&schema_name"."REGION" ADD CONSTRAINT region_id_pk PRIMARY KEY (region_id);
COMMIT;

-- CREATE COUNTRY TABLE
-- verificam daca tabela exista
DROP TABLE "&schema_name"."COUNTRY" CASCADE CONSTRAINTS;
-- cream tabela COUNTRY
CREATE TABLE "&schema_name"."COUNTRY" (
country_id NUMBER,
country_name VARCHAR2(50) CONSTRAINT country_name_nn NOT NULL,
region_id NUMBER CONSTRAINT country_region_id_nn NOT NULL, 
creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON COLUMN "&schema_name"."COUNTRY".country_id IS 'The primary key of COUNTRY table';
COMMENT ON COLUMN "&schema_name"."COUNTRY".country_name IS 'The name of the COUNTRY';
COMMENT ON COLUMN "&schema_name"."COUNTRY".region_id IS 'The foreign key from region table';
COMMENT ON COLUMN "&schema_name"."COUNTRY".creation_date IS 'Tehnical Column - date when the row was inserted';
COMMENT ON COLUMN "&schema_name"."COUNTRY".update_date IS 'Tehnical Column - date when the row was updated';
--adaugare primary key country_id 
ALTER TABLE "&schema_name"."COUNTRY" ADD CONSTRAINT country_id_pk PRIMARY KEY (country_id);

--adaugare foreign key on delete CASCADE 
ALTER TABLE "&schema_name"."COUNTRY" ADD CONSTRAINT region_id_fk FOREIGN KEY (region_id)
REFERENCES "&schema_name"."REGION"(region_id)
ON DELETE CASCADE;
COMMIT;

-- CREATE PUBLISHER TABLE
-- verificam daca tabela exista
DROP TABLE "&schema_name"."PUBLISHER";
-- cream tabela PUBLISHER
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
--comentariile pe tabela publisher
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
--adaugam cheia primara pe coloana publisher_id
ALTER TABLE "&schema_name"."PUBLISHER" ADD CONSTRAINT publisher_id_pk PRIMARY KEY (publisher_id);
COMMIT;

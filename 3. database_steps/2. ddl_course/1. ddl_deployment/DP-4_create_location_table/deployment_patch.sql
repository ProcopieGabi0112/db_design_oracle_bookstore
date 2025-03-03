-- vom defini variabila schema_name pe care o vom folosi pentru a seta schema tuturor obiectelor pe care le vom crea
-- vom folosi variabila prin intermediul &schema_name(referinta)
DEFINE schema_name = "DB_IN_OWNER;

-- CREATE LOCATION TABLE
-- verificam daca tabela exista
DROP TABLE "&schema_name"."LOCATION" CASCADE CONSTRAINTS;
-- cream tabela LOCATION
CREATE TABLE "&schema_name"."LOCATION" (
location_id NUMBER,
street_name VARCHAR2(100) CONSTRAINT location_name_nn NOT NULL,
street_number VARCHAR2(50),
block VARCHAR2(10),
building_entrance VARCHAR2(30),
floor_number NUMBER(3),
apartament_number NUMBER(4),
postal_code VARCHAR2(15) CONSTRAINT postal_code_nn NOT NULL,
city VARCHAR2(100) CONSTRAINT city_nn NOT NULL,
state_province VARCHAR2(50),
country_id NUMBER CONSTRAINT country_id_nn NOT NULL,
publisher_id NUMBER,
creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON COLUMN "&schema_name"."LOCATION".location_id IS 'The primary key of location table';
COMMENT ON COLUMN "&schema_name"."LOCATION".street_name IS 'The street name of the location';
COMMENT ON COLUMN "&schema_name"."LOCATION".street_number IS 'The street number of the location';
COMMENT ON COLUMN "&schema_name"."LOCATION".block IS 'The block of the location';
COMMENT ON COLUMN "&schema_name"."LOCATION".building_entrance IS 'The building entrance of the location';
COMMENT ON COLUMN "&schema_name"."LOCATION".floor_number IS 'The floor number of the location';
COMMENT ON COLUMN "&schema_name"."LOCATION".apartament_number IS 'The apartament number of the location';
COMMENT ON COLUMN "&schema_name"."LOCATION".postal_code IS 'The postal_code of the location';
COMMENT ON COLUMN "&schema_name"."LOCATION".city IS 'The city of the location';
COMMENT ON COLUMN "&schema_name"."LOCATION".state_province IS 'The state province of the location';
COMMENT ON COLUMN "&schema_name"."LOCATION".country_id IS 'The foreign key from country table';
COMMENT ON COLUMN "&schema_name"."LOCATION".publisher_id IS 'The foreign key from publisher table';
COMMENT ON COLUMN "&schema_name"."LOCATION".creation_date IS 'Tehnical Column - date when the row was inserted';
COMMENT ON COLUMN "&schema_name"."LOCATION".update_date IS 'Tehnical Column - date when the row was updated';
--adaugare primary key LOCATION_id 
ALTER TABLE "&schema_name"."LOCATION" ADD CONSTRAINT location_id_pk PRIMARY KEY (location_id);

--adaugare foreign key on delete CASCADE 
ALTER TABLE "&schema_name"."LOCATION" ADD CONSTRAINT country_id_fk FOREIGN KEY (country_id)
REFERENCES "&schema_name"."COUNTRY"(country_id)
ON DELETE CASCADE;
ALTER TABLE "&schema_name"."LOCATION" ADD CONSTRAINT publisher_id_fk FOREIGN KEY (publisher_id)
REFERENCES "&schema_name"."PUBLISHER"(publisher_id)
ON DELETE CASCADE;
COMMIT;

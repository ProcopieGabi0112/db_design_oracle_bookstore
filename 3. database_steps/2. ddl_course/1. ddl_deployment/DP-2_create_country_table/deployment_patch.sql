DEFINE schema_name = "DB_IN_OWNER";

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
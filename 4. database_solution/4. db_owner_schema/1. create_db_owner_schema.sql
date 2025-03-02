-- vom defini variabila schema_name pe care o vom folosi pentru a seta schema tuturor obiectelor pe care le vom crea
-- vom folosi variabila prin intermediul &schema_name(referinta)
DEFINE schema_name = "DB_OWNER";

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
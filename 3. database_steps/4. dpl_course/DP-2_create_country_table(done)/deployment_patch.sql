-- vom defini variabila schema_name pe care o vom folosi pentru a seta schema tuturor obiectelor pe care le vom crea
-- vom folosi variabila prin intermediul &schema_name(referinta)
DEFINE schema_name = "FERB_DBA";

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

-- vom crea un trigger care va actualiza valoarea de pe coloana update_date in momentul in care oricare dintre valorile
-- din inregistrarea respectiva sunt modicate 
CREATE OR REPLACE TRIGGER trigger_upt_dt_country
BEFORE UPDATE ON "&schema_name"."COUNTRY"
FOR EACH ROW 
BEGIN
        :NEW.update_date := CURRENT_TIMESTAMP;
END;
/
--trigger-ul odata rulat este activat
--acesta se poate dezactiva folosind comanda
ALTER TRIGGER trigger_upt_dt_country DISABLE;
--si se poate activa la loc 
ALTER TRIGGER trigger_upt_dt_country ENABLE;
-- acum vom crea o secventa
DROP SEQUENCE sequence_country_id;
CREATE SEQUENCE sequence_country_id 
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;
-- acum vom crea un trigger care va prelua ultima valoare din secventa de mai sus si o va face cheie primara pentru 
-- inregistrarile pe care incercam sa le introduce in tabela COUNTRY.
CREATE OR REPLACE TRIGGER trigger_seq_country_id_pk
BEFORE INSERT ON "&schema_name"."COUNTRY"
FOR EACH ROW
BEGIN
    :NEW.country_id := sequence_country_id.NEXTVAL;
END;
/
--trigger-ul odata rulat este activat
--acesta se poate dezactiva folosind comanda
ALTER TRIGGER trigger_seq_country_id_pk DISABLE;
--si se poate activa la loc 
ALTER TRIGGER trigger_seq_country_id_pk ENABLE;
COMMIT;
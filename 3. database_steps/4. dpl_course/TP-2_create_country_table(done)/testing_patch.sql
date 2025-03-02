-- 1. verificare existenta tabela;
SELECT * FROM FERB_DBA.COUNTRY;

-- 2. verificare structura tabela;
DESCRIBE FERB_DBA.COUNTRY;
--Name          Null?    Type         
------------- -------- ------------ 
--COUNTRY_ID    NOT NULL NUMBER       
--COUNTRY_NAME  NOT NULL VARCHAR2(50) 
--REGION_ID     NOT NULL NUMBER       
--CREATION_DATE          TIMESTAMP(6) 
--UPDATE_DATE            TIMESTAMP(6) 

-- 3. verificare comentarii coloane adaugate;
SELECT column_name, comments
FROM user_col_comments
WHERE table_name = 'COUNTRY';
--COUNTRY_ID	The primary key of COUNTRY table
--COUNTRY_NAME	The name of the COUNTRY
--REGION_ID		The foreign key from region table
--CREATION_DATE	Tehnical Column - date when the row was inserted
--UPDATE_DATE	Tehnical Column - date when the row was updated

-- 4. verificare constrangeri simple adaugate pe coloane;
SELECT constraint_name,search_condition,constraint_type,index_name,status,last_change
FROM user_constraints
WHERE UPPER(owner) LIKE '%FERB_DBA%'
AND UPPER(table_name) LIKE '%COUNTRY%';
--REGION_ID_FK										R					ENABLED	09-FEB-25
--COUNTRY_REGION_ID_NN	"REGION_ID" IS NOT NULL		C					ENABLED	09-FEB-25
--COUNTRY_NAME_NN		"COUNTRY_NAME" IS NOT NULL	C					ENABLED	09-FEB-25
--COUNTRY_ID_PK										P	COUNTRY_ID_PK	ENABLED	09-FEB-25	                          P	              COUNTRY_ID_PK	ENABLED	31-01-2025

-- 5. verifica constrangere de tip foreign key on delete cascade;
-- 5.1. insereaza in tabela region 2 inregistrari cu doua regiuni.
INSERT INTO FERB_DBA.REGION(region_id,region_name)
VALUES (1,'Europa');
INSERT INTO FERB_DBA.REGION(region_id,region_name)
VALUES (2,'Asia');
-- 5.2. vom insera 4 inregistraril in tabela country. primele doua inregistrari
--      vor avea region_id-ul=1. celelalte 2 inregistrari vor avea region_id-ul=2
INSERT INTO FERB_DBA.COUNTRY(country_id,country_name,region_id)
VALUES (7,'Olanda',1);
INSERT INTO FERB_DBA.COUNTRY(country_id,country_name,region_id)
VALUES (8,'Belgia',1);
INSERT INTO FERB_DBA.COUNTRY(country_id,country_name,region_id)
VALUES (9,'China',2);
INSERT INTO FERB_DBA.COUNTRY(country_id,country_name,region_id)
VALUES (10,'Mongolia',2);
-- 5.3. sterge o inregistrare din tabela region.
DELETE FROM FERB_DBA.REGION
WHERE region_id=2;
-- 5.4. verifica daca au fost sterse si cele doua inregistrari din tabela country 
--      care au fost legate de inregistrarea stearsa din tabela region. 
SELECT * FROM COUNTRY;
--1	Olanda	1	09-FEB-25 06.08.35.439000000 PM	09-FEB-25 06.08.35.439000000 PM
--2	Belgia	1	09-FEB-25 06.08.35.447000000 PM	09-FEB-25 06.08.35.447000000 PM
	
--6. verificare trigger pentru update
--   6.1. inserare in tabela o inregistrare;
INSERT INTO FERB_DBA.COUNTRY(country_id,country_name,region_id)
VALUES (57,'Japonia',1);
-- 1 row inserted.

-- 6.2. realizeaza un update pe inregistrarea respectiva;
UPDATE FERB_DBA.COUNTRY 
SET country_name = 'JAPONIA OCC'
WHERE country_id = 5;
-- 1 row updated.

--6.3. verifica daca valoarea de pe update_date a fost modificata;
SELECT * FROM FERB_DBA.COUNTRY;
--5	JAPONIA OCC	1	09-FEB-25 06.15.05.539000000 PM	09-FEB-25 06.16.50.960000000 PM

-- 7 verifica daca fluxul realizat de trigger este in regula;
-- 7.1. dau truncate la tabela ca sa elimin inregistrarile din tabela
TRUNCATE TABLE FERB_DBA.COUNTRY;

-- 7.2. insereaza 5 inregistrari in tabel folosind doar coloana COUNTRY_name;
INSERT INTO FERB_DBA.COUNTRY(country_name,region_id) VALUES ('Anglia',1);
INSERT INTO FERB_DBA.COUNTRY(country_name,region_id) VALUES ('Franta',1);
INSERT INTO FERB_DBA.COUNTRY(country_name,region_id) VALUES ('Croatia',1);
INSERT INTO FERB_DBA.COUNTRY(country_name,region_id) VALUES ('Ucraina',1);
INSERT INTO FERB_DBA.COUNTRY(country_name,region_id) VALUES ('Romania',1);
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.

-- 7.3. verifica daca pe coloana country_id sunt valori consecutive;
SELECT * FROM FERB_DBA.COUNTRY;
--6	Anglia	1	09-FEB-25 06.23.00.307000000 PM	09-FEB-25 06.23.00.307000000 PM
--7	Franta	1	09-FEB-25 06.23.00.321000000 PM	09-FEB-25 06.23.00.321000000 PM
--8	Croatia	1	09-FEB-25 06.23.00.328000000 PM	09-FEB-25 06.23.00.328000000 PM
--9	Ucraina	1	09-FEB-25 06.23.00.334000000 PM	09-FEB-25 06.23.00.334000000 PM
--10Romania	1	09-FEB-25 06.23.00.340000000 PM	09-FEB-25 06.23.00.340000000 PM
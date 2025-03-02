-- 1. verificare existenta tabela;
SELECT * FROM DB_IN_OWNER.COUNTRY;

-- 2. verificare structura tabela;
DESCRIBE DB_IN_OWNER.COUNTRY;
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
WHERE UPPER(owner) LIKE '%DB_IN_OWNER%'
AND UPPER(table_name) LIKE '%COUNTRY%';
--REGION_ID_FK		                                R		            ENABLED	02-MAR-25
--COUNTRY_NAME_NN	    "COUNTRY_NAME" IS NOT NULL	C		            ENABLED	02-MAR-25
--COUNTRY_REGION_ID_NN	"REGION_ID" IS NOT NULL	    C		            ENABLED	02-MAR-25
--COUNTRY_ID_PK		                                P	COUNTRY_ID_PK	ENABLED	02-MAR-25                          

--verificare constrangere de tip NULL, DEFAULT
SELECT * FROM DB_IN_OWNER.REGION;
INSERT INTO DB_IN_OWNER.COUNTRY(country_id,country_name,region_id)
VALUES (null,'Romania',1);
INSERT INTO DB_IN_OWNER.COUNTRY(country_id,country_name,region_id)
VALUES (1,null,1);
INSERT INTO DB_IN_OWNER.COUNTRY(country_id,country_name,region_id)
VALUES (1,'America',1);
SELECT * FROM DB_IN_OWNER.COUNTRY;

-- 5. verifica constrangere de tip foreign key on delete cascade;
-- 5.1. insereaza in tabela region 2 inregistrari cu doua regiuni.
INSERT INTO DB_IN_OWNER.REGION(region_id,region_name)
VALUES (1,'Europa');
INSERT INTO DB_IN_OWNER.REGION(region_id,region_name)
VALUES (2,'Asia');
-- 5.2. vom insera 4 inregistraril in tabela country. primele doua inregistrari
--      vor avea region_id-ul=1. celelalte 2 inregistrari vor avea region_id-ul=2
INSERT INTO DB_IN_OWNER.COUNTRY(country_id,country_name,region_id)
VALUES (7,'Olanda',1);
INSERT INTO DB_IN_OWNER.COUNTRY(country_id,country_name,region_id)
VALUES (8,'Belgia',1);
INSERT INTO DB_IN_OWNER.COUNTRY(country_id,country_name,region_id)
VALUES (9,'China',2);
INSERT INTO DB_IN_OWNER.COUNTRY(country_id,country_name,region_id)
VALUES (10,'Mongolia',2);
SELECT * FROM COUNTRY;
-- 5.3. sterge o inregistrare din tabela region.
DELETE FROM DB_IN_OWNER.REGION
WHERE region_id=2;
-- 5.4. verifica daca au fost sterse si cele doua inregistrari din tabela country 
--      care au fost legate de inregistrarea stearsa din tabela region. 
SELECT * FROM COUNTRY;
--7	Olanda	1	02-MAR-25 02.04.41.800000000 PM	02-MAR-25 02.04.41.800000000 PM
--8	Belgia	1	02-MAR-25 02.04.41.807000000 PM	02-MAR-25 02.04.41.807000000 PM
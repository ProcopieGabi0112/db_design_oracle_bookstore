-- 1. verificare existenta tabela;
SELECT * FROM FERB_DBA.PUBLISHER;

-- 2. verificare structura tabela;
DESCRIBE FERB_DBA.PUBLISHER;
--Name          Null?    Type          
--------------- -------- ------------- 
--PUBLISHER_ID  NOT NULL NUMBER        
--NAME          NOT NULL VARCHAR2(200) 
--EMAIL                  VARCHAR2(70)  
--PHONE                  VARCHAR2(20)  
--WEBSITE                VARCHAR2(100) 
--FOUNDED_YEAR  NOT NULL VARCHAR2(4)   
--STATUS                 VARCHAR2(20)  
--NOTES                  VARCHAR2(200) 
--DESCRIPTION            VARCHAR2(250) 
--RATING                 NUMBER(3,1)   
--CREATION_DATE          TIMESTAMP(6)  
--UPDATE_DATE            TIMESTAMP(6)  

-- 3. verificare comentarii coloane adaugate;
SELECT column_name, comments
FROM user_col_comments
WHERE table_name = 'PUBLISHER';
--PUBLISHER_ID	The primary key of publisher table
--NAME	The name of the publisher
--EMAIL	The email of the publisher
--PHONE	The phone of the publisher
--WEBSITE	The website of the publisher
--FOUNDED_YEAR	The founded year of the publisher
--STATUS	The status of the publisher
--NOTES	The notes about the publisher
--DESCRIPTION	The description of the publisher
--RATING	The rating of the publisher
--CREATION_DATE	Tehnical Column - date when the row was inserted
--UPDATE_DATE	Tehnical Column - date when the row was updated

-- 4. verificare constrangeri simple adaugate pe coloane;
SELECT constraint_name,search_condition,constraint_type,index_name,status,last_change
FROM user_constraints
WHERE UPPER(owner) LIKE '%FERB_DBA%'
AND UPPER(table_name) LIKE '%PUBLISHER%';
--PUBLISHER_FOUNDED_YEAR_NN	"FOUNDED_YEAR" IS NOT NULL	C		ENABLED	15-FEB-25
--PUBLISHER_NAME_NN	"NAME" IS NOT NULL	C		ENABLED	15-FEB-25
--PUBLISHER_ID_PK		P	PUBLISHER_ID_PK	ENABLED	15-FEB-25


--5. verificare trigger pentru update
--   5.1. inserare in tabela o inregistrare;
INSERT INTO FERB_DBA.PUBLISHER(publisher_id,name,email,phone,website,founded_year,notes,description,rating)
VALUES (7,'Editura Art','george.adelin@art.com','+4074587646','www.edituraart.ro','1997',null,null,3.7);
-- 1 row inserted.

-- 5.2. realizeaza un update pe inregistrarea respectiva;
UPDATE FERB_DBA.PUBLISHER 
SET name = 'Editura Arthur'
WHERE publisher_id = 1;
-- 1 row updated.

--5.3. verifica daca valoarea de pe update_date a fost modificata;
SELECT * FROM FERB_DBA.PUBLISHER;
--1	Editura Arthur	george.adelin@art.com	+4074587646	www.edituraart.ro	1997	activ			3.7	15-FEB-25 06.26.04.232000000 PM	15-FEB-25 06.27.41.140000000 PM

-- 6 verifica daca fluxul realizat de trigger este in regula;
-- 6.1. dau truncate la tabela ca sa elimin inregistrarile din tabela
TRUNCATE TABLE FERB_DBA.PUBLISHER;

-- 6.2. insereaza 5 inregistrari in tabel folosind doar coloana PUBLISHER_name;
INSERT INTO FERB_DBA.PUBLISHER(name,email,phone,website,founded_year,notes,description,rating) VALUES ('Editura Art','george.adelin@art.com','+4074587646','www.edituraart.ro','1997',null,null,3.7);
INSERT INTO FERB_DBA.PUBLISHER(name,email,phone,website,founded_year,notes,description,rating) VALUES ('Editura Arthur','george.adelin@arthur.com','+4074587546','www.edituraarthur.ro','1967',null,null,10.0);
-- 1 row inserted.
-- 1 row inserted.

-- 6.3. verifica daca pe coloana publisher_id sunt valori consecutive;
SELECT * FROM FERB_DBA.PUBLISHER;
--2	Editura Art	george.adelin@art.com	+4074587646	www.edituraart.ro	1997	activ			3.7	15-FEB-25 06.32.37.683000000 PM	15-FEB-25 06.32.37.683000000 PM
--3	Editura Arthur	george.adelin@arthur.com	+4074587546	www.edituraarthur.ro	1967	activ			10	15-FEB-25 06.32.37.698000000 PM	15-FEB-25 06.32.37.698000000 PM
-- 1. verificare existenta tabela;
SELECT * FROM FERB_DBA.LOCATION;

-- 2. verificare structura tabela;
DESCRIBE FERB_DBA.LOCATION;
--Name              Null?    Type          
----------------- -------- ------------- 
--LOCATION_ID       NOT NULL NUMBER        
--STREET_NAME       NOT NULL VARCHAR2(100) 
--STREET_NUMBER              VARCHAR2(50)  
--BLOCK                      VARCHAR2(10)  
--BUILDING_ENTRANCE          VARCHAR2(30)  
--FLOOR_NUMBER               NUMBER(3)     
--APARTAMENT_NUMBER          NUMBER(4)     
--POSTAL_CODE       NOT NULL VARCHAR2(15)  
--CITY              NOT NULL VARCHAR2(100) 
--STATE_PROVINCE             VARCHAR2(50)  
--COUNTRY_ID        NOT NULL NUMBER        
--PUBLISHER_ID               NUMBER        
--CREATION_DATE              TIMESTAMP(6)  
--UPDATE_DATE                TIMESTAMP(6)  


-- 3. verificare comentarii coloane adaugate;
SELECT column_name, comments
FROM user_col_comments
WHERE table_name = 'LOCATION';
--LOCATION_ID		The primary key of location table
--STREET_NAME		The street name of the location
--STREET_NUMBER		The street number of the location
--BLOCK				The block of the location
--BUILDING_ENTRANCE	The building entrance of the location
--FLOOR_NUMBER		The floor number of the location
--APARTAMENT_NUMBER	The apartament number of the location
--POSTAL_CODE		The postal_code of the location
--CITY				The city of the location
--STATE_PROVINCE	The state_provinceof the location
--COUNTRY_ID		The foreign key from region table
--PUBLISHER_ID		The foreign key from region table
--CREATION_DATE		Tehnical Column - date when the row was inserted
--UPDATE_DATE		Tehnical Column - date when the row was updated

-- 4. verificare constrangeri simple adaugate pe coloane;
SELECT constraint_name,search_condition,constraint_type,index_name,status,last_change
FROM user_constraints
WHERE UPPER(owner) LIKE '%FERB_DBA%'
AND UPPER(table_name) LIKE '%LOCATION%';
--COUNTRY_ID_FK									R						ENABLED	16-FEB-25
--PUBLISHER_ID_FK								R						ENABLED	16-FEB-25
--POSTAL_CODE_NN	"POSTAL_CODE" IS NOT NULL	C						ENABLED	16-FEB-25
--LOCATION_NAME_NN	"STREET_NAME" IS NOT NULL	C						ENABLED	16-FEB-25
--CITY_NN			"CITY" IS NOT NULL			C						ENABLED	16-FEB-25
--COUNTRY_ID_NN		"COUNTRY_ID" IS NOT NULL	C						ENABLED	16-FEB-25
--LOCATION_ID_PK								P	LOCATION_ID_PK		ENABLED	16-FEB-25

-- 5. verifica constrangere de tip foreign key on delete cascade;
-- 5.1. insereaza in tabela region 2 inregistrari cu doua regiuni.
INSERT INTO FERB_DBA.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (101,'Linistei','27','061012','Bucuresti','10');
INSERT INTO FERB_DBA.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (102,'Cernisoara','1','061001','Bucuresti','10');
-- 5.2. vom insera 4 inregistrari in tabela location. primele doua inregistrari
--      vor avea country_id-ul=10. celelalte 2 inregistrari vor avea location_id-ul=(6 si 7)
INSERT INTO FERB_DBA.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (101,'Linistei','27','061012','Bucuresti','10');
INSERT INTO FERB_DBA.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (102,'Cernisoara','1','061001','Bucuresti','10');
INSERT INTO FERB_DBA.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (103,'Principal','75B','091012','Paris','7');
INSERT INTO FERB_DBA.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (104,'Picadilly Circus','5','071001','London','6');
--1	Linistei			27					061012	Bucuresti		10		17-FEB-25 11.32.45.089000000 AM	17-FEB-25 11.32.45.089000000 AM
--2	Cernisoara			1					061001	Bucuresti		10		17-FEB-25 11.34.00.324000000 AM	17-FEB-25 11.34.00.324000000 AM
--3	Picadilly Circus	5					071001	London			6		17-FEB-25 12.01.05.118000000 PM	17-FEB-25 12.01.05.118000000 PM
--4	Principal			75B					091012	Paris			7		17-FEB-25 12.01.42.158000000 PM	17-FEB-25 12.01.42.158000000 PM
-- 5.3. sterge o inregistrare din tabela country.
DELETE FROM FERB_DBA.COUNTRY
WHERE country_id=10;
-- 5.4. verifica daca au fost sterse si cele doua inregistrari din tabela location
--      care au fost legate de inregistrarea stearsa din tabela country. 
SELECT * FROM COUNTRY;
--3	Picadilly Circus	5					071001	London		6		17-FEB-25 12.01.05.118000000 PM	17-FEB-25 12.01.05.118000000 PM
--4	Principal			75B					091012	Paris		7		17-FEB-25 12.01.42.158000000 PM	17-FEB-25 12.01.42.158000000 PM
	
--6. verificare trigger pentru update
--   6.1. inserare in tabela o inregistrare;
INSERT INTO FERB_DBA.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (105,'Bulevardul Mare','105','031010','Zagreb','8');
-- 1 row inserted.

-- 6.2. realizeaza un update pe inregistrarea respectiva;
UPDATE FERB_DBA.LOCATION
SET street_name = 'Bulevardul Mai Mare'
WHERE location_id = 6;
-- 1 row updated.

--6.3. verifica daca valoarea de pe update_date a fost modificata;
SELECT * FROM FERB_DBA.LOCATION;
--6	Bulevardul Mai Mare	105					031010	Zagreb		8		17-FEB-25 12.16.45.941000000 PM	17-FEB-25 12.21.57.645000000 PM

-- 7 verifica daca fluxul realizat de trigger este in regula;
-- 7.1. dau truncate la tabela ca sa elimin inregistrarile din tabela
TRUNCATE TABLE FERB_DBA.LOCATION;

-- 7.2. insereaza 5 inregistrari in tabel folosind doar coloanele cu constrangerea NN;
INSERT INTO FERB_DBA.LOCATION(street_name,street_number,postal_code,city,country_id) VALUES ('Linistei','27','061012','Bucuresti','9');
INSERT INTO FERB_DBA.LOCATION(street_name,street_number,postal_code,city,country_id) VALUES ('Cernisoara','1','061001','Bucuresti','9');
INSERT INTO FERB_DBA.LOCATION(street_name,street_number,postal_code,city,country_id) VALUES ('Principal','75B','091012','Paris','7');
INSERT INTO FERB_DBA.LOCATION(street_name,street_number,postal_code,city,country_id) VALUES ('Picadilly Circus','5','071001','London','6');
INSERT INTO FERB_DBA.LOCATION(street_name,street_number,postal_code,city,country_id) VALUES ('Bulevardul Mai Mare','105','031010','Zagreb','8');
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.

-- 7.3. verifica daca pe coloana location_id sunt valori consecutive;
SELECT * FROM FERB_DBA.LOCATION;
--11	Linistei			27					061012	Bucuresti	9		17-FEB-25 12.55.40.662000000 PM	17-FEB-25 12.55.40.662000000 PM
--12	Cernisoara			1					061001	Bucuresti	9		17-FEB-25 12.55.40.677000000 PM	17-FEB-25 12.55.40.677000000 PM
--13	Principal			75B					091012	Paris		7		17-FEB-25 12.55.40.686000000 PM	17-FEB-25 12.55.40.686000000 PM
--14	Picadilly Circus	5					071001	London		6		17-FEB-25 12.55.40.691000000 PM	17-FEB-25 12.55.40.691000000 PM
--15	Bulevardul Mai Mare	105					031010	Zagreb		8		17-FEB-25 12.55.40.697000000 PM	17-FEB-25 12.55.40.697000000 PM

COMMIT;
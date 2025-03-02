-- 1. verificare existenta tabela;
SELECT * FROM DB_IN_OWNER.LOCATION;

-- 2. verificare structura tabela;
DESCRIBE DB_IN_OWNER.LOCATION;
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
WHERE UPPER(owner) LIKE '%DB_IN_OWNER%'
AND UPPER(table_name) LIKE '%LOCATION%';
--COUNTRY_ID_FK		                            R		            ENABLED	02-MAR-25
--PUBLISHER_ID_FK		                        R		            ENABLED	02-MAR-25
--POSTAL_CODE_NN	"POSTAL_CODE" IS NOT NULL	C		            ENABLED	02-MAR-25
--CITY_NN	        "CITY" IS NOT NULL	        C		            ENABLED	02-MAR-25
--COUNTRY_ID_NN	    "COUNTRY_ID" IS NOT NULL	C		            ENABLED	02-MAR-25
--LOCATION_NAME_NN	"STREET_NAME" IS NOT NULL	C		            ENABLED	02-MAR-25
--LOCATION_ID_PK		                        P	LOCATION_ID_PK	ENABLED	02-MAR-25

--verificam constrangerea NULL
INSERT INTO DB_IN_OWNER.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO DB_IN_OWNER.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (101,'Linistei','27','061012','Bucuresti','1');
INSERT INTO DB_IN_OWNER.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)


-- 5. verifica constrangere de tip foreign key on delete cascade;
-- 5.1. insereaza in tabela region 2 inregistrari cu doua regiuni.
VALUES (102,'Principal Str.','72','601120','Bruxelle','2');
SELECT * FROM DB_IN_OWNER.LOCATION;
INSERT INTO DB_IN_OWNER.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (103,'Cernisoara','1','061001','Bucuresti','1');
-- 5.2. vom insera 4 inregistrari in tabela location. primele doua inregistrari
--      vor avea country_id-ul=10. celelalte 2 inregistrari vor avea location_id-ul=(6 si 7)
INSERT INTO DB_IN_OWNER.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (101,'Linistei','27','061012','Bucuresti','10');
INSERT INTO DB_IN_OWNER.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (102,'Cernisoara','1','061001','Bucuresti','10');
INSERT INTO DB_IN_OWNER.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (105,'Picadilly Circus','5','071001','London','3');
INSERT INTO DB_IN_OWNER.LOCATION(location_id,street_name,street_number,postal_code,city,country_id)
VALUES (105,'Principal','75B','091012','Paris','2');
--101	Linistei	        27					061012	Bucuresti		1		02-MAR-25 05.18.21.367000000 PM	02-MAR-25 05.18.21.367000000 PM
--102	Principal Str.	    72					601120	Bruxelle		2		02-MAR-25 05.19.01.667000000 PM	02-MAR-25 05.19.01.667000000 PM
--103	Cernisoara	        1					061001	Bucuresti		1		02-MAR-25 05.29.14.390000000 PM	02-MAR-25 05.29.14.390000000 PM
--104	Picadilly Circus	5					071001	London		    3		02-MAR-25 05.29.38.283000000 PM	02-MAR-25 05.29.38.283000000 PM
--105	Principal	        75B					091012	Paris		    2		02-MAR-25 05.30.12.461000000 PM	02-MAR-25 05.30.12.461000000 PM


-- 5.3. sterge o inregistrare din tabela country.
DELETE FROM DB_IN_OWNER.COUNTRY
WHERE country_id=1;
-- 5.4. verifica daca au fost sterse si cele doua inregistrari din tabela location
--      care au fost legate de inregistrarea stearsa din tabela country. 
SELECT * FROM LOCATION;
--102	Principal Str.	    72					601120	Bruxelle		2		02-MAR-25 05.19.01.667000000 PM	02-MAR-25 05.19.01.667000000 PM
--104	Picadilly Circus	5					071001	London		    3		02-MAR-25 05.29.38.283000000 PM	02-MAR-25 05.29.38.283000000 PM
--105	Principal	        75B					091012	Paris		    2		02-MAR-25 05.30.12.461000000 PM	02-MAR-25 05.30.12.461000000 PM
COMMIT;
-- 1. verificare existenta tabela;
SELECT * FROM DB_IN_OWNER.PUBLISHER;

-- 2. verificare structura tabela;
DESCRIBE DB_IN_OWNER.PUBLISHER;
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
WHERE UPPER(owner) LIKE '%DB_IN_OWNER%'
AND UPPER(table_name) LIKE '%PUBLISHER%';
--PUBLISHER_NAME_NN	            "NAME" IS NOT NULL	        C		                ENABLED	02-MAR-25
--PUBLISHER_FOUNDED_YEAR_NN	    "FOUNDED_YEAR" IS NOT NULL	C		                ENABLED	02-MAR-25
--PUBLISHER_ID_PK		                                    P	PUBLISHER_ID_PK 	ENABLED	02-MAR-25

--verificare constrangere de tip NULL, DEFAULT
INSERT INTO DB_IN_OWNER.PUBLISHER(publisher_id,name,founded_year)
VALUES (1,null,1998);
INSERT INTO DB_IN_OWNER.PUBLISHER(publisher_id,name,founded_year)
VALUES (1,'Editura Artemis',null);
INSERT INTO DB_IN_OWNER.PUBLISHER(publisher_id,name,founded_year)
VALUES (1,'Editura Artemis',1998);
SELECT * FROM DB_IN_OWNER.PUBLISHER;
--1	Editura Artemis				1998	activ				02-MAR-25 03.00.24.909000000 PM	02-MAR-25 03.00.24.909000000 PM

-- 1. verificare existenta tabela;
SELECT * FROM DB_IN_OWNER.REGION;

-- 2. verificare structura tabela;
DESCRIBE DB_IN_OWNER.REGION;
--Name          Null?    Type         
--------------- -------- ------------ 
--REGION_ID     NOT NULL NUMBER       
--REGION_NAME   NOT NULL VARCHAR2(50) 
--CREATION_DATE          TIMESTAMP(6) 
--UPDATE_DATE            TIMESTAMP(6)

-- 3. verificare comentarii coloane adaugate;
SELECT column_name, comments
FROM user_col_comments
WHERE table_name = 'REGION';
--REGION_ID	    The primary key of region table
--REGION_NAME	The name of the region
--CREATION_DATE	Tehnical Column - date when the row was inserted
--UPDATE_DATE	Tehnical Column - date when the row was updated

-- 4. verificare constrangeri adaugate pe coloane;
SELECT constraint_name,search_condition,constraint_type,index_name,status,last_change
FROM user_constraints
WHERE UPPER(owner) LIKE '%DB_IN_OWNER%'
AND UPPER(table_name) LIKE '%REGION%';
--constraint_name  search_condition           constraint_type index_name    status  last_change
--REGION_NAME_NN   "REGION_NAME" IS NOT NULL  C		                        ENABLED	31-01-2025
--REGION_ID_PK		                          P	              REGION_ID_PK	ENABLED	31-01-2025

--verificare contrangere de tip default
INSERT INTO DB_IN_OWNER.REGION(region_id,region_name) values (34,'Europa');
SELECT * FROM DB_IN_OWNER.REGION;
--verificare contrangere de tip null
INSERT INTO DB_IN_OWNER.REGION(region_id,region_name) values (null,null);
SELECT * FROM DB_IN_OWNER.REGION;
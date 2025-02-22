-- RUNNING ON SYS_USER
--change to CDB$ROOT container;
ALTER SESSION SET CONTAINER = CDB$ROOT;

--CREATE CDB$ROOT TABLESPACE bookstore_tablespace
--delete if exists this tablespace;				                                                          ()	            - SYSTEM - READ WRITE
DROP TABLESPACE bookstore_tablespace INCLUDING CONTENTS AND DATAFILES;
--create tablespace
CREATE TABLESPACE bookstore_tablespace
DATAFILE 'C:\ORACLE19C\ORADATA\ORCL\bookstore_tablespace.dbf' 
SIZE 1G  
AUTOEXTEND ON NEXT 1G MAXSIZE 2G
ONLINE;

--CREATE BOOKSTORE_DB DATABASE
--delete if exists this database;
ALTER PLUGGABLE DATABASE bookstore_db CLOSE;
DROP PLUGGABLE DATABASE bookstore_db INCLUDING DATAFILES;
--create database
CREATE PLUGGABLE DATABASE bookstore_db
ADMIN USER bookstore_db_owner IDENTIFIED BY bookstore_db_owner_pass
DEFAULT TABLESPACE bookstore_tablespace
DATAFILE 'C:\oracle19c\oradata\ORCL\bookstore_db' SIZE 3G AUTOEXTEND OFF
FILE_NAME_CONVERT = ('C:\oracle19c\oradata\ORCL\pdbseed','C:\oracle19c\oradata\ORCL\bookstore_db');
--open this database;
ALTER PLUGGABLE DATABASE bookstore_db OPEN;

--CREATE BOOKSTORE_DB TABLESPACE bookstore_db_tablespace
--connect to bookstore_db session
ALTER SESSION SET CONTAINER = bookstore_db;
--delete if exists this tablespace;				                                                          ()	            - SYSTEM - READ WRITE
DROP TABLESPACE bookstore_db_tablespace INCLUDING CONTENTS AND DATAFILES;
--create tablespace
CREATE TABLESPACE bookstore_db_tablespace
DATAFILE 'C:\ORACLE19C\ORADATA\ORCL\BOOKSTORE_DB\bookstore_db_tablespace.dbf' 
SIZE 2G  
AUTOEXTEND ON NEXT 1G MAXSIZE 3G
ONLINE;

--CREATE BD_IN_OWNER USER
--delete if exists;
DROP USER db_in_owner CASCADE;
--create user;
CREATE USER db_in_owner IDENTIFIED BY db_in_owner_pass  
DEFAULT TABLESPACE bookstore_db_tablespace
QUOTA UNLIMITED ON bookstore_db_tablespace;
--grant the rights for this user;
GRANT CREATE SESSION TO db_in_owner;             -- Permite conectarea
GRANT CREATE TABLE TO db_in_owner;               -- Permite crearea de tabele
GRANT CREATE VIEW TO db_in_owner;                -- Permite crearea de view-uri
GRANT CREATE PROCEDURE TO db_in_owner;           -- Permite crearea de proceduri
GRANT CREATE SEQUENCE TO db_in_owner;            -- Permite crearea de secvente
GRANT CREATE TRIGGER TO db_in_owner;             -- Permite crearea de trigger-e
GRANT CREATE SYNONYM TO db_in_owner;             -- Permite crearea de sinonime
GRANT CREATE INDEXTYPE TO db_in_owner;           -- Permite crearea de indextypes
GRANT CREATE OPERATOR TO db_in_owner;            -- Permite crearea de operatori
GRANT CREATE MATERIALIZED VIEW TO db_in_owner;   -- Permite crearea de materialized views
GRANT CREATE TYPE TO db_in_owner;                -- Permite crearea de tipuri
-- grant to user the right to administrate his objects
GRANT ALTER ANY PROCEDURE TO db_in_owner;        -- Permite modificarea procedurilor proprii
GRANT DROP ANY TABLE TO db_in_owner;             -- Permite stergerea tabelelor proprii
-- unlock the account if it is blocked
ALTER USER db_in_owner ACCOUNT UNLOCK;

--CREATE BD_OWNER USER
--delete if exists;
DROP USER db_owner CASCADE;
--create user;
CREATE USER db_owner IDENTIFIED BY db_owner_pass  
DEFAULT TABLESPACE bookstore_db_tablespace
QUOTA UNLIMITED ON bookstore_db_tablespace;
--grant the rights for this user;
GRANT CREATE SESSION TO db_owner;             -- Permite conectarea
GRANT CREATE TABLE TO db_owner;               -- Permite crearea de tabele
GRANT CREATE VIEW TO db_owner;                -- Permite crearea de view-uri
GRANT CREATE PROCEDURE TO db_owner;           -- Permite crearea de proceduri
GRANT CREATE SEQUENCE TO db_owner;            -- Permite crearea de secvente
GRANT CREATE TRIGGER TO db_owner;             -- Permite crearea de trigger-e
GRANT CREATE SYNONYM TO db_owner;             -- Permite crearea de sinonime
GRANT CREATE INDEXTYPE TO db_owner;           -- Permite crearea de indextypes
GRANT CREATE OPERATOR TO db_owner;            -- Permite crearea de operatori
GRANT CREATE MATERIALIZED VIEW TO db_owner;   -- Permite crearea de materialized views
GRANT CREATE TYPE TO db_owner;                -- Permite crearea de tipuri
-- grant to user the right to administrate his objects
GRANT ALTER ANY PROCEDURE TO db_owner;        -- Permite modificarea procedurilor proprii
GRANT DROP ANY TABLE TO db_owner;             -- Permite stergerea tabelelor proprii
-- unlock the account if it is blocked
ALTER USER db_owner ACCOUNT UNLOCK;

--CREATE BD_OUT_OWNER USER
--delete if exists;
DROP USER db_out_owner CASCADE;
--create user;
CREATE USER db_out_owner IDENTIFIED BY db_out_owner_pass  
DEFAULT TABLESPACE bookstore_db_tablespace
QUOTA UNLIMITED ON bookstore_db_tablespace;
--grant the rights for this user;
GRANT CREATE SESSION TO db_out_owner;             -- Permite conectarea
GRANT CREATE TABLE TO db_out_owner;               -- Permite crearea de tabele
GRANT CREATE VIEW TO db_out_owner;                -- Permite crearea de view-uri
GRANT CREATE PROCEDURE TO db_out_owner;           -- Permite crearea de proceduri
GRANT CREATE SEQUENCE TO db_out_owner;            -- Permite crearea de secvente
GRANT CREATE TRIGGER TO db_out_owner;             -- Permite crearea de trigger-e
GRANT CREATE SYNONYM TO db_out_owner;             -- Permite crearea de sinonime
GRANT CREATE INDEXTYPE TO db_out_owner;           -- Permite crearea de indextypes
GRANT CREATE OPERATOR TO db_out_owner;            -- Permite crearea de operatori
GRANT CREATE MATERIALIZED VIEW TO db_out_owner;   -- Permite crearea de materialized views
GRANT CREATE TYPE TO db_out_owner;                -- Permite crearea de tipuri
-- grant to user the right to administrate his objects
GRANT ALTER ANY PROCEDURE TO db_out_owner;        -- Permite modificarea procedurilor proprii
GRANT DROP ANY TABLE TO db_out_owner;             -- Permite stergerea tabelelor proprii
-- unlock the account if it is blocked
ALTER USER db_out_owner ACCOUNT UNLOCK;

--CREATE BOOKSTORE_DW DATABASE
--change session to CDB$ROOT;
ALTER SESSION SET CONTAINER = CDB$ROOT;
--delete if exists this database;
ALTER PLUGGABLE DATABASE bookstore_dw CLOSE IMMEDIATE;
DROP PLUGGABLE DATABASE bookstore_dw INCLUDING DATAFILES;
--create database
CREATE PLUGGABLE DATABASE bookstore_dw
ADMIN USER bookstore_dw_owner IDENTIFIED BY bookstore_dw_owner_pass
DEFAULT TABLESPACE bookstore_tablespace
DATAFILE 'C:\oracle19c\oradata\ORCL\bookstore_dw' SIZE 4G AUTOEXTEND OFF
FILE_NAME_CONVERT = ('C:\oracle19c\oradata\ORCL\pdbseed','C:\oracle19c\oradata\ORCL\bookstore_dw');
--open this database;
ALTER PLUGGABLE DATABASE bookstore_dw OPEN;

--CREATE BOOKSTORE_DW TABLESPACE bookstore_dw_tablespace
--connect to bookstore_dw session
ALTER SESSION SET CONTAINER = bookstore_dw;
--delete if exists this tablespace;				                                                          ()	            - SYSTEM - READ WRITE
DROP TABLESPACE bookstore_dw_tablespace INCLUDING CONTENTS AND DATAFILES;
--create tablespace
CREATE TABLESPACE bookstore_dw_tablespace
DATAFILE 'C:\ORACLE19C\ORADATA\ORCL\BOOKSTORE_DW\bookstore_dw_tablespace.dbf' 
SIZE 3G  
AUTOEXTEND ON NEXT 1G MAXSIZE 4G
ONLINE;

--CREATE BW_IN_OWNER USER
--delete if exists;
DROP USER dw_in_owner CASCADE;
--create user;
CREATE USER dw_in_owner IDENTIFIED BY dw_in_owner_pass  
DEFAULT TABLESPACE bookstore_dw_tablespace
QUOTA UNLIMITED ON bookstore_dw_tablespace;
--grant the rights for this user;
GRANT CREATE SESSION TO dw_in_owner;             -- Permite conectarea
GRANT CREATE TABLE TO dw_in_owner;               -- Permite crearea de tabele
GRANT CREATE VIEW TO dw_in_owner;                -- Permite crearea de view-uri
GRANT CREATE PROCEDURE TO dw_in_owner;           -- Permite crearea de proceduri
GRANT CREATE SEQUENCE TO dw_in_owner;            -- Permite crearea de secvente
GRANT CREATE TRIGGER TO dw_in_owner;             -- Permite crearea de trigger-e
GRANT CREATE SYNONYM TO dw_in_owner;             -- Permite crearea de sinonime
GRANT CREATE INDEXTYPE TO dw_in_owner;           -- Permite crearea de indextypes
GRANT CREATE OPERATOR TO dw_in_owner;            -- Permite crearea de operatori
GRANT CREATE MATERIALIZED VIEW TO dw_in_owner;   -- Permite crearea de materialized views
GRANT CREATE TYPE TO dw_in_owner;                -- Permite crearea de tipuri
-- grant to user the right to administrate his objects;
GRANT ALTER ANY PROCEDURE TO dw_in_owner;        -- Permite modificarea procedurilor proprii
GRANT DROP ANY TABLE TO dw_in_owner;             -- Permite stergerea tabelelor proprii
-- unlock the account if it is blocked;
ALTER USER dw_in_owner ACCOUNT UNLOCK;


--CREATE DW_OWNER USER
--delete if exists;
DROP USER dw_owner CASCADE;
--create user;
CREATE USER dw_owner IDENTIFIED BY dw_owner_pass  
DEFAULT TABLESPACE bookstore_dw_tablespace
QUOTA UNLIMITED ON bookstore_dw_tablespace;
--grant the rights for this user;
GRANT CREATE SESSION TO dw_owner;             -- Permite conectarea
GRANT CREATE TABLE TO dw_owner;               -- Permite crearea de tabele
GRANT CREATE VIEW TO dw_owner;                -- Permite crearea de view-uri
GRANT CREATE PROCEDURE TO dw_owner;           -- Permite crearea de proceduri
GRANT CREATE SEQUENCE TO dw_owner;            -- Permite crearea de secvente
GRANT CREATE TRIGGER TO dw_owner;             -- Permite crearea de trigger-e
GRANT CREATE SYNONYM TO dw_owner;             -- Permite crearea de sinonime
GRANT CREATE INDEXTYPE TO dw_owner;           -- Permite crearea de indextypes
GRANT CREATE OPERATOR TO dw_owner;            -- Permite crearea de operatori
GRANT CREATE MATERIALIZED VIEW TO dw_owner;   -- Permite crearea de materialized views
GRANT CREATE TYPE TO dw_owner;                -- Permite crearea de tipuri
-- grant to user the right to administrate his objects;
GRANT ALTER ANY PROCEDURE TO dw_owner;        -- Permite modificarea procedurilor proprii
GRANT DROP ANY TABLE TO dw_owner;             -- Permite stergerea tabelelor proprii
-- unlock the account if it is blocked;
ALTER USER dw_owner ACCOUNT UNLOCK;

--CREATE DW_OUT_OWNER USER
--delete if exists;
DROP USER dw_out_owner CASCADE;
--create user;
CREATE USER dw_out_owner IDENTIFIED BY dw_out_owner_pass  
DEFAULT TABLESPACE bookstore_dw_tablespace
QUOTA UNLIMITED ON bookstore_dw_tablespace;
--grant the rights for this user;
GRANT CREATE SESSION TO dw_out_owner;             -- Permite conectarea
GRANT CREATE TABLE TO dw_out_owner;               -- Permite crearea de tabele
GRANT CREATE VIEW TO dw_out_owner;                -- Permite crearea de view-uri
GRANT CREATE PROCEDURE TO dw_out_owner;           -- Permite crearea de proceduri
GRANT CREATE SEQUENCE TO dw_out_owner;            -- Permite crearea de secvente
GRANT CREATE TRIGGER TO dw_out_owner;             -- Permite crearea de trigger-e
GRANT CREATE SYNONYM TO dw_out_owner;             -- Permite crearea de sinonime
GRANT CREATE INDEXTYPE TO dw_out_owner;           -- Permite crearea de indextypes
GRANT CREATE OPERATOR TO dw_out_owner;            -- Permite crearea de operatori
GRANT CREATE MATERIALIZED VIEW TO dw_out_owner;   -- Permite crearea de materialized views
GRANT CREATE TYPE TO dw_out_owner;                -- Permite crearea de tipuri
-- grant to user the right to administrate his objects;
GRANT ALTER ANY PROCEDURE TO dw_out_owner;        -- Permite modificarea procedurilor proprii
GRANT DROP ANY TABLE TO dw_out_owner;             -- Permite stergerea tabelelor proprii
-- unlock the account if it is blocked;
ALTER USER dw_out_owner ACCOUNT UNLOCK;

--CREATE EXPOSURE_DB DATABASE
--change session to CDB$ROOT;
ALTER SESSION SET CONTAINER = CDB$ROOT;
--delete if exists this database;
ALTER PLUGGABLE DATABASE exposure_db CLOSE IMMEDIATE;
DROP PLUGGABLE DATABASE exposure_db INCLUDING DATAFILES;
--create database
CREATE PLUGGABLE DATABASE exposure_db
ADMIN USER exposure_db_owner IDENTIFIED BY exposure_db_owner_pass
DEFAULT TABLESPACE bookstore_tablespace
DATAFILE 'C:\oracle19c\oradata\ORCL\exposure_db' SIZE 1G AUTOEXTEND OFF
FILE_NAME_CONVERT = ('C:\oracle19c\oradata\ORCL\pdbseed','C:\oracle19c\oradata\ORCL\exposure_db');
--open this database;
ALTER PLUGGABLE DATABASE exposure_db OPEN;

--CREATE EXPOSURE_DB TABLESPACE exposure_db_tablespace
--connect to bookstore_dw session
ALTER SESSION SET CONTAINER = exposure_db;
--delete if exists this tablespace;				                                                          ()	            - SYSTEM - READ WRITE
DROP TABLESPACE exposure_db_tablespace INCLUDING CONTENTS AND DATAFILES;
--create tablespace
CREATE TABLESPACE exposure_db_tablespace
DATAFILE 'C:\ORACLE19C\ORADATA\ORCL\EXPOSURE_DB\exposure_db_tablespace.dbf' 
SIZE 500M  
AUTOEXTEND ON NEXT 500M MAXSIZE 1G
ONLINE;

--CREATE EXPOSURE_OWNER USER
--delete if exists;
DROP USER exposure_owner CASCADE;
--create user;
CREATE USER exposure_owner IDENTIFIED BY exposure_owner_pass  
DEFAULT TABLESPACE exposure_db_tablespace
QUOTA UNLIMITED ON exposure_db_tablespace;
--grant the rights for this user;
GRANT CREATE SESSION TO exposure_owner;             -- Permite conectarea
GRANT CREATE TABLE TO exposure_owner;               -- Permite crearea de tabele
GRANT CREATE VIEW TO exposure_owner;                -- Permite crearea de view-uri
GRANT CREATE PROCEDURE TO exposure_owner;           -- Permite crearea de proceduri
GRANT CREATE SEQUENCE TO exposure_owner;            -- Permite crearea de secvente
GRANT CREATE TRIGGER TO exposure_owner;             -- Permite crearea de trigger-e
GRANT CREATE SYNONYM TO exposure_owner;             -- Permite crearea de sinonime
GRANT CREATE INDEXTYPE TO exposure_owner;           -- Permite crearea de indextypes
GRANT CREATE OPERATOR TO exposure_owner;            -- Permite crearea de operatori
GRANT CREATE MATERIALIZED VIEW TO exposure_owner;   -- Permite crearea de materialized views
GRANT CREATE TYPE TO exposure_owner;                -- Permite crearea de tipuri
-- grant to user the right to administrate his objects;
GRANT ALTER ANY PROCEDURE TO exposure_owner;        -- Permite modificarea procedurilor proprii
GRANT DROP ANY TABLE TO exposure_owner;             -- Permite stergerea tabelelor proprii
-- unlock the account if it is blocked;
ALTER USER exposure_owner ACCOUNT UNLOCK;
COMMIT;

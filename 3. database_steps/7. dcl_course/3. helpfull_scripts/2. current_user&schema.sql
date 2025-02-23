ALTER SESSION SET CONTAINER = CDB$ROOT;
ALTER SESSION SET CONTAINER = bookstore_db;
SELECT sys_context('USERENV', 'SESSION_USER') AS current_user,
       name AS database_name,
       sys_context('USERENV', 'CON_NAME') AS current_container,
       CASE 
           WHEN cdb = 'YES' AND sys_context('USERENV', 'CON_NAME') = 'CDB$ROOT' 
           THEN 'Container Database (CDB)' 
           ELSE 'Pluggable Database (PDB)' 
       END AS database_type
FROM v$database;
ALTER SESSION SET CONTAINER = CDB$ROOT;
SELECT name db_name,
             open_mode state,
             status db_status,
             cdb final_status 
FROM v$database,v$instance;
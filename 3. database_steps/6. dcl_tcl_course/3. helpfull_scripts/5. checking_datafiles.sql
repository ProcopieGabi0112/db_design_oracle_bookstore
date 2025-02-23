--setare conexiune;
ALTER SESSION SET CONTAINER = CDB$ROOT;
ALTER SESSION SET CONTAINER = bookstore_db;
--vizualizare fisiere in functie de conexiune;
SELECT 
       f.con_id||'/'||f.file_id||'/'||v.file# con_file_id,
       f.tablespace_name,
       f.file_name,
       ROUND(f.bytes / 1024 / 1024, 2) AS size_mb,
       ROUND(f.bytes / 1024 / 1024 / 1024, 2) AS size_gb,
       p.pdb_name||'('||p.status||')',
       f.status ||' - '|| v.status ||' - '||v.enabled as status
FROM   cdb_data_files f
FULL JOIN   cdb_pdbs p ON f.con_id = p.con_id
FULL JOIN   v$datafile v ON f.file_id = v.file#
ORDER BY f.con_id;

--nu sterge fisiere direct din folder'
--se poate cu comanda asta;
ALTER DATABASE DATAFILE 'C:\oracle19c\oradata\ORCL\BOOKSTORE_TABLESPACE.DBF' OFFLINE DROP;
--cu comanda asta stergi tablespace-uri;
DROP TABLESPACE bookstore_tablespace INCLUDING CONTENTS AND DATAFILES;
-- si cu asta stergi baze;
ALTER PLUGGABLE DATABASE bookstore_db CLOSE;
DROP PLUGGABLE DATABASE bookstore_db INCLUDING DATAFILES;

ALTER SESSION SET CONTAINER = CDB$ROOT;
SELECT c.pdb_id no,
             c.pdb_name pluggable_db_name,
             c.status status,
             v.open_mode open_mode
FROM v$pdbs v 
INNER JOIN cdb_pdbs c 
ON v.name = c.pdb_name;
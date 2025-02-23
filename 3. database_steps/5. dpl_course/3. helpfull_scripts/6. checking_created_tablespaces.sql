--setare conexiune;
ALTER SESSION SET CONTAINER = CDB$ROOT;
ALTER SESSION SET CONTAINER = bookstore_db;

SELECT ts.tablespace_name, df.file_name,bytes/1000000000.0 AS gb_memory
FROM dba_tablespaces ts
JOIN dba_data_files df
  ON ts.tablespace_name = df.tablespace_name;
--WHERE ts.tablespace_name LIKE 'BOOKSTORE_TABLESPACE';

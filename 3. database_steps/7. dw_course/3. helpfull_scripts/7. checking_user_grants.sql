--alege baza pe care vrei sa verifici
ALTER SESSION SET CONTAINER = bookstore_db;
--vizualizeaza toate informatiile despre useri;
SELECT
    u.user_id,                          -- User id-ul utilizatorului
    u.username,                         -- Numele utilizatorului
    u.account_status,                   -- Statusul contului
    u.created,                          -- Data creării
    u.lock_date,
    u.expiry_date,
    u.default_tablespace,
    u.last_login,
    NVL(LISTAGG(DISTINCT r.granted_role, ', ') WITHIN GROUP (ORDER BY r.granted_role), 'NO ROLE') AS roles,          -- Rolurile concatenate
    NVL(LISTAGG(DISTINCT t.table_name, ', ') WITHIN GROUP (ORDER BY t.table_name), 'NO OBJECT') AS objects,          -- Obiectele asupra cărora are privilegii
    NVL(LISTAGG(DISTINCT tp.privilege, ', ') WITHIN GROUP (ORDER BY tp.privilege), 'NO OBJECT PRIV') AS object_privileges, -- Privilegii la nivel de obiect
    NVL(LISTAGG(DISTINCT sp.privilege, ', ') WITHIN GROUP (ORDER BY sp.privilege), 'NO SYS PRIV') AS system_privileges -- Privilegii sistemice
FROM 
    dba_users u
LEFT JOIN 
    dba_role_privs r ON u.username = r.grantee
LEFT JOIN 
    dba_tab_privs tp ON u.username = tp.grantee
LEFT JOIN 
    dba_sys_privs sp ON u.username = sp.grantee
LEFT JOIN 
    dba_tables t ON tp.owner = t.owner AND tp.table_name = t.table_name
WHERE 
    UPPER(u.username) LIKE '%OWNER%'
GROUP BY 
    u.user_id, u.username, u.account_status, u.created, u.lock_date, u.expiry_date, u.default_tablespace, u.last_login
ORDER BY 
    u.username;
--daca ai un anumit user il poti cauta si asa;
--vizualizeaza toate informatiile de care ai nevoie cu privire la un user.
SELECT
    u.user_id,                          -- User id-ul utilizatorului
    u.username,                         -- Numele utilizatorului
    u.account_status,                   -- Statusul contului
    u.created,                           -- Data creării
    u.lock_date,
    u.expiry_date,
    u.default_tablespace,
    u.last_login,
    r.granted_role AS role,             -- Rolul (dacă este acordat vreun rol)
    t.table_name AS object,             -- Obiectele asupra cărora utilizatorul are privilegii
    tp.privilege AS object_privilege,   -- Tipul de privilegiu asupra obiectului
    sp.privilege AS system_privilege    -- Privilegii sistemice (ex. CREATE SESSION)
FROM 
    dba_users u
LEFT JOIN 
    dba_role_privs r ON u.username = r.grantee -- Alătură rolurile acordate utilizatorului
LEFT JOIN 
    dba_tab_privs tp ON u.username = tp.grantee  -- Alătură privilegii pe tabele
LEFT JOIN 
    dba_sys_privs sp ON u.username = sp.grantee  -- Alătură privilegii sistemice
LEFT JOIN 
    dba_tables t ON tp.owner = t.owner AND tp.table_name = t.table_name  -- Obiectele de tip tabel
WHERE UPPER(u.username) LIKE '%OWNER%' 
ORDER BY 
    u.username, 
    r.granted_role, 
    t.table_name, 
    tp.privilege;

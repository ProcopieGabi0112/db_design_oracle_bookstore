--Transaction Control Language(TCL)

--comenzii principale;
COMMIT; -- salveaza definitiv modificãrile efectuate în tranzac?ia curentã;
ROLLBACK; -- anuleazã toate modificãrile din tranzac?ia curentã.
SAVEPOINT savepoint_name; -- creeazã un punct de salvare în cadrul unei tranzac?ii, permi?ând revenirea la acel punct fãrã a anula întreaga tranzac?ie.
ROLLBACK TO SAVEPOINT savepoint_name; -- revine la un punct de salvare anterior, fãrã a afecta modificãrile anterioare acestuia
SET TRANSACTION READ ONLY / SET TRANSACTION READ WRITE; --specifica proprietati ale tranzactiei, cum ar fi izolarea si nivelul de acces.

-- TUTORIAL (ChatGBT  followed by Procopie Gabi)
--Vom prezenta acest tutorial ca si o saptamana de lucru 
--in cadrul unei baze de date obisnuite.
--P.S. (aceste exemple pot fi rulate pe orice schema)

--Ziua 1.
-- Primim cerinta sa cream o tabela employees cu un id, un nume pentru angajat si un salariu. Dupa trebuie sa introducem datele despre angajatii nostri in tabela.
-- pornim sql developer-ul si ne conectam pe user-ul db_owner.
--INCEPE TRANZACTIA;

--verificam daca exista tabela;
DROP TABLE employees;
--cream tabela employees;
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    salary NUMBER
);

--dupa ce am creat tabela introducem datele despre angajati nostri.
INSERT INTO employees VALUES (1, 'Te Grecu', 4000);
INSERT INTO employees VALUES (2, 'Gabi Procpie', 4500);
INSERT INTO employees VALUES (3, 'Adia Ioani', 4000);
INSERT INTO employees VALUES (4, 'Violta Procpie', 4000);
INSERT INTO employees VALUES (5, 'Marus Ioni', 4500);

--am terminat ce am avut de lucru pe azi.
--pentru a salva ce am lucrat azi trebuie sa dam comanda urmatoare.
COMMIT;

--Ziua 2.
-- Primim cerinta sa verificam datele pe care le-am introdus in tabela employees sunt corecte si sa facem o lista cu valorile care nu ni se par in regula.
-- Nu primim cerinta de a modifica nimic azi. Doar vrem sa verificam vizual tabelul fara sa facem vreun insert sau update.
-- pornim sql developer-ul si ne conectam pe user-ul db_owner.
--INCEPE TRANZACTIA;

--vrem sa facem in tranzactia aceasta doar select.
SET TRANSACTION READ ONLY; 

SELECT *
FROM employees;  
-- EMP_ID     NAME               SALARY
------------------------------------
-- 1	            Te Grecu    	    4000
-- 2	            Gabi Procpie	    4500
-- 3	            Adia Ioani	        4000
-- 4	            Violta Procpie	4000
-- 5	            Marus Ioni     	4500

--verificam ce anume avem de verificat in tabela employees;
-- 1. emp_id = 1 "Teo Grecu" - lipseste "o" din "Teo"
-- 2. emp_id = 2 "Gabi Procopie" - lipseste "o" din "Procopie"
-- 3. emp_id = 3 "Adina Ioani" - lipseste "n" din "Adina"
-- 4. emp_id = 4 "Violeta Procopie" - lipseste "e" din "Violeta" si "o" din "Procopie"
-- 5. emp_id = 5 ""Marius Ioani" - lipseste "i" din "Marius" si "a" din "Ioani."

--incerci in ziua respectiva chiar daca ai terminat ce aveai planificat sa modifici 
--fara sa vrei inregistrarile din tabele ca sa arate cum trebuie
UPDATE employees SET name = 'Teo Grecu' WHERE emp_id = 1;
UPDATE employees SET name = 'Gabi Procopie' WHERE emp_id = 2;
UPDATE employees SET name = 'Adina Ioani' WHERE emp_id = 3;
UPDATE employees SET name = 'Violeta Procopie' WHERE emp_id = 4;
UPDATE employees SET name = 'Marius Ioani' WHERE emp_id = 5;
--daca incerci sa rulezi chestiile astea prin care modifici valorile gresite o sa primesti 
--eroare pentru ca pentru la inceputul zilei ti-ai stabilit doar sa faci select-uri fara nicio modificare.

--ca sa iesi din asta dai commit ca sa inchei tranzactia;
COMMIT;

--Ziua 3.
-- Primim cerinta sa mai adaugam niste date despre 30 de angajati care o sa vina in schimb de experienta la firma noastra.
-- pornim sql developer-ul si ne conectam pe user-ul db_owner.
--INCEPE TRANZACTIA;

--inseram user 1.....
INSERT INTO employees VALUES (6, 'Maria Vasilescu', 5000);
--inseram user 2.....
INSERT INTO employees VALUES (7, 'Donald Trump', 3000);
--inseram user 3.....
INSERT INTO employees VALUES (8, 'Michael Jackson', 7000);
--inseram user 4.....
INSERT INTO employees VALUES (9, 'Barrack Obama', 8000);
--inseram user 5.....
INSERT INTO employees VALUES (10, 'Andi Moisescu', 5500);
--inseram user 6.....
--mesaj primit: "Nu mai trebuie sa ii introduci pe cei 30 de anagajati. Nu ii mai primim prin firma noatra. O sa facem o smecherie si ii bagam 
--                      ca angajati externi la firma matusii Tamara. Nu ii mai baga in tabela. Daca ai apucat sa ii bagi apuca-te sa ii stergi."

-- Am inserat 5 angajati noi azi. Trebui sa ii stergem pe astia de azi.
-- Rulam comanda aceasta care va sterge tot ce a fost facut in cadrul zilei / tranzactiei de azi.
ROLLBACK;

-- Verificam daca au mai fost adusi alti angajati la finalul zilei.
SELECT * FROM employees;  
-- EMP_ID     NAME               SALARY
------------------------------------
-- 1	            Te Grecu    	    4000
-- 2	            Gabi Procpie	    4500
-- 3	            Adia Ioani	        4000
-- 4	            Violta Procpie	4000
-- 5	            Marus Ioni     	4500

--salvam ceea ce am facut azi
COMMIT;

--Ziua 4.
-- Primim cerinta sa modificam tabela in felul urmator. Aplica modificarile realizate in ziua 2. Desparte coloanele de nume in coloana "Nume" si "Prenume".
-- Mai adauga o coloana numita data_angajare.
-- pornim sql developer-ul si ne conectam pe user-ul db_owner.
--INCEPE TRANZACTIA;

SAVEPOINT ziua4;
-- task 1. aplicam modificarile din ziua 2
UPDATE employees SET name = 'Teo Grecu' WHERE emp_id = 1;
UPDATE employees SET name = 'Gabi Procopie' WHERE emp_id = 2;
UPDATE employees SET name = 'Adina Ioani' WHERE emp_id = 3;
UPDATE employees SET name = 'Violeta Procopie' WHERE emp_id = 4;
UPDATE employees SET name = 'Marius Ioani' WHERE emp_id = 5;
--verificam daca modificarile au fost aplicate.
select * from employees;
-- EMP_ID     NAME                  SALARY
-------------------------------------------
-- 1	            Teo Grecu    	       4000
-- 2	            Gabi Procopie	   4500
-- 3	            Adina Ioani	       4000
-- 4	            Violeta Procopie	   4000
-- 5	            Marius Ioani     	   4500

SAVEPOINT task_2_numeprenume;

--adaugam inca doua coloane numite prenume  si nume 
ALTER TABLE employees ADD (prenume VARCHAR2(50), nume VARCHAR2(50));

--modificam valoarea celor doua coloane pe baza coloanei name deja existente in tabele
UPDATE employees
SET prenume = SUBSTR(name, 1, INSTR(name, ' ') - 1),
   nume = SUBSTR(name, INSTR(name, ' ') + 1);

--stergem coloana veche numita name;    
ALTER TABLE employees DROP COLUMN name;

--vizualizam ceea ce am obtinut;
SELECT * FROM employees; 
-- EMP_ID    SALARY     PRENUME     NUME
------------------------------------------------
-- 1	           4000         Teo             Grecu 
-- 2	           4500         Gabi            Procopie
-- 3	           4000         Adina           Ioani
-- 4	           4000         Violeta         Procopie	
-- 5	           4500         Marius         Ioani

SAVEPOINT data_angajare;

--adaugam coloana data_angajare;
ALTER TABLE employees ADD data_angajare DATE;

--facem ca coloana data_angajare sa fie default data curenta introducerii in sistem.
UPDATE employees
SET data_angajare = SYSDATE;
ALTER TABLE employees MODIFY data_angajare DEFAULT SYSDATE;

--verificam daca apare coloana data_angajare in formatul cerut de noi
select * from employees;

SAVEPOINT final_de_zi;

--daca vrei sa te intorci la un anumit pas poti sa dai comanda
ROLLBACK TO SAVEPOINT ziua4;  -- Ne intoarcem cu ce aveam la inceputul zilei. (tabela cu 3 coloane: id,nume si salary)
--verificam daca asa este
select  * from employees;

ROLLBACK TO SAVEPOINT task_2_nume_prenume;  -- Ne intoarcem la momentul in care avem randurile corectate cu datele din ziua 2
--verificam daca asa este
select  * from employees;

ROLLBACK TO SAVEPOINT data_angajare;  -- Suntem in punctul in care avem coloana name sparta in doua
--verificam daca asa este
select  * from employees;

ROLLBACK TO SAVEPOINT final_de_zi;  -- In punctul asta sunt la finalul zilei 4 cu tot ceea ce am lucrat la zi
--verificam daca asa este
select  * from employees;

--La toate rollback-urile de mai sus ai primit eroare?
--Este bine atunci.

--Toate comenziile ALTER TABLE, CREATE, DROP realizeaza un commit implicit automat dupa ce rulezi o comanda de acest fel.
--Acest commit implicit este ca si cand ai da o comanda COMMIT imediat dupa ce ai rulat comanda. Sunt doar 3 comenzi dupa care trebuie neaparat sa dai commit
--si anume INSERT, UPDATE si DELETE (DML)

SAVEPOINT tabel_final;

--O stergem pe Teo din tabel
DELETE employees WHERE emp_id = 1;
--verificam daca Teo a fost stearsa din tabel
select  * from employees;

SAVEPOINT fara_teo;

DELETE employees
WHERE emp_id = 4; 

SAVEPOINT fara_mama_lui_gabi;

DELETE employees
WHERE emp_id = 3 or emp_id = 5;

SAVEPOINT doar_cu_gabi_in_tabel;
-----------------------------------------------------
--In momentul acesta poti da un singur ROLLBACK TO SAVEPOINT;
--Comanda asta este similara cu commit;
--Adica in momentul in care dai rollback se considera commit-ul si dupa toate savepoint-urile sunt sterse.
--Daca vreti sa incercati cu alte savepoint-uri atunci rulati din nou tot scriptul pana la acest punct *.

ROLLBACK TO SAVEPOINT tabel_final;  -- In punctul asta suntem la finalul tabelului facut in ziua 4
--verificam daca asa este
select  * from employees;

ROLLBACK TO SAVEPOINT fara_teo;  -- In punctul asta ar trebui sa avem 4 randuri fara Teo
--verificam daca asa este
select  * from employees;

ROLLBACK TO SAVEPOINT fara_mama_lui_gabi;  -- In punctul asta ar trebui sa avem 3 randuri fara teo si mama lui gabi
--verificam daca asa este
select  * from employees;

ROLLBACK TO SAVEPOINT doar_cu_gabi_in_tabel;  -- In punctul asta ar trebui sa fie doar gabi in tabel
--verificam daca asa este
select  * from employees;

--la final de zi, dam comanda
COMMIT;

--Cam acesta este tutorialul meu cu privire la Transaction Control Language(TCL). 
--Sper ca va placut...
--Inainte de a incheia aici povestea
DROP TABLE employees;
COMMIT;

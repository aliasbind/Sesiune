--nu sunt toti angajatii-lab 2- pr 20
--sunt doar 106, si nu 107 cum ar trebui
--de exemplu cele care nu se regasesc in departaments sau null
--join standard-natural
SELECT employee_id, last_name,employees.department_id,department_name
FROM employees,departments
WHERE employees.department_id=departments.department_id;

--conditia va deveni
SELECT employee_id, last_name,employees.department_id,department_name
FROM employees,departments
WHERE employees.department_id=departments.department_id(+);--LEFT JOIN, si angajatul care nu are departament

--vreau departamentele care nu au angajati
SELECT employee_id, last_name,employees.department_id,department_name
FROM employees,departments
WHERE employees.department_id(+)=departments.department_id;--RIGHT JOIN, si angajatul care nu are departament

--daca le vreu pe amandoua folosesc si full join
--sau
SELECT employee_id, last_name,employees.department_id,department_name
FROM employees,departments
WHERE employees.department_id(+)=departments.department_id
UNION--pentru a uni cele 2 tabele fara duplicate
SELECT employee_id, last_name,employees.department_id,department_name
FROM employees,departments
WHERE employees.department_id=departments.department_id(+);

--pt fiecare angajat se cere codul, numelelast, codul sefului sau si numele acestuia
--se introduc aliasuri,aici a,b
SELECT a.employee_id "ID ANGAJAT", a.last_name"NUME ANGAJAT",a.manager_id "ID SEF", b.last_name"NUME SEF"
FROM employees a, employees b
WHERE a.manager_id=b.employee_id(+);

--sa se det codul si numele departamentelor in care nu lucreaza nici un angajat
--e.department_id-daca lucreaza cineva in acel departament(daca acel departament se regaseste in tabelul angajati)
--distinct scapa de dubluri
SELECT distinct d.department_id,e.department_id,d.department_name
FROM departments d, employees e
WHERE d.department_id=e.department_id(+) AND e.department_id is NULL;

--pt fiecare angajat codul, numele, numele departamentului,numele jobului
SELECt employee_id,last_name,department_name,job_title
FROM employees e, departments d, jobs j
WHERE e.department_id=d.department_id(+) and e.job_id=j.job_id(+);

--numele prenumele, date angajarii pe toti angajarii care au data angajarii mai mare decat cea a lui GRANT
SELECT distinct a.last_name, a.first_name, a.hire_date
--,b.last_name,b.first_name,b.hire_date
FROM employees a, employees b
WHERE upper(b.last_name)='GRANT' and a.hire_date>b.hire_date
ORDER BY 1;

--fiecare angajat impreuna cu colegii lui
--pt fiecare angajat se cer codul, departamnet, impreuna cu codul tuturor colegilor de departament
SELECT a.first_name "ANGAJAT", a.employee_id, a.department_id, b.first_name "COLEG", b.employee_id, b.department_id
FROM employees a, employees b
WHERE a.department_id=b.department_id AND (a.first_name!=b.first_name OR a.last_name!=b.last_name) AND b.employee_id>a.employee_id --am eliminat si duplicatele gen e1,e2 si e2,e1
ORDER BY 1;

--care este cel mai mare salariu
SELECT max(salary))
from employees;

--ex 22 lab 2

SELECT a.first_name,b.department_name,b.location_id
FROM employees a, departments b
WHERE a.department_id=b.department_id(+) and a.commission_pct is not null;

--ex3 lab 3
SELECT e.last_name, e.salary, j.job_title,l.city, l.state_province
FROM employees e, departments d, locations l, jobs j, employees k
WHERE e.job_id=j.job_id and e.department_id=d.department_id and d.location_id=l.location_id and e.manager_id=k.employee_id and lower(k.last_name)='king';
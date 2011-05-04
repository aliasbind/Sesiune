--lab 5 ex 1
select department_name, job_title, avg(salary), GROUPING (department_id), GROUPING (job_id)
FROM employees join departments using (department_id) join jobs using (job_id)
group by ROLLUP( department_name, department_id, job_title, job_id);

--lab5 ex 3
SELECT department_name,job_title,employees.manager_id, max(salary),min(salary)
FROM employees join departments using (department_id) join jobs using (job_id)
GROUP BY GROUPING SETS ((department_name, department_id,job_title,job_id), (job_title,job_id,employees.manager_id),());

--lab5 ex 4

SELECT Max(salary)
FROM employees
HAVING max(salary)>15000;

--LAB 5 EX  5.
--a) S? se afi?eze informa?ii despre angaja?ii al c?ror salariu dep??e?te valoarea medie a salariilor colegilor s?i de departament.
--b) Analog cu cererea precedent?, afi?ându-se ?i numele departamentului ?i media salariilor acestuia ?i num?rul de angaja?i (2 solutii: subcerere necorelat? în clauza FROM, subcerere corelat? în clauza SELECT).
select employee_id,department_id,salary
from employees e
where salary >(SELECT avg(salary)
              FROM employees
              WHERE department_id=e.department_id);
              
--b)->in select
select (SELECT count(employee_id) FROM employees WHERE e.department_id=department_id) nr,
       employee_id,e.department_id,salary,
       (SELECT avg(salary) FROM employees WHERE e.department_id=department_id) medie,
       department_name
from employees e join departments d on (e.department_id=d.department_id);

--in from sau->sigur merge->pt angajti ->departamente
select employee_id,department_id,salary,department_name,carmen,lab223--nr de angajati
from employees e left join departments using (department_id) left join
(select department_id, avg(salary) carmen, count(employee_id) lab223 from employees group by department_id) using (department_id);

--de la departament adaugam angajat
select d.department_id,department_name,avg(e.salary),count(e.employee_id),t.employee_id,t.salary
from departments d left join employees e on (e.department_id=d.department_id) join 
      (select department_id,employee_id,salary from employees) t on (e.department_id=t.department_id)
group by d.department_id, department_name, t.employee_id, t.salary;

-- lab 5 ex 6
--S? se afi?eze numele ?i salariul angaja?ilor al c?ror salariu este mai mare decât salariile medii din toate departamentele. 
--Se cer 2 variante de rezolvare: cu operatorul ALL sau cu func?ia MAX.
--nu e bine??de ce ??
SELECT last_name,salary
FROM employees
WHERE salary>(SELECT avg(salary) from employees);

--cu all
SELECT last_name,salary
FROM employees
WHERE salary>all (SELECT avg(salary) from employees group by department_id);
--cu max
SELECT last_name,salary
FROM employees
WHERE salary>all (SELECT max(avg(salary)) from employees group by department_id);

--lab5 ex7
--Sa se afiseze numele si salariul celor mai prost platiti angajati din fiecare departament 
--(se cer 3 solutii: subcerere sincronizata, subcerere nesincronizata si subcerere în clauza FROM).
--1--corelata
SELECT last_name,salary,department_id
FROM employees e
WHERE salary = (SELECT min(salary) FROM employees WHERE department_id=e.department_id);

--2--in from
SELECT last_name,salary,e.department_id
FROM employees e join 
     (SELECT min(salary) salariu,department_id FROM employees GROUP BY department_id ) a
      on (e.department_id=a.department_id)
WHERE e.salary=a.salariu;

--3--nesincronizata
SELECT last_name,salary,department_id
FROM employees
WHERE (department_id,salary) IN (SELECT department_id,min(salary) FROM employees GROUP BY department_id);

--lab 5 ex 8--nu e facuta
--Pentru fiecare departament, s? se obtina numele salariatului avand cea mai mare vechime din departament. 
--S? se ordoneze rezultatul dup? numele departamentului.
SELECT last_name,department_id
FROM employees 
WHERE hire_date<=(SELECT min(;

--lab 5 ex 9
--Sa se obtina numele salariatilor care lucreaza intr-un departament in care exista cel putin un 
--angajat cu salariul egal cu salariul maxim din departamentul 30 (operatorul exists).
SELECT last_name,department_id
from employees a
where exists (select employee_id from employees b where a.department_id=b.department_id and b.salary= 
                            (select max(salary) from employees c where c.department_id=30));
                            
--sau
SELECT last_name,department_id,salary
from employees a
where exists (select 1 from employees b where a.department_id=b.department_id and b.salary= 
                            (select max(salary) from employees c where c.department_id=30));


--lab5 ex 8
--Pentru fiecare departament, s? se obtina numele salariatului avand cea mai mare vechime din departament. 
--S? se ordoneze rezultatul dup? numele departamentului.
select last_name, a.department_id, d.department_name
from employees a join departments d on (a.department_id=d.department_id)
where hire_date = (select min(hire_date) from employees b where a.department_id=b.department_id )
order by d.department_name;

--lab5 ex 11
--S? se afi?eze codul, numele ?i prenumele angaja?ilor care au cel pu?in doi subalterni.
select last_name,first_name,employee_id
from employees a
where 2<=(select count(manager_id) from employees b where a.employee_id=b.manager_id);

--lab 5 ex 10
--Sa se obtina numele primilor 3 angajati avand salariul maxim. Rezultatul se va afi?a în ordine cresc?toare a salariilor.
--2 feluri
--primii trei, cu sau fara duplicate
--primele trei linii dupa ce a fost ordonat
--sau primele trei salarii

select salary
from (select salary from employees order by salary desc)
where rownum<4;
--pt distincte
select salary
from (select distinct salary from employees order by salary desc)
where rownum<4;
--si numele
select last_name, salary
from employees
where salary in (select salary
from (select distinct salary from employees order by salary desc)
where rownum<6);

--se poate si fara rownum
select employee_id,salary
from employees e
where 2 >=(select count(distinct salary) from employees where salary>e.salary);

--lab 5 ex 12
--S? se determine loca?iile în care se afl? cel pu?in un departament.
select location_id
from locations e
where exists (select 1 from departments where location_id=e.location_id);

--lab5 ex 13
--S? se determine departamentele în care nu exist? nici un angajat 
--(operatorul exists; cererea a mai fost rezolvata si printr-o cerere necorelata).
select department_id
from departments d
where not exists (select 1 from employees where d.department_id=department_id);

--lab 5 ex 14
--S? se afi?eze codul, numele, data angaj?rii, salariul ?i managerul pentru:
--a)subalternii directi ai lui De Haan; 
--b) ierarhia arborescenta de sub De Haan.

--a)
select employee_id,last_name,hire_date,manager_id
from employees
where manager_id in (select employee_id from employees where lower(last_name)='de haan');

--b)
-- ->legatura employee_id=manager_id
--daca prioritar e employee_id (PRIOR employee_id=manager_id)--merge in jos
--altfel employee_id=PRIOR manager_id--merge in sus

--pentru cei fara de haan
select employee_id,last_name,hire_date,manager_id
from employees
start with manager_id in (select employee_id from employees where lower(last_name)='de haan')
   connect by PRIOR employee_id=manager_id;
   
--si pentru de haan
select employee_id,last_name,hire_date,manager_id
from employees
start with employee_id in (select employee_id from employees where lower(last_name)='de haan')
   connect by PRIOR employee_id=manager_id;
   
--pentru cei in sus
select employee_id,last_name,hire_date,manager_id
from employees
start with employee_id in (select employee_id from employees where lower(last_name)='de haan')
   connect by  employee_id= PRIOR manager_id;
 
--pentru nivele adaugam level  
select employee_id,last_name,hire_date,manager_id , LEVEL
from employees
start with employee_id in (select employee_id from employees where lower(last_name)='de haan')
   connect by PRIOR employee_id=manager_id;
   
--lab 5 ex 15
--S? se ob?in? ierarhia ?ef-subaltern, considerând ca r?d?cin? angajatul având codul 114.
select employee_id,last_name,hire_date,manager_id , LEVEL
from employees
start with employee_id =114
   connect by PRIOR employee_id=manager_id;
   
--lab 5 ex 16
--Scrieti o cerere ierarhica pentru a afisa codul salariatului, codul managerului si numele salariatului, 
--pentru angajatii care sunt cu 2 niveluri sub De Haan. Afisati, de asemenea, nivelul angajatului în ierarhie.
select employee_id,last_name,hire_date,manager_id , LEVEL
from employees
where level=3
start with employee_id in (select employee_id from employees where lower(last_name)='de haan')
     connect by PRIOR employee_id=manager_id;

--lab 5 ex 17
--Pentru fiecare linie din tabelul EMPLOYEES, se va afisa o structura arborescenta in care va ap?rea angajatul, managerul s?u, 
--managerul managerului etc. 
--Coloanele afi?ate vor fi: codul angajatului, codul managerului, nivelul în ierarhie (LEVEL) si numele angajatului.

select employee_id,last_name,manager_id,level
from employees
connect by employee_id=PRIOR manager_id
order by employee_id;

--lab 5 ex 18

select employee_id, manager_id, last_name, salary, level
from employees
where salary > 5000
 start with employee_id in (select employee_id from employees where salary=(select max(salary) from employees))
 connect by prior employee_id = manager_id;
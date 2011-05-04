-- Lab 6, 4. Pentru fiecare ?ar?, s? se afiseze num?rul de angaja?i din cadrul acesteia.

select count(employee_id), country_name
from employees join departments using (department_id)
               join locations using (location_id)
               full join countries using (country_id)
group by country_name
order by country_name;

-- Lab5, 21. S? se detemine primii 10 cei mai bine platiti angajati
select *
from (select employee_id, salary
      from employees
      order by salary desc)
where rownum < 11;

--Lab5, 22. S? se determine cele mai prost pl?tite 3 job-uri, 
-- din punct de vedere al mediei salariilor.
select job_id, medie
from (select job_id, avg(salary) medie
      from employees
      group by job_id
      order by 2)
where rownum < 4;

-- Lab5, 23. S? se afi?eze informa?ii despre departamente, în formatul urm?tor: „Departamentul
-- <department_name> este condus de {<manager_id> | nimeni} ?i {are num?rul de salaria?i
-- <n> | nu are salariati}“.
select 'Departamentul ' || department_name || ' este condus de ' ||
       nvl(to_char(manager_id), 'nimeni') || ' si ' ||
       decode(count(employee_id), 0, 'nu are salariati', 'are numarul de salariati ' || count(employee_id))
       "Informatii"
from employees right join departments using(department_id)
group by department_id, department_name, departments.manager_id;

-- 24. S? se afi?eze numele, prenumele angaja?ilor ?i lungimea numelui pentru înregistr?rile în care
-- aceasta este diferit? de lungimea prenumelui. (NULLIF)
select last_name, first_name,
nullif(length(last_name), length(first_name)) lungime
from employees;

-- 25. S? se afi?eze numele, data angaj?rii, salariul ?i o coloan? reprezentând salariul dup? ce se
-- aplic? o m?rire, astfel: pentru salaria?ii angaja?i în 1989 cre?terea este de 20%, pentru cei angaja?i
-- în 1990 cre?terea este de 15%, iar salariul celor angaja?i în anul 1991 cre?te cu 10%.
-- Pentru salaria?ii angaja?i în al?i ani valoarea nu se modific?.
select last_name, hire_date, salary,
salary * decode(to_char(hire_date, 'yyyy'), 1989, 1.2, 1990, 1.15, 1991, 1.1, 1) "Salariu Marit"
from employees;

-- 26. S? se afi?eze:
-- - suma salariilor, pentru job-urile care incep cu litera S;
-- - media generala a salariilor, pentru job-ul avand salariul maxim;
-- - salariul minim, pentru fiecare din celelalte job-uri.
-- Se poate folosi DECODE?
select job_id,
case
when substr(lower(job_id), 1, 1) = 's' then sum(salary)
when max(salary) = (select max(salary) from employees)
then avg(salary)
else min(salary) end "Mixt"
from employees
group by job_id;

-- Lab6 5. S? se listeze angajatii (codul si numele acestora) care au lucrat pe cel putin dou? 
-- proiecte nelivrate la termen.
select employee_id, last_name
from employees join works_on using(employee_id)
               join project using(project_id)
where deadline < delivery_date
group by employee_id, last_name
having count(project_id) > 1;

-- Lab6 6. S? se listeze codurile angajatilor si codurile proiectelor pe care au lucrat. Listarea va
-- cuprinde si angajatii care nu au lucrat pe nici un proiect.
select employee_id, project_id
from employees left join works_on using(employee_id);

-- Lab6 7. S? se afiseze angajatii care lucreaz? în acelasi departament cu cel putin un manager de proiect.
select employee_id
from employees
where department_id in
(select department_id
from project join employees on(employee_id = project_manager));

-- Lab6 8. S? se afiseze angajatii care nu lucreaz? în acelasi departament cu nici un manager de proiect.
select employee_id
from employees
where department_id not in
(select department_id
from project join employees on(employee_id = project_manager));

-- Lab6 9. S? se determine departamentele având media salariilor mai mare decît un num?r dat.
select department_id
from employees
group by department_id
having avg(salary) > &medie;

-- Lab6 10. Se cer informatii (nume, prenume, salariu, num?r proiecte) despre managerii 
-- de proiect care au condus 2 proiecte.
with manager as
(select project_manager, count(project_id) nr
 from project
 group by project_manager
 having count(project_id) = 2)
select last_name, first_name, salary, nr
from manager join employees on (employee_id = project_manager);

-- 11. S? se afiseze lista angajatilor care au lucrat numai pe proiecte conduse de 
-- managerul de proiect având codul 102.
select distinct employee_id
from works_on x
where not exists
(select project_id
 from works_on
 where employee_id = x.employee_id
  minus
select project_id
 from project
 where project_manager = 102);
 
-- 12. a) S? se obtin? numele angajatilor care au lucrat cel putin pe aceleasi proiecte ca si angajatul
-- având codul 200.
-- b) S? se obtin? numele angajatilor care au lucrat cel mult pe aceleasi proiecte ca si angajatul având
-- codul 200.

-- a)
select distinct employee_id
from works_on x
where not exists
(select project_id
 from works_on
 where employee_id = 200
  minus
select project_id
 from works_on
 where employee_id = x.employee_id);
 
-- b)
select distinct employee_id
from works_on x
where not exists
(
select project_id
 from works_on
 where employee_id = x.employee_id
 minus
select project_id
 from works_on
 where employee_id = 200
);

-- 13. S? se ob?in? angaja?ii care au lucrat pe aceleasi proiecte ca si angajatul având codul 200.

select distinct employee_id
from works_on x
where not exists
(
select project_id
 from works_on
 where employee_id = x.employee_id
 minus
select project_id
 from works_on
 where employee_id = 200
) and not exists
(
select project_id
 from works_on
 where employee_id = 200
 minus
select project_id
 from works_on
 where employee_id = x.employee_id
);

-- 14. Modelul HR con?ine un tabel numit JOB_GRADES, care con?ine grilele de salarizare ale companiei.
-- a) Afisa?i structura si con?inutul acestui tabel.
-- b) Pentru fiecare angajat, afisa?i numele, prenumele, salariul si grila de salarizare corespunz?toare.
-- Ce opera?ie are loc între tabelele din interogare?

-- b)
select last_name, first_name, salary, grade_level
from employees, job_grades
where salary between lowest_sal and highest_sal;

-- 89.38.230.59

-- 16. Sa se afiseze numele, codul departamentului si salariul anual pentru toti angajatii care 
-- au un anumit job.
define;
define job;
define job='IT_PROG';
select last_name, department_id, salary * 12
from employees
where job_id = '&job';
undefine job;
define job;

-- Cu accept:
accept job prompt "dati job-ul:";
select last_name, department_id, salary * 12
from employees
where job_id = '&job';
undefine job;

-- 17. Sa se afiseze numele, codul departamentului si salariul anual pentru toti angajatii care au fost
-- angajati dupa o anumita data calendaristica.
select last_name, department_id, salary * 12, hire_date
from employees
where hire_date > to_date('&data', 'dd-mm-yyyy');

-- 18. Sa se afiseze o coloana aleasa de utilizator, dintr-un tabel ales de utilizator, ordonand dupa aceeasi
-- coloana care se afiseaza. De asemenea, este obligatorie precizarea unei conditii WHERE.
select &&col
from &tab
where &cond
order by &col;

-- 19. S? se realizeze un script prin care s? se afiseze numele, job-ul si data angaj?rii salariatilor care
-- au început lucrul între 2 date calendaristice introduse de utilizator. S? se concateneze numele
-- si job-ul, separate prin spatiu si virgul?, si s? se eticheteze coloana "Angajati".
-- Se vor folosi comanda ACCEPT si formatul pentru data calendaristica MM/DD/YY.
accept data1 prompt "data1 = ";
accept data2 prompt "data2 = ";
select last_name, job_id, hire_date
from employees
where hire_date between to_date('&data1', 'dd-mm-yyyy') and 
                        to_date('&data2', 'dd-mm-yyyy');
                        
-- 20. Sa se realizeze un script pentru a afisa numele angajatului, codul job-ului, salariul si numele
-- departamentului pentru salariatii care lucreaza intr-o locatie data de utilizator. Va fi permisa cautarea
-- case-insensitive.
define loc=1400;
select last_name, job_id, salary, department_name
from employees join departments using(department_id)
where location_id = &loc;

-- 21. a)S? se citeasc? dou? date calendaristice de la tastatur? si s? se afiseze zilele dintre aceste dou? date.
-- b)Modificati cererea anterioar? astfel încât s? afiseze doar zilele lucr?toare dintre cele dou? date
-- calendaristice introduse.
accept data1 prompt "data1 = ";
accept data2 prompt "data2 = ";
select to_date('&data1', 'dd-mm-yyyy') + rownum-1
from dual
connect by rownum < to_date('&data2', 'dd-mm-yyyy') - to_date('&data1', 'dd-mm-yyyy');
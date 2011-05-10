describe employees;
select * from countries;

--6
desc employees;

--7. Sa se afiseze codul angajatului, numele, codul job-ului sau, data angajarii
select employee_id, last_name, job_id, hire_date
from employees;

--8. cu nume pt fiecare coloana
select employee_id cod , last_name nume, job_id "cod job" , hire_date "data angajarii" 
from employees;

--9. Listare cu si fara duplicate a codurilor joburilor din employees
select job_id from employees;  --cu duplicate
select distinct job_id from employees;  --fara duplicate

--10. Afisare nume concatenat cu job_id, separat prin virgula si spatiu ; eticheta coloana "angajat si titlu"
select last_name||', '||job_id "Angajat si titlu"
from employees;

--11. Creati o cerere prin care sa se afiseze toate datele din tabelul EMPLOYEES.
--Separa?i fiecare coloan? printr-o virgul?. Etichetati coloana ”Informatii complete”.
select employee_id||', '||first_name||', '||last_name||', '||email||', '||phone_number||', '||hire_date||', '||
job_id||', '||salary||', '||nvl(commission_pct,0)||', '||nvl(manager_id,-1)||', '||department_id "Informatii complete"
from employees;

--12. Listare nume si salariu angajati care castiga mai mult de 2850$
select last_name, salary
from employees
where salary>2850;

--13. Listare nume angajat si nr departament pt angajatul nr 104
select last_name, department_id
from employees
where employee_id=104;

--14. Listare numele si salariul pt toti angajatii al caror salariu nu se afla in domeniul 1500-2850
select last_name, salary
from employees
where salary not between 1500 and 2850;

select last_name, salary
from employees
where salary<=1500 or salary>=2850;

--15. Listarenumele,job-ul si data la care au inceput lucrul salariatii angajati intre 20 febr 1987 si 1 mai 1989; 
--rez ord cresc dupa data de inceput
select last_name,job_id,hire_date
from employees
where hire_date between '20-FEB-1987' and '1-MAY-1989'
order by 3;

--16. Listare numele salariati, cod dep pt toti angajatii din dep 10 si 30 in ordine alfabetica a numelor
select employee_id,last_name, department_id
from employees
where department_id = 10 or department_id = 30
order by last_name;

select employee_id,last_name, department_id
from employees
where department_id in (10,30)
order by last_name;

--17. Listare numele si salariile angajatilor care castiga mai mult de 1500 si lucreaza in dep 10 sau 30;
--etichetati coloanele "angajat" si "salariu lunar"
select last_name angajat , salary "Salariu lunar", department_id
from employees
where salary>1500 and department_id in (10,30);

--18. Care e data curenta? + ce este dual 
desc dual;
select sysdate from dual;
select 2+2 from dual;

select to_char(sysdate,'DD MONTH YYYY HH24:MI:SS') "DATA"
from dual;

--19. Listare numele si data angajarii pt fiecare salariat care a fost angajat in 1987
--2 sol: una cu format implicit al datei si alta prin care se formateaza data
select last_name, hire_date
from employees
where hire_date between '01-JAN-1987' and '31-DEC-1987';

select last_name, hire_date
from employees
where hire_date like ('%87%');

--sol 2:
select last_name,hire_date
from employees
where to_char(hire_date,'yyyy') = 1987;

--20. Listare nume si job pt toti angajatii care nu au manager
select last_name, job_id
from employees
where manager_id is null;

--21. Listare nume,salariu,comision pt toti salariatii care castiga comisioane; 
--sortati in ordine desc a salarilor si comisioanelor
select last_name,salary,commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

--23. Listare nume angajati care au a treia litera din nume 'A'
select distinct last_name 
from employees
where substr(lower(last_name),3,1) = 'a';

SELECT DISTINCT last_name
FROM employees
WHERE LOWER(last_name) LIKE '__a%';

--24. Listare nume angajati care au 2 litere 'L' in nume si lucreaza in dep 30 sau managerul lor e 7782
select first_name , department_id, manager_id
from employees
where lower(first_name) like '%l%l%'  and  (department_id=30 or manager_id=7782);

--25. Listare nume,job, salary pt toti angajatii al caror job contine sirul 'clerk' sau 'rep' si salariul
--nu este egal cu 1000,2000,3000
select first_name, job_id, salary
from employees
where (lower(job_id) like '%clerk%' or lower(job_id) like '%rep%') and salary not in (1000,2000,3000);

--26. Listare nume,salariu,comision pt toti angajatii al caror salariu este mai mare decat comisionul marit de 5 ori
select last_name, salary, commission_pct
from employees
where salary>5*salary*nvl(commission_pct,0);

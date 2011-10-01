-- lab6, prb.4 - pt fiecare tara, nr de angajati din cadrul acesteia

select count(employee_id) , country_id
from employees  join departments using (department_id)  join locations using (location_id)
full join countries using (country_id) 
group by country_id;  

-- lab5, ex 21
select * 
from (select employee_id , salary
from employees
order by salary desc)
where rownum < 11;

--lab5, ex 22
select job_id, medie
from (select job_id, avg(salary) medie
from employees
group by job_id
order by 2)
where rownum<4;  -- nu folosim rownum daca nu avem sortare!!!

--23
select 'Departamentul ' || department_name || 'este condus de ' || nvl(to_char(departments.manager_id), 'nimeni') || ' si ' || 
decode(count(employee_id), 0, 'nu are salariat ', 'are numarul de salariati ' || count(employee_id)) "Informatii"
from employees right join departments using (department_id)
group by department_id, department_name, departments.manager_id;

--24
select last_name, first_name, 
nullif(length(last_name), length(first_name)) lungime
from employees;

--25
select last_name, hire_date, salary,
salary* decode(to_char(hire_date,'yyyy'), 1989, 1.2, 1990, 1.15, 1991, 1.1,1) "salariu marit"
from employees;

--26
select job_id,
case 
when substr(lower(job_id),1,1) = 's' then sum(salary)
when max(salary) = (select max(salary)
                    from employees) 
then avg(salary)
else min(salary) 
end "mixt"
from employees
group by job_id;

--lab6. 5
select employee_id, last_name
from employees join works_on using(employee_id)
join project using(project_id)
where deadline < delivery_date 
group by employee_id, last_name
having count(project_id) > 1;

--6.
select employee_id, project_id
from employees left join works_on using (employee_id);

--7
select employee_id, department_id
from employees
where department_id in 
(select department_id
from project join employees on (employee_id=project_manager));

--8 : la fel ca 7 , dar not in

--9
select department_id
from employees
group by department_id
having avg(salary) > &medie; --variabilaaaa!!!

--10
with manager as
(select project_manager, count(project_id) nr
from project
group by project_manager
having count(project_id) =2)
select last_name, first_name, salary, nr
from manager join employees on (employee_id=project_manager);

--11
select distinct employee_id
from works_on x
where not exists( select project_id
                from works_on
                where employee_id=x.employee_id
                minus
                select project_id
                from project
                where project_manager=102);
                
--12
select distinct employee_id
from works_on x
where not exists(select project_id
                from works_on
                where employee_id=200
                minus
                select project_id
                from works_on
                where employee_id=x.employee_id);

select distinct employee_id
from works_on x
where not exists(select project_id
                from works_on
                where employee_id=x.employee_id
                minus
                select project_id
                from works_on
                where employee_id=200);
                
                --cel putin, cel mult => multimi
                
--13
select distinct employee_id
from works_on x
where not exists(select project_id
                from works_on
                where employee_id=x.employee_id
                minus
                select project_id
                from works_on
                where employee_id=200) 
and not exists( select project_id
                from works_on
                where employee_id=200
                minus
                select project_id
                from works_on
                where employee_id=x.employee_id);
                
--14
select last_name, first_name, salary, grade_level
from employees, job_grades
where salary between lowest_sal and highest_sal; --face produs cartezian, dar grilele sunt disjuncte, deci e ok :D

--Variaaaaabileee \:D/
--scriptul se ruleaza cu f5 (de ex, un define si un select formeaza un script)

--16
define;
define job;
define job='IT_PROG';
select last_name, department_id, salary*12
from employees
where job_id='&job';
undefine job;
define job;

--cu accept
accept job prompt "Dati job-ul";
select last_name, department_id, salary*12
from employees
where job_id='&job';

select last_name, department_id, salary*12
from employees
where job_id='&&job'; --a fost deja definit cu accept, exista

define job; --job-ul deja exista
undefine job;  --il scot

--17
select last_name, first_name, department_id, salary*12, hire_date
from employees
where hire_date > to_date('&data','dd-mm-yyyy');

--18
select &&col --oo fac globala
from &tabel
where &conditie 
order by &col;

--19
accept data1 prompt "Data1=";
accept data2 prompt "Data2=";
select last_name, first_name, job_id, hire_date
from employees
where hire_date between to_date('&data1', 'dd-mm-yyyy') and to_date('&data2', 'dd-mm-yyyy');

--20
define loc=1400;
select last_name, job_id, salary, department_name
from employees join departments using(department_id) 
where location_id=&loc;

--21
accept data1 prompt "Data1=";
accept data2 prompt "Data2=";
select to_date('&data1', 'dd-mm-yyyy')+rownum-1 from dual
connect by rownum < to_date('&data2', 'dd-mm-yyyy')-to_date('&data1', 'dd-mm-yyyy');




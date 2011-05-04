--pt anagajatzii condusi de 102 se cere codul numele  data angajarii si numele sefului
select a.employee_id,a.last_name,a.hire_date,b.last_name
from emplyees a,employees b
where a.manager_id=b.employee_id and a.manager_id=102;
select b.department_id 
from employees a, departments b
where a.department_id=b.department_id;
--- cod angajat si numele
select employee_id, department_name
from employees a,departments b
where a.department_id=b.department_id(+) --right join
union-- (+) pt ambele, reuninune
select employee_id, department_name
from employees a,departments b
where a.department_id(+)=b.department_id; --right join
select distinct b.department_id
from employees a, departments b
where a.department_id(+)=b.department_id
and a.department_id is NULL;
-- afisatzi codul numele data angajarii si data angajarii sefului pt totzi angajatzii care au fost recrutatzi in firma dupa seful lor
select a.employee_id,a.first_name,a.last_name,a.hire_date,b.hire_date
from employees a,employees b
where a.manager_id=b.employee_id(+) and 
nvl(b.hire_date,to_date ('01-01-1900','dd-mm-yyyy')) < a.hire_date;
--pt fiecare angajat coudl numele sau impreuna cu id si numele colegilor sai

select a.employee_id,a.last_name,b.employee_id,b.last_name
from employees a,employees b
where nvl(a.department_id,0)=nvl(b.department_id,0)
and a.employee_id<=b.employee_id;
--LAB 3
select empoyee_id,last_name,deparment_name
from emplyees e,departments d
where e.department_id=d.department_id;
select employee_id,last_name,department_name
from employees left/right/full join departments--(left right iin loc de (+),full pt reuniune 
on (employees.department_id = departments.department_id);-- on se poate folosi oricand 
using (department_id); --cand avem nevoie de alias
--join -> ''=''
--     ->outer join
--Lab 3 prob 1
select a.first_name,to_char(a.hire_date,'month'),to_char(a.hire_date,'yyyy')
from employees a join employees b
on (a.department_id=b.department_id)
where lower(b.last_name)='gates'
and instr (lower(a.last_name),'a',1)>0
and lower (a.last_name)<>'gates';
--lab 3 prob 2
select distinct a.employee_id,a.last_name,d.department_id,d.department_name
from employees a join departments d
on (a.department_id=d.department_id)
join employees b
on(a.department_id=b.department_id)
where lower(b.last_name) like '%t%'
order by 2;
--lab 3 prob 3
select e.last_name,e.salary,job_title,city,country_id
from employees e join jobs j
on (e.jobs_id=j.jobs_id) join departments d 
on (e.department_id=d.department_id) join locations l
on (d.location_id=l.location_id) join employees f
on (e.manager_id=f.employee_id)
where lower(f.last_name)='king';
--lob 3 prob 7
select distinct a.employee_id,a.last_name,a.salary
from employees a join jobs b
on (a.job_id=b.job_id) join employees c
on (a.department_id=c.department_id)
where instr(lower(c.last_name),'t')>0
and a.salary >(b.min_salary + b.max_salary)/2;
-- lab 3 probl 5
select department_id,department_name,last_name,job_id,to_char(salary,'$99,999.00')
from employees join departments 
using (department_id)
where lower(department_name) like '%ti%'
order by 2,3;
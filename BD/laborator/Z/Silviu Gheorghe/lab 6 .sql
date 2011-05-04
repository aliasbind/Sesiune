-- lab 5 prob 1
select department_name, job_title, avg(salary), grouping(job_id),grouping(department_id)
from employees join departments using (department_id)
join jobs using (job_id)
group by rollup(department_id,department_name,job_id,job_title);
-- lab 5 prob 3
select department_name, job_title, avg(salary), grouping(job_id),grouping(department_id)
from employees join departments using (department_id)
join jobs using (job_id)
group by cube(department_id,department_name,job_id,job_title);
--lab 5 prob 3
select department_name, job_title, employees.manager_id, max(salary), sum(salary)
from employees join departments using (department_id)
join jobs using (job_id)
group by grouping sets((department_name, job_title), (job_title, employees.manager_id),());
-- lab 5 prob 4
select max(salary)
from employees
having max(salary)>15000;
--lab prob 5 a
select employee_id,first_name,salary
from employees
where (select avg(salary)
  from employees a
  where a.department_id=department_id)<salary;
--lab prob 5 b
select employee_id,first_name,salary,department_id,numar,medie
from employees join (select department_id, count (employee_id) numar, avg(salary)medie
  from employees
  group by department_id)
 using(department_id);
 -- cu succedere
 select employee_id,first_name,salary,a.department_id,(select count(employee_id)
 from employees 
 where a.department_id=department_id)"numar", (select avg(salary)
  from employees
  where a.department_id=department_id)"medie",department_name
   from employees a join departments b
    on(a.department_id=b.department_id);
-- lab 5 prob 6 MAX 
select last_name,salary
from employees 
where salary >(select max(avg(salary))
  from employees 
  group by department_id);
-- ALL
select last_name,salary
from employees 
where salary >ALL(select avg(salary)
  from employees 
  group by department_id);
-- lab 5 prob probl 7 
select employee_id,department_id,last_name,salary
from employees
where salary = (select min(salary)
  from employees 
  where department_id=a.department_id);
--succedere in from
select employee_id,department_id,last_name,salary
from employees join(select min(salary) minim,department_id
  from employees 
group by department_id) using (department_id)
where salary = minim;
-- succedre nesincronizata
select department_id,last_name,salary
from employees 
where salary,department_id in select min(salary),department_id
from employees
group by department_id;
-- lab 5 prob 9
select last_name,department_id
from employees a
where exists (select employee_id
  from employees
  where a.department_id=department_id and salary =
  (select max(salary)
    from employees
    where department_id=30));
--lab 5 probl 10
select last_name,salary
from employees a
where 2>=(select count (distinct salary)
  from employees
  where a.salary < salary);
--rownum
select last_name,salary
from (select last_name,salary
from employees
order by salary desc)
where rownum < 4;

select last_name,salary
from employees
where salary in (select salary
order by salary desc)
where rownum < 4;
--lab 5 probl 11
select employee_id,first_name,last_name
from employees a
where 2<= (select count (employee_id)
  from employees
  where manager_id=a.employee_id);
--lab 5 probl 12
select location_id
from locations l
where exists (select '1'
  from departments 
  where location_id=l.location_id);
--lab 5 probl 13
select department_id
from departments d
where not exists (select '1'
  from employees
  where department_id = d.department_id);
-- lab 5 probl 14a
select employee_id,last_name,salary,manager_id,hire_date
from employees
where manager_id=(select employee_id
  from employees
  where lower(last_name)='de haan');
-- lab 5 probl 14b/probl 15
select employee_id,last_name,manager_id
from employees
start with employee_id=100
connect by prior employee_id= manager_id;
--lab probl 16
select employee_id,last_name,salary,manager_id,hire_date
from employees
where manager_id=(select employee_id, level
  from employees
  level 3
  start with employee_id=(select employee_id
  from employees
  where lower(last_name)='de haan')
  connect by prior employee_id=,manager_id;
  -- probl 17 lab 5
select employee_id,last_name,manager_id,level
from employees 
connect by employee_id=prior manager_id;
--lab 5 probl 18
select employee_id,salary,last_name
from employees
where salary>5000
start with employee_id in (select employee_id
from employees 
where salary=(select max(salary)
from employees))
connect by prior employee_id = manager_id;
-- lab 5 probl 9
with department_favourite as
(select department_id
from employees
where salary=(select max(salary) from employees where department_id=30))
select last_name
from employees join department_favourite using (department_id);
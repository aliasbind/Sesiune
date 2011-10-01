-- ex 1 lab 5

select department_name, job_title, avg(salary), grouping (department_name), grouping(job_title)
from employees join departments using (department_id) join jobs using (job_id)
group by rollup(department_name,department_id,job_title,job_id);

-- ex 2 analog, dar cu group by cube...

-- ex 3

select department_name, employees.manager_id, max(salary), min(salary)
from employees join departments using (department_id) join jobs using (job_id)
group by grouping sets ((department_name, department_id, job_title, job_id),(job_title,job_id,employees.manager_id),());


-- ex 4

select max(salary)
from employees
having max(salary)>15000;


-- ex 5 a

select employee_id, last_name, department_id
from employees a
where salary > (select avg(salary) from employees b where a.department_id=b.department_id);


-- ex 5 b

select employee_id, last_name, department_id, department_name, mediasal, numarang
from employees a join departments using (department_id)
  join (select department_id, avg(salary) mediasal, count(employee_id) numarang from employees 
  group by department_id) using (department_id);


-- sau

select a.department_id, department_name, avg(b.salary), count(b.employee_id), c.employee_id, c.salary
from departments a left join employees b on (a.department_id=b.department_id) 
  join (select department_id, employee_id, salary from employees) c on (b.department_id=c.department_id)
group by a.department_id, department_name, c.employee_id, c.salary;


-- sau

select employee_id, salary, e.department_id, (select avg(salary) from employees o where e.department_id=o.department_id) MedieSal,
  (select count(employee_id) from employees t where t.department_id=e.department_id) NumarAng, department_name
from employees e join departments d on (e.department_id=d.department_id);


-- ex 6

select last_name, salary
from employees
where salary > all 
  (select avg(salary) from employees group by department_id);

-- sau

select last_name, salary
from employees
where salary > 
  (select max(avg(salary)) from employees group by department_id);


-- ex 7

select last_name, salary
from employees a
where salary = 
 (select min(salary) from employees b where a.department_id=b.department_id);

-- sau

select last_name, salary, a.department_id, a.employee_id
from employees a join 
  (select min(salary) salariu, department_id from employees group by department_id ) b on (a.department_id=b.department_id)
where salary = salariu;

-- sau

select last_name, salary
from employees
where (department_id,salary) in (select department_id, min(salary) from employees group by department_id);


-- ex 9

select last_name, department_id
from employees a
where exists ( select employee_id from employees b where a.department_id=b.department_id 
  and b.salary = ( select max(salary) from employees where department_id = 30 )) ;


-- ex 8

select last_name, a.department_id, d.department_name
from employees a join departments d on (a.department_id=d.department_id)
where hire_date = (select min(hire_date) from employees b where a.department_id=b.department_id )
order by d.department_name;


-- ex 11

select last_name,first_name,employee_id
from employees a
where 2 <= (select count(manager_id) from employees b where a.employee_id=b.manager_id);


-- ex 10

select last_name, salary
from employees
where salary in
 (select salary
  from (select distinct salary from employees order by salary desc )
  where rownum < 4)
order by salary;

-- aceeasi cerinta, fara rownum

select last_name, salary
from employees e
where 2 >= (select count(distinct salary) from employees where salary > e.salary);


-- ex 12

select location_id
from locations e
where exists (select 1 from departments where e.location_id=location_id);


-- ex 13

select department_id
from departments d
where not exists (select 1 from employees where department_id=d.department_id);


-- ex 14 a

select employee_id, last_name, hire_date, manager_id
from employees
where manager_id in (select employee_id from employees where lower(last_name)='de haan');


-- ex 14 b

select employee_id, last_name, hire_date, manager_id, level
from employees
  start with employee_id=(select employee_id from employees where lower(last_name)='de haan')
  connect by prior employee_id=manager_id;


-- ex 15

select employee_id, last_name, hire_date, manager_id, level
from employees
  start with employee_id = 114
  connect by prior employee_id=manager_id;


-- ex 16

select employee_id, manager_id, last_name, level
from employees
where level = 3
  start with employee_id=(select employee_id from employees where lower(last_name)='de haan')
  connect by prior employee_id=manager_id;


-- ex 17

select last_name, level, employee_id, manager_id
from employees
connect by employee_id = prior manager_id
order by employee_id;


-- ex 18

select employee_id, manager_id, last_name, salary, level
from employees
where salary > 5000
 start with employee_id in (select employee_id from employees where salary=(select max(salary) from employees))
 connect by prior employee_id = manager_id;

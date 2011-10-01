-- lab 3 ex 2

select distinct a.employee_id, a.last_name, c.department_id, c.department_name 
from employees a join employees b on ( a.department_id = b.department_id )
  join departments c on ( a.department_id = c.department_id )
where lower(b.last_name) like '%t%'
order by 2;


-- ex 3

select a.last_name, a.salary, j.job_title, d.city, d.country_id
from employees a join employees b on (a.manager_id=b.employee_id)
  join jobs j on (a.job_id=j.job_id)
  join departments c on ( b.department_id=c.department_id )
  join locations d on ( c.location_id=d.location_id )
  where lower(b.last_name)='king';


-- ex 5

select department_id, department_name, last_name, job_id, salary
from departments join employees using (department_id)
where lower(department_name) like '%ti%'
order by department_name, last_name;


-- ex 6

select last_name, department_id, department_name, job_id, city
from employees join departments using (department_id)
  join locations using (location_id)
  where lower(city)='oxford';


-- ex 7

select a.employee_id, a.last_name, a.salary
from employees a
where salary > (select (min(salary)+max(salary))/2 from employees b where a.department_id = b.department_id);

-- sau

select distinct a.employee_id, a.last_name, a.salary
from employees a join employees b on (a.department_id=b.department_id)
  join jobs j on (a.job_id=j.job_id)
  where a.salary > (j.min_salary + j.max_salary)/2 and lower(b.last_name) like '%t%';
 

-- ex 8,9,10

select last_name, department_name
from employees left join departments using (department_id);     -- sau right, sau full
-- daca scriam left outer join, right outer join, full outer join - era acelasi lucru + compatibilitate cu versiuni mai vechi


-- ex 11

select department_id
from departments
where lower(department_name) like '%re%'
union                                      -- union all => cu tot cu duplicate
select department_id
from employees
where lower(job_id)='sa_rep';


-- ex 13

select department_id
from departments
minus
select department_id
from employees;

--sau

select distinct department_id
from departments left join employees using (department_id)
where last_name is null
order by 1;



-- ex 14

select department_id
from departments
where lower(department_name) like '%re%'
intersect
select department_id
from employees
where lower(job_id)='hr_rep';


-- ex 18

select last_name, salary
from employees
where manager_id = (select employee_id from employees where manager_id is null);


-- ex 19

select last_name, department_id, salary
from employees
where (department_id, salary) IN 
  (select department_id, salary
   from employees
   where commission_pct is not null);


-- ex 21

select employee_id, last_name, salary
from employees
where salary >  all (select salary from employees
                     where lower(job_id) like '%clerk%') -- sau any in loc de all
order by salary desc;


-- ex 24

select last_name, department_id, job_id
from employees
where department_id = (select department_id from departments where location_id = 
  (select location_id from locations where lower(city)='toronto'));


-- ex 22

select last_name, department_name, salary
from employees, departments
where employees.department_id=departments.department_id and commission_pct is null and employees.manager_id IN 
  ( select manager_id from employees where commission_pct is not null);


-- ex 23

select last_name, department_id, salary, job_id
from employees
where (salary,commission_pct) IN 
 ( select salary, commision_pct from employees join departments using (department_id) 
   join locations on (location_id) where lower(city)='oxford');


-- laboratorul 4
-- pt fiecare departament sa se afiseze numele, codul, si un calificativ - mic, mediu, mare - dupa regula: 
-- daca are < 5 angajati => mic, intre 5 si 10 => mediu, restu mare

select department_id, count(employee_id)
from employees
group by department_id;

select distinct l.department_id, department_name, (select count(employee_id)
  from employees where department_id=d.department_id)
from employees l join departments d on (l.department_id=d.department_id); --group by l.department_id, department_name

select distinct e.department_id, department_name, 
  ( select max(salary) from employees where department_id=e.department_id) "Max salary",
  ( select max(hire_date) from employees where department_id=e.department_id) "Max date"
from employees e join departments d on (e.department_id=d.department_id);


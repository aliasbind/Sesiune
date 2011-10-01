-- lab 4 prob 3
select job_id ,max(salary_,min(salary) ,sum(salary) ,avg(salary)
from employees
group by job_id;
-- lab 4 prob 4
select count(employee_id), job_id
from employees
group by job_id;
-- lab 4 prob 5
select count (distinct manager_id)--Nr. manager
from employees;
-- lab 4 prob 6
select max(salary),min(salary)
from employees;
-- lab 4 prob 7
select department_name, location_id, count(employee_id), avg(salary)
from departments
join employees using (department_id)
group by department_id, department_name, location_id;
-- lab 4 prob 8
select employee_id,first_name, salary
from employees
where salary>(select avg(salary)
from employees)
order by salary desc;
-- lab 4 prob 9
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary)>1000
order by 2 desc;
-- lab 4 prob 10
select department_id,department_name,max(salary)
from employees join departments using(department_id)
group by derpatment_id,department_name
having max(salary)>3000;
-- lab 4 prob 11
select min(avg(salary))
from employees
group by job_id;
-- lab 4 prob 12
select department_id,department_name,sum(salary)
from employees join departments using(department_id)
group by department_id,department_name;
-- lab 4 prob 13
select max(avg(salary))
from employees
group by department_id;
-- lab 4 prob 14
select job_id, job_title, avg(salary)
from employees join jobs using (job_id)
group by job_id, job_title
having avg(salary)=(select min(avg(salary))
from employees
group by job_id);
-- lab 4 prob 15
select avg(salary)
from employees
having avg(salary)>2500;
-- lab 4 prob 16
select sum(salary) ,department_id,job_id
from employees
group by department_id, job_id;
-- lab 4 prob 17
select department_name,min(salary)
from employees join departments using (department_id)
group by department_name,department_id
having avg(salary)=(select max(avg(salary))
from employees
group by department_id);
-- lab 4 prob 18
select department_name,department_id,count(employee_id)
from employees join departments using(department_id)
group by department_id,department_name
having count(employee_id)<4
union
select department_name,department_id,count(employee_id)
from employees join departments using(department_id)
group by department_id,department_name
having count(employee_id)=(select max(count(employee_id))
from employees
group by department_id);
-- lab 4 prob 19
select employee_id,to_char(hire_date,'dd')
from employees
where to_char(hire_date,'dd')=(select to_char(hire_date,'dd')
from employees
group by to_char(hire_date,'dd')
having count(employee_id)=(select max(count(employee_id))
from employees
group by to_char(hire_date,'dd')));
-- lab 4 prob 23
select sum(salary) ,city, department_name ,job_id
from employees
join departments using (department_id)
join locations using(location_id)
join jobs using (job_id)
group by department_id, department_name, job_id,city
having department_id>80;
-- lab 4 prob 25
select avg(nvl(commission_pct,0))
from employees
select sum(commission_pct)/count(*)
from employees;
-- lab 4 prob 30
select department_id,department_name,sum(salary)
from departments left join employees using(department_id)
group by department_id,department_name;
-- lab 4 prob 30 var 2
select a.department_id,a.department_name,miercuri
from departments a left join (select department_id,sum(salary) miercuri
from employees
group by department_id) b
on (a.department_id=b.department_id);
-- lab 4 prob 30 var 3
select department_id,department_name,(select sum(salary) 
from employees 
where department_id = a.department_id)
from departments a;
--lab 4 prob 22
select d.department_id,department_name,salary,job_id,last_name,
(select avg(salary)
from employees
where d.department_id=department_id) "medie",
(select count(employee_id)
from employees
where d.department_id=department_id) "numar"
from departments d left join employees e
on (d.department_id=e.department_id);
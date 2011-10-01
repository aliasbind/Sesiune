--lab 4 prob 27
select job_id "job",sum(salary),(select sum(salary)
  from employees
  where department_id=30 and job_id=e.job_id)"dep 30",(select sum(salary)
    from employees
    where department_id=50 and job_id=e.job_id)"dep 50",(select sum(salary)
      from employees
      where department_id=80
      and job_id=e.job_id)"dep 80"
from employees e
group by job_id;
--lab 4 prob 27 cu decode
select job_id,sum(salary) total,
  sum(decode(department_id,30,salary,0)) "dep 30",
  sum(decode(department_id,50,salary,0)) "dep 50",
  sum(decode(department_id,80,salary,0)) "dep 80"
from employees
group by job_id;
--lab 4 prob 27 cu decod
select count(employee_id),
  sum(decode(to_char(hire_date, 'yyyy'), 1997, 1,0)),
  sum(decode(to_char(hire_date, 'yyyy'), 1998, 1,0)),
  sum(decode(to_char(hire_date, 'yyyy'), 1999, 1,0)),
  sum(decode(to_char(hire_date, 'yyyy'), 2000, 1,0))
from employees;
--lab 4 prob 31
select a.department_id,a.employee_id,a.last_name,medie,numar
from employees a join (select department_id,avg(salary) medie,count(employee_id) numar
  from employees
  group by department_id) b
  on (a.department_id=b.department_id);
--lab 4 prob 33
select d.department_id,d.department_name,e.last_name,salary
from departments d join employees e on(d.department_id=e.department_id)
  where salary=(select min(salary)
    from employees
    where department_id=d.department_id);
--lab 4 prob 33 var 2
select d.department_id,d.department_name
from departments d join(select department_id,last_name,salary
  from employees right join departments d on (e.department_id=d.department_id)
  where salary=(select min(salary)
  from employees
  where (d.department_id=e.department_id)))
  on 
--lab 4 prob 5
select count(manager_id)
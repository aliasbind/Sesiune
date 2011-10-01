-- ex 27

select a.job_id, sum(salary),
  (select sum(b.salary) from employees b where a.job_id=b.job_id and department_id=30) "Dep 30",
  (select sum(b.salary) from employees b where a.job_id=b.job_id and department_id=50) "Dep 50",
  (select sum(b.salary) from employees b where a.job_id=b.job_id and department_id=80) "Dep 80"
from employees a
group by a.job_id;


-- sau

select job_id, sum(salary) Total, sum(decode(department_id,30,salary,0)) "Dep 30",
  sum(decode(department_id,50,salary,0)) "Dep 50",
  sum(decode(department_id,80,salary,0)) "Dep 80"
from employees 
group by job_id;


-- ex 28

select count(employee_id) Total, sum(decode(to_char(hire_date,'YYYY'),1997,1,0)) "1997",
  sum(decode(to_char(hire_date,'YYYY'),1998,1,0)) "1998",
  sum(decode(to_char(hire_date,'YYYY'),1999,1,0)) "1999",
  sum(decode(to_char(hire_date,'YYYY'),2000,1,0)) "2000"
from employees;


-- ex 31

select  employee_id, last_name, b.department_id, medie, numar
from employees a
right join
(select department_id, avg(salary) medie, count(employee_id) numar
 from employees right join departments using (department_id) group by department_id) b
on (a.department_id=b.department_id);


-- ex 33
select department_name, a.department_id, last_name, salary
from departments a left join employees b on (a.department_id=b.department_id)
where salary = (select min(salary) from employees c where c.department_id=b.department_id)
order by 2;


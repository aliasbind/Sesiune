desc COUNTRIES;
select * from JOBS where min_salary>=8000;

select department_id, department_name as department
from departments;

select department_id || ' ' || department_name department
from departments;

select employee_id, last_name, job_id, hire_date
from employees;

select distinct department_id
from employees
order by department_id;

select department_id || ', ' || email || ', ' || employee_id || ', ' || first_name || ', ' || hire_date || ', ' || job_id || ', ' || last_name || ', ' || manager_id || ', ' || phone_number || ', ' || salary as "Informatii complete"
from employees;

select employee_id, department_id
from employees
where department_id=80 or department_id=40;

select first_name, salary
from employees
where salary>=5000 and (department_id=30 or department_id=50);

select first_name, salary
from employees
where salary>=5000 and department_id not in (10,30,50,70);

select first_name, salary
from employees
where salary>=7000 and salary<=10000;

select first_name, salary
from employees
where salary between 7000 and 10000;

select first_name, salary
from employees
where salary not between 7000 and 10000;

select first_name, last_name, job_id, hire_date
from employees
where hire_date between '20-FEB-1987' and '1-MAY-1989'
order by hire_date;                        -- sau order by 4 - numarul coloanei dintre cele selectate!

desc dual;

select 2+2 from dual;

select sysdate from dual;

select to_char(sysdate,'DD MONTH YYYY HH24:MI:SS')
from dual;

select employee_id, first_name
from employees
where lower(first_name) like '%l%l%';

select employee_id, salary
from employees
where salary like '__5%';

select employee_id, manager_id, first_name, last_name
from employees
where manager_id is null;

select first_name, last_name, salary, commission_pct
from employees
--where commission_pct is not null
order by salary desc, commission_pct desc;

select first_name, last_name, job_id, salary
from employees
where (lower(job_id) like '%clerk%' or lower(job_id) like '%rep%') and salary not in (1000,2000,3000);

select first_name, last_name, salary, commission_pct
from employees
where salary>5*salary*commission_pct or commission_pct is null;

select first_name, last_name, salary, commission_pct
from employees
where salary > 5 * salary * nvl(commission_pct,0);

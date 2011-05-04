select distinct employee_id
from works_on w
where not exists
  (select project_id
  from project p
  where budget=10000 and not exists
    (select employee_id
    from works_on
    where project_id=p.project_id
    and employee_id=w.employee_id));
-- solutzie normala
select distinct employee_id
from works_on A
where (select count(project_id)
    from project
    where budget=10000)=(select count(project_id)
    from works_on join project using(project_id)
    where budget=10000 and
    employee_id=A.employee_id);
-- alta sol 
select distinct employee_id
from works_on w
where not exists (select project_id
  from project 
  where budget=10000
  minus
  select project_id
  from works_on
  where employee_id=w.employee_id);
--URM SOL
select distinct employee_id
from works_on
where employee_id not in
(select employee_id from
(select employee_id,t.project_id
  from works_on,
  (select project_id
  from project
  where budget=10000) t
  minus
  select employee_id, project_id
  from works_on));
--lab 6 probl 1
select distinct employee_id
from works_on w
where not exists 
(select project_id
  from project p
  where start_date>=to_date('01-01-2006','dd-mm-yy') and 
        start_date<=to_date('30-01-2006','dd-mm-yy')
        and not exists
        (select employee_id
        from works_on
        where project_id=p.project_id and employee_id=w.employee_id));
--var 2
select distinct employee_id
from works_on where employee_id not in(
select distinct employee_id from
(select employee_id,project_id
from employees, (select project_id
          from project
          where start_date>=to_date('01-01-2006','dd-mm-yy') and
                start_date<=to_date('30-06-2006','dd-mm-yy'))
                minus
select employee_id,project_id
from works_on));
--lab 6 probl 2 (o var)
select project_id
from project p
where not exists
(select employee_id
from job_history
group by employee_id
having count(*)>1
minus
select employee_id
from works_on
where project_id=p.project_id);
--lab 6 probl 3
select j.employee_id, count(distinct j.job_id)
from job_history j join employees x on(x.employee_id=j.employee_id)
group by j.employee_id,x.job_id,x.employee_id
having count(distinct j.job_id)+
case when x.job_id in 
(select job_id
from job_history
where employee_id=x.employee_id) then 0 else 1 end
>2;
-- lab 5 probl 19
with lab223 as
(select department_id,sum(salary) suma
from employees 
group by department_id),lab214 as
(select *
from lab223
where suma>(select avg(suma) from lab223))
select department_name,suma
from departments join lab214 using(department_id);
--lab 5 probl 20
with stevenking as
(select employee_id,hire_date
from employees
where manager_id=(select employee_id
  from employees 
  where lower(last_name)='king' and lower(first_name)='steven')),
  stevenking_old as (select employee_id
  from stevenking
  where hire_date=(select min(hire_date)
  from stevenking))
  select employee_id,last_name,first_name,job_id,hire_date,level,manager_id
  from employees
  where to_char(hire_date,'yyyy')<>1970
  start with employee_id in (select employee_id from stevenking_old) connect by prior employee_id=manager_id;
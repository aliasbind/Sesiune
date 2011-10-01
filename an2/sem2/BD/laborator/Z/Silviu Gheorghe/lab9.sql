create table emp_pnu as select * from employees;
create table dept_pnu as select * from departments;

desc emp_pnu;
desc employees;
ALTER TABLE emp_pnu
ADD CONSTRAINT pk_emp_pnu PRIMARY KEY(employee_id);
ALTER TABLE dept_pnu
ADD CONSTRAINT pk_dept_pnu PRIMARY KEY(department_id);
ALTER TABLE emp_pnu
ADD CONSTRAINT fk_emp_dept_pnu
FOREIGN KEY(department_id) REFERENCES dept_pnu(department_id);
--
alter table dept_pnu
add constraint fk_manager foreign key(manager_id)
references emp_pnu(employee_id);

alter table emp_pnu
add constraint fk_sef foreign key(manager_id)
references emp_pnu(employee_id);
--lab 7 prob 5
INSERT INTO DEPT_pnu (department_id, department_name, location_id)
VALUES (300, ‘Programare’, null);
commit;

insert unto emp_pnu
values(220,null,'nume1','email@nume1',null,
to date ('01-01-2011','dd-mm-yyyy'),'SA_MAN',null,null,null,300);
commit;

-- probl 7 lab 7
insert into emp_pnu(employee_id,last_name,email,hire_date,job_id,department_id)
values (221, 'nume2' ,'email@nume2', sysdate , 'IT_Prog',300);

--lab 7 probl 8
insert into
(select employee_id, last_name,email,hire_date,job_id
from emp_pnu)
values ((select max(employee_id)+1 from emp_pnu), 'nume3',
'email',sysdate,'AD_MAN');
--lab 7 prob 9
create table emp1_pnu
as select * from employees
where 1>2;

insert into emp1_pnu
select *
from employees
where commission_pct>0.25;

-- lab 7 probl 10

insert into emp_pnu
values(0,user, user, 'total','total',sysdate, 'total',
(select sum(salary) from emp_pnu),
(select avg(commission_pct)from emp_pnu), null, null);
--lab 7 probl 11

undefine nume;
undefine prenume;
insert into emp_pnu(employee_id,first_name,last_name,email,hire_date,job_id,salary)
values (&cod, '&&prenume','&&nume',substr('&prenume',1,1)||
substr('&nume', 1,7), to_date('data','dd-mm-yyyy'),
'&job', &sal);
--
delete from emp3_pnu;

create table emp3_pnu
as select * from employees
where 1>2;

-- lab 7 probl 12

insert all
when salary <5000 then into emp1_pnu
when salary between 5000 and 10000 then into emp2_pnu
else into emp3_pnu
select *
from employees;

--lab 7 probl 13

insert all
when departmment_id=80 then into emp0_pnu
when salary <5000 then into emp1_pnu
when salary between 5000 and 10000 then into emp2_pnu
else into emp3_pnu
select *
from employees;
commit;
-lab 7 probl 14

update emp_pnu
set salary=salary*1.05;
rollback;
--lab 7 probl 15

update emp_pnu
set job_id='SA_REP'
where department_id=80 and commission_pct is not null;

rollback;

--lab 7 probl 16.

update dept_pnu
set manager_id=(
select employee_id
from emp_pnu
where lower(first_name)='douglas' and lower (last_name)='grant')
where department_id=20;

update emp_pnu

set salary=salary+1000
where employee_id=(
select employee_id
from emp_pnu
where lower(first_name)='douglas' and lower (last_name)='grant');

rollback;




rollback;

--lab 7 probl 17

update  emp_pnu x
set (salary, commission_pct)=(select salary,commission_pct
  from emp_pnu
  where employee_id=x.manager_id)
where salary=(select min(salary) from emp_pnu);

rollback;

--lab 7 probl 18

update emp_pnu y
set email=substr(last_name,1,1)||nvl(first_name,'.')
where salary=(select max(salary)
from emp_pnu
where department_id=y.department_id);

rollback;

--lab 7 probl 19
update emp_pnu y
set salary=(select avg(salary) from emp_pnu where employee_id>0)
where hire_date=(select min(hire_date)
from emp_pnu
where department_id=y.department_id);

rollback;

--lab 7 probl 20

update emp_pnu
set (job_id,department_id)=( select job_id,department_id
from emp_pnu
where employee_id=205)

where employee_id=114;

rollback;

--lab 7 probl 21
undefine cod;
define cod=&x;
select *
from dept_pnu
where department_id=&cod;
update dept_pnu
set department_name='&dep',location_id=&loc,manager_id=&sef
where department_id=&cod;
select *
from dept_pnu
where department_id=&cod;

rollbackl;

--lab 7 probl 22

delete from dept_pnu;

--lab 7 probl 24
delete from dept_pnu
where department_id not in
(select nvl (department_id,0)
from emp_pnu);

rollback;
--lab 7 probl 23

delete from emp_pnu
where commission_pct is null;

rollback;
--lab 7 probl 25

define cod=0;
select employee_id,salary
from emp_pnu
where employee_id=&cod;
delete from emp_pnu
where emplopyee_id=&cod;
commit;
--lab 7 probl 31

delete from emp2_pnu
where commission_pct is not null;
commit;
merge into emp2_pnu x
using employees e
on (x.employee_id=e.employee_id)
when matched then 
update set
x.first_name=e.first_name,
x.last_name=e.last_name,
x.email=e.email,
x.phone_number=e.phone_number,
x.hire_date=e.hire_date,
x.job_id=e.job_id,
x.salary=e.salary,
x.commission_pct=e.commission_pct,
x.manager_id=e.manager_id,
x.department_id=e.department_id
when not matched then
insert
values(e.employee_id,e.first_name,e.last_name,e.email,
e.phone_number,e.hire_date,e.job_id,e._salary,e.commission_pct,
e.manager_id,e.departmment_id);

-- lab7

select salary 
from employees
where employee_id=104;

update employees
set salary=salary+2000
where employee_id=104;

commit;


--lab7, ex 1

CREATE TABLE EMP_pnu AS SELECT * FROM employees;
CREATE TABLE DEPT_pnu AS SELECT * FROM departments;

desc employees;
desc emp_pnu;

ALTER TABLE emp_pnu
ADD CONSTRAINT pk_emp_pnu PRIMARY KEY(employee_id);
ALTER TABLE dept_pnu
ADD CONSTRAINT pk_dept_pnu PRIMARY KEY(department_id);
ALTER TABLE emp_pnu
ADD CONSTRAINT fk_emp_dept_pnu
FOREIGN KEY(department_id) REFERENCES dept_pnu(department_id);


alter table dept_pnu
add constraint fk_manager foreign key (manager_id) references emp_pnu(employee_id);

alter table emp_pnu
add constraint fk_sef foreign key (manager_id) references emp_pnu(employee_id);

-- ex 5 - variantele corecte: b, d
-- e incorect pt ca nu se pune pk, a nu specifica in ce coloane, c nu e ordinea corecta

INSERT INTO DEPT_pnu (department_id, department_name)
VALUES (300, 'Programare');

commit;

-- ex 6

insert into emp_pnu values
(220,'nume1','prenume1','email','999.999',to_date('02-02-2001','dd-mm-yyyy'),'IT_PROG',3000,null,null,300);


-- ex 7

insert into emp_pnu (employee_id, last_name, email, hire_date, job_id, department_id)
values (221,'nume2','email',sysdate,'SA_MAN',300);

commit;

-- ex 8

insert into
(select employee_id, last_name, email, hire_date, job_id from emp_pnu)
values ((select max(employee_id)+1 from emp_pnu),'view','enmail@view',sysdate,'lab223');


-- ex 9 - il cream cu o conditie falsa => o sa tina minte doar structura

create table emp1_pnu
as select * from employees
where 1>2;

insert into emp1_pnu
select * from emp_pnu
where commission_pct > 0.25;


-- ex 10

insert into emp_pnu
values (0, user, user, 'total', 'total', sysdate, 'total', (select sum(salary) from employees), 
  (select avg(commission_pct) from employees), null, null);


-- ex 11

insert into emp_pnu (employee_id, first_name, last_name, email, hire_date, job_id, salary)
values (&id, &&prenume, &&nume, substr(&&prenume,1,1) || substr(&&nume,1,7), to_date('&data','dd-mm-yyyy'), &job, &sal);


-- ex 12

delete from emp1_pnu;

select * from emp2_pnu;

create table emp2_pnu as select * from employees where 1>2;
create table emp3_pnu as select * from employees where 1>2;

commit;

insert all
when salary < 5000 then into emp1_pnu
when salary between 5000 and 10000 then into emp2_pnu
else into emp3_pnu
select * from employees;


-- ex 13

delete from emp1_pnu;
delete from emp2_pnu;
delete from emp3_pnu;

create table emp0_pnu as select * from employees where 1>2;

insert first
when department_id = 80 then into emp0_pnu
when salary < 5000 then into emp1_pnu
when salary between 5000 and 10000 then into emp2_pnu
else into emp3_pnu
select * from employees;


-- update
-- ex 14

update emp_pnu
set salary = salary*1.05;

rollback;   -- anuleaza modificarile

-- ex 15

update emp_pnu
set job_id='SA_REP'
where department_id = 80 and commission_pct is not null;

rollback;


-- ex 16 - nu se poate face la nivelul anului 2 - e nevoie de un trigger, il invatam in anul 3

update dept_pnu
set  manager_id = (select employee_id from emp_pnu where lower(last_name) = 'grant' and lower(first_name) = 'douglas')
where department_id = 20;

update emp_pnu
set salary = salary + 1000
where employee_id = (select employee_id from emp_pnu where lower(last_name) = 'grant' and lower(first_name) = 'douglas');


-- ex 17

update emp_pnu x
set (salary, commission_pct) = (select salary, commission_pct from emp_pnu where employee_id = x.manager_id)
where salary = (select min(salary) from emp_pnu);

rollback;

--ex18

update emp_pnu y
set email=substr(last_name,1,1)||nvl(first_name,'.')
where salary = (select max(salary) from emp_pnu where department_id=y.department_id);

rollback;

--ex19

update emp_pnu y
set salary=(select avg(salary) from emp_pnu where employee_id>0)
where hire_date = (select max(hire_date) from emp_pnu where department_id=y.department_id);

rollback;


-- ex 20

update emp_pnu
set (job_id, department_id) = (select job_id, department_id from emp_pnu
                               where employee_id = 205)
where employee_id = 114;


-- ex 21

undefine cod;
undefine nume;

accept cod prompt "cod departament = ";

select * from dept_pnu
where department_id = &cod;

update dept_pnu
set department_name = '&nume', location_id = &loc, manager_id = &sef
where department_id = &cod;

select * from dept_pnu where department_id = &cod;

rollback;


-- delete

--ex 22

delete from dept_pnu;

delete from dept_pnu
where department_id not in (select nvl(department_id,0) from emp_pnu);

rollback;


-- ex 23

delete from emp_pnu
where commission_pct is null;

rollback;


-- ex 25


undefine cod;
define cod = &cod;

select employee_id, last_name
from emp_pnu
where employee_id = &cod;

delete from emp_pnu
where employee_id = &cod;


-- ex 26-30

insert into emp3_pnu values
(888,'nume1','prenume1','email','999.999',to_date('02-02-2001','dd-mm-yyyy'),'IT_PROG',3000,null,null,300);

savepoint x;
delete from emp3_pnu;
select * from emp3_pnu;

rollback to x;

rollback;


-- ex 31

delete from emp2_pnu
where commission_pct is not null;

commit;

merge into emp2_pnu x
using employees e
on (x.employee_id = e.employee_id)
when matched then
  update set
 first_name = e.first_name,
 last_name = e.last_name,
 email = e.email,
 phone_number = e.phone_number,
 hire_date = e.hire_date,
 job_id = e.job_id,
 salary = e.salary,
 commission_pct = e.commission_pct,
 manager_id = e.manager_id,
 department_id = e.department_id
when not matched then
  insert values (e.employee_id, e.first_name, e.last_name, e.email, e.phone_number, e.hire_date, e.job_id,
    e.salary, e.commission_pct, e.manager_id, e.department_id);


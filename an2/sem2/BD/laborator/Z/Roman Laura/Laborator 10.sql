select * from employees;

CREATE TABLE EMP_pnu AS SELECT * FROM employees;
CREATE TABLE DEPT_pnu AS SELECT * FROM departments;

desc emp_pnu;
desc employees;

ALTER TABLE emp_pnu
ADD CONSTRAINT pk_emp_pnu PRIMARY KEY(employee_id);
ALTER TABLE dept_pnu
ADD CONSTRAINT pk_dept_pnu PRIMARY KEY(department_id);
ALTER TABLE emp_pnu
ADD CONSTRAINT fk_emp_dept_pnu
FOREIGN KEY(department_id) REFERENCES dept_pnu(department_id);
--cine conduce departamentul tre sa fie angajat
alter table dept_pnu
add constraint fk_manager foreign key(manager_id)
references emp_pnu;
-- manager id din employees tre sa fie angajat
alter table emp_pnu
add constraint fk_sef foreign key(manager_id)
references emp_pnu(employee_id);

INSERT INTO DEPT_pnu (department_id, department_name)
VALUES (300, 'Programare');

commit;
--6
insert into emp_pnu --metoda implicita
values (220, null, 'nume1', 'email@nume1',null, to_date('01-01-2011', 'dd-mm-yyyy'), 'SA-MAN', null,null,null,300);

commit;
--7 metoda explicita
insert into emp_pnu(employee_id, last_name, email, hire_date, job_id,department_id)
values(221,'nume2', 'email@nume2',sysdate,'IT_PROG',300);

--8
insert into 
(select employee_id, last_name, email, hire_date, job_id
from emp_pnu)
values((select max(employee_id)+1 from emp_pnu), 'nume3', 'email', sysdate, 'AD_MAN');

--9
create table emp1_pnu
as select * from employees
where 1>2;

insert into emp1_pnu
select * from employees --in loc de values, subcerere
where commission_pct>0.25;

--10
insert into emp_pnu
values(0,user,user, 'total', 'total', sysdate, 'total', (select sum(salary) from emp_pnu), 
(select avg(commission_pct) from emp_pnu), null, null);

--11
undefine nume;
undefine prenume;
insert into emp_pnu(employee_id, first_name, last_name, email, hire_date, job_id,salary)
values (&cod, '&&prenume','&&nume', substr('&prenume',1,1)||substr('&nume',1,7), to_date('&data','dd-mm-yyyy'),
'&job', &sal);
--12
delete from emp3_pnu;

--cream si 2,3,0
create table emp0_pnu
as select * from employees
where 1>2;

insert all 
when salary<5000 then into emp1_pnu
when salary between 5000 and 10000 then into emp2_pnu
else into emp3_pnu
select * from employees;
--delete from emp1_pnu +2+3

insert first
when department_id=80 then into emp0_pnu
when salary<5000 then into emp1_pnu
when salary between 5000 and 10000 then into emp2_pnu
else into emp3_pnu
select * from employees;

--14
update emp_pnu
set salary = salary*1.05;

rollback;

update emp_pnu
set job_id='SA_REP'
where department_id=80 and commission_pct is not null;

rollback;

--16
update dept_pnu
set manager_id = (select employee_id from emp_pnu where lower(first_name)='douglas' and lower(last_name)='grant')
where department_id=20;

update emp_pnu
set salary = salary+1000
where employee_id = (select employee_id from emp_pnu where lower(first_name)='douglas' and lower(last_name)='grant');

--17
update emp_pnu x
set (salary,commission_pct) = (select salary, commission_pct
                              from emp_pnu
                              where employee_id= x.manager_id)
where salary=(select min(salary) from emp_pnu);

--18
update emp_pnu y
set email = substr(last_name,1,1)||nvl(first_name,'.')
where salary = (select max(salary)
               from emp_pnu
               where department_id=y.department_id);
               
rollback;

--19

update emp_pnu y
set salary = (select avg(salary) from emp_pnu where employee_id > 0)
where hire_date = (select min(hire_date) from emp_pnu where department_id=y.department_id);

rollback;
--20
update emp_pnu
set (job_id,department_id) = (select job_id, department_id
                            from emp_pnu
                            where employee_id = 205)
where employee_id = 114;

--21
undefine cod;
define cod=&x;
select *
from dept_pnu
where department_id = &cod;
update dept_pnu
set department_name = '&dep', location_id = &loc, manager_id = &sef
where department_id = &cod;
select *
from dept_pnu
where department_id = &cod;

rollback;

--22 nu merge. se pot sterge doar departamente goale, fara angajati
delete from dept_pnu;
--24
delete from dept_pnu
where department_id not in (select nvl(department_id,0) from emp_pnu); 

rollback;

--23
delete from emp2_pnu
where commission_pct is null;

--25
define cod =0;
select employee_id, salary from emp_pnu
where employee_id = &cod;
delete from emp_pnu
where employee_id = &cod;

commit;

--31
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
values(e.employee_id,e.first_name,e.last_name,e.email,e.phone_number,e.hire_date,e.job_id,e.salary, e.commission_pct,e.manager_id,
e.department_id);


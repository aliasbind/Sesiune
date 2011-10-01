-- with tabel as (subcerere), tabel2 as (subcerere2), ...

-- lab 5 ex 19

with tabel as 
(select department_id, sum(salary) suma
 from employees
 group by department_id),
     tab_max as
 (select * from tabel where suma > (select avg(suma) from tabel))
select department_name, suma
from departments join tab_max using (department_id);


-- ex 20

with tabel as -- primul tabel selecteaza angajatii directi ai lui king
 (select employee_id, hire_date 
  from employees
  where manager_id = (select employee_id from employees 
                      where last_name='King' and first_name='Steven') ),
     tabel2 as -- al doilea selecteaza angajatii din primul tabel cu vechimea cea mai mare
 (select * 
 from tabel
 where hire_date = ( select min(hire_date) from tabel) )
-- ultima cerere face restul
select employee_id, last_name || ' ' || first_name, job_id, hire_date, manager_id, level
from employees
where to_char(hire_date,'yyyy') <> 1970                         -- <> e diferit
start with employee_id in (select employee_id from tabel2)
connect by prior employee_id=manager_id;


-- ex 21

select employee_id, salary
from (select employee_id, salary
      from employees
      order by salary desc)
where rownum < 11;


-- ex 22

select * from
 (select job_id, avg(salary)
  from employees
  group by job_id
  order by 2)
where rownum < 4;


-- ex 23

select 'departamentul ' || department_name || ' este condus de ' || departments.manager_id ||
  nvl(to_char(departments.manager_id),'nimeni') || ' si ' ||
case when count(employee_id) = 0 then 'nu are angajati'
     else 'are numarul de angajati ' || count(employee_id)
end "informatii"
from employees right join departments using (department_id)
group by department_id, department_name, departments.manager_id;


-- ex 24

select last_name, first_name, nullif(length(last_name),length(first_name)) lungime
from employees;


-- ex 25

select last_name, hire_date, salary, salary * decode(to_char(hire_date,'yyyy'),1989,1.2,1990,1.15,1991,1.1,1) "salariul marit"
from employees;


-- ex 26

with tabel_joburi as
 (select job_id, substr(lower(job_id),1,1) litera, sum(salary) suma, avg(salary) medie, min(salary) minim, max(salary) maxim
 from employees
group by job_id, substr(lower(job_id),1,1))
select job_id,
 case when litera='s' then suma
      when job_id= (select job_id from tabel_joburi where maxim = (select max(maxim) from tabel_joburi))
                      then (select avg(salary) from employees)
      else minim
      end "mixt"
from tabel_joburi;



drop table works_on;
drop table project;

create table PROJECT(
	project_id number(4) primary key, 
	project_name varchar2(30), 
	budget number(6), 
	start_date date, 
	deadline date,
	delivery_date date,
	project_manager number(4) references employees(employee_id)); 

create table WORKS_ON(
	project_id number(4) references project(project_id),
	employee_id number(6) references employees(employee_id),
	start_date date, 
	end_date date,
	primary key(project_id, employee_id));
	
insert into project values (1, 'ALFA', 20000, '2-JAN-2006', '30-MAR-2006', '7-APR-2006', 102);
insert into project values (2, 'BETA', 10000, '5-MAY-2006', '15-JUL-2006', '15-JUL-2006', 103); 
insert into project values (3, 'GAMA', 10000, '11-DEC-2006', '15-JAN-2007', '17-JAN-2007', 102); 

insert into works_on values(1, 125, '1-FEB-2006', '7-APR-2006');
insert into works_on values(1, 136, '2-JAN-2006', '30-MAR-2006');
insert into works_on values(1, 140, '15-FEB-2006', '7-APR-2006');
insert into works_on values(2, 145, '6-MAY-2006', '15-JUL-2006');
insert into works_on values(2, 125, '6-MAY-2006', '15-JUL-2006');
insert into works_on values(2, 101, '6-MAY-2006', '15-JUL-2006');
insert into works_on values(2, 148, '14-MAY-2006', '10-JUL-2006');
insert into works_on values(2, 200, '6-MAY-2006', '15-JUL-2006');
insert into works_on values(3, 145, '15-DEC-2007', '15-JAN-2007');
insert into works_on values(3, 148, '14-DEC-2006', '17-JAN-2007');
insert into works_on values(3, 150, '14-DEC-2006', '17-JAN-2007');
insert into works_on values(3, 162, '20-DEC-2006', '17-JAN-2007');
insert into works_on values(3, 101, '20-DEC-2006', '17-JAN-2007');
insert into works_on values(3, 176, '20-DEC-2006', '17-JAN-2007');
insert into works_on values(3, 200, '20-DEC-2006', '17-JAN-2007');
insert into works_on values(3, 140, '15-DEC-2006', '7-JAN-2007');

commit;


select &nr from dual;
select &date from dual;

select to_date('&date','dd-mm-yyyy') +3
from dual;


-- lab 6 ex 21a

undefine date1;
undefine date2;
select to_date('&date1','dd-mm-yyyy') + rownum
from employees
where to_date('&&date1','dd-mm-yyyy') + rownum <= to_date('&date2','dd-mm-yyyy');

undefine data1;
undefine data2;
select to_date('&&data1','dd-mm-yyyy')+rownum
from dual
where to_date('&&data1','dd-mm-yyyy') < to_date('&&data2','dd-mm-yyyy')
connect by prior to_date('&&data1','dd-mm-yyyy') = to_date('&&data1','dd-mm-yyyy') + rownum;




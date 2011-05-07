select * from employees;

-- LDD : create, alter, drop, truncate
-- Teoria DD 

--lab 8 , ex 26
insert into departamente_pnu(cod_dep,nume)
values(60,'Analiza');

commit;

--27
delete from departamente_pnu
where cod_dep=20; --nu se poate sterge deoarece sunt anajati care lucreaza acolo

--28
delete from departamente_pnu
where cod_dep=60; --deoarece nu avem angajati, se poate sterge

rollback;

desc angajati_pnu;


--29
insert into angajati_pnu(cod_ang,nume,email,cod_sef)
values(120,'lab223','email223',114);

insert into angajati_pnu(cod_ang,nume,email,cod_sef)
values(114,'nume','numeemail', 100);

--31
alter table angajati_pnu
drop constraint fk_cod_dep;

alter table angajati_pnu add constraint fk_cod_dep
foreign key(cod_dep) references departamente_pnu(cod_dep)
on delete cascade;

delete from departamente_pnu
where cod_dep=20; --acum va sterge

rollback;

--33
alter table departamente_pnu add constraint fk_cod_director foreign key(cod_director) references
angajati_pnu(cod_ang) on delete set null;

--34
update departamente_pnu
set cod_director=102
where cod_dep=30;

delete from angajati_pnu
where cod_ang=101; -- nu merge

rollback;

--35
alter table angajati_pnu
add constraint verifica_salariu check(salariu<30000);

update angajati_pnu
set salariu = salariu + 28000;

alter table angajati_pnu
modify constraint verifica_salariu enable ;

update angajati_pnu
set salariu = salariu + 28000;

rollback;

--coloana ok
--constrangere salariu<3000
--disable
--modific salariu < 3000
--enable -> NU (nu a functionat)
--rollback (se duce la randul 3)

--Laborator 9 - Tabele temporare
--1
create global temporary table temp_tranz
( x number(2) primary key)
on commit delete rows; --la nivel de sesiune

--nicio sesiune nu este asociata tabelului; i se asociaza cand fac insert
insert into temp_tranz values(3);

select * from temp_tranz;

commit;

create global temporary table temp_sesiune
( x number(2) primary key)
on commit preserve rows; --la nivel de sesiune

insert into temp_sesiune values(3);

select * from temp_sesiune;

drop table temp_sesiune;
truncate table temp_sesiune;
--5
create global temporary table angajati_azi_pnu
on commit preserve rows
as
select last_name, department_id, employee_id
from employees
where hire_date > to_date('01-01-2000','dd-mm-yyyy');

drop table angajati_azi_pnu;

--6
insert into angajati_azi_pnu
values('lab223', 500, 111);

--view

--lab 8, 23
SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE lower(table_name) IN ('angajati_pnu', 'departamente_pnu');

select * from tab;

--7
create or replace view viz_emp30
as select employee_id, last_name, email, salary 
from emp_pnu
where department_id = 30;

select * from viz_emp30;

select * 
from  (select employee_id, last_name, email, salary 
from emp_pnu
where department_id = 30);  --aici e view inline

desc viz_emp30;

insert into viz_emp30 
values(344, 'lab','email_lab',3000); --nu merge; insertul se face intr-un tabel, nu intr-o cerere; un vieweste o cerere

create or replace view viz_emp30
as select employee_id, last_name, email, salary ,hire_date, job_id
from emp_pnu
where department_id = 30;

insert into viz_emp30 
values(344, 'lab','email_lab',3000,sysdate,'programare');
--o conditie NECESARA sa pot efectua INSERT intr un VIEW este sa am toate coloanele not null
-- din tabelul de baza

--UPDATE: 
--vreau sa maresc salariul angajatului cu 205
update viz_emp30
set salary = salary + 30
where employee_id = 118 ; -- => pt 118 rez este 1, iar la 205 rez este 0; unul este in view ; 
--deci MODIFICA linii DOAR DIN VIEW ****

rollback;

--vreau sa modific departamentul
update viz_emp30
set department_id = 80
where employee_id = 118; -- nu merge
-- **** si doar coloane care exista in view; department_id nu apare ca si coloana in view

--DELETE - sterge linii din view;
delete viz_emp30
where employee_id = 205; -- 0 rows deleted

delete viz_emp30
where employee_id = 118; -- 1 rows deleted
rollback;

--9
create or replace view viz_emp50
as select employee_id, last_name, email, job_id, hire_date, salary*12 sal_anual
from emp_pnu
where department_id = 50; --orice coloana calculata trebe sa aiba nume => dupa salariu dau nume

--pe orice coloana "calculata" nu se pot efectua operatii LMD;

--vreau sa sterg pe toti care ausalariul anual mai mic ca 50000
delete from viz_emp50
where sal_anual < 50000;

rollback;




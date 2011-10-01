select * from employees;

select user from dual;

desc grupa42.departments;

update grupa42.departments
set department_id=department_id+150
where department_id=170;

select * from user_tables;

select * from all_objects 
where owner=user;


--1 a.
create table angajati_pnu (
cod_ang number(4),
nume varchar2(20),
prenume varchar2(20),
email char(15),
data_ang date,
job varchar2(10),
cod_sef number(4),
salariu number(8,2),
cod_dep number(2));

desc angajati_pnu; --describe

drop table angajati_pnu; --stergem tabelul pt ca nu e bun de nimic :D

insert into angajati_pnu(job)
values('etc');

--b
create table angajati_pnu (
cod_ang number(4) primary key,
nume varchar2(20) not null,
prenume varchar2(20),
email char(15),
data_ang date,
job varchar2(10),
cod_sef number(4),
salariu number(8,2) not null,
cod_dep number(2));

insert into angajati_pnu(cod_ang,nume,salariu)
values(10,'etc',3000);

--ii dam drop
create table angajati_pnu (
cod_ang number(4) constraint pk_cod_ang primary key,
nume varchar2(20) constraint nume_not_null not null,
prenume varchar2(20),
email char(15),
data_ang date,
job varchar2(10),
cod_sef number(4),
salariu number(8,2) constraint salariu_not_null not null,
cod_dep number(2));

--c
--drop
create table angajati_pnu (
cod_ang number(4) ,
nume varchar2(20) constraint nume_not_null not null,
prenume varchar2(20),
email char(15),
data_ang date default sysdate,
job varchar2(10),
cod_sef number(4),
salariu number(8,2) constraint salariu_not_null not null,
cod_dep number(2),
constraint pk_cod_ang primary key(cod_ang)  
);

insert into angajati_pnu(cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu, cod_dep)
values (100, 'Nume1','Prenume1',null,null,'Director',null,20000,10);

insert into angajati_pnu
values (101, 'Nume2','Prenume2','Nume2',to_date('02-02-2004', 'dd-mm-yyyy'),'Inginer',100,10000,10);

insert into angajati_pnu
values (102, 'Nume3','Prenume3','Nume3',to_date('05-06-2000', 'dd-mm-yyyy'),'Analist',101,5000,20);

insert into angajati_pnu
values (103, 'Nume4','Prenume4',null,null,'Inginer',100,9000,20);

insert into angajati_pnu(cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu, cod_dep)
values (104, 'Nume5','Prenume5','Nume5',null,'Analist',101,3000,30);

--3
create table angajati10_pnu
as select * from angajati_pnu where cod_dep=10;

desc angajati10_pnu; --se pierde cheia primara,deoarece a fost definita la nivel de tabel; cand copiez un tabel, copiez doar constrangeri 
--la nivel de coloana; cele la nivel de tabel nu se pastreaza

select * from angajati_pnu;

--4
alter table angajati_pnu
add (comision number(4,2));

--5
alter table angajati_pnu
modify (salariu number(6,2)); --nu se poate rezolva; dimensiune mai mica se poate doardaca tabelul este gol

--6.
alter table angajati_pnu
modify (salariu number(8,2) default 3000 );

--7
alter table angajati_pnu
modify (comision number(2,2), salariu number(10,2));

--8
update angajati_pnu
set comision = 0.1
where lower(job) like 'a%';

--9
--putem sa schimbam char la varchar daca nu micsoram dimensiunea
alter table angajati_pnu
modify (email varchar2(15));

--10
alter table angajati_pnu
add (nr_telefon varchar2(10) default '012345');

--11
select * from angajati_pnu;

alter table angajati_pnu
drop column nr_telefon;

--12
--ex de tabel din dictionarul datelor
desc tab;
select * from tab;

rename angajati_pnu to angajati3_pnu;

select * from tab; --o comanda ldd este vizibila in dictionarul datelor

--13
rename angajati3_pnu to angajati_pnu;

--14
truncate table angajati10_pnu;

rollback;

select * from angajati10_pnu;

--15
create table departamente_pnu
( cod_dep number(2),
nume varchar2(15) constraint not_null_nume_dep not null,
cod_director number(4));

--16
insert into departamente_pnu
values (10, 'Administrativ',100);

insert into departamente_pnu
values (20, 'Proiectare',101);

insert into departamente_pnu
values (30, 'Programare',null);

--17
alter table departamente_pnu
add constraint pk_cod_dep primary key(cod_dep);

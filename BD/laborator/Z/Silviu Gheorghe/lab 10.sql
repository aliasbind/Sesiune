select user from dual;
desc grupa42.departments;
update grupa42.departments
set department_id=department_id+150
where department_id=170;

select * from user_tables;

select * from all_objects
where owner=user;

--lab 8 problema 1
create table angajati_pnu
(cod_ang number(4) ,
nume varchar2(20) constraint nume_not_null not null,
prenume varchar2(20),
email char(15),
data_ang date default sysdate,
job varchar2(10),
cod_sef number(4),
salariu number(8,2) constraint salariu_not_null not null,
cod_dep number (2),
 constraint pk_cod_ang primary key(cod_ang));

desc angajati_pnu;
drop table angajati_pnu;

insert into angajati_pnu(cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu,cod_dep)
values(100,'nume1','prenume1',null,null,'director',null,2000,10);

insert into angajati_pnu(cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu,cod_dep)
values(101,'nume2','prenume2','nume2',to_date('02-02-2004','dd-mm-yyyy'),'inginer',100,1000,10);

insert into angajati_pnu(cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu,cod_dep)
values(102,'nume3','prenume3','nume3',to_date('05-06-2000','dd-mm-yyyy'),'analist',101,5000,20);

insert into angajati_pnu(cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu,cod_dep)
values(103,'nume4','prenume4',null,null,'inginer',100,9000,20);

insert into angajati_pnu(cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu,cod_dep)
values(104,'nume5','prenume5',null,null,'director',null,2000,10);


--lab 8 probl 3

create table angajati10_pnu
as select * from angajati_pnu
where cod_dep=10;

desc angajati10_pnu;

--lab 8 probl 4

alter table angajati_pnu
add (comision number(4,2));

--lab 8 probl 5

alter table angajati_pnu
modify (salariu number(6,2));

--lab 8 probl 6

alter table angajati_pnu
modify (salariu number (8,2) default 3000);

--lab 8 probl 7
alter table angajati_pnu
modify (comision number(2,2),salariu number(10,2));

--lab 8 probl 8

update angajati_pnu
set comision =0.1
where lower(job) like 'a&';

--lab 8 probl 9

alter table angajati_pnu
modify (email varchar2(15));

--lab 8 probl 10
alter table angajati_pnu
add (nr_telefon varchar2(10) default '012345');

--lab 8 probl 11

alter table angajati_pnu
drop column nr_telefon;

--lab 8 probl 12

desc tab;
select * from tab;

rename angajati3_pnu to angajati_pnu;

--lab 8 probl 14

truncate table angajati10_pnu;

rollback;

--lab 8 probl 16

create table departmente_pnu
(cod_dep number(2),
nume varchar2(15) constraint not_null_name_dep not null,
cod_director number(4));

insert into departmente_pnu
values (30,'Programare', null);


--lab 8 probl 17

alter table departamente_pnu
add constraint pk_cod_dep primary key(cod_dep);






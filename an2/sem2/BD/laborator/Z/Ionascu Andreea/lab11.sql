-- ex 1 lab 8 a
create table angajati_pnu
( cod_ang number(4),
  nume varchar2(20),
   prenume varchar2(20),
   email char(15),
   data_ang date,
   job varchar2(10),
   cod_sef number(4),
   salariu number(8,2),
   cod_dept number(2));
   
--sa vedem ce am creat
desc angajati_pnu;

--inserare total aiurea:D
insert into angajati_pnu(email)
values ( null );
--stergere, dar il avem in recycle bin
drop table angajati_pnu;

--sau
-- ex 1 lab 8 b
create table angajati_pnu
( cod_ang number(4) primary key,
  nume varchar2(20),
   prenume varchar2(20),
   email char(15),
   data_ang date,
   job varchar2(10),
   cod_sef number(4),
   salariu number(8,2) not null,
   cod_dept number(2));
   
--sa vedem ce am creat
desc angajati_pnu;

--inserare
insert into angajati_pnu(cod_ang,nume,salariu)
values ( 10,'nume1',2000);

--stergere, dar il avem in recycle bin
drop table angajati_pnu;

--ca o constrangere sa aiba un nume
create table angajati_pnu
( cod_ang number(4) constraint pk_cod_ang primary key,
  nume varchar2(20) constraint nume_not_null not null,
   prenume varchar2(20),
   email char(15),
   data_ang date,
   job varchar2(10),
   cod_sef number(4),
   salariu number(8,2) constraint salariu_not_null not null,
   cod_dept number(2));
   
--lab 8 ex 1 c
--default sysdate-> in mod default seteaza sysdate

create table angajati_pnu
( cod_ang number(4),
  nume varchar2(20) constraint nume_not_null not null,
   prenume varchar2(20),
   email char(15),
   data_ang date,
   job varchar2(10),
   cod_sef number(4),
   salariu number(8,2) constraint salariu_not_null not null,
   cod_dept number(2),
constraint pk_cod_ang primary key(cod_ang)   
   );
  
drop table angajati_pnu;

insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dept)
values ( 100, 'nume1','prenume1',null,null,'director',null,20000,10);

insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dept)
values ( 101, 'nume2','prenume2','nume2',to_date('02-02-2004','dd-mm-yyyy'),'inginer',100,10000,10);

insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dept)
values ( 102, 'nume3','prenume3','nume3',to_date('05-06-2000','dd-mm-yyyy'),'analist',101,5000,20);


insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dept)
values ( 103, 'nume4','prenume4',null,null,'inginer',100,9000,20);

insert into angajati_pnu 
--(cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dept)
values ( 104, 'nume5','prenume5','nume5',null,'analist',101,3000,30);

--ex 3 facem o copie 
create table angajati10_pnu
as select * from angajati_pnu
where cod_dept=10;
--nu am cheia primara, deoarece a fost definita la nivel de tabel
desc angajati10_pnu;

desc user_tables;

select * from user_tables;

select * from all_tables;

--in schema utilizatorilor
desc tab;
select * from  tab;

--constrangerile pe care le avem
desc USER_CONSTRAINTS;
select * from USER_CONSTRAINTS;
--R foreign chei

--constrangerile despre coloane
desc USER_CONS_COLUMNS;
select * from USER_CONS_COLUMNS;

--ex4
ALTER TABLE angajati_pnu
add (comision number(4,2));

--ex 5 nu pt ca trebuie sa ii miscoram dimensiunea si avem date

--ex6
--seta, default 3000
alter table angajati_pnu
modify (salariu number ( 8,2 ) default 3000);

--ex 7
alter table angajati_pnu
modify (comision number (2,2),salariu number ( 10,2 ));

--ex8
update angajati_pnu
set comision=0.1
where lower(job) like 'a%';

--ex 9
--pt 12 nu se poate, pt 15 da
alter table angajati_pnu
modify (email varchar2(15));

--ex10
--intai adaugam
alter table angajati_pnu
add(nr_tel varchar2(10) default '0123456');

--stergem
alter table angajati_pnu
drop column nr_tel;
--ce rol ar avea...nici unul

select *from tab;

rename angajati_pnu to angajati3_pnu;

rename angajati3_pnu to angajati_pnu;

truncate table angajati10_pnu;

--ex15
create table departamente_pnu
( cod_dep number(2),-- constraint dk_cod_dep primary key,
  nume varchar2(15) constraint nue_not_null not null,
  cod_director number(4));

drop table departamente_pnu;

insert into departamente_pnu
values(10,'Administrativ',100);
insert into departamente_pnu
 values(20,'Proiectare',101);
 insert into departamente_pnu
 values(30,'Programare',null);
 
-- ??? 
 alter table departamente_pnu
 add constraint pk_cod_dep primary key(cod_dep);
 

 
 desc departamente_pnu;
 
 --18
 --a
 alter table angajati_pnu
 add constraint fk_cod_dept foreign key (cod_dept)
 references departamente_pnu(cod_dep);
 
 insert into angajati_pnu(cod_ang,nume,salariu,cod_dept)
 values(110,'nume7',3000,50);
 
 rollback;
 
 --b
 
 create table angajati_pnu
( cod_ang number(4) constraint fk_cod_ang primary key,
  nume varchar2(20) constraint fk_nume_not_null not null,
  prenume varchar2(20),
  email char(15) constraint unic_email unique,
  data_ang date,
  job varchar2(10),
  cod_sef number(4) ,
  salariu number(8,2),
  cod_dep number(2) constraint min_cod_dep check(cod_dep>0), 
  comision number(2,2),
  constraint unic_nume_prenume unique(nume,prenume),
  constraint salariu_comision check (salariu>100*comision),
  constraint fk_cod_sef foreign key (cod_sef) references
          angajati_pnu(cod_ang)
   );
--unique nume+prenume-se pune doar la tabel  
drop table angajati_pnu;

--ex19->toate la nivel de tabel
 create table angajati_pnu
( cod_ang number(4) ,
  nume varchar2(20) constraint fk_nume_not_null not null,--nu poate fi mutata
  prenume varchar2(20),
  email char(15) ,
  data_ang date,
  job varchar2(10),
  cod_sef number(4) ,
  salariu number(8,2),
  cod_dep number(2) , 
  comision number(2,2),
  
  constraint unic_nume_prenume unique(nume,prenume),
  constraint salariu_comision check (salariu>100*comision),
  constraint fk_cod_sef foreign key (cod_sef) references
          angajati_pnu(cod_ang),
  constraint fk_cod_ang primary key (cod_ang),
  constraint unic_email unique (email),
  constraint min_cod_dep check(cod_dep>0),
  constraint fk_cod_dep foreign key(cod_dep)
   references departamente_pnu(cod_dep)
   --un angajat poate fi fie cu departamentul null sau cu unul care apare in department
   );
   
drop tabel departamente_pnu;
--nu pot sa sterg departamentele care au angajati pentru ca au angaajti
drop table angajati_pnu;
   
alter table angajati_pnu
drop constraint fk_cod_dep;

alter table angajati_pnu
add constraint fk_cod_dep foreign key(cod_dep)
references departamente_pnu(cod_dep) on delete set null;

delete from departamente_pnu
where cod_dep=20;

insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dep,comision)
values ( 100, 'nume1','prenume1',null,null,'director',null,20000,10,null);

insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dep,comision)
values ( 101, 'nume2','prenume2','nume2',to_date('02-02-2004','dd-mm-yyyy'),'inginer',100,10000,10,null);

insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dep,comision)
values ( 102, 'nume3','prenume3','nume3',to_date('05-06-2000','dd-mm-yyyy'),'analist',101,5000,20,0.1);

insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dep,comision)
values ( 103, 'nume4','prenume4',null,null,'inginer',100,9000,20,null);

insert into angajati_pnu 
--(cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dep,comision)
values ( 104, 'nume5','prenume5','nume5',null,'analist',101,3000,30,0.1);

--mai putem
--insert into
--(select cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,comision,cod_dep
--from angajati_pnu)
--values ....; daca le am intr-o ordine gresita

--ex 20
--exercitiu
--tabelul first care are a number(2),b,d);
--cum facem sa calculam un alt tabel first ( a, b, c, d)
drop table first;
create table first
( a number(2),
  b varchar2(10),
  d date
);

insert into first values (1,'unu',sysdate);
insert into first values (2,'doi',sysdate);

select * from first;
create table first_aux 
as select* from first;

drop table first;
create table first
as select a , b, a as c, d
from first_aux;

desc first;

--avem tabel1 - are nr impare, tabel 2 - nr pare
--din el tabel12 care contine toate liniile in ordine descrescatoare

create table tabel1
{a number(10)
};

create table tabel2
{b number(10)
};

insert into tabel1 values(5);
insert into tabel1 values(11);
insert into tabel1 values(13);

insert into tabel1 values(2);
insert into tabel1 values(4);
insert into tabel1 values(12);

--ramas la 21
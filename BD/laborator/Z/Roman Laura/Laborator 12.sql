select * from employees;

--18 a
alter table angajati_pnu 
add constraint fk_cod_dep foreign key (cod_dep) 
references departamente_pnu(cod_dep);

--b
desc angajati_pnu;

drop table angajati_pnu;

create table angajati_pnu
( cod_ang number(4) constraint pk_cod primary key,
nume varchar2(20) constraint nume_not_null not null,
prenume varchar2(20),
email varchar2(15) constraint unique_email unique,
data_ang date,
job varchar2(10),
cod_sef number(4),
salariu number(10,2),
cod_dep number(2) constraint ck_cod_dep check(cod_dep>0),
comision number(2,2),
constraint unique_nume_prenume unique(nume,prenume),
constraint fk_sef2 foreign key(cod_sef) references angajati_pnu(cod_ang),
constraint fk_cod_dep foreign key(cod_dep) references departamente_pnu(cod_dep),
constraint ck_salariu check(salariu>100*comision)
);

--foreign key si combinatii de coloana se trec la nivel de tabel
--19
create table angajati_pnu
( cod_ang number(4) ,
nume varchar2(20) constraint nume_not_null not null,
prenume varchar2(20),
email varchar2(15) ,
data_ang date,
job varchar2(10),
cod_sef number(4),
salariu number(10,2),
cod_dep number(2) ,
comision number(2,2),
constraint unique_nume_prenume unique(nume,prenume),
constraint fk_sef2 foreign key(cod_sef) references angajati_pnu(cod_ang),
constraint fk_cod_dep foreign key(cod_dep) references departamente_pnu(cod_dep),
constraint ck_salariu check(salariu>100*comision),
constraint pk_cod primary key(cod_ang),
constraint unique_email unique(email),
constraint ck_cod_dep check(cod_dep>0)
);

insert into angajati_pnu(cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu, cod_dep,comision)
values (100, 'Nume1','Prenume1',null,null,'Director',null,20000,10,null);

insert into angajati_pnu
values (101, 'Nume2','Prenume2','Nume2',to_date('02-02-2004', 'dd-mm-yyyy'),'Inginer',100,10000,10,null);

insert into angajati_pnu
values (102, 'Nume3','Prenume3','Nume3',to_date('05-06-2000', 'dd-mm-yyyy'),'Analist',101,5000,20,0.1);

insert into angajati_pnu
values (103, 'Nume4','Prenume4',null,null,'Inginer',100,9000,20,null);

insert into angajati_pnu(cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu, cod_dep,comision)
values (104, 'Nume5','Prenume5','Nume5',null,'Analist',101,3000,30,0.1);

--21
delete from departamente_pnu; --nu se poate -> constrangerea de foreign key

--22
select * from user_tables; --apar tabelele din stanga

select * from tab; --apar si alea din recycle bin

select * from user_constraints; --cine detine, cum se numeste constrangerea,tipul ei etc

--24
alter table angajati_pnu
modify (email varchar2(15) not null);  --am null prin tabel => fac mai intai vezi mai jos
--add constraint email_not_null email not null;  --not null doar la nivel de coloana

update angajati_pnu
set email=nume||'@gmail.com'
where email is null;

--acuma nu mai am null in tabel si pot sa fac cererea


--25
insert into angajati_pnu(cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu, cod_dep,comision)
values (110, 'Nume10','Prenume3','Nume320',null,'Analist',101,3000,50,0.1); --nu merge
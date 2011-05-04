-- lab 8 probl 18
alter table angajati_pnu
add constraint fk_cod_dep foreign key (cod_dep)
references departamente_pnu(cod_dep);

desc anagajati_pnu;
drop table angajati_pnu;

alter table departmente_pnu add primary key(cod_dep);

create table angajati_pnu
(cod_ang number(4) ,
nume varchar2(20) constraint nume_not_null not null,
prenume varchar2(20),
email varchar2(15),
data_ang date,
job varchar2(10),
cod_sef number(4),
salariu number(10,2),
cod_dep number(2),
comision number(2,2),
constraint unique_name_prenume unique (nume,prenume),
constraint fk_sef2 foreign key(cod_sef) references
angajati_pnu(cod_ang),
constraint fk_cod_dep foreign key(cod_dep) references
departmente_pnu(cod_dep),
constraint ck_salariu check(salariu>100*comision),
constraint pk_cod_ang primary key(cod_ang),
constraint unique_email unique(email),
constraint ck_cod_dep check(cod_dep>0)
);

-- lab 8 probl 21

delete from departmente_pnu;

--lab 8 probl 22
select * from user_tables;

select * from tab;

select * from user_constraints;

alter table angajati_pnu
modify (email varcahr2(15) not null);

update angajati_pnu
set email = nume || '@gmail.com'
where email is null;

-- lab 8 probl 25
insert into angajati_pnu
values(102,'nume3','prenume3','nume3',to_date('05-06-2000','dd-mm-yyyy'),'analist',101,5000,50,0.1);

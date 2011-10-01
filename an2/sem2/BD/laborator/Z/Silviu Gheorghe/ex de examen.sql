create table companie
(cod number(4) constraint pk_cod primary key,
denumire varchar(2) constraint dep_not_null not null,
capital number(4) constraint capital_cs check(capital>1000),
proprietar varchar(20));

create table statie
(cod_statie number(4) constraint pk_cod_statie primary key,
denumire varchar(20) constraint dep_statie_not_null not null,
nr_angajati number(4) constraint numar_ang check(nr_angajati>0),
cod_companie number(4),
capacitate number(4) constraint cap_not_null check(capacitate>0),
constraint fk_cod_comp foreign key (cod_companie) references companie(cod));

create table produs
(cod_produs number(4) constraint pk_cod_pr primary key,
denumire varchar(20) constraint den_prod_not_null not null,
pret_vanzare number(4) constraint pret_vanz_not_null check(pret_vanzare>0));

create table achizitie
(cod_st number(4) not null,
cod_prod number(4) not null,
data_achizitie date not null,
cantitate number(4) constraint cant_not_null check(cantitate>0),
pret_achizitie number(4) constraint pret_not_null check(pret_achizitie>0),
constraint fk_cod_st foreign key (cod_st) references statie(cod_statie),
constraint fk_cod_prod foreign key(cod_prod) references produs(cod_produs),
constraint pk_achizitie primary key (cod_st,cod_prod,data_achizitie));

alter table statie
add(oras varchar(50) not null);

select sum(nr_angajati)
from statie
where cod_statie in (select cod_statie 
  from statie join achizitie on(cod_statie=cod_st)
  group by cod_statie
  having count (distinct cod_prod)>4);
  
  

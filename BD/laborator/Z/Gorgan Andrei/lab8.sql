// 1.

create table achizitie
(
    cod_st         number(9) not null,
    cod_prod       number(9) not null,
    data_achizitie date not null,
    cantitate      number(9) constraint c_cont check (cantitate > 0),
    pret_achizitie number(20) constraint c_pr_ac check (pret_achizitie > 0),
    constraint pk_achizitie  primary key(cod_st, cod_prod, data_achizitie),
    constraint fk_codst      foreign key(cod_st)   references statie(cod_statie),
    constraint fk_codprod    foreign key(cod_prod) references produs(cod_produs)  
);

create table statie
(
    cod_statie     number(9) primary key,
    denumire       varchar2(255) not null,
    nr_angajati    number(5) constraint nr_not_negative check (nr_angajati>=0),
    cod_companie   number(9),
    capacitate     number(9) constraint c_capacitate check(capacitate>=0),
    constraint fk_codcomp foreign key(cod_companie) references companie(cod)
);

create table produs
(
    cod_produs     number(9) primary key,
    denumire       varchar2(255) not null,
    pret_vanzare   number(20) constraint c_pv check(pret_vanzare > 0)
);

create table companie
(
    cod            number(9) primary key,
    denumire       varchar2(255) not null,
    capital        number(9) constraint bigger_than_1000 check(capital>1000),
    proprietar     varchar2(255)
);

drop table achizitie;
drop table statie;
drop table companie;
drop table produs;

alter table statie
add (oras varchar2(255) NOT NULL);

// 2.
select sum(nr_angajati)
from statie
where cod_statie in (select cod_st
                     from achizitie
                     group by cod_st
                     having (count(distinct cod_prod) > 4));

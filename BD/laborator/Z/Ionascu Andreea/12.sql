-- lab 8
-- ex 26

insert into departamente_pnu (cod_dep, nume)
vakues (60, 'Analiza');

commit;

-- ex 27

delete from departamente_pnu
where cod_dep = 20;
-- nu am dep 20, dar daca am avea angajati da eroare de cheie externa

-- ex 28

delete from departamente_pnu
where cod_dep = 60;

rollback;

-- ex 29

insert into angajati_pnu (cod_ang, nume, email, cod_sef)
values (120,'lab223','email223',114);

-- da eroare fiindca 114 nu exista ca si angajat
-- varianta corecta e cea de mai jos

-- ex 30

insert into angajati_pnu (cod_ang, nume, email, cod_sef)
values (114,'lab223','email223',100);

insert into angajati_pnu (cod_ang, nume, email, cod_sef)
values (120,'lab223','email223',114);

-- ex 31

alter table angajati_pnu
drop constraint fk_cod_dep;

alter table angajati_pnu
add constraint fk_cod_dep
foreign key (cod_dep) references departamente_pnu (cod_dep)
on delete cascade;

-- ex 32

delete from departamente_pnu
where cod_dep = 20;

rollback;

-- ex 33

alter table departamente_pnu
add constraint fk_cod_director foreign key (cod_director) references angajati_pnu(cod_ang)
on delete set null;

-- ex 34

update departamente_pnu
set cod_director=102
where cod_dep = 20;

delete from angajati_pnu
where cod_ang = 102;
-- nu merge fiindca angajatul cu codul 102 poate avea subalterni si nu e specificat ce sa faca la delete
-- ar trebui schimbat cu on delete set null

rollback;

delete from angajati_pnu
where cod_ang = 101;


-- ex 35, 36, 37 - daca facem disable si enable tot nu merge fiindca cand facem enable verifica toate datele sa respecte
-- constrangerea activata

alter table angajati_pnu
add constraint verifica_salariu check (salariu<30000);

--36

update angajati_pnu
set salariu=salariu+28000;

-- e prea mare, da eroare

-- 37

alter table angajati_pnu
modify constraint verifica_salariu disable;

-- orice comanda ldd are commit in ea (createm akterm drop, truncate) => rollback nu merge dupa ele


-- lab 9

-- ex 1

create global temporary table temp_tranz
(x number(2) primary key)
on commit delete rows;

-- tabel temporar - exista in cadrul altei sesiuni, insa e gol in sesiunea respectiva

insert into temp_tranz values (3);

select * from temp_tranz;

commit;


-- ex 2

create global temporary table temp_sesiune
(x number(2) primary key)
on commit preserve rows;

insert into temp_sesiune values (3);

select * from temp_sesiune;

commit;

truncate table temp_sesiune;

drop table temp_sesiune;


-- ex 5

create global temporary table angajati_azi_pnu
on commit preserve rows
as select last_name, department_id, employee_id
from employees
where hire_date > to_date('01-01-2000','dd-mm-yyyy');


-- ex 6

insert into angajati_azi_pnu
values ('lab223', 500, 111);

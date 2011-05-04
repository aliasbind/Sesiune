-- lab 8 -> pb 26
--
insert into departamente_pnu(cod_dep,nume)
values (60,'Analiza');

commit;
-- 27
delete from departamente_pnu
where cod_dep=20; --nu am dep 20, dar daca am angaajti da eroare de cheie externa
--28
delete from departamente_pnu
where cod_dep=60;

rollback;
--29
insert into angajati_pnu(cod_ang,nume,email,cod_sef)
values (120,'lab223','email1223',114); --tre sa introducem seful 114
--30
insert into angajati_pnu(cod_ang,nume,email,cod_sef)
values (114,'lab224','email1224',100);

--31 tre sa sterg constrangere fk_cod_dep
alter table angajati_pnu
drop constraint fk_cod_dep;

--si adaugare constrangere cu stergere in cascada
alter table angajati_pnu
add constraint fk_cod_dep
foreign key(cod_dep) references departamente_pnu(cod_dep)
on delete cascade;

--32
delete from departamente_pnu
where cod_dep=30;

rollback;

--33
alter table departamente_pnu add constraint
fk_cod_director foreign key(cod_director) references
angajati_pnu(cod_ang)
on delete set null;

--34
update departamente_pnu
set cod_director=102
where cod_dep=30;

delete from angajati_pnu
where cod_ang=102;

rollback;

--pt 101 nu merge
update departamente_pnu
set cod_director=101
where cod_dep=30;

--35 doar daca constrangerea verifica coloana

alter table angajati_pnu
add constraint verifica_salariu check(salariu<30000);

--36+37-- e prea mare-am facut update
update angajati_pnu
set salariu=salariu+28000;

alter table angajati_pnu
modify constraint verifica_salariu disable;

update angajati_pnu
set salariu=salariu+28000;

alter table angajati_pnu
modify constraint verifica_salariu enable;

rollback;--nu merge sa modific salariile pt ca inainte de alter table da commit(inainte de enable

--lab 9 ex1
create global temporary table TEMP_TRANZ
(x number(2) primary key
)
on commit delete rows;
--nu avem nici o sesiune tabelului, incepe cand se face un insert

insert into temp_tranz values(3);
-- daca mai deschid un sql developer va aparea tabelul, dar nu vor aparea datele din cel de aici
select * from temp_tranz;

commit;

--2
create global temporary table TEMP_sesiune
(x number(2) primary key
)
on commit preserve rows;

insert into temp_sesiune values(3);

select * from temp_sesiune;

commit;

--ca sa stergem

drop table temp_sesiune;

--
truncate table temp_sesiune;

rollback;

--5
create global temporary table angajati_azi_pnu
on commit preserve rows
as
from employees
where hire_date>to_date('01-01-2000','dd-mm-yyyy')
;
--nu s-a copiat constrangerea de cheie primara pt ca era la nivel de tabel

insert into angajati_azi_pnu
values('lab223',500,111)--joc rolul secretarei visatoare, nu stie ca nu exista dep 500

--drop table angajati_azi_pnu;


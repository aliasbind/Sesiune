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
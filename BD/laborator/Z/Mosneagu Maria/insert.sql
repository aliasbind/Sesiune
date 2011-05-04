insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dept)
values ( 100, 'nume1','prenume1',null,null,'director',null,20000,10);

insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dept)
values ( 101, 'nume2','prenume2','nume2',to_date('02-02-2004','dd-mm-yyyy'),'inginer',100,10000,10);

insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dept)
values ( 102, 'nume3','prenume3','nume3',to_date('05-06-2000','dd-mm-yyyy'),'analist',101,5000,20);


insert into angajati_pnu (cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dept)
values ( 103, 'nume4','prenume4',null,null,'inginer',100,9000,20);

insert into angajati_pnu 
--(cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dept) -- putem sa nu mai punem si unde
values ( 104, 'nume5','prenume5','nume5',null,'analist',101,3000,30);
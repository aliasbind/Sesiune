-- lab 6 ex 21a - CORECT!! -- fara zile lucratoare

undefine data1;
undefine data2;
with tabel as
( select to_date('&&data1','dd-mm-yyyy')+rownum zile
  from dual
  connect by rownum < to_date('&&data2','dd-mm-yyyy') - to_date('&&data1','dd-mm-yyyy') )
select zile 
from tabel
where to_char(zile,'d')  not in (6,7);


-- lab 6 ex 1

select project_id
from project
where start_date > to_date('01-01-2006','dd-mm-yyyy') 
  and start_date < to_date('30-06-2006','dd-mm-yyyy');

select project_id
from works_on join project using (project_id)
where project.start_date > to_date('01-01-2006','dd-mm-yyyy') 
  and project.start_date < to_date('30-06-2006','dd-mm-yyyy');

select distinct employee_id
from works_on w
where
  (select count(project_id)
   from works_on join project using (project_id)
   where project.start_date > to_date('01-01-2006','dd-mm-yyyy') 
     and project.start_date < to_date('30-06-2006','dd-mm-yyyy')
     and employee_id = w.employee_id) = 
  (select count(project_id)
   from project
   where start_date > to_date('01-01-2006','dd-mm-yyyy') 
     and start_date < to_date('30-06-2006','dd-mm-yyyy'));

-- sau

select distinct employee_id
from works_on w
where not exists
(select project_id
 from project
 where start_date > to_date('01-01-2006','dd-mm-yyyy') 
   and start_date < to_date('30-06-2006','dd-mm-yyyy')
 minus
 select project_id
 from works_on
 where employee_id = w.employee_id);

-- sau - nu exista proiect la care angajatul sa nu fi lucrat

select distinct employee_id
from works_on w
where not exists
(select project_id
 from project p
 where start_date > to_date('01-01-2006','dd-mm-yyyy') 
   and start_date < to_date('30-06-2006','dd-mm-yyyy')

and not exists
(select employee_id
 from works_on
 where project_id = p.project_id and employee_id = w.employee_id));


-- sau - toti angajatii lucreaza pe toate proiectele

select distinct employee_id
from works_on
where employee_id not in
  ( select employee_id
    from
    ( select employee_id, project_id
      from ( select distinct employee_id from works_on),
        ( select project_id
          from project
          where start_date > to_date('01-01-2006','dd-mm-yyyy') 
            and start_date < to_date('30-06-2006','dd-mm-yyyy'))
      minus
      select employee_id, project_id
      from works_on
  ));


-- ex 2


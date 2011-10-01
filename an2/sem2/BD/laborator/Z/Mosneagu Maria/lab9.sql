--lab6 ex 21 -- merge

undefine date1;
undefine date2;
select to_date('&date1','dd-mm-yyyy') + rownum --sau level in loc de rownum
from dual
connect by rownum < to_date('&date2','dd-mm-yyyy')- to_date('&date1','dd-mm-yyyy')+ rownum ;

--doar zilele lucratoare
undefine date1;
undefine date2;
with tabel as
   (select to_date('&date1','dd-mm-yyyy') + rownum zile--sau level in loc de rownum
    from dual
    connect by rownum < to_date('&date2','dd-mm-yyyy')- to_date('&date1','dd-mm-yyyy'))
SELECT zile from tabel 
where to_char(zile,'d') not in ( 7, 1 );

--S? se listeze informatii despre angajatii care au lucrat în toate proiectele demarate în primele 6 luni
--ale anului 2006. Implementati toate variantele.

--varianta 1

  SELECT distinct employee_id
  from works_on w
  where(
        SELECT count(project_id)
        from works_on join project using(project_id)
        where project.start_date>to_date('01-01-2006','dd-mm-yyyy') and 
               project.start_date<to_date('30-06-2006','dd-mm-yyyy') and
               employee_id=w.employee_id) = 
                        (select count (project_id)
                         from project
                         where start_date>to_date('01-01-2006','dd-mm-yyyy') and 
                         project.start_date<to_date('30-06-2006','dd-mm-yyyy'));
                         
--varianta 2
 SELECT distinct employee_id
 from works_on x
 where not exists
           (select project_id
            from project
            where start_date>to_date('01-01-2006','dd-mm-yyyy') and 
            start_date<to_date('30-06-2006','dd-mm-yyyy')
            minus
            select project_id
            from works_on
            where employee_id=x.employee_id            
            );
            
--varianta 3
--nu exista proiect la care angajatul nostru sa nu fi lucrat
SELECT distinct employee_id
from works_on w
where not exists
    (select project_id --nu exista proiect demarat in primele sase luni
     from project p
     where start_date>to_date('01-01-2006','dd-mm-yyyy') and 
    start_date<to_date('30-06-2006','dd-mm-yyyy')
     and not exists --pentru care nu am o linie
       (select employee_id
        from works_on
        where project_id=p.project_id and employee_id=w.employee_id
        
       )
     );
     
--varianta 4
--toti angajatii lucreaza pe toate proiectele

select distinct employee_id
from works_on
where employee_id not in( 
       select employee_id from (
              select employee_id, project_id
              from (select distinct employee_id from works_on),             
                    (select project_id 
                    from project
                     where start_date>to_date('01-01-2006','dd-mm-yyyy') and
                           start_date<to_date('30-06-2006','dd-mm-yyyy'))
--imi raman acele linii care sunt false
              minus 
                    select employee_id,project_id
                    from works_on));
       
--2.S? se listeze informatii despre proiectele la care au participat toti angajatii care au detinut alte 2
--posturi în firm?.
select project_id
from project p
where not exists 
        (select employee_id
         from job_history j
         group by employee_id
         having count(distinct job_id)>1 --pt ca numaram functia si nu postul
         and not exists
                (select project_id
                from works_on
                 where employee_id=j.employee_id and 
                        project_id=p.project_id));
                        
--3. S? se obtin? num?rul de angajati care au avut cel putin trei job-uri, luându-se în considerare si job-ul
--curent.
--tinem cont de faptul ca joburile sunt distincte? sau nu?
--tinem cont

select count(count(employee_id)) numar--pt ca un singur count numara nr de joburi
from (
      select employee_id,job_id
      from employees
      union 
      select employee_id,job_id
      from job_history)
group by employee_id
having count(job_id)>2;

--4. Pentru fiecare tar?, s? se afiseze num?rul de angajati din cadrul acesteia.
select country_id,count(employee_id)
from countries left join  locations using (country_id) left join departments using (location_id)
      left join employees using (department_id)
group by country_id;

--5. S? se listeze angajatii (codul si numele acestora) care au lucrat pe cel putin dou? proiecte nelivrate
--la termen.
--delivery_date>deadline
select employee_id
from employees join works_on using (employee_id) join project using (project_id)
where deadline<delivery_date
group by employee_id
having count(project_id)>1;

--6. S? se listeze codurile angajatilor si codurile proiectelor pe care au lucrat. Listarea va cuprinde si
--angajatii care nu au lucrat pe nici un proiect.
select employee_id,project_id
from employees left join works_on using (employee_id)
order by 1;

--7. S? se afiseze angajatii care lucreaz? în acelasi departament cu cel putin un manager de proiect.
select employee_id,department_id
from employees
where department_id in (
--departmentele cu project_maanger
         select department_id
         from employees join project on (employee_id=project_manager))
order by 2;
--8. S? se afiseze angajatii care nu lucreaz? în acelasi departament cu nici un manager de proiect.
select employee_id,department_id
from employees
where department_id not in (
--departmentele cu project_maanger
         select department_id
         from employees join project on (employee_id=project_manager))
order by 2;

--9. S? se determine departamentele având media salariilor mai mare decît un num?r dat.
select department_id,avg(salary)
from employees
group by department_id
having  avg(salary)>&val;

--10. Se cer informatii (nume, prenume, salariu, num?r proiecte) despre managerii de proiect care au
--condus 2 proiecte.

--acei proiect_managerii care au condus 2 proiecte
with manager as
(   select project_manager, count(project_id) nr
    from project
    group by project_manager
    having count(project_id)=2 --nu merge nr=2
)

SELECT last_name, first_name, salary, nr
from employees join manager on (employee_id=project_manager);

--11. S? se afiseze lista angajatilor care au lucrat numai pe proiecte conduse de managerul de proiect
--având codul 102.

--cun proiecte
select distinct employee_id
from works_on x
where not exists
     (select project_id
      from works_on
      where employee_id=x.employee_id
      minus
      select project_id
      from project
      where project_manager=102);
      
--12. a) S? se obtin? numele angajatilor care au lucrat cel putin pe aceleasi proiecte ca si angajatul
--având codul 200.
--b) S? se obtin? numele angajatilor care au lucrat cel mult pe aceleasi proiecte ca si angajatul având
--codul 200.
--nu mai merge cu count, sau e foarte complicat
--a
select distinct employee_id
from works_on x
where not exists
     (select project_id
      from works_on
      where employee_id=200
      minus
      select project_id
      from works_on
      where employee_id=x.employee_id);
      
--b
select distinct employee_id
from works_on x
where not exists
     (select project_id
      from works_on
      where employee_id=x.employee_id
      minus 
      select project_id
      from works_on
      where employee_id=200);
      
--13. S? se obtin? angajatii care au lucrat pe aceleasi proiecte ca si angajatul având codul 200.
select distinct employee_id
from works_on x
where not exists
     (select project_id
      from works_on
      where employee_id=x.employee_id
      minus 
      select project_id
      from works_on
      where employee_id=200) 
      
      and not exists 
      
      (select project_id
      from works_on
      where employee_id=200
      minus
      select project_id
      from works_on
      where employee_id=x.employee_id);
      
--14. Modelul HR contine un tabel numit JOB_GRADES, care contine grilele de salarizare ale companiei.
--a) Afisati structura si continutul acestui tabel.
--b) Pentru fiecare angajat, afisati numele, prenumele, salariul si grila de salarizare corespunz?toare.
--Ce operatie are loc între tabelele din interogare?

--b
select last_name,first_name, salary, grade_level
from employees,job_grades
where salary between lowest_sal and highest_sal;

--16.Sa se afiseze numele, codul departamentului si salariul anual pentru toti angajatii care au un anumit
--job.
define;
DEFINE JOB;--daca este definita afiseaza
define job='IT_PROG';
select last_name,department_id,salary*12
from employees
where job_id='&job';
undefine job;
--cu accept
define;
define job;
accept job prompt "dati job-ul";
select last_name,department_id,salary*12
from employees
where job_id='&job';
undefine job;
--dupa ce rulam o data are definita variabila daca nu dam undefine
define;
define job;
select last_name,department_id,salary*12
from employees
where job_id='&&job';

--18. Sa se afiseze o coloana aleasa de utilizator, dintr-un tabel ales de utilizator, ordonand dupa aceeasi
--coloana care se afiseaza. De asemenea, este obligatorie precizarea unei conditii WHERE.

SELECT &&col
from &tabel
where &conditie
order by &col;

--17. Sa se afiseze numele, codul departamentului si salariul anual pentru toti angajatii care au fost
--angajati dupa o anumita data calendaristica.
select last_name,first_name, department_id, salary,hire_date
from employees
where hire_date>to_date('&date','dd-mm-yyyy')
order by 5;

--19. S? se realizeze un script prin care s? se afiseze numele, job-ul si data angaj?rii salariatilor care
--au început lucrul între 2 date calendaristice introduse de utilizator. S? se concateneze numele
--si job-ul, separate prin spatiu si virgul?, si s? se eticheteze coloana "Angajati".
--Se vor folosi comanda ACCEPT si formatul pentru data calendaristica MM/DD/YY.

accept data1 from prompt "dati data1=";
accept data2 from prompt "dati data2=";
select last_name,first_name,job_id,hire_date
from employees
where hire_date between to_date('&data1','mm-dd-yyyy') and to_date('&data2','mm-dd-yyyy');
describe jobs;
select *from jobs;
select employee_id "cod angajat", salary "salariu", hire_date from employees;
select department_id from employees;
select employee_id, first_name || ' ' || last_name where salary>5000from employees;
select employee_id, salary  from employees where salary>5000;
--ang care au salariul >5000 si lucreaza in dep 80
select employee_id,salary from employees where salary>5000 and department_id=80;
-- and care sunt condusi de 100 si lucreaza in dep 30 sau 50
select employee_id,department_id,manager_id 
   from employees 
      where manager_id=100 and (department_id=30 or department_id=50);
--sa se af ang care lucreaza in unul din 30,40,50,60 (cod si dep)
select employee_id,department_id
   from employees
      where department_id in(30,40,50,60);
--cod pt ang care nu castiga comision      
select employee_id
  from employees
       where commission_pct is null;
select employee_id
  from employees
       where nvl(commission_pct,0) < 0.20;
select employee_id, hire_date, round(sysdate - hire_date,2), round((sysdate-hire_date)/7,2), 
       round(months_between(sysdate,hire_date),2) "luni lucrate", from employees; 
select employee_id, hire_date,round((sysdate-hire_date)/7,2) nr_sapt,to_char(hire_date,'day') "ziua angajarii",
       round((sysdate-hire_date)/7)+decode(to_char(hire_date,'day'),'wednesday',1,0) 
       "zile miercuri" from employees;
select employee_id, salary,hire_date from employees where mod(round(sysdate-hire_date),7)=0;
select employee_id,first_name||last_name ,hire_date, salary*1.25 , next_day(add_months(hire_date,3),'monday') from employees;
select employee_id, hire_date, manager_id, department_id, phone_number,job_id
       case when department_id=30 then salary
            when lower('job_id')='it_prog' then phone_number
            when manager_id=100 then department_id
       else last_name end "diverse"
       from employees;
select employee_id, hire_date, manager_id, department_id, phone_number,job_id,
       case when department_id=30 then to_char(salary)
            when lower('job_id')='it_prog' then phone_number
            when manager_id=100 then to_char(department_id)
       else last_name end "diverse"
       from employees;
select first_name, nvl(to_char(commission_pct),'Fara comision') from employees;
select employee_id, first_name, department_name from employees,departments
       where employees.department_id=departments.department_id;
select a.employee_id, a.last_name, a.manager_id, b.last_name
       from employees a, employees b
       where a.manager_id=b.employee_id;
--pt angajatii care sunt condusi de 100 codul,numele,data angajarii si numele sefului
select a.employee_id,a.first_name,a.hire_date,b.last_name 
       from employees a, employees b 
       where a.manager_id=b.employee_id
       and a.manager_id=100;
--codul angajatului, numele dep pt toti angajatii (+) este join pt tabelul deficitar
select employee_id,department_name
       from employees a,departments b
       where a.department_id=b.department_id(+);
--se cer codurile departamentelor in care nu exista angajati
select employee_id,department_name
       from employees a,departments b
       where a.department_id(+)=b.department_id;
--cele in care nu sunt angajati
select employee_id,department_name
       from employees a,departments b
       where a.department_id=b.department_id(+);
select employee_id,department_name
       from employees a,departments b
       where a.department_id(+)=b.department_id;
       UNION
select employee_id,department_name
       from employees a,departments b
       where a.department_id=b.department_id(+);
--codurile departamentelor in care nu sunt angajati (distincte)
select employee_id,department_name
       from employees a,departments b
       where a.department_id(+)=b.department_id
       and a.department_id is null;
--codul,numele,data angajarii si data angajarii sefului pt toti angajatii care 
--au fost recrutati in firma dupa seful lor direct

select a.employee_id,a.first_name,a.hire_date,b.hire_date
      from employees a,employees b
      where a.manager_id=b.employee_id
      and b.hire_date<a.hire_date;
--se vor angaja si angajatii care nu au sef
select a.employee_id,a.first_name,a.hire_date,b.hire_date
      from employees a,employees b
      where a.manager_id=b.employee_id(+)
      and nvl(b.hire_date,to_date('01-01-1900','DD-MM-YYYY'))<a.hire_date;
--pt angajatii care lucreaza in oxford se cere numele,numele dep in care lucreaza
select first_name,department_name
      from  employees a,departments b,locations c
      where a.department_id=b.department_id 
      and b.location_id=c.location_id
      and lower(c.city)='oxford';
--pt fiecare angajat codul,numele sau,idul si numele colegilor sai(din departament)
select a.employee_id,a.last_name,b.employee_id,b.last_name
     from employees a,employees b
     where a.department_id=b.department_id
     and a.employee_id<=b.employee_id;
--
select employee_id,last_name,department_name
     from employees b, departments b
     where a.department_id=b.department_id;
--on se poate folosi intotdeauna 
select employee_id,last_name,department_name
     from employees join departments
     on (employees.department_id=departments.department_id);
--daca am coloana comuna si nu folosesc alias atunci pot sa pun using
--cand vreau informatii in plus pun left(noi puneam plus in coloana deficitara) 
--daca vrem plus in ambele parti(ce nu se putea) punem full
select employee_id,last_name,department_name
     from employees left join departments
     using (department_id);  
--pb1lab3
select a.last_name,to_char(a.hire_date,'month'),to_char(a.hire_date,'yyyy')
     from employees a join employees b
     on a.department_id=b.department_id
     where lower(b.last_name)='gates'
     and instr(lower(a.last_name),'a',1)>0
     and lower(a.last_name)<>'gates';
--pb2lab3
select distinct a.employee_id,a.last_name,a.department_id,d.department_name
     from employees a join departments d 
     on (a.department_id=d.department_id) join employees b
     on (a.department_id=b.department_id)
     where lower(b.last_name) like '%t%'
     order by 2;
--pb3lab3 (doar ca nu afisam numele tarii ci codul acesteia)
select a.last_name, a.salary, job_title,city, country_id
     from employees a join jobs j 
     on(a.job_id=j.job_id) join departments d
     on(a.department_id=d.department_id) join locations l
     on(d.location_id=l.location_id) join employees b
     on(a.manager_id=b.employee_id)
     where lower(b.last_name)='king';
--pb7lab3
select distinct a.employee_id,a.last_name,a.salary
     from employees a join jobs j
     on(a.job_id=j.job_id) join employees b
     on(a.department_id=b.department_id) 
     where instr(lower(b.last_name),'t')>0
     and a.salary>(j.min_salary+j.max_salary)/2;
--pb5lab3
select department_id,department_name,last_name,job_id, to_char(salary,'$99,999.0')
     from employees  join departments
     using(department_id)
     where lower(department_name) like '%ti%'
     order by 2,3;
--pb 11 lab3
select department_id from departments 
     where lower(department_name) like '%re%'
     union 
     select department_id
     from employees 
     where upper(job_id)='sa_rep';
--pb 14 lab3
select department_id from departments
     where lower(department_name) like '%re%'
     intersect 
     select department_id from employees
     where upper(job_id)='HR_REP';
--pb 21 lab3
select employee_id,salary from employees
     where salary> all( select salary from employees 
     where lower(job_id) like '%clerk%') 
     order by salary desc;
--pb 22 lab3
select first_name,department_name,salary
     from employees left join departments
     using (department_id)
     where commission_pct is not null
     and employees.manager_id in (select nvl(manager_id,0)
     from employees
     where commission_pct is not null);
--pb 23 lab 3
select first_name,department_id,salary,job_id
     from employees 
     where (salary,commission_pct) in(select salary,commission_pct 
     from employees
     join departments
     using (department_id) join locations
     using (location_id)
     where lower(city)='oxford');
--pb 24 lab 3
select last_name,department_id, job_id
     from employees where
     department_id=(select department_id
     from departments join locations
     using (location_id)
     where lower(city)='toronto');
--pb 2 lab 4 (in fct de departament,doar pt dep in care exista mai mult de 5 angajati)
select department_id,max(salary) Maxim,min(salary) Minim,sum(salary) Suma, avg(salary) Media,count(employee_id)
    from employees
    group by department_id
    having count(employee_id)>5;
--sa se af codul si numele departamentelor in care salariul mediu este mai mare decat salariul mediu pe firma 
select department_id,department_id 
    from departments join employees  
    using (department_id)
    group by department_id
    having avg(salary)>(select avg(salary) 
    from employees);
--pb3 lab 4
select job_id,min(salary), max(salary),sum(salary),avg(salary)
    from employees
    group by job_id;
--pb4 lab 4
select job_id, count(employee_id)
    from employees
    group by job_id;
--pb5 lab 4
select count (distinct manager_id) "Nr_manageri"
    from employees;
--pb 9 lab 4
select manager_id, min(salary)
    from employees
    where manager_id is not null
    group by manager_id
    having min(salary)>1000
    order by 2 desc;
--ordonez dupa nr coloanei 2 din salect adica min(salary)
--pb 10 lab 4
select department_id, department_name, max(salary)
    from employees join departments using (department_id)
    group by department_id, department_name
    having max(salary)>3000;
--pb 11 lab 4
select min(avg(salary))
    from employees
    group by job_id;
--pb 6 lab 4
select max(salary)-min(salary) "Diferenta"
   from employees;
--pb 7 lab 4
select department_name, location_id, count(employee_id), avg(salary)
   from employees join departments using (department_id)
   group by department_id, department_name, location_id;
--la group by trb sa apara si coloanele simple din select
--pb 8 lab 4
select employee_id, first_name, salary
   from employees 
   where salary>(select avg(salary) from employees)
   order by 3 desc;
--pb 12 lab 4
select department_id, department_name, sum(salary)
   from employees join departments using(department_id)
   group by department_id,department_name;
--pb 13 lab 4
select max(avg(salary))
  from employees
  group by department_id;
--pb 14 lab 4
select job_id, job_title,avg(salary)
  from jobs join employees using(job_id)
  group by job_id, job_title
  having avg(salary)=(select min(avg(salary))
  from employees
  group by job_id);
--pb 15 lab 4
select avg(salary)
  from employees
  having avg(salary)>2500;
--pb 16 lab 4
select department_id, job_id, sum(salary)
  from employees 
  group by department_id,job_id;
--pb 17 lab 4
select department_name,min(salary)
  from employees join departments using (department_id)
  group by department_name, department_id
  having avg(salary)=(select max(avg(salary))
  from employees 
  group by  department_id);
--pb 18 lab 4
select department_id, department_name, count(employee_id)
  from employees join departments using (department_id)
  group by department_id, department_name
  having count(employee_id)<4 
  union
  select department_id, department_name, count(employee_id)
  from employees join departments using (department_id)
  group by department_id, department_name
  having count(employee_id)=(select max(count(employee_id))
  from employees
  group by department_id);
--pb 19 lab 4
select employee_id, to_char(hire_date,'dd')
  from employees 
  where to_char(hire_date,'dd')=
  (select to_char(hire_date,'dd')
  from employees
  group by to_char(hire_date,'dd')
  having count(employee_id)=(
  select max(count(employee_id))
  from employees
  group by to_char(hire_date,'dd')
  ));
--pb 20 lab 4
select count(department_id)
  from employees 
  group by department_id
  having count(employee_id)>15;
--pb 21 lab 4
select department_id,sum(salary)
  from employees 
  group by department_id
  having count(employee_id)>10
  and department_id<>30
  order by 2 desc;
--pb 24 lab 4
select employee_id
  from job_history
  group by employee_id
  having count(employee_id)>1;
--pb 23 lab 4
--se poate si cu having dar in cazul asta este mai performant where
select sum(salary),city,department_name,job_id
  from employees join departments 
  using (department_id)
  join locations
  using (location_id)
  where department_id>80
  group by department_id, department_name,job_id,city;
--pb 25 lab 4
--varianta 1
select avg(nvl(commission_pct,0))
  from employees;
--varianta 2
select sum(commission_pct)/count(*)
  from employees;
--pb 30 lab 4
--varianta 1
select department_id,department_name,sum(salary)
  from departments left join employees using(department_id)
  group by department_id,department_name;
--varianta 2 ca sa pot lega 2 tabele trb sa am o coloana de leg
select a.department_id, department_name, miercuri
  from departments a left join(select department_id, sum(salary) miercuri
  from employees 
  group by department_id) b
  on (a.department_id=b.department_id);
--varianta 3 
select department_id, department_name,
  (select sum(salary) 
  from employees
  where department_id=a.department_id) 
  from departments  a;
--pb 22 lab 4
select d.department_id,department_name,last_name,salary,job_id,
  (select avg(salary)
  from employees
  where d.department_id=department_id) "medie",
  (select count(employee_id)
  from employees
  where d.department_id=department_id) "numar" 
  from employees e right join departments d on(e.department_id=d.department_id);
--pb 27 lab 4 varianta 1
select job_id "Job", sum(salary) "Total",
  (select sum(salary)
  from employees where department_id=30 and job_id=e.job_id) "dep 30",
  (select sum(salary) 
  from employees where department_id=50 and job_id=e.job_id)"dep 50",
  (select sum(salary)
  from employees where department_id=80 and job_id=e.job_id) "dep 80"
  from employees e
  group by job_id;
--varianta 2 cu decode
select job_id, sum(salary)"Total",
  sum(decode(department_id,30,salary,0))"dep 30",
  sum(decode(department_id,50,salary,0)) "dep 50",
  sum(decode(department_id,80,salary,0))"dep 80"
  from employees 
  group by job_id;
--pb 28 lab 4
select count(employee_id),
  sum(decode(to_char(hire_date,'yyyy'),1997,1,0))"an97",
  sum(decode(to_char(hire_date,'yyyy'),1998,1,0))"an98",
  sum(decode(to_char(hire_date,'yyyy'),1999,1,0))"an99",
  sum(decode(to_char(hire_date,'yyyy'),2000,1,0))"an00"
  from employees;
--pb 31 lab 4
select a.first_name, a.salary, t.department_id, medie,numar
  from employees a  right join 
  (select department_id, avg(salary)medie,
  count(employee_id) numar
  from employees right join departments using(department_id)
  group by department_id) t
  on(a.department_id=t.department_id);
--pb 33 lab 4 var1
select d.department_id,d.department_name,first_name,salary
  from departments d  left join employees e on(d.department_id=e.department_id)
  where salary=(select min(salary)
  from employees 
  where d.department_id=department_id);
--var 2
select d.department_id, d.department_name,salary
  from departments d left join( 
  select e.department_id,department_name,first_name,salary
  from employees e right join departments dep
  on(e.department_id=dep.department_id)
  where salary=(select min(salary)
  from employees 
  where department_id=dep.department_id)) aux
  on(d.department_id=aux.department_id);
--  exemplu cube(la cube exista NU DA)
SELECT department_id, TO_CHAR(hire_date, 'yyyy'), SUM(salary)
FROM employees
WHERE department_id < 50
group by department_id, TO_CHAR(hire_date, 'yyyy');
--pb5 lab 5 a
select first_name, employee_id , salary 
  from employees a
  where (select avg(salary)
  from employees where a.department_id=department_id)<salary;
--pb 5 lab 5 b
select first_name, employee_id , salary,numar,medie
  from employees  join 
  (select department_id,count(employee_id) numar, avg(salary) medie
  from employees 
  group by department_id) 
  using (department_id);
--aceaasi cerere cu subcerere in select
select first_name,employee_id,salary,a.department_id,
  (select count(employee_id)
  from employees
  where a.department_id=department_id)"numar",
  (select avg(salary)
  from employees
  where a.department_id=department_id
  ) "medie"
  from employees a join departments b
  on(a.department_id=b.department_id);
-- pb 6 lab 5 cu max
select first_name,salary
  from employees
  where salary > (select
  max(avg(salary))
  from employees 
  group by department_id);
-- pb 6 lab 5 cu all
select first_name,salary
  from employees
  where salary > all(select
  avg(salary)
  from employees 
  group by department_id);
--pb 7 lab 5 sincronizata
select first_name, salary,department_id
 from employees a
 where salary=(select 
 min(salary)
 from employees
 where a.department_id=department_id);
--pb 7 lab 5 subcerere from
select last_name,salary,department_id
 from employees join 
 (select department_id,min(salary) minim
 from employees
 group by department_id)
 using (department_id)
 where salary = minim;
--pb 7 lab 5 nesincronizata
select employee_id, last_name, salary, department_id
 from employees
 where (salary,department_id) in (select min(salary),department_id
 from employees
 group by department_id);
--pb 8 lab 5
select a.department_id, last_name, hire_date
 from employees a join departments d
  on (d.department_id=a.department_id)
 where hire_date=(select min(hire_date)
 from employees
 where a.department_id=department_id) 
 order by department_name;
--pb 9 lab 5
select last_name,department_id
 from employees a
 where exists (select 'x'
 from employees
 where a.department_id=department_id
 and salary=(select max(salary)
 from employees
 where department_id=30));
--pb 10 lab 5
select last_name, salary
 from employees e
 where 2>=(select
 count(distinct salary)
 from employees 
 where e.salary<salary);
select last_name, salary
 from (select last_name,salary
 from employees
 order by salary desc)
 where rownum<4;
--primii3
select last_name,salary
 from employees where salary in
 (select salary 
 from
 (select distinct salary
 from employees 
 order by salary desc)
 where rownum<4);
--pb 11 lab 5
select employee_id, last_name, first_name
 from employees e
 where 2<=(select count(employee_id)
 from employees 
 where manager_id=e.employee_id);
--pb 12 lab 5
select location_id
 from locations l
 where exists(select '1' 
 from departments
 where location_id=l.location_id);
--pb 13 lab 5
select department_id
 from departments d
 where not exists(select '1'
 from employees
 where department_id=department_id);
--pb 14 lab 5
select employee_id, last_name, hire_date,salary,manager_id
 from employees e
 where manager_id=(select employee_id
 from employees
 where lower(last_name)='de haan');
--start with r .. connect by... employee_id=PRIOR manager_id (bottom up)..prior employee_id= manager_id (top down)
--pb 14 b) lab 5
select employee_id,last_name,manager_id
 from employees
 start with employee_id=(select employee_id
 from employees
 where lower(last_name)='de haan')
 connect by prior employee_id=manager_id;
--invers
select employee_id,last_name,manager_id
 from employees
 start with employee_id=(select employee_id
 from employees
 where lower(last_name)='de haan')
 connect by employee_id=prior manager_id;
--15 lab 5
select employee_id,last_name,manager_id
 from employees
 start with employee_id=100
 connect by prior employee_id= manager_id;
--pb 16 lab 5
select employee_id,last_name,manager_id, level
 from employees
 where level=3
 start with employee_id=(select employee_id
 from employees
 where lower(last_name)='de haan')
 connect by prior employee_id=manager_id;
--pb 17 lab 5
select employee_id, first_name,manager_id,level
 from employees
 connect by employee_id = prior manager_id;
--pb 18 lab 5
select employee_id, last_name, manager_id, level
 from employees
 where salary>5000
 start with employee_id in
 (select employee_id
 from employees
 where salary=(select max(salary)
 from employees))
 connect by prior employee_id=manager_id;
--pb 9 lab 5 remake :D with face un tabel nou
with dep_favorite as
  (select distinct department_id from employees
  where salary=(select
  max(salary) from employees
  where department_id=30))
  select last_name, department_id
  from employees join dep_favorite
  using(department_id);
--primul exemplu din lab6
select distinct employee_id
 from works_on w
 where not exists
 (select project_id
 from project p
 where budget=10000
 and not exists
 (select employee_id
 from works_on
 where project_id=p.project_id
 and employee_id=w.employee_id));
--alta varianta - aceeasi pb
select distinct employee_id
 from works_on a
 where(select count (project_id)
 from project
 where budget=10000)=
 (select count(project_id)
 from works_on join project
 using (project_id)
 where budget=10000 and
 employee_id=a.employee_id);
--alta varianta - aceeasi pb
select distinct employee_id
 from works_on w
 where not exists 
 (select project_id
 from project
 where budget=10000
 minus
 select project_id
 from works_on
 where employee_id=w.employee_id);
--alta varianta - aceeasi problema
 select distinct employee_id
 from works_on
 where employee_id not in
 (select employee_id
 from 
 (select employee_id,t.project_id
 from works_on,
 (select project_id
 from project
 where budget=10000)t
 minus
 select employee_id,project_id
 from works_on));
--pb 1 lab 5 (not exists)
select distinct employee_id
 from works_on w
 where not exists
 (select project_id 
 from project p
 where start_date>=to_date('01-01-2006','dd-mm-yyyy')
 and
 start_date<=to_date('30-06-2006','dd-mm-yyyy')
 and not exists 
 (select employee_id
 from works_on
 where project_id=p.project_id
 and employee_id=w.employee_id));
--aceeasi pb cu reducere la absurd
 select distinct employee_id
 from works_on
 where employee_id not in
 (select employee_id
 from 
 (select  employee_id, project_id 
  from employees,
  (select project_id 
  from project
  where start_date>=to_date('01-01-2006','dd-mm-yyyy')
  and
  start_date<=to_date('30-06-2006','dd-mm-yyyy'))
  minus
  select employee_id,project_id
  from works_on));
--pb 2 lab 6 proiectul la care lucreaza toti angajatii B: angajatii care luctreaza la proiect
select distinct project_id
 from project p
 where not exists
 (select employee_id
 from job_history
 group by employee_id
 having count(*)>1
 minus
 select employee_id
 from works_on
 where project_id=p.project_id);
--pb 3 lab 6 (+cele 3 joburi pe care le-a avut sa fie distincte)
select j.employee_id, count(distinct j.job_id)
 from job_history j join employees x
 on (x.employee_id=j.employee_id) 
 group by j.employee_id,x.job_id,x.employee_id
 having count(distinct j.job_id)+
 case when x.job_id in
 (select job_id from job_history
 where employee_id=x.employee_id)
 then 0 else 1 end >2;
--pb 19 lab 5 
with lab223 as 
 (select department_id, sum(salary) suma
 from employees
 group by department_id), lab214 as
 (select * from lab223
 where suma>(select avg(suma)
 from lab223))
 select department_name, suma
 from departments join lab214
 using(department_id);
--pb 20 lab 5
 with stevenking as
 (select employee_id,hire_date,manager_id
 from employees
 where manager_id=(select
 employee_id from employees
 where lower(last_name)='king'
 and lower(first_name)='steven')),
 stevenking_old as (select employee_id
 from stevenking
 where hire_date=(select min(hire_date)
 from stevenking))
 select employee_id, last_name||first_name,job_id,hire_date, level,manager_id
 from employees 
 where to_char(hire_date,'yyyy')<>1970
 start with employee_id in 
 (select employee_id from stevenking_old)
 connect by prior employee_id=manager_id;
--DE AMINTIT CA AM RAMAS LA 20
create table EMP_pnu as select * from employees;
create table DEPT_pnu as select * from departments;
desc emp_pnu;
desc employees;
--trebuie sa definim constrangerile
ALTER TABLE emp_pnu
ADD CONSTRAINT pk_emp_pnu PRIMARY KEY(employee_id);
ALTER TABLE dept_pnu
ADD CONSTRAINT pk_dept_pnu PRIMARY KEY(department_id);
ALTER TABLE emp_pnu
ADD CONSTRAINT fk_emp_dept_pnu
FOREIGN KEY(department_id) REFERENCES dept_pnu(department_id);
alter table dept_pnu
add constraint fk_manager foreign key(manager_id)
references emp_pnu(employee_id);
alter table emp_pnu
add constraint fk_sef foreign key(manager_id)
references emp_pnu(employee_id);
INSERT INTO DEPT_pnu (department_id, department_name, location_id)
VALUES (300, 'Programare', null);
commit;
insert into emp_pnu
values (220,null,'nume1','email@nume1',null,to_date('01-01-2011','dd-mm-yyyy'),'SA_MAN',null,null,null,300);
commit;
--pb7 lab 7
insert into emp_pnu(employee_id,last_name,email,hire_date,job_id,department_id)
values(221,'nume2','email@nume2',sysdate,'IT_PROG',300);
--pb8 lab 7
insert into
(select employee_id,last_name,email,hire_date,job_id
from emp_pnu)
values((select max(employee_id)+1 from emp_pnu),'nume3','email',sysdate,'AD_MAN');
--pb9 lab7
create table emp1_pnu
as select * from employees
where 1>2;

insert into emp1_pnu 
select * from employees
where commission_pct>0.25;
--pb 10 lab 7
insert into emp_pnu
values(0,user,user,'total','total',sysdate,'total',
(select sum(salary) from emp_pnu),
(select avg(commission_pct) from emp_pnu),null,null);
--pb 11 lab 7
undefine nume;
undefine prenume;
insert into emp_pnu(employee_id,first_name,last_name,email,hire_date,job_id,salary)
values (&cod,'&&prenume','&&nume',substr('&prenume',1,1)||substr('&nume',1,7),
to_date('&data','dd-mm-yyyy'),'&job',&sal);

delete from emp2_pnu;
create table emp3_pnu
as select * from employees 
where 1>2;

--pb 12 lab 7
insert all
when salary<5000 then into emp1_pnu
when salary between 5000 and 10000 then into emp2_pnu
else into emp3_pnu
select *
from employees;
--pb13 lab 7
insert first
when department_id=80 then into emp0_pnu
when salary<5000 then into emp1_pnu
when salary between 5000 and 10000 then into emp2_pnu
else into emp3_pnu
select *
from employees;
commit;
--pb 14 lab 7
update emp_pnu
set salary=salary*1.05;
rollback;
--pb 15 lab 7
update emp_pnu
set job_id='SA_REP'
where department_id=80 and commission_pct is not null;
rollback;
--pb 16 lab 7
update dept_pnu
set manager_id=(
select employee_id
from emp_pnu
where lower(first_name)='douglas' and lower(last_name)='grant')
where department_id=20;

update emp_pnu
set salary=salary+1000
where employee_id=(
select employee_id
from emp_pnu
where lower(first_name)='douglas' and lower(last_name)='grant');

--pb 17 lab 7
update emp_pnu x
set (salary,commission_pct)=
(select salary, commission_pct
from emp_pnu
where employee_id=x.manager_id)
where salary=
(select min(salary)
from emp_pnu);
--pb 18 lab7
update emp_pnu y
set email=substr(last_name,1,1)||nvl(first_name,'.')
where salary=(select max(salary)
from emp_pnu
where department_id=y.department_id);
rollback;
--pb19 lab 7
update emp_pnu y
set salary=(select avg(salary) from emp_pnu where employee_id>0)
where hire_date=(select min(hire_date)
from emp_pnu
where department_id=y.department_id);
rollback;
--pb 20 lab 7
update emp_pnu
set (job_id,department_id)=(select job_id,department_id
from emp_pnu
where employee_id=205)
where employee_id=114;
--pb 21 lab 7
undefine cod;
define cod=&x;
select *
from dept_pnu
where department_id=&cod;
update dept_pnu
set department_name='&dep',location_id=&loc,manager_id=&sef
where department_id=&cod;
select *
from dept_pnu
where department_id=&cod;

--pb 22 lab 7
delete from dept_pnu;

--pb 24 lab 7
delete from dept_pnu
where department_id not in 
(select nvl(department_id,0) from emp_pnu);
rollback;

--pb 23 lab 7
delete from emp2_pnu
where commission_pct is null;
--pb 25 lab 7
define cod=0;
select employee_id,salary
from emp_pnu
where employee_id=&cod;
delete from emp_pnu
where employee_id=&cod;
commit;
--pb 31 lab 7
delete from emp2_pnu
where commission_pct is not null;
commit;
merge into emp2_pnu x
using employees e
on(x.employee_id=e.employee_id)
when matched then
update set
x.first_name=e.first_name,
x.last_name=e.last_name,
x.email=e.email,
x.phone_number=e.phone_number,
x.hire_date=e.hire_date,
x.job_id=e.job_id,
x.salary=e.salary,
x.commission_pct=e.commission_pct,
x.manager_id=e.manager_id,
x.department_id=e.department_id
when not matched then
insert 
values (e.employee_id,e.first_name,e.last_name,e.email,e.phone_number,e.hire_date,e.job_id,
e.salary,e.commission_pct,e.manager_id,e.department_id);
select user from dual;
desc grupa42.departments;
update grupa42.departments
set department_id=department_id+150
where department_id=170;
select * from user_tables;
select * from all_objects
where owner=user;
--pb 1 lab 8 a)
create table angajati_pnu(cod_ang number(4) constraint pk_cod_ang primary key,
nume varchar2(20) constraint numt_not_null not null,
prenume varchar2(20),
email char(15),
data_ang date,
job varchar2(20),
cod_sef number(4),
salariu number(8,2) constraint salariu_not_null not null,
cod_dep number(2));
desc angajati_pnu;
drop table angajati_pnu;
insert into angajati_pnu(cod_ang,nume,salariu)
values(10,'etc',3000);
--c)
create table angajati_pnu(cod_ang number(4) ,
nume varchar2(20) constraint numt_not_null not null,
prenume varchar2(20),
email char(15),
data_ang date default sysdate,
job varchar2(20),
cod_sef number(4),
salariu number(8,2) constraint salariu_not_null not null,
cod_dep number(2),
constraint pk_cod_ang primary key (cod_ang));
desc angajati_pnu;
drop table angajati_pnu;
--pb 2 lab 8
insert into angajati_pnu(cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dep)
values(100,'Nume1','Prenume1',null,null,'Director',null,20000,10);
insert into angajati_pnu(cod_ang,nume,prenume,email,data_ang,job,cod_sef,salariu,cod_dep)
values(103,'Nume4','Prenume4',null,null,'Inginer',100,9000,20);
insert into angajati_pnu
values(101,'Nume2','Prenume2','Nume2',to_date('02-02-2004','dd-mm-yyyy'),'Inginer',100,10000,10);
insert into angajati_pnu
values(102,'Nume3','Prenume3','Nume3',to_date('05-06-2000','dd-mm-yyyy'),'Analist',101,5000,20);
insert into angajati_pnu
values(104,'Nume5','Prenume5','Nume5',null,'Analist',101,3000,30);
--pb3 lab 8
create table angajati10_pnu
as select * from angajati_pnu
where cod_dep=10;
desc angajati10_pnu;
--cand copiez un tabel se copiaza doar constrangerile l nivel de coloana si nu la nivel de tabel
--pb 4 lab 8
alter table angajati_pnu
add (comision number(4,2));
--pb 5 lab 8
alter table angajati_pnu
modify (salariu number(6,2));
--pb 6 lab 8
alter table angajati_pnu
modify (salariu number(8,2) default 3000);
--pb 7 lab 8
alter table angajati_pnu
modify (comision number(2,2),salariu number(10,2));
--pb 8 lab 8
update angajati_pnu
set comision=0.1
where lower(job) like 'a%';
--pb 9 lab 8
alter table angajati_pnu
modify(email varchar2(15));
--pb 10 lab 8
alter table angajati_pnu
add(nr_telefon varchar2(10) default '012345');
--pb 11 lab 8
alter table angajati_pnu
drop column nr_telefon;
--pb 12 lab 8
desc tab;
select * from tab;
rename angajati_pnu to angajati3_pnu;
rename angajati_3pnu to angajati_pnu;
--pb 14 lab 8
truncate table angajati10_pnu;
rollback;
--pb 15 lab 8
create table departamente_pnu
(cod_dep number(2),
nume varchar2(15) constraint not_null_nume_dep not null,
cod_director number(4));
insert into departamente_pnu
values(10,'Administrativ',100);
insert into departamente_pnu
values(20,'Proiectare',101);
insert into departamente_pnu
values(30,'Programare',null);
--pb 17 lab 8
alter table departamente_pnu
add constraint pk_cod_dep primary key(cod_dep);
--pb 18,19 lab 8
alter table angajati3_pnu 
add constraint fk_cod_deprt foreign key (cod_dep) references departamente_pnu(cod_dep);
drop table angajati_pnu;
create table angajati_pnu
(
cod_ang number(4),
nume varchar2(20) constraint nume_not_null not null,--nu se poate muta la nivel de tabel
prenume varchar2(20),
email varchar2(15) ,
data_ang date,
job varchar2(10),
cod_sef number(4),
salariu number(10,2),
cod_dep number(2) ,
comision number(2,2),
constraint unique_nume_prenume unique (nume,prenume),
constraint fk_sef_f foreign key (cod_sef) references angajati_pnu (cod_ang),
constraint fk_cod_depp foreign key (cod_dep) references departamente_pnu (cod_dep),
constraint ck_salariu check(salariu>100*comision),
constraint pk_codcc primary key(cod_ang),
constraint unique_email unique(email),
constraint ck_cod_dep check(cod_dep>0)
);
--pb 21 lab 8
delete from departamente_pnu;
--pb 22 lab 8
select * from USER_CONSTRAINTS;
--not null se poate adauga doar la nivel de coloana
alter table angajati_pnu 
modify (email varchar2(15) default 'lab223');
update angajati_pnu
set email=nume||'@gmail.com'
where email is null;
--pb 25 lab8
insert into angajati_pnu
values(110, 'Nume10', 'Prenume3', 'Nume310', to_date('05-06-2000', 'dd-mm-yyyy'), 'Analist', 101, 5000, 50, 0.1);

--lab 8 probl 26

insert into departamente_pnu(cod_dep, nume)
values(60, 'Analiza');

commit;
--lab 8 probl 27
delete from departamente_pnu
where cod_dep=60;

rollback;

desc angajati_pnu;

--lab 8 probl 29

insert into angajati_pnu(cod_ang, nume, email, cod_sef)
values (114, 'lab223', 'email223', 100);

insert into angajati_pnu(cod_ang, nume, email,cod_sef)
values (120, 'lab224', 'email224', 114);

alter table angajati_pnu
drop constraint fk_cod_dep;

alter table angajati_pnu add constraint fk_cod_dep
foreign key(cod_dep) references departamente_pnu(cod_dep)
on delete cascade;

--lab 8 probl 32

delete from departments_pnu
where cod_dep=20;
rollback;

--lab 8 probl 33

alter table departamente_pnu add constraint fk_cod_director foreign key(cod_director) references
angajati_pnu(cod_ang) on delete set null;

--lab 8 probl 34
update departamente_pnu
set cod_director=102
where cod_dep=30;
delete from angajati_pnu
where cod_ang=102;

rollback;

--lab 8 probl 35
alter table angajati_pnu
add constraint verifica_salariu check(salariu<30000);
alter table angajati_pnu
drop constraint verifica_salariu;

update angajati_pnu
set salariu=salariu+28000;

update angajati_pnu
set salariu=salariu-28000;

rollback;

--lab 8 probl 36

alter table angajati_pnu
modify constraint verifica_salariu disable;

alter table angajati_pnu
modify constraint verifica_salariu enable;

rollback;

-- lab 9 probl 1

create global temporary table temp_tranz
(x number(2) primary key)
on commit delete rows;

insert into temp_tranz values(3);

select * from temp_tranz;

commit;

-- lab 9 probl 2

create global temporary table temp_sesiune
(x number(2) primary key)
on commit preserve rows;

insert into temp_sesiune values(3);

select * from temp_sesiune;

commit;

drop table temp_sesiune;

truncate table temp_sesiune;

-- lab 9 probl 5

create global temporary table angajati_azi_pnu
on commit preserve rows
as
select last_name, department_id, employee_id
from employees
where hire_date>to_date('01-01-2000', 'dd-mm-yyyy');

-- lab 9 probl 6

insert into angajati_azi_pnu
values ('lab223', 500, 111);

-- lab 8 probl 23

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE lower(table_name) IN ('angajati_pnu', 'departamente_pnu');

select *
from tab;

-- lab 9 probl 7

create or replace view viz_emp30
as select employee_id, last_name, email, salary, hire_Date, job_id
from emp_pnu
where department_id=30;

select * from viz_emp30;

select *
from (select employee_id, last_name, email, salary
from emp_pnu
where department_id=30);

desc viz_emp30;

insert into viz_emp30
values(344, 'lab', 'email_lab', 3000, sysdate, 'programare');

update viz_emp30
set salary=salary+30
where employee_id=118;

rollback;

update viz_emp30
set department_id=80
where employee_id=118;

delete viz_emp30
where employee_id=118;

-- lab 9 probl 9

create or replace view viz_emp50
as select employee_id, last_name, email, salary, job_id, salary*12 sal_anual
from emp_pnu
where department_id=50;

delete from viz_emp50
where sal_anual<50000;

rollback;

insert into viz_emp50(employee_id,last_name,email, job_id, hire_date,sal_anual)
values(347, 'lab', 'email_lab2', 'programare', sysdate,12000);
insert into viz_emp50(employee_id,last_name,email, job_id, hire_date)
values(347, 'lab', 'email_lab2', 'programare', sysdate);

create or replace view viz_emp50
as select employee_id, last_name, email, salary, job_id, salary*12 sal_anual
from emp_pnu
where department_id=50;

delete from viz_emp50
where sal_anual>200000;
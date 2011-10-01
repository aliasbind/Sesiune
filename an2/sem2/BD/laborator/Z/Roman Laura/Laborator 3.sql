select * from employees;

-- pt angajatii care sunt condusi de 102, se cere codul,numele data angajarii si numele sefului
select a.employee_id, a.first_name, a.last_name, a.hire_date, b.last_name 
from employees a, employees b
where a.manager_id=b.employee_id and a.manager_id=102;

--codul angajatului si numele departamentului pt toti angajatii
select a.employee_id, b.department_id
from employees a, departments b
where a.department_id = b.department_id (+); --rightjoin

select a.employee_id, b.department_id
from employees a, departments b
where a.department_id (+) = b.department_id; --leftjoin
-- (+) se pune la tabelul deficitar in informatie

select a.employee_id, b.department_id
from employees a, departments b
where a.department_id (+) = b.department_id 
UNION
select a.employee_id, b.department_id
from employees a, departments b
where a.department_id= b.department_id(+); --nu poti sa ai (+) de ambele parti (si in dreapta si in stanga)

--codurile departamentelor in care nu exista angajati
select distinct b.department_id
from employees a, departments b
where a.department_id (+) =b.department_id and a.department_id is null; --a.manager_id is null

--afisati codul, numele, data_angajare si data angajare_sef pt toti angajatii care au fost recrutati
-- in firma dupa seful lor direct + se vor afisa si anhajatii care nu au sef
select a.employee_id, a.first_name, a.last_name, a.hire_date, b.hire_date
from employees a, employees b
where a.manager_id=b.employee_id(+) and 
      nvl(b.hire_date, to_date('01-01-1900','dd-mm-yyyy')) < a.hire_date;
      
-- pt angajatii care lucreaza in oxford se cer : numele, numele departamentului in care lucreaza
select a.last_name , b.department_name
from employees a, departments b, locations c
where a.department_id=b.department_id and c.location_id = b.location_id and lower(city)='oxford';

-- pt fiecare angajat, codul, numele sau, impreuna cu id-ul si numele colegilor sai

select a.employee_id, a.last_name, a.first_name, b.employee_id, b.last_name, b.first_name
from employees a, employees b
where a.department_id=b.department_id and a.employee_id < b.employee_id ;

--cod angajat, numele lui si numele departamentului : ex anterior
select employee_id, last_name, department_name
from employees e, departments d
where e.department_id=d.department_id; --daca punem + la d.department_id,intoarce toti angfajatii, pt ca
--departamentene sunt deficitare

--altfel

--left right full pt tabelul in care vreau sa scot informatii in plus, (+) este pt cand tabelul este deficitar de informatie
select employee_id, last_name, department_name
from employees full join departments --daca nu pun join, nu il ia pe ala cu null in considerare; in partea ailalta puneam right
--full pt (+) in ambele parti
--ON (employees.department_id = departments.department_id);
USING(department_id); --merg amandoua
--sau USING - tre sa am o coloana comuna; daca am coloana comuna si nu folosesc alias, pot sa pun
-- USING(department_id); iar
--ON folosim oricand
-- join: scoate doar liniile care verifica un set de egalitate "="
    -- : am si linii care nu verifica conditia de egalitate : OUTER JOIN; pot sa zic si left outer join si full outer join blabla
    
--lab 3, exercitii:
select a.first_name, to_char(a.hire_date, 'month'), to_char(a.hire_date, 'yyyy') 
from employees a join employees b 
on (a.department_id=b.department_id)
where lower(b.last_name)='gates' and instr(lower(a.last_name), 'a',1)>0 and 
  lower(a.last_name)<>'gates' ; 
  
select distinct a.employee_id, a.last_name, a.department_id, department_name
from employees a join departments d
on (a.department_id=d.department_id) join employees b 
on (a.department_id=b.department_id)
where lower(b.last_name) like '%t%'
order by 2;

--nu afisam numele tarii , ci codul
select e.last_name, e.salary, job_title, city, country_id
from employees e join jobs j on (e.job_id=j.job_id) 
join departments d on (d.department_id=e.department_id)
join locations l on (l.location_id=d.location_id)
join employees f on (e.manager_id=f.employee_id)
where lower(f.last_name)='king';

--where lower(city) = 'oxford'
-- 7.
select distinct a.employee_id, a.last_name, a.salary
from employees a join jobs b 
on (a.job_id=b.job_id) join employees c
on (a.department_id=c.department_id)
where instr(lower(c.last_name),'t')>0 and (a.salary>(b.min_salary+b.max_salary)/2);

--5
select department_id, department_name, last_name, job_id, to_char(salary, '$99,999.00')
from employees join departments
using (department_id)
where lower(department_name) like '%ti%'
order by 2,3;
select * from employees;
select to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss') from dual;
select length('Informatica') from dual;
select REPLACE ('$a$aa','$a') from dual;
select TRANSLATE('$a$baa','$a','xyz') from dual;

--pt fiecare angajat cod , nume concatenat cu prenume , impreuna cu nr de vocale

select employee_id, last_name || first_name "nume",
length(last_name||first_name)-length(translate(lower(last_name||first_name),'*aeiou','r')) "nr vocale"
from employees;

--angajatii care n au pe prima sau ultima litera vocala
select employee_id, last_name
from employees
where substr(lower(last_name), 1,1)  in ('a','e','i','o','u')
or substr(lower(last_name), length(last_name),1)  in ('a','e','i','o','u');

--pt fiecare angajat se cere: codul, data angajarii, nr de zile lucrate, nr de saptamani lucrate rotunjit cu 2 zecimale, respectic
-- nr de luni lucrate rotunjite cu 2 zecimale

select employee_id, hire_date, round(sysdate - hire_date,2) "days_worked" , round((sysdate-hire_date)/7,2) "weeks_worked", 
round(months_between(sysdate,hire_date),2) "months_worked"
from employees;

--cate saptamani a lucrat si cate zile de miercuri
select employee_id, hire_date, round((sysdate-hire_date)/7,2) "weeks_worked", 
round((sysdate-hire_date)/7) + decode(to_char(hire_date, 'day'),'wednesday',1,0) "zile_miercuri",
to_char(hire_date, 'day') "nr_inceput_lucru"
from employees;

-- pt angajatii care au lucrat un nr intreg de sapt, sa se afiseze cod, salariu, hire_date

select employee_id, salary, hire_date
from employees
where mod(round(sysdate-hire_date),7)=0;

--pt fiecare angajat sa se afis salariul, salariul marit cu 25% si ziua in care i se va mari salariul si ziua o sa fie prima zi deluni de peste 3 luni
select employee_id, salary, hire_date, salary+1/4*salary "Raised Salary", next_day(add_months(hire_date,3),'monday') "Raise day"
from employees;

select user from dual;

select employee_id, hire_date, manager_id, department_id, salary, job_id, phone_number,
case when department_id=30 then  to_char(salary)
    when lower(job_id)='it_prog' then phone_number
    when manager_id=100 then to_char(department_id)
else last_name end "diverse"
from employees;

select employee_id, last_name, first_name,  nvl(to_char(commission_pct), 'fara comision') 
from employees;

--pt fiecare angajat, cine e seful lui ?
-- pt fiecare angajat vreau codul ,numele "last_name" si numele departamentului in care lucreaza 

select employee_id, last_name, department_name
from employees,departments
where employees.department_id=departments.department_id;

--pt fiecare angajat, codul  , numele impreuna cu numele sefului si codul acestuia

select a.employee_id, a.last_name, a.manager_id, b.last_name
from employees a, employees b
where a.manager_id=b.employee_id;
select replace('abcdab','ab','x')
from dual;

select replace('abcab','ab',' ')
from dual;

select length(replace('abcab','ab',' '))
from dual;

select translate('abcdab','ab','x')
from dual;

select translate('abcdab','a','xy')
from dual;

select translate('abcdab','ac','xy')
from dual;

select translate('abcdab','*a',' ')
from dual;

select replace('abcdab','ab','')
from dual;

select employee_id, first_name || last_name, length(concat(first_name,last_name))-length(translate(concat(first_name,last_name),'*aeiou',' ')) "Numar vocale"
from employees;


-- pentru fiecare angajat, codul, data angajarii, nr de zile, saptamani, luni de munca in firma

select employee_id, hire_date, round(sysdate-hire_date,2) "Numar de zile"
from employees;

select employee_id, hire_date, round((sysdate-hire_date)/7,2) "Numar de saptamani"
from employees;

select employee_id, hire_date, months_between(sysdate,hire_date) "Numar de luni"
from employees
order by 3 desc;

select next_day(sysdate,'Wednesday')
from dual;


-- pt fiecare angajat, nr de zile de miercuri pe care le-a lucrat

select employee_id, to_char(hire_date,'Day'), 
 round((sysdate-hire_date)/7) + decode(to_char(hire_date,'Day'),'Wednesday',1,0) "Numar de Miercuri lucrate"
from employees;

select decode(to_char(sysdate,'Day'),'Wednesday',1,0)
from dual;


-- exercitii

select first_name || ' ' || last_name || ' castiga ' || salary || ' pe luna dar doreste sa castige ' || salary*3 "Propozitie"
from employees;

select initcap(first_name) "Prenume", upper(last_name) "Nume", length(last_name) "Lungimea numelui"
from employees
where lower(last_name) like 'j%' or lower(last_name) like 'm%' or lower(last_name) like '__a%'
order by length(last_name) desc;

select first_name, last_name, employee_id, department_id
from employees
where lower(first_name) like 'steven';

select first_name, last_name, nvl(to_char(commission_pct),'Fara comision') "Comision"
from employees;

select first_name, last_name, salary, commission_pct
from employees
where salary + salary*nvl(commission_pct,0) > 10000;

select first_name, last_name, job_id, salary, 
  salary + salary*decode(job_id,'IT_PROG',0.2,'SA_REP',0.25,'SA_MAN',0.35,0) "Salariu renegociat"
from employees;

select employee_id, salary, department_id, job_id, manager_id,
 case when department_id=30 then salary*1.1
      when job_id='IT_PROG' then salary*1.2
      when manager_id=100 then salary*1.15
      else salary
      end "Salary"
from employees;


-- join

select employee_id, first_name, last_name, employees.department_id, department_name
from employees, departments
where employees.department_id=departments.department_id;


-- sa se afiseze codul si numele angajatilor al caror nume este palindrom
-- vsl@fmi.unibuc.ro

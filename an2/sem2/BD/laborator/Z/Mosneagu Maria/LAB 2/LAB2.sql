SELECT replace('$b$bb','$b','a')
FROM dual;

SELECT replace('$b$bb','$','ac')
FROM dual;

SELECT REPLACE('abcab','ab',' ')
FROM dual;

SELECT LENGTH(REPLACE('abcab','ab',' '))
FROM dual;

select INSTR(LOWER('AbCdE abcdE','ab',5))
from dual;

select TRANSLATE('abcdab','ab','x')
from dual;

select TRANSLATE('abcdab','a','xy')
from dual;

SELECT translate('etc','*e',' ')
from dual;

--numarul de vocale din numele angajatilor//trebuie sa scap de spatii
SELECT employee_id,first_name||last_name,(length(last_name||first_name)-length(TRANSLATE(lower(last_name||first_name),'*aeiou',' '))) "nr vocale"
FROM employees;

--pentru fiecare angajat se cer codul, data angajarii, nr de zile, nr de saptamani, nr de luni,(vor fi rotunjite ca intregi)
--aranjati si in ordine crescatoare dupa nr de zile 
SELECT employee_id,hire_date,round(SYSDate-hire_date)"nr zile",round((SYSDate-hire_date)/7)"nr saptamani",round(months_between(SYSDATE,hire_date))"nr de luni"
FROM employees
--ORDER BY "nr zile";
ORDER BY 3;

--care este data urmatoarei zile de miercuri
SELECT next_day(SYSDATE,'WEDNESDAY')
FROM dual;

--pt fiecare angajat sa vedem nr de zile de miercuri pe care le-a lucrat si ziua in care a fost angajat
--DECODE(value,if1,then1,else)
SELECT 
      employee_id,
      TO_CHAR(hire_date,'day') "ziua sapt angajarii",
      DECODE(TO_CHAR(hire_date,'day'),'wednesday',1,0)"decode",
      round((SYSDate-hire_date)/7)+DECODE(TO_CHAR(hire_date,'day'),'wednesday',1,0) "cate miercuri",
      (SYSDate-hire_date)/7 "nr saptamani"
FROM employees;

SELECT DECODE(TO_CHAR(SYSdate,'day'),'wednesday',1,0)
from dual;

SELECT round((SYSDate-hire_date)/7)+DECODE(TO_CHAR(hire_date,'day'),'wednesday',1,0)--de verificat daca round merge bine pe un exemplu concret
from dual;

--ex1
SELECt first_name||' '||last_name||'castiga'||salary||'lunar, dar doreste'||salary*3
FROM employees;
--sau cu concat

--ex2
--SELECt INITCAP(first_name), UPPER(last_name),

--ex3
SELECT employee_id,last_name,first_name,department_id
FROM employees
WHERE TRIM(both ' ' from lower(first_name))='steven';

--
SELECT employee_id, first_name, salary, ROUND(salary* 1.15, 2) "Salariu nou",
ROUND(salary*1.15/100, 2) "Numar sute"
FROM employees
WHERE MOD(salary, 1000)!=0;

--ex9
SELECT last_name AS "Nume angajat" ,
RPAD(TO_CHAR(hire_date),20,' ') "Data angajarii"
FROM employees
WHERE commission_pct IS NOT NULL;

SELECT TO_CHAR(SYSDATE+30, 'MONTH DD HH24:MM:SS') "Data"
FROM DUAL;

--selectati codul si data angajarii, pentru cei care au fost angajati sambata sau duminica
SELECT employee_id,hire_date,to_char(hire_date,'day')
from employees
where lower(to_char(hire_date,'day')) in ('sunday','saturday');

--ex17
SELECT last_name,NVL(TO_CHAR(commission_pct),'FARA COMISION') comision
from employees;

--ex19
SELECT last_name,department_id,manager_id,job_id,salary,
       CASE
          WHEN  department_id=30 then salary*1.1
          WHEN upper(job_id)='IT_PROG' then salary*1.5
          WHEN manager_id=100 then salary*1.8
          else salary end "salariu marit"
FROM employees;

--face produs cartezian-fiecare cu fiecare
SELECT employee_id, last_name,employees.department_id,department_name
FROM employees,departments
ORDER BY employee_id;

--ca sa nu mai faca produs cartezian
SELECT employee_id, last_name,employees.department_id,department_name
FROM employees,departments
WHERE employees.department_id=department.department_id;

--sa se afiseze angajatii, codul al carui nume este palindrom
--SELECT EMPLOYEE_ID id, LAST_NAME nume, JOB_ID "id-ul jobului", HIRE_DATE "data angajarii"
--FROM EMPLOYEES;

--SELECT  LAST_NAME||' ,'||FIRST_NAME||' ,'||JOB_ID||' ,'|| COMMISSION_PCT||' ,'||EMAIL||' ,'||EMPLOYEE_ID||' ,'||HIRE_DATE||' ,'||MANAGER_ID||' ,'||PHONE_NUMBER||' ,'||SALARY||' ,'|| Department_id "informatii complete"
SELECT employee_id,FIRST_NAME, last_name, salary
From EMPLOYEES
WHERE salary like('__5%');
--WHERE TO_CHAR (hire_date,'YYYY')='1987;
--WHERE department_id=30 OR department_id=50
--WHERE salary>=7000 AND SALARY<=10000;
--where salary between 7000 and 10000
--WHERE hire_date BETWEEN '20-FEB-1987' AND '1-May-1989'
--ORDER By 3;
--SELECT to_char(sysdate,'dd/mm/yyyy ; hh24:mi:ss') from dual;
SELECT LAST_NAME,FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
--WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY DESC, COMMISSION_PCT DESC;

select FIRST_NAME, LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE (LOWER(JOB_ID) LIKE ('%clerk%') or LOWER(JOB_ID) LIKE('%rep%')) AND salary not in (1000,2000,3000);--ex 25 lab 1

select first_name, last_name, salary, commission_pct
From employees
where commission_pct is null or salary>5*commission_pct*salary;--ex 26 lab 1

---select first_name, last_name, salary, commission_pct
--From employees
--where commission_pct is null--ex 26 lab 1

select first_name, last_name, salary, commission_pct
From employees
where salary>5*salary*nvl(commission_pct,0); --ex 26 lab 1
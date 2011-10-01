--lab 4 ex 27
--Scrie?i o cerere pentru a afi?a job-ul, salariul total pentru job-ul respectiv pe departamente
--si salariul total pentru job-ul respectiv pe departamentele 30, 50, 80.
--Se vor eticheta coloanele corespunz?tor. Rezultatul va ap?rea sub forma de mai jos:
--Job Dep30 Dep50 Dep80 Total
-- ----------------------------------------------------------------------------
-- ………….
SELECT job_id "JOB", sum(SALARY) , (SELECT sum(salary) FROM employees WHERE department_id=30 and job_id=e.job_id)"DEP 30",
            (SELECT sum(salary) FROM employees WHERE department_id=50 and job_id=e.job_id)"DEP 50", 
            (SELECT sum(salary) FROM employees WHERE department_id=80 and job_id=e.job_id)"DEP 80"
FROM employees e 
GROUP BY job_id
ORDER BY 1;

--sau
SELECT job_id,sum(salary) total,
       sum(DECODE(department_id, 30, salary,0)) "DEPT 30",
       sum(DECODE(department_id, 50, salary,0)) "DEPT 50",
       sum(DECODE(department_id, 80, salary,0))"DEPT 80"

FROM employees
GROUP BY job_id;

--lab 4 ex 28
--S? se creeze o cerere prin care s? se afi?eze num?rul total de angaja?i ?i, din acest total,
--num?rul celor care au fost angaja?i în 1997, 1998, 1999 si 2000. Denumiti capetele de
--tabel in mod corespunzator.
SELECT count(employee_id)"Toti angajati", 
       sum(decode(to_char(hire_date,'YYYY'),1997,1,0)) "Angajati 1997",
       sum(decode(to_char(hire_date,'YYYY'),1998,1,0)) "Angajati 1998",
       sum(decode(to_char(hire_date,'YYYY'),1999,1,0)) "Angajati 1999",
       sum(decode(to_char(hire_date,'YYYY'),2000,1,0)) "Angajati 2000"
FROM employees;

--lab4 ex 31
--S? se afi?eze numele si salariul angajatului, codul departamentului si salariul mediu din departamentul
--respectiv.
SELECT last_name,salary,b.department_id,medie,numar
FROM employees a right join 
(SELECT department_id,avg(salary) medie, count(employee_id) numar
                       FROM employees right join departments using (department_id)
                       GROUP BY department_id) b
                       on (a.department_id=b.department_id);
                       
--lab4 ex 33
--Pentru fiecare departament, s? se afi?eze numele acestuia, numele ?i salariul celor mai
--prost pl?ti?i angaja?i din cadrul s?u.
--sigur bine
SELECT d.department_id,d.department_name,last_name,salary
FROM departments d left JOIN (SELECT e.department_id , last_name, salary
                              FROM employees e right join departments dd on(e.department_id=dd.department_id)
                              WHERE salary=(SELECT min(salary) from employees where department_id=dd.department_id))
                              b on (d.department_id=b.department_id);
                         
--sau??
SELECT b.department_id, department_name, last_name, salary
FROM departments a left join employees b on (a.department_id=b.department_id)
WHERE salary in (SELECT min(salary)
                 FROM employees
                 GROUP BY department_id)
ORDER BY 1;
                 
--sigur corect
SELECT d.department_id, department_name, last_name, salary
FROM departments d left join employees e on (d.department_id=e.department_id)
WHERE salary = (SELECT min(salary)
                 FROM employees
                 WHERE department_id=d.department_id);
                 
 --lab4 ex 26 rollup
SELECT department_id, TO_CHAR(hire_date, 'yyyy'), SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP(department_id, TO_CHAR(hire_date, 'yyyy'));

--cube
SELECT department_id, TO_CHAR(hire_date, 'yyyy'), SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY CUBE(department_id, TO_CHAR(hire_date, 'yyyy'));
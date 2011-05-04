--LAB4 EX 2
SELECT MAX(salary) "salariu maxim" , MIN(salary) "salariu minim", sum (salary)"suma", avg(salary)"media"
FROM employees;
--daca se cerea  pentru fiecare departament, nu afecteaza rezultatul daca adaugam department_id pentru ca fiecare multime
SELECT MAX(salary) "salariu maxim" , MIN(salary) "salariu minim", sum (salary)"suma", avg(salary)"media",department_id
FROM employees
GROUP BY department_id;
--dar afecteaza daca adaugam last_name, tre sa adaugam si la group by -> avem 105, pentru ca sunt cativa care au acelasi last_name
SELECT MAX(salary) "salariu maxim" , MIN(salary) "salariu minim", sum (salary)"suma", avg(salary)"media",department_id,last_name
FROM employees
GROUP BY department_id, last_name;
--luand in considerare departamentele care au mai mult de 10 angajati
SELECT MAX(salary) "salariu maxim" , MIN(salary) "salariu minim", sum (salary)"suma", avg(salary)"media",department_id
FROM employees
GROUP BY department_id
HAVING count(employee_id)>10;

--lab4 ex 3 ->group by job_id

--lab4 ex 5
select count(manager_id) "Manageri"
from employees;

--lab 4 ex 6
SELECT max(salary)-min(salary)"Diferenta"
From employees;

--lab 4 ex 7
SeLECT department_name, location_id, max(salary), min(salary)
FROM departments join employees using (department_id)
Group by department_id, department_name, location_id;

--lab 4 ex 8
--S? se afi?eze codul ?i numele angaja?ilor care câstiga mai mult decât salariul mediu
--din firm?. Se va sorta rezultatul în ordine descresc?toare a salariilor.
SELECT employee_id, last_name,salary
From employees
Where salary>
             (SELECT AVG(salary)
              FROM employees)
Order by salary;

--lab4 ex 9
--Pentru fiecare ?ef, s? se afi?eze codul s?u ?i salariul celui mai prost platit
--subordonat. Se vor exclude cei pentru care codul managerului nu este cunoscut. De
--asemenea, se vor exclude grupurile în care salariul minim este mai mic de 1000$.->6000
--Sorta?i rezultatul în ordine descresc?toare a salariilor.
SELECT manager_id, min(salary)
FROM employees
WHERE manager_id is not null 
HAVING min(salary)>6000
GROUP BY manager_id
ORDER BY 2;

--lab4 ex 10
--Pentru departamentele in care salariul maxim dep??e?te 3000$, s? se ob?in? codul,
--numele acestor departamente ?i salariul maxim pe departament.
SELECT d.department_id,department_name,max(salary)
FROM departments d join employees e on (d.department_id=e.department_id)
HAVING max(salary)>3000
GROUP BY d.department_id,department_name;

--lab4 ex 11
--Care este salariul mediu minim al job-urilor existente? Salariul mediu al unui job va fi
--considerat drept media arirmetic? a salariilor celor care îl practic?.
--salariu mediu
SELECT AVG(salary),job_id
FROM employees
GROUP BY job_id
ORDER BY 1;

--salariu mediu minim
SELECT MIN(AVG(salary))
FROM employees
GROUP BY job_id;

--lab4 ex12
--S? se afi?eze codul, numele departamentului ?i suma salariilor pe departamente.
SELECT department_id,department_name, sum(salary)
FROM employees join departments using (department_id)
GROUP BY department_id,department_name;

--lab4 ex 13
--S? se afi?eze maximul salariilor medii pe departamente.
SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id;

--lab4 ex 14
--S? se obtina codul, titlul ?i salariul mediu al job-ului pentru care salariul mediu este
--minim.
SELECT job_id,job_title,avg(salary)
FROM jobs join employees using (job_id)
GROUP BY job_id, job_title
HAVING avg(salary)=(SELECT min(avg(salary))
                    FROM employees
                    GROUP BY job_id);
        
--lab4 ex 15
--S? se afi?eze salariul mediu din firm? doar dac? acesta este mai mare decât 2500.
--(clauza HAVING f?r? GROUP BY)
SELECT avg(salary)
FROM employees
HAVING avg(salary)>2500;

--lab4 ex 16
--S? se afi?eze suma salariilor pe departamente ?i, în cadrul acestora, pe job-uri.
SELECT sum(salary),department_id,job_id
FROM employees
GROUP BY department_id, job_id
ORDER BY 2;

--lab4 ex 17
--S? se afi?eze numele departamentului si cel mai mic salariu din departamentul
--avand cel mai mare salariu mediu.
SELECT department_name, min(salary)
from employees join departments using (department_id)
GROUP by department_id, department_name
HAVING avg(salary)=(SELECT max(avg(salary))
                    FROM employees
                    GROUP BY department_id);
                    
--lab4 ex 18
--Sa se afiseze codul, numele departamentului si numarul de angajati care lucreaza
--in acel departament pentru:
--a) departamentele in care lucreaza mai putin de 4 angajati;
--b) departamentul care are numarul maxim de angajati.
--a)
SELECT department_id, department_name, count(employee_id)
FROM employees join departments using (department_id)
GROUP By department_id,department_name
HAVING count(employee_id)<4;
--UNION
SELECT department_id, department_name, count(employee_id)
FROM employees join departments using (department_id)
GROUP By department_id,department_name
HAVING count(employee_id)=(SELECT max(count(employee_id))
                           FROM employees
                           GRoup by department_id);

--lab 4 ex 19
--Sa se afiseze salariatii care au fost angajati în aceea?i zi a lunii în care cei mai multi
--dintre salariati au fost angajati.
Select employee_id,to_char(hire_date,'DD')--DDziua din luna
FROM employees
WHERE to_char(hire_date,'DD') = (
                        SELECT to_char(hire_date,'DD')
                        FROM employees
                        GROUP BY to_char(hire_date,'DD')
                        HAVING count(employee_id)=
                                (SELECT max(count(employee_id)) 
                                 FROM employees 
                                 GROUP BY to_char(hire_date,'DD')
                                 ));
                                 
--lab 4 ex 20
--S? se ob?in? num?rul departamentelor care au cel pu?in 15 angaja?i.
select count(department_id) "Numaram"
from employees
group by department_id
having count(employee_id)>15;

--lab 4 ex21
select department_id "Iddd" , sum(salary)
from employees
group by department_id
having count (employee_id)>10 and department_id != 30
order by 2;

--lab 4 ex 23
--Scrieti o cerere pentru a afisa, pentru departamentele avand codul > 80, salariul total
--pentru fiecare job din cadrul departamentului. Se vor afisa orasul, numele
--departamentului, jobul si suma salariilor. Se vor eticheta coloanele corespunzator.
SELECT city,department_name,job_id,sum(salary)
FROM employees join departments using (department_id) join locations using (location_id)
WHERE department_id>80
GROUP BY city,department_name, department_id,job_id;

SELECT city,department_name,job_id,sum(salary)
FROM employees join departments using (department_id) join locations using (location_id)
HAVING department_id>80
GROUP BY city,department_name, department_id,job_id;

--lab4 ex 24
--Care sunt angajatii care au mai avut cel putin doua joburi?
SELECT employee_id
FROM job_history
GROUP BY employee_id
HAVING count(employee_id)>=2;

--lab 4 ex 25
--S? se calculeze comisionul mediu din firm?, luând în considerare toate liniile din tabel.
SELECT (sum(commission_pct)/count(*))
FROM employees;

--sau
SELECT avg(nvl(commission_pct,0))
FROM employees;

--lab 4 ex 30
--S? se afi?eze codul, numele departamentului ?i suma salariilor pe departamente.
SELECT department_id, department_name, sum(salary)
FROM departments join employees using (department_id)
GROUP BY department_id, department_name;
--11-fara cele null
--sau

SELECT department_id, department_name, (SELECT sum(salary) FROM employees WHERE department_id=a.department_id ) "SUMA"
FROM departments a;
--si cele null-27

--sau 
SELECT a.department_id,a.department_name, SUMA
FROM departments a left join (SELECT department_id, sum(salary) SUMA --fara ghilimele
                       FROM employees
                       GROUP BY department_id) b on (a.department_id=b.department_id);
                      
--Sa se afiseze codul, numele departamentului, numarul de angajati si salariul mediu 
--din departamentul respectiv, impreuna cu numele, salariul si jobul angajatilor din acel
--departament. Se vor afi?a ?i departamentele f?r? angaja?i (outer join).
--SELECT department_id,department_name, count(employee_id),avg(salary),last_name,salary,job_id
FROM departments left join employees using (department_id)
--am avea group by department_id,department_name,last_name,saalry,job_id
--deci:
SELECT d.department_id,d.department_name, (SELECT count(employee_id) FROM employees WHERE department_id=d.department_id),(SELECT avg(salary) FROM employees WHERE department_id=d.department_id),last_name,salary,job_id
FROM departments d left join employees e on (d.department_id=e.department_id)GROUP BY d.department_id, d.department_name, last_name, salary, job_id 


--left outer join

select employee_id, last_name, employees.department_id, department_name
from employees, departments
where employees.department_id=departments.department_id(+);


--right outer join

select employee_id, last_name, employees.department_id, department_name
from employees, departments
where employees.department_id(+)=departments.department_id;


--full outer join - cu union - unionul elimina duplicatele

select employee_id, last_name, employees.department_id, department_name
from employees, departments
where employees.department_id=departments.department_id(+)
union
select employee_id, last_name, employees.department_id, department_name
from employees, departments
where employees.department_id(+)=departments.department_id;


-- pt fiecare angajat - codul, numele, seful, numele sefului

select a.employee_id, a.last_name, a.manager_id, b.last_name MANAGER
from employees a, employees b
where a.manager_id=b.employee_id(+);


-- codul, numele departamentelor in care nu lucreaza nici un angajat

select distinct a.department_id, department_name
from departments a, employees b
where b.department_id(+)=a.department_id and b.department_id is null;


-- pt fiecare angajat codul numele, numele departamentului, numele codului

select employee_id, last_name, department_name, c.job_title
from employees a, departments b, jobs c
where a.department_id=b.department_id(+) and a.job_id=c.job_id(+);


-- numele, prenumele, data angajarii pt toti angajatii care au data angajarii mai mare decat cea a lui Grant

select a.last_name, a.first_name, a.hire_date
from employees a, employees b
where a.hire_date > b.hire_date and lower(b.last_name)='grant';


-- fiecare angajat - codul, departamentul, impreuna cu codul tuturor colegii lui de departament

select a.employee_id, a.department_id, b.employee_id
from employees a, employees b
where a.department_id=b.department_id and (a.last_name!=b.last_name or a.first_name!=b.first_name);

-- aceeasi cerinta ca mai sus, doar ca (a,b)=(b,a)

select a.employee_id, a.department_id, b.employee_id
from employees a, employees b
where a.department_id=b.department_id and (a.last_name!=b.last_name or a.first_name!=b.first_name) and a.employee_id < b.employee_id;


-- cel mai mare salariu din firma

select last_name, first_name, salary
from employees 
where employees.salary=(select max(salary) from employees);


--ex 22

select a.last_name, b.department_name, b.location_id
from employees a, departments b
where a.department_id=b.department_id(+) and a.commission_pct is not null;


-- ex 3 lab 3

select a.last_name, a.salary, job_title, city, country_id
from employees a, departments b, locations c, jobs d, employees e
where a.manager_id=e.employee_id and lower(e.last_name)='king' and a.department_id=b.department_id
  and c.location_id = b.location_id and a.job_id=d.job_id;


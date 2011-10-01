
--laboartor 3 ex 2
select distinct a.employee_id, a.last_name,a.department_id, c.department_name
from employees a join employees b on (a.department_id = b.department_id) 
                 join departments c on (a.department_id=c.department_id)
where lower(b.last_name) like '%t%'
order by 2;

--laborator 3 ex 3
select a.last_name, a.salary, c.job_title, e.location_id
from employees a join employees b on (a.manager_id=b.employee_id) 
                 join jobs c on (a.job_id=c.job_id) 
                 join departments d on (a.department_id=d.department_id) 
                 join locations e on (d.location_id=e.location_id)
where lower(b.last_name) like 'king';

--laborator 3 ex 5
select department_id, department_name, last_name, job_id, salary
from employees join departments using (department_id)
where lower (department_name) like '%ti%'
order by 2,3;

--laborator 3 ex 6
select last_name, a.department_id, department_name,city, job_id
from employees a join departments b on (a.department_id=b.department_id) join locations c on (b.location_id = c.location_id)
where lower(city) like 'oxford';

--laborator 3 ex 7
--media salarilor=minsalary+maxsalary/2
select distinct a.employee_id, a.last_name, a.salary
from employees a join employees b on (a.department_id=b.department_id) join jobs c on (a.job_id=c.job_id)
where lower(b.last_name) like '%t%' and a.salary > ((c.min_salary+c.max_salary)/2);

--laborator 3 ex 8
select last_name, department_name
from employees left join  departments using (department_id);--vreau de la employees

--laborator 3 ex 9
select last_name, department_name
from employees right join  departments using (department_id);--vreau de la departments

--laborator 3 ex 10
select last_name, department_name
from employees full join  departments using (department_id);--vreau de la ambele

--left outer join-multimea acelor joinuri care aduc pe langa cele care verifica egalitate si pe cele din partea 'stanga' care sunt deficitare = left join
--right outer join = right join
--full outer join= full join

--operatii pe multimi
--union( union all )->cele doua selecturi trebui e sa intoarca linii compatibile->select union select, intersect, minus

--laborator 3 ex 11
select department_id
from departments
where lower(department_name) like '%re%'
union
select department_id
from employees
where lower(job_id)='sa_rep';
--e deja ordonat

--laborator 3 ex 12
select department_id
from departments
where lower(department_name) like '%re%'
union all
select department_id
from employees
where lower(job_id)='sa_rep';

--laborator 3 ex 13
select department_id
from departments
minus
select department_id
from employees;

--sau cu join
select distinct department_id
from departments left join employees using (department_id)--linii deficitare in departments
where last_name is null;

--laborator 3 ex 14
select department_id
from departments
where lower(department_name) like '%re%'
intersect
select department_id
from employees
where lower(job_id)='hr_rep';
--sau
select b.department_id,b.department_name,a.job_id
from employees a join departments b on (a.department_id=b.department_id)
where lower(department_name) like '%re%'
intersect
select b.department_id,b.department_name,a.job_id
from employees a join departments b on (a.department_id=b.department_id)
where lower(a.job_id)='hr_rep';

--laborator 3 ex 15
select employee_id,job_title,last_name
from employees join jobs using (job_id)
where salary>3000
union 
select employee_id, job_title, last_name
from employees join jobs using (job_id)
where salary>=((min_salary+max_salary)/2);

--subcereri  laborator 3 ex 16
--laborator 3 ex 18
select last_name, salary
from employees
where manager_id = 
        (select employee_id
         from employees
         where manager_id is null);
         
--laborator 3 ex 19
select last_name, department_id, salary
from employees
where department_id in
       (select department_id
        from employees
        where commission_pct is not null) and
        salary in 
        (select salary
         from employees
         where commission_pct is not null);
 
--sau

select last_name, department_id, salary
from employees
where (department_id,salary) in
       (select department_id,salary
        from employees
        where commission_pct is not null);
        --34
        
--laborator 3 ex 20--de facut
select distinct a.employee_id, a.last_name, a.salary
from employees a 
-- employees b on (a.department_id=b.department_id) join jobs c on (a.job_id=c.job_id)
where department_id in (select department_id from employees where a.department_id=department_id);


--lower(b.last_name) like '%t%' and a.salary > ((c.min_salary+c.max_salary)/2);

--laborator 3 ex 21
select last_name
from employees
where salary > all(select salary from employees where lower(job_id) like '%clerk%')
order by  1 desc;
--all-compara cu toate din subcerere
--afisarea angajatilor care castiga mai mult decat cel putin unul dintre cei cu clerk
select last_name
from employees
where salary > any(select salary from employees where lower(job_id) like '%clerk%')
order by  1 desc;

--laborator 3 ex 24
select last_name, department_id, job_id
from employees
where department_id in 
            (select department_id from departments where location_id in
                        (select location_id from locations where lower(city) like 'toronto'));
        
--laborator 3 ex 22
select last_name, department_name, salary
from employees e join departments d on  (e.department_id=d.department_id)
where commission_pct is null and e.manager_id in
                                 (select manager_id --sau daca aveam null->select nvl(manager_id,0)
                                  from employees where commission_pct is not null);
                                 
--laborator 3 ex 23--de vazut de ce nu mere
select last_name,deaprtment_id, salary, job_id
from employees
where (salary,commission_pct) is          
         ( select salary , commission_pct
          from employees join departments using (department_id) join locations using (location_id) where lower(city) like 'oxford');
      --    where location_id is 
       --             (select location_id
       --              from locations
       --              where lower(city) like 'oxford'));
   
--Problema 1 
 --pt fiecare departament sa afiseze numele lui, codul, si un calificativ->mic, mediu,mare dupa regula:
 --daca are mai putin de 5 angajati mic
 --daca 5-10-mediu
 --daca >10-mare
 --de verificat
 select distinct d.department_id, d.department_name, 
            (select count(employee_id)
              from employees 
              where department_id=d.department_id) "numar angajati"
            --, "calificativ"
 from employees e right join departments d on (e.department_id=d.department_id); --group by department_id, "calificativ"s ;
 
 --Problema 2
 --cati angajati sunt in departamentul 50--de verificat
 select department_id, count(employee_id)
 from employees 
 where department_id=50;
 
 --Problema 3
 --fiecare departament,
 --codul_departamentului, 
 --numele_departamentului, 
 --cel mai mare salariu, 
 --data in care s-a facut ultima angajare pentru fiecare departament
 --de verificat
 select distinct e.department_id, d.department_name,
                (SELECT max(salary) from employees where department_id=e.department_id )"max salary",
                (SELECT max(hire_date) from employees where department_id=e.department_id )"max date"
 from employees e right join departments d on (e.department_id=d.department_id )--group by d.department_id, d.department_name)
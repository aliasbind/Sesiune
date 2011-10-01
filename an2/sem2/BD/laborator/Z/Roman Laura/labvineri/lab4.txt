--operatori pe multimi 
--11.
select department_id
from departments 
where lower(department_name) like '%re%'
UNION --all - da si duplicate
select department_id
from employees
where upper(job_id)='SA_REP';

--14
select department_id
from departments 
where lower(department_name) like '%re%'
INTERSECT
select department_id
from employees
where upper(job_id)='HR_REP';

--18.
select first_name, last_name, salary
from employees
where manager_id = (select employee_id
                    from employees
                    where manager_id is NULL);
                    
--19.
select first_name, last_name, department_id, salary
from employees
where (department_id, salary) in (select department_id, salary
                                  from employees
                                  where commission_pct is not null);
                                  
--nume si prenume angajat care castiga cel mai mare salariu din firma

select first_name, last_name
from employees
where salary = (select max(salary) from employees );

select employee_id,salary
from employees
where salary> all(select salary
                  from employees
                  where upper(job_id) like '%CLERK%')
order by salary desc;

select first_name, last_name, department_name, salary
from employees left join departments using (department_id)
where commission_pct is null and
employees.manager_id in (select (nvl(manager_id,0)
                        from employees
                        where commission_pct is not null);
                        
select first_name, last_name, department_id, salary, job_id
from employees
where (salary,commission_pct) in (select salary, commission_pct
                                  from employees join departments using(department_id)
                                  join locations using(location_id)
                                  where lower(city)='oxford');
                                  
select last_name, department_id, job_id
from employees
where department_id=(select department_id
                    from departments join locations using(location_id)
                    where lower(city)='toronto');
                    
-- having - asemanator cu where, doar ca nu pt fiecare linie, ci pt o multime (where se aplica pt fiecare linie)

--exercitii: group by si having
--2.
-- pt fiecare departament; partitioneaza toti angajatii dupa departament
--doar pt dep in care sunt mai mult de 5 angajati
select department_id , max(salary) MAXIM , min(salary) MIN, sum(salary) SUM , avg(salary) AVG, count(employee_id) 
from employees
group by department_id
having count(employee_id)>5;

--media salarii pt jobul in care exista cei mai multi angajati

select avg(salary)
from employees
group by job_id
having count(employee_id)= (select max(count(employee_id))
              from employees
              group by job_id);
            
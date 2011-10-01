select * from employees;
--1
select department_name, job_title, avg(salary), grouping (department_id) , grouping (job_id)
from employees join departments using (department_id) 
join jobs using(job_id) 
group by rollup(department_id, department_name, job_id, job_title);
--2
select department_name, job_title, avg(salary), grouping(department_id), grouping(job_id)
from employees join departments using(department_id)
join jobs using(job_id)
group by cube(department_id, department_name, job_id, job_title);
--3
select department_name, job_title, employees.manager_id, max(salary), sum(salary)
from employees join departments using(department_id) join jobs using(job_id)
group by grouping sets ((department_name, job_title ), (job_title, employees.manager_id), ());
--4
select max(salary) 
from employees 
having max(salary) >15000;
--5a
select employee_id, first_name, salary
from employees a
where salary > (select avg(salary)
                from employees
                where a.department_id = department_id);
                
--5b
select employee_id, first_name, salary, department_id, numar, medie
from employees left join (select department_id , count(employee_id) numar, avg(salary) medie
                    from employees
                    group by department_id) using(department_id);
                    
--subcerere in select

select employee_id, first_name, salary, a.department_id, (select count(employee_id)
                                                        from employees
                                                        where a.department_id=b.department_id) numar, 
                                                        
(select avg(salary)
from employees
where a.department_id=department_id) medie, department_name
from employees a left join departments b on (a.department_id=b.department_id);

--6
select last_name, salary
from employees
where salary > (select max(avg(salary))
               from employees
               group by department_id
               );
               
select  last_name, salary
from employees
where salary > all(select max(avg(salary))
               from employees
               group by department_id
               );
    --7 subcerere sincronizata           
select employee_id, last_name, salary, department_id
from employees a 
where salary = (select min(salary)
              from employees
              where department_id=a.department_id);
 -- subcerere in clauza from             
select employee_id, last_name, salary, department_id
from employees join (select min(salary) s, department_id
                    from employees
                    group by department_id) using (department_id)
where salary = s;

--subcerere nesincronizata
select employee_id, last_name, salary, department_id
from employees
where (salary, department_id) in (select min(salary), department_id
                                  from employees
                                  group by department_id);
--8
select a.department_id, last_name, hire_date
from employees a join departments d on (a.department_id=d.department_id)
where hire_date = (select min(hire_date)
                  from employees
                  where department_id=a.department_id)
order by department_name;

--9
select last_name, department_id
from employees a
where exists (select 'x' --employee_id
              from employees
              where department_id = a.department_id and salary = (select max(salary) 
                                                                  from employees
                                                                 
                                                                  where department_id=30));
                                                                  
--10
select last_name, salary
from employees e
where 2 >= (select count (distinct salary)
          from employees
          where salary > e.salary);
   
select last_name, salary
from (select last_name, salary
    from employees
order by salary desc)
where rownum <= 4; --afis doar primii 4

select last_name, salary from employees where salary in 
(select salary from (select distinct salary 
                    from employees 
                    order by salary desc)
where rownum <4);

--11
select employee_id, last_name, first_name
from employees a
where 2<= (select count(employee_id)
          from employees
          where manager_id = a.employee_id);
          
--12
select location_id
from locations l
where exists(select 'x' 
            from departments
            where location_id=l.location_id);

--13
select department_id
from departments d
where not exists(select '1'
                from employees
                where department_id=d.department_id);
                
--14a
select employee_id, last_name, hire_date, salary, manager_id
from employees a
where manager_id=(select employee_id
                  from employees
                  where lower(last_name) = 'de haan');
                  
--ierarhii (arbori)
--radacina se specifica prin start with 
--legatura intre noduri este data de o relatie : connect by
--top down si bottom up  , data de cuvantul prior
--14b prior este la employee_id
select employee_id, last_name, manager_id
from employees
start with employee_id = (select employee_id
                          from employees
                          where lower(last_name)='de haan')
connect by  employee_id = prior manager_id;

--15
select employee_id, last_name, manager_id, level
from employees
start with employee_id = 100
connect by  prior employee_id =  manager_id;

--16
select employee_id, last_name, manager_id, level
from employees
where level=3
start with employee_id = (select employee_id
                          from employees
                          where lower(last_name)='de haan')
connect by  prior employee_id = manager_id;

--17
select employee_id, last_name, manager_id, level
from employees --tb pt fiecare, deci n-am radacina
connect by employee_id= prior manager_id
order by 1;

--18
select employee_id, salary, last_name
from employees
where salary > 5000
start with employee_id in (select employee_id
                          from employees
                          where salary=(select max(salary)
                                        from employees))
connect by prior employee_id=manager_id; --subalternii lui

--with
with dep_favorite as
(select distinct department_id
from employees
where salary = (select max(salary)
                from employees
                where department_id=30))
select last_name,department_id from employees join dep_favorite using(department_id);
                                        
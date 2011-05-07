select * from employees;

--27.
--partitionez angajatii pt fiecare job, pt fiecare submultime: totalul + niste sume;
--in cadrul fieacrei submultimi, se mai dorea suma salariilor doar daca angajatii sunt in dep 30,50,80
select job_id "job" , sum(salary) "total", (select sum(salary)
                                            from employees
                                            where department_id=30 and job_id = e.job_id) "dep 30",
                                            (select sum(salary)
                                            from employees 
                                            where department_id=50 and job_id = e.job_id) "dep 50", 
                                            (select sum(salary)
                                            from employees 
                                            where department_id=80 and job_id = e.job_id) "dep 80"

from employees e
group by job_id;

--27 cu decode
select job_id, sum(salary) "Total",
sum(decode(department_id, 30, salary, 0)) "dep 30",
sum(decode(department_id,50,salary,0)) "dep 50",
sum(decode)department_id,80,salary,0)) "dep 80"
from employees
group by job_id;

select count(employee_id) , sum(decode(to_char(hire_date,'yyyy'), 1997, 1,0)) ,
sum(decode(to_char(hire_date,'yyyy'), 1998, 1,0)) , sum(decode(to_char(hire_date,'yyyy'), 1999, 1,0)) ,
sum(decode(to_char(hire_date,'yyyy'), 2000, 1,0)) 
from employees;

--31
select employee_id, last_name, b.department_id, medie, numar 
from employees a right join (select department_id, avg(salary) Medie , count(employee_id) Numar
                    from employees right join departments using(department_id)
                    group by department_id) b on(a.department_id=b.department_id);
                    
--33
select d.department_id, department_name, last_name, salary
from departments d left join employees  e on(d.department_id=e.department_id)
where salary = (select min(salary)
              from employees
              where department_id=d.department_id);
--33 cu subcerere in from

select d.department_id, department_name, last_name, salary
from departments d left join (select e.department_id,  last_name, salary
                      from employees e right join departments dd on (e.department_id=dd.department_id)
                      where salary= (select min(salary)
                                    from employees
                                    where department_id=dd.department_id)) auz 
                                    on d.department_id=aux.department_id;
                                    
-- rollup  
--cube: in primul rand, scoate totatlul
--grouping sets 
                                    



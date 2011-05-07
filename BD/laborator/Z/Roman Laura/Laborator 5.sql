select * from employees;
--3
select job_id, max(salary), min(salary), sum(salary), avg(salary)
from employees
group by job_id;
--4
select count(employee_id), job_id
from employees
group by job_id;
--5
select count( distinct manager_id)
from employees;
--6
select max(salary) - min(salary) "diferenta"
from employees;

--7
select department_name, location_id, count(employee_id) , avg(salary)
from employees join departments using(department_id)
group by department_id, department_name, location_id;

--8.
select employee_id, first_name, last_name,salary
from employees
where salary > ( select avg(salary)
                from employees)
order by salary desc;
                
--9
select manager_id, min(salary)
from employees 
where manager_id is not null
group by manager_id
having min(salary) > 1000
order by 2 desc;

--!!! tot ce e simplu in select se trece in group by!!!!!!

--10.
select department_id, department_name, max(salary)
from employees join departments using(department_id)
group by department_id, department_name
having max(salary) > 8000;

--11.
select min(avg(salary)) "Salariu mediu minim"
from employees
group by job_id;

--12.
select department_id , department_name, sum(salary)
from departments join employees using (department_id)
group by department_id, department_name;

--13
select max(avg(salary))
from employees
group by department_id;

--14
select job_id, job_title, avg(salary) 
from employees join jobs using(job_id)
group by job_id, job_title
having avg(salary) = (select min(avg(salary))
                      from employees
                      group by job_id);
                      
--15.
select avg(salary)
from employees
having avg(salary)>2500;

--16.
select sum(salary), department_id, job_id
from employees
group by department_id, job_id;

--17
select department_name, min(salary)
from employees join departments using(department_id)
group by department_id, department_name
having avg(salary)= (select max(avg(salary))
                    from employees
                    group by department_id);

--18.
select department_id, department_name, count(employee_id)
from employees join departments using(department_id)
group by department_id, department_name
having count(employee_id) < 4
UNION
select department_id, department_name, count(employee_id)
from employees join departments using(department_id)
group by department_id, department_name
having count(employee_id) = (select max(count(employee_id))
                              from employees
                              group by department_id);
                              
--19
select employee_id, to_char(hire_date, 'dd')
from employees
where to_char(hire_date,'dd') = (select to_char(hire_date,'dd')
                                  from employees
                                  group by to_char(hire_date,'dd')
                                  having count(employee_id) = (select max(count(employee_id))
                                                              from employees
                                                              group by to_char(hire_date,'dd')));

--20
select count(department_id)
from employees
group by department_id
having count(employee_id)>15;

--21
select department_id ,  sum(salary)
from employees
group by department_id
having count(employee_id) >10 and department_id !=30
order by 2;

--24
select employee_id 
from job_history
group by employee_id
having count(employee_id)>=2;


--23
select sum(salary), department_name, city, job_id
from employees join departments using(department_id)
join locations using(location_id)
--where department_id>80
group by department_name, city, job_id, department_id
having department_id > 80;

--25
select avg(nvl(commission_pct,0))
from employees;

--var2
select sum(commission_pct) / count(*)
from employees;

--cum punem o cere in from sau in select?
--in from -> view-in-line

--30 :standard
select department_id, department_name, sum(salary)
from employees right join departments using(department_id)
group by department_id, department_name;

--30.
select a.department_id, department_name , Miercuri
from departments a left join (select department_id, sum(salary) Miercuri
                       from employees 
                      group by department_id) b
                      on (a.department_id=b.department_id)
                      where b.miercuri>10000;
                      
select department_id, department_name, (select sum(salary)  
                                        from employees 
                                        where department_id=a.department_id) x
from departments a 
where x>10000;  --nu mergeeee :( nu se poate

--22
select d.department_id, department_name, last_name, salary, job_id,
  (select avg(salary)
  from employees
  where d.department_id=department_id) "medie", (select count(employee_id)
                                                  from employees
                                                  where d.department_id=department_id) numar

from employees e right join departments d on (d.department_id=e.department_id);



                
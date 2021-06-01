--Example 1 Basic
select e.first_name, e.last_name, e.hire_date from employees e;

--Example 2 Selection
select e.employee_id, e.salary from employees e where e.salary>10000;

--Example 3 Cross-product
select e.employee_id, e.first_name, e.last_name, d.department_name from employees e, departments d
where e.department_id=d.department_id and d.department_name='IT';

--Example 4 Expressions and strings
select e.employee_id, e.salary, e.salary+1000 as pay_increase from employees e;

--Example 5 Expressions and strings
select e.first_name from employees e where e.first_name like 'D%';

--Example 6 union vs or
select e.first_name, e.last_name, e.salary, l.city from employees e, departments d, locations l 
where (e.salary>10000 or l.city='London') and (e.department_id=d.department_id and d.location_id=l.location_id);

--Example 7 union vs or
select e.first_name, e.last_name, e.salary, l.city from employees e, departments d, locations l 
where e.department_id=d.department_id and d.location_id=l.location_id and e.salary>10000
union
select e.first_name, e.last_name, e.salary, l.city from employees e, departments d, locations l 
where e.department_id=d.department_id and d.location_id=l.location_id and l.city='London';

--Example 8 intersect vs and
select e.first_name, e.last_name, e.hire_date, e.salary, j.min_salary*1.2 as newMin from employees e, jobs j
where e.hire_date<'1999-01-01' and e.job_id=j.job_id
intersect
select e.first_name, e.last_name, e.hire_date, e.salary, j.min_salary*1.2 as newMin from employees e, jobs j
where e.salary<j.min_salary*1.2 and e.job_id=j.job_id;

--Example 9 intersect vs and
select e.first_name, e.last_name, e.hire_date, e.salary, j.min_salary*1.2 as newMin from employees e, jobs j
where e.job_id=j.job_id and e.hire_date<'1999-01-01' and e.salary<j.min_salary*1.2;

--Example 10 except
select e.first_name, e.last_name, l.country_id from employees e, departments d, locations l
where e.department_id=d.department_id and d.location_id=l.location_id
except
select e.first_name, e.last_name, l.country_id from employees e, departments d, locations l
where e.department_id=d.department_id and d.location_id=l.location_id and l.country_id='US';

--Example 11 nested
select e.first_name, e.last_name, l.country_id from employees e, departments d, locations l
where e.department_id=d.department_id and d.location_id=l.location_id and l.country_id in (select l.country_id from locations l where l.country_id='US');

--Example 12 correlated nested
select e.first_name, e.last_name, l.country_id from employees e, locations l
where exists (select * from departments d where l.country_id='US' and e.department_id=d.department_id and d.location_id=l.location_id);

--Example 13 set-comparison operators
select e.first_name, e.last_name, e.salary from employees e
where e.job_id=9 and e.salary > any (select e2.salary from employees e2 where e2.job_id=16);

--Example 14 aggregate operators
select avg(e.salary) as Average_Salary from employees e;

--Example 15 aggregate operators
select avg(e.salary) as Average_Programmer_Salary from employees e where e.job_id=9;

--Example 16 aggregate operators
select e.salary, avg(e.salary) as Average_Programmer_Salary from employees e where e.job_id=9;

--Example 17 aggregate operators
select e.first_name, e.last_name, e.hire_date from employees e where e.hire_date=(select min (e2.hire_date) from employees e2);
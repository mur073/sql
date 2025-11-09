-- 1. Вывести сотрудников с зарплатой выше средней по компании
select *
from employees e
where e.salary > (select avg(e.salary) from employees e);

-- 2. Вывести продукты дороже среднего
select *
from products p
where p.price > (select avg(price) from products);

-- 3. Вывести отделы, где есть хотя бы один сотрудник с зарплатой > 10 000
select *
from departments d
where d.id in (select e.department_id from employees e where e.salary > 10000);

-- 4. Вывести продукты, которые чаще всего встречаются в заказах
select p.id, p.name, count(*)
from products as p
join order_items as oi on oi.product_id = p.id
group by p.id, p.name
order by count(*) desc
limit 5;

-- 5. Вывести для каждого клиента количество его заказов
select  c.id, c.name, count(o.id) as orders_count
from customers c
left join orders o
	on o.customer_id = c.id
group by c.id, c.name;

-- 6. Вывести топ 3 отдела по средней зарплате
select  d.id, d.name, avg(e.salary) as avg_salary
from departments d
join employees e
	on e.department_id = d.id
group by d.id, d.name
order by avg_salary desc
limit 3;

-- 7. Вывести клиентов без заказов
select *
from customers c
where c.id not in (select distinct o.customer_id from orders o);

-- 8. Вывести сотрудников, зарабатывающих больше, чем любой из менеджеров.
select *
from employees e
where e.salary > (
	select max(e1.salary)
	from employees e1
	where e1.manager_id is null
);

-- 9. Вывести отделы, где все сотрудники зарабатывают выше 5000.
select *
from departments d
where d.id in (
	select e.department_id
	from employees e
	group by e.department_id
	having min(e.salary) > 5000
);

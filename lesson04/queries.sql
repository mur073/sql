-- 1. Вывести employee.id, employee.name, department.name — сотрудники без отдела должны показать No Department.
select e.id, e.name, COALESCE(d.name, 'No Department')
from employees e
left join departments d
	on e.department_id = d.id;


-- 2. Сотрудники, у которых есть менеджер (показать имя сотрудника и имя менеджера).
select e.name as employee_name, m.name as manager_name
from employees e
join employees m
	on e.manager_id = m.id;

-- 3. Отделы без сотрудников.
select d.id, d.name as department_name
from departments d
where d.id not in (select distinct e.department_id from employees e where e.department_id is not null);

-- 4. Все заказы с именем сотрудника и именем клиента — если employee или customer отсутствует, показывать No Employee / No Customer.
select
	o.id as order_id,
	COALESCE(e.name, 'No Employee') as employee_name, 
	COALESCE(c.name, 'No Customer') as customer_name
from orders o
left join employees e
	on o.employee_id = e.id
left join customers c
	on o.customer_id = c.id;

-- 5. Список заказов с товарами: для каждого заказа вывести order_id, product_name, quantity. Показать также заказы без позиций.
select o.id as order_id, p.name as product_name, oi.quantity
from orders o
left join order_items oi
	on o.id = oi.order_id
left join products p
	on oi.product_id = p.id;

-- 6. Для каждого отдела — все заказы (через сотрудников этого отдела); включать отделы с нулём заказов.
select d.name as department, e.name as employee_name, o.id as order_id
from departments d
left join employees e
	on d.id = e.department_id
inner join orders o
	on e.id = o.employee_id
group by d.id, e.id, o.id;

-- 7. Найти пары клиентов и продуктов, которые этот клиент никогда не покупал (т.е. построить Cartesian клиент×продукт и исключить реальные покупки).
select 
	c.name as customer_name,
	p.name as product_name
from customers c
cross join products p
where concat(
	cast(c.id as varchar),
	'-',
	cast(p.id as varchar)
) not in (
	select
	concat(
		cast(o.customer_id as varchar),
		'-',
		cast(p.id as varchar)
	)
	from order_items oi
	join products p
		on oi.product_id = p.id
	join orders o
		on oi.order_id = o.id
)
group by c.name, p.name;

-- 8. Показать, какие продукты никогда не продавались.
select p.id as product_id, p.name as product_name
from products p
where p.id not in (select distinct oi.product_id from order_items oi);

-- 9. Для каждого менеджера — показать суммарную сумму заказов, оформленных его подчинёнными.
select
    m.id as manager_id,
    m.name as manager,
    sum(o.amount) as orders_amount
from employees e
join employees m
	on e.manager_id = m.id
join orders o 
	on o.employee_id = e.id
group by m.id, m.name;

-- 10. Общее количество заказов и суммарная выручка (amount).
select count(*) as orders_count, sum(amount) as total_amount
from orders o;


-- 11. Средняя и максимальная зарплата по отделам.
select
	COALESCE(d.name, 'No Department') as department,
	avg(e.salary) as average_salary,
	max(e.salary) as max_salary
from employees e
left join departments d
	on e.department_id = d.id
group by department;

-- 12. Для каждого заказа — общее количество товаров (sum quantity) и уникальных позиций (count distinct product_id).
select
    oi.order_id,
    sum(oi.quantity) as quantity,
    count(distinct oi.product_id) as unique_products
from order_items oi
group by oi.order_id
order by oi.order_id;


-- 13. Топ-3 продукта по суммарной выручке (price*quantity).
select p.id as product_id, p.name as product_name, sum(p.price * oi.quantity) as revenue
from order_items oi
join products p
	on oi.product_id = p.id
group by p.id
order by revenue desc
limit 3;


-- 14. Количество клиентов, у которых есть хотя бы один заказ.
select count(distinct customer_id) as count
from orders
where customer_id is not null;

-- 15. Для каждого отдела — количество сотрудников, средняя зарплата, суммарная сумма заказов (через сотрудников этого отдела).
select
    d.id as department_id,
    d.name as department,
    count(distinct e.id) as employees_count,
    avg(e.salary) as avg_salary,
    COALESCE(SUM(o.amount), 0) as total_orders
from departments d
left join employees e
	on e.department_id = d.id
left join orders o 
	on o.employee_id = e.id
group by d.id, d.name
order by d.id;


-- 16. Найти клиентов, чья средняя сумма заказа выше средней по всем заказам.
select
    c.id as customer_id,
    c.name as customer_name
from customers as c
join orders as o
	on o.customer_id = c.id
group by c.id, c.name
having avg(o.amount) > (
    select avg(amount)
    from orders
    where amount is not null
);

-- 17. Сформировать полное имя сотрудника
-- ??? у нас ведь в модели юзера есть только поле `name`, что подразумевает что мы храним имя+фамилия

-- 18. Вывести дату заказа в формате DD.MM.YYYY HH24:MI.
select id, to_char(order_date, 'DD.MM.YYYY HH24:MI') as order_date
from orders;

-- 19. Найти заказы старше N дней (параметр)
select id, order_date
from orders
where order_date < CURRENT_TIMESTAMP - interval '2 days'; -- n days


-- 20. Для таблицы employees: заменить NULL в salary на 0 в вычислениях и вывести salary + bonus (bonus = 10% для определённой позиции).
select
    id,
    name,
    position,
    case
        when position = 'Junior Support'
        	then COALESCE(salary, 0) * 0.1 else 0
    end as bonus,
    case
        when position = 'Junior Support'
            then COALESCE(salary, 0) * 0.1 else 0
    end + COALESCE(salary, 0) as total
from employees;


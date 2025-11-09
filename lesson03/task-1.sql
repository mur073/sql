CREATE TABLE sales (
   id SERIAL PRIMARY KEY,
   region VARCHAR(20),
   amount BIGINT,
   sale_date DATE
);
INSERT INTO sales (region, amount, sale_date) VALUES
('North', 1000, '2024-01-01'),
('South', 700, '2024-01-02'),
('North', 500, '2024-01-03'),
('West', NULL, '2024-01-04'),
('South', 900, '2024-01-05'),
('North', 1500, '2024-01-06');


-- 1. Найди сумму продаж по каждому региону.
SELECT region, SUM(amount) as sales_amount
FROM sales
GROUP BY region;


-- 2. Покажи среднюю сумму продаж по регионам, где больше одной продажи.
SELECT region, AVG(amount) as average_sales_amount, COUNT(region) as sales_count
FROM sales
GROUP BY region
HAVING COUNT(region) > 1;


-- 3. Найди регион с максимальной суммой продаж.
SELECT region, SUM(amount) as max_sales_amount
FROM sales
WHERE amount is not null
GROUP BY region
ORDER BY max_sales_amount desc
LIMIT 1;


-- 4. Выведи общее количество продаж и сколько из них имеют ненулевую сумму.
SELECT region, COUNT(*) as sales_count, COUNT(*) FILTER (WHERE amount != 0) as not_zero_sales_count
FROM sales
GROUP BY region;


-- 5. Покажи регионы, где продажи превышают среднюю по всем регионам.
SELECT region, SUM(amount) sales_amount
FROM sales
GROUP BY region
HAVING SUM(amount) > (
	SELECT AVG(total_amount)
	FROM (
        SELECT SUM(amount) AS total_amount
        FROM sales
        GROUP BY region
    )
)













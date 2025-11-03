-- CREATE TABLE orders (
--     id SERIAL PRIMARY KEY,
--     customer_name TEXT,
--     customer_email TEXT,
--     product_name TEXT,
--     product_price NUMERIC(10,2)
-- );

-- CREATE TABLE order_items (
--     order_id INT,
--     product_id INT,
--     quantity INT,
--     product_name TEXT,
--     PRIMARY KEY (order_id, product_id)
-- );

-- CREATE TABLE customers (
--     id SERIAL PRIMARY KEY,
--     name TEXT,
--     city TEXT,
--     region TEXT
-- );

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    city TEXT,
    region TEXT
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE
);

CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
);
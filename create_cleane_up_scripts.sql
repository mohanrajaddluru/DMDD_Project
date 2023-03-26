--CLEANUP SCRIPT
set serveroutput on
declare
    v_table_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start schema cleanup');
   for i in (select 'BOOKS' table_name from dual union all
             select 'CUSTOMERS' table_name from dual union all
             select 'REVIEWS' table_name from dual union all
             select 'DISCOUNTS' table_name from dual union all
             select 'ORDERS' table_name from dual union all
             select 'SHIPPERS' table_name from dual union all
             select 'ORDERS_DETAILS' table_name from dual union all
             select 'PUBLISHERS' table_name from dual union all
             select 'AUTHORS' table_name from dual union all
             select 'GENRES' table_name from dual
             
   )
   loop
   dbms_output.put_line('....Drop table '||i.table_name);
   begin
       select 'Y' into v_table_exists
       from USER_TABLES
       where TABLE_NAME=i.table_name;

       v_sql := 'drop table '||i.table_name || ' CASCADE CONSTRAINTS';
       execute immediate v_sql;
       dbms_output.put_line('........Table '||i.table_name||' dropped successfully');
       
   exception
       when no_data_found then
           dbms_output.put_line('........Table already dropped');
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;


--BEGIN
--    FOR rec IN (SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLE_NAME IN ('BOOKS', 'AUTHOR', 'ORDER', 'SHIPPERS', 'DISCOUNTS', 'CUSTOMERS', 'PUBLISHERS', 'GENRES', 'REVIEWS', 'ORDER_DETAILS'))
--    LOOP
--        EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS';
--    END LOOP;
--END;

--BEGIN
--   EXECUTE IMMEDIATE 'DROP TABLE books';
--EXCEPTION
--   WHEN OTHERS THEN NULL;
--END;
--CASCADE;

CREATE TABLE authors (
  id           NUMBER(10) PRIMARY KEY,
  first_name   VARCHAR(100),
  second_name  VARCHAR(100),
  company_name VARCHAR(100),
  CHECK ((first_name IS NOT NULL AND second_name IS NOT NULL)
         OR company_name IS NOT NULL)
);

CREATE TABLE publishers (
  id   NUMBER(10) PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE genres (
  id   NUMBER(10) PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE books (
    id NUMBER(10) PRIMARY KEY,
    isbn VARCHAR(13),
    title VARCHAR2(100),
    publication_date DATE,
    edition INTEGER,
    available_quantity INTEGER,
    price NUMERIC(6,2),
    author NUMBER(10),
    publisher NUMBER(10),
    genres_id NUMBER(10),
    FOREIGN KEY (author) REFERENCES authors(ID),
    FOREIGN KEY (PUBLISHER) REFERENCES publishers(ID),
    FOREIGN KEY (genres_id) REFERENCES genres(ID)
    );

--CREATE TABLE authors (
--    id integer PRIMARY KEY REFERENCES books(author),
--    first_name VARCHAR(100),
--    second_name VARCHAR(100),
--    company_name VARCHAR(100)
--);

CREATE TABLE customers (
  id           NUMBER(10) PRIMARY KEY,
  first_name   VARCHAR(100)        NOT NULL,
  last_name    VARCHAR(100)        NOT NULL,
  login        VARCHAR(100) UNIQUE NOT NULL,
  passwordHash VARCHAR(100)        ,
  postal_code  VARCHAR(6)          NOT NULL,
  street       VARCHAR(100)        NOT NULL,
  building_no  VARCHAR(5)          NOT NULL,
  flat_no      VARCHAR(5),
  city         VARCHAR(100)        NOT NULL,
  zip          VARCHAR(10),
  phone_number VARCHAR(9)
);

CREATE TABLE reviews (
    id int PRIMARY KEY,
    book_id int,
    customer_id int,
    rating int,
    review_date Date,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
    );


CREATE TABLE discounts (
    id int primary key,
    name varchar(100),
    discount_value numeric(2,2),
    book_id int,
    discount_expiry date, 
    FOREIGN KEY (book_id) REFERENCES books(id)
    );
    
CREATE TABLE shippers (
    id int primary key,
    name varchar(100),
    phone_number Numeric (10)
    );
    
CREATE TABLE orders (
    id int primary key,
    customer_id int,
    order_date date,
    discount_id int,
    shipper int,
    status varchar(50),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (discount_id) REFERENCES discounts(id),
    FOREIGN KEY (shipper) REFERENCES shippers(id)
    );

CREATE TABLE orders_details(
    book_id int primary key,
    order_id int,
    quantity int,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
    );
    
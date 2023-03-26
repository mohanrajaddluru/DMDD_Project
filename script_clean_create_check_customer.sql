------cleaning up script and creating the tables script in from the application admin script




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
/


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
  building_no  VARCHAR(100)        NOT NULL,
  flat_no      VARCHAR(100),
  city         VARCHAR(100)        NOT NULL,
  zip          VARCHAR(10),
  phone_number VARCHAR(10)
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
    
commit;

select * from customers;

insert into customers (ID, first_name, last_name, LOGIN, PASSWORDHASH, POSTAL_CODE, STREET, BUILDING_NO, FLAT_NO, CITY, ZIP, PHONE_NUMBER) values (1, 'Kissee', 'Caress', 'kcaress0@jimdo.com', '457443f7c9bdc746b50c076615a6a42ea118bef1', '69400', 'Alley', '10', 55, 'Manacapuru', '686008', '9411740307');

DECLARE
  v_customer_id customers.id%TYPE;
  v_customer_email customers.login%TYPE;
BEGIN
  -- Set the customer details
  v_customer_email := 'kcaress0@jmdo.com';
  -- set other customer details as needed

  -- Check if the customer already exists
  BEGIN
    SELECT id INTO v_customer_id
    FROM customers
    WHERE login = v_customer_email;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_customer_id := NULL;
  END;

  -- If the customer already exists, raise an exception
  IF v_customer_id IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'Customer already exists with ID ' || v_customer_id);
  END IF;

  -- If the customer does not exist, create the customer
  INSERT INTO customers (ID, first_name, last_name, LOGIN, PASSWORDHASH, POSTAL_CODE, STREET, BUILDING_NO, FLAT_NO, CITY, ZIP, PHONE_NUMBER)
  VALUES (10, 'Kissee', 'Caress', 'kcaress0@jmdo.com', '457443f7c9bdc746b50c076615a6a42ea118bef1', '69400', 'Alley', '10', 55, 'Manacapuru', '686008', '9411740307');

  -- set other customer details as needed
END;
/
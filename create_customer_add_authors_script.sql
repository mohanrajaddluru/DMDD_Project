set serveroutput on
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
    DBMS_OUTPUT.PUT_LINE(v_customer_email ||' already exists with ID ' || v_customer_id);
    RETURN;
    --RAISE_APPLICATION_ERROR(-20001, 'Customer already exists with ID ' || v_customer_id);
  END IF;

  -- If the customer does not exist, create the customer
  INSERT INTO customers (ID, first_name, last_name, LOGIN, PASSWORDHASH, POSTAL_CODE, STREET, BUILDING_NO, FLAT_NO, CITY, ZIP, PHONE_NUMBER)
  VALUES (10, 'Kissee', 'Caress', 'kcaress0@jmdo.com', '457443f7c9bdc746b50c076615a6a42ea118bef1', '69400', 'Alley', '10', 55, 'Manacapuru', '686008', '9411740307');

  -- set other customer details as needed
END;
/


--select * from customers;





grant select on books to customer;
grant select on authors to customer;
grant select on publishers to customer;
grant select on genres to customer;


grant insert on orders to customer;
commit;






-------------------------------------------------------





DECLARE
  v_id NUMBER(10);
  v_isbn VARCHAR2(13);
  v_title VARCHAR2(100);
  v_publication_date DATE;
  v_edition NUMBER;
  v_available_quantity NUMBER;
  v_price NUMBER(6,2);
  v_author_id NUMBER(10);
  v_publisher NUMBER(10);
  v_genres_id NUMBER(10);
BEGIN
  FOR i IN 1..5 LOOP
    -- Generate random values for each column
    v_id := i;
    v_isbn := DBMS_RANDOM.STRING('A', 6) || DBMS_RANDOM.STRING('N', 6);
    v_title := DBMS_RANDOM.STRING('A', 10) || ' ' || DBMS_RANDOM.STRING('A', 5);
    v_publication_date := TRUNC(SYSDATE - DBMS_RANDOM.VALUE(0, 365*10));
    v_edition := TRUNC(DBMS_RANDOM.VALUE(1, 8));
    v_available_quantity := TRUNC(DBMS_RANDOM.VALUE(0, 100));
    v_price := TRUNC(DBMS_RANDOM.VALUE(10, 1000)*100)/100;
    v_author_id := TRUNC(DBMS_RANDOM.VALUE(1, 5));
    v_publisher := TRUNC(DBMS_RANDOM.VALUE(1, 5));
    v_genres_id := TRUNC(DBMS_RANDOM.VALUE(1, 5));

    -- Insert the random values into the table
    INSERT INTO books (id, isbn, title, publication_date, edition, available_quantity, price, author, publisher, genres_id)
    VALUES (v_id, v_isbn, v_title, v_publication_date, v_edition, v_available_quantity, v_price, v_author_id, v_publisher, v_genres_id);
    END LOOP;
COMMIT;
END;
/
    
-----------generating the genres and the publishers

DECLARE
  v_id NUMBER;
  v_name VARCHAR2(100);
BEGIN
  FOR i IN 1..5 LOOP
    -- Generate random values for each column
    v_id := i;
    v_name := DBMS_RANDOM.STRING('A', 5) || ' ' || DBMS_RANDOM.STRING('A', 5);

    -- Insert the random values into the table
    INSERT INTO publishers (id, name)
    VALUES (v_id, v_name);
  END LOOP;
  COMMIT;
END;
/



select * from genres;


select * from publishers;


insert into Authors (id, first_name, second_name, Company_name) values (1, 'Electra', 'De Bruyn', 'Camido');
insert into Authors (id, first_name, second_name, Company_name) values (2, 'Ruprecht', 'Lafont', 'Youtags');
insert into Authors (id, first_name, second_name, Company_name) values (3, 'Lester', 'Burberry', 'Roombo');
insert into Authors (id, first_name, second_name, Company_name) values (4, 'Niel', 'Burriss', 'Twitterwire');
insert into Authors (id, first_name, second_name, Company_name) values (5, 'Andee', 'Brame', 'Photobug');


select * from authors;

select * from books join authors on books.author=authors.id;

DECLARE
  v_id NUMBER;
  v_first_name VARCHAR2(100);
  v_last_name VARCHAR2(100);
BEGIN
  FOR i IN 1..5 LOOP
    -- Generate random values for each column
    v_id := i;
    v_first_name := DBMS_RANDOM.STRING('A', 5) || ' ' || DBMS_RANDOM.STRING('A', 5);

    -- Insert the random values into the table
    INSERT INTO publishers (id, name)
    VALUES (v_id, v_name);
  END LOOP;
  COMMIT;
END;
/

-------------------------
--application admin cleared the tables

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


commit;


------------------------------
--application admin created the tables

CREATE TABLE authors (
  id           NUMBER(10) PRIMARY KEY,
  first_name   VARCHAR(100) NOT NULL,
  second_name  VARCHAR(100),
  company_name VARCHAR(100) NOT NULL
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
    isbn VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR2(100),
    publication_date DATE,
    edition INTEGER,
    available_quantity INTEGER,
    price NUMBER(4,2),
    author INTEGER,
    publisher INTEGER,
    genres_id INTEGER,
    FOREIGN KEY (author) REFERENCES authors(ID),
    FOREIGN KEY (PUBLISHER) REFERENCES publishers(ID),
    FOREIGN KEY (genres_id) REFERENCES genres(ID)
    );

CREATE TABLE customers (
  id           NUMBER(10) PRIMARY KEY,
  first_name   VARCHAR(100)        NOT NULL,
  last_name    VARCHAR(100)        NOT NULL,
  login        VARCHAR(100) UNIQUE NOT NULL,
  passwordHash VARCHAR(100)        ,
  --postal_code  VARCHAR(6)          NOT NULL,
  street       VARCHAR(100)        NOT NULL,
  building_no  VARCHAR(10)          NOT NULL,
  flat_no      VARCHAR(10),
  city         VARCHAR(100)        NOT NULL,
  zip          VARCHAR(10)         NOT NULL,
  phone_number NUMBER(10)
);

CREATE TABLE reviews (
    id NUMBER(10) PRIMARY KEY,
    book_id NUMBER(10),
    customer_id NUMBER(10),
    rating NUMBER(1),
    review_date Date,
    CONSTRAINT rating_range CHECK (rating >= 1 AND rating <= 5),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
    );


CREATE TABLE discounts (
    id NUMBER(10) primary key,
    name varchar(100),
    discount_value NUMBER(2,2),
    book_id NUMBER(10),
    discount_expiry date, 
    FOREIGN KEY (book_id) REFERENCES books(id)
    );
    
CREATE TABLE shippers (
    id NUMBER(10) primary key,
    name varchar(100),
    phone_number NUMBER(10)
    );
    
CREATE TABLE orders (
    id NUMBER(10) primary key,
    customer_id NUMBER(10),
    order_date date,
    discount_id NUMBER(10),
    shipper NUMBER(10),
    status varchar(50),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (discount_id) REFERENCES discounts(id),
    FOREIGN KEY (shipper) REFERENCES shippers(id)
    );

CREATE TABLE orders_details(
    book_id NUMBER(10) primary key,
    order_id NUMBER(10),
    quantity NUMBER(10),
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
    );


commit;

--deleting sequence for all tables if exits

BEGIN
        EXECUTE IMMEDIATE 'DROP SEQUENCE books_id_seq';
        EXECUTE IMMEDIATE 'DROP SEQUENCE customers_id_seq';
        EXECUTE IMMEDIATE 'DROP SEQUENCE reviews_id_seq' ;
        EXECUTE IMMEDIATE 'DROP SEQUENCE authors_id_seq' ;
        EXECUTE IMMEDIATE 'DROP SEQUENCE genres_id_seq' ;
        EXECUTE IMMEDIATE 'DROP SEQUENCE publishers_id_seq' ;
        EXECUTE IMMEDIATE 'DROP SEQUENCE discounts_id_seq' ;
        EXECUTE IMMEDIATE 'DROP SEQUENCE orders_id_seq' ;
        EXECUTE IMMEDIATE 'DROP SEQUENCE orders_details_id_seq' ;
        EXECUTE IMMEDIATE 'DROP SEQUENCE shippers_id_seq';        
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN
      RAISE;
    END IF;
END;
/

--creating sequence generator for each table
BEGIN
  EXECUTE IMMEDIATE 'CREATE SEQUENCE books_id_seq START WITH 1';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE customers_id_seq START WITH 1';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE reviews_id_seq START WITH 1';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE authors_id_seq START WITH 1';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE genres_id_seq START WITH 1';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE publishers_id_seq START WITH 1';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE discounts_id_seq START WITH 1';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE orders_id_seq START WITH 1';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE orders_details_id_seq START WITH 1';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE shippers_id_seq START WITH 1';
END;
/


insert into Authors (id, first_name, second_name, Company_name) values (authors_id_seq.NEXTVAL, 'Lezley', 'Manthorpe', 'Quatz publishing');
insert into Authors (id, first_name, second_name, Company_name) values (authors_id_seq.NEXTVAL, 'Kaylee', 'Thalmann', 'Mudo publishing');
insert into Authors (id, first_name, second_name, Company_name) values (authors_id_seq.NEXTVAL, 'Marris', 'Tampling', 'Twitterwire publishing');
insert into Authors (id, first_name, second_name, Company_name) values (authors_id_seq.NEXTVAL, 'Roley', 'Millott', 'Twitterlist publishing');
insert into Authors (id, first_name, second_name, Company_name) values (authors_id_seq.NEXTVAL, 'Gisele', 'Lowings', 'Avamba publishing');


grant select on books to customer;
grant select on authors to customer;
grant select on publishers to customer;
grant select on genres to customer;

commit;




select * from authors;

set serveroutput on;

--Drop Tables if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BOOKS';
    EXECUTE IMMEDIATE 'DROP TABLE CUSTOMERS';
    EXECUTE IMMEDIATE 'DROP TABLE REVIEWS';
    EXECUTE IMMEDIATE 'DROP TABLE DISCOUNTS';
    EXECUTE IMMEDIATE 'DROP TABLE ORDERS';
    EXECUTE IMMEDIATE 'DROP TABLE SHIPPERS';
    EXECUTE IMMEDIATE 'DROP TABLE ORDER_DETAILS';  
    EXECUTE IMMEDIATE 'DROP TABLE PUBLISHERS';
    EXECUTE IMMEDIATE 'DROP TABLE AUTHORS';
    EXECUTE IMMEDIATE 'DROP TABLE GENRES';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/


-------- dropping and creating the sequence

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



set serveroutput on
DECLARE
    table_name VARCHAR2(100) := 'authors';
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name || 
    '(id           NUMBER(10) DEFAULT authors_id_seq.nextval PRIMARY KEY ,
    first_name   VARCHAR(100),
    second_name  VARCHAR(100),
    company_name VARCHAR(100),
    CHECK ((first_name IS NOT NULL AND second_name IS NOT NULL)
         OR company_name IS NOT NULL))';
    DBMS_OUTPUT.PUT_LINE('Table ' || table_name || ' created successfully');

EXCEPTION    
    WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ' || table_name || ' ALREADY EXISTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/


---- CREATING publishers TABLES


set serveroutput on
DECLARE
    table_name VARCHAR2(100) := 'publishers';
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name || 
        '(id   NUMBER(10) DEFAULT publishers_id_seq.nextval PRIMARY KEY,
        name VARCHAR(100) UNIQUE NOT NULL)';
    DBMS_OUTPUT.PUT_LINE('Table ' || table_name || ' created successfully');

EXCEPTION    
    WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ' || table_name || ' ALREADY EXISTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

----- CREATING GENRES TABLE

set serveroutput on
DECLARE
    table_name VARCHAR2(100) := 'genres';
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name || 
        '(id   NUMBER(10) DEFAULT genres_id_seq.nextval PRIMARY KEY,
        name VARCHAR(100) UNIQUE NOT NULL)';
    DBMS_OUTPUT.PUT_LINE('Table ' || table_name || ' created successfully');

EXCEPTION    
    WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ' || table_name || ' ALREADY EXISTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

------ CREATING BOOKS TABLE 

set serveroutput on
DECLARE
    table_name VARCHAR2(100) := 'books';
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name || 
        '(id NUMBER(10) DEFAULT books_id_seq.nextval PRIMARY KEY,
        isbn VARCHAR(13) UNIQUE ,
        title VARCHAR2(100),
        publication_date DATE,
        edition INTEGER,
        available_quantity INTEGER,
        price NUMERIC(6,2),
        author NUMBER(10),
        publisher NUMBER(10),
        genres_id NUMBER(10),
        second_author NUMBER(10),
        FOREIGN KEY (author) REFERENCES authors(ID),
        FOREIGN KEY (PUBLISHER) REFERENCES publishers(ID),
        FOREIGN KEY (second_author) REFERENCES authors(ID),
        FOREIGN KEY (genres_id) REFERENCES genres(ID))';
        DBMS_OUTPUT.PUT_LINE('Table ' || table_name || ' created successfully');
EXCEPTION    
    WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ' || table_name || ' ALREADY EXISTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/


------ CREATING BOOKS TABLES 


set serveroutput on
DECLARE
    table_name VARCHAR2(100) := 'customers';
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name || 
        '(id           NUMBER(10) DEFAULT customers_id_seq.nextval PRIMARY KEY,
        first_name   VARCHAR(100)        NOT NULL,
        last_name    VARCHAR(100)        NOT NULL,
        login        VARCHAR(100) UNIQUE NOT NULL,
        passwordHash VARCHAR(100)        ,
        postal_code  VARCHAR(6)          NOT NULL,
        street       VARCHAR(100)        NOT NULL,
        building_no  VARCHAR(5)          NOT NULL,
        flat_no      VARCHAR(5),
        city         VARCHAR(100)        NOT NULL,
        phone_number VARCHAR(10))';
        DBMS_OUTPUT.PUT_LINE('Table ' || table_name || ' created successfully');
EXCEPTION    
    WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ' || table_name || ' ALREADY EXISTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/


------- CREATING REVIEWS TABLE

set serveroutput on
DECLARE
    table_name VARCHAR2(100) := 'reviews';
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name || 
        '(id NUMBER(10) DEFAULT reviews_id_seq.nextval  PRIMARY KEY,
        book_id int,
        customer_id int,
        rating int,
        review_date Date,
        FOREIGN KEY (customer_id) REFERENCES customers(id),
        FOREIGN KEY (book_id) REFERENCES books(id))';
        DBMS_OUTPUT.PUT_LINE('Table ' || table_name || ' created successfully');
EXCEPTION    
    WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ' || table_name || ' ALREADY EXISTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/


------- CREATING DISCOUNTS TABLE

set serveroutput on
DECLARE
    table_name VARCHAR2(100) := 'discounts';
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name || 
        '(id NUMBER(10) DEFAULT  discounts_id_seq.nextval primary key,
        name varchar(100),
        discount_value NUMERIC(4,2),
        book_id NUMBER(10),
        discount_expiry date, 
        FOREIGN KEY (book_id) REFERENCES books(id))';
        DBMS_OUTPUT.PUT_LINE('Table ' || table_name || ' created successfully');
EXCEPTION    
    WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ' || table_name || ' ALREADY EXISTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/


---------- CREATING SHIPPERS DETAILS


set serveroutput on
DECLARE
    table_name VARCHAR2(100) := 'shippers';
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name || 
        '(id NUMBER(10) DEFAULT shippers_id_seq.nextval primary key,
        name varchar(100),
        phone_number Numeric (10))';
        DBMS_OUTPUT.PUT_LINE('Table ' || table_name || ' created successfully');
EXCEPTION    
    WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ' || table_name || ' ALREADY EXISTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/



------------ CREATING ORDERS DETAILS

set serveroutput on
DECLARE
    table_name VARCHAR2(100) := 'orders';
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name || 
        '(id NUMBER(10) DEFAULT orders_id_seq.nextval primary key,
        customer_id int,
        order_date date,
        discount_id int,
        book_id int,
        shipper int,
        status varchar(50),
        FOREIGN KEY (customer_id) REFERENCES customers(id),
        FOREIGN KEY (discount_id) REFERENCES discounts(id),
        FOREIGN KEY (shipper) REFERENCES shippers(id),
        FOREIGN KEY (book_id) REFERENCES books(id))';
        DBMS_OUTPUT.PUT_LINE('Table ' || table_name || ' created successfully');
EXCEPTION    
    WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ' || table_name || ' ALREADY EXISTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/
commit;

--select * from orders;

---------CREATING ORDERS DETAILS TABLES


set serveroutput on
DECLARE
    table_name VARCHAR2(100) := 'orders_details';
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name || 
        '(book_id NUMBER(10) DEFAULT orders_details_id_seq.nextval primary key,
        order_id int,
        quantity int,
        FOREIGN KEY (book_id) REFERENCES books(id),
        FOREIGN KEY (order_id) REFERENCES orders(id))';
        DBMS_OUTPUT.PUT_LINE('Table ' || table_name || ' created successfully');
EXCEPTION    
    WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ' || table_name || ' ALREADY EXISTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/



------------------------------------------------------------------------------------------------------------------------

--creating views for each tables



create or replace view view_books as select * from books;

create or replace view book_reviews as select * from reviews;

create or replace view view_discounts as select * from discounts;

create or replace view view_shippers as select * from shippers;

create or replace view view_authors as select * from authors;

create or replace view view_publishers as select * from publishers;


-----------------------------------------------------------------------------------------------------------------------------

---- creating the procedures in the databaser

create or replace PROCEDURE add_authors (
    p_first_name IN authors.first_name%TYPE,
    p_second_name IN authors.second_name%TYPE,
    p_company_name IN authors.company_name%TYPE
)
IS
BEGIN
    INSERT INTO authors (id,first_name, second_name, company_name)
    VALUES (authors_id_seq.nextval, p_first_name, p_second_name, p_company_name);
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid author, publisher, or genre ID');
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            DBMS_OUTPUT.PUT_LINE('Parent key not found');
        ELSIF SQLCODE = -2292 THEN
            DBMS_OUTPUT.PUT_LINE('Child records already exist');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/
commit;

---------------------


--creating the procedure for publishers


create or replace PROCEDURE add_publishers (
    p_name IN publishers.name%TYPE
)
IS
BEGIN
    INSERT INTO publishers (id,name)
    VALUES (publishers_id_seq.nextval, p_name);
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid author, publisher, or genre ID');
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            DBMS_OUTPUT.PUT_LINE('Parent key not found');
        ELSIF SQLCODE = -2292 THEN
            DBMS_OUTPUT.PUT_LINE('Child records exist');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/
commit;

----------------------creating the procedure for genres

create or replace PROCEDURE add_genres (
    p_name IN genres.name%TYPE
)
IS
    v_genre_name genres.name%TYPE;
BEGIN
    v_genre_name := UPPER(p_name);
    INSERT INTO genres (id,name)
    VALUES (genres_id_seq.nextval, v_genre_name);
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid data');
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            DBMS_OUTPUT.PUT_LINE('Parent key not found');
        ELSIF SQLCODE = -2292 THEN
            DBMS_OUTPUT.PUT_LINE('Child records exist');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/
commit;


----------------------creating the procedure for shippers


CREATE OR REPLACE PROCEDURE add_shippers (
    p_name IN shippers.name%TYPE,
    p_phone_number IN shippers.phone_number%TYPE
)
IS
BEGIN
    INSERT INTO shippers(id,name, phone_number)
    VALUES (shippers_id_seq.nextval,p_name, p_phone_number);
    COMMIT;
END;
/
commit;

----------------------creating the procedure for customers

CREATE OR REPLACE PROCEDURE add_customer (
    p_customer_first_name IN customers.first_name%TYPE,
    p_customer_last_name IN customers.last_name%TYPE,
    p_customer_email IN customers.login%TYPE,
    p_customer_password IN customers.passwordhash%TYPE,
    p_customer_zip IN customers.postal_code%TYPE,
    p_customer_street IN customers.street%TYPE,
    p_customer_building_no IN customers.building_no%TYPE,
    p_customer_flat_no IN customers.flat_no%TYPE,
    p_customer_city IN customers.city%TYPE,
    p_customer_phone IN customers.phone_number%TYPE
)
IS
BEGIN
    INSERT INTO customers (id,first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
    VALUES (customers_id_seq.nextval,LOWER(p_customer_first_name), LOWER(p_customer_last_name), LOWER(p_customer_email), p_customer_password, p_customer_zip, p_customer_street, p_customer_building_no, p_customer_flat_no, p_customer_city, p_customer_phone);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Customer data not added, error: '|| SQLERRM);
END;
/
commit;


----------------------creating the procedure for books

create or replace PROCEDURE add_books (
    p_isbn IN books.isbn%TYPE,
    p_title IN books.title%TYPE,
    p_publication_date IN books.publication_date%TYPE,
    p_edition IN books.edition%TYPE,
    p_available_quantity IN books.available_quantity%TYPE,
    p_price IN books.price%TYPE,
    p_author IN books.author%TYPE,
    p_publisher IN books.publisher%TYPE,
    p_genres_id IN books.genres_id%TYPE,
    p_second_author IN books.second_author%TYPE
)
IS
BEGIN
    INSERT INTO books (id,isbn, title, publication_date, edition, available_quantity, price,author, publisher, genres_id, second_author)
    VALUES (books_id_seq.nextval, p_isbn, p_title, p_publication_date, p_edition, p_available_quantity, p_price, p_author, p_publisher, p_genres_id, p_second_author);
    commit;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate ISBN');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid author, publisher, or genre ID');
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            DBMS_OUTPUT.PUT_LINE('Parent key not found');
        ELSIF SQLCODE = -2292 THEN
            DBMS_OUTPUT.PUT_LINE('Child records exist');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/
commit;

select * from books;

------------------------------------------------------------------------------------------------------------------------------------

-----------creating the add_discounts procedure

set serveroutput on
CREATE OR REPLACE PROCEDURE add_discounts (
    p_name IN discounts.name%TYPE,
    p_discount_value IN discounts.discount_value%TYPE,
    p_book_id IN discounts.book_id%TYPE,
    p_discount_expiry IN discounts.discount_expiry%TYPE
)
IS
BEGIN
    INSERT INTO discounts(id,name, discount_value, book_id, discount_expiry)
    VALUES (discounts_id_seq.nextval,p_name, p_discount_value, p_book_id, p_discount_expiry);
    DBMS_OUTPUT.PUT_LINE('discounts added to table');
    COMMIT;
END;
/
COMMIT;


-----------creating the add_orders procedure

--select * from orders;

--------------- update the order and reduce the available quantity after order is placed

------------add if condition to check the book available or not
set serveroutput on
CREATE OR REPLACE PROCEDURE add_orders (
    p_customer_id IN orders.customer_id%TYPE,
    p_order_date IN orders.order_date%TYPE,
    p_discount_id IN orders.discount_id%TYPE,
    p_book_id IN orders.book_id%TYPE,
    p_shipper IN orders.shipper%TYPE,
    p_status IN orders.status%TYPE
)
IS
    book_quantity NUMBER;
BEGIN
    SELECT available_quantity INTO book_quantity FROM books WHERE id = p_book_id FOR UPDATE;
    IF book_quantity IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Book not found');
        --RAISE_APPLICATION_ERROR(-20002, 'Book not found');
    ELSIF book_quantity <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Selected Book is outof stock!!');
        --RAISE_APPLICATION_ERROR(-20001, 'Book not available');
    ELSE
        INSERT INTO orders(id,customer_id, order_date, discount_id, book_id, shipper, status)
        VALUES (orders_id_seq.nextval,p_customer_id, p_order_date, p_discount_id, p_book_id, p_shipper, p_status);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Order added successfully');
    END IF;
END;
/
commit;

---------------------------------

---trigger updates the book quantity in books table after the insert is executed to the orders table

CREATE OR REPLACE TRIGGER update_book_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
UPDATE books
SET available_quantity = available_quantity - 1
WHERE id = :new.book_id;
END;
/

commit;

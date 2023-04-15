set serveroutput on;

--Drop Tables if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BOOKS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE CUSTOMERS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE REVIEWS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE DISCOUNTS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE ORDERS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE SHIPPERS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE ORDER_DETAILS CASCADE CONSTRAINTS';  
    EXECUTE IMMEDIATE 'DROP TABLE PUBLISHERS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE AUTHORS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE GENRES CASCADE CONSTRAINTS';
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
        book_id NUMBER,
        customer_id NUMBER,
        rating NUMBER CHECK (rating >= 1 AND rating <= 10),
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
        discount_value NUMBER,
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
        customer_id NUMBER,
        order_date date,
        discount_id NUMBER,
        book_id NUMBER,
        final_price NUMBER,
        quantity NUMBER,
        shipper NUMBER,
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
        '(id NUMBER (10) DEFAULT orders_details_id_seq.nextval primary key,
        book_id NUMBER(10),
        order_id NUMBER,
        quantity NUMBER,
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

create or replace view view_orders as select * from orders;

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
EXCEPTION 
    WHEN OTHERS THEN
        IF sqlcode = -2291 or sqlcode = -6512 THEN
            dbms_output.put_line('no parent key found for the added data');
        ELSE
            dbms_output.put_line('error in adding the discounts code');
            RAISE;
        END IF;
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
    p_final_price IN orders.final_price%TYPE,
    p_number_of_books IN orders.quantity%TYPE,
    p_shipper IN orders.shipper%TYPE,
    p_status IN orders.status%TYPE
)
IS
    order_count NUMBER;
    book_quantity NUMBER;
    discount_percentage NUMBER;
    book_price NUMBER;
    discounted_price NUMBER;
    first_order_discount NUMBER;
    discount_coupon NUMBER;
    num_books_ordered NUMBER;
    v_discount_expiry date;
    p_discount_expiry_date discounts.discount_expiry%TYPE;
BEGIN
    SELECT COUNT(*) INTO order_count FROM orders WHERE id = p_customer_id;
    IF p_number_of_books > 5 THEN
        discount_percentage := 30;
    ELSIF order_count = 0 THEN
        first_order_discount := 10;
        SELECT discount_value INTO discount_coupon FROM discounts WHERE id = p_discount_id;
        discount_percentage := first_order_discount + discount_coupon;
    ELSE
        SELECT discount_value INTO discount_percentage FROM discounts WHERE id = p_discount_id;
    END IF;

    SELECT (price*p_number_of_books) - ((price*p_number_of_books) * (discount_percentage / 100)) INTO discounted_price FROM books WHERE id = p_book_id;

    SELECT available_quantity INTO book_quantity FROM books WHERE id = p_book_id FOR UPDATE;

    IF book_quantity < p_number_of_books THEN
        DBMS_OUTPUT.PUT_LINE('Selected Book is low in stock!! cannot complete the order');
    ELSE
        SELECT discount_expiry INTO v_discount_expiry FROM discounts WHERE id = p_discount_id;
        IF p_order_date >  v_discount_expiry THEN
            DBMS_OUTPUT.PUT_LINE('Discount coupon has expired!! cannot complete the order');
        ELSE
            INSERT INTO orders(id,customer_id, order_date, discount_id, book_id, shipper, final_price, quantity, status)
            VALUES (orders_id_seq.nextval,p_customer_id, p_order_date, p_discount_id, p_book_id, p_shipper, discounted_price, p_number_of_books, p_status);
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Order added successfully');
        END IF;
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('some of the entered data not found');
    WHEN OTHERS THEN
        RAISE;
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
    SET available_quantity = available_quantity - :new.quantity
    WHERE id = :new.book_id;
END;
/

commit;


---------------------------------

--creating trigger to add in the order_details table

CREATE OR REPLACE TRIGGER update_order_details
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO orders_details(id, book_id, order_id, quantity) VALUES (orders_details_id_seq.nextval,:new.book_id,:new.id,:new.quantity);
END;
/


---------------------------------


CREATE OR REPLACE PROCEDURE view_order_history (
    customer_id IN orders.customer_id%TYPE
)
IS
    order_id NUMBER;
    order_date date;
    book_title VARCHAR2(225);
    quantity NUMBER;
    total_price NUMBER;
    order_status VARCHAR(225);
BEGIN
    BEGIN
        SELECT orders.id, orders.order_date, (select title from books where id=book_id) as book_title, orders.quantity, orders.final_price, orders.status
        INTO order_id, order_date, book_title, quantity, total_price, order_status
        FROM orders
        WHERE orders.customer_id = customer_id;
    EXCEPTION
        WHEN no_data_found THEN
            order_id := NULL;
            order_date := NULL;
            book_title := NULL;
            quantity := NULL;
            total_price := NULL;
            order_status := NULL;
            dbms_output.put_line('no orders associated with this customer');
    END;
END;
/



----------------------------------------------------------------------------------------------------------------
-------

create or replace procedure order_cancel (
    order_id IN orders.id%TYPE,
    p_customer_id IN orders.customer_id%TYPE
)
IS
BEGIN
    UPDATE orders
    SET status = 'cancelled'
    WHERE id = order_id and customer_id = p_customer_id;
EXCEPTION
    when no_data_found then
        dbms_output.put_line('given order id and customer id does not match');
END;
/


----------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE increase_stock (
    p_book_id IN books.id%TYPE,
    p_quantity IN books.available_quantity%TYPE
)
IS
BEGIN
    UPDATE books
    SET available_quantity = available_quantity + p_quantity
    WHERE id = p_book_id;
    
    dbms_output.put_line(p_quantity || ' added to stock of book with ID ' || p_book_id);
EXCEPTION
    when no_data_found then
        dbms_output.put_line('Book with ID ' || p_book_id || ' does not exist');
END;
/



------------------------------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE add_book_rating(
  p_book_id IN reviews.book_id%TYPE,
  p_customer_id IN reviews.customer_id%TYPE,
  p_rating IN reviews.rating%TYPE,
  p_date IN reviews.review_date%TYPE,
) AS
  v_order_count NUMBER;
BEGIN

  SELECT COUNT(*)
  INTO v_order_count
  FROM orders
  WHERE book_id = p_book_id
  AND customer_id = p_customer_id;
  
  IF v_order_count = 0 THEN
    dbms_output.put_line('Error: Customer has not purchased this book');
  ELSE
    INSERT INTO reviews (id, book_id, customer_id, rating, review_date)
    VALUES (reviews_id_seq.nextval,p_book_id, p_customer_id, p_rating,p_date);
    
    dbms_output.put_line('Rating added for book ' || p_book_id || ' by customer ' || p_customer_id);
    COMMIT;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('Error: ' || SQLERRM);
    ROLLBACK;
END;
/


--------------------------------------------------------------------------------


-------view with most books published by a publisher

CREATE OR REPLACE VIEW most_books_published AS
SELECT p.name AS publisher_name, COUNT(*) AS num_books_published
FROM books b
JOIN publishers p ON b.publisher = p.id
GROUP BY p.name
ORDER BY num_books_published DESC
FETCH FIRST 1 ROW ONLY;


---------view with the books per genre

CREATE or REPLACE VIEW books_per_genre AS
SELECT g.name AS genre, COUNT(b.id) AS book_count
FROM genres g
JOIN books b ON b.genres_id = g.id
GROUP BY g.name

---------view with the number of books by author

CREATE OR REPLACE VIEW NUMBER_OF_BOOKS_BY_AUTHOR AS
SELECT a.first_name || '' '' || a.second_name AS author_name, COUNT(b.id) AS book_count
FROM authors a
JOIN books b ON b.author = a.id
GROUP BY a.first_name, a.second_name


------- view that has most sold books in a location

CREATE or REPLACE VIEW most_sold_genre_by_location AS
SELECT c.city, g.name AS genre_name, COUNT(DISTINCT o.book_id) AS book_count
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN books b ON o.book_id = b.id
JOIN genres g ON b.genres_id = g.id
WHERE o.status = 'confirmed'
GROUP BY c.city, g.name
ORDER BY c.city, book_count DESC;





CREATE VIEW books_details AS
SELECT b.title, b.isbn, a.first_name AS author_name, b.price AS price, p.name AS publisher_name
FROM books b
JOIN authors a ON b.author = a.id
JOIN publishers p ON b.publisher = p.id;
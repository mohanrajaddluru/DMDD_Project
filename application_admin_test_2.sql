------ SCRIPT TO DROP THE TABLES


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

----------- SCRIPTS TO CREATE SEQUENCE

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

---- SCRIPT TO CREATE THE TABLES

---- CREATING AUTHORS TABLES


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

--creates tables upto here 

------------------------------------------------------------------------------------------------------------------------------
--creating the procedure for authors


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
            DBMS_OUTPUT.PUT_LINE('Child records exist');
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
        RAISE_APPLICATION_ERROR(-20002, 'Book not found');
    ELSIF book_quantity <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Book not available');
    ELSE
        INSERT INTO orders(id,customer_id, order_date, discount_id, book_id, shipper, status)
        VALUES (orders_id_seq.nextval,p_customer_id, p_order_date, p_discount_id, p_book_id, p_shipper, p_status);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Order added successfully');
    END IF;
/*EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        INSERT INTO error_log (error_message)
        VALUES (SQLERRM);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);*/
    
END;
/
commit;

--exec application_admin.add_orders(4,sysdate,1,3,3,'confirmed');


--select * from books;

--update books set available_quantity = 0 where id = 3;

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

----------------creating the sales executive user 

set serveroutput on
DECLARE
   user_exist INTEGER;
BEGIN
   SELECT COUNT(*) INTO user_exist FROM all_users WHERE username = 'SALES_EXECUTIVE';
   IF user_exist > 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER sales_executive CASCADE';
            DBMS_OUTPUT.PUT_LINE('User dropped successfully.');
            EXECUTE IMMEDIATE 'CREATE USER sales_executive IDENTIFIED BY "Sales_Password@321"';
            EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO sales_executive';
            DBMS_OUTPUT.PUT_LINE('User CREATED successfully.');
            EXECUTE IMMEDIATE 'GRANT INSERT, SELECT, UPDATE, DELETE ON application_admin.discounts TO sales_executive';
            EXECUTE IMMEDIATE 'GRANT SELECT ON discounts_id_seq TO sales_executive';
            EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_discounts TO sales_executive';

            DBMS_OUTPUT.PUT_LINE('User granted privileges successfully.');
        EXCEPTION
            WHEN OTHERS THEN
            IF SQLCODE!=-1918 THEN
                DBMS_OUTPUT.PUT_LINE('Currently user is connected cannot be deleted');
            END IF;
        END;
    ELSE 
        EXECUTE IMMEDIATE 'CREATE USER sales_executive IDENTIFIED BY "Sales_Password@321"';
        DBMS_OUTPUT.PUT_LINE('User CREATED successfully.');
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO sales_executive';
        EXECUTE IMMEDIATE 'GRANT INSERT, SELECT, UPDATE, DELETE ON application_admin.discounts TO sales_executive';
        EXECUTE IMMEDIATE 'GRANT SELECT ON discounts_id_seq TO sales_executive';
        EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_discounts TO sales_executive';
        DBMS_OUTPUT.PUT_LINE('User granted privileges successfully.');
        
   END IF;    
END;
/
commit;

select * from customers;
------------------------------------------------ creating customer role 

set serveroutput on
DECLARE
   user_exist INTEGER;
BEGIN
   SELECT COUNT(*) INTO user_exist FROM all_users WHERE username = 'CUSTOMER';
   IF user_exist > 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER CUSTOMER CASCADE';
            DBMS_OUTPUT.PUT_LINE('User dropped successfully.');
            EXECUTE IMMEDIATE 'CREATE USER customer IDENTIFIED BY "Custom_Password@321"';
            EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO CUSTOMER';
            DBMS_OUTPUT.PUT_LINE('User CREATED successfully.');
            EXECUTE IMMEDIATE 'GRANT SELECT ON application_admin.books TO CUSTOMER';
            --EXECUTE IMMEDIATE 'GRANT SELECT ON discounts_id_seq TO sales_executive';
            EXECUTE IMMEDIATE 'GRANT SELECT ON books_details TO customer';
            EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_orders TO customer';
            DBMS_OUTPUT.PUT_LINE('User granted privileges successfully.');
        EXCEPTION
            WHEN OTHERS THEN
            IF SQLCODE!=-1918 THEN
                DBMS_OUTPUT.PUT_LINE('Currently user is connected cannot be deleted');
            END IF;
        END;
    ELSE 
        EXECUTE IMMEDIATE 'CREATE USER customer IDENTIFIED BY "Custom_Password@321"';
        DBMS_OUTPUT.PUT_LINE('User CREATED successfully.');
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO CUSTOMER';
        EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_customer to CUSTOMER';
        EXECUTE IMMEDIATE 'GRANT SELECT application_admin.books TO CUSTOMER';
        EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_orders TO CUSTOMER';
        DBMS_OUTPUT.PUT_LINE('User granted privileges successfully.');
        
   END IF;    
END;
/
commit;

------------------------------------------------------------------------------------------------------------------------------------

set serveroutput on
DECLARE
   user_exist INTEGER;
BEGIN
   SELECT COUNT(*) INTO user_exist FROM all_users WHERE username = 'MANAGER';
   IF user_exist > 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER MANAGER CASCADE';
            DBMS_OUTPUT.PUT_LINE('User dropped successfully.');
            EXECUTE IMMEDIATE 'CREATE USER MANAGER IDENTIFIED BY "Manage_Password@321"';
            EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO MANAGER';
            DBMS_OUTPUT.PUT_LINE('User CREATED successfully.');
            --EXECUTE IMMEDIATE 'GRANT SELECT ON application_admin.books TO CUSTOMER';
            --EXECUTE IMMEDIATE 'GRANT SELECT ON discounts_id_seq TO sales_executive';
            EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_books, add_publishers, add_authors, add_shippers, add_genres TO MANAGER';
            EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_shippers TO MANAGER';
            --EXECUTE IMMEDIATE 'GRANT EXECUTE ON  TO MANAGER';
            --EXECUTE IMMEDIATE 'GRANT SELECT ON books_details TO customer';
            --EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_orders TO customer';
            DBMS_OUTPUT.PUT_LINE('User granted privileges successfully.');
        EXCEPTION
            WHEN OTHERS THEN
            IF SQLCODE!=-1918 THEN
                DBMS_OUTPUT.PUT_LINE('Currently user is connected cannot be deleted');
            END IF;
        END;
    ELSE 
        EXECUTE IMMEDIATE 'CREATE USER MANAGER IDENTIFIED BY "Manage_Password@321"';
        DBMS_OUTPUT.PUT_LINE('User CREATED successfully.');
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO MANAGER';
        EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_books, add_publishers, add_authors, add_shippers, add_genres TO MANAGER';
        EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_shippers TO MANAGER';
        --EXECUTE IMMEDIATE 'GRANT SELECT application_admin.books TO customer';
        --EXECUTE IMMEDIATE 'GRANT EXECUTE ON add_orders TO customer';
        DBMS_OUTPUT.PUT_LINE('User granted privileges successfully.');
        
   END IF;    
END;
/
commit;

------------------------------------------------------------------------------------------------------------------------------------

----------------adding shipper details

exec add_shippers('ABC Shipping', 5551234567);
exec add_shippers('XYZ Shipping', 5552345678);
exec add_shippers('Acme Shipping', 5555678901);
exec add_shippers('Globe Shipping', 5554567890);
exec add_shippers('Oceanic Shipping', 5556789012);
exec add_shippers('Transglobal Logistics', 5553456789);
exec add_shippers('Fast Track Shipping', 5552345678);
exec add_shippers('Ocean Blue Logistics', 5557890123);


select * from shippers;
----------------adding publishers details

exec add_publishers ('Daugherty-Collier publishing');
exec add_publishers ('Boyer LLC publishing');
exec add_publishers ('Kemmer-Shanahan publishing');
exec add_publishers ('Bailey, Wyman and Zulauf publishing');
exec add_publishers ('McDermott-Bergstrom publishing');
exec add_publishers ('Fay and Sons publishing');
exec add_publishers ('Adams and Sons publishing');
exec add_publishers ('O''Keefe-Rath publishing');
exec add_publishers ('Rosenbaum Group publishing');
exec add_publishers ('Cole Group publishing');

select * from publishers;

-----------------------adding authors details

exec add_authors ('Leda', 'Dupree', 'Schuppe, Kling and Koepp');
exec add_authors ('Shayne', 'Steffan', 'Kautzer Inc');
exec add_authors ('Anatola', 'Aveline', 'Breitenberg Group');
exec add_authors ('Lesly', 'Delhay', 'Haag Group');
exec add_authors ('Virginie', 'Amey', 'Jacobi, Wuckert and Yundt');
exec add_authors ('Charleen', 'Selley', 'Mitchell LLC');
exec add_authors ('Meredithe', 'Stanbra', 'Hilll-Nicolas');
exec add_authors ('Zolly', 'Kilvington', 'Feeney-Schimmel');
exec add_authors ('Zolly', 'Kilvington', 'Feeney-Schimmel');
exec add_authors ('Aluino', 'Thairs', 'Renner-Donnelly');
exec add_authors ('Jamima', 'Dunthorne', 'Haag, Feest and Mante');

select * from authors;

-----------------------adding genre details

exec add_genres ('DRAMA');
exec add_genres ('Comedy');
exec add_genres ('Musical');
exec add_genres ('Horror');
exec add_genres ('Action');
exec add_genres ('Romantic');
exec add_genres ('sci-fi');
exec add_genres ('Documentry');
exec add_genres ('poetry');
exec add_genres ('mystery');
exec add_genres ('Humor');

select * from genres;

----------------------adding customers data to the table

exec add_customer('John', 'Doe', 'johndoe@example.com', 'password123', '123456', 'Main Street', '123', NULL, 'Anytown', '5551234567');
exec add_customer('Jane', 'Smith', 'janesmith@example.com', 'password456', '234567', 'Maple Avenue', '456', '20B', 'Someville', '5555678901');
exec add_customer('Bob', 'Johnson', 'bobjohnson@example.com', 'password789', '345678', 'Oak Boulevard', '789', NULL, 'Othercity', '5559101112');
exec add_customer('Alice', 'Williams', 'alicewilliams@example.com', 'passwordabc', '456789', 'Pine Street', '321', '10C', 'Anotherplace', '5551212123');
exec add_customer('Emily', 'Davis', 'emilydavis@example.com', 'passworddef', '567890', 'Cedar Road', '456', NULL, 'Anytown', '5552345678');
exec add_customer('Charlie', 'Garcia', 'charliegarcia@example.com', 'passwordeg', '678901', 'Spruce Street', '789', '5D', 'Someville', '5556789012');
exec add_customer('Olivia', 'Brown', 'oliviabrown@example.com', 'passwordhij', '789012', 'Elm Avenue', '123', NULL, 'Othercity', '5551234567');
exec add_customer('Daniel', 'Wilson', 'danielwilson@example.com', 'passwordklm', '890123', 'Maple Street', '456', '11A', 'Anotherplace', '5555678901');
exec add_customer('Sophia', 'Lopez', 'sophialopez@example.com', 'passwordnop', '901234', 'Oak Lane', '789', '7B', 'Anytown', '5559101112');
exec add_customer('William', 'Taylor', 'williamtaylor@example.com', 'passwordqrs', '012345', 'Pine Road', '321', NULL, 'Someville', '5556667779');
exec add_customer('William', 'Taylor', 'williamtaylcqecdqeor@example.com', 'passwordqrs', '012345', 'Pine Road', '321', NULL, 'Someville', '5556667779');

select * from customers;
----------------------adding books data to the table
--select * from customers;
------------------------------------------------------------------------------------------

exec add_books('071565262-16', 'Python', '12-Mar-2010', 5, 15, 23.10, 3, 4, 2, 6);

exec add_books('071565216-16', 'Faily Tales', '12-Mar-2010', 5, 9, 23.10, 9, 4, 2, 6);

exec add_books('071235216-16', 'Faily books', '10-Feb-2023', 1, 2, 2.1, 4, 2, 1, 9);

exec add_books('091565216-16', 'data base', '9-Dec-2022', 1, 4, 6.30, 2, 1, 5, 4);

exec add_books('091569316-91', 'algotithms', '1-Jun-2010', 2, 13, 5.40, 9, 3, 6, 9);

select * from books;
----------------------adding books data to the table


exec add_discounts ('special10', 20, 1, '21-June-2023');
  
select * from discounts;
select * from orders;
------------------------------------------------------------------------------------------------------------------------------------

------------------creating the views for the customers to show the books details

set serveroutput on
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP VIEW books_details';
        DBMS_OUTPUT.PUT_LINE('dropped books_details view');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE VIEW books_details AS
                       SELECT b.title, b.isbn, a.first_name author_name, b.price AS price, p.name AS publisher_name, b.available_quantity
                       FROM books b
                       JOIN authors a ON b.author = a.id
                       JOIN publishers p ON b.publisher = p.id';
    DBMS_OUTPUT.PUT_LINE('created the books_details view');
    BEGIN
        EXECUTE IMMEDIATE 'GRANT SELECT ON books_details TO customer';
        DBMS_OUTPUT.PUT_LINE('provided the select previleges to the customer user for books_details view');
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -1917 THEN
            DBMS_OUTPUT.PUT_LINE('customer user does not exist as of now so ignoring the providing the view previleges');
        END IF;
    END;
    DBMS_OUTPUT.PUT_LINE('provided the select previleges to the customer user for books_details view');
END;
/
commit;

-------------  creating view for the number of books in the each genre

set serveroutput on
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP VIEW books_per_genre';
        DBMS_OUTPUT.PUT_LINE('dropped books_per_genre view');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE VIEW books_per_genre AS
                       SELECT g.name AS genre, COUNT(b.id) AS book_count
                       FROM genres g
                       JOIN books b ON b.genres_id = g.id
                       GROUP BY g.name';
    DBMS_OUTPUT.PUT_LINE('created books_per_genre view');
    BEGIN
        EXECUTE IMMEDIATE 'GRANT SELECT ON books_per_genre TO sales_executive';
        DBMS_OUTPUT.PUT_LINE('provided the select previleges to the customer user for books_details view');
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -1917 THEN
            DBMS_OUTPUT.PUT_LINE('customer user does not exist as of now so ignoring the providing the view previleges');
        END IF;
    END;
    DBMS_OUTPUT.PUT_LINE('provided view access of books_per_genre to the sales_executive');
END;
/
commit;

----------------creating view to see the number of books by author;
set serveroutput on
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP VIEW NUMBER_OF_BOOKS_BY_AUTHOR';
        DBMS_OUTPUT.PUT_LINE('dropped NUMBER_OF_BOOKS_BY_AUTHOR view');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                RAISE;
            END IF;
    END;

    EXECUTE IMMEDIATE 'CREATE VIEW NUMBER_OF_BOOKS_BY_AUTHOR AS
                       SELECT a.first_name || '' '' || a.second_name AS author_name, COUNT(b.id) AS book_count
                       FROM authors a
                       JOIN books b ON b.author = a.id
                       GROUP BY a.first_name, a.second_name';
    DBMS_OUTPUT.PUT_LINE('created NUMBER_OF_BOOKS_BY_AUTHOR view');
    BEGIN
        EXECUTE IMMEDIATE 'GRANT SELECT ON NUMBER_OF_BOOKS_BY_AUTHOR TO sales_executive';
        DBMS_OUTPUT.PUT_LINE('provided the select previleges to the customer user for books_details view');
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -1917 THEN
            DBMS_OUTPUT.PUT_LINE('customer user does not exist as of now so ignoring the providing the view previleges');
        END IF;
    END;
    DBMS_OUTPUT.PUT_LINE('provided view access of NUMBER_OF_BOOKS_BY_AUTHOR to the sales_executive');
END;
/

commit;

--select * from authors;

-------------------- creating the list of books_order_by_rating view and providing the access to the sales_executive


set serveroutput on
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP VIEW LIST_OF_BOOKS_ORDER_BY_RATING';
        DBMS_OUTPUT.PUT_LINE('View LIST_OF_BOOKS_ORDER_BY_RATING dropped successfully');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE VIEW LIST_OF_BOOKS_ORDER_BY_RATING AS
                       SELECT b.title, r.rating
                       FROM books b
                       JOIN reviews r ON b.id = r.book_id
                       ORDER BY r.rating DESC';
    DBMS_OUTPUT.PUT_LINE('View LIST_OF_BOOKS_ORDER_BY_RATING created successfully');
     BEGIN
        EXECUTE IMMEDIATE 'GRANT SELECT ON LIST_OF_BOOKS_ORDER_BY_RATING TO sales_executive';
        DBMS_OUTPUT.PUT_LINE('provided the select previleges to the customer user for books_details view');
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -1917 THEN
            DBMS_OUTPUT.PUT_LINE('customer user does not exist as of now so ignoring the providing the view previleges');
        END IF;
    END;
END;
/
commit;

---creating the view to see the most number of books published

DECLARE
    v_publisher_name VARCHAR2(100);
    v_max_books_published NUMBER;
BEGIN
    SELECT p.name, COUNT(*) INTO v_publisher_name, v_max_books_published
    FROM books b
    JOIN publishers p
    ON b.publisher = p.id
    GROUP BY p.name
    ORDER BY COUNT(*) DESC
    FETCH FIRST 1 ROW ONLY;
    DBMS_OUTPUT.PUT_LINE('Publisher with most books published: ' || v_publisher_name);
    DBMS_OUTPUT.PUT_LINE('Number of books published: ' || v_max_books_published);
END;
/
commit;


select * from orders;



--------------------------------

-- deleting the rows and foreign keys issues need to handle (use soft delete like putting status of the rows)

-- 

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
        discount_value numeric(2,2),
        book_id int,
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
        shipper int,
        status varchar(50),
        FOREIGN KEY (customer_id) REFERENCES customers(id),
        FOREIGN KEY (discount_id) REFERENCES discounts(id),
        FOREIGN KEY (shipper) REFERENCES shippers(id))';
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

--desc authors;

--select * from authors;


--insert into authors values (authors_id_seq.nextval,'fir','seco','compa');

--select * from authors;



commit;




------- inserting sample data to the authors table

insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Leda', 'Dupree', 'Schuppe, Kling and Koepp');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Shayne', 'Steffan', 'Kautzer Inc');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Anatola', 'Aveline', 'Breitenberg Group');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Lesly', 'Delhay', 'Haag Group');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Virginie', 'Amey', 'Jacobi, Wuckert and Yundt');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Charleen', 'Selley', 'Mitchell LLC');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Meredithe', 'Stanbra', 'Hilll-Nicolas');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Zolly', 'Kilvington', 'Feeney-Schimmel');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Aluino', 'Thairs', 'Renner-Donnelly');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Jamima', 'Dunthorne', 'Haag, Feest and Mante');

commit;

----------inserting the sample data to the publishers table


insert into publishers (id, name) values (publishers_id_seq.nextval, 'Daugherty-Collier publishing');
insert into publishers (id, name) values (publishers_id_seq.nextval, 'Boyer LLC publishing');
insert into publishers (id, name) values (publishers_id_seq.nextval, 'Kemmer-Shanahan publishing');
insert into publishers (id, name) values (publishers_id_seq.nextval, 'Bailey, Wyman and Zulauf publishing');
insert into publishers (id, name) values (publishers_id_seq.nextval, 'McDermott-Bergstrom publishing');
insert into publishers (id, name) values (publishers_id_seq.nextval, 'Fay and Sons publishing');
insert into publishers (id, name) values (publishers_id_seq.nextval, 'Adams and Sons publishing');
insert into publishers (id, name) values (publishers_id_seq.nextval, 'O''Keefe-Rath publishing');
insert into publishers (id, name) values (publishers_id_seq.nextval, 'Rosenbaum Group publishing');
insert into publishers (id, name) values (publishers_id_seq.nextval, 'Cole Group publishing');

commit;
--select * from publishers;



-------------- inserting random data to the genres table


insert into genres (id, name) values (genres_id_seq.nextval, 'Drama');
insert into genres (id, name) values (genres_id_seq.nextval, 'Comedy');
insert into genres (id, name) values (genres_id_seq.nextval, 'Musical');
insert into genres (id, name) values (genres_id_seq.nextval, 'Horror');
insert into genres (id, name) values (genres_id_seq.nextval, 'Action');

commit;
---select * from genres;



---------------inserting random data to the customers table


INSERT INTO customers (first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
VALUES ('John', 'Doe', 'johndoe@example.com', 'password123', '123456', 'Main Street', '123', NULL, 'Anytown', '5551234567');

INSERT INTO customers (first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
VALUES ('Jane', 'Smith', 'janesmith@example.com', 'password456', '234567', 'Maple Avenue', '456', '20B', 'Someville', '5555678901');

INSERT INTO customers (first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
VALUES ('Bob', 'Johnson', 'bobjohnson@example.com', 'password789', '345678', 'Oak Boulevard', '789', NULL, 'Othercity', '5559101112');

INSERT INTO customers (first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
VALUES ('Alice', 'Williams', 'alicewilliams@example.com', 'passwordabc', '456789', 'Pine Street', '321', '10C', 'Anotherplace', '5551212123');

INSERT INTO customers (first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
VALUES ('Emily', 'Davis', 'emilydavis@example.com', 'passworddef', '567890', 'Cedar Road', '456', NULL, 'Anytown', '5552345678');

INSERT INTO customers (first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
VALUES ('Charlie', 'Garcia', 'charliegarcia@example.com', 'passwordeg', '678901', 'Spruce Street', '789', '5D', 'Someville', '5556789012');

INSERT INTO customers (first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
VALUES ('Olivia', 'Brown', 'oliviabrown@example.com', 'passwordhij', '789012', 'Elm Avenue', '123', NULL, 'Othercity', '5551234567');

INSERT INTO customers (first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
VALUES ('Daniel', 'Wilson', 'danielwilson@example.com', 'passwordklm', '890123', 'Maple Street', '456', '11A', 'Anotherplace', '5555678901');

INSERT INTO customers (first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
VALUES ('Sophia', 'Lopez', 'sophialopez@example.com', 'passwordnop', '901234', 'Oak Lane', '789', '7B', 'Anytown', '5559101112');

INSERT INTO customers (first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number)
VALUES ('William', 'Taylor', 'williamtaylor@example.com', 'passwordqrs', '012345', 'Pine Road', '321', NULL, 'Someville', '5556667779');


select * from customers;

commit;

--select * from discounts;
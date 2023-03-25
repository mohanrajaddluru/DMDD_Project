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
        second_author NUMBER(10),
        FOREIGN KEY (author) REFERENCES authors(ID),
        FOREIGN KEY (PUBLISHER) REFERENCES publishers(ID),
        FOREIGN KEY (genres_id) REFERENCES genres(ID),
        FOREIGN KEY (second_author) REFERENCES authors(ID))';
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

--insert customer data
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Frederica', 'Weyland', '5dosw3KgxZt', '16vhAt1h', '88980', 'Mccormick', '50879', '18', 'Del Valle', '6925062365');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Cathrin', 'Lydon', 'XyF5qCoKk2', '1Ja2KaAbqMv', '258745', 'Hollow Ridge', '50288', '24', 'Simpangpasir', '6494667002');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Cad', 'Mullane', '1hJCqJJDBf', '14o9ckgKCFN', '787870', 'Miller', '77311', '3', 'Bené Beraq', '9655173858');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Lindsay', 'Strippling', 'isTbZyr', 'DqejyFgh', '380854', 'Porter', '1', '6', 'Carregal', '4267089085');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Kevina', 'Praton', 'WQwhcUm', 'CWGSUtaWZ', '885000', 'Bowman', '209', '6', 'Celso Ramos', '7142840366');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Mady', 'Lewzey', 'uA4ZwS', '69VENDFp5fc', '253401', 'Summerview', '27745', '63', 'Hostivice', '8724918388');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Dael', 'Windybank', 'fffgQ7qQyqLx', 'E74PGW5Sr', '78452', 'Orin', '0745', '1', 'Slavs’ke', '7333735211');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Sabina', 'Hatchard', 'Xhr5Y1ZLik69p', 'EqqEN1nvm', '500401', 'Chinook', '5', '3016', 'Liboro', '6085302868');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Christean', 'Ackeroyd', 'tz1iK', 'FWRJ1XWhGs', '750008', 'Carpenter', '161', '8', 'Anápolis', '6714074850');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Ophelie', 'Aizik', 'gfg1YjxV2', 'PJ5asHy9pV5gScm', '785214', 'Walton', '2', '8', 'Manonjaya', '3131344487');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Elias', 'Pestell', 'tz1Y5Qjzu5', '8aqjtSgW2Av', '254541', 'Superior', '7036', '12', 'Huaikan', '6295597641');
insert into customers (id, first_name, last_name, login, passwordHash, postal_code, street, building_no, flat_no, city, phone_number) values (customers_id_seq.nextval, 'Borden', 'Credland', 'werPZhbW', '3cNhY7hxkGY', '454548', 'Corben', '26', '52', 'Chervonoarmiys', '5686751532');

--insert books
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '617214699-8', 'Secret of NIMH 2: Timmy to the Rescue, The', '17-Sep-2017', 1, 56, '43.76');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '753962689-5', 'Go Now', '06-Aug-2017', 2, 25, '40.61');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '534269730-1', 'Hawk the Slayer', '21-May-2016', 3, 38, '48.45');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '414915876-2', 'Mystery Train', '03-Dec-2016', 2, 48, '32.14');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '630951129-7', 'Green Hornet, The', '31-Dec-2021', 1, 57, '22.05');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '924244434-0', 'The Walking Stick', '21-Sep-2014', 1, 60, '43.04');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '853664505-9', 'Iron Mask, The', '08-May-2019', 8,12, '12.26');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '818160811-9', 'Budd Boetticher: An American Original ', '08-Aug-2015', 8, 58, '38.92');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '963464143-1', 'High Life', '19-Nov-2022', 2, 26, '17.05');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '114457604-0', 'Croods, The', '06-Sep-2015', 5, 11, '27.50');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '708833782-7', 'Arrival, The', '19-Oct-2021', 1, 51, '27.78');
insert into books (id, isbn, title, publication_date, edition, available_quantity, price) values (books_id_seq.nextval, '411832645-0', 'The Big Cube', '01-Jul-2019', 12, 32, '5.49');

--insert authors
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Carr', 'Queenie', 'The Bookshelf');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Tallie', 'Mirabel', 'Gabtype');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Remington', 'Norman', 'Topiczoom');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Nerta', 'Maryjo', 'Paperback Adventures');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Petronella', 'Johnny', 'Youbridge');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Glynn', 'Barb', 'Fantasy Lights Bookstore');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Micheil', 'Mady', 'Aibox');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Trina', 'Zelda', 'Dabvine');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Silas', 'Allen', 'Photobug');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Uri', 'Mona', 'Tanoodle');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Antin', 'Olympe', 'The Reading Nook');
insert into authors (id, first_name, second_name, company_name) values (authors_id_seq.nextval, 'Herminia', 'Leslie', 'Yakitri');


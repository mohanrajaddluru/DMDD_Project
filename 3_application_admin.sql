------ this script creates the sales_executive roles in the data base

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

            DBMS_OUTPUT.PUT_LINE('User granted privileges successfully.');
        EXCEPTION
            WHEN OTHERS THEN
            IF SQLCODE!=-1918 THEN
                DBMS_OUTPUT.PUT_LINE('Currently user is connected cannot be deleted');
            END IF;
        END;
    --ELSE 
        --EXECUTE IMMEDIATE 'CREATE USER sales_executive IDENTIFIED BY "Sales_Password@321"';
        --DBMS_OUTPUT.PUT_LINE('User CREATED successfully.');
        --EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO sales_executive';
        --EXECUTE IMMEDIATE 'GRANT INSERT, SELECT, UPDATE, DELETE ON application_admin.discounts TO sales_executive';
        --DBMS_OUTPUT.PUT_LINE('User granted privileges successfully.');
        
   END IF;    
END;
/
commit;


---------------- creating customer role 

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
        EXECUTE IMMEDIATE 'GRANT SELECT application_admin.books TO customer';
        DBMS_OUTPUT.PUT_LINE('User granted privileges successfully.');
        
   END IF;    
END;
/
commit;


-----------Script to check if the customers are already exist or not, if exit raise exception else add into customer table



/*set serveroutput on
DECLARE
  v_customer_id customers.id%TYPE;
  v_customer_email customers.login%TYPE;
BEGIN
  -- Set the customer details
  v_customer_email := 'kcaress0@jmdo.com'; ------ input need to taken here sample added now
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
  INSERT INTO customers (ID, first_name, last_name, LOGIN, PASSWORDHASH, POSTAL_CODE, STREET, BUILDING_NO, FLAT_NO, CITY, PHONE_NUMBER)
  VALUES (customers_id_seq.nextval, 'Kissee', 'Caress', 'kcaress0@jmdo.com', '457443f7c9bdc746b50c076615a6a42ea118bef1', '69400', 'Alley', '10', 55, 'Manacapuru', '9411740307');
  DBMS_OUTPUT.PUT_LINE(v_customer_email || '  added successfully');
  -- set other customer details as needed
END;
/

commit;
*/







-------------- creating the script for customer creating in the database

/*DECLARE
  v_username VARCHAR2(30);
  v_password VARCHAR2(30);
BEGIN
  FOR c IN (SELECT login,passwordHash FROM customers)
  LOOP
    v_username := c.login;
    v_password := 'Hash_Password@123';
    EXECUTE IMMEDIATE 'CREATE USER ' || v_username || ' IDENTIFIED BY " '|| v_password ||' " ' ;
  END LOOP;
END;
*/

--select passwordHash from customers;
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
        DBMS_OUTPUT.PUT_LINE('User granted privileges successfully.');
        
   END IF;    
END;
/




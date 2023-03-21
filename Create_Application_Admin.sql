DECLARE
   v_username VARCHAR2(30) := 'APPLICATION_ADMIN';
   v_count NUMBER := 0;
BEGIN
   -- Check if the user already exists
   SELECT COUNT(*)
   INTO v_count
   FROM dba_users
   WHERE username = v_username;

   -- If the user exists, drop the user
   IF v_count = 1 THEN
      EXECUTE IMMEDIATE 'DROP USER ' || v_username || ' CASCADE';
      DBMS_OUTPUT.PUT_LINE('User ' || v_username || ' deleted.');
   END IF;

   -- Create the user
   EXECUTE IMMEDIATE 'CREATE USER ' || v_username || ' IDENTIFIED BY "Admin_Password@321"';
   DBMS_OUTPUT.PUT_LINE('User ' || v_username || ' created.');

   -- Grant privileges to the user
   EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO ' || v_username;
   EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO ' || v_username || ' WITH ADMIN OPTION';
   EXECUTE IMMEDIATE 'GRANT CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TRIGGER TO ' || v_username;
   EXECUTE IMMEDIATE 'ALTER USER ' || v_username || ' QUOTA UNLIMITED ON DATA';
   DBMS_OUTPUT.PUT_LINE('Privileges granted to user ' || v_username || '.');
END;
/

create user customer identified by Books_buy_Password_321;
grant create session to customer;


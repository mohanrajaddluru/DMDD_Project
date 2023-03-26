set serveroutput on
BEGIN
  INSERT INTO application_admin.discounts (id, name, discount_value, book_id, discount_expiry) 
  VALUES (application_admin.discounts_id_seq.nextval, 'Spring Sale', 0.15, 1, TO_DATE('2023-04-30', 'YYYY-MM-DD'));

  INSERT INTO application_admin.discounts (id, name, discount_value, book_id, discount_expiry) 
  VALUES (application_admin.discounts_id_seq.nextval, 'Summer Sale', 0.20, 2, TO_DATE('2023-08-31', 'YYYY-MM-DD'));

  INSERT INTO application_admin.discounts (id, name, discount_value, book_id, discount_expiry) 
  VALUES (application_admin.discounts_id_seq.nextval, 'Holiday Sale', 0.10, 3, TO_DATE('2023-12-31', 'YYYY-MM-DD'));

  INSERT INTO application_admin.discounts (id, name, discount_value, book_id, discount_expiry) 
  VALUES (application_admin.discounts_id_seq.nextval, 'Back to School Sale', 0.25, 4, TO_DATE('2023-09-30', 'YYYY-MM-DD'));

  INSERT INTO application_admin.discounts (id, name, discount_value, book_id, discount_expiry) 
  VALUES (application_admin.discounts_id_seq.nextval, 'Black Friday Sale', 0.30, 5, TO_DATE('2023-11-30', 'YYYY-MM-DD'));
  
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            dbms_output.put_line('Matching primay key book is not yet added to the books table');
    END IF;
END;
/

commit;
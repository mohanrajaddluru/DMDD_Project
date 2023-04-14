alter session set current_schema=application_admin;


exec add_discounts('SPECIAL10',10,3,to_date('21-JAN-2024','DD-MON-YYYY'));

exec add_discounts('BOOKWORM', 25, 3, to_date('31-DEC-2029','DD-MON-YYYY'));
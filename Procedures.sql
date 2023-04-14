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
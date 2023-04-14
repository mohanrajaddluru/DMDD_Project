set serveroutput on;
begin
    execute immediate 'drop user manager cascade';
    dbms_output.put_line('manager user dropped successfully');
    execute immediate 'create user manager identified by "Manage_Password@321"';
    execute immediate 'grant create session to manager';
    execute immediate 'grant select on view_shippers to manager';
    execute immediate 'grant execute on add_books to manager';
    execute immediate 'grant execute on add_genres to manager';
    execute immediate 'grant execute on add_authors to manager';
    execute immediate 'grant execute on add_publishers to manager';
    execute immediate 'grant execute on add_shippers to manager';
    execute immediate 'grant execute on view_books to manager';
    execute immediate 'grant execute on increase_stock to manager';
    dbms_output.put_line('manager user created successfully');
exception
    when others then
        if sqlcode = -1940 then
            dbms_output.put_line('manager session is currently active disconnect the session to drop the user');
        elsif sqlcode = -1918 then
            execute immediate 'create user manager identified by "Manage_Password@321"';
            execute immediate 'grant create session to manager';
            execute immediate 'grant select on view_shippers to manager';
            execute immediate 'grant execute on add_books to manager';
            execute immediate 'grant execute on add_genres to manager';
            execute immediate 'grant execute on add_authors to manager';
            execute immediate 'grant execute on add_publishers to manager';
            execute immediate 'grant execute on add_shippers to manager';
            execute immediate 'grant execute on view_books to manager';
            execute immediate 'grant execute on increase_stock to manager';
            dbms_output.put_line('manager user created successfully');
        elsif sqlcode!=-1918 then
            raise;
        end if;
end;
/
begin
    execute immediate 'drop user sales_executive cascade';
    dbms_output.put_line('sales_executive user dropped successfully');
    execute immediate 'create user sales_executive identified by "Sal_Executive@321"';
    execute immediate 'grant create session to sales_executive';
    execute immediate 'grant execute on add_discounts to sales_executive';
    execute immediate 'grant select on view_orders to sales_executive';
    dbms_output.put_line('sales_executive user created successfully');
exception
    when others then
        if sqlcode = -1940 then
            dbms_output.put_line('sales_executive session is currently active disconnect the session to drop the user');
        elsif sqlcode = -1918 then
            execute immediate 'create user sales_executive identified by "Sal_Executive@321"';
            execute immediate 'grant create session to sales_executive';
            execute immediate 'grant execute on add_discounts to sales_executive';
            execute immediate 'grant select on view_orders to sales_executive';
            dbms_output.put_line('sales_executive user created successfully');
        elsif sqlcode!=-1918 then
            raise;
        end if;
end;
/
begin
    execute immediate 'drop user customer cascade';
    dbms_output.put_line('customer user dropped successfully');
    execute immediate 'create user customer identified by "Custom_Password@321"';
    execute immediate 'grant create session to customer';
    execute immediate 'grant execute on add_orders to customer';
    execute immediate 'grant execute on add_customer to customer';
    execute immediate 'grant execute on view_order_history to customer';
    execute immediate 'grant execute on order_cancel to customer';
    dbms_output.put_line('customer user created successfully');
exception
    when others then
        if sqlcode = -1940 then
            dbms_output.put_line('customer session is currently active disconnect the session to drop the user');
        elsif sqlcode = -1918 then
            execute immediate 'create user customer identified by "Custom_Password@321"';
            execute immediate 'grant create session to customer';
            execute immediate 'grant execute on add_orders to customer';
            execute immediate 'grant execute on add_customer to customer';
            execute immediate 'grant execute on view_order_history to customer';
            execute immediate 'grant execute on order_cancel to customer';
            dbms_output.put_line('customer user created successfully');
        elsif sqlcode!=-1918 then
            raise;
        end if;
end;
/
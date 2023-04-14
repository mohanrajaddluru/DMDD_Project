begin
    execute immediate 'drop user manager cascade';--view/update baggage,baggage_data
    execute immediate 'drop user sales_executive cascade';--view and update complaints, view baggage
    execute immediate 'drop user customer cascade';--adds himself,books tickets and creates/views complaints
exception
    when others then
        if sqlcode!=-1918 then
            raise;
        end if;    
end;
/




create user manager identified by "Manage_Password@321";
grant create session to manager;
grant select on view_shippers to manager;
grant execute on add_books to manager;
grant execute on add_shippers to manager;

create user sales_executive identified by "Sal_Executive@321";
grant create session to sales_executive;
grant execute on add_discounts to sales_executive;


create user customer identified by "Custom_Password@321";
grant create session to customer;
grant execute on add_orders to customer;

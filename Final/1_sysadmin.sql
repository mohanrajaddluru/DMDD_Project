set serveroutput on;


begin
    execute immediate 'drop user application_admin cascade';
    dbms_output.put_line('application_admin user dropped successfully');
exception
    when others then
        if sqlcode!=-1918 then
            raise;
        end if;    
end;
/



create user application_admin identified by "Admin_Password@321";
grant connect, resource to application_admin;
grant create session to application_admin with admin option;
grant create table to application_admin;
alter user application_admin quota unlimited on data;
grant create view, create procedure, create sequence,create trigger to application_admin;
grant create user to application_admin;
grant drop user to application_admin;

commit;
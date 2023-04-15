show user;


select * from application_admin.books_details;


exec application_admin.add_orders(6, sysdate, 1, 1, 4, 'confirmed')

exec application_admin.add_orders(3, sysdate, 1, 4, 1, 'confirmed')

exec application_admin.add_orders(4,sysdate,1,3,3,'confirmed');


exec application_admin.add_shippers('Ocean green Logistics', 6667890123);


select * from application_admin;





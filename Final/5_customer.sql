alter session set current_schema=application_admin;
set serveroutput on;

exec add_customer('John', 'Doe', 'johndoe@example.com', 'password123', '123456', 'Main Street', '123', NULL, 'Anytown', '5551234567');
exec add_customer('Jane', 'Smith', 'janesmith@example.com', 'password456', '234567', 'Maple Avenue', '456', '20B', 'Someville', '5555678901');
exec add_customer('Bob', 'Johnson', 'bobjohnson@example.com', 'password789', '345678', 'Oak Boulevard', '789', NULL, 'Othercity', '5559101112');
exec add_customer('Alice', 'Williams', 'alicewilliams@example.com', 'passwordabc', '456789', 'Pine Street', '321', '10C', 'Anotherplace', '5551212123');
exec add_customer('Emily', 'Davis', 'emilydavis@example.com', 'passworddef', '567890', 'Cedar Road', '456', NULL, 'Anytown', '5552345678');
exec add_customer('Charlie', 'Garcia', 'charliegarcia@example.com', 'passwordeg', '678901', 'Spruce Street', '789', '5D', 'Someville', '5556789012');
exec add_customer('Olivia', 'Brown', 'oliviabrown@example.com', 'passwordhij', '789012', 'Elm Avenue', '123', NULL, 'Othercity', '5551234567');
exec add_customer('Daniel', 'Wilson', 'danielwilson@example.com', 'passwordklm', '890123', 'Maple Street', '456', '11A', 'Anotherplace', '5555678901');
exec add_customer('Sophia', 'Lopez', 'sophialopez@example.com', 'passwordnop', '901234', 'Oak Lane', '789', '7B', 'Anytown', '5559101112');
exec add_customer('William', 'Taylor', 'williamtaylor@example.com', 'passwordqrs', '012345', 'Pine Road', '321', NULL, 'Someville', '5556667779');
exec add_customer('William', 'Taylor', 'williamtaylcqecdqeor@example.com', 'passwordqrs', '012345', 'Pine Road', '321', NULL, 'Someville', '5556667779');





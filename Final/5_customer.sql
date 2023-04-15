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
exec add_customer('David', 'Brown', 'davidbrown@example.com', 'password789', '345678', 'Oak Avenue', '1011', NULL, 'Sometown', '5555551212');
exec add_customer('Samantha', 'Green', 'samanthagreen@example.com', 'passwordabc', '901234', 'Park Place', '1213', NULL, 'Hometown', '5557778888');
exec add_customer('Michael', 'Wilson', 'michaelwilson@example.com', 'passworddef', '567890', 'First Street', '1415', NULL, 'Thisville', '5551112222');
exec add_customer('Amanda', 'Jones', 'amandajones@example.com', 'passwordghi', '234567', 'Second Street', '1617', NULL, 'Thatcity', '5554445555');
exec add_customer('Christopher', 'Garcia', 'christophergarcia@example.com', 'passwordjkl', '890123', 'Third Street', '1819', NULL, 'Someplace', '5556667777');
exec add_customer('Melissa', 'Lee', 'melissalee@example.com', 'passwordmno', '456789', 'Fourth Street', '2021', NULL, 'Anyplace', '5558889999');
exec add_customer('Jason', 'King', 'jasonking@example.com', 'passwordpqr', '012345', 'Fifth Street', '2223', NULL, 'Anotherplace', '5552223333');
exec add_customer('Katherine', 'Scott', 'katherinescott@example.com', 'passwordstu', '678901', 'Sixth Street', '2425', NULL, 'Sometown', '5555551212');
exec add_customer('Kevin', 'Adams', 'kevinadams@example.com', 'passwordvwx', '234567', 'Seventh Street', '2627', NULL, 'Hometown', '5557778888');
exec add_customer('Laura', 'Baker', 'laurabaker@example.com', 'passwordyz1', '890123', 'Eighth Street', '2829', NULL, 'Thiscity', '5551112222');
exec add_customer('Daniel', 'Brown', 'danielbrown@example.com', 'password234', '456789', 'Ninth Street', '3031', NULL, 'Thatplace', '5554445555');
exec add_customer('Maria', 'Davis', 'mariadavis@example.com', 'password567', '012345', 'Tenth Street', '3233', NULL, 'Somecity', '5556667777');
exec add_customer('Nicholas', 'Garcia', 'nicholasgarcia@example.com', 'password890', '678901', 'Eleventh Street', '3435', NULL, 'Anytown', '5558889999');
exec add_customer('Rebecca', 'Hernandez', 'rebeccahernandez@example.com', 'passwordabc1', '234567', 'Twelfth Street', '3637', NULL, 'Anotherplace', '9555222111');
exec add_customer('Maggie', 'Lee', 'magglee@example.com', 'passwordxyz', '987654', 'Oak Street', '101', NULL, 'Greenfield', '5557779999');
exec add_customer('Derek', 'Jones', 'derekjones@example.com', 'passworduvw', '456789', 'Main Street', '50', NULL, 'Riverdale', '5551113333');
exec add_customer('Cynthia', 'Hall', 'cynthiahall@example.com', 'passwordabc', '234567', 'Cedar Lane', '123', NULL, 'Woodville', '5554446666');
exec add_customer('Philip', 'Wu', 'philipwu@example.com', 'passworddef', '345678', 'Walnut Avenue', '5', NULL, 'Sunnyvale', '5552224444');
exec add_customer('Samantha', 'Miller', 'samanthamiller@example.com', 'passwordklm', '789012', 'Elm Street', '27', NULL, 'Hillview', '5556668888');
exec add_customer('Oscar', 'Wilson', 'oscarwilson@example.com', 'passwordnop', '890123', 'Pine Street', '111', NULL, 'Lakeside', '5559992222');
exec add_customer('Janice', 'Cooper', 'janicecooper@example.com', 'passwordqwe', '456123', 'Chestnut Lane', '2', NULL, 'Westwood', '5553335555');
exec add_customer('Lucas', 'Gonzalez', 'lucasgonzalez@example.com', 'passwordrty', '789456', 'Maple Street', '34', NULL, 'Highland', '5557774444');
exec add_customer('Chloe', 'Sanchez', 'chloesanchez@example.com', 'passwordfgh', '123456', 'Birch Avenue', '8', NULL, 'Fairview', '5552228888');
exec add_customer('Owen', 'Hernandez', 'owenhernandez@example.com', 'passwordvbn', '345678', 'Sycamore Road', '45', NULL, 'Hawthorne', '5555553333');
exec add_customer('Lila', 'Ramirez', 'lilaramirez@example.com', 'passwordjkl', '789012', 'Pine Lane', '23', NULL, 'Huntington', '5558881111');
exec add_customer('Isaac', 'Jackson', 'isaacjackson@example.com', 'passwordzxc', '901234', 'Holly Drive', '7', NULL, 'Springfield', '5554442222');
exec add_customer('Gianna', 'Baker', 'giannabaker@example.com', 'passwordbnm', '234567', 'Dogwood Street', '12', NULL, 'Briarwood', '5556661111');
exec add_customer('Ryan', 'Tang', 'ryantang@example.com', 'passwordplo', '345678', 'Cherry Lane', '56', NULL, 'Crescent', '5557772222');
exec add_customer('Sophia', 'Gomez', 'sophiagomez@example.com', 'passwordiuy', '890123', 'Oak Lane', '14', NULL, 'Westfield', '5551116666');



exec add_orders(25, '14-APR-2023', 14, 26, 8.3, 7, 4, 'confirmed');
exec add_orders(39, '13-APR-2023', 7, 8, 9.7, 11, 12, 'confirmed');
exec add_orders(31, '12-APR-2023', 8, 9, 14.2, 14, 25, 'confirmed');
exec add_orders(11, '10-APR-2023', 18, 13, 22.1, 8, 15, 'confirmed');
exec add_orders(45, '09-APR-2023', 30, 1, 20.3, 26, 25, 'confirmed');
exec add_orders(7, '07-APR-2023', 25, 8, 16.2, 29, 20, 'confirmed');
exec add_orders(9, '06-APR-2023', 22, 15, 27.4, 14, 21, 'confirmed');
exec add_orders(4, '05-APR-2023', 1, 9, 9.8, 13, 14, 'confirmed');
exec add_orders(6, '03-APR-2023', 6, 25, 25.6, 4, 3, 'confirmed');
exec add_orders(48, '02-APR-2023', 19, 2, 17.1, 11, 22, 'confirmed');
exec add_orders(40, '01-APR-2023', 12, 29, 1.4, 8, 1, 'confirmed');
exec add_orders(34, '30-MAR-2023', 7, 15, 12.7, 5, 12, 'confirmed');
exec add_orders(5, '29-MAR-2023', 17, 2, 25.8, 2, 20, 'confirmed');
exec add_orders(12, '27-MAR-2023', 7, 14, 27.7, 1, 19, 'confirmed');
exec add_orders(24, '26-MAR-2023', 29, 8, 7.1, 11, 9, 'confirmed');
exec add_orders(37, '25-MAR-2023', 18, 6, 12.9, 25, 2, 'confirmed');



exec add_book_rating(15,9,3,sysdate);



alter session set current_schema=application_admin;



exec add_shippers('ABC Shipping', 5551234567);
exec add_shippers('XYZ Shipping', 5552345678);
exec add_shippers('Acme Shipping', 5555678901);
exec add_shippers('Globe Shipping', 5554567890);
exec add_shippers('Oceanic Shipping', 5556789012);
exec add_shippers('Transglobal Logistics', 5553456789);
exec add_shippers('Fast Track Shipping', 5552345678);
exec add_shippers('Ocean Blue Logistics', 5557890123);


exec add_authors ('Leda', 'Dupree', 'Schuppe, Kling and Koepp');
exec add_authors ('Shayne', 'Steffan', 'Kautzer Inc');
exec add_authors ('Anatola', 'Aveline', 'Breitenberg Group');
exec add_authors ('Lesly', 'Delhay', 'Haag Group');
exec add_authors ('Virginie', 'Amey', 'Jacobi, Wuckert and Yundt');
exec add_authors ('Charleen', 'Selley', 'Mitchell LLC');
exec add_authors ('Meredithe', 'Stanbra', 'Hilll-Nicolas');
exec add_authors ('Zolly', 'Kilvington', 'Feeney-Schimmel');
exec add_authors ('Zolly', 'Kilvington', 'Feeney-Schimmel');
exec add_authors ('Aluino', 'Thairs', 'Renner-Donnelly');
exec add_authors ('Jamima', 'Dunthorne', 'Haag, Feest and Mante');




exec add_publishers ('Daugherty-Collier publishing');
exec add_publishers ('Boyer LLC publishing');
exec add_publishers ('Kemmer-Shanahan publishing');
exec add_publishers ('Bailey, Wyman and Zulauf publishing');
exec add_publishers ('McDermott-Bergstrom publishing');
exec add_publishers ('Fay and Sons publishing');
exec add_publishers ('Adams and Sons publishing');
exec add_publishers ('O''Keefe-Rath publishing');
exec add_publishers ('Rosenbaum Group publishing');
exec add_publishers ('Cole Group publishing');




exec add_genres ('DRAMA');
exec add_genres ('Comedy');
exec add_genres ('Musical');
exec add_genres ('Horror');
exec add_genres ('Action');
exec add_genres ('Romantic');
exec add_genres ('sci-fi');
exec add_genres ('Documentry');
exec add_genres ('poetry');
exec add_genres ('mystery');
exec add_genres ('Humor');



exec add_books('071565262-16', 'Python', '12-Mar-2010', 5, 15, 23.10, 3, 4, 2, 6);

exec add_books('071565216-16', 'Faily Tales', '12-Mar-2010', 5, 9, 23.10, 9, 4, 2, 6);

exec add_books('071235216-16', 'Faily books', '10-Feb-2023', 1, 2, 2.1, 4, 2, 1, 9);

exec add_books('091565216-16', 'data base', '9-Dec-2022', 1, 4, 6.30, 2, 1, 5, 4);

exec add_books('091569316-91', 'algotithms', '1-Jun-2010', 2, 13, 5.40, 9, 3, 6, 9);
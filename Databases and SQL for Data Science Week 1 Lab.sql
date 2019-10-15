drop TABLE INSTRUCTOR;

create table INSTRUCTOR
(ins_id integer NOT NULL,
lastname varchar(15)  NOT NULL,
firstname varchar(15) NOT NULL,
city varchar(15),
country char(2),
PRIMARY KEY (ins_id)
);

INSERT INTO  INSTRUCTOR (ins_id, lastname, firstname, city, country) 
values 
 (1, 'Ahuja', 'Rav', 'Toronto', 'CA');

INSERT INTO  INSTRUCTOR (ins_id, lastname, firstname, city, country) 
values
 (2, 'Vasudevan', 'Hima', 'Mumbai', 'IN'),
 (3, 'Chong', 'Raul', 'Hongkong', 'CH');
 
select * from INSTRUCTOR;

select firstname, lastname, country from INSTRUCTOR where city='Toronto';

update INSTRUCTOR set city='Markham' where firstname='Rav';

delete from INSTRUCTOR where firstname='Raul';

select * from INSTRUCTOR;
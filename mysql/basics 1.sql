create database fdb;
create database DTR;
drop database DTR;
use fdb;
create table students (roll_no int,name_ char(10),address varchar(30));
create table walter_white (id int,drug_name char(20),deliver_address varchar(30));
describe students;
insert into students (roll_no,name_,address) values(1,'balaya','hyderabad');
select * from students;
insert into students (roll_no,name_) values(2,'nitish');
insert 
into students
(roll_no,name_,address)
values
(3,'chopper','hyderabad'),
(4,'zoro','hyderabad'),
(5,'nami','hyderabad');
insert into students (roll_no,name_,address) values(6,'robin',null);
select * from students;
use fdb;
create table register(roll_no char(20),name_ varchar(56),dob date,gender char(6),phone_no char(10),address mediumtext);
insert into register (roll_no,name_,dob,gender,phone_no,address) values(1234567890,'bala shiva',"2000-10-10",'male',9363524852,'hyderabad'),
(1234567891,'teen shiva',"2000-10-11",'male',9363524851,'hyderabad'),
(1234567892,'late teen shiva',"2000-10-12",'male',936352485,'hyderabad'),
(1234567894,'adult shiva',"2000-10-13",'male',9363524856,'hyderabad'),
(1234567896,'semi adult shiva',"2000-10-15",'male',9363524857,'hyderabad');
select * from register;
alter table register add column father_no char(10);
insert into register (roll_no,name_,dob,gender,phone_no,address,father_no) values(1234567810,'erri shiva',"2000-10-10",'male',9363524865,'hyderabad','0080090046');
select * from register;
alter table register change column father_no mother_no char(10);
select * from register;
alter table register modify column mother_no char(15);
describe register;
alter table register drop column mother_no;
select * from register;
alter table register 
change column phone_no mobile_no char(30),
change column name_ student_name char(30);
select * from register;
rename table register to register_book;
use fbd;
use fdb;
create table new_register(roll_no int,student_name varchar(30) not null);
insert into new_register(roll_no,student_name) values (null,null);
insert into new_register(roll_no,student_name) values (1,'DTR');
insert into new_register(roll_no,student_name) values (null,'nitish');
select * from new_register;
alter table new_register add column age int check(age > 16);
insert into new_register(roll_no,student_name,age) values (3,'nit',17);
insert into new_register(roll_no,student_name,age) values (4,'nat',20);
select * from new_register;
alter table new_register add column e_mail char(30) unique;
insert into new_register(roll_no,student_name,age,e_mail) values (5,'Rome',17,'rome@gmail.com');
select * from new_register;
alter table  new_register modify column roll_no int primary key auto_increment;
insert into new_register(student_name,age,e_mail) values ('Romen',17,'romen@gmail.com');
insert into new_register(roll_no,student_name,age,e_mail) values (8,'Romem',17,'romem@gmail.com');
select * from new_register;
alter table new_register add column country char(30) default 'India';
insert into new_register(student_name,age,e_mail) values ('Roen',17,'roen@gmail.com');
insert into new_register(student_name,age,e_mail) values ('Rqen',17,'rqen@gmail.com');
select * from new_register;
insert into new_register(student_name,age,e_mail,country) values ('Ramen',17,'ramen@gmail.com','russian');
-- Add CHECK constraints
ALTER TABLE students
ADD CONSTRAINT chk_age CHECK (age BETWEEN 10 AND 100),
ADD CONSTRAINT chk_marks CHECK (marks BETWEEN 0 AND 100);
-- Add UNIQUE constraint for firstname and lastname combination
ALTER TABLE students
ADD CONSTRAINT unique_name UNIQUE (firstname, lastname);
-- add default values
ALTER TABLE students
MODIFY city VARCHAR(255) DEFAULT 'Unknown',
MODIFY marks INT DEFAULT 0;

-- new table
use fdb;
create table class_register (roll_no int,s_name char(30),dob date,gender char(10),age int,adddress char(56));
insert into class_register 
values (1,'ram',"2000-11-11",'male',24,'hyderabad'),
 (2,'ravi',"2000-11-11",'male',24,'hyderabad'),
  (3,'charry',"2000-11-11",'male',24,'hyderabad'),
   (4,'rama charry',"2000-11-11",'male',24,'hyderabad'),
    (5,'nami',"2000-11-11",'male',24,'hyderabad'),
     (6,'luffy',"2000-11-11",'male',24,'hyderabad'),
      (7,'chopper',"2000-11-11",'male',24,'hyderabad'),
       (8,'brook',"2000-11-11",'male',24,'hyderabad'),
        (9,'naruto',"2000-11-11",'male',24,'hyderabad'),
         (10,'itachi',"2000-11-11",'male',24,'hyderabad');

select*from class_register;
-- to get acces to edit the data in table
set sql_safe_updates=0;
update class_register set age = 16 where age =24;
update class_register set gender='female' where s_name= 'nami' and age =16;
update class_register set dob="1800-01-01", gender= 'other' where s_name='brook';
update class_register set age = 224 where dob<="1950-10-01";
-- how to reset the numbers in a col
-- UPDATE table_name SET column_name = 0;
-- SET @num = 0;
-- UPDATE table_name SET column_name = (@num := @num + 1) ORDER BY id;
-- delete
delete from class_register where roll_no=1 or roll_no=2;
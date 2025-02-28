use fdb; 
create table dept(dep_id int primary key,dep_name char(30));
create table student (id int primary key,
name_ char(30),dep_id int,foreign key(dep_id) references dept(dep_id) on update cascade on delete cascade);
insert into dept values (1,'it'),
(2,'cse'),(3,'ece');
insert into student values (1,'DTR',1);
update dept set dep_id=10 where dep_id=1; 
select * from student;
use learndb;
-- left join
select * from books 
left join authors on books.AuthorId=authors.AuthorId;
-- right join
select * from books 
right join authors on books.AuthorId=authors.AuthorId;
select * from authors 
left join books on authors.AuthorId=books.AuthorId;
-- getting specific columns
select mb.first_name,mb.last_name,mo.title from members as mb left join movies as mo on mb.movieid=mo.id;
-- using
select * from authors
left join books using(AuthorId);
-- self joinning a single table
select emp.EMP_ID,emp.first_name,emp.LAST_NAME,mgr.EMP_ID,mgr.FIRST_NAME,mgr.LAST_NAME from myemp as emp 
right join myemp as mgr on emp.EMP_ID=mgr.MGR_ID; 
-- inner join
select emp.EMP_ID,emp.first_name,emp.LAST_NAME,mgr.EMP_ID,mgr.FIRST_NAME,mgr.LAST_NAME from myemp as emp 
inner join myemp as mgr on emp.EMP_ID=mgr.MGR_ID; 
-- cross join
select emp.EMP_ID,emp.first_name,emp.LAST_NAME,mgr.EMP_ID,mgr.FIRST_NAME,mgr.LAST_NAME from myemp as emp 
cross join myemp as mgr on emp.EMP_ID=mgr.MGR_ID; 

select *,m.rate +d.rate as total_price 
from meals as m
cross join drinks as d;


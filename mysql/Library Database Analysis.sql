create database test_data;
use test_data;
-- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"? - 5
SELECT book_copies_No_Of_Copies
FROM `book copies` bc
JOIN books b ON bc.book_copies_BookID = b.book_BookID
JOIN `library branch` lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE b.book_Title = 'The Lost Tribe' 
AND lb.library_branch_BranchName = 'Sharpstown';
-- How many copies of the book titled "The Lost Tribe" are owned by each library branch? - 5 
SELECT book_copies_No_Of_Copies,library_branch_BranchName
FROM `book copies` bc
JOIN books b ON bc.book_copies_BookID = b.book_BookID
JOIN `library branch` lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE b.book_Title = 'The Lost Tribe';
-- Retrieve the names of all borrowers who do not have any books checked out? -'Jane Smith'
select borrower_BorrowerName
from borrower bo
left join `book loans` bl on bo.borrower_CardNo = bl.book_loans_CardNo
where book_loans_BookID is null;
-- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address?
select book_Title,borrower_BorrowerName,borrower_BorrowerAddress
from borrower bo
join `book loans` bl on bo.borrower_CardNo = bl.book_loans_CardNo
join `library branch` lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
join books b on b.book_BookID = bl.book_loans_BookID
where lb.library_branch_BranchName = 'Sharpstown' 
and bl.book_loans_DueDate = '2/3/18';
-- For each library branch, retrieve the branch name and the total number of books loaned out from that branch?
select library_branch_BranchName,count(bl.book_loans_BranchID)
from `book loans` bl
join `library branch` lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
group by library_branch_BranchName;
-- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out?
select borrower_BorrowerName,borrower_BorrowerAddress,count(book_loans_CardNo) as total_loan_books
from `book loans` bl
join borrower bo on bo.borrower_CardNo = bl.book_loans_CardNo
group by bo.borrower_CardNo, bo.borrower_BorrowerName, bo.borrower_BorrowerAddress
having count(book_loans_CardNo) > 5;
-- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central"?
select book_Title,book_copies_No_Of_Copies
from `book copies` bc
JOIN books b ON bc.book_copies_BookID = b.book_BookID
JOIN `library branch` lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
join authors a on a.book_authors_BookID=b.book_BookID
where book_authors_AuthorName = "Stephen King"
and library_branch_BranchName = "Central";
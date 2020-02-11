-- Complete the following exercises to practice using SQL.

-- Order
-- Find all subjects sorted by subject
 SELECT * FROM subjects ORDER BY subject;
-- Find all subjects sorted by location
SELECT * FROM subjects ORDER BY location;

-- Where
-- Find the book "Little Women"
SELECT * FROM books WHERE title = 'Little Women';
 id  |    title     | author_id | subject_id 
-----+--------------+-----------+------------
 190 | Little Women |        16 |          6

-- Find all books containing the word "Python"
booktown=# SELECT * FROM books WHERE title LIKE '%Python%';
  id   |       title        | author_id | subject_id 
-------+--------------------+-----------+------------
 41473 | Programming Python |      7805 |          4
 41477 | Learning Python    |      7805 |          4
(2 rows)


-- Find all subjects with the location "Main St" sort them by subject
SELECT * FROM subjects WHERE location = 'Main St' ORDER BY subject;
 id |     subject     | location 
----+-----------------+----------
  6 | Drama           | Main St
  7 | Entertainment   | Main St
 13 | Romance         | Main St
 15 | Science Fiction | Main St
(4 rows)


-- Joins
-- Find all books about Computers and list ONLY the book titles
SELECT b.title FROM subjects s INNER JOIN books b ON s.id = b.subject_id WHERE s.subject = 'Computers';
        title     
----------------------
 Practical PostgreSQL
 Perl Cookbook
 Learning Python
 Programming Python

-- Find all books and display a result table with ONLY the following columns
-- Book title
-- Author's first name
-- Author's last name
-- Book subject
SELECT b.title, a.first_name, a.last_name, s.subject
booktown-# FROM ((books b
booktown(# INNER JOIN authors a ON b.author_id = a.id)
booktown(# INNER JOIN subjects s ON b.subject_id = s.id);
            title            |    first_name    |  last_name   |     subject      
-----------------------------+------------------+--------------+------------------
 Practical PostgreSQL        | John             | Worsley      | Computers
 Franklin in the Dark        | Paulette         | Bourgeois    | Children's Books
 The Velveteen Rabbit        | Margery Williams | Bianco       | Classics
 Little Women                | Louisa May       | Alcott       | Drama
 The Shining                 | Stephen          | King         | Horror
 Dune                        | Frank            | Herbert      | Science Fiction
 Dynamic Anatomy             | Burne            | Hogarth      | Arts
 Goodnight Moon              | Margaret Wise    | Brown        | Children's Books
 The Tell-Tale Heart         | Edgar Allen      | Poe          | Horror
 Programming Python          | Mark             | Lutz         | Computers
 Learning Python             | Mark             | Lutz         | Computers
 Perl Cookbook               | Tom              | Christiansen | Computers
 2001: A Space Odyssey       | Arthur C.        | Clarke       | Science Fiction
 The Cat in the Hat          | Theodor Seuss    | Geisel       | Children's Books
 Bartholomew and the Oobleck | Theodor Seuss    | Geisel       | Children's Books

-- Find all books that are listed in the stock table
-- Sort them by retail price (most expensive first)
-- Display ONLY: title and price
SELECT books.title, stock.retail       
FROM (( books                                                                          
INNER JOIN editions ON books.id = editions.book_id)               
INNER JOIN stock ON stock.isbn = editions.isbn) ORDER BY stock.retail DESC;
            title            | retail 
-----------------------------+--------
 2001: A Space Odyssey       |  46.95
 Dune                        |  45.95
 The Shining                 |  36.95
 The Cat in the Hat          |  32.95
 Goodnight Moon              |  28.95
 The Shining                 |  28.95
 Dynamic Anatomy             |  28.95
 The Tell-Tale Heart         |  24.95
 The Velveteen Rabbit        |  24.95
 The Cat in the Hat          |  23.95
 Franklin in the Dark        |  23.95
 Little Women                |  23.95
 2001: A Space Odyssey       |  22.95
 The Tell-Tale Heart         |  21.95
 Dune                        |  21.95
 Bartholomew and the Oobleck |  16.95
(16 rows)

-- Find the book "Dune" and display ONLY the following columns
-- Book title
-- ISBN number
-- Publisher name
-- Retail price
booktown=# SELECT b.title, s.isbn, p.name, s.retail     
 FROM (((books b                              
 INNER JOIN editions e ON b.id = e.book_id)     
INNER JOIN stock s ON s.isbn = e.isbn)                 
INNER JOIN publishers p ON p.id = e.publisher_id) WHERE title = 'Dune';
 title |    isbn    |   name    | retail 
-------+------------+-----------+--------
 Dune  | 0441172717 | Ace Books |  21.95
 Dune  | 044100590X | Ace Books |  45.95


-- Find all shipments sorted by ship date display a result table with ONLY the following columns:
-- Customer first name
-- Customer last name
-- ship date
-- book title
booktown=# SELECT c.first_name, c.last_name, sh.ship_date, b.title 
FROM ((((books b                                                          
INNER JOIN editions e ON b.id = e.book_id)                           
INNER JOIN shipments sh ON sh.isbn = e.isbn)                               
INNER JOIN customers c ON c.id = sh.customer_id));

 Wendy      | Black     | 2001-08-09 09:30:46-07 | The Velveteen Rabbit
 Dave       | Olson     | 2001-08-09 07:30:07-07 | The Velveteen Rabbit
 Eric       | Morrill   | 2001-08-07 13:00:48-07 | Little Women
 Owen       | Bollman   | 2001-08-05 09:34:04-07 | Little Women
 Kathy      | Corner    | 2001-08-13 09:47:04-07 | The Cat in the Hat
 James      | Williams  | 2001-08-11 13:34:08-07 | The Cat in the Hat
 Owen       | Becker    | 2001-08-12 13:39:22-07 | The Shining
 Ed         | Gould     | 2001-08-08 09:53:46-07 | The Shining
 Royce      | Morrill   | 2001-08-07 11:31:57-07 | The Tell-Tale Heart
 Adam       | Holloway  | 2001-08-14 13:41:39-07 | The Tell-Tale Heart
 Jean       | Black     | 2001-08-10 08:29:42-07 | The Tell-Tale Heart
 Trevor     | Young     | 2001-08-14 08:42:58-07 | Dune
 Kate       | Gerdes    | 2001-08-12 08:46:35-07 | Dune
 Christine  | Holloway  | 2001-08-07 11:56:42-07 | 2001: A Space Odyssey
 Shirley    | Gould     | 2001-08-15 14:02:01-07 | 2001: A Space Odyssey
 Tim        | Owens     | 2001-08-14 07:33:47-07 | Dynamic Anatomy

-- Grouping and Counting
-- Get the COUNT of all books
booktown=# SELECT COUNT(*) FROM books;
 count 
-------
    15
(1 row)
-- Get the COUNT of all Locations
booktown=# SELECT COUNT(location) FROM subjects;
 count 
-------
    15
(1 row)
-- Get the COUNT of each unique location in the subjects table. Display the count and the location name. (hint: requires GROUP BY).
 SELECT COUNT(location) FROM subjects GROUP BY location;
 count 
-------
     0
     1
     1
     2
     2
     2
     4
     3
(8 rows)

-- List all books. Display the book_id, title, and a count of how many editions each book has. (hint: requires GROUP BY and JOIN)
SELECT b.id, e.title, COUNT(e.edition) 
FROM books b INNER JOIN editions e 
ON b.id=e.book_id GROUP BY b.id;

-- YAY! You're done!!
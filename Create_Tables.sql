USE [master];
GO
CREATE DATABASE [MyLibrary] CONTAINMENT = NONE ON PRIMARY
(
                                                          NAME = N'MyLibrary', 
                                                          FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.HAMIDI\MSSQL\DATA\MyLibrary.mdf', 
                                                          SIZE = 8192 KB, 
                                                          MAXSIZE = UNLIMITED, 
                                                          FILEGROWTH = 65536 KB
) LOG ON
(
                                                          NAME = N'MyLibrary_log', 
                                                          FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.HAMIDI\MSSQL\DATA\MyLibrary_log.ldf', 
                                                          SIZE = 8192 KB, 
                                                          MAXSIZE = 2048 GB, 
                                                          FILEGROWTH = 65536 KB
);
GO
USE [MyLibrary];

-- Table: author
CREATE TABLE author
(id             INT NOT NULL, 
 author_name    VARCHAR(255) NOT NULL, 
 author_surname VARCHAR(255) NOT NULL, 
 date_birth     DATE NULL, 
 date_death     DATE NULL, 
 CONSTRAINT author_pk PRIMARY KEY(id)
);
INSERT INTO author
VALUES
(1, 
 'Wally', 
 'Lamb', 
 '9/1/1965', 
 ''
),
(2, 
 'Bill', 
 'McKibben', 
 '9/1/1968', 
 ''
),
(3, 
 'Harold', 
 'Bloom', 
 '9/1/1975', 
 ''
),
(4, 
 'Paul', 
 'Auster', 
 '9/1/1960', 
 ''
);

-- Table: autorship_role
CREATE TABLE autorship_role
(id        INT NOT NULL, 
 role_name VARCHAR(255) NOT NULL, 
 CONSTRAINT autorship_role_pk PRIMARY KEY(id)
);
INSERT INTO [autorship_role]
VALUES
(1, 
 'Author'
),
(2, 
 'Co-Author'
);

-- Table: book
CREATE TABLE book
(isbn                   INT NOT NULL, 
 book_title             VARCHAR(255) NOT NULL, 
 literature_category_id INT NOT NULL, 
 publishing_house_id    INT NOT NULL, 
 year_published         DATE NOT NULL, 
 CONSTRAINT book_pk PRIMARY KEY(isbn)
);
INSERT INTO [book]
VALUES
(1111, 
 'African Folktales', 
 1, 
 1, 
 '2/2/1988'
),
(2222, 
 '10 Years of the Caine Prize for African Writing:', 
 2, 
 1, 
 '2/2/1998'
),
(3333, 
 'Oral Epics from Africa', 
 3, 
 1, 
 '2/2/2018'
),
(4444, 
 'Land Apart', 
 4, 
 1, 
 '2/2/2010'
);

-- Table: book_authorship
CREATE TABLE book_authorship
(book_id           INT NOT NULL, 
 author_id         INT NOT NULL, 
 autorship_role_id INT NOT NULL, 
 CONSTRAINT book_authorship_pk PRIMARY KEY(book_id, author_id, autorship_role_id)
);
INSERT INTO book_authorship
VALUES
(1111, 
 1, 
 1
),
(2222, 
 1, 
 1
),
(3333, 
 1, 
 1
),
(4444, 
 1, 
 1
);

-- Table: book_item
CREATE TABLE book_item
(id         INT NOT NULL, 
 isbn       INT NOT NULL, 
 library_id INT NOT NULL, 
 CONSTRAINT book_item_pk PRIMARY KEY(id)
);
INSERT INTO book_item
VALUES
(1, 
 1111, 
 1
),
(2, 
 2222, 
 1
),
(3, 
 3333, 
 1
),
(4, 
 4444, 
 1
);

-- Table: city
CREATE TABLE city
(id          INT NOT NULL, 
 postal_code VARCHAR(255) NOT NULL, 
 city_name   VARCHAR(255) NOT NULL, 
 country_id  INT NOT NULL, 
 CONSTRAINT city_pk PRIMARY KEY(id)
);
INSERT INTO city
VALUES
(1, 
 23060, 
 'Richmond', 
 1
),
(2, 
 23059, 
 'Glen Allen', 
 1
),
(3, 
 21204, 
 'Towson', 
 1
),
(4, 
 21201, 
 'Baltimore', 
 1
);

-- Table: country
CREATE TABLE country
(id           INT NOT NULL, 
 country_name VARCHAR(255) NOT NULL, 
 CONSTRAINT country_pk PRIMARY KEY(id)
);
INSERT INTO country
VALUES
(1, 
 'USA'
),
(2, 
 'Canada'
),
(3, 
 'Turkey'
),
(4, 
 'France'
);

-- Table: library
CREATE TABLE [library]
(id           INT NOT NULL, 
 library_name VARCHAR(255) NOT NULL, 
 address      VARCHAR(255) NOT NULL, 
 city_id      INT NOT NULL, 
 CONSTRAINT library_pk PRIMARY KEY(id)
);
INSERT INTO [library]
VALUES
(1, 
 'AAAA', 
 'AAAA AAAA aaaa', 
 1
),
(2, 
 'BBBB', 
 '212 British Rd', 
 1
),
(3, 
 'CCCC', 
 'AAAA AAAA aaaa', 
 1
),
(4, 
 'DDDD', 
 'AAAA AAAA aaaa', 
 1
);

-- Table: literature_category
CREATE TABLE literature_category
(id            INT NOT NULL, 
 category_name VARCHAR(255) NOT NULL, 
 CONSTRAINT literature_category_pk PRIMARY KEY(id)
);
INSERT INTO literature_category
VALUES
(1, 
 'Cat1'
),
(2, 
 'Cat2'
),
(3, 
 'Cat3'
),
(4, 
 'Cat4'
);

-- Table: loan_status
CREATE TABLE loan_status
(id          INT NOT NULL, 
 status_name VARCHAR(255) NOT NULL, 
 CONSTRAINT loan_status_pk PRIMARY KEY(id)
);
INSERT INTO loan_status
VALUES
(1, 
 'Active'
),
(2, 
 'Overdue'
),
(3, 
 'Return'
);

-- Table: loaned_book
CREATE TABLE loaned_book
(id             INT NOT NULL, 
 book_item_id   INT NOT NULL, 
 member_id      INT NOT NULL, 
 date_loaned    VARCHAR(50) NOT NULL, 
 date_due       VARCHAR(50) NOT NULL, 
 date_returned  VARCHAR(50) NULL, 
 overdue_fine   INT NULL, 
 loan_status_id INT NOT NULL, 
 CONSTRAINT loaned_book_pk PRIMARY KEY(id)
);
INSERT INTO loaned_book
VALUES
(1, 
 1, 
 1, 
 '8/15/2020', 
 '9/15/2020', 
 '', 
 0, 
 1
),
(2, 
 2, 
 2, 
 '5/15/2020', 
 '6/15/2020', 
 '7/15/2020', 
 10, 
 2
),
(3, 
 3, 
 3, 
 '4/15/2020', 
 '5/15/2020', 
 '5/10/2020', 
 0, 
 3
),
(4, 
 1, 
 1, 
 '8/15/2020', 
 '9/15/2020', 
 '', 
 0, 
 1
);

-- Table: member
CREATE TABLE member
(id            INT NOT NULL, 
 name          VARCHAR(255) NOT NULL, 
 surname       VARCHAR(255) NOT NULL, 
 address       VARCHAR(255) NOT NULL, 
 city_id       INT NOT NULL, 
 email_address VARCHAR(255) NOT NULL, 
 phone_number  VARCHAR(255) NOT NULL, 
 CONSTRAINT member_pk PRIMARY KEY(id)
);
INSERT INTO member
VALUES
(1, 
 'Ali', 
 'Abasi', 
 'Add1', 
 1, 
 'Email@myemail.com', 
 '777-7777-777'
),
(4, 
 'Ali', 
 'Asadi', 
 'Add5', 
 1, 
 'Email7@myemail.com', 
 '777-7777-777'
),
(3, 
 'Ali', 
 'Hamidi', 
 'Add5', 
 1, 
 'Email3@myemail.com', 
 '777-7777-777'
),
(2, 
 'Ali', 
 'Nafasi', 
 'Add2', 
 1, 
 'Email1@myemail.com', 
 '777-7777-777'
);

-- Table: publishing_house
CREATE TABLE publishing_house
(id                    INT NOT NULL, 
 publishing_house_name VARCHAR(255) NOT NULL, 
 city_id               INT NOT NULL, 
 CONSTRAINT publishing_house_pk PRIMARY KEY(id)
);
INSERT INTO publishing_house
VALUES
(1, 
 'pub1', 
 1
),
(2, 
 'pub2', 
 2
),
(3, 
 'pub3', 
 3
),
(4, 
 'pub4', 
 4
);

-- foreign keys
-- Reference: book_authorship_author (table: book_authorship)
ALTER TABLE book_authorship
ADD FOREIGN KEY(author_id) REFERENCES author(id);

-- Reference: book_authorship_autorship_role (table: book_authorship)
ALTER TABLE book_authorship
ADD FOREIGN KEY(autorship_role_id) REFERENCES autorship_role(id);

-- Reference: book_authorship_book (table: book_authorship)
ALTER TABLE book_authorship
ADD FOREIGN KEY(book_id) REFERENCES book(isbn);

-- Reference: book_item_book (table: book_item)
ALTER TABLE book_item
ADD FOREIGN KEY(isbn) REFERENCES book(isbn);

-- Reference: book_item_library (table: book_item)
ALTER TABLE book_item
ADD FOREIGN KEY(library_id) REFERENCES library(id);

-- Reference: book_literature_category (table: book)
ALTER TABLE book
ADD FOREIGN KEY(literature_category_id) REFERENCES literature_category(id);

-- Reference: book_publishing_house (table: book)
ALTER TABLE book
ADD FOREIGN KEY(publishing_house_id) REFERENCES publishing_house(id);

-- Reference: borrowed_book_borrowing_status (table: loaned_book)
ALTER TABLE loaned_book
ADD FOREIGN KEY(loan_status_id) REFERENCES loan_status(id);

-- Reference: borrowed_book_member (table: loaned_book)
ALTER TABLE loaned_book
ADD FOREIGN KEY(member_id) REFERENCES member(id);

-- Reference: borrowed_books_book_item (table: loaned_book)
ALTER TABLE loaned_book
ADD FOREIGN KEY(book_item_id) REFERENCES book_item(id);

-- Reference: city_country (table: city)
ALTER TABLE city
ADD FOREIGN KEY(country_id) REFERENCES country(id);

-- Reference: library_city (table: library)
ALTER TABLE library
ADD FOREIGN KEY(city_id) REFERENCES city(id);

-- Reference: members_city (table: member)
ALTER TABLE member
ADD FOREIGN KEY(city_id) REFERENCES city(id);

-- Reference: publishing_house_city (table: publishing_house)
ALTER TABLE publishing_house
ADD FOREIGN KEY(city_id) REFERENCES city(id);
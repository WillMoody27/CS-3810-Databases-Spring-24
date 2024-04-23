-- *** Activity 19 ***
CREATE DATABASE orders;
 
\c orders
 
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Orders;
DROP FUNCTION IF EXISTS check_qtt_before_insert();
DROP TRIGGER IF EXISTS items_no_negative_qtt;

CREATE TABLE Orders (
    number INT PRIMARY KEY,
    date DATE
);
 


INSERT INTO Orders VALUES
    (101, '2020-09-12'),  
    (202, '2021-09-27'),
    (303, '2021-09-30'),
    (404, '2021-10-12');
 
CREATE TABLE Products (
    id SERIAL PRIMARY KEY,
    descr VARCHAR(30),
    price DECIMAL(10,2)
);
 
INSERT INTO Products (descr, price) VALUES
    ( 'Ninja Sword', 250.00 ),  
    ( 'Dummy', 50.00 ),
    ( 'Fake Blood', 5.00 ),
    ( 'Rubber Ducky', 1.00 ),
    ( 'Bathtub Soap', 3.00 ),
    ( 'Brazilian Coffee', 5.00 ),
    ( 'Running Shoes', 50.00 );
 
CREATE TABLE Items (
    order_ INT,
    product INT,
    qtt INT,
    PRIMARY KEY (order_, product),
    FOREIGN KEY (order_) REFERENCES Orders (number),
    FOREIGN KEY (product) REFERENCES Products (id)
);
 


CREATE FUNCTION check_qtt_before_insert() RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
        BEGIN
            IF NEW.qtt <= 0 THEN
                NEW.qtt = 1;
            END IF;
            RETURN NEW;
        END;
    $$;
 
CREATE TRIGGER items_no_negative_qtt
    BEFORE INSERT ON Items
    FOR EACH ROW
        EXECUTE PROCEDURE check_qtt_before_insert();
 
INSERT INTO Items VALUES (101, 1, -1);  -- trigger!
INSERT INTO Items VALUES (101, 2, 10);
INSERT INTO Items VALUES (101, 3, 5);
INSERT INTO Items VALUES (202, 4, 200);
INSERT INTO Items VALUES (202, 6, 10);
INSERT INTO Items VALUES (303, 7, 0); -- trigger!
INSERT INTO Items VALUES (303, 1, 10);
INSERT INTO Items VALUES (404, 4, 1);
INSERT INTO Items VALUES (404, 7, 3);

-- TRY TO FIGURE OUT THE VIEW 

-- Finally, create the following views:
-- View 1: OrdersTotalByMonth

-- COMMON IN DATEBASE ADMINISTRATION - Where they may be requests to summarize the view of the data.

-- THIS IS NOT AN UPDATABLE VIEW - It is a read-only view.
-- -- ANY VIEW THAT INVOLVES AGGREGATION IS NOT UPDATABLE.
-- -- IF YOU WANT TO UPDATE THE DATA, YOU HAVE TO UPDATE THE UNDERLYING TABLES.

CREATE VIEW OrdersTotalByMonth AS
    SELECT DATE_PART('year', date) AS year, DATE_PART('month', date) AS month, SUM(price * qtt) AS total
    FROM Orders
    JOIN Items
    ON number = order_
    JOIN Products
    ON product = id
    GROUP BY year, month
    ORDER BY year, month;

-- Chaneg the view to by YEAR ONLY
CREATE VIEW OrdersTotalByYear AS
    SELECT DATE_PART('year', date) AS year, SUM(price * qtt) AS total
    FROM Orders
    JOIN Items
    ON number = order_
    JOIN Products
    ON product = id
    GROUP BY year
    ORDER BY year;


-- FROM LECTURE _ CODE SNIPPETS
CREATE VIEW OrdersTotalByMonth AS
    SELECT  DATE_PART('year', date) AS year,
            DATE_PART('month', date) AS month,
            SUM(qtt * price) AS total
    FROM Orders
    JOIN Items
    ON number = order_
    JOIN Products
    ON product = id
    GROUP BY year, month
    ORDER BY year, month;
 
CREATE VIEW OrdersTotalByYear AS
    SELECT  DATE_PART('year', date) AS year,
            SUM(qtt * price) AS total
    FROM Orders
    JOIN Items
    ON number = order_
    JOIN Products
    ON product = id
    GROUP BY year
    ORDER BY year;





---------------------------------------------------------

-- LECTURE EXAMPLE - GET FROM TEAMS

CREATE TABLE Movies (
  title VARCHAR(30) NOT NULL,
  year INT NOT NULL,
  PRIMARY KEY (title, year),
  length INT,
  studio VARCHAR(30) NOT NULL
);

INSERT INTO PixarMovies VALUES ('Brave', 2012, 'Pixar');

-- Insert Toy Story 3
INSERT INTO PixarMovies VALUES ('Toy Story 3', 2010, 'Pixar');

CREATE VIEW PixarMovies AS
    SELECT title, year
    FROM Movies
    WHERE studio = 'Pixar';

INSERT INTO PixarMovies VALUES ('Spiderman 3', 2002, 'Marvel');


-- NOT ALL VIEW ARE UPDATABLE with inserts and updates. Can be difficult if the view is based on multiple tables using joins.


----------- 

CREATE TYPE year_type_tracks AS (
    year INT,
    type VARCHAR,
    tracks INT
);

CREATE TABLE Tracks (
    value year_type_tracks PRIMARY KEY,
    descr VARCHAR
);

INSERT INTO Tracks VALUES ((2021, 'Rock', 10), 'Rock 2021');

SELECT * FROM Tracks;


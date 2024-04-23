-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The employees database

-- TODO: create database employees

CREATE DATABASE employees;

-- TODO: create table departments

DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments (
    code CHAR(2) PRIMARY KEY,
    "desc" VARCHAR(50) NOT NULL
);

-- TODO: populate table departments
INSERT INTO Departments VALUES (
    'HR', 'Human Resources'),
    ('IT', 'Information Technology'),
    ('SL', 'Sales');

INSERT INTO Departments VALUES
    ('MK', 'Marketing');

-- TODO: create table employees

DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    sal DECIMAL(10,2) NOT NULL,
    deptCode CHAR(4),
    FOREIGN KEY (deptCode) REFERENCES departments(code)
);

-- TODO: populate table Employees
-- Must list attribute since id is auto-generated
INSERT INTO Employees(name, sal, deptCode) VALUES
('Sam Mai Tai', 50000, 'HR'),
('James Brandy', 55000, 'HR'),
('Whisky Strauss', 60000, 'HR'),
('Romeo Curacau', 65000, 'IT'),
('Jose Caipirinha', 65000, 'IT'),
('Tony Gin and Tonic', 80000, 'SL'),
('Debby Derby', 85000, 'SL'),
('Morbid Mojito', 150000, NULL);

-- TODO: a) list all rows in Departments.

SELECT * FROM Departments;

-- TODO: b) list only the codes in Departments.

SELECT code FROM Departments;

-- TODO: c) list all rows in Employees.

SELECT * FROM Employees;

-- TODO: d) list only the names in Employees in alphabetical order.

SELECT name FROM Employees ORDER BY name, code;

-- TODO: e) list only the names and salaries in Employees, from the highest to the lowest salary.
    -- DESC: descending order
SELECT name, sal FROM Employees ORDER BY sal DESC;

-- TODO: f) list the cartesian product of Employees and Departments.

SELECT * FROM Employees, Departments;

-- TODO: g) do the natural join of Employees and Departments; the result should be exactly the same as the cartesian product; do you know why?

SELECT * FROM Employees NATURAL JOIN Departments; 

-- 🔥 WHY THE RESULT IS THE SAME AS THE CARTESIAN PRODUCT?
-- The result is the same as the cartesian product because the natural join is matching all the columns with the same name in both tables. Since the columns have the same name, the result is the same as the cartesian product.

-- TODO: i) do an equi join (SAME AS INNER JOIN -> NO NEED TO WRITE "INNER") of Employees and Departments matching the rows by Employees.deptCode and Departments.code (hint: use JOIN and the ON clause).

-- SELECT * FROM Employees JOIN Departments ON Employees.deptCode = Departments.code;
SELECT * FROM Employees A 
JOIN Departments B
ON A.deptCode = B.code;


-- TODO: j) same as previous query but project name and salary of the employees plus the description of their departments.

SELECT A.name, A.sal, B.desc 
FROM Employees A
JOIN Departments B
ON A.deptCode = B.code;

-- No ALIAS Example:
SELECT name, sal, "desc" 
FROM Employees A
JOIN Departments B
ON A.deptCode = B.code;

-- TODO: k) same as previous query but only the employees that earn less than 60000.

SELECT A.name, A.sal, B.desc
FROM Employees A
JOIN Departments B
ON A.deptCode = B.code
WHERE A.sal < 60000;

SELECT A.name, A.sal, B.desc
FROM Employees A, Departments B
WHERE A.deptCode = B.code AND A.sal < 60000;

-- TODO: l) same as query ‘i’  but only the employees that earn more than ‘Jose Caipirinha’.

-- Using the result of a query as a subquery 🤨
SELECT * FROM Employees A
JOIN Departments B
ON A.deptCode = B.code
WHERE A.sal > (SELECT sal FROM Employees WHERE name = 'Jose Caipirinha');

-- TODO: m) list the left outer join of Employees and Departments (use the ON clause to match by department code); how does the result of this query differs from query ‘i’?

SELECT * FROM Employees A
LEFT OUTER JOIN Departments B 
ON A.deptCode = B.code;
-- -- The result of this query differs from query ‘i’ because it includes all the rows from the left table (Employees) and only the matching rows from the right table (Departments) -> some the rows that dont have a match will have NULL values for the columns of the right table and wont be included in the result of query ‘i’.


-- TODO: n) from query ‘m’, how would you do the left anti-join?
SELECT * FROM Employees A
LEFT JOIN Departments B
ON A.deptCode = B.code
WHERE B.code IS NULL;


---- This query will return all the rows from the left table (Employees) that do not have a match in the right table (Departments).

--- Alternative Way
SELECT * FROM Employees WHERE deptCode IS NULL;

-- TODO: n') Department with no employees
SELECT * FROM Employees A
RIGHT JOIN Departments B
ON A.deptCode = B.code
WHERE A.deptCode IS NULL;


-- TODO: o) show the number of employees per department.
SELECT deptCode AS department, COUNT(deptCode) AS total
FROM Employees
WHERE deptCode IS NOT NULL
GROUP BY deptCode
ORDER BY deptCode;

SELECT deptCode AS department, COUNT(deptCode) AS total
FROM Employees
GROUP BY deptCode
HAVING COUNT(deptCode) > 0
ORDER BY deptCode;

---- This will return the number of employees per department, but only for the departments that have at least one employee. The result will be ordered by department code. 
-- - The COUNT(*) will count even the NULL values, so we need to use COUNT(deptCode) to count only the non-NULL values.
-- - HAVE clause is used to filter the result of the GROUP BY clause. In this case, we are filtering the result to show only the departments that have at least one employee.
-- - COUNT(deptCode) will count the number of employees per department.
-- - ORDER BY deptCode will order the result by department code.


-- TODO: p) same as query ‘o’ but I want to see the description of each department (not just their codes).

SELECT B.desc AS department, COUNT(deptCode) AS total
FROM Employees A
JOIN Departments B
ON A.deptCode = B.code
GROUP BY department
ORDER BY department;



-- ####################################
-- INSTRUCTOR EXAMPLE FROM LECTURE 3-7-24: 

[10:53 AM] Thyago Mota
*** Activity 12: Final Code *** 
-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The employees database
 
-- TODO: create database employees
CREATE DATABASE employees;
 
\c employees
 
-- TODO: create table departments
CREATE TABLE Departments (
    code CHAR(2) PRIMARY KEY,
    "desc" VARCHAR(30) NOT NULL
);
 
-- TODO: populate table departments
INSERT INTO Departments VALUES
    ('HR', 'Human Resources'),
    ('IT', 'Information Technology'),
    ('SL', 'Sales');
 
INSERT INTO Departments VALUES
    ('MK', 'Marketing');
 
-- TODO: create table employees
CREATE TABLE Employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    sal DECIMAL(10,2) NOT NULL,
    deptCode CHAR(2),
    FOREIGN KEY (deptCode) REFERENCES Departments (code)
);
 
-- TODO: populate table Employees
INSERT INTO Employees (name, sal, deptCode) VALUES
    ('Sam Mai Tai', 50000, 'HR');
 
INSERT INTO Employees (name, sal, deptCode) VALUES
    ('James Brandy', 55000, 'HR');
 
INSERT INTO Employees (name, sal, deptCode) VALUES
    ('Whisky Strauss', 60000, 'HR');
 
INSERT INTO Employees (name, sal, deptCode) VALUES
    ('Romeo Curacao', 65000, 'IT');
 
INSERT INTO Employees (name, sal, deptCode) VALUES
    ('Jose Caipirinha', 65000, 'IT');
 
INSERT INTO Employees (name, sal, deptCode) VALUES
    ('Toni Gin and Tonic', 80000, 'SL');
 
INSERT INTO Employees (name, sal, deptCode) VALUES
    ('Debby Derby', 85000, 'SL');
 
INSERT INTO Employees (name, sal, deptCode) VALUES
    ('Morbid Mojito', 150000, NULL);
 
-- TODO: a) list all rows in Departments.
SELECT * FROM Departments;
 
-- TODO: b) list only the codes in Departments.
SELECT code FROM Departments;
 
-- TODO: c) list all rows in Employees.
SELECT * FROM Employees;
 
-- TODO: d) list only the names in Employees in alphabetical order.
SELECT name FROM Employees ORDER BY name;
 
-- TODO: e) list only the names and salaries in Employees, from the highest to the lowest salary.
SELECT name, sal FROM Employees ORDER BY sal DESC;
 
-- TODO: f) list the cartesian product of Employees and Departments.
SELECT * FROM Employees, Departments;
 
-- TODO: g) do the natural join of Employees and Departments; the result should be exactly the same as the cartesian product; do you know why?
SELECT * FROM Employees NATURAL JOIN Departments;
 
-- TODO: i) do an equi join of Employees and Departments matching the rows by Employees.deptCode and Departments.code (hint: use JOIN and the ON clause).
SELECT * FROM Employees A
JOIN Departments B
ON A.deptCode = B.code;
 
-- TODO: j) same as previous query but project name and salary of the employees plus the description of their departments.
SELECT A.name, A.sal, B.desc
FROM Employees A
JOIN Departments B
ON A.deptCode = B.code;
 
SELECT name, sal, "desc"
FROM Employees
JOIN Departments
ON deptCode = code;
 
-- TODO: k) same as previous query but only the employees that earn less than 60000.
SELECT A.name, A.sal, B.desc
FROM Employees A
JOIN Departments B
ON A.deptCode = B.code
WHERE sal < 60000;
 
SELECT A.name, A.sal, B.desc
FROM Employees A, Departments B
WHERE A.deptCode = B.code AND sal < 60000;
 
-- TODO: l) same as query ‘i’  but only the employees that earn more than ‘Jose Caipirinha’.
SELECT * FROM Employees A
JOIN Departments B
ON A.deptCode = B.code
WHERE sal > (SELECT sal FROM Employees WHERE name = 'Jose Caipirinha');
 
-- TODO: m) list the left outer join of Employees and Departments (use the ON clause to match by department code); how does the result of this query differs from query ‘i’?
SELECT * FROM Employees A
LEFT OUTER JOIN Departments B
ON A.deptCode = B.code;
 
-- TODO: n) from query ‘m’, how would you do the left anti-join?
SELECT * FROM Employees A
LEFT JOIN Departments B
ON A.deptCode = B.code
WHERE A.deptCode IS NULL;
 
SELECT * FROM Employees
WHERE deptCode IS NULL;
 
-- TODO: n') departments that do not have employees working in
SELECT B.code, B.desc FROM Employees A
RIGHT JOIN Departments B
ON A.deptCode = B.code
WHERE A.deptCode IS NULL;
 
-- TODO: o) show the number of employees per department.
SELECT deptCode AS department, COUNT(deptCode) AS total
FROM Employees
GROUP BY deptCode
HAVING COUNT(deptCode) > 0
ORDER BY deptCode;
 
SELECT deptCode AS department, COUNT(*) AS total
FROM Employees
WHERE deptCode IS NOT NULL
GROUP BY deptCode
ORDER BY deptCode;
 
-- TODO: p) same as query ‘o’ but I want to see the description of each department (not just their codes).
SELECT B.desc AS department, COUNT(deptCode) AS total
FROM Employees A
JOIN Departments B
ON A.deptCode = B.code
GROUP BY department
ORDER BY department;
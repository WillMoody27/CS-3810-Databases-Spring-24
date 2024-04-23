[3/12 10:53 AM] Thyago Mota
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
    ('Sam Mai Tai', 50000, 'HR'),
    ('James Brandy', 55000, 'HR'),
    ('Whisky Strauss', 60000, 'HR'),
    ('Romeo Curacao', 65000, 'IT'),
    ('Jose Caipirinha', 65000, 'IT'),
    ('Toni Gin and Tonic', 80000, 'SL'),
    ('Debby Derby', 85000, 'SL'),
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
SELECT * FROM Employees 
NATURAL JOIN Departments;
 
-- TODO: i) do an equi join (Just a JOIN Bro) of Employees and Departments matching the rows by Employees.deptCode and Departments.code (hint: use JOIN and the ON clause).
SELECT * FROM Employees E
JOIN Departments D
ON E.deptCode = D.code;
 
-- TODO: j) same as previous query but project name and salary of the employees plus the description of their departments.
SELECT name, sal, description FROM Employees E
JOIN Departments D
ON E.deptCode = D.code;
 
-- TODO: k) same as previous query but only the employees that earn less than 60000. 
SELECT name, sal, description FROM Employees E
JOIN Departments D
ON E.deptCode = D.code
WHERE sal < 60000;
 
-- TODO: l) same as query ‘i’  but only the employees that earn more than ‘Jose Caipirinha’.
SELECT * FROM Employees E
JOIN Departments D
ON E.deptCode = D.code
WHERE sal > (SELECT sal FROM Employees WHERE name = 'Jose Caipirinha');
 
-- TODO: m) list the left outer join of Employees and Departments (use the ON clause to match by department code); how does the result of this query differs from query ‘i’? -> Show everything in the employees table including those without a deptCode
SELECT * FROM Employees E
LEFT OUTER JOIN Departments D
ON E.deptCode = D.code;
 
-- TODO: n) from query ‘m’, how would you do the **left anti-join**? -> Shows the employees that dont have a dept code only (or are null for the deptCode).
SELECT * FROM Employees E
LEFT JOIN Departments D
ON E.deptCode = D.code
WHERE E.deptCode IS NULL;
 
-- TODO: n') departments that do not have employees working in
SELECT code, description FROM Employees E
RIGHT JOIN Departments D
ON E.deptCode = D.code
WHERE E.deptCode IS NULL;
 

-- TODO: o) show the number of employees per department.❌ 
SELECT deptCode AS Department, COUNT(deptCode) AS total
FROM Employees E
GROUP BY deptCode
HAVING COUNT(deptCode) > 0
ORDER BY deptCode;
 
-- TODO: p) same as query ‘o’ but I want to see the description of each department (not just their codes). ❌
SELECT description AS department, COUNT(deptCode) AS total
FROM Employees E
JOIN Departments D
ON E.deptCode = D.code
GROUP BY department
ORDER BY department;

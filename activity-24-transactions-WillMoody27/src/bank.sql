CREATE DATABASE bank;

\c bank

CREATE TABLE Accounts (
    number INT PRIMARY KEY, 
    owner VARCHAR(50) NOT NULL, 
    balance DECIMAL(10,2)
);

INSERT INTO Accounts VALUES 
    (101, 'Daniel', 2500), 
    (202, 'Max', 300);


CREATE USER "bank" PASSWORD '135791';
GRANT ALL ON TABLE Accounts TO "bank";
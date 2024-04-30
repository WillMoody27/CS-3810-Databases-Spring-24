-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): William Hellems-Moody, David Carter
-- Description: SQL for the job hunters database


-- ---------------------------- PART B ----------------------------

DROP DATABASE job_hunters;

CREATE DATABASE job_hunters;

\c job_hunters;

-- Commands to run docker container -> Replace with you own values "<....>" --
-- docker run --rm --name postgres --publish <PORT>:<PORT> -e POSTGRES_PASSWORD=135791 -v <PATH TO LOCAL DB>:/var/lib/postgresql/data postgres

-- Run PSQL --
-- docker exec -it postgres psql -U postgres

-- TODO: table create statements.
DROP TABLE Positions;
DROP TABLE Candidates;
DROP TABLE Applications;
DROP TABLE StatusCodes;

-- Create Table for Positions
-- Skill can be a null field for this database setup
-- TODO 🔥 - Changed VARCHAR(255) -> TEXT to handle larger text input.
CREATE TABLE Positions (
    id SERIAL PRIMARY KEY NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    skills VARCHAR(100),
    level VARCHAR(20) NOT NULL,
    creation_date DATE NOT NULL,
    exp_date DATE NOT NULL
);

-- Create Table for Candidates
CREATE TABLE Candidates (
    email VARCHAR(100) PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100),
    telephone VARCHAR(20) NOT NULL
);


-- Create Table for Status Codes
-- TODO 🔥 - Updated CHAR(n) for code.
CREATE TABLE StatusCodes (
    code CHAR(3) PRIMARY KEY NOT NULL,
    description VARCHAR(100) NOT NULL
);

-- Create Table for Applications
CREATE TABLE Applications (
    position_id INT NOT NULL,
    candidate_email VARCHAR(100) NOT NULL,
    status_code CHAR(3) NOT NULL,
    FOREIGN KEY (position_id) REFERENCES positions(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_email) REFERENCES candidates(email) ON DELETE CASCADE,
    FOREIGN KEY (status_code) REFERENCES statuscodes(code),
    application_date DATE NOT NULL
);

-- These position are added to represent the project's requirements
-- TODO-Completed: Updated the INSERT STATEMENTS to all for the Positions ID to auto increment (3-10-24). 🔥🔥🥴🔥🔥
INSERT INTO Positions (title, description, skills, level, creation_date, exp_date) VALUES 
('Software Engineer', 'A software engineer for a mobile app development project', 'android, java, postgres', 'entry', '2024-02-25', '2024-03-25'),
('Database Administrator', 'A database administrator with experience with postgres', 'sql, postgres, erd, uml', 'senior', '2024-02-20', '2024-04-20'),
('Software QA', 'A software quality assurance test engineer', 'python, java, unit test, selenium', 'medium', '2024-01-15', '2024-02-20'),
('Project Manager', 'A project manager with experience in agile development', 'agile, scrum', 'senior', '2024-02-26', '2024-06-26'),
('Software Intern', 'An intern with desire to learn (no skill needed)', NULL, 'entry', '2024-02-25', '2024-03-30');

-- ADDED 🔥 Data Analyst Position
INSERT INTO Positions (title, description, skills, level, creation_date, exp_date) VALUES 
('Data Analyst', 'A data analyst with experience in data visualization', 'sql, python, tableau', 'medium', '2024-02-25', '2024-03-25');

-- TODO-Completed: Updated the INSERT STATEMENTS for the Candidates to include the NULL fields for the address, and added the correct candidates per the project requirements (3-10-24). 🥴
INSERT INTO Candidates (email, name, address, telephone) VALUES 
('amelinha@gmail.com', 'Amelia Claudia Garcia Collares', NULL, '(720) 484-1234'),
('cazuza@gmail.com', 'Angnor de Miranda Araujo Neto', NULL, '(484) 234-2312'),
('yahoo@yahoo.com', 'Robertinho do Recife', 'Recife, PE', '(720) 123-9876');

-- ADDED 🔥 - Jank Yeon is not applying for any position, for example
INSERT INTO Candidates (email, name, address, telephone) VALUES 
('janky@email.com', 'Jank Yeon', 'Seoul, South Korea', '(720) 123-9876');

-- Status codes using a 3-letter code: APL (“candidate”), RJT (“rejected”), SLT (“selected”), DRP (“discarded”). ") or HRD ("contractor");
INSERT INTO StatusCodes (code, description) VALUES
('APL', 'candidate'),
('RJT', 'rejected'),
('SLT', 'selected'),
('DRP', 'discarded'),
('HRD', 'contractor');

-- Have candidates apply for positions
-- TODO-Completed: Updated the INSERT STATEMENTS for the Applications to include the possiblity that multiple candidates can apply to different positions (3-10-24).🥴
-- TODO 🔥 - Updated the status codes.
INSERT INTO Applications (position_id, candidate_email, status_code, application_date) VALUES
(1, 'amelinha@gmail.com', 'APL', '2021-02-08'),
(2, 'cazuza@gmail.com', 'RJT', '2021-03-10'),
(3, 'amelinha@gmail.com', 'SLT', '2021-03-10'),
(4, 'yahoo@yahoo.com', 'APL', '2021-05-15'),
(2, 'yahoo@yahoo.com', 'DRP', '2021-05-15'),
(5, 'yahoo@yahoo.com', 'HRD', '2021-02-27'),
(1, 'cazuza@gmail.com', 'RJT', '2021-01-12');



-- - All foreign keys must be set whenever appropriate and if a position is deleted, all candidate applications to that position must as well be automatically deleted; 😱
-- - All tables must have a primary key; 😱
DELETE FROM Positions WHERE id = 1;
DELETE FROM Candidates WHERE email = 'yahoo@yahoo.com';

-- ---------------------------- PART C ----------------------------

-- TODO: SQL queries

-- a) all position titles in alphabetical order 🔥.

SELECT title FROM Positions ORDER BY title;

-- b) number of candidates (labeled as total_candidates) in the database 🔥

SELECT COUNT(*) AS total_candidates FROM Candidates;

-- c) number of positions (labeled as number_positions) by classification 🔥
-- Assuming classification means level

SELECT level, COUNT(*) AS number_positions FROM Positions GROUP BY level;

-- d) a list of all applications with the position ids, candidate names, and the status (description) of their applications, ordered by position id and then candidate name 🔥

SELECT pos.id, cand.name, stat.description FROM Applications app, Positions pos, Candidates cand, StatusCodes stat WHERE app.position_id = pos.id AND app.candidate_email = cand.email AND app.status_code = stat.code ORDER BY pos.id, cand.name;

-- e) similar to d, but showing the position title too 🔥 

SELECT pos.id, pos.title, cand.name, stat.description FROM Applications app, Positions pos, Candidates cand, StatusCodes stat WHERE app.position_id = pos.id AND app.candidate_email = cand.email AND app.status_code = stat.code ORDER BY pos.id, cand.name;

-- f) number of positions per classification, order by classification and having the number of positions column referred to as "total" 🔥

SELECT level, COUNT(*) AS total FROM Positions GROUP BY level ORDER BY level;

-- g) positions (id and title) that are still open (ie, candidates can still apply today), order by their id. 🔥

SELECT id, title FROM Positions WHERE exp_date >= CURRENT_DATE ORDER BY id;

-- h) a (distinct) alphabetic list of the candidates that are applying for positions 🔥

SELECT DISTINCT name FROM Candidates, Applications WHERE Candidates.email = Applications.candidate_email;

-- i) show a (distinct) alphabetic list of the candidates that are NOT applying for positions 🔥

-------> ADDED 🔥 (Jank Yeon is not applying for any position, for example)

SELECT DISTINCT name FROM Candidates WHERE email NOT IN (SELECT candidate_email FROM Applications);

-- j) show a list of all positions that require "java" as a skill 🔥

SELECT * FROM Positions WHERE skills LIKE '%java%';

-- *** BONUS *** 
-- k) the name of the candidate that applied for the most positions 🔥

SELECT name, COUNT(*) AS total FROM Candidates, Applications WHERE Candidates.email = Applications.candidate_email GROUP BY name ORDER BY total DESC LIMIT 1;


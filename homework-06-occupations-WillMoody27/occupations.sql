-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: William Hellems-Moody
-- Description: a database of occupations

CREATE DATABASE occupations;

\c occupations

DROP TABLE IF EXISTS Occupations;

-- TODO: create table Occupations

CREATE TABLE Occupations(
    code VARCHAR(12) PRIMARY KEY,
    occupation VARCHAR(250),
    job_family VARCHAR(250)
);

-- TODO: populate table Occupations
\copy Occupations FROM '/var/lib/postgresql/data/occupations.csv' CSV HEADER;

-- TODO: a) the total number of occupations (expect 1016).

SELECT COUNT(*) FROM Occupations;

-- TODO: b) a list of all job families in alphabetical order (expect 23).

SELECT DISTINCT job_family FROM Occupations ORDER BY job_family;

-- TODO: c) the total number of job families (expect 23)

SELECT COUNT(DISTINCT job_family) FROM Occupations;

-- TODO: d) the total number of occupations per job family in alphabetical order of job family.

SELECT COUNT(*) AS total, job_family FROM Occupations GROUP BY job_family ORDER BY job_family;

-- This will filter out the count of the total number of occupation per job fam and order the values by the job family. 🔥

SELECT job_family, COUNT(*) FROM Occupations GROUP BY job_family ORDER BY job_family;

-- TODO: e) the number of occupations in the "Computer and Mathematical" job family (expect 38)

SELECT COUNT(*) FROM Occupations WHERE job_family = 'Computer and Mathematical' GROUP BY job_family;


-- BONUS POINTS

-- TODO: f) an alphabetical list of occupations in the "Computer and Mathematical" job family.

SELECT Occupation FROM Occupations WHERE job_family = 'Computer and Mathematical' ORDER BY Occupation;

-- TODO: g) an alphabetical list of occupations in the "Computer and Mathematical" job family that begins with the word "Database"

SELECT Occupation FROM Occupations WHERE job_family = 'Computer and Mathematical' AND Occupation LIKE 'Database%' ORDER BY Occupation;

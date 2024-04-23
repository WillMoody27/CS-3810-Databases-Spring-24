-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The astronauts database

CREATE DATABASE astronauts;

\c astronauts

DROP TABLE Astronauts;

```
Astronauts(id: integer, year: int, name: string, nasa_group: integer, status: string, birth_date: date, birth_place: string, gender: string, alma_mater: string, ugrad_major: string, grad_major: string, mil_rank: string, mil_branch: string, number_flights: integer, flight_hours: float, number_walks: integer, walk_hours: integer, missions: string, death_date: date, death_mission: string)  

Save all SQL commands in a file called [astronauts.sql](astronauts.sql).  

Primary key id should be an auto-incremented field (serial in Postgres). Carefully inspect [astronauts.csv](astronauts.csv) and then decide the maximum size of each column and whether a column should accept null values or not. 
```

CREATE TABLE Astronauts(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    year INT,
    nasa_group INT,
    status VARCHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    birth_place VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    alma_mater VARCHAR(150),
    ugrad_major VARCHAR(100),
    grad_major VARCHAR(100),
    mil_rank VARCHAR(50),
    mil_branch VARCHAR(50),
    number_flights INT NOT NULL,
    flight_hours FLOAT NOT NULL,
    number_walks INT NOT NULL,
    walk_hours FLOAT,
    missions VARCHAR(150),
    death_date DATE,
    death_mission VARCHAR(50)
);

-- copy command
```
FOR LAUNCHING DOCKER:

\copy Astronauts FROM '/var/lib/postgresql/data/astronauts.csv' CSV HEADER;

\copy Astronauts(name, year, nasa_group, status, birth_date, birth_place, gender, alma_mater, ugrad_major, grad_major, mil_rank, mil_branch, number_flights, flight_hours, number_walks, walk_hours, missions, death_date, death_mission) FROM '/var/lib/postgresql/data/astronauts.csv' DELIMITER ',' CSV HEADER;
```

-- a) the total number of astronauts. 

SELECT COUNT(*) AS total FROM Astronauts;

-- b) the total number of American astronauts. 

SELECT COUNT(*) AS total FROM Astronauts WHERE birth_place LIKE '%USA%';

SELECT COUNT(*) AS total FROM Astronauts WHERE birth_place LIKE '%__';

-- c) birth places of all non-american astronauts in alphabetical order. 

SELECT birth_place FROM Astronauts WHERE birth_place NOT LIKE '%USA%' ORDER BY birth_place;

-- d) alphabetical list of all astronauts

SELECT name FROM Astronauts ORDER BY name;

-- e) the total number of astronauts by gender. 

SELECT gender, COUNT(*) AS total FROM Astronauts GROUP BY gender;

-- f) the total number of female astronauts that are still active. 

SELECT COUNT(*) AS total FROM Astronaut WHERE gender = 'Female' AND status = 'Active';

-- g) the total number of American female astronauts that are still active. 

SELECT COUNT(*) AS total FROM Astronauts WHERE birth_place LIKE '%USA%' AND status = 'Active';

-- h) alphabetical list of all American female astronauts that are still active ordered by last name (use the same name format used in d). 

SELECT name FROM Astronauts WHERE birth_place LIKE '%__' AND gender = 'Female' AND status = 'Active' ORDER BY name;

-- i) the total number of American astronauts by state birth plae. 

SELECT SUBSTRING(birth_place FROM POSITION(',' in birth_place) + 2) AS state, COUNT(*)
 FROM Astronauts 
 WHERE birth_place LIKE '%__' 
 GROUP BY state 
 ORDER BY total;

-- j) the state that had the most number of astronauts according to the dataset. 

SELECT SUBSTRING(birth_place FROM POSITION(',' in birth_place) + 2) AS state, COUNT(*) AS total
 FROM Astronauts 
 WHERE birth_place LIKE '%__' 
 GROUP BY state 
 ORDER BY total DESC
 LIMIT 1;

 -- Limit 1 will show the first row of the table, which will be the state with the most astronauts.


-- k) the total number of astronauts by statuses (i.e., active or retired). 

SELECT status, COUNT(*) AS total FROM Astronauts GROUP BY status;

-- l) name and age (in years) of all still active astronauts (oldest first). 

SELECT name, DATE_PART('year', AGE(CURRENT_DATE, birth_date)) AS age
 FROM Astronauts 
 WHERE status = 'Active' 
 ORDER BY age DESC;

-- m) the average age of all astronauts that are still active. 

SELECT AVG(DATE_PART('year', AGE(CURRENT_DATE, birth_date))) AS average_age
 FROM Astronauts 
 WHERE status = 'Active';


-- #############################################################
-- #############################################################

-- DR. MOTA'S SOLUTIONS FROM IN-CLASS LECTURE

-- a) the total number of astronauts.
SELECT COUNT(*) AS total FROM Astronauts;
 
-- b) the total number of American astronauts.
SELECT COUNT(*) FROM Astronauts WHERE birth_place LIKE '%, __';
 
-- c) birth places of all non-american astronauts in alphabetical order.
SELECT birth_place FROM Astronauts WHERE birth_place NOT LIKE '%, __';
 
-- d) alphabetical list of all astronauts
SELECT name FROM Astronauts ORDER BY name;
 
-- e) the total number of astronauts by gender.
SELECT gender, COUNT(*) AS total FROM Astronauts GROUP BY gender;
 
-- f) the total number of female astronauts that are still active.
SELECT COUNT(*) AS total FROM Astronauts WHERE gender = 'Female' AND status = 'Active';
 
-- g) the total number of American female astronauts that are still active.
SELECT COUNT(*) FROM Astronauts WHERE birth_place LIKE '%, __' AND gender = 'Female' AND status = 'Active';
 
-- h) alphabetical list of all American female astronauts that are still active ordered by name
SELECT name FROM Astronauts WHERE birth_place LIKE '%, __' AND gender = 'Female' AND status = 'Active' ORDER BY name;
 
-- i) the total number of American astronauts by state birth place.
SELECT SUBSTRING(birth_place FROM POSITION(',' in birth_place) + 2) AS state, COUNT(*)
FROM Astronauts
WHERE birth_place LIKE '%, __'
GROUP BY state
ORDER BY state;
 
-- j) the state that had the most number of astronauts according to the dataset.
SELECT SUBSTRING(birth_place FROM POSITION(',' in birth_place) + 2) AS state, COUNT(*) AS total
FROM Astronauts
WHERE birth_place LIKE '%, __'
GROUP BY state
ORDER BY total DESC
LIMIT 1;
 
-- k) the total number of astronauts by statuses (i.e., active or retired).
SELECT status, COUNT(*) AS total
FROM Astronauts
GROUP BY status;
 
-- l) name and age (in years) of all still active astronauts (oldest first).
SELECT name, DATE_PART('year', AGE(CURRENT_DATE, birth_date)) AS age
FROM Astronauts
WHERE status = 'Active'
ORDER BY age DESC;
 
-- m) the average age of all astronauts that are still active.
SELECT AVG(DATE_PART('year', AGE(CURRENT_DATE, birth_date))) AS avg_age
FROM Astronauts
WHERE status = 'Active';

-- #############################################################
-- #############################################################


-- a) the number of star wars films
SELECT COUNT(*) AS total FROM Films;
-- b) the age group (description) that has the most fans
SELECT description, COUNT(*) AS total
FROM Fans A
JOIN AgeGroups B
ON A.age = B.seq
GROUP BY description
ORDER BY total DESC
LIMIT 1;

-- c) the education level (description) with the least number of fans
SELECT description, COUNT(*) AS total
FROM Fans A
JOIN EducationLevels B
ON A.education = B.seq
GROUP BY description
ORDER BY total
LIMIT 1;

-- d) the name of the star wars characters in alphabetical order 🔥
SELECT name FROM Characters ORDER BY name;

-- e) the star wars characters that have no fan ratings 
SELECT name FROM Characters C
LEFT JOIN FilmRatings F
ON C.id = F.fan
WHERE rating IS NULL;

-- f) the top 3 star wars characters based on fan ratings, showing their names and the average rating (rounded to 2 decimals) that they received 

-- g) The ids of the fans that gave a rating of 1 for "Darth Vader", in ascending order, so that they be banned from future star wars views

-- h) the top rated star wars film by the fans 

-- j) the top rated film by fans with income '$150,000+'

-- k) the number of ratings AND the average rating received by "Princess Leia", rounded to 2 decimals

-- l) the average rating of "Star Wars: Episode V The Empire Strikes Back", rounded to 2 decimals

-- m) the name of the character that received the least number of ratings 

-- n) the favorite character according the yongest fan audience

-- o) the income levels (descriptions) that has at least 100 fans, ordered by income sequential number


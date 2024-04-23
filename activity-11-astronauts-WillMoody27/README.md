The goal of this activity is to create a database of living astronauts and use it to answer a few queries.

## Part I - Database Schema

You should use astronauts as the name of your database. This database should have a single table named **Astronauts** with the following relational schema:

```
Astronauts(id: integer, year: int, name: string, nasa_group: integer, status: string, birth_date: date, birth_place: string, gender: string, alma_mater: string, ugrad_major: string, grad_major: string, mil_rank: string, mil_branch: string, number_flights: integer, flight_hours: float, number_walks: integer, walk_hours: integer, missions: string, death_date: date, death_mission: string)
```

Save all SQL commands in a file called [astronauts.sql](astronauts.sql).

Primary key id should be an auto-incremented field (serial in Postgres). Carefully inspect [astronauts.csv](astronauts.csv) and then decide the maximum size of each column and whether a column should accept null values or not.

Start Postgres if you haven't yet using the following command, obviously changing the path to your local postgres folder to match your settings.

<!--  -->

```
docker run --rm --name postgres --publish 5432:5432 -e POSTGRES_PASSWORD=135791 -v /Users/tmota/devel/teach/__24SCS3810_DB/postgres:/var/lib/postgresql/data postgres


✅
docker run --rm --name postgres --publish 5433:5433 -e POSTGRES_PASSWORD=135791 -v /Users/williamhellems-moody/Documents/spring-2024/3180-databases/3810-db:/var/lib/postgresql/data postgres
```

Next, start **psql** using:

```
docker exec -it postgres psql -U postgres
```

Create the **astronauts** database and the **Astronauts** table. Finish this part of the activity by successfully uploading the csv file into the newly created table. Remember to manually copy the csv file to your local postgres folder.

## Part II - Queries

When you are done populating your table, you should write the following queries using SQL syntax. Save all query commands in astronauts.sql.

a) the total number of astronauts.

b) the total number of American astronauts.

c) birth places of all non-american astronauts in alphabetical order.

d) alphabetical list of all astronauts

e) the total number of astronauts by gender.

f) the total number of female astronauts that are still active.

g) the total number of American female astronauts that are still active.

h) alphabetical list of all American female astronauts that are still active ordered by last name (use the same name format used in d).

i) the total number of American astronauts by state birth plae.

j) the state that had the most number of astronauts according to the dataset.

k) the total number of astronauts by statuses (i.e., active or retired).

l) name and age (in years) of all still active astronauts (oldest first).

m) the average age of all astronauts that are still active.

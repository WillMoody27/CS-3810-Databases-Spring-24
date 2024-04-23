# Introduction

A container is a standardized software package that allows applications to run quickly and reliably in different computing environments​. A container packages up code and all its dependencies so applications can be easily deployed in different computer platforms. A container is created from a container image. A container engine runs containers​. Available for most popular platforms, containerized software will always run the same, regardless of the underlying infrastructure.

Docker is a container image format and also a complete solution for software containerization. Download docker desktop from [docs.docker.com/desktop](https://docs.docker.com/desktop). Docker hub [hub.docker.com](https://hub.docker.com) is a public repository of docker images that are available to use, currently with > 7M images.

# Setup Local Storage

<!--  -->

Create a (local) folder fo all of the databases you will be creating this semester using postgres. Make sure you know the absolute path to this folder. For example:

```
/Users/tmota/devel/teach/__24SCS3810_DB/postgres
```

# PATH TO MY DOCKER FOLDER 🔥

```
/Users/williamhellems-moody/Documents/spring-2024/3180-databases/docker_folder

<!-- Desktop -->
/Users/williamhellems-moody/Desktop/docker-main
```

# Running Postgres as a Container

Download the postgres (standard) docker image from Docker hub using:

```
docker pull postgres
```

Then start your postgres container from the image that you downloaded using:

```
✅
docker run --rm --name postgres --publish 5432:5432 -e POSTGRES_PASSWORD=135791 -v /Users/tmota/devel/teach/__24SCS3810_DB/postgres:/var/lib/postgresql/data postgres
```

```
docker run --rm --name postgres --publish 5432:5432 -e POSTGRES_PASSWORD=1234 -v /Users/williamhellems-moody/Documents/spring-2024/3180-databases/3810-db:/var/lib/postgresql/data postgres
```

```
<!-- Personal Project -->
docker run --rm --name postgres --publish 5432:5432 -e POSTGRES_PASSWORD=1234 -e POSTGRES_USER=postgres -e POSTGRES_DB=mydb -v /Users/williamhellems-moody/Desktop/docker-pdf-backend:/var/lib/postgresql/data postgres
```

```

The command above will start postgres using 135791 as the password for the postgres (default) user. Note the use of -e parameter (useful to set environment variables) for your container. The environment variables that need to be set is container-dependent. Also note the -v parameter which allows mapping the container's postgres storage to a localq folder of your choice. Of course, you need to replace the absolute path to match your own environment. If postgres started successfully, you should be able to see the following log message:

```

LOG: database system is ready to accept connections

```

# Starting a psql Session

On another terminal window, use **docker exec** to start **psql** session to connect with the DBMS.

```

docker exec -it postgres psql -U postgres

```

If the command above is successful, you should be able to see **psql** prompt:

```

psql (16.2 (Debian 16.2-1.pgdg120+2))
Type "help" for help.

postgres=#

```

# Create a Database

Use the following commands to create a simple database for testing purposes. Run one command at a time using copy-and-paste.

```

CREATE DATABASE test;

\c test

CREATE TABLE Employees (
id INT PRIMARY KEY,
name VARCHAR(35) NOT NULL,
sal INT );

INSERT INTO Employees VALUES
(101, 'Sam Mai Tai', 35000),
(202, 'Morbid Mojito', 65350);

```

Use the following command to display all employees:

```

SELECT \* FROM Employees;

```

If the command above is successful, you should be able to see the Employees table:

```

id | name | sal
-----+---------------+-------
101 | Sam Mai Tai | 35000
202 | Morbid Mojito | 65350
(2 rows)

```

To quit psql just run exit or \q.

# Reconnect

To make sure your database is preserved, use CTRL-C to stop your container image from running. Than recreate a container from the postgres image using:

```

docker run --rm --name postgres --publish 5433:5433 -e POSTGRES_PASSWORD=135791 -v /Users/williamhellems-moody/Documents/spring\ 2024/3180-databases/docker_folder:/var/lib/postgresql/data postgres

```

On another terminal window, use docker exec to start psql session to connect with the DBMS.

```

docker exec -it postgres psql -U postgres

```

Use the following commands to display all employees:

```

\c test

SELECT \* FROM Employees;

```

You should be able to see all of the employees inserted previously. When you are done, exit psql using \q.

# PostgreSQL VS-Code Extension

Install [Kolkman's PostgreSQL VS-Code extension](https://marketplace.visualstudio.com/items?itemName=ckolkman.vscode-postgres). Choose, using VS-Code command feature (CMD-SHIFT-P), **PostgreSQL: Add Connection**. Use the following parameters to configure the database connection:

- localhost
- postgres
- 135791
- 5433
- Standard Connection
- Show All Databases

Next use **PostgreSQL: Explorer** to view the Employees table.
```

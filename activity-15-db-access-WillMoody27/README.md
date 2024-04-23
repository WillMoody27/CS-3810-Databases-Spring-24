# Introduction

An important task of a database system administrator is to manage user access. This activity walks you through the steps to create users with different privileges in a database using SQL Data Control Language (DCL).

## Step 1: Create Database and Tables

Create a database name **hr** and a table called **Employees** with the following schema.

```
CREATE DATABASE hr;

\c hr

CREATE TABLE Employees (
 id INT NOT NULL PRIMARY KEY,
 name VARCHAR(35) NOT NULL,
 sal INT );

INSERT INTO Employees VALUES
 ( 1, 'Sam Mai Tai', 35000 ),
 ( 2, 'Morbid Mojito', 65350 );
```

## Step 2: Create Users

Create users **hr** and **hr_admin** using the following syntax.

```
CREATE USER "hr" PASSWORD '024680';
CREATE USER "hr_admin" PASSWORD '135791';
```

## Step 3: Verify Users

All users in Postgres are saved internally. You can list them using:

```
\du
```

Verify that users hr and hr_admin are listed.

```

                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 hr        |                                                            | {}
 hr_admin  |                                                            | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```

## Step 4: Grant Access to the Users

We want to restrict access of user **hr** to **SELECT** operations on table **Employees**. On the other hand, user **hr_admin** should be granted full access to the same table. Below are the commands you use to grant specific access to users on a table.

```
GRANT SELECT ON TABLE Employees TO "hr";
GRANT ALL ON TABLE Employees TO "hr_admin";

-- This is how we can grant access to the sequence of the table.
```

## Step 5: Test User Access

Now logoff from psql and login again as user **hr**. Try to issue a query and an INSERT. The later operation should fail because user hr access was restricted to SELECT operations only.

On the terminal:

```
docker exec -it postgres psql -d hr -U hr -W
```

On psql tool, let's try to add employee name Thyago with a 200K salary since he is such a great professor!

```
INSERT INTO Employees VALUES (3, 'Thyago', 200000);
INSERT INTO Employees VALUES (4, 'Will', 200000);
```

Unfortunately, it should NOT work! I guess my planned weekend at the Broadmoor Hotel will have to be canceled.

```
ERROR:  permission denied for table employees
```

Now try select on table Employees. It should work!

Logoff from postgres and repeat the insert statement, but now logged in as **hr_admin**. This time it should work!

```
docker exec -it postgres psql -d hr -U hr_admin -W

-- Admin will be able to add the new employees to the table.
```

There is much more about user access control. For example, you can grant access to a user on different object types, not only on a table but to a whole database, for example. There are also many other grant privilege levels other than the ones described here.

# Further Practice

Create another database called **hotels** using the SQL script below.

```
CREATE DATABASE hotels;

\c hotels

CREATE TABLE hotels (
    code SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state CHAR(2) NOT NULL
);

INSERT INTO hotels (name, city, state) VALUES
    ('Le Boutique', 'New Orleans', 'LA'),
    ('Supreme', 'San Francisco', 'CA');
```

Then create the following user with the permissions below.

```
CREATE USER "hotel_manager" PASSWORD '135791';
GRANT ALL ON TABLE hotels TO "hotel_manager";
GRANT ALL ON SEQUENCE hotels_code_seq TO "hotel_manager";
```

Check if you are able to login on Postgres using the user **hotel_manager**.

```
docker exec -it postgres psql -d hotels -U hotel_manager -W
```

Once you successfully logged in with user **hotel_manager**, check access to the table by inserting the following row:

```
INSERT INTO hotels (name, city, state) VALUES
    ('Broadmoor', 'Colorado Springs', 'CO');
```

# Introduction

SQL injection exploits user input as part of the SQL statement​ for malicious purposes. In this activity you will write a code that illustrates SQL injection.

# Database

Create the **academics** database using the following schema:

```
CREATE DATABASE academics;

\c academics

CREATE TABLE Courses (
    code VARCHAR(3) NOT NULL,
    number INT NOT NULL,
    descr VARCHAR(50) NOT NULL,
    PRIMARY KEY (code, number)
);

INSERT INTO Courses VALUES
    ('CS', 2050, 'Computer Science 2'),
    ('CS', 3810, 'Principles of Database Systems');

CREATE TABLE Students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

INSERT INTO Students (name) VALUES
    ('Sneaky Peaky'),
    ('Butch Cassidy'),
    ('John Dillinger');

CREATE TABLE Grades (
    code VARCHAR(3) NOT NULL,
    number INT NOT NULL,
    id INT NOT NULL,
    letter VARCHAR(2) NOT NULL,
    PRIMARY KEY (id, code, number),
    FOREIGN KEY (code, number) REFERENCES Courses (code, number),
    FOREIGN KEY (id) REFERENCES Students (id)
);

INSERT INTO Grades VALUES
    ('CS', 3810, 1, 'F');

-- UPDATE Grades SET letter = 'A+' WHERE name =

CREATE USER "academics" PASSWORD '135791';
GRANT ALL ON TABLE Courses TO "academics";
GRANT ALL ON TABLE Students TO "academics";
GRANT ALL ON TABLE Grades TO "academics";
GRANT ALL ON SEQUENCE students_id_seq TO "academics";

SELECT * FROM Grades
NATURAL JOIN Students
NATURAL JOIN Courses
WHERE name = 'Sneaky Peaky';
```

# Python Script

The original intention of the following Python script was to show the grades of a student given their id.

```
import psycopg2
import configparser as cp

config = cp.RawConfigParser()
config.read('src/config.ini')
params = dict(config.items('db'))
conn = psycopg2.connect(**params)
conn.autocommit = True
if conn:
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    # code to inject in the name: 1; UPDATE Grades SET letter = 'B+' WHERE id = 1
    id = input('id? ')
    sql = '''
        SELECT * FROM Grades
        WHERE id = %s;
    '''
    cur = conn.cursor()
    cur.execute(sql % (id))
    for row in cur:
        print(row)

    print('Bye!')
    conn.close()
```

When asked for the student's id, enter the following:

```
1; UPDATE Grades SET letter = 'B+' WHERE id = 1
```

Because there is no validation on the id, the user completed the id with a **sneaky** SQL code that was maliciously injected to update the student's letter grade to A+. Note that for the code to work the connection was set to **autocommit**.

# Protecting the Code (version 1)

Simply checking the type of an input field solves most SQL injection problems.

```
import psycopg2
import configparser as cp

config = cp.RawConfigParser()
config.read('src/config.ini')
params = dict(config.items('db'))
conn = psycopg2.connect(**params)
conn.autocommit = True
if conn:
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    # code to inject in the name: 1; UPDATE Grades SET letter = 'A+' WHERE id = 1
    id = input('id? ')
    try:
        id = int(id)
        sql = '''
            SELECT * FROM Grades
            WHERE id = %s;
        '''
        cur = conn.cursor()
        cur.execute(sql % (id))
        for row in cur:
            print(row)
    except:
        print('Given id is NOT valid!')

    print('Bye!')
    conn.close()
```

# Protecting the Code (version 2)

The best protection against SQL injection is using the so-called **prepared statements** which is a parameterized and reusable SQL query that splits the SQL command and the user-provided data. Although **psycopg2** does not support **prepared statements** (yet), you can leverage postgres' support of **prepared statement**.

```
import psycopg2
import configparser as cp

config = cp.RawConfigParser()
config.read('src/config.ini')
params = dict(config.items('db'))
conn = psycopg2.connect(**params)
conn.autocommit = True
if conn:
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    # code to inject in the name: 1; UPDATE Grades SET letter = 'A+' WHERE id = 1
    id = input('id? ')
    sql = '''
        prepare statement as
        SELECT * FROM Grades
        WHERE id = $1;
    '''
    cur = conn.cursor()
    cur.execute(sql)
    cur.execute("execute statement (%s)", (id))
    for row in cur:
        print(row)

    print('Bye!')
    conn.close()
```

<!-- -- This statement prepares the SQL query and then executes it with the user-provided data, and avoids SQL injection and executes the query safely and faster. -->

When asked for the student's id, try to inject the following:

```
1; UPDATE Grades SET letter = 'F' WHERE id = 1
```

You should now get the following error:

```
TypeError: not all arguments converted during string formatting
```

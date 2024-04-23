# Introduction

This activity walks you through the steps to connect and run SQL queries in Python using the **psycopg**, Python's most popular Postgres module. More info about **psycopg** can be found at [https://pypi.org/project/psycopg2/](https://pypi.org/project/psycopg2/).

# Install psycopg (version 2)

```
pip3 install psycopg2
```

Note: if the command above doesn't work, try installing the binary version of the module:

```
pip3 install psycopg2-binary
```

# Connect to Postgress from Python

Type the code below (save it as **testdb.py**), making sure you have database "hr" created (use psql to verify that).

```
import psycopg2

params = {
    'host': 'localhost',
    'port': 5432,
    'dbname': 'hr',
    'user': 'hr_admin',
    'password': '135791'
}

conn = psycopg2.connect(**params)
if conn:
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    print('Bye!')
    conn.close()
```

Run **testdb.py** and verify that you are able to connect to postgres. If everything works you should get a message saying:

✅

```
Connection to Postgres database hr was successful!
Bye!
```

# Run a Simple Query

Add the following lines of code right-after the connection but before the call to close.

✅

```
    cur = conn.cursor()
    sql = 'SELECT id, name FROM employees'
    cur.execute(sql)
    for row in cur.fetchall():
        print(row)
```

Run your code again. You should be able to see the rows from table **Employees**. ✅

# Final Note

The example here exposes the database password in the code which is bad practice that you should avoid. On the next activity we will discuss alternatives to properly secure your password in a program that access a database.

# Further Practice

Remember the **hotels** database? Do you think you can write a Python script to connect to the **hotels** database?

- The script for he **hotels** database should be similar to the one above, but with the correct parameters for the **hotels** database.
- The script should print the rows from the **hotels** table.
- The script should not expose the password in the code.
- The script should be able to connect to the **hotels** database and print the rows from the **hotels** table.

```
import psycopg2

params = {
    'host': 'localhost',
    'port': 5432,
    'dbname': 'hotels',
    'user': hotel_manager,
    'password': '135791'
}

conn = psycopg2.connect(**params)
if conn:
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    cur = conn.cursor()
    sql = 'SELECT * FROM hotels'
    cur.execute(sql)
    for row in cur.fetchall():
        print(row)

    print('Bye!')
    conn.close()
```

<!--
For macOS M1 users, you may need to install virtualenv to create a virtual environment for your Python project.
(Not Covered In Lecture)

Here's how to install virtualenv on macOS M1:
Install Python 3
Install Pip 3
Run pip3 install virtualenv
Run virtualenv -p python3 <desired-path> to create a virtualenv
Run source <desired-path>/bin/activate to activate the virtualenv
 -->

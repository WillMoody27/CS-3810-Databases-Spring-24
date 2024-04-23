# Instructions

To properly secure your database connection parameters, create a **config.ini** file (a text file) with the following values:

```
[db]
host=localhost
port=5432
dbname=hr
user=hr_admin
password=135791
```

Then install the **psycopg2** and **configparser** modules (under a properly configure virtual environment) using:

```
pip3 install configparser
```

Finally, change **testdb.py** like the following:

```
import psycopg2
import configparser as cp

config = cp.RawConfigParser()
config.read('config.ini')
params = dict(config.items('db'))

conn = psycopg2.connect(**params)
if conn:
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    print('Bye!')
    conn.close()
```

Protect **config.ini**. For example, if your project is hosted on GitHub, make sure you add **config.ini** in your **.gitignore** list.

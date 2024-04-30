# Instructions 

This activity illustrates how to use transactions in postgres. Start by creating the following database. 

```
CREATE DATABASE bank;

\c bank

CREATE TABLE Accounts (
    number INT PRIMARY KEY, 
    owner VARCHAR(50) NOT NULL, 
    balance DECIMAL(10,2)
);

INSERT INTO Accounts VALUES 
    (101, 'Daniel', 2500), 
    (202, 'Max', 300);


CREATE USER "bank" PASSWORD '135791';
GRANT ALL ON TABLE Accounts TO "bank";
```

Next, write the following Python script named **bank_transfer.py** that transfers funds from one account to another using a transaction. The script also simulates what happens if the transaction gets interrupted. 

```
import psycopg2
import sys
import configparser as cp

config = cp.RawConfigParser()
config.read('src/config.ini')
params = dict(config.items('db'))

conn = psycopg2.connect(**params)
# by default postgres autocommit each SQL statement 
# to define transactions that span more than one SQL statement set autocommit to false
conn.autocommit = False 

if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    # I/O
    print('Transfering funds from source to destination!')
    source = input('source? ')
    dest = input('destination? ')
    amount = input('amount? ')

    # by creating a cursor you start a transaction automatically
    # the transaction will have 2 parts
    with conn.cursor() as cur:
        
        # part 1: take money from source account
        sql = '''
            prepare st1 as 
            UPDATE accounts SET balance = balance - $1 
            WHERE number = $2;
        '''
        cur.execute(sql)
        cur.execute("execute st1 (%s, %s)", (amount, source))

        # simulate that something went awry here 
        # conn.rollback()
        # sys.exit(1)

        # part 2: put money into destination account
        sql = '''
            prepare st2 as 
            UPDATE accounts SET balance = balance + $1 
            WHERE number = $2;
        '''
        cur.execute(sql)
        cur.execute("execute st2 (%s, %s)", (amount, dest))
    
        # commit the transaction
        conn.commit()

    print('Bye!')
    conn.close()
```

Run the script and try to transfer $100 from account 101 to 202.

```
Transfering funds from source to destination!
source? 101
destination? 202
amount? 100
Bye!
```

Confirm that the funds were indeed transferred. 

```
 number | owner  | balance 
--------+--------+---------
    101 | Daniel | 2400.00
    202 | Max    |  400.00
```

Uncomment the lines that simulate an error between the transfer of funds. Confirm that no funds get transferred this time. 
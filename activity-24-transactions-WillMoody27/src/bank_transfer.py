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
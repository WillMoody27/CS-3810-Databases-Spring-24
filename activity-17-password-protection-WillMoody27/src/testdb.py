import psycopg2
import configparser as cp
import os


config = cp.RawConfigParser()
config.read('config.ini')
params = dict(config.items('db'))
# params['password'] = os.getenv('PASSWORD')

conn = psycopg2.connect(**params)
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    

    print('Bye!')
    conn.close()


# Project 2 will involve using configparser to read the database connection parameters from a configuration file and then use psycopg2 to connect to the database.
# - Create a new file called config.ini in the root of your project. This allows you to protect your database connection parameters from being exposed in your code.
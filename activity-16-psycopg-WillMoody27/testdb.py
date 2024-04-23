# import psycopg2

# params = {
#     'host': 'localhost',
#     'port': 5432,
#     'dbname': 'hr',
#     'user': 'hr_admin',
#     'password': '135791'
# }

# conn = psycopg2.connect(**params)
# if conn:

#     '''
#     # cursor is a control structure that enables traversal over the records in a database
#     - In Java it uses JDBC (Java Database Connectivity)
#     '''
#     cur = conn.cursor()
#     sql = 'SELECT id, name FROM employees'
#     cur.execute(sql)
#     for row in cur.fetchall():
#         # print(row)
#         id, name = row
#         print(f' id: {id}, name: {name}')

#     print('Connection to Postgres database ' + params['dbname'] + ' was successful!')


#     print('Bye!')
#     conn.close()

## FOR HOTELS ✅
import psycopg2

params = {
    'host': 'localhost',
    'port': 5432,
    'dbname': 'hotels',
    'user': 'hotel_manager',
    'password': '135791'
}

conn = psycopg2.connect(**params)
if conn:
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    cur = conn.cursor()
    sql = 'SELECT * FROM hotels'
    cur.execute(sql)
    for row in cur.fetchall():
        # print(row)
        id, name, city, state = row
        print(f' id: {id}, name: {name}, city: {city}, state: {state}')

    print('Bye!')
    conn.close()



# Project (Will get project Friday 5th)
# Spread sheet that is not normalized
# - will need to write a program that split the table and read single row at time and populate the tables using pyscopg2 commands.